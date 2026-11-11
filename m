Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374068;
	b=L36eJJhJCsA3IfIy6F1NthpleBj0gUi2TVMWw+35LMUiYRyZz45WH10Z7uL8L5++YBG8
	 62BwcF3TOcsk4eq3jDZvkQceO5SL9GlGotnZBa0n4ruKxOEGfXLuo1dtbkYJOppMW61ph
	 JkkpgkLTlzyHSb6+Yn/o01KNsI227c+xkr9yu0ttau6S61UjdSCh6ByT6KJ0x7h1LtQl+
	 j67SlB9BxslmsFwVO+/NDlb5ADB/N+YyJDWuzGp+brCG3R0dyX+RgkTet+ldn0JcuN0Hh
	 GGVgvfkdDyNsJ/8CSNew71c6w6f00gWw4f3EammNSeePBAYrA4GVU0WFXlH5kD54R5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=har0By6tZi7yOX3PxMCwY9Y1zNMOXRRHPwbDCEfPXcI=;
	b=AUNR4iUq6DVObI976gDW0dWZsJ98fUKvFGYjtUOELxuM7KqQ/+9eDP9AtWJBC60YTZrY
	 5M4mSCxMOtpK39A7395M1jtc5Y7CfGiRd46RVvPzSN9LGbvYciufKtMNUrFmyORtucIve
	 ijXaQTho6Yy6uQoAQvUBPNlAhLW/BVDPQb8LZEA4oC1ueMmw95GQGvMl5CmZHFDhly8AD
	 xNpRyNysyeMRwGSUfvKcwTlauuMZeji2C+9048GSxl1E0VjEK3ztHwsNHYNqBbnxrG97Q
	 ghRHNGNErIenOxDiqO2pp21ayQA9pTiVFh8qkUhmi8XSjVq81u2y2LVnC0P/Muwj2UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPRqW0ZJ;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F6606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF8F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPRqW0ZJ
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso16478685ad.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374067; x=1794978867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=har0By6tZi7yOX3PxMCwY9Y1zNMOXRRHPwbDCEfPXcI=;
        b=rPRqW0ZJvjkpP8rUhKmjQe3x5fr2USUo3dQ/+OWN5qC/7CAdmSUOYO4dDtRUT8HNuX
         x2p22NaueHDyMRrHsuPdGT0hs9keXL60+tY53UOVNYH5BNfmejL9vr9BanIEkqKs6ox2
         9hMKNFyZ6C9epVFmy/rda+LFuOGKwCQkblJNT0GNqh3ojo1zYv9MJDS9mhX5HVBFuaCK
         +JaxRLqnRy+Rzs6OM5QQKolqd4UykyEGLEaBqy/KotkwiuzCqc6FUR+IoBPmbLaHccZn
         vd4hQRnZZccOVpeHLg8kJ548ViCBetsont27l3XU9MMc9P7LyA8/Ni47RbRE9Rdn6CKU
         RVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374067; x=1794978867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=har0By6tZi7yOX3PxMCwY9Y1zNMOXRRHPwbDCEfPXcI=;
        b=cFWfz9gcdCq1DP90OLaODP53bchQaKdES6T/YsyFaN1MidAR3YP6UaYhcRbTLn998Z
         tmZ4YO0dNJ4cVfXLfgO2p1eRVQzDRwOKPlSHemMmti7t8IWODhi8HTt/hDAkLA3Etv2h
         uwUpbgj+yweHZsrfJPxZCJIsQbzQLETVssOjtp4G0NSwenFqbvBMTjzpmH2HaWYi9NQu
         hfijblm1GU4IMG8WwQsYHchBgC4UrO1sj3y6vxyjfbKl8qf4B2ts8NX6My4LB7XYPVP2
         s6+XLOwuRTTg9VEPB75pWaHDMBiVqAU45S8oUwzahtj/Zapm10TAhtEeAAeQXroqTTlr
         B3LQ==
X-Gm-Message-State: APuU4Z/Di4zmwwTXRvBNWHbjBTUt6GLqC7CS+qrJtu9uCT1fr2AyajWO
	hwQWfqpOYkWxBmGV/mPAOUuFpSwAsC61LuJ2lbkluKDzBL+R2B69qXBMgzNILQ==
X-Gm-Gg: AYBFou3Lab0f7qETdma34CX1qx/Obbc9i206Cb1X0WnuusKrcLUezZoA+WYVKk7JJ0P
	L2bwksq+YVJpghsWxlFB7NPN6GlF/KDOeK7Ov6ZV7Zh0oceoGY+CtFa/A9tZhE+5YKvWPAgtM9s
	BYXvAaR1wvwNjW0Jo6YRiLwD1hZ/AuRZBXXzIK7YuP+jxdUK3TTZhI5QgyuBPBr98/TiR6/8bJC
	MErAPPLK5l3GxC6XjUcIpAZ1bHH9RjcwcWYlORVhOOa7Ej/NjS0sbvRGu+VqjQKxtTA+6m6ySB9
	5GzsTd14Di8os5N2hr4sPzzwuEh1XpMn/VasMNENx19vvJVY6sv4FXny1BD60miIxPHe33lxeH/
	XMGyqxQwp7ksIF2dSEnkmxDPTGHpyV/qAI60ht+93kW5LKOh3HpMngdvvYNrrUAdGZBxFofS+aJ
	4jkblEBQCzVUbD5wZy3tNqdthHFd0n5GFg/pPnZWSQ35k5xj5wXnL+S5tXCjXMQzIevJSsk6338
	2hn7kbqFJ09Zs7ozHE2KhJFBcNsHX8aJtX1Ez5YcKPIQTMMJBz0wty+FFzcd84ipTdVFk3cd2x+
	YLxRI5AcNuzx92VTEFGWa1h0dnKG+mWeYEOcFZAr9DEdWVOetrmOMhkdQEPIFB9wIHrT7X9uuXD
	BPIn9ac6IIKKiggdD7YHxSahr0GhUL6BMfxVkIIcoEAfFMyTsO2uJo3JmyYOWnQXsRYzRPaNN1w
	==
X-Received: by 2002:a17:903:2a84:b0:2e5:54c6:e5c9 with SMTP id d9443c01a7336-2edd73f9573mr18430955ad.2.1794374066860;
        Tue, 10 Nov 2026 21:14:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e11e9asm16361205ad.74.2026.11.10.21.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:14:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/29] bpf: Compute scalar evolution expressions for whole subprogs
Date: Wed, 11 Nov 2026 05:13:18 +0000
Message-ID: <20261111051341.2800252-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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
index 5fb31d6be97e..a0324fbc875e 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -287,7 +287,8 @@ static int imm_expr(struct scev *scev, s64 value)
 
 /*
  * The insn at @idx defines @reg. Without its backedges and with nested loops collapsed the body is
- * acyclic: an insn executes at most once per iteration, so a def is one value per iteration.
+ * acyclic: an insn executes at most once per iteration, so a def is one value per iteration. A
+ * subprog is the outermost loop, which runs once.
  */
 static struct expr_def insn_def(int idx, u32 reg)
 {
@@ -767,6 +768,25 @@ static struct env *get_loop_env(struct scev *scev, int loop_header, int insn_idx
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
@@ -1337,7 +1357,7 @@ static int worklist_push(struct bpf_verifier_env *env, int loop_header, int idx)
 {
 	struct scev *scev = env->scev;
 	struct scev_worklist *worklist = &scev->worklist;
-	u32 tag = (u32)loop_header + 1;
+	u32 tag = loop_header + 2; /* -1 is a subprog */
 
 	if (scev->discovered[idx] == tag)
 		return 0;
@@ -1621,11 +1641,52 @@ static bool can_compute_loop_scev(const struct bpf_loop *loop)
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
@@ -1633,17 +1694,21 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
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
@@ -1662,17 +1727,30 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
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
@@ -1684,12 +1762,16 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
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
@@ -1713,8 +1795,12 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
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
@@ -1739,6 +1825,9 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 					goto out;
 			}
 		}
+		/* Reverse post-order: all predecessors came first, the env has no users any more */
+		if (!aux[start].need_scev)
+			free_loop_env(scev, cur_header, start);
 	}
 
 	err = 0;
@@ -2146,7 +2235,12 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
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
index cab2fe974d44..6d1b8542f801 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2377,12 +2377,14 @@ __naked __noinline __used static int returns_zero(void)
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

