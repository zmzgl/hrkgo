package response

import (
	"github.com/gin-gonic/gin"
	"hrkGo/utils/global/consts"
	"net/http"
)

// Response 响应结构体
type Response struct {
	Code int         `json:"code"` // 自定义错误码
	Data interface{} `json:"data"` // 数据
	Msg  string      `json:"msg"`  // 信息
}

// ResponseRow 响应结构体
type ResponseRow struct {
	Code  int         `json:"code"`  // 自定义错误码
	Row   interface{} `json:"rows"`  // 数据
	Msg   string      `json:"msg"`   // 信息
	Total int64       `json:"total"` // 总数
}

// Success 直接返回成功
func Success(c *gin.Context, msg string, data interface{}) {
	ReturnJson(c, http.StatusOK, consts.CurdStatusOkCode, msg, data)
}

// SuccessNil 直接返回成功
func SuccessNil(c *gin.Context, msg string) {
	ReturnNil(c, http.StatusOK, consts.CurdStatusOkCode, msg)
}

// SuccessToken 直接返回成功token
func SuccessToken(c *gin.Context, msg string, data interface{}) {
	ReturnTokenJson(c, http.StatusOK, consts.CurdStatusOkCode, msg, data)
}

// SuccessInfo 直接返回成功token
func SuccessInfo(c *gin.Context, msg string, permissions []string, roles []string, user interface{}) {
	ReturnTokenInfo(c, http.StatusOK, consts.CurdStatusOkCode, msg, permissions, roles, user)
}
func ReturnTokenInfo(Context *gin.Context, httpCode int, dataCode int, msg string, permissions []string, roles []string, user interface{}) {
	Context.JSON(httpCode, gin.H{
		"code":        dataCode,
		"msg":         msg,
		"permissions": permissions,
		"roles":       roles,
		"user":        user,
	})
}

// ValidateFail 请求参数验证失败
func ValidateFail(c *gin.Context, msg string) {
	Fail(c, http.StatusInternalServerError, msg)
}

// BusinessFail 业务逻辑失败
func BusinessFail(c *gin.Context, msg string) {
	Fail(c, http.StatusInternalServerError, msg)
}

// TokenFail 鉴权失败
func TokenFail(c *gin.Context) {
	Fail(c, http.StatusUnauthorized, consts.Authenticationfailed)
}

// TokenForbidden 鉴权失败
func TokenForbidden(c *gin.Context) {
	Fail(c, http.StatusForbidden, consts.Forbidden)
}

// Fail 响应失败 ErrorCode 不为 0 表示失败
func Fail(c *gin.Context, errorCode int, msg string) {
	c.JSON(http.StatusOK, Response{
		errorCode,
		nil,
		msg,
	})
}

// SuccessRow 分页查询 ErrorCode 为 200 表示成功
func SuccessRow(c *gin.Context, msg string, rows interface{}, total int64) {
	c.JSON(http.StatusOK, ResponseRow{
		200,
		rows,
		msg,
		total,
	})
}
func ReturnTokenJson(Context *gin.Context, httpCode int, dataCode int, msg string, data interface{}) {
	Context.JSON(httpCode, gin.H{
		"code":  dataCode,
		"msg":   msg,
		"token": data,
	})
}

func ReturnJson(Context *gin.Context, httpCode int, dataCode int, msg string, data interface{}) {
	Context.JSON(httpCode, gin.H{
		"code": dataCode,
		"msg":  msg,
		"data": data,
	})
}

func ReturnNil(Context *gin.Context, httpCode int, dataCode int, msg string) {
	Context.JSON(httpCode, gin.H{
		"code": dataCode,
		"msg":  msg,
	})
}
