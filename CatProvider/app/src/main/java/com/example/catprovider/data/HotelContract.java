package com.example.catprovider.data;

import android.content.ContentResolver;
import android.net.Uri;
import android.provider.BaseColumns;

public final class HotelContract {

    // To prevent someone from accidentally instantiating the contract class,
    // give it an empty constructor.
    private HotelContract() {
    }

    /**
     * The "Content authority" is a name for the entire content provider, similar to the
     * relationship between a domain name and its website.  A convenient string to use for the
     * content authority is the package name for the app, which is guaranteed to be unique on the
     * device.
     */
    public static final String CONTENT_AUTHORITY = "com.example.catprovider";

    /**
     * Use CONTENT_AUTHORITY to create the base of all URI's which apps will use to contact
     * the content provider.
     */
    public static final Uri BASE_CONTENT_URI = Uri.parse("content://" + CONTENT_AUTHORITY);

    /**
     * Possible path (appended to base content URI for possible URI's)
     * For instance, content://com.example.android.guests/guests/ is a valid path for
     * looking at guest data. content://com.example.android.guests/staff/ will fail,
     * as the ContentProvider hasn't been given any information on what to do with "staff".
     */
    public static final String PATH_GUESTS = "guests";

    public static final class GuestEntry implements BaseColumns {

        /** The content URI to access the guest data in the provider */
        public static final Uri CONTENT_URI = Uri.withAppendedPath(BASE_CONTENT_URI, PATH_GUESTS);

        /**
         * The MIME type of the {@link #CONTENT_URI} for a list of pets.
         */
        public static final String CONTENT_LIST_TYPE =
                ContentResolver.CURSOR_DIR_BASE_TYPE + "/" + CONTENT_AUTHORITY + "/" + PATH_GUESTS;

        /**
         * The MIME type of the {@link #CONTENT_URI} for a single pet.
         */
        public static final String CONTENT_ITEM_TYPE =
                ContentResolver.CURSOR_ITEM_BASE_TYPE + "/" + CONTENT_AUTHORITY + "/" + PATH_GUESTS;

        public final static String TABLE_NAME = "guests";

        public final static String _ID = BaseColumns._ID;
        public final static String COLUMN_NAME = "name";
        public final static String COLUMN_CITY = "city";
        public final static String COLUMN_GENDER = "gender";
        public final static String COLUMN_AGE = "age";

        public static final int GENDER_FEMALE = 0;
        public static final int GENDER_MALE = 1;
        public static final int GENDER_UNKNOWN = 2;

        /**
         * Returns whether or not the given gender is {@link #GENDER_UNKNOWN}, {@link #GENDER_MALE},
         * or {@link #GENDER_FEMALE}.
         */
        public static boolean isValidGender(int gender) {
            if (gender == GENDER_UNKNOWN || gender == GENDER_MALE || gender == GENDER_FEMALE) {
                return true;
            }
            return false;
        }
    }
}
