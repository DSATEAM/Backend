package edu.upc.eetac.dsa.orm;

import edu.upc.eetac.dsa.RandomUtils;
import edu.upc.eetac.dsa.orm.util.ObjectHelper;
import edu.upc.eetac.dsa.orm.util.QueryHelper;

import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.sql.*;
import java.util.*;


public class SessionImpl implements Session {
    private final Connection conn;
    private static final int sizeId = 32;
    public SessionImpl(Connection conn) {
        this.conn = conn;
    }
    // Saves an Object(Player,Item,Material...) in DB excluded ListFields(use saveList for this)!z
    public String save(Object entity) {

        String[] insertQueryAndFieldsOrdered = QueryHelper.createQueryINSERT(entity);
        String insertQuery = insertQueryAndFieldsOrdered[0];
        //Not Using getStrFields, but in exchange use Ordered Fields obtained from createQuery for the password bug!
        String[] fieldsOrdered = Arrays.copyOfRange(insertQueryAndFieldsOrdered,1,(insertQueryAndFieldsOrdered.length));
        RandomUtils randomUtils = new RandomUtils();
        PreparedStatement preparedStatement;
        String id = RandomUtils.generateID(sizeId);
        try {
            preparedStatement = conn.prepareStatement(insertQuery);
            ObjectHelper.setter(entity,"id",id);

            int i = 1;
            //Only Primitive Types Int String float
            for (String field: fieldsOrdered) {
                Object objt = ObjectHelper.getter(entity, field);
                preparedStatement.setObject(i, objt);
                i++;
            }
            preparedStatement.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }
    //SAVES THE LIST OF OBJECT(Item,Materials) GIVEN Object(Player) Not Recursive
    public void saveList(Object entity){
        //For a Player which contains listItems, this will save all the items in the table items
        try {
            Object objList = null;
            //listObjects Relational Mapping to ObjectName Table
            for (Field field: ObjectHelper.getListFields(entity)) {
                objList = ObjectHelper.getter(entity,field.getName());
                //Class<?> cls = Class.forName("String");
                for (Object o :(List) objList) {
                    // Save the Object in Database in the Corresponding Table
                    save(o);
                }
            }
            //EXECUTE STATEMENT
            //REPEAT ABOVE STATEMENT TILL SIZE OF LIST OBJECTS
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void close() {
        try {
            this.conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    //Completed getObject(Player..) with list as null, use getList for that!
    public Object get(Class theClass, String id) {

        Object obj = null; PreparedStatement pstm = null;
        //Instantiating a object of type class for the getters
        try {
            String selectQuery = QueryHelper.createQuerySELECT(theClass.newInstance());

            obj = theClass.newInstance();
            pstm = conn.prepareStatement(selectQuery);
            pstm.setObject(1, id);
            ResultSet resultSet =  pstm.executeQuery();
            //INVOKE SETTER FOR EACH CORRESPONDING PROPERTY OF THE TABLE TO MAP WITH OBJECT
            while (resultSet.next()){
                //SQL WILL NEVER RETURN LIST AS A RESULT
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                for(int i=1;i<=resultSetMetaData.getColumnCount();i++){
                    String name = resultSetMetaData.getColumnName(i);
                       ObjectHelper.setter(obj,name, resultSet.getObject(i));
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return obj;
    }
    // Given Class (Player) with parentID returns list<Item>
    public List<Object> getList(Class theClass,String parentId){

         PreparedStatement pstm = null;
        //Instantiating a object of type class for the getters
        List<Object> objList = new LinkedList<>();
        try {
            String selectQuery = QueryHelper.createParentIdQuerySELECT(theClass.newInstance());
            pstm = conn.prepareStatement(selectQuery);
            pstm.setObject(1, parentId);
            ResultSet resultSet = pstm.executeQuery();
            while(resultSet.next()) {
                Object obj = theClass.newInstance();
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                for(int i=1;i<=resultSetMetaData.getColumnCount();i++){
                    String name = resultSetMetaData.getColumnName(i);
                    obj = ObjectHelper.setter(obj,name, resultSet.getObject(i));
                }
                //We have filled all of the fields inside the Object of type <E>
                objList.add(obj);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return objList;
    }
    // FINISH THE MODFICATION OF THE OBJECT GIVEN THE UPDATED OBJECT
    public int update(Object entity) {
        String[] updateQueryAndFieldsOrdered = QueryHelper.createQueryUPDATE(entity);
        String updateQuery = updateQueryAndFieldsOrdered[0];
        //Not Using getStrFields, but in exchange use Ordered Fields obtained from createQueryUpdate for the password bug!
        String[] fieldsOrdered = Arrays.copyOfRange(updateQueryAndFieldsOrdered,1,(updateQueryAndFieldsOrdered.length));
        PreparedStatement preparedStatement;int affectedRows = 0;
        try {
            preparedStatement = conn.prepareStatement(updateQuery);
            int i = 1;
            //Only Primitive Types Int String float
            for (String field: fieldsOrdered) {
                Object objt = ObjectHelper.getter(entity, field);
                preparedStatement.setObject(i, objt);
                i++;
            }
         affectedRows = preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return affectedRows;
    }
    // FINISH THE DELETE OBJECT FROM DB GIVEN THE OBJECT
    public int delete(Object object) {
        String delete = QueryHelper.createQueryDELETE(object);
        int affectedRows = 0;
        PreparedStatement pstm = null;
        try {
            pstm=conn.prepareStatement(delete);
            for(String field: ObjectHelper.getStrFields(object)){
                if(field.equals("id")) {
                    pstm.setObject(1, ObjectHelper.getter(object, field));
                }
            }
          affectedRows = pstm.executeUpdate();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return affectedRows;
    }
    // GET ALL OF THE DATA FROM DB GIVEN THE CLASS(model)
    public List<Object> findAll(Class theClass){

        PreparedStatement pstm = null;
        //Instantiating a object of type class for the getters
        List<Object> objList = new LinkedList<>();
        try {
            String selectQuery = QueryHelper.createQuerySELECTALL(theClass.newInstance());
            pstm = conn.prepareStatement(selectQuery);
            ResultSet resultSet = pstm.executeQuery();
            while(resultSet.next()) {
                Object obj = theClass.newInstance();
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                for(int i=1;i<=resultSetMetaData.getColumnCount();i++){
                    String name = resultSetMetaData.getColumnName(i);
                    obj = ObjectHelper.setter(obj,name, resultSet.getObject(i));
                }
                //We have filled all of the fields inside the Object of type <E>
                objList.add(obj);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return objList;

    }
    // GET ALL OF THE DATA FROM DB GIVEN THE CLASS(model) & THE PARAMETERS WHICH MATCH THE HASH
    public List<Object> findAll(Class theClass, HashMap params) {
        return null;
    }

    @Override
    public List<Object> queryExecute(Class theClass, String queryExecute, List params) {
        List<Object> objList = new LinkedList<>();
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement(queryExecute);
            int k = 1;
            for(Object obj: params){
                pstm.setObject(k, params.get(k-1));
                k++;
            }
            ResultSet resultSet = pstm.executeQuery();
            while(resultSet.next()) {
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                for(int i=1;i<=resultSetMetaData.getColumnCount();i++){
                    objList.add(resultSet.getObject(i));
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return objList;
    }
    @Override
    public List<Object> queryExecuteGetObject(Class theClass, String queryExecute, List params) {
        List<Object> objList = new LinkedList<>();
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement(queryExecute);
            int k = 1;
            for(Object obj: params){
                pstm.setObject(k, params.get(k-1));
                k++;
            }
            ResultSet resultSet = pstm.executeQuery();
            while(resultSet.next()) {
                Object obj = theClass.newInstance();
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                for(int i=1;i<=resultSetMetaData.getColumnCount();i++){
                    String name = resultSetMetaData.getColumnName(i);
                    obj = ObjectHelper.setter(obj,name, resultSet.getObject(i));
                }
                objList.add(obj);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return objList;
    }
}
