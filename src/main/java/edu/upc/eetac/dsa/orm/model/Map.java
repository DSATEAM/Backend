package edu.upc.eetac.dsa.orm.model;

public class Map {
    private String ID;
    private int sizeX;
    private int sizeY;
    private String designGrid;
    //Empty Constructor
    public Map() {}

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public int getSizeX() {
        return sizeX;
    }

    public void setSizeX(int sizeX) {
        this.sizeX = sizeX;
    }

    public int getSizeY() {
        return sizeY;
    }

    public void setSizeY(int sizeY) {
        this.sizeY = sizeY;
    }

    public String getDesignGrid() {
        return designGrid;
    }

    public void setDesignGrid(String designGrid) {
        this.designGrid = designGrid;
    }



}
