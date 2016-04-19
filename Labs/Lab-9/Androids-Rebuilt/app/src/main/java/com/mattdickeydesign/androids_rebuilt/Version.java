package com.mattdickeydesign.androids_rebuilt;

public class Version {

    private String versionName;
    private int imageResouceID;


    //Constructor

    private Version(String newName, int newID) {
        this.versionName = newName;
        this.imageResouceID = newID;
    }

    public static final Version[] allversions = {
            new Version("Jelly Beanz", R.drawable.jelly),
            new Version("Kit Katz", R.drawable.kitkat),
            new Version("Marshmallowz", R.drawable.marshmallow)

    };

    public String getName() {
        return versionName;
    }

    public int getImageID() {
        return imageResouceID;
    }

    //the string representation of a version is it's name

    public String toString() {
        return this.versionName;
    }
}

