Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829359;
	b=fy8DrcW+JwhXPWPi3Pev/nsL8IePLNP/Axc9uIbyS0/xDSP2XfEsGOM9NzENsMPld5Dc
	 yXY8MGSvAS7AnHt79gz9Zq+kv62ePVUq+l3VAFMAdA505lzozjoKg51Z2RZWwmXGqhYoP
	 ve2wMoRzNlaQMwJuGuo23xeh0YvzaGs8neNlvhVBZbSrDasIgt3JFIiLZ/gmHdE02JM4y
	 4WJku22EjYviByy9bARCoZ5wq8vHF012lGBWVfJOa6m2syHMQejSkeFpwPbk7Nei6Eih3
	 7hZJAe7bad8tRJAQ+u9i65OrR7fv8Lt7Sl/jdva4uyi+AWmFyEEwepfPa2a5c2wd2ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RqFd60Y8Jyd0PeHHkrefkxXFWVi08YyaezE6tsNMCvI=;
	b=HIv8VgAhopzkvpKNg1A6se0x2oC1YLF+jRaxivq10Oq4oEQUN1/unTkCkhocANlKSncv
	 Mn0NTpZl7eg1bGNW+hXbFcPEmI0pMV8ieF26fx+Kcj2ztXF4sGNSGWH3+l792kULs/hFL
	 M7wKIubQ6ciELrzWWD988sBeLJFSX4Xj9Zqd1aXLrLixFQn3M4d7W5G/EUs7VmdGHibxb
	 3Q4BtQuSEaIPptO7N9ZqTxTuj20u8VAk8dpCEosIIBiOT64XUsEL05TnmIQZN5zBOMq1M
	 GgLpgQVFV5zmObBvwVLu0YavQk61jrwSkQYpK01IP54InLo9lJVrJ7BomBNjdtUbioQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQ5U4F3L;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25460A6F76
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B25460A6F76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQ5U4F3L
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so699792a91.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829359; x=1794434159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RqFd60Y8Jyd0PeHHkrefkxXFWVi08YyaezE6tsNMCvI=;
        b=pQ5U4F3LVkltDGSeCUEVkUXWdYuarfTdnqP7MCyWsJnLIJfmTnsg+3x9NVyFL3ItD6
         uk6LOIBq91ol9W0rK6DDIZaNVdMZM+eH+5Kx1z8DDMdaXSi3cAv9RXV4oFxu84YxxZyL
         3jljZaWt3kwNL5DezeEyJpRRAT/uadpQtFHcGKRzYa2UaKE3Y9BJxsoFaFVuQ/SgVNV5
         xCUYkw/bNaO0qxg0PvuW6QCjGxHagp2IHYFrIqB0/0t3eeMyEv3X0RyfuoDrRrjepL5y
         uCQpbC1V+hgtugMnzau1WReLcEKDpDC+6Rd77MljEZpe/Ws1coSZew6L+jkBIcqNOd/v
         h9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829359; x=1794434159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqFd60Y8Jyd0PeHHkrefkxXFWVi08YyaezE6tsNMCvI=;
        b=swF7+csocZGErJiL+a52G99qCPAhubysJzg0ULeKrzDfugTx3dfNgoNKGVqTCmFV+c
         nC0cuu42eDjy7GarzkuLmHCMLfOLDQh3x+B2n7PERORE1J46BlpkwOrD7Sf2J2oYdWji
         9Jppas37IL6aCnFBxJtDi5VZbceUg0sqAq1UL696xYfUD53DGt7vMrOcQ4jsS6tN06Nb
         34xx47WrAgzorvh/IPTm5p/AYOfZOn1r4DGHzvrIRrUC2xT87IVPIVVKX/ulWy0InzUc
         aNeBb9M6Boj3GmeY4UG6kGSJ9lBR1w3wtmLNJmtEC1eCHkRJgzGUaAdQDKgqPEWgcbtO
         jckQ==
X-Gm-Message-State: APuU4Z9StqGlFhkxvhTkfjl5gUDSgTQCBNYAekdoC9hVfJF7FT2z/Pf7
	DpP/ggyzbcU5PfVXV8shtRlIzKxrzelNhQ12iXZGNIKo5fZoEHq6ipKWAkxASQ==
X-Gm-Gg: AYBFou2JrMoInyb7ZrNR0gOHvdk3x90egGEtP7L7w5/X79ka6BjkcaQrMFMMZaEfbG8
	I21/8zAR4pgsYoB3xUEI3TlJQOXkxWg47biTc2itdC+DgNP1w6xEIg5c0D4KGcuZ0R2RR6psS5z
	7zms7a7mcL+ujCm8SJSPJqTfZr2QaldFDncpLTiKQO4qLxWaiCsd37QC1spX7bz/cyjXtqoLUYY
	7DVGWs6cdzhGOUOPUr7e7+6v597aCebtqMpmFJ5ewO64xx6VThQwsjS2OuPWdagIIVjumfU27NQ
	xRFh0edFl68ZpMtMme0TnYwlvGpadDgKz2KlMN8P4EUJbtlTZh0YSFkrs04Z9ps8u2LTuMqdnJ4
	1tAp77rliD/sEDI9pgCKvrvAb5HVs9YuXx+9O9SwdDzPULse2Vy0RcKVF8vU1bdJ3uDXMIN/TNM
	NRqxTVK6ZK0dzDSkirc9D6iRYqVvuGKRfk6/QzBVxdnm05YkZStEPb0C1WnQrc2ArWDcvAeB5K4
	eo8B1UbA6nWO8du4RbAcTBx49snR9zgndQ1zCBm17hiSe8fYmMnUr9LVIdlCevjz2Cl26r3yPfR
	i2huNlHLuG01rlPi5V0BRliYXE6h9V1KNFeRz/vbI1uZug/7E5UeKE0DWL8p7mM+PDHoXqlz9AI
	Jes1r1RyIHj0i4odSWpx+7+AgO3UroSlRKYJnIgV3oV+ANgzl79/xCac9FYpPkTx8r2AvxNW8jw
	==
X-Received: by 2002:a17:90b:17cd:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3ae89851212mr13696145a91.61.1793829358375;
        Wed, 04 Nov 2026 13:55:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm616291a91.11.2026.11.04.13.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:55:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/9] bpf: Use the call graph to choose subprogs with a private stack
Date: Wed,  4 Nov 2026 21:55:19 +0000
Message-ID: <20261104215523.1852636-6-alexei.starovoitov@gmail.com>
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

Whether a subprog has its frame in the private stack depends on the prog,
on the size of the frame, and on its callers: no async callback may get to
the subprog. An async callback can run on top of the main prog on the same
cpu, and both would use the same frame.

The walk of the chains of calls gets the last condition from its order. It
starts at the async callbacks and marks what it visits as NO_PRIV_STACK.
The main prog comes last and takes what is not marked.

In the call graph "the async callbacks and what they get to" is a set. The
mode of every subprog is known before the walk starts, and the walk only
adds up the frames.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 74 +++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3e80e60f9883..5362687eba8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5809,6 +5809,7 @@ struct bpf_call_graph {
 	unsigned long *reach; /* reach + s * words: the subprogs that s gets to */
 	unsigned long *live; /* what the kernel calls and what that gets to */
 	unsigned long *in_cb; /* callbacks and what they get to */
+	unsigned long *in_async_cb; /* async callbacks and what they get to */
 	unsigned long *tail_calls; /* subprogs that have a tail call */
 	unsigned long *arena_sp; /* subprogs that count on r12 of the caller */
 };
@@ -5839,13 +5840,14 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 
 	cg->cnt = cnt;
 	cg->words = words;
-	cg->calls = kvcalloc((2 * cnt + 4) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
+	cg->calls = kvcalloc((2 * cnt + 5) * words, sizeof(long), GFP_KERNEL_ACCOUNT);
 	if (!cg->calls)
 		return -ENOMEM;
 	cg->reach = cg->calls + cnt * words;
 	cg->live = cg->reach + cnt * words;
 	cg->in_cb = cg->live + words;
-	cg->tail_calls = cg->in_cb + words;
+	cg->in_async_cb = cg->in_cb + words;
+	cg->tail_calls = cg->in_async_cb + words;
 	cg->arena_sp = cg->tail_calls + words;
 
 	for (s = 0; s < cnt; s++) {
@@ -5878,6 +5880,8 @@ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call_graph
 	for_each_set_bit(s, cg->live, cnt) {
 		if (si[s].is_cb)
 			add_reach(cg, cg->in_cb, s);
+		if (si[s].is_async_cb)
+			add_reach(cg, cg->in_async_cb, s);
 		if (si[s].has_tail_call)
 			__set_bit(s, cg->tail_calls);
 	}
@@ -6053,8 +6057,7 @@ struct bpf_subprog_call_depth_info {
  * Ignore jump and exit insns.
  */
 static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
-					 struct bpf_subprog_call_depth_info *dinfo,
-					 bool priv_stack_supported)
+					 struct bpf_subprog_call_depth_info *dinfo)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
@@ -6067,8 +6070,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	dinfo[idx].caller = -1;
 
 	i = subprog[idx].start;
-	if (!priv_stack_supported)
-		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
 process_func:
 	dinfo[idx].callx_insn = -1;
 
@@ -6108,19 +6109,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	}
 
 	subprog_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (IS_ENABLED(CONFIG_X86_64) && subprog[idx].stack_arg_cnt) {
-		/* x86-64 uses R9 for both private stack frame pointer and arg6. */
-		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
-	} else if (priv_stack_supported) {
-		/* Request private stack support only if the subprog stack
-		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
-		 * avoid jit penalty if the stack usage is small.
-		 */
-		if (subprog[idx].priv_stack_mode == PRIV_STACK_UNKNOWN &&
-		    subprog_depth >= BPF_PRIV_STACK_MIN_SIZE)
-			subprog[idx].priv_stack_mode = PRIV_STACK_ADAPTIVE;
-	}
-
 	if (subprog[idx].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
 		if (subprog_depth > env->max_stack_depth)
 			env->max_stack_depth = subprog_depth;
@@ -6190,9 +6178,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		i = next_insn;
 
 		idx = sidx;
-		if (!priv_stack_supported)
-			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
-
 		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
 		if (frame >= MAX_CALL_FRAMES) {
 			verbose(env, "the call stack of %d frames is too deep !\n",
@@ -6226,8 +6211,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	struct bpf_subprog_call_depth_info *dinfo = NULL;
 	struct bpf_subprog_info *si = env->subprog_info;
 	struct bpf_call_graph cg = {};
-	bool priv_stack_supported;
-	int ret;
+	int s, ret;
 
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
@@ -6257,36 +6241,42 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 		goto out;
 	mark_arena_stack_entries(env, &cg);
 
+	for_each_set_bit(s, cg.live, cg.cnt) {
+		/*
+		 * All async_cb subprogs use normal kernel stack. If a particular
+		 * subprog appears in both main prog and async_cb subtree, that
+		 * subprog will use normal kernel stack to avoid potential nesting.
+		 * x86-64 uses R9 for both private stack frame pointer and arg6.
+		 */
+		if (priv_stack_mode != PRIV_STACK_ADAPTIVE || test_bit(s, cg.in_async_cb) ||
+		    (IS_ENABLED(CONFIG_X86_64) && si[s].stack_arg_cnt)) {
+			si[s].priv_stack_mode = NO_PRIV_STACK;
+			continue;
+		}
+		/*
+		 * Request private stack support only if the subprog stack
+		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
+		 * avoid jit penalty if the stack usage is small.
+		 */
+		if (round_up_stack_depth(env, si[s].stack_depth) >= BPF_PRIV_STACK_MIN_SIZE) {
+			si[s].priv_stack_mode = PRIV_STACK_ADAPTIVE;
+			env->prog->aux->jits_use_priv_stack = true;
+		}
+	}
+
 	dinfo = kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
 	if (!dinfo) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	/* All async_cb subprogs use normal kernel stack. If a particular
-	 * subprog appears in both main prog and async_cb subtree, that
-	 * subprog will use normal kernel stack to avoid potential nesting.
-	 * The reverse subprog traversal ensures when main prog subtree is
-	 * checked, the subprogs appearing in async_cb subtrees are already
-	 * marked as using normal kernel stack, so stack size checking can
-	 * be done properly.
-	 */
 	for (int i = env->subprog_cnt - 1; i >= 0; i--) {
 		if (!i || si[i].is_async_cb) {
-			priv_stack_supported = !i && priv_stack_mode == PRIV_STACK_ADAPTIVE;
-			ret = check_max_stack_depth_subprog(env, i, dinfo,
-					priv_stack_supported);
+			ret = check_max_stack_depth_subprog(env, i, dinfo);
 			if (ret < 0)
 				goto out;
 		}
 	}
-
-	for (int i = 0; i < env->subprog_cnt; i++) {
-		if (si[i].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
-			env->prog->aux->jits_use_priv_stack = true;
-			break;
-		}
-	}
 out:
 	kvfree(dinfo);
 	kvfree(cg.calls);
-- 
2.55.0

