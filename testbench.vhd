library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is

    -- Declaração do componente a ser testado (FSM)
    component fsm
      port ( 
        i_CLK : in  std_logic;  -- Entrada de clock
        i_A   : in  std_logic;  -- Entrada de controle
        o_R   : out std_logic   -- Saída da FSM
      );
    end component;

    -- Sinais de estímulo usados no testbench
    signal w_CLK : std_logic := '0'; -- Sinal de clock
    signal w_A   : std_logic := '0'; -- Sinal de entrada (simula apertar a chave)
    signal w_R   : std_logic;        -- Sinal de saída da FSM

    -- Constante que define o período do clock
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instancia o componente FSM dentro do testbench
    DUT: fsm
      port map (
         i_CLK => w_CLK,  -- Conecta o clock da FSM ao sinal w_CLK
         i_A   => w_A,    -- Conecta a entrada da FSM ao sinal w_A
         o_R   => w_R     -- Conecta a saída da FSM ao sinal w_R
      );

    -- Processo responsável por gerar o sinal de clock contínuo
    p_CLK_GEN : process
    begin
      w_CLK <= '0';
      wait for CLK_PERIOD / 2; -- metade do período (fase baixa)
      w_CLK <= '1';
      wait for CLK_PERIOD / 2; -- metade do período (fase alta)
    end process;

    -- Processo que gera os estímulos de teste (simula o comportamento da entrada)
    stim_proc : process
    begin
        -- Estado inicial: entrada desativada
        w_A <= '0';

        -- Primeira sequência de pulsos (simula apertos da chave)
        wait for 20 ns;
        w_A <= '1';
        wait for 10 ns; -- Estado K1
        wait for 10 ns; -- Estado K2
        wait for 10 ns; -- Estado K3
        wait for 10 ns; -- Estado K4
        
        -- Pausa (entrada em '0')
        w_A <= '0';
        wait for 10 ns; 
        
        -- Segunda sequência: alterna '1' e '0' rapidamente
        w_A <= '1';
        wait for 10 ns; -- K1
        w_A <= '0';
        wait for 10 ns; -- K2
        wait for 10 ns; -- K3
        wait for 10 ns; -- K4
        
        -- Terceira sequência: mantém '1' constante (testa ciclo contínuo)
        wait for 10 ns; -- Espera
        w_A <= '1';
        wait for 10 ns; -- K1
        wait for 10 ns; -- K2
        wait for 10 ns; -- K3
        wait for 10 ns; -- K4
        wait for 10 ns; -- Espera
    
        wait; -- Finaliza a simulação (sem tempo definido)
    end process;
end tb;
