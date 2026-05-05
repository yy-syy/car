package com.fuint.common.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * ?????DTO
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
@Getter
@Setter
public class ReqCouponDto implements Serializable {

    @ApiModelProperty("???ID")
    private Integer id;

    @ApiModelProperty("??ID")
    private Integer merchantId;

    @ApiModelProperty("??ID")
    private Integer storeId;

    @ApiModelProperty("??ID")
    private Integer groupId;

    @ApiModelProperty("?????")
    private String type;

    @ApiModelProperty("?????")
    private String name;

    @ApiModelProperty("?????")
    private Integer isGive;

    @ApiModelProperty("??????")
    private Integer point;

    @ApiModelProperty("????????")
    private Integer timerPoint;

    @ApiModelProperty("???")
    private String receiveCode;

    @ApiModelProperty("????")
    private String useFor;

    @ApiModelProperty("????")
    private String expireType;

    @ApiModelProperty("????")
    private Integer expireTime;

    @ApiModelProperty("?????")
    private String timerReceiveCode;

    @ApiModelProperty("????")
    private String beginTime;

    @ApiModelProperty("????")
    private String endTime;

    @ApiModelProperty("?????")
    private BigDecimal amount;

    @ApiModelProperty("????")
    private String sendWay;

    @ApiModelProperty("????")
    private String applyGoods;

    @ApiModelProperty("????")
    private Integer sendNum;

    @ApiModelProperty("???")
    private Integer total;

    @ApiModelProperty("??????")
    private Integer limitNum;

    @ApiModelProperty("????")
    private String exceptTime;

    @ApiModelProperty("????ID??")
    private String storeIds;

    @ApiModelProperty("??????ID??")
    private String gradeIds;

    @ApiModelProperty("????ID")
    private String goodsIds;

    @ApiModelProperty("??")
    private String remarks;

    @ApiModelProperty("??")
    private String image;

    @ApiModelProperty("??")
    private String description;

    @ApiModelProperty("????")
    private String inRule;

    @ApiModelProperty("?????")
    private String outRule;

    @ApiModelProperty("???")
    private String operator;

    @ApiModelProperty("??")
    private String status;

    @ApiModelProperty("???????")
    private Integer content;

    public Integer getContent() {
        return content;
    }

    public void setContent(Integer content) {
        this.content = content;
    }

}