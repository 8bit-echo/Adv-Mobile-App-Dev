package com.mattdickeydesign.mattdickeyart;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import org.w3c.dom.Text;

public class CategoryActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_category);

        Intent intent = getIntent();
        String categoryName = intent.getStringExtra("categoryName");

        TextView catName = (TextView) findViewById(R.id.categoryNameText);

        catName.setText(categoryName);
    }
}
