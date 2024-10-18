```
sudo sed -i 's/-encoding utf-8/ /g' /usr/lib/tk8.6/tk.tcl
sudo sed -i 's/-encoding utf-8/ /g' /usr/lib/tk8.6/ttk/ttk.tcl
```
https://gist.githubusercontent.com/cseas/3639de92b03cc27ca3c480b3a0d3af90/raw/516a5639faacc3b8cb891f1e704107dae65c6316/simple.tcl




To estimate the time it will take for data transfer in the simulation, you need to consider both the TCP (FTP) and UDP (CBR) traffic. Here's how you can break it down:

### 1. **TCP (FTP) Transfer**
- **Data Size**: From the previous calculation, we estimated approximately **637,500 bytes**.
- **Assumed Throughput**: Let's say we use an effective TCP throughput of **1.7 Mbps**.

**Calculate Transfer Time:**
\[
\text{Time} = \frac{\text{Data Size}}{\text{Throughput}}
\]
\[
\text{Time} = \frac{637,500 \text{ bytes} \times 8}{1.7 \times 10^6 \text{ bits/sec}} \approx 2.99 \text{ seconds}
\]

### 2. **UDP (CBR) Transfer**
- **Data Size**: From the previous calculation, we estimated approximately **550,000 bytes**.
- **Rate**: **1 Mbps** (1 × 10^6 bits/sec).

**Calculate Transfer Time:**
\[
\text{Time} = \frac{\text{Data Size}}{\text{Rate}}
\]
\[
\text{Time} = \frac{550,000 \text{ bytes} \times 8}{1 \times 10^6 \text{ bits/sec}} \approx 4.4 \text{ seconds}
\]

### **Total Transfer Time**
Since both TCP and UDP are running simultaneously, the overall time taken will be determined by the longer transfer time.

- **TCP Transfer Time**: ~2.99 seconds
- **UDP Transfer Time**: ~4.4 seconds

### Conclusion
The overall time it will take for the data transfer to complete is approximately **4.4 seconds**, as the UDP transfer duration is the limiting factor in this scenario.
