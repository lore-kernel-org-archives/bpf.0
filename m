Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B13FE5D
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614349; cv=none; b=d6OBhVWgD2fIFl58CuT0ZtAXDQ9pnPNDvXaejs3JanHq7k3sSsLoUlmRDBCQxnb1r+566Z1QnAQ+XRL2ptD3eC8Y2qcsPkWYAIQsFQRis53edpGSlD7jBgM+G5MbewsMls7P+v97VBy7Xmny6LPFFtKHxgyBiX3D0NHoWkYqLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614349; c=relaxed/simple;
	bh=DxgHdibrSRFHhMaVjVmU5nqJVai/ep/f6RuZp4OkJ+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPe2AofIXQScacNJTRiiIAVe32OUGORVn4XBmLyeWXqprryZonbLLmu1/YZxc41ReTYifrAm8TqAakqDV/7T4JMKYZdfdzaizE+Dv0jSIaLM3+8uRhD/RiMZXTDpQcGMeYPoaij3xVNqacnWNA0vUZScrUs6mETucmcNdZBQ3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx3U0BxN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx3U0BxN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6082eab17so1811792b3a.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709614346; x=1710219146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5G+DvvquklTF1213OQAnBXP3S9jFBHoAvfve7kaHGg=;
        b=Kx3U0BxNIG2knFdIUto5JS19aZ+wLl6SPm/XH/nOfDi9z/bYTu9Pw7g3QtX4SVrBvS
         5/NmYZmLNOk2LTt1l5/6DfrZ4sBLmquP3C9zNvR+1tc6Gn6Z+6JzpFWJNOZ27zlU+ty9
         JWL8E7Je+/6MwatYSrFP6SQ02JpdF+A9NKBeOoveRsepa/Mj1yiiIlmuVBjJWsXUTomO
         qtBYh97miBX0edFsYMMSi0G9fcCKJEZfj3VwM5ycIxBCnxbAXBHjFrthTUTnx7vjp5rn
         m/Mf+YLkNYt3jlG7S4KsjQQegVu//SyLNUz1pXYdtEw4nLyxAqi2+M10WwdnlJl4N9ZV
         fCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709614346; x=1710219146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5G+DvvquklTF1213OQAnBXP3S9jFBHoAvfve7kaHGg=;
        b=PShYoHIOrtndV8zhLuF+IS91oJbjBj6VYRtIpC9hu4JOrHi2V3VhQZe9h+3rPzoJxe
         6YWSs4TeoSB0CkNbY8HBNSm1LY6oKJC13fdaZnOY0r4D7daEzeAehypXlwBgY3TePBn0
         /FGweoxN5yQEI3KvZAktABzUl3fN5kEnTu0TX1HeMkGTbZFJuJUlQDzVu4bWe1eTCMXO
         WiWcSyddFIBI9Aqu1iB5ybWHt1EDPsc28H9BAgLhqPU6RC9lDOip5cY17vDlvezrRTVX
         FeLpvDZoDuQs0VbuHyRbkvky3ff5oqxRn4fL2EaHLqNlH4AyGVJLPt8UIL38xpOWmgcX
         efVQ==
X-Gm-Message-State: AOJu0YwAI2Y6WXSds9ZpnhXISSPI5d7mcV0QUlyHS69CHnw15PeuiePs
	GN/9WTBQvMsd1zwqnLC1OD3mLZBVyM6IhM078Pd+NJajDDJuMUu1KG9qfP22
X-Google-Smtp-Source: AGHT+IEyq4LoMAsDM2HD7zrAMrIKPirxpVhM11ney2MHFPjy3w/Q570CF6l+/mx1WbUVRI7uA2gRxg==
X-Received: by 2002:a05:6a00:22cc:b0:6e5:9031:9886 with SMTP id f12-20020a056a0022cc00b006e590319886mr11341244pfj.25.1709614345541;
        Mon, 04 Mar 2024 20:52:25 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id n18-20020a056a000d5200b006e4d2cbcac8sm8328001pfv.94.2024.03.04.20.52.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 20:52:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 1/4] bpf: Introduce may_goto instruction
Date: Mon,  4 Mar 2024 20:52:16 -0800
Message-Id: <20240305045219.66142-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce may_goto instruction that acts on a hidden bpf_iter_num, so that
bpf_iter_num_new(), bpf_iter_num_destroy() don't need to be called explicitly.
It can be used in any normal "for" or "while" loop, like

  for (i = zero; i < cnt; cond_break, i++) {

The verifier recognizes that may_goto is used in the program,
reserves additional 8 bytes of stack, initializes them in subprog
prologue, and replaces may_goto instruction with:
aux_reg = *(u64 *)(fp - 40)
if aux_reg == 0 goto pc+off
aux_reg += 1
*(u64 *)(fp - 40) = aux_reg

may_goto instruction can be used by LLVM to implement __builtin_memcpy,
__builtin_strcmp.

may_goto is not a full substitute for bpf_for() macro.
bpf_for() doesn't have induction variable that verifiers sees,
so 'i' in bpf_for(i, 0, 100) is seen as imprecise and bounded.

But when the code is written as:
for (i = 0; i < 100; cond_break, i++)
the verifier see 'i' as precise constant zero,
hence cond_break (aka may_goto) doesn't help to converge the loop.
A static or global variable can be used as a workaround:
static int zero = 0;
for (i = zero; i < 100; cond_break, i++) // works!

may_goto works well with arena pointers that don't need to be bounds-checked
on every iteration. Load/store from arena returns imprecise unbounded scalars.

Reserve new opcode BPF_JMP | BPF_JMA for may_goto insn.
JMA stands for "jump maybe", and "jump multipurpose", and "jump multi always".
Since goto_or_nop insn was proposed, it may use the same opcode.
may_goto vs goto_or_nop can be distinguished by src_reg:
code = BPF_JMP | BPF_JMA:
src_reg = 0 - may_goto
src_reg = 1 - goto_or_nop
We could have reused BPF_JMP | BPF_JA like:
src_reg = 0 - normal goto
src_reg = 1 - may_goto
src_reg = 2 - goto_or_nop
but JA is a real insn and it's unconditional, while may_goto and goto_or_nop
are pseudo instructions, and both are conditional. Hence it's better to
have a different opcode for them. Hence BPF_JMA.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/core.c              |   1 +
 kernel/bpf/disasm.c            |   3 +
 kernel/bpf/verifier.c          | 156 ++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |   1 +
 6 files changed, 134 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..917ca603059b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -449,6 +449,7 @@ struct bpf_verifier_state {
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
+	u32 may_goto_cnt;
 };
 
 #define bpf_get_spilled_reg(slot, frame, mask)				\
@@ -619,6 +620,7 @@ struct bpf_subprog_info {
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
 	u16 stack_depth; /* max. stack depth used by this function */
+	u16 stack_extra;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a241f407c234..932ffef0dc88 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JMA		0xe0	/* may_goto */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..ba6101447b49 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1675,6 +1675,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JMA] = true,
 	};
 #undef BPF_INSN_3_TBL
 #undef BPF_INSN_2_TBL
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..598cd38af84c 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -322,6 +322,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JMA)) {
+			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
+				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
 				insn->code, insn->imm);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4dd84e13bbfe..226bb65f9c2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1429,6 +1429,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
+	dst_state->may_goto_cnt = src->may_goto_cnt;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -7880,6 +7881,11 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool is_may_goto_insn(struct bpf_verifier_env *env, int insn_idx)
+{
+	return env->prog->insnsi[insn_idx].code == (BPF_JMP | BPF_JMA);
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -14871,11 +14877,35 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	int err;
 
 	/* Only conditional jumps are expected to reach here. */
-	if (opcode == BPF_JA || opcode > BPF_JSLE) {
+	if (opcode == BPF_JA || opcode > BPF_JMA) {
 		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
 		return -EINVAL;
 	}
 
+	if (opcode == BPF_JMA) {
+		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
+		int idx = *insn_idx;
+
+		if (insn->code != (BPF_JMP | BPF_JMA) ||
+		    insn->src_reg || insn->dst_reg || insn->imm || insn->off == 0) {
+			verbose(env, "invalid may_goto off %d imm %d\n",
+				insn->off, insn->imm);
+			return -EINVAL;
+		}
+		prev_st = find_prev_entry(env, cur_st->parent, idx);
+
+		/* branch out 'fallthrough' insn as a new state to explore */
+		queued_st = push_stack(env, idx + 1, idx, false);
+		if (!queued_st)
+			return -ENOMEM;
+
+		queued_st->may_goto_cnt++;
+		if (prev_st)
+			widen_imprecise_scalars(env, prev_st, queued_st);
+		*insn_idx += insn->off;
+		return 0;
+	}
+
 	/* check src2 operand */
 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
@@ -15659,6 +15689,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	default:
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
+		if (insn->code == (BPF_JMP | BPF_JMA))
+			mark_force_checkpoint(env, t);
 
 		ret = push_insn(t, t + 1, FALLTHROUGH, env);
 		if (ret)
@@ -17135,6 +17167,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			if (is_may_goto_insn(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, true)) {
+					update_loop_entry(cur, &sl->state);
+					goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
 			if (calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, true))
 					goto hit;
@@ -17144,6 +17183,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, true) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
+			    sl->state.may_goto_cnt == cur->may_goto_cnt &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
@@ -19408,7 +19448,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_insn insn_buf[16];
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
-	int i, ret, cnt, delta = 0;
+	int i, ret, cnt, delta = 0, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_extra = 0;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn patch[] = {
@@ -19428,7 +19471,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt;) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
@@ -19467,7 +19510,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
@@ -19487,7 +19530,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
@@ -19502,7 +19545,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i + delta];
 			if (!aux->alu_state ||
 			    aux->alu_state == BPF_ALU_NON_POINTER)
-				continue;
+				goto next_insn;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
@@ -19540,19 +19583,39 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
+		}
+
+		if (insn->code == (BPF_JMP | BPF_JMA)) {
+			int stack_off = -stack_depth - 8;
+
+			stack_depth_extra = 8;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+			insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
+			cnt = 4;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto next_insn;
 		}
 
 		if (insn->code != (BPF_JMP | BPF_CALL))
-			continue;
+			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
-			continue;
+			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
 				return ret;
 			if (cnt == 0)
-				continue;
+				goto next_insn;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -19561,7 +19624,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
@@ -19609,11 +19672,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				}
 
 				insn->imm = ret + 1;
-				continue;
+				goto next_insn;
 			}
 
 			if (!bpf_map_ptr_unpriv(aux))
-				continue;
+				goto next_insn;
 
 			/* instead of changing every JIT dealing with tail_call
 			 * emit two extra insns:
@@ -19642,7 +19705,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_timer_set_callback) {
@@ -19754,7 +19817,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				delta    += cnt - 1;
 				env->prog = prog = new_prog;
 				insn      = new_prog->insnsi + i + delta;
-				continue;
+				goto next_insn;
 			}
 
 			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
@@ -19785,31 +19848,31 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			switch (insn->imm) {
 			case BPF_FUNC_map_lookup_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_update_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_update_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_delete_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_push_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_push_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_pop_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_peek_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_redirect_map:
 				insn->imm = BPF_CALL_IMM(ops->map_redirect);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_for_each_map_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
-				continue;
+				goto next_insn;
 			case BPF_FUNC_map_lookup_percpu_elem:
 				insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
-				continue;
+				goto next_insn;
 			}
 
 			goto patch_call_imm;
@@ -19837,7 +19900,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_arg inline. */
@@ -19862,7 +19925,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ret inline. */
@@ -19890,7 +19953,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement get_func_arg_cnt inline. */
@@ -19905,7 +19968,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ip inline. */
@@ -19920,7 +19983,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_kptr_xchg inline */
@@ -19938,7 +20001,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
@@ -19952,6 +20015,39 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+next_insn:
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_extra = 0;
+		}
+		i++; insn++;
+	}
+
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int subprog_start = subprogs[i].start, j;
+		int stack_slots = subprogs[i].stack_extra / 8;
+
+		if (stack_slots >= ARRAY_SIZE(insn_buf)) {
+			verbose(env, "verifier bug: stack_extra is too large\n");
+			return -EFAULT;
+		}
+
+		/* Add insns to subprog prologue to init extra stack */
+		for (j = 0; j < stack_slots; j++)
+			insn_buf[j] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+						 -subprogs[i].stack_depth + j * 8, BPF_MAX_LOOPS);
+		if (j) {
+			insn_buf[j] = env->prog->insnsi[subprog_start];
+
+			new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, j + 1);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = prog = new_prog;
+		}
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a241f407c234..932ffef0dc88 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JMA		0xe0	/* may_goto */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
-- 
2.43.0

