Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549A1DE8AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219468; cv=none; b=dLYbeFduBtJCdteTI90mSEtz+hFeGn6SAS3x8vA8s52AcvtaDbWE2oCcdM3vnRfpkYP/jk/Hg4Y55zKltxL98zYP2//21U9FTx3r2c0TqiyfdiAik/oZc+38YORZbmGIK76f23PNm8nbkvqQ7D5JRIGrDBm02ssv5kq+154A8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219468; c=relaxed/simple;
	bh=XtZdNvyqFDgc6EJAJVdCQlML+dIQSt0stG8CFt6rY1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2zlKgVqXWWemM50bvbdWDEKXZpZdN3qIHkNpoTOJ/9lxtAKTxbIvXOwu4w9tNM+D2/BWWBrM3RtBeM2QjbHYXv3fpFTyLy4B+8oVubzhjwEObtR5k+dw3Lg5TjiJ8EmcFHJZB5vRYNb8zodFLbCM3LOmCqm5lgXdZ4AjFMgfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kswVu1/E; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kswVu1/E"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so8373565ad.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219466; x=1790824266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KM6nmIZ2Z99Cq5tdn79sn37AsAkSr0GpubzcCjWmPJc=;
        b=kswVu1/E1NV4c7Rx7Pl+4rQSyJs5te52nTyK398yAV/UAfZThKINj+yS+rVJJO1Xa+
         YZAYdRrpjjZzOW1hDasPkF4IIRbMLdukAbgQfTRWvYBcMtuCdQ0vb7C/UaiRdxNS1nyn
         n3pUEm6lStLZtrZH/wNaNuxFMVx6GM4ZfFbQbIXGQc2yBkMlV0XWrNtuZms9Gjf2m+Ok
         4FN3PUx2op9xE58hLpQBWWlght2qILuR5Kmw0IF3Ny/19UBE999erFp753fmJI3wzDop
         kvaohYJANu8A0khpFLhqUkiiWZ7GFf6bIJu+34ZhENmpDlqLdw3Y3PJtdjBKdKv52yyx
         J+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219466; x=1790824266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KM6nmIZ2Z99Cq5tdn79sn37AsAkSr0GpubzcCjWmPJc=;
        b=kwqG4v5WxFFJ/jlgAX8TRMD/pzo3HitRocpmC1RjIDrQE1D7lg6i2nfkBObyRyBhee
         VfMuA0KtC8XjYiWhGoj8sZYf0VQt8+ulXjXlnsKDxQNYR3ILzD3VWh4YVXqhXVItc83J
         Z934NV6LbfOu2UbKA9EBg2dzyhSoXCElMOs+2w7qq5qOmhnw36cP7PiVi5iLDkTmhuOh
         5E3l7185irS+sSrIrP5pBpyc90h7GcLt24Q5RUnnGfuQTd475fHwgY/HqPzKozlm2b/c
         7XHfeaUeU0CFavWK7hd0FxmSN4BwSWVQBNlHoYFOVL1MSrTaMoPb6md3ClZNLHolaLNo
         MgMg==
X-Gm-Message-State: AFuF++kEc8Pk8GZ8m5FpA26MnkU9dhJ8sp5I/oLnuY2BDGjhmAbbNsQb
	8L9ZN8PQxKX4+dVyFbx6cRUETQDgqmcUkmhV8kYMkVr+CjY6Z7CBzJnerqswGw==
X-Gm-Gg: AYBFou3JZis637qQS1cD7qAzmhlZoOeQaKFKknh01xu31tHM5f1f3Mq87LC2uoPkbS4
	K+mEf3JPSn0+qwCgS621rS1rTGWrJhLqsd2hBoH+1yVFWapbH9zemKC8CI2K7xXZzNIo9CY2tbQ
	S1Dv/Y51AyjHSLZHhTIMYsO890XuK1Rph2hNtxusLtJxP06m4DqMtImALxB7hoUhQ4p4xHH7pJa
	qpey0nAiivYjN+/YO8lgmVWEKOaxsAvjFH/jlbEd4Coh73sR6ssAsNRaPUGRcauQAnlB/gmCD8O
	3tGWaRfkr3IxbV6PtM1+KArBT+DqikrVQPo5O4yk3Aqfl+AlIu5PtdRR0/fVoh3mMhx9RiJyRR4
	K559QSSOM/E8P4uPGbwDnA0nYKeaQtqQf4fCdJy3uTdsJT5xG4AQob4G8OKJayMFDHmBPQZCQ+p
	9GlpjR6uX9E+ckBFWaukyR0iBlbvekug3KSQBDagKHZQN0nJecwr6PbcyCwQjL9RBuZ1Y5fFiwz
	u69MaBRhWoZGEsJTYSfcZE0vdmQIYew92f4jwBqzdznfmx1PHI+qsKdca/SMZd6ZiIiJMgC0zlB
	MDQCgvqvkxd5lhZ1snk85juQWlUZu4ppILmfCAs7uN6Q
X-Received: by 2002:a17:903:1a70:b0:2dd:c100:b2ca with SMTP id d9443c01a7336-2df7dc5d8d6mr10345965ad.53.1790219466357;
        Wed, 23 Sep 2026 20:11:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a48d0sm18956055ad.13.2026.09.23.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/17] bpf: Add callx calls to the call graph
Date: Thu, 24 Sep 2026 03:10:31 +0000
Message-ID: <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The callee of callx is known to the main verifier pass only, but
sort_subprogs_topo() (recursion check) and check_max_stack_depth()
(stack size, number of frames, tail_call_reachable, private stack) need
the call graph. Both treat ld_imm64 BPF_PSEUDO_FUNC as a call from
the subprog that takes the address, which is not where callx calls it:

  main:  r1 = foo ll; call bar
  bar:   callx r1

The call chain is main -> bar -> foo, but only main -> bar and
main -> foo are seen.

Record caller -> callee edge in a bitmap when the main pass processes
callx. It explores all feasible paths, so all feasible edges are there.
Then:

- rerun sort_subprogs_topo() after the main pass with callx edges.
  Unbounded recursion is already rejected by the frame limit. This one
  catches bounded recursion via callx, same as direct recursion.
  The call graph is not context sensitive: foo() that calls bar() via
  callx and bar() that calls foo() is a recursion even if it never
  happens in the same call chain.

- check_max_stack_depth_subprog() walks all recorded callees at each
  callx.

The same goes for sync callbacks. The address of a callback may be
taken in one subprog and passed to a helper in another one:

  main:  r1 = cb ll; call bar
  bar:   r2 = r1; call bpf_loop

Only main -> cb was accounted. Record caller -> callback edge in
push_callback_call() and walk the edges at helper and kfunc calls
that call callbacks too.

JITs pass tail call counter to the callee in a register. callx doesn't.
Reject tail_call_reachable callees of callx.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/verifier.c        | 144 +++++++++++++++++++++++++++++------
 2 files changed, 127 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6380c851ed24..931f305fa440 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -965,6 +965,13 @@ struct bpf_verifier_env {
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 2]; /* max + 2 for the fake and exception subprogs */
 	/* subprog indices sorted in topological order: leaves first, callers last */
 	int subprog_topo_order[BPF_MAX_SUBPROGS + 2];
+	/*
+	 * Call graph edges created by callx instructions. A bitmap of
+	 * subprog_cnt * subprog_cnt bits, where bit (caller * subprog_cnt + callee)
+	 * is set when the main verification pass sees 'caller' calling 'callee'
+	 * via callx. Allocated when the first such edge is recorded.
+	 */
+	unsigned long *callx_edges;
 	union {
 		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb014bf6a2e8..d00d0ecab17c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3149,12 +3149,50 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * The callee of callx is known to the main verification pass only, which
+ * records the 'caller' -> 'callee' edge of the call graph for the checks
+ * that follow it: absence of recursion and the maximum stack depth.
+ */
+static int record_callx_edge(struct bpf_verifier_env *env, int caller, int callee)
+{
+	u32 cnt = env->subprog_cnt;
+
+	if (!env->callx_edges) {
+		env->callx_edges = kvcalloc(BITS_TO_LONGS(cnt * cnt), sizeof(long),
+					    GFP_KERNEL_ACCOUNT);
+		if (!env->callx_edges)
+			return -ENOMEM;
+	}
+	__set_bit(caller * cnt + callee, env->callx_edges);
+	return 0;
+}
+
+/*
+ * Return the first subprog with the number >= 'from' that 'caller' calls
+ * via callx, or -1 when there is none.
+ */
+static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
+{
+	u32 cnt = env->subprog_cnt;
+	unsigned long bit, end = (caller + 1) * cnt;
+
+	if (!env->callx_edges || from >= cnt)
+		return -1;
+	bit = find_next_bit(env->callx_edges, end, caller * cnt + from);
+	return bit < end ? bit - caller * cnt : -1;
+}
+
 /*
  * Sort subprogs in topological order so that leaf subprogs come first and
  * their callers come later. This is a DFS post-order traversal of the call
  * graph. Scan only reachable instructions (those in the computed postorder) of
  * the current subprog to discover callees (direct subprogs and sync
  * callbacks).
+ *
+ * The callees of callx are not known before the main verification pass.
+ * When callx is used the sort is repeated after it with the recorded callx
+ * edges added to the call graph to reject recursion through indirect calls.
  */
 static int sort_subprogs_topo(struct bpf_verifier_env *env)
 {
@@ -3195,12 +3233,22 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 				int idx = insn_postorder[j];
 				int callee;
 
-				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
+				if (bpf_is_callx(&insn[idx])) {
+					/* find a callee that is not explored yet */
+					callee = -1;
+					do {
+						callee = next_callx_callee(env, cur, callee + 1);
+					} while (callee >= 0 && color[callee] == 2);
+					if (callee < 0)
+						continue;
+				} else if (bpf_pseudo_call(&insn[idx]) || bpf_pseudo_func(&insn[idx])) {
+					callee = bpf_find_subprog(env, idx + insn[idx].imm + 1);
+					if (callee < 0) {
+						ret = -EFAULT;
+						goto out;
+					}
+				} else {
 					continue;
-				callee = bpf_find_subprog(env, idx + insn[idx].imm + 1);
-				if (callee < 0) {
-					ret = -EFAULT;
-					goto out;
 				}
 				if (color[callee] == 2)
 					continue;
@@ -5372,6 +5420,9 @@ struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
 	int caller; /* caller subprogram idx */
 	int frame; /* # of consecutive static call stack frames on top of stack */
+	int callx_insn; /* callx instruction whose callees are being walked */
+	int callx_next; /* next callee of callx_insn to walk */
+	bool via_callx; /* the subprogram is entered via callx */
 };
 
 /* starting from main bpf function walk all instructions of the function
@@ -5391,11 +5442,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 	/* no caller idx */
 	dinfo[idx].caller = -1;
+	dinfo[idx].via_callx = false;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
 		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
 process_func:
+	dinfo[idx].callx_insn = -1;
 	if (subprog[idx].has_ld_abs) {
 		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
 			if (subprog[tmp].is_cb) {
@@ -5472,11 +5525,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	for (; i < subprog_end; i++) {
 		int next_insn, sidx;
 
-		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
+		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off &&
+		    bpf_is_throw_kfunc(insn + i)) {
 			bool err = false;
 
-			if (!bpf_is_throw_kfunc(insn + i))
-				continue;
 			for (tmp = idx; tmp >= 0 && !err; tmp = dinfo[tmp].caller) {
 				if (subprog[tmp].is_cb) {
 					err = true;
@@ -5491,23 +5543,41 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			return -EINVAL;
 		}
 
-		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
-			continue;
-		/* remember insn and function to return to */
-
-		/* find the callee */
-		next_insn = i + insn[i].imm + 1;
-		sidx = bpf_find_subprog(env, next_insn);
-		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
-			return -EFAULT;
-		if (subprog[sidx].is_async_cb) {
-			/* async callbacks don't increase bpf prog stack size unless called directly */
-			if (!bpf_pseudo_call(insn + i))
+		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i)) {
+			/*
+			 * Walk the callees and the callbacks recorded by
+			 * the main verification pass one by one, returning to
+			 * this insn after each.
+			 */
+			if (dinfo[idx].callx_insn != i) {
+				dinfo[idx].callx_insn = i;
+				dinfo[idx].callx_next = 0;
+			}
+			sidx = next_callx_callee(env, idx, dinfo[idx].callx_next);
+			if (sidx < 0)
 				continue;
-			if (subprog[sidx].is_exception_cb) {
-				verbose(env, "insn %d cannot call exception cb directly", i);
-				return -EINVAL;
+			dinfo[idx].callx_next = sidx + 1;
+			dinfo[idx].ret_insn = i;
+			next_insn = subprog[sidx].start;
+		} else if (bpf_pseudo_call(insn + i) || bpf_pseudo_func(insn + i)) {
+			/* find the callee */
+			next_insn = i + insn[i].imm + 1;
+			sidx = bpf_find_subprog(env, next_insn);
+			if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
+				return -EFAULT;
+			if (subprog[sidx].is_async_cb) {
+				/* async callbacks don't increase bpf prog stack size unless called directly */
+				if (!bpf_pseudo_call(insn + i))
+					continue;
+				if (subprog[sidx].is_exception_cb) {
+					verbose(env, "insn %d cannot call exception cb directly", i);
+					return -EINVAL;
+				}
 			}
+			/* remember insn to return to */
+			dinfo[idx].ret_insn = i + 1;
+		} else {
+			continue;
 		}
 
 		/*
@@ -5533,10 +5603,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		/* store caller info for after we return from callee */
 		dinfo[idx].frame = frame;
-		dinfo[idx].ret_insn = i + 1;
 
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
+		dinfo[sidx].via_callx = bpf_is_callx(insn + i);
 
 		i = next_insn;
 
@@ -5570,6 +5640,14 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				verbose(env, "tail_calls are not allowed in programs with stack args\n");
 				return -EINVAL;
 			}
+			/*
+			 * JITs pass tail call counter in a register that is
+			 * not available when the callee is called via callx.
+			 */
+			if (dinfo[tmp].via_callx) {
+				verbose(env, "tail_calls are not allowed in functions called via callx\n");
+				return -EINVAL;
+			}
 			subprog[tmp].tail_call_reachable = true;
 		}
 	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt) {
@@ -10615,6 +10693,15 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return 0;
 	}
 
+	/*
+	 * The address of the callback might be taken in another function or
+	 * read from a map, see check_func_ptr_read(). Like with callx it's
+	 * known here what is called.
+	 */
+	err = record_callx_edge(env, caller->subprogno, subprog);
+	if (err)
+		return err;
+
 	/* for callback functions enqueue entry to callback and
 	 * proceed with next instruction within current frame.
 	 */
@@ -10835,6 +10922,10 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 
+	err = record_callx_edge(env, caller->subprogno, subprog);
+	if (err)
+		return err;
+
 	return check_static_func_call(env, subprog, insn_idx);
 }
 
@@ -21978,6 +22069,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
+	/* reject recursion through the callx edges found by the main pass */
+	if (ret == 0 && env->callx_edges)
+		ret = sort_subprogs_topo(env);
+
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
@@ -22120,6 +22215,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	kvfree(env->callx_edges);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.55.0

