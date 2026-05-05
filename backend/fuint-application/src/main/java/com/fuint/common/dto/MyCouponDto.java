package com.fuint.common.dto;

import com.fuint.repository.model.MtStore;
import com.fuint.repository.model.MtUser;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * ?????DTO
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
@Data
public class MyCouponDto implements Serializable {

    @ApiModelProperty("???ID")
    private Integer id;

    @ApiModelProperty("?????")
    private String name;

    @ApiModelProperty("????")
    private String code;

    @ApiModelProperty("?????")
    private String type;

    @ApiModelProperty("??")
    private String status;

    @ApiModelProperty("???ID")
    private Integer couponId;

    @ApiModelProperty("????")
    private String useRule;

    @ApiModelProperty("??")
    private String image;

    @ApiModelProperty("??")
    private BigDecimal amount;

    @ApiModelProperty("??")
    private BigDecimal balance;

    @ApiModelProperty("??")
    private Integer num;

    @ApiModelProperty("????")
    private boolean canUse;

    @ApiModelProperty("???")
    private String effectiveDate;

    @ApiModelProperty("????")
    private String tips;

    @ApiModelProperty("????")
    private Date usedTime;

    @ApiModelProperty("????")
    private Date createTime;

    @ApiModelProperty("????")
    private MtUser userInfo;

    @ApiModelProperty("????")
    private MtStore storeInfo;

    @ApiModelProperty("???????")
    private Integer content;

    public void setContent(Integer content) {
        this.content = content;
    }

    public Integer getContent() {
        return content;
    }

}