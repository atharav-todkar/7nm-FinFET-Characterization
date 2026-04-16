# 7nm FinFET Device and Circuit Characterization

![PDK](https://img.shields.io/badge/PDK-ASAP7%207nm-blue?style=for-the-badge)
![Tool](https://img.shields.io/badge/Tool-Ngspice%2045+-green?style=for-the-badge)
![Tool](https://img.shields.io/badge/Tool-Xschem%203.4.8-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Workshop](https://img.shields.io/badge/Workshop-VSD%20FinFET%202026-purple?style=for-the-badge)

> **Full characterization of 7nm FinFET devices and analog circuits using the ASAP7 Predictive PDK with open-source EDA tools — Xschem and Ngspice — covering device physics, digital cell analysis, and analog bandgap reference design.**

---

## Table of Contents

- [Project Overview](#project-overview)
- [Technology and Tools](#technology-and-tools)
- [Repository Structure](#repository-structure)
- [Part 1 — NFET Device Characterization](#part-1--nfet-device-characterization)
- [Part 2 — FinFET CMOS Inverter Characterization](#part-2--finfet-cmos-inverter-characterization)
- [Part 3 — 7nm Bandgap Reference Circuit](#part-3--7nm-bandgap-reference-circuit)
- [Key Results Summary](#key-results-summary)
- [Skills Demonstrated](#skills-demonstrated)
- [How to Reproduce](#how-to-reproduce)
- [Acknowledgements](#acknowledgements)

---

## Project Overview

This project presents a complete bottom-up characterization flow for 7nm FinFET technology — from individual transistor device physics to full analog circuit simulation. All work was performed using the **ASAP7 Predictive PDK** (Arizona State University) with industry-standard BSIM-CMG FinFET models, running entirely on open-source EDA tools in a cloud Linux environment.

The project covers three progressively complex design problems:

1. **NFET DC Characterization** — extracting fundamental device parameters (Id-Vgs, Id-Vds, gm, ro)
2. **CMOS Inverter Analysis** — full VTC extraction, noise margins, propagation delay, and power
3. **Bandgap Reference Design** — CTAT/PTAT compensation and temperature-stable Vref generation

**Workshop:** VSD FinFET Circuit Design and Characterization, March 2026
**Technology Node:** ASAP7 7nm Predictive PDK — BSIM-CMG FinFET Models
**Environment:** GitHub Codespaces — Ubuntu 22.04 Cloud Linux

---

## Technology and Tools

| Tool / Technology | Version | Purpose |
|---|---|---|
| Ngspice | 45+ | SPICE circuit simulation engine |
| Xschem | 3.4.8 | Schematic capture and netlist generation |
| ASAP7 PDK | — | 7nm predictive FinFET device models (BSIM-CMG) |
| GitHub Codespaces | Ubuntu 22.04 | Cloud Linux simulation environment |

**PDK Reference:** ASAP7 — Arizona State Predictive 7nm Technology
**Device Models:** BSIM-CMG — UC Berkeley Device Group

---

## Repository Structure

```
7NM-FINFET/
│
├── bandgap/
│   ├── netlist/
│   │   ├── bandgap.sch
│   │   └── bandgap.spice
│   └── plots/
│       ├── bandgap_circuit_diagram.png
│       ├── bandgap_schematic.png
│       ├── bandgap_vref_vs_temp.png
│       ├── bandgap_vctat_vs_temp.png
│       ├── bandgap_vptat_vs_temp.png
│       └── bandgap_iptat_vs_temp.png
│
├── device/
│   ├── netlist/
│   │   ├── nfet_char.sch
│   │   └── nfet_char.spice
│   └── plots/
│       ├── gm_plot.png
│       ├── r_out_plot.png
│       ├── nfet_id_curve.png
│       ├── nfet_id_vds.png
│       └── nfet_schematic.png
│
├── inverter/
│   ├── netlist/
│   │   ├── inverter_finfet.sch
│   │   ├── inverter_finfet.spice
│   │   ├── inverter_vtc.sch
│   │   ├── inverter_vtc.spice
│   │   └── inverter_vtc2.spice
│   └── plots/
│       ├── inverter_schematic.png
│       ├── inverter_vtc.png
│       ├── inverter_vtc_parameters.png
│       ├── inverter_delay_power.png
│       └── inverter_parameters.png
│
├── variation/
├── results/
├── scripts/
├── DIFFERENCES_FROM_VSD.md
├── RESULTS_SUMMARY.md
└── README.md
```

---

## Part 1 — NFET Device Characterization

### Objective

Characterize the fundamental DC behavior of a 7nm NFET FinFET device using ASAP7 BSIM-CMG models. Extract drain current characteristics, transconductance, and output resistance to validate device operating points and understand FinFET scaling behavior.

**Device Under Test:** `asap_7nm_nfet` | L = 7nm | nfin = 14

### Testbench Schematic

![NFET Testbench Schematic](device/plots/nfet_schematic.png)

### Id vs Vds — Family of Curves

Drain current swept across Vds with Vgs stepped as a parameter to capture linear and saturation regions.

![Id vs Vds](device/plots/nfet_id_vds.png)

### Id vs Vgs — Transfer Characteristic

![Id vs Vgs](device/plots/nfet_id_curve.png)

### Transconductance (gm)

Transconductance extracted as `gm = dId/dVgs` at constant Vds. Peak gm indicates the bias point of maximum current efficiency.

![Transconductance gm](device/plots/gm_plot.png)

### Output Resistance (ro)

Output resistance extracted as `ro = dVds/dId` at constant Vgs. High ro indicates good channel length modulation suppression at 7nm.

![Output Resistance ro](device/plots/r_out_plot.png)

### Fin Count Scaling Study

One of the key degrees of freedom in FinFET design is the number of fins (nfin), which directly controls effective transistor width without changing gate length.

| nfin | Drive Current | Transconductance gm | Threshold Voltage Vth |
|---|---|---|---|
| 14 | Baseline | Baseline | ~0.344 V |
| 16 | Slight increase | Slight increase | ~0.344 V |
| 28 | Higher | Higher | ~0.344 V |

**Key observation:** Increasing nfin scales drive current and gm proportionally while Vth remains constant — consistent with expected FinFET multi-fin behavior. Since NMOS and PMOS scale symmetrically, the inverter switching threshold remains unaffected by fin count changes.

---

## Part 2 — FinFET CMOS Inverter Characterization

### Objective

Design and fully characterize a minimum-geometry 7nm FinFET CMOS inverter. Extract the complete Voltage Transfer Characteristic (VTC), noise margins, propagation delay, and power consumption to establish a baseline for 7nm digital cell performance.

### Inverter Schematic

![Inverter Schematic](inverter/plots/inverter_schematic.png)

### Voltage Transfer Characteristic (VTC)

The VTC was extracted using a DC sweep of the input voltage from 0 V to VDD. The curve captures the full logic transition, gain region, and logic-level boundaries.

![VTC](inverter/plots/inverter_vtc.png)

### VTC with Extracted Parameters

![VTC with Parameters](inverter/plots/inverter_vtc_parameters.png)

### Extracted DC Parameters

| Parameter | Symbol | Value |
|---|---|---|
| Switching Threshold | Vth | 0.344 V |
| Maximum Voltage Gain | Av | 6.428 |
| Input Low Voltage | VIL | 0.348 V |
| Input High Voltage | VIH | 0.351 V |
| Output High Voltage | VOH | 0.319 V |
| Output Low Voltage | VOL | 0.304 V |
| Noise Margin High | NMH | −0.032 V |
| Noise Margin Low | NML | 0.044 V |
| Peak Transconductance | gm_max | 1.235 × 10⁻³ S |

> **Note on Noise Margins:** The slightly negative NMH value reflects the compressed supply headroom at 7nm operating voltage. This is characteristic of minimum-geometry 7nm FinFET cells and is accounted for in library timing margin analysis at the PDK level.

### Propagation Delay and Power

Transient simulation was run with a square wave input to extract rise and fall propagation delays and average power consumption.

![Delay and Power](inverter/plots/inverter_delay_power.png)

| Parameter | Value |
|---|---|
| Rise Propagation Delay (tpr) | 25.0 ps |
| Fall Propagation Delay (tpf) | 25.6 ps |
| Average Propagation Delay (tp) | 25.3 ps |
| Average Power | 2.97 × 10⁻⁵ W |

### Terminal Output — Parameter Extraction

![Parameter Terminal Output](inverter/plots/inverter_parameters.png)

---

## Part 3 — 7nm Bandgap Reference Circuit

### Objective

Simulate a **Self-Cascode MOS Bandgap Reference** implemented in 7nm FinFET technology. Demonstrate CTAT/PTAT compensation principles and characterize the stability of the output reference voltage across a wide industrial temperature range.

**Supply Voltage:** VDD = 1.75 V
**Temperature Range:** −45 °C to +125 °C

### Circuit Topology

The bandgap reference uses the self-cascode MOS configuration to generate:
- A **CTAT** (Complementary to Absolute Temperature) voltage that decreases with temperature
- A **PTAT** (Proportional to Absolute Temperature) voltage that increases with temperature
- A **Vref** output that sums CTAT and PTAT contributions for near-zero temperature coefficient

![Bandgap Circuit Diagram](bandgap/plots/bandgap_circuit_diagram.png)

### Schematic in Xschem

![Bandgap Schematic](bandgap/plots/bandgap_schematic.png)

### Operating Principle

| Signal | Behavior | Role |
|---|---|---|
| Vctat | Decreases with temperature | CTAT component |
| Vptat | Increases with temperature | PTAT component |
| Vref | Near-constant with temperature | Stable voltage reference output |

### Simulation Results

**Vref vs Temperature** — Near-flat reference voltage across the full temperature range, confirming effective CTAT/PTAT cancellation.

![Vref vs Temperature](bandgap/plots/bandgap_vref_vs_temp.png)

**Vctat vs Temperature** — Monotonically decreasing behavior as expected from gate-referred threshold voltage thermal dependence.

![Vctat vs Temperature](bandgap/plots/bandgap_vctat_vs_temp.png)

**PTAT Voltage vs Temperature** — Linear increase with temperature, generated by differential current mirroring within the self-cascode topology.

![PTAT Voltage vs Temperature](bandgap/plots/bandgap_vptat_vs_temp.png)

**PTAT Current vs Temperature** — Temperature-proportional current confirming the PTAT generator is operating correctly.

![PTAT Current vs Temperature](bandgap/plots/bandgap_iptat_vs_temp.png)

---

## Key Results Summary

| Parameter | Value |
|---|---|
| NFET Threshold Voltage | ~0.35 V |
| Inverter Switching Threshold | 0.344 V |
| Maximum Inverter Gain | 6.428 |
| Rise Propagation Delay | 25.0 ps |
| Fall Propagation Delay | 25.6 ps |
| Power Consumption | 2.97 × 10⁻⁵ W |
| Bandgap Reference Vref | ~1.6 V |
| Temperature Range Tested | −45 °C to +125 °C |
| Supply Voltage | 1.75 V |

---

## Skills Demonstrated

**Device Physics and Modeling**
- 7nm FinFET device physics and BSIM-CMG model interpretation
- DC characterization — Id-Vgs, Id-Vds, gm, ro extraction
- FinFET fin-count scaling behavior and multi-fin device analysis

**Digital Circuit Analysis**
- CMOS inverter VTC extraction and interpretation
- Noise margin analysis (NMH, NML, VIL, VIH, VOH, VOL)
- Propagation delay (tpr, tpf) and average power measurement

**Analog Circuit Design**
- Bandgap reference circuit — CTAT and PTAT compensation principle
- Self-cascode MOS topology for low-supply bandgap generation
- Temperature sweep simulation across industrial range (−45 °C to +125 °C)

**EDA Toolchain**
- Xschem schematic capture and hierarchical design entry
- Ngspice SPICE netlist simulation — DC, transient, temperature sweep
- ASAP7 PDK integration and BSIM-CMG model setup
- Linux command line, Git version control, GitHub workflow

---

## How to Reproduce

### Prerequisites

```bash
# Install Ngspice
sudo apt-get install ngspice

# Install Xschem
sudo apt-get install xschem

# Clone the ASAP7 PDK
git clone https://github.com/The-OpenROAD-Project/asap7
```

### Running Simulations

```bash
# Clone this repository
git clone <repo-url>
cd 7NM-FINFET

# NFET characterization
cd device/netlist
ngspice nfet_char.spice

# Inverter VTC
cd ../../inverter/netlist
ngspice inverter_vtc.spice

# Bandgap Reference
cd ../../bandgap/netlist
ngspice bandgap.spice
```

### Opening Schematics in Xschem

```bash
xschem device/netlist/nfet_char.sch
xschem inverter/netlist/inverter_vtc.sch
xschem bandgap/netlist/bandgap.sch
```

---

## Differences from VSD Base Repository

See [`DIFFERENCES_FROM_VSD.md`](DIFFERENCES_FROM_VSD.md) for a detailed log of modifications made relative to the base VSD workshop repository, including netlist changes, simulation setup adjustments, and additional characterization scripts.

---

## Acknowledgements

**Workshop:** VSD FinFET Circuit Design and Characterization — March 2026
**Instructor:** Kunal Ghosh, VLSI System Design (VSD) Corp. Pvt. Ltd.
**Base Repository:** [https://github.com/vsdip/vsd-7nm](https://github.com/vsdip/vsd-7nm)
**ASAP7 PDK:** Arizona State Predictive 7nm Technology
**BSIM-CMG Models:** UC Berkeley Device Group

> All simulation results, plots, analysis, and documentation presented in this repository represent my own independent work, building upon the base workshop netlists and schematics.

---

*7nm FinFET Device and Circuit Characterization — VSD Workshop, March 2026*