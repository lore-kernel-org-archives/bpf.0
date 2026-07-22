Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD9307AE3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726690; cv=none; b=sKA/NOMWAiLVE/iI6WGoRWzY0hisxzVsj/i8UeTx2nDo+XvNI4wNYb9p/Sz3FWtUKpWeoXokAc8o1bTV5mTqkIXAT3a5jwQVdORqJYaGxBWJ2h0ROXk+uvvMJAI4vb48Jn/C+CgIRgp5pnaQfbjPQdpb9CeBl3/9oy/aU+TlZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726690; c=relaxed/simple;
	bh=T1dgH0vxUqD8LHp3m8aNc+PjeuXiRWB6+T80Go2/guo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuDMo5g+QmL/rQNTdkd+aamT/KBP2qTqRhyAE1iSFIXG15EnbGxm54tVWYH9jQedzjtq7wB31B00vg5sQ3g9+BSKk/n2oQ0ZoWZ+fyiCAeh5eq68ChMxH67nwmwXISS3a1X7uz5z7SeT4cpkIJuNbjEBjq5zseFnwt8nJnQm/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU0KoPsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU0KoPsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704B91F00A3A;
	Wed, 22 Jul 2026 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726688;
	bh=+wjcMbQJcgUadXbW/bsR4aDjKHJ1cZINNiDcQt8xu8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MU0KoPsxtBc9yYY+YQnW0qqMYjpfkDGerzfYOfTus1cbBYVl2ghW9IZR7hhHhmp+k
	 bIj1qmjO/tr45iFvvMmGnbV38PsQy0CxJKYuX+mIzGftomyzyBUfq0FRTyT+cqob1a
	 aG0towOZw9Y1Cr/H3x8EtZ2L9y3eOXVyBW19hN/JlLm0ug2c8oZigaNEORWhx3Nc0Z
	 TAYwbqrl1qrCkNfJvwXTBuyRmPgUl8VmwIsNa0rqziJ5zq0KDNWKEKRux5uTKKsTeW
	 Y7IXKtZNIbIdXT0C6Rpbs2AGeFNrV0/nNtbw95k9fXncSO2s9/QPSs0wEPUttM1zA1
	 86WovPZ2U5JUg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 4/6] bpf: Elide range checks when inlining bpf_iter_num_new() for constant bounds
Date: Wed, 22 Jul 2026 06:24:19 -0700
Message-ID: <20260722132424.450230-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
References: <20260722132424.450230-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_for() is frequently used with constant bounds, e.g. bpf_for(i, 0, N)
with a literal N. In that case bpf_iter_num_new()'s start > end and
range > BPF_MAX_LOOPS checks, and their error paths, are decidable at
verification time and need not be emitted at all.

Record, per call site, whether both the start and end arguments are
constant with the same value on every visit, mirroring the state tracking
bpf_loop() inlining already does. check_kfunc_call() stores this in
bpf_insn_aux_data; the multi-visit merge matters because the same call
site can be reached with different constants on different paths, in which
case it falls back to the general sequence.

The fold relies on the exact constant values, so the start and end
registers are marked precise. Without that the verifier could prune a
path reaching the call with different constants before the merge above
sees it, and the folded code would run with a stale value.

When the bounds are known, inline_bpf_iter_num_new() folds the checks and
emits only the reachable tail: the iterator init for a valid range, or the
zeroing store plus the -EINVAL / -E2BIG result otherwise. The runtime
behaviour is identical to the general sequence and to the kfunc.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf_verifier.h | 13 ++++++
 kernel/bpf/verifier.c        | 76 +++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 682c2cd3b8443..8c04e2fd80170 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -612,6 +612,15 @@ struct bpf_loop_inline_state {
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
+struct bpf_iter_num_new_state {
+	unsigned int initialized:1; /* set to true upon first entry */
+	unsigned int fit_for_inline:1; /* true if start and end are constant
+					* with the same value at each call
+					*/
+	s32 start; /* valid when fit_for_inline is true */
+	s32 end;   /* valid when fit_for_inline is true */
+};
+
 /* pointer and state for maps */
 struct bpf_map_ptr_state {
 	struct bpf_map *map_ptr;
@@ -661,6 +670,10 @@ struct bpf_insn_aux_data {
 		 * the state of the relevant registers to make decision about inlining
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
+		/* if instruction is a call to bpf_iter_num_new this field tracks its start/end
+		 * arguments to make a decision about eliding the range checks when inlining
+		 */
+		struct bpf_iter_num_new_state iter_num_new_state;
 	};
 	union {
 		/* remember the size of type passed to bpf_obj_new to rewrite R1 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dec6bcba53a22..d5b73ae801944 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12962,6 +12962,47 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
 
+/*
+ * bpf_iter_num_new() can be inlined more tightly when its start and end arguments are constant,
+ * as the range checks and their error paths can then be resolved at rewrite time. Record, per
+ * call site, whether both arguments are constant with the same value on every visit.
+ */
+static int update_iter_num_new_state(struct bpf_verifier_env *env)
+{
+	struct bpf_iter_num_new_state *state = &cur_aux(env)->iter_num_new_state;
+	struct bpf_reg_state *start_reg = &cur_regs(env)[BPF_REG_2];
+	struct bpf_reg_state *end_reg = &cur_regs(env)[BPF_REG_3];
+	bool known = tnum_is_const(start_reg->var_off) && tnum_is_const(end_reg->var_off);
+	s32 start = start_reg->var_off.value;
+	s32 end = end_reg->var_off.value;
+	int err;
+
+	if (!state->initialized) {
+		state->initialized = 1;
+		state->fit_for_inline = known;
+		state->start = start;
+		state->end = end;
+	} else if (state->fit_for_inline) {
+		state->fit_for_inline = known && state->start == start && state->end == end;
+	}
+
+	/*
+	 * While folding is still viable the decision relies on the exact constant values, so mark
+	 * the registers precise; otherwise the verifier could prune a path that reaches this call
+	 * with different constants and the folded code would run with a stale value.
+	 */
+	if (state->fit_for_inline) {
+		err = mark_chain_precision(env, BPF_REG_2);
+		if (err)
+			return err;
+		err = mark_chain_precision(env, BPF_REG_3);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -13163,6 +13204,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
+		err = update_iter_num_new_state(env);
+		if (err)
+			return err;
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
@@ -19774,10 +19821,34 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
  * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 and R3 hold the (int)
  * start and end arguments. Keep in sync with the kfunc in kernel/bpf/bpf_iter.c.
  */
-static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
+static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf, struct bpf_iter_num_new_state *state)
 {
 	int i = 0;
 
+	/*
+	 * When start and end are constant the range checks and their error paths fold away,
+	 * leaving just the state init or the error result.
+	 */
+	if (state->fit_for_inline) {
+		s32 start = state->start, end = state->end;
+
+		if (start > end) {
+			/* s->cur = s->end = 0; return -EINVAL; */
+			insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+			insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+		} else if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
+			/* s->cur = s->end = 0; return -E2BIG; */
+			insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+			insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
+		} else {
+			/* s->cur = start - 1; s->end = end; return 0; */
+			insn_buf[i++] = BPF_ST_MEM(BPF_W, BPF_REG_1, 0, start - 1);
+			insn_buf[i++] = BPF_ST_MEM(BPF_W, BPF_REG_1, 4, end);
+			insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		}
+		return i;
+	}
+
 	/* if (start > end) goto einval; */
 	insn_buf[i++] = BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8);
 	/*
@@ -19979,7 +20050,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
-		*cnt = inline_bpf_iter_num_new(insn_buf);
+		*cnt = inline_bpf_iter_num_new(insn_buf,
+					       &env->insn_aux_data[insn_idx].iter_num_new_state);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
 		*cnt = inline_bpf_iter_num_next(insn_buf);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
-- 
2.53.0-Meta

