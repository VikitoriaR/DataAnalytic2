def comparison_first():
    a: float = 0.1 * 0.3
    b: float = 0.03
    c: float = 0.09 / 3
    equal = (a == b == c)
    print(f"Равны или нет эти три значение: {equal}")


comparison_first() # это почему-то выводит True, хотя числа в формате Float

import math

def comparison_second():
    a = 0.1
    b = 0.2
    c = 0.3

    result = a + b + c  # должно быть 0.6
    expected_result = 0.6

    print(f"x + y + z = {result:.18f}")
    print(f"0.6 = {expected_result:.18f}")
    print("Равны или нет:", result == expected_result)

    equal = math.isclose(result, expected_result, rel_tol=1e-9, abs_tol=1e-9)
    print("Равны или нет (с учетом погрешности):", equal)

comparison_second()