Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317127;
	b=TtKXC8dB68MUUGuX+OO47U4mc6ObHwyFP39vZRV8688nhjtgI1eHpAZjWhHEX7PVHzkL
	 BZblqS1max4t0RsD4NjYKOVTEDLtMfJacQal0/MwA4SaBvo8pE1XK7zWNSzQG1D5EsXHR
	 Bsxst5Rh92ey10Sge9VFNYZkdiMkHmlG2rBtWUwQUmhqP4VPBXhMAlTPWnieMvu+SH/wQ
	 6AQ8ustxOT9jUw/ZqUrPMsAixy7CM0fc3SAge36wdx7ryRnd6pW5XZb5xOc0PjLOLWw1y
	 gLWLyF0uYalzoEAOOio6fecw+11zYMMvJ04sVKxioDoWO4ZmBt4aQNppbo2JjbKzxZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317127;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=gAgUm+zu4ouAPHk2ltR9YWlOESQgVA+D9Wg1zFD55wo=;
	b=fdpGjMJA+cETIX4wztd7F9RiaMl9i1L9UArIQJSdpZCKWwebzjKEK79FemcZG4pInrDN
	 Uw+zkPxT1cav/3piRs+wjYBtbOSPpjZmeXsRaOYUeGOKWSLJnQwOV+oetz78Q2ki7w8Yp
	 Y7eFS3ws3fVcDY8Kf/IbIsMSnqOfNPYJjq9SOF/dAL0ZZ3jF6FIV1oCJMECS93xMinN8A
	 oi2r8OPe5wdSjep3iETMnG1yOm1wIOIK8a1KuqmOtGW01PZ5tW6h8LCbm3Og1ZrAwl1Y6
	 YIbwjHzt3d9iHY79mIfgIWmzm+qhHsEYX9sYBSDtrywXHgWU8v+kNmXIa9kCYrl6hNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3D606A7D8;
	Tue, 10 Nov 2026 13:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB3D606A7D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794317125; x=1825853125;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=coFMHXrP0qcF3S1aGstc7G6RDhIOeADEJJLQLLJLVZU=;
  b=A7j+Bngtd5dZam/hE0IRY21iqWf4RJs/NcFA9J8jX75rdqpLvLQrRo+I
   QdeOAMQzxwNTtsU1EOTx1GtIAzkQi+ypWFfq7RGLPt6GBKYhx3ekzMVtJ
   6e/Yxn0T7SQzo/tBNMTWbfVBBIClBTt7nMvt4JWm+h8VIzY9Z2v+Lzm1+
   r6kj0taJ5W42rohokm9Gvn5cCZTnLWwh5qqtk8oQ9l4pgrl3pw28N7ltW
   iY9MnOK+H03oXKv6dZ4hny0MU114CneTGaGjxaDqPtOOALfC/WBUQ7Fea
   tFiER32hIE9kDIcZDGdjryqRetT6ms3zH5QrtYyhZfLe2RULy1Iu5Uy/y
   g==;
X-CSE-ConnectionGUID: 1X3Eq3HWSwW2H+8428Svhg==
X-CSE-MsgGUID: 6AcQ3tuKR8GVRB3ZXNk3AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:22:53 +0200
X-CSE-ConnectionGUID: xsgB36dIQoWRmHm+zOXwPg==
X-CSE-MsgGUID: gyu9GASCTaWhK0lgF45j3Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 10 Nov 2026 15:30:58 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:52 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 10 Nov 2026 15:20:59 +0200
Subject: [PATCH v6 2/6] riscv: build kernel atomics from LR/SC when Zaamo
 is disabled
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
Message-Id: <20261110-lrsc-only-v6-2-bafc3cc0fcae@mobileye.com>
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

The A extension is Zaamo plus Zalrsc. On some CPUs Zaamo is present
only formally. MIPS P8700 traps every AMO instruction into M-mode and
emulates it there, so the extension is supported but very slow. A
typical uncontended atomic increment costs:

  native AMO                                     2..5 cycles
  LR/SC, private L1 reservation monitor         6..12 cycles
  LR/SC, PoC (L2) reservation monitor       about 40 cycles
  AMO emulated by an M-mode trap           about 600 cycles

The last two were measured on the eyeq7h hardware. On such a CPU the
kernel must use LR/SC for every atomic.

Add RISCV_ISA_ZAAMO, default y. The default keeps "a" in -march and
the generated code unchanged. When it is disabled, -march carries
_zalrsc instead of "a", and atomic_*, bitops, xchg, futex and the
early boot code use LR/SC loops. The sequence is chosen with the
preprocessor, on CONFIG_RISCV_ISA_ZAAMO like the other ISA options in
the headers, because the assembler rejects AMO mnemonics once -march
lacks Zaamo. A kernel built this way runs on any hart that implements
A; it just does not use AMO. It is therefore a plain option, not a
NONPORTABLE one, and the hart keeps advertising "a" to userspace,
which is true.

The LR/SC loops follow the ordering convention of the existing ones
in cmpxchg.h, from commit 5ce6c1f3535f ("riscv/atomic: Strengthen
implementations with fences") and commit 1d84afaf0252 ("riscv: Fix
fully ordered LR/SC xchg[8|16]() implementations"): a fully ordered
operation is lr, sc.rl and a trailing fence rw,rw; acquire is lr.aq
with a plain sc; release is a plain lr with sc.rl. The futex loop is
bounded to 128 retries and returns -EAGAIN after that, as arm64 does,
because userspace can keep the word changing from another thread and
futex_wake_op() retries on -EAGAIN anyway.

Zabha, Zacas and the ssamoswap instruction of Zicfiss are AMO
instructions, so RISCV_ISA_ZABHA, RISCV_ISA_ZACAS and RISCV_USER_CFI
depend on RISCV_ISA_ZAAMO. The riscv64imac Rust target emits AMO too,
so RUSTC_SUPPORTS_RISCV depends on it as well.

The choice is made at compile time rather than with alternatives.
Nearly every CPU has a native A extension, and an alternative would
inflate all those kernels with the nops needed to pad one AMO to the
size of an LR/SC loop, at every atomic site, for the benefit of a few.

Turning Zaamo off needs a compiler that accepts _zaamo and _zalrsc in
-march. GCC 15.1 is the first release that does.
TOOLCHAIN_HAS_ZALRSC_ZAAMO checks for it; with an older compiler the
option stays at y.

Three sets of extensions provide every atomic Linux needs. "a" is what
the kernel supports today. Zalrsc plus Ziccrse is what this patch adds:
every atomic is a constrained LR/SC loop, and Ziccrse is the
forward-progress guarantee for such loops. Zaamo plus Zacas would do
as well, with CAS loops in place of LR/SC as on x86, and is left for
whoever has such hardware.

Suggested-by: Chao-ying Fu <chao-ying.fu@globalfoundries.com>
Nacked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/linux-riscv/20261106-smock-headband-d6a7d568c228@spud/
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/Kconfig               | 36 +++++++++++++++++++
 arch/riscv/Makefile              | 15 +++++---
 arch/riscv/include/asm/atomic.h  | 53 +++++++++++++++++++++++++++-
 arch/riscv/include/asm/bitops.h  | 76 ++++++++++++++++++++++++++++++++++++++--
 arch/riscv/include/asm/cmpxchg.h | 39 +++++++++++++++++----
 arch/riscv/include/asm/futex.h   | 58 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/entry.S        |  7 ++++
 arch/riscv/kernel/head.S         | 12 +++++++
 8 files changed, 281 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5874ca30f4f6..3c3679701a60 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -237,6 +237,8 @@ config RISCV
 config RUSTC_SUPPORTS_RISCV
 	def_bool y
 	depends on 64BIT
+	# The riscv64imac target emits AMO instructions
+	depends on RISCV_ISA_ZAAMO
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
 	def_bool CC_IS_CLANG
@@ -706,6 +708,7 @@ config RISCV_ISA_ZABHA
 	bool "Zabha extension support for atomic byte/halfword operations"
 	depends on TOOLCHAIN_HAS_ZABHA
 	depends on RISCV_ALTERNATIVE
+	depends on RISCV_ISA_ZAAMO
 	default y
 	help
 	  Enable the use of the Zabha ISA-extension to implement kernel
@@ -723,6 +726,7 @@ config TOOLCHAIN_HAS_ZACAS
 config RISCV_ISA_ZACAS
 	bool "Zacas extension support for atomic CAS"
 	depends on RISCV_ALTERNATIVE
+	depends on RISCV_ISA_ZAAMO
 	default y
 	help
 	  Enable the use of the Zacas ISA-extension to implement kernel atomic
@@ -730,6 +734,36 @@ config RISCV_ISA_ZACAS
 
 	  If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZALRSC_ZAAMO
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64im_zaamo_zalrsc)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32im_zaamo_zalrsc)
+
+config RISCV_ISA_ZAAMO
+	bool "Zaamo extension support for AMO atomics" if TOOLCHAIN_HAS_ZALRSC_ZAAMO
+	default y
+	help
+	  Use AMO instructions for kernel atomic memory operations. When
+	  disabled, those operations are built from LR/SC and the kernel
+	  is compiled with zalrsc instead of the A extension.
+
+	  Disable this for a CPU where AMO is much slower than LR/SC. That
+	  is the case when AMO instructions are emulated by a trap into
+	  M-mode, as on the MIPS P8700: an emulated atomic costs hundreds
+	  of cycles where LR/SC costs tens.
+
+	  A kernel built without Zaamo runs on any CPU that implements the
+	  A extension. Zabha, Zacas, userspace control flow integrity and
+	  Rust need Zaamo and are unavailable without it.
+
+	  The compiler must accept _zaamo and _zalrsc in -march to make
+	  this choice. GCC 15.1 is the first release that does. With an
+	  older compiler the option stays enabled and -march keeps the A
+	  extension.
+
+	  If you don't know what to do here, say Y.
+
 config TOOLCHAIN_HAS_ZBB
 	bool
 	default y
@@ -1206,6 +1240,8 @@ config RISCV_USER_CFI
 	depends on 64BIT && MMU && \
 		$(cc-option,-mabi=lp64 -march=rv64ima_zicfiss_zicfilp -fcf-protection=full)
 	depends on RISCV_ALTERNATIVE
+	# ssamoswap is an AMO instruction
+	depends on RISCV_ISA_ZAAMO
 	select RISCV_SBI
 	select ARCH_HAS_USER_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 44f5a439741a..59c5123c5485 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -58,8 +58,9 @@ ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
 endif
 
 # ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
+riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32im
+riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64im
+riscv-march-$(CONFIG_RISCV_ISA_ZAAMO)	:= $(riscv-march-y)a
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
@@ -75,9 +76,15 @@ else
 riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) := $(riscv-march-y)_zicsr_zifencei
 endif
 
-KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima?|rv64ima?)fd([^v_]*)v?/\1\2/')
 export KBUILD_BASE_ISA
 
+# Without Zaamo only the LR/SC half of "a" is used. The compiler accepts
+# _zalrsc here, see TOOLCHAIN_HAS_ZALRSC_ZAAMO.
+ifneq ($(CONFIG_RISCV_ISA_ZAAMO),y)
+riscv-march-y := $(riscv-march-y)_zalrsc
+endif
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
@@ -85,7 +92,7 @@ KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
 # For C code built with floating-point support, exclude V but keep F and D.
-CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+CC_FLAGS_FPU  := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima?|rv64ima?)([^v_]*)v?/\1\2/')
 
 KBUILD_CFLAGS += -mno-save-restore
 
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 616b8b332ac5..cca1fc3a68ff 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -50,6 +50,7 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
  * have the AQ or RL bits set.  These don't return anything, so there's only
  * one version to worry about.
  */
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
 static __always_inline							\
 void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
@@ -59,7 +60,23 @@ void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
 		: "+A" (v->counter)					\
 		: "r" (I)						\
 		: "memory");						\
-}									\
+}
+#else
+#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
+static __always_inline							\
+void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n"					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+}
+#endif
 
 #ifdef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC_OPS(op, asm_op, I)					\
@@ -84,6 +101,7 @@ ATOMIC_OPS(xor, xor,  i)
  * There's two flavors of these: the arithmetic ops have both fetch and return
  * versions, while the logical ops only have fetch versions.
  */
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
 c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
@@ -108,6 +126,39 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 		: "memory");						\
 	return ret;							\
 }
+#else
+#define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
+					     atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type " %2, %2, %0\n"			\
+		"	bnez %2, 1b\n"					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}									\
+static __always_inline							\
+c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
+{									\
+	register c_type ret, temp;					\
+	__asm__ __volatile__ (						\
+		"1:	lr." #asm_type " %1, %0\n"			\
+		"	" #asm_op " %2, %1, %3\n"			\
+		"	sc." #asm_type ".rl %2, %2, %0\n"		\
+		"	bnez %2, 1b\n"					\
+		RISCV_FULL_BARRIER					\
+		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
+		: "r" (I)						\
+		: "memory");						\
+	return ret;							\
+}
+#endif
 
 #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 3c1a15be54d8..adcd70525774 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -170,12 +170,17 @@ static __always_inline int variable_fls(unsigned int x)
 
 #if (BITS_PER_LONG == 64)
 #define __AMO(op)	"amo" #op ".d"
+#define __LR	"lr.d"
+#define __SC	"sc.d"
 #elif (BITS_PER_LONG == 32)
 #define __AMO(op)	"amo" #op ".w"
+#define __LR	"lr.w"
+#define __SC	"sc.w"
 #else
 #error "Unexpected BITS_PER_LONG"
 #endif
 
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 #define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
 ({								\
 	unsigned long __res, __mask;				\
@@ -195,10 +200,58 @@ static __always_inline int variable_fls(unsigned int x)
 		: "r" (mod(BIT_MASK(nr)))			\
 		: "memory");
 
-#define __test_and_op_bit(op, mod, nr, addr) 			\
+#define __test_and_op_bit(op, mod, nr, addr)			\
 	__test_and_op_bit_ord(op, mod, nr, addr, .aqrl)
+#define __test_and_op_bit_acquire(op, mod, nr, addr)		\
+	__test_and_op_bit_ord(op, mod, nr, addr, .aq)
 #define __op_bit(op, mod, nr, addr)				\
 	__op_bit_ord(op, mod, nr, addr, )
+#define __op_bit_release(op, mod, nr, addr)			\
+	__op_bit_ord(op, mod, nr, addr, .rl)
+#else
+/*
+ * Fully ordered LR/SC is lr, sc.rl and a full fence; acquire is lr.aq and
+ * release is sc.rl, with no ordering on the other instruction. This is how
+ * the LR/SC loops in asm/atomic.h and asm/cmpxchg.h are built.
+ */
+#define __test_and_op_bit_lrsc(op, mod, nr, addr, lr_sfx, sc_sfx, append)	\
+({								\
+	unsigned long __res, __mask, __temp;			\
+	__mask = BIT_MASK(nr);					\
+	__asm__ __volatile__ (					\
+		"1: " __LR lr_sfx " %0, %1\n"			\
+		#op " %2, %0, %3\n"				\
+		__SC sc_sfx " %2, %2, %1\n"			\
+		"bnez %2, 1b\n"					\
+		append						\
+		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
+		: "r" (mod(__mask))				\
+		: "memory");					\
+	((__res & __mask) != 0);				\
+})
+
+#define __op_bit_lrsc(op, mod, nr, addr, lr_sfx, sc_sfx)	\
+do {								\
+	unsigned long __res, __temp;				\
+	__asm__ __volatile__ (					\
+		"1: " __LR lr_sfx " %0, %1\n"			\
+		#op " %2, %0, %3\n"				\
+		__SC sc_sfx " %2, %2, %1\n"			\
+		"bnez %2, 1b\n"					\
+		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
+		: "r" (mod(BIT_MASK(nr)))			\
+		: "memory");					\
+} while (0)
+
+#define __test_and_op_bit(op, mod, nr, addr)			\
+	__test_and_op_bit_lrsc(op, mod, nr, addr, "", ".rl", RISCV_FULL_BARRIER)
+#define __test_and_op_bit_acquire(op, mod, nr, addr)		\
+	__test_and_op_bit_lrsc(op, mod, nr, addr, ".aq", "", "")
+#define __op_bit(op, mod, nr, addr)				\
+	__op_bit_lrsc(op, mod, nr, addr, "", "")
+#define __op_bit_release(op, mod, nr, addr)			\
+	__op_bit_lrsc(op, mod, nr, addr, "", ".rl")
+#endif
 
 /* Bitmask modifiers */
 #define __NOP(x)	(x)
@@ -297,7 +350,7 @@ static __always_inline void arch_change_bit(int nr, volatile unsigned long *addr
 static __always_inline int arch_test_and_set_bit_lock(
 	unsigned long nr, volatile unsigned long *addr)
 {
-	return __test_and_op_bit_ord(or, __NOP, nr, addr, .aq);
+	return __test_and_op_bit_acquire(or, __NOP, nr, addr);
 }
 
 /**
@@ -310,7 +363,7 @@ static __always_inline int arch_test_and_set_bit_lock(
 static __always_inline void arch_clear_bit_unlock(
 	unsigned long nr, volatile unsigned long *addr)
 {
-	__op_bit_ord(and, __NOT, nr, addr, .rl);
+	__op_bit_release(and, __NOT, nr, addr);
 }
 
 /**
@@ -337,20 +390,37 @@ static __always_inline void arch___clear_bit_unlock(
 static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned long mask,
 		volatile unsigned long *addr)
 {
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 	unsigned long res;
 	__asm__ __volatile__ (
 		__AMO(xor) ".rl %0, %2, %1"
 		: "=r" (res), "+A" (*addr)
 		: "r" (__NOP(mask))
 		: "memory");
+#else
+	unsigned long res, temp;
+
+	__asm__ __volatile__ (
+		"1: " __LR " %0, %1\n"
+		"xor %2, %0, %3\n"
+		__SC ".rl %2, %2, %1\n"
+		"bnez %2, 1b\n"
+		: "=&r" (res), "+A" (*addr), "=&r" (temp)
+		: "r" (__NOP(mask))
+		: "memory");
+#endif
 	return (res & BIT(7)) != 0;
 }
 
 #undef __test_and_op_bit
+#undef __test_and_op_bit_acquire
 #undef __op_bit
+#undef __op_bit_release
 #undef __NOP
 #undef __NOT
 #undef __AMO
+#undef __LR
+#undef __SC
 
 #include <asm-generic/bitops/instrumented-atomic.h>
 #include <asm-generic/bitops/instrumented-lock.h>
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 662e160b0522..f0199432948a 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -57,16 +57,39 @@
 	}									\
 })
 
-#define __arch_xchg(sfx, prepend, append, r, p, n)			\
+/*
+ * Word and double-word xchg is one amoswap, or an LR/SC loop without
+ * Zaamo. Each form uses its own pair of ordering arguments, as in
+ * __arch_xchg_masked() above.
+ */
+#ifdef CONFIG_RISCV_ISA_ZAAMO
+#define __arch_xchg(w, sc_sfx, swap_sfx, prepend, sc_append,		\
+		    swap_append, r, p, n)				\
 ({									\
 	__asm__ __volatile__ (						\
 		prepend							\
-		"	amoswap" sfx " %0, %2, %1\n"			\
-		append							\
+		"	amoswap" w swap_sfx " %0, %2, %1\n"		\
+		swap_append						\
 		: "=r" (r), "+A" (*(p))					\
 		: "r" (n)						\
 		: "memory");						\
 })
+#else
+#define __arch_xchg(w, sc_sfx, swap_sfx, prepend, sc_append,		\
+		    swap_append, r, p, n)				\
+({									\
+	__typeof__(*(p)) __temp;					\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"1:	lr" w " %0, %1\n"				\
+		"	sc" w sc_sfx " %2, %3, %1\n"			\
+		"	bnez %2, 1b\n"					\
+		sc_append						\
+		: "=&r" (r), "+A" (*(p)), "=&r" (__temp)		\
+		: "r" (n)						\
+		: "memory");						\
+})
+#endif
 
 #define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
 		   sc_append, swap_append)				\
@@ -87,12 +110,14 @@
 				   __ret, __ptr, __new);		\
 		break;							\
 	case 4:								\
-		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".w", sc_sfx, swap_sfx,			\
+			    prepend, sc_append, swap_append,		\
+			    __ret, __ptr, __new);			\
 		break;							\
 	case 8:								\
-		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
-			      __ret, __ptr, __new);			\
+		__arch_xchg(".d", sc_sfx, swap_sfx,			\
+			    prepend, sc_append, swap_append,		\
+			    __ret, __ptr, __new);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 6f3bc9bdb85e..e79d28af55cd 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-extable.h>
+#include <asm/fence.h>
 
 /* We don't even really need the extable code, but for now keep it simple */
 #ifndef CONFIG_MMU
@@ -19,6 +20,7 @@
 #define __disable_user_access()		do { } while (0)
 #endif
 
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
 {								\
 	__enable_user_access();					\
@@ -32,6 +34,39 @@
 	: "memory");						\
 	__disable_user_access();				\
 }
+#else
+/*
+ * Bound the number of LR/SC retries, as arm64 does for LL/SC: a user can
+ * keep the word changing from another thread forever. futex_wake_op()
+ * retries on -EAGAIN after dropping the hash bucket locks.
+ */
+#define FUTEX_MAX_LOOPS	128
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
+{								\
+	int temp, loops = FUTEX_MAX_LOOPS;			\
+								\
+	__enable_user_access();					\
+	__asm__ __volatile__ (					\
+	"1:	lr.w %[ov], %[u]			\n"	\
+	"	" insn "				\n"	\
+	"2:	sc.w.rl %[t], %[t], %[u]		\n"	\
+	"	beqz %[t], 3f				\n"	\
+	"	addi %[l], %[l], -1			\n"	\
+	"	bnez %[l], 1b				\n"	\
+	"	li %[r], %[ea]				\n"	\
+	"3:						\n"	\
+	RISCV_FULL_BARRIER					\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %[r])			\
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %[r])			\
+	: [r] "+r" (ret), [ov] "=&r" (oldval),			\
+	  [t] "=&r" (temp), [l] "+&r" (loops),			\
+	  [u] "+m" (*(uaddr))					\
+	: [op] "Jr" (oparg), [ea] "I" (-EAGAIN)			\
+	: "memory");						\
+	__disable_user_access();				\
+}
+#endif
 
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
@@ -43,6 +78,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	uaddr = untagged_addr(uaddr);
 
 	switch (op) {
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 	case FUTEX_OP_SET:
 		__futex_atomic_op("amoswap.w.aqrl %[ov],%z[op],%[u]",
 				  ret, oldval, uaddr, oparg);
@@ -63,6 +99,28 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		__futex_atomic_op("amoxor.w.aqrl %[ov],%z[op],%[u]",
 				  ret, oldval, uaddr, oparg);
 		break;
+#else
+	case FUTEX_OP_SET:
+		__futex_atomic_op("mv %[t], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor %[t], %[ov], %z[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+#endif
 	default:
 		ret = -ENOSYS;
 	}
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 61b7a7716697..ba2db6804a6c 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -73,7 +73,14 @@
 	beq	a2, zero, .Lnew_valid_map_cpus_restore_context
 
 	/* Atomically reset the current cpu bit in new_valid_map_cpus */
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 	amoxor.d	a0, a1, (a0)
+#else
+1:	lr.d	a2, (a0)
+	xor	a2, a1, a2
+	sc.d	a2, a2, (a0)
+	bnez	a2, 1b
+#endif
 
 	/*
 	 * A sfence.vma is required here. Even if we had Svvptc, there's no
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index f6a8ca49e627..dc3862ed29c4 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -265,7 +265,19 @@ SYM_CODE_START(_start_kernel)
 	/* Pick one hart to run the main boot sequence */
 	la a3, hart_lottery
 	li a2, 1
+#ifdef CONFIG_RISCV_ISA_ZAAMO
 	amoadd.w a3, a2, (a3)
+#else
+	/*
+	 * hart_lottery is a small 32-bit counter. add is valid on RV32
+	 * and RV64; sc.w stores the low 32 bits.
+	 */
+1:	lr.w t0, (a3)
+	add t1, t0, a2
+	sc.w t1, t1, (a3)
+	bnez t1, 1b
+	mv a3, t0
+#endif
 	bnez a3, .Lsecondary_start
 #endif /* CONFIG_RISCV_BOOT_SPINWAIT */
 

-- 
2.43.0

