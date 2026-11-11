Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415705;
	b=qso3kdgMqbQbusIQASbSocLmZ11CgAU0oSie4dQ9tmqvtih9BGx9YF30PKZVjRaur4q3
	 MIay6sS8tn9C906SqcXDnKhPHeyit7QD2r8k3VtLcUfTSmxdb3JdBmRUUhFKqRaJ2P3dF
	 Bb7HNfXqsuoyoSdF3DOnYlhFDS0B432o9YY9AyjvcqSi7fE6KvsYY0XYXGzIWvdueOuW6
	 755wAPkf+QE2EH3tdcTMQge5nNFTyOgVLdp8kpptBBFvBCnItjwWCjONZUSbctvakINAA
	 O+kpbXl88Jack/KjwPlGCGni17VwSlADvJ8iFRmkf1kum3Tg93zBCN0uH8HFIr0eZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SeU5gJWbjUnplWaKTWCqs+Bo9xvZPOBs8KMaKSHp2Zs=;
	b=TkoRUnINk5WW7fJlLgUx6FDd6naLqZ5aJ6zbUItIblSKyGOGuLpEekQ61oJHCPS5yspA
	 xNCmrjc/vuQ59MzM33eR/xHvo0DeuNsIPZ/KE1nLZufUpZ+knsHG48/oAp2LN4d05SM4m
	 j4NWYKq/xAfjp8NH70ZyTYMB4NsRCeFhhg3atasm2JckY3CCXJc0toYISoo2fFzwhDV3z
	 Wn3AYnOFPUXc02/bwzbSYkrJHQfSccneSAuS2xusXw4rjh84MqLhzg5kNJeSkgYx3inDf
	 lQ+ChyjMfMamHKebFH9OunuwhNDWz/mlBmA0SaydzDRqadPfrCFRAz5lmF87a077vgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYmWWJLv;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD11B606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD11B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hYmWWJLv
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso1187995a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415704; x=1795020504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SeU5gJWbjUnplWaKTWCqs+Bo9xvZPOBs8KMaKSHp2Zs=;
        b=hYmWWJLvUqrn2xm01QvC0V1Q3dZFtqvdobVGw2ATO9bN9ULEyr+PpDlZ/zcf8sJ4Ut
         GZs/T1ZYfYwzMC0SKnjuaLxkq1cqh3GVo6JXysyMiDTAbvmszv5rq8nTTs18y4neJvok
         MZjbfwMcDJ+299/wTjKYBK7cmyAnQz0XgXJsyP9qlpp6XFtbfYJh+d/pBk0sTGxUedC3
         ZpXpcq96kVjc9OcL26yRqinMK88rRELW2lwGJX9Pr07yjqGU04r4RPlbT58UTxKNbng1
         cOXnsN1pIxKTUMcHqpGqvaMD/KnBJpthmjbvKmkZ0k6THUYfIsSVOiZFQKfdASBghjlr
         To0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415704; x=1795020504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SeU5gJWbjUnplWaKTWCqs+Bo9xvZPOBs8KMaKSHp2Zs=;
        b=t5D32elL/9o13j58EAofpz8MeAT4eU/v+T34drKk6R17v389v9d6okpP072yPYuKiN
         l6IkAcGP91drs24rSxgULhRjMJTkNTFVcrYbxwEFhPMIY8zs9YRqHYNepR60NzQGNOOU
         SC6dGc1SCjllOk8dpWVaR0z1L+RF2irIoxhL0Z1G237GlxwfPCreTlQ6foqJLbvVcI2e
         sV+80/SCHeOIJcyONChm9CDuRMvDnoLNSZPhqacfVDlIcOZ2YD2sdAiCejGB6Pgz3H2m
         Oq2EO8s6HSt0WIBdx0YqzTKthOAhnx2ARP6/TPxhhdrNsK4/fejnBbCXstDcarxYzKn4
         86pQ==
X-Gm-Message-State: APuU4Z9hNxjCfOCV5b/faDrKFNjrhsnG7BMaFTJV50Vi+/o3HzqFFSy7
	2omk7gMsCKilGLRsPRdMfB400HJQ9+04So1S2LQ0EKYdaHD3oH5lVJGkRh+FdQ==
X-Gm-Gg: AYBFou3AWW6InNGnPVAmjnZoQBB/BlSnGqFXmmGt2Gs/ZI5EkfOgg3ssFOiZF+YQBQV
	r1BPW3xBLB326h+InoOHFmCxFDElF0Y3piS7D9yss6JMy/aoxcH5RaMUiFx7+pKRQhHkqCcuTf0
	qudfVLv0VjBXuDBDGKTfjN1a+VmRrXnKTtusXVPfqPMeSRHktrquVgMloUBFgVBoT9e9GAkSwe5
	EV4LpMg9ggshgfTv34jamN7P/ODktWsPGCFJjx2AJJE9PUmMSZ67omtFiGqdf6gKp54o4G2C91L
	/+O29YOMfmzumKWT6ePvScci6/lw56cFCafQvYiex2yqi2WyAPyK/AgphPCaiMNQc+94E0S6rZ5
	SKQJ0voBxr/J/q7SdBRz7iUyXKQm5AwT05gfZQoNxP41gwGk8TTGU5n0jFAP/9m5CTE35+Ga2m1
	0ByAmfB4/8nigLQg2cKFogkE/cJzTXjQF8Tf3toS58CPn/907qS8VgLBJWecQ9W5Bnm6KuE5BCy
	C3TesmM4mxhqoN3tVBGgla7x5VYs6LtI8xEk/bqGHB+UfxfMzN+1osfso183uirV231M0NG9m8b
	D3w1yzXfs5C97zAtsEF1kcAuqC/j5HYoHNyS9rZr5hlWsU2xVZuT0PDJyaLNa1wGvqVa6ZXemdo
	Dul5irEzDhF8ze5fuf5rwgIVYujQBQUa7/atc37/C9JKbBQo52RQRot9tWg6cVByj+VNkdgs6TA
	==
X-Received: by 2002:a17:90b:574e:b0:3ac:8897:7ba4 with SMTP id 98e67ed59e1d1-3b182e10907mr2774399a91.5.1794415703613;
        Wed, 11 Nov 2026 08:48:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm22765a91.13.2026.11.11.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 24/29] bpf: Stop assigning ids to scalars
Date: Wed, 11 Nov 2026 16:45:47 +0000
Message-ID: <20261111164557.2659679-25-alexei.starovoitov@gmail.com>
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

A removal. Nothing learns anything about a prog from a scalar id any more.
The code that is left only maintains the ids. Stop assigning them. No
verdict changes, the number of states goes down.

	r2 = r1                     r1 and r2 get id 7
	r2 += 4                     id 7 | BPF_ADD_CONST64, delta 4
	*(u64 *)(r10 - 8) = r1      fp-8 has id 7
	if r1 > 100 goto ..         all three were refined

A scalar id in a state said that scalars hold the same value, or differ by
delta. Each insn that moves or changes a scalar had to assign, keep or
clear it. regsafe() and the join of states had to map the ids of one state
to those of the other.

What does that job now:
 - After a conditional jump refine_linked_regs() refines the linked
   registers of the jump: the live registers and stack slots that are
   a tested register + a constant on every path to the jump. Scalar
   evolution computes them before the main pass.
 - Memory behind a pointer is a linked register too: the stack slot of
   a caller that the tested register was loaded from is refined.
 - Scalar evolution compares expressions to find a copy of an induction
   variable: const_diff_at_header().
 - flow_join_makes_up() recognizes copies of a scalar by their ranges.

Remove assign_scalar_id_before_mov(), BPF_ADD_CONST and delta in
adjust_reg_min_max_vals(), the ids that a spill and a fill keep or clear,
the callers of clear_scalar_id(), bpf_clear_singular_ids() and its caller.
get_reg_width() has no user left.

The ids of pointers, references, dynptrs and iterators stay.

States that differed in scalar ids only are one state now. veristat over
the selftests, Cilium, sched_ext, katran, bpfjailer and programs in Rust:
2.3 % fewer insns and 3.7 % fewer states, in Rust 5.3 % and 6.3 %. No
verdict changes. The kernel spends 0.7 % fewer instructions on loading the
C programs and 4.9 % fewer on those in Rust.

Tests that change:
 - Log lines that pin 'id=' of a scalar lose it. The id of a packet pointer
   is smaller: ids are assigned less often.
 - two_old_ids_one_cur_id maps the scalar ids of two states: removed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c                             |   2 -
 kernel/bpf/scev.c                             |   8 +-
 kernel/bpf/verifier.c                         | 247 +-----------------
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_bounds_step.c          |   6 +-
 .../bpf/progs/verifier_direct_packet_access.c |   2 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  55 +---
 7 files changed, 19 insertions(+), 303 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 778288acb5ba..abbadba1e79f 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2924,8 +2924,6 @@ static struct flow_state *flow_arrive(struct bpf_verifier_env *env, struct bpf_v
 		flow_free_state(env, s);
 		return ERR_PTR(err);
 	}
-	/* when the registers that it was shared with are dead, or are those of the caller */
-	bpf_clear_singular_ids(env, &s->st);
 	return s;
 }
 
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 2beeda8a75b8..e08777e0fdaa 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -4237,7 +4237,7 @@ static bool is_unbound_scev_reg(struct bpf_verifier_env *env, const struct bpf_f
 {
 	const struct bpf_reg_state *reg = scev_reg_for_read(env, st, r);
 
-	return reg && reg->type == SCALAR_VALUE && !reg->id && reg->step <= 1 &&
+	return reg && reg->type == SCALAR_VALUE && reg->step <= 1 &&
 	       tnum_is_unknown(reg->var_off) &&
 	       reg->r64.size == U64_MAX && reg->r32.size == U32_MAX;
 }
@@ -4323,9 +4323,6 @@ bool bpf_is_widenable_reg_type(const struct bpf_reg_state *reg)
 static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	switch (base_type(reg->type)) {
-	case SCALAR_VALUE:
-		clear_scalar_id(reg);
-		break;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 		reg->id = ++env->id_gen;
@@ -5065,7 +5062,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		if (back && (!val || !entry_val || !bpf_reg_union_compatible(val, entry_val)))
 			continue;
 		if (test_bit(r, iters->mask_regs)) {
-			/* The range stays. It's no longer equal to the registers with its id. */
+			/* the range stays */
 			err = scev_reg_for_write(env, cur_func, r, &reg);
 			if (!err && back)
 				err = bpf_reg_union(env, reg, entry_val);
@@ -5077,7 +5074,6 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				bpf_log(log, " stays in 0..%llu, it loses bits only\n",
 					reg_umax(reg));
 			}
-			scratch_widened_reg_id(env, reg);
 			mark_scev_reg_scratched(env, r);
 			continue;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5714c4d1036b..c9c6b1367a0b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3634,27 +3634,6 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return is_pointer_regtype(reg->type);
 }
 
-static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
-					struct bpf_reg_state *src_reg)
-{
-	if (src_reg->type != SCALAR_VALUE)
-		return;
-	/*
-	 * The verifier is processing rX = rY insn and
-	 * rY->id has special linked register already.
-	 * Cleared it, since multiple rX += const are not supported.
-	 */
-	if (src_reg->id & BPF_ADD_CONST)
-		clear_scalar_id(src_reg);
-	/*
-	 * Ensure that src_reg has a valid ID that will be copied to
-	 * dst_reg and then will be used by sync_linked_regs() to
-	 * propagate min/max range.
-	 */
-	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
-		src_reg->id = ++env->id_gen;
-}
-
 static void save_register_state(struct bpf_verifier_env *env,
 				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
@@ -3681,11 +3660,6 @@ static bool is_bpf_st_mem(struct bpf_insn *insn)
 	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
 }
 
-static int get_reg_width(struct bpf_reg_state *reg)
-{
-	return fls64(reg_umax(reg));
-}
-
 /* See comment for mark_fastcall_pattern_for_call() */
 static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 					  struct bpf_func_state *state, int insn_idx, int off)
@@ -3786,16 +3760,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && reg->type == SCALAR_VALUE && env->bpf_capable) {
-		bool reg_value_fits;
-
-		reg_value_fits = get_reg_width(reg) <= BITS_PER_BYTE * size;
-		/* Make sure that reg had an ID to build a relation on spill. */
-		if (reg_value_fits)
-			assign_scalar_id_before_mov(env, reg);
 		save_register_state(env, state, spi, reg, size);
-		/* Break the relation on a narrowing spill. */
-		if (!reg_value_fits)
-			clear_scalar_id(&ss->spilled_ptr);
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   env->bpf_capable) {
 		struct bpf_reg_state *tmp_reg = &env->fake_reg[0];
@@ -4098,19 +4063,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				if (dst_regno < 0)
 					return 0;
 
-				if (env->bpf_capable && size == 4 && spill_size == 4 &&
-				    get_reg_width(reg) <= 32)
-					/* Ensure stack slot has an ID to build a relation
-					 * with the destination register on fill.
-					 */
-					assign_scalar_id_before_mov(env, reg);
+				/* coerce_reg_to_size will adjust the boundaries. */
 				state->regs[dst_regno] = *reg;
-
-				/* Break the relation on a narrowing fill.
-				 * coerce_reg_to_size will adjust the boundaries.
-				 */
-				if (get_reg_width(reg) > size * BITS_PER_BYTE)
-					clear_scalar_id(&state->regs[dst_regno]);
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -4155,11 +4109,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 		} else if (dst_regno >= 0) {
 			/* restore register state from stack */
-			if (env->bpf_capable)
-				/* Ensure stack slot has an ID to build a relation
-				 * with the destination register on fill.
-				 */
-				assign_scalar_id_before_mov(env, reg);
 			state->regs[dst_regno] = *reg;
 		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			/* If dst_regno==-1, the caller is asking us whether
@@ -7689,18 +7638,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			/* b/h/w load zero-extends, mark upper bits as known 0 */
 			coerce_reg_to_size(&regs[value_regno], size);
 		} else {
-			/*
-			 * Sign-extension can change the register value relative
-			 * to a scalar it is linked with by id (e.g. a zero-
-			 * extending fill of the same spilled stack slot), thus
-			 * drop the shared id in that case.
-			 */
-			bool no_sext = reg_umax(&regs[value_regno]) <
-					(1ULL << (size * BITS_PER_BYTE - 1));
-
 			coerce_reg_to_size_sx(&regs[value_regno], size);
-			if (!no_sext)
-				clear_scalar_id(&regs[value_regno]);
 		}
 	}
 
@@ -11736,16 +11674,11 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	callee->entry_rcu_locks = entry.active_rcu_locks;
 	callee->entry_preempt_locks = entry.active_preempt_locks;
 	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
-		/* what a scalar is linked to stays with the caller, so does the delta to it */
-		if (callee->regs[i].type == SCALAR_VALUE)
-			clear_scalar_id(&callee->regs[i]);
 		callee->regs[i].id = inherited_id(state, callee->regs[i].id);
 		callee->regs[i].parent_id = inherited_id(state, callee->regs[i].parent_id);
 		callee->regs[i].map_uid = inherited_id(state, callee->regs[i].map_uid);
 	}
 	for (i = 0; i < callee->out_stack_arg_cnt; i++) {
-		if (callee->stack_arg_regs[i].type == SCALAR_VALUE)
-			clear_scalar_id(&callee->stack_arg_regs[i]);
 		callee->stack_arg_regs[i].id = inherited_id(state, callee->stack_arg_regs[i].id);
 		callee->stack_arg_regs[i].parent_id =
 			inherited_id(state, callee->stack_arg_regs[i].parent_id);
@@ -11791,19 +11724,18 @@ static int exit_func_on_its_own(struct bpf_verifier_env *env)
 
 static u32 fresh_id(struct bpf_verifier_env *env, struct bpf_idmap *idmap, u32 id)
 {
-	u32 flags = id & BPF_ADD_CONST, i;
+	u32 i;
 
-	id &= ~BPF_ADD_CONST;
 	if (!id)
 		return 0;
 	for (i = 0; i < idmap->cnt; i++)
 		if (idmap->map[i].old == id)
-			return idmap->map[i].cur | flags;
+			return idmap->map[i].cur;
 	if (idmap->cnt == BPF_ID_MAP_SIZE)
 		return 0;
 	idmap->map[idmap->cnt].old = id;
 	idmap->map[idmap->cnt].cur = ++env->id_gen;
-	return idmap->map[idmap->cnt++].cur | flags;
+	return idmap->map[idmap->cnt++].cur;
 }
 
 /*
@@ -17876,13 +17808,6 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	/* Apply bswap if alu64 or switch between big-endian and little-endian machines */
 	bool need_bswap = alu64 || (to_le == is_big_endian);
 
-	/*
-	 * If the register is mutated, manually reset its scalar ID to break
-	 * any existing ties and avoid incorrect bounds propagation.
-	 */
-	if (need_bswap || insn->imm == 16 || insn->imm == 32)
-		clear_scalar_id(dst_reg);
-
 	if (need_bswap) {
 		if (insn->imm == 16)
 			dst_reg->var_off = tnum_bswap16(dst_reg->var_off);
@@ -17983,7 +17908,6 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * like any other. At this insn the branch is a part of the state that is looked at:
 	 * it must not be compared with it.
 	 */
-	clear_scalar_id(reg);
 	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
 }
 
@@ -18193,10 +18117,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
-	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	struct bpf_insn_aux_data *aux = cur_aux(env);
 	u8 opcode = BPF_OP(insn->code);
-	int err;
 
 	dst_reg = &regs[insn->dst_reg];
 	if (BPF_SRC(insn->code) == BPF_X)
@@ -18303,69 +18225,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EFAULT;
 	}
-	/*
-	 * For alu32 linked register tracking, we need to check dst_reg's
-	 * umax_value before the ALU operation. After adjust_scalar_min_max_vals(),
-	 * alu32 ops will have zero-extended the result, making umax_value <= U32_MAX.
-	 */
-	u64 dst_umax = reg_umax(dst_reg);
-
-	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
-	if (err)
-		return err;
-	/*
-	 * Compilers can generate the code
-	 * r1 = r2
-	 * r1 += 0x1
-	 * if r2 < 1000 goto ...
-	 * use r1 in memory access
-	 * So remember constant delta between r2 and r1 and update r1 after
-	 * 'if' condition.
-	 */
-	if (env->bpf_capable &&
-	    (BPF_OP(insn->code) == BPF_ADD || BPF_OP(insn->code) == BPF_SUB) &&
-	    dst_reg->id && is_reg_const(src_reg, alu32) &&
-	    !(BPF_SRC(insn->code) == BPF_X && insn->src_reg == insn->dst_reg)) {
-		u64 val = reg_const_value(src_reg, alu32);
-		s32 off;
-
-		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
-			goto clear_id;
-
-		if (alu32 && (dst_umax > U32_MAX))
-			goto clear_id;
-
-		off = (s32)val;
-
-		if (BPF_OP(insn->code) == BPF_SUB) {
-			/* Negating S32_MIN would overflow */
-			if (off == S32_MIN)
-				goto clear_id;
-			off = -off;
-		}
-
-		if (dst_reg->id & BPF_ADD_CONST) {
-			/*
-			 * If the register already went through rX += val
-			 * we cannot accumulate another val into rx->off.
-			 */
-clear_id:
-			clear_scalar_id(dst_reg);
-		} else {
-			if (alu32)
-				dst_reg->id |= BPF_ADD_CONST32;
-			else
-				dst_reg->id |= BPF_ADD_CONST64;
-			dst_reg->delta = off;
-		}
-	} else {
-		/*
-		 * Make sure ID is cleared otherwise dst_reg min/max could be
-		 * incorrectly propagated into other registers by sync_linked_regs()
-		 */
-		clear_scalar_id(dst_reg);
-	}
-	return 0;
+	return adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
 }
 
 /*
@@ -18579,7 +18439,6 @@ void bpf_reg_union_range(struct bpf_reg_state *acc, const struct bpf_reg_state *
 /*
  * Extends acc's scalar range to include src's scalar range.
  * Caller must ensure that other kinds of metadata is compatible.
- * Caller must clear acc's scalar ID.
  */
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src)
@@ -18720,7 +18579,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					/* case: R1 = R2
 					 * copy register state to dest reg
 					 */
-					assign_scalar_id_before_mov(env, src_reg);
 					*dst_reg = *src_reg;
 				} else {
 					/* case: R1 = (s8, s16 s32)R2 */
@@ -18730,14 +18588,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							insn->src_reg);
 						return -EACCES;
 					} else if (src_reg->type == SCALAR_VALUE) {
-						bool no_sext;
-
-						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
-						if (no_sext)
-							assign_scalar_id_before_mov(env, src_reg);
 						*dst_reg = *src_reg;
-						if (!no_sext)
-							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
@@ -18751,29 +18602,10 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						insn->src_reg);
 					return -EACCES;
 				} else if (src_reg->type == SCALAR_VALUE) {
-					if (insn->off == 0) {
-						bool is_src_reg_u32 = get_reg_width(src_reg) <= 32;
-
-						if (is_src_reg_u32)
-							assign_scalar_id_before_mov(env, src_reg);
-						*dst_reg = *src_reg;
-						/* Make sure ID is cleared if src_reg is not in u32
-						 * range otherwise dst_reg min/max could be incorrectly
-						 * propagated into src_reg by sync_linked_regs()
-						 */
-						if (!is_src_reg_u32)
-							clear_scalar_id(dst_reg);
-					} else {
-						/* case: W1 = (s8, s16)W2 */
-						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
-
-						if (no_sext)
-							assign_scalar_id_before_mov(env, src_reg);
-						*dst_reg = *src_reg;
-						if (!no_sext)
-							clear_scalar_id(dst_reg);
+					*dst_reg = *src_reg;
+					/* case: W1 = (s8, s16)W2 */
+					if (insn->off)
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
-					}
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -20804,69 +20636,6 @@ static void adjust_btf_func(struct bpf_verifier_env *env)
 		aux->func_info[i].insn_off = env->subprog_info[i].start;
 }
 
-/* Find id in idset and increment its count, or add new entry */
-static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < idset->num_ids; i++) {
-		if (idset->entries[i].id == id) {
-			idset->entries[i].cnt++;
-			return;
-		}
-	}
-	/* New id */
-	if (idset->num_ids < BPF_ID_MAP_SIZE) {
-		idset->entries[idset->num_ids].id = id;
-		idset->entries[idset->num_ids].cnt = 1;
-		idset->num_ids++;
-	}
-}
-
-/* Find id in idset and return its count, or 0 if not found */
-static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < idset->num_ids; i++) {
-		if (idset->entries[i].id == id)
-			return idset->entries[i].cnt;
-	}
-	return 0;
-}
-
-/*
- * Clear singular scalar ids in a state.
- * A register with a non-zero id is called singular if no other register shares
- * the same base id. Such registers can be treated as independent (id=0).
- */
-void bpf_clear_singular_ids(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *st)
-{
-	struct bpf_idset *idset = &env->idset_scratch;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-
-	idset->num_ids = 0;
-
-	bpf_for_each_reg_in_vstate(st, func, reg, ({
-		if (reg->type != SCALAR_VALUE)
-			continue;
-		if (!reg->id)
-			continue;
-		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
-	}));
-
-	bpf_for_each_reg_in_vstate(st, func, reg, ({
-		if (reg->type != SCALAR_VALUE)
-			continue;
-		if (!reg->id)
-			continue;
-		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) == 1)
-			clear_scalar_id(reg);
-	}));
-}
-
 /* Return true if it's OK to have the same insn return a different type. */
 static bool reg_type_mismatch_ok(enum bpf_reg_type type)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 9a7bf79242c9..b39275b92e6a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1476,7 +1476,7 @@ __naked void sub64_full_overflow(void)
 SEC("socket")
 __description("64-bit subtraction, partial overflow, result in unbounded reg")
 __success __log_level(2)
-__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar(id=1-1)")
+__msg("3: (1f) r3 -= r2 {{.*}} R3=scalar()")
 __retval(0)
 __naked void sub64_partial_overflow(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index 51b703058cf7..b42717a825c6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -299,7 +299,7 @@ SEC("socket")
 __success __log_level(2)
 __msg("r0 += 8 {{.*}}smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
 __msg("from 4 to 6: R0=scalar(smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
-__msg("r1 = r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=umin=smin32=umin32=104,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
+__msg("r1 = r0 {{.*}}R1=scalar(smin=umin=smin32=umin32=104,smax=umax=smax32=umax32=176,{{.*}}step=8+24)")
 __msg("r1 += 24 {{.*}}R1=scalar({{.*}}smin=umin=smin32=umin32=128,smax=umax=smax32=umax32=200,{{.*}}step=8+24)")
 __naked void step_bounds_resync_after_arith(void)
 {
@@ -336,10 +336,10 @@ l_out_%=:						\
  */
 SEC("socket")
 __success __log_level(2)
-__msg("r1 = (s16)r0 {{.*}}R1=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
+__msg("r1 = (s16)r0 {{.*}}R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
 __msg("r2 = (s16)r0 {{.*}}R2=scalar(smin=smin32=-24,smax=smax32=144,{{.*}}step=0+24)")
 __msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)")
-__msg("w4 = (s16)w1 {{.*}}R4=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
+__msg("w4 = (s16)w1 {{.*}}R4=scalar(smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
 __msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,var_off=(0x0; 0xffffffff))")
 __naked void step_movsx_bounds_on_line(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 6c1d2014b95b..212c08a27058 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -569,7 +569,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("direct packet access: test23 (x += pkt_ptr, 4)")
-__failure __msg("invalid access to packet, off=31 size=8, R5(id=3,off=31,r=0)")
+__failure __msg("invalid access to packet, off=31 size=8, R5(id=1,off=31,r=0)")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void test23_x_pkt_ptr_4(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index e22120e5858f..56c2412608a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -11,11 +11,10 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-/* scalar in [0, max] that shares id with other registers, as it is in the log */
-#define LINKED(id, max, mask) \
-	"scalar(id=" id ",smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+/* scalar in [0, max], as it is in the log. @id: the registers that hold copies of one value. */
 #define ALONE(max, mask) \
 	"scalar(smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+#define LINKED(id, max, mask) ALONE(max, mask)
 
 /*
  * Registers r{0,1,2} have the same scalar ID.
@@ -151,7 +150,7 @@ __naked void linked_regs_broken_link(void)
 SEC("socket")
 __success __log_level(2)
 __msg("13: (25) if r1 > 0x7 goto pc+0        ; R1=" ALONE(7, 0x7))
-__msg("10: R0=0 R6=scalar(id={{.*}}umax32=255,{{.*}} R7=scalar(id={{.*}}umax32=255,")
+__msg("10: R0=0 R6=scalar({{.*}}umax32=255,{{.*}} R7=scalar({{.*}}umax32=255,")
 __msg("5: R0=0 R6=" ALONE(255, 0xff))
 __naked void precision_many_frames(void)
 {
@@ -317,7 +316,7 @@ __naked void linked_regs_too_many_regs(void)
 
 SEC("socket")
 __failure __log_level(2)
-__msg("5: (3d) if r8 >= r0 goto pc+3         ; R0=scalar(umin=1) R7=scalar(id=1,umax=0xfffffffffffffffe) R8=scalar(id=1,umax=0xfffffffffffffffe)")
+__msg("5: (3d) if r8 >= r0 goto pc+3         ; R0=scalar(umin=1) R7=scalar(umax=0xfffffffffffffffe) R8=scalar(umax=0xfffffffffffffffe)")
 __msg("div by zero")
 __naked void linked_regs_broken_link_2(void)
 {
@@ -680,52 +679,6 @@ __naked void two_nil_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
-/*
- * Check that two different scalar IDs in the state that is there can't be
- * mapped to the same scalar ID in the state that arrives.
- */
-SEC("socket")
-__success __log_level(2)
-__not_msg("from 10 to 11: within")
-__msg("11: R0=0 R6=" ALONE(255, 0xff) " R7=" ALONE(255, 0xff))
-__naked void two_old_ids_one_cur_id(void)
-{
-	asm volatile (
-	/* Give unique scalar IDs to r{6,7} */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	"r6 = r0;"
-	"r8 = r0;"
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	"r7 = r0;"
-	"r9 = r0;"
-	"r0 = 0;"
-	/* Maybe make r{6,7} IDs identical */
-	"if r6 <= r7 goto l1_%=;"
-	"r6 = r7;"
-"l1_%=:"
-	/*
-	 * Get here in two states:
-	 * - first:  r6{.id=A}, r7{.id=B}
-	 * - second: r6{.id=B}, r7{.id=B}
-	 * Currently we don't want to consider the second one to be within
-	 * the first one. Thus they are joined.
-	 */
-	"r2 = r10;"
-	"r2 += r6;"
-	"r2 += r7;"
-	/*
-	 * keep r8 and r9 live, otherwise r6->id and r7->id
-	 * will become singular and reset to zero before if r6 <= r7
-	 */
-	"r9 += r8;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
 SEC("socket")
 /* Note the flag, see verifier.c:opt_subreg_zext_lo32_rnd_hi32() */
 __flag(BPF_F_TEST_RND_HI32)
-- 
2.55.0

