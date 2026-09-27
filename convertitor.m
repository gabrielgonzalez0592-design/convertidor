
L = 2e-3;       % 2 mH
R = 10;         % 10 Ohms
C = 10e-6;      % 10 uF
Uin = 32;       % 32 V
f = 100e3;      % Frecuencia 100 kHz
D = 0.4;        % Ciclo de trabajo 40%
T = 1/f;        % Periodo del PWM


pwm = @(t) double(mod(t, T) < D*T);

odefun = @(t, x) [
    -(1/L)*x(2) + (Uin/L)*pwm(t);
    (1/C)*x(1) - (1/(R*C))*x(2)
    ];


x0 = [0; 0];
tspan = [0 0.005]; 


options = odeset('MaxStep', 1e-6);


[t, x] = ode45(odefun, tspan, x0, options);


figure;
subplot(2,1,1);
plot(t, x(:,1), 'LineWidth', 1.2);
title('Corriente en el Inductor (i_L)');
ylabel('Amperes'); xlabel('Tiempo (s)'); grid on;

subplot(2,1,2);
plot(t, x(:,2), 'LineWidth', 1.2, 'Color', 'r');
title('Voltaje en el Capacitor (V_c)');
ylabel('Volts'); xlabel('Tiempo (s)'); grid on;