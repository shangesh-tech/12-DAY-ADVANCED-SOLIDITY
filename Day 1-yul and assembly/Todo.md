# ✅ **20 Progressive Yul + Solidity Questions (increasing difficulty)**

---

## **🔰 LEVEL 1 — Basic Arithmetic & Memory (Beginner)**

### **Q1.**

Write a function that **adds two numbers** in Solidity and Yul.

### **Q2.**

Write a function that **multiplies two numbers** using:

* Solidity
* Yul (`mul(a,b)`)

### **Q3.**

Write a function that **stores a number into memory** at slot `0x00` and returns it.

### **Q4.**

Write Yul code that **stores two numbers** at:

* memory[0x00]
* memory[0x20]
  and returns both in ABI format.

---

## **📦 LEVEL 2 — Free Memory Pointer, Calldata, Return Values**

### **Q5.**

Write Yul code that:

* loads the **free memory pointer** using `mload(0x40)`
* stores a value there
* updates the pointer
* returns the value

### **Q6.**

Write Yul code that:

* reads two function arguments from calldata
* adds them
* returns the result
  (no Solidity fallback allowed)

### **Q7.**

Write a Yul function to **manually encode (uint256 a, uint256 b)** in memory and return packed 64 bytes.

---

## **🔐 LEVEL 3 — Storage Read/Write + Control Flow**

### **Q8.**

Write Solidity + Yul versions of:

* `setValue(uint256 x)`
* `getValue()`

Store/read from **storage slot 0** manually using `sstore(0, x)` & `sload(0)`.

### **Q9.**

Write a Yul loop:

* sum numbers from **1 to n**
* return the total

### **Q10.**

Write a Yul version of:

```solidity
if (x > 100) return x; else return 0;
```

---

## **🧬 LEVEL 4 — Struct Packing, Bitwise, ABI Encoding**

### **Q11.**

Given values:

* age (uint8)
* score (uint16)
* level (uint8)

Pack them into **one uint32** using Yul.

### **Q12.**

Unpack the uint32 into original values using bitwise operations.

### **Q13.**

Write Yul that ABI-encodes:

```
(uint256 x, address user, bool flag)
```

in correct order.

---

## **🛰 LEVEL 5 — Arrays, Dynamic Data & Calldata Decoding**

### **Q14.**

Write Solidity + Yul code to:

* accept `uint256[] calldata arr`
* sum all elements
* return sum

(Yul must manually decode the dynamic array.)

### **Q15.**

Write Yul code that:

* reads a `string calldata`
* returns its length only
  (no Solidity parsing allowed)

---

## **🔗 LEVEL 6 — Low-Level Calls & Error Handling**

### **Q16.**

Write Yul code that performs a **low-level call**:

* call another contract’s `getNumber()`
* handle success & revert on failure
  (use `call(gas(), target, ...)`)

### **Q17.**

Write a Yul function that:

* uses `staticcall`
* loads returned data
* returns it ABI encoded

---

## **🛠 LEVEL 7 — CREATE, CREATE2, Minimal Proxy**

### **Q18.**

Write Yul code that deploys a contract using:

* `create(0, bytecode, size)`

Return the deployed address.

### **Q19.**

Write Yul code that:

* deploys using CREATE2
* returns predicted address
* verifies deployed address matches prediction

---

## **🏗 LEVEL 8 — Mini Full Yul Contract (Final Boss)**

### **Q20.**

Write a complete **simple ERC20** with Yul functions:

* balanceOf
* transfer
* mint
* totalSupply

All logic must be fully Yul.
(Balance mapping stored at keccak256(slot, key).)
