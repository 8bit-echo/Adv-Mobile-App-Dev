package com.mattdickeydesign.dickeyfinal;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class ItemDetailActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_item_detail);
        Intent from = getIntent();
        String itemName = (String) getIntent().getExtras().get("data type");
        int dataID = (Integer) getIntent().getExtras().get("dataID");
        //just an init. will get mutated
        Workout myType = Workout.Cardio[0];


        //Pull the appropriate data from the list
        switch (itemName) {
            case "Treadmill":
                myType = Workout.Cardio[dataID];
                break;
            case "Elliptical":
                myType = Workout.Cardio[dataID];
                break;
            case "Lifting":
                myType = Workout.Strength[dataID];
                break;
            case "Roids":
                myType = Workout.Strength[dataID];
                break;
            case "Yoga":
                myType = Workout.Flexibility[dataID];
                break;

            default:
                myType = Workout.Flexibility[dataID];
                break;
        }

        //populate data to UI
        ImageView myImageView = (ImageView) findViewById(R.id.imageView);
        myImageView.setImageResource(myType.getImageReseourceID());

        TextView myTextView = (TextView) findViewById(R.id.textView);
        myTextView.setText(itemName);
    }

    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.signUp:
//start order activity
                Intent intent = new Intent(this, SignUpActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
