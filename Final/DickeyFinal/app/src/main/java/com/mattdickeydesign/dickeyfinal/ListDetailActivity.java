package com.mattdickeydesign.dickeyfinal;

import android.app.ListActivity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

public class ListDetailActivity extends ListActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_detail);

        Intent from = getIntent();
        String dataType = from.getStringExtra("item name");

        //get the listView
        ListView mylistData = getListView();

        //define an array adapter
        ArrayAdapter<Workout> myListAdapter;

        //Initialize the array with the right kind of data
        switch (dataType) {
            case "Cardio":
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, Workout.Cardio);
                break;
            case "Strength":
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, Workout.Strength);
                break;
            case "Flexibility":
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, Workout.Flexibility);
                break;
            default:
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, Workout.Cardio);
        }
        //set the array adapter to the list view
        mylistData.setAdapter(myListAdapter);

        // change xml ID property to this: android:id="@android:id/list"
    }

    //doing the listener differently because this extends ListActivity
    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        Intent detailItem = new Intent(ListDetailActivity.this, ItemDetailActivity.class);

        String dataType = getListView().getItemAtPosition(position).toString();
        System.out.println("This is datatype variable: " + dataType);

        detailItem.putExtra("dataID", (int) id);
        detailItem.putExtra("data type", dataType);

        //start intent
        startActivity(detailItem);
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

    //Add New Things

    public void showAddSheet(){
        Intent addIntent = new Intent(ListDetailActivity.this, AddNewActivity.class);

        startActivity(addIntent);
    }
}
