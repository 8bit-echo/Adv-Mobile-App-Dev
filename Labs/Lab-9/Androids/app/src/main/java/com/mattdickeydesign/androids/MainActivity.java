package com.mattdickeydesign.androids;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.view.Menu;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);


        //Create the Listener
        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                String versionName = (String) listView.getItemAtPosition(position);

                //create intent
                Intent intent = new Intent(MainActivity.this, VersionActivity.class);
                intent.putExtra("version", versionName);

                //start Intent
                startActivity(intent);
            }
        };

        //get the list view
        ListView listView = (ListView) findViewById(R.id.listView);

        //add listener to the list view
        listView.setOnItemClickListener(itemClickListener);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }
    @Override
    public boolean onOptionsItemSelected(MenuItem item){
        // get ID of the item on the action bat that was clicked
        switch (item.getItemId()){
            case R.id.create_download:
                //start the download activity
                Intent intent = new Intent(this, DownloadActivity.class);
                startActivity(intent);
                return true;
            default:
                return  super.onOptionsItemSelected(item);

        }
    }
}

