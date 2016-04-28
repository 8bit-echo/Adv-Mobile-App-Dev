package com.mattdickeydesign.finalreference;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.app.Dialog;
import android.widget.Button;
import android.widget.EditText;
import android.content.Context;

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
        ArrayAdapter<DataModel> myListAdapter;

        //Initialize the array with the right kind of data
        switch (dataType) {
            case "Characters":
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, DataModel.Characters);
                break;
            case "Colors":
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, DataModel.Colors);
                break;
            default:
                myListAdapter = new ArrayAdapter<>(this, android.R.layout.simple_list_item_1, DataModel.Characters);
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


    //Add / Delete Things

    //step 1: create interface
    interface ButtonClickListener {
        void addItemClicked(View view);
    }
    //create listener
//    private ButtonClickListener myButtonListener;

//    Button myButton = (Button) findViewById(R.id.button);


    public void AddButtonClicked() {
        System.out.println("dialog box should appear.");
        //show dialog box
        final EditText taskEditText = new EditText(this);
        AlertDialog dialog = new AlertDialog.Builder(this)
                .setTitle("Add a new task")
                .setMessage("What do you want to do next?")
                .setView(taskEditText)
                .setPositiveButton("Add", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        String task = String.valueOf(taskEditText.getText());
//                        Log.d(TAG, "Task to add: " + task);
                    }
                })
                .setNegativeButton("Cancel", null)
                .create();
        dialog.show();
    }
}