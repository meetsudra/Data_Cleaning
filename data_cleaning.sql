/*
cleaning data in sql queries
*/

Select * 
from myotherdatabase..Nashville

------------------------------------------------------------------------------------------------------

--standardise date format
Select SaleDate
from myotherdatabase..Nashville

Select SaleDate , CONVERT(date,SaleDate)
from myotherdatabase..Nashville

Alter Table Nashville
add SaleDateConverted date

Update  Nashville
set SaleDateConverted = CONVERT(date,Saledate)

Select SaleDateConverted 
from myotherdatabase..Nashville

----------------------------------------------------------------------------------------------------------------------------------------------------

--populate property address data
Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from myotherdatabase..Nashville a
JOIN myotherdatabase..Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from myotherdatabase..Nashville a
JOIN myotherdatabase..Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

------------------------------------------------------------------------------------------------------------------------------------------------------

--Breaking out address into individual columns (Address, City, State)

Select PropertyAddress
from myotherdatabase..Nashville
--where PropertyAddress is Null
--Order by ParcelID

select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as Address ,
CHARINDEX(',',PropertyAddress)
from myotherdatabase..Nashville

ALTER TABLE Nashville
ADD PropertySplitAddress Nvarchar(255)

Update Nashville
set PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1);

Alter Table Nashville
add PropertySplitCity Nvarchar(255)

Update Nashville
set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress));

select *
from myotherdatabase..Nashville

