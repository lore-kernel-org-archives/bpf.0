Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829346;
	b=f3gOWLMP1q1Tw4+03iuSqve4Owl15W9bJh3sOoydc2+ONSD59JPItDHDUmV0iMLu79Bz
	 GPS7lr8W/2z9XDAFXQIiKeCPL7zGXItMPWpvEycqjuvlSF/LtkdYveq/3GeNdzKG1UdB6
	 WGjShKPgQCavgjHX1q/YNunxnjEnR6ngkBAaeob9oDEQrQDFLeLxwqhhBLI4DwQWxbBcd
	 P11vU69zfprNShCxsNk5KxeLoCsdhOOhOImc9p/yZXcpkEY+rjQd5Zf8GHQwZUIxScqC3
	 9QSyT+cFKi09rlumlNWCDL+pFxHlWquLNkDjUSR2WdzSN8qX8RCX4UUEcpu17UT7PSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7c912qRIX31rDQCs5Lk71H+mOpn1tYHm9/cq1yH+Q+s=;
	b=XuG8qEUR45W/eQvZ/LrFZuS1ApInipVPauKLjknVr+LW5lIlFtrXoEfAl3Hnq1v/T5jo
	 +0jOdo4F9+uOICzwIiYm5YLPsHSlefnhEJa3wP0jUMLYdgnJtP4lkUa88geCNFzTkZyUC
	 TRsnsoUg+weJSlDd4FHE3bAb7XN+t+4se+9thb0c1b8qocYsRamu8tDuT5GDFBErMhSBi
	 jJwJoMmhN585PRLtdrpE4BhhNSRaj9HY36XTrJuWvw7Jw8p4WRGZCzVIuUvJXWGwxuyZs
	 y+NwBxUT5hnbRjyXJ2KOP6Mxm3oOnt3VPrcLroVuxPBDCmZJLPUMAAbHWZKC6q5b9uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEUvzx3d;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439F60A5BE7
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C439F60A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEUvzx3d
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so465471a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829345; x=1794434145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7c912qRIX31rDQCs5Lk71H+mOpn1tYHm9/cq1yH+Q+s=;
        b=IEUvzx3dKRf+K1OyTq5zux250MliIjo/mOIT7P39uK1lQh+G8RXLqsrxULNoYS08NB
         7RwXce5+2jNh/UTPmS+8pMyQtmgxTZq+ohb28g8UUiI/ZiCq0KmIe9lBBCaCwkJ+tsOM
         hQlLtKUKs+PXebPI2yOaWeMLWHgqBOy9oL1S/XYI4xgGkgCeJMBdmwO62vS9z5yiP+j5
         N1JjQlCpj5IajCogvm5aScPG0IAXM9rhotharZedU51nC8rPJlIjUe8wdiKV7uw/r6qq
         E9a0NO4Jt0ayF2LsBpzhgepRqxyoIfPy+o027E/G1Jb3fblY/F7hE9zo3BeE6MGrsoX/
         3QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829345; x=1794434145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7c912qRIX31rDQCs5Lk71H+mOpn1tYHm9/cq1yH+Q+s=;
        b=d5AISJivaVA3aFGU7SE5RdB/MZ1GmR1HFe8LyCmvOdmJqQNnHM885Io52kD/3p0lYu
         M1OaabOSWuysVu9lWpjFWBUGgqMaE1y+5z3Mdg+YQEMN+TqQAGJdMrJ8D3tm1fPwZNtF
         vbGT8usVpjSDw2AnyXY7+6RIuBRDo+kdz+8m6IY/tEV+rEz5Tn7E4y9BoadenMj8iZ8P
         wEeeDDqR0psxnQd8ktkhkhIQ3Ni71tKf96fnblHp852zkpd38fu8b5hpPeAf4ynsSu/Q
         4YcvbArCW2NCk4DLXXZ2Z3tHxZ7/xzSc2tKFefOpQwtuUjXtm6OHMlZJPH57lfQdgKve
         pQkA==
X-Gm-Message-State: APuU4Z8XfLtzquqEkQ206j6tp1T02LN9dowO9EFNqLwk3BMILOWqBvEw
	R8BecbM4n0elU7y5w+/NWDNhEN/TdowJAIuDSpzmi4YNzgxverObK/0inFvjtA==
X-Gm-Gg: AYBFou1swTKQvWf3VFuGMuHkm3pBBYpi0LJ5N5e1KG/MzXg2H2omzSjvr78xE3AXRHG
	ZvnqAjYwQVxw2MFhPhakc+op8+nWFshF67RU2V3galFTPseX4vPT+mmYZmf2ZPfoYu6dYXH7FPo
	eGlanvDfqrqV5XtaNBceFEv8mFCRCsyxFsGXfvS+9b08NungL7X781jydjpF6BTi0JoUp9e/VCA
	5LnwpD1GgqTH2gqH8lHHIXw3wBJmWEF3glg1RE7pW7LujqOr1Xsg/79zupg42OpxCrrf7QnfBVC
	0wfzhLg3T/aRkobuqO3nxTlihM5m31g4VcGpe7iWPzm3RtCXabsVXD0EEN7kngj3xtkkeum7TpW
	SUtTLkStQZvttBa+0WWIakrEwmUQzxngFtePM67z3GJW9zgy3ermihO+4iBk96jepyMRE4ZwNX7
	gi8qOGVZdSRug7kzd0mrh3VmK3KqcHs4gmjLtk1/dGZPd4qMC10azshf3MkVjyJGkUjquZYeXwi
	SmMAUYB5gfd9uUz//kPKUS9QIFhsCFTHGm/0iTMMerv7a618RooGHRuWXXmuqhTn/dgqDUrutof
	SDVXWq88e1PniPR9tfMvbpgZl04nGPH9Eif2kom4XRaCfR45vipZl0BYpo0psROnetcUHfobq5d
	uSi9vbYR7d1DS7mvOJzzh/zsAbruXEojnq5RN+5B0miVYm2jEbg2WTtB8pXhVo3GX2jvASuHzzp
	Q=
X-Received: by 2002:a17:90a:e704:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3ae8984b3d6mr15879421a91.59.1793829344933;
        Wed, 04 Nov 2026 13:55:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31cd6c0sm619742a91.13.2026.11.04.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/9] bpf: Use the call graph to find what gets to a tail call
Date: Wed,  4 Nov 2026 21:55:17 +0000
Message-ID: <20261104215523.1852636-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

JITs pass the tail call counter from the main prog down to the subprog that
has the tail call. Every subprog on the way has to be marked as
tail_call_reachable. It cannot be a callback, cannot have stack arguments
and cannot be called via callx.

The walk of the chains of calls marks and checks all callers in the current
chain when it leaves a subprog that has a tail call or is already marked.

In the call graph these are the live subprogs that have a tail call or get
to one:

  main -> A -> C -> tail call       main, A, B and C are marked,
  main -> B -> C                    D is not
  main -> D

Let callx mark its target in the main verification pass. The walk took
every callee that was recorded for a subprog with a callx insn for a target
of callx, the callbacks of helpers included. That made no difference,
because a callback cannot get to a tail call anyway.

The walk starts at an entry point with "no tail call seen". So it misses
a tail call in an async callback that calls nothing. Such a tail call is
dead code, because an async callback has no ctx for bpf_tail_call(). It is
rejected now, like in all other callbacks.

A prog that breaks two rules can get the other message and errno.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 88 ++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b56f9969002c..60d6d93c57db 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -987,6 +987,7 @@ struct bpf_subprog_info {
 	bool has_tail_call: 1;
 	bool might_throw: 1;
 	bool can_unwind: 1; /* has unwind_exit */
+	bool via_callx: 1; /* callx calls it */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ef2af44afb0c..76f4e1f238ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5809,6 +5809,7 @@ struct bpf_call_graph {
 	unsigned long *reach; /* reach + s * words: the subprogs that s gets to */
 	unsigned long *live; /* what the kernel calls and what that gets to */
 	unsigned long *in_cb; /* callbacks and what they get to */
+	unsigned long *tail_calls; /* subprogs that have a tail call */
 };
 
 static unsigned long *subprog_calls(struct bpf_call_graph *cg, int s)
@@ -5837,12 +5838,13 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 2) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 3) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
 	cg->live = cg->reach + cnt * words;
 	cg->in_cb = cg->live + words;
+	cg->tail_calls = cg->in_cb + words;
 
 	for (s = 0; s < cnt; s++) {
 		for (i = si[s].start; i < si[s + 1].start; i++) {
@@ -5874,6 +5876,8 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 	for_each_set_bit(s, cg->live, cnt) {
 		if (si[s].is_cb)
 			add_reach(cg, cg->in_cb, s);
+		if (si[s].has_tail_call)
+			__set_bit(s, cg->tail_calls);
 	}
 	return 0;
 }
@@ -5967,6 +5971,43 @@ static int check_callbacks(struct bpf_verifier_env *env, struct bpf_call_graph *
 	return 0;
 }
 
+/*
+ * Mark the subprogs that get to a tail call as tail call reachable subprogs;
+ * this info will be utilized by JIT so that we will be preserving the
+ * tail call counter throughout bpf2bpf calls combined with tailcalls
+ */
+static int check_tail_calls(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	int s;
+
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		if (!si[s].has_tail_call &&
+		    !bitmap_intersects(subprog_reach(cg, s), cg->tail_calls, cg->cnt))
+			continue;
+		if (si[s].is_cb) {
+			verbose(env, "cannot tail call within callback\n");
+			return -EINVAL;
+		}
+		if (si[s].stack_arg_cnt) {
+			verbose(env, "tail_calls are not allowed in programs with stack args\n");
+			return -EINVAL;
+		}
+		/*
+		 * JITs pass tail call counter in a register that is
+		 * not available when the callee is called via callx.
+		 */
+		if (si[s].via_callx) {
+			verbose(env, "tail_calls are not allowed in functions called via callx\n");
+			return -EINVAL;
+		}
+		si[s].tail_call_reachable = true;
+	}
+	if (si[0].tail_call_reachable)
+		env->prog->aux->tail_call_reachable = true;
+	return 0;
+}
+
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
@@ -5974,7 +6015,6 @@ struct bpf_subprog_call_depth_info {
 	int frame; /* # of consecutive static call stack frames on top of stack */
 	int callx_insn; /* callx instruction whose callees are being walked */
 	int callx_next; /* next callee of callx_insn to walk */
-	bool via_callx; /* the subprogram is entered via callx */
 };
 
 /* starting from main bpf function walk all instructions of the function
@@ -5988,14 +6028,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
-	bool tail_call_reachable = false;
 	int arena_depth = 0;
 	int total;
 	int tmp;
 
 	/* no caller idx */
 	dinfo[idx].caller = -1;
-	dinfo[idx].via_callx = false;
 
 	i = subprog[idx].start;
 	if (!priv_stack_supported)
@@ -6126,7 +6164,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		/* push caller idx into callee's dinfo */
 		dinfo[sidx].caller = idx;
-		dinfo[sidx].via_callx = bpf_is_callx(insn + i);
 
 		i = next_insn;
 
@@ -6134,9 +6171,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (!priv_stack_supported)
 			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
 
-		/* sync tail_call_reachable with callee state on entry */
-		tail_call_reachable = subprog[idx].has_tail_call;
-
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
@@ -6145,39 +6179,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		}
 		goto process_func;
 	}
-	/* if tail call got detected across bpf2bpf calls then mark each of the
-	 * currently present subprog frames as tail call reachable subprogs;
-	 * this info will be utilized by JIT so that we will be preserving the
-	 * tail call counter throughout bpf2bpf calls combined with tailcalls
-	 */
-	if (tail_call_reachable) {
-		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (subprog[tmp].is_cb) {
-				verbose(env, "cannot tail call within callback\n");
-				return -EINVAL;
-			}
-			if (subprog[tmp].stack_arg_cnt) {
-				verbose(env, "tail_calls are not allowed in programs with stack args\n");
-				return -EINVAL;
-			}
-			/*
-			 * JITs pass tail call counter in a register that is
-			 * not available when the callee is called via callx.
-			 */
-			if (dinfo[tmp].via_callx) {
-				verbose(env, "tail_calls are not allowed in functions called via callx\n");
-				return -EINVAL;
-			}
-			subprog[tmp].tail_call_reachable = true;
-		}
-	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt) {
-		verbose(env, "tail_calls are not allowed in programs with stack args\n");
-		return -EINVAL;
-	}
-
-	if (subprog[0].tail_call_reachable)
-		env->prog->aux->tail_call_reachable = true;
-
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
 	 */
@@ -6194,9 +6195,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	frame = dinfo[idx].frame;
 	i = dinfo[idx].ret_insn;
 
-	/* reset tail_call_reachable to the parent's actual state */
-	tail_call_reachable = subprog[idx].tail_call_reachable;
-
 	goto continue_func;
 }
 
@@ -6232,6 +6230,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	ret = ret ?: check_exception_cb(env, &cg);
 	ret = ret ?: check_recursion(env, &cg);
 	ret = ret ?: check_callbacks(env, &cg);
+	ret = ret ?: check_tail_calls(env, &cg);
 	if (ret)
 		goto out;
 
@@ -11946,6 +11945,7 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = record_callx_edge(env, caller->subprogno, subprog);
 	if (err)
 		return err;
+	env->subprog_info[subprog].via_callx = true;
 
 	return check_static_func_call(env, subprog, insn_idx);
 }
-- 
2.55.0

