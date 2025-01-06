package sys_repositories

import (
	"errors"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/global/variable"
)

type userCrud struct{}

var UserCrud = new(userCrud)

// SelectUserByUserName 根据username查询用户
func (u *userCrud) SelectUserByUserName(username string) (user *sys_model.SysUser, err error) {
	result := variable.GormDbMysql.Where("user_name = ? and del_flag = 0", username).First(&user)
	if result.RowsAffected == 0 {
		return nil, errors.New(consts.EXISTS)
	}
	return
}
