package com.mattdickeydesign.finalreference;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

import java.util.List;

//Changed this to Activity
public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//Create a listener
        AdapterView.OnItemClickListener myItemClickListener = new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                //get item name as String
                String listItemName = (String) parent.getItemAtPosition(position);

                //create new intent
                Intent goToDetail = new Intent(MainActivity.this, ListDetailActivity.class);

                //add data to pass
                goToDetail.putExtra("item name", listItemName);

                //start the intent
                startActivity(goToDetail);

            }
        };

        //get the listView
        ListView myListView = (ListView) findViewById(R.id.listView);
        //attach the listener
        myListView.setOnItemClickListener(myItemClickListener);
    }
}
