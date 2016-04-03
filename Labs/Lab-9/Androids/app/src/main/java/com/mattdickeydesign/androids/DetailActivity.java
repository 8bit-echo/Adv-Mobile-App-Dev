package com.mattdickeydesign.androids;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

public class DetailActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.detail_activity);


        //get data from the intent
        int versionNum = (Integer) getIntent().getExtras().get("versionID");
        String type = (String) getIntent().getExtras().get("version");
        Version version = Version.allversions[versionNum];

        //populate image
        ImageView versionImage = (ImageView) findViewById(R.id.versionImageView);
        versionImage.setImageResource(version.getImageID());

        //populate name
        TextView versionName = (TextView) findViewById(R.id.versionNameLabel);
        versionName.setText(version.getName());

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
