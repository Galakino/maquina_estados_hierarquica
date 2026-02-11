library ieee;
use ieee.std_logic_1164.all;

entity saida is
  port (
    i_B : in  std_logic_vector(2 downto 0); -- Entrada de 3 bits representando o estado atual
    o_R : out std_logic                     -- Saída de 1 bit (sinal lógico)
  );
end entity;

architecture comb of saida is
begin
  process (i_B) -- Processo sensível às mudanças no vetor de entrada i_B
  begin
    case i_B is
      when "001" | "010" | "100" => -- Quando o estado é K1, K2 ou K4
        o_R <= '1';                -- Ativa a saída (coloca em nível lógico alto)
      when others =>               -- Para qualquer outro estado
        o_R <= '0';                -- Desativa a saída (nível lógico baixo)
    end case;
  end process;
end architecture;
