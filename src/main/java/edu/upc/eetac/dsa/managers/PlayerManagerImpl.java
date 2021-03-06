package edu.upc.eetac.dsa.managers;

import edu.upc.eetac.dsa.orm.dao.PlayerDAOImpl;
import edu.upc.eetac.dsa.orm.model.Player;
import org.apache.log4j.Logger;

import java.io.FileReader;
import java.util.Properties;

public class PlayerManagerImpl implements PlayerManager {
    private static PlayerManager instance;
    PlayerDAOImpl playerDAO = new PlayerDAOImpl();
    RankingManagerImpl rankingManager= new RankingManagerImpl();
    private static final Logger log = Logger.getLogger(PlayerManagerImpl.class);
    //Singleton implementation for the instance of the GameManager
    private PlayerManagerImpl(){
        //Singleton Private Constructor
    }

    public static PlayerManager getInstance() {
        if (instance == null) {
            instance = new PlayerManagerImpl();
        }
        return instance;
    }

    @Override
    public Player signUp(Player player) {
        if(playerDAO.existUsername(player.getUsername())) {
            return null;
        }else{
            player = checkPlayerAvatar(player);
            String password = player.getPassword();
            String playerID = playerDAO.addPlayer(player);
            player.setPassword(password);
            player.setId(playerID);
            return player;
        }
    }

    @Override
    public String signIn(Player player) {
        //If correct return id, else empty String(Not Null)
        player = checkPlayerAvatar(player);
        return playerDAO.getId(player.getUsername(),player.getPassword());
    }
    @Override
    public Player getPlayer(String playerId) {
        //Returns Player with Items and Materials list included!
        return playerDAO.getPlayer(playerId);
    }

    @Override
    public Player updatePlayer(Player player) {
        //Check avatar, is null or empty and add basicAvatar than update
        player = checkPlayerAvatar(player);
        String password = player.getPassword();
        player = playerDAO.updatePlayer(player);
        player.setPassword(password);
        return player;
    }
    private Player checkPlayerAvatar(Player player){
        if(player.getAvatar() == null ){
            try{
            // Create Properties object.
            Properties databaseProperties = new Properties();
            String dbSettingsPropertyFile = "src/main/resources/basicAvatar.properties";
            // Properties will use a FileReader object as input.
            FileReader fReader = new FileReader(dbSettingsPropertyFile);
            // Load jdbc related properties in above file.
            databaseProperties.load(fReader);
            // Get each property value of DataBase.
            String avatar = databaseProperties.getProperty("user.avatar");
            player.setAvatar(avatar);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else if(player.getAvatar().equals("")||player.getAvatar().isEmpty())
        {
            try{
                // Create Properties object.
                Properties databaseProperties = new Properties();
                String dbSettingsPropertyFile = "src/main/resources/basicAvatar.properties";
                // Properties will use a FileReader object as input.
                FileReader fReader = new FileReader(dbSettingsPropertyFile);
                // Load jdbc related properties in above file.
                databaseProperties.load(fReader);
                // Get each property value of DataBase.
                String avatar = databaseProperties.getProperty("user.avatar");
                player.setAvatar(avatar);
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return player;
    }
    @Override
    public int deletePlayer(String playerId) {
       return playerDAO.deletePlayer(playerId);
    }
}
