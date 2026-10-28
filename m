Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219038;
	b=2yUYczmNpAWo9zOW5hNdvP4W192OBW/Xr4kZgtVB10J3Ud0T5hd12lPJ+HFRALY+F4m7
	 /X3LFxSngj3aClvS6JZpLb9fHOvzKpiNNJ/bD2xLl3aSGj9tFpXqIQS9HDCGsTLZhJzC6
	 AeyyDoGusc1ubS8QGcGfWvxYaog6WQhJoyVXDYkqgnnBChYboaCixQlEcLx3JOs6m9VVY
	 iFvWf8s5bj5OC1JThDXGWRAxDSnTBCIFPzgf6Lm98qnuH16sZ/qj74i0zAW0/wyuUShwb
	 GTV/Yq9bZMgluU5iwDlAFblJs3PrjcO4Z61I6iZbqfaFZWexz64FB93KRiH6+chzSsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219038;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=uM3dzNePX+CkZXaR4uIldLiii3CikIu7SQ4i+5pDCss=;
	b=p5V9avpvfp7GFiEP/SeI392bJIH01Hf5vOGlSwRMmUyY5fbzFamMFbfCnmtNi3yWpbta
	 6ozPI/lOC0r89DkEDPZnNzxqrMh/stHuvsB2uXPsIjZ/JobqV+p419BDZPPk7HRckHBf/
	 Knva19TFs8BgHQ4mfmwmG+qnxJ2xGovsv+mqLiDLIn5Gdo23bqNbT7UCXSMKKgb4TM89o
	 mxlV60t7/o3yiWphShvOVU3aRbWHKeP7VkKMoOsOSnBT78xDjE2xEHcPkwZR8ecSVrMCE
	 l9UnQjulCm1UuOFt0PLoYq9y2qT6/PkuBwqC2GfIt0ePDOqRtf49XTUUl9k5a2HNXDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=W6EV8y9Q;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95409606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95409606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=W6EV8y9Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=uM3dzNePX+CkZXaR4uIldLiii3CikIu7SQ4i+5pDCss=; b=W6EV8y9Qukh/0xoAXErtiSliBy
	r+F52WN/PCQEfbXLkBrVKoZrJW6BailOTCZ5vlG71JHPI8trIuFeiI7ns8dZr70LL8UI/SgUXFLS1
	0Zxq9Ffe7NxQh+qEUhOdhKTrfSt22lmwtCkYoVuoTqnbEr5KdVh67coLtxHgNZDvq9pb//wJ9fXuL
	cWjxV3ll4Vr2EsykaF5YSPqR9GCK1kXwxr3VEEePWNYGWVL5nt6PhSTy6s7EX9rPFPenYFo4Z7UfU
	74sVXv1HqVuTW/ghIqILoNjrALvA7RmvkUAua8vok7Vg6j/udf2CuzwNCDiQWS+LktPN23/y6wCI1
	EfpjlMDQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xMABW-0007I8-1u;
	Wed, 28 Oct 2026 21:23:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: rostedt@goodmis.org,
	ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf v3 1/2] x86/ftrace: Mark jmp mode by clearing bit 63 of trampoline address
Date: Wed, 28 Oct 2026 21:23:44 +0100
Message-ID: <20261028202345.1215859-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

Since commit 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
ftrace_call_replace() emits a jmp instead of a call when bit 0 of the
target is set, the mark of a direct trampoline that is entered by a jmp.
ftrace_update_ftrace_func() and arch_ftrace_update_trampoline() use it
too, for the call of the ftrace callback in ftrace_caller, ftrace_regs_caller
and the ftrace trampolines, but a callback is a C function and can start
at an odd address. It does with gcc13 and CONFIG_CC_OPTIMIZE_FOR_SIZE=y:
gcc13 has no -fmin-function-alignment, so CONFIG_CC_HAS_SANE_FUNCTION_ALIGNMENT
is not set, and the -falign-functions=16 used in its place does not apply
to functions optimized for size. Here ftrace_ops_list_func() starts at:

  ffffffff810e0147 T ftrace_ops_list_func

ftrace_regs_call then becomes a jmp to the byte before it:

  ftrace_regs_call ffffffff810374f3: e9 4e 8c 0a 00

That byte is the last one of the preceding function's tail jump, and with
the first two of ftrace_ops_list_func() it decodes as an inc DWORD PTR
[rcx+0x57], which swallows the push %r15 of the prologue. Entered without
a return address and one push short, the list function returns through
the pt_regs that ftrace_regs_caller saved, here to the saved R14:

  BUG: unable to handle page fault for address: ffff888116c29f40
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0xffff888116c29f40
  R13: 0000000000000000 R14: ffff888116c29f40 R15: 0000000000000000
  Call Trace:
   ? bpf_trampoline_6442499918+0x1/0x149
   ? bpf_lsm_file_open+0x5/0x8
   ? bpf_lsm_file_open+0x5/0x8
   ? security_file_open+0x19/0x46
   ? do_dentry_open+0x16c/0x32a

The list function is installed whenever two ftrace_ops are registered,
and a function that two of them trace calls it. A kprobe next to a BPF
trampoline is one such case, and with the single ftrace_ops of the BPF
trampolines every update_ftrace_direct_mod() is another, as it registers
a stub ops for the sites it modifies. Here, detaching one of several BPF
LSM programs from a busy hook crashed the tasks that ran the hook during
the update.

Bit 0 is free only in the direct trampolines that a dyn_ftrace record can
point to, but bit 63 is set in every kernel text address on x86_64. Thus,
mark jmp mode by clearing bit 63 instead, so that ftrace_is_jmp() is false
for any callback, whatever its alignment, and ftrace_regs_caller sets the
bit again where it cleared bit 0 before. A marked address is not canonical,
so a return or indirect branch to one that missed ftrace_jmp_get() faults
instead of running from a byte before its target.

Fixes: 0c3772a8db1f ("x86/ftrace: Implement DYNAMIC_FTRACE_WITH_JMP")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Menglong Dong <dongml2@chinatelecom.cn>
---
 v2 -> v3:
   - Removed Kconfig text, rest as-is
 v1 -> v2:
   - Steven suggested as an alternative/more generic fix to go
     the route via bit 63
   - BPF selftest kept as-is

 arch/x86/kernel/ftrace_64.S | 6 +++---
 include/linux/ftrace.h      | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 62c1c93aa1c6..4b20673a3395 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -286,9 +286,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	RET
 
 1:
-	testb	$1, %al
-	jz	2f
-	andq $0xfffffffffffffffe, %rax
+	/* See ftrace_jmp_set(), jmp to the trampoline */
+	btsq	$63, %rax
+	jc	2f
 	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
 	restore_mcount_regs
 	/* Restore flags */
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b041d9142d2b..1c2056a1a68b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -618,19 +618,21 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+#define FTRACE_JMP_BIT	BIT(BITS_PER_LONG - 1)
+
 static inline bool ftrace_is_jmp(unsigned long addr)
 {
-	return addr & 1;
+	return !(addr & FTRACE_JMP_BIT);
 }
 
 static inline unsigned long ftrace_jmp_set(unsigned long addr)
 {
-	return addr | 1UL;
+	return addr & ~FTRACE_JMP_BIT;
 }
 
 static inline unsigned long ftrace_jmp_get(unsigned long addr)
 {
-	return addr & ~1UL;
+	return addr | FTRACE_JMP_BIT;
 }
 #else
 static inline bool ftrace_is_jmp(unsigned long addr)
-- 
2.43.0

