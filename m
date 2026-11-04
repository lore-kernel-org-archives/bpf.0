Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755523;
	b=DX5uJWMHKt65+XHDQyQjuGoB1/hfLjc0L+39QQKjjuN1n9YkEJyHA2QDA7AAknVUIja/
	 HU8ZcyQapbxEhzrriAZTqLmNnztvhqvNHNi5ph3LpjwMBqt+Qfo47MngpU5n2BTb6AcAw
	 FxL8O0xmCbCrvJ/oKFiGpZYxG3PnX4FmqlpS2sRppGdp7wudZUlTA1MP21tbKjOY2+55w
	 zvPUTmEGsIAhM0gWFbtdKNALN40gUlA7WRKiTEhA/gQyHT1+W7zGNyP9WtD5fRZXYUou6
	 O6cL1pV0Q5eplFSX9s1+xlQyWZyeg2Xr4xDU4OKa+apBz3fJd0+6nekBfIXs5VzOeFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
	b=CfI93cqsnwRiCSEL+n9aS24Azwv3fzZp2tvYvMKWVnUL5l2PfpN+edI8VLrFC/3wRKgE
	 sC6czzK9euKH0S2JmjghtOR4aM+yOFYToumRB0Dl0yFYoncVBzpKGZ6yYDSLQsc1eZDn1
	 uNi//WQeYPKPf+cwmYEMf3FH6bDszOCzVCLr3XDbdsw4r0YywDS8fO0uMiEgvPOpWJV7A
	 usp/A4HsMLHfN2x6Yt+qghDx1h531oyCUjruW02r8T9tdp0KMf8PmRmJBgLRs407Tn+p3
	 cnaD0FybIPD3cCP6jLT81k+/jesMNVH+pkhUdBy7gQrjEqRL0U8ePzONVSxBVOkff5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhWknvf2;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AF606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C96AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhWknvf2
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so113922a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755522; x=1794360322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
        b=UhWknvf2o1zBZuOYWipUIZUnyQ39VNgCwFsYsUj0MY7VOe4x3Kc8CJFEISWX/WPGbO
         9yE9YjD2N/ix40BGv9sRcqwBQF9YtRA/eDfC3JNSpaXHslZIrWVe2jjNCaKrmFkpDGH1
         1fbqost7BzNHV4gO6FzoiddMuLhlIgwX+7ipHgkEM3k74dtNJPinYAkqNtL7TZDZ0a5E
         6aNLty8qNvgMV71ENdxiyfYXahcQNpGwIu0nCcJn4RQVJvLsYGynZZVDGx4F34bUV1Rt
         iyV8XrwCqtiFHcvMLr8aklEASjYuDkTOALnW8XtJrUStqRncMws2yIpxcAOAKr43nHu7
         ffyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755522; x=1794360322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lr/wxfOS32+ALQofs1tJZPZvXT4JxRnn24bqDnojpHE=;
        b=hi/m4wfyZxQmldmTPF70LL73AgfkxDfop3FEk8AsQTPRfpGtj2964RzDD1v3N6xKJt
         xGxNZLLBV+izMRbQ6VBV0CCmCxoAAZXGugz+JiZSporJT2RAZzh/EYd9j6I5tYbaTMvo
         UPCCP9z8AwsO50SacqPiT4zSuSO+LSP4/m8GbSbEAg1OLpSsBG0sXjVJ8/cqUQDUxa8K
         KBcjzTxcYkZO99oCIc52FwtDdAN6NSlXZsOFc4XJMEv4d2KR3KzXJyh2SAvuetzwJn8W
         N1aAVaelEzBbIaNNTyvZ7bRn7mCZZ/0qnDohxF7/js7MZZ9vBbXkokDeHfcrM0UbIQsz
         4kMA==
X-Gm-Message-State: APuU4Z9wipwmn+rW60/spz3weuXwktvUv1Ua0Lu9nST0IsK40R/6/4m2
	5ei/Df+FE6Jt3JUxK/C1qsIXi1h1beEfy24MMomD96pp4HZh8m762E1BsLha3A==
X-Gm-Gg: AYBFou04pG6GpJShx/Uy24LUs5ahMzhf1sk2ltCoDlfC72ng+roaMbwfcCtkAUQ1VAo
	+RTmgxdCjOQQKTHJvbxUO2BHIwqlOPp1sw8uaS25Lz8LSiDsOF2loaot41iQs7sspkgg24aEDDi
	0D8tFC45q+StagjZSumBz7Jxf+wZo9DMa9SIqqcofMk4EKM8vWKOBy8LKM9iT8Fz0uXOkHjlsKn
	t4igFyyT0umAvGeKQgJkkFaLPdNv4hMg2cxpbycgOLiFKJ0SUbKFCKrcwdmNWKD86E72Eoc2Rx1
	UAkguCLk4t9usrXp8zu/lLHDhl/ReIDPcp3fsiT0nRAlyRksoDou4odIzcUb64Rw1rmZ/9gu6Ul
	nG2vgeupn+2WG4BnhAmTlqVG/B9P+vHxx620OsQqS4rjKTsdRA7uChBJxdj8dqYUyK9W37PhQXd
	0jptq+CK1+wnzYt6iVsyXVttoZJ6p/o+0kWcg7XQ/wBKfPttpqSMZqK12O2DjPmAMIRLXtUeunH
	PnumQNgRxfhqEB/XtAR0LL/JKmUJjOEgDK1UXi2tfLi5Ws3p/nNIBQuuUJfQYGMotByUilQdX8F
	noD58Vr4XfO8fbchPAXGhNDRhY+dA6P5GWoK1LOrmO4iEfIaQ03RGIX6Vyxr8yXs1pGGlnL74+G
	BdX4/IOmA8yO9hQ5TX8TdOwgsN6823GVta66pmLdva7XLFT5zSBQ0hltOt6cV9oxBvfjalzPsXN
	P9qtdcqAo9NVKVQ3Am7uaL
X-Received: by 2002:a17:90b:1b03:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ae89287394mr11156429a91.0.1793755521562;
        Tue, 03 Nov 2026 17:25:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944903bdsm1313507a91.8.2026.11.03.17.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:25:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 13/14] bpf, arm64: Support BPF_REG_ARENA_SP
Date: Wed,  4 Nov 2026 01:23:59 +0000
Message-ID: <20261104012401.1354861-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

r12 (BPF_REG_ARENA_SP) is the stack pointer of the second stack of a prog.
This stack is in arena. The verifier replaces the insns that use r12 with
insns that the JIT already knows: a 32-bit add, addr_space_cast, and loads
and stores in arena. Thus the JIT only has to supply a register.

Map r12 to x23. The JIT does not use x23 for other data. x23 is callee
saved, thus helpers and kfuncs keep its value. It is not an argument
register, thus calls do not change.

The kernel calls the main prog and callbacks, and it does not know about
r12. The main prog, and a callback that uses r12, take a stack at entry and
set r12. Thus they save x23 at entry and restore it at exit. Other subprogs
get x23 from the caller.

Progs without r12 get the same code. The cost in progs with r12:

  save and restore of x23      0 or 2 insns (stp, ldp). The JIT saves
                               registers in pairs.
  load or store through r12    3 insns: add of the base of arena, mov of
                               the negative offset, ldr or str.
  load or store through r10    1 insn, for reference.

Tested in QEMU with the selftests of this series and bpf_testmod: with LSE
atomics and without, at EL1 and at EL2 (VHE), with 2 and 4 cpus, with
bpf_jit_harden 0 and 2, with pages of 4 Kbyte and of 64 Kbyte, with KASAN
and lockdep.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e99f105b7f61..e6d6df96fa99 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -61,6 +61,8 @@ static const int bpf2a64[] = {
 	[BPF_REG_9] = A64_R(22),
 	/* read-only frame pointer to access stack */
 	[BPF_REG_FP] = A64_R(25),
+	/* callee saved register for the pointer to the stack in arena */
+	[BPF_REG_ARENA_SP] = A64_R(23),
 	/* temporary registers for BPF JIT */
 	[TMP_REG_1] = A64_R(10),
 	[TMP_REG_2] = A64_R(11),
@@ -430,6 +432,11 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	if (ctx->arena_vm_start)
 		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
 
+	/* subprogs get it from the caller and leave it as it was, unless the kernel calls them */
+	if (prog->aux->arena_stack_size &&
+	    (!bpf_is_subprog(prog) || prog->aux->arena_stack_entry))
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_ARENA_SP];
+
 	ctx->nr_used_callee_reg = i;
 }
 
@@ -2548,6 +2555,11 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
-- 
2.55.0

