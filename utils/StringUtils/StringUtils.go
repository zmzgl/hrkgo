package StringUtils

import (
	"golang.org/x/crypto/bcrypt"
	"log"
	"strings"
	"unicode"
	"unicode/utf8"
)

func BcryptMake(pwd []byte) string {
	hash, err := bcrypt.GenerateFromPassword(pwd, bcrypt.MinCost)
	if err != nil {
		log.Println(err)
	}
	return string(hash)
}

// BcryptMakeCheck 密码校验
func BcryptMakeCheck(pwd []byte, hashedPwd string) bool {
	byteHash := []byte(hashedPwd)
	err := bcrypt.CompareHashAndPassword(byteHash, pwd)
	if err != nil {
		return false
	}
	return true
}

// IsBlank 检查字符串是否为空（包括空字符串、纯空格字符串）
func IsBlank(str string) bool {
	return len(strings.TrimSpace(str)) != 0
}

// Capitalize 将字符串的第一个字符转换为大写
func Capitalize(str string) string {
	if str == "" {
		return str
	}

	// 获取第一个字符
	r, size := utf8.DecodeRuneInString(str)
	if r == utf8.RuneError {
		return str
	}

	// 如果第一个字符已经是大写，直接返回原字符串
	if unicode.IsUpper(r) {
		return str
	}

	// 转换第一个字符为大写
	return string(unicode.ToUpper(r)) + str[size:]
}

// IsHttp 是否为http(s)://开头
func IsHttp(link string) bool {
	return strings.HasPrefix(link, "http://") || strings.HasPrefix(link, "https://")
}

// IsNotEmpty 正确的写法
func IsNotEmpty[T any](arr []T) bool {
	return arr != nil && len(arr) > 0 // 使用 AND 操作符
}

// IsEmptyStr 判断字符串为空的函数
func IsEmptyStr(str string) bool {
	return len(strings.TrimSpace(str)) == 0
}
