Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292950;
	b=VMdu7dpKaG16olBFWwVrymxvXYkcISCiGAZcJD0LxX31Pqven/CcSj+3vVSdtOlKLnR9
	 pyZGgMdUR7BI/vkStU4u9mJZ56VjRZ6EYQjI24Jl/M55+zBlhg43Xel0jNtBqhX2bCXB5
	 3BJAcrTQyjs0Esm+g0hItjNT74bnqQYUj0ixMyA4/L8f1QcS63X0AVKEDXrH787wj9htT
	 lxGVa2SKVS1I0IcMj3R1E0HAtxo+WkkExLROHgIhpXiaJt7u4UdS6XIUH4ci8Ip6LEPPy
	 BW7xjFVtouItsdt8gc0PJF8Vo8Ko/mUHOOKyGcE3IVGSHjUbGnojEzlw7XXLaGMEnNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292950;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=kJkRWzKTSLUK2/Faj3tcwhme6sF5UGHV5NUdGjAN3AY=;
	b=DD09cq9Bwu9OBPhcMq5QNg/Ee6S6D3cWe9d+okEbwZ4vjUjIePUcDcLOeLoQdAknQsKk
	 Eg+H5XmFgOfOSwAKoaNqZbudb9+RLtx99uv4GzMNjIxeTC1up73LF+DeU83ROn2OrFUlh
	 5qGgDADdq58R49J7phimWE+qap9DowMkobB0w9cAPKF+BXrvzur3UxUv3sikc7zJclxLm
	 RADWff3VjbS5eEicXrj0bh5Is8xQaPJhZGW4Eol679/rxZOJ2vPwm9ANKMqntFs/p6gnD
	 GCKCoRmcoennxJnNd4cQlhUO9Pxob8yQ7QsUXRsBnCaHOWESvHGBaQTnJOTBOoqi3sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="fzQx/vyh";
	arc=none smtp.remote-ip=95.215.58.213
Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDF606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EBDF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fzQx/vyh
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DcbHqMXm9YywQXQS5isNbN/DF/Ks2LOHcly/ru2g6p8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292947; v=1; x=1793897747;
 b=fzQx/vyhDMsNSbH05grz1vVv/dy+61aONHR6Y2tDDyMwJb/K3ZaVBoFEBQ7w8j7qzwF+CqvG
 QIcxH4CmRuSVSy9wASTv4XvQLtKIHfGWlKeVVvvYppk9RzEfEE6fIOzRO8GPv+MI4NuS7x/nofP
 v/ooAxUwdsWIQeuXUQCYIgZw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fa999a47ed1d7bdc;
	Thu, 29 Oct 2026 16:55:23 +0000
X-Mizu-Trace-ID: fa999a47ed1d7bdc
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:55:13 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH v3 3/7] arm64: ftrace: Make the CALL_OPS prefix layout
 configurable
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-3-1b011ad5ddec@linux.dev>
X-Mailer: b4 0.15.2
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>

The arm64 ftrace code assumes two NOPs before every function in
several places. Replace the hardcoded count with a Kconfig value named
CONFIG_ARM64_FUNCTION_PREFIX_NOPS that defaults to 2. Compute the ops
literal address with one formula in both the assembly that reads it
and the C code that writes it. kCFI kernels with CALL_OPS need three
NOPs, or five with ThinLTO and BTI, and the reader and the writer stay
in sync either way.

Also make ftrace_call_adjust() look at each site's bytes and refuse
the ones that do not match the expected layout instead of patching
them. The two instructions to patch must be NOPs and the literal must
fall within the prefix NOPs. Log a refused site and leave it untraced.

No functional change for the layouts compilers generate today.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/Kconfig               |   5 ++
 arch/arm64/include/asm/ftrace.h  |  16 ++++++
 arch/arm64/kernel/entry-ftrace.S |  16 +++---
 arch/arm64/kernel/ftrace.c       | 120 ++++++++++++++++++++++-----------------
 4 files changed, 98 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cfef22aee709..aa7d5e1859af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -271,6 +271,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=2)
 
+config ARM64_FUNCTION_PREFIX_NOPS
+	int
+	default 2 if DYNAMIC_FTRACE_WITH_CALL_OPS
+	default 0
+
 config 64BIT
 	def_bool y
 
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1621c84f44b3..5a7a515bf7cd 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -24,6 +24,22 @@
 #define FTRACE_PLT_IDX		0
 #define NR_FTRACE_PLTS		1
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+/*
+ * ftrace_caller reads the callsite's ftrace_ops literal at
+ * ALIGN_DOWN(LR, 8) - FTRACE_CALL_OPS_BIAS. See ftrace_call_ops_adjust()
+ * for the layouts this serves.
+ */
+#define FTRACE_PREFIX_NOPS	CONFIG_ARM64_FUNCTION_PREFIX_NOPS
+#if FTRACE_PREFIX_NOPS == 2 || FTRACE_PREFIX_NOPS == 3
+#define FTRACE_CALL_OPS_BIAS	16
+#elif FTRACE_PREFIX_NOPS == 5
+#define FTRACE_CALL_OPS_BIAS	24
+#else
+#error "Unsupported number of function prefix NOPs"
+#endif
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS */
+
 /*
  * Currently, gcc tends to save the link register after the local variables
  * on the stack. This causes the max stack tracer to report the function
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 025140caafe7..95727fee3cc5 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -39,17 +39,17 @@ SYM_CODE_START(ftrace_caller)
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
 	/*
 	 * The literal pointer to the ops is at an 8-byte aligned boundary
-	 * which is either 12 or 16 bytes before the BL instruction in the call
-	 * site. See ftrace_call_adjust() for details.
+	 * before the BL instruction in the call site. See ftrace_call_adjust()
+	 * and <asm/ftrace.h> for details.
 	 *
-	 * Therefore here the LR points at `literal + 16` or `literal + 20`,
-	 * and we can find the address of the literal in either case by
-	 * aligning to an 8-byte boundary and subtracting 16. We do the
-	 * alignment first as this allows us to fold the subtraction into the
-	 * LDR.
+	 * Therefore here the LR points at `literal + FTRACE_CALL_OPS_BIAS` or
+	 * `literal + FTRACE_CALL_OPS_BIAS + 4`, and we can find the address of
+	 * the literal in either case by aligning to an 8-byte boundary and
+	 * subtracting FTRACE_CALL_OPS_BIAS. We do the alignment first as this
+	 * allows us to fold the subtraction into the LDR.
 	 */
 	bic	x11, x30, 0x7
-	ldr	x11, [x11, #-(4 * AARCH64_INSN_SIZE)]		// op
+	ldr	x11, [x11, #-FTRACE_CALL_OPS_BIAS]		// op
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	/*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index e1a3c0b3a051..0d922fa63f71 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -60,6 +60,73 @@ int ftrace_regs_query_register_offset(const char *name)
 }
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+/*
+ * The address of the ops literal for a callsite whose `BL <caller>` is at
+ * @pc, exactly as ftrace_caller derives it from the return address.
+ */
+static unsigned long ftrace_call_ops_literal(unsigned long pc)
+{
+	return ALIGN_DOWN(pc + AARCH64_INSN_SIZE, 8) - FTRACE_CALL_OPS_BIAS;
+}
+
+/*
+ * addr is the first of the FTRACE_PREFIX_NOPS NOPs before a function:
+ *
+ * addr-04:		.word		// kCFI type hash, address-taken and non-local only
+ * addr+00:		NOP		// FTRACE_PREFIX_NOPS of these, two hold the literal
+ * func+00:	func:	BTI	C	// only if BTI and the function may be called indirectly
+ * func+04:		NOP		// patched to MOV X9, LR
+ * func+08:		NOP		// patched to BL <caller>
+ *
+ * The compiler aligns whatever comes first to 8 bytes. ftrace_caller reads
+ * the literal at ALIGN_DOWN(LR, 8) - FTRACE_CALL_OPS_BIAS, with LR at
+ * func+8, or func+12 after a BTI:
+ *
+ *	NOPs	BIAS	literal at
+ *	2	16	func - 8
+ *	3	16	func - 8, or func - 12 if func % 8 == 4 (no hash, no BTI)
+ *	5	24	func - 16, or func - 12 / func - 20 if func % 8 == 4
+ *
+ * Return the address of the NOP to be patched to BL, or 0 when the two
+ * NOPs are not there or the literal would fall outside the prefix.
+ */
+static unsigned long ftrace_call_ops_adjust(unsigned long addr)
+{
+	unsigned long func = addr + FTRACE_PREFIX_NOPS * AARCH64_INSN_SIZE;
+	unsigned long pc = func + AARCH64_INSN_SIZE;
+	unsigned long literal;
+	u32 nop = aarch64_insn_gen_nop();
+
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) &&
+	    aarch64_insn_is_bti(le32_to_cpu(*(__le32 *)func)))
+		pc += AARCH64_INSN_SIZE;
+
+	/* Objects built with only the prefix NOPs have nothing to patch. */
+	if (le32_to_cpu(*(__le32 *)(pc - AARCH64_INSN_SIZE)) != nop ||
+	    le32_to_cpu(*(__le32 *)pc) != nop) {
+		pr_warn_ratelimited("ftrace: no patchable entry at %ps\n",
+				    (void *)func);
+		return 0;
+	}
+
+	/* The literal would overlap the type hash or the entry point. */
+	literal = ftrace_call_ops_literal(pc);
+	if (literal < addr || literal + sizeof(u64) > func) {
+		pr_warn_ratelimited("ftrace: cannot trace %ps: no room for the ops literal\n",
+				    (void *)func);
+		return 0;
+	}
+
+	return pc;
+}
+#else
+static unsigned long ftrace_call_ops_adjust(unsigned long addr)
+{
+	return 0;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS */
+
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
@@ -91,56 +158,7 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
 		return addr + AARCH64_INSN_SIZE;
 
-	/*
-	 * When using patchable-function-entry with pre-function NOPs, addr is
-	 * the address of the first pre-function NOP.
-	 *
-	 * Starting from an 8-byte aligned base, the compiler has either
-	 * generated:
-	 *
-	 * addr+00:		NOP		// Literal (first 32 bits)
-	 * addr+04:		NOP		// Literal (last 32 bits)
-	 * addr+08:	func:	NOP		// To be patched to MOV X9, LR
-	 * addr+12:		NOP		// To be patched to BL <caller>
-	 *
-	 * Or:
-	 *
-	 * addr+00:		NOP		// Literal (first 32 bits)
-	 * addr+04:		NOP		// Literal (last 32 bits)
-	 * addr+08:	func:	BTI	C
-	 * addr+12:		NOP		// To be patched to MOV X9, LR
-	 * addr+16:		NOP		// To be patched to BL <caller>
-	 *
-	 * We must adjust addr to the address of the NOP which will be patched
-	 * to `BL <caller>`, which is at either addr+12 or addr+16 depending on
-	 * whether there is a BTI.
-	 */
-
-	if (!IS_ALIGNED(addr, sizeof(unsigned long))) {
-		WARN_RATELIMIT(1, "Misaligned patch-site %pS\n",
-			       (void *)(addr + 8));
-		return 0;
-	}
-
-	/* Skip the NOPs placed before the function entry point */
-	addr += 2 * AARCH64_INSN_SIZE;
-
-	/* Skip any BTI */
-	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)) {
-		u32 insn = le32_to_cpu(*(__le32 *)addr);
-
-		if (aarch64_insn_is_bti(insn)) {
-			addr += AARCH64_INSN_SIZE;
-		} else if (insn != aarch64_insn_gen_nop()) {
-			WARN_RATELIMIT(1, "unexpected insn in patch-site %pS: 0x%08x\n",
-				       (void *)addr, insn);
-		}
-	}
-
-	/* Skip the first NOP after function entry */
-	addr += AARCH64_INSN_SIZE;
-
-	return addr;
+	return ftrace_call_ops_adjust(addr);
 }
 
 /* Convert fentry_ip to the symbol address without kallsyms */
@@ -368,7 +386,7 @@ static const struct ftrace_ops *arm64_rec_get_ops(struct dyn_ftrace *rec)
 static int ftrace_rec_set_ops(const struct dyn_ftrace *rec,
 			      const struct ftrace_ops *ops)
 {
-	unsigned long literal = ALIGN_DOWN(rec->ip - 12, 8);
+	unsigned long literal = ftrace_call_ops_literal(rec->ip);
 	return aarch64_insn_write_literal_u64((void *)literal,
 					      (unsigned long)ops);
 }

-- 
2.54.0

