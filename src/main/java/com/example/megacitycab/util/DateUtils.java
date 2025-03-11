package com.example.megacitycab.util;

import java.sql.Date;
import java.time.LocalDate;

public class DateUtils {
    public static Date toSqlDate(LocalDate localDate) {
        return localDate == null ? null : Date.valueOf(localDate);
    }

    public static LocalDate toLocalDate(Date sqlDate) {
        return sqlDate == null ? null : sqlDate.toLocalDate();
    }
}