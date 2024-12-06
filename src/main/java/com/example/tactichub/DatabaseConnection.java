package com.example.tactichub;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.InputStream;

public class DatabaseConnection {
    public static Connection getConnection() throws Exception {
        Properties props = new Properties();
        InputStream input = DatabaseConnection.class.getClassLoader().getResourceAsStream("db.properties");
        if (input == null) {
            throw new Exception("db.properties 파일을 찾을 수 없습니다.");
        }
        props.load(input);

        String url = props.getProperty("db.url");
        String user = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        return DriverManager.getConnection(url, user, password);
    }
}
