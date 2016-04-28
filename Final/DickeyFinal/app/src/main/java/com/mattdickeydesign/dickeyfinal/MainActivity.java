package com.mattdickeydesign.dickeyfinal;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
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

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.signUp:
//start order activity
                Intent intent = new Intent(this, SignUpActivity.class); startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

}
