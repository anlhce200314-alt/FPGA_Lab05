library ieee;
use ieee.std_logic_1164.all;

entity chia is
 port (
 i_Data : in std_logic;
 i_Sel0 : in std_logic;
 i_Sel1 : in std_logic;
 o_Data0 : out std_logic;
 o_Data1 : out std_logic;
 o_Data2 : out std_logic;
 o_Data3 : out std_logic);
end entity chia;

architecture RTL of chia is
begin
 o_Data0 <= i_Data when i_Sel1 = '0' and i_Sel0 = '0' else '0';
 o_Data1 <= i_Data when i_Sel1 = '0' and i_Sel0 = '1' else '0';
 o_Data2 <= i_Data when i_Sel1 = '1' and i_Sel0 = '0' else '0';
 o_Data3 <= i_Data when i_Sel1 = '1' and i_Sel0 = '1' else '0';
end architecture RTL;