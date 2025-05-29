-- exploratory data analysis (eda)

select *
from layoffs_staging2;


select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off =1
order by total_laid_off desc;


select *
from layoffs_staging2
where percentage_laid_off =1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;


select *
from layoffs_staging2;


select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;


-- we order by individual date

select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

-- we order by the year

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by  stage
order by 2 desc;

-- we are going to look at percentages


select company, avg(percentage_laid_off)
from layoffs_staging2
group by  company
order by 2 desc;


-- we look at the progression of layoffs

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;

-- we use cte to create rolling total

with rolling_total as 
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`,total_off, sum(total_off) over(order by `month` ) as rolling_total
from rolling_total;



select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by company asc;


-- we are going to rank the companies based onthe number of people they laid off


with company_year(company,years,total_laid_off) as 
(

select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)

), company_year_rank as 
-- we are adding this as another cte


(
select * , dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select* 
from company_year_rank
where ranking <=5
;