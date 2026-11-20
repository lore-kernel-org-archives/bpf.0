Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160873;
	b=ybSc/z6K1huYUz/kagKfHAnur+9x4hwzs0i2CaV0Z34eZHy3LmJirri0iY0QeEHCnEtL
	 QW2HmNawc0NyBAbxhD72UU5zs5Bp77QWxtWFls2Cp76jsnU84XPFEEAN7VoENbS4LYvRZ
	 rpeI4OjPR6HhTrf5/L7GtvELkm4cDkqa7PIGvDdNPNhAlLeSiEaapjUQtvMNtOwdpyOY1
	 b5+hmkm+OMXeR7/2xaPsILnMkDoEE9E2CFL1kw84Xd2Vkj/eWyE1mjItqBDDNPObTYKor
	 J5OYXvy89clbwUk6rvD6Um/UD/ITpZABHuyAwC0yyOYf9VTw6IAkwVDtuoIiy7J9UnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XTgNaoXVh1pqWkYJBQ2pVDHhYoBZzCotDB6tt2LZ6Cs=;
	b=E8pZGpJYeE0rI0Ki0YoSy4z8Bzq2HmALoOj6PTGVm4sWYqbd2UI9niXCiSC5dLM4skpF
	 aTnOltPuhNSjVVMXFyhuw4dWuk7bC+99YgFallpAg1mWlm4azHEuqx1li2/ocm0KAXX17
	 ucCsBz4Ks7QfxRIIfiDqxvgoMW1bYLvj/YxjctBgK33OV2O+WFeZa/NUQc9gknVHxNNig
	 sEFuqHvrBDd4LL+hjz5CmkzUMfU29b0oqnM7hMMNHk+aHwIWI33XQm98FzDIt399J5sUR
	 ZTij/0rSRdVvjOyFDFapRTciSr8T3uFvgu7fN3Sbz4anCrQa/5pfK2tBNJKOaI/iwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5xh6sw5;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BA606A336
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E1BA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5xh6sw5
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f04b676219so1049245ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160872; x=1795765672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTgNaoXVh1pqWkYJBQ2pVDHhYoBZzCotDB6tt2LZ6Cs=;
        b=h5xh6sw5BSicwMI1dJjTj5eCnLbU9MKJskO+VWRJpLIcmQ/BhvWzUDU178DPHXk+BL
         TcEFP7V6pJNhV316WiRKz7AMZC6X89WLFWm9eMSl7CR7W4VEImisNOLGaZC7AacQaJOP
         pDO6mX0B3KnhDOz9DHLjKcTTWVGOukLz4UP7u0vVQ/vhVAKAA4B7Xv3D4vVznjgIaOES
         dr1/Me3S4VhiOD2f/l/Ietbyj3972E5AOOq4VvZ3rzA3a03xmQLrWOGJEv/3L2VM0lr7
         SAv/xn0AKBZeBLqV0ioIrdWl4sjKcTBnepsG/tQJyp/I4WxyuDnun1ZLMrzQwyQhi+Af
         DG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160872; x=1795765672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTgNaoXVh1pqWkYJBQ2pVDHhYoBZzCotDB6tt2LZ6Cs=;
        b=xGDLiU3p9cgSiZoKF+/itac9EQvJZPCJMmbOHJvAqflL6lKgcuTlohfNzDSh+jMLmi
         GKA1HTDOkSGGs1iP2uMbJJbRyPzBxscMSqa3xXjnckccWvKpe5zXQTrHkUjFfv8Ky7W3
         VuavnicYFkZjgErA4Osilpbucp+syiu7QT6sp32/iMO7otYveC63Z+ZIlHl2IdOWncjC
         9yi67gScZSr+9Tg5mrKv+TP0dxvacyRFO+U9wH0G6cAoG5ZPEoDCdDz98CFYq0BjmRdU
         0DAomUnMwR8uKxc3hCysUGch4drl6Qy1j31xPkoMSZz7ifmiDqtkMeRVeQEEcrcdTfXV
         VXYA==
X-Gm-Message-State: APuU4Z8/ixXXsiH4JUT6XwMLqxuaOKsA4Ps4wu+LgWNDkhYE3BMK6rFI
	uF34kQvKUbRRHwHdn2j7RUGJYk5oUxbN8oyAL/odxTrr32cXkr5AlwPIiYzDHg==
X-Gm-Gg: AZFdTZdFzsxeukMTEVLgTGuo+0Zvbj5Gs2dElnN3Q6IQypyVlLwsl6Ck50Ad9c2lLAT
	MIeybuh1/GJ6wNt1RqvD6W2Tb38Za+FIff5j2x6mKqreqY8hkVYDgGQaetoHouagUZzIyJNIWKn
	+Ld1zvbqoQJtln3MoC5kiFqiucTUssPAbOLgsh0RUY41fgJCgSxpYIxySr5PwP4iYct11p7+ihy
	9HCHJ2Joz3CLDZfkk+RjEsK56Bt9AgIQ+aUAmR1Ge7oYVep1/IxS7TsMT+mJswQdfBHO9ucOIhS
	T06a9LuHjKH7FqT021EurKWjAMB56zTwH24HRNr2zkyGh2D5N9H8rh1xf5NxyGME0p5O0BHU1Nv
	w8/L4pncv0W/nHx1SxOzTTQwvH4m10WwO1AVsuL2t6eLPsVX99WfT3BT1DnGRq9hZ0gC8AO2ZVU
	Ny93dVwWVUkYO3XUcwX0J75QgGs7TojFM82oGLl9F0QYFWKKwiBLNM2LZPwhmacL6yIwIQXpeMu
	deHPqPPZYkHYJx1oz391MORAvC07XD+JXS+bz0oPHQOzbgQwbrU+LM4U3TNfw+ICeV/cbgP2M7e
	KbPsR4I8SLPPbKVK3v5yvcFLfBYbyLA0bbZTeljlfSij19lD8fIUOXYyN2nSffmzl0dlKFm/tcm
	HhGJUT68kKiSGQKxYOml+NWcsJLWCvUTh0kInhWpvOErYqYpXf3ip5UsxCa2MhXcJ8w1sjjRR87
	Y=
X-Received: by 2002:a17:903:3888:b0:2e9:5714:608e with SMTP id d9443c01a7336-2f03f1beee0mr25095045ad.49.1795160872293;
        Thu, 19 Nov 2026 23:47:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105bb2sm10326075ad.45.2026.11.19.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:47:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 34/49] bpf: Partition the states after an error
Date: Fri, 20 Nov 2026 07:42:06 +0000
Message-ID: <20261120074430.2704488-35-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

If a pass has an error, what does the next pass keep apart? This is
trace partitioning. More precision costs more, so take the cheap steps
first. bpf_partition_more() takes the first line that adds something:

  ADD_DEPS             the deps of the unproven insns
  PEEL                 suspect loops: one trip, then what a budget pays
  PEELED_APART         suspect loops: the join rule holds at the start
                       of a peeled trip
  TRANSITIVE_DEPS      data_deps |= control_deps; add the jumps that can
                       skip their writes
  DISJOINT_APART       disjoint values in data_deps stay apart
  LOOP_DISJOINT_APART  suspect loops: the same at the header
  PEEL_MORE            suspect loops: 4, 16, 64, ... trips; no prune of
                       a peeled trip if the last pass pruned one
  IN_FRAMES            calls with an argument that is in the deps and
                       has an equation: if (!ok(x)) return; buf[x]

A step can be the wrong one, and use up the limit of the load: to peel
a loop of 100000 trips does not help if the error needs control_deps. So
each step but the first has a budget, and can be undone:

            +-----------------+   in the budget, or it helped
       +--->| partition, pass |------------------------------> keep
       |    +--------+--------+
       |             | over its part of the budget
       |             v
       +--- undo, take the next line
       |             | no line left, one was too costly
       |             v
       +--- budget *= 4, undo all since one helped

If a step was too costly for a loop, a later step is a second choice.
It is undone when the budget grows, also if it helped:
LOOP_DISJOINT_APART makes each later peel much more costly.

The first budget is two times the cost of a pass. charge_loops() gives
the cost of a state to the loops that keep it apart.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  23 ++
 kernel/bpf/equation.c        |  12 +
 kernel/bpf/precision.c       | 500 +++++++++++++++++++++++++++++++++++
 kernel/bpf/precision.h       |  20 ++
 kernel/bpf/verifier.c        |  32 ++-
 5 files changed, 586 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 44c99bf1bf5..540608bcd8f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -839,6 +839,7 @@ struct bpf_loop_per_pass {
 	bool peel_pruned;	/* see flow_prune_peeled() */
 	/* a check failed in a state that the loop kept apart, with no other suspect */
 	bool has_unproven;
+	bool starves, starved;	/* see charge_loops() */
 	u32 last_peeled_trip;	/* see flow_keep_peeled() */
 	u32 peeled_cnt;		/* trips that the pass peeled */
 	u64 cost;		/* for the states that the loop keeps apart */
@@ -871,7 +872,12 @@ struct bpf_loop {
 	bool disjoint_apart;	/* disjoint values in data_deps stay apart, also in the leftover */
 	bool no_peel_prune;	/* a larger earlier trip does not prune, see flow_prune_peeled() */
 	);
+	struct bpf_loop_precision undo;	/* before the last partition */
+	struct bpf_loop_precision kept;	/* see keep_precision() */
 	struct bpf_loop_per_pass last_pass;	/* the last pass whose partition was kept */
+	/* to peel all trips, estimated from a partition that was over its budget */
+	u64 full_peel_cost;
+	u16 tried;		/* bits of PARTITION_*, with this budget */
 	bool partitioned;	/* the last partition was for this loop */
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
 	bool changed;		/* see flow_forget_loop() */
@@ -1350,9 +1356,11 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	bool replay;			/* the good pass, once more for the driver */
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	bool for_log;			/* the verdict is known, see do_check_all() */
 	bool fallthrough_first;		/* see find_failing_path() */
+	u32 pass;			/* number of the pass, see do_check_all() */
 	struct bpf_precision *precision;
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
@@ -1696,6 +1704,8 @@ u64 bpf_hash_apart_xregs(struct bpf_verifier_env *env, const struct bpf_verifier
 u64 bpf_hash_args(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u64 hash);
 void bpf_range_of_data_dep(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   u32 *first, u32 *last);
+bool bpf_call_needs_frames(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u16 args);
 bool bpf_xreg_in_data_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			   u32 fr, u32 xregno);
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
@@ -1707,6 +1717,15 @@ bool bpf_insn_is_unproven(struct bpf_verifier_env *env);
 void bpf_note_fixups_differ(struct bpf_verifier_env *env);
 void bpf_find_unproven_after_pass(struct bpf_verifier_env *env);
 bool bpf_same_insns_unproven(struct bpf_verifier_env *env);
+int bpf_partition_more(struct bpf_verifier_env *env);
+bool bpf_undo_precision(struct bpf_verifier_env *env);
+void bpf_precision_new_pass(struct bpf_verifier_env *env);
+u64 bpf_pass_max_cost(struct bpf_verifier_env *env);
+u64 bpf_precision_budget(struct bpf_verifier_env *env);
+u64 bpf_precision_first_budget(struct bpf_verifier_env *env);
+int bpf_precision_init(struct bpf_verifier_env *env);
+void bpf_precision_free(struct bpf_verifier_env *env);
+
 /*
  * The two limits of the verifier, for the whole load. The unit of cost is one step of a scan,
  * about a dozen insns of the CPU. Memory is the bytes of states and tables at a time.
@@ -1718,6 +1737,9 @@ bool bpf_same_insns_unproven(struct bpf_verifier_env *env);
 #define BPF_COST_STATE	512	/* make, order and free a state */
 #define BPF_MAX_COST	(1ULL << 33)
 #define BPF_MAX_MEM	(1ULL << 31)
+/* The floors of the cost after the first error, and of the budget of a partition */
+#define BPF_PARTITION_BUDGET	(BPF_MAX_COST / 3)
+#define BPF_MIN_BUDGET	(BPF_MAX_COST >> 12)
 /* Without CAP_BPF programs are small, and their loads wait for each other */
 #define BPF_LIMITS_SHIFT_UNPRIV	5
 
@@ -2456,6 +2478,7 @@ void bpf_equations_fill(struct bpf_verifier_env *env, struct bpf_func_state *fra
 void bpf_equations_refine_all(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 void bpf_equations_jump(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int idx,
 			bool taken);
+u16 bpf_args_with_equation(const struct bpf_verifier_state *st);
 void bpf_equations_next_trip(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			     u32 depth);
 bool bpf_equations_subsume(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
diff --git a/kernel/bpf/equation.c b/kernel/bpf/equation.c
index fc05ca7dd60..4216fd00879 100644
--- a/kernel/bpf/equation.c
+++ b/kernel/bpf/equation.c
@@ -1217,6 +1217,18 @@ static void add_distance_equation(struct bpf_verifier_env *env, const struct bpf
 			env->insn_idx, a.off - b.off });
 }
 
+/* At a call bpf_equations_before_insn() moves the equations of r1-r5 to the next frame */
+u16 bpf_args_with_equation(const struct bpf_verifier_state *st)
+{
+	u16 args = 0;
+	u32 r;
+
+	for (r = BPF_REG_1; r <= BPF_REG_5; r++)
+		if (bpf_find_xreg_equation(&st->equations, bpf_xreg(st->curframe + 1, r)))
+			args |= BIT(r);
+	return args;
+}
+
 /* Note the operands. Delete the equations of the registers that the insn writes. */
 void bpf_equations_before_insn(struct bpf_verifier_env *env)
 {
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index aa9f7f76256..42d9fd0ee72 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -62,6 +62,28 @@ bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	return test_bit(xregno, data_deps) || test_bit(xregno, control_deps);
 }
 
+/*
+ * On its own a function does not get the equations of its arguments @args:
+ *	if (!ok(x)) return 0;  buf[x];		the test in ok() has to bound x
+ */
+bool bpf_call_needs_frames(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   u16 args)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 func = st->frame[st->curframe]->subprogno, idx = st->insn_idx;
+
+	args &= bpf_args_with_equation(st);
+	if (prec->data_deps) {
+		if (args & *mask_at(env, prec->in_frames, func, idx))
+			return true;
+		prec->this_pass.arg_lost_equation |=
+			args & (*mask_at(env, prec->data_deps, func, idx) |
+				*mask_at(env, prec->control_deps, func, idx));
+	}
+	env->imprecise |= args && !env->err;
+	return false;
+}
+
 /* The value in a slot. NULL if the slot has bytes of several types. */
 static const struct bpf_reg_state *slot_value(struct bpf_verifier_env *env,
 					      const struct bpf_func_state *f, u32 spi,
@@ -1037,6 +1059,157 @@ static int compute_deps_of_unproven(struct bpf_verifier_env *env)
 	return add_control_deps(env);
 }
 
+/* An unreadable xreg needs one type and object, whatever the numbers are. Try that first. */
+static int add_deps(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 len = env->prog->len, i;
+	int ret, more = 0;
+
+	if (!bitmap_empty(prec->last_pass.bad_read_insns, len)) {
+		ret = bpf_compute_deps(env, prec->new_data_deps, prec->last_pass.bad_read_insns);
+		if (ret)
+			return ret;
+		more = add_masks(prec, prec->type_apart, prec->new_data_deps);
+	}
+	if (more)
+		bitmap_andnot(prec->last_pass.unproven_insns, prec->last_pass.unproven_insns,
+			      prec->last_pass.bad_read_insns, len);
+	bitmap_or(prec->bad_read_insns_done, prec->bad_read_insns_done,
+		  prec->last_pass.bad_read_insns, len);
+	ret = compute_deps_of_unproven(env);
+	for (i = 0; i < 5 * prec->words; i++)
+		prec->kept[i] |= prec->data_deps[i] & ~prec->undo[i];
+	bitmap_or(prec->earlier_unproven_insns, prec->earlier_unproven_insns,
+		  prec->last_pass.unproven_insns, len);
+	return ret < 0 ? ret : ret | more;
+}
+
+/* Add the jumps that decide which value an xreg of data_deps has */
+static int add_transitive_deps(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 cnt, len = env->prog->len;
+	int ret = compute_deps_of_unproven(env);
+
+	while (!ret) {
+		cnt = bitmap_weight(prec->control_seeds, len);
+		add_masks(prec, prec->new_data_deps, prec->new_control_deps);
+		bitmap_or(prec->controlled_insns, prec->controlled_insns, prec->def_insns, len);
+		bitmap_or(prec->controlled_insns, prec->controlled_insns,
+			  prec->last_pass.call_insns, len);
+		bitmap_or(prec->controlled_insns, prec->controlled_insns, prec->control_seeds, len);
+		ret = add_control_deps(env);
+		if (bitmap_weight(prec->control_seeds, len) == cnt)
+			break;
+	}
+	return ret;
+}
+
+/* A copy of the deps. ADD_DEPS has no budget, so it must not add calls. */
+static int check_calls_in_frames(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return prec->last_pass.arg_lost_equation &&
+	       (add_masks(prec, prec->in_frames, prec->new_data_deps) |
+		add_masks(prec, prec->in_frames, prec->new_control_deps));
+}
+
+static int keep_disjoint_apart(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return prec->last_pass.disjoint_joined &&
+	       add_masks(prec, prec->disjoint_apart, prec->new_data_deps);
+}
+
+/* @loop is a suspect. Returns false if @kind adds nothing. */
+static bool partition_loop(struct bpf_loop *loop, u32 kind)
+{
+	bool open = loop->last_pass.has_leftover || loop->last_pass.peel_pruned ||
+		    (loop->budget && loop->last_pass.cost > loop->budget);
+
+	switch (kind) {
+	case PARTITION_PEEL:
+		/* the first trip is often different from the other trips */
+		loop->max_peel_cnt = loop->peel_cnt || loop->exit_trip ? U32_MAX : 1;
+		break;
+	case PARTITION_PEEL_MORE:
+		loop->max_peel_cnt = min(4ULL * loop->peel_cnt ?: 1, U32_MAX);
+		loop->no_peel_prune |= loop->last_pass.peel_pruned;
+		break;
+	case PARTITION_PEELED_APART:
+		open = !loop->peeled_apart && loop->peeled_joined;
+		loop->peeled_apart = true;
+		loop->max_peel_cnt = U32_MAX;
+		break;
+	case PARTITION_LOOP_DISJOINT_APART:
+		open = !loop->disjoint_apart &&
+		       (loop->last_pass.has_leftover || loop->peel_cnt > 1);
+		loop->peel_cnt = min(loop->peel_cnt, 1);
+		loop->disjoint_apart = true;
+		loop->max_peel_cnt = 0;
+		break;
+	}
+	return open;
+}
+
+/*
+ * The suspect loops divide half of the budget. If the cost to peel all trips is known, the
+ * loop gets that, or it waits.
+ */
+static int partition_suspect_loops(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	struct bpf_loop *loop;
+	u32 i, cnt = 0;
+	int more = 0;
+	u64 budget, bits = 0;
+
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		loop->partitioned = (prec->last_pass.suspect_loops & loop->suspect_bit) &&
+				    !(loop->tried & prec->partitioned_by) &&
+				    partition_loop(loop, __ffs(prec->partitioned_by));
+		if (!loop->partitioned)
+			loop->precision = loop->undo;
+		cnt += loop->partitioned;
+		bits |= loop->partitioned ? loop->suspect_bit : 0;
+	}
+	budget = div_u64(prec->budget / 2, cnt ?: 1);
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		if (!loop->partitioned)
+			continue;
+		loop->budget = max(loop->budget, budget);
+		if (prec->partitioned_by == BIT(PARTITION_PEEL) && loop->max_peel_cnt > 1)
+			loop->budget = max(loop->budget, loop->full_peel_cost);
+		if (!memcmp(&loop->precision, &loop->undo, sizeof(loop->undo)) ||
+		    loop->budget > 2 * prec->budget)
+			loop->tried |= prec->partitioned_by | BIT(PARTITION_TOO_COSTLY);
+		loop->partitioned = (bits & prec->last_pass.first_suspect_loops) &&
+				    !(loop->tried & prec->partitioned_by);
+		if (!loop->partitioned)
+			loop->precision = loop->undo;
+		prec->budget_left += loop->partitioned ? loop->budget - budget : 0;
+		loop->changed |= loop->partitioned;
+		more |= loop->partitioned;
+	}
+	return more;
+}
+
+static int (* const partition_by[])(struct bpf_verifier_env *env) = {
+	[PARTITION_ADD_DEPS]		= add_deps,
+	[PARTITION_PEEL]		= partition_suspect_loops,
+	[PARTITION_TRANSITIVE_DEPS]	= add_transitive_deps,
+	[PARTITION_PEELED_APART]	= partition_suspect_loops,
+	[PARTITION_DISJOINT_APART]	= keep_disjoint_apart,
+	[PARTITION_LOOP_DISJOINT_APART]	= partition_suspect_loops,
+	[PARTITION_PEEL_MORE]		= partition_suspect_loops,
+	[PARTITION_IN_FRAMES]		= check_calls_in_frames,
+};
+
 static int alloc_masks(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *sub = env->subprog_info;
@@ -1090,3 +1263,330 @@ static int alloc_masks(struct bpf_verifier_env *env)
 	prec->loop_control_deps = masks + 17 * prec->words;
 	return 0;
 }
+
+u64 bpf_precision_budget(struct bpf_verifier_env *env)
+{
+	return env->precision->budget;
+}
+
+u64 bpf_precision_first_budget(struct bpf_verifier_env *env)
+{
+	return max(2 * env->precision->pass_cost, BPF_MIN_BUDGET);
+}
+
+/* The limit on cost of a pass */
+u64 bpf_pass_max_cost(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return env->cost + prec->pass_cost + prec->budget_left;
+}
+
+/*
+ * @keep: the partition helped, keep the precision. Else undo all since the last keep.
+ * If a partition was too costly for a loop, a later one is a second choice. It stays only
+ * until the budget grows.
+ */
+static void keep_precision(struct bpf_precision *prec, bool keep)
+{
+	struct bpf_loop *loop;
+	u16 second_choice = 0;
+	u32 i;
+
+	for (i = 0; keep && i < prec->loop_cnt; i++)
+		second_choice |= prec->loops[i]->tried & BIT(PARTITION_TOO_COSTLY);
+	prec->too_costly = 0;
+	for (i = 0; i < prec->loop_cnt; i++)
+		prec->loops[i]->tried &= second_choice;
+	if (second_choice)
+		return;
+	memcpy(keep ? prec->kept : prec->data_deps, keep ? prec->data_deps : prec->kept,
+	       5 * prec->words * sizeof(long));
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		if (keep) {
+			loop->kept = loop->precision;
+			loop->full_peel_cost = 0;
+		}
+		loop->changed |= !!memcmp(&loop->precision, &loop->kept, sizeof(loop->kept));
+		loop->precision = loop->kept;
+	}
+}
+
+/* The first partition that adds something. If all others are too costly, start again. */
+static int partition_next(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	int i, ret;
+	u16 wait;
+
+	prec->budget_left = prec->budget;
+	memcpy(prec->undo, prec->data_deps, 5 * prec->words * sizeof(long));
+	for (i = 0; i < prec->loop_cnt; i++) {
+		prec->loops[i]->undo = prec->loops[i]->precision;
+		prec->loops[i]->partitioned = false;
+	}
+	for (i = 0; i < ARRAY_SIZE(partition_by); i++) {
+		prec->partitioned_by = BIT(i);
+		ret = prec->too_costly & prec->partitioned_by ? 0 : partition_by[i](env);
+		ret = ret ?: prec->new_nospec;
+		if (ret)
+			return ret;
+	}
+	wait = prec->too_costly | prec->last_pass.calls_joined;
+	for (i = 0; i < prec->loop_cnt; i++)
+		if (prec->last_pass.first_suspect_loops & prec->loops[i]->suspect_bit)
+			wait |= prec->loops[i]->tried & BIT(PARTITION_TOO_COSTLY);
+	prec->partitioned_by = 0;
+	wait = wait && prec->budget < env->max_cost - env->cost;
+	prec->budget_left = prec->budget = min(4 * prec->budget, env->max_cost - env->cost);
+	prec->failing_path_due = prec->budget_grew = true;
+	return wait;
+}
+
+static void undo_loop(struct bpf_precision *prec, struct bpf_loop *loop)
+{
+	loop->precision = loop->undo;
+	loop->tried |= BIT(PARTITION_TOO_COSTLY);
+	if (!loop->this_pass.starved)
+		loop->tried |= prec->partitioned_by;
+	if (prec->partitioned_by == BIT(PARTITION_PEEL) && loop->this_pass.peeled_cnt > 1 &&
+	    loop->disjoint_apart == loop->kept.disjoint_apart)
+		loop->full_peel_cost = div_u64(loop->this_pass.cost * 9 / 8,
+					       loop->this_pass.peeled_cnt - 1) *
+				       min(loop->exit_trip, U32_MAX);
+	loop->changed = true;
+}
+
+/*
+ * The first unproven insn of the last pass has no error now, and no old error came back.
+ * A pass that is over its budget possibly did not get to that insn.
+ */
+static bool partition_helped(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return prec->first_unproven_insn < env->prog->len &&
+	       !test_bit(prec->first_unproven_insn, prec->this_pass.unproven_insns) &&
+	       (!test_bit(env->err_insn, prec->earlier_unproven_insns) ||
+		(test_bit(env->err_insn, prec->last_unproven_insns) &&
+		 !prec->this_pass.over_budget));
+}
+
+/* The pass is over its budget. Returns true if another partition replaces the last one. */
+bool bpf_undo_precision(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	bool over_budget = false, again = false;
+	struct bpf_loop *loop;
+	u32 i;
+
+	prec->this_pass.over_budget = env->over_limit;
+	prec->this_pass.calls_joined = env->calls_joined;
+	if (!env->over_limit || env->cost > env->max_cost)
+		return false;
+	if (prec->partitioned_by <= BIT(PARTITION_ADD_DEPS) ||
+	    (env->err && (prec->last_pass.over_budget || partition_helped(env)))) {
+		env->over_limit = !env->err;
+		return false;
+	}
+	env->over_limit = false;
+	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));
+	for (i = 0; i < prec->loop_cnt; i++)
+		over_budget |= prec->loops[i]->partitioned &&
+			       !bpf_loop_has_budget(prec->loops[i]);
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		if (loop->partitioned)
+			undo_loop(prec, loop);
+		/* if the old budget was enough, the pass possibly did not get to the loop */
+		if (loop->partitioned && over_budget && bpf_loop_has_budget(loop))
+			loop->tried &= ~prec->partitioned_by;
+		/* peeled_apart did not help. The partition can fit without it. */
+		if (loop->peeled_apart && !loop->kept.peeled_apart) {
+			loop->peeled_apart = false;
+			loop->tried |= BIT(PARTITION_PEELED_APART) |
+				       BIT(PARTITION_TOO_COSTLY);
+			loop->changed = again = true;
+		}
+	}
+	if (partition_by[__ffs(prec->partitioned_by)] != partition_suspect_loops && !again)
+		prec->too_costly |= prec->partitioned_by;
+	return partition_next(env) > 0;
+}
+
+/*
+ * Keep more apart in the next pass. Take the first line that adds something:
+ *
+ *  ADD_DEPS             the deps of the unproven insns; for an unreadable xreg
+ *                       type_apart first
+ *  PEEL                 suspect loops: one trip, then as many as the budget pays for
+ *  PEELED_APART         suspect loops: the join rule holds at the start of a peeled trip
+ *  TRANSITIVE_DEPS      data_deps |= control_deps; add the jumps that can skip their writes
+ *  DISJOINT_APART       disjoint values in data_deps stay apart
+ *  LOOP_DISJOINT_APART  suspect loops: the same, also at the header of the leftover;
+ *                       it replaces peeling
+ *  PEEL_MORE            suspect loops: 4, 16, 64, ... trips for each state that enters
+ *  IN_FRAMES            calls with an argument that is in the deps and has an equation
+ *
+ * All but ADD_DEPS can be undone:
+ *
+ *            +-----------------+   in the budget, or it helped
+ *       +--->| partition, pass |------------------------------------> keep
+ *       |    +--------+--------+
+ *       |             | over its part of the budget
+ *       |             v
+ *       +--- undo, take the next line
+ *       |             | no line left, one was too costly
+ *       |             v
+ *       +--- budget *= 4, undo all since one helped, see keep_precision()
+ *
+ * Returns 1 if more is kept apart.
+ */
+int bpf_partition_more(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	bool helped, undone = false;
+	struct bpf_loop *loop;
+	int ret;
+	u32 i;
+
+	ret = prec->data_deps ? 0 : alloc_masks(env);
+	if (ret)
+		return ret;
+	if (!test_bit(env->err_insn, prec->this_pass.unproven_insns))
+		env->err_insn = find_first_bit(prec->this_pass.unproven_insns, env->prog->len);
+	helped = partition_helped(env);
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		if (loop->partitioned && !helped &&
+		    (!bpf_loop_has_budget(loop) || loop->this_pass.starves)) {
+			undo_loop(prec, loop);
+			undone = true;
+			continue;
+		}
+		/* the next PARTITION_PEEL_MORE sets no_peel_prune */
+		if (loop->partitioned && loop->this_pass.peeled_cnt < loop->max_peel_cnt &&
+		    !(prec->partitioned_by == BIT(PARTITION_PEEL_MORE) &&
+		      loop->this_pass.peel_pruned))
+			loop->tried |= prec->partitioned_by;
+		if (loop->max_peel_cnt && bpf_loop_has_budget(loop)) {
+			loop->peel_cnt = max(loop->peel_cnt, loop->this_pass.peeled_cnt);
+			loop->max_peel_cnt = 0;
+			if (!loop->peeled_apart && !loop->disjoint_apart)
+				loop->budget = 0;
+		}
+		loop->last_pass = loop->this_pass;
+	}
+	/* what this pass found is not valid after the undo */
+	if (undone)
+		return partition_next(env);
+	if (!prec->this_pass.over_budget)
+		prec->pass_cost = max(prec->pass_cost, env->cost - prec->start_cost);
+	if (prec->partitioned_by <= BIT(PARTITION_ADD_DEPS))
+		prec->budget = max(prec->budget, bpf_precision_first_budget(env));
+	swap(prec->this_pass, prec->last_pass);
+	bitmap_copy(prec->last_unproven_insns, prec->last_pass.unproven_insns, env->prog->len);
+	if (helped)
+		keep_precision(prec, true);
+	prec->failing_path_due |= helped;
+	prec->first_unproven_insn = env->err_insn;
+	return find_calls_to_unproven(env) ?: partition_next(env);
+}
+
+void bpf_precision_new_pass(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	bitmap_zero(prec->this_pass.unproven_insns, env->prog->len);
+	bitmap_zero(prec->this_pass.bad_read_insns, env->prog->len);
+	bitmap_zero(prec->this_pass.call_insns, env->prog->len);
+	bitmap_zero(prec->this_pass.unproven_funcs, env->subprog_cnt);
+	prec->this_pass.suspect_loops = prec->this_pass.first_suspect_loops =
+		prec->this_pass.disjoint_joined = prec->this_pass.arg_lost_equation = 0;
+	if (prec->apart_xregno)
+		memset(prec->apart_xregno, 0, env->prog->len * sizeof(u16));
+	if (prec->data_deps && !env->replay && (prec->budget_grew || env->for_log)) {
+		keep_precision(prec, false);
+		prec->partitioned_by = prec->pass_cost = 0;
+	}
+	prec->budget_grew = prec->new_nospec = false;
+	prec->start_cost = env->cost;
+	prec->last_unproven_left = bitmap_weight(prec->last_unproven_insns, env->prog->len);
+	/* ADD_DEPS has no alternative, so it has no limit of its own */
+	if (prec->partitioned_by > BIT(PARTITION_ADD_DEPS) && !env->replay)
+		env->pass_max_cost = bpf_pass_max_cost(env);
+}
+
+static int add_loop(struct bpf_precision *prec, struct bpf_loop *loop)
+{
+	struct bpf_loop **loops = prec->loops;
+
+	if (!loop || loop->suspect_bit)
+		return 0;
+	if (is_power_of_2(prec->loop_cnt + 1)) {
+		loops = kvrealloc(loops, 2 * (prec->loop_cnt + 1) * sizeof(*loops),
+				  BPF_VERIFIER_GFP);
+		if (!loops)
+			return -ENOMEM;
+		prec->loops = loops;
+	}
+	loop->suspect_bit = BIT_ULL(prec->loop_cnt % 64);
+	loops[prec->loop_cnt++] = loop;
+	return 0;
+}
+
+int bpf_precision_init(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	u32 words = BITS_TO_LONGS(env->prog->len), i;
+	struct bpf_precision *prec;
+	unsigned long *bits;
+	int err = 0;
+
+	prec = env->precision = kvzalloc(sizeof(*prec) + 20 * words * sizeof(long),
+					 BPF_VERIFIER_GFP);
+	if (!prec)
+		return -ENOMEM;
+	bits = (void *)(prec + 1);
+	prec->this_pass.unproven_insns = bits;
+	prec->this_pass.call_insns = bits + words;
+	prec->this_pass.bad_read_insns = bits + 2 * words;
+	prec->last_pass.unproven_insns = bits + 3 * words;
+	prec->last_pass.call_insns = bits + 4 * words;
+	prec->last_pass.bad_read_insns = bits + 5 * words;
+	prec->held_insns = bits + 6 * words;
+	prec->err_insns = bits + 7 * words;
+	prec->earlier_unproven_insns = bits + 8 * words;
+	prec->control_seeds = bits + 9 * words;
+	prec->controlled_insns = bits + 10 * words;
+	prec->bad_read_insns_done = bits + 11 * words;
+	prec->controlled_insns_done = bits + 12 * words;
+	prec->def_insns = bits + 13 * words;
+	prec->last_unproven_insns = bits + 14 * words;
+	prec->bad_value_insns = bits + 15 * words;
+	prec->this_pass.unproven_funcs = bits + 16 * words;
+	prec->last_pass.unproven_funcs = bits + 17 * words;
+	prec->pass_cost = env->cost;
+	prec->budget_left = prec->budget = bpf_precision_first_budget(env);
+	prec->first_unproven_insn = prec->loop_carried_at = U32_MAX;
+	for (i = 0; i < env->prog->len && !err; i++, aux++)
+		err = add_loop(prec, aux->loop) ?: add_loop(prec, aux->callback_loop) ?:
+		      add_loop(prec, aux->recursion_loop);
+	return err;
+}
+
+void bpf_precision_free(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	if (!prec)
+		return;
+	kvfree(prec->func);
+	kvfree(prec->loops);
+	kvfree(prec->hops_to_err);
+	kvfree(prec->seen);
+	kvfree(prec->data_deps);
+	kvfree(prec);
+	env->precision = NULL;
+}
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index e057e452ec1..7b27c27c8d9 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -22,6 +22,8 @@ struct precision_per_pass {
 	unsigned long *unproven_funcs;		/* of functions */
 	u64 suspect_loops, first_suspect_loops;	/* of the unproven states, of the first one */
 	bool disjoint_joined;			/* disjoint values in data_deps were joined */
+	bool over_budget, calls_joined;
+	bool arg_lost_equation;			/* see bpf_call_needs_frames() */
 };
 
 /* callx calls one of the functions whose address is taken. They count as one function. */
@@ -51,8 +53,18 @@ struct bpf_precision {
 	unsigned long *bad_value_insns;		/* unproven, its value is possibly the cause */
 	unsigned long *last_unproven_insns;	/* in the last pass */
 	unsigned long *bad_read_insns_done;
+	unsigned long *earlier_unproven_insns;	/* in an earlier pass */
 	unsigned long *control_seeds, *controlled_insns, *controlled_insns_done, *def_insns;
+	u32 first_unproven_insn;	/* of the last pass */
 	u32 last_unproven_left;		/* last_unproven_insns whose check did not fail again */
+	struct bpf_loop **loops;
+	u32 loop_cnt;
+	u64 start_cost, pass_cost;	/* env->cost before the pass, the cost of a pass */
+	/* the cost that a partition can add to it, and that this one can add */
+	u64 budget, budget_left;
+	u8 partitioned_by, too_costly;	/* bits of PARTITION_* */
+	bool failing_path_due;		/* see bpf_failing_path_is_due() */
+	bool budget_grew;		/* see partition_next() */
 	bool new_nospec;
 
 	u16 *apart_xregno;	/* per insn, see bpf_range_of_data_dep() */
@@ -60,6 +72,7 @@ struct bpf_precision {
 	/* The path-sensitive run */
 	unsigned long *err_insns;		/* insns at which the failing path can end */
 	u32 *hops_to_err, *hops_to_exit;	/* per insn, see compute_hops() */
+	u64 *seen;				/* hash set, see bpf_failing_path_was_here() */
 	unsigned long *loop_control_deps;	/* see bpf_jumps_see_same() */
 	u32 loop_carried_at;
 	unsigned long loop_carried[XREG_WORDS];
@@ -72,6 +85,13 @@ struct state_cmp {
 	u32 disjoint_apart;		/* what differs in these xregs */
 };
 
+enum {
+	PARTITION_ADD_DEPS, PARTITION_PEEL, PARTITION_PEELED_APART, PARTITION_TRANSITIVE_DEPS,
+	PARTITION_DISJOINT_APART, PARTITION_LOOP_DISJOINT_APART, PARTITION_PEEL_MORE,
+	PARTITION_IN_FRAMES,
+	PARTITION_TOO_COSTLY,	/* in bpf_loop.tried */
+};
+
 u32 bpf_frame_mask(struct bpf_verifier_env *env, unsigned long *masks,
 		   const struct bpf_verifier_state *st, u32 fr, unsigned long *out);
 const struct bpf_reg_state *bpf_xreg_value(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4068014fedc..c79537dd671 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11540,7 +11540,7 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 		if (arg_needs_caller(env, state, sub, &caller->stack_arg_regs[i]))
 			return false;
 	}
-	return true;
+	return sub->recursive || !bpf_call_needs_frames(env, state, live);
 }
 
 static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_state *callee);
@@ -21611,6 +21611,36 @@ static bool pass_needs_restart(struct bpf_verifier_env *env)
 	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
 }
 
+/*
+ * The loops that keep the current state apart pay for the work since the last state, but not
+ * a loop that the state enters. A trip that is peeled on the budget of a loop belongs to that
+ * loop. Such trips can use up the budget of an inner loop.
+ */
+static void charge_loops(struct bpf_verifier_env *env, u64 cost)
+{
+	const struct bpf_verifier_state *st = env->cur_state;
+	const struct loop_stack_entry *e;
+	struct bpf_loop *starved_loop = NULL;
+	int fr, i;
+
+	for (fr = st->curframe; env->pass && fr >= 0; fr--) {
+		for (i = st->frame[fr]->loop_stack_cnt - 1; i >= 0; i--) {
+			e = &st->frame[fr]->loop_stack[i];
+			if ((e->peeled || e->loop->disjoint_apart) &&
+			    (e->trip || e->loop->header != st->insn_idx))
+				e->loop->this_pass.cost += cost;
+			if (e->peeled && e->trip >= e->loop->peel_cnt) {
+				if (starved_loop && e->loop->partitioned)
+					starved_loop->this_pass.starved =
+						e->loop->this_pass.starves = true;
+				return;
+			}
+			if (e->loop->partitioned && !bpf_loop_has_budget(e->loop))
+				starved_loop = e->loop;
+		}
+	}
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool level2 = env->log.level & BPF_LOG_LEVEL2;
-- 
2.55.0

