package com.mattdickeydesign.superheroes;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.app.FragmentTransaction;
import android.view.View;

public class MainActivity extends AppCompatActivity implements UniverseListFragment.UniverseListListener, HeroDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public void itemClicked(long id) {
//create new fragment instance
        HeroDetailFragment frag = new HeroDetailFragment(); //create new fragment transaction
        FragmentTransaction ft = getFragmentManager().beginTransaction();
//set the id of the universe selected
        frag.setUniverse(id);
//replace the fragment in the fragment container
        ft.replace(R.id.fragment_container, frag);
//add fragment to the back stack
        ft.addToBackStack(null);
//set the transition animation-optional ft.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE); //commit the transaction
        ft.commit();
    }

    @Override
    public void addHeroClicked(View view){
        HeroDetailFragment fragment = (HeroDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addHero();
    }

    @Override
    public void onBackPressed() {
        if (getFragmentManager().getBackStackEntryCount() > 0) {
            getFragmentManager().popBackStack();
        } else {
            super.onBackPressed();
        }
    }
}
