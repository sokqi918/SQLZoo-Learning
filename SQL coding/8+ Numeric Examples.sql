/* 1.
The example shows the number who responded for:

question 1
at 'Edinburgh Napier University'
studying '(8) Computer Science'
Show the the percentage who STRONGLY AGREE */

SELECT (A_STRONGLY_AGREE * 1.0 / 
       (A_STRONGLY_DISAGREE + A_DISAGREE + A_NEUTRAL + A_AGREE + A_STRONGLY_AGREE + A_NA)) * 100 AS ratio_percentage
FROM nss
WHERE question = 'Q01'
  AND institution = 'Edinburgh Napier University'
  AND subject = '(8) Computer Science';

/* 2.
Show the institution and subject where the score is at least 100 for question 15. */

SELECT institution, subject
FROM nss
WHERE score >= 100 AND question = 'Q15';

/* 3.
Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15' */

SELECT institution,score
  FROM nss
 WHERE question='Q15' AND subject = '(8) Computer Science'
AND score < 50;

/* 4.
Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. */

SELECT subject, SUM(response)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
 GROUP BY subject;

/* 5.
Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. */

SELECT subject, SUM(response*A_STRONGLY_AGREE/100)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
   AND A_STRONGLY_AGREE IS NOT NULL
 GROUP BY subject;

/* 6.
Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

Use the ROUND function to show the percentage without decimal places. */

SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response),0)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject='(H) Creative Arts and Design')
 GROUP BY subject;

/* 7.
Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.
The column score is a percentage - you must use the method outlined above to multiply the percentage by the response and divide by the total response. Give your answer rounded to the nearest whole number. */

SELECT institution,
    ROUND(SUM(response*score)/SUM(response),0) AS score
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
 GROUP BY institution
ORDER BY institution;

/* 8.
Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'. */

SELECT institution, 
       SUM(SAMPLE) AS total_sample, 
       SUM(CASE WHEN subject LIKE '(8)%' THEN sample ELSE 0 END) AS subject_count
FROM nss
WHERE question = 'Q01'
  AND institution LIKE '%Manchester%'
GROUP BY institution;

