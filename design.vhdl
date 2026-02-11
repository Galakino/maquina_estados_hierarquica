library ieee;
use ieee.std_logic_1164.all;

-- Entidade principal da máquina de estados
entity fsm is
  port (
    i_CLK   : in  std_logic;            -- Sinal de clock
    i_A     : in  std_logic;            -- Entrada (chave de controle)
    o_R     : out std_logic             -- Saída (resultado da FSM)
  );
end entity;

architecture estrutural of fsm is
  -- Sinais internos para interligar os blocos
  signal w_B, w_N : std_logic_vector(2 downto 0);  -- w_B = estado atual / w_N = próximo estado
begin
  -- Bloco responsável por armazenar o estado atual (registrador)
  u_BLOCO_ESTADO : entity work.registrador_estado
    port map (
      i_CLK => i_CLK,   -- Clock da FSM
      i_N   => w_N,     -- Próximo estado calculado
      o_B   => w_B      -- Estado atual armazenado
    );

  -- Bloco combinacional que define o próximo estado da FSM
  u_BLOCO_PROX : entity work.proximo_estado
    port map (
      i_B => w_B,       -- Estado atual
      i_A => i_A,       -- Entrada de controle
      o_N => w_N        -- Próximo estado calculado
    );

  -- Bloco de saída (define o valor da saída conforme o estado atual)
  u_BLOCO_SAIDA : entity work.saida
    port map (
      i_B => w_B,       -- Estado atual
      o_R => o_R        -- Saída da FSM
    );
end architecture;
