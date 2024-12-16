package system

import (
	"github.com/mojocn/base64Captcha"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis_config"
	"image/color"
	"time"
)

const CAPTCHA = "captcha:"

var store base64Captcha.Store = redis_config.RedisStore{
	Client:   variable.Redis,
	ExpireIn: time.Minute * 2,
}

// CaptMake 生成验证码
func CaptMake() (id, b64s string, err error) {
	var driver base64Captcha.Driver
	// 配置验证码信息
	driverString := base64Captcha.DriverString{
		Height:          40,
		Width:           100,
		NoiseCount:      0,
		ShowLineOptions: 2 | 4,
		Length:          4,
		Source:          "1234567890qwertyuioplkjhgfdsazxcvbnm",
		BgColor: &color.RGBA{
			R: 3, G: 102, B: 214, A: 125}, Fonts: []string{"wqy-microhei.ttc"}}
	//ConvertFonts 按名称加载字体
	driver = driverString.ConvertFonts()

	// 实例化一个captcha结构体
	captcha := base64Captcha.NewCaptcha(driver, store)
	// 生成id,content,answer
	id, content, answer := captcha.Driver.GenerateIdQuestionAnswer()

	// 将answer存到内存中
	key := CAPTCHA + id
	err = captcha.Store.Set(key, answer)

	item, errs := captcha.Driver.DrawCaptcha(content)
	if errs != nil {
		err = errs
	}
	lb64s := item.EncodeB64string()

	return id, lb64s, err
}

// CaptVerify 验证captcha是否正确
func CaptVerify(id string, capt string) bool {
	key := CAPTCHA + id
	if store.Verify(key, capt, false) {
		return true
	} else {
		return false
	}
}
