package com.fuint.module.backendApi.controller;

import com.fuint.common.service.CaptchaService;
import com.fuint.common.util.SeqUtil;
import com.fuint.framework.web.ResponseObject;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 图形验证码接口
 *
 * Created by FSQ
 * CopyRight https://www.fuint.cn
 */
@Api(tags="管理端-图形验证码相关接口")
@Controller
@AllArgsConstructor
@RequestMapping("/backendApi/captcha")
public class BackendCaptchaController {

    private static final Logger logger = LoggerFactory.getLogger(BackendCaptchaController.class);

    private CaptchaService captchaService;

    @ApiOperation(value = "获取图形验证码")
    @RequestMapping(value="/getCode", method = RequestMethod.GET)
    @CrossOrigin
    public void getCode(HttpServletResponse response, HttpServletRequest request) throws Exception {
        String uuid = SeqUtil.getUUID();
        request.getSession().setAttribute("captchaUuid", uuid);
        
        BufferedImage codeImage = captchaService.getCodeByUuid(uuid);

        response.setDateHeader("Expires", 0);
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.addHeader("Cache-Control", "no-cache");
        response.setContentType("image/jpeg");
        response.setHeader("captcha-uuid", uuid);
        
        ServletOutputStream out = null;
        try {
            out = response.getOutputStream();
            ImageIO.write(codeImage, "jpg", out);
            out.flush();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    logger.error(e.getMessage(), e);
                }
            }
        }
    }

    @ApiOperation(value = "验证图形验证码")
    @RequestMapping(value="/checkCode", method = RequestMethod.POST)
    @CrossOrigin
    @ResponseBody
    public ResponseObject checkCode(@RequestBody Map<String, String> params) {
        String code = params.get("code");
        String uuid = params.get("uuid") == null ? "" : params.get("uuid");
        Boolean flag = captchaService.checkCodeByUuid(code, uuid);
        if (flag) {
            return new ResponseObject(200, "success", true);
        } else {
            return new ResponseObject(200, "验证码错误", false);
        }
    }
}
