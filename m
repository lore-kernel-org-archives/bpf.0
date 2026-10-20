Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519319;
	b=0t0Fykw0re5DfSUKfzmFaIs6yqI25q0yP9jnmWnMhIQnWa0VQ8gsC0ynv1KxQQEPkZW/
	 AjfhJ9Dow3osGRhpETFqxrheW7r3asitWp4ubCWBOm4x/fC7u8N6Bm1NHBjHN14OOGlhT
	 DwUvNIpWcJTf6JfJJYXE3M5EZIn5/h6pj1uxFxRU7/k8dtySJFPyX2x4tvPDRFjC/C2LP
	 +dek56MhcIXFWJe7I6reHn9YvEWsiCObpauINNmL/WJjDVTXjW+YjIsYoJgPnZJ3xWkfJ
	 m1xeXL+079UkQ/BOunLhpOBHuem0x38xqzVBUntnLV7dUjw4LMmLchaqwgkkYmckRig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=nSaGp8JVs6QUwiBa5iidywBjHQeTkwHxRSjvAp43n2s=;
	b=L0AQq6Jla5gQQleQ7nlUPr0Jo22mPhNzUH7jgWLIY1y7lV5L6K0ZOzJOKHtfkZ7XKTAr
	 235G0WKcZfidHPAtDsWXUWlXiHg+a+RtDqXRXuqLp6kFEtOn1C++6YS4z4mEVGkfCAjVy
	 yNtOAk+9dnYvVAnRyowykveGpgnf63AtUT1W7dpNHxfWifkKu3jixtbysOneCRSiJZu5p
	 I+Jhwcv78at/KTzEdpsPsOlBkqB0IWbALUoH1PWthppOCYr3dF6WoAuVvNWeWlU6ud4Ax
	 0AXkqKaxOSDrDqttiYV5HXiArgpYOy8xC+5XXZFqXzAvDqU8Pd02zIfVEjl3nnDeqlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JjoQoFCG;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DB606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 300DB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JjoQoFCG
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso10347845e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519317; x=1793124117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSaGp8JVs6QUwiBa5iidywBjHQeTkwHxRSjvAp43n2s=;
        b=JjoQoFCGEK/61w63JQ7wq3wKIOUgZG6M4tWfLEn1uLwlYoaAiGiTBJ86iM6y6efnof
         77SVHnEjUm95Jzr08lgcSTyffsLmB6y6uSeUrOp/HV8qJzWSXijgzeV7/5Bou/dMta6n
         VcsjEdNujAekSj+9gW218KmpBiRAvI0UxL5r/BpY0YzkMsgN/UPRRSmfsFkE9X1YjIVO
         rVmrrwFaLtLlYzzg8THdlSIrtKbGCcRyqZJIuvainANkgG9TQ6npswXYwZdwlM+8gr2v
         xUMqzSlcF/bVkOi1oux8MQU7AR8lzRa1WzSLVRjtqcEhmg6Bu/79KveDOs8cNO+eWG7o
         GpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519317; x=1793124117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSaGp8JVs6QUwiBa5iidywBjHQeTkwHxRSjvAp43n2s=;
        b=FblK5Kpqwy203rvWaWDPFWEQM0/xsUlhBF6UXwgAiasjhLZnOLu+D/x0Wh/1zvFMtJ
         4NDTlRlm8GKWXwLwbds9R7+Suzkj58yOMGRIIT1LJ9DvcfDfgQhvk7YgWgBEHp0RE9Om
         1SDdf8DUxpcWadzLLnWdaV419wCpri2FdhHOReAjGnYK3BFh1nDfgV0iw1Ex/1S1bElY
         gTwHlhOLKYulnJQmLV7e0ay2MHr3ZIClf2fFIwqRPF4fUi6ekl5bN361L3uRLa0B1MWu
         Tf8TgTHLtcRqOGY22+jeWcu7KpTbE0mzlegfo9JhIJQaFnLvp2jmehuoeU4V9zd523zC
         QDPg==
X-Gm-Message-State: AFq9FYJ5glVGOO5L6H+2DiUYRzh+lfQg8AfpLbW5pd62fyoHNiyl7Loy
	bwzqgWEyy6WCarmWd4jq+xXp7Y4BACVuZSU0Wq4GcyTbjqLpwDz7iNrqx6xH6V8q
X-Gm-Gg: AYBFou0mptr2YW3CkcYtkZe4VvtOVL8OcsKC7qw+Z6xrv+FrMlR9GkpZaycaBQxu1Uz
	TM6n9vTbSSEmxlIqDUtmY1iLoNW9NGHaIlD1tF7r/njhbpSfT7d8oJgN5xDZWtlHTs0QqlSAHcq
	36QO2JgYyrzAPYv666dbsbDpvdjNHcgaS9dXROicNj2LIBTQUtwER5kJXIQj4d52bFUbOw6FyBy
	VasSFWKVRn3LrAmN835p4WTAylYzQHJRPAAQVo/MG+uEPg+KF0Gvdbt4WWAUwiR5kAVsbLW02do
	/q6bCpbFA5AZvJ1XQi2aM+Fx++zlErMRYPYwS+ck/Kbz305ZjIUWV53U/sQk9xzwzMjLm6E8riu
	UpvvDahXiaZLRRircf+npE0F+kyo17xxVm9LfzI/L1c0VU2gfOVZudR2oYCQa3LXV9xKr6E0yHU
	xqdRr/h8UyDLAidhn4NLLrrDCfyxhpwxV/IRmtGAuXy4w/QfJ6FzWLye1lza5nuPigS6GBNA2cF
	bn+odXfvAKtoejfIHHivs/G63SoKV1Iuvg3kR0zZOmeP+mGFuRDDCjXZ0du4ATzX2b6D2i2MNS1
	/yKJ7Tkvr56FxuejEMWsn4otdEDQhstwo/CGSQ==
X-Received: by 2002:a05:600c:621b:b0:4a1:dfd4:9429 with SMTP id 5b1f17b1804b1-4a1dfd49552mr202926355e9.31.1792519317488;
        Tue, 20 Oct 2026 11:01:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb859326sm14330125e9.10.2026.10.20.11.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 4/6] bpf, x86: Add a native bpf_throw() entry that captures R6 to R9
Date: Tue, 20 Oct 2026 20:01:40 +0200
Message-ID: <20261020180147.1769873-5-memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3341; i=memxor@gmail.com; h=from:subject; bh=na8g/EzprpURQ9gLEurYDm3U555dPhSidfQknqt89Is=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6ikcad8JF0+fpsRfraO6c/ie2g1k4Vz0hfGOBz9LpP WJtjL0dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMikXQz/KyfL11ncirV9mSvf VzzR6auUQIKjlHBaedENDZ19aRl5jAwvZgtKbSrhk1daXrh37bRmfodORr7VWy58WxSZkbDtZC4 LAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add bpf_throw_entry, which the verifier calls in place of bpf_throw(). It
saves R6..R9 to the stack in the layout of struct bpf_throw_regs, passes
the cookie from R1 and calls bpf_throw_unwind(), which does not return,
so a ud2 follows the call.

The JIT calls the entry directly through __bpf_call_base + imm, so it
needs no ENDBR. objtool generates ORC for its frame, so the stack walk of
bpf_throw_unwind() passes through the entry to the BPF frames, where the
frame pointer fallback of the ORC unwinder takes over as before.

The entry calls bpf_throw_unwind(), which is built with the syscall, so
it is built with CONFIG_BPF_SYSCALL as well and the JIT returns it only
then. The JIT itself builds with CONFIG_BPF_JIT alone, for cBPF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/Makefile       |  1 +
 arch/x86/net/bpf_jit_comp.c |  8 ++++++++
 arch/x86/net/bpf_throw.S    | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 arch/x86/net/bpf_throw.S

diff --git a/arch/x86/net/Makefile b/arch/x86/net/Makefile
index dddbefc0f439..daef0aa8b28c 100644
--- a/arch/x86/net/Makefile
+++ b/arch/x86/net/Makefile
@@ -7,4 +7,5 @@ ifeq ($(CONFIG_X86_32),y)
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
 else
         obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
+        obj-$(CONFIG_BPF_SYSCALL) += bpf_throw.o
 endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2d7495438d18..1a865313d09e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -5171,6 +5171,14 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp
 #endif
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+/* arch/x86/net/bpf_throw.S, which calls bpf_throw_unwind(); both need the syscall. */
+void *bpf_arch_throw_entry(void)
+{
+	return (void *)bpf_throw_entry;
+}
+#endif
+
 void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 			       struct bpf_prog *new, struct bpf_prog *old)
 {
diff --git a/arch/x86/net/bpf_throw.S b/arch/x86/net/bpf_throw.S
new file mode 100644
index 000000000000..c70a4002cc8a
--- /dev/null
+++ b/arch/x86/net/bpf_throw.S
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+
+	.code64
+	.section .text, "ax"
+
+/*
+ * Native entry of the bpf_throw() kfunc. The verifier retargets the call to
+ * bpf_throw() here, so the BPF register file of the throw site is still intact
+ * on entry. Capture its callee-saved registers on the stack as a struct
+ * bpf_throw_regs and hand it to bpf_throw_unwind(), which never returns.
+ */
+SYM_FUNC_START(bpf_throw_entry)
+	ANNOTATE_NOENDBR
+
+	/* Setup frame. */
+	pushq %rbp
+	movq %rsp, %rbp
+
+	/* Save R9..R6 so that [rsp + 8 * i] is saved[i]. */
+	pushq %r15	/* R9 */
+	pushq %r14	/* R8 */
+	pushq %r13	/* R7 */
+	pushq %rbx	/* R6 */
+
+	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
+	movq %rdi, %rsi
+	movq %rsp, %rdi
+
+	/* Emit call depth accounting for call below. */
+	CALL_DEPTH_ACCOUNT
+	call bpf_throw_unwind
+	ud2
+SYM_FUNC_END(bpf_throw_entry)
-- 
2.53.0

