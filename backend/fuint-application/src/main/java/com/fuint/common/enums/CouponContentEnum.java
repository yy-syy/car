package com.fuint.common.enums;

/**
 * ??????????????
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
public enum CouponContentEnum {
    ROOM("1", "????"),
    ROOM_BTEAKFAST("2", "????+???"),
    MEALS("3", "????"),
    WASH("4", "???"),
    HEALTH("5", "????"),
    PERCENT("6", "????");

    private String key;

    private String value;

    CouponContentEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}