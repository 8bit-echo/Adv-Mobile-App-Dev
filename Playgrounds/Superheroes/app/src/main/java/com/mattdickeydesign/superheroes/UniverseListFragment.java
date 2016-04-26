package com.mattdickeydesign.superheroes;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;


public class UniverseListFragment extends Fragment implements AdapterView.OnItemClickListener {

    public UniverseListFragment() {
        // Required empty public constructor
    }

    //create interface
    interface UniverseListListener{
        void itemClicked(long id);
    }

    //create listener
    private UniverseListListener listener;

    @Override
    public void onAttach(Context context){
        super.onAttach(context);
        //attaches the context to the listener
        listener = (UniverseListListener) context;

    }

    public void onItemClick(AdapterView<?> parent, View view, int position, long id){
        if (listener != null) {
            //tells the listener an item was clicked
            listener.itemClicked(id);
        }
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
            //attach the listener to the listview
            listUniverse.setOnItemClickListener(this);
        }

        }


    }// end of class

