Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911647;
	b=1hA6Uf29xjSEZbKxyenuOV/7kykwkWjP0Hl/6uiy84mMrboY0Cdd7QLEQQ7OZlVWV5J+
	 xSAUKoc+bHlVlWFwZ+tByh/z/gq62oGr7mj9dQmJwvnN1RR3XqFqiZSVYggtUZ/LpZIBm
	 xdUknb8/okTcH6Jyz1yUn+YItuzkEVZOO1MqsJjKgVFuesGyjbTQwzECacVR/dvcsKjvc
	 1g38zXefw19C33SF6XnJnVzkd0weedKryEUDNChlCT9oDlLWBjf6SWg7rvPIC9Syp/eIG
	 O5Gd+/93ClJUsJShf5up7Pxh8D2FF7gCYFAPExqhy8984BachYuxvvcSP64UPA07KfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yEkABW/S63xpRqTlJltPEQQlpFb2ervS2DbFbgxA3H8=;
	b=ciHAboBj5LqA+Nx4skUwN0NQzXO94uj0GevTYQb6hgLNIWUQYrFPl8Bv8ZYBRUksvSo/
	 Hd85wcUyEfpBN7bbhxGUUB7O0XycAMTbq23r3WFBg+/pdYQd1ueI7TpWDoQZA/0gJ32ae
	 4JXlnNL9PpIO3UKiMu6fyN61AuUE28nDrUNqBeMoAtlaEDzkNkWSwM9UWNSYgVvWxuZu9
	 +CzrcmlTUG7OZSGLE9BmRTMLKkWsP0HTmabOkhKI8RIp6YFL7VMdaCdkYKWuNhKJyNDNH
	 dqur6q97IpeV5fpqj4m+chFL335bBsWRHPKhGlzmxg8kGFJIz0a3tBOzd88mTJh9gKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR3zTk3d;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE0606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DFE0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UR3zTk3d
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0afe09854so811377a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911646; x=1794516446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEkABW/S63xpRqTlJltPEQQlpFb2ervS2DbFbgxA3H8=;
        b=UR3zTk3dKXmItu8+sXUxb1NOpOYxPm9foekIcIlXpM3Jq9JbY0wB191w5YsM1bLHcx
         eTQozPeRyyh7cgTfvD6iPLjX/AzmMuowH39yU4kbjLjRHvr2JJkLKhmGMzrVo4c/fwWm
         kIgdn45KMZuyzMH4jAEfftQlNGG/K+dCm05FIJxQSSoeCWVbeYRIgRmFbCPmIwjazPCD
         hTitirOF8DFgqoFYx3JqkQZMJjc/Vi1ZnbXvzGR21BPOP7QA3kBMDOYI+ckIHSX5Fi10
         rydfupj2PuWY2enkNX4EnXHnTvNB8gh1auxHeVHpr4v08veODsYV4X0eR8cMVIK0vYXl
         4v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911646; x=1794516446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEkABW/S63xpRqTlJltPEQQlpFb2ervS2DbFbgxA3H8=;
        b=Tdc+BuQcuvx3sIUrLCROIiOscwL7iRNfA1+W2rq6lKkm6z10ctFiXb98LHIa2FKp49
         gwXFHrM8oOJDeen2mrVb4v00mGYHOSq4GYKxBVQSLnoVpRxh8OSTcSZ6Zhr1ouRbcnen
         TIqPT8Y+bVq1DdR6yF5ljbr9WeQdO0FUlnG5rr5ZfIConBcgofQsYqx+zl55JzHgm5VE
         NBdfFmTozewIa/IIWM7CnKqzjzELPIzldZVIC4ON9QlVOs7pLWf9NW0MXV+Mgw8solVE
         tyKJix3ktWf20A6YsBtl3okKTfVDObKXcBY6CpV1vT6XGEEsgzHExxUpHJXd9mn8wT9o
         Hv7g==
X-Gm-Message-State: APuU4Z8D5f0bjiol+HbSWJJnLAq2VtKbUQRVwnk7hS69R0r1gTwKmR3E
	PJfDhxJ4NuqyuPjSqDniQglBx3jkEYkhUdRNxtov/yS7cCTt+tyJ8Jx2kccpmw==
X-Gm-Gg: AYBFou3e/843Ccstl/GxPIojPtwyAMlP/J6Br6UQarZHxH7yMNzMyxz2vRC/by7+3ns
	BHNzAsBPxP+uwdisBRN7Vna3t9C46LCI5hb7Kzn2eNOLhqQqxq3ROlWqNIOSJuwO5oHVLypXoAy
	JPWdbMNHxJMx68GuedbEpqhmqLiyeCKKlMItMRu/2BL2rEzXoaS++zDDoXTe/tNmJC4Hz1kqDyg
	vVPCJC5SAMo+MKi5GsUM+wUXI7iFdqs4A4mL+UaB0r66EGYxvNEw59r4TnLWd6xEcH8+xH/zSR3
	it/Lh/7uwRhOLAGRExRiq2uiP1ly/UQeknQUgbyI6YFAaahoXIHL/QEAwRacDF33y9Z2QPJBpTh
	Qnd6O9KQvHP2Vi4A1+uPjAxgRgiz7KtM8mItNhvU0NvziJ4Pe6wA5Zf3n+PiTOTDSAzS46PZ6+H
	cxVTVwG2A+xQfYjeM/Uv4hG6ugeZI7ZOlNQuqo0QP/l8LtYwHjnJQYR7vIyNKf2sVs8smpUwOQ3
	ZZdbg6G1hMG8t2oUb1H8DeBDz+8iTBJi3BU+Ivg6YUr0LEFUXGO5s+4Ub2rmPgnNvUXVSqPV14R
	SuZDpZsIYJVN5HjPvfOuJ6mNKx4aiS3zsZCUphthS9p+jwdg8ik/8HBK2ya/+fCmPcBv8WBuUkG
	Keo9SVQarTRquwrkiWOO8Z/QU5qRUypJtQeMFf3oXlePCfREagUUR8XqfjR8OUvHEZgYeC4XhuA
	==
X-Received: by 2002:a17:90b:4486:b0:3b0:9deb:d994 with SMTP id 98e67ed59e1d1-3b0db7251bamr162667a91.64.1793911646078;
        Thu, 05 Nov 2026 12:47:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096994650sm5038029a91.2.2026.11.05.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:47:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 22/35] bpf: Allow recursive subprogs
Date: Thu,  5 Nov 2026 20:44:59 +0000
Message-ID: <20261105204513.2230344-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

  candidates.sort_unstable_by(|a, b| b.0.cmp(&a.0));    scx_rusty.rs

quicksort() of the core library calls itself, and rusty_tick is rejected:
"recursive call from quicksort<..>() to quicksort<..>()". The same for
progs that drop a list, a tree or an Arc of a parent, that use BTreeMap,
serde_json or regex-automata: 100 of the 225 progs of the schedulers of
rust-bpf and 100 of its 437 tests have a subprog that gets to itself.
A verifier that follows each chain of calls has no choice: there is no
last chain.

  depth(n) { return n ? (depth(n - 1) + 1) & 255 : 0; }

The main pass verifies a static subprog for its entry states, and a call
waits for the exit states. A call of a subprog that is in progress waits
like each other call. The first insn of a recursive subprog is like a loop
head: the entry states are joined with widening. So are the exit states.

    main prog: call depth          entry state { r1=5 }
                  v
  +-->  first insn of depth()      join with widening: { r1=[0,5] }
  |        ...
  +---  call depth(n - 1)          entry state { r1=[0,4] }, the call waits
           ^
        exit of depth()            goes to all calls that wait

How deep the calls go and how many there are is not known. Thus each
subprog on a cycle of the call graph gets the checks of
"bpf: Limit depth and time of recursive subprogs at run time". When a check
fails the subprog returns 0. This is a new edge, and
check_recursion_guard() verifies it.
linux-notes.rst says 'recursive calls are limited at run time' now.

mark_recursive_subprogs() finds the cycles before the main pass: callx can
call each subprog whose address is taken, a helper calls its callback. The
main pass finds what callx calls. A mark that it does not confirm is
dropped, and the subprog gets no check.

Still rejected: a call of the main prog; recursion in an extension, in an
offloaded prog, with a tail call, LD_ABS or bpf_clone_redirect(), or in
a prog that gets a private stack without a request, like kprobe, raw_tp and
fentry progs; an extension of a subprog that is called in a recursion;
a pointer to the stack as an argument of a call between recursive subprogs.
In the static limit on the stack of a chain of calls a recursion counts as
one frame, the last one.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/linux-notes.rst |   4 +-
 kernel/bpf/cfg.c                  |  43 ++++-
 kernel/bpf/liveness.c             |  40 ++++-
 kernel/bpf/verifier.c             | 281 ++++++++++++++++++++++++++----
 4 files changed, 318 insertions(+), 50 deletions(-)

diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 6c036b54a29f..12f0dc43e154 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -36,8 +36,8 @@ In both cases only static functions can be referenced. Therefore all functions
 that can be called indirectly are known to the verifier before it starts to
 analyze the program, and ``callx`` is verified as a direct call of every
 function that ``dst`` may point to at that instruction. The same rules apply:
-the calls can not be recursive, and the depth of the call chain and its
-combined stack size are limited.
+the depth of the call chain and its combined stack size are limited, and
+recursive calls are limited at run time.
 
 Calling helper or kernel functions through a register, indirect calls of global
 functions, and tail calls in functions that are called via ``callx`` are not
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 2ee950e9ac82..04c1c98ba248 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -75,21 +75,28 @@ static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 	subprog->might_throw = true;
 }
 
-/* 't' is an index of a call-site.
+/*
+ * 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
- * Rely on DFS traversal order and absence of recursive calls to guarantee that
- * callee's effect marks would be correct at that moment.
+ * DFS traversal order guarantees that callee's effect marks are correct at that
+ * moment, unless the callee calls one of its callers: see close_callee_effects().
+ * Returns true if the marks of the caller changed.
  */
-static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
+static bool merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
 	struct bpf_subprog_info *caller, *callee;
 
 	caller = bpf_find_containing_subprog(env, t);
 	callee = bpf_find_containing_subprog(env, w);
+	if (caller->changes_pkt_data >= callee->changes_pkt_data &&
+	    caller->might_sleep >= callee->might_sleep &&
+	    caller->might_throw >= callee->might_throw)
+		return false;
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
 	caller->might_throw |= callee->might_throw;
+	return true;
 }
 
 enum {
@@ -534,6 +541,33 @@ static int visit_func_ptrs_insn(int t, struct bpf_verifier_env *env,
 	return DONE_EXPLORING;
 }
 
+/*
+ * A subprog that calls one of its callers is EXPLORED before that caller is: it
+ * took the marks that the caller had so far, and so did everybody who called it
+ * since. Merge again at every call until nothing changes.
+ */
+static void close_callee_effects(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	struct bpf_func_ptr *ptrs;
+	bool changed;
+	u32 cnt, j;
+	int t;
+
+	do {
+		changed = false;
+		for (t = 0; t < env->prog->len; t++) {
+			if (bpf_pseudo_call(&insn[t]) || bpf_pseudo_func(&insn[t]))
+				changed |= merge_callee_effects(env, t, t + insn[t].imm + 1);
+			ptrs = insn_func_ptrs(env, t, &cnt);
+			for (j = 0; j < cnt; j++)
+				changed |= merge_callee_effects(env, t, ptrs[j].xlated_off);
+			if (bpf_is_ldimm64(&insn[t]))
+				t++;
+		}
+	} while (changed);
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -759,6 +793,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 		}
 	}
 	ret = 0; /* cfg looks good */
+	close_callee_effects(env);
 	env->prog->aux->changes_pkt_data = env->subprog_info[0].changes_pkt_data;
 	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 6a2ee407412b..290d6e8147de 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2354,6 +2354,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		struct func_instance *callee_instance;
 		int callee, target;
 		int caller_reg, cb_callee_reg;
+		u16 live;
 
 		j = idx - start; /* relative index within this subprog */
 		memset(callee_args, 0, MAX_AT_TRACK_REGS * sizeof(*callee_args));
@@ -2369,11 +2370,17 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 			if (callee < 0 || bpf_subprog_is_global(env, callee))
 				continue;
 
-			/* Build entry args: R1-R5 and stack args from at_in at call site */
+			/*
+			 * Build entry args: R1-R5 and stack args from at_in at call site.
+			 * What is left over in a register that the callee doesn't read is no arg.
+			 */
+			live = env->insn_aux_data[target].live_regs_before;
 			for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
-				callee_args[r] = info[subprog].at_in[j][r];
+				callee_args[r] = live & BIT(r) ? info[subprog].at_in[j][r] : none;
 			for (int r = 0; r < MAX_STACK_ARG_SLOTS; r++)
-				callee_args[MAX_BPF_REG + r] = info[subprog].at_in[j][MAX_BPF_REG + r];
+				callee_args[MAX_BPF_REG + r] =
+					r < bpf_in_stack_arg_cnt(&env->subprog_info[callee]) ?
+					info[subprog].at_in[j][MAX_BPF_REG + r] : none;
 		} else if (bpf_calls_callback(env, idx)) {
 			callee = find_callback_subprog(env, insn, idx, &caller_reg, &cb_callee_reg);
 			if (callee == -2) {
@@ -2408,6 +2415,17 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		if (!has_fp_args(callee_args))
 			continue;
 
+		/*
+		 * at_in[] is kept per subprog and the snapshot of the stack per call insn:
+		 * the walk must not enter a subprog that it has not left.
+		 */
+		if (env->subprog_info[subprog].recursive && env->subprog_info[callee].recursive) {
+			verbose(env, "recursive %s() passes a pointer to the stack to %s()\n",
+				bpf_subprog_name(env, subprog), bpf_subprog_name(env, callee));
+			err = -EINVAL;
+			goto out_free;
+		}
+
 		if (depth == MAX_CALL_FRAMES - 1) {
 			verbose(env, "%s() passes a pointer to the stack to %s()\n",
 				bpf_subprog_name(env, subprog), bpf_subprog_name(env, callee));
@@ -2781,14 +2799,15 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
 	}
 
-	/* Forward pass: resolve stack access through FP-derived pointers */
-	err = bpf_compute_subprog_arg_access(env);
-	if (err)
-		goto out;
-
 	changed = true;
 	while (changed) {
 		changed = false;
+		/* a cycle of calls takes a round for each link */
+		if (signal_pending(current)) {
+			err = -EAGAIN;
+			goto out;
+		}
+		cond_resched();
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
@@ -2838,6 +2857,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		insn_aux[i].zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32));
 	}
 
+	/*
+	 * Forward pass: resolve stack access through FP-derived pointers.
+	 * It looks at live_regs_before of the callees.
+	 */
+	err = bpf_compute_subprog_arg_access(env);
 out:
 	kvfree(state);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 901f4c7620e9..e9466cff05a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3441,7 +3441,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 /*
  * The callee of callx is known to the main verification pass only, which
  * records the 'caller' -> 'callee' edge of the call graph for the checks
- * that follow it: absence of recursion and the maximum stack depth.
+ * that follow it: recursion that was not seen coming and the maximum stack depth.
  */
 static int record_callx_edge(struct bpf_verifier_env *env, int caller, int callee)
 {
@@ -3529,9 +3529,9 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
  * the current subprog to discover callees (direct subprogs and sync
  * callbacks).
  *
- * The callees of callx are not known before the main verification pass.
- * When callx is used the sort is repeated after it with the recorded callx
- * edges added to the call graph to reject recursion through indirect calls.
+ * The callees of callx are not known before the main verification pass: callx
+ * is no edge here. The order within a cycle is arbitrary. For recursion see
+ * mark_recursive_subprogs() and check_recursion().
  */
 static int sort_subprogs_topo(struct bpf_verifier_env *env)
 {
@@ -3591,20 +3591,19 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 				}
 				if (color[callee] == 2)
 					continue;
-				if (color[callee] == 1) {
-					if (bpf_pseudo_func(&insn[idx]))
-						continue;
-					verbose(env, "recursive call from %s() to %s()\n",
-						bpf_subprog_name(env, cur),
-						bpf_subprog_name(env, callee));
-					bpf_diag_program_structure(
-						env, idx, "recursive subprogram call",
-						"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-						"This bpf2bpf call would make the subprogram call graph recursive. "
-						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+				/*
+				 * The call that is its own target never returns. It is
+				 * also what libbpf leaves in place of a call that it
+				 * could not resolve.
+				 */
+				if (bpf_pseudo_call(&insn[idx]) && insn[idx].imm == -1) {
+					verbose(env, "call at insn %d calls itself\n", idx);
 					ret = -EINVAL;
 					goto out;
 				}
+				/* recursion: the order within the cycle is arbitrary */
+				if (color[callee] == 1)
+					continue;
 				color[callee] = 1;
 				dfs_stack[top++] = callee;
 				pushed = true;
@@ -5851,7 +5850,8 @@ static void close_call_graph(unsigned long *calls, int cnt)
  *
  * What follows for a subprog from its callers, or from what it calls, is computed
  * over this graph and not by a walk of one chain of calls after another: the
- * number of chains grows exponentially.
+ * number of chains grows exponentially, and there is no end to them when subprogs
+ * call themselves.
  */
 struct bpf_call_graph {
 	int cnt; /* subprogs */
@@ -5861,6 +5861,7 @@ struct bpf_call_graph {
 	unsigned long *live; /* what the kernel calls and what that gets to */
 	unsigned long *in_cb; /* callbacks and what they get to */
 	unsigned long *in_async_cb; /* async callbacks and what they get to */
+	unsigned long *in_recursion; /* recursive subprogs and what they get to */
 	unsigned long *tail_calls; /* subprogs that have a tail call */
 	unsigned long *arena_sp; /* subprogs that count on r12 of the caller */
 };
@@ -5891,14 +5892,15 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 5) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 6) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
 	cg->live = cg->reach + cnt * words;
 	cg->in_cb = cg->live + words;
 	cg->in_async_cb = cg->in_cb + words;
-	cg->tail_calls = cg->in_async_cb + words;
+	cg->in_recursion = cg->in_async_cb + words;
+	cg->tail_calls = cg->in_recursion + words;
 	cg->arena_sp = cg->tail_calls + words;
 
 	for (s = 0; s < cnt; s++) {
@@ -5933,6 +5935,8 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 			add_reach(cg, cg->in_cb, s);
 		if (si[s].is_async_cb)
 			add_reach(cg, cg->in_async_cb, s);
+		if (test_bit(s, subprog_reach(cg, s)))
+			add_reach(cg, cg->in_recursion, s);
 		if (si[s].has_tail_call)
 			__set_bit(s, cg->tail_calls);
 	}
@@ -5975,20 +5979,45 @@ static int check_exception_cb(struct bpf_verifier_env *env, struct bpf_call_grap
 	return 0;
 }
 
+static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog);
+
 /*
- * The DFS of sort_subprogs_topo() follows the address of a function like a call, and
- * tolerates a cycle only when such address closes it, since it doesn't know what it is
- * taken for. Such cycle counts as a recursion, unless the function is an async callback:
- * its address is not an edge of the graph. The main verification pass limits the
- * depth of the recursion, but it doesn't follow calls of global functions.
+ * Every subprog on a cycle has to check the stack at run time. mark_recursive_subprogs()
+ * didn't see the cycle coming when a helper got the callback from a table of
+ * functions, or from another subprog. A subprog that it marked for callx, which turned out
+ * to call something else, needs no check.
  */
 static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
 	int j, s;
 
 	for_each_set_bit(s, cg->live, cg->cnt) {
-		if (!test_bit(s, subprog_reach(cg, s)))
+		if (!test_bit(s, subprog_reach(cg, s))) {
+			env->subprog_info[s].recursive = false;
 			continue;
+		}
+		if (env->subprog_info[s].recursive) {
+			/*
+			 * These progs run on top of other progs. Their frames belong in the
+			 * private stack, which has room for one frame of a subprog.
+			 */
+			if (bpf_enable_priv_stack(env->prog) != NO_PRIV_STACK &&
+			    !env->prog->aux->priv_stack_requested) {
+				verbose(env, "recursive %s() in a tracing program\n",
+					bpf_subprog_name(env, s));
+				return -EINVAL;
+			}
+			/* It runs on top of its own frames. The half of the stack is not enough. */
+			if (bpf_prog_reenters_datapath(env->prog)) {
+				verbose(env, "recursive %s() in a program that calls bpf_clone_redirect()\n",
+					bpf_subprog_name(env, s));
+				return -EINVAL;
+			}
+			if (bpf_prog_has_invocation_budget(env->prog))
+				continue;
+			verbose(env, "JIT does not support recursive calls\n");
+			return -EOPNOTSUPP;
+		}
 		/* the last call of the cycle */
 		for_each_set_bit(j, subprog_reach(cg, s), cg->cnt)
 			if (test_bit(s, subprog_calls(cg, j)))
@@ -5997,9 +6026,9 @@ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *
 			bpf_subprog_name(env, j), bpf_subprog_name(env, s));
 		bpf_diag_program_structure(
 			env, find_call_insn(env, j, s), "recursive subprogram call",
-			"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-			"This call or callback would make the subprogram call graph recursive. "
-			"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+			"Load the address of the callback in the subprogram that passes it to the helper, or rewrite the recursion as a loop.",
+			"This call or callback closes a cycle of the call graph that was not seen before the main pass: "
+			"the callback comes from a table of functions or from another subprogram. Nothing checks the stack.");
 		return -EINVAL;
 	}
 	return 0;
@@ -6114,7 +6143,8 @@ static int subprog_stack_size(struct bpf_verifier_env *env, int s)
 
 /*
  * A subprog is entered with no more than what one of its callers is entered with plus
- * the frame of that caller. The graph has no cycles, so this comes to an end.
+ * the frame of that caller. Not when both are recursive: the callee checks the stack at run
+ * time. A cycle adds nothing, so this comes to an end.
  */
 static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg,
 			       struct bpf_subprog_call_depth_info *dinfo)
@@ -6134,11 +6164,17 @@ static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_gra
 		for_each_set_bit(s, cg->live, cg->cnt) {
 			if (dinfo[s].depth < 0)
 				continue;
-			depth = dinfo[s].depth + subprog_stack_size(env, s);
-			arena_depth = dinfo[s].arena_depth + si[s].arena_stack_depth;
 			for_each_set_bit(j, subprog_calls(cg, s), cg->cnt) {
 				callee = &dinfo[j];
-				frame = bpf_subprog_is_global(env, j) ? 0 : dinfo[s].frame + 1;
+				depth = dinfo[s].depth;
+				arena_depth = dinfo[s].arena_depth;
+				if (!si[s].recursive || !si[j].recursive) {
+					depth += subprog_stack_size(env, s);
+					arena_depth += si[s].arena_stack_depth;
+				}
+				frame = dinfo[s].frame + !si[j].recursive;
+				if (bpf_subprog_is_global(env, j))
+					frame = 0;
 				if (depth <= callee->depth && arena_depth <= callee->arena_depth &&
 				    frame <= callee->frame)
 					continue;
@@ -6219,6 +6255,10 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 		 * of caller's stack as shown on the example above.
 		 */
 		depth = dinfo[s].depth;
+		/* nor of the frames of recursive subprogs, see bpf_insert_recursion_checks() */
+		si[s].in_recursion = test_bit(s, cg->in_recursion);
+		if (si[s].in_recursion)
+			depth += THREAD_SIZE / 2;
 		if (s && si[s].has_tail_call && depth >= 256) {
 			verbose(env,
 				"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
@@ -6256,6 +6296,151 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 	return err;
 }
 
+/*
+ * The address of the callback at @idx goes nowhere but to a helper that keeps it for
+ * later: a timer, a work queue, call_rcu.
+ */
+static bool func_is_kept_for_later(struct bpf_verifier_env *env, int idx, int end)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	u8 class, reg = insn[idx].dst_reg;
+	int i;
+
+	if (reg < BPF_REG_1 || reg > BPF_REG_5)
+		return false;
+	for (i = idx + 2; i < end; i++) {
+		class = BPF_CLASS(insn[i].code);
+		if (class == BPF_JMP || class == BPF_JMP32)
+			return bpf_is_async_callback_calling_insn(&insn[i]);
+		if (insn[i].dst_reg == reg)
+			return false;
+		if (bpf_is_ldimm64(&insn[i]))
+			i++;
+		else if (insn[i].src_reg == reg)
+			return false;
+	}
+	return false;
+}
+
+/*
+ * Find the subprogs on cycles of the call graph. It is not known yet what callx
+ * calls: it may be any subprog whose address is taken. A subprog that is
+ * marked for no reason is treated like a recursive one all the same.
+ */
+static int mark_recursive_subprogs(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cnt = env->subprog_cnt, words = BITS_TO_LONGS(cnt);
+	unsigned long *calls, *taken, *callx;
+	bool plain_callx = false;
+	int i, j, s, err = 0;
+
+	/* calls + s * words: the subprogs that s calls */
+	calls = kvcalloc((cnt + 2) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	if (!calls)
+		return -ENOMEM;
+	taken = calls + cnt * words;
+	callx = taken + words;
+
+	for (s = 0; s < cnt; s++) {
+		for (i = si[s].start; i < si[s + 1].start; i++) {
+			if (bpf_is_callx(&insn[i])) {
+				__set_bit(s, callx);
+				if (!bpf_is_unwind_goto(&insn[i + 1]))
+					plain_callx = true;
+			}
+			if (bpf_pseudo_call(&insn[i]) || bpf_pseudo_func(&insn[i])) {
+				j = bpf_find_subprog(env, i + insn[i].imm + 1);
+				if (j < 0)
+					continue;
+				/*
+				 * The first insns of the main prog are for the kernel. A call from
+				 * an async callback is on no cycle.
+				 */
+				if (!j && bpf_pseudo_call(&insn[i])) {
+					verbose(env, "recursive call of the main program\n");
+					kvfree(calls);
+					return -EINVAL;
+				}
+				/* the helper that calls a callback doesn't expect it to unwind */
+				if (bpf_pseudo_func(&insn[i]) || !bpf_is_unwind_goto(&insn[i + 1]))
+					si[j].plain_call = true;
+				/*
+				 * The helper that takes a callback calls it, or keeps it: the
+				 * callback that arms itself again doesn't call itself.
+				 */
+				if (bpf_pseudo_call(&insn[i]) ||
+				    !func_is_kept_for_later(env, i, si[s + 1].start))
+					__set_bit(j, calls + s * words);
+				if (bpf_pseudo_func(&insn[i]))
+					__set_bit(j, taken);
+			}
+			if (bpf_is_ldimm64(&insn[i]))
+				i++;
+		}
+	}
+	for (i = 0; i < env->func_ptr_cnt; i++) {
+		j = bpf_find_subprog(env, env->func_ptrs[i].xlated_off);
+		if (j >= 0)
+			__set_bit(j, taken);
+	}
+	for_each_set_bit(s, callx, cnt)
+		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
+
+	/*
+	 * Callers of a global subprog look at can_unwind before the subprog is verified.
+	 * The main prog returns to the kernel.
+	 */
+	for (s = 0; s < cnt; s++) {
+		if (plain_callx && test_bit(s, taken))
+			si[s].plain_call = true;
+		si[s].bail_unwinds = si[s].can_unwind ||
+				     (s && !si[s].plain_call && !bpf_subprog_is_global(env, s) &&
+				      bpf_jit_supports_unwind() &&
+				      !bpf_prog_is_offloaded(env->prog->aux));
+	}
+
+	close_call_graph(calls, cnt);
+
+	for (s = 0; s < cnt; s++) {
+		if (!test_bit(s, calls + s * words))
+			continue;
+		err = -EINVAL;
+		if (!s) {
+			verbose(env, "recursive call of the main program\n");
+			break;
+		}
+		/*
+		 * Each call of the function that it replaces is an invocation of its own: a
+		 * loop in the prog that it extends gets a new time slice each time.
+		 */
+		if (env->prog->type == BPF_PROG_TYPE_EXT) {
+			verbose(env, "recursive %s() in an extension\n", bpf_subprog_name(env, s));
+			break;
+		}
+		/* the device runs the insns that the driver was given, without the checks */
+		if (bpf_prog_is_offloaded(env->prog->aux)) {
+			verbose(env, "recursive %s() in an offloaded program\n",
+				bpf_subprog_name(env, s));
+			break;
+		}
+		if (si[s].has_tail_call || si[s].has_ld_abs) {
+			verbose(env, "recursive %s() cannot have %s\n", bpf_subprog_name(env, s),
+				si[s].has_tail_call ? "tail calls" : "LD_ABS");
+			break;
+		}
+		if (si[s].bail_insn < 0) {
+			verbose(env, "recursive %s() has no exit\n", bpf_subprog_name(env, s));
+			break;
+		}
+		si[s].recursive = true;
+		err = 0;
+	}
+	kvfree(calls);
+	return err;
+}
+
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
@@ -6296,10 +6481,11 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		 * All async_cb subprogs use normal kernel stack. If a particular
 		 * subprog appears in both main prog and async_cb subtree, that
 		 * subprog will use normal kernel stack to avoid potential nesting.
+		 * The private stack has room for one frame of a subprog.
 		 * x86-64 uses R9 for both private stack frame pointer and arg6.
 		 */
 		if (priv_stack_mode != PRIV_STACK_ADAPTIVE || test_bit(s, cg.in_async_cb) ||
-		    (IS_ENABLED(CONFIG_X86_64) && si[s].stack_arg_cnt)) {
+		    si[s].recursive || (IS_ENABLED(CONFIG_X86_64) && si[s].stack_arg_cnt)) {
 			si[s].priv_stack_mode = NO_PRIV_STACK;
 			continue;
 		}
@@ -21933,6 +22119,21 @@ static int flow_drain(struct bpf_verifier_env *env)
 	return err;
 }
 
+/*
+ * A subprog on a cycle of the call graph checks the stack at run time, see
+ * bpf_insert_recursion_checks(). When there is no room, or the time slice is over, it leaves
+ * at once with 0 in place of the result: it unwinds if it can, see bail_unwinds, otherwise
+ * it returns and callers have to be fine with that.
+ */
+static int check_recursion_guard(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[cur_func(env)->subprogno];
+
+	if (!sub->recursive || env->insn_idx != sub->start)
+		return 0;
+	return push_budget_exit(env);
+}
+
 /* Process the current state until it gets to the start of a basic block. */
 static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
@@ -22056,6 +22257,10 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		if (err)
 			return err;
 
+		err = check_recursion_guard(env);
+		if (err)
+			return err;
+
 		err = do_check_insn(env, &do_print_state);
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
@@ -24152,6 +24357,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
 			return -EINVAL;
 		}
+		/* It can have tail calls, which are not allowed there, see check_call_depth() */
+		if (aux->func && aux->func[subprog]->aux->in_recursion && prog_extension) {
+			bpf_log(log, "Cannot replace %s, which is called in a recursion\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
@@ -25584,10 +25794,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = sort_subprogs_topo(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = sort_subprogs_topo(env);
+	/* what no JIT can run is reported first */
+	ret = mark_recursive_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -25651,9 +25863,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		goto skip_full_check;
 
 	ret = do_check_all(env);
-	/* reject recursion through the callx edges found by the main pass */
-	if (ret == 0 && env->callx_edges)
-		ret = sort_subprogs_topo(env);
 	/* while the calls are what they are in the program */
 	if (env->log.level & BPF_LOG_STATS)
 		add_insns_of_callees(env);
-- 
2.55.0

