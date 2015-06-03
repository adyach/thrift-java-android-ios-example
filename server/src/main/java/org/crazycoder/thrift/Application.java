package org.crazycoder.thrift;

import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocolFactory;
import org.apache.thrift.server.TServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.crazycoder.thrift.*;

import javax.servlet.Servlet;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public TProtocolFactory protocolFactory() {
        return new TBinaryProtocol.Factory();
    }

    @Bean
    public Servlet demo(TProtocolFactory protocolFactory, MessagingImpl handler) {
        return new TServlet(new Messaging.Processor<>(handler), protocolFactory);
    }
}