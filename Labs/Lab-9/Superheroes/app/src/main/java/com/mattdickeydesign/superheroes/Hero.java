package com.mattdickeydesign.superheroes;

import java.util.Arrays;
import java.util.ArrayList;

public class Hero {
    private  String universe;
            private ArrayList<String> superheroes = new ArrayList<>();


    //constructor
    private Hero(String univ, ArrayList<String> heroes){
        this.universe = univ;
        this.superheroes = new ArrayList<> (heroes);
    }

    public static final Hero[]heroes = {
            new Hero("DC", new ArrayList<>(Arrays.asList("Superman", "Batman", "Wonder Woman", "The Flash", "Green Arrow", "Catwoman"))),
            new Hero("Marvel", new ArrayList<>(Arrays.asList("Iron Man", "Black Widow", "Captain America", "Jean Grey", "Thor", "Hulk")))
    };

    public String getUniverse(){
        return universe;
    }
    public ArrayList<String> getSuperheroes(){
        return superheroes;
    }

    public String toString(){
        return this.universe;
    }
}
