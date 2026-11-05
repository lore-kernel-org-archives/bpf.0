Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911617;
	b=tZd1JkG6jQetdwxC9CAdab/pnPOsT99CL8+NEFehsGfe2l/GbNuzJ6+KosZYnlYZ8eaq
	 lfPsM0kY3LPytLW7CILIn6TcDzuSN0wW+Vt/69XfBnOwZ1pgGARk0ATEwxC13joYf3W65
	 aR040rvFg5zGfz1tl7wiADIOf57lysWrujrNzeJiBlekK6TXSPnLuyEH/+goIxwMOGEXM
	 1kXB42E6L2BSrEV0QS+7A3U7JED/3xO9uGCJlU07suYKam/U+bODwVvTBjvSmfthLEozc
	 +OTuwv0WSnDYyv+o1fTKew02S8a9KSTBBcHqIqIcyuzx9CaRUmYgaBQIBMM02TAddkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zkd4xiauCZk32f4hUl6cCjGKki3RHHeQc5JwGYDkuSk=;
	b=GNQlsRVB0UCgDz4AcVfFLW2YHLX6LBYcBlw0LxT/zMHt+DY1BHsWZg5x46nokNyTDY/w
	 nLtsxpOJxTK3ToblJoMtglIPDbJfdK8LVipFjMhm32LsSageOSQZkxLqLNfEdPxCEFFdi
	 sdpivcCPkLuLABC9/o61CWxzXeX5yYyaOFVYPfAZcr1/ciEK3f1SZ66Bje4kfiEuVx5cN
	 GdtEw9BH685TesjXmjKuMC2a/CL0/dcrSuNLMa8JxnY17uN/mwUQ4dmgoj9VD+R3xw5iJ
	 UpyoT0HfM+cLAhAPL0Q3hTSXq4QTSHVvUke/kq7olcmVaht9Nmj1k+dPh2gTkUEQsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZAjM5f0;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B6606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZAjM5f0
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1097616a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911617; x=1794516417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zkd4xiauCZk32f4hUl6cCjGKki3RHHeQc5JwGYDkuSk=;
        b=HZAjM5f0CRJei8jzH8brd7TD4yYmgO1co8WDaPUHM9H0dOVuibJpE0Lqfg/GShRsVI
         wseHZ+rIt4bIds/YP064fiOcL94ZTm1Yo5L9z9kuvGwKVk4WjH2YJCkP2z5HepB4j2+j
         vGUKsqSm6bmET5hYRZs8zpwXJ2/mYbzipCZ8jCDlbO+uhFKsZ/TXNyPJ41JUCIXsERvg
         lfnDfOdp0BAh+qy1NkmNBt7Bv3SFLeDUtrmU/tdTtN/lYi3N+bHNK8+U9fMyBsBJavKN
         j1LtSMvQ4g8efhiMIQTh33aa+n8TdcwsJvnyDxwt9NkoHIy+6uGOP6s8VO5s3vKl5DkY
         nFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911617; x=1794516417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zkd4xiauCZk32f4hUl6cCjGKki3RHHeQc5JwGYDkuSk=;
        b=UCSnW9B/g84U8qLcrQLrNf+KzQFxPDQMPaBkXE1YznqxhQxqlgWLu1ID6FiHwyDguB
         WOPAIkKWSNFU2AL1A7q2k5lwD+OeozhTXpYqTnj2h8t9vxdsc60ln5Jar/wdSRDu49qz
         rQuvnbkUt84h907w41rtD2FmTCL1mwchbRVZ8GzWXP9fnKKMSAOSeNySLe+BOrYk8v8l
         RFLcONIRnK+z5CrVoHmUrYyjjnBu0Rwdra5NKgXX0BnBZ1kqfuA9dnvuMOnu60xhRPa8
         l2w4EKOHQOgr03Y6MExPeDRSxqri0Go1RHkDcjei4tLihk+ebS+VACpRi9kXiovNqSbC
         MSLg==
X-Gm-Message-State: APuU4Z+tmvbyQ5NPthOK6PPXLRAGR7yUV81BtMPILhe3d+QCbjQuNYhb
	GgyEdv25YnhnjUb5tIUHH8HzXmz7ofF+FQfdSxi7+1Uege9199kCrTEE1BGA3g==
X-Gm-Gg: AYBFou0RijF+gCk9RnQN4fVCiiNUyl3ZaQTQvxzX5fC9c5zwZOwETy/aFNim2HdfupL
	nW37Mbf8O0/N32IleKTqoHW8+q7SuiRh4Br0WmYq/8G5YXnHOjJIucotNjACNpxYXoVOI13AAdc
	sCubVDWajvluHrBGx9Zl9wwzPo0+gDAmCsRBoUDmb2HVGwM1I8fcql5OHebHfFsm+GroJtBqk/e
	gYFLUIp5/hZ4QAZ55bg8Q5y9mzxn6N9qGjTA7z90erIPku43UZmmFUGRN+BgeH7wMZIi/XPP3x/
	F1UBCF/XaFikep7Fjl6Ncc+ooNaL6y2CSt3qo0AXTMJ/U5QpDZc8S3lGC2OyfrpWi8SHT4l8FsI
	SPZu+uCDlNBfp8G6WaypmULcHCWQHuIKK1UleHcavrTsj2CYdHBc+V4D9MNAqO3jNhTTNK3+xSb
	hYeTA2Ip44lTMCjCQNCLVLSchZ4gaBxQMasp44NRpbsmFaUh7Tlb3VsBdDWVoOTaiAMiYYQUoKI
	mRZ3olW9ZY9lH7ZOaa6psolHBiDL0NNiqL+HaLGmVKHUHCbQJG88XsfwFk6vfZ8q1k+poYX7kvI
	jt371PA+6IP8/JQtociDhJPYJmwG3yrqCxIvoYOnKB2Z3I9tbZ2txvuqrqdqrg5JjkVgiSo39bg
	i5F9KRxyl8kFS04Sg16T0q0ug9EwYCyMSEbYD58qTKD8erImGpEI8UQIbgQQAyJvqoZ2csq/Baj
	642te9qQcLrE0oDjf7wLQ=
X-Received: by 2002:a17:90a:d88f:b0:3ac:a203:e0a1 with SMTP id 98e67ed59e1d1-3b0db6f7401mr203791a91.37.1793911616255;
        Thu, 05 Nov 2026 12:46:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32678ecsm5516756a91.9.2026.11.05.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 17/35] bpf: Enter and leave loops in the main pass, build flow.c
Date: Thu,  5 Nov 2026 20:44:54 +0000
Message-ID: <20261105204513.2230344-18-alexei.starovoitov@gmail.com>
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

The main pass joins the states that meet at an insn. At the head of a loop
with a join alone real progs are rejected. bpf_flow_loop_enter() has three
methods for a state that enters a loop, and tries them in this order:
1. Count. scx_lavd/lavd_dispatch:
  for (int j = 0; j < LAVD_CPDOM_MAX_NR; j++) {
      ...
      cpdom_id = get_neighbor_id(cpdomc, i, j);
Scalar evolution finds at most 128 iterations. The state gets j = [0, 127]
and covers all of them: one pass through the body, no may_goto, as today.

2. Walk: each iteration has its own state. Selftest netif_receive_skb:
  for (i = 0; i < len; i++) {
      delta = s1[i] - s2[i];
      if (delta || s1[i] == 0 || s2[i] == 0)
          break;
The compiler tests 'i - 9 < 247', unsigned: no count. After a join i is
unknown: "math between map_value pointer and register with unbounded .."
In a walk i is a constant and decides its test.
flow_try_walk() starts a walk. It goes on while each iteration but the
first decides a jump that leaves the loop, for at most 4096 insns, or two
iterations of a longer loop. A loop with calls is not walked.
A loop with two entries is walked whatever its jumps do. bpfjailer:
  for (int i = BPFJ_MAX_POD_PER_PID - 1; i >= 0; --i) {
      if (i >= num_pods)
          continue;
The compiler copies the test in front of the loop and jumps into its
middle. Scalar evolution says "unsupported loop: irreducible". With a join
14 progs get a may_goto in a loop of 8 iterations.

3. Join, widen, add may_goto. Test hash_fnv_bytes of rust-bpf:
  for b in bytes {
      h = (h ^ *b as u64).wrapping_mul(0x100000001b3);
The length is unknown and h differs in each iteration. Today that is
"BPF program is too large. Processed 1000001 insn". Now the walk ends in
the second iteration, flow.c widens h to an unknown scalar, and the state
that returns next is covered: 160 insns. That shows that each iteration is
safe, not that the loop ends. Thus the loop gets a may_goto. If there is
no place for one: "loop at insn N never exits".

bpf_flow_loop_leave() removes the loops that an edge leaves. flow.c and
the two functions call each other, so flow.o is built from here on, and
do_check() does not use it yet. A loop that leaks a reference in each
iteration has no fixpoint: check_refs_taken_in_loop() rejects a state that
returns to the head with a reference that no register and no slot holds.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  72 ++++++++++
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/verifier.c        | 249 +++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1963a079589d..ab7f62941b76 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -364,6 +364,13 @@ struct bpf_loop_iters {
 	struct cnum64 iv_range;
 };
 
+/* Where may_goto that the verifier adds goes, see check_loop_guard() */
+enum bpf_guard_edge {
+	BPF_NO_GUARD_EDGE,
+	BPF_GUARD_LEAVES_SUBPROG,
+	BPF_GUARD_LEAVES_LOOP,
+};
+
 struct loop_stack_entry {
 	struct bpf_verifier_state *entry_state;
 	u32 min_header_count;
@@ -379,6 +386,10 @@ struct loop_stack_entry {
 	u32 apart:1;
 	/* max_header_count follows from the state at the entry, not from patience */
 	u32 counted:1;
+	/* the walk goes on for as long as each iteration decides a jump that leaves the loop */
+	u32 probe:1;
+	/* this one did */
+	u32 decided:1;
 	/*
 	 * How many times the state came back to the head of the loop. With @apart that is
 	 * the iteration that it is in. A state that stands for many iterations is a join, and has
@@ -387,6 +398,12 @@ struct loop_stack_entry {
 	u32 trip;
 	/* the number of references that the state had when it entered the loop */
 	u32 refs;
+	/*
+	 * A walk on patience: which one it is, and how many insns may be looked at in it, see
+	 * env->walk_insns. The size of the loop says nothing about the functions that it calls.
+	 */
+	u32 walk_id;
+	u32 walk_patience;
 	int iv_reg;
 	struct cnum64 iv_range;
 };
@@ -603,6 +620,11 @@ struct bpf_verifier_state {
 	 * and their packet pointers are not in the state, see bpf_flow_return().
 	 */
 	bool changed_pkt_data;
+	/*
+	 * Not zero in a function that is verified on its own: the call that the
+	 * state at its entry came from, see bpf_flow_call().
+	 */
+	u32 flow_entry;
 
 	/*
 	 * First and last insn idx of this verifier state.
@@ -807,8 +829,23 @@ struct bpf_loop {
 	bool exits_overflow;
 	/* @exits of a loop in this one is cut. Then @exits of this loop can lack exits too. */
 	bool nested_exits_overflow;
+	/* every trip goes through an insn that stops the loop, see flow_is_bound() */
+	bool rt_bounded;
+	/* insns in the loop, nested loops included */
+	u32 nr_insns;
+	/*
+	 * a walk on patience whose jumps were all decided didn't get to the end of the loop:
+	 * there is no other try
+	 */
+	bool walk_failed;
+	/* functions of the program are called in the loop */
+	bool has_calls;
+	/* not rt_bounded: there are places for may_goto, see guard_to in bpf_insn_aux_data */
+	bool has_guards;
 	/* and it is going to be there, see bpf_flow_loop_gets_guards() */
 	bool guarded;
+	/* a state went through it without the edges of may_goto, see bpf_flow_loop_gets_guards() */
+	bool no_guard_edges;
 	/*
 	 * Loop-entry registers used to compute stack addresses for loads,
 	 * stores and calls requiring fixed stack offsets, in this and nested
@@ -860,6 +897,9 @@ struct bpf_insn_aux_data {
 	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
 	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
 	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
+	/* regs that hold a number or a pointer to arena; that, or a pointer to a plain map value */
+	u16 plain_regs;
+	u16 value_regs;
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
 	u64 nospec:1; /* do not execute this instruction speculatively */
@@ -877,6 +917,7 @@ struct bpf_insn_aux_data {
 	u64 guard_place:1; /* it's the place for may_goto if the loop needs one */
 	u64 guard_at_header:1; /* there is no better place than the head of the loop */
 	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
+	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -1060,6 +1101,7 @@ struct bpf_subprog_info {
 	bool can_unwind: 1; /* has unwind_exit */
 	bool recursive: 1; /* on a cycle of the call graph */
 	bool in_recursion: 1; /* recursive, or a recursive subprog gets to it */
+	bool addr_taken: 1; /* callx calls nothing else */
 	bool via_callx: 1; /* callx calls it */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
@@ -1273,6 +1315,10 @@ struct bpf_verifier_env {
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	bool restart;			/* see bpf_flow_next_is_no_bound() */
+	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
+	u32 walk_cnt;			/* see loop_stack_entry.walk_id */
+	u32 *walk_insns;		/* the insns that were looked at in each of them */
 	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
@@ -1420,6 +1466,7 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	struct bpf_flow *flow;
 	struct bpf_join_state *join;
 };
 
@@ -1621,6 +1668,31 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 		    bool widen);
 void bpf_join_free(struct bpf_verifier_env *env);
 
+/* flow.c */
+int bpf_flow_prepare(struct bpf_verifier_env *env);
+void bpf_flow_reset(struct bpf_verifier_env *env);
+void bpf_flow_free(struct bpf_verifier_env *env);
+bool bpf_flow_is_point(struct bpf_verifier_env *env, int insn_idx);
+struct bpf_verifier_state *bpf_flow_keep_state(struct bpf_verifier_env *env,
+					       const struct bpf_verifier_state *st);
+int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		     int insn_idx, int prev_insn_idx);
+int bpf_flow_guard_edge(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			int insn_idx, int prev_insn_idx, enum bpf_guard_edge edge);
+int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx);
+int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		  struct bpf_verifier_state *entry, int subprog, int call_idx);
+int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
+void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h);
+bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env);
+void bpf_flow_loop_gets_guards(struct bpf_verifier_env *env, int h);
+void bpf_flow_new_round(struct bpf_verifier_env *env);
+int bpf_flow_place_guards(struct bpf_verifier_env *env);
+int bpf_flow_compute_kinds(struct bpf_verifier_env *env);
+bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r);
+/* verifier.c, for flow.c */
+int bpf_flow_loop_leave(struct bpf_verifier_env *env, bool *enters);
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop, bool *ends_walk);
 int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		    const struct bpf_verifier_state *exit, int call_idx);
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 3e0b096cfc9f..ab3ba42596ec 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o join.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o join.o flow.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03940b2fc516..33e3da724975 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21254,6 +21254,255 @@ static int handle_loop_entry_exit(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * The current state came back to the head of a loop. If it has a reference more than the states
+ * that are there it is neither within one of them nor joined with one. It goes around again:
+ *	bpf_for(i, 0, n) { if (!p) p = bpf_ringbuf_reserve(...); ... }
+ * That ends when the loop stops taking references, or when there is no place left to keep them.
+ * A reference that no live register and no live stack slot holds cannot be released any more.
+ * There is nothing to wait for.
+ *
+ * Only what was taken in the loop is looked at. New references are added at the end. What callers
+ * hold is not in the state of a function that is verified on its own.
+ */
+static int check_refs_taken_in_loop(struct bpf_verifier_env *env,
+				    const struct loop_stack_entry *entry)
+{
+	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR) | (1 << STACK_ITER);
+	struct bpf_verifier_state *st = env->cur_state;
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *frame;
+	struct bpf_reg_state *reg;
+	bool held;
+	int i, j, id;
+
+	for (i = entry->refs; i < st->acquired_refs; i++) {
+		if (st->refs[i].type != REF_TYPE_PTR)
+			continue;
+		id = st->refs[i].id;
+		held = false;
+		for (j = 0; j < st->acquired_refs; j++)
+			if (st->refs[j].type == REF_TYPE_PTR && st->refs[j].parent_id == id)
+				held = true;
+		bpf_for_each_reg_in_vstate_mask(st, frame, reg, stack, mask, ({
+			if (reg->id == id || reg->parent_id == id)
+				held = true;
+		}));
+		if (held)
+			continue;
+		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n", id, st->refs[i].insn_idx);
+		verbose(env, "nothing holds it in the next iteration of the loop at insn %d\n",
+			entry->loop_id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/* How many insns it may take to go through the iterations of a loop one by one. */
+#define BPF_FLOW_MAX_WALK	100000
+/* The same when it is not known that the walk gets to the end of the loop. */
+#define BPF_FLOW_MAX_TRY	4096
+
+/* How many times the current insn is looked at because of the loops around it that are walked. */
+static u64 flow_walk_factor(const struct bpf_verifier_state *st)
+{
+	const struct loop_stack_entry *e;
+	u64 factor = 1;
+	u32 fr, i;
+
+	for (fr = 0; fr <= st->curframe; fr++) {
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++) {
+			e = &st->frame[fr]->loop_stack[i];
+			/* the walk of a loop with two entries pays as it goes, see env->walk_insns */
+			if (e->counted || e->probe)
+				factor = min_t(u64, factor * max(e->max_header_count, 1U), U32_MAX);
+		}
+	}
+	return factor;
+}
+
+/*
+ * The current state enters the loop of @entry, for which there is no count. It's found out on the
+ * way whether the loop has an end: the walk goes on for as long as the jumps that leave the loop
+ * are decided. Returns 1 if the iterations are kept apart from now on, 0 if that takes too long.
+ */
+static int flow_try_walk(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct bpf_loop *loop = env->insn_aux_data[entry->loop_id].loop;
+	u64 factor = flow_walk_factor(env->cur_state);
+	u32 patience, *walk_insns;
+
+	patience = env->allow_uninit_stack && !loop->rt_bounded && !loop->has_calls ?
+		   BPF_FLOW_MAX_TRY : 0;
+	if (loop->walk_failed)
+		patience = 0;
+	/* Two trips for a loop of any length. Many a loop is left in the second one. */
+	if (patience && factor == 1)
+		patience = max_t(u64, patience, 2ULL * loop->nr_insns);
+	if (factor * loop->nr_insns > patience)
+		return 0;
+	entry->max_header_count = max(patience / (u32)(factor * loop->nr_insns), 1U);
+	entry->terminates = true;
+	/* scalar evolution has nothing to say about a loop with two entries */
+	entry->probe = !loop->irreducible;
+	entry->walk_id = env->walk_cnt + 1;
+	if (is_power_of_2(entry->walk_id)) {
+		walk_insns = kvrealloc(env->walk_insns, 2 * entry->walk_id * sizeof(u32),
+				       GFP_KERNEL_ACCOUNT);
+		if (!walk_insns)
+			return -ENOMEM;
+		env->walk_insns = walk_insns;
+	}
+	env->walk_cnt++;
+	env->walk_insns[entry->walk_id] = 0;
+	entry->walk_patience = patience;
+	entry->apart = true;
+	return 1;
+}
+
+/*
+ * The current state gets to env->insn_idx. Leave the loops that the insn is not in.
+ * @enters: the insn is the head of a loop that the state is not in yet.
+ */
+int bpf_flow_loop_leave(struct bpf_verifier_env *env, bool *enters)
+{
+	struct bpf_func_state *frame = cur_func(env);
+	int err;
+
+	err = loop_stack_pop(env);
+	if (err)
+		return err;
+	*enters = env->insn_aux_data[env->insn_idx].loop &&
+		  (!frame->loop_stack_cnt ||
+		   frame->loop_stack[frame->loop_stack_cnt - 1].loop_id != env->insn_idx);
+	return 0;
+}
+
+/*
+ * Enter the loops that env->insn_idx is in.
+ *
+ * When the number of iterations follows from the state that enters a loop at its head
+ * the state is made to stand for all of them, with the ranges that induction variables
+ * have in that many iterations. The state that comes back to the head is then expected
+ * to be within it.
+ * Otherwise the state is left as it is. What comes back to the head is joined with it.
+ * @ends_walk: the state came back to the head and is the last one that is kept apart from
+ * the states of other iterations.
+ */
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop, bool *ends_walk)
+{
+	struct bpf_verifier_state *cur = env->cur_state, *entry_state;
+	const struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	struct bpf_loop_iters iters;
+	struct bpf_loop *loop;
+	bool pushed, decided;
+	u32 trip;
+	u64 per_trip;
+	int err;
+
+	err = loop_stack_push(env, &pushed);
+	if (err)
+		return err;
+
+	if (frame->loop_stack_cnt == 0)
+		return 0;
+
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	if (env->insn_idx != entry->loop_id)
+		return 0;
+
+	/*
+	 * No edge goes from a call to itself: the call goes on with one function of a set, see
+	 * split_func_set(), in the same iteration.
+	 */
+	if (!pushed && cur->last_insn_idx == env->insn_idx &&
+	    BPF_CLASS(insn->code) == BPF_JMP && BPF_OP(insn->code) == BPF_CALL)
+		return 0;
+
+	/* The callback came back to the helper that calls it, in the same iteration. */
+	if (frame->callback_depth)
+		return 0;
+
+	/* If nothing was pushed and env->insn_idx is a loop header, we've taken a backedge. */
+	if (!pushed) {
+		if (!entry->apart) {
+			entry->trip++;
+			*backedge = true;
+			return check_refs_taken_in_loop(env, entry) ?: maybe_clamp_scev_regs(env);
+		}
+		loop = env->insn_aux_data[env->insn_idx].loop;
+		/* the next iteration is another kind of state, there is no cycle */
+		trip = entry->trip;
+		decided = !entry->probe || entry->decided || !trip;
+		entry->decided = false;
+		if (decided && ++entry->trip < entry->max_header_count &&
+		    (entry->counted ||
+		     env->walk_insns[entry->walk_id] <= entry->walk_patience))
+			return 0;
+		/* there is no such iteration at run time */
+		if (entry->counted) {
+			*drop = true;
+			return 0;
+		}
+		/*
+		 * The walk doesn't get to the end of the loop. From now on what comes back to
+		 * the head is joined with what is there. The loop gets may_goto.
+		 */
+		if (!loop->rt_bounded && !loop->has_guards) {
+			verbose(env, "loop at insn %d never exits\n", env->insn_idx);
+			return -EINVAL;
+		}
+		if (!loop->rt_bounded)
+			bpf_flow_loop_gets_guards(env, env->insn_idx);
+		/* the jumps were decided, it's the loop that is too long */
+		if (decided)
+			loop->walk_failed = true;
+		/* the iteration that it went through: its state is at the head */
+		entry->trip = trip;
+		*ends_walk = true;
+		return 0;
+	}
+
+	loop = env->insn_aux_data[env->insn_idx].loop;
+	err = bpf_compute_loop_iters(env, cur, &iters);
+	if (err < 0)
+		return err;
+
+	/* @per_trip: the insns of one iteration, times the walks around the loop. */
+	per_trip = flow_walk_factor(cur) * loop->nr_insns;
+	/* The walk has to get to the end of the loop, so it is known to have one. Or not: */
+	if (!err) {
+		err = flow_try_walk(env, entry);
+		if (err)
+			return err < 0 ? err : 0;
+		if (!loop->rt_bounded && !loop->has_guards) {
+			verbose(env, "loop at insn %d never exits\n", env->insn_idx);
+			return -EINVAL;
+		}
+		if (!loop->rt_bounded) {
+			bpf_flow_loop_gets_guards(env, env->insn_idx);
+			entry->guarded = true;
+		}
+		return 0;
+	}
+
+	/* What the ranges are derived from for as long as the loop is looked at. */
+	entry_state = bpf_flow_keep_state(env, cur);
+	if (!entry_state)
+		return -ENOMEM;
+
+	entry->min_header_count = iters.min_header_count;
+	entry->max_header_count = iters.max_header_count;
+	entry->iv_reg = iters.iv_reg;
+	entry->iv_range = iters.iv_range;
+	entry->entry_state = entry_state;
+	entry->terminates = true;
+	err = bpf_widen_scev_regs(env, cur, entry_state, &iters);
+	return err < 0 ? err : 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
-- 
2.55.0

