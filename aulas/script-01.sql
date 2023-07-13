SET serveroutput ON
DECLARE
  v_contador  NUMBER;
BEGIN
  FOR v_contador IN REVERSE 0..10 LOOP
    DBMS_OUTPUT.PUT_LINE(v_contador);
  END LOOP;
END;
