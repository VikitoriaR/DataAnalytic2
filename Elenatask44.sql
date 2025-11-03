SELECT MAX(EXTRACT(YEAR FROM AGE(NOW(), Student.birthday))) AS max_year
from Student
     LEFT  join Student_in_class on Student_in_class.student=Student.id
     LEFT join class on Student_in_class.class=Class.id
where Class.name LIKE '10%'