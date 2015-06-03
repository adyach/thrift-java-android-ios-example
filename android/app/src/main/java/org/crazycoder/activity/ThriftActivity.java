package org.crazycoder.activity;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.TextView;

import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.transport.THttpClient;
import org.crazycoder.Constants;
import org.crazycoder.thrift.Message;
import org.crazycoder.thrift.Messaging;
import org.crazycoder.thrift.UserCredentials;

import java.util.List;


/**
 * ThriftActivity
 *
 * @author Andrey Dyachkov
 */
public class ThriftActivity extends AppCompatActivity {

    private static final String TAG = "ThriftActivity";
    public static final String DEMO = "demo";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_thrift);
        new FetchMessages(DEMO).execute();
    }

    /**
     * FindById
     * <p/>
     * Created by Andrey Dyachkov on 03/06/15.
     */
    private class FetchMessages extends AsyncTask<Void, Void, List<Message>> {

        private final String token;

        public FetchMessages(String token) {
            this.token = token;
        }

        @Override
        protected List<Message> doInBackground(Void... params) {
            try {
                THttpClient tHttpClient = new THttpClient(Constants.HOST, new DefaultHttpClient());
                TBinaryProtocol protocol = new TBinaryProtocol(tHttpClient);
                Messaging.Client client = new Messaging.Client(protocol);
                return client.fetchMessages(new UserCredentials(token));
            } catch (Exception e) {
                Log.d(TAG, e.getMessage());
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(List<Message> entities) {
            String result = entities == null ? getString(R.string.error) : entities.toString();
            Log.d(TAG, result);
            TextView response = (TextView) findViewById(R.id.response);
            response.setText(result);
        }
    }
}
