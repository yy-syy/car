package com.fuint.common.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 优惠券DTO
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
@Data
public class CouponDto implements Serializable {

    @ApiModelProperty("优惠券ID")
    private Integer id;

    @ApiModelProperty("优惠券名称")
    private String name;

    @ApiModelProperty("优惠券类型")
    private String type;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("使用规则")
    private String inRule;

    @ApiModelProperty("不适用规则")
    private String outRule;

    @ApiModelProperty("图片")
    private String image;

    @ApiModelProperty("金额")
    private BigDecimal amount;

    @ApiModelProperty("领取所需积分")
    private Integer point;

    @ApiModelProperty("卖点")
    private String sellingPoint;

    @ApiModelProperty("已领取数量")
    private Integer gotNum;

    @ApiModelProperty("剩余数量")
    private Integer leftNum;

    @ApiModelProperty("总数量")
    private Integer total;

    @ApiModelProperty("每人限领数量")
    private Integer limitNum;

    @ApiModelProperty("适用门店")
    private String storeNames;

    @ApiModelProperty("是否已领取")
    private Boolean isReceive;

    @ApiModelProperty("是否需要领取码")
    private boolean needReceiveCode;

    @ApiModelProperty("用户优惠券ID")
    private int userCouponId;

    @ApiModelProperty("有效期")
    private String effectiveDate;

    @ApiModelProperty("优惠券描述")
    private String description;

    @ApiModelProperty("优惠券内容类型")
    private Integer content;

}