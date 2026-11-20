Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208018;
	b=uj4Y5QeraFYHAuzvVLFbY3Ziis8FlVwvpjd1ZQmN5+LWIE86RiFwDZjWO1WxoUc/3n8Z
	 SYeQejV9Tmh+ek9OQYTYZr0vMi46WOQsaBZjuBi+i800BUdaMBPfveDm/FffvoHAy5Mkm
	 CN6XljRJMuUeb4nKNQFkW2hffNkok8oaj4YA6S299OOoX8HHcOrLK59s3HTgW63ZXx+bh
	 pU05weGuWwXnshXehl0UE7otzJz4olwr14zs9XD20+geACaSyKq9lyrRS+OTKbOorbjeA
	 qpgAf5hgJgl9XtJ3uak7o/e2YlYfmHwOpMhsLx6W1LCQbF06GWlQTTXL33HQ2ihH/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vuOaIhrfffDKzhWGrgsmo38dUrsdwIbfc/h9z9o4rh8=;
	b=ruZsgaqe3xoCCh6nCR42MAlpqKnUR/mNCDpgINnA3U4TkO9rgDHOj1aNQEX49KK6tg6U
	 e/Ebt5wZPWvmDXI0ZVsJtaMmgKtxmORR9MBNUadIu5vb4OcDXdzIiJYVI9oWdeCA14vd/
	 +TRys7yR1XK81+Ma+DrnPblapua4Zp8Mieb3Eol87C+xmyMTtGaRQnwKfaiP3+8U1AYmM
	 VVbtEQPDCN/1NqaKJy/DZWDVElszlGtBm6R/fpskAjxUWwLwgQ/SDqP0hxfWG/wbqVTri
	 esGy/lmaZIL5wgRsEyqtw/iKcCOHjkSfiS4SOCLmtbSjqELhbHR+S45cubn7tfFrr6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0JgtNqb;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B7606A695
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238B7606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0JgtNqb
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso715624a91.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208010; x=1795812810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vuOaIhrfffDKzhWGrgsmo38dUrsdwIbfc/h9z9o4rh8=;
        b=i0JgtNqbpPxPr4glw8fjoSGlYpDHzW5yyxeq+jV6qXJHHfDMzsd1PQw/7Lq7oCHeCJ
         lRRDHNx07SpQwJ8gHAHXP+2hubP+MQT8HYK0+AsJJyhZHJVjitVvoXDm65BhPnf7SO9I
         NL3qr8p926Y0TTIaforI4l9fJtjzOaw1MIF7zvROCMnUoyT5OWEDPw7tJgOQI3vNuWGX
         J7ZdLE1gV3xCwnKeNk2e1ER8wUfSNtaksgaZ/FtSIFG/13EZOtNdCqs3Si3ISay/QADW
         jfEZX4EeGVG3i+7WewX63mqxWAUIZFqerrSvB5Gk4QpI8UW+6alCGJoOp7E4OB/yhhW3
         bvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208010; x=1795812810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vuOaIhrfffDKzhWGrgsmo38dUrsdwIbfc/h9z9o4rh8=;
        b=KnTc0lUXZelgFgWUN+OA8OrSFeD20IfsoL3s60gYPqR4kmKPxtU3HqPbcO+Iv+Ojz6
         Y9RgO0sINgNnH9zISN786hODB2GAL3TuYFP7o8O1YP0lM08SrOY0pWgG1NhYarJrKWsd
         JUZpZG8+hVAX1CPixZFpbdrGBjCfZJgm4S1Su/8cTyaFuIdIZAn8cyQzDazL0IjH33dm
         hF6Z9b2VHaNAPifs2qNpeGZP0zVLH5rjgtSDRefb47YPHHbxZC+2g2IyK3Aj1fqO9gIv
         tjx+/aBKbVul1co/2kW5AhN9x9YpCgmea3UTJLunkbemkcjWLcqcA2vZt4mo2Q6W3qUe
         +8lQ==
X-Gm-Message-State: APuU4Z9y6HCmx3DqmHzLlvQ27nu5nxJ2SJ7xt6EcXRp119H98Tj5DVnu
	x4Q8FLcSzWVT67Isole7N6cnofd25UUOnQuUSMvjDUZW53nKLJjhhFjRJaHyig==
X-Gm-Gg: AZFdTZe79iJOZt7zALmqwM3/r1XYcVN2gf1OHkC7n91bxk/bxphsqsjC2QBYpluc2dY
	wQznHbNwqiQFw28MpB8lvYr0aZE/mVthN8X9eCifcJsBI2ZhST9nf6sCHHHBcO4LXyi5qpbAMn8
	SI3ez6vDT2hW9GIvRmQ2MB6VPQDIOqYd1vczCXKon/0PyFg7dUcx2AjKArcNVbs/KdnzCMMYPkj
	arWHCNFKv3mVdaInfkCtAzwLAkvRPHSu41ZlTPerCbfGcR5T2APIcOsDGj7r9QpswBgotGbndgp
	bFGzej9n43BgFcqCRxiHvg8RVhBoAwDv2hSvJutr/4cwM1Bw94OENchDAU/NTw44IHlttU5d9Pd
	2XDLLiZQctbjMvOQujdNeRe/bYVAX3htARS+RXhMbWWDlshfPgbSIT3aFMmCikGCxKs2sTyz1iu
	ytqlF20sqsVgFBtPWLemAJVogcFXpHutMSJ/AXb3FXizIOXI6Y5whgu5hiWdlKc5ln4+CL1FnlA
	7nI78FnS5urdn3k0b85SSYyqpwAGrY+TEHjYZgEjGFy8V0qi5mKLAs4P1XExlGr8gPE+7Ntmxgl
	eLgEFsvVGa6CbvgWSD8YZJRcHW5Mwl3wcT/bmr4q5CziU4ihwHUFGbf7hJy7/UUzD40VoVfNlun
	yuFBluFxAq51oWfTjnJWoP5UWVB8yZnl2buv4Q89ef3bgx3ua+cXj8w+44mNWrxk57vATeKWVOA
	==
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr4082860a91.20.1795208009764;
        Fri, 20 Nov 2026 12:53:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad47091sm5650455a91.10.2026.11.20.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 35/49] bpf: Reproduce an error on one path, with no joins
Date: Fri, 20 Nov 2026 20:49:43 +0000
Message-ID: <20261120204959.614908-36-alexei.starovoitov@gmail.com>
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

After a join a pass cannot tell a real error from a false one. If the
error is real, more passes are wasted work, and the log of the joined
state does not show the bug:

  R6=scalar(smin=0,smax=max)  R7=scalar(smin=-22,smax=0)

find_failing_path() tries to reproduce the error. It checks one path
after another until the check of an insn in err_insns fails. This is a
path-sensitive run. It has the same checks as a pass, and goes depth
first, the shortest way first:
- There are no joins. A call stays in the frames of its caller. Each
  trip is peeled.
- A state is dropped if a state with the same values in the deps was at
  the insn.
- If only the jump on the iv of a loop depends on the xregs that moved,
  the path skips trips, see below.
- If the jumps of a loop see the same values in two trips, the loop is
  infinite. The path continues where may_goto leaves it.
- A run that is cut by its budget starts again, fall-through edge first.
  If it is cut again, or by its limit on trips, it starts again with the
  next limit on trips.

The path on which the check fails is the failing path. If the run made
no guess, see below, the passes that are left get a small budget. So a
wrong program is rejected fast. And the log has the full path. Only log
level 2 has the paths that the run dropped.

A path can have errors that do not end it: in a speculative state, or
in the BTF check of the arguments of a static function. Such an error
gets no "Verification failed" report, see env->no_report. A missing
stack argument ends the path, so report it at the first check.

The paths that continue from a header share a copy of the state there,
see bpf_header_state. leave_loops() drops the copy. check_funcs() checks
all functions from a snapshot. A pass uses it too.

A path has to get through a long loop to an error after it:

  for (i = 0; i < 100000; i++) { if (rnd() && n < 8) n++; }
  a[n] = 0;

It makes no joins, so it has no equation for the trip index. Two trips
give the step:

  trip 3: the jump sees i = 3      step 1
  trip 4: the jump sees i = 4      99996 trips left

failing_path_trip() compares the state with the saved state of an
earlier trip. If the other jumps do not depend on the xregs that moved,
bpf_fast_forward_xregs() moves them to the last trips.

The nonlinear_xregs of the loop are not moved: the step of two trips
does not tell where '(i + 1) & 63' is after 99996 trips.

Two paths can have the same ranges, and only one of them has r1 == r6.
The other one can be the path that fails. So the hash of a state has
the xregs that share a sym, see bpf_equations_hash().

Three guesses of the run can make a path that the program cannot take.
If such a path cuts the budget, a valid program can be rejected. So a
guess sets env->run_has_guess, and the budget is not cut.

1. The skip. Two trips show a step also for 'sum += i':

     for (i = 0; i < 1000; i++) sum += i;
     buf[sum - 499500]               valid, this is buf[0]

     trip   i      sum    real sum
     2      2      1      1          saved
     4      4      6      6          since trip 2: i +2, sum +5
     skip   998    2491   497503     497 times: (996 left - 1) / 2
     exit   1000   4488   499500     buf[-495012] fails

   bpf_steps_are_constant() looks at the xregs that move and at the
   operands of the jump on the iv, such as 'i < n / i'. A copy has to
   have the step of its source.

2. "The loop is infinite". Two trips give more than 2^32 trips also for
   this loop of 512 trips:

     u64 i = 600; do { i = (i + 1) & 1023; } while (i != 88);

   The next runs keep this answer. So it is also a guess if the run made
   a guess before it.

3. The target of may_goto. All states have the same one. A state that
   only a join makes can hold a lock. Then the target is the code after
   the loop, also for a path with no lock.

The run accepts nothing. It is not the verdict either: a path has ranges
too, and it can fail at an insn that a pass proves.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  36 +++++
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/diagnostics.c     |   2 +-
 kernel/bpf/equation_join.c   | 202 +++++++++++++++++++++++++++
 kernel/bpf/failing_path.c    | 261 +++++++++++++++++++++++++++++++++++
 kernel/bpf/flow.c            |  62 ++++++++-
 kernel/bpf/precision.c       |   4 +
 kernel/bpf/precision.h       |   2 +
 kernel/bpf/verifier.c        | 235 ++++++++++++++++++++++++++++++-
 9 files changed, 801 insertions(+), 4 deletions(-)
 create mode 100644 kernel/bpf/failing_path.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 22afe110d43..74cc3e2fbc7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -445,6 +445,7 @@ static inline u64 bpf_xreg(u32 frameno, u32 xregno)
  */
 struct loop_stack_entry {
 	struct bpf_loop *loop;
+	struct bpf_header_state *header_state;	/* see failing_path_trip() */
 	/* How many times the state came back to the header. A join has the larger number. */
 	u32 trip;
 	/* The state that entered the loop. What comes back to the header is for that state. */
@@ -455,6 +456,9 @@ struct loop_stack_entry {
 	struct scalar trip_index;
 	bool trip_widened;	/* it was moved to a threshold, or it does not grow */
 	u64 exit_threshold;	/* by the jumps that the state passed and that leave the loop */
+	/* Path-sensitive run: the jump that tests the iv, the value it saw, the trips left */
+	u32 iv_jump_idx;
+	u64 iv_prev, trips_left;
 };
 
 /* The states of trip 0, 1, 2, 4, 8, ... are saved. A compare with them finds any period. */
@@ -632,6 +636,12 @@ static inline struct bpf_stack_state *bpf_stack_slot(const struct bpf_func_state
 	return &frame->stack[spi];
 }
 
+/* The state in which a path started a trip, see failing_path_trip() */
+struct bpf_header_state {
+	struct bpf_verifier_state st;
+	u32 refcnt;
+};
+
 static inline struct bpf_reg_state *
 bpf_get_spilled_reg(int slot, struct bpf_func_state *frame, u32 mask)
 {
@@ -882,7 +892,9 @@ struct bpf_loop {
 	bool peeled_joined;	/* at the start of a peeled trip, against the join rule */
 	bool changed;		/* see flow_forget_loop() */
 	bool guarded;		/* states take the edges of may_goto */
+	bool was_infinite;	/* at the start of the last path-sensitive run */
 	bool infinite;		/* see failing_path_trip() */
+	bool infinite_is_guess;	/* see fast_forward_trips() */
 	struct bpf_iv_threshold *iv_thresholds;	/* where an iv can stop, see equation_join.c */
 	u32 iv_threshold_cnt, iv_threshold_cap;
 	u32 leftover_epoch;	/* how many leftovers started */
@@ -1361,6 +1373,9 @@ struct bpf_verifier_env {
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
 	bool for_log;			/* the verdict is known, see do_check_all() */
 	bool fallthrough_first;		/* see find_failing_path() */
+	bool run_has_guess;		/* see run_path_sensitive() */
+	u32 failing_path_budget_shift;	/* see func_failing_path_budget() */
+	u32 failing_path_max_trips;	/* see failing_path_trip() */
 	u32 pass;			/* number of the pass, see do_check_all() */
 	struct bpf_precision *precision;
 	u64 cost, mem;			/* see bpf_check_limits() */
@@ -1376,6 +1391,8 @@ struct bpf_verifier_env {
 	u32 err_insn;
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
+	bool too_deep;			/* see failing_path_trip() */
+	bool run_over_budget;		/* in one of its functions, see find_failing_path() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_needs_guard() */
 	bool calls_joined;		/* see flow_may_add_instance() */
@@ -1521,6 +1538,7 @@ struct bpf_verifier_env {
 	int *idoms;
 	struct bpf_equation_env *eq_env;
 	struct bpf_flow *flow;
+	bool no_report;		/* an error does not end the path, see diag_write() */
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1724,6 +1742,14 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env);
 u64 bpf_pass_max_cost(struct bpf_verifier_env *env);
 u64 bpf_precision_budget(struct bpf_verifier_env *env);
 u64 bpf_precision_first_budget(struct bpf_verifier_env *env);
+bool bpf_failing_path_is_due(struct bpf_verifier_env *env);
+int bpf_failing_path_prepare(struct bpf_verifier_env *env, bool repeat);
+bool bpf_failing_path_may_end_at(struct bpf_verifier_env *env, u32 idx);
+u32 bpf_failing_path_hops(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
+int bpf_failing_path_was_here(struct bpf_verifier_env *env, const struct bpf_verifier_state *st);
+int bpf_jumps_see_same(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+		       const struct bpf_verifier_state *new, int iv_jump_idx,
+		       const unsigned long *iv_xregs);
 int bpf_precision_init(struct bpf_verifier_env *env);
 void bpf_precision_free(struct bpf_verifier_env *env);
 
@@ -1763,6 +1789,8 @@ void bpf_flow_reset(struct bpf_verifier_env *env);
 void bpf_flow_free(struct bpf_verifier_env *env);
 bool bpf_flow_trip_is_new(struct bpf_verifier_env *env, struct loop_stack_entry *entry);
 bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx);
+int bpf_flow_save_header_state(struct bpf_verifier_env *env, struct loop_stack_entry *entry);
+void bpf_flow_put_header_state(struct loop_stack_entry *entry);
 int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 		     int insn_idx, int prev_insn_idx, bool again);
 int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos, u64 *diag_pos);
@@ -2216,6 +2244,7 @@ struct bpf_call_arg_meta {
 
 	/* Only set by subprog */
 	bool subprog_may_change_pkt;
+	bool subprog_is_static;
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
@@ -2498,7 +2527,14 @@ bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_v
 				const struct bpf_verifier_state *b, u32 fr,
 				const unsigned long *data_deps, const unsigned long *xregs,
 				u32 bits);
+u32 bpf_equations_hash(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u32 fr,
+		       const unsigned long *xregs, u32 bits);
 void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
+bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
+			    const unsigned long *iv_xregs, bool infinite);
+void bpf_fast_forward_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			    struct bpf_verifier_state *cur, u64 factor, unsigned long *iv_xregs);
+
 void scalar_bounds_sync(struct scalar *s);
 bool scalar_subsumes(const struct scalar *old, const struct scalar *cur);
 bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 575c7d0ff4e..389e78b0bc4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-$(CONFIG_BPF_SYSCALL) += equation.o
 obj-$(CONFIG_BPF_SYSCALL) += equation_join.o
 obj-$(CONFIG_BPF_SYSCALL) += precision.o
+obj-$(CONFIG_BPF_SYSCALL) += failing_path.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 2cb9eceb408..0e12078ffe1 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -372,7 +372,7 @@ static void diag_write(struct bpf_verifier_env *env, const char *fmt, ...)
 {
 	va_list args;
 
-	if (!bpf_diag_enabled(env))
+	if (!bpf_diag_enabled(env) || env->no_report)
 		return;
 
 	va_start(args, fmt);
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index 93ebf337e4c..47db8f8ae2b 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -12,6 +12,7 @@
 #include <linux/bpf.h>
 #include <linux/cnum.h>
 #include <linux/filter.h>
+#include <linux/jhash.h>
 #include <linux/slab.h>
 #include <linux/tnum.h>
 #include "equation.h"
@@ -621,6 +622,27 @@ bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_v
 	return false;
 }
 
+/* Which xregs of @xregs in frame @fr have one sym? */
+u32 bpf_equations_hash(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u32 fr,
+		       const unsigned long *xregs, u32 bits)
+{
+	const struct bpf_xreg_equation *xreg_eq;
+	u32 i, hash = 0, *first;
+
+	for (i = 0; i < st->equations.sym_cnt; i++)
+		env->eq_env->scratch[i].new_symno = U32_MAX;
+	for_each_xreg_equation(env, &st->equations, xreg_eq) {
+		if (xreg_eq->xreg >> 32 != fr || (u32)xreg_eq->xreg >= bits ||
+		    !test_bit((u32)xreg_eq->xreg, xregs))
+			continue;
+		first = &env->eq_env->scratch[xreg_eq->sym].new_symno;
+		if (*first != U32_MAX)
+			hash = jhash_2words(*first, xreg_eq->xreg, hash);
+		*first = min_t(u32, *first, xreg_eq->xreg);
+	}
+	return hash;
+}
+
 /* Thresholds */
 
 /*
@@ -721,6 +743,64 @@ static u64 compute_trip_count(s64 step, u64 *x, u8 op, bool jmp32, struct scalar
 	return min(div64_u64(step > 0 ? arc.size - left : left, abs64(step)), U64_MAX - 1) + 1;
 }
 
+/* A path-sensitive run has no equations for the trip index. Two trips give the step. */
+static void note_trips_left(struct bpf_verifier_env *env, struct loop_stack_entry *e,
+			    const struct scalar *x, u8 op, bool jmp32, const struct scalar *bound,
+			    bool is_body_jump)
+{
+	u64 value = jmp32 ? x->r32.base : x->r64.base, far_end;
+	s64 step = jmp32 ? (s32)(value - e->iv_prev) : value - e->iv_prev;
+
+	if (e->iv_jump_idx && e->iv_jump_idx != env->insn_idx)
+		return;
+	far_end = value + (step < 0 ? 0 : jmp32 ? x->r32.size : x->r64.size);
+	if (e->iv_jump_idx)
+		e->trips_left = step ? compute_trip_count(step, &far_end, op, jmp32, *bound) : 0;
+	if (e->iv_jump_idx && step && is_body_jump && !e->trips_left)
+		e->trips_left = compute_trip_count(step, &far_end, bpf_rev_opcode(op),
+						   jmp32, *bound);
+	e->iv_jump_idx = env->insn_idx;
+	e->iv_prev = value;
+}
+
+static void move_bounds(struct bpf_verifier_env *env, struct scalar *s, bool is_ptr, u64 off)
+{
+	struct scalar step;
+
+	scalar_set_const(&step, off);
+	scalar_add(s, s, &step);
+	/* see refine_ptr() */
+	if (is_ptr)
+		bpf_blur_far_offset(env, container_of(&s->var_off, struct bpf_reg_state, var_off));
+	else
+		scalar_bounds_sync(s);
+}
+
+/* Some xregs of @cur moved since @old. Note them in @iv_xregs, move them @factor times as far. */
+void bpf_fast_forward_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+			    struct bpf_verifier_state *cur, u64 factor, unsigned long *iv_xregs)
+{
+	u32 xregno, cnt = bpf_spi_to_xreg(bpf_stack_nr_slots(cur->frame[cur->curframe]));
+	struct scalar *a, *b;
+	u64 xreg;
+	bool is_ptr;
+
+	bpf_add_cost(env, cnt, BPF_COST_COPY);
+	for (xregno = 0; xregno < cnt; xregno++) {
+		xreg = bpf_xreg(cur->curframe, xregno);
+		a = bpf_find_var_bounds(env, old, xreg, &is_ptr);
+		b = bpf_find_var_bounds(env, cur, xreg, &is_ptr);
+		if (!a || !b || a->r64.size != b->r64.size || a->r64.base == b->r64.base ||
+		    test_bit(xregno,
+			     bpf_top_loop(cur->frame[cur->curframe])->loop->nonlinear_xregs))
+			continue;
+		__set_bit(xregno, iv_xregs);
+		move_bounds(env, b, is_ptr, (b->r64.base - a->r64.base) * factor);
+		if (factor)
+			bpf_equations_forget_xreg(env, cur, xreg);
+	}
+}
+
 static bool insn_is_in_loop(struct bpf_verifier_env *env, const struct bpf_loop *loop, int idx)
 {
 	int h = bpf_loop_at_index(env, idx);
@@ -728,6 +808,118 @@ static bool insn_is_in_loop(struct bpf_verifier_env *env, const struct bpf_loop
 	return h == loop->header || bpf_is_nested_loop(env, h, loop->header);
 }
 
+/* The slot that @insn fills from or spills to. 0 if there is none. */
+static u32 slot_of_insn(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), base = class == BPF_LDX ? insn->src_reg : insn->dst_reg;
+
+	if (class != BPF_LD && class <= BPF_STX && base == BPF_REG_FP && insn->off < 0 &&
+	    !(insn->off % BPF_REG_SIZE) && -insn->off <= env->stack_limit &&
+	    BPF_MODE(insn->code) != BPF_ATOMIC && bpf_size_to_bytes(BPF_SIZE(insn->code)) >= 4)
+		return bpf_spi_to_xreg(-insn->off / BPF_REG_SIZE - 1);
+	return 0;
+}
+
+/* If the operand has a constant step, the result has one too. @prev: in the same block. */
+static bool keeps_constant_step(const struct bpf_insn *insn, const struct bpf_insn *prev,
+				bool infinite)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	if (bpf_is_ldimm64(insn))
+		return true;
+	if (class != BPF_ALU64 && (class != BPF_ALU || infinite))
+		return false;
+	if (op == BPF_MOV)
+		return !insn->off || (!infinite && insn->off == 32);
+	if (BPF_SRC(insn->code) == BPF_X)
+		return false;
+	if (op == BPF_ADD || op == BPF_SUB)
+		return true;
+	/* x <<= 32; x >>= 32; */
+	return !infinite && insn->imm == 32 &&
+	       (op == BPF_LSH || ((op == BPF_RSH || op == BPF_ARSH) && prev && prev->imm == 32 &&
+				  prev->code == (BPF_ALU64 | BPF_LSH | BPF_K) &&
+				  prev->dst_reg == insn->dst_reg));
+}
+
+/* How far @xregno moved since the saved trip */
+static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
+			const unsigned long *iv_xregs, u32 xregno)
+{
+	u64 xreg = bpf_xreg(env->cur_state->curframe, xregno);
+	bool is_ptr;
+
+	if (!test_bit(xregno, iv_xregs))
+		return 0;
+	return bpf_find_var_bounds(env, env->cur_state, xreg, &is_ptr)->r64.base -
+	       bpf_find_var_bounds(env, &entry->header_state->st, xreg, &is_ptr)->r64.base;
+}
+
+/*
+ * Two trips gave the steps. Does each trip add the same constant to the operands of the jump on
+ * the iv, and to @iv_xregs? The code shows it, or a pass saw it at the header.
+ *	i += 1; x = (u32)i;		yes
+ *	sum += i; x = n / i;		no
+ *	a = b; b = 0;			no, if a moved and b did not
+ * @infinite: above 2^32 trips. Only the jump counts, and 32-bit insns wrap.
+ */
+bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
+			    const unsigned long *iv_xregs, bool infinite)
+{
+	const struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	const struct bpf_insn *insn, *prev = NULL;
+	const struct bpf_loop *loop = entry->loop;
+	DECLARE_BITMAP(not_linear, MAX_BPF_XREG);
+	u16 no_step = 0;	/* an insn of the loop writes it with no constant step */
+	u16 new_step = 0;	/* the last write in this basic block has a constant step */
+	u16 last_round, uses_no_step;
+	u64 steps[MAX_BPF_EXT_REG];
+	bool has_step;
+	u32 slot;
+	int n;
+
+	bitmap_andnot(not_linear, iv_xregs, loop->linear_xregs, MAX_BPF_XREG);
+	do {
+		last_round = no_step;
+		bpf_add_cost(env, loop->nr_insns, BPF_COST_SCAN);
+		for (n = 0; n < MAX_BPF_EXT_REG; n++)
+			steps[n] = step_of_xreg(env, entry, iv_xregs, n);
+		for (n = loop->header; n >= 0 && insn_is_in_loop(env, loop, n);
+		     prev = insn, n = bpf_flow_insn_after(env, n)) {
+			insn = &env->prog->insnsi[n];
+			if (bpf_flow_is_bb_start(env, n)) {
+				new_step = 0;
+				prev = NULL;
+			}
+			uses_no_step = aux[n].use_regs & no_step & ~new_step;
+			if (n == entry->iv_jump_idx && (uses_no_step & ~aux[n].const_reg_mask))
+				return false;
+			slot = slot_of_insn(env, insn);
+			has_step = !slot ? keeps_constant_step(insn, prev, infinite) :
+				   test_bit(bpf_xreg_to_spi(slot),
+					    aux[loop->header].live_stack_before) &&
+				   !test_bit(slot, not_linear) &&
+				   (!infinite || BPF_SIZE(insn->code) == BPF_DW);
+			/* a copy that the run made has the step of its source */
+			if (has_step && aux[n].seen && (aux[n].def_regs & ~aux[n].use_regs))
+				steps[insn->dst_reg] =
+					slot ? step_of_xreg(env, entry, iv_xregs, slot) :
+					aux[n].use_regs ? steps[insn->src_reg] : 0;
+			new_step |= aux[n].def_regs;
+			if (has_step && !uses_no_step)
+				continue;
+			new_step &= ~aux[n].def_regs;
+			no_step |= aux[n].def_regs;
+		}
+		for_each_set_bit(n, iv_xregs, MAX_BPF_EXT_REG)
+			if (steps[n] != step_of_xreg(env, entry, iv_xregs, n))
+				no_step |= BIT(n);
+	} while (no_step != last_round);
+	not_linear[0] &= no_step | ~GENMASK(BPF_REG_FP, BPF_REG_0);
+	return infinite || bitmap_empty(not_linear, MAX_BPF_XREG);
+}
+
 /* The jump stays in the loop if operand 0 or 1, or their difference, is "op" the bound */
 static u8 loop_cond_opcode(const struct bpf_insn *insn, bool taken, int i)
 {
@@ -756,6 +948,7 @@ void bpf_collect_iv_thresholds(struct bpf_verifier_env *env)
 	const struct bpf_func_state *f = st->frame[st->curframe];
 	bool is_ptr, is_iv[3], low32[3], start_is_range[3] = {}, stays_in_loop[2], is_body_jump;
 	struct loop_stack_entry *e = bpf_top_loop(f);
+	const struct bpf_iv_threshold *threshold;
 	struct expr trip, step, expr[3];
 	struct scalar bound[3];
 	struct equation_pos pos = {};
@@ -781,6 +974,15 @@ void bpf_collect_iv_thresholds(struct bpf_verifier_env *env)
 	stays_in_loop[1] = insn_is_in_loop(env, e->loop, env->insn_idx + insn->off + 1);
 	is_body_jump = stays_in_loop[0] && stays_in_loop[1];
 	low32[0] = low32[1] = low32[2] = BPF_CLASS(insn->code) == BPF_JMP32;
+	if (env->path_sensitive) {
+		if (is_body_jump)
+			for_each_iv_threshold(env, e->loop, threshold, THRESHOLD_EXIT_JUMP)
+				return;
+		i = aux->iv_operand - 1;
+		return note_trips_left(env, e, &bound[!i],
+				       loop_cond_opcode(insn, stays_in_loop[1], i), low32[i],
+				       &bound[i], is_body_jump);
+	}
 	x = bpf_xreg(st->curframe, BPF_XREG_TRIP + f->loop_stack_cnt - 1);
 	if (!bpf_xreg_expr(env, st, x, &trip, &is_ptr) || !var_is_sym(trip.var))
 		return;
diff --git a/kernel/bpf/failing_path.c b/kernel/bpf/failing_path.c
new file mode 100644
index 00000000000..0aebd7bfe8f
--- /dev/null
+++ b/kernel/bpf/failing_path.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Help for the path-sensitive run, see run_path_sensitive(). If the error of a pass is real,
+ * the next passes get a small budget and the log gets a path to the error. The run reproduces
+ * the error with no joins. The path on which the check fails again is the failing path.
+ *
+ *	entry --> ... --> state --+--> 2 hops --> unproven insn		goes first
+ *	                          +--> 9 hops --> unproven insn
+ *	                          +--> no path				is dropped
+ */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+
+#include "precision.h"
+
+#define NO_PATH	(U32_MAX / 2)
+
+static bool shorter(u32 *hops, u32 via)
+{
+	if (via + 1 >= *hops)
+		return false;
+	*hops = via + 1;
+	return true;
+}
+
+/* @to follows @from in one function */
+static bool shorter_via(struct bpf_precision *prec, u32 from, u32 to)
+{
+	bool to_err = shorter(&prec->hops_to_err[from], prec->hops_to_err[to]);
+	bool to_exit = shorter(&prec->hops_to_exit[from], prec->hops_to_exit[to]);
+
+	return to_err || to_exit;
+}
+
+/*
+ * For each insn, the number of edges to
+ * - an unproven insn, in its function or in a function that it calls,
+ * - the exit of its function.
+ * The first unproven insn is nearer than the other ones.
+ */
+static int compute_hops(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	u32 len = env->prog->len, taken = NO_PATH, i, k, n, s;
+	struct bpf_precision *prec = env->precision;
+	struct bpf_insn_aux_data *aux;
+	struct bpf_iarray *succ;
+	bool changed = true;
+	int t, err = 0;
+
+	for (i = 0; i < len; i++) {
+		prec->hops_to_err[i] = !test_bit(i, prec->err_insns) ? NO_PATH :
+				       i == prec->first_unproven_insn ? 0 : len;
+		prec->hops_to_exit[i] = env->prog->insnsi[i].code == (BPF_JMP | BPF_EXIT) ?
+					0 : NO_PATH;
+	}
+	while (changed && !err) {
+		changed = false;
+		/* callees first */
+		for (k = 0; k < env->subprog_cnt; k++) {
+			s = env->subprog_topo_order[k];
+			for (i = sub[s].postorder_start; i < sub[s + 1].postorder_start; i++) {
+				n = env->cfg.insn_postorder[i];
+				aux = &env->insn_aux_data[n];
+				succ = bpf_insn_successors(env, n);
+				iarray_for_each(t, succ)
+					changed |= shorter_via(prec, n, t);
+				/* see check_loop_guard() and check_recursion_guard() */
+				if (aux->guard_place)
+					changed |= shorter_via(prec, n, aux->guard_to);
+				if ((aux->guard_place || (sub[s].cycle && n == sub[s].start)) &&
+				    sub[s].bail_insn >= 0)
+					changed |= shorter_via(prec, n, sub[s].bail_insn);
+				if (!bpf_calls_function(env, n))
+					continue;
+				t = bpf_insn_callee(env, n);
+				changed |= shorter(&prec->hops_to_err[n],
+						   t > 0 ? prec->hops_to_err[sub[t].start] : taken);
+			}
+			if (sub[s].addr_taken)
+				changed |= shorter(&taken, prec->hops_to_err[sub[s].start]);
+		}
+		err = bpf_add_cost_and_check(env, len, BPF_COST_XREG);
+	}
+	return err;
+}
+
+bool bpf_failing_path_may_end_at(struct bpf_verifier_env *env, u32 idx)
+{
+	return idx < env->prog->len && test_bit(idx, env->precision->err_insns);
+}
+
+/* The number of edges from @st to an unproven insn. U32_MAX if there is no path. */
+u32 bpf_failing_path_hops(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	const struct bpf_precision *prec = env->precision;
+	u32 idx = st->insn_idx, fr = st->curframe;
+	u64 hops = prec->hops_to_err[idx], out = 0;
+
+	for (; fr; fr--) {
+		out += prec->hops_to_exit[idx];
+		idx = st->frame[fr]->callsite + !st->frame[fr]->in_callback_fn;
+		hops = min(hops, out + prec->hops_to_err[idx]);
+	}
+	return hops < NO_PATH ? hops : U32_MAX;
+}
+
+static u64 hash_value(const struct bpf_reg_state *reg, u64 hash)
+{
+	return bpf_hash64(reg, offsetof(struct bpf_reg_state, grew_once), hash);
+}
+
+/* The join_key, the values of the deps, and which of them have one sym */
+static u64 hash_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	unsigned long all[XREG_WORDS], control_deps[XREG_WORDS];
+	u64 hash = bpf_hash_join_key(env, st);
+	const struct bpf_reg_state *reg;
+	const struct bpf_func_state *f;
+	struct bpf_reg_state tmp;
+	u32 fr, xregno, i, bits;
+
+	for (fr = 0; fr <= st->curframe; fr++) {
+		f = st->frame[fr];
+		bpf_frame_mask(env, env->precision->control_deps, st, fr, control_deps);
+		bits = bpf_frame_mask(env, env->precision->type_apart, st, fr, all);
+		bitmap_or(all, all, control_deps, bits);
+		bpf_add_cost(env, 2 * bitmap_weight(all, bits), BPF_COST_XREG);
+		hash += bpf_equations_hash(env, st, fr, all, bits);
+		for_each_set_bit(xregno, all, bits) {
+			for (i = 0; xregno == XREG_STACK_ARGS && i < f->out_stack_arg_cnt; i++)
+				hash = hash_value(&f->stack_arg_regs[i], hash);
+			reg = bpf_xreg_value(env, f, xregno, &tmp);
+			if (reg)
+				hash = hash_value(reg, hash + xregno);
+			i = bpf_xreg_to_spi(xregno);
+			if (i < bpf_stack_nr_slots(f))
+				hash = bpf_hash64(bpf_stack_slot(f, i)->slot_type,
+						  BPF_REG_SIZE, hash);
+		}
+	}
+	return hash;
+}
+
+static bool add_to_set(u64 *set, u32 bits, u64 hash)
+{
+	u32 i;
+
+	for (i = hash & (BIT(bits) - 1); set[i]; i = (i + 1) & (BIT(bits) - 1))
+		if (set[i] == hash)
+			return false;
+	set[i] = hash;
+	return true;
+}
+
+/* Returns 1 if a path was at this insn with the same hash_state(). A collision drops a path. */
+int bpf_failing_path_was_here(struct bpf_verifier_env *env, const struct bpf_verifier_state *st)
+{
+	struct bpf_precision *prec = env->precision;
+	u32 size = BIT(prec->seen_bits), i;
+	u64 *set;
+
+	if (2 * prec->seen_cnt + 2 > size) {
+		set = kvcalloc(2 * size, sizeof(*set), BPF_VERIFIER_GFP);
+		if (!set)
+			return -ENOMEM;
+		for (i = 0; prec->seen && i < size; i++)
+			if (prec->seen[i])
+				add_to_set(set, prec->seen_bits + 1, prec->seen[i]);
+		env->mem += size * sizeof(*set);
+		kvfree(prec->seen);
+		prec->seen = set;
+		prec->seen_bits++;
+	}
+	if (!add_to_set(prec->seen, prec->seen_bits, hash_state(env, st) | 1))
+		return 1;
+	prec->seen_cnt++;
+	return 0;
+}
+
+/* The insn at @idx selects what runs next, and a path can get to it more than once */
+static bool selects_path_again(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	if (env->insn_aux_data[idx].calls_callback)
+		return true;
+	if (idx < env->subprog_info[1].start && bpf_loop_at_index(env, idx) < 0)
+		return false;
+	return bpf_insn_is_cond_jump(insn->code) || insn_is_gotox(insn) ||
+	       (bpf_calls_function(env, idx) && !bpf_pseudo_call(insn));
+}
+
+/*
+ * A path came around a loop from @old to @new. Do the jumps that it can get to again see the
+ * same values? Then it can take the same edges again.
+ * @iv_jump_idx: ignore the jump that tests the iv. -1 if there is none.
+ * @iv_xregs: each trip adds a constant to these xregs. Are all other loop-carried xregs the
+ * same too, and not computed from these?
+ */
+int bpf_jumps_see_same(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
+		       const struct bpf_verifier_state *new, int iv_jump_idx,
+		       const unsigned long *iv_xregs)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[old->insn_idx];
+	struct bpf_precision *prec = env->precision;
+	unsigned long *masks = iv_jump_idx < 0 ? prec->loop_control_deps : prec->new_data_deps;
+	u32 *made_for = iv_jump_idx < 0 ? &prec->loop_control_deps_for : &prec->new_data_deps_for;
+	DECLARE_BITMAP(loop_carried, MAX_BPF_XREG) = {};
+	u32 key = 2 * iv_jump_idx + !iv_xregs, i;
+	struct state_cmp cmp;
+	int err;
+
+	if (iv_xregs) {
+		loop_carried[0] = aux->live_regs_before & XREG_REGS;
+		bpf_add_slots(loop_carried, aux->live_stack_before, MAX_BPF_XREG);
+		bitmap_andnot(loop_carried, loop_carried, iv_xregs, MAX_BPF_XREG);
+	}
+	if (*made_for == key) {
+		bpf_compare_states(env, old, new, masks, NULL, &cmp);
+		/* masks that were made for other @iv_xregs can miss an xreg */
+		if (cmp.all || bitmap_subset(loop_carried, prec->loop_carried, MAX_BPF_XREG))
+			return !cmp.all;
+	}
+	for (i = 0; i < env->prog->len; i++)
+		__assign_bit(i, prec->control_seeds,
+			     i != iv_jump_idx && selects_path_again(env, i));
+	if (iv_xregs) {
+		bitmap_copy(prec->loop_carried, loop_carried, MAX_BPF_XREG);
+		prec->loop_carried_at = old->insn_idx;
+	}
+	err = bpf_compute_deps(env, masks, prec->control_seeds);
+	prec->loop_carried_at = U32_MAX;
+	if (err)
+		return err;
+	*made_for = key;
+	bpf_compare_states(env, old, new, masks, NULL, &cmp);
+	return !cmp.all;
+}
+
+/* The masks or the budget are new */
+bool bpf_failing_path_is_due(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return prec->failing_path_due || prec->partitioned_by == BIT(PARTITION_ADD_DEPS);
+}
+
+/* @repeat: start like the last run */
+int bpf_failing_path_prepare(struct bpf_verifier_env *env, bool repeat)
+{
+	struct bpf_precision *prec = env->precision;
+
+	prec->failing_path_due = false;
+	if (prec->seen)
+		memset(prec->seen, 0, sizeof(*prec->seen) << prec->seen_bits);
+	prec->seen_cnt = prec->new_data_deps_for = 0;
+	return repeat ? 0 : compute_hops(env);
+}
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index cce3f88f916..4dbf288f11a 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -102,7 +102,8 @@ struct flow_instance {
 
 struct flow_kept {
 	struct list_head node;
-	struct bpf_verifier_state st;
+	struct bpf_flow *flow;
+	struct bpf_header_state header_state;
 };
 
 struct bpf_flow {
@@ -129,6 +130,7 @@ struct bpf_flow {
 	u32 instance_cnt, instance_cap;
 	struct flow_instance *last_instance;	/* of the last pending state */
 	u64 priority_gen;
+	struct list_head unused;		/* struct flow_kept */
 	u32 seq;
 	u32 live_states;
 };
@@ -552,6 +554,7 @@ int bpf_flow_prepare(struct bpf_verifier_env *env)
 	if (!flow)
 		return -ENOMEM;
 	env->flow = flow;
+	INIT_LIST_HEAD(&flow->unused);
 	flow->state_tree = flow->pending = RB_ROOT_CACHED;
 	flow->call_loop.kind = BPF_LOOP_RECURSION;
 
@@ -689,6 +692,17 @@ static void flow_free_list(struct bpf_verifier_env *env, struct list_head *list)
 		flow_free_state(env, s);
 }
 
+static void flow_free_unused(struct bpf_verifier_env *env)
+{
+	struct flow_kept *k;
+
+	while ((k = list_first_entry_or_null(&env->flow->unused, struct flow_kept, node))) {
+		list_del(&k->node);
+		bpf_free_verifier_state(env, &k->header_state.st, false);
+		kfree(k);
+	}
+}
+
 /* What a check leaves behind. */
 void bpf_flow_reset(struct bpf_verifier_env *env)
 {
@@ -706,6 +720,7 @@ void bpf_flow_reset(struct bpf_verifier_env *env)
 		flow->instances[i]->group->instances = NULL;
 		kfree(flow->instances[i]);
 	}
+	flow_free_unused(env);
 	env->mem -= flow->instance_cnt * INSTANCE_BYTES;
 	flow->instance_cnt = 0;
 	flow->last_instance = NULL;
@@ -735,6 +750,35 @@ bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx)
 	return test_bit(insn_idx, env->flow->bb_starts);
 }
 
+/* The paths that continue from the current state share a copy of it */
+int bpf_flow_save_header_state(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct flow_kept *k = kzalloc_obj(*k, BPF_VERIFIER_GFP);
+
+	if (!k)
+		return -ENOMEM;
+	bpf_flow_put_header_state(entry);
+	entry->header_state = NULL;
+	k->flow = env->flow;
+	k->header_state.refcnt = 1;
+	if (bpf_copy_verifier_state(env, &k->header_state.st, env->cur_state)) {
+		list_add(&k->node, &k->flow->unused);
+		return -ENOMEM;
+	}
+	entry->header_state = &k->header_state;
+	return 0;
+}
+
+void bpf_flow_put_header_state(struct loop_stack_entry *entry)
+{
+	struct flow_kept *k;
+
+	if (!entry->header_state || --entry->header_state->refcnt)
+		return;
+	k = container_of(entry->header_state, struct flow_kept, header_state);
+	list_add(&k->node, &k->flow->unused);
+}
+
 /* A peeled trip is complete before the next one starts. The leftover is last. */
 static int flow_cmp_trips(const struct bpf_func_state *fa, const struct bpf_func_state *fb)
 {
@@ -784,6 +828,8 @@ static bool flow_less(struct rb_node *na, const struct rb_node *nb)
  * 3. The trip, then the position, in each frame. A callee in the frames of its callers is
  *    complete before the code after the call.
  * 4. Exit states. They go to the calls when the instance is complete.
+ *
+ * A path-sensitive run goes depth first, to the state that is nearer to an unproven insn.
  */
 static void flow_set_pending(struct bpf_verifier_env *env, struct flow_state *s)
 {
@@ -798,6 +844,12 @@ static void flow_set_pending(struct bpf_verifier_env *env, struct flow_state *s)
 		s->order[i] = flow->pos[st->frame[i + 1]->callsite];
 	s->order[i] = s->kind == FLOW_FUNC_EXIT ? U32_MAX : flow->pos[st->insn_idx];
 	s->order_len = i + 1;
+	if (env->path_sensitive) {
+		s->priority = (u64)~env->insn_processed << 32 | (env->fallthrough_first ?
+			      st->insn_idx != s->prev_insn_idx + 1 :
+			      bpf_failing_path_hops(env, st));
+		s->order_len = 0;
+	}
 	s->pending = true;
 	instance->pending_cnt++;
 	instance->group->busy_cnt++;
@@ -1301,6 +1353,8 @@ static int flow_add(struct bpf_verifier_env *env, struct flow_state *s, bool sta
 	if (!err && env->id_gen != id_gen)
 		err = bpf_renumber_ids(env, &s->st);
 	if (!err && env->path_sensitive) {
+		if (test_bit(s->st.insn_idx, env->flow->join_points))
+			err = bpf_failing_path_was_here(env, &s->st);
 	} else if (!err && loop && flow_loop_entry(&s->st, loop)->peeled) {
 		err = flow_prune_peeled(env, s, loop);
 	}
@@ -1345,6 +1399,11 @@ int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 	s->st.insn_idx = insn_idx;
 	s->st.last_insn_idx = prev_insn_idx;
 
+	if (env->path_sensitive && (s->st.infeasible || s->st.speculative ||
+				    bpf_failing_path_hops(env, &s->st) == U32_MAX)) {
+		flow_free_state(env, s);
+		return 0;
+	}
 	err = bpf_clean_verifier_state(env, &s->st);
 	if (err) {
 		flow_free_state(env, s);
@@ -1696,6 +1755,7 @@ int bpf_flow_next(struct bpf_verifier_env *env, int *prev_insn_idx, u64 *log_pos
 		flow_free_state(env, t);
 	}
 
+	flow_free_unused(env);
 
 	env->insn_idx = s->st.insn_idx;
 	if (s->kind == FLOW_FUNC_EXIT) {
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index a24cea7ee79..bcbc89655ed 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1491,6 +1491,10 @@ int bpf_partition_more(struct bpf_verifier_env *env)
 	if (prec->partitioned_by <= BIT(PARTITION_ADD_DEPS))
 		prec->budget = max(prec->budget, bpf_precision_first_budget(env));
 	swap(prec->this_pass, prec->last_pass);
+	/* only the unproven insns of this pass: no check failed at the other ones */
+	bitmap_or(prec->last_unproven_insns, prec->last_pass.unproven_insns,
+		  prec->last_pass.bad_read_insns, env->prog->len);
+	bitmap_and(prec->err_insns, prec->err_insns, prec->last_unproven_insns, env->prog->len);
 	bitmap_copy(prec->last_unproven_insns, prec->last_pass.unproven_insns, env->prog->len);
 	if (helped)
 		keep_precision(prec, true);
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index 7b27c27c8d9..39284d1df97 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -73,7 +73,9 @@ struct bpf_precision {
 	unsigned long *err_insns;		/* insns at which the failing path can end */
 	u32 *hops_to_err, *hops_to_exit;	/* per insn, see compute_hops() */
 	u64 *seen;				/* hash set, see bpf_failing_path_was_here() */
+	u32 seen_cnt, seen_bits;
 	unsigned long *loop_control_deps;	/* see bpf_jumps_see_same() */
+	u32 loop_control_deps_for, new_data_deps_for;
 	u32 loop_carried_at;
 	unsigned long loop_carried[XREG_WORDS];
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4f73bcf6c57..a2c5f967c37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1732,10 +1732,17 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	return NULL;
 }
 
+static void leave_loops(struct bpf_func_state *state, u32 cnt)
+{
+	while (state->loop_stack_cnt > cnt)
+		bpf_flow_put_header_state(&state->loop_stack[--state->loop_stack_cnt]);
+}
+
 static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
 		return;
+	leave_loops(state, 0);
 	kfree(state->loop_stack);
 	kfree(state->stack_arg_regs);
 	kfree(state->stack);
@@ -1780,6 +1787,9 @@ void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
+	u32 i;
+
+	leave_loops(dst, 0);
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
 	/* Instruction accounting is path-local, not part of verifier state. */
 	dst->insns_subtotal = 0;
@@ -1789,6 +1799,9 @@ static int copy_func_state(struct bpf_func_state *dst,
 	if (!dst->loop_stack)
 		return -ENOMEM;
 	dst->loop_stack_cnt = src->loop_stack_cnt;
+	for (i = 0; i < src->loop_stack_cnt; i++)
+		if (src->loop_stack[i].header_state)
+			src->loop_stack[i].header_state->refcnt++;
 	return copy_stack_state(dst, src);
 }
 
@@ -10363,8 +10376,10 @@ static int check_func_args(struct bpf_verifier_env *env, struct bpf_call_arg_met
 		err = check_outgoing_stack_args(env, caller, proto_slots, meta->func_name,
 						meta->btf, proto_slots == nargs ? args : NULL);
 		if (err)
-			return err;
+			return meta->subprog_is_static ? -ENODATA : err;
 	}
+	/* the other errors only make BTF unreliable, see btf_check_subprog_call() */
+	env->no_report |= meta->subprog_is_static;
 
 	for (arg = 0; arg < nargs; arg++, prev_slot = slot, slot += nslots) {
 		const struct btf_type *t;
@@ -11297,6 +11312,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	memset(&meta, 0, sizeof(meta));
 	meta.btf = btf;
 	meta.subprog_may_change_pkt = sub->changes_pkt_data;
+	meta.subprog_is_static = !bpf_subprog_is_global(env, subprog);
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
@@ -11335,6 +11351,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
  *
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
+ * ENODATA - a static function loads a stack argument that is not there.
  * Other errors - there is a type mismatch or BTF is not available.
  * 0 - BTF matches with what bpf_reg_state expects.
  */
@@ -11342,6 +11359,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_prog *prog = env->prog;
 	struct btf *btf = prog->aux->btf;
+	bool no_report = env->no_report;
 	u32 btf_id;
 	int err;
 
@@ -11356,6 +11374,7 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 		return -EINVAL;
 
 	err = btf_check_func_arg_match(env, subprog, btf);
+	env->no_report = no_report;
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * Mark a static function as unreliable from BTF point of view. The other call is unproven.
@@ -11368,7 +11387,11 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 /* The helper returns */
 static void leave_callback(struct bpf_func_state *caller)
 {
+	struct loop_stack_entry *entry = bpf_top_loop(caller);
+
 	caller->callback_depth = 0;
+	if (entry && entry->loop->kind == BPF_LOOP_CALLBACK)
+		leave_loops(caller, caller->loop_stack_cnt - 1);
 }
 
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
@@ -11796,6 +11819,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
+	if (err == -ENODATA)
+		return -EINVAL;
 	if (bpf_subprog_is_global(env, subprog)) {
 		struct bpf_func_info_aux *sub_aux = subprog_aux(env, subprog);
 		const char *sub_name = bpf_subprog_name(env, subprog);
@@ -11922,6 +11947,8 @@ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *
 	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
+	if (err == -ENODATA)
+		return -EINVAL;
 
 	/* bpf_compute_live_registers() counts on it */
 	if (verifier_bug_if(!env->subprog_info[subprog].addr_taken, env,
@@ -20884,7 +20911,7 @@ static void loop_stack_pop(struct bpf_verifier_env *env)
 			if (frame->loop_stack[i].loop->kind == BPF_LOOP_JUMPS)
 				verbose(env, "exiting loop %d\n",
 					frame->loop_stack[i].loop->header);
-	frame->loop_stack_cnt = new_cnt;
+	leave_loops(frame, new_cnt);
 	if (new_cnt != cnt)
 		bpf_equations_clean(env, env->cur_state);
 }
@@ -20944,6 +20971,86 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
 	return held_cnt(st) > st->max_held_cnt;
 }
 
+/*
+ * A path-sensitive run is in a loop with a trip count. If only the jump on the iv depends on
+ * the xregs that moved, the path can take the same edges again and again:
+ *	for (i = 0; i < 100000; i++) { if (rnd() && n < 8) n++; }
+ * Two trips show a step also for 'sum += i', and more than 2^32 trips also for a ring index.
+ * If the steps are not constant, the skip or "infinite" is a guess.
+ * Returns 1 if it skipped these trips.
+ */
+static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct bpf_verifier_state *cur = env->cur_state, *old = &entry->header_state->st;
+	u32 period = entry->trip - bpf_top_loop(old->frame[old->curframe])->trip;
+	bool infinite = entry->trips_left > BPF_MAX_TRIPS, guess;
+	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) = {};
+	int err;
+
+	/* the answer needs a walk over the program */
+	if ((infinite ? entry->loop->infinite : entry->trips_left <= period) ||
+	    (u64)entry->trip * entry->loop->nr_insns < env->prog->len)
+		return 0;
+	bpf_fast_forward_xregs(env, old, cur, 0, iv_xregs);
+	err = bpf_jumps_see_same(env, old, cur, entry->iv_jump_idx, infinite ? NULL : iv_xregs);
+	if (err <= 0)
+		return err;
+	guess = !bpf_steps_are_constant(env, entry, iv_xregs, infinite);
+	if (infinite) {
+		entry->loop->infinite = true;
+		entry->loop->infinite_is_guess = guess || env->run_has_guess;
+		return 0;
+	}
+	env->run_has_guess |= guess;
+	bpf_fast_forward_xregs(env, old, cur, div_u64(entry->trips_left - 1, period), iv_xregs);
+	entry->iv_jump_idx = 0;
+	entry->trips_left = 1;
+	return 1;
+}
+
+/*
+ * A path of a path-sensitive run starts a trip. Compare it with the state in which it started
+ * trip 0, 1, 2, 4, ...
+ * If the jumps see the same values, the loop is infinite and needs may_goto.
+ * With a trip count the path makes that many trips. Else it makes up to
+ * env->failing_path_max_trips. Returns 1 if it ends here.
+ */
+static int failing_path_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct bpf_verifier_state *cur = env->cur_state, *old = &entry->header_state->st;
+	struct bpf_loop *loop = entry->loop;
+	struct loop_stack_entry mine;
+	int err;
+
+	if (entry->trip > env->failing_path_max_trips &&
+	    (!entry->trips_left || entry->trips_left > BPF_MAX_TRIPS)) {
+		env->too_deep = true;
+		return 1;
+	}
+	if (entry->header_state) {
+		mine = *entry;
+		*entry = *bpf_top_loop(old->frame[old->curframe]);
+		err = bpf_same_join_key(old, cur);
+		*entry = mine;
+		if (err)
+			err = entry->trips_left ? fast_forward_trips(env, entry) :
+						  bpf_jumps_see_same(env, old, cur, -1, NULL);
+		if (err < 0)
+			return err;
+		if (err && entry->trips_left)
+			return bpf_flow_save_header_state(env, entry);
+		if (err && !loop->infinite && !loop->rt_bounded) {
+			loop->infinite = true;
+			/* the next runs keep it */
+			loop->infinite_is_guess = env->run_has_guess;
+			return bpf_flow_needs_guard(env, loop);
+		} else if (err && !bpf_values_grew_in_deps(env, old, cur)) {
+			return 1;
+		}
+	}
+	return bpf_trip_is_saved(entry) ? bpf_flow_save_header_state(env, entry) : 0;
+}
+
 /*
  * The cpu can speculate past the jump that the equations decide.
  * The removal of dead code can delete an edge only from a conditional jump.
@@ -20968,6 +21075,8 @@ static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entr
 		    (env->bypass_spec_v1 && cnum64_is_empty(entry->trip_index.r64)))
 			return 1;
 	}
+	if (env->path_sensitive)
+		return failing_path_trip(env, entry);
 	if (!entry->peeled)
 		return check_held_in_leftover(env, entry);
 	*starts_leftover = !bpf_flow_trip_is_new(env, entry) || !try_peel_trip(entry);
@@ -21020,6 +21129,8 @@ static int enter_callback(struct bpf_verifier_env *env, bool back, struct bpf_lo
 		entry = push_loop(env, frame, loop);
 		if (!entry)
 			return -ENOMEM;
+		if (env->path_sensitive)
+			return failing_path_trip(env, entry);
 		starts_leftover = !try_peel_trip(entry);
 	}
 	if (starts_leftover)
@@ -21066,6 +21177,10 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge
 	entry = bpf_top_loop(frame);
 	if (!entry || entry->loop != cur_aux(env)->loop)
 		return enter_callback(env, false, NULL);
+	if (env->path_sensitive)
+		return (pushed ? failing_path_trip(env, entry) :
+			next_trip(env, entry, starts_leftover)) ?:
+		       enter_callback(env, false, NULL);
 	if (pushed) {
 		*starts_leftover = !try_peel_trip(entry);
 		return *starts_leftover ? 0 : enter_callback(env, false, NULL);
@@ -21192,6 +21307,7 @@ static int check_loop_guard(struct bpf_verifier_env *env)
 	}
 
 	env->imprecise |= !env->err;
+	env->run_has_guess |= loop->infinite_is_guess;
 	/* the device runs the insns that the driver was given, without may_goto */
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
 		verbose(env, "loop at insn %d has no known bound in an offloaded program\n",
@@ -21231,6 +21347,9 @@ static int check_loop_guard(struct bpf_verifier_env *env)
 		env->guards_late |= aux->loop_guard;
 		aux->guard_no_unwind = true;
 	}
+	/* another state selected the target, possibly a state that only a join makes */
+	env->run_has_guess |= aux->guard_no_unwind &&
+			      state_can_unwind(env, env->cur_state, aux->guard_unset_reg);
 out:
 	aux->loop_guard = true;
 	aux->guard_unwinds = !aux->guard_no_unwind;
@@ -21541,7 +21660,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		held = held_cnt(state);
 		from_unproven = reads_from_unproven(env);
 		fixups = insn_aux->fixups;
+		env->no_report = state->speculative;
 		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
+		env->no_report = false;
 		/* a call or an exit gave the state to the flow, the error is from there */
 		if (err < 0 && !state->frame[0])
 			return err;
@@ -21672,10 +21793,20 @@ static int do_check(struct bpf_verifier_env *env)
 		err = do_check_block(env, prev_insn_idx);
 		if (env->bug)
 			return -EFAULT;
+		/* a pass had no error at this insn, possibly with a state that has more values */
+		if (err && env->path_sensitive && is_error_of_state(env, err) &&
+		    (env->cur_state->infeasible || env->cur_state->equations.infeasible ||
+		     !bpf_failing_path_may_end_at(env, env->insn_idx))) {
+			bpf_free_verifier_state(env, env->cur_state, false);
+			memset(env->cur_state, 0, sizeof(*env->cur_state));
+			free_pushed_states(env);
+			err = 0;
+		}
 	}
 	/* bpf_flow_edge_unproven() noted it with the state that failed */
 	if (err && !bpf_insn_is_unproven(env))
 		note_error(env, err);
+	env->run_over_budget |= !err;
 	return err;
 }
 
@@ -22761,6 +22892,16 @@ static void free_states(struct bpf_verifier_env *env)
 	bpf_flow_reset(env);
 }
 
+/* A multiple of the shortest path. It doubles with each pass. A function gets half. */
+static u64 func_failing_path_budget(struct bpf_verifier_env *env)
+{
+	u64 hops = (bpf_failing_path_hops(env, env->cur_state) + 1ULL) * BPF_COST_STATE;
+
+	env->failing_path_budget = min(hops << env->failing_path_budget_shift,
+				       env->failing_path_budget);
+	return env->failing_path_budget / 2;
+}
+
 static int do_check_common(struct bpf_verifier_env *env, int subprog,
 			   enum bpf_func_context context)
 {
@@ -22917,6 +23058,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 		}
 	}
 
+	state->insn_idx = sub->start;
+	if (env->path_sensitive)
+		env->failing_path_max_cost = env->cost + func_failing_path_budget(env);
 	ret = do_check(env);
 out:
 	if (ret && !env->err)
@@ -23153,6 +23297,93 @@ static int check_after_pass(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* Returns the first error */
+static int check_funcs(struct bpf_verifier_env *env, struct bpf_snapshot *initial)
+{
+	u32 level = env->log.level;
+	int ret;
+
+	restore_snapshot(env, initial);
+	kvfree(env->callx_edges);
+	kvfree(env->callx_index.slots);
+	env->callx_edges = NULL;
+	env->callx_index = (struct bpf_index){};
+	bpf_flow_new_pass(env);
+	ret = do_check_main(env) ?: do_check_subprogs(env) ?: bpf_check_limits(env);
+	env->log.level = level;
+	env->pass_max_cost = U64_MAX;
+	return ret == -EINTR ? ret : env->err ?: ret;
+}
+
+/*
+ * If the error of a pass is real, do_check_all() limits the next passes and logs a path to it.
+ * To see if it is real, reproduce it with no joins. Check one path after another, depth first
+ * from the entry of the function, until the check of an insn in err_insns fails:
+ * - there are no joins, a call stays in the instance of its caller, each trip is peeled
+ * - a state is dropped if a state with the same values in the deps was at the insn
+ * - only a loop that is found to be infinite gets may_goto, see failing_path_trip()
+ * That path is the failing path. The run accepts nothing. It is not the verdict: a path has
+ * ranges too, and a check can fail on it where the joined state is proven.
+ * run_has_guess: the run made a guess, on any of its paths. Then the failing path can be false,
+ * see fast_forward_trips() and check_loop_guard().
+ * Returns the error on the path, 0 if there is none.
+ */
+static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_snapshot *initial,
+			      bool repeat)
+{
+	u64 budget = env->failing_path_budget;
+	int ret;
+
+	env->path_sensitive = true;
+	env->run_has_guess = false;
+	env->err = 0;
+	ret = bpf_failing_path_prepare(env, repeat) ?: check_funcs(env, initial);
+	env->path_sensitive = false;
+	/* for the repeat */
+	if (env->err)
+		env->failing_path_budget = budget;
+	return ret == -EINTR ? ret : env->err;
+}
+
+/*
+ * The path-sensitive runs, in their order:
+ *
+ *	trips of a loop without a trip count	1, any number, 3, 7, ...
+ *	which edge goes first			the shortest path; if over budget, the fall-through
+ *
+ * A function gets half of the budget that is left. @last: the budget is twice the cost so far.
+ */
+static int find_failing_path(struct bpf_verifier_env *env, struct bpf_snapshot *initial, bool last)
+{
+	u32 trips;
+	u64 start;
+	int ret;
+
+	if (env->log.level & BPF_LOG_LEVEL2)
+		verbose(env, "path-sensitive run after pass %u\n", env->pass);
+	env->failing_path_budget_shift = last ? 20 : min(env->pass + 3, 20);
+	env->failing_path_budget = last ? 2 * env->cost : bpf_precision_budget(env) / 4;
+	env->failing_path_max_trips = trips = 1;
+	env->fallthrough_first = false;
+	for (;;) {
+		start = env->cost;
+		ret = run_path_sensitive(env, initial, false);
+		if (ret || env->over_limit || env->bug ||
+		    env->cost - start >= env->failing_path_budget)
+			return ret;
+		env->failing_path_budget -= env->cost - start;
+		env->fallthrough_first = !env->fallthrough_first && env->run_over_budget;
+		if (env->fallthrough_first)
+			continue;
+		if (env->no_mem || (!env->run_over_budget && !env->too_deep))
+			return 0;
+		if (env->failing_path_max_trips == 1)
+			env->failing_path_max_trips = U32_MAX;
+		else
+			env->failing_path_max_trips = trips = 2 * trips + 1;
+	}
+}
+
 /*
  * What stops a loop is assumed before the main pass and checked in it, see flow_is_bound(). The
  * main prog and global functions may get to the same loop. It has may_goto for all of them or
-- 
2.55.0

