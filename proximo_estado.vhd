library ieee;
use ieee.std_logic_1164.all;

-- Bloco combinacional responsável por determinar o próximo estado da FSM
entity proximo_estado is
  port (
    i_B : in  std_logic_vector(2 downto 0);  -- Estado atual
    i_A : in  std_logic;                     -- Entrada de controle (chave)
    o_N : out std_logic_vector(2 downto 0)   -- Próximo estado calculado
  );
end entity;

architecture comb of proximo_estado is
begin
  -- Processo combinacional que define a lógica de transição entre estados
  process (i_B, i_A)
  begin
    case i_B is
      -- Estado de espera: só avança para K1 se a entrada for '1'
      when "000" =>
        if i_A = '1' then 
          o_N <= "001";   -- Vai para K1
        else 
          o_N <= "000";   -- Permanece em espera
        end if;

      -- Estado K1 → avança para K2
      when "001" =>
        o_N <= "010";

      -- Estado K2 → avança para K3
      when "010" =>
        o_N <= "011";

      -- Estado K3 → avança para K4
      when "011" =>
        o_N <= "100";

      -- Estado K4 → retorna para espera
      when "100" =>
        o_N <= "000";

      -- Situação padrão (segurança)
      when others =>
        o_N <= "000";
    end case;
  end process;
end architecture;
