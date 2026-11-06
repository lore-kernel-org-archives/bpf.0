Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937092;
	b=E8VZVkEkyimUPCU9WJSFXT7zrYo+JxZtRJGal1zZ+IeEbTS9tlO/E2Xm8cg+gnkDaE65
	 CX168NNVSeS8arfR+Vb2eTOMUBj15y2mKNYR+4DgE3UGUNBbIKjIqkCRcxsRyO7oGagaL
	 SLMs4uGhFNJ8pm1EXR8EX8eaykcEXelZ5B/zopRWfuBIG6lbvVb/G0EYdedRgQuvpA2gr
	 3Sgg6h8BA/YG+pDPTO2plx2PInlKdWlMc5vF9YW+DOAwQqhwnGoJ8O58qbU82EklIhy1g
	 MOcIBwFauc2ob2XfCVZKS9tfQFx45ps6VvjgcfOzTCdIBJATLMAeRQ2T3ebpFWFIOdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zVBzhbE1oSVIc8stmRdzZ2gqZIqgODcqqAcfsI2hV0w=;
	b=CYeukQ9O2N6gFraIOGQP90B9NsL63EJs7BeFuF5ptPtrEtM6Q6LjQi+BQx3VlfpgUjKs
	 gV+7KdwNHcYq702hJKpBQ5dsAj/nbayjYD9radA6T18346ejuBCgqe0KvY1FxcA4gTgHa
	 D5o9BdxjIv8epAQbYlqcNjYWZZq0zbPp/bGyZE2ZfZEUjiDK2HI7oiKOrny2rmBDhspP0
	 7AfhdavRkMrg6AXWwClAS0n75mx0LsPWE2p8P0v7I6mwU8T8ANRBn+KxTABI9ScRq7Z0c
	 NpWmMj6a2Lckv9L7S/svvMGarfrAOkn7afS4h04CVivXzhMVOd7Bv5176Xy+m+nM32Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDQpPAVz;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5008606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5008606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDQpPAVz
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso118095a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937091; x=1794541891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVBzhbE1oSVIc8stmRdzZ2gqZIqgODcqqAcfsI2hV0w=;
        b=aDQpPAVz4GoD5gX8CXGc0JYlZnugdAbloLWIZuRzA1DZ9UFlzXmHA+ynZqb7dxbJX7
         XEgj5VS7Zqrr3H4UxhKh3qNMtwIMr0slnfZlL/cg2VesAkb0VAv+9J52Qbm1Xb2cAibE
         3raMLi+PPLk2PQ0ZhGDa3FKHIa+29ydzYObm+Wer6D7X1PkS7wEaQmjBzvr87t7zF8DY
         GumyUx3Fi2gIbY6p/ZB1RkWo7tSCswftIYSN6S00NhT1pJAfZNLXX7NINfHjRodkC37u
         i2/YwAf0sVC/QzLwRuidDax1Y2d8avCLN+bgW3Rrw7rB5uccW8G/6w1gCRuTitjM90Ky
         kmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937091; x=1794541891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVBzhbE1oSVIc8stmRdzZ2gqZIqgODcqqAcfsI2hV0w=;
        b=Z1F74UqOiFyAPjC4oOcbS4oGqo6BIF9qGKraw6PT9UsJIEom3VSLuZeb0W15toEneM
         E6uIP597Qq8Ros/CK4E98RkhSpDRJ2SdS78i9e4+2LvKcvfW0CKq5GxX7Eap0nr0SuGb
         iLD0k8W99/bVrbfl+g5NeB/eutceLOCryBRMUSRVroXGrOrNlZfvSJiDDrePBynmCVTP
         Fg7TBMfDtC/1dsI2U3LRwvwcqxeqZzukcAVJCd7WGUakyCOEQmBsEuCoUFRdGSaR+lsm
         VT5XXnnGm2yNdTSooRaoM5+vnyQk9yl4KwCPrw04Et4XsbHTKFsFjGAbEbgs02YKPEVf
         wibA==
X-Gm-Message-State: APuU4Z+E88ZrsHg742tmoo3nu+8PAN0eMap6CIWK3XcejRTXLqfaYJHz
	WJvAhtcYk+kW7u/2pmSUsxMYexKJULL9hc6Pawe5mf1Zzn660uGEbhqxcav8pg==
X-Gm-Gg: AYBFou2O9vBwSOS8zNiMjqUQHykZ1ifoTxUGlqH5e3x0EeDpYTHLnkX5glgTyAaFvXy
	oVQJq48N790aUZkalZqFMitF+FQzWfTlwu8hYbT4WfSNNKD6LBimRJFX/SlNYh/c8SOzJzk6TnD
	h3zrFCDRA8AVKcy46zMTTISDKDEWwE8LYkQUo+aZHgI0JhflCrHqmbxZqlN3zOC0PoRIWiBoiyy
	mzSEWZTpATS4Fujb4283ZBLSh5LwcRAqTcPBj1rldL0j0udbhtVFIeBPd7wyVMho2IcNGB7Xd64
	M3y/JCJhF5eLjuujAWwuDc54fxCxXGdTIjfN98P4j/qB8Unp32GXZ8ntwc+EG1+VYcIcCCWiOwX
	CY0Sfy3aAwW0U+yR0YElOgCKbGqCJIzImengILxYmuHZWvFq5k13vvck+H2Ids2ZT5nTz11rDgU
	J4YHagDsCivZYe51VTkdQ7eyoFg8uAVLigDEKdEeXKYgZ1kTokgQRgkI0PVbW5wufFP09psCPGE
	LOxTApl7MyNYYVGjwdOTp0v9jBBKfg+MG5n9UGykacNov+RxGo3CCR9l65jhm4//8jIN4yk5Gcn
	9ebt6xxYlSMMG+LQ9et9un5YTP3yHHE/ej/uWaHBtjv9OYn1RRJjIrJOiBvKO9Gz4xjaLMWmQPk
	m5HVem5gKLmmJBRhzH2jaFibjK5mNIgEOgI+RqoFMGHhB+yV6YPD82MsAbvwo/FoXAx1jVNP59A
	==
X-Received: by 2002:a17:90b:2891:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3b0db6ee368mr1127144a91.58.1793937090946;
        Thu, 05 Nov 2026 19:51:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b2cf80c9sm6161840a91.0.2026.11.05.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:51:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 03/45] bpf: Add union and widening of the range of a register
Date: Fri,  6 Nov 2026 03:50:27 +0000
Message-ID: <20261106035111.3315285-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

format_cgrp_path() of scx_layered, prog layered_runnable:

  u32 len = 0;
  bpf_for(level, 1, max_level + 1) {
          if (level > 1 && len < MAX_PATH - 1)
                  path[len++] = '/';
          ...
          len += ret - 1;
  }

The verifier follows each path, and its work grows with the number of
paths. To make it grow with the size of the prog, the states that meet at
an insn must become one state. Then the loop head has one state for all
iterations. len in it is the union of what arrives there: 0 from above,
more after each pass through the loop. A union can grow by a small step
per pass, 'n++' by one, and the passes do not end. Widening ends them: the
bound that moved is put far out at once, and the jumps in the loop make
the range small again. How far out decides about this prog, because the
compiler tests len in 32 bits:

  len at the head  after 'if w7 > 0xffe'    path[len++] = '/'
  [0, S64_MAX]     [0, 0x7fffffff00000ffe]  R2 unbounded memory access
  [0, U32_MAX]     [0, 4094]                ok

A 32-bit compare cannot bring back what widening to 64 bits threw away.
Thus bpf_reg_widen_range() moves a bound to the nearest of a few stops:

  lower bound:  S64_MIN <- S32_MIN <- 0
  upper bound:                        0 -> S32_MAX -> U32_MAX -> S64_MAX

The price is one more pass through the loop per stop. rusty_dispatch of
rust-bpf has '(1..doms.len()).map(..).filter(..).any(..)', which is
'r9 += 1; if r9 < r8 goto' with r8 from memory. No jump holds r9 back:
[2, S32_MAX], [2, U32_MAX], [2, S64_MAX], unknown: 4 passes. Scalar
evolution knows that each iteration adds a constant to r9: @linear. Such
a number goes on until it wraps. It becomes an unknown scalar at once, or
[0, U32_MAX] if it is computed in 32 bits: 1 pass, 914 -> 536 insns. The
225 progs of the schedulers of rust-bpf take 13 % more insns without it.

bpf_reg_union_range() is the union. It differs from bpf_reg_union() in
that it has no reg_bounds_sync(): each part of the result must include
that part of the two inputs, and an input is not always in sync.
bpf_reg_forget_range() drops all that is known about a number.
The join of two registers is the caller. Nothing calls them in this patch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 11 ++++++
 kernel/bpf/verifier.c        | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2f935061b8fd..79faf084cbcd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1341,6 +1341,7 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	struct bpf_join_state *join;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1531,6 +1532,13 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+
+/* join.c */
+int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst,
+		    const struct bpf_verifier_state *a, const struct bpf_verifier_state *b,
+		    bool widen);
+void bpf_join_free(struct bpf_verifier_env *env);
+
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
@@ -2059,6 +2067,9 @@ void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
+void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src);
+void bpf_reg_forget_range(struct bpf_reg_state *reg);
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old, int linear);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f61613fb5a0..754c64d7c9cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18180,6 +18180,80 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 	       a->id == b->id && a->parent_id == b->parent_id && a->map_uid == b->map_uid;
 }
 
+/* Nothing is known about the number or the variable part of the offset anymore. */
+void bpf_reg_forget_range(struct bpf_reg_state *reg)
+{
+	reg->var_off = tnum_unknown;
+	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
+}
+
+/*
+ * @reg is what @old became after a trip around a cycle, @old included. The end
+ * of the range that moved is going to move again. Put it where it may come
+ * to rest. There are few such places, so this is done a few times at most.
+ * It's put at the nearest of these places: every value between the range and the place is
+ * made up, and the program is checked with it. Wherever it's put, the range only gets larger.
+ * @linear: every iteration adds a constant to it, in that many bits. Then nothing but a jump
+ * stops it. It goes on until it wraps, and is any number of that many bits.
+ */
+void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old, int linear)
+{
+	bool moved = reg->r64.base != old->r64.base || reg->r64.size != old->r64.size ||
+		     reg->r32.base != old->r32.base || reg->r32.size != old->r32.size;
+	s64 min = reg_smin(reg), max = reg_smax(reg);
+
+	/* Only the step is gone, see bpf_reg_union_range() */
+	if (!moved && reg->var_off.value == old->var_off.value &&
+	    reg->var_off.mask == old->var_off.mask)
+		return;
+
+	if (linear && (max > reg_smax(old) || min < reg_smin(old))) {
+		if (linear == 64 || min < 0 || max > U32_MAX) {
+			bpf_reg_forget_range(reg);
+			return;
+		}
+		min = 0;
+		max = U32_MAX;
+	}
+	if (max > reg_smax(old))
+		max = max <= 0 ? 0 :
+		      max <= S32_MAX ? S32_MAX :
+		      max <= U32_MAX ? U32_MAX : S64_MAX;
+	if (min < reg_smin(old))
+		min = min >= 0 ? 0 :
+		      min >= S32_MIN ? S32_MIN : S64_MIN;
+	if (min == S64_MIN && max == S64_MAX) {
+		bpf_reg_forget_range(reg);
+		return;
+	}
+	/* every part has to include what it did before, hence no reg_bounds_sync() */
+	reg->r64 = cnum64_union(reg->r64, cnum64_from_srange(min, max));
+	if (min >= 0 && max <= U32_MAX) {
+		reg->r32 = cnum32_union(reg->r32, cnum32_from_urange(min, max));
+		reg->var_off = tnum_union(reg->var_off, tnum_range(min, max));
+	} else if (min >= S32_MIN && max <= S32_MAX) {
+		reg->r32 = cnum32_union(reg->r32, cnum32_from_srange(min, max));
+		reg->var_off = tnum_unknown;
+	} else {
+		reg->r32 = CNUM32_UNBOUNDED;
+		reg->var_off = min >= 0 ? tnum_union(reg->var_off, tnum_range(min, max))
+					: tnum_unknown;
+	}
+}
+
+void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *src)
+{
+	acc->r64 = cnum64_union(acc->r64, src->r64);
+	acc->r32 = cnum32_union(acc->r32, src->r32);
+	acc->var_off = tnum_union(acc->var_off, src->var_off);
+	reg_step_reset(acc);
+	/*
+	 * No reg_bounds_sync(): every part of the result has to include that
+	 * part of both inputs, and an input is not always in sync.
+	 */
+}
+
 /*
  * Extends acc's scalar range to include src's scalar range.
  * Caller must ensure that other kinds of metadata is compatible.
-- 
2.55.0

