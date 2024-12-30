package bootstrap

import (
	"hrkGo/app/service/sys_log_hook"
	"hrkGo/utils/global/my_errors"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/gorm_v2"
	"hrkGo/utils/redis"
	"hrkGo/utils/snow_flake"
	"hrkGo/utils/yml_config"
	"hrkGo/utils/zap_factory"
	"log"
	"os"
)

// 检查项目必须的非编译目录是否存在，避免编译后调用的时候缺失相关目录
func checkRequiredFolders() {
	//1.检查配置文件是否存在
	if _, err := os.Stat(variable.BasePath + "/config/config.yml"); err != nil {
		log.Fatal(my_errors.ErrorsConfigYamlNotExists + err.Error())
	}
	if _, err := os.Stat(variable.BasePath + "/config/gorm_v2.yml"); err != nil {
		log.Fatal(my_errors.ErrorsConfigGormNotExists + err.Error())
	}

	//3.检查storage/logs 目录是否存在
	if _, err := os.Stat(variable.BasePath + "/storage/logs/"); err != nil {
		log.Fatal(my_errors.ErrorsStorageLogsNotExists + err.Error())
	}

}

func init() {
	// 1. 初始化 项目根路径，参见 variable 常量包，相关路径：app\global\variable\variable.go
	//2.检查配置文件以及日志目录等非编译性的必要条件
	checkRequiredFolders()

	// 4.启动针对配置文件(confgi.yml、gorm_v2.yml)变化的监听， 配置文件操作指针，初始化为全局变量
	variable.ConfigYml = yml_config.CreateYamlFactory()
	variable.ConfigYml.ConfigFileChangeListen()

	// config>gorm_v2.yml 启动文件变化监听事件
	variable.ConfigGormv2Yml = variable.ConfigYml.Clone("gorm_v2")
	variable.ConfigGormv2Yml.ConfigFileChangeListen()

	// 7.雪花算法全局变量
	variable.SnowFlake = snow_flake.CreateSnowflakeFactory()

	// 5.初始化全局日志句柄，并载入日志钩子处理函数
	variable.ZapLog = zap_factory.CreateZapFactory(sys_log_hook.ZapLogHandler)
	variable.Redis = redis.CreateRedisFactory()

	// 6.根据配置初始化 gorm mysql 全局 *gorm.Db
	if variable.ConfigGormv2Yml.GetInt("Gormv2.Mysql.IsInitGlobalGormMysql") == 1 {
		if dbMysql, err := gorm_v2.GetOneMysqlClient(); err != nil {
			log.Fatal(my_errors.ErrorsGormInitFail + err.Error())
		} else {
			variable.GormDbMysql = dbMysql
		}
	}

}
