package sys_service

import (
	"errors"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/StringUtils"
	"hrkGo/utils/global/variable"
)

type LoginCurd struct {
}

// Login 登录
func (u *LoginCurd) Login(params sys_model.Login) (user *sys_model.SysUser, err error) {
	err = variable.GormDbMysql.Where("user_name = ? and del_flag = 0", params.Username).First(&user).Error
	if err != nil || !StringUtils.BcryptMakeCheck([]byte(params.Password), user.Password) {
		return nil, errors.New("用户名或密码错误")
	}
	return user, nil
}

// GetOpenIdUser 通过uuid查找用户
func (u *LoginCurd) GetOpenIdUser(openId string) (user *sys_model.SysUser, err error) {
	err = variable.GormDbMysql.Where("open_id = ? and del_flag = 0", openId).First(&user).Error
	return user, err
}

// GetUserInfo 获取用户信息
func (u *LoginCurd) GetUserInfo(id uint) (user *sys_model.SysUserInfo, err error) {
	err = variable.GormDbMysql.Preload("Dept").Preload("Roles").Where("user_id = ? and del_flag = 0", id).First(&user).Error
	return user, err
}
