Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316990;
	b=0oqI80IJQkkcWNiwHDcgCY2MI+QuzJaPP2jEJZi3U/Fen8VblHeuUJZqmKet5Tbva3+Z
	 3jfg29bEafw5ZQXmHf1JM8e4rxeSUyr/KhdhmW/zq1WR3wTGy5ReLJhz240tuqMEZlE/6
	 SXd9sqLePy90Ad33+eoME37yRVbU0K3pS6sWDo6x48Z6Xf04RHctXe5+8q8l5QZjtuB8M
	 wbxmpODPIHfrJutLacmCDjfHteNzxb0PQtYWP1P0ofKQfQpwFdx0I6gXi6jNQi8eCeDVD
	 Y057juBMAvlYgvOZG3st0Bft4VVl/KgLfj2XYLR73TenCbvF0zypb9RNWoJoJ/AvIsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316990;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lJXYqaKatt00/W9XQdJefYtCIBSZeqpG+bH7pn/jzc8=;
	b=JRvxNtblIJKfRE1IHOqOA3irbgOiHGoSWz4ieeTJ6nfxlicdagLRRHkIzYL63CIQvfh6
	 N7/gVJT+lgF+EsMhERPs7PLs74N6rlWwRfK1L+CM4S3Ajzk+uIX1UWaSe8Okfk4/AKXwM
	 akJTQnpBjdc305nOWCjrAmt+NIrsrYgpn87w41Scthv92TkWkPh7/Zhjz75DliU2eXp34
	 ENoKOTXQMvVVgA6DwK2Aa3IMCCg2sURsuLagHZYeNRkx8U7jsShTVFeMHfSzFsGjAtMCA
	 CtZubDkWH5Y8yIme6R8UGJnN+OndkgyfcJQw3BGN/56UrdixWo6kuA6MrR4IMU3SxhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5056071E45;
	Tue, 10 Nov 2026 13:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C5056071E45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794316988; x=1825852988;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LzlVl625yDZ4KTdVb3j9o7R28lsiqGG9g7XtN8d/VNo=;
  b=ZcPMK0UH5x0ls58wDcBiqk+/+f07crmVXuFkRJGveXXAVjYPC/p3YmRm
   4v/YHBhgr5WPNBvAYfPqVAjihag8P2d7OtoyEFXBUGnzphuF7oBzjeABI
   J8UjUVSZ/P2UNJelzMZkYytemwjFCxDu7lWrlFjmpCr+0Vb2fYpzKCJ1W
   wecz5pHcVgsZFHhFntrZSGt0IHE0BZLvwZSRf/5tSi8zJmjd9YTG5jrBw
   Nro+xAaN/DbbW7IOz0blh44lILPHf0FSOQ1EDqPFUBhjSl+orevlHFr5b
   VJKiT0D1RQXmkAyfTtd2I73tAKu1fZyhJEb37QVecS5azWWUYhz74+tss
   Q==;
X-CSE-ConnectionGUID: REa7wYvdRtuMLxsABJvMYA==
X-CSE-MsgGUID: JUuian0OQwmqvZrHZAP/9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:22:59 +0200
X-CSE-ConnectionGUID: OzexV7RbQdKSEsivlOUlUQ==
X-CSE-MsgGUID: k/r52ngBQkSqNOOf0j+0gw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 10 Nov 2026 15:31:01 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:57 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 10 Nov 2026 15:21:03 +0200
Subject: [PATCH v6 6/6] riscv: hwprobe: report whether AMO is faster than
 LR/SC
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-lrsc-only-v6-6-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
In-Reply-To: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>, 
 Conor Dooley <conor.dooley@microchip.com>, torvalds@linux-foundation.org, 
 olof@lixom.net, aleksa.paunovic@htecgroup.com, arikalo@gmail.com, 
 Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir.Kondratiev@mobileye.com, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

On a CPU that traps AMO instructions into firmware and emulates them
there, such as MIPS P8700, an uncontended AMO costs about 600 cycles
where the equivalent LR/SC sequence costs about 40. Userspace built for
the A extension uses AMO for every atomic and pays that on every one.
It cannot tell from the ISA string: such a CPU still has Zaamo, and
correctly so.

Give userspace the same kind of hint the kernel gives for misaligned
access. At boot, time AMO_SPEED_ITERS amoadd.w against the same number
of lr.w/addi/sc.w loops on each CPU, take the best sample from an 8 ms
window of each, and report the result through a new hwprobe key,
RISCV_HWPROBE_KEY_AMO_PERF:

  RISCV_HWPROBE_AMO_FAST         AMO is at least as fast as LR/SC
  RISCV_HWPROBE_AMO_SLOW         LR/SC is faster; use it where possible
  RISCV_HWPROBE_AMO_UNSUPPORTED  the CPU has no Zaamo
  RISCV_HWPROBE_AMO_UNKNOWN      not measured, or differs across CPUs

Only the direction of the difference is reported, not its size: the
question a program can act on is which sequence to pick. Each CPU logs
its ratio, and a kernel whose own atomics are AMO warns once when the
CPU turns out to be slow, pointing at RISCV_ISA_ZAAMO.

The amoadd.w is spelled with .insn through a new AMOADD_W() in
insn-def.h, so the file assembles when -march has no Zaamo, and the
probe is skipped on a CPU whose ISA lacks the extension. CPUs that come
online later are measured by a hotplug callback. amo_speed={slow|fast}
on the command line skips the measurement, as unaligned_scalar_speed=
does. The probe runs at the same initcall level as the misaligned
access probe, for the same reasons.

Tested on the eyeq7h hardware, with the DT advertising "a":

  [    0.163714] cpu10: AMO speed is 0.07x LR/SC speed (slow)
  [    0.163727] cpu11: AMO speed is 0.07x LR/SC speed (slow)
  [    0.163724] cpu6: AMO speed is 0.07x LR/SC speed (slow)

and, with CONFIG_RISCV_ISA_ZAAMO set:

  [    0.163729] AMO is slow but kernel atomics use it, consider disabling RISCV_ISA_ZAAMO

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   7 +
 Documentation/arch/riscv/hwprobe.rst            |  18 +++
 arch/riscv/Kconfig                              |  13 ++
 arch/riscv/include/asm/cpufeature.h             |   4 +
 arch/riscv/include/asm/hwprobe.h                |   2 +-
 arch/riscv/include/asm/insn-def.h               |   5 +
 arch/riscv/include/uapi/asm/hwprobe.h           |   5 +
 arch/riscv/kernel/Makefile                      |   1 +
 arch/riscv/kernel/amo_speed.c                   | 183 ++++++++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c                 |  37 +++++
 10 files changed, 274 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..9bc5baff20ff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -513,6 +513,13 @@ Kernel parameters
 			Format: <a>,<b>
 			See also Documentation/input/joydev/joystick.rst
 
+	amo_speed=	[RISCV]
+			Format: {slow | fast}
+			Allow skipping the AMO instruction speed test. This is
+			useful for testing alternative code paths and to skip
+			the test in environments where it runs too slowly. All
+			CPUs must have the same AMO speed.
+
 	analog.map=	[HW,JOY] Analog joystick and gamepad support
 			Specifies type or capabilities of an analog joystick
 			connected to one of 16 gameports
diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bb1e0cbab36f..51ecb836f491 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -423,3 +423,21 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZA64RS`: The Za64rs extension is supported,
     as defined in the RISC-V Profiles specification starting from commit
     b1d80660 ("Updated to ratified state.")
+
+* :c:macro:`RISCV_HWPROBE_KEY_AMO_PERF`: An enum value describing the
+  performance of the AMO instructions of the Zaamo extension, relative to
+  the equivalent LR/SC sequence, on the selected set of processors.
+
+  * :c:macro:`RISCV_HWPROBE_AMO_UNKNOWN`: The performance of AMO instructions
+    is unknown.
+
+  * :c:macro:`RISCV_HWPROBE_AMO_SLOW`: An uncontended AMO instruction takes
+    longer than the equivalent LR/SC sequence. This is the case when AMO
+    instructions are trapped and emulated by firmware. Code that can choose
+    should use LR/SC.
+
+  * :c:macro:`RISCV_HWPROBE_AMO_FAST`: An uncontended AMO instruction is at
+    least as fast as the equivalent LR/SC sequence.
+
+  * :c:macro:`RISCV_HWPROBE_AMO_UNSUPPORTED`: AMO instructions are not
+    supported, the Zaamo extension is absent.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3c3679701a60..dfd6237f879b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -764,6 +764,19 @@ config RISCV_ISA_ZAAMO
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_PROBE_AMO_SPEED
+	bool "Probe AMO instruction speed at boot"
+	default y
+	help
+	  During boot, time an uncontended AMO instruction against the
+	  equivalent LR/SC sequence on every CPU, and report which one is
+	  faster to userspace through the hwprobe syscall, as
+	  RISCV_HWPROBE_KEY_AMO_PERF. On a CPU that traps AMO instructions
+	  into firmware and emulates them there, LR/SC is much faster, and
+	  code that can choose should use it.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 5efa72823475..92cab4a7a0f1 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -83,6 +83,10 @@ static inline bool unaligned_ctl_available(void)
 }
 #endif
 
+#ifdef CONFIG_RISCV_PROBE_AMO_SPEED
+DECLARE_PER_CPU(long, amo_speed);
+#endif
+
 #if defined(CONFIG_RISCV_MISALIGNED)
 DECLARE_PER_CPU(long, misaligned_access_speed);
 bool misaligned_traps_can_delegate(void);
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 9b04377c0f98..b700852ac42f 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,7 +8,7 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY		16
+#define RISCV_HWPROBE_MAX_KEY		17
 
 static inline bool riscv_hwprobe_key_is_valid(__s64 key)
 {
diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 8fcc848c196e..5ca5c0b8ad66 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -219,6 +219,11 @@ ALTERNATIVE("nop", "fence rw, rw", SIFIVE_VENDOR_ID,			\
 	__ASM_STR(.error "hlv.d requires 64-bit support")
 #endif
 
+/* Spelled out so that it assembles when -march lacks Zaamo */
+#define AMOADD_W(dest, addr, val)				\
+	INSN_R(OPCODE_AMO, FUNC3(2), FUNC7(0),			\
+	       RD(dest), RS1(addr), RS2(val))
+
 #define LB_AQ(dest, addr)					\
 	INSN_R(OPCODE_AMO, FUNC3(0), FUNC7(26),			\
 	       RD(dest), RS1(addr), __RS2(0))
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index e6a394fbe7fc..a5f726f94204 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -122,6 +122,11 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZICCIF	_BITULL(3)
 #define		RISCV_HWPROBE_EXT_ZICCRSE	_BITULL(4)
 #define		RISCV_HWPROBE_EXT_ZA64RS	_BITULL(5)
+#define RISCV_HWPROBE_KEY_AMO_PERF	17
+#define		RISCV_HWPROBE_AMO_UNKNOWN	0
+#define		RISCV_HWPROBE_AMO_SLOW		1
+#define		RISCV_HWPROBE_AMO_FAST		2
+#define		RISCV_HWPROBE_AMO_UNSUPPORTED	3
 
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index ebe1c3588177..fc935c877e82 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
 obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
 obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)		+= copy-unaligned.o
 obj-$(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)	+= vec-copy-unaligned.o
+obj-$(CONFIG_RISCV_PROBE_AMO_SPEED)	+= amo_speed.o
 
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_FPU)		+= kernel_mode_fpu.o
diff --git a/arch/riscv/kernel/amo_speed.c b/arch/riscv/kernel/amo_speed.c
new file mode 100644
index 000000000000..933891b69db6
--- /dev/null
+++ b/arch/riscv/kernel/amo_speed.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Measure whether AMO instructions are faster than the equivalent LR/SC
+ * sequence. They are not on a CPU that traps them into firmware and
+ * emulates them there, such as MIPS P8700, where an AMO costs hundreds of
+ * cycles and LR/SC tens. The result goes to userspace through hwprobe,
+ * so code that can choose between the two knows which one to use.
+ */
+
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <linux/timekeeping.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+#include <asm/insn-def.h>
+#include <asm/timex.h>
+
+/* Time window for each measurement, and atomics per sample within it */
+#define AMO_SPEED_NS		8000000
+#define AMO_SPEED_ITERS		1024
+
+DEFINE_PER_CPU(long, amo_speed) = RISCV_HWPROBE_AMO_UNKNOWN;
+
+static DEFINE_PER_CPU_ALIGNED(u32, amo_speed_word);
+static long amo_speed_param = RISCV_HWPROBE_AMO_UNKNOWN;
+
+static void amo_speed_amo(u32 *word, unsigned long n)
+{
+	unsigned long tmp;
+
+	asm volatile(
+		"1:\n"
+		AMOADD_W(%[tmp], %[word], %[one])
+		"	addi %[n], %[n], -1\n"
+		"	bnez %[n], 1b\n"
+		: [tmp] "=&r" (tmp), [n] "+&r" (n), "+m" (*word)
+		: [word] "r" (word), [one] "r" (1UL)
+		: "memory");
+}
+
+static void amo_speed_lrsc(u32 *word, unsigned long n)
+{
+	unsigned long tmp;
+
+	asm volatile(
+		"1:	lr.w %[tmp], (%[word])\n"
+		"	addi %[tmp], %[tmp], 1\n"
+		"	sc.w %[tmp], %[tmp], (%[word])\n"
+		"	bnez %[tmp], 1b\n"
+		"	addi %[n], %[n], -1\n"
+		"	bnez %[n], 1b\n"
+		: [tmp] "=&r" (tmp), [n] "+&r" (n), "+m" (*word)
+		: [word] "r" (word)
+		: "memory");
+}
+
+/*
+ * For a fixed amount of time, repeatedly run func and take the best time
+ * in cycles as the measurement.
+ */
+static u64 amo_speed_measure(void (*func)(u32 *word, unsigned long n),
+			     u32 *word)
+{
+	u64 start_cycles, end_cycles, cycles = -1ULL;
+	u64 start_ns;
+
+	/* Do a warmup. */
+	func(word, AMO_SPEED_ITERS);
+
+	preempt_disable();
+
+	start_ns = ktime_get_mono_fast_ns();
+	while (ktime_get_mono_fast_ns() < start_ns + AMO_SPEED_NS) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the atomics. */
+		mb();
+		func(word, AMO_SPEED_ITERS);
+		/* Ensure the atomics end before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < cycles)
+			cycles = end_cycles - start_cycles;
+	}
+
+	preempt_enable();
+
+	return cycles;
+}
+
+static void check_amo_speed(void *unused)
+{
+	int cpu = smp_processor_id();
+	u32 *word = this_cpu_ptr(&amo_speed_word);
+	u64 amo_cycles, lrsc_cycles;
+	long speed;
+	int ratio;
+
+	if (per_cpu(amo_speed, cpu) != RISCV_HWPROBE_AMO_UNKNOWN)
+		return;
+
+	if (!riscv_cpu_has_extension_unlikely(cpu, RISCV_ISA_EXT_ZAAMO)) {
+		per_cpu(amo_speed, cpu) = RISCV_HWPROBE_AMO_UNSUPPORTED;
+		return;
+	}
+
+	amo_cycles = amo_speed_measure(amo_speed_amo, word);
+	lrsc_cycles = amo_speed_measure(amo_speed_lrsc, word);
+
+	/* Don't divide by zero. */
+	if (!amo_cycles || !lrsc_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure AMO speed\n",
+			cpu);
+		return;
+	}
+
+	if (amo_cycles <= lrsc_cycles)
+		speed = RISCV_HWPROBE_AMO_FAST;
+	else
+		speed = RISCV_HWPROBE_AMO_SLOW;
+
+	ratio = div64_u64(lrsc_cycles * 100, amo_cycles);
+	pr_info("cpu%d: AMO speed is %d.%02dx LR/SC speed (%s)\n",
+		cpu, ratio / 100, ratio % 100,
+		speed == RISCV_HWPROBE_AMO_FAST ? "fast" : "slow");
+
+	per_cpu(amo_speed, cpu) = speed;
+
+	if (speed == RISCV_HWPROBE_AMO_SLOW && IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO))
+		pr_warn_once("AMO is slow but kernel atomics use it, consider disabling RISCV_ISA_ZAAMO\n");
+}
+
+static int amo_speed_online_cpu(unsigned int cpu)
+{
+	if (per_cpu(amo_speed, cpu) != RISCV_HWPROBE_AMO_UNKNOWN)
+		return 0;
+
+	if (amo_speed_param != RISCV_HWPROBE_AMO_UNKNOWN)
+		per_cpu(amo_speed, cpu) = amo_speed_param;
+	else
+		check_amo_speed(NULL);
+
+	return 0;
+}
+
+static int __init set_amo_speed_param(char *str)
+{
+	if (!strcmp(str, "slow"))
+		amo_speed_param = RISCV_HWPROBE_AMO_SLOW;
+	else if (!strcmp(str, "fast"))
+		amo_speed_param = RISCV_HWPROBE_AMO_FAST;
+	else
+		return -EINVAL;
+
+	return 1;
+}
+__setup("amo_speed=", set_amo_speed_param);
+
+static int __init check_amo_speed_all_cpus(void)
+{
+	int cpu;
+
+	if (amo_speed_param != RISCV_HWPROBE_AMO_UNKNOWN) {
+		pr_info("AMO speed set to '%s' (%lu) by command line\n",
+			amo_speed_param == RISCV_HWPROBE_AMO_FAST ? "fast" : "slow",
+			amo_speed_param);
+		for_each_online_cpu(cpu)
+			per_cpu(amo_speed, cpu) = amo_speed_param;
+	} else {
+		on_each_cpu(check_amo_speed, NULL, 1);
+	}
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:amo_speed",
+				  amo_speed_online_cpu, NULL);
+
+	return 0;
+}
+
+/*
+ * Same level as the unaligned access probe: after clocksource_done_booting()
+ * so that amo_speed_measure() uses a stable clocksource, but before
+ * rootfs_initcall() enables usermode helpers that can reach hwprobe.
+ */
+fs_initcall_sync(check_amo_speed_all_cpus);
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 7818e1d32622..47836ecbd9af 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -257,6 +257,39 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 }
 #endif
 
+#ifdef CONFIG_RISCV_PROBE_AMO_SPEED
+static u64 hwprobe_amo(const struct cpumask *cpus)
+{
+	int cpu;
+	u64 perf = -1ULL;
+
+	for_each_cpu(cpu, cpus) {
+		int this_perf = per_cpu(amo_speed, cpu);
+
+		if (perf == -1ULL)
+			perf = this_perf;
+
+		if (perf != this_perf) {
+			perf = RISCV_HWPROBE_AMO_UNKNOWN;
+			break;
+		}
+	}
+
+	if (perf == -1ULL)
+		return RISCV_HWPROBE_AMO_UNKNOWN;
+
+	return perf;
+}
+#else
+static u64 hwprobe_amo(const struct cpumask *cpus)
+{
+	if (!hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZAAMO))
+		return RISCV_HWPROBE_AMO_UNSUPPORTED;
+
+	return RISCV_HWPROBE_AMO_UNKNOWN;
+}
+#endif
+
 #ifdef CONFIG_RISCV_VECTOR_MISALIGNED
 static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
 {
@@ -332,6 +365,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		pair->value = hwprobe_vec_misaligned(cpus);
 		break;
 
+	case RISCV_HWPROBE_KEY_AMO_PERF:
+		pair->value = hwprobe_amo(cpus);
+		break;
+
 	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
 		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
 			pair->value = riscv_cboz_block_size;

-- 
2.43.0

