Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911623;
	b=SOPsE3p6NJS/xUmPcbLrRdcua0Ci9K7mDxukAIT75K3GMEnSiX7j9cTWzrtaInXYmbtv
	 Ge3kutfCB2pS3fSkjOKBtIN8uxO3OkGj0phldBz7BY1N00KRya8UXmv83wujNg+C3z9p0
	 59CW31m1L+xui5tj5VKNCECue4aZsha6lJanh4576cNeGc39IEMmaKrNFXHJTedn7JrH/
	 LYLUI9tRQ4t7h8Iw9UbeaU/K5qFHiKpgLXoGXDjPpejnG5fQEVlndjDuV2fjUcsmtmtEr
	 CRXn+8dTIDTun06CLQW6ptHClE8C/M5GItqWbc7y8bKkdWQFeMxwvkFmU5Ign+0hesA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=30HbYtOVJj+vysneNVkbA+vV0qWpW5EQNsvIoe4osiA=;
	b=VH3euinrrRAaouTNWct1OhsNUPvudiSg4Kql9Z0HPL/6JgIO2gmcqU7KGejMC3JBkqu9
	 fFnBWUrYeIMkXqdhcPK2TyDRK11JPEDzyVq/blOiiBlEnujdPvVlWXxG1rrzW2gQxUoMD
	 b3CgvwBmntEZIMcH+uyEXqx30bSSd6GXwOIWhHExvveq9u+6lYxfvl35wv9tPlgBs1TuL
	 24ak1e/Jp4450gtDC5SloOTlV9cRirsJ0wKJkPZSwO1tJsiRshOf2WjWdaIYHvfX4ojgU
	 4h3OHVSu9gWRPE+AMrlJ2BwfwSGliKTrImktq/R8BO1fZQCkvaugV/XAZ3GjEj4MnEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p7tLA/jl";
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A2606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034A2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7tLA/jl
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc502d509c0so1012700a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911622; x=1794516422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30HbYtOVJj+vysneNVkbA+vV0qWpW5EQNsvIoe4osiA=;
        b=p7tLA/jlzQyY6oMkeYdEcM6iwRWnfLYa/D5Po7Rny2qMmSodQlQ4Ejnaskq/JAZpvk
         Iv+D0PdyGV8yz8e0noETSg2zhJPTzBjCF6UGZuY4zBDwlIVjsk9HevQChcYtzbipaZlj
         nvLkYmAITgXm2W7Hr/yRXEJ7wbvMRsNkBjr0sU0ndOsMPkJqLY8Q/28PIa8e/2gQWtze
         LKftnVFnr+eUQzAiXz2QoiRxFqVuzvrA77CZgqb/m1rLaqcjIJuxkVldSixjj8E0w2ZF
         /g3sZ8jImOU5HfzyhM23/Y6rke8bwOODKJg65kA5C8Nux1gRUwFI1n8oTe2GFTn/sflB
         NKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911622; x=1794516422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=30HbYtOVJj+vysneNVkbA+vV0qWpW5EQNsvIoe4osiA=;
        b=SO9qVFcezeMLhZK4QlGuyvKUO7nAcybbTL/2stLVqyK3pGIyW9xpz6IkZV8Kc6GmAZ
         yI25yufaQzLabXJQ0Yii3/UQAbOaIxejsd/sSES42/IUBGWkMo3Jhy/rtSmhzFuAWoZs
         na2nrLkQgexzeSrChHa/T8z2kRlSUQWfZWRkLYlyTBSPFNr5J0fUcxSU7XsTqQnqnbF5
         Co5S2MqLTEhEEK9t8iM9sYCFt7e9LUO+w3KIWXfWrH45Vp769rs1f/CyrrlpmqDimjx7
         TMvyY9ROuRTwz6MiMMZo7yugU3zve7tgDUWRURIBGvxjQ38nYf4Ai68sC2CaI4t06pqE
         x5OQ==
X-Gm-Message-State: APuU4Z8gzgrrAjdzMHKomr1bEHGSdiZFyPZx4msjCu65F3UGco4TaJyv
	ryUBIpZlcT6mphugwireEWcUQF2CawFI4KmzvvbQ9K2qujZENwSRbsqzn8nM8w==
X-Gm-Gg: AYBFou0NLrsVA+EE5KHq0VOWLa+OxCJAKHRQvojJ9xI1IjqTeK3Mhuff0VMWOFAA3KE
	ov2uilG+uv8USChTvxy4gvoJrr2OrquSwUeFP8Wk7JbDwePphc9Vi8BnT/Kj4k7R1mEI0Ygjw1e
	mWxREKKsviTdDtwPDC8D5M+h675VZLxdgfyvuaPIZ6WXdsDOQbwXu4aEeeQte13Ep4OUB14xpj7
	oWtHh+CFHUzOHPl5k14B7GBfIR81kf+JjK0QitNT7XFDHhVM18GQVlJBINRcpK70Mq0ITGj9Tct
	ruFKKTJc9gbBYUEZ6m3MuqcMtXNmrMC8S6pQxFOPs1xyx8SKd3fDmD8dl8uPRQZGXsmcxEPpzZP
	KDzgzdHKyyirKDiSfo9nz8V5uhCQlvxMNh8x6bEeeFX3pEBhbME4BqUk3HnOwpsIvzw3gshnIRd
	rBAsH9g3XmNiddb9gAhYzey1vtteCbQ0R7BULS4WxGTyM9j6NkAmARLkxkXSb5LH+Yl+w++c0pu
	KG71jOP5qKhKO4EOCNcJpzyEnQ2+tNBXDg+AZzP/ynhAoHeQ2CArhXplqKLP+P/fKVv/CA/v+gi
	5WeRR/PBzICV8lFuQZ6rAxWJ6rgJGJcvHdh37Bu2dZumguAbZfI/0VvwGkNLzDNwb06OU7mgsSU
	IFVs+MvMCQq7YRl6N9uB83+TPriImFMm0zlpfVJ8biP2NvRtcr9PQqvOIodHnQqxYBAiqvUvPbn
	lUJZx6d41ylTM6HJ8mB0U=
X-Received: by 2002:a17:90b:57ee:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3b0db6ee3aemr163836a91.26.1793911622142;
        Thu, 05 Nov 2026 12:47:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed092133ecsm19970675ad.73.2026.11.05.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:47:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 18/35] bpf: Tell the passes over the graph where an added may_goto goes
Date: Thu,  5 Nov 2026 20:44:55 +0000
Message-ID: <20261105204513.2230344-19-alexei.starovoitov@gmail.com>
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

A spin lock in Rust, test atomic_spin_lock of rust-bpf:

  for _ in 0..n {
      while lock.compare_exchange_weak(...).is_err() {
          core::hint::spin_loop();
      }
      data += 1;
      lock.store(false, Release);
  }

The compiler makes one loop with two back edges. The spin does not pass the
test of the counter: no jump that leaves the loop is in each iteration.
Today: "infinite loop detected at insn 41". The only place for may_goto
that each iteration passes is the head. Its target is an exit of all loops
around it. Without that place: "loop at insn 41 never exits". 142 of the
225 progs of the schedulers of rust-bpf have such a loop.

The prog has no edge from the head to the exit. The main pass verifies the
state that goes there. But three passes before it see only the control flow
graph, and the main pass and scalar evolution rely on their results:

  pass                      if it does not know the edge
  ------------------------  -----------------------------------------------
  bpf_compute_const_regs()  r7 == &ro on all edges to the exit, r7 == &rw
                            at the head. 'for (i = 0; i < *r7; i++)' after
                            the exit gets its count from ro. The count is
                            wrong for the state that comes from the head.
  compute_subprog_args()    The same with fp-8 and fp-16: a store through
                            r7 changes a slot that the pass does not know.
  live registers            A register that the loop sets on each path to
                            the exit is dead at the head. The state at the
                            head drops it. A read after the exit is
                            rejected.

The place and the target depend only on the loops. Thus call
bpf_flow_place_guards() directly after the loops are known. If a loop has
this place bpf_check() calculates the constants again, with nothing known
at the target. compute_subprog_args() joins what it knows at the head into
the target. A register that is live at the target is live at the head.

The edge is there for each loop that can get a may_goto at its head, if it
gets one or not. Thus the passes can know less than before. The loop of
compute_live_registers/may_goto is such a loop: r1 is live at its head.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/const_fold.c                       |  8 +++-
 kernel/bpf/liveness.c                         | 41 ++++++++++++++-----
 kernel/bpf/verifier.c                         | 11 +++++
 .../bpf/progs/compute_live_registers.c        |  8 +++-
 4 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index eac2bf80274c..1d71c2b611a5 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -250,7 +250,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	struct const_arg_info ci_out[MAX_BPF_REG];
 	struct bpf_iarray *succ;
 	bool changed;
-	int i, r;
+	int i, r, t;
 
 	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
 	ci_in = kvzalloc_objs(*ci_in, insn_cnt, GFP_KERNEL_ACCOUNT);
@@ -264,6 +264,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 		for (r = 0; r < MAX_BPF_REG; r++)
 			ci_in[start][r] = unknown;
 	}
+	/* The same from the head of a loop to where the loop is left, once the loops are known. */
+	for (i = 0; i < insn_cnt; i++) {
+		t = bpf_head_guard_target(env, i);
+		for (r = 0; r < MAX_BPF_REG && t >= 0; r++)
+			ci_in[t][r] = unknown;
+	}
 
 redo:
 	changed = false;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 525c0faff1a6..6a2ee407412b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1054,6 +1054,22 @@ static bool arg_track_join(struct bpf_verifier_env *env, int idx, int target, in
 	return true;
 }
 
+/* What leaves @idx gets to @target */
+static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target,
+			       struct arg_track *in, struct arg_track *stack_in,
+			       const struct arg_track *out, const struct arg_track *stack_out,
+			       u32 nslots)
+{
+	bool changed = false;
+	int r;
+
+	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
+		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
+	for (r = 0; r < nslots; r++)
+		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
+	return changed;
+}
+
 /*
  * Compute the result when an ALU op destroys offset precision.
  * If a single arg is identifiable, preserve it with OFF_IMPRECISE.
@@ -2069,6 +2085,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		int i = idx - start;
 		struct bpf_insn *insn = &insns[idx];
 		struct bpf_iarray *succ;
+		int ti;
 
 		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
 			continue;
@@ -2076,6 +2093,12 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*at_stack_out));
 
+		ti = bpf_head_guard_target(env, idx) - start;
+		if (ti >= 0)
+			changed |= arg_track_join_all(env, idx, start + ti, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
+
 		arg_track_xfer(env, insn, idx, at_out, at_stack_out, nslots,
 			       at_stack_arg_entry, instance, callsites);
 		arg_track_log(env, insn, idx, at_in[i], &at_stack_in[(size_t)i * nslots], at_out,
@@ -2085,21 +2108,14 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		succ = bpf_insn_successors(env, idx);
 		for (int s = 0; s < succ->cnt; s++) {
 			int target = succ->items[s];
-			int ti;
 
 			/* Filter: stay within the subprogram's range */
 			if (target < start || target >= end)
 				continue;
 			ti = target - start;
-
-			for (r = 0; r < MAX_AT_TRACK_REGS; r++)
-				changed |= arg_track_join(env, idx, target, r,
-							  &at_in[ti][r], at_out[r]);
-
-			for (r = 0; r < nslots; r++)
-				changed |= arg_track_join(env, idx, target, -r - 1,
-							  &at_stack_in[(size_t)ti * nslots + r],
-							  at_stack_out[r]);
+			changed |= arg_track_join_all(env, idx, target, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
 		}
 	}
 	if (changed)
@@ -2780,6 +2796,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			u32 new_out = 0;
 			u32 new_in = 0;
 			u32 use;
+			int t;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2794,6 +2811,10 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
 				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
 			new_in = (new_out & ~live->def) | use;
+			/* may_goto that is added at the head of a loop goes there */
+			t = bpf_head_guard_target(env, insn_idx);
+			if (t >= 0)
+				new_in |= state[t].in;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
 				live->out = new_out;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33e3da724975..8b26bf625e5f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25141,6 +25141,17 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/*
+	 * It took the constants to remove dead branches and find the loops. Now it's known
+	 * which edges the verifier may add, see bpf_head_guard_target(). What follows
+	 * believes the constants.
+	 */
+	ret = bpf_flow_place_guards(env);
+	if (ret > 0)
+		ret = bpf_compute_const_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index ba43304836ca..f5c505dfd464 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -316,11 +316,15 @@ __naked void gotol(void)
 }
 #endif
 
+/*
+ * If the verifier had to add may_goto to this loop it would be at the head, insn 0, and go to
+ * insn 3. What is live at 3 is live at 0.
+ */
 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 1")
+__msg("0: .1........ (b7) r1 = 1")
 __msg("1: .1........ (e5) may_goto pc+1")
-__msg("2: .......... (05) goto pc-3")
+__msg("2: .1........ (05) goto pc-3")
 __msg("3: .1........ (bf) r0 = r1")
 __msg("4: 0......... (95) exit")
 __naked void may_goto(void)
-- 
2.55.0

