CREATE OR REPLACE PACKAGE BODY pkg_std IS
FUNCTION fn_formata_data(p_valor DATE) RETURN VARCHAR2 IS
  BEGIN
    RETURN TO_CHR(p_valor, 'dd/mm/yyyy hh24:mi:ss');
  END;
  FUNCTION fn_to_char_aula(p_vlor DATE) RETURN VARCHAR2 IS
  BEGIN
    RETURN fn_formata_data(p_valor);
  END;
  FUNCTION fn_to_char_aula(p_valor NUMBER) RETURN VARCHAR2 IS
  BEGIN
    RETURN TO_CHAR(p_valor + 1);
  END;
END;
