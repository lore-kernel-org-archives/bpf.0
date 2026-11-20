Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207841;
	b=tY1mmm+y7S8uHqm4GKzYYCDU/OxvgrBqnsEF01hXSPKToCLh+OdZMEuBBeGtr3YpvP/2
	 bcf1pgFfSJNCgK2alu8iy9l8ZoizBP9lvDOJkEvIYW5Pd9Zqs3+aH/EQQmnOJeam6KnTP
	 yNIgUTM4SeV8i5S3rggd54gGPsS4HFUB/zlmZGG8W8iHQcPkw7wAxdoDmNKwJZEMwL8R9
	 DO4qHluMAKnxb256x4W8vYByjOj7mGlUcyCzKm1IY7nfcZqf6WAPec7wDb6z51n5ffsoJ
	 Ujj5uO9psTSbPWzcS2yuDRQkzSynqkwxruWWyPCOw/MgYcUTeee6r+i8WOPPeai2+4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hqgmVeZo06+ZsnUzbLUOAYSSBcj/nhw3agmGoD8SXn4=;
	b=M4lzSkpF3PX2Ig5mCASIIw36+uII5qU+jw7Iq+fyUrLH2tkv/jpfCRgQVeL4QDwJtBrk
	 qwkMQxZovpZjayhesoGn08x1DTvbBLn0+L4N55uJNp3PTn/CDyvPlxINvvPvswHwjGmqI
	 bnExGRcuhX0nGHKd1o3I7zkvVKPJ6oD453YVuTQ0OhCDmNxHbrL5TNPXanlJTidWyk/E+
	 uZ1gte1XyJTrox3eL9NkGQ27BqOZwt+kyBzHHIKrKW0/VvuV41ckpmtUQzlTkMg2KX3Um
	 JJkIDekLoh6/qCVAaqKn4V16VjOp74UOHasij7li6Z5l9WjSdSEtgs8S8G+sWmxaLZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wOcq/G7u";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613F606A6A0
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2613F606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wOcq/G7u
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cddff772fffso386416a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207833; x=1795812633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqgmVeZo06+ZsnUzbLUOAYSSBcj/nhw3agmGoD8SXn4=;
        b=wOcq/G7uTlpTHeaPucuMobMPJIr7fT4X9BIMgR9kc9Rt8Whgk6KnFU0qyjaZgvjtJi
         vhfcoYdzDZdkK8g+HYB4y1ckhqqH/s6i2rMUHx+zALUNk4pGJLlIyb+cQfyw+1a5+DBv
         3gFHHMnRtFdjc4cxvmwMOR5U9wCGG75cKy2/xW/UttDyVrTUKYpQGkBuSTHrP0ZsO2Jo
         G4m80qZtgmrGwEtgnWT8EmrnHLRXvEiWQcXNSMQ2V8Qw6KI+VX/MwT/7cKbY93xT30Q6
         4TPB3LlU9uh8ek1uhkJa7PjDWvFQXmb/nN472+ntVaXsRFu1RMab8DI1Qe/LgTkKQJYD
         U//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207833; x=1795812633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hqgmVeZo06+ZsnUzbLUOAYSSBcj/nhw3agmGoD8SXn4=;
        b=R5XqW3BA6UTGEQd4w6IGKm52YrBDXzoYWmN30CnxtXrKCbKxLnYh+qRG6I9azBhna+
         2t5dkIB2ZbG6V6h+HwbN4dcpPJkRQoCft+BACMCwMExqDQVCyaIYwcf/hQhe4sCa3dYb
         dAZfNeTaYB7q1rxfHGhZYmlNusP/YgAUXxCVnsTybc3ivI4FJ7GDAYh6IizkUBbbk32b
         y1kBc8idpyG/zmqDv7kcN5S/WTtpfqsC3WnwWZWYrzI2G4Bn7I3Va4KPZ6R7bhKlPWAV
         4NOcpqiOlswZZQNokagYDVs749IaFR7PAJVF7AU3metQA3CT6R3COh8/bShzJBot2v2N
         xJQA==
X-Gm-Message-State: APuU4Z8fmknlVy7MPInXS51anNr7/wYTvowR4MK9hjEWstm/Khdkz5lk
	KuZj5dRGD2OQLM5c3itj9UWsoYo3mwxtCWKtEKbF52FVZ7Q0VEsmp8DZ1IB/iA==
X-Gm-Gg: AZFdTZf5mlc01M2qSFPsKXrk44QN8gURYJMba+3dmOn5GJGhwRqrddnoFC+AyY3x3LN
	tZ4UJPD9EwnR5m3vFvjur6zHLAbPjgsLcJfc/3nsbipV3n98t3cO1pmSKZu1UcyouNiIjMPCIF+
	D0F1nXSiQ+pu2o+ljAukxpEQDzD0wpDwkd8qmLBwgYsjxPqQdyJjNjRgE70dQdhyjH/YfIlDOWc
	RBUdSRn0nN8haSaG6XIG6N4FcuL4GswE9faWQHD+h4gRjR9T61RhTjjyGQgxcZ5rgHGv1PVxRPc
	kWbt6aYpcgiai4l8pPYzLvJMWgGDCgW4nnFR5uqzpxiWo+Bhz4HG5B2hCIB1uuQOkBlGf0sUg6n
	a+i8MMOk6jZ4xN2eohzTQas3mNqaG38bB1aDZcmuS7DWuthhcZlUj4GJ1HoHjmswVg4wF/rBwXR
	JqfHFrDUC12tS7SPtjl/Wog6tZf/LiXT4yV6jpRjNvjOIngohGHiQDS/4UPWiRC11vQktBAg5/f
	BkO5xJAY1mtjmL/18KoGLxlbfQBr22pLRvYBJxy5qdWXTvDU+ZV96ttRJ3Y4MXe2KN1m0Rb4nxt
	Opcutnfk2YUGn/ayD5K8I6b3TuHcHZNYoeRk26u0uC9iVl4vpDDXu9XyPcJV8fvPs9LKJnyzG3s
	67vHf+oPqI39ZoyxjhqivXA7oOy6pWn+RkYLkYEVJv5ROQw/cyvg0+iNwIxGa1VFLSqvaPchpdl
	cYG3DmPtvF66MKEB2bz1Ny
X-Received: by 2002:a17:90b:1644:b0:3b0:ae41:2711 with SMTP id 98e67ed59e1d1-3b41c911824mr3572411a91.24.1795207833024;
        Fri, 20 Nov 2026 12:50:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm8444163a91.6.2026.11.20.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/49] bpf: Limit the cost and the memory of a load
Date: Fri, 20 Nov 2026 20:49:13 +0000
Message-ID: <20261120204959.614908-6-alexei.starovoitov@gmail.com>
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

The caps on states are gone. Something has to stop a load that takes
too long. A cap on one kind of work is a poor tool. It rejects a valid
program that needs much of that kind and little else.

Use two limits for the whole load, one on cost and one on memory:

  weight  work
       1  one step of a scan
       4  copy an xreg
      16  clean, compare or join an xreg
     128  check an insn
     512  make, order and free a state

  BPF_MAX_COST 1 << 33, BPF_MAX_MEM 2 GB, 1/32 of both without CAP_BPF

The cost counts work, not time. So the verdict does not depend on the
speed or the load of the machine. bpf_check_limits() calls
bpf_must_abort() too, and replaces it in the loops that add cost. A
thaw does not take an abort back, see env->aborted.

A state knows its part of env->mem, so copy and free take env.
free_pushed_states() frees the states that an insn pushed. A load from
a table of functions pays for the scan and for the set that it makes.
gotox pays for the sort of its targets.

The walks up a deep nest of loops are quadratic. Move the check of
LOOP_STACK_SIZE to bpf_compute_loops(), before these walks.
Stack liveness skips the registers and slots that hold no argument.
It copies the stack only for a call that passes a pointer to a stack.

Stack liveness has a cap on one kind of work too. It rejects a program
after 10000 calls of functions:

  for 12000 times:
    call small_func     liveness analysis exceeded complexity limit

The program is valid and cheap. Remove the cap. Each call site has an
instance, and the hash table of instances has 256 buckets. So 12000
instances make long chains. Use an array with the call site as the
index. An entry has one instance for each depth:

  by_callsite[insn] -> depth 2 -> depth 1 -> NULL

A list has all instances, for the loops over them.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   4 +-
 include/linux/bpf_verifier.h |  41 +++++++-
 kernel/bpf/const_fold.c      |  15 +--
 kernel/bpf/flow.c            |  39 +++++---
 kernel/bpf/liveness.c        | 188 +++++++++++++++++++----------------
 kernel/bpf/loops.c           |  42 +++++++-
 kernel/bpf/states.c          |   1 +
 kernel/bpf/verifier.c        |  90 ++++++++++++-----
 8 files changed, 282 insertions(+), 138 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 971e584c6ef..41f2cb37c19 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2627,8 +2627,8 @@ struct bpf_array {
 int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
 
 /*
- * the longest program. The verifier limits the number of states, not of
- * processed insns, see BPF_FLOW_MAX_STATES.
+ * the longest program. The verifier limits the cost of a load, not the number
+ * of processed insns, see BPF_MAX_COST.
  */
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 06429f57c39..9ae46e3a8d6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -551,6 +551,8 @@ struct bpf_verifier_state {
 
 	/* The insn that the state comes from, -1 if no instructions have been executed yet. */
 	u32 last_insn_idx;
+	/* its part of env->mem */
+	u32 bytes;
 };
 
 /* Number of BPF_REG_SIZE stack slots tracked for the frame so far. */
@@ -1173,6 +1175,10 @@ struct bpf_verifier_env {
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
 	u64 cost, mem;			/* see bpf_check_limits() */
+	u64 max_cost, max_mem;
+	u64 pass_max_cost;		/* see bpf_undo_precision() */
+	bool aborted;			/* a thaw does not take it back */
+	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
 	u32 loop_entry_cnt;		/* see loop_stack_entry.entry_id, callback_entry_id */
@@ -1470,14 +1476,34 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
 			struct bpf_verifier_state *cur);
 
+/*
+ * The two limits of the verifier, for the whole load. The unit of cost is one step of a scan,
+ * about a dozen insns of the CPU. Memory is the bytes of states and tables at a time.
+ */
 #define BPF_COST_SCAN	1	/* one step of a scan */
+#define BPF_COST_COPY	4	/* copy an xreg, or look at its type */
+#define BPF_COST_XREG	16	/* clean, compare or join an xreg */
+#define BPF_COST_INSN	128	/* check an insn */
+#define BPF_COST_STATE	512	/* make, order and free a state */
+#define BPF_MAX_COST	(1ULL << 33)
+#define BPF_MAX_MEM	(1ULL << 31)
+/* Without CAP_BPF programs are small, and their loads wait for each other */
+#define BPF_LIMITS_SHIFT_UNPRIV	5
 
 /* flow.c */
+int bpf_check_limits(struct bpf_verifier_env *env);
+
 static inline void bpf_add_cost(struct bpf_verifier_env *env, u64 cnt, u32 weight)
 {
 	env->cost += cnt * weight;
 }
 
+static inline int bpf_add_cost_and_check(struct bpf_verifier_env *env, u64 cnt, u32 weight)
+{
+	bpf_add_cost(env, cnt, weight);
+	return bpf_check_limits(env);
+}
+
 int bpf_flow_prepare(struct bpf_verifier_env *env);
 void bpf_flow_reset(struct bpf_verifier_env *env);
 void bpf_flow_free(struct bpf_verifier_env *env);
@@ -1501,9 +1527,11 @@ bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 
-int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
+int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *dst_state,
 			    const struct bpf_verifier_state *src);
-void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
+void bpf_charge_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			     bool free_self);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
 void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
@@ -2146,4 +2174,13 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int outer_header);
 
 
+static inline u32 bpf_xreg_cnt(const struct bpf_verifier_state *st)
+{
+	u32 fr, nr = 0;
+
+	for (fr = 0; fr <= st->curframe; fr++)
+		nr += MAX_BPF_REG + bpf_stack_nr_slots(st->frame[fr]);
+	return nr;
+}
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index bf81bd54232..50179edbf34 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -250,9 +250,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	struct const_arg_info ci_out[MAX_BPF_REG];
 	struct bpf_iarray *succ;
 	bool changed;
-	int i, r, t;
+	int i, r, t, err;
 
 	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
+	env->mem += insn_cnt * sizeof(*ci_in);
 	ci_in = kvzalloc_objs(*ci_in, insn_cnt, BPF_VERIFIER_GFP);
 	if (!ci_in)
 		return -ENOMEM;
@@ -278,10 +279,9 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	}
 
 redo:
-	if (bpf_must_abort()) {
-		kvfree(ci_in);
-		return -EINTR;
-	}
+	err = bpf_add_cost_and_check(env, env->cfg.cur_postorder * 2ULL, BPF_COST_XREG);
+	if (err)
+		goto out;
 	changed = false;
 	for (i = env->cfg.cur_postorder - 1; i >= 0; i--) {
 		int idx = env->cfg.insn_postorder[i];
@@ -334,9 +334,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 		aux->const_reg_map_mask = map_mask;
 		aux->const_reg_subprog_mask = subprog_mask;
 	}
-
+out:
+	env->mem -= insn_cnt * sizeof(*ci_in);
 	kvfree(ci_in);
-	return 0;
+	return err;
 }
 
 static int eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index d2248745fdd..5a04cf19805 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -220,9 +220,11 @@ static bool flow_loop_is_bounded(struct bpf_verifier_env *env, int h)
 	if (loop->backedges_overflow || loop->irreducible)
 		return false;
 	for (i = 0; i < loop->backedges_cnt; i++) {
-		for (n = loop->backedges[i].from; n >= 0 && n != h; n = env->idoms[n])
+		for (n = loop->backedges[i].from; n >= 0 && n != h; n = env->idoms[n]) {
+			bpf_add_cost(env, 1, BPF_COST_SCAN);
 			if (flow_is_bound(env, h, n))
 				break;
+		}
 		if (n < 0 || !flow_is_bound(env, h, n))
 			return false;
 	}
@@ -269,7 +271,7 @@ bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env)
 int bpf_flow_place_guards(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	int len = env->prog->len, h, i, depth, ret = 0;
+	int len = env->prog->len, h, i, ret = 0, err = 0;
 	struct bpf_loop *loop;
 	u32 *seen;
 
@@ -279,27 +281,18 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 
 	for (i = 0; i < len; i++) {
 		aux[i].not_stopped = -1;
-		depth = 0;
-		for (h = bpf_loop_at_index(env, i); h >= 0; h = aux[h].loop_header) {
-			/* the main pass doesn't get that deep */
-			if (++depth > LOOP_STACK_SIZE) {
-				verbose(env, "Too many nested loops at %d\n", i);
-				kvfree(seen);
-				return -E2BIG;
-			}
+		for (h = bpf_loop_at_index(env, i); h >= 0; h = aux[h].loop_header)
 			aux[h].loop->nr_insns++;
-		}
 	}
 
 	for (h = 0; h < len; h++) {
 		loop = aux[h].loop;
 		if (!loop)
 			continue;
-		/* a deep nest of loops takes long */
-		if (bpf_must_abort()) {
-			ret = -EINTR;
+		err = bpf_add_cost_and_check(env, (u64)loop->nr_insns * loop->backedges_cnt,
+					     BPF_COST_COPY);
+		if (err)
 			break;
-		}
 		loop->rt_bounded = flow_loop_is_bounded(env, h);
 		/* also when it's bounded: the main pass may find that it's not */
 		flow_place_guards(env, h, seen);
@@ -307,5 +300,19 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 			ret = 1;
 	}
 	kvfree(seen);
-	return ret;
+	return err ?: ret;
+}
+
+int bpf_check_limits(struct bpf_verifier_env *env)
+{
+	env->aborted |= bpf_must_abort();
+	if (env->aborted)
+		return -EINTR;
+	if (env->cost <= min(env->max_cost, env->pass_max_cost) && env->mem <= env->max_mem &&
+	    !env->over_limit)
+		return 0;
+	verbose(env, "BPF program is too complex: cost %llu of %llu, memory %llu of %llu\n",
+		env->cost, min(env->max_cost, env->pass_max_cost), env->mem, env->max_mem);
+	env->over_limit = true;
+	return -E2BIG;
 }
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 711f9da2b26..4a58c5f4db8 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -3,8 +3,6 @@
 
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
-#include <linux/hashtable.h>
-#include <linux/jhash.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
@@ -54,7 +52,9 @@ struct frame_masks {
  * Marks are tracked for each frame up to @depth.
  */
 struct func_instance {
-	struct hlist_node hl_node;
+	struct list_head node;		/* all instances */
+	struct func_instance *next;	/* same callsite, other depth */
+	struct bpf_verifier_env *env;
 	u32 callsite;		/* call insn that invoked this subprog (subprog_start for depth 0) */
 	u32 depth;		/* call depth (0 = entry subprog) */
 	u32 subprog;		/* subprog index */
@@ -75,36 +75,25 @@ struct live_stack_query {
 struct arg_track;
 
 struct bpf_liveness {
-	DECLARE_HASHTABLE(func_instances, 8);		/* maps (depth, callsite) to func_instance */
-	struct live_stack_query live_stack_query;	/* cache to avoid repetitive ht lookups */
-	u32 subprog_calls;				/* analyze_subprog() invocations */
+	struct list_head func_instances;
+	struct live_stack_query live_stack_query;	/* cache to avoid repetitive lookups */
 	/* MAX_AT_TRACK_REGS for every depth: analyze_subprog() calls itself, keep its frame small */
 	struct arg_track *callee_args;
+	struct func_instance *by_callsite[];
 };
 
 /*
- * Hash/compare key for func_instance: (depth, callsite).
  * For depth == 0 (entry subprog), @callsite is the subprog start insn.
  * For depth > 0, @callsite is the call instruction index that invoked the subprog.
  */
-static u32 instance_hash(u32 callsite, u32 depth)
-{
-	u32 key[2] = { depth, callsite };
-
-	return jhash2(key, 2, 0);
-}
-
 static struct func_instance *find_instance(struct bpf_verifier_env *env,
 					   u32 callsite, u32 depth)
 {
-	struct bpf_liveness *liveness = env->liveness;
-	struct func_instance *f;
-	u32 key = instance_hash(callsite, depth);
+	struct func_instance *f = env->liveness->by_callsite[callsite];
 
-	hash_for_each_possible(liveness->func_instances, f, hl_node, key)
-		if (f->depth == depth && f->callsite == callsite)
-			return f;
-	return NULL;
+	while (f && f->depth != depth)
+		f = f->next;
+	return f;
 }
 
 static struct func_instance *call_instance(struct bpf_verifier_env *env,
@@ -115,7 +104,6 @@ static struct func_instance *call_instance(struct bpf_verifier_env *env,
 	u32 subprog_start = env->subprog_info[subprog].start;
 	u32 lookup_key = depth > 0 ? callsite : subprog_start;
 	struct func_instance *f;
-	u32 hash;
 
 	f = find_instance(env, lookup_key, depth);
 	if (f)
@@ -124,13 +112,16 @@ static struct func_instance *call_instance(struct bpf_verifier_env *env,
 	f = kvzalloc_obj(*f, BPF_VERIFIER_GFP);
 	if (!f)
 		return ERR_PTR(-ENOMEM);
+	f->env = env;
 	f->callsite = lookup_key;
 	f->depth = depth;
 	f->subprog = subprog;
 	f->subprog_start = subprog_start;
 	f->insn_cnt = (env->subprog_info + subprog + 1)->start - subprog_start;
-	hash = instance_hash(lookup_key, depth);
-	hash_add(env->liveness->func_instances, &f->hl_node, hash);
+	f->next = env->liveness->by_callsite[lookup_key];
+	env->liveness->by_callsite[lookup_key] = f;
+	list_add(&f->node, &env->liveness->func_instances);
+	env->mem += sizeof(*f);
 	return f;
 }
 
@@ -155,22 +146,23 @@ static struct func_instance *lookup_instance(struct bpf_verifier_env *env,
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env)
 {
-	env->liveness = kvzalloc_obj(*env->liveness, BPF_VERIFIER_GFP);
+	env->liveness = kvzalloc_flex(*env->liveness, by_callsite, env->prog->len,
+				      BPF_VERIFIER_GFP);
 	if (!env->liveness)
 		return -ENOMEM;
-	hash_init(env->liveness->func_instances);
+	INIT_LIST_HEAD(&env->liveness->func_instances);
+	env->mem += env->prog->len * sizeof(*env->liveness->by_callsite);
 	return 0;
 }
 
 void bpf_stack_liveness_free(struct bpf_verifier_env *env)
 {
-	struct func_instance *instance;
-	struct hlist_node *tmp;
-	int bkt, i;
+	struct func_instance *instance, *tmp;
+	int i;
 
 	if (!env->liveness)
 		return;
-	hash_for_each_safe(env->liveness->func_instances, bkt, tmp, instance, hl_node) {
+	list_for_each_entry_safe(instance, tmp, &env->liveness->func_instances, node) {
 		for (i = 0; i <= instance->depth; i++)
 			kvfree(instance->frames[i]);
 		kvfree(instance);
@@ -213,12 +205,18 @@ static struct frame_masks *widen_frame_masks(struct func_instance *instance,
 {
 	struct frame_masks *old = instance->frames[frame], *new;
 	u32 i, kind;
+	int err;
 
 	if (old && old->words >= words)
 		return old;
+	instance->env->mem += frame_mask_words(instance, words - (old ? old->words : 0)) *
+			      sizeof(long);
+	err = bpf_check_limits(instance->env);
+	if (err)
+		return ERR_PTR(err);
 	new = kvzalloc_flex(*new, bits, frame_mask_words(instance, words), BPF_VERIFIER_GFP);
 	if (!new)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	new->words = words;
 	if (old) {
 		for (i = 0; i < instance->insn_cnt; i++)
@@ -249,8 +247,8 @@ static int mark_stack_range(struct func_instance *instance, u32 frame, u32 insn_
 	if (lo > hi)
 		return 0;
 	fm = widen_frame_masks(instance, frame, BITS_TO_LONGS(hi + 1));
-	if (!fm)
-		return -ENOMEM;
+	if (IS_ERR(fm))
+		return PTR_ERR(fm);
 	bitmap_set(rel_mask(fm, relative_idx(instance, insn_idx), kind), lo, hi - lo + 1);
 	return 0;
 }
@@ -314,8 +312,8 @@ static int mark_stack_mask(struct func_instance *instance, u32 frame, u32 insn_i
 	if (last == nbits)
 		return 0;
 	fm = widen_frame_masks(instance, frame, BITS_TO_LONGS(last + 1));
-	if (!fm)
-		return -ENOMEM;
+	if (IS_ERR(fm))
+		return PTR_ERR(fm);
 	dst = rel_mask(fm, relative_idx(instance, insn_idx), kind);
 	/* @src has no bits set past @last, hence none past @fm->words either */
 	src_words = min(src_words, fm->words);
@@ -462,6 +460,7 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 	int *insn_postorder = env->cfg.insn_postorder;
 	struct bpf_subprog_info *subprog;
 	bool changed;
+	int err;
 
 	instance->must_write_initialized = true;
 	subprog = &env->subprog_info[instance->subprog];
@@ -469,12 +468,15 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 	po_end = (subprog + 1)->postorder_start;
 	/* repeat until fixed point is reached */
 	do {
-		if (bpf_must_abort())
-			return -EINTR;
 		changed = false;
 		for (frame = 0; frame <= instance->depth; frame++) {
 			if (!instance->frames[frame])
 				continue;
+			err = bpf_add_cost_and_check(env, (po_end - po_start) *
+							  (4ULL + instance->frames[frame]->words),
+						     BPF_COST_XREG);
+			if (err)
+				return err;
 
 			for (i = po_start; i < po_end; i++) {
 				changed |= update_insn(env, instance, frame, insn_postorder[i],
@@ -779,9 +781,9 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
 	struct func_instance *instance;
 	struct frame_masks *fm;
 	u32 nbits;
-	int bkt, i;
+	int i;
 
-	hash_for_each(liveness->func_instances, bkt, instance, hl_node) {
+	list_for_each_entry(instance, &liveness->func_instances, node) {
 		fm = instance->frames[instance->depth];
 		if (!fm)
 			continue;
@@ -800,16 +802,16 @@ static int print_instances(struct bpf_verifier_env *env)
 {
 	struct func_instance *instance, **sorted_instances;
 	struct bpf_liveness *liveness = env->liveness;
-	int i, bkt, cnt;
+	int i, cnt;
 
 	cnt = 0;
-	hash_for_each(liveness->func_instances, bkt, instance, hl_node)
+	list_for_each_entry(instance, &liveness->func_instances, node)
 		cnt++;
 	sorted_instances = kvmalloc_objs(*sorted_instances, cnt, BPF_VERIFIER_GFP);
 	if (!sorted_instances)
 		return -ENOMEM;
 	cnt = 0;
-	hash_for_each(liveness->func_instances, bkt, instance, hl_node)
+	list_for_each_entry(instance, &liveness->func_instances, node)
 		sorted_instances[cnt++] = instance;
 	sort(sorted_instances, cnt, sizeof(*sorted_instances), cmp_instances, NULL);
 	for (i = 0; i < cnt; i++)
@@ -1058,9 +1060,13 @@ static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 static bool arg_track_join(struct bpf_verifier_env *env, int idx, int target, int r,
 			   struct arg_track *in, struct arg_track out)
 {
-	struct arg_track old = *in;
-	struct arg_track new_val = __arg_track_join(old, out);
+	struct arg_track old, new_val;
 
+	/* most registers and slots hold no argument */
+	if (out.frame == ARG_NONE && in->frame == ARG_NONE)
+		return false;
+	old = *in;
+	new_val = __arg_track_join(old, out);
 	if (arg_track_eq(&new_val, &old))
 		return false;
 
@@ -1101,6 +1107,9 @@ static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target
 	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
 		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
 	same = !memcmp(stack_in, stack_out, nslots * sizeof(*stack_in));
+	/* a change pays for the next visit of @target too */
+	bpf_add_cost(env, MAX_AT_TRACK_REGS + nslots,
+		     same && !changed ? BPF_COST_COPY : BPF_COST_XREG);
 	for (r = 0; r < nslots && !same; r++)
 		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
 	return changed;
@@ -2041,6 +2050,18 @@ static void record_stack_ptrs(struct bpf_verifier_env *env, int idx, struct arg_
 	env->insn_aux_data[idx].stack_ptrs |= mask;
 }
 
+/* Return true if any of R1-R5 or stack args is derived from a frame pointer. */
+static bool has_fp_args(struct arg_track *args)
+{
+	for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
+		if (arg_is_fp(&args[r]))
+			return true;
+	for (int r = 0; r < MAX_STACK_ARG_SLOTS; r++)
+		if (arg_is_fp(&args[MAX_BPF_REG + r]))
+			return true;
+	return false;
+}
+
 /*
  * Compute arg tracking dataflow for a single subprog.
  * Runs forward fixed-point with arg_track_xfer(), then records
@@ -2074,9 +2095,15 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	struct arg_track at_stack_arg_entry[MAX_STACK_ARG_SLOTS];
 	struct arg_track unvisited = { .frame = ARG_UNVISITED };
 	struct arg_track none = { .frame = ARG_NONE };
-	int i, p, r, err = -ENOMEM;
+	size_t bytes = (size_t)len * nslots * sizeof(*at_stack_in);
 	unsigned long *changed = NULL;
+	int i, p, r, err;
 
+	env->mem += bytes;
+	err = bpf_check_limits(env);
+	if (err)
+		goto err_free;
+	err = -ENOMEM;
 	at_in = kvmalloc_objs(*at_in, len, BPF_VERIFIER_GFP);
 	if (!at_in)
 		goto err_free;
@@ -2122,6 +2149,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 
 	/* Forward fixed-point iteration in reverse post order, over insns whose input changed */
 	__set_bit(0, changed);
+	/* the first visit of each insn, see arg_track_join_all() for the others */
+	bpf_add_cost(env, (u64)len * (MAX_AT_TRACK_REGS + nslots), BPF_COST_XREG);
 redo:
 	for (p = po_end - 1; p >= po_start; p--) {
 		int idx = env->cfg.insn_postorder[p];
@@ -2130,8 +2159,8 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		struct bpf_iarray *succ;
 		int ti;
 
-		err = -EINTR;
-		if (bpf_must_abort())
+		err = bpf_add_cost_and_check(env, 1, BPF_COST_SCAN);
+		if (err)
 			goto err_free;
 		if (!__test_and_clear_bit(i, changed))
 			continue;
@@ -2184,16 +2213,18 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 				goto err_free;
 		}
 
-		if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
-			struct spill_snapshot *snap;
+		if ((bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) &&
+		    has_fp_args(at_in[i])) {
+			struct spill_snapshot *snap = env->callsite_at_stack[idx];
 
-			kvfree(env->callsite_at_stack[idx]);
-			env->callsite_at_stack[idx] = kvmalloc_flex(*snap, at, nslots, BPF_VERIFIER_GFP);
-			snap = env->callsite_at_stack[idx];
 			if (!snap) {
-				err = -ENOMEM;
-				goto err_free;
+				snap = kmalloc_flex(*snap, at, nslots, BPF_VERIFIER_GFP);
+				env->callsite_at_stack[idx] = snap;
+				env->mem += ksize(snap);
 			}
+			err = snap ? bpf_check_limits(env) : -ENOMEM;
+			if (err)
+				goto err_free;
 			snap->slots = nslots;
 			memcpy(snap->at, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*snap->at));
 		}
@@ -2208,6 +2239,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	err = 0;
 
 err_free:
+	env->mem -= bytes;
 	kvfree(changed);
 	kvfree(at_stack_out);
 	kvfree(at_stack_in);
@@ -2215,18 +2247,6 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 	return err;
 }
 
-/* Return true if any of R1-R5 or stack args is derived from a frame pointer. */
-static bool has_fp_args(struct arg_track *args)
-{
-	for (int r = BPF_REG_1; r <= BPF_REG_5; r++)
-		if (arg_is_fp(&args[r]))
-			return true;
-	for (int r = 0; r < MAX_STACK_ARG_SLOTS; r++)
-		if (arg_is_fp(&args[MAX_BPF_REG + r]))
-			return true;
-	return false;
-}
-
 /*
  * Merge a freshly analyzed instance into the original.
  * may_read, may_fill: union (any pass might read the slot).
@@ -2264,8 +2284,8 @@ static int merge_instances(struct func_instance *dst, struct func_instance *src)
 			continue;
 		}
 		d = widen_frame_masks(dst, f, s->words);
-		if (!d)
-			return -ENOMEM;
+		if (IS_ERR(d))
+			return PTR_ERR(d);
 		for (i = 0; i < dst->insn_cnt; i++) {
 			unsigned long *dst_read = rel_mask(d, i, FM_MAY_READ);
 			unsigned long *dst_write = rel_mask(d, i, FM_MUST_WRITE);
@@ -2323,6 +2343,7 @@ static struct func_instance *fresh_instance(struct func_instance *src)
 	f = kvzalloc_obj(*f, BPF_VERIFIER_GFP);
 	if (!f)
 		return ERR_PTR(-ENOMEM);
+	f->env = src->env;
 	f->callsite = src->callsite;
 	f->depth = src->depth;
 	f->subprog = src->subprog;
@@ -2335,8 +2356,12 @@ static void free_instance(struct func_instance *instance)
 {
 	int i;
 
-	for (i = 0; i <= instance->depth; i++)
+	for (i = 0; i <= instance->depth; i++) {
+		if (instance->frames[i])
+			instance->env->mem -= sizeof(long) *
+				frame_mask_words(instance, instance->frames[i]->words);
 		kvfree(instance->frames[i]);
+	}
 	kvfree(instance);
 }
 
@@ -2364,16 +2389,6 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	struct func_instance *prev_instance = NULL;
 	int j, err;
 
-	/* a subprog on its own is analyzed once, chains of calls multiply */
-	if (depth && ++env->liveness->subprog_calls > 10000) {
-		verbose(env, "liveness analysis exceeded complexity limit (%d calls)\n",
-			env->liveness->subprog_calls);
-		return -E2BIG;
-	}
-
-	if (bpf_must_abort())
-		return -EINTR;
-
 	/*
 	 * When an instance is reused (must_write_initialized == true),
 	 * record into a fresh instance and merge afterward.  This avoids
@@ -2544,12 +2559,15 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 	int insn_cnt = env->prog->len;
 	struct func_instance *instance;
 	struct subprog_at_info *info;
+	/* each subprog keeps its at_in[] to the end */
+	size_t bytes = insn_cnt * (sizeof(*info->at_in) + sizeof(*env->callsite_at_stack));
 	int k, err = 0;
 
 	info = kvzalloc_objs(*info, env->subprog_cnt, BPF_VERIFIER_GFP);
 	if (!info)
 		return -ENOMEM;
 
+	env->mem += bytes;
 	env->callsite_at_stack = kvzalloc_objs(*env->callsite_at_stack, insn_cnt,
 					       BPF_VERIFIER_GFP);
 	env->liveness->callee_args = kvcalloc(MAX_CALL_FRAMES * MAX_AT_TRACK_REGS,
@@ -2592,8 +2610,11 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 		err = print_instances(env);
 
 out:
-	for (k = 0; k < insn_cnt; k++)
-		kvfree(env->callsite_at_stack[k]);
+	env->mem -= bytes;
+	for (k = 0; k < insn_cnt; k++) {
+		env->mem -= ksize(env->callsite_at_stack[k]);
+		kfree(env->callsite_at_stack[k]);
+	}
 	kvfree(env->callsite_at_stack);
 	env->callsite_at_stack = NULL;
 	kvfree(env->liveness->callee_args);
@@ -2887,10 +2908,9 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 
 		changed = false;
 		/* a cycle of calls takes a round for each link */
-		if (bpf_must_abort()) {
-			err = -EINTR;
+		err = bpf_add_cost_and_check(env, env->cfg.cur_postorder, BPF_COST_XREG);
+		if (err)
 			goto out;
-		}
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
 			int insn_idx = order[i];
 			struct insn_live_regs *live = &state[insn_idx];
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 8a63bb1799a..e1f39629f60 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -88,9 +88,11 @@ static int idoms_intersect(struct bpf_verifier_env *env, int a, int b)
 	while (a != b) {
 		while (postorder_nums[a] < postorder_nums[b]) {
 			a = idoms[a];
+			bpf_add_cost(env, 1, BPF_COST_SCAN);
 		}
 		while (postorder_nums[b] < postorder_nums[a]) {
 			b = idoms[b];
+			bpf_add_cost(env, 1, BPF_COST_SCAN);
 		}
 	}
 	return a;
@@ -248,6 +250,7 @@ static int mark_as_header(struct bpf_verifier_env *env, int h)
 		aux[h].loop = kvzalloc_obj(struct bpf_loop, BPF_VERIFIER_GFP);
 		if (!aux[h].loop)
 			return -ENOMEM;
+		env->mem += sizeof(struct bpf_loop);
 	}
 	return 0;
 }
@@ -268,6 +271,7 @@ static int assign_header(struct bpf_verifier_env *env, struct loops_dfs *dfs, in
 
 	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
 	while (aux[n].loop_header != -1) {
+		bpf_add_cost(env, 1, BPF_COST_SCAN);
 		nh = aux[n].loop_header;
 		if (nh == h)
 			return 0;
@@ -290,6 +294,20 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
 	return aux[idx].loop ? idx : aux[idx].loop_header;
 }
 
+static int check_loop_depth(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int h, depth = 0;
+
+	for (h = bpf_loop_at_index(env, idx); h >= 0; h = aux[h].loop_header) {
+		if (++depth <= LOOP_STACK_SIZE)
+			continue;
+		bpf_log(&env->log, "Too many nested loops at %d\n", idx);
+		return -E2BIG;
+	}
+	return 0;
+}
+
 /*
  * The backedge->from and its latch can reside in an inner loop of @h, e.g.:
  *
@@ -331,8 +349,9 @@ static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct loops_d
 	dfs_pos[start] = 1;
 	stack_sz = 1;
 	do {
-		if (bpf_must_abort())
-			return -EINTR;
+		err = bpf_add_cost_and_check(env, 1, BPF_COST_XREG);
+		if (err)
+			return err;
 
 		cur = stack[stack_sz - 1];
 		succ = bpf_insn_successors(env, cur);
@@ -351,6 +370,10 @@ static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct loops_d
 			stack_sz++;
 			continue;
 		}
+		/* A nest only grows. The cases below walk up the nests of both insns. */
+		err = check_loop_depth(env, cur) ?: check_loop_depth(env, s);
+		if (err)
+			return err;
 		/* 's' is fully explored at this point */
 		if (dfs_pos[s]) {
 			/*
@@ -414,9 +437,11 @@ bool bpf_is_nested_loop(struct bpf_verifier_env *env, int inner_header, int oute
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	int idx;
 
-	for (idx = inner_header; idx >= 0; idx = aux[idx].loop_header)
+	for (idx = inner_header; idx >= 0; idx = aux[idx].loop_header) {
+		bpf_add_cost(env, 1, BPF_COST_SCAN);
 		if (aux[idx].loop_header == outer_header)
 			return true;
+	}
 
 	return false;
 }
@@ -463,12 +488,20 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 		if (err)
 			goto out;
 	}
+	for (i = 0; i < len; i++) {
+		err = check_loop_depth(env, i);
+		if (err)
+			goto out;
+	}
 	for (i = 0; i < len; i++) {
 		loop = aux[i].loop;
 		if (!loop)
 			continue;
 		loop->exit_to = -1;
 		for (j = 0; j < loop->backedges_cnt; j++) {
+			err = bpf_check_limits(env);
+			if (err)
+				goto out;
 			loop->backedges[j].latch = find_latch(env, i, loop->backedges[j].from);
 		}
 	}
@@ -477,6 +510,9 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 		iloop = aux[i].loop ? i : aux[i].loop_header;
 		if (iloop < 0)
 			continue;
+		err = bpf_check_limits(env);
+		if (err)
+			goto out;
 		succ = bpf_insn_successors(env, i);
 		iarray_for_each(s, succ) {
 			sloop = bpf_loop_at_index(env, s);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 73c329ec755..5d78a10dd29 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -179,6 +179,7 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 {
 	int i, err;
 
+	bpf_add_cost(env, bpf_xreg_cnt(st), BPF_COST_XREG);
 	err = bpf_live_stack_query_init(env, st);
 	if (err)
 		return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b184452230..06bd1cd3d18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1742,11 +1742,27 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
-void bpf_free_verifier_state(struct bpf_verifier_state *state,
-			    bool free_self)
+/* @st is new or has grown */
+void bpf_charge_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	/* with the struct that holds it */
+	u32 bytes = 2 * sizeof(*st) + ksize(st->refs), fr;
+	struct bpf_func_state *f;
+
+	for (fr = 0; fr <= st->curframe && (f = st->frame[fr]); fr++)
+		bytes += kmalloc_size_roundup(sizeof(*f)) + ksize(f->stack) +
+			 ksize(f->stack_arg_regs) + ksize(f->loop_stack);
+	env->mem += bytes - (s64)st->bytes;
+	st->bytes = bytes;
+}
+
+void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			     bool free_self)
 {
 	int i;
 
+	env->mem -= state->bytes;
+	state->bytes = 0;
 	for (i = 0; i <= state->curframe; i++) {
 		free_func_state(state->frame[i]);
 		state->frame[i] = NULL;
@@ -1772,8 +1788,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 	return copy_stack_state(dst, src);
 }
 
-int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
-			   const struct bpf_verifier_state *src)
+int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *dst_state,
+			    const struct bpf_verifier_state *src)
 {
 	struct bpf_func_state *dst;
 	int i, err;
@@ -1786,6 +1802,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	err = copy_reference_state(dst_state, src);
 	if (err)
 		return err;
+	bpf_add_cost(env, bpf_xreg_cnt(src) + src->acquired_refs, BPF_COST_COPY);
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->callers_unknown = src->callers_unknown;
@@ -1807,6 +1824,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 		if (err)
 			return err;
 	}
+	bpf_charge_state(env, dst_state);
 	return 0;
 }
 
@@ -1838,9 +1856,9 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	env->head = elem;
-	err = bpf_copy_verifier_state(&elem->st, cur);
+	err = bpf_copy_verifier_state(env, &elem->st, cur) ?: bpf_check_limits(env);
 	if (err)
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(err);
 	elem->st.speculative |= speculative;
 	return &elem->st;
 }
@@ -6952,6 +6970,9 @@ static int check_stack_access_within_bounds(
 		return err;
 	}
 
+	/* the callers look at each byte */
+	bpf_add_cost(env, max_off - min_off, BPF_COST_COPY);
+
 	/*
 	 * Every stack access passes through here, including buffers passed to
 	 * helpers and kfuncs and accesses into a caller's frame, so check the
@@ -7046,6 +7067,7 @@ static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_reg_state
 			kvfree(set);
 			return -ENOMEM;
 		}
+		env->mem += struct_size(set, subprog, n);
 		set->cnt = n;
 		memcpy(set->subprog, subprogs, n * sizeof(*subprogs));
 		env->func_sets[env->func_set_cnt++] = set;
@@ -7105,6 +7127,9 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
 	if (!ptrs)
 		return -ENOENT;
+	err = bpf_add_cost_and_check(env, cnt * sizeof(u64), BPF_COST_COPY);
+	if (err)
+		return err;
 	targets = kvmalloc_array(min(cnt, env->subprog_cnt), sizeof(*targets), BPF_VERIFIER_GFP);
 	found = kvcalloc(BITS_TO_LONGS(env->subprog_cnt), sizeof(long), BPF_VERIFIER_GFP);
 	if (!targets || !found)
@@ -11458,7 +11483,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 			callee->regs[i] = caller->regs[i];
 	err = grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->subprog_info[subprog]));
 	if (err) {
-		bpf_free_verifier_state(&entry, false);
+		bpf_free_verifier_state(env, &entry, false);
 		return err;
 	}
 	for (i = 0; i < callee->out_stack_arg_cnt; i++)
@@ -11466,7 +11491,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 
 	err = copy_reference_state(&entry, state);
 	if (err) {
-		bpf_free_verifier_state(&entry, false);
+		bpf_free_verifier_state(env, &entry, false);
 		return err;
 	}
 	for (i = 0; i < entry.acquired_refs; i++) {
@@ -11496,7 +11521,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	account_current_path(env);
 	env->subprog_info[subprog].on_its_own = true;
 	err = bpf_flow_call(env, state, &entry, subprog, insn_idx);
-	bpf_free_verifier_state(&entry, false);
+	bpf_free_verifier_state(env, &entry, false);
 	/* the call waits, there is nothing to go on with */
 	return err ?: PROCESS_BPF_EXIT;
 }
@@ -11926,13 +11951,13 @@ static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *in
 		copy = kzalloc_obj(*copy, BPF_VERIFIER_GFP);
 		if (!copy)
 			return -ENOMEM;
-		err = bpf_copy_verifier_state(copy, cur);
+		err = bpf_copy_verifier_state(env, copy, cur);
 		if (!err) {
 			env->cur_state = copy;
 			err = check_func_callx_one(env, set->subprog[i], insn_idx);
 			env->cur_state = cur;
 		}
-		bpf_free_verifier_state(copy, true);
+		bpf_free_verifier_state(env, copy, true);
 		if (err == PROCESS_BPF_EXIT)
 			err = 0;
 		else if (verifier_bug_if(!err, env, "callx: func#%d doesn't wait", set->subprog[i]))
@@ -12228,6 +12253,7 @@ static void account_processed_insn(struct bpf_verifier_env *env)
 	struct bpf_func_state *frame = cur_func(env);
 
 	env->insn_processed++;
+	bpf_add_cost(env, 1, BPF_COST_INSN);
 	frame->insns_subtotal++;
 	env->subprog_info[frame->subprogno].insns_self++;
 }
@@ -20282,6 +20308,11 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EFAULT;
 
 	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
+	if (err)
+		return err;
+	/* the targets are sorted */
+	n = max_index - min_index + 1;
+	err = bpf_add_cost_and_check(env, (u64)n * ilog2(n), BPF_COST_COPY);
 	if (err)
 		return err;
 
@@ -20732,7 +20763,7 @@ static int flow_drain(struct bpf_verifier_env *env)
 		else if (!err)
 			err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
 					       elem->prev_insn_idx);
-		bpf_free_verifier_state(&elem->st, false);
+		bpf_free_verifier_state(env, &elem->st, false);
 		kfree(elem);
 	}
 	return err;
@@ -20753,6 +20784,17 @@ static int check_recursion_guard(struct bpf_verifier_env *env)
 	return push_budget_exit(env);
 }
 
+static void free_pushed_states(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_stack_elem *elem;
+
+	while ((elem = env->head)) {
+		env->head = elem->next;
+		bpf_free_verifier_state(env, &elem->st, false);
+		kfree(elem);
+	}
+}
+
 /* Process the current state until it gets to the start of a basic block. */
 static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
@@ -20766,14 +20808,14 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		struct bpf_insn_aux_data *insn_aux;
 		int err;
 
-		if (bpf_must_abort())
-			return -EINTR;
-
 		/* no insn makes as many ids as there are from here to BPF_INHERITED_ID */
 		if (env->id_gen >= BPF_MAX_ID) {
 			verbose(env, "too many ids\n");
 			return -E2BIG;
 		}
+		err = bpf_check_limits(env);
+		if (err)
+			return err;
 
 		env->prev_insn_idx = prev_insn_idx;
 		if (env->insn_idx >= insn_cnt) {
@@ -20910,7 +20952,7 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 process_bpf_exit:
 			account_current_path(env);
 			mark_verifier_state_scratched(env);
-			bpf_free_verifier_state(state, false);
+			bpf_free_verifier_state(env, state, false);
 			memset(state, 0, sizeof(*state));
 			return flow_drain(env);
 		}
@@ -22034,15 +22076,9 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 
 static void free_states(struct bpf_verifier_env *env)
 {
-	struct bpf_verifier_stack_elem *elem;
-
-	bpf_free_verifier_state(env->cur_state, true);
+	bpf_free_verifier_state(env, env->cur_state, true);
 	env->cur_state = NULL;
-	while ((elem = env->head)) {
-		env->head = elem->next;
-		bpf_free_verifier_state(&elem->st, false);
-		kfree(elem);
-	}
+	free_pushed_states(env);
 	bpf_flow_reset(env);
 }
 
@@ -24183,6 +24219,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
+	env->max_cost = BPF_MAX_COST >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
+	env->pass_max_cost = U64_MAX;
+	env->max_mem = BPF_MAX_MEM >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
 	env->signature = attr->signature;
 
 	/* user could have requested verbose verifier output
@@ -24231,6 +24270,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto skip_full_check;
+	env->mem = len * sizeof(struct bpf_insn_aux_data);
+	/* the analyses that look at an insn once */
+	bpf_add_cost(env, len, BPF_COST_INSN);
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
 	env->succ = bpf_iarray_realloc(NULL, 2);
-- 
2.55.0

