library ieee;
use ieee.std_logic_1164.all;

-- Registrador responsável por armazenar o estado atual da FSM
entity registrador_estado is
  port (
    i_CLK : in  std_logic;                     -- Sinal de clock
    i_N   : in  std_logic_vector(2 downto 0);  -- Próximo estado calculado
    o_B   : out std_logic_vector(2 downto 0)   -- Estado atual armazenado
  );
end entity;

architecture rtl of registrador_estado is
  -- Registrador interno que guarda o estado atual (inicializado em "000")
  signal r_ESTADO : std_logic_vector(2 downto 0) := "000";
begin
  -- Processo sensível ao clock: atualiza o estado a cada borda de subida
  process (i_CLK)
  begin
    if rising_edge(i_CLK) then
      r_ESTADO <= i_N;  -- Armazena o próximo estado
    end if;
  end process;

  -- Saída do estado atual
  o_B <= r_ESTADO;
end architecture;
