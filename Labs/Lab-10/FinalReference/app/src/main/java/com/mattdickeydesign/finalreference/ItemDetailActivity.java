package com.mattdickeydesign.finalreference;

import android.content.Intent;
import android.provider.ContactsContract;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class ItemDetailActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_item_detail);

        Intent from = getIntent();
        String itemName = (String) getIntent().getExtras().get("data type");
        int dataID = (Integer) getIntent().getExtras().get("dataID");
        DataModel myType = DataModel.Characters[0];

        //Pull the appropriate data from the list
        switch (itemName) {
            case "Numbers":
                myType = DataModel.Characters[dataID];
                break;
            case "Letters":
                 myType = DataModel.Characters[dataID];
                break;

            default:
                myType = DataModel.Colors[dataID];
                break;
        }

        //populate data to UI
        ImageView myImageView = (ImageView) findViewById(R.id.imageView);
        myImageView.setImageResource(myType.getImageReseourceID());

        TextView myTextView = (TextView) findViewById(R.id.textView);
        myTextView.setText(itemName);
    }

}
