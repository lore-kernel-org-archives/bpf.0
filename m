Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292988;
	b=iWcdaDjgsf4B2gMDVuXx4yR3Q+rOKKxmaE4gDsD8TI4tmR41q5ev8n3qhEavxJBJNHUW
	 B9tzAytunAhqw6ttY3z+yB5vQ9rcfXaRUKLXOEsVPDGSqoTvK5dbKTATynGBm8SbaQj8A
	 GwXb/hZg3qTP342kLbuLsAazCtjb0seBcmBWSQyWj9faZWcs08YydlRKa+uuDpJr/9yUZ
	 3AX1rv1Jihpx9kEFBrSY7yn+5TGUwx7Oorm8QX1GKLLkLpyZgWOLX5iskXDS+hebvKJM5
	 2U7rth7nSYhdiNOT3pbXA7fk3sLPGHYFC377LDOayG37WknImG+/KjJb5oC7Nv64LlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hua8r15V7TSjOPkP1LZ0fLVVfYG8l7xLUVsTAllRXFY=;
	b=A+lsp5FPbOUHMZhpmrbWpZjKKBrlThY6AIsMVpeeuTPdZUlzxoK7eBxntXpQQ4LvbZ/J
	 V42dV7qv67X0SXWJcme79hmwUd8bbW3RtvTr9Eo6rTNsxhpSIuvWELgQ2nSEGcFmCotLE
	 2q5IQeInzPyrJGyevmiIbKSlSZ9nlhm37PbXm2Rj+MnwwQsvWRUPnwL7znZBdKd/izjXs
	 j3nIzYckDSySkGcXgv6Md5gZTOg4LtAj9+R64M1jEwTmgb34IDyRLIOcwOmx5ioCM0m4p
	 XMEA6KZvNxp5qXS3SVYTDvHhtqMRkad86ISesekAlwehMaQd/7borkK1lTWP3a3sz9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SNPi9ypx;
	arc=none smtp.remote-ip=91.218.175.142
Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3E606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B3E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SNPi9ypx
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=434KqqiFbfCjkA3irR1iRo73T1t1MZ/g1nUcxCwYWug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292985; v=1; x=1793897785;
 b=SNPi9ypxbGsORekGrbMvynSR4jQhVAfuw6NBy6Y1dznoM1q+yoLL+kpMOlg1TRZE/Kw36Ptx
 Wfp2hI+JFzUuS50dHUQxag/ZLJfSMBdIk0vNQZNOyDB+U3W8pKt6Gf1NRd8TxEH9EcavtJOJKip
 ydamlvzS5kbujnhexIPLuAWg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d6b4a9e39e1a764;
	Thu, 29 Oct 2026 16:56:24 +0000
X-Mizu-Trace-ID: 5d6b4a9e39e1a764
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:56:15 +0000
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
Subject: [PATCH v3 4/7] arm64: cfi: Use CONFIG_ARM64_FUNCTION_PREFIX_NOPS for
 the type hash offset
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-4-1b011ad5ddec@linux.dev>
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

Make cfi_get_offset(), SYM_TYPED_FUNC_START and the BPF JIT use
CONFIG_ARM64_FUNCTION_PREFIX_NOPS instead of hardcoding four bytes. kCFI
kernels with CALL_OPS need three NOPs, or five with ThinLTO and BTI.

CONFIG_ARM64_FUNCTION_PREFIX_NOPS is 0 on every CFI kernel today, so no
functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/include/asm/cfi.h     | 11 +++++++++++
 arch/arm64/include/asm/linkage.h | 11 +++++++++++
 arch/arm64/net/bpf_jit_comp.c    |  8 ++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
index ab90f0351b7a..f3c04a2a6a95 100644
--- a/arch/arm64/include/asm/cfi.h
+++ b/arch/arm64/include/asm/cfi.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_ARM64_CFI_H
 #define _ASM_ARM64_CFI_H
 
+#include <asm/insn-def.h>
+
 #define __bpfcall
 
+#ifdef CONFIG_CFI
+static inline int cfi_get_offset(void)
+{
+	/* The 4-byte type hash sits before the prefix NOPs. */
+	return 4 + CONFIG_ARM64_FUNCTION_PREFIX_NOPS * AARCH64_INSN_SIZE;
+}
+#define cfi_get_offset cfi_get_offset
+#endif /* CONFIG_CFI */
+
 #endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index d1f7a16729d2..14bc3c67c38b 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -39,6 +39,17 @@
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
 	bti c ;
 
+/*
+ * The compiler emits CONFIG_ARM64_FUNCTION_PREFIX_NOPS NOPs between a C
+ * function's kCFI type hash and its entry point. Callers check the hash
+ * at that offset.
+ */
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name ASM_NL		\
+	.rept CONFIG_ARM64_FUNCTION_PREFIX_NOPS ASM_NL	\
+	nop ASM_NL					\
+	.endr
+
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
 	bti c ;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaa34c739004..42cb2d446680 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -185,8 +185,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 
 static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
 {
-	if (IS_ENABLED(CONFIG_CFI))
-		emit_u32_data(hash, ctx);
+	if (!IS_ENABLED(CONFIG_CFI))
+		return;
+
+	emit_u32_data(hash, ctx);
+	for (int i = 0; i < CONFIG_ARM64_FUNCTION_PREFIX_NOPS; i++)
+		emit(A64_NOP, ctx);
 }
 
 /*

-- 
2.54.0

