package com.mattdickeydesign.superheroes;


import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import java.util.ArrayList;

import android.widget.ArrayAdapter;
import android.app.FragmentTransaction;
import android.app.Dialog;
import android.widget.Button;
import android.widget.EditText;
import android.content.Context;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.widget.AdapterView;


/**
 * A simple {@link Fragment} subclass.
 */
public class HeroDetailFragment extends Fragment implements View.OnClickListener {

    interface ButtonClickListener {
        void addHeroClicked(View view);
    }

    private ButtonClickListener listener;

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        listener = (ButtonClickListener) context;
    }

    @Override
    public void onClick(View view) {
        if (listener != null) {
            listener.addHeroClicked(view);
        }
    }

    public void addHero() {
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Hero");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextHero);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String heroName = editText.getText().toString();
                Hero.heroes[(int) universeID].getSuperheroes().add(heroName);
                HeroDetailFragment.this.adapter.notifyDataSetChanged();
                Hero.heroes[(int) universeID].storeHeroes(getActivity(), universeID);
                dialog.dismiss();
            }
        });
        dialog.show();
    }


    public HeroDetailFragment() {
        // Required empty public constructor
    }

    private ArrayAdapter<String> adapter;
    private long universeID;


    @Override
    public void onStart() {
        super.onStart();
        View view = getView();
        Button addButton = (Button) view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);
        ListView listHeroes = (ListView) view.findViewById(R.id.herolistView);

        //get hero data
        ArrayList<String> herolist = new ArrayList<String>();
        herolist = Hero.heroes[(int) universeID].getSuperheroes();


        //set array adapter
        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, herolist);

        //blind array adapter to list view
        listHeroes.setAdapter(adapter);
    }

    public void setUniverse(long id) {
        this.universeID = id;
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        if (Hero.heroes[0].getSuperheroes().size() == 0) {
            Hero.heroes[0].loadHeroes(getActivity(), 0);
        }
        if (Hero.heroes[1].getSuperheroes().size() == 0) {
            Hero.heroes[1].loadHeroes(getActivity(), 1);
        }

        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_hero_detail, container, false);
    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState) {
        savedInstanceState.putLong("universeId", universeID);
    }

    @Override
    public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, view, menuInfo);

        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String heroName = adapter.getItem(adapterContextMenuInfo.position);
        menu.setHeaderTitle("Delte" + heroName);

        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    @Override
    public boolean onContextItemSelected(MenuItem menuItem) {
        int itemID = menuItem.getItemId();
        if (itemID == 1) {
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) menuItem.getMenuInfo();
            Hero.heroes[(int) universeID].getSuperheroes().remove(info.position);
            HeroDetailFragment.this.adapter.notifyDataSetChanged();
        }
        return true;
    }

}


