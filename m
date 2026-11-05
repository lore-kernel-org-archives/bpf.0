Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911534;
	b=hqDwbHjGvuoQAuf7zd2j4oTmiFiQDhoQo23YCyajmAn6WGLdJsCC636jHzzzrPDDDy1n
	 4HAB6uT42d/boCIeq7huQz6E7rtDKmJP0YCMRHC0rkj4T6SN8R+OkSYeFCnNRIfd3raBN
	 MaGX386qMbxEBF2fEfvEr4LLeSFPVCTltEZfSCre6Qt17D5AROR+wwtB12U64Sh7yPGHT
	 osWLV6Rlnd/Q6RKZ5Bxu6VdPqjXVJxqHArJbshtAQJWTpkoXf5avCUqSDcQX3M+Jea9NM
	 LVj8DE3LlrwklZbhbHbvtG90VwjokJtLG8Q24+V7aNOzDwVdJXACRa6DW5ER2XUs1OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K3zh3NXVuTf351fO6LwUMOTRSYo1y4GD6aHlZ9IJ5/c=;
	b=lD9eHl+Q24UNTBVPREPD0y7hjxGsBUoraPfoG7egcEZjt8L/M4iJ/+dlqtTuNstT9s9g
	 tAKgLHr/uxNQ1g1e3smdxxIl2qLZC3xu2cuDIqg881cbqDG/WaUQXiQpzlIjjNH+2yNIc
	 s8s0+VJ+qhmsSf/5g+DsYQNaeWNfgpQwH+ujEWFRKdNDMRaLohV0CYHWX6w4MxK553W9C
	 l9MEpvi7fNm49VpMazlSU2gp7EDRZvOLDxblLNwTnlKwHCgcKZc5K+uONMwVPvoMsUsQ0
	 JiDn87KdFmIs9/nlOaUjWUJswc1vCGeupKsroiJAnz6r8DTH4lt/ZRQYsL/9f2VdLbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNTH7h2g;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A038606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A038606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNTH7h2g
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso832888a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911533; x=1794516333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3zh3NXVuTf351fO6LwUMOTRSYo1y4GD6aHlZ9IJ5/c=;
        b=pNTH7h2gqCt3/LTO2+phy5n2R8othNDiGbs8t5moqZyDBXBbWV1sdUcfex6NoUn90o
         qTQeXW6jYS+uzGFvbNTRfZ4pCTyIV7mgK1cvj5fopzFG1DD/H9YqoC0dER5BYCFmiy4R
         U3/7gEFZ/3DXJK16zSBmlljW3isioWWjA3K8NZHvWzt2QmvrOgq2IJrYfjOgheqmUvc3
         Hj6BbfqnQDxRil8r6W3D5beDbuVDlsajhZk+MRvZeP190VasmYypX4d9m3iEMUPXtPeJ
         T/ggnOhX2YsiyQO0jEcePfQZ9aRisfsASuOqXgHTN2ErSwE2l5EVxy4GYnZCqqCi1Ymh
         iX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911533; x=1794516333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3zh3NXVuTf351fO6LwUMOTRSYo1y4GD6aHlZ9IJ5/c=;
        b=uPTwEaTFn0Tc978wl4sVZ5VMZuGeg8GV0Q+pkulo4SB7Q8Sqy0sAxllWe7Fp+ZXEYN
         bnimipdfIrIu1ucIbDOYHoCsHlwCMuxAxrJV4CvG+jUv15FszmPhnWCi+2x5jbLT3ybC
         bNe+pZc+1yFGxPQrRr4VFIK71eGqnkETnHB63N3GEsej9Wa83H+j/bKfQLyTQ4UNbWy9
         pvHbpHhhKphhfDCnKa2iUR6HXn2SpQrbpRiCf3vX1NDBgtBiSP4GcKh/4Dfu/Izh1n7t
         SfC+aD8n3uu2K9rjfGhCL+zSEbEoHru37bkkM9TV4EZ8sXHKcA2uncwiSqNra/nCLRxp
         Gn3g==
X-Gm-Message-State: APuU4Z9qHoVzL6TfAqefdnUYYgKFqBP67JTGcQrBAJ2SSafFFOFwHZDw
	RGPFxYInxYK+1U0OZJ/jK1NByeBaIvj0JTyUopGMyxX96wWqGZGR2vj/go319w==
X-Gm-Gg: AYBFou3+rscjGJkuZIAE0OgE51+IytoPQeBRptP0yfgT4zgDSJkEtr59OkWFgQQFguf
	VtoSTX7iNwRSVU/x7+1f0F01mQagzxV98EqIf/RGL4USDfoK8AcLf1hOGzCiJTeKeTN6mTJ0bFR
	yu0lSZIoAF7ecCGJ6tFHxpMdYra9qMcKHbMyCxgwRqKVsifK1B9UnTFsfDolSzFYQ+qeDGdGVV8
	FI2YMODTqxUs0T4Deo/49rxrBI/dVt1KpxLELyezL4I1Q1nU3XwuG5DaG4WGSQd92Tsv0kgmayo
	Edm57gik2HeZGop8aYndOAGT3lWXgB95+oJFbo4NMA36S91IL4+9kEKaNwRdNDfmjF/8gk5q77Q
	Wsi6Llg39xUoeAxjMefa7QJmZy3Ozs38ALiWoHihIQHmtGTAmqHwQi8HPBuXQclf1rj3vgzY319
	iwtBr9u+XVkZ1eD47S8ynexC8lR0fYqVB7eIYxlIEiLfn7SBw/1yE6TFXdWNVT6jCva6/MUe6QJ
	1slntPOeBhNn1BpBbLKkMZGLuxk+0yPa1pCOKlofdL2BegpwInAhzOco9MkE/2R5cMCkBQ23aiw
	JxPllREWKOtLPkum4prMKxK82+YnhXbb8gTUAriUBp2wAqPqP4hHP3Nio2QfFWBNhfAoHvHokma
	au0hOJMQb650vy31nH+nKW0UDrm0aZ7miiexBMCq65GGqHFddrFqlUhoLR9i7JOqHJQEA5wbXzF
	4=
X-Received: by 2002:a17:90a:da86:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b0db60977cmr139885a91.3.1793911533098;
        Thu, 05 Nov 2026 12:45:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm5147570a91.1.2026.11.05.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 03/35] bpf: Add union and widening of the range of a register
Date: Thu,  5 Nov 2026 20:44:40 +0000
Message-ID: <20261105204513.2230344-4-alexei.starovoitov@gmail.com>
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
index 08140ac6e624..e39d1efb08ae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18116,6 +18116,80 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
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

