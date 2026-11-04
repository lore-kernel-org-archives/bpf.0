Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829333;
	b=4vdEnsIclueXeJrONiYlEgnrUpQhaYdc5odNTe1s5NSRVYHINJsdr47UxReMBLCf666u
	 q8A8fS+nel7T6zIAKZDq2JKfV1JYpDm3MwMnzpNaSk+c2T8TMbDUayNWVDdYokTLMLsKJ
	 EydLUO9m2q3Wl5/4R2Z/gUXn8z6xvz9ZAUr0BV0hNmOvXIM6jcx6CuYei3FXzPaymVHjd
	 Md1AMC91SU6Sm95fSyiLN7KadkH7APa86bKbAkaMM53lLw/xhYZJ7YvgTRZHjF4js6O6I
	 VIlB9SPlCo5Qp0SV8mL3Lo2AifVC6lLML/lnRmbClKtZpIImpLaxBywaVhcgeeCdPBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XXb9NT+V17pIowvzvAxSQFiHNLNgwbN7uYYm5BsHdjs=;
	b=5IQY/3ConPBupqaeRMkYsm8cDbt4V/qoLXLGOH0tDndBf9QuTxksAfdpFwX1WOPczYP/
	 Di2cqKQdaso1gv5qkHlTDzkjOum1NCPklYUILrfsZukgWOgOjfBGMiLHvknPHDqoltQVp
	 Q8imFM6HeCzbeW2e5eVnl5ISBck4/hY4o73Uunpxqci+7GOMxzNdjWHUNmAC/+75ToNy/
	 W1Ifkb3gfwcCuzuXQ73z5SW6K3DtcazFBFO9tJVU75Ii2MufldxLKP2nYT0jZ6Pq0qrBx
	 48zTcOM0Y3gagAnR0SW8QN/Apwro8B/10KM3sEQwLfZmiwFmESjCxc41y98aXU8EzuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG1loZFp;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72B60A3830
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B72B60A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG1loZFp
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso212370a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829332; x=1794434132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXb9NT+V17pIowvzvAxSQFiHNLNgwbN7uYYm5BsHdjs=;
        b=pG1loZFp8uunV4rtY+/HhJ6SS1OOW2hxCiD+7oQalYLNqdKmhoi2G7Zh+ceZ6NRbM7
         LtjEfsXfOBpmLZbwG7dr/5NqPDQi+kk5Z0kSFvWSs1WIKyKvMT+hTDARg5F+LBBIa2h1
         QqnLIYgYy/vnUf9fK820EorC4RqBMBu8Tbjh6A+ieyVk7sc6WeWXml9KX78zuqaC1AgN
         BsZAh6Vy/g1AW2wLwTU4HxgsL/FiVyAU2N71LGf/VhvXbE2vWUXgy3AtX+pmg51YKLq1
         S9R4ieyjgSX3BTNNxRAsMB5yYaSX9DKXwXvJfirtceN7o7nzNyiDZuy56/R5hCRA5xDp
         l1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829332; x=1794434132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXb9NT+V17pIowvzvAxSQFiHNLNgwbN7uYYm5BsHdjs=;
        b=vAi9a6Gv/0deQnM+u6OcKDRV+rgfcGs/33BBxQRKi9MFziX5YG3W6YUwQdTwzCO3nU
         cQG3fRsTR1C5lAe5z0fHPoUGSWWfoFC92mlbYtr1DrPhaKjx8tQSWH0nr9NKLiIMoiqg
         SIC1bcuPQboCP+rwlhAYgdeI6yAZsasSXEFW6apCEH+XYMHsieWGB7rBtcbyFZcLUkOP
         dGHmkE3sz1CIKmoaG9yMYtxrFdHtm/AVDLV01D0Vv+VAE8UDTggA3/EhP8lFB/FKBB6X
         ZAR1WdUJXs1CYbOYBpeSgq4EGnZ0fWi795RMxca7H1XkR4wxjTmFrCGsTPoJTSoQeCf6
         owLQ==
X-Gm-Message-State: APuU4Z+FWzNWvywgnnQm+0Ct7xwRZncP/Q4yAUUnzY/kngB5jDejMTKf
	GSomj4y7mLb9CzaFl4AXBcorLBmwTXlEjUPIVW2WKMwowvWw3hU4p9QSjgJRpQ==
X-Gm-Gg: AYBFou34NP9KSJOaTaDyYhW8IevUOY+fFghoNVCvhLF36aX0qM90tjp7iaBqErpBrgz
	QyRNEFwruaWF7ADS3AS/9j/EdlR1I1bsbuD4wOMjujWwFsXwzA/iy9oWqA38TM0H8JUSWkWg6HU
	6xGGji26SkbaL4DJc+LeTJeCz1tUaDykZ+YSCkpHwdKS45WA1cF4eYiaplRMx8DDV1cchbCt7zk
	6yxZ1HJAxOPvdk5x73rt2K1CH+HMQMrE7sGZdfzmSfdTmXxKwUC01+a0VMe22SneGCQ0FaJqLaO
	xJYp5vWmf0VENGSx/VjtQmDY5B+lZ4aPO4w1zXdX+3NBC1dfKCAN/ctFqEhKNQ1RtjJZIyDzbSp
	kgxoiJnJHu5N98/h8K5ZLLL9gr3SNwbJut1WE28mOYVtZufMmJ66fw9SjIaUL2KwNcvRbTn5pex
	V+RQBYBZk61YTdgwKcI7wHgVE5VQSM65qJIfRSHtzFtlKKhuEX4D8ckbhZtzZirKd3DMEsqwrhc
	KoMHWghr84ym4xH6ckibRZnUKGxNQ60ES8kUlxaryCljQgadcXQ1+35ux0ldgur6bVRkoeQMr3u
	EmrxAMTd9MGhfuirf+uSsjYiTwmSAQKNDmPrIuyblWsd0OgXg5Xe6dRv2nB3pKJsRmlisuzR3h0
	i8ur+ZZQ99v5IHWd/1jsP1LdtTyaKQdnEb/f4A1OhnnYC9Mj6fmEuIiRC2sIsgDYP4zyC4JY+b3
	8=
X-Received: by 2002:a17:90b:4f8a:b0:3a4:b74a:795c with SMTP id 98e67ed59e1d1-3ae89710dd1mr14236397a91.16.1793829332408;
        Wed, 04 Nov 2026 13:55:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3131f8csm734656a91.2.2026.11.04.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/9] bpf: Build the call graph of a prog after the main verification pass
Date: Wed,  4 Nov 2026 21:55:15 +0000
Message-ID: <20261104215523.1852636-2-alexei.starovoitov@gmail.com>
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

check_max_stack_depth() walks the chains of calls of a prog one by one:

      main          main -> A -> C -> D
      /  \          main -> A -> C -> E
     A    B         main -> B -> C -> D
      \  /          main -> B -> C -> E
       C
      / \
     D   E

The number of chains grows exponentially with the number of subprogs. When
each of N global functions calls the next one in both branches of an 'if',
the prog executes N calls, and the walk looks at 2^N chains. 24 functions
take 1.3 sec to load, 30 functions take 105 sec.

The walk does more than its name says. It looks for recursion, it finds
the subprogs that get to a tail call, that run in a callback and that can
use a private stack, and it counts frames. None of it depends on a chain.
It depends on who calls whom.

Build that graph: a bitmap of callees for every subprog, and the transitive
closure, which says what a subprog gets to. The edges are what the walk
follows, in dead code too:
 - a call of a subprog,
 - the address of a subprog, unless it is an async callback,
 - what the main verification pass recorded for callx and for helpers that
   call callbacks.
'live' are the subprogs that the walk visits: the main prog, the async
callbacks and what they get to.

Move the first two checks. A live subprog that gets to itself is
a recursion. A live subprog cannot call the exception callback. The walk
still does the rest.

No verdict changes. The message names the last call of the cycle. When
several subprogs are on the cycle, it can be another call of that cycle
than before. A prog that breaks two rules can get the other message and
errno. sort_subprogs_topo() and its rerun after the main pass stay: they
also reject some cycles through the address of an async callback.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 218 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 180 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81ed32a4b048..d94c273aa3b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5777,6 +5777,167 @@ static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_depth)
 	return round_up(max_t(u32, stack_depth, 1), 32);
 }
 
+/*
+ * A set of subprogs is a bitmap. The call graph has a set for every subprog:
+ * calls + s * BITS_TO_LONGS(cnt) are the subprogs that s calls. Make it
+ * the subprogs that s gets to, through any number of calls.
+ */
+static void close_call_graph(unsigned long *calls, int cnt)
+{
+	int words = BITS_TO_LONGS(cnt);
+	int j, s;
+
+	for (j = 0; j < cnt; j++)
+		for (s = 0; s < cnt; s++)
+			if (test_bit(j, calls + s * words))
+				bitmap_or(calls + s * words, calls + s * words,
+					  calls + j * words, cnt);
+}
+
+/*
+ * Who calls whom. It's known after the main verification pass, which finds out
+ * what callx and the helpers that take callbacks call.
+ *
+ * What follows for a subprog from its callers, or from what it calls, is computed
+ * over this graph and not by a walk of one chain of calls after another: the
+ * number of chains grows exponentially.
+ */
+struct bpf_call_graph {
+	int cnt; /* subprogs */
+	int words; /* longs in a set of subprogs */
+	unsigned long *calls; /* calls + s * words: the subprogs that s calls */
+	unsigned long *reach; /* reach + s * words: the subprogs that s gets to */
+	unsigned long *live; /* what the kernel calls and what that gets to */
+};
+
+static unsigned long *subprog_calls(struct bpf_call_graph *cg, int s)
+{
+	return cg->calls + s * cg->words;
+}
+
+static unsigned long *subprog_reach(struct bpf_call_graph *cg, int s)
+{
+	return cg->reach + s * cg->words;
+}
+
+/* add the subprog and what it gets to */
+static void add_reach(struct bpf_call_graph *cg, unsigned long *set, int s)
+{
+	__set_bit(s, set);
+	bitmap_or(set, set, subprog_reach(cg, s), cg->cnt);
+}
+
+static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cnt = env->subprog_cnt, words = BITS_TO_LONGS(cnt);
+	int i, j, s;
+
+	cg->cnt = cnt;
+	cg->words = words;
+	cg->calls = kvcalloc((2 * cnt + 1) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	if (!cg->calls)
+		return -ENOMEM;
+	cg->reach = cg->calls + cnt * words;
+	cg->live = cg->reach + cnt * words;
+
+	for (s = 0; s < cnt; s++) {
+		for (i = si[s].start; i < si[s + 1].start; i++) {
+			/* the subprog that takes the address of a subprog counts as its caller */
+			if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
+				continue;
+			j = bpf_find_subprog(env, i + insn[i].imm + 1);
+			if (verifier_bug_if(j < 0, env, "callee not found at insn %d",
+					    i + insn[i].imm + 1))
+				return -EFAULT;
+			/*
+			 * async callbacks don't increase bpf prog stack size
+			 * unless called directly
+			 */
+			if (si[j].is_async_cb && !bpf_pseudo_call(insn + i))
+				continue;
+			__set_bit(j, subprog_calls(cg, s));
+		}
+		/* the callees of callx and the callbacks of helpers, see record_callx_edge() */
+		for (j = next_callx_callee(env, s, 0); j >= 0; j = next_callx_callee(env, s, j + 1))
+			__set_bit(j, subprog_calls(cg, s));
+	}
+	memcpy(cg->reach, cg->calls, cnt * words * sizeof(long));
+	close_call_graph(cg->reach, cnt);
+
+	for (s = 0; s < cnt; s++)
+		if (!s || si[s].is_async_cb)
+			add_reach(cg, cg->live, s);
+	return 0;
+}
+
+/* the insn of subprog 'caller' that is the edge to subprog 'callee' */
+static int find_call_insn(struct bpf_verifier_env *env, int caller, int callee)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i, end = si[caller + 1].start;
+
+	for (i = si[caller].start; i < end; i++) {
+		if (!bpf_pseudo_call(insn + i) &&
+		    (!bpf_pseudo_func(insn + i) || si[callee].is_async_cb))
+			continue;
+		if (i + insn[i].imm + 1 == si[callee].start)
+			return i;
+	}
+	/* It's not recorded which callx or helper calls what. Take the first one. */
+	for (i = si[caller].start; i < end - 1; i++)
+		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
+			break;
+	return i;
+}
+
+/* The exception callback is an async callback, so only a call is an edge to it */
+static int check_exception_cb(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	int cb = env->exception_callback_subprog, s;
+
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		if (!cb || !test_bit(cb, subprog_calls(cg, s)))
+			continue;
+		verbose(env, "insn %d cannot call exception cb directly\n",
+			find_call_insn(env, s, cb));
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * The DFS of sort_subprogs_topo() follows the address of a function like a call, and
+ * tolerates a cycle only when such address closes it, since it doesn't know what it is
+ * taken for. Such cycle counts as a recursion, unless the function is an async callback:
+ * its address is not an edge of the graph. The main verification pass limits the
+ * depth of the recursion, but it doesn't follow calls of global functions.
+ */
+static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
+{
+	int j, s;
+
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		if (!test_bit(s, subprog_reach(cg, s)))
+			continue;
+		/* the last call of the cycle */
+		for_each_set_bit(j, subprog_reach(cg, s), cg->cnt)
+			if (test_bit(s, subprog_calls(cg, j)))
+				break;
+		verbose(env, "recursive call from %s() to %s()\n",
+			bpf_subprog_name(env, j), bpf_subprog_name(env, s));
+		bpf_diag_program_structure(
+			env, find_call_insn(env, j, s), "recursive subprogram call",
+			"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
+			"This call or callback would make the subprogram call graph recursive. "
+			"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /* temporary state used for call frame depth calculation */
 struct bpf_subprog_call_depth_info {
 	int ret_insn; /* caller instruction where we return to. */
@@ -5950,10 +6111,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 				/* async callbacks don't increase bpf prog stack size unless called directly */
 				if (!bpf_pseudo_call(insn + i))
 					continue;
-				if (subprog[sidx].is_exception_cb) {
-					verbose(env, "insn %d cannot call exception cb directly", i);
-					return -EINVAL;
-				}
 			}
 			/* remember insn to return to */
 			dinfo[idx].ret_insn = i + 1;
@@ -5961,27 +6118,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 			continue;
 		}
 
-		/*
-		 * sort_subprogs_topo() tolerates cycles in the call graph that
-		 * go through the address of a function being taken, since it
-		 * doesn't know what it is taken for. Such cycle is a recursion
-		 * unless it's an async callback, which are skipped above.
-		 * The main verification pass limits the depth of the recursion,
-		 * but it doesn't follow calls of global functions.
-		 */
-		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
-			if (tmp != sidx)
-				continue;
-			verbose(env, "recursive call from %s() to %s()\n",
-				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
-			bpf_diag_program_structure(
-				env, i, "recursive subprogram call",
-				"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
-				"This call or callback would make the subprogram call graph recursive. "
-				"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
-			return -EINVAL;
-		}
-
 		/* store caller info for after we return from callee */
 		dinfo[idx].frame = frame;
 
@@ -6064,22 +6200,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
 	enum priv_stack_mode priv_stack_mode = PRIV_STACK_UNKNOWN;
-	struct bpf_subprog_call_depth_info *dinfo;
+	struct bpf_subprog_call_depth_info *dinfo = NULL;
 	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_call_graph cg = {};
 	bool priv_stack_supported;
 	int ret;
 
-	dinfo = kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
-	if (!dinfo)
-		return -ENOMEM;
-
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
 			/* the stack in arena wouldn't be returned */
 			if (env->uses_arena_sp) {
 				verbose(env, "tail_calls are not allowed in programs that use R%d\n",
 					BPF_REG_ARENA_SP);
-				kvfree(dinfo);
 				return -EINVAL;
 			}
 			priv_stack_mode = NO_PRIV_STACK;
@@ -6093,6 +6225,18 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
 		priv_stack_mode = bpf_enable_priv_stack(env->prog);
 
+	ret = build_call_graph(env, &cg);
+	ret = ret ?: check_exception_cb(env, &cg);
+	ret = ret ?: check_recursion(env, &cg);
+	if (ret)
+		goto out;
+
+	dinfo = kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
+	if (!dinfo) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	/* All async_cb subprogs use normal kernel stack. If a particular
 	 * subprog appears in both main prog and async_cb subtree, that
 	 * subprog will use normal kernel stack to avoid potential nesting.
@@ -6106,10 +6250,8 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 			priv_stack_supported = !i && priv_stack_mode == PRIV_STACK_ADAPTIVE;
 			ret = check_max_stack_depth_subprog(env, i, dinfo,
 					priv_stack_supported);
-			if (ret < 0) {
-				kvfree(dinfo);
-				return ret;
-			}
+			if (ret < 0)
+				goto out;
 		}
 	}
 
@@ -6119,10 +6261,10 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 			break;
 		}
 	}
-
+out:
 	kvfree(dinfo);
-
-	return 0;
+	kvfree(cg.calls);
+	return ret;
 }
 
 static int __check_buffer_access(struct bpf_verifier_env *env,
-- 
2.55.0

