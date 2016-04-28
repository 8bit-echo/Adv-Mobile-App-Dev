package com.mattdickeydesign.finalreference;

public class DataModel {
    private String name;
    private int imageResourceID;

    //constructor
    private DataModel(String passedName, int passedID) {
        this.name = passedName;
        this.imageResourceID = passedID;
    }

    public static final DataModel[] Characters = {
            new DataModel("Letters", R.drawable.letters),
            new DataModel("Numbers", R.drawable.numbers)
    };

    public static final DataModel[] Colors = {
            new DataModel("Red", R.drawable.red),
            new DataModel("Green", R.drawable.green),
            new DataModel("Blue", R.drawable.blue)
    };


    public String getName() {
        return name;
    }

    public int getImageReseourceID() {
        return imageResourceID;
    }

    public String toString(){
        return this.name;
    }
}