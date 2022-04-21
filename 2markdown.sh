#!/bin/bash

echo "# $1城市销量" > /home/liu/Tools/carsql/$1城市销量.md

echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 城市销量排名" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 城市,sum(2022y1),sum(2022y2),sum(2022y3),(sum(2022y1)+sum(2022y2)+sum(2022y3)) as 累计销量
FROM just4live.car2022 
WHERE 省份='河南'
GROUP BY 城市
ORDER BY 累计销量
DESC;" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 新能源占比" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 燃料类别,sum(2022y3)
FROM just4live.car2022
WHERE 城市='$1'
GROUP BY 燃料类别
ORDER BY sum(2022y3)
DESC
;" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 车型占比" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 级别,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' 
GROUP BY 级别 
ORDER BY sum(2022y3) 
DESC;" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 月度品牌销量" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1'
GROUP BY 整理品牌 HAVING sum(2022y3)>0
ORDER BY sum(2022y3) 
DESC
LIMIT 35;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 单车型 TOP20" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 纯电 TOP20" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 燃料类别='BEV'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## SUV TOP20" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='SUV'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 微型车 TOP20" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='微型车'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


echo "" >> /home/liu/Tools/carsql/$1城市销量.md
echo "---" >> /home/liu/Tools/carsql/$1城市销量.md
echo "## 紧凑型车 TOP20" >> /home/liu/Tools/carsql/$1城市销量.md
mysql -uliu -p0imchen@ -t -e "
SELECT 整理品牌,车型,sum(2022y3) 
FROM just4live.car2022 
WHERE 城市='$1' AND 级别='紧凑型车'
GROUP BY 整理品牌,车型 HAVING sum(2022y3)>0
ORDER BY sum(2022y3)
DESC
LIMIT 20;
QUIT" >> /home/liu/Tools/carsql/$1城市销量.md


exit;
