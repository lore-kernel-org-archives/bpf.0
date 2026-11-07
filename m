Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022876;
	b=DJRkkoiZSGzdhO2Z/bkNZrHgu5uRsD3RB5d3RSWiVte3CnVZNNrebr8wLF3/D79dVx+L
	 G0cXvvxjD1tgK/uVEHpTuGHi0aio8A/9h9tLSWfjVhRpX3Jw1lf3CFvP29MczIdsSczQ9
	 2fwUZDmHSaSgmN7k7aiSbNTZMPBO1XJofsO3to8UnLbPxoC1zjA8zpJ5bEe/Mlx8ymDn6
	 E9PYoxXsxk2OWE2UpEuhrK+JnbAsihUUx6HwojYt08bXU9jO7sTxOS4xESz4fuTUWqbzs
	 yvhY7WVXEif3QUjG67MvJjf1J/1a5J7WBbjMGR3+VIQBu9YjmRr9BM5XA5iog1ePFLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QuVycvgdkAGlLGbaOtyRIBnejX8JeeRtm6Epx8L8emI=;
	b=ea0n8l3oz8bKsD92+3NbKaekBM9YO6Qxx5+iBGC+y03QpGK/umYOA/P9RQN1ErwQWkcv
	 KO1NinkS3NgIBSDcM1Sl5UqamnaRS3ChzAEaOYXuAqlw2pF/Yc+TS62vLXkimnacXyD46
	 fD40x7oSvO8KGvO4xbJpVYpqYn3MYADPRGCLGFL5BNIQXcS7+GAJzJQJ7StQQ72kzPuk8
	 R6hBkktAXEtoTCiCXjIHnRExmA7Q3Ph5cq4Zrjg5GBEIVyuSxllpRWAcVdxtK5k7v+uxX
	 35HV6me5YzlX/L+46rsiBJ9n8KLOugDU4CRHoZMZ05hM8tJ4NtVsfTmlU8VHzq8ZWEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q/mK0rvC";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C822606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C822606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/mK0rvC
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a089dfee18so122406b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022875; x=1794627675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuVycvgdkAGlLGbaOtyRIBnejX8JeeRtm6Epx8L8emI=;
        b=q/mK0rvCDeite7QtWQ8NmuDTUru+ywrKhpi2WzZvgnoxIbgXkcje5tL7i/ujvu/pF3
         cU3yc+0RShLJrsE3nTR7s0h881rX/7EiVR/4pr8JNUOZNuU+ijZp5d3jRhXjSmV/yTED
         aGRleMBwcJ/pyIpyo0571IWttOYUinw+ip4apHIU217KkCO+TM6C/5ghFb5iHgwJUCGO
         /rfSTl6PJ/Y/olJUFEe7ZrmIWeo2e2LLlh03cZVHJBhk5fyaRe9KH7Clx4EWlQxHoCD7
         TrCV64dvBmckLL9WEiSCHXDcX0ORinm2rdBLkVzl2SY9krLsnaEQ/2DsOcXxdeZqcvyv
         94Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022875; x=1794627675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QuVycvgdkAGlLGbaOtyRIBnejX8JeeRtm6Epx8L8emI=;
        b=rQux8eq7NVxHGtywp6LEDbhAnbOTu1SVs0rssTYgprM/1im9sGgocVUmPCotDmw379
         y5vIc0yyTRrZtZPdRPPFBfpQ4kkPCRSOvcA0MTBskBQ8BnKWoEOdqvBC4bMRTc5BVDDU
         YIZJeufTx/gQ21OVllVodt/uEuXJ8wElj3BB7VNpSkcB13uKrEooSf/LvbmX7oToIeG1
         cnhptkFBXoYjbuYn999oXMmrxpDxGxZw+MjiShgyaqxxODQ6A9EQwMHpOfmN5Tr6e72E
         Fv1sMa646LZCkrwtvYa5vXiVETJdOufJmu8RDCzZaDJ8xEUYhl3CVaztBFmjFID42nQE
         gm8A==
X-Gm-Message-State: APuU4Z8jYkkJKCrmSQsIX2EUy1ePdbzkq2Dk6mQObQDU47QpSmBehGr3
	1DKNrFGvTQA/D7rD+OALVHBB+sLi6MJVdFP2mUrUebynHo01ZI1HlmG//Zwm1w==
X-Gm-Gg: AYBFou1B55MXyPZw2VXQNRiwHOockGNca6GOMisKbzwLdlVJRTGylZqXAzcJQ1GtdJu
	WB3mHtoJKASJDie1ol0U9KTZ7/PR1QN7yUks7cXSWeQpc2KKWIvRdTVlmyqPs6mtf4v5F/XKyS8
	MN7JOI0vPyLet2lIi9s6t2+68jGb4/jV0Db/ZeczEiRekgjtttilBYiy/Cw6R5vttMSUWDMkhjt
	kajn+wyoTWcN/zuaFdoeryCTFGrYE/yDlTy90Oe2Jb2XNEYuyldDDM6a+NZK7AdUHefJpufvh30
	IdUTvQqCuhUuC/rbcJ5aFb4PhSjV79G0E+9K3XFd1vsY79sLw2K/aCMr7fGkJon/Drs1ir+F5Xf
	aYKKSswif8Ajs0PFW6AQwJFx9c4U8Wui3SGlFWdcjLR/0l1sKNSfwsoaBeeJcBGcesvpWUCjd0M
	gx3qG8Qar/h0DAvAPpYDTcrbMsGQu6ElpCvRbzOa5ax09A7npYit685kxZXrtDYCCNSOg+2q5au
	kxpcwNB4fkYdc0e6aRgPlTdmKx3TRKMJ/qvNzaGQVs4z8zZ6WRZTe7Anh4v7kFUAbGiDXuoX574
	q5nnM3IWv9xA9AqxagGRimGVbraYh0kwJyZbSBWmxc5TbbmzKqRjrbbrWGGA1BJ3gvXIvAufYSy
	lym0K7ir5Kt7qdS3sE8WXMY7HAq0m63yX0cjywxVvr0aqDEYslcVFkZaAkBU4CPmOeR08ciH+nQ
	==
X-Received: by 2002:a05:6a00:2e1a:b0:884:831e:d0e3 with SMTP id d2e1a72fcca58-8b4e5c2b9c0mr653887b3a.17.1794022875345;
        Fri, 06 Nov 2026 19:41:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b359ddaf39sm1095855b3a.41.2026.11.06.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 32/46] bpf: A loop is one iteration shorter behind the jump that counts it
Date: Sat,  7 Nov 2026 03:37:40 +0000
Message-ID: <20261107033758.1547725-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

	#pragma clang loop unroll_count(3)
	for (i = 0; i < 250; i++) {
		if (!bpf_get_prandom_u32())
			break;
		out[i] = bpf_get_prandom_u32();
	}

is rejected with
'invalid access to map value, value_size=1000 off=1000 size=4'.
250 is 83 * 3 + 1. The compiler makes a loop of three copies of the body
and leaves it behind the first copy in iteration 84:

	l: ...; *(u32 *)(r6 - 4) = w0;
	   if r7 == 251 goto out;
	   ...; *(u32 *)(r6 + 0) = w0;
	   ...; *(u32 *)(r6 + 4) = w0;
	   r6 += 12; r7 += 3; goto l;

The loop is counted. At its head r6 gets the offsets of all 84 iterations:
4 to 1000. The jump narrows r7, which it tests. It says nothing about r6:
the two stores behind it are checked with an offset that they never see.

A state that goes on in the loop behind the jump that counts is not in the
last iteration. Give the range of one iteration less to what is linear at
the jump: r6 is 4 to 988. Only for a jump that leaves the loop itself. An
edge that leaves by way of a flag stays in the loop for a while, with the
last iteration: no shorter range behind a jump that has such an edge.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  5 ++-
 kernel/bpf/scev.c            | 59 ++++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c        |  9 ++++--
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 85404ef790ef..61f133e4d72f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -365,6 +365,8 @@ struct bpf_loop_iters {
 	 */
 	int iv_reg;
 	struct cnum64 iv_range;
+	/* a jump that counts: it leaves the loop in the last iteration, if not before. Or -1 */
+	int count_insn;
 	/* a pointer to the stack that stores go through moves in the loop */
 	bool spill_base;
 };
@@ -426,6 +428,7 @@ struct loop_stack_entry {
 	u32 walk_patience;
 	int iv_reg;
 	struct cnum64 iv_range;
+	int count_insn;
 };
 
 /* The state is in a walk on patience, which may not get to the end of the loop */
@@ -2216,6 +2219,6 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters,
 			bool back);
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
-			const struct loop_stack_entry *entry);
+			const struct loop_stack_entry *entry, bool behind);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 06f485853df1..4ce8ad5d5a27 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3470,6 +3470,13 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		return 0;
 	}
 
+	/*
+	 * It leaves the loop itself: a flag does that later. If one edge does the one and the
+	 * other edge the other, the last iteration goes on behind the jump as well.
+	 */
+	iters->count_insn = bpf_jump_leaves_loop(env, insn_idx, first.insn_idx) &&
+			    aux[first.insn_idx].edge_leaves != 3 ? first.insn_idx : -1;
+
 	if (iters->max_header_count == 0) {
 		if (log->level & BPF_LOG_LEVEL2)
 			bpf_log(log, "loop header at %d, 0 iterations count\n", insn_idx);
@@ -3822,12 +3829,31 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 	return 1;
 }
 
+/* (linear (+ rX imm) slope): the iteration has added a constant to rX so far */
+static bool is_moved_linear(struct scev *scev, u32 id, struct linear_coefs *out, s64 *moved)
+{
+	u32 base, slope, l, r;
+
+	out->spill32 = false;
+	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) && !out->zext32 &&
+	       is_add(scev, base, &l, &r) && is_reg(scev, l, &out->base_reg) &&
+	       is_imm(scev, r, moved) && is_simple_slope(scev, slope, &out->slope);
+}
+
+/*
+ * The state came back to the head of a counted loop. Or, with @behind, it goes on in the loop
+ * behind the jump that counts. That jump leaves the loop in the last iteration, so this is
+ * not the last one:
+ *	for (i = 0; ; i++, p += 8) { if (i == 4) break; *p = 0; }
+ * At the head p is up to 32 bytes from where it was, at the store up to 24. The jump tells that
+ * about i only. It holds for all that is linear at the jump.
+ */
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur_func_state, u32 insn_idx,
-			const struct loop_stack_entry *entry)
+			const struct loop_stack_entry *entry, bool behind)
 {
 	struct bpf_verifier_state *entry_state = entry->entry_state;
 	struct bpf_func_state *entry_st = entry_state->frame[entry_state->curframe];
-	u32 max_header_count = entry->max_header_count;
+	u32 max_header_count = entry->max_header_count - behind;
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_reg_state *reg, *entry_reg;
 	struct scev *scev = env->scev;
@@ -3835,6 +3861,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct env *header_env;
 	struct bounds bounds;
 	u32 r, r_scev;
+	s64 moved;
 	int err;
 
 	if (entry_state->curframe != cur_func_state->frameno) {
@@ -3843,16 +3870,21 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		return -EFAULT;
 	}
 
-	header_env = find_header_env(scev, insn_idx);
+	header_env = find_loop_env(scev, insn_idx, behind ? entry->count_insn : insn_idx);
+	if (!max_header_count)
+		return 0;
 	for (r = 0; r < REGS_NUM; r++) {
 		r_scev = header_env->reg2scev[r];
+		moved = 0;
 		entry_reg = spill32_counter(scev, entry_st, r_scev, r, &coefs);
 		reg = spill32_counter(scev, cur_func_state, r_scev, r, &coefs);
 		if (entry_reg && reg)
 			goto clamp;
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (!is_simple_linear(scev, r_scev, &coefs) || coefs.base_reg != r)
+		if ((!is_simple_linear(scev, r_scev, &coefs) &&
+		     !(behind && is_moved_linear(scev, r_scev, &coefs, &moved))) ||
+		    coefs.base_reg != r)
 			continue;
 
 		entry_reg = scev_reg_for_linear(entry_st, r);
@@ -3878,8 +3910,22 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 clamp:
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
-		if (r == entry->iv_reg)
+		if (r == entry->iv_reg && !moved)
 			iv_bounds(&bounds, entry->iv_range);
+		if (moved) {
+			bounds.r64 = cnum64_add(bounds.r64, cnum64_from_srange(moved, moved));
+			bounds.base = imod(bounds.base + moved, bounds.step);
+		}
+		if (behind) {
+			/* jumps on the way may have told more */
+			bounds.r64 = cnum64_intersect(bounds.r64, reg->r64);
+			bounds.r32 = cnum32_intersect(bounds.r32, reg->r32);
+			if (type_is_pkt_pointer(reg->type) || cnum64_is_empty(bounds.r64) ||
+			    cnum32_is_empty(bounds.r32) ||
+			    (cnum64_is_subset(bounds.r64, reg->r64) &&
+			     cnum32_is_subset(bounds.r32, reg->r32)))
+				continue;
+		}
 		if (log->level & BPF_LOG_LEVEL2) {
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
 			log_reg(env, r);
@@ -3887,7 +3933,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			log_bounds(env, &bounds);
 			bpf_log(log, "\n");
 		}
-		scratch_widened_reg_id(env, reg);
+		if (!behind)
+			scratch_widened_reg_id(env, reg);
 		/*
 		 * The range of a packet pointer goes together with its id and with the offsets
 		 * that it had in the compare with pkt_end. Both are replaced here. What holds for
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa7aa8218218..afb5b9dd18b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21329,7 +21329,7 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
 	if (!entry->terminates)
 		return 0;
 
-	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry);
+	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry, false);
 }
 
 /*
@@ -21501,8 +21501,12 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 		return 0;
 
 	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
-	if (env->insn_idx != entry->loop_id)
+	if (env->insn_idx != entry->loop_id) {
+		/* the jump that counts didn't leave the loop */
+		if (entry->entry_state && !entry->apart && cur->last_insn_idx == entry->count_insn)
+			return bpf_clamp_scev_regs(env, frame, entry->loop_id, entry, true);
 		return 0;
+	}
 
 	/*
 	 * No edge goes from a call to itself: the call goes on with one function of a set, see
@@ -21623,6 +21627,7 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	entry->max_header_count = iters.max_header_count;
 	entry->iv_reg = iters.iv_reg;
 	entry->iv_range = iters.iv_range;
+	entry->count_insn = iters.count_insn;
 	entry->entry_state = entry_state;
 	entry->terminates = true;
 	/*
-- 
2.55.0

