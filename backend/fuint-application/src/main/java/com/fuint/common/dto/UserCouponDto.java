package com.fuint.common.dto;

import com.fuint.repository.model.MtConfirmLog;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * ?????DTO
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
@Getter
@Setter
public class UserCouponDto implements Serializable {

    @ApiModelProperty("???ID")
    private Integer id;

    @ApiModelProperty("?????")
    private String name;

    @ApiModelProperty("?????")
    private String type;

    @ApiModelProperty("??")
    private String status;

    @ApiModelProperty("???ID")
    private Integer couponId;

    @ApiModelProperty("????")
    private String useRule;

    @ApiModelProperty("????")
    private String code;

    @ApiModelProperty("???")
    private String qrCode;

    @ApiModelProperty("??")
    private String image;

    @ApiModelProperty("??")
    private BigDecimal amount;

    @ApiModelProperty("?????")
    private Boolean isGive;

    @ApiModelProperty("??")
    private BigDecimal balance;

    @ApiModelProperty("????")
    private Integer confirmCount;

    @ApiModelProperty("????")
    private List<MtConfirmLog> confirmLogs;

    @ApiModelProperty("????(????)")
    private boolean canUse;

    @ApiModelProperty("???")
    private String effectiveDate;

    @ApiModelProperty("????")
    private String storeNames;

    @ApiModelProperty("????")
    private String tips;

    @ApiModelProperty("?????")
    private String description;

    @ApiModelProperty("???????")
    private Integer content;

    public void setContent(Integer content) {
        this.content = content;
    }

    public Integer getContent() {
        return content;
    }

}