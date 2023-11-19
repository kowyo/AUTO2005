## 运行结果

![task1](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task1.png?imageSlim)

<center>连续周期方波信号的分解与合成</center>

![task2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task2.png?imageSlim)

<center>离散方波信号 采样频率1</center>

![task2_2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task2_2.png?imageSlim)

<center>离散方波信号 采样频率2</center>

![task3](/Users/mitcher/Library/CloudStorage/OneDrive-Personal/Documents/Course-2023-Fall/信号分析与处理/labs/lab1/task3.png)

<center>锯齿波信号</center>

## 思考题

1. 简述连续周期信号频谱的特点

   > 连续周期信号的频谱是离散的

2. 简述离散周期信号频谱的特点

   > 离散从时域看，是对连续信号进行抽样得到的。从频域看，是对连续信号的频谱进行周期性搬移。所以，离散信号的频谱都是周期的。并且周期等于抽样频率。

3. 以周期矩形脉冲信号为例，分析:当信号的周期 *T* 和脉冲宽度*τ*发生变化的时候，信号的频谱将如何变化? 离散时间矩形周期信号当采样间隔发生变化时，信号的频谱会如何变化?

   > a. 周期T的变化：
   >
   > 如果周期 *T* 发生变化，频谱中的基本频率会随之改变。频率为基本频率的谐波成分的间隔将按照频率的倒数（频率=1/T）的整数倍发生变化。较大的周期将导致较低的基本频率和更宽的谱线。
   >
   > b. 脉冲宽度 *τ* 的变化：
   >
   > 脉冲宽度 *τ* 的变化将影响频谱的宽度。较小的脉冲宽度将导致更宽的频谱，因为更宽的频带包含更多的高频分量。较大的脉冲宽度则导致较窄的频谱。
   >
   > 
   >
   > 对于离散时间矩形周期信号，采样间隔的变化将影响信号的抽样过程。采样定理表明，采样频率应该至少是信号最高频率的两倍。如果采样间隔增大，可能发生混叠，即高于采样频率一半的频率成分将被错误地还原为低于采样频率一半的频率。这将导致频谱中出现混叠的成分，使得信号失真。
   
   
