from decimal import Decimal

# 链上收益0.0228/T/天
current_chain_profit = 0.0228
total_xft = 1024 * 1024

left_xft = 767570
sold_xft = total_xft - left_xft
days = 14
seconds = days * 24 * 3600

# 提高精度，不要显示科学计数，精确到小数点后18个0
def print_decimal(f):
    f = Decimal.from_float(f * 1000000000000000000)
    print(f)

# 每TiB算力每小时奖励
print("收益周期：%s" % seconds  )
print("40TB每小时收益：")
print(current_chain_profit*0.4*40*100/103/24)
print("40TB每天收益：")
print(current_chain_profit*0.4*40*100/103)
print("40TB每分钟收益： ")
print(current_chain_profit*0.4*40*100/103/24/60)
print(current_chain_profit*0.4*40*100/103/24/60)

# 总共需要补充进池子的FIL数量
transfer = sold_xft / 1024 * current_chain_profit * 0.4 * days

# 总共需要发放的数量
total = current_chain_profit * (total_xft / 1024) * 0.4 * days
print("总共需要发的：%s" % total)
print_decimal(total)

xft_pool = total * 100 / 103
xfti_pool = total * 3 / 103

xft = transfer * 100 / 103
xfti = transfer * 3 / 103

print()
print("xft池子收益")
print(xft_pool)
print_decimal(xft_pool)
print()
print("xfti池子收益")
print(xfti_pool)
print_decimal(xfti_pool)

print()
print("实际需转账到2个池子的金额：")
print(xft)
print(xfti)
print("总计：")
print(transfer)
