Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206857;
	b=BzHq64SdIoQM/gAqlXCuB0cS9lpdpkDrgfYoens/1DFoE6vGNLkrR9QNiP0Ks5O++CeF
	 5EbeUEfvqZELh+21VT9eiG6gpzqB64Wlq7mcOkqzc6D78tYQjk1ntgeWJqqFoSVAS91tx
	 uqnAktRG79ApyvF21YCPUDV5XlbWSt8oMbUghQgsh6bmdtVm2b8jq4cQrYcDOpVyaeGVA
	 AJ1ClikcEVVfZAw67z+FQJ+OaD6rVLG0NFS7sMvWRXYBp8hZWFzE3c6cUwtcBw5q3/n9Q
	 n1fLEuGENwde2iMNtLGmpo7NpRCFyjV6UgENWKwYbpzGV8XgcqP86/0Ia73mbh6KGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
	b=bv9/U2S8r8cmTcZjjCHs90lV5RtIPU7bgM/z9v9JCdp1BQmXGLjpsQ8FqOOEcNeceWFr
	 0sYIYv+Cut0cXdQuVYUwFJfcVLHAB+2V/nWv0QgKyyMRnlE7WnH9FvDFjKuM1IBJpHj09
	 yXeyb+k8X0eNvbHFmtXhPtwpyriC2+BENIokbsG8sZrOgsciGoEoJ3Xu97n5Wo+x7QhmZ
	 d0OPsOl8G679JqQBAMcTtqZca6Pt1yQFW99zNEjzBT/DUoiCzA2HnHPbDI4mMBZpCM+Hf
	 WSc+KcFuijJ1L6J9UOEAkIVdJncPUbBQI2QcmJ2b8DQyCqGqp4XzEAz8hD5HAD4Ck7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wcq+WW2B;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04809606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04809606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wcq+WW2B
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so225996b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206856; x=1794811656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
        b=Wcq+WW2BTuBbTrYendPokA4oc1Jt4NpKjQR7kQicZvQtp+niauQ/gJnsR+P+XwxzoJ
         wvFG9tXZtwssbR4ExBSHcLQcvYkF7HiBh1UV/8TJHcsu8bmfGu3u4swoDjM9xQyZpLWc
         AfIV0ViVhpzxhZ15rwM3jyWBZN5NDcGOEYOGKUXsEuQ5RJPcu4rtzqFAqzC5zO5+UsOi
         YH/SBodv3edLeU0btkomjqSDzVF/eo/XRbcZYH8rfudVuIuy12eQ5v0w37JVxtU7CL/i
         duaCc34f++EhusuCWe6prA+UVuRCHyQkIkskKUwrZ2sx1hdObrwiEZtdixaCwXnBv8CL
         rfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206856; x=1794811656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZrpLqYxg7j9G9nBlkn/W+YsrzIcvzIAr+qoqAFOCiI=;
        b=B7wyQBv7Uv/JzcLFiISlgFXIW7W8QeJ+QGX2GtW4k4DIyHDOx0EZhQwQrbZ/hDBonT
         Rc1DYJoJFiWg3JNiryyE96bYiSsjDQR6702UiypxkAV0y73hpy+E0Y24Aj+FDANJ+rb3
         u9fhNB/zznpHcqp1jO59KPpVF0VkG0naTVaWTjiPUu99z0s6jruQ30FM3zVhw61QeEoq
         U31GBmYtpHTG4UcMjAneq0oozDvcxvDbXzdx12M4OQApKQvluvJjWNWQ+/abX1rROtSU
         ALbmeiOdwH+LYLnwKdvX4ClwPABcEe3cRTy7bCS00mEuFHBdaoxO9KfdM+TSAa4G8jif
         L8FA==
X-Gm-Message-State: APuU4Z8U2hihHCvQzD4nI2XKGK0KAFZu4oUGRovMFSpZhr3GqWoQ0XdT
	kl4AljF283Rk8Jyy7LzYy0F8Agdcm9N7hnGgj59wXrnsBMLROjkKWM7WrPFY3w==
X-Gm-Gg: AYBFou0XL6b1YEWY3Hwfpa/dLNb0XQKYreyVVKooNnGZ5LGdqfK9zf+L3PSIdNHjM6Z
	euUVLDyv/txXDDLsI9J1BkaV/1Xl4lwUN7vN3wcl/WNAumUtY59p4iFRRHupYVzXry1dPmu71kv
	iSh6v8xu5hLyJPYnpp3GENmU9jWbmjh9IaDOqO8asLwCUka1KERNQupzR+fOUEvMKQugk9MpxjP
	R8u1OmsautRloYxA0GIpM/Yyl7xseQd/Bv+BEz12dhVRrcfHyyqCKNya11QK+Tb1dHwpZO9M/cI
	LF+cixPdzGcOfsRn+u2Nanqj/w8Btp/5DUxtbOsPzOXGyVq8vU3vgn11g7TRqptm2thE218TEaT
	CuC7tCextYgnkH1Jj3AvcxXiJJRVP8r80AVrtoP6kRnfBVazRYiZtirM9lzyjGX3L82ZjGqpXW0
	OeZ7ULwPfsIit9/lEIA1tX21VmX/uOHo4fKu9DtDWgpJYWZmiHbwU/NBVZpyMStc7qAoQxkFlpm
	jECqXE/yKRie2odT4mo7tbjGIvrTTgcRHu8UXYV1ggGzALHB2G9vzgPAGx7e2gwq/U9ffddbOUs
	+FFCTeK8fPpnHogZNPOrcS1LQbha+fOIbj/EKYNZYabQ//26X1tGFrXFth6jG9BwpCrEvKRN2HJ
	5BU6Hr/n+4kg/rdUrfIQwMXtsxJ0Hicza+EzU3izP48BWbVd6nZ1Pf1uH8RO5wYL+RJiQ18G+b1
	KfenxJqIgm4cL3S6D4afc=
X-Received: by 2002:a05:6a00:981:b0:8b6:ca80:1ad6 with SMTP id d2e1a72fcca58-8b6ca801c74mr1718378b3a.45.1794206855900;
        Sun, 08 Nov 2026 22:47:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b646bd4af6sm977561b3a.2.2026.11.08.22.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 03/26] bpf: Construct scalar evolution expressions without allocations
Date: Mon,  9 Nov 2026 06:46:47 +0000
Message-ID: <20261109064715.2382452-4-alexei.starovoitov@gmail.com>
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

