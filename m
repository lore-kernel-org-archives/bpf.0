Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160763;
	b=1m6PH0ILCBoJ/na1hip6cbZxM37o7zNoFG3Ci4A8cxkW4l7Gb6KekA7swStbWqlz/C1G
	 UCBntTFXb2buTEfM0NcdfsXyVsIVNC6u0KJRGakfI8O7TkS0ZrbHhWmNMTFruVafVfe4f
	 gehUHgDis2qeegzO5Z1x9IM7KZnj6xsYq9P/OTG82ZObw0qpBL++6auW5ac1jdieurKdn
	 PEpkFcx5g1/EYmF5A+U/bQl+Ly3g6w5nExt5sd6dK/L1DCv/sXYzxb5cAygIX2NKAGZnJ
	 KMz7HSWzPJbnCfaBsAC7P8bnNP0MBRchcM0KDM4aWKUpu34yaX3swtb+KEncQVDcUrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3nclYKOamF6GAnAirFLkCociBbMw7yq6mYA6JP+S/jM=;
	b=cUydfjqI4q+PC1IH5Z/mTUoLGT2uCedXHEeRlHDH8Zcy42eODstI1CuZKKhdoreaJ/yn
	 SHu0kZwXX5oNjRDNRC0tnrH3QHRQJmaVMQ0VkH4AxrM21Fcsz84m34ngATTM1OB5MoThI
	 jExd6n37BH2lg9MmhP6ImJ5SS6x9Zji/q+HFUFRMD6/jejwOb/iY4PO8zX9BrlvNO6sqP
	 xFea0swMFFApurS95/TeVqn1xYkAUf2cDIK0L5vb0BdRpuSFCsx2/qTHpTDDpnv4+OPXo
	 eLKeToGn+oHOml/SSEtdiEYholfV3xlwZWhEgCTHB853TMIiSuGuhteaYtjVFESqekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7MvsN9Y;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F9606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D96F9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7MvsN9Y
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f04b676219so1036825ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160762; x=1795765562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nclYKOamF6GAnAirFLkCociBbMw7yq6mYA6JP+S/jM=;
        b=p7MvsN9YCI24DTataL2yPrhzjKdJZ6hHN4QeMzw8mwWFafT0nZnk35Sbdrvgs2Re1b
         jzuZd56os54j7Jz2n3/Mff61kRrkQ8X0HjaD22i0aTCbpoDy3hVeBZZLoJ6hwMNKSUd+
         LKkbIMVWTGuXCriMha9yv2b+F4wLuD3HRZ6rzK0BqucSn5H7ZD5F/akD9TuM9wyZZ8bG
         FD4868a5rKNPKuzMwI1KiYBgv1JIxyxUV9IxT44BpIV95idhAXqQBcGLxynS2JcqsEV0
         4/mhn+Lz/LftduVFrStQFYbpjPDvu7aJMbYzFa9dfdMEApZhmgyT0EmEm6oTdoBIQs16
         eDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160762; x=1795765562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3nclYKOamF6GAnAirFLkCociBbMw7yq6mYA6JP+S/jM=;
        b=nl1phylWA4puaEADUSpkoyykAE1t4aTxeQ1xfBpTem6rfwS1+1it3ksistTb7Zvqmo
         bDOL1XDS09n4DHQ942FksJJ9CrLF4M1nanxT/dsZ9v1v4mTBfY2fTFyTwe6YXLwac5f3
         pfCGIU7tes/dCgJdEfrHsaDvxqPpe3paTdstWhzATZjEPdrunj2SpsWmY9afpM5QToLd
         HECCZgSOMqmdGNJoopP1wXfkKbxpKIJWPSQrPnRJP0Aqqdju4ML7nLE8dMHFKA4qQPIp
         aRJGEgbEVJpYDF9/DwBhQT/Y4sC236q7hjspJQNYsq+dyYxJGAetRoJJb7M32TvHm7g/
         /pHQ==
X-Gm-Message-State: APuU4Z/nt1k4eVaHW1G+zSIkzeZ1IkVbshhrYcTYA+PUlaNcOBqqHIDJ
	5KLdTJWwG6jy4GuXS8QbxJwBampQbnSSe3Kt5R/kjT6KDmvf8oxy6AIgVxm2BQ==
X-Gm-Gg: AZFdTZcEawY1GX4vwDLW/h8Nn4CQW+kZgKZkZwev8z3QGjwJFpBLJCBg6qbiHaHJBP9
	R0/MubXHQKq7aPNSMAW0mGaRSvXEU6Y8HLuGPUi8cvPyLi2bPlb166vfduJ5ttWF3sMyrDzro3J
	R8q1glNwXJ9k0YrB+PFyhiiEB0CcmUmuca3dOgnQJZYsQQRTYpXDVk0kfqRhRFZdRpnVvNrknng
	CaLp1FyDRaSTkI2mqp0BVvvsSdxk7yiooQyGebjM95qywJ7F1gkXBVmwjmy9gY4vRQsGzhd75/y
	87Nj13nuI7WL+91HMaeXIVaFfFpz3zPEiantGtt3AfyE6apEmuIdj13j7vg5uOTKBkZHSI+PpDm
	GjCFpNzmckjQHoHHt743Nu6od8HqRibOuGcqc5LwLWl+rfcGnTLeUWq20t4aHHXu/AcYFJCOpRs
	uxihxgJ4ELY3ZeQ9C0KJ/6NYiVRrQ7gR4/00k8GufeuVwgto8ISS5T21O2FTXA9yvJxinq72J5u
	PlDFo2GRJCm3UW+4qdKKv2ET5EobAuILvJvk1KcJQEcVdnXo3cLmfAr0auKdGW85bCSWmXvpjhR
	JGsjeQM94r/vSCB6+8NmZvy205wipC/r/1GvT16ThkVEbLQ9iKnrN4G+JmJfVPC5Kpe0x7u93oa
	It+Q7SsCk8idwReMg/gpFu/tbXpqyXNGZ97af+V6IxHmnh3eHC2isXFbKBEOVhur2y/uh6R7zyH
	YuiaaDA8zTlDrVpUwa1fw=
X-Received: by 2002:a17:90b:4ec4:b0:3ac:7116:434a with SMTP id 98e67ed59e1d1-3b41c900858mr1841495a91.15.1795160761786;
        Thu, 19 Nov 2026 23:46:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm6338417a91.4.2026.11.19.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:46:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 15/49] bpf: Peel the first trips of a loop and join the other trips
Date: Fri, 20 Nov 2026 07:41:47 +0000
Message-ID: <20261120074430.2704488-16-alexei.starovoitov@gmail.com>
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

A loop can be verified trip by trip, or with one state for all trips.
The first way is precise and too long for a long loop. The second way
is short and loses what differs between trips:

  char buf[64]; off = 255; ok = 0;             trip 0 is different
  for (...) { if (ok) buf[off] = 0; off = x & 63; ok = 1; }

Use both. A loop has peeled trips and a leftover:

  entry -> [0] -> [1] -> ... -> [d-1] -> +----------+ <--+
           peeled trips, kept apart      | LEFTOVER |    |
                                         |  widened |----+
                                         +----------+

Pass 0 peels nothing. A later pass peels if an error asks for it, see
try_peel_trip(). bpf_flow_loop_enter() keeps the loop stack of a frame.

The calls of a callback and recursive calls go around like the body of
a loop. One struct bpf_loop describes the three:

  kind                 header
  BPF_LOOP_JUMPS       the target of the back edge
  BPF_LOOP_CALLBACK    the call of the helper
  BPF_LOOP_RECURSION   the start of the first function of the cycle

What is held has no join. A loop that acquires in each trip makes new
states without end. check_held_in_leftover() stops it: a reference that
is in no xreg is a leak, and the peeled trips limit the locks.

The log has the innermost loop. Level 2 has all loops for each block.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  79 ++++++++
 kernel/bpf/fixups.c          |  15 +-
 kernel/bpf/flow.c            |  17 ++
 kernel/bpf/log.c             |  18 +-
 kernel/bpf/loops.c           |   1 +
 kernel/bpf/verifier.c        | 346 ++++++++++++++++++++++++++++++++---
 6 files changed, 444 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cc90e237d53..77f1fe969a2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -93,6 +93,8 @@ struct scalar {
 	 */
 	u16 base;
 	u16 step;
+	/* Not a part of the value: it grew once at a loop header, see join_range() */
+	bool grew_once;
 };
 
 /* The struct scalar that is an anonymous member of *@p */
@@ -420,6 +422,24 @@ static inline u32 bpf_xreg_to_spi(u32 xregno)
 	return xregno - MAX_BPF_EXT_REG;
 }
 
+/*
+ * A state in a loop, see bpf_flow_loop_enter()
+ *
+ * entry -> [0] -> [1] -> ... -> [d-1] -> +----------+ <--+
+ *          peeled trips, kept apart      | LEFTOVER |    |
+ *                                        |  widened |----+
+ *                                        +----------+
+ */
+struct loop_stack_entry {
+	struct bpf_loop *loop;
+	/* How many times the state came back to the header. A join has the larger number. */
+	u32 trip;
+	/* The state that entered the loop. What comes back to the header is for that state. */
+	u32 entry_id;
+	u32 held_cnt;		/* when the state entered the loop */
+	bool peeled;		/* in a peeled trip, not in the leftover */
+};
+
 #define LOOP_STACK_SIZE 16
 
 /* state of the program:
@@ -524,6 +544,11 @@ struct bpf_verifier_state {
 	u32 curframe;
 	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
 	bool infeasible;
+	/* an error only in a leftover, see check_held_in_leftover() */
+	bool holds_too_much;
+	u32 max_held_cnt;	/* when it first held too much */
+	/* the loops that made an xreg of data_deps imprecise, see bpf_loop.suspect_bit */
+	u64 suspect_loops;
 
 	struct_group(held,
 	void *active_lock_ptr;
@@ -754,7 +779,28 @@ struct bpf_backedge {
 	int latch;
 };
 
+/* Calls of a callback and recursive calls go around like the body of a loop does */
+enum bpf_loop_kind {
+	BPF_LOOP_JUMPS,
+	BPF_LOOP_CALLBACK,	/* the header is the call of the helper */
+	/* the header is the first insn of the first function of the cycle */
+	BPF_LOOP_RECURSION,
+};
+
+/* What a pass finds about a loop */
+struct bpf_loop_per_pass {
+	bool has_leftover;	/* the peeled trips were not enough */
+	/* a check failed in a state that the loop kept apart, with no other suspect */
+	bool has_unproven;
+	u32 peeled_cnt;		/* trips that the pass peeled */
+	u64 cost;		/* for the states that the loop keeps apart */
+};
+
 struct bpf_loop {
+	enum bpf_loop_kind kind;
+	u32 header;
+	/* in bpf_verifier_state.suspect_loops. Loops with the same bit are suspects together. */
+	u64 suspect_bit;
 	struct bpf_backedge backedges[MAX_BACKEDGES];
 	int exit_to;		/* where the first edge that leaves the loop goes, or -1 */
 	int backedges_cnt;
@@ -766,8 +812,29 @@ struct bpf_loop {
 	u32 nr_insns;
 	/* not rt_bounded: there are places for may_goto, see guard_to in bpf_insn_aux_data */
 	bool has_guards;
+
+	/* What one pass gives to the next pass */
+	struct_group_tagged(bpf_loop_precision, precision,
+	u32 peel_cnt;		/* trips before the leftover */
+	/* while bpf_loop_per_pass.cost is not above @budget: */
+	u64 budget;
+	u32 max_peel_cnt;	/* peel up to this trip */
+	);
+	bool partitioned;	/* the last partition was for this loop */
+	struct bpf_loop_per_pass this_pass;
 };
 
+static inline bool bpf_loop_has_budget(const struct bpf_loop *loop)
+{
+	return loop->this_pass.cost <= loop->budget;
+}
+
+/* A partition for a loop ends when a state that it kept apart is unproven */
+static inline bool bpf_loop_partition_is_active(const struct bpf_loop *loop)
+{
+	return bpf_loop_has_budget(loop) && !(loop->partitioned && loop->this_pass.has_unproven);
+}
+
 struct bpf_insn_aux_data {
 	/* What a pass writes for the rewrite of the insn. Each pass starts from the snapshot. */
 	struct_group_tagged(bpf_insn_fixups, fixups,
@@ -899,6 +966,8 @@ struct bpf_insn_aux_data {
 	s32 guard_to;
 	/* additional information about the loop if this instruction is a loop header */
 	struct bpf_loop *loop;
+	/* the call of a callback, or the first insn of a recursive function */
+	struct bpf_loop *callback_loop, *recursion_loop;
 };
 
 /*
@@ -995,6 +1064,7 @@ struct bpf_subprog_info {
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u16 arena_stack_depth; /* size of the frame in the stack in arena */
+	u32 cycle; /* the first subprog of its cycle of the call graph, 0 if it is on none */
 	u32 insns_total;
 	u32 insns_self;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
@@ -1539,6 +1609,9 @@ int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, i
 void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h);
 bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env);
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
+/* verifier.c, for flow.c */
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge_loop,
+			bool *starts_leftover);
 #define BPF_EXIT_NEEDS_CALLER	1	/* verify the call in the frames of the caller */
 int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		    const struct bpf_verifier_state *exit, int call_idx);
@@ -2223,6 +2296,12 @@ static inline int pkt_min_len(const struct bpf_reg_state *reg)
 	return reg->r64.size ? reg->pkt_min_len : max(reg->range, reg->pkt_min_len);
 }
 
+/* The loop that the frame is in, or NULL */
+static inline struct loop_stack_entry *bpf_top_loop(const struct bpf_func_state *frame)
+{
+	return frame->loop_stack_cnt ? &frame->loop_stack[frame->loop_stack_cnt - 1] : NULL;
+}
+
 static inline u32 bpf_xreg_cnt(const struct bpf_verifier_state *st)
 {
 	u32 fr, nr = 0;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2bbacd26180..751b25c92c9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -754,6 +754,13 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static void free_loop(struct bpf_loop *loop)
+{
+	if (!loop)
+		return;
+	kvfree(loop);
+}
+
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -762,10 +769,10 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 	int i;
 
 	for (i = start; i < end; i++) {
-		if (aux_data[i].loop) {
-			kvfree(aux_data[i].loop);
-			aux_data[i].loop = NULL;
-		}
+		free_loop(aux_data[i].loop);
+		free_loop(aux_data[i].callback_loop);
+		free_loop(aux_data[i].recursion_loop);
+		aux_data[i].loop = aux_data[i].callback_loop = aux_data[i].recursion_loop = NULL;
 	}
 }
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index cbbc663acac..2c1835d1b3e 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -311,3 +311,20 @@ int bpf_check_limits(struct bpf_verifier_env *env)
 	env->over_limit = true;
 	return -E2BIG;
 }
+
+static struct bpf_loop *flow_new_call_loop(struct bpf_verifier_env *env, enum bpf_loop_kind kind,
+					   int header, int func)
+{
+	struct bpf_loop *loop = kvzalloc_obj(*loop, BPF_VERIFIER_GFP);
+
+	env->mem += sizeof(*loop);
+	if (!loop)
+		return NULL;
+	loop->kind = kind;
+	loop->header = header;
+	/* the helper stops, the function checks the stack, see check_recursion_guard() */
+	loop->rt_bounded = true;
+	loop->nr_insns = func < 0 ? 1 :
+			 env->subprog_info[func + 1].start - env->subprog_info[func].start;
+	return loop;
+}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 0d381e31421..7b1390d9054 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -702,7 +702,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 {
 	const struct bpf_func_state *state = vstate->frame[frameno];
 	const struct bpf_reg_state *reg;
-	int i;
+	int i, first;
 
 	if (state->frameno)
 		verbose(env, " frame%d:", state->frameno);
@@ -789,15 +789,19 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		verbose(env, " cb");
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
-	/* the iterations of the loops in which they are kept apart */
-	for (i = 0; i < state->loop_stack_cnt; i++)
-		if (state->loop_stack[i].apart)
-			verbose(env, " iter(%d)=%u", state->loop_stack[i].loop_id,
+	/* The innermost loop. Level 2 has all loops, once for each block. */
+	first = print_all && (env->log.level & BPF_LOG_LEVEL2) ? 0 :
+		max(state->loop_stack_cnt, 1U) - 1;
+	/* the peeled trips */
+	for (i = first; i < state->loop_stack_cnt; i++)
+		if (state->loop_stack[i].peeled)
+			verbose(env, " iter(%d)=%u", state->loop_stack[i].loop->header,
 				state->loop_stack[i].trip);
 	if (state->loop_stack_cnt) {
 		verbose(env, " loop_stack=");
-		for (i = 0; i < state->loop_stack_cnt; i++)
-			verbose(env, "%s%d", i ? "," : "", state->loop_stack[i].loop_id);
+		for (i = first; i < state->loop_stack_cnt; i++)
+			verbose(env, "%s%d", i > first ? "," : "",
+				state->loop_stack[i].loop->header);
 	}
 	verbose(env, "\n");
 	if (!print_all)
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index e1f39629f60..f8b2f8befa6 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -251,6 +251,7 @@ static int mark_as_header(struct bpf_verifier_env *env, int h)
 		if (!aux[h].loop)
 			return -ENOMEM;
 		env->mem += sizeof(struct bpf_loop);
+		aux[h].loop->header = h;
 	}
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1523ae1be51..e4c9ced59b2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1731,10 +1731,17 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
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
@@ -1777,13 +1784,16 @@ void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
+	leave_loops(dst, 0);
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
 	/* Instruction accounting is path-local, not part of verifier state. */
 	dst->insns_subtotal = 0;
+	dst->loop_stack_cnt = 0;
 	dst->loop_stack = copy_array(dst->loop_stack, src->loop_stack, src->loop_stack_cnt,
 				     sizeof(*src->loop_stack), BPF_VERIFIER_GFP);
 	if (!dst->loop_stack)
 		return -ENOMEM;
+	dst->loop_stack_cnt = src->loop_stack_cnt;
 	return copy_stack_state(dst, src);
 }
 
@@ -1809,6 +1819,8 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 	dst_state->changed_pkt_data = src->changed_pkt_data;
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->infeasible = src->infeasible;
+	dst_state->max_held_cnt = src->max_held_cnt;
+	dst_state->suspect_loops = src->suspect_loops;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
 	dst_state->last_insn_idx = src->last_insn_idx;
@@ -2574,6 +2586,7 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * Initialize it similar to do_check_common().
 	 */
 	elem->st.in_sleepable = is_sleepable;
+	elem->st.suspect_loops = env->cur_state->suspect_loops;
 	frame = kzalloc_obj(*frame, BPF_VERIFIER_GFP);
 	if (!frame)
 		return ERR_PTR(-ENOMEM);
@@ -6019,6 +6032,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 			break;
 		}
 		si[s].recursive = true;
+		j = cg.cycle[s];
+		si[s].cycle = cg.order[j] = min_t(u32, cg.order[j], s);
 		err = 0;
 	}
 out:
@@ -8783,15 +8798,14 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
 }
 
 /*
- * bpf_iter_*_next() that every trip of a loop goes through stops the loop if the iterator is
- * older than the loop: every trip takes an element, and there are only so many. It doesn't stop
- * - the loop that makes the iterator, which starts from the beginning in every trip then:
+ * Every trip of a loop goes through bpf_iter_*_next(). It stops the loop if the iterator is older
+ * than the loop: every trip takes an element, and the number of elements is finite.
+ * It does not stop
+ * - the loop that makes the iterator. The iterator starts again in every trip:
  *	while (v->x) { bpf_for(i, 0, 10) ...; }
- *   Of the loops that the program is in, the ones that it entered before it made the iterator
- *   are among the first iter.loops.
- * - any loop if nothing was left already: the program was told so and did not leave.
- * A loop with a known number of trips doesn't count on the iterator. Nor does a walk on patience:
- * there is none in a loop that is taken for bounded, see flow_try_walk().
+ *   The loops that the program entered before it made the iterator are among the first
+ *   iter.loops loops.
+ * - any loop, if no element was left already. The program knew that and did not leave.
  */
 static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
 			     const struct bpf_reg_state *iter)
@@ -8804,12 +8818,12 @@ static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
 	int i;
 
 	/* the loops of this subprog: flow_is_bound() doesn't look into the functions it calls */
-	for (i = frame->loop_stack_cnt - 1; i >= 0; i--) {
+	for (i = frame->loop_stack_cnt - 1; i >= 0 && !st->speculative; i--) {
 		entry = &frame->loop_stack[i];
 		stops = iter->iter.state != BPF_ITER_STATE_DRAINED && below + i >= iter->iter.loops;
-		if (entry->terminates || stops)
+		if (entry->loop->kind != BPF_LOOP_JUMPS || stops)
 			continue;
-		bpf_flow_next_is_no_bound(env, insn_idx, entry->loop_id);
+		bpf_flow_next_is_no_bound(env, insn_idx, entry->loop->header);
 		return;
 	}
 }
@@ -11311,6 +11325,16 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 	return err;
 }
 
+/* The helper returns */
+static void leave_callback(struct bpf_func_state *caller)
+{
+	struct loop_stack_entry *entry = bpf_top_loop(caller);
+
+	caller->callback_depth = 0;
+	if (entry && entry->loop->kind == BPF_LOOP_CALLBACK)
+		leave_loops(caller, caller->loop_stack_cnt - 1);
+}
+
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			      int insn_idx, int subprog,
 			      set_callee_state_fn set_callee_state_cb)
@@ -11398,7 +11422,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		return err;
 
 	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
-	caller->callback_depth = 0;
+	leave_callback(caller);
 	return 0;
 }
 
@@ -11484,6 +11508,10 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 	return true;
 }
 
+static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_state *callee);
+static int check_held_in_leftover(struct bpf_verifier_env *env,
+				  const struct loop_stack_entry *entry);
+
 static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int insn_idx)
 {
 	u16 live = env->insn_aux_data[env->subprog_info[subprog].start].live_regs_before;
@@ -11497,6 +11525,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 		return -ENOMEM;
 	entry.frame[0] = callee;
 	entry.in_sleepable = state->in_sleepable;
+	entry.suspect_loops = state->suspect_loops;
 	entry.callers_unknown = state->callers_unknown;
 	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
 	/* the frame that says so is not there when the function is verified */
@@ -11504,7 +11533,8 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 		if (live & BIT(i))
 			callee->regs[i] = caller->regs[i];
-	err = grow_stack_arg_slots(env, callee, bpf_in_stack_arg_cnt(&env->subprog_info[subprog]));
+	i = bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
+	err = grow_stack_arg_slots(env, callee, i) ?: enter_recursion(env, callee);
 	if (err) {
 		bpf_free_verifier_state(env, &entry, false);
 		return err;
@@ -11517,6 +11547,7 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 		bpf_free_verifier_state(env, &entry, false);
 		return err;
 	}
+	entry.max_held_cnt = state->max_held_cnt;
 	callee->entry_refs = entry.acquired_refs;
 	callee->entry_rcu_locks = entry.active_rcu_locks;
 	callee->entry_preempt_locks = entry.active_preempt_locks;
@@ -11549,6 +11580,9 @@ static int exit_func_on_its_own(struct bpf_verifier_env *env)
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
 	err = destroy_dynptrs_in_stack_slots(env, callee, 0,
 					     callee->allocated_stack / BPF_REG_SIZE - 1);
+	/* what comes out of a recursion goes around too */
+	if (!err && env->subprog_info[callee->subprogno].recursive)
+		err = check_held_in_leftover(env, callee->loop_stack);
 	if (err)
 		return err;
 
@@ -11596,6 +11630,8 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		return -EINVAL;
 	}
 	caller->unwound = exit->unwound;
+	caller->max_held_cnt = max(caller->max_held_cnt, exit->max_held_cnt);
+	caller->suspect_loops |= exit->suspect_loops;
 
 	/*
 	 * bpf_check_cfg() takes the subprog that loads the address of a function for the
@@ -12959,7 +12995,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 						 set_loop_callback_state);
 		} else {
-			cur_func(env)->callback_depth = 0;
+			leave_callback(cur_func(env));
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame%d bpf_loop iteration limit reached\n",
 					env->cur_state->curframe);
@@ -20607,6 +20643,105 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+static u32 held_cnt(const struct bpf_verifier_state *st)
+{
+	return st->acquired_refs + st->active_rcu_locks + st->active_preempt_locks;
+}
+
+/* The current state enters @loop in @frame. It is in trip 0. */
+static struct loop_stack_entry *push_loop(struct bpf_verifier_env *env,
+					  struct bpf_func_state *frame, struct bpf_loop *loop)
+{
+	u32 cnt = frame->loop_stack_cnt;
+	struct loop_stack_entry *stack;
+
+	stack = krealloc(frame->loop_stack, kmalloc_size_roundup((cnt + 1) * sizeof(*stack)),
+			 BPF_VERIFIER_GFP);
+	if (!stack)
+		return NULL;
+	frame->loop_stack = stack;
+	stack[cnt] = (struct loop_stack_entry){
+		.loop = loop,
+		.held_cnt = held_cnt(env->cur_state),
+		.entry_id = ++env->loop_entry_cnt,
+		.peeled = true,
+	};
+	frame->loop_stack_cnt++;
+	return &frame->loop_stack[cnt];
+}
+
+static bool try_peel_trip(const struct loop_stack_entry *entry)
+{
+	struct bpf_loop *loop = entry->loop;
+
+	if (entry->trip >= loop->peel_cnt &&
+	    (entry->trip >= loop->max_peel_cnt || !bpf_loop_partition_is_active(loop)))
+		return false;
+	loop->this_pass.peeled_cnt = max(loop->this_pass.peeled_cnt, entry->trip + 1);
+	return true;
+}
+
+/* The loop of @entry starts its leftover. Nothing grew in it so far. */
+static void leave_peeled_trips(struct bpf_verifier_env *env, struct loop_stack_entry *entry)
+{
+	struct bpf_func_state *frame;
+	struct bpf_reg_state *reg;
+
+	entry->peeled = false;
+	entry->loop->this_pass.has_leftover = true;
+	bpf_for_each_reg_in_vstate(env->cur_state, frame, reg, reg->grew_once = false);
+}
+
+/*
+ * Push the loop entered at insn_idx onto the stack. Usually this adds a single
+ * entry on top of its enclosing loop. However, an edge may enter an inner loop
+ * directly, bypassing the header(s) of its enclosing loop(s), e.g.:
+ *
+ *   1: for (...):       // enclosing loop, header at 1
+ *   2:   for (...):     // inner loop, header at 2
+ *        ...
+ *   3: if ...:
+ *        goto 2b;       // enters loop 2 without going through header 1
+ *
+ * Such a bypass makes the enclosing loop irreducible, so its header is missing
+ * from the stack and both headers (1) and (2) need to be pushed onto stack.
+ *
+ * Assumes loop_stack_pop() has already truncated the stack to the common ancestor
+ * of the bpf_loop_at_index(env->insn_idx) and whatever was at the top of the loop stack.
+ */
+static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry = bpf_top_loop(frame);
+	u32 missing_headers[LOOP_STACK_SIZE];
+	u32 num_missing = 0;
+	int h;
+
+	/* bpf_compute_loops() checked how deep loops nest */
+	for (h = bpf_loop_at_index(env, env->insn_idx);
+	     h >= 0 && !(entry && entry->loop == aux[h].loop); h = aux[h].loop_header)
+		missing_headers[num_missing++] = h;
+
+	*pushed = num_missing;
+	while (num_missing--) {
+		h = missing_headers[num_missing];
+		/* wherever it is entered: a loop can have more than one entry */
+		if (aux[h].loop->exit_to < 0) {
+			verbose(env, "loop at insn %d never exits\n", h);
+			return -EINVAL;
+		}
+		entry = push_loop(env, frame, aux[h].loop);
+		if (!entry)
+			return -ENOMEM;
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "entering loop %d\n", h);
+		if (h != env->insn_idx && !env->path_sensitive && !try_peel_trip(entry))
+			leave_peeled_trips(env, entry);
+	}
+	return 0;
+}
+
 /*
  * An exit from a loop can cross several nested loops, e.g.:
  *
@@ -20616,13 +20751,15 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
  *            if ...:    // before goto the loop stack is [1, 2, 3 <top>]
  *              goto 1b; // after goto it should become [1]
  */
-static int loop_stack_pop(struct bpf_verifier_env *env)
+static void loop_stack_pop(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_func_state *frame = cur_func(env);
-	int new_cnt = 0;
+	int cnt = frame->loop_stack_cnt, new_cnt;
 	int h, i;
 
+	/* the function stays in its recursion */
+	new_cnt = cnt && frame->loop_stack[0].loop->kind == BPF_LOOP_RECURSION;
 	/*
 	 * Walk the loop nest of insn_idx outwards (innermost first) and stop at
 	 * the first loop that is present on the stack - that loop is the common
@@ -20630,8 +20767,8 @@ static int loop_stack_pop(struct bpf_verifier_env *env)
 	 * stack, drop all loops.
 	 */
 	for (h = bpf_loop_at_index(env, env->insn_idx); h >= 0; h = aux[h].loop_header) {
-		for (i = frame->loop_stack_cnt - 1; i >= 0; i--) {
-			if (frame->loop_stack[i].loop_id == h) {
+		for (i = cnt - 1; i >= 0; i--) {
+			if (frame->loop_stack[i].loop == aux[h].loop) {
 				new_cnt = i + 1;
 				goto pop;
 			}
@@ -20640,12 +20777,179 @@ static int loop_stack_pop(struct bpf_verifier_env *env)
 
 pop:
 	if (env->log.level & BPF_LOG_LEVEL2)
-		for (i = frame->loop_stack_cnt - 1; i >= new_cnt; i--)
-			verbose(env, "exiting loop %d\n", frame->loop_stack[i].loop_id);
-	frame->loop_stack_cnt = new_cnt;
+		for (i = cnt - 1; i >= new_cnt; i--)
+			if (frame->loop_stack[i].loop->kind == BPF_LOOP_JUMPS)
+				verbose(env, "exiting loop %d\n",
+					frame->loop_stack[i].loop->header);
+	leave_loops(frame, new_cnt);
+}
+
+static bool xreg_has_id(struct bpf_verifier_state *st, u32 id)
+{
+	u32 mask = BIT(STACK_SPILL) | BIT(STACK_DYNPTR) | BIT(STACK_ITER) | BIT(STACK_IRQ_FLAG);
+	struct bpf_stack_state *slot;
+	struct bpf_func_state *frame;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate_mask(st, frame, reg, slot, mask, ({
+		if (reg->id == id || reg->parent_id == id)
+			return true;
+	}));
+	return false;
+}
+
+/*
+ * The current state went around a loop. If it holds more than the states at the header, none of
+ * them subsumes it, and it has no join. It goes around again:
+ *	bpf_for(i, 0, n) { if (prev) release(prev); prev = cur; cur = acquire(); }
+ * The number of xregs limits the references: a reference that is in no xreg is a leak. The
+ * number of peeled trips limits the rest. The state continues until it holds more, so it is
+ * unproven where a check fails on a path. Returns 1 if it ends here.
+ */
+static int check_held_in_leftover(struct bpf_verifier_env *env,
+				  const struct loop_stack_entry *entry)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	u32 held = held_cnt(st), i;
+	bool leak = false;
+
+	if (entry->peeled || held <= entry->held_cnt)
+		return 0;
+	/* the callers have xregs for the first ones */
+	for (i = st->frame[0]->entry_refs; i < st->acquired_refs && !leak; i++) {
+		if (st->refs[i].type != REF_TYPE_PTR || st->refs[i].ctx_arg)
+			continue;
+		bpf_add_cost(env, bpf_xreg_cnt(st), BPF_COST_SCAN);
+		leak = !xreg_has_id(st, st->refs[i].id);
+		held--;
+	}
+	if (!leak && held <= entry->held_cnt + entry->loop->this_pass.peeled_cnt)
+		return 0;
+	if (st->speculative)
+		return -EINVAL;
+	verbose(env, "loop at insn %d acquires more than it releases\n", entry->loop->header);
+	env->imprecise |= !env->err;
+	st->suspect_loops |= entry->loop->suspect_bit;
+	st->holds_too_much = true;
+	if (bpf_same_insns_unproven(env))
+		return -EINVAL;
+	note_error(env, -EINVAL);
+	st->holds_too_much = false;
+	st->max_held_cnt = st->max_held_cnt ?: held_cnt(st);
+	return held_cnt(st) > st->max_held_cnt;
+}
+
+/* The current state came back to the header of the loop of @entry. Returns 1 if it ends here. */
+static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entry *entry,
+		     bool *starts_leftover)
+{
+	entry->trip++;
+	if (env->path_sensitive)
+		return failing_path_trip(env, entry);
+	if (!entry->peeled)
+		return check_held_in_leftover(env, entry);
+	*starts_leftover = !bpf_flow_trip_is_new(env, entry) || !try_peel_trip(entry);
+	if (*starts_leftover)
+		entry->entry_id = ++env->loop_entry_cnt;
 	return 0;
 }
 
+/* @callee is the frame of a function that is verified on its own */
+static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_state *callee)
+{
+	u32 cycle = env->subprog_info[callee->subprogno].cycle;
+	struct bpf_loop *loop = env->insn_aux_data[env->subprog_info[cycle].start].recursion_loop;
+	struct loop_stack_entry *entry, *from = env->cur_state->frame[0]->loop_stack;
+	bool starts_leftover;
+	int err = 0;
+
+	if (!loop)
+		return 0;
+	entry = push_loop(env, callee, loop);
+	if (!entry)
+		return -ENOMEM;
+	starts_leftover = !try_peel_trip(entry);
+	if (env->cur_state->frame[0]->loop_stack_cnt && from->loop == loop) {
+		*entry = *from;
+		starts_leftover = false;
+		err = next_trip(env, entry, &starts_leftover);
+	}
+	if (starts_leftover)
+		leave_peeled_trips(env, entry);
+	return err;
+}
+
+/* The helper at env->insn_idx calls the callback again and again. @back: the callback returned. */
+static int enter_callback(struct bpf_verifier_env *env, bool back, struct bpf_loop **backedge_loop)
+{
+	struct bpf_loop *loop = cur_aux(env)->callback_loop;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	bool starts_leftover = false;
+	int err = 0;
+
+	if (!loop)
+		return 0;
+	if (back) {
+		entry = bpf_top_loop(frame);
+		err = next_trip(env, entry, &starts_leftover);
+		*backedge_loop = starts_leftover ? NULL : loop;
+	} else {
+		entry = push_loop(env, frame, loop);
+		if (!entry)
+			return -ENOMEM;
+		if (env->path_sensitive)
+			return failing_path_trip(env, entry);
+		starts_leftover = !try_peel_trip(entry);
+	}
+	if (starts_leftover)
+		leave_peeled_trips(env, entry);
+	return err;
+}
+
+/*
+ * The current state gets to env->insn_idx. Leave the loops that the insn is not in. Enter
+ * the loops that it is in. Returns 1 if the state ends here.
+ * @backedge_loop: the state came back to the header of that loop.
+ * @starts_leftover: see bpf_flow_start_leftover()
+ */
+int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge_loop,
+			bool *starts_leftover)
+{
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	bool pushed;
+	int err;
+
+	/* The callback came back to the helper that calls it, in the same trip. */
+	if (frame->callback_depth)
+		return enter_callback(env, true, backedge_loop);
+
+	loop_stack_pop(env);
+
+	err = loop_stack_push(env, &pushed);
+	if (err)
+		return err;
+
+	entry = bpf_top_loop(frame);
+	if (!entry || entry->loop != cur_aux(env)->loop)
+		return enter_callback(env, false, NULL);
+	if (env->path_sensitive)
+		return (pushed ? failing_path_trip(env, entry) :
+			next_trip(env, entry, starts_leftover)) ?:
+		       enter_callback(env, false, NULL);
+	if (pushed) {
+		*starts_leftover = !try_peel_trip(entry);
+		return *starts_leftover ? 0 : enter_callback(env, false, NULL);
+	}
+
+	*backedge_loop = entry->loop;
+	err = next_trip(env, entry, starts_leftover);
+	if (err || *starts_leftover)
+		return err;
+	return enter_callback(env, false, NULL);
+}
+
 /* Can the main program return 0? */
 static bool zero_is_valid_retval(struct bpf_verifier_env *env)
 {
-- 
2.55.0

