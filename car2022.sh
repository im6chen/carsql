#!/bin/bash
# echo "输入城市: "  
# read city 

# echo "每月城市总销量"
# mysql -uliu -p0imchen@ -t -e "
# SELECT 城市,sum(2022y1),sum(2022y2),sum(2022y3) 
# FROM just4live.car2022 
# WHERE 城市='$1' 
# into outfile '/tmp/每月城市总销量-$1.txt'
# # FIELDS TERMINATED BY '|'
# # LINES TERMINATED BY '\n'
# ;"
# mv /tmp/每月城市总销量-$1.txt /home/liu/Tools/carsql/


echo "- $1城市销量"

echo ""
echo "-- 每月销量"
mysql -uliu -p0imchen@ -e "
SELECT 城市,sum(2022y1),sum(2022y2),sum(2022y3),(sum(2022y1)+sum(2022y2)+sum(2022y3)) as 累计销量
FROM just4live.car2022 
WHERE 省份='河南'
GROUP BY 城市
ORDER BY 累计销量
DESC;"

echo ""
echo "-- 每月销量"
mysql -uliu -p0imchen@ -e "
SELECT 城市,sum(2022y1),sum(2022y2),sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1';"


echo ""
echo "-- 新能源占比"
mysql -uliu -p0imchen@ -e "
SELECT 燃料类别,sum(2022y3)
FROM just4live.car2022
WHERE 城市='$1'
GROUP BY 燃料类别
ORDER BY sum(2022y3)
DESC
;"


echo ""
echo "-- 车型占比"
mysql -uliu -p0imchen@ -e "
SELECT 级别,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' 
GROUP BY 级别 
ORDER BY sum(2022y3) 
DESC;"

echo ""
echo "-- 月度品牌销量"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1'
GROUP BY 整理品牌 HAVING sum(2022y3)>0
ORDER BY sum(2022y3) 
DESC;
QUIT"

echo ""
echo "---------------"
echo "## 单车型 TOP20"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT"

echo ""
echo "-------------"
echo "## 纯电 TOP20"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 燃料类别='BEV'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT"

echo ""
echo "------------"
echo "## SUV TOP20"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='SUV'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT"

echo ""
echo "---------------"
echo "## 微型车 TOP20"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='微型车'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT"

echo ""
echo "-----------------"
echo "## 紧凑型车 TOP20"
mysql -uliu -p0imchen@ -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='紧凑型车'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT"


exit;
