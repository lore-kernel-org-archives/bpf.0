Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79A368D47
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039634; cv=none; b=JA/ShkIrmDt298settBySYKtxS0sU2hBIKmWg4UmfSQVW0cFOJd7BFkXiZXm8NzhVWGisX9u41tz2Ri2Vt+/LbBQV+/cb1+mTRO/H+I4lNrDoeOIRbih6dz3DRx5QjBDUqoQ5MIROj2uiaW8tnnzsNl6pXWQMeYpLxk3hktOE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039634; c=relaxed/simple;
	bh=at3roGkE9j0EqeQsxcBi6WGwtmPDCGN+2yrKWTD9/vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn7HXisak0wAJY4aYpwWtEOM6r8zex4bXlhe4Z32sW/Ro3GAN504PKnf1bpkx1VuJOZZf98MC57+NrXWYsEunVIsGMT+EbbwEAiDAL6fpod2BmJxlqD5QUkiZDBdI+dTfMonl8y0UhzcP0gYdgtBKB4QCJbPpr2mLsuUazy4hnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyAnXk+a; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyAnXk+a"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so2202672a12.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039632; x=1790644432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl4sCoDVdKVuCGGJVaNKglTWCXGQy6qYrca+n+8sFa4=;
        b=QyAnXk+a6ymgVJm5+GQsjSba8qcCJe/xNOE1bokImo/3tj/eTDKaMyaqLjNCRJ9yr6
         tAVAn7biZmJF74UoaAUeXrx4YdcySXlZd4tnzD+IQiPj/fCspRglGsJFlQUrPCO4BHcH
         IhtV62R1wy503g++vf/Li/Z4epwjlrsR8xZ+qmMbfZGULRRJ5yquoxZw86hHRhG2D504
         rayNlMW5Dg8Iqm0qD2CJOJPm3ddcppat9yvu+y4iISAwzf4wsSDTEze3LVFIDAMR1m6/
         vnfWzMDVK6x7M6vkSKFB7IWl3cMGI8taDiWcdY6DzKaeHGGWZCzCE/RR11KxD1QXCJxo
         RARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039632; x=1790644432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl4sCoDVdKVuCGGJVaNKglTWCXGQy6qYrca+n+8sFa4=;
        b=mAST21Ysj4rjCsFBBjgXTkxbbrubFeV8ZKzGsCaowFzB4zmWjbQgVho7Qgj6/qA3cg
         sle2f1e1OpmyGhzVN2Oq4ipg1HRZJ41PbE5rPMdKowTzzGbv6kJZhkiIZvGIO59S4OK9
         bc/yC9SE2dfd/xXuPg5yzdP2gAfvLZH+E6RT/vMxZjDlSJRxEwU+eIcj8fKYcKODu2KA
         crtBQMDGyPJk4lGSyPO++2CwdKQK1+VW/+SynboAQzzQSik9L+RR8zbi8FC+Rc4G0Ep8
         007pjLFhdzZEd7AuaGbyzRGQE4lufJ1Bn6cUNhx4o652BUk9Cz3XwsINpXT325VhdvDp
         R3BQ==
X-Gm-Message-State: AFuF++mqsJO1qBN0DeiGzj90OSWKxto8jtYR7yzqPpWUUSBYVNE5uNYH
	LH2TBJRmyH1vgkCuA51XtE/NDjiI0QJszHzd8x1mlkS7UnsBKTHE3CiYRaK/3w==
X-Gm-Gg: AYBFou1DxmBKgwXl2YataOSP9dvtYxIxYAg5LyRDnu40U5pVm2zyUsVT7B/6iosjbzM
	nKanBZfoNjKgfyVsa5ksAgy/AlVroW1qSbsMmLEvUCWRi909Z788c0CxXGQf76HcHvV4tSuh8L6
	4POyMSITqgTCvFxvIpUj3f1U/nONaqBcSchpRwxNAqfBkm2nsiokV1oFK1udRiNHGD4+ZLzGDgH
	Zn1n9jZt5W88gJXADpHsV8ifNBMk2aljTrtxI1FwYX6jJ85qiTRsvzvQ1tPSmlwLajKwKKa4Lb2
	f0roiAu6P8G26X+3WleSRYy6+nWWe/LjodOhBS5IO7vD09+gct6Me6SPbID/djqn48x7Yb+tSJe
	UyfMMQQzlZK+T1eQyfn5OjxDJLGFrNMWNcQBGftUgMg3GxexpTasqKVo73eD8bVkIo0IqQi2onG
	fWJA5l2Hy2IUaSIAvkzInHPS98MaFEpld6xrjBY1BXWqPNlcO57TY5SBCHiauhWXLDqabJOhAN1
	kUmBWjH93GQWuzZ9/tEO3X5OTesIhpqwYlgF48UZaS5c9JU0AUQBiO0fsuzoLOHDMVEsoBhO5Gs
	chwNFjEKkefuUOfUi4yUrjKqpl2KQuF02YTs3W3LJSk=
X-Received: by 2002:a17:90b:2f8d:b0:39e:6c69:f475 with SMTP id 98e67ed59e1d1-39e6c69f4ddmr12907977a91.52.1790039631369;
        Mon, 21 Sep 2026 18:13:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e26e70asm322054a91.1.2026.09.21.18.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 06/17] bpf: Add callx calls to the call graph
Date: Tue, 22 Sep 2026 01:13:12 +0000
Message-ID: <20260922011323.1298619-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
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

JITs pass tail call counter to the callee in a register. callx doesn't.
Reject tail_call_reachable callees of callx.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/verifier.c        | 129 +++++++++++++++++++++++++++++------
 2 files changed, 115 insertions(+), 21 deletions(-)

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
index 0d32d3921210..12898d31e244 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3144,12 +3144,50 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -3190,12 +3228,22 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
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
@@ -5367,6 +5415,9 @@ struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
 	int caller; /* caller subprogram idx */
 	int frame; /* # of consecutive static call stack frames on top of stack */
+	int callx_insn; /* callx instruction whose callees are being walked */
+	int callx_next; /* next callee of callx_insn to walk */
+	bool via_callx; /* the subprogram is entered via callx */
 };
 
 /* starting from main bpf function walk all instructions of the function
@@ -5386,11 +5437,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
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
@@ -5486,23 +5539,40 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
+		if (bpf_is_callx(insn + i)) {
+			/*
+			 * Walk the callees recorded by the main verification
+			 * pass one by one, returning to this insn after each.
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
@@ -5523,10 +5593,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		/* store caller info for after we return from callee */
 		dinfo[idx].frame = frame;
-		dinfo[idx].ret_insn = i + 1;
 
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
+		dinfo[sidx].via_callx = bpf_is_callx(insn + i);
 
 		i = next_insn;
 
@@ -5560,6 +5630,14 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
@@ -10806,6 +10884,10 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 
+	err = record_callx_edge(env, caller->subprogno, subprog);
+	if (err)
+		return err;
+
 	return check_static_func_call(env, subprog, insn_idx);
 }
 
@@ -21884,6 +21966,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
+	/* reject recursion through the callx edges found by the main pass */
+	if (ret == 0 && env->callx_edges)
+		ret = sort_subprogs_topo(env);
+
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
@@ -22026,6 +22112,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->scc_info);
 	kvfree(env->succ);
 	kvfree(env->gotox_tmp_buf);
+	kvfree(env->callx_edges);
 	bpf_diag_free(env);
 	kvfree(env);
 	return ret;
-- 
2.55.0

