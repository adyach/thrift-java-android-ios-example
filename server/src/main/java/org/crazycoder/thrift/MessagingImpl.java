package org.crazycoder.thrift;

import org.apache.thrift.TException;
import org.springframework.stereotype.Component;
import org.crazycoder.thrift.*;
import java.util.ArrayList;
import java.util.List;

@Component
public class MessagingImpl implements Messaging.Iface {

//    private static final Logger log = Logger.getLogger(MessagingImpl.class);

    @Override
    public List<Message> fetchMessages(UserCredentials credentials) throws TException {

//        log.debug(credentials);

        List<Message> messages = new ArrayList<>();
        if (credentials.getToken().equals("demo")) {
            User sender = new User(111, "Demo Demo");
            Message msg = new Message("demoBody", sender, 0);
            messages.add(msg);
            return messages;
        }

        return messages;
    }

    @Override
    public boolean postMessage(NewMessage message) throws TException {
//        log.debug(message);
        return false;
    }

    @Override
    public void ping(UserCredentials credentials) throws TException {
//        log.debug(credentials);
    }

}
