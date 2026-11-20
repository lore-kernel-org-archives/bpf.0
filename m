Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207954;
	b=COZehWjAPuHvmJ9e7BaEuUez7b75qIb4y4ARz+8+FpffJexTjn/7N99iMsvmQwiv82Y9
	 nssyowwRlSdcEOLGrvxtBTcm/TaM6J+T/wfhg4bwu/d7Li45X6T9upUrWMejt3xVttPvW
	 YLJuppQ2uIEfm/ssEp8wRZQBtezyryWOz1pd+5Y9A8EUQmo14DQG115+Qy3lPx2Vz0Wzt
	 VUmuTbdLO/Siwaz/zvcI/hqAO22SU++SevQpOEnUpB0bL1OdcuIeIfJ59ua9U4hPZgwj/
	 hNNURoEZsnFqttG7IYm41j6fO9zibPmsMzlsiZAXPZUuE6Mxzh1MuybP7jU2i+oKpUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hS8/cIVKL0YBJnzq7OiJYsYnhWhGkkmV4FV5/nW4g3U=;
	b=fB5Raenv1AM6HTpFWN+cSN+YxthTeYceJZhdHaJPGe4hCTfHgNwPxm05gs5M0myFki/v
	 ne3y2AQStmZxsTzjC+Ba80s5AeJZtgMn681iAW1FrWs3d/aVEkUv3tiSZXbMDn/dd7tjP
	 low7TDPQFFauW2HOj+FczsLeV+PJG1cd2rLgvRvph+84r3kYb7qoSXUbrG6oCZnwMf49n
	 gYRSEyV8cuihoepsUM1M8Ja+4mP9bZDg5OMBLPh7c31VPZNeHcVkdmKRKEVmj1E0Yllb0
	 ch2i/rnymqB5shQaY5wY4WZCyBSTum5LLD1ZlKi1FvPnkUW/yo/N1wvH9C6LsYeVOKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIwogFaq;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A2606A6AA
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D02A2606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIwogFaq
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so755559a91.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207951; x=1795812751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hS8/cIVKL0YBJnzq7OiJYsYnhWhGkkmV4FV5/nW4g3U=;
        b=MIwogFaq1RUNh14V9JvHHSSLe25j312IFJf9Ro/ob/jjm5daneU+gUt3NFyNihp2gl
         uPahYiFMNVjX1jxttR+7ae2Cc+I4fIN/oWFEXnrN5Eug9efxacgXEGt7EAPAypt3Sf8W
         v6BWP1trJvQh++CKDI6EUBRWEfVI0RQrT1lflJV+h+LhYc1EaX7k5C3dUj7wbfRBjmw1
         vok2qk1wxq6stD+AWTcLy7U4xTRz1KPAUMu1Vg7WYZcJ23TMYYrFhbXvzgtFmlFPN9FG
         eqTeeZSM1ED+RdLJcS8V71GN20IlyAuwBHNy3ugKCCbJwCKjBZbOImyBWDhDrL4sHAQo
         tipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207951; x=1795812751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hS8/cIVKL0YBJnzq7OiJYsYnhWhGkkmV4FV5/nW4g3U=;
        b=RRr2WB7hLa3L/3Oh3vfHdR0XQFQ4hrptkuHoaWfoPxkytU+VosWLPKy8H/8FSEHfjX
         af9CnRIGnropQZnXroz2jZh3zDM7y8yCWnCTFMX8kwA+7F9EzsDSgWdnxjBGmbU8wRy8
         IE68g2xWVsP5/HJ/g/ij1cxt27jbLunRV+cVKe2FzjdMhH40fyEoTTMzaspEBb5FwhW4
         Qj71IrsQ1H+BV3pORE2hN7P7ozFNx0hVR96YeRTPkKXGMHgyIg+WMVEZk0zAHEt4IYCb
         jYhQZmeyk2palxLykMKntuyu9BBYN7606LHsolZCk/JT9cJk1/T74h5GYNE4Svt/+lDe
         nJMw==
X-Gm-Message-State: APuU4Z8oq8SWPirn5RbR01JR+DJEeoAMAI3ewFNj/Yuyj3qqG6kxQcX6
	p6lscU9V/++n8H6LdDmsB8xMW2ymXkn1Ta221leJ0kR0hBXyZFh4P7FtDjMYiQ==
X-Gm-Gg: AZFdTZcZ4FgVOr5PDyG/KR7ZnsXbwLFxfAEqd7m0Fm8wjzbHuLOD9KTttU0rKL1exjE
	/tSb97JsAogS8ZFegHpB8X4E6DGi06BPm03bnSesFrld4KHDl/++0FRYlsTuuI1iZPzV+LTb8N0
	a2Hb7RCcdDbAxNYL4InjkTBDZJcbA45jOqV9eVVWOso26z/2uI1bhC1NYdrGz2kSyS+Z4zceYmu
	FtjiC61McnKnLjX8WYWg5ShQdTBP7JRdBBIntDPIirmgTky3ZwJ4Uzsj+8kLXV7pc8Zh45UR6PO
	Y8ShBqbT/csNWOh1ah9I7iHH8VzZekraNdNyoQH6xGk25G3/ECxCoBkYI86t7gxYoRISofVrhqO
	Mb1bTWqdTPVjQOojdBP40m8czGFaDa7Ru/V8VLuLcT1cMPSMBS/90dIOXIrvOmFU98wmgF2sR/q
	w7CfoOm+KAUx+VZgek26MiJnREU8a8gPtjxupNNyyx+JxNtSYwXhj/f0trp92rT7XWUT/hm1MYc
	8lZdFr28TKT5hIkIDfoeFhtmu4R11V8AA3zzOG4N2bE79Fm4oAZaqfmxC/nREiGT2joWRtPQAQk
	M39hqxGh+zFlkvrYhw9ZEjaEmvWMeImKFgsoJkGJFb8/pnQu0i80Ej00Ym2XEkscKZx6VPCnIdG
	E+EuBnoiA2g4gxLMi0Xy7/0UvE9MQtXjBaVCeQ+0rAVVroqG1oA/29u7Tb47wQHPR4rKaJq4ZuQ
	==
X-Received: by 2002:a17:90b:2f8f:b0:3b0:d070:3c46 with SMTP id 98e67ed59e1d1-3b41c98a389mr3558793a91.12.1795207950864;
        Fri, 20 Nov 2026 12:52:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b73b2b3sm360941a91.2.2026.11.20.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 25/49] bpf: Join any two states that have the same join_key
Date: Fri, 20 Nov 2026 20:49:33 +0000
Message-ID: <20261120204959.614908-26-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

The old join could fail: a pointer and a number had no join, and the
states stayed apart. So the number of states had no bound but the caps.
The new join is total:

  map ptr  |  scalar      -> unreadable -+
  two objects             -> unreadable -+-> a use is unproven
  p+1, p+2, ... at header -> p+unknown  -+   -> next pass keeps apart

If nothing uses the value, the join costs nothing. An unreadable xreg
can hold a pointer, so __is_pointer_value() is true for it.

A number can grow in each trip of a leftover. The first growth is a
join. After that the bound that moves goes to a threshold:

  do { a[i] = 0; i += 3; } while (i < 30);     29
  while (i < 30) { a[i] = 0; i += 3; }         32

The thresholds are the constants of the loop and of the functions that
it calls, one less, and one step more. They apply to the deps.
Other xregs stop at 0, S32_MAX, U32_MAX or S32_MIN. A threshold is a
guess: the state that comes back is compared with it.
bpf_flow_insn_after() walks the insns of a loop.

The old join compared its result with both inputs on each call. The
new one changes dst in place. It compares the result only with src, and
only with BPF_F_TEST_REG_INVARIANTS.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  24 ++--
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/flow.c            |  12 +-
 kernel/bpf/join.c            | 243 +++++++++++++++++++++++++++++++++++
 kernel/bpf/loops.c           | 108 ++++++++++++++++
 kernel/bpf/verifier.c        |  59 ++++-----
 6 files changed, 399 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f2fea1985ab..1a42a5e1ab2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -863,13 +863,6 @@ struct bpf_loop_per_pass {
 	u64 cost;		/* for the states that the loop keeps apart */
 };
 
-struct bpf_loop_rungs {
-	s64 max[2];
-	s64 min[2];
-	bool has_max;
-	bool has_min;
-};
-
 struct bpf_loop {
 	enum bpf_loop_kind kind;
 	u32 header;
@@ -899,6 +892,10 @@ struct bpf_loop {
 	bool partitioned;	/* the last partition was for this loop */
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
 	struct bpf_loop_per_pass this_pass;
+	/* sorted constants of the loop, the largest and the smallest constant that an insn adds */
+	s64 *thresholds;
+	u32 threshold_cnt, threshold_cap;
+	s32 max_step, min_step;
 	bool guarded;
 };
 
@@ -1686,6 +1683,11 @@ u64 bpf_hash64(const void *p, size_t len, u64 hash);
 u64 bpf_hash_join_key(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
 int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
+/* join.c */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+		    bool widen);
+
 /* precision.c, failing_path.c */
 enum bpf_join_point { BPF_JOIN_POINT, BPF_JOIN_POINT_HEADER, BPF_JOIN_POINT_CALLS };
 bool bpf_must_keep_apart(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
@@ -2291,8 +2293,8 @@ void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar
 void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits);
 void scalar_union(struct scalar *acc, const struct scalar *src);
-void scalar_widen(struct scalar *s, const struct scalar *old,
-		  const struct bpf_loop_rungs *rungs, int linear);
+void scalar_widen(struct scalar *s, const struct scalar *old, s64 min_threshold, s64 max_threshold);
+
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
@@ -2432,8 +2434,10 @@ u8 bpf_rev_opcode(u8 opcode);
 int bpf_compute_idoms(struct bpf_verifier_env *env);
 int bpf_compute_loops(struct bpf_verifier_env *env);
 int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
+int bpf_flow_insn_after(struct bpf_verifier_env *env, int idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
-
+u32 bpf_loop_thresholds_below(const struct bpf_loop *loop, s64 k);
+int bpf_loop_collect_thresholds(struct bpf_verifier_env *env, struct bpf_loop *loop);
 int bpf_insn_callee(struct bpf_verifier_env *env, int idx);
 
 /* equation.c */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2fa6065b0d9..bd26c6f563e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -753,6 +753,7 @@ static void free_loop(struct bpf_loop *loop)
 {
 	if (!loop)
 		return;
+	kvfree(loop->thresholds);
 	kvfree(loop);
 }
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index f8e8ea7b05a..0d9bd4652bb 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -16,6 +16,7 @@ struct flow_kept {
 struct bpf_flow {
 	/* computed once */
 	u32 *pos;			/* place of the insn in the order */
+	s32 *insn_after;		/* the next insn in the order, or -1 */
 };
 
 /*
@@ -32,7 +33,7 @@ struct bpf_flow {
 static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flow)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	int len = env->prog->len, i, s, n, h, top, depth;
+	int len = env->prog->len, i, s, n, h, top, depth, prev = -1;
 	int *next, *head, *tail, *stack;
 	unsigned long *linked;
 	u32 pos = 0;
@@ -82,6 +83,10 @@ static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flo
 				continue;
 			}
 			flow->pos[n] = pos++;
+			flow->insn_after[n] = -1;
+			if (prev >= 0)
+				flow->insn_after[prev] = n;
+			prev = n;
 			if (aux[n].loop && head[n] >= 0) {
 				stack[depth++] = n;
 				n = head[n];
@@ -100,6 +105,11 @@ static int flow_compute_order(struct bpf_verifier_env *env, struct bpf_flow *flo
 	return err;
 }
 
+int bpf_flow_insn_after(struct bpf_verifier_env *env, int idx)
+{
+	return env->flow->insn_after[idx];
+}
+
 /* Does the insn at @idx stop the loop @h? */
 static bool flow_is_bound(struct bpf_verifier_env *env, int h, int idx)
 {
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 782a7c3f934..9b9cddfa124 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -1,5 +1,248 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Join of verifier states.
+ *
+ * Two states at one insn with the same join_key always have a join, see bpf_same_join_key().
+ *
+ *  map ptr  |  scalar      -> unreadable -+
+ *  two objects             -> unreadable -+-> a use is unproven -> partition
+ *  p+1, p+2, ... at header -> p+unknown  -+
+ *
+ * Values of one type and object differ only in a number, see bpf_same_type_and_object().
+ * Numbers are joined. At a loop header they are widened, so the sequence of states ends.
+ *
+ * bpf_clean_verifier_state() cleans the inputs: dead xregs are the same in both.
+ */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/cnum.h>
 #include <linux/filter.h>
+
+struct join {
+	struct bpf_verifier_env *env;
+	struct bpf_verifier_state *dst;
+	struct bpf_loop *leftover_loop;	/* the states are at its header, in its leftover */
+	bool widen;
+	u32 fr;
+	u32 xregno;		/* see MAX_BPF_XREG, BPF_REG_FP for stack args */
+	int err;
+};
+
+/*
+ * A number can grow in each trip. The bound that moved goes to a threshold. The constants of
+ * the loop give the thresholds:
+ *	do { a[i] = 0; i += 3; } while (i < 30);		29 at most comes back to the header
+ *	while (i < 30) { a[i] = 0; i += 3; }			32
+ *	loop { if (...) { if (n >= 64) break; a[n++] = x; } }	64
+ * A threshold is a guess. The state that comes back to the header is compared with it.
+ *
+ * Only a number on a cycle grows again and again. So the first growth is a join.
+ *	x = 0; loop { a[x]; x = rnd & 7; }
+ */
+static void join_range(struct join *j, struct bpf_reg_state *dst, const struct bpf_reg_state *src)
+{
+	s64 min_threshold = S64_MIN, max_threshold = S64_MAX, off;
+	struct bpf_loop *loop = j->leftover_loop;
+	struct bpf_reg_state old = *dst;
+	bool in_deps;
+	int i, n;
+
+	if (scalar_equal(scalar_of(dst), scalar_of(src)))
+		return;
+	scalar_union(scalar_of(dst), scalar_of(src));
+	if (loop && !scalar_equal(scalar_of(dst), scalar_of(&old))) {
+		if (!j->widen || !old.grew_once)
+			goto out;
+		/* two pointers are compared by their offsets up to there */
+		if (dst->type != SCALAR_VALUE) {
+			if (reg_smax(dst) < BPF_MAX_VAR_OFF)
+				max_threshold = BPF_MAX_VAR_OFF - 1;
+			if (reg_smin(dst) > -BPF_MAX_VAR_OFF)
+				min_threshold = -BPF_MAX_VAR_OFF + 1;
+		}
+		in_deps = bpf_xreg_in_deps(j->env, j->dst, j->fr, j->xregno);
+		if (in_deps)
+			j->err = j->err ?: bpf_loop_collect_thresholds(j->env, loop);
+		/* at the constant or one before it, and the largest step or this step further */
+		for (i = 0; i < 6 && in_deps && !j->err; i++) {
+			off = i & 4 ? reg_smax(dst) - reg_smax(&old) : i & 2 ? loop->max_step : 0;
+			off -= i & 1;
+			n = bpf_loop_thresholds_below(loop, reg_smax(dst) - off);
+			if (n < loop->threshold_cnt && loop->thresholds[n] + off >= reg_smax(dst))
+				max_threshold = min(max_threshold, loop->thresholds[n] + off);
+			off = i & 4 ? reg_smin(dst) - reg_smin(&old) : i & 2 ? loop->min_step : 0;
+			off += i & 1;
+			n = bpf_loop_thresholds_below(loop, reg_smin(dst) - off + 1);
+			if (n && loop->thresholds[n - 1] + off <= reg_smin(dst))
+				min_threshold = max(min_threshold, loop->thresholds[n - 1] + off);
+		}
+		scalar_widen(scalar_of(dst), scalar_of(&old), min_threshold, max_threshold);
+out:
+		dst->grew_once = true;
+	}
+	if (!bpf_scalar_subsumes(dst, &old) || !bpf_scalar_subsumes(dst, src))
+		scalar_set_unknown(scalar_of(dst));
+}
+
+/*
+ * Pointers to the packet that share an id keep their displacement. No id is an id too:
+ * the start of the packet plus a constant, see find_good_pkt_pointers().
+ */
+static u32 join_pkt_id(struct bpf_verifier_env *env, const struct bpf_reg_state *ra,
+		       const struct bpf_reg_state *rb)
+{
+	struct bpf_pkt_pair new = { ra->id, rb->id, rb->r64.base - ra->r64.base, ra->type, ra->id };
+	struct bpf_pkt_pair *p = env->pkt_pairs;
+	bool taken = !ra->id;
+
+	bpf_add_cost(env, env->pkt_pair_cnt, BPF_COST_SCAN);
+	for (; p < env->pkt_pairs + env->pkt_pair_cnt; taken |= p++->id == ra->id)
+		if (!memcmp(p, &new, offsetof(struct bpf_pkt_pair, id)))
+			return p->id;
+	if (taken && (new.old || new.cur || new.delta))
+		new.id = bpf_new_id(env);
+	/* with no memory the load fails, see bpf_check_limits() */
+	bpf_add_pkt_pair(env, &new);
+	return new.id;
+}
+
+/* The bytes that are left after the pointer in both states are left in the join */
+static void join_pkt(struct join *j, struct bpf_reg_state *dst, const struct bpf_reg_state *src)
+{
+	struct bpf_reg_state old = *dst;
+	struct cnum64 both = cnum64_union(old.r64, src->r64);
+
+	dst->id = join_pkt_id(j->env, &old, src);
+	join_range(j, dst, src);
+	dst->pkt_min_len = min(pkt_min_len(&old), pkt_min_len(src));
+	if (old.r64.size == dst->r64.size && src->r64.size == dst->r64.size) {
+		if (old.range != src->range)
+			dst->range = max(min(old.range, src->range), 0);
+		return;
+	}
+	if (pkt_has_bytes_left(&old) && pkt_has_bytes_left(src) && pkt_has_bytes_left(dst))
+		dst->range = reg_smax(dst) + min(pkt_bytes_left(&old), pkt_bytes_left(src));
+	else
+		dst->range = 0;
+	dst->range = max(dst->range, dst->pkt_min_len);
+	/* pointers that share an id have ranges of the same size */
+	if (cnum64_umax(dst->r64) > MAX_PACKET_OFF || dst->r64.size != both.size)
+		dst->id = bpf_new_id(j->env);
+}
+
+static void join_reg(struct join *j, struct bpf_reg_state *dst, const struct bpf_reg_state *src)
+{
+	bool from_unproven = dst->from_unproven || (src && src->from_unproven);
+
+	if (!src || dst->type == NOT_INIT || !bpf_same_type_and_object(j->env, dst, src))
+		bpf_mark_reg_not_init(j->env, dst);
+	else if (type_is_pkt_pointer(dst->type))
+		join_pkt(j, dst, src);
+	else if (base_type(dst->type) != PTR_TO_ARENA) /* its offset is not tracked */
+		join_range(j, dst, src);
+	dst->from_unproven = from_unproven;
+}
+
+/* What a byte of a slot is if the number in the slot is not known */
+static u8 join_byte(struct bpf_stack_state *s, int i)
+{
+	if (s->slot_type[i] != STACK_SPILL)
+		return s->slot_type[i];
+	return bpf_register_is_null(&s->spilled_ptr) ? STACK_ZERO : STACK_MISC;
+}
+
+static bool byte_is_set(u8 t)
+{
+	return t != STACK_INVALID && t != STACK_POISON;
+}
+
+static void join_slot(struct join *j, struct bpf_stack_state *dst, struct bpf_stack_state *src)
+{
+	u8 x, y, ptr_type = STACK_SPILL;
+	bool ptr;
+	int i;
+
+	/* it is in the join_key */
+	if (bpf_slot_is_held(dst))
+		return;
+	if (!memcmp(dst->slot_type, src->slot_type, sizeof(dst->slot_type))) {
+		if (bpf_is_spilled_reg(dst))
+			join_reg(j, &dst->spilled_ptr, &src->spilled_ptr);
+		return;
+	}
+	ptr = (bpf_is_spilled_reg(dst) && !bpf_is_spilled_scalar_reg(dst)) ||
+	      (bpf_is_spilled_reg(src) && !bpf_is_spilled_scalar_reg(src));
+	/* a byte that is possibly not written is not read, not even into an unreadable register */
+	for (i = 0; i < BPF_REG_SIZE && !j->env->allow_uninit_stack; i++)
+		if (!byte_is_set(dst->slot_type[i]) || !byte_is_set(src->slot_type[i]))
+			ptr_type = STACK_INVALID;
+	for (i = 0; i < BPF_REG_SIZE; i++) {
+		x = join_byte(dst, i);
+		y = join_byte(src, i);
+		dst->slot_type[i] = ptr ? ptr_type : !byte_is_set(x) || x == y ? x :
+				    !byte_is_set(y) ? STACK_INVALID : STACK_MISC;
+	}
+	bpf_mark_reg_not_init(j->env, &dst->spilled_ptr);
+}
+
+static void join_func(struct join *j, struct bpf_func_state *dst, struct bpf_func_state *src,
+		      u16 live_regs)
+{
+	static struct bpf_stack_state invalid_slot;
+	const struct loop_stack_entry *s;
+	struct loop_stack_entry *d;
+	u32 i;
+
+	for (i = 0; i < dst->loop_stack_cnt; i++) {
+		d = &dst->loop_stack[i];
+		s = &src->loop_stack[i];
+		d->trip = max(d->trip, s->trip);
+		d->held_cnt = min(d->held_cnt, s->held_cnt);
+	}
+	for (i = 0; i < BPF_REG_FP; i++) {
+		j->xregno = i;
+		if (live_regs & BIT(i))
+			join_reg(j, &dst->regs[i], &src->regs[i]);
+		else
+			bpf_mark_reg_not_init(j->env, &dst->regs[i]);
+	}
+	/* slots and arguments that only @src has are unreadable */
+	for (i = 0; i < bpf_stack_nr_slots(dst); i++) {
+		j->xregno = bpf_spi_to_xreg(i);
+		join_slot(j, bpf_stack_slot(dst, i),
+			  i < bpf_stack_nr_slots(src) ? bpf_stack_slot(src, i) : &invalid_slot);
+	}
+	j->xregno = BPF_REG_FP;
+	for (i = 0; i < dst->out_stack_arg_cnt; i++)
+		join_reg(j, &dst->stack_arg_regs[i],
+			 bpf_stack_arg(dst, src, i) ? bpf_stack_arg(src, dst, i) : NULL);
+	dst->no_stack_arg_load |= src->no_stack_arg_load;
+	dst->callback_depth = min(dst->callback_depth, src->callback_depth);
+}
+
+/*
+ * Make @dst describe all that @dst or @src describe. They have the same join_key.
+ * Both are speculative, or neither is.
+ * @leftover_loop: they are at its header, in its leftover.
+ */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *src, struct bpf_loop *leftover_loop,
+		    bool widen)
+{
+	struct join j = { .env = env, .dst = dst, .leftover_loop = leftover_loop, .widen = widen };
+
+	bpf_add_cost(env, bpf_xreg_cnt(dst), BPF_COST_XREG);
+	env->pkt_pair_cnt = 0;
+	env->imprecise |= !env->err;
+	dst->suspect_loops |= src->suspect_loops;
+	for (j.fr = 0; j.fr <= dst->curframe; j.fr++)
+		join_func(&j, dst->frame[j.fr], src->frame[j.fr],
+			  env->insn_aux_data[bpf_frame_insn_idx(dst, j.fr)].live_regs_before);
+	dst->max_held_cnt = max(dst->max_held_cnt, src->max_held_cnt);
+	/* no equation is found over a limit */
+	if (env->test_reg_invariants && !bpf_state_subsumes(env, dst, src) &&
+	    verifier_bug_if(!bpf_check_limits(env), env, "join at %d", dst->insn_idx))
+		return -EFAULT;
+	/* the first xreg that had an id can be gone */
+	return j.err ?: bpf_renumber_ids(env, dst);
+}
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index f8b2f8befa6..bb8cb4fedc5 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/bpf_verifier.h>
 
 static bool is_cfg_jump(struct bpf_insn *insn)
@@ -555,3 +556,110 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 	kvfree(dfs.state);
 	return err;
 }
+
+static int cmp_thresholds(const void *a, const void *b)
+{
+	return *(s64 *)a < *(s64 *)b ? -1 : *(s64 *)a > *(s64 *)b;
+}
+
+static int add_threshold(struct bpf_verifier_env *env, struct bpf_loop *loop, s64 k)
+{
+	if (!bpf_grow_array(env, &loop->thresholds, &loop->threshold_cap, loop->threshold_cnt + 1,
+			    sizeof(k)))
+		return -ENOMEM;
+	loop->thresholds[loop->threshold_cnt++] = k;
+	return 0;
+}
+
+static int add_insn_thresholds(struct bpf_verifier_env *env, struct bpf_loop *loop, int idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	bool alu = class == BPF_ALU || class == BPF_ALU64;
+	bool cmp = bpf_insn_is_cond_jump(insn->code);
+	u8 reg;
+
+	if (bpf_is_ldimm64(insn) && !insn->src_reg)
+		return add_threshold(env, loop, (u32)insn->imm | (u64)insn[1].imm << 32);
+	if (class != BPF_ST && !cmp && !alu)
+		return 0;
+	if (class != BPF_ST && BPF_SRC(insn->code) == BPF_X) {
+		reg = aux->const_reg_mask & BIT(insn->src_reg) ? insn->src_reg : insn->dst_reg;
+		return cmp && (aux->const_reg_mask & BIT(reg)) ?
+		       add_threshold(env, loop, aux->const_reg_vals[reg]) : 0;
+	}
+	if (!alu || (op != BPF_ADD && op != BPF_SUB))
+		return add_threshold(env, loop, insn->imm);
+	if (insn->imm != S32_MIN && !(aux->stack_ptrs & BIT(insn->dst_reg))) {
+		loop->max_step = max(loop->max_step, op == BPF_ADD ? insn->imm : -insn->imm);
+		loop->min_step = min(loop->min_step, op == BPF_ADD ? insn->imm : -insn->imm);
+	}
+	return 0;
+}
+
+/* The number of constants of @loop that are below @k */
+u32 bpf_loop_thresholds_below(const struct bpf_loop *loop, s64 k)
+{
+	u32 lo = 0, hi = loop->threshold_cnt, mid;
+
+	while (lo < hi) {
+		mid = lo + (hi - lo) / 2;
+		if (loop->thresholds[mid] < k)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+	return lo;
+}
+
+/* The constants in the body of @loop and in the functions that it calls */
+int bpf_loop_collect_thresholds(struct bpf_verifier_env *env, struct bpf_loop *loop)
+{
+	struct bpf_subprog_info *sub = bpf_find_containing_subprog(env, loop->header);
+	u32 words = BITS_TO_LONGS(env->subprog_cnt);
+	unsigned long *todo, *done;
+	int i, s, n, err = 0;
+
+	if (loop->threshold_cnt || !loop->nr_insns)
+		return 0;
+	todo = kvcalloc(2 * words, sizeof(long), BPF_VERIFIER_GFP);
+	if (!todo)
+		return -ENOMEM;
+	done = todo + words;
+	/* the insns of a loop follow its header, see flow_compute_order() */
+	i = loop->header;
+	n = loop->kind == BPF_LOOP_CALLBACK ? 1 : loop->nr_insns;
+	for (;;) {
+		err = err ?: bpf_add_cost_and_check(env, n, BPF_COST_XREG);
+		for (; n-- && i >= 0 && i < sub[1].start && !err; i = bpf_flow_insn_after(env, i)) {
+			err = add_insn_thresholds(env, loop, i);
+			s = bpf_insn_callee(env, i);
+			if (s > 0 && !bpf_subprog_is_global(env, s) && !__test_and_set_bit(s, done))
+				__set_bit(s, todo);
+		}
+		bpf_add_cost(env, words, BPF_COST_SCAN);
+		s = find_first_bit(todo, env->subprog_cnt);
+		if (s == env->subprog_cnt)
+			break;
+		__clear_bit(s, todo);
+		sub = &env->subprog_info[s];
+		i = sub->start;
+		n = sub[1].start - i;
+	}
+	kvfree(todo);
+	err = err ?: add_threshold(env, loop, 0) ?:
+	      bpf_add_cost_and_check(env, loop->threshold_cnt * ilog2(loop->threshold_cnt),
+				     BPF_COST_COPY);
+	if (err) {
+		/* only the pass ends, the next pass starts again */
+		loop->threshold_cnt = 0;
+		return err;
+	}
+	sort(loop->thresholds, loop->threshold_cnt, sizeof(s64), cmp_thresholds, NULL);
+	for (i = 1, n = 1; i < loop->threshold_cnt; i++)
+		if (loop->thresholds[i] != loop->thresholds[n - 1])
+			loop->thresholds[n++] = loop->thresholds[i];
+	loop->threshold_cnt = n;
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce26d681bb0..e72a58d34f5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3561,7 +3561,8 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	if (allow_ptr_leaks)
 		return false;
 
-	return is_pointer_regtype(reg->type);
+	/* an unreadable xreg can have a pointer */
+	return reg->type != SCALAR_VALUE;
 }
 
 static void save_register_state(struct bpf_verifier_env *env,
@@ -11552,8 +11553,9 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 {
 	u16 live = env->insn_aux_data[env->subprog_info[subprog].start].live_regs_before;
 	struct bpf_verifier_state *state = env->cur_state;
-	struct bpf_func_state *caller = state->frame[state->curframe], *callee;
+	struct bpf_func_state *caller = state->frame[state->curframe], *callee, *frame;
 	struct bpf_verifier_state entry = {};
+	struct bpf_reg_state *reg;
 	int i, err;
 
 	callee = kzalloc_obj(*callee, BPF_VERIFIER_GFP);
@@ -11583,6 +11585,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 		bpf_free_verifier_state(env, &entry, false);
 		return err;
 	}
+	bpf_for_each_reg_in_vstate(&entry, frame, reg, reg->grew_once = false);
 	entry.max_held_cnt = state->max_held_cnt;
 	callee->entry_refs = entry.acquired_refs;
 	callee->entry_rcu_locks = entry.active_rcu_locks;
@@ -17973,61 +17976,43 @@ void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax)
 
 /*
  * @s is what @old became after a trip around a cycle, @old included. The end
- * of the range that moved is going to move again. Put it where it may come
- * to rest. There are few such places, so this is done a few times at most.
- * @rungs: where the jumps of the loop stop it, if they do.
- * It's put at the nearest of all these places: every value between the range and the place is
- * made up, and the program is checked with it. Wherever it's put, the range only gets larger.
- * @linear: every iteration adds a constant to it, in that many bits. Then nothing but a jump
- * stops it. If there is none ahead it goes on until it wraps, and is any number of that many bits.
+ * of the range that moved will move again. Move it to a threshold where it
+ * can stop. @min_threshold, @max_threshold: the caller guesses that it stops there.
+ * Take the nearest threshold. Each value between the range and the threshold is made up,
+ * and the program is checked with it. With each threshold the range only gets larger.
  */
-void scalar_widen(struct scalar *s, const struct scalar *old,
-		  const struct bpf_loop_rungs *rungs, int linear)
+void scalar_widen(struct scalar *s, const struct scalar *old, s64 min_threshold, s64 max_threshold)
 {
 	bool moved = s->r64.base != old->r64.base || s->r64.size != old->r64.size ||
 		     s->r32.base != old->r32.base || s->r32.size != old->r32.size;
-	s64 min = cnum64_smin(s->r64), max = cnum64_smax(s->r64), stop;
+	s64 min = cnum64_smin(s->r64), max = cnum64_smax(s->r64), threshold;
 
 	/* Only the step got weaker. It comes to rest without help, see below. */
 	if (!moved && s->var_off.value == old->var_off.value &&
 	    s->var_off.mask == old->var_off.mask)
 		return;
 
-	if (linear &&
-	    ((max > cnum64_smax(old->r64) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
-	     (min < cnum64_smin(old->r64) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
-		if (linear == 64 || min < 0 || max > U32_MAX) {
-			scalar_set_unknown(s);
-			return;
-		}
-		min = 0;
-		max = U32_MAX;
-	}
 	if (max > cnum64_smax(old->r64)) {
-		stop = max <= 0 ? 0 :
-		       max <= S32_MAX ? S32_MAX :
-		       max <= U32_MAX ? U32_MAX : S64_MAX;
-		if (rungs && rungs->has_max && max <= rungs->max[1])
-			stop = min(stop, max <= rungs->max[0] ? rungs->max[0] : rungs->max[1]);
-		max = stop;
+		threshold = max <= 0 ? 0 :
+			    max <= S32_MAX ? S32_MAX :
+			    max <= U32_MAX ? U32_MAX : S64_MAX;
+		max = min(threshold, max_threshold);
 	}
 	if (min < cnum64_smin(old->r64)) {
-		stop = min >= 0 ? 0 :
-		       min >= S32_MIN ? S32_MIN : S64_MIN;
-		if (rungs && rungs->has_min && min >= rungs->min[1])
-			stop = max(stop, min >= rungs->min[0] ? rungs->min[0] : rungs->min[1]);
-		min = stop;
+		threshold = min >= 0 ? 0 :
+			    min >= S32_MIN ? S32_MIN : S64_MIN;
+		min = max(threshold, min_threshold);
 	}
 	if (min == S64_MIN && max == S64_MAX) {
 		scalar_set_unknown(s);
 		return;
 	}
 	/*
-	 * A fixed stop is a guess. A number of 32 bits that gets past S32_MAX comes to rest at
-	 * U32_MAX. What gets past S32_MAX, U32_MAX or S32_MIN and out of 32 bits is stopped by
-	 * nothing:
+	 * A fixed threshold is a guess. A number of 32 bits that gets past S32_MAX stops at
+	 * U32_MAX. No threshold stops what gets past S32_MAX, U32_MAX or S32_MIN and out of
+	 * 32 bits:
 	 *	sum += a[i]; if (sum == 77) ...
-	 * It wraps in the next pass, and the other bound is gone as well.
+	 * It wraps in the next trip, and the other bound is gone as well.
 	 */
 	if ((max == S64_MAX &&
 	     (cnum64_smax(old->r64) == S32_MAX || cnum64_smax(old->r64) == U32_MAX)) ||
-- 
2.55.0

