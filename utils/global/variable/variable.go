package variable

import (
	"github.com/go-redis/redis/v8"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"hrkGo/utils/global/my_errors"
	"hrkGo/utils/yml_config/ymlconfig_interf"
	"log"
	"os"
	"strings"
)

// ginskeleton 封装的全局变量全部支持并发安全，请放心使用即可
// 开发者自行封装的全局变量，请做好并发安全检查与确认

var (
	BasePath           string                  // 定义项目的根目录
	EventDestroyPrefix = "Destroy_"            //  程序退出时需要销毁的事件前缀
	ConfigKeyPrefix    = "Config_"             //  配置文件键值缓存时，键的前缀
	DateFormat         = "2006-01-02 15:04:05" //  设置全局日期时间格式

	Redis *redis.Client
	// 全局日志指针
	ZapLog *zap.Logger
	// 全局配置文件
	ConfigYml       ymlconfig_interf.YmlConfigInterf // 全局配置文件指针
	ConfigGormv2Yml ymlconfig_interf.YmlConfigInterf // 全局配置文件指针

	GormDbMysql *gorm.DB // 全局gorm的客户端连接

	//gorm 数据库客户端，如果您操作数据库使用的是gorm，请取消以下注释，在 bootstrap>init 文件，进行初始化即可使用

	//  用户自行定义其他全局变量 ↓

)

func init() {
	// 1.初始化程序根目录
	if curPath, err := os.Getwd(); err == nil {
		// 路径进行处理，兼容单元测试程序程序启动时的奇怪路径
		if len(os.Args) > 1 && strings.HasPrefix(os.Args[1], "-test") {
			BasePath = strings.Replace(strings.Replace(curPath, `\test`, "", 1), `/test`, "", 1)
		} else {
			BasePath = curPath
		}
	} else {
		log.Fatal(my_errors.ErrorsBasePath)
	}
}
