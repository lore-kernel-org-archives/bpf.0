Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148298;
	b=CY1IgphIGw5QdXibdLZl82miPTrWa0uZN66/HxeWNed+bFZxL6uxfnln3fiJpqJrzU6W
	 IDbIaJk3Poja5FcZlfylNh2kRLSY1dsuSXjTnUMf07w2AiKHy0WsbyeYO4W0ukXPc2x6a
	 TPzUNm2j9kPLLySX56rcVHjjjL2s+BnZexzRm74KHYVVO0FAl94j87qNrzQ+hRG8OxTG5
	 WvR5eX82SiOvSwocMIwR6R7pJOwoSarL2KQhUmUKnNom5csIetm5rAlKxEK+H5AR2oad6
	 K/Bfywk45c4Kqpwvs7qiZRKLH46jeienB9XB45IzcW5O5feWQoX/nIJbs693xaoPt3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=V/Pn267RPewG0W/p9am9YVZxP5Y75eW6Dou0Odt3vhA=;
	b=G1Xj+hKhhfD/eMCdkCw3YMC8AJpeOdj9mzCKAq8/naZbxziSJ/dYqTaOSq68N1b/+3dX
	 3vKwPQCxhvYbEwRt3IljpUdCDDwjKzstAFXyqIE1G16ri70H8ZkLmt8LKomc1qQGo5dRh
	 eIk5wLuWiYx4tt6zUR1OPht8hym+aeCFqddht5+CpgrBrvt5kOHRSb5gBiSIBbpmQYx3a
	 39TA9PpkMiZieNVendFvf9C4jQw8cmQ5xPe7sAqsCNj9ajLk9hdhpTBgPtlL5kcep5e27
	 6YQfAU51E87bYj6X8mqWC4x+gcmEc4BsMwCbqkaupPv8HWYBHb43qfkugrnxEgpHmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vhRsNPUs;
	arc=none smtp.remote-ip=209.85.221.66
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45D606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F45D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vhRsNPUs
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so282188f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148297; x=1793753097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/Pn267RPewG0W/p9am9YVZxP5Y75eW6Dou0Odt3vhA=;
        b=vhRsNPUsagSVfR4U5DkmjmgRpxRcBaUscO6V2i4SttcpgQEixsrd+Qn5Pww1kuGYGV
         cckgxi472tQkwXmLSy35MJ8/rEGLIRnsYekbQJntneVwPHen2qi+RHXXkwzQ1t0H3vS2
         iU5YmU9gQUHGLdaqLVmM/wbvFI+Glgr8B2vtrFePUrDrV+GVRJB+nGHLfZ1Xxtd+DbIS
         7ezZY5rSh8MSj60My+kY4io3fnY+ZSEKBAmUn1A2uGizzJNCy5eotXdmGiHk7mVaHvFf
         sw2v8qs+lj/JUP3WjxRqmKO5Afc9mDjlmf5Fe7vrNM4EPtT/BKfKaVVee2lWE+GhfQee
         z1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148297; x=1793753097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/Pn267RPewG0W/p9am9YVZxP5Y75eW6Dou0Odt3vhA=;
        b=1Dyrpdu6qSpgg7yy1X6TZKKLi/82zLN89PstLf+jBZXyyCmHZ9+PvRerY/ig/fIkab
         I6BUL+F0Q8gv6lm+waJi8AqHv9epv33Qt2qGUY3/WV1CUjU5LU4CTSdber/SOJRTPrHS
         sZ1GHeYluEP8o7eut98sGbtnwziJC8bA5z4KLMe7zlw5fYN8tTyUMmMwlmMXI8W2vz+I
         m8jDPB90yUdNEiNX6MqtZZIrVPyQK1+fTuSfg7HvMuQ6S8eKO+zvhzKyHOF5D/dOdKYT
         jE//QLKaX0VXdsR7YempDt4lpwUg3ltGtnvixNUIPf9kAyVqoPhIIcQTuJm4JfiAgzs7
         lRtQ==
X-Gm-Message-State: AFq9FYIQW2Vh8Di4MMm5EFeBgbvuKYQJCfun8uQhPnQ6a9BT1lGKVPym
	7jj3+cYjaBCxy1e3ObeKDhga8H60GYXFtvowY+xppxU7G9NSP5ju1FoLlWtLDAoi
X-Gm-Gg: AYBFou2UIN+oJYGPPlpdnTsDRu4VMG+ROZ4HZcRB5IsGBXxZ42ai8N6P1PMz71Y9Tcf
	5k3fpIVGTedYWuuCsl5NRDJeVKeTGBJ5M21S263FY5QYmxNReOJulmnC+f3axcPQKVTEAyf3pvn
	jTxRnwI54xgNADfEGPqHetQiHmWO5esI5Jx7UCRD5uIp9YO+vDWDDuWYZqu+cNEQPZTQkfM9Ykl
	K+0mzownaQeMu09aBfHjGMVPqCVHLV/D5P0EWQkaXmm7qXZ6ANn5I6C6fG19D1u+pKzPgsYWT/I
	aJGiSv3tBVm3FeYvK8qlrK9NY/UHqDz9F2DUC5HbXmtvRG1FniKayUD9ovPy04j78XaB48eH6mr
	4v8fF3AUAso34Aipemym4V9QSpjK/XneNSvjR+kluWzkCEp4nbR3kfGthiE2WykWBtGd5TAeEVb
	x24PHVHkyZEp2wwN+MlohetXhZl0ascZqOUePX+0D+ErsW7eMutvxc38q5kPxbYosPDaU3/y9z9
	rrZIDjiZlrQN+qLdwAoymAUGLOr2iBYo/IGZm8CdcX4qMmLZVZMmgb/YytRsQ2q+sn/U+1mVopG
	kfHrB2Z6YZwyRUcjsrOiiRkJZHZfrEvESuT/pknAnGFufpUU5Zasq/fZQCPJ9+Pp2KDbphh2y8N
	e1DlfpzvKWy2WkWa77iI=
X-Received: by 2002:a5d:5f44:0:b0:48e:55bd:9ce2 with SMTP id ffacd0b85a97d-48e55bd9d56mr10370417f8f.20.1793148296675;
        Tue, 27 Oct 2026 17:44:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm24955378f8f.42.2026.10.27.17.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:56 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 04/11] bpf: Give the inlined bpf_loop a pad
Date: Wed, 28 Oct 2026 01:44:41 +0100
Message-ID: <a9599f7ed1c7bbb5109d2a9e2c7135af15045738.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5714; i=memxor@gmail.com; h=from:subject:message-id; bh=J0MfcYR8jSu8fiyxDsbQnQU7kwYzJzcmLcs2NSkzq/g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh47M3P7b94U3byq01vcTzb9yTy8vefKx1Us7Y27/27 C2BL4/9OkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRwFJGhv+KM94L7rjPrGR0 aautd7DZPwHhuF73p1+rj0y9Y8GaqsvIcPaz1Kcz+zMvWDOExV0ztZ5luvfqGb7d+p7MZ5iUfpm Y8AAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier inlines bpf_loop() when the flags are zero and the callback
is the same at every visit. Once the loop is BPF insns the caller of the
callback is BPF code, and the pad is the ordinary one: unwind_goto after
the call of the callback, which costs nothing, and a pad that restores
r6-r8 and jumps to the pad after the call of bpf_loop with the r0 of the
callback, the one the verifier checked with the state of that r0. The
unwind_goto that followed the call of bpf_loop follows no call anymore and
becomes a no-op jump.

Only a callback with unwind_exit gets the pad, and only when an
unwind_goto follows the call: a loop of no rounds never runs its
callback, so the verifier asked for none, and the insn after the call is
some other insn. The inlined loop of every other program is the one it
was. Nothing takes the pad yet: the callback of bpf_loop() is let unwind
next.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f062ef7dd943..94a379c94c67 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2836,6 +2836,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * When the callback can unwind and unwind_goto follows the call of bpf_loop,
+ * unwind_goto follows the call of the callback, and the pad restores r6-r8 and
+ * jumps to the pad after the call of bpf_loop with the r0 of the callback, which
+ * the verifier has checked with the state of that r0. The unwind_goto that
+ * followed the call of bpf_loop doesn't follow a call anymore and becomes a
+ * no-op jump. A loop of no rounds never runs its callback, so the verifier asked
+ * for no unwind_goto there, and the insn after the call is some other insn.
+ */
 static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 					int position,
 					s32 stack_base,
@@ -2848,6 +2857,8 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	int reg_loop_max = BPF_REG_6;
 	int reg_loop_cnt = BPF_REG_7;
 	int reg_loop_ctx = BPF_REG_8;
+	bool pad = env->subprog_info[callback_subprogno].can_unwind &&
+		   bpf_is_unwind_goto(&env->prog->insnsi[position + 1]);
 
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog;
@@ -2865,7 +2876,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	 */
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
 	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
-	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, pad ? 22 : 16);
 	/* spill R6, R7, R8 to use these as loop vars */
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
@@ -2877,17 +2888,20 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	/* loop header,
 	 * if reg_loop_cnt >= reg_loop_max skip the loop body
 	 */
-	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
+	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, pad ? 6 : 5);
 	/* callback call,
 	 * correct callback offset would be set after patching
 	 */
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
 	insn_buf[cnt++] = BPF_CALL_REL(0);
+	if (pad)
+		/* to the pad below when the callback left with unwind_exit */
+		insn_buf[cnt++] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, 7, 0);
 	/* increment loop counter */
 	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
 	/* jump to loop header if callback returned 0 */
-	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6);
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, pad ? -7 : -6);
 	/* return value of bpf_loop,
 	 * set R0 to the number of iterations
 	 */
@@ -2896,12 +2910,35 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
+	if (pad) {
+		/* over the pad */
+		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 4);
+		/* the pad: r0 is what the callback unwound with */
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
+		/*
+		 * To the pad of the caller, where the unwind_goto that follows
+		 * the patch goes. Its offset is known once the patch is in and
+		 * the jumps across it are adjusted, see below.
+		 */
+		insn_buf[cnt++] = BPF_JMP32_A(0);
+	}
 
 	*total_cnt = cnt;
 	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
 	if (!new_prog)
 		return new_prog;
 
+	if (pad) {
+		struct bpf_insn *unwind_goto = &new_prog->insnsi[position + cnt];
+
+		/* the jump of the pad, one insn before, takes the target of the unwind_goto */
+		new_prog->insnsi[position + cnt - 1].imm = unwind_goto->off + 1;
+		/* and the unwind_goto after the call of bpf_loop follows no call anymore */
+		*unwind_goto = BPF_JMP_A(0);
+	}
+
 	/* callback start is known only after patching */
 	callback_start = env->subprog_info[callback_subprogno].start;
 	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
-- 
2.53.0

