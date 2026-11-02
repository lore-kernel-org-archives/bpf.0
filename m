Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583038;
	b=oiPVYLrCUYPMGiwaQxTUA6LZ+hCTyiSQD+6Hgm4pjCa/VtT+G+QrMjb7tefBHEs+6lnL
	 fL1JhI3kZaEDiADil8FXgrDPWluI2D32G/+tzDgjSSq4rcjMgdP+NUCnqiX6jdiIsmVSO
	 rOQry84F9acCG8M26nlof3/ZstJ0Th3SBQ1n4VdQY+C37jL1XmZQUGw4/X1PLQprvJv6H
	 P54GKQvGYsnfLiCmH/IAxKbsls+QWGCYLLFDEZvJ3TSwD5InBveYamI4SgBh8lsqmAyOS
	 Hspg5LG89trfWB6HOx++X2LUNjRCrG5KQmPcU1VTZDZ/mBOKm4SAzS9O/6RoNfpe7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yme6eZ0Qmp1iHe0ra9POP2sWwXJoL20ve/O9f/VSlNE=;
	b=SKTMTcomeDzClTFxa+i9eD8Gfl5C9qlV3FFE6ZBV/buKliesZ8N0ChpOow5YKOhSZOj4
	 abQxpLdyocUt9JX95fTSnx+4EQ9njSHKT5sIy1yrw4PgZm08BCbH2u0QeoNM1FMf86IcT
	 jizPtDTClJ+RgIsbRosx4vKSlA5JGBNTuJYdtBZmWewiz8obNQiQUWOJhSOLWcf4RFljF
	 Uzgr28S3ewXLrQgfsBGWWFJTEJl++sFUoAc6YfRWrKeKIYBwD1CNj9GyNHwc0b4jvmEos
	 nAWJTxxavDu3OeKpyNfKbucwGYdt8yhQ66vs2siT0oCk7p6ZHZMqWvnoZdyd8gXhO7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="COzw0/Q+";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12B606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF12B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=COzw0/Q+
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so1708667a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583037; x=1794187837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yme6eZ0Qmp1iHe0ra9POP2sWwXJoL20ve/O9f/VSlNE=;
        b=COzw0/Q+TIxvL8fgDtUgEeDYGVmoc44sYn+37UE8wChSpdWHMdFYI4Fw22i6pjoeSD
         eUbL2csIoeEZRNPU2iHrQySuuFNEIbUTw3fpn1fr3QIM28+Lim76uHv/gbH1UAK1tS8Y
         47ML+xOL7lXf/PkQTzdwzlHZwHJ9isFcGYsL2dvBMDXsjZPwkkW5bEoFJQIbF6JsrHbp
         Dt34RQLfQpSrJOpXrhmReJvEZmNR2Os1pTbAShYqDxa50BDPAt6id25SVCJSxcwRPI8L
         wosXPi9fDbxwaS2S8eW6kH+ubtizlJWKHZpBxA5HL/bGL436wzWx9imKZ0+SEFieHHwS
         fapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583037; x=1794187837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yme6eZ0Qmp1iHe0ra9POP2sWwXJoL20ve/O9f/VSlNE=;
        b=22FrYMTt0CRyoP5YlZ3g9/r/TdiyTzso9B6Vr4hnYfEGIoB0OQYfcnU9f06t2hReNy
         cJ11XcCunkzrESN53sXmcaOvnBgbJ/udW00icysHqy7++KIc7ny3IGzV8eu24RyjOSZO
         qop1DMLNwvgXEKrBBcU0RxVtiXKG5ASjJu1uhWc3iG4M3ex/4JLHz83V7Oi6YjnFmqOD
         YRCKMHMfDtGMMcnavYu2UR3AuzOGow86yxz65ijsTtYC+rmVoqorizs6c4uzh6EbP0kP
         VMelrQymhqQG5D3LAq+QiHqYRFbZy0KbNG02SGpLBpMrCaS1sn9qdHBMdfrWf7MKBRqW
         Az/Q==
X-Gm-Message-State: APuU4Z/XTiYiIiUu3Dmw6gviT6kaGkQ6FEgwsV4fHa7sX7AGvhQNM4S2
	evijx0jL6AZc8rV2V6Rv82/sGmZV5DHoxH+5ekmDPryPpkyv62uUJS9hXJsPnQ==
X-Gm-Gg: AYBFou2TdYg6UgIj1D0iPazWULAo+p/WEZDT5I7zmZs2YFME+i/VgsVNF3q6NTZ4Yxc
	YqsQ8mmbMjUXdfSuJffwC3cITg0QjnEvzE2J7OxUaa/GcIpPeNmY7UUc+BGVV8NsN3HwB0qLmPA
	5PmuLfq4F38MhhJg/3iN2HQEE5tXQgpMaoAomt51n2trrqBTuMh35miZkjxxN7/1sHGmq03eb0m
	yv4H6QACZZRndt2CWIaou+13ZGjURbIyWjvJpTG2Ei89doDU7YimCVa5Si2bwqnHJC8KDXMFdku
	C7ZkiCgsZ1emreMOhSDtjYxYSOsW6dtKD2dKsKnagmiSLuOY5iWgdsNfwM2o0kvDEoqCMQ5qzxJ
	c+bqk5fPhXjrKlrIcRLbeftSj6ruh3YmvBRDXSStwBagmJKi6TvvHs3tQe15AkqCB1ug64iAnsq
	jNpI1/RonTe8npKkmJI/LS6arK89P57YwkI6DuJL2aO8nP/k8uOcJ02gNQuhSOYTZVxvrRC4xLP
	P5OKAEqRs+65VzeiOk1zikT0cupHYK8ycMWpy85mZjgs85LHz3h4hCsZiX8pyLZrH279eZm4mMt
	gAeLCmYdhMXvvNCVPA9Or9u/N+zS+/80spLfKMQ0s1fMv2FJreacuxZoI2FqnX21Bvs6OpHpHF+
	fe6EjxrPhuT/YmmVAKBFpcLaMt39XSbUCiSO3PCnQc5agFDUaIpXjH+9quGTswse1mikmO108Jg
	==
X-Received: by 2002:a17:90b:1f92:b0:3ad:4a8b:c701 with SMTP id 98e67ed59e1d1-3ae897b51a8mr7087332a91.45.1793583037179;
        Sun, 01 Nov 2026 17:30:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8441a6f0sm11636670a91.1.2026.11.01.17.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:30:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 09/13] bpf: Move the remaining verifier rewrites to the patch list
Date: Mon,  2 Nov 2026 01:29:36 +0000
Message-ID: <20261102012940.1756142-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
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

From: Qiliang Yuan <odys.yuan@gmail.com>

Three passes of the verifier call bpf_patch_insn_data(), which patches one
insn immediately. Each call costs O(N) in a prog of N insns.

Queue the changes in the patch list, and commit one time at the end of the
pass. The commit builds the new image of the prog from the old image and
the list. No insn moves before the commit. Thus a pass uses old indexes
only.

  pass                     what it does, and what is not mechanical
  -----------------------  ------------------------------------------------
  bpf_do_misc_fixups(),    It puts 1 or 2 stores in front of each subprog
  setup of the may_goto    that has may_goto. Use bpf_patch_list_insert().
  count                    A call of the subprog lands on the stores, and
                           a jump to its first insn lands on that insn.
                           Thus adjust_jmp_off() has no users. Remove it.
  add_hidden_subprog()     It puts the default exception callback behind
                           the last insn. The patch is that insn and the
                           new insns. Commit immediately, because the new
                           prog->len gives the start of the new subprog.
  bpf_optimize_bpf_loop()  It replaces a call of bpf_loop() with a loop of
                           19 insns. insn_buf[12] calls the callback, and
                           this call leaves its patch.

The new start of the callback is not known before the commit. Thus
inline_bpf_loop() writes the offset of this call as if this patch was the
only one. The commit adjusts it for the other patches.

  callback       offset of the call, for bpf_loop() at index i
  -------------  ---------------------------------------------
  in front of i  old start - (i + 12) - 1
  behind i       old start + 18 - (i + 12) - 1

18 is the growth of the patch, the number of insns that it adds.

What users can see:
 - A jump that gets out of range gives -ERANGE, and the message names the
   jump. Before this patch the passes return -ENOMEM, and the message names
   the patched insn.
 - A jump back to the first insn of a subprog keeps its offset when the
   stores go in front. Before this patch the offset first gets longer by
   their number, and adjust_jmp_off() then restores it. Thus an offset near
   -32768 fails the load.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 155 +++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 109 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 9216b19370c3..d0d099c34c80 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -738,44 +738,6 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
 	return 0;
 }
 
-/*
- * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
- * jump offset by 'delta'.
- */
-static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
-{
-	struct bpf_insn *insn = prog->insnsi;
-	u32 insn_cnt = prog->len, i;
-	s32 imm;
-	s16 off;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		u8 code = insn->code;
-
-		if (tgt_idx <= i && i < tgt_idx + delta)
-			continue;
-
-		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
-		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
-			continue;
-
-		if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			if (i + 1 + insn->imm != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->imm, delta, &imm))
-				return -ERANGE;
-			insn->imm = imm;
-		} else {
-			if (i + 1 + insn->off != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->off, delta, &off))
-				return -ERANGE;
-			insn->off = off;
-		}
-	}
-	return 0;
-}
-
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -1924,7 +1886,8 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
 	struct bpf_subprog_info *info = env->subprog_info;
-	int cnt = env->subprog_cnt;
+	int err, cnt = env->subprog_cnt;
+	struct bpf_insn *last;
 	struct bpf_prog *prog;
 
 	/* We only reserve one slot for hidden subprogs in subprog_info. */
@@ -1932,14 +1895,17 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 		verifier_bug(env, "only one hidden subprog supported");
 		return -EFAULT;
 	}
-	/* We're not patching any existing instruction, just appending the new
-	 * ones for the hidden subprog. Hence all of the adjustment operations
-	 * in bpf_patch_insn_data are no-ops.
+	/*
+	 * We're not patching any existing instruction, just appending the new
+	 * ones for the hidden subprog.
 	 */
-	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
-	if (!prog)
-		return -ENOMEM;
-	env->prog = prog;
+	last = bpf_patch_list_add(env, env->prog->len - 1, patch, len);
+	if (IS_ERR(last))
+		return PTR_ERR(last);
+	err = bpf_patch_list_commit(env);
+	if (err)
+		return err;
+	prog = env->prog;
 	info[cnt + 1].start = info[cnt].start;
 	info[cnt].start = prog->len - len + 1;
 	/* The patch ends with the exit. */
@@ -2011,7 +1977,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	const struct bpf_map_ops *ops;
 	struct bpf_insn_aux_data *aux;
 	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
@@ -2842,10 +2807,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
-		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
-		int subprog_start = subprogs[i].start;
+		int slots = bpf_jit_supports_timed_may_goto() ? 2 : 1;
 		int stack_slots = subprogs[i].stack_extra / 8;
-		int slots = delta, cnt = 0;
 
 		if (!stack_slots)
 			continue;
@@ -2855,6 +2818,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 
+		cnt = 0;
 		stack_depth = subprogs[i].stack_depth;
 		if (bpf_jit_supports_timed_may_goto()) {
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
@@ -2865,30 +2829,17 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 						     BPF_MAX_LOOPS);
 		}
-		/* Copy first actual insn to preserve it */
-		insn_buf[cnt] = env->prog->insnsi[subprog_start];
-		ret = bpf_adj_moved_insn(&insn_buf[cnt], cnt);
-		if (ret) {
-			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[subprog_start].orig_idx);
+		/* jumps to the first insn of the subprog skip the setup */
+		ret = bpf_patch_list_insert(env, subprogs[i].start, insn_buf, cnt);
+		if (ret)
 			return ret;
-		}
-		cnt++;
-
-		new_prog = __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
-						 BPF_PATCH_MOVE_TARGET);
-		if (!new_prog)
-			return -ENOMEM;
-		env->prog = prog = new_prog;
-		/*
-		 * If may_goto is a first insn of a prog there could be a jmp
-		 * insn that points to it, hence adjust all such jmps to point
-		 * to insn after BPF_ST that inits may_goto count.
-		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
-		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
 	}
 
+	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
+	prog = env->prog;
+
 	/* Since poke tab is now finalized, publish aux to tracker. */
 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
 		map_ptr = prog->aux->poke_tab[i].tail_call.map;
@@ -2909,11 +2860,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
-					int position,
-					s32 stack_base,
-					u32 callback_subprogno,
-					u32 *total_cnt)
+static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
+			   s32 stack_base, u32 callback_subprogno)
 {
 	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
 	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
@@ -2923,9 +2871,8 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	int reg_loop_ctx = BPF_REG_8;
 
 	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_prog *new_prog;
 	u32 callback_start;
-	u32 call_insn_offset;
+	struct bpf_insn *last;
 	s32 callback_offset;
 	u32 cnt = 0;
 
@@ -2951,9 +2898,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	 * if reg_loop_cnt >= reg_loop_max skip the loop body
 	 */
 	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
-	/* callback call,
-	 * correct callback offset would be set after patching
-	 */
+	/* callback call, the offset is set below */
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
 	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
 	insn_buf[cnt++] = BPF_CALL_REL(0);
@@ -2970,19 +2915,19 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
 
-	*total_cnt = cnt;
-	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
-	if (!new_prog)
-		return new_prog;
-
-	/* callback start is known only after patching */
+	/*
+	 * Note: insn_buf[12] is the BPF_CALL_REL instruction. Jumps and calls
+	 * out of a patch are relative to the patch placed at 'position': its
+	 * 'cnt' insns push what is behind 'position' down by cnt - 1.
+	 */
 	callback_start = env->subprog_info[callback_subprogno].start;
-	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
-	call_insn_offset = position + 12;
-	callback_offset = callback_start - call_insn_offset - 1;
-	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+	callback_offset = callback_start - position;
+	if (callback_start > position)
+		callback_offset += cnt - 1;
+	insn_buf[12].imm = callback_offset - 12 - 1;
 
-	return new_prog;
+	last = bpf_patch_list_add(env, position, insn_buf, cnt);
+	return PTR_ERR_OR_ZERO(last);
 }
 
 static bool is_bpf_loop_call(struct bpf_insn *insn)
@@ -3004,7 +2949,7 @@ static bool is_bpf_loop_call(struct bpf_insn *insn)
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
-	int i, cur_subprog = 0, cnt, delta = 0;
+	int i, cur_subprog = 0, err;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	u16 stack_depth = subprogs[cur_subprog].stack_depth;
@@ -3013,26 +2958,18 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		struct bpf_loop_inline_state *inline_state =
-			&env->insn_aux_data[i + delta].loop_inline_state;
+			&env->insn_aux_data[i].loop_inline_state;
 
 		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
-			struct bpf_prog *new_prog;
-
 			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
-			new_prog = inline_bpf_loop(env,
-						   i + delta,
-						   -(stack_depth + stack_depth_extra),
-						   inline_state->callback_subprogno,
-						   &cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta     += cnt - 1;
-			env->prog  = new_prog;
-			insn       = new_prog->insnsi + i + delta;
+			err = inline_bpf_loop(env, i,
+					      -(stack_depth + stack_depth_extra),
+					      inline_state->callback_subprogno);
+			if (err)
+				return err;
 		}
 
-		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+		if (subprogs[cur_subprog + 1].start == i + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			cur_subprog++;
 			stack_depth = subprogs[cur_subprog].stack_depth;
@@ -3043,7 +2980,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 
-	return 0;
+	return bpf_patch_list_commit(env);
 }
 
 /* Remove unnecessary spill/fill pairs, members of fastcall pattern,
-- 
2.55.0

