package com.test.demo.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class Db {
  private static final Properties props = new Properties();

  static {
    try (InputStream in = Db.class.getClassLoader().getResourceAsStream("db.properties")) {
      if (in == null) throw new RuntimeException("Không tìm thấy db.properties");
      props.load(in);

      Class.forName(props.getProperty("db.driver"));
    } catch (Exception e) {
      throw new RuntimeException("Lỗi load db.properties", e);
    }
  }

  public static Connection getConnection() throws Exception {
    return DriverManager.getConnection(
        props.getProperty("db.url"),
        props.getProperty("db.username"),
        props.getProperty("db.password")
    );
  }
}
