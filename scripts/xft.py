from decimal import Decimal

# 8/25 链上收益0.0346/T/天
current_chain_profit = 0.0346

total_xft = 1024 * 1024
left_xft = 777310
sold_xft = total_xft - left_xft

# 总共需要补充进池子的FIL数量
transfer = sold_xft / 1024 * current_chain_profit * 0.4 * 7

# 提高精度，不要显示科学计数，精确到小数点后18个0
def print_decimal(f):
    f = Decimal.from_float(f * 1000000000000000000)
    print(f)




# 两个池子总共需要发放的数量
total = current_chain_profit * (total_xft / 1024) * 0.4 * 7
print("总共需要发的：%s" % total)
print_decimal(total)

# 各池子本期需要发放的FIL数量
xft_pool = total*100/103
xfti_pool = total*3/103

# 池子实际需要补充的FIL
xft = transfer * 100/103
xfti = transfer * 3/103

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
