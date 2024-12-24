package consts

// 这里定义的常量，一般是具有错误代码+错误说明组成，一般用于接口返回
const (

	// CURD 常用业务状态码
	CurdStatusOkCode int    = 200
	CurdStatusOkMsg  string = "Success"

	Authenticationfailed string = "登录授权失效"

	/** Layout组件标识 */
	LAYOUT string = "Layout"
	/** 路由名 */
	EMPTY string = ""
	/** 菜单类型（菜单） */
	TYPE_MENU string = "C"
	/** 是否菜单外链（否） */
	NO_FRAME string = "1"
	/** 菜单类型（目录） */
	TYPE_DIR string = "M"

	/** InnerLink组件标识 */
	INNER_LINK string = "InnerLink"
	/** ParentView组件标识 */
	PARENT_VIEW                  string = "ParentView"
	CaptchaCheckParamsInvalidMsg string = "校验验证码：提交的参数无效，请检查 【验证码ID、验证码值】 提交时的键名是否与配置项一致"

	CaptchaCheckFailMsg string = "验证码校验失败"
)
