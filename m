Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519321;
	b=C9eF4PDQgOMe/fQxHBazmw3uQqw4hFdh8FP94pvv7lTPu1tTVjHa8HWcwYJhc7JbVepc
	 QGLU0Sg0DFNJ2BGX/8vOqWl3JUwwy9WftYjGQBUMIqBdwq4aiBNUf7cH+FVZNprtvnvST
	 efEc23rE3FF5bLJlX3O98Zu7C2yBaBg0ETcArf9w1Sann3PllNF3yQDoVkKOOKG/054B0
	 PMgK/kcr+UyOtFcuP9hGuYlx1Kqlua4JgQzqDMJHSHH6n3MH9ECifY/fR5FAlWlAKY3Fj
	 oTwJspOMUFHPkcSuyll+n4nrINUHDukmYfJZlxQKIHcy+0VWs9JqvSvdDeYm1YKRnOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=WmfPyLABnAQ/2TikokWeXShkoBNb5cUtl//phQN76ok=;
	b=R9eSASDVx23o80L59SRjGRuuL8c8Lkgsa8OPGYAW+SBAT/lPP0CVxaSBvQVYdkK82cy5
	 TuJYxCxWp9x/pcBu8vcS49aoqP87+LUSvpLMJTb0V271SzmhwD9KXBkEq3BgHb9llPkHM
	 4AsC2U2crsP7Hru7V38mkyzVRQDkV6tcyIzokoOD8cKU3r5zsCFBSUuzW01bfi3nZ5bwb
	 8F5/+Pq+vdWNjfaIhR+a3PVVMR4paEUp4g/qsTLdSJz8T9VaC1j8rZd7KwFTGNFSoPUIs
	 Szk7XyuLMMRTSMoXHmeRk4LSbqgL5JkWO40VrTBJiHttOzDFFnkgqd5+VANf2aKU1qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qOife3p4;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80488606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80488606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qOife3p4
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a1f866310eso3799315e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519320; x=1793124120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmfPyLABnAQ/2TikokWeXShkoBNb5cUtl//phQN76ok=;
        b=qOife3p45I+4Ey1ZZXeDZss/l7UJ/vzZVUKCEA+ETD2yKTCzmblvFgWCiruzV4SCue
         cFANsqHKqAeod4fP4HnsUbWV/JYXN342th/SIZkid1DeZGqDQ14uL6uNuYHpPRDUfedO
         LGFNUyEN8W8Rk6BspzFYBUijWVAiX+jexg0+rvWg2i6igyzz6LnRi+oTSaaTbTCA++2Z
         6Rw4b3WnV9CrdGsKG3Wu0lLqkfyUBbFUC1TTuThgYxCpFyVz6acPJ6Wp1W4xDnKLuxVk
         8Zhsj2/twK/U04yCltqLJS2SW+luiMbydK/DpF0I2fjvKnE1xCEj9aiBBLvPO9LmzF38
         Axvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519320; x=1793124120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmfPyLABnAQ/2TikokWeXShkoBNb5cUtl//phQN76ok=;
        b=DptjVzsvaxqd5CozVugPNp6LFzS4D5M+6i3YdP6jyDyS4vLNfz0LNR6W9WMDaHMapa
         DTrVka+HuYeugSC9t9jBEeH4COI33eYdtoCkBhQkcbNEuu2fodnUFoM/qSQWFQ0pkY1m
         qjKv05KBvhB+la6SXKUkfzXfw8HOID38CZ5VUGMtlZIYNmuWPbh/6om1oi5D776eFC0F
         WVFAJCGErRh8pFnpgZtW3IdnNdlJ1huLpb5Dy1n18K9NLplMkeqRvz81FnyeXPVwWKjQ
         3gdB1KDnTsMQrGKENJol1byHgvXIeKB27J4CWGQQC2ke7G7quFi27LUnXyZxBXKWDCsW
         sZhA==
X-Gm-Message-State: AFq9FYLRd/5Kw9jl7Q8hyIxEf9aw86p67irBZtUh4SnPtjvAoZpXZbv3
	2EnMF6mv6/V3shU/B86lbl6WE0mr2oQuQGK/Y2A5qHOiomA8xXxJzvBE4Z34QVzp
X-Gm-Gg: AYBFou3mVIJ8LJWrUW074dBZrHpT+H3Pd3QVdqLsUghnPehzpP3VcH6eqqCDNbjNYhJ
	w0Z8V+2lqWMZY7DwN4gnBd5bHa7AfoskBHqTmMqkTJJPGzY4urWEWaVCRD3tL30f5gYNR0aI+23
	SyVYQVn32I41s09NdA3ad3QOlKv5qfQBerXDGk6DLfGpjS0n+xHD5cAnrjVhqkIEDIZl1sDWrXh
	HtjzK5P3k67Jjw8/Qm0XuoVev331YuENwJCXj6WRIvFHZPQqgqXQS9P9/tKTyh8JRe7McWh5biF
	s73lIJOSB7xDGduTYJzyYHKFrU0FAudKxgsSrjzqqH2SGyosFroiSUM60a8QPHjzmG3TXvaIe7k
	EI5XSrpgAURDstR+82lOFXpZzgthCPhF7d1ac2nrKgqT+TC2gkwazSE7sw8pghAUVUkC0Br+3T9
	aruE4rdpFPOPN/cqPZY7v/Ym08lAHYL88XfNtoXb8p9GoYDQxdegVCsPk5OY19klKwUMbMklHMJ
	pzCbLiu3iWN/gbNtcn4aXDSfnU/GloIlOmQPy9KA2Fh5RSu7/j+opQeyT02JImxb9f1OgFKWB2J
	MI/fhRCDBf1bYQdgWtKkxLxyOpNTcaTZ3d0ymw==
X-Received: by 2002:a05:600c:3b17:b0:4a1:7c7d:8881 with SMTP id 5b1f17b1804b1-4a1d76139ffmr264007505e9.13.1792519319652;
        Tue, 20 Oct 2026 11:01:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0a2sm16685f8f.10.2026.10.20.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] bpf, arm64: Add a native bpf_throw() entry that captures R6 to R9
Date: Tue, 20 Oct 2026 20:01:41 +0200
Message-ID: <20261020180147.1769873-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020180147.1769873-1-memxor@gmail.com>
References: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=memxor@gmail.com; h=from:subject; bh=m8kMnQEHU22Kmf1gh3oU/JTvNm7INsBh0HZXD9w7lkI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6ikczTOecmqv/+HSB5scmxf/6kcLzc37bXnyuoigy+ 07mQnaTjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE9j7DH24bo61TnBe3b5NM f3a2TnxTHUM263Ob32LFHs61TCsa2xn+2WqYWbtFHpEv/Xc5Pkrp/d4J7xXX9CRWps1+tSrjruQ VHgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Give arm64 the native entry of bpf_throw() that x86-64 has: the verifier
retargets the call to bpf_throw() to bpf_throw_entry(), which pushes a
frame record whose return address is the one into the program and saves
R6-R9 of the throw site, x19-x22, below it as a struct bpf_throw_regs,
then calls bpf_throw_unwind() with it. Nothing consumes the registers
yet.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/Makefile       |  1 +
 arch/arm64/net/bpf_jit_comp.c |  8 ++++++++
 arch/arm64/net/bpf_throw.S    | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 arch/arm64/net/bpf_throw.S

diff --git a/arch/arm64/net/Makefile b/arch/arm64/net/Makefile
index 3ae382bfca87..70d18f067d01 100644
--- a/arch/arm64/net/Makefile
+++ b/arch/arm64/net/Makefile
@@ -3,3 +3,4 @@
 # ARM64 networking code
 #
 obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_throw.o
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6a99f883a091..cc0ee9b3726b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/bpf_throw.h>
 #include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
@@ -3499,6 +3500,13 @@ bool bpf_jit_supports_timed_may_goto(void)
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+void *bpf_arch_throw_entry(void)
+{
+	return (void *)bpf_throw_entry;
+}
+#endif
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
diff --git a/arch/arm64/net/bpf_throw.S b/arch/arm64/net/bpf_throw.S
new file mode 100644
index 000000000000..aac1c5e967e1
--- /dev/null
+++ b/arch/arm64/net/bpf_throw.S
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+#include <linux/bpf_throw.h>
+
+/*
+ * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
+ * bpf_throw() here, so the BPF register file of the throw site is still intact
+ * on entry and x30 is the return address into the program. Push a frame record
+ * whose link register is that address and save R6-R9, x19-x22, below it as a
+ * struct bpf_throw_regs: saved[i] sits at [sp + 16 + 8 * i]. Then hand it to
+ * bpf_throw_unwind(), which never returns.
+ */
+SYM_FUNC_START(bpf_throw_entry)
+	stp	x29, x30, [sp, #-(16 + BPF_THROW_REGS_SIZE)]!
+	mov	x29, sp
+	stp	x19, x20, [sp, #16]
+	stp	x21, x22, [sp, #32]
+
+	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
+	mov	x1, x0
+	add	x0, sp, #16
+	bl	bpf_throw_unwind
+	brk	#0x1
+SYM_FUNC_END(bpf_throw_entry)
-- 
2.53.0

