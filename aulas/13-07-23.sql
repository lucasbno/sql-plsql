SET serveroutput ON
DECLARE
  v_x   NUMBER := 10;
BEGIN
  LOOP
    dbms_output.put_line(v_x);
    v_x := v_x + 10;
    EXIT WHEN v_x > 50;  
  END LOOP;
  
  dbms_output.put_line('Depois do EXIT v_x eh: ' || v_x);  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a + 1;
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2);
BEGIN
  FOR v_a IN 10..20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_contador    NUMBER := 0;
BEGIN
  FOR i IN 1..100 LOOP
    v_contador := v_contador + 1;
  END LOOP;
  
  dbms_output.put_line('O valor final de v_contador eh: ' || v_contador);
  
END;


SET serveroutput ON
BEGIN
  FOR i IN 0..100 LOOP
    dbms_output.put_line('O valor de i eh: ' || i);
  END LOOP;  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2);
BEGIN
  FOR v_a IN REVERSE 10..20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_contador    NUMBER := 1;
BEGIN
  <<loop_pai>>
  FOR i IN 1..1000 LOOP
    <<loop_filho>>
    LOOP
      EXIT loop_pai WHEN v_contador > 10;
      EXIT loop_filho WHEN MOD(v_contador, 10) = 0;
      
      v_contador := v_contador + 1;
    END LOOP loop_filho;
    
    v_contador := v_contador + 1;
  END LOOP loop_pai;
  
  dbms_output.put_line('O valor de v_contador eh: ' || v_contador);
  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('O valor de v_a: ' || v_a);
    v_a := v_a + 1;
    
    IF (v_a > 15) THEN
      --finalizando o loop usando a instrução EXIT
      EXIT;
    END IF;  
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('O valor de v_a: ' || v_a);
    v_a := v_a + 1;
    -- finalizando o loop usando a instrução EXIT WHEN
    EXIT WHEN v_a > 15;
  END LOOP;
END;

SET serveroutput ON
DECLARE
  v_a  NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a + 1;
    
    IF (v_a = 15) THEN
      v_a := v_a + 1;
      CONTINUE;
    END IF;    
  END LOOP;
END;