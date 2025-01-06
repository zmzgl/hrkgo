package dict_redis

import (
	"fmt"
	"github.com/go-redis/redis/v8"
	"hrkGo/utils/global/variable"
	redis2 "hrkGo/utils/redis"
	"time"
)

type DictStore struct {
	Client *redis.Client
}

// SetWithExpire 设置临时存储(带过期时间)
func (d *DictStore) SetWithExpire(key string, value interface{}, expiration time.Duration) error {
	return d.Client.Set(redis2.Ctx, key, value, expiration).Err()
}

// Set 永久存储
func (d *DictStore) Set(key string, value interface{}) error {
	return d.Client.Set(redis2.Ctx, key, value, 0).Err()
}

// Get 实现获取 captcha 的方法
func (d *DictStore) Get(key string, clear bool) string {
	val, err := variable.Redis.Get(redis2.Ctx, key).Result()
	if err != nil {
		fmt.Println(err)
		return ""
	}
	if clear {
		err := variable.Redis.Del(redis2.Ctx, key).Err()
		if err != nil {
			fmt.Println(err)
			return ""
		}
	}
	return val
}

// Verify 效验
func (d *DictStore) Verify(id, answer string, clear bool) bool {
	v := d.Get(id, clear)
	return v == answer
}

// DeleteByPrefixBatch 支持自定义批次大小的删除
func (d *DictStore) DeleteByPrefixBatch(prefix string, batchSize int64) (int64, error) {

	var cursor uint64
	var totalDeleted int64

	for {
		var keys []string
		var err error

		// 每次扫描指定数量的键
		keys, cursor, err = variable.Redis.Scan(redis2.Ctx, cursor, prefix+"*", batchSize).Result()
		if err != nil {
			return totalDeleted, err
		}

		if len(keys) > 0 {
			// 批量删除当前批次的键
			deleted, err := variable.Redis.Del(redis2.Ctx, keys...).Result()
			if err != nil {
				return totalDeleted, err
			}
			totalDeleted += deleted
		}

		// 如果 cursor 为 0，说明已经扫描完所有键
		if cursor == 0 {
			break
		}
	}

	return totalDeleted, nil
}
