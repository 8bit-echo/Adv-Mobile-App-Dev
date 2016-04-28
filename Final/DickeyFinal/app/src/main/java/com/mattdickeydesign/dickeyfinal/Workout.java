package com.mattdickeydesign.dickeyfinal;

import android.app.Activity;


public class Workout {
    private String name;
    private int imageResourceID;

    //constructor
    private Workout(String passedName, int passedID){
        this.name = passedName;
        this.imageResourceID = passedID;
    }

    public static final Workout[] Cardio = {
            new Workout("Treadmill", R.drawable.cardio),
            new Workout("Elliptical", R.drawable.cardio)
    };
    public static final Workout[] Strength = {
            new Workout("Lifting", R.drawable.strength),
            new Workout("Roids", R.drawable.strength)
    };
    public static final Workout[] Flexibility = {
            new Workout("Yoga", R.drawable.flexibility),
            new Workout("Pretending to Yoga so you can wear comfy pants", R.drawable.flexibility)
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
