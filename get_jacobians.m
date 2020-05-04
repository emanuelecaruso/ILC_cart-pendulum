function [A,B] = get_jacobians(x)

x_3=x(3);
x_4=x(4);

global g l_p b c m_p 

a_23=(g*sin(x_3)^2 - g*cos(x_3)^2 + l_p*x_4^2*cos(x_3))/(sin(x_3)^2 + b) + (2*cos(x_3)*sin(x_3)*(- l_p*sin(x_3)*x_4^2 + g*cos(x_3)*sin(x_3)))/(sin(x_3)^2 + b)^2;
a_24=(2*l_p*x_4*sin(x_3))/(sin(x_3)^2 + b);
a_43=(x_4^2*sin(x_3)^2)/(sin(x_3)^2 + b) + (cos(x_3)*(- l_p*cos(x_3)*x_4^2 + c))/(l_p*(sin(x_3)^2 + b)) - (2*cos(x_3)*sin(x_3)^2*(- l_p*cos(x_3)*x_4^2 + c))/(l_p*(sin(x_3)^2 + b)^2);
a_44=-(2*x_4*cos(x_3)*sin(x_3))/(sin(x_3)^2 + b);



A= [  0  ,  1 ,  0  ,  0  ;
      0  , 0 , a_23 , a_24 ;
      0  ,  0  ,  0  , 1  ; 
      0  , 0 , a_43 , a_44 ];

B= [0; 1/m_p; 0; (-cos(x_3))/m_p];






end

