package com.example.catprovider;

import android.app.AlertDialog;
import android.app.LoaderManager;
import android.content.ContentValues;
import android.content.CursorLoader;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.Loader;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NavUtils;

import com.example.catprovider.data.HotelContract;
import com.example.catprovider.data.HotelContract.GuestEntry;

public class EditorActivity extends AppCompatActivity implements
        LoaderManager.LoaderCallbacks<Cursor> {

    private EditText mNameEditText;
    private EditText mCityEditText;
    private EditText mAgeEditText;

    private Spinner mGenderSpinner;

    /**
     * Пол для гостя. Возможные варианты:
     * 0 для кошки, 1 для кота, 2 - не определен.
     */
    private int mGender = 2;

    /**
     * Content URI for the existing guest (null if it's a new guest)
     */
    private Uri mCurrentGuestUri;

    /**
     * Identifier for the guest data loader
     */
    private static final int EXISTING_GUEST_LOADER = 0;

    /** Boolean flag that keeps track of whether the guest has been edited (true) or not (false) */
    private boolean mGuestHasChanged = false;

    /**
     * OnTouchListener that listens for any user touches on a View, implying that they are modifying
     * the view, and we change the mGuestHasChanged boolean to true.
     */
    private View.OnTouchListener mTouchListener = new View.OnTouchListener() {
        @Override
        public boolean onTouch(View view, MotionEvent motionEvent) {
            mGuestHasChanged = true;
            return false;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_editor);

        Intent intent = getIntent();
        mCurrentGuestUri = intent.getData();

        // If the intent DOES NOT contain a guest content URI, then we know that we are
        // creating a new pet.
        if (mCurrentGuestUri == null) {
            setTitle("Новый гость");

            // Invalidate the options menu, so the "Delete" menu option can be hidden.
            // (It doesn't make sense to delete a guest that hasn't been created yet.)
            invalidateOptionsMenu();
        } else {
            setTitle("Изменение данных");

            // Initialize a loader to read the guest data from the database
            // and display the current values in the editor
            getLoaderManager().initLoader(EXISTING_GUEST_LOADER, null, this);
        }

        mNameEditText = (EditText) findViewById(R.id.edit_guest_name);
        mCityEditText = (EditText) findViewById(R.id.edit_guest_city);
        mAgeEditText = (EditText) findViewById(R.id.edit_guest_age);
        mGenderSpinner = (Spinner) findViewById(R.id.spinner_gender);

        mNameEditText.setOnTouchListener(mTouchListener);
        mCityEditText.setOnTouchListener(mTouchListener);
        mAgeEditText.setOnTouchListener(mTouchListener);
        mGenderSpinner.setOnTouchListener(mTouchListener);

        setupSpinner();
    }

    /**
     * Настраиваем spinner для выбора пола у гостя.
     */
    private void setupSpinner() {

        ArrayAdapter genderSpinnerAdapter = ArrayAdapter.createFromResource(this,
                R.array.array_gender_options, android.R.layout.simple_spinner_item);

        genderSpinnerAdapter.setDropDownViewResource(android.R.layout.simple_dropdown_item_1line);

        mGenderSpinner.setAdapter(genderSpinnerAdapter);
        mGenderSpinner.setSelection(2);

        mGenderSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String selection = (String) parent.getItemAtPosition(position);
                if (!TextUtils.isEmpty(selection)) {
                    if (selection.equals(getString(R.string.gender_female))) {
//                        mGender = 0; // Кошка
                        mGender = HotelContract.GuestEntry.GENDER_FEMALE; // Кошка
                    } else if (selection.equals(getString(R.string.gender_male))) {
//                        mGender = 1; // Кот
                        mGender = HotelContract.GuestEntry.GENDER_MALE; // Кот
                    } else {
//                        mGender = 2; // Не определен
                        mGender = HotelContract.GuestEntry.GENDER_UNKNOWN; // Не определен
                    }
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                mGender = 2; // Unknown
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu options from the res/menu/menu_editor.xml file.
        // This adds menu items to the app bar.
        getMenuInflater().inflate(R.menu.menu_editor, menu);
        return true;
    }

    /**
     * This method is called after invalidateOptionsMenu(), so that the
     * menu can be updated (some menu items can be hidden or made visible).
     */
    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        super.onPrepareOptionsMenu(menu);
        // If this is a new guest, hide the "Delete" menu item.
        if (mCurrentGuestUri == null) {
            MenuItem menuItem = menu.findItem(R.id.action_delete);
            menuItem.setVisible(false);
        }
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // User clicked on a menu option in the app bar overflow menu
        switch (item.getItemId()) {
            // Respond to a click on the "Save" menu option
            case R.id.action_save:
//                insertGuest();
                saveGuest();
                // Закрываем активность
                finish();
                return true;
            // Respond to a click on the "Delete" menu option
            case R.id.action_delete:
                // Pop up confirmation dialog for deletion
                showDeleteConfirmationDialog();
                return true;
            // Respond to a click on the "Up" arrow button in the app bar
            case android.R.id.home:
                // Navigate back to parent activity (MainActivity)
//                NavUtils.navigateUpFromSameTask(this);
//                return true;
                if (!mGuestHasChanged) {
                    NavUtils.navigateUpFromSameTask(EditorActivity.this);
                    return true;
                }

                // Otherwise if there are unsaved changes, setup a dialog to warn the user.
                // Create a click listener to handle the user confirming that
                // changes should be discarded.
                DialogInterface.OnClickListener discardButtonClickListener =
                        new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                // User clicked "Discard" button, navigate to parent activity.
                                NavUtils.navigateUpFromSameTask(EditorActivity.this);
                            }
                        };

                // Show a dialog that notifies the user they have unsaved changes
                showUnsavedChangesDialog(discardButtonClickListener);
                return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * This method is called when the back button is pressed.
     */
    @Override
    public void onBackPressed() {
        // If the pet hasn't changed, continue with handling back button press
        if (!mGuestHasChanged) {
            super.onBackPressed();
            return;
        }

        // Otherwise if there are unsaved changes, setup a dialog to warn the user.
        // Create a click listener to handle the user confirming that changes should be discarded.
        DialogInterface.OnClickListener discardButtonClickListener =
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        // User clicked "Discard" button, close the current activity.
                        finish();
                    }
                };

        // Show dialog that there are unsaved changes
        showUnsavedChangesDialog(discardButtonClickListener);
    }

    /**
     * Сохраняем введенные данные в базе данных.
     */
//    private void insertGuest() {
//        // Считываем данные из текстовых полей
//        String name = mNameEditText.getText().toString().trim();
//        String city = mCityEditText.getText().toString().trim();
//        String ageString = mAgeEditText.getText().toString().trim();
//        int age = Integer.parseInt(ageString);
//
//        HotelDbHelper mDbHelper = new HotelDbHelper(this);
//
//        SQLiteDatabase db = mDbHelper.getWritableDatabase();
//
//        ContentValues values = new ContentValues();
//        values.put(GuestEntry.COLUMN_NAME, name);
//        values.put(GuestEntry.COLUMN_CITY, city);
//        values.put(GuestEntry.COLUMN_GENDER, mGender);
//        values.put(GuestEntry.COLUMN_AGE, age);
//
//        // Вставляем новый ряд в базу данных и запоминаем его идентификатор
//        long newRowId = db.insert(GuestEntry.TABLE_NAME, null, values);
//
//        // Встравляем новый ряд в провайдер, возвращая URI для нового гостя.
//        Uri newUri = getContentResolver().insert(GuestEntry.CONTENT_URI, values);
//
//        // Выводим сообщение в успешном случае или при ошибке
//         if (newRowId == -1) {
//             // Если ID  -1, значит произошла ошибка
//             Toast.makeText(this, "Ошибка при заведении гостя", Toast.LENGTH_SHORT).show();
//         } else {
//             Toast.makeText(this, "Гость заведён под номером: " + newRowId, Toast.LENGTH_SHORT).show();
//         }
//
//        if (newUri == null) {
//            // Если null, значит ошибка при вставке.
//            Toast.makeText(this, "Ошибка при заведении гостя", Toast.LENGTH_SHORT).show();
//        } else {
//            Toast.makeText(this, "Гость заведён успешно",
//                    Toast.LENGTH_SHORT).show();
//        }
//    }

    /**
     * Получаем данные и сохраняем гостя в базе данных
     */
    private void saveGuest() {

        // Считываем данные из текстовых полей
        String name = mNameEditText.getText().toString().trim();
        String city = mCityEditText.getText().toString().trim();
        String ageString = mAgeEditText.getText().toString().trim();
//        int age = Integer.parseInt(ageString);

        // Check if this is supposed to be a new guest
        // and check if all the fields in the editor are blank
        if (mCurrentGuestUri == null &&
                TextUtils.isEmpty(name) && TextUtils.isEmpty(city) &&
                TextUtils.isEmpty(ageString) && mGender == GuestEntry.GENDER_UNKNOWN) {
            // Since no fields were modified, we can return early without creating a new guest.
            // No need to create ContentValues and no need to do any ContentProvider operations.
            return;
        }

        // Create a ContentValues object where column names are the keys,
        // and guest attributes from the editor are the values.
        ContentValues values = new ContentValues();
        values.put(GuestEntry.COLUMN_NAME, name);
        values.put(GuestEntry.COLUMN_CITY, city);
        values.put(GuestEntry.COLUMN_GENDER, mGender);
//        values.put(GuestEntry.COLUMN_AGE, age);


        // If the age is not provided by the user, don't try to parse the string into an
        // integer value. Use 0 by default.
        int age = 0;
        if (!TextUtils.isEmpty(ageString)) {
            age = Integer.parseInt(ageString);
        }
        values.put(GuestEntry.COLUMN_AGE, age);

        // Determine if this is a new or existing guest by checking if mCurrentGuestUri is null or not
        if (mCurrentGuestUri == null) {
            // This is a NEW guest, so insert a new guest into the provider,
            // returning the content URI for the new guest.
            Uri newUri = getContentResolver().insert(GuestEntry.CONTENT_URI, values);

            if (newUri == null) {
                // Если null, значит ошибка при вставке.
                Toast.makeText(this, "Ошибка при заведении гостя", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Гость заведён успешно",
                        Toast.LENGTH_SHORT).show();
            }

        } else {
            // Otherwise this is an EXISTING guest, so update the guest with content URI: mCurrentGuestUri
            // and pass in the new ContentValues. Pass in null for the selection and selection args
            // because mCurrentGuetUri will already identify the correct row in the database that
            // we want to modify.
            int rowsAffected = getContentResolver().update(mCurrentGuestUri, values, null, null);

            // Show a toast message depending on whether or not the update was successful.
            if (rowsAffected == 0) {
                // If no rows were affected, then there was an error with the update.
                Toast.makeText(this, "Ошибка при редактировании гостя", Toast.LENGTH_SHORT).show();
            } else {
                // Otherwise, the update was successful and we can display a toast.
                Toast.makeText(this, "Данные исправлены успешно",
                        Toast.LENGTH_SHORT).show();
            }
        }
    }

    /**
     * Show a dialog that warns the user there are unsaved changes that will be lost
     * if they continue leaving the editor.
     *
     * @param discardButtonClickListener is the click listener for what to do when
     *                                   the user confirms they want to discard their changes
     */
    private void showUnsavedChangesDialog(
            DialogInterface.OnClickListener discardButtonClickListener) {
        // Create an AlertDialog.Builder and set the message, and click listeners
        // for the postivie and negative buttons on the dialog.
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.unsaved_changes_dialog_msg);
        builder.setPositiveButton(R.string.discard, discardButtonClickListener);
        builder.setNegativeButton(R.string.keep_editing, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                // User clicked the "Keep editing" button, so dismiss the dialog
                // and continue editing the pet.
                if (dialog != null) {
                    dialog.dismiss();
                }
            }
        });

        // Create and show the AlertDialog
        AlertDialog alertDialog = builder.create();
        alertDialog.show();
    }

    @Override
    public Loader<Cursor> onCreateLoader(int id, Bundle args) {
        // Since the editor shows all pet attributes, define a projection that contains
        // all columns from the pet table
        String[] projection = {
                GuestEntry._ID,
                GuestEntry.COLUMN_NAME,
                GuestEntry.COLUMN_CITY,
                GuestEntry.COLUMN_GENDER,
                GuestEntry.COLUMN_AGE};

        // This loader will execute the ContentProvider's query method on a background thread
        return new CursorLoader(this,   // Parent activity context
                mCurrentGuestUri,         // Query the content URI for the current guest
                projection,             // Columns to include in the resulting Cursor
                null,                   // No selection clause
                null,                   // No selection arguments
                null);                  // Default sort order
    }

    @Override
    public void onLoadFinished(Loader<Cursor> loader, Cursor cursor) {
        // Bail early if the cursor is null or there is less than 1 row in the cursor
        if (cursor == null || cursor.getCount() < 1) {
            return;
        }

        // Proceed with moving to the first row of the cursor and reading data from it
        // (This should be the only row in the cursor)
        if (cursor.moveToFirst()) {
            // Find the columns of guest attributes that we're interested in
            int nameColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_NAME);
            int cityColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_CITY);
            int genderColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_GENDER);
            int ageColumnIndex = cursor.getColumnIndex(GuestEntry.COLUMN_AGE);

            // Extract out the value from the Cursor for the given column index
            String name = cursor.getString(nameColumnIndex);
            String city = cursor.getString(cityColumnIndex);
            int gender = cursor.getInt(genderColumnIndex);
            int age = cursor.getInt(ageColumnIndex);

            // Update the views on the screen with the values from the database
            mNameEditText.setText(name);
            mCityEditText.setText(city);
            mAgeEditText.setText(Integer.toString(age));

            // Gender is a dropdown spinner, so map the constant value from the database
            // into one of the dropdown options (0 is Female, 1 is Male, 2 is Unknown).
            // Then call setSelection() so that option is displayed on screen as the current selection.
            switch (gender) {
                case GuestEntry.GENDER_MALE:
                    mGenderSpinner.setSelection(1);
                    break;
                case GuestEntry.GENDER_FEMALE:
                    mGenderSpinner.setSelection(0);
                    break;
                default:
                    mGenderSpinner.setSelection(2);
                    break;
            }
        }
    }

    @Override
    public void onLoaderReset(Loader<Cursor> loader) {
        // If the loader is invalidated, clear out all the data from the input fields.
        mNameEditText.setText("");
        mCityEditText.setText("");
        mAgeEditText.setText("");
        mGenderSpinner.setSelection(2); // Select "Unknown" gender
    }

    private void showDeleteConfirmationDialog() {
        // Create an AlertDialog.Builder and set the message, and click listeners
        // for the postivie and negative buttons on the dialog.
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(R.string.delete_dialog_msg);
        builder.setPositiveButton(R.string.delete, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                // User clicked the "Delete" button, so delete the guest.
                deleteGuest();
            }
        });
        builder.setNegativeButton(R.string.cancel, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                // User clicked the "Cancel" button, so dismiss the dialog
                // and continue editing the guest.
                if (dialog != null) {
                    dialog.dismiss();
                }
            }
        });

        // Create and show the AlertDialog
        AlertDialog alertDialog = builder.create();
        alertDialog.show();
    }

    /**
     * Perform the deletion of the pet in the database.
     */
    private void deleteGuest() {
        // Only perform the delete if this is an existing guest.
        if (mCurrentGuestUri != null) {
            // Call the ContentResolver to delete the guest at the given content URI.
            // Pass in null for the selection and selection args because the mCurrentGuestUri
            // content URI already identifies the guest that we want.
            int rowsDeleted = getContentResolver().delete(mCurrentGuestUri, null, null);

            // Show a toast message depending on whether or not the delete was successful.
            if (rowsDeleted == 0) {
                // If no rows were deleted, then there was an error with the delete.
                Toast.makeText(this, "Ошибка при удалении гостя",
                        Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Гость успешно удален",
                        Toast.LENGTH_SHORT).show();
            }
        }

        // Закрываем активность
        finish();
    }
}
