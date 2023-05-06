package com.example.catprovider;

import android.app.LoaderManager;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.CursorLoader;
import android.content.Intent;
import android.content.Loader;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.example.catprovider.data.HotelContract.GuestEntry;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

public class MainActivity extends AppCompatActivity
        implements LoaderManager.LoaderCallbacks<Cursor> {

//    private HotelDbHelper mDbHelper;

    /**
     * Идентификатор для загрузчика
     */
    private static final int GUEST_LOADER = 0;

    /**
     * Адаптер для ListView
     */
    GuestCursorAdapter mCursorAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
//                        .setAction("Action", null).show();
                Intent intent = new Intent(MainActivity.this, EditorActivity.class);
                startActivity(intent);
            }
        });

//        mDbHelper = new HotelDbHelper(this);

        ListView guestListView = (ListView) findViewById(R.id.list);
        guestListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(MainActivity.this, EditorActivity.class);

                // Form the content URI that represents the specific guest that was clicked on,
                // by appending the "id" (passed as input to this method) onto the
                // {@link GuestEntry#CONTENT_URI}.
                // For example, the URI would be "content://com.example.android.guests/guests/2"
                // if the guest with ID 2 was clicked on.
                Uri currentGuestUri = ContentUris.withAppendedId(GuestEntry.CONTENT_URI, id);

                // Set the URI on the data field of the intent
                intent.setData(currentGuestUri);

                // Launch the {@link EditorActivity} to display the data for the current guest.
                startActivity(intent);
            }
        });

        // Если список пуст
        View emptyView = findViewById(R.id.empty_view);
        guestListView.setEmptyView(emptyView);

        // Адаптер
        // Пока данных нет используем null
        mCursorAdapter = new GuestCursorAdapter(this, null);
        guestListView.setAdapter(mCursorAdapter);


        getLoaderManager().initLoader(GUEST_LOADER, null, this);
    }

//    @Override
//    protected void onStart() {
//        super.onStart();
//        displayDatabaseInfo();
//    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_insert_new_data:
                insertGuest();
               // displayDatabaseInfo();
                return true;
            case R.id.action_delete_all_entries:
                deleteAllGuest();
                return true;
        }

        return super.onOptionsItemSelected(item);
    }


//    private void displayDatabaseInfo() {
//        // Создадим и откроем для чтения базу данных
//        SQLiteDatabase db = mDbHelper.getReadableDatabase();
//
//        // Зададим условие для выборки - список столбцов
//        String[] projection = {
//                GuestEntry._ID,
//                GuestEntry.COLUMN_NAME,
//                GuestEntry.COLUMN_CITY,
//                GuestEntry.COLUMN_GENDER,
//                GuestEntry.COLUMN_AGE};
//
//
//        // Делаем запрос
//
//        Cursor cursor = db.query(
//                GuestEntry.TABLE_NAME,   // таблица
//                projection,            // столбцы
//                null,                  // столбцы для условия WHERE
//                null,                  // значения для условия WHERE
//                null,                  // Don't group the rows
//                null,                  // Don't filter by row groups
//                null);                   // порядок сортировки
//
////        Cursor cursor = getContentResolver().query(
////                GuestEntry.CONTENT_URI,
////                projection,
////                null,
////                null,
////                null);
//
//        TextView displayTextView = (TextView) findViewById(R.id.text_view_info);
//
//        try {
//            displayTextView.setText("Таблица содержит " + cursor.getCount() + " гостей.\n\n");
//            displayTextView.append(GuestEntry._ID + " - " +
//                    GuestEntry.COLUMN_NAME + " - " +
//                    GuestEntry.COLUMN_CITY + " - " +
//                    GuestEntry.COLUMN_GENDER + " - " +
//                    GuestEntry.COLUMN_AGE + "\n");
//
//            // Узнаем индекс каждого столбца
//            int idColumnIndex = cursor.getColumnIndex(GuestEntry._ID);
//            int nameColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_NAME);
//            int cityColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_CITY);
//            int genderColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_GENDER);
//            int ageColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_AGE);
//
//            // Проходим через все ряды
//            while (cursor.moveToNext()) {
//                // Используем индекс для получения строки или числа
//                int currentID = cursor.getInt(idColumnIndex);
//                String currentName = cursor.getString(nameColumnIndex);
//                String currentCity = cursor.getString(cityColumnIndex);
//                int currentGender = cursor.getInt(genderColumnIndex);
//                int currentAge = cursor.getInt(ageColumnIndex);
//                // Выводим значения каждого столбца
//                displayTextView.append(("\n" + currentID + " - " +
//                        currentName + " - " +
//                        currentCity + " - " +
//                        currentGender + " - " +
//                        currentAge));
//            }
//        } finally {
//            // Всегда закрываем курсор после чтения
//            cursor.close();
//        }
//    }

    /**
     * Вспомогательный метод для вставки записи
     */
    private void insertGuest() {

        // Получим доступ к базе данных для записи
        //SQLiteDatabase db = mDbHelper.getWritableDatabase();

        // Создаем объект ContentValues, где имена столбцов ключи,
        // а информация о госте является значениями ключей
        ContentValues values = new ContentValues();
        values.put(GuestEntry.COLUMN_NAME, "Мурзик");
        values.put(GuestEntry.COLUMN_CITY, "Мурманск");
        values.put(GuestEntry.COLUMN_GENDER, GuestEntry.GENDER_MALE);
        values.put(GuestEntry.COLUMN_AGE, 7);

        //long newRowId = db.insert(GuestEntry.TABLE_NAME, null, values);

        Uri newUri = getContentResolver().insert(GuestEntry.CONTENT_URI, values);
    }

    @Override
    public Loader<Cursor> onCreateLoader(int id, Bundle args) {
        // Зададим нужные колонки
        String[] projection = {
                GuestEntry._ID,
                GuestEntry.COLUMN_NAME,
                GuestEntry.COLUMN_CITY};

        // Загрузчик запускает запрос ContentProvider в фоновом потоке
        return new CursorLoader(this,
                GuestEntry.CONTENT_URI,   // URI контент-провайдера для запроса
                projection,             // колонки, которые попадут в результирующий курсор
                null,                   // без условия WHERE
                null,                   // без аргументов
                null);                  // сортировка по умолчанию
    }

    @Override
    public void onLoadFinished(Loader<Cursor> loader, Cursor data) {
        // Обновляем CursorAdapter новым курсором, которые содержит обновленные данные
        mCursorAdapter.swapCursor(data);
    }

    @Override
    public void onLoaderReset(Loader<Cursor> loader) {
        // Освобождаем ресурсы
        mCursorAdapter.swapCursor(null);
    }

    /**
     * Helper method to delete all guests in the database.
     */
    private void deleteAllGuest() {
        int rowsDeleted = getContentResolver().delete(GuestEntry.CONTENT_URI, null, null);
        Log.v("MainActivity", rowsDeleted + " rows deleted from hotel database");
    }
}