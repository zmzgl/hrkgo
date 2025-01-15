package sys_service

import (
	"errors"
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
	"hrkGo/utils/StringUtils"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis"
	"time"
)

type LoginService struct {
}

func getCacheKey(username string) string { return "pwd_err_cnt:" + username }

// Login 登录
func (u *LoginService) Login(params sys_model.Login) (user *sys_model.SysUser, err error) {
	user, err = sys_repositories.UserCrud.SelectUserByUserName(params.Username)
	if err != nil {
		return nil, err
	} else if user.Status == "1" {
		return nil, errors.New(consts.BLOCKED)
	}

	retryCount := redis.GetInt(getCacheKey(user.UserName))

	if retryCount > 5 {
		return nil, errors.New(consts.DISUSER)
	}

	if !matches(user, params.Password) {
		retryCount = retryCount + 1
		redis.Set(getCacheKey(user.UserName), retryCount, 10*time.Minute)
		return nil, errors.New(consts.EXISTS)

	} else {
		redis.Del(getCacheKey(user.UserName))
	}

	return user, nil
}

// getMenuPermission 菜单权限信息
func (u *LoginService) getMenuPermission(userId string) (perms []string) {
	if sys_model.IsAdmin(userId) {
		perms = append(perms, "*:*:*")
	}

	return perms
}

// matches 判断密码是否与数据库一致
func matches(user *sys_model.SysUser, password string) bool {
	return StringUtils.BcryptMakeCheck([]byte(password), user.Password)
}

// GetOpenIdUser 通过uuid查找用户
func (u *LoginService) GetOpenIdUser(openId string) (user *sys_model.SysUser, err error) {
	err = variable.GormDbMysql.Where("open_id = ? and del_flag = 0", openId).First(&user).Error
	return user, err
}

// GetUserInfo 获取用户信息
func (u *LoginService) GetUserInfo(id string) (user *sys_model.SysUserInfo, err error) {
	err = variable.GormDbMysql.Preload("Dept").Preload("Roles").Where("user_id = ? and del_flag = 0", id).First(&user).Error
	return user, err
}
