Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206881;
	b=HXPlxLIBJHQBtrVhqdBj9OrjEZhMVXmVe0/arHvDQ9balebv584SExs46OgP4uuUTNMJ
	 57NyhUxgQHqHDPbfXLM0Rskup6NE91NdF6WrNoGVExhO9X7xLV1QU/I5VffvU8Kwwo/9d
	 Rz2hOTNzO8wxhbOFi7ZRL0OTcSYU0ehBhhl0PnCfrkdg76/HIXaQny3B+yha67vBxRISo
	 EhLGxoUPZy2sI5lBV9jpqJToFUIAPfNDi0nML4tCMCj2ckY/KB18EuudKxM97hSZcoI2T
	 Rn+uglqB0CBl1u76eKLZbTfE/Sw6iDBiRI/0rTePOcYv/O0U4AY9YT9yUQmranBEuBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Io8v30c4qg4IagvQK0XobufbdTXsQv1ihLRylzdmOUk=;
	b=ilJ/jkb/EoDLZApzildmVn5I7oNFSxUsIcIyEsl+EKyo17dnZb6EMJfsP4+h7SNbFp1o
	 9aUb9NQMw0cb5zO8EsrfJNj9/XANgfKfT+HvOvbLM1PzmAzbGV/vnKw88HhCgPoXANGRn
	 3zfJkvkcmLRGTiuzcdhDhc5iyuk9OtNjr0bonS5IinPRKRhD/+frVzn4XMkQwqkOUQFnH
	 v2BhIkGnRzPSp2AEJnLS2GKJrlSGZrOGn0ghLnmU/71ydH+2jNQEI02Icz/dkH4dAoDQp
	 gkLARQaPcoFtc2bu+Hf/0aD0Puloo0Q19huC0w9XgOs4THUUUeU0rUcsPMmqgHv5GJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ECjqmx9I;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB6606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ECjqmx9I
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so66769a91.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206880; x=1794811680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Io8v30c4qg4IagvQK0XobufbdTXsQv1ihLRylzdmOUk=;
        b=ECjqmx9IigTDBidzWeGFbVF+sHTnaXQnqnEgvIc3F9MZxXFqRhHOK1fJWxaPI3cZDM
         971w2ef/w1SdF5b922jbisL5cOOuG4zQD/3EosYqad2iQBKlfJFcgrjSEAHx6mMjxx9s
         oah9PPWqQPzxJ5wg1AJ4FPj+t/ojTW8KJyi+qPJeTA7zqrO9kvZHTET9nRmIMHW2/bo/
         ADk5gNeLEhq3XoteyXa3oBtA0mGlqCK6sH3EuTEoRs3fDoZMKBLjdfq1zkY6WVLt2v68
         +vZsRwXK+s7ZQ32XsR53/u6p6Ght7WikhnFttKFj0ThZqL39PGQD4/JZQ8YjRnaiq064
         p5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206880; x=1794811680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Io8v30c4qg4IagvQK0XobufbdTXsQv1ihLRylzdmOUk=;
        b=tx8XFCshRURHqoApz07QEKlZsDG6w0iS+ZIoASZAYjT90GB12OSmI/IImKeLzHjONx
         /cczLJE7P3ZA9V/eX8ViH7hasreNMmbyBlteLjpv8yeHrsNEJ5qnqLfWOPIbtR7KlbnM
         7dg4T0DOZqeFGmNzMjvSIUJvjNi3d2LkhlgH8ypwgDm+5gb+roTYQv4GWk3uprlQfKXc
         W2tig/im128n35+orqon4SZXvqS5QrpjOiC1FxLUHL19Itcp2YpAUasuz+TlwrrMDpyp
         xpTmo5D1+2dLyFD3RYtpashZCFxBT0OqIxJe0rSUWFZbTXoI7AAIdBQONxU+JTO5IxrR
         q/8A==
X-Gm-Message-State: APuU4Z9WOhx4Dv0FVAjeEhX2zovZovx4U6JbMflScyQHFMnTfSXmcalN
	q/v3iXtT12lrjVH73AkTANavV6NHLkmcq/PsMJagK5fZwmxrwci7eRkIH6eITQ==
X-Gm-Gg: AYBFou3NFAUHRL5xHQPosSFE8rzEpNbzGmqCbuR66+Ti5RFWoz8xiRW60QEz0Wd9NAF
	0wFSRDkUCmmYvytaMCVqg5tQ2eDxSpbZGspNrmNM/VIF/vnFvxyuBA7yMAhNzwHOJ7gdHlo2IpT
	WkSDcFbx/uqgGftuoRiwAg+cKw138Gt7I5DyY2Uj64BPVq3KYz/+f+g87dIK0xTQqnyLyHQjv5x
	wq8/XeAYYxlXt/U2viFPjkUP9tHC+uw2z9OSgd2DxzdC931xt2TGKQl7LoAt9CqhBdWllXFfGTw
	elmm8URQyotuCGEgsAJ/nV446rmnaEJujcsZsIycY59RN+O8zfQURyZJeLPLXKlt7rF8u9FjxeE
	MTuWj+nGucNg5No4J6Ufu2zMlSxmn3ABuwwCaJruZBegbZ9coeExE2HqR+Cb1UE/7OkrL8MkZim
	bSQb5cp9Ib9W/sfFa78tjCe2Hjb29foQ/1MTTodRjmPIdrOJOJOLXI5SUFmeNtrmALBXKp0RfeO
	F4KhgoKCUOJdA96n7CSLmDEBBLjMeXWRB/QXmP4OtUQaxDji71VoRJHJw7/BUYL49n4HH4fHbxy
	CTZVRV8QVqoLDEBZwT30WLYz+Iw755gB3Gw4w1oF61g8irW9gGCHZlwHBNTUvpaJTsKrgNspVbD
	0aCtzxbDDZKc6TwH5UgHH57PhyxY4GjgKON7CUn2PAUhoiPCdWgXAuKgN2O0u50ut8o69/G0yJA
	==
X-Received: by 2002:a17:90b:54c4:b0:3ab:36c4:b500 with SMTP id 98e67ed59e1d1-3b12d108881mr3183813a91.5.1794206879668;
        Sun, 08 Nov 2026 22:47:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc4dc537sm5891954a91.1.2026.11.08.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 07/26] bpf: Compute scalar evolution expressions for whole subprogs
Date: Mon,  9 Nov 2026 06:46:51 +0000
Message-ID: <20261109064715.2382452-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the patches that use scalar evolution at conditional
jumps. Expressions exist in loops only. Compute them for all code. They
have no users yet: no verdict changes, the prog below is still rejected.

	char *buf = bpf_map_lookup_elem(&map, &key);    /* 128 bytes */
	..
	p = buf + i;                                    /* i is a byte */
	if (i > 100)
		return 0;
	*p = buf[0];

The jump bounds i. p was computed before:

	invalid access to map value, value_size=128 off=255 size=1

That p is buf + i is a static fact: it holds on every path. Treat the
subprog as the outermost loop, which runs once: compute_scev_for_loop()
with -1 for the header. (REG r) is the entry value of r. A loop is a single
insn for the subprog, as a nested loop is for the enclosing one, so
join_successor(), topmost_nested_loop(), forget_non_invariants() and the
worklist work as they are. The body is acyclic: each basic block is visited
once, and a def is one value per call of the subprog. The prog above, from
the level 2 log after 'Computing SCEV for subprog at 0:':

	 2: r7 &= 255                      r7 is (& %r0.0 255)
	 8: call bpf_map_lookup_elem#1     r0 is %r0.8
	10: r6 = r0
	11: r2 = r6
	12: r2 += r7                       r2 is (+ %r0.8 (& %r0.0 255))
	13: if r7 > 0x64 goto pc+2

%r0.8 is the def of r0 by insn 8.

The verifier adds edges that the CFG does not have, see
bpf_head_guard_target(): from may_goto before a loop header, and from
a subprog that is out of budget to its last exit. Nothing is known on them:
join_added_edges() joins '?' at their targets, as bpf_compute_const_regs()
does. A subprog that has a loop with a truncated exit list is not analyzed:
the exits are the successors of the loop as a single insn.

The worklist is in reverse post-order: all predecessors come first. So the
env of a basic block, 2140 bytes, is freed when the block is done, unless
it starts with a header, a latch or an exit. That goes for loops too. Their
envs stayed until the end of bpf_check(), so memory goes down.

To load the selftests, Cilium, sched_ext, katran, bpfjailer and programs in
Rust the kernel spends 1.9 % more instructions (perf stat), and load time
goes up by 2 to 3 % (veristat). mem_peak of veristat goes down by 1.1 % for
the C programs and by 7.3 % for those in Rust.

reg_bounds.c looks for '18: (bf) r0 = r6' and ';' in the log. Scalar
evolution prints that for code outside of loops now, after 't'.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 130 +++++++++++++++---
 .../selftests/bpf/prog_tests/reg_bounds.c     |   5 +-
 .../selftests/bpf/progs/verifier_scev.c       |   4 +-
 3 files changed, 118 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fdeedba90d66..f47faeb0ba53 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -286,7 +286,8 @@ static int imm_expr(struct scev *scev, s64 value)
 
 /*
  * The insn at @idx defines @reg. Without its backedges and with nested loops collapsed the body is
- * acyclic: an insn executes at most once per iteration, so a def is one value per iteration.
+ * acyclic: an insn executes at most once per iteration, so a def is one value per iteration. A
+ * subprog is the outermost loop, which runs once.
  */
 static struct expr_def insn_def(int idx, u32 reg)
 {
@@ -766,6 +767,25 @@ static struct env *get_loop_env(struct scev *scev, int loop_header, int insn_idx
 	return e;
 }
 
+/* The env has no users any more */
+static void free_loop_env(struct scev *scev, int loop_header, int insn_idx)
+{
+	struct insn_envs *envs = scev->envs[insn_idx];
+	u32 i;
+
+	for (i = 0; i < envs->cnt; i++) {
+		if (envs->entries[i].loop_header != loop_header)
+			continue;
+		kfree(envs->entries[i].env);
+		envs->entries[i] = envs->entries[--envs->cnt];
+		break;
+	}
+	if (envs->cnt)
+		return;
+	kfree(envs);
+	scev->envs[insn_idx] = NULL;
+}
+
 static int replace_reg(struct scev *scev, struct env *e, u32 reg, int id)
 {
 	if (id < 0)
@@ -1315,7 +1335,7 @@ static int worklist_push(struct bpf_verifier_env *env, int loop_header, int idx)
 {
 	struct scev *scev = env->scev;
 	struct scev_worklist *worklist = &scev->worklist;
-	u32 tag = (u32)loop_header + 1;
+	u32 tag = loop_header + 2; /* -1 is a subprog */
 
 	if (scev->discovered[idx] == tag)
 		return 0;
@@ -1599,11 +1619,52 @@ static bool can_compute_loop_scev(const struct bpf_loop *loop)
 	return !loop->irreducible && !loop->nested_exits_overflow;
 }
 
-static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
+/* A loop is a single instruction for the subprog too: no exit list may be truncated. */
+static bool can_compute_subprog_scev(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	struct bpf_loop *loop;
+	int i;
+
+	for (i = sub->start; i < (sub + 1)->start; i++) {
+		loop = env->insn_aux_data[i].loop;
+		if (loop && (loop->exits_overflow || loop->nested_exits_overflow))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * The edges that the verifier adds, see bpf_head_guard_target(): bpf_insn_successors() doesn't have
+ * them. They leave all loops. The env at their source is not known: @cur_env is all '?'. So their
+ * target is a join point with a phi for every live register.
+ */
+static int join_added_edges(struct bpf_verifier_env *env, struct bpf_subprog_info *sub,
+			    struct env *old_env, struct env *cur_env)
+{
+	int i, t, err;
+
+	for (i = sub->start; i < (sub + 1)->start; i++) {
+		t = bpf_head_guard_target(env, i);
+		if (t < 0)
+			continue;
+		err = join_successor(env, -1, t, old_env, cur_env);
+		if (err)
+			return err;
+	}
+	return sub->bail_insn < 0 ? 0 : join_successor(env, -1, sub->bail_insn, old_env, cur_env);
+}
+
+/*
+ * @cur_header and @first are a loop header. Or -1 and the first insn of a subprog: the subprog is
+ * the outermost loop, which runs once. (REG r) is the entry value of r, the loops in it are single
+ * instructions.
+ */
+static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header, int first)
 {
 	struct scev_worklist *worklist = &env->scev->worklist;
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_loop *cur_loop = aux[cur_header].loop;
+	struct bpf_loop *cur_loop = cur_header < 0 ? NULL : aux[cur_header].loop;
+	struct bpf_subprog_info *sub = bpf_find_containing_subprog(env, first);
 	struct env *header_env;
 	struct scev *scev = env->scev;
 	struct bpf_loop *nested_loop;
@@ -1611,17 +1672,21 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 	struct env *old_env = NULL;
 	struct bpf_iarray *succ;
 	bool log_level2 = env->log.level & BPF_LOG_LEVEL2;
-	int s, i, err, idx, succ_idx;
+	int s, i, err, idx, succ_idx, start;
 	u32 r;
 
 	if (log_level2)
-		bpf_log(&env->log, "Computing SCEV for loop at %d:\n", cur_header);
+		bpf_log(&env->log, "Computing SCEV for %s at %d:\n",
+			cur_loop ? "loop" : "subprog", first);
+
+	if (!cur_loop && !can_compute_subprog_scev(env, sub))
+		return 0;
 
 	/*
 	 * For irreducible loops, and for loops nesting a loop with a truncated
 	 * exit list, just assume that everything is clobbered for now.
 	 */
-	if (!can_compute_loop_scev(cur_loop)) {
+	if (cur_loop && !can_compute_loop_scev(cur_loop)) {
 		header_env = get_loop_env(scev, cur_header, cur_header);
 		if (!header_env)
 			return -ENOMEM;
@@ -1640,17 +1705,30 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 		if (!old_env)
 			goto nomem;
 	}
-	header_env = get_loop_env(scev, cur_header, cur_header);
+	header_env = get_loop_env(scev, cur_header, first);
 	if (!header_env)
 		goto nomem;
 	setup_initial_loop_env(header_env);
-	err = worklist_push(env, cur_header, cur_header);
+	err = worklist_push(env, cur_header, first);
 	if (err)
 		goto out;
+	if (!cur_loop) {
+		/* no backedge overwrites it */
+		header_env->empty = false;
+		err = join_added_edges(env, sub, old_env, cur_env);
+		if (err)
+			goto out;
+	}
 
 	while (worklist->nr) {
 		idx = *min_heap_peek_inline(worklist);
 		min_heap_pop_inline(worklist, &worklist_cb, env->cfg.postorder_nums);
+		start = idx;
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			goto out;
+		}
+		cond_resched();
 
 		/* join_successor() maps nested-loop entries to their representative header. */
 		nested_loop = idx != cur_header ? aux[idx].loop : NULL;
@@ -1662,12 +1740,16 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			 */
 			if (log_level2)
 				memcpy(old_env, cur_env, sizeof(*old_env));
-			/* Pull the nested loop's stack-store base dependencies up. */
-			for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
-				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
-			/* And what its jumps depend on. */
-			for_each_set_bit(r, nested_loop->tested_regs, BPF_SCEV_REGS_NUM)
-				or_expr_regs(env, cur_env->reg2expr[r], cur_loop->tested_regs);
+			if (cur_loop) {
+				/* Pull the nested loop's stack-store base dependencies up. */
+				for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
+					or_expr_regs(env, cur_env->reg2expr[r],
+						     cur_loop->store_base_regs);
+				/* And what its jumps depend on. */
+				for_each_set_bit(r, nested_loop->tested_regs, BPF_SCEV_REGS_NUM)
+					or_expr_regs(env, cur_env->reg2expr[r],
+						     cur_loop->tested_regs);
+			}
 			err = forget_non_invariants(env, cur_env, idx);
 			if (err)
 				goto out;
@@ -1691,8 +1773,12 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 			for (;;) {
 				if (log_level2)
 					memcpy(old_env, cur_env, sizeof(*old_env));
-				collect_store_base_regs(env, cur_env, idx, cur_loop->store_base_regs);
-				collect_tested_regs(env, cur_env, idx, cur_loop->tested_regs);
+				if (cur_loop) {
+					collect_store_base_regs(env, cur_env, idx,
+								cur_loop->store_base_regs);
+					collect_tested_regs(env, cur_env, idx,
+							    cur_loop->tested_regs);
+				}
 				err = transfer(env, cur_env, idx);
 				if (err)
 					goto out;
@@ -1717,6 +1803,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 					goto out;
 			}
 		}
+		/* Reverse post-order: all predecessors came first, the env has no users any more */
+		if (!aux[start].need_scev)
+			free_loop_env(scev, cur_header, start);
 	}
 
 	err = 0;
@@ -2124,7 +2213,12 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		idx = postorder[i];
 		if (!aux[idx].loop)
 			continue;
-		err = compute_scev_for_loop(env, idx);
+		err = compute_scev_for_loop(env, idx, idx);
+		if (err)
+			return err;
+	}
+	for (i = 0; i < env->subprog_cnt; i++) {
+		err = compute_scev_for_loop(env, -1, env->subprog_info[i].start);
 		if (err)
 			return err;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 09f7930733be..c2079eb64201 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1290,7 +1290,8 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 		 *   18: (bf) r0 = r6       ; R0=... R6=...
 		 * Different verifier passes may print
 		 *   18: (bf) r0 = r6
-		 * as well, but never followed by ';'.
+		 * as well, but never followed by ';'. Except for scalar evolution:
+		 *   t   18: (bf) r0 = r6   ; r0 ... -> ...
 		 * The branches are in the log in the order the verifier looked at them.
 		 */
 		q = log_buf;
@@ -1299,7 +1300,7 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 
 			while (*s == ' ' || *s == '\t')
 				s++;
-			if (*s == ';')
+			if (*s == ';' && (q == log_buf || q[-1] == '\n'))
 				break;
 			q = s;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index de7679656831..939f49a4ebdb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2346,12 +2346,14 @@ __naked __noinline __used static int returns_zero(void)
  * A loop that the compiler unrolls in part has an exit for every 'break' and 'return' in every
  * copy of its body. How many there are says nothing about the number of iterations.
  * Scalar evolution takes a nested loop for one insn, and its exits are the successors of this insn.
- * The list of exits is not complete: the loop around has no formulas.
+ * The exit list is truncated: the enclosing loop has no SCEVs, the subprog is not analyzed.
  */
 SEC("xdp")
 __success __log_level(2)
 __msg("loop at 1, too many exits, too many exits of a nested loop")
 __msg("loop at 2, nested in 1, too many exits")
+__msg("Computing SCEV for subprog at 0:")
+__msg_next("Computing SCEV for subprog at {{[0-9]+}}:")
 __msg("loop header at 1, unsupported loop: too many exits of a nested loop")
 __msg("loop header at 2, header_count is [0..4] ")
 __naked void loop_around_301_exits(void)
-- 
2.55.0

