Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415579;
	b=lXss0w75IZjzTWpFxnPVx6VftXtCVoS5euZrvSu9zg6EqD/VTlWKY8LDqOX+9Tm9EYRP
	 8Lb8ldl3KegzmLhYcYPYbVzHg0ZLNoaa+iim0C4L8oLZPLfEKCB+xmrgnCw+4p6QASdJi
	 9ErmCpsmHqZOTo//xuRX5xevAxzLAeBQqKTuEnpSOY//DD7g0gz6ON3kSQqC0kM4bVBMe
	 rssmU9KxtESjc7S27N2sON+nFIRy4x5jq9yl/9ZyewK/79WadcwEKzAIP0Kok0tiNIl4s
	 NZbvynQM+DYnADYSUU8kq/t/u3A/4L0m4FElt5oCJondt3Fex6cysxlz9VIaWQclhQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
	b=WRsJt0QrUOExLdj6jYIeghyxpvGpGru92c5X3LPFpMdgF/qGMFFFeALw6nVu0pmWd22T
	 phpdwMcMN39+TzvZzMOpTfb2kZuQ3cJHRfR/PZHjSJGiI9HPok1I2kDAXMWrfgsry287G
	 tQvhpNVFPDzPZbnxphJtbHSsHtZPraOBcn+ZobXt+v5iuFMdyEmC/gx5DmElhnZeqkS5d
	 I9mNhJBYIfqReTDsv+bMvg5ofKaibuhkZm+b91bl3PbF8f4UfxpDojE+iQI4X8Cgoo/4q
	 z5RnwfgNtQ90HqLbqMZj6+EmXo0s+Nvf/NkAuJIKENdUxLdSQvG4nttSvdNgkGukHCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDz6WjsK;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BB606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9BB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDz6WjsK
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b2382bf051so1943927b3a.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415578; x=1795020378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
        b=lDz6WjsKOdp2d6L6MVBwgY6oExzOe+d0U7Rd65onhVguyAmpIxvqXiYWIxkrjAPT2P
         0HEb0b3V8smr91dd0LyXTi9dN/MHNpP6YZPvn05eX4rjqERSd+lR6vdARywLgsjruwhU
         cbF96E49qlct32jOTbLhWMT0Jb+ZT4UkyysKCIOsTQQlMqWOW5rSu2KWoC2VHBN3N0pN
         CaUCBA1R7EOGfSH6htqvfVGorBP2blY5uxiS601uFdeRCmKFY356TQA/g9OkK16g/cDq
         2yE0F2s3Y62tAlXvbrV3TL572KiY8y3Clr/mOSjdaLo7B2gv0R8+Lc0bsvmT/u7RnjHF
         fecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415578; x=1795020378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
        b=pAvrVFSGNH5G6c1kXS4csIJHfSlBQRBKjRui2qr+IMzmuh1XMz1EqrX9EVtpCrGGMA
         cvVAwqZLGNtC3j+3JmS2odCg3Op66eezu8LmdKCCxybAZ0+AmToazn8nYKSbrgAqXrA7
         9AxrDLAaX9AxYtQR6wKXDQNoWdqiYuZGrHl0WZ9215gqswselrcX6F1S6u+IyHjnCXG6
         3fPO8GkFRRmTcMJ//oc50KjkLtpv2Q4tMbAFcM65u1YC2rY3O4Qfrw5tyyOF2eOu5iuq
         8UzPU+RRGN8/8hANOpYUkoowizTU/0j5aj02PXL6Pu+Hj34aUiSdyEfT/s55aqwdcCXl
         1VRw==
X-Gm-Message-State: APuU4Z/86g4XXdTdUsP+ycBTETD7OopT2Zu/CDnITwAQsV28wDcSgRIc
	ykX7xJv4/x0wRSaBxHjIGAkhWYaj8eAK8Bc9nN5mMMGLLnCR9RjV+entMMldxg==
X-Gm-Gg: AYBFou1gGSvsHI/lokFpcgtq4FfH0Qu0aYjYM2IfAVSqtZOI6BVZEXgB09NDCtfnNU8
	zwSAX7rC9RAWTUY8eLB15c9NjVcoiTUrXeDFUQeH9iEWzixFRSwcIikYQ4jrl5pHw/y+6C7AiQA
	3z5vflDWorWir8+Qvojfcm32f9geWQTQkYvrxpjpEFgXr6NaOvCCMwqQ5awnb3wTRcXUrhuAaOS
	pLWCtxStYYFxy9/MQJThoTMS7jTPEA+xfWWrQIY/3ZSQLU/UzMvPqjB5uIYzrcXMp6Vx51uqP6u
	uGKoZUnZFpGEkvKmCb5hKcGyMX9fzWXfqDXPvtZMQi52tLIMa7G8eKc+782IMf4xw4+v5E3x9rE
	6xryu7cUSTckxDgHWsVO1nNEqQgmfAmB69pG04yEAux96rJKddnVTs3YHdJSRczv1okoOGi0L6K
	gdLVh8TflcSsv/IgIUsi3qTLMeV+X4FEdX1aQ9l4WAmUHlIdzBIh9Myb3g56nzuoO7kxCrrSp0V
	ot2vRiomk6Q3vNorUV3bLppJrPP9VAAFQORbAE58bSHEJQyQt+2yyXjsy6CzQh0LLkKD9OdqISw
	HSxW/aNr4xdL9Al47Oix3PwATZlQAZttdbrEkC7G0NacOppfy3+a5Zsa1p2bXm8I/Y07R0ShfOO
	S89aJF2GHweVgKX1a6LUkt0sJM8QzBKugoAZrW6dvpbwp5XI9AzLxMYxPffX2tgw24vrHhYUhA4
	o5
X-Received: by 2002:a05:6a00:3d0c:b0:8a0:237:36fb with SMTP id d2e1a72fcca58-8bc1a493a8fmr3169799b3a.8.1794415577656;
        Wed, 11 Nov 2026 08:46:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab8ded4dsm2372288b3a.54.2026.11.11.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 03/29] bpf: Construct scalar evolution expressions without allocations
Date: Wed, 11 Nov 2026 16:45:26 +0000
Message-ID: <20261111164557.2659679-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

This is about the cost of scalar evolution. The time in scev.c goes down by
a constant factor: 1.7 per insn, 5 per subprog, 11 for the smallest prog.
No expression changes, only the way expressions are stored and found.

Scalar evolution analyzes loops only. A later patch computes expressions
for whole subprogs, to find the registers that are linked at a conditional
jump:

	j = i + 1;
	if (i > 100)
		return 0;
	use(buf[j]);

Then every prog pays for it, with a loop or without, and 1.8 expressions
are constructed per insn, not 0.13. Two things that a few loops do not feel
would be a third of that cost:

- Per expression: expressions are hash consed, and each bucket of exprs_ht
  is an array of ids of its own. That is a kvrealloc(), charged to the
  memcg, and a kvfree() for every second expression. The hash table has
  max(256, len / 4) buckets and never grows.
- Per loop: the analysis starts with a lookup of (REG r) for all
  267 registers and stack slots. Each subprog would do the same. The first
  one constructs them: 'r0 = 0; exit' would take 180 allocations.

Chain the ids of a bucket through exprs_next[], an array next to exprs[].
exprs_ht[] grows with exprs[]. A load has these three arrays, which double.
(REG r) has the fixed id 2 + r and is not in the hash table.

What it would cost to compute expressions for all code of the selftests,
Cilium, sched_ext, katran, bpfjailer and programs in Rust. The last two
rows are against loops only:

                                           before     after
  allocations in add_expr() per load          471         6
  scev.c for 'r0 = 0; exit'               12.1 us    1.1 us
  scev.c for each more subprog             3.6 us    0.7 us
  scev.c per insn                          485 ns    291 ns
  kernel instructions (perf stat)          +6.2 %    +4.2 %
  load time (veristat)                     +8.5 %    +5.7 %

The allocations go with the chains, the cost per subprog with the fixed
ids, the cost of 'r0 = 0; exit' with both: the first lookups of (REG r)
fill the buckets. Not joining dead registers takes most of what is left.

The time in scev.c is linear in the number of insns before and after, so
small progs gain most: 12 % of the load time up to 100 insns, 3 % from
1000 to 10000, 2 % above.

With loops only, as today, the kernel spends 0.3 % fewer instructions on
loading these progs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 125 +++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 1cb4bc7c0f96..8f8ca69482ca 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -14,6 +14,8 @@
 #define REGS_NUM BPF_SCEV_REGS_NUM
 #define UNKNOWN_EXPR_ID 0
 #define OPAQUE_EXPR_ID  1
+/* (REG r). UNKNOWN, OPAQUE and (REG r) have fixed ids and are not in the hash table. */
+#define REG_EXPR_ID(r)  (2 + (r))
 
 /*
  * BPF instructions use 'code', 'src_reg', 'off' and 'imm' fields for instruction encoding.
@@ -58,12 +60,6 @@ struct expr {
 	};
 };
 
-struct expr_bucket {
-	u32 cnt;
-	u32 cap;
-	u32 ids[];
-};
-
 struct env {
 	bool empty;
 	u32 reg2expr[REGS_NUM];
@@ -96,8 +92,11 @@ struct scev {
 	 * Expressions are identified by id, exprs_ht ensures that
 	 * each expression exists as a unique instance.
 	 * This allows for fast equivalence check: id1 === id2.
+	 * exprs_ht[hash] is the first id of a chain, exprs_next[id] is the next one, 0 ends it.
+	 * Both have exprs_cap elements, like exprs[].
 	 */
-	struct expr_bucket **exprs_ht;
+	u32 *exprs_ht;
+	u32 *exprs_next;
 	struct scev_worklist worklist;
 	struct insn_envs **envs;
 	struct expr *exprs;
@@ -106,7 +105,6 @@ struct scev {
 	 * instruction was visited on a current pass.
 	 */
 	u32 *discovered;
-	u32 exprs_ht_cnt;
 	int exprs_cnt;
 	int exprs_cap;
 	int envs_cnt;
@@ -125,44 +123,58 @@ static int expr_eq(struct expr *a, struct expr *b)
 	return a->op == b->op && a->imm == b->imm;
 }
 
-static int add_expr(struct scev *scev, struct expr e)
+static void exprs_ht_add(struct scev *scev, u32 id)
+{
+	u32 *bucket = &scev->exprs_ht[expr_hash(&scev->exprs[id]) & (scev->exprs_cap - 1)];
+
+	scev->exprs_next[id] = *bucket;
+	*bucket = id;
+}
+
+/* @cap is a power of two. No warning for a size that kvmalloc() rejects. */
+static int grow_exprs(struct scev *scev, u32 cap)
 {
-	struct expr_bucket *bucket;
-	u32 i, id, hash, new_cap;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_NOWARN;
 	void *tmp;
+	u32 id;
 
-	hash = expr_hash(&e) & (scev->exprs_ht_cnt - 1);
-	bucket = scev->exprs_ht[hash];
+	tmp = kvrealloc(scev->exprs, array_size(cap, sizeof(*scev->exprs)), gfp);
+	if (!tmp)
+		return -ENOMEM;
+	scev->exprs = tmp;
+	tmp = kvrealloc(scev->exprs_next, array_size(cap, sizeof(u32)), gfp);
+	if (!tmp)
+		return -ENOMEM;
+	scev->exprs_next = tmp;
+	tmp = kvrealloc(scev->exprs_ht, array_size(cap, sizeof(u32)), gfp);
+	if (!tmp)
+		return -ENOMEM;
+	scev->exprs_ht = tmp;
+	scev->exprs_cap = cap;
+	memset(scev->exprs_ht, 0, array_size(cap, sizeof(u32)));
+	for (id = REG_EXPR_ID(REGS_NUM); id < scev->exprs_cnt; id++)
+		exprs_ht_add(scev, id);
+	return 0;
+}
 
-	if (bucket) {
-		for (i = 0; i < bucket->cnt; i++) {
-			id = bucket->ids[i];
-			if (expr_eq(&e, &scev->exprs[id]))
-				return id;
-		}
-	}
+static int add_expr(struct scev *scev, struct expr e)
+{
+	u32 id;
 
-	if (!bucket || bucket->cap == bucket->cnt) {
-		new_cap = bucket ? bucket->cap * 2 : 4;
-		bucket = kvrealloc(bucket, sizeof(*bucket) + sizeof(u32) * new_cap, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!bucket)
-			return -ENOMEM;
-		scev->exprs_ht[hash] = bucket;
-		bucket->cap = new_cap;
-	}
+	if (e.op == REG)
+		return REG_EXPR_ID(e.params[0]);
 
-	if (scev->exprs_cnt == scev->exprs_cap) {
-		new_cap = scev->exprs_cap ? scev->exprs_cap * 2 : 256;
-		tmp = kvrealloc(scev->exprs, sizeof(struct expr) * new_cap, GFP_KERNEL_ACCOUNT);
-		if (!tmp)
-			return -ENOMEM;
-		scev->exprs = tmp;
-		scev->exprs_cap = new_cap;
-	}
+	id = scev->exprs_ht[expr_hash(&e) & (scev->exprs_cap - 1)];
+	for (; id; id = scev->exprs_next[id])
+		if (expr_eq(&e, &scev->exprs[id]))
+			return id;
+
+	if (scev->exprs_cnt == scev->exprs_cap && grow_exprs(scev, scev->exprs_cap * 2))
+		return -ENOMEM;
 
 	id = scev->exprs_cnt++;
 	scev->exprs[id] = e;
-	bucket->ids[bucket->cnt++] = id;
+	exprs_ht_add(scev, id);
 	return id;
 }
 
@@ -182,11 +194,6 @@ static int expr1(struct scev *scev, u32 op, int a)
 	return expr2(scev, op, a, 0);
 }
 
-static int expr0(struct scev *scev, u32 op)
-{
-	return expr2(scev, op, 0, 0);
-}
-
 static int imm_expr(struct scev *scev, s64 value)
 {
 	return add_expr(scev, (struct expr){ .op = IMM, .imm = value });
@@ -576,10 +583,9 @@ static int replace_reg(struct scev *scev, struct env *e, u32 reg, int id)
 	return 0;
 }
 
-static int setup_initial_loop_env(struct bpf_verifier_env *env, struct env *e, int insn_idx)
+static void setup_initial_loop_env(struct env *e)
 {
-	struct scev *scev = env->scev;
-	int i, err;
+	int i;
 
 	/*
 	 * Initial assignments are of form rX -> rX are needed as seeds for subsequent
@@ -587,12 +593,8 @@ static int setup_initial_loop_env(struct bpf_verifier_env *env, struct env *e, i
 	 * join() will overwrite the them. compute_header_scevs() accounts for register
 	 * states at loop entry.
 	 */
-	for (i = 0; i < REGS_NUM; i++) {
-		err = replace_reg(scev, e, i, expr1(scev, REG, i));
-		if (err)
-			return err;
-	}
-	return 0;
+	for (i = 0; i < REGS_NUM; i++)
+		e->reg2expr[i] = REG_EXPR_ID(i);
 }
 
 static void forget_call_regs(struct env *e)
@@ -1404,9 +1406,7 @@ static int compute_scev_for_loop(struct bpf_verifier_env *env, int cur_header)
 	header_env = get_loop_env(scev, cur_header, cur_header);
 	if (!header_env)
 		goto nomem;
-	err = setup_initial_loop_env(env, header_env, cur_header);
-	if (err)
-		goto out;
+	setup_initial_loop_env(header_env);
 	err = worklist_push(env, cur_header, cur_header);
 	if (err)
 		goto out;
@@ -1966,10 +1966,8 @@ void bpf_free_scev(struct bpf_verifier_env *env)
 			kfree(envs->entries[j].env);
 		kfree(envs);
 	}
-	if (scev->exprs_ht)
-		for (i = 0; i < scev->exprs_ht_cnt; i++)
-			kvfree(scev->exprs_ht[i]);
 	kvfree(scev->exprs_ht);
+	kvfree(scev->exprs_next);
 	kvfree(scev->worklist.data);
 	kvfree(scev->envs);
 	kvfree(scev->exprs);
@@ -1981,6 +1979,7 @@ void bpf_free_scev(struct bpf_verifier_env *env)
 int bpf_init_scev(struct bpf_verifier_env *env)
 {
 	struct scev *scev;
+	u32 r;
 
 	scev = kzalloc(sizeof(struct scev), GFP_KERNEL_ACCOUNT);
 	if (!scev)
@@ -1988,13 +1987,13 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	env->scev = scev;
 	bpf_mark_reg_known_scalar(&scev->zero_reg, 0);
 	bpf_mark_reg_unknown(&scev->unknown_reg);
-	/* A power of two for hash & (exprs_ht_cnt - 1)` indexing. */
-	scev->exprs_ht_cnt = roundup_pow_of_two(max(256U, DIV_ROUND_UP(env->prog->len, 4)));
-	scev->exprs_ht = kvcalloc(scev->exprs_ht_cnt, sizeof(*scev->exprs_ht), GFP_KERNEL_ACCOUNT);
-	if (!scev->exprs_ht)
-		goto nomem;
-	if (expr0(scev, UNKNOWN) < 0 || expr0(scev, OPAQUE)  < 0)
+	if (grow_exprs(scev, roundup_pow_of_two(REG_EXPR_ID(REGS_NUM))))
 		goto nomem;
+	scev->exprs[UNKNOWN_EXPR_ID] = (struct expr){ .op = UNKNOWN };
+	scev->exprs[OPAQUE_EXPR_ID] = (struct expr){ .op = OPAQUE };
+	for (r = 0; r < REGS_NUM; r++)
+		scev->exprs[REG_EXPR_ID(r)] = (struct expr){ .op = REG, .params = { r, 0 } };
+	scev->exprs_cnt = REG_EXPR_ID(REGS_NUM);
 	scev->envs = kvcalloc(env->prog->len, sizeof(*scev->envs), GFP_KERNEL_ACCOUNT);
 	scev->discovered = kvcalloc(env->prog->len, sizeof(*scev->discovered), GFP_KERNEL_ACCOUNT);
 	if (!scev->envs || !scev->discovered)
-- 
2.55.0

