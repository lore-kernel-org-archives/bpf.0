Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A8D79DE
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 03:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695183; cv=none; b=Ks7rxkfG1RWBJ0ChKZlN2DrT7ovhXA/nEnT2uA5DhQq9U3HZ7E37Zk04RpnGwgO6+eJkMVOMqjYOJWVNTWf0LWebvQ1d3RtVnrAwLTvBy3FiaeE3qwXghhL8uTRsCW1mzU4lJ03cerXmkd1JEIt22RFhlhMgO6e99wiAhiOhSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695183; c=relaxed/simple;
	bh=LmbIqjBvMiQoOk+bRCqbuhi1lqOUp9YREgd1Xtf/+RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjRfrboNtt7M/5gEeh0QX3WYB9boncyWGN0oftpM17edEkDWruL3C72oQ1N1dsBt2/rys0fWLu6cC9vHuY63XE3oL1bfEZHRmsHbXvm/CF8I3nzqaxAMpm3JsQXytRQo1c2zGhXiJYdW9Rpo1dHiBmtdjUU8U48d38OXRUwaaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phgv4wFT; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phgv4wFT"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214def5da12so3857511fac.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 19:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695180; x=1710299980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3g4pDfrGTsD340XQYwR0v4nnzNgvfyzWie+F6zzJmo=;
        b=Phgv4wFTVu+f2uL/TmzlTezGseofkFNjyoYe1tJPTdvUjpvN+VDjX6ipWMCNlKPVN7
         W812hyGavgDytBzMzwI0J0w3CQYMw9JoWZ1DnUusL/hmVggPJPx3AC1fUluyLCf6eT0X
         lTBo0qxBvz8z7NivrFUJ0tRdh8blLlnrIBGQ/U4qDhimKtJVDtF+0tmPdmE9TBPa1C+h
         weRtEIWfGO164cmFWzDx0SsXcqgS/aTEK8vLBOiGFxp8q5Y7RobCAVy8gkLdHQEx5MTs
         yFKfttdlEfyQuUVEIny7srpXGf6E0mwbspFIbk5nxwd37PaKewAXII5u5MRl4zqmTHm7
         aIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695180; x=1710299980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3g4pDfrGTsD340XQYwR0v4nnzNgvfyzWie+F6zzJmo=;
        b=gC58jeDtlQm5f96MjxpC3tH+wM3Qgj0sKPn6ZC+s/jWO2KB+HDUfaFD0h4JD2uE2Bm
         jB3pBTIXE9jfypbf/0qGg/iNtI+7ClaqqCDhHpGyNdWThBpjX3xj2SrvCQBQxj444Lrt
         TervWx50qgs+NSXC8gPzVZAo5ptf0tCYKz6qbr969QM7n+C8GjaUApNRbFEvEZk10Civ
         5qRYChD68PxkSgQwXTO2EFait10kd0Q4YlTCOitV0ihDpfbddbP39iyTQFFaoxo2DuD3
         VpXnXb+Hr2VvHjfUZ9QXIwrYY6d/gm7FdxFONbFnxuOXuQfhRwxf1AFV/QcleRwHwlkU
         2hqQ==
X-Gm-Message-State: AOJu0YzbSqiDDG/nEdDqL+AzORFHCm+E3t2b+VXAPURuKWUnXU3tLEv6
	aLv/d8ePrbtDWE4P52pUnrlScdY/ZlvWoPJtg10IqjbXpL95jEdyqiB9D7KX
X-Google-Smtp-Source: AGHT+IGOYbSjctTzc9N9iMq1j0abbNRGjRqj+iszp4Gz4rrlqJLHTlo6UxQbDpx6hpU2RGgOcaG9Sg==
X-Received: by 2002:a05:6870:2113:b0:220:87bb:cadd with SMTP id f19-20020a056870211300b0022087bbcaddmr4051544oae.16.1709695179515;
        Tue, 05 Mar 2024 19:19:39 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:52ad])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00188e00b006e55f6cd7fesm9639998pfh.137.2024.03.05.19.19.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:19:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v6 bpf-next 1/4] bpf: Introduce may_goto instruction
Date: Tue,  5 Mar 2024 19:19:26 -0800
Message-Id: <20240306031929.42666-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce may_goto instruction that from the verifier pov is similar to
open coded iterators bpf_for()/bpf_repeat() and bpf_loop() helper, but it
doesn't iterate any objects.
In assembly 'may_goto' is a nop most of the time until bpf runtime has to
terminate the program for whatever reason. In the current implementation
may_goto has a hidden counter, but other mechanisms can be used.
For programs written in C the later patch introduces 'cond_break' macro
that combines 'may_goto' with 'break' statement and has similar semantics:
cond_break is a nop until bpf runtime has to break out of this loop.
It can be used in any normal "for" or "while" loop, like

  for (i = zero; i < cnt; cond_break, i++) {

The verifier recognizes that may_goto is used in the program, reserves
additional 8 bytes of stack, initializes them in subprog prologue, and
replaces may_goto instruction with:
aux_reg = *(u64 *)(fp - 40)
if aux_reg == 0 goto pc+off
aux_reg -= 1
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

may_goto works well with arena pointers that don't need to be bounds
checked on access. Load/store from arena returns imprecise unbounded
scalar and loops with may_goto pass the verifier.

Reserve new opcode BPF_JMP | BPF_JCOND for may_goto insn.
JCOND stands for conditional pseudo jump.
Since goto_or_nop insn was proposed, it may use the same opcode.
may_goto vs goto_or_nop can be distinguished by src_reg:
code = BPF_JMP | BPF_JCOND
src_reg = 0 - may_goto
src_reg = 1 - goto_or_nop

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h   |   2 +
 include/uapi/linux/bpf.h       |   5 +
 kernel/bpf/core.c              |   1 +
 kernel/bpf/disasm.c            |   4 +
 kernel/bpf/verifier.c          | 163 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |   5 +
 6 files changed, 150 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 84365e6dd85d..4b0f6600e499 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -449,6 +449,7 @@ struct bpf_verifier_state {
 	u32 jmp_history_cnt;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
+	u32 may_goto_depth;
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
index a241f407c234..85ec7fc799d7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JCOND	0xe0	/* conditional pseudo jumps: may_goto, goto_or_nop */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
@@ -50,6 +51,10 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+enum bpf_cond_pseudo_jmp {
+	BPF_MAY_GOTO = 0,
+};
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 71c459a51d9e..9ee4536d0a09 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1675,6 +1675,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JCOND] = true,
 	};
 #undef BPF_INSN_3_TBL
 #undef BPF_INSN_2_TBL
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 49940c26a227..82b2dbdd048f 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -322,6 +322,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		} else if (insn->code == (BPF_JMP | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) goto pc%+d\n",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
+			   insn->src_reg == BPF_MAY_GOTO) {
+			verbose(cbs->private_data, "(%02x) may_goto pc%+d\n",
+				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) gotol pc%+d\n",
 				insn->code, insn->imm);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4dd84e13bbfe..8030b50d3b45 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -533,6 +533,16 @@ static bool is_async_callback_calling_insn(struct bpf_insn *insn)
 	return bpf_helper_call(insn) && is_async_callback_calling_function(insn->imm);
 }
 
+static bool is_may_goto_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
+}
+
+static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
+{
+	return is_may_goto_insn(&env->prog->insnsi[insn_idx]);
+}
+
 static bool is_storage_get_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_storage_get ||
@@ -1429,6 +1439,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
+	dst_state->may_goto_depth = src->may_goto_depth;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -14871,11 +14882,36 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	int err;
 
 	/* Only conditional jumps are expected to reach here. */
-	if (opcode == BPF_JA || opcode > BPF_JSLE) {
+	if (opcode == BPF_JA || opcode > BPF_JCOND) {
 		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
 		return -EINVAL;
 	}
 
+	if (opcode == BPF_JCOND) {
+		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
+		int idx = *insn_idx;
+
+		if (insn->code != (BPF_JMP | BPF_JCOND) ||
+		    insn->src_reg != BPF_MAY_GOTO ||
+		    insn->dst_reg || insn->imm || insn->off == 0) {
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
+		queued_st->may_goto_depth++;
+		if (prev_st)
+			widen_imprecise_scalars(env, prev_st, queued_st);
+		*insn_idx += insn->off;
+		return 0;
+	}
+
 	/* check src2 operand */
 	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
@@ -15659,6 +15695,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	default:
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
+		if (is_may_goto_insn(insn))
+			mark_force_checkpoint(env, t);
 
 		ret = push_insn(t, t + 1, FALLTHROUGH, env);
 		if (ret)
@@ -17135,6 +17173,13 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			if (is_may_goto_insn_at(env, insn_idx)) {
+				if (states_equal(env, &sl->state, cur, true)) {
+					update_loop_entry(cur, &sl->state);
+					goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
 			if (calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, true))
 					goto hit;
@@ -17144,6 +17189,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, true) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
+			    sl->state.may_goto_depth == cur->may_goto_depth &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
@@ -19408,7 +19454,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19428,7 +19477,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = 0; i < insn_cnt;) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
@@ -19467,7 +19516,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
@@ -19487,7 +19536,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
@@ -19502,7 +19551,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			aux = &env->insn_aux_data[i + delta];
 			if (!aux->alu_state ||
 			    aux->alu_state == BPF_ALU_NON_POINTER)
-				continue;
+				goto next_insn;
 
 			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
 			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
@@ -19540,19 +19589,39 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
+		}
+
+		if (is_may_goto_insn(insn)) {
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
@@ -19561,7 +19630,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta	 += cnt - 1;
 			env->prog = prog = new_prog;
 			insn	  = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
@@ -19609,11 +19678,11 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19642,7 +19711,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		if (insn->imm == BPF_FUNC_timer_set_callback) {
@@ -19754,7 +19823,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				delta    += cnt - 1;
 				env->prog = prog = new_prog;
 				insn      = new_prog->insnsi + i + delta;
-				continue;
+				goto next_insn;
 			}
 
 			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
@@ -19785,31 +19854,31 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -19837,7 +19906,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_arg inline. */
@@ -19862,7 +19931,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ret inline. */
@@ -19890,7 +19959,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement get_func_arg_cnt inline. */
@@ -19905,7 +19974,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_get_func_ip inline. */
@@ -19920,7 +19989,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 
 		/* Implement bpf_kptr_xchg inline */
@@ -19938,7 +20007,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
-			continue;
+			goto next_insn;
 		}
 patch_call_imm:
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
@@ -19952,6 +20021,40 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
+		i++;
+		insn++;
+	}
+
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int subprog_start = subprogs[i].start;
+		int stack_slots = subprogs[i].stack_extra / 8;
+
+		if (!stack_slots)
+			continue;
+		if (stack_slots > 1) {
+			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
+			return -EFAULT;
+		}
+
+		/* Add ST insn to subprog prologue to init extra stack */
+		insn_buf[0] = BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+					 -subprogs[i].stack_depth, BPF_MAX_LOOPS);
+		/* Copy first actual insn to preserve it */
+		insn_buf[1] = env->prog->insnsi[subprog_start];
+
+		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, 2);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = prog = new_prog;
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a241f407c234..85ec7fc799d7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -42,6 +42,7 @@
 #define BPF_JSGE	0x70	/* SGE is signed '>=', GE in x86 */
 #define BPF_JSLT	0xc0	/* SLT is signed, '<' */
 #define BPF_JSLE	0xd0	/* SLE is signed, '<=' */
+#define BPF_JCOND	0xe0	/* conditional pseudo jumps: may_goto, goto_or_nop */
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
@@ -50,6 +51,10 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+enum bpf_cond_pseudo_jmp {
+	BPF_MAY_GOTO = 0,
+};
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.43.0

