package com.mattdickeydesign.androids_rebuilt;


import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class VersionActivity extends ListActivity {

    private String version;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Intent i = getIntent();
        version = i.getStringExtra("version");


        //get the list view
        ListView listVersions = getListView();

        //define Array Adapter
        ArrayAdapter<Version> listAdapter;

        //initialize the array adapter with the correct list
        switch (version) {
            case "Jelly Bean":
                listAdapter = new ArrayAdapter<Version>(this, android.R.layout.simple_list_item_1, Version.allversions);
                break;
            case "Kit Kat":
                listAdapter = new ArrayAdapter<Version>(this, android.R.layout.simple_list_item_1, Version.allversions);
                break;
            case "Marshmallow":
                listAdapter = new ArrayAdapter<Version>(this, android.R.layout.simple_list_item_1, Version.allversions);
                break;
            default:
                listAdapter = new ArrayAdapter<Version>(this, android.R.layout.simple_list_item_1, Version.allversions);

        }

        //set array adapter on list view
        listVersions.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listVersions, View view, int position, long id) {
        Intent intent = new Intent(VersionActivity.this, DetailActivity.class);
        intent.putExtra("versionID", (int) id);
        intent.putExtra("version", version);
        startActivity(intent);
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

