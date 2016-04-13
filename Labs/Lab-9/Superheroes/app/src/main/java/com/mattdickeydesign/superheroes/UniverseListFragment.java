package com.mattdickeydesign.superheroes;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;


public class UniverseListFragment extends Fragment {

    public UniverseListFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_universe_list, container, false);
    }

    @Override
    public void onStart(){
        super.onStart();
        View view = getView();

        if (view != null) {
            //load data into fragment
            //get the list view
            ListView listUniverse = (ListView) view.findViewById(R.id.listView);

            //define Array adapter (separates items and assigns to table)
            ArrayAdapter<Hero> listAdapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_list_item_1, Hero.heroes);
            //set array adapter on list view
            listUniverse.setAdapter(listAdapter);
        }

        }


    }// end of class

