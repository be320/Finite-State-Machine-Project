library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity fsm is
    port(
    clk,vdd,vss,daytime:in bit;
    reset:in bit;
    code:in bit_vector(3 downto 0);
    door,alarm:out bit        
    );
    end entity;

architecture moore of fsm is
    type state_type is(sBegin,sChar1,sChar2,sChar3,sChar4,sDoor,sAlarm);
    signal current_state: state_type;
    signal next_state: state_type;
-- Synthesis directives :
-- pragma current_state current_state
-- pragma next_state next_state
-- pragma clock clk
    begin

        process(clk)
        begin
            if clk='1' and clk'event then
                current_state <=next_state;      
            end if;
            end process; 

           
        process(current_state,code,reset) 
        begin
           -- if reset ='1' then
          --      next_state <= sBegin;
           -- else
            --Night Conditions
if daytime ='0' then 
            case current_state is

                when sBegin =>
                    door <= '0';
                    alarm <= '0';
		if reset ='1' then
                              next_state <= sBegin; 
	else
                if code= "0010" then         
                    next_state <= sChar1;
                else
                     next_state <= sAlarm;
                   end if;
end if;

                   when sChar1 =>
                        door<= '0';
                       alarm <= '0';
                   if code= "0110" then 
                       next_state <= sChar2;
                   else
                       next_state <= sAlarm;
                      end if;   

                      when sChar2 =>
                      door<= '0';
                      alarm <= '0';
                      if code= "1010" then
                          next_state <= sChar3;
                      else
                          next_state <= sAlarm;
                         end if;

                         when sChar3 =>
                         door<= '0';
                         alarm <= '0';
                         if code= "0000" then
                             next_state <= sChar4;
                         else
                             next_state <= sAlarm;
                            end if; 

                            when sChar4 =>
                            door<= '0';
                            alarm <= '0';
                            if code= "0101" then
                                next_state <= sDoor;
                            else
                                next_state <= sAlarm;
                               end if;  
                               
                              when sDoor =>
                              door<= '1';
                              alarm <= '0';
                              next_state <= sBegin; 
                              
                              when sAlarm =>
                              door<= '0';
                              alarm <= '1';
                              next_state <= sBegin; 
   
         end case; 
else
	case current_state is

                when sBegin =>
                    door<= '0';
                    alarm <= '0';
                if code= "0010" then         
                    next_state <= sChar1;
		elsif code= "1101" then
		     next_state <= sDoor;	
                else
                     next_state <= sAlarm;
                   end if;

                   when sChar1 =>
                        door<= '0';
                       alarm <= '0';
                   if code= "0110" then 
                       next_state <= sChar2;
                 elsif code= "1101" then
		            next_state <= sDoor;	
                   else
                       next_state <= sAlarm;
                      end if;   

                      when sChar2 =>
                      door<= '0';
                      alarm <= '0';
                      if code= "1010" then
                          next_state <= sChar3;
                        elsif code= "1101" then
		                 next_state <= sDoor;	
                      else
                          next_state <= sAlarm;
                         end if;

                         when sChar3 =>
                         door<= '0';
                         alarm <= '0';
                         if code= "0000" then
                             next_state <= sChar4;
                        elsif code= "1101" then
		                 next_state <= sDoor;	
                         else
                             next_state <= sAlarm;
                            end if; 

                            when sChar4 =>
                            door<= '0';
                            alarm <= '0';
                            if code= "0101" then
                                next_state <= sDoor;
                            elsif code= "1101" then
		                       next_state <= sDoor;	
                            else
                                next_state <= sAlarm;
                               end if;  
                               
                              when sDoor =>
                              door<= '1';
                              alarm <= '0';
 			      if reset ='1' then
                              next_state <= sBegin; 
                              end if;
                              when sAlarm =>
                              door<= '0';
                              alarm <= '1';
			      if reset ='1' then
                              next_state <= sBegin; 
				end if;
   
         end case; 
       
end if;    

         end process;
                   

    end architecture;