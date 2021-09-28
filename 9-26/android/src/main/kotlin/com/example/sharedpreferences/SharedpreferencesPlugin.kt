package com.example.sharedpreferences

import android.annotation.SuppressLint
import android.app.Activity
import android.content.ContentValues
import android.content.Context
import android.content.SharedPreferences
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.os.strictmode.SqliteObjectLeakedViolation
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.sql.Array
import java.util.*


class MyDBHelper(context: Context, factory: SQLiteDatabase.CursorFactory?) : SQLiteOpenHelper(context, "myDb", factory, 1) {

    override fun onCreate(p0: SQLiteDatabase?) {
        Log.i("autopDev", "create DB");
        p0?.execSQL("CREATE Table `${TableMap.user}`(  ${UserModel.Column.id}  integer primary key autoincrement, ${UserModel.Column.username} text not null ,  ${UserModel.Column.passwd} text not null ,  ${UserModel.Column.role}  integer not null  );");
    }

    override fun onUpgrade(p0: SQLiteDatabase?, p1: Int, p2: Int) {
    }

}

class TableMap {
    companion object {
        val user = "user";
    }
}


class UserModel {

    class Column {
        companion object {
            val id = "id";
            val username = "username";
            val passwd = "passwd";
            val role = "role";
        }
    }

    companion object {
        fun insertUser(db: SQLiteDatabase, username: String, passwd: String, role: Int): Boolean {
            val result = db.rawQuery("SELECT * from `${TableMap.user}` WHERE `${Column.username}`=?", arrayOf(username));
            return if (result.count == 0) {
                val values = ContentValues()
                values.put(Column.username, username)
                values.put(Column.passwd, passwd)
                values.put(Column.role, role)
                db.insert(TableMap.user, null, values)
                result.close();
                true
            } else {
                result.close();
                false
            }
        }

        fun testUser(db: SQLiteDatabase, username: String, passwd: String, role: Int): Boolean {
            val result = db.rawQuery("SELECT * from `${TableMap.user}` WHERE `${Column.username}`=? AND ${Column.passwd}=? AND ${Column.role}=${role}", listOf(username, passwd).toTypedArray());
            val count = result.count
            result.close()
            return count == 1;
        }

    }
}


/** SharedpreferencesPlugin */
class SharedpreferencesPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var sharedPreferences: SharedPreferences
    private lateinit var edit: SharedPreferences.Editor
    private lateinit var myDBHelper: MyDBHelper
    private lateinit var writableDatabase: SQLiteDatabase;


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sharedpreferences")
        channel.setMethodCallHandler(this)
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "put" -> {
                val k = call.argument<String>("key");
                val v = call.argument<Any>("value");
                if (k != null && v != null) {
                    save(k, v);
                } else {
                    Log.d("show", "$k : $v");
                }
            }
            "createDB" -> {
                myDBHelper = MyDBHelper(context = activity, factory = null);
                writableDatabase = myDBHelper.writableDatabase;

                result.success(true);
            }

            "insertUser"->{
                val username=call.argument<String>("username");
                val passwd = call.argument<String>("passwd")
                val role = call.argument<Int>("role")
                result.success(username!=null&&passwd!=null&&role!=null&&UserModel.insertUser(writableDatabase,username,passwd,role))
            }

            "testUser"->{
                val username=call.argument<String>("username");
                val passwd = call.argument<String>("passwd")
                val role = call.argument<Int>("role")
                result.success(username!=null&&passwd!=null&&role!=null&&UserModel.testUser(writableDatabase,username,passwd,role))
            }



            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            else -> {
                result.notImplemented()
            }
        }
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    fun save(key: String, saveValue: Any) {
        when (saveValue) {
            is Boolean -> {
                edit.putBoolean(key, saveValue);
            }
            is Float -> {
                edit.putFloat(key, saveValue);
            }
            is Int -> {
                edit.putInt(key, saveValue);
            }
            is Long -> {
                edit.putLong(key, saveValue);
            }
            is String -> {
                edit.putString(key, saveValue);
            }
            else -> {
                edit.putString(key, saveValue.toString());
            }
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        sharedPreferences = activity.getSharedPreferences("mysp_1", Context.MODE_PRIVATE)
        edit = sharedPreferences.edit();

    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }
}
