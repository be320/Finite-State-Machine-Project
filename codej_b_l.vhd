LIBRARY sxlib_ModelSim;
entity codej_b_l is
   port (
      clk     : in      bit;
      vdd     : in      bit;
      vss     : in      bit;
      daytime : in      bit;
      reset   : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit
 );
end codej_b_l;

architecture structural of codej_b_l is
Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa2ao222_x2
   port (
      i1  : in      bit;
      i0  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      i4  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component on12_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x4
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o3_x2
   port (
      i0  : in      bit;
      i2  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff1_x4
   port (
      ck  : in      bit;
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal fsm_current_state     : bit_vector( 2 downto 0);
signal not_code              : bit_vector( 3 downto 0);
signal not_fsm_current_state : bit_vector( 1 downto 0);
signal oa22_x2_sig           : bit;
signal oa22_x2_2_sig         : bit;
signal o4_x2_sig             : bit;
signal o3_x2_sig             : bit;
signal o2_x2_sig             : bit;
signal not_reset             : bit;
signal not_aux6              : bit;
signal not_aux14             : bit;
signal not_aux13             : bit;
signal not_aux12             : bit;
signal not_aux1              : bit;
signal not_aux0              : bit;
signal no4_x1_sig            : bit;
signal no4_x1_2_sig          : bit;
signal no3_x1_sig            : bit;
signal no3_x1_2_sig          : bit;
signal na4_x1_sig            : bit;
signal na4_x1_2_sig          : bit;
signal na3_x1_sig            : bit;
signal na3_x1_5_sig          : bit;
signal na3_x1_4_sig          : bit;
signal na3_x1_3_sig          : bit;
signal na3_x1_2_sig          : bit;
signal na2_x1_sig            : bit;
signal na2_x1_4_sig          : bit;
signal na2_x1_3_sig          : bit;
signal na2_x1_2_sig          : bit;
signal inv_x2_sig            : bit;
signal inv_x2_3_sig          : bit;
signal inv_x2_2_sig          : bit;
signal aux2                  : bit;

begin

not_aux13_ins : a2_x2
   port map (
      i0  => not_reset,
      i1  => not_fsm_current_state(1),
      q   => not_aux13,
      vdd => vdd,
      vss => vss
   );

inv_x2_ins : inv_x2
   port map (
      i   => daytime,
      nq  => inv_x2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => fsm_current_state(1),
      i1  => inv_x2_sig,
      i2  => fsm_current_state(2),
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

not_aux12_ins : oa2ao222_x2
   port map (
      i1  => na3_x1_sig,
      i0  => not_aux0,
      i2  => fsm_current_state(1),
      i3  => daytime,
      i4  => not_reset,
      q   => not_aux12,
      vdd => vdd,
      vss => vss
   );

not_aux14_ins : on12_x1
   port map (
      i0  => code(1),
      i1  => code(3),
      q   => not_aux14,
      vdd => vdd,
      vss => vss
   );

not_aux1_ins : o2_x2
   port map (
      i0  => code(0),
      i1  => not_fsm_current_state(1),
      q   => not_aux1,
      vdd => vdd,
      vss => vss
   );

inv_x2_2_ins : inv_x2
   port map (
      i   => fsm_current_state(2),
      nq  => inv_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => code(1),
      i1  => code(3),
      i2  => aux2,
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

not_aux6_ins : o3_x2
   port map (
      i0  => na3_x1_2_sig,
      i1  => not_fsm_current_state(0),
      i2  => inv_x2_2_sig,
      q   => not_aux6,
      vdd => vdd,
      vss => vss
   );

not_fsm_current_state_0_ins : inv_x2
   port map (
      i   => fsm_current_state(0),
      nq  => not_fsm_current_state(0),
      vdd => vdd,
      vss => vss
   );

not_aux0_ins : o2_x2
   port map (
      i0  => fsm_current_state(1),
      i1  => fsm_current_state(2),
      q   => not_aux0,
      vdd => vdd,
      vss => vss
   );

not_fsm_current_state_1_ins : inv_x4
   port map (
      i   => fsm_current_state(1),
      nq  => not_fsm_current_state(1),
      vdd => vdd,
      vss => vss
   );

not_reset_ins : inv_x2
   port map (
      i   => reset,
      nq  => not_reset,
      vdd => vdd,
      vss => vss
   );

not_code_3_ins : inv_x2
   port map (
      i   => code(3),
      nq  => not_code(3),
      vdd => vdd,
      vss => vss
   );

not_code_2_ins : inv_x2
   port map (
      i   => code(2),
      nq  => not_code(2),
      vdd => vdd,
      vss => vss
   );

not_code_0_ins : inv_x2
   port map (
      i   => code(0),
      nq  => not_code(0),
      vdd => vdd,
      vss => vss
   );

aux2_ins : no2_x1
   port map (
      i0  => code(0),
      i1  => code(2),
      nq  => aux2,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => not_code(3),
      i1  => not_code(0),
      i2  => code(1),
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => daytime,
      i1  => code(2),
      i2  => not_aux0,
      i3  => no3_x1_sig,
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => not_aux6,
      i1  => na4_x1_sig,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => not_aux14,
      i1  => not_code(2),
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

o3_x2_ins : o3_x2
   port map (
      i0  => o2_x2_sig,
      i2  => not_aux1,
      i1  => fsm_current_state(2),
      q   => o3_x2_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => code(3),
      i1  => code(1),
      i2  => not_code(2),
      i3  => not_code(0),
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_3_ins : na3_x1
   port map (
      i0  => no4_x1_sig,
      i1  => fsm_current_state(2),
      i2  => not_fsm_current_state(1),
      nq  => na3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => na3_x1_3_sig,
      i1  => o3_x2_sig,
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => na2_x1_2_sig,
      i1  => not_fsm_current_state(0),
      i2  => na2_x1_sig,
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

fsm_current_state_0_ins : sff1_x4
   port map (
      ck  => clk,
      i   => oa22_x2_sig,
      q   => fsm_current_state(0),
      vdd => vdd,
      vss => vss
   );

na2_x1_3_ins : na2_x1
   port map (
      i0  => not_aux6,
      i1  => not_aux12,
      nq  => na2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => not_aux14,
      i1  => not_aux1,
      i2  => code(2),
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_2_ins : oa22_x2
   port map (
      i0  => fsm_current_state(2),
      i1  => no3_x1_2_sig,
      i2  => na2_x1_3_sig,
      q   => oa22_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

fsm_current_state_1_ins : sff1_x4
   port map (
      ck  => clk,
      i   => oa22_x2_2_sig,
      q   => fsm_current_state(1),
      vdd => vdd,
      vss => vss
   );

na2_x1_4_ins : na2_x1
   port map (
      i0  => fsm_current_state(2),
      i1  => not_fsm_current_state(1),
      nq  => na2_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

inv_x2_3_ins : inv_x2
   port map (
      i   => aux2,
      nq  => inv_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_2_ins : no4_x1
   port map (
      i0  => inv_x2_3_sig,
      i1  => code(1),
      i2  => not_aux13,
      i3  => code(3),
      nq  => no4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_5_ins : na3_x1
   port map (
      i0  => no4_x1_2_sig,
      i1  => fsm_current_state(0),
      i2  => na2_x1_4_sig,
      nq  => na3_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_2_ins : na4_x1
   port map (
      i0  => not_code(3),
      i1  => code(1),
      i2  => code(2),
      i3  => not_code(0),
      nq  => na4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

o4_x2_ins : o4_x2
   port map (
      i0  => not_aux13,
      i1  => na4_x1_2_sig,
      i2  => fsm_current_state(0),
      i3  => fsm_current_state(2),
      q   => o4_x2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_4_ins : na3_x1
   port map (
      i0  => not_aux12,
      i1  => o4_x2_sig,
      i2  => na3_x1_5_sig,
      nq  => na3_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

fsm_current_state_2_ins : sff1_x4
   port map (
      ck  => clk,
      i   => na3_x1_4_sig,
      q   => fsm_current_state(2),
      vdd => vdd,
      vss => vss
   );

alarm_ins : no2_x1
   port map (
      i0  => not_aux0,
      i1  => fsm_current_state(0),
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );

door_ins : no2_x1
   port map (
      i0  => not_aux0,
      i1  => not_fsm_current_state(0),
      nq  => door,
      vdd => vdd,
      vss => vss
   );


end structural;

architecture moore of codej_b_l is
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
                   

    end moore;
