Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160839;
	b=Q7fVoYiCPnNhKApk7ZSm7fKNBrAW9JIwvMgH3ION5qt6HROCUjjOoBhGmC6GLfyxboi1
	 tucoUI7mU/TtmHB9aMzrFLYGFt/LPOOeGVxaJgdphrr/dlwyPoCj/Dy7SRCzlAkH0jaeG
	 flNWTpm8jkVbwkjfuUw5fuiB+g+6YyLi8QENMT7ORkDMXTD1ZLkzxTO5orbqtnaOqBump
	 37hE2dQB61GCMEgCvxJ6QpiVO4mHabC/9reP1ew+EFxLtGAmNdLZeljmcrQNqZfcGpG9m
	 onOJ0pUipHy9D9ybIidIuXKEt4iDz+DnbjUOToEyeC2GZ8zgkvGuFAVPx9tfK69KGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a4+XMx4BfLqP3tmmH6EQO1ABdOaxbTma8J5q66bRknA=;
	b=E/bntqNcetpAh129A6zi++uNQ0PFcqxyeQrjt74ETaGOHkvvrNGbRWVnXUhxtL8HCq1p
	 D2HbJFq785LcGI6jLY0JGOhhlHTh7DvYF0XyB+aY5zGdYSgOI4p0uIBhIhcyPW/9ilB/a
	 QRPfTMjUb3d3XbErgBYb1ti9dM2MGdYYyZdr3Sas6w5FIgVgqN03Pk6l80yMR21nnz5mR
	 S42r7IvaFOSL6h6kCrDtQXRYb74v8HdJp4zvgo9vqm8jXGvcSc/eXca4FjCaLLocotB0n
	 R95Mm+qZjulzHFetS+g6qoGlnUs6byKLqKZo6MlY1XGH1p6ENxz5+KRotw4f/jC/XpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hn8rb3p8;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643D606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7643D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hn8rb3p8
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f048476ab9so1794255ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160838; x=1795765638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4+XMx4BfLqP3tmmH6EQO1ABdOaxbTma8J5q66bRknA=;
        b=Hn8rb3p8hPbhtZ48GwHNfKYqt+15+fgmHCbIapLSe8WuwcKbEdTdJ6jp6CVRjsVrpu
         5KpHdBnizZYMxWOWsi7vzIWjryZMapwjKnDN/puCoGf9fPKWknDKLeYVU67nNvg641mS
         r5dyNnn5HZpUxSVoo1MaIm0fH7gfCYT+C/2lkTCSXyxekDqcPnH2Vmg/K/1GSTue/N6E
         XGi0G/ZMC44RlAV2yGXqfh1eq+7gFS0x66xiV5pDe5xQsTkKSvMDY4pV7hutkdfDGX5v
         2lBpf5Wc7OFMUxt77dk00YMVq5hbmbarX2N8La57JqIff+KkDq4oBew0FpXageItdoIz
         a6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160838; x=1795765638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4+XMx4BfLqP3tmmH6EQO1ABdOaxbTma8J5q66bRknA=;
        b=vfIa+DQ/znTULCIgYqTiOdjyoXVLRRFD5Kuha0cfBpp4o//JDNwkp2wGWdwvcGh9Yp
         wIU+gQQRXgCir6L4H57ZRwxfgeMVlNVB2DUdrtf3O5x+1wc2itenRmE2rzv0N/BLBOm5
         pvtjGrtIIHq+AYAmDzJP0H0sHp5dbgPjNZ8hVzRazhr6y4thluDjQsXXBFoeTog1l5gV
         P2Z0x9plZ7iFqD4tLXLNeZDwegc8bDgCK5hsoIWZ4AK+BDyDeM655SsjgTfRIqScrpog
         64VLdFyWKoEyIf1NeoyuMvdpdAfAI0p1bmzhiG4i9qNLdwZI6hixI9EJLnnKdyW/FxaK
         Z8FQ==
X-Gm-Message-State: APuU4Z/ru4T0mqiwG82y5ZZjBP1Nuz/hTxIYT8/4zVqNQVyps69YsKaP
	z7qgV/QR854aatSyx0wDMBFV0T4wzLsE7g1X/9lEjIKu+ecoHEMWx7AcW+32hQ==
X-Gm-Gg: AZFdTZdXemRQFIUMEqhqqdc/6vJg2JDJA9JXC3iYrOrxkNkEgxcekb+um5XcX3LzMXV
	9MnPTWiltQrmiXpBH/8uDAzEADLaJE+6qy5NrtRwavQ9ggEqZ3v/Z8o4FNg8NX8KMq6U/0qcm0c
	6nnunNETkt6Gq6hxpm0flnJ7EkLqLYapDLIKBqldoHMcwpP0S88hbLYZ7F2FBAvtLQOGKNPlnwf
	lXuUpXCgagJdi+Ugq6Jx0bgUOM0hepfHOYM79lcg2p9rF9GLsiUf2+jRmQ/HaDbk0X1r+ZGtW6Y
	Z2YTqtWQ1gYG04tU3k6jkDJoHr+Hcv+ql26mdBxVe7ClahO/FEvPOrdJ2cLxOmiODbWLi3xYVlk
	8OumtKZuXlCuljCQcnALIR00HOwGKtcpklNFFNQhgkeZBhoR7NZuAnD1HHvzAYymBbSkTXainv0
	Ea4zwjRueXTT3jxBvRYlOEy4pbaR+O+RsWcK+6xXHrZQcLkZpSAJryQjrqo/ggGAS0sreCrgr8c
	KORHruGQ1lsNgvVXY8Ly1LOAhEs0GMJ8/6d6tzoU3dDQbanVOlWloP4ZA0x50KkLEK1Uya40EdT
	W2uAOeeSD2w7V2VIAJ+j00l07pCkSURKfXuiBXZVj7FkueMixehRCIrkeDkUP2lKgqn+ZkpuvVd
	cusni0w/jUbr6Jixwp/llxDNaOIVpJhIv7TrNaeNPsy4XYpSSrYhtKEtSOmIm/k4WoD72SezNux
	4=
X-Received: by 2002:a17:90b:1c08:b0:3b0:9deb:d990 with SMTP id 98e67ed59e1d1-3b41cafd549mr1948192a91.39.1795160837545;
        Thu, 19 Nov 2026 23:47:17 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm3351208a91.16.2026.11.19.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:47:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 28/49] bpf: Prune or join each state that arrives
Date: Fri, 20 Nov 2026 07:42:00 +0000
Message-ID: <20261120074430.2704488-29-alexei.starovoitov@gmail.com>
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

Add the table of states of the main pass. All states go one way:

              +---------+   next    +-------------------+
        +---->| pending |---------->| check basic block |
        |     +---------+           +---------+---------+
        | new                                 v
        |                           +-------------------+   subsumed
        +---------------------------|    join point     |-----> prune
          joined, or kept apart     +-------------------+

bpf_flow_deliver() cleans the state and updates its loop stack.
flow_prune_or_join() compares it with the states that have the same
join_key:

  if bpf_must_keep_apart()   look at the next state
  if old subsumes new        prune new
  if new subsumes old        free old, but widen in a leftover
  else                       join, and compare the join again

There is no cap on the states at an insn. A list makes n states cost
n * n. So one interval tree sorts all states by the hash of the
join_key, then by the range of one xreg of data_deps, see flow_find().

The hash has kernel addresses, such as the address of a map. If it has
32 bits, two of 2048 states at one insn collide in 1 of 2000 loads, and
that can change the result. So it has 64 bits. The tree has room for
32 bits. A state that collides only there is skipped.

@again is for an insn that is checked once more with a part of the
state: one function of a set, one part of a range. It meets no other
state at that insn, see FLOW_AGAIN. The parts meet at the next insn.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/diagnostics.c     |   5 +
 kernel/bpf/diagnostics.h     |   1 +
 kernel/bpf/flow.c            | 607 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        |  24 +-
 5 files changed, 629 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbffbe9d0a..f153e5e7c28 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1709,6 +1709,9 @@ static inline int bpf_add_cost_and_check(struct bpf_verifier_env *env, u64 cnt,
 int bpf_flow_prepare(struct bpf_verifier_env *env);
 void bpf_flow_reset(struct bpf_verifier_env *env);
 void bpf_flow_free(struct bpf_verifier_env *env);
+bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx);
+int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		     int insn_idx, int prev_insn_idx, bool again);
 int bpf_flow_call(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		  struct bpf_verifier_state *entry, int subprog, int call_idx);
 int bpf_flow_exit(struct bpf_verifier_env *env, struct bpf_verifier_state *st, int exit_idx);
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 25d7982327d..2cb9eceb408 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -392,6 +392,11 @@ static u32 log_pos(const struct bpf_diag_log *log, u32 idx)
 	return pos < log->cap ? pos : pos - log->cap;
 }
 
+u64 bpf_diag_event_log_save(struct bpf_verifier_env *env)
+{
+	return env->diag ? log_end(&env->diag->log) : 0;
+}
+
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
 {
 	struct bpf_diag *diag = env->diag;
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index f6380137e9a..cb255218c41 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -53,6 +53,7 @@ const char *bpf_diag_fmt(struct bpf_verifier_env *env, const char *fmt, ...) __p
 const char *bpf_diag_fmt_btf_type(struct bpf_verifier_env *env, const struct btf *btf, u32 type_id);
 const char *bpf_diag_reg_type_plain(struct bpf_verifier_env *env, enum bpf_reg_type type);
 const char *bpf_diag_arg_type_plain(enum bpf_arg_type type);
+u64 bpf_diag_event_log_save(struct bpf_verifier_env *env);
 void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos);
 u32 bpf_diag_irq_depth(const struct bpf_verifier_state *state);
 void bpf_diag_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 0cb56390ffd..9c96f10f3ac 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1,18 +1,125 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The main pass of the verifier. It is a fixpoint over the control flow graph.
+ *
+ *              +---------+   next    +-------------------+
+ *        +---->| pending |---------->| check basic block |
+ *        |     +---------+           +---------+---------+
+ *        | new                                 v
+ *        |                           +-------------------+   subsumed
+ *        +---------------------------|    join point     |------------> prune
+ *          joined, or kept apart     +-------------------+
+ *
+ * A state that arrives is compared with the states that have the same join_key, see
+ * flow_prune_or_join(). The order of pending states completes a loop before the code that
+ * follows it, see flow_compute_order(). The check of a function ends when nothing is pending.
+ *
+ * Loops. The peeled trips are kept apart. The leftover stands for all later trips. A state
+ * that comes back to the header of the leftover is joined and widened.
+ *
+ * Functions. A static function can get only numbers and pointers that are not to the stack.
+ * Then it is verified on its own: once for each instance, not for each chain of calls.
+ * The call waits, see bpf_flow_call().
+ */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
-#include <linux/jhash.h>
+#include <linux/interval_tree_generic.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
+enum flow_kind {
+	FLOW_AT,		/* before the insn */
+	FLOW_AGAIN,		/* the same, it meets no state */
+	FLOW_LEFTOVER,		/* about to start the leftover of the loop */
+	FLOW_PEELED,		/* started an earlier peeled trip, see flow_prune_peeled() */
+	FLOW_FUNC_ENTRY,	/* starts an instance */
+	FLOW_JOINED_CALLS,	/* the same, for all numbers, see flow_may_add_instance() */
+	FLOW_FUNC_EXIT,		/* came out of an instance */
+};
+
+struct flow_state {
+	struct bpf_verifier_state st;
+	struct rb_node tree_node;	/* see flow_find() */
+	u64 hash, first, last, subtree_last;
+	/* in a list of its instance, or in waiting_calls of @callee */
+	struct list_head node;
+	struct flow_instance *started_instance;	/* FLOW_FUNC_ENTRY */
+	struct flow_instance *callee;	/* of a call */
+	struct rb_node rb;		/* pending states */
+	int prev_insn_idx;
+	u64 log_pos, diag_pos;		/* the logs have the path up to there */
+	u32 seq;
+	u32 join_key_id;		/* states with one id have the same join_key */
+	enum flow_kind kind;
+	bool pending;
+	bool late_exit_reaches;		/* a late exit state can get to it */
+	/* it is kept until the states leave this loop, see flow_loop_is_left() */
+	u8 kept_frameno, kept_depth;
+	/* the order of pending states, see flow_set_pending() */
+	u64 priority;
+	u8 order_len;
+	u32 order[MAX_CALL_FRAMES];
+};
+
+#define FLOW_FIRST(s)	((s)->first)
+#define FLOW_LAST(s)	((s)->last)
+INTERVAL_TREE_DEFINE(struct flow_state, tree_node, u64, subtree_last, FLOW_FIRST, FLOW_LAST, static,
+		     flow_tree)
+
+/* One check of a function: its entry state, its exit states and the calls that get them */
+struct flow_instance {
+	u32 id;
+	u64 priority;			/* 0 until a call waits for it, see flow_set_pending() */
+	struct flow_state *entry_state;	/* NULL after the start: it does not change any more */
+	u32 pending_cnt;		/* states */
+	/* calls from this instance that can get more exit states, and those that call itself */
+	u32 open_call_cnt, self_call_cnt;
+	u64 *cost;			/* of its function, see flow_may_add_instance() */
+	bool in_peeled_trip;		/* a call of it, or of a caller, is in a peeled trip */
+	bool ended;			/* see flow_end_instance() */
+	struct flow_instance *next;
+	struct list_head waiting_calls;	/* calls of this instance */
+	struct list_head exit_states;	/* these go to @waiting_calls */
+	struct list_head done;		/* see flow_keep() */
+};
+
+#define INSTANCE_BYTES	(sizeof(struct flow_instance) + 2 * sizeof(void *))
+
 struct flow_kept {
 	struct list_head node;
 	struct bpf_verifier_state st;
 };
 
+struct bpf_flow {
+	/* computed once */
+	u32 *pos;			/* position of the insn in the order */
+	u32 *rank;			/* callers go first */
+	unsigned long *bb_starts;	/* insn starts a basic block */
+	unsigned long *join_points;	/* more than one edge leads to the insn */
+	struct bpf_loop call_loop;	/* from the exit of a function to its next call */
+
+	/* of the pass */
+	u64 *cost;			/* per function */
+	u64 budget, charged_cost;
+	u32 budget_func_cnt;
+
+	/* of the check */
+	struct rb_root_cached state_tree;
+	u32 *nr_states;				/* per insn */
+	struct rb_root_cached pending;
+	struct flow_instance **instances;	/* bpf_verifier_state.instance_id is the index */
+	u32 instance_cnt, instance_cap;
+	struct flow_instance *last_instance;	/* of the last pending state */
+	u64 priority_gen;
+	u32 seq;
+	u32 live_states;
+};
+
 /*
  * The order. Reverse post order is a topological order of the graph without
  * back edges, but it may put what follows a loop between the insns of
@@ -298,6 +405,19 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env)
 	return err ?: ret;
 }
 
+static bool flow_may_load_pkt_end(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	struct bpf_insn_access_aux info = { .reg_type = SCALAR_VALUE };
+	bool tstamp = env->prog->tstamp_type_access, valid;
+
+	valid = env->subprog_cnt > 1 && insn->src_reg != BPF_REG_FP && env->ops->is_valid_access &&
+		env->ops->is_valid_access(insn->off, bpf_size_to_bytes(BPF_SIZE(insn->code)),
+					  BPF_READ, env->prog, &info);
+	/* it notes what the prog reads, and this is a question */
+	env->prog->tstamp_type_access = tstamp;
+	return valid && info.reg_type == PTR_TO_PACKET_END;
+}
+
 int bpf_check_limits(struct bpf_verifier_env *env)
 {
 	env->aborted |= bpf_must_abort();
@@ -330,3 +450,488 @@ static struct bpf_loop *flow_new_call_loop(struct bpf_verifier_env *env, enum bp
 			 env->subprog_info[func + 1].start - env->subprog_info[func].start;
 	return loop;
 }
+
+int bpf_flow_prepare(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int len = env->prog->len, i, s, err = 0;
+	struct bpf_iarray *succ;
+	struct bpf_flow *flow;
+	unsigned long *pred;
+
+	flow = kzalloc_obj(*flow, BPF_VERIFIER_GFP);
+	if (!flow)
+		return -ENOMEM;
+	env->flow = flow;
+	flow->state_tree = flow->pending = RB_ROOT_CACHED;
+	flow->call_loop.kind = BPF_LOOP_RECURSION;
+
+	flow->pos = kvcalloc(2 * len, sizeof(u32), BPF_VERIFIER_GFP);
+	flow->rank = kvcalloc(env->subprog_cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
+	flow->cost = kvcalloc(env->subprog_cnt, sizeof(u64), BPF_VERIFIER_GFP);
+	flow->bb_starts = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	flow->join_points = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	flow->nr_states = kvcalloc(len, sizeof(u32), BPF_VERIFIER_GFP);
+	pred = kvcalloc(BITS_TO_LONGS(len), sizeof(long), BPF_VERIFIER_GFP);
+	if (!flow->pos || !flow->rank || !flow->cost || !flow->bb_starts || !flow->join_points ||
+	    !flow->nr_states || !flow->groups || !pred) {
+		kvfree(pred);
+		return -ENOMEM;
+	}
+
+	/* subprog_topo_order[] has callees first */
+	for (i = 0; i < env->subprog_cnt; i++)
+		flow->rank[env->subprog_topo_order[i]] = env->subprog_cnt - i;
+
+	for (i = 0; i < len; i++) {
+		succ = bpf_insn_successors(env, i);
+		iarray_for_each(s, succ) {
+			if (__test_and_set_bit(s, pred))
+				__set_bit(s, flow->join_points);
+			if (aux[i].bb_end)
+				__set_bit(s, flow->bb_starts);
+		}
+		if (bpf_is_throw_kfunc(&insns[i]) && i + 1 < len)
+			__set_bit(i + 1, flow->bb_starts);
+		/* where the callees come back to */
+		if ((bpf_pseudo_call(&insns[i]) || bpf_is_callx(&insns[i])) && i + 1 < len)
+			__set_bit(i + 1, flow->join_points);
+		if (aux[i].calls_callback) {
+			aux[i].callback_loop = flow_new_call_loop(env, BPF_LOOP_CALLBACK, i,
+								  bpf_insn_callee(env, i));
+			err = aux[i].callback_loop ? err : -ENOMEM;
+		}
+		if (aux[i].calls_callback || aux[i].loop)
+			__set_bit(i, flow->join_points);
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+		/* a guess: the base register can point to something else than ctx */
+		if (BPF_CLASS(insns[i].code) == BPF_LDX && flow_may_load_pkt_end(env, &insns[i]))
+			bpf_find_containing_subprog(env, i)->loads_pkt_end = true;
+	}
+	for (s = 0; s < env->subprog_cnt; s++, sub++) {
+		i = sub->start;
+		__set_bit(i, flow->join_points);
+		if (!sub->cycle || err)
+			continue;
+		if (sub->cycle != s) {
+			aux[env->subprog_info[sub->cycle].start].recursion_loop->nr_insns +=
+				sub[1].start - i;
+			continue;
+		}
+		aux[i].recursion_loop = flow_new_call_loop(env, BPF_LOOP_RECURSION, i, s);
+		err = aux[i].recursion_loop ? 0 : -ENOMEM;
+	}
+	bitmap_or(flow->bb_starts, flow->bb_starts, flow->join_points, len);
+	kvfree(pred);
+	return err ?: flow_compute_order(env, flow);
+}
+
+static struct flow_state *flow_new_state(struct bpf_verifier_env *env, int prev_insn_idx)
+{
+	struct flow_state *s = kzalloc_obj(*s, BPF_VERIFIER_GFP);
+	struct bpf_flow *flow = env->flow;
+
+	if (!s)
+		return NULL;
+	RB_CLEAR_NODE(&s->tree_node);
+	INIT_LIST_HEAD(&s->node);
+	s->prev_insn_idx = prev_insn_idx;
+	s->seq = ++flow->seq;
+	s->log_pos = env->log.end_pos;
+	s->diag_pos = bpf_diag_event_log_save(env);
+	bpf_add_cost(env, 1, BPF_COST_STATE);
+	env->total_states++;
+	flow->live_states++;
+	env->peak_states = max(env->peak_states, flow->live_states);
+	return s;
+}
+
+static struct flow_instance *flow_state_instance(struct bpf_flow *flow, const struct flow_state *s)
+{
+	return s->started_instance ?: flow->instances[s->st.instance_id];
+}
+
+static void flow_clear_pending(struct bpf_flow *flow, struct flow_state *s)
+{
+	if (!s->pending)
+		return;
+	rb_erase_cached(&s->rb, &flow->pending);
+	flow_state_instance(flow, s)->pending_cnt--;
+	s->pending = false;
+}
+
+static void flow_unlink(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	struct flow_instance *instance;
+
+	flow_clear_pending(env->flow, s);
+	if (s->callee || !RB_EMPTY_NODE(&s->tree_node))
+		env->flow->nr_states[s->st.insn_idx]--;
+	if (s->callee) {
+		instance = flow_state_instance(env->flow, s);
+		instance->open_call_cnt--;
+		instance->self_call_cnt -= instance == s->callee;
+		s->callee = NULL;
+	}
+	if (!RB_EMPTY_NODE(&s->tree_node))
+		flow_tree_remove(s, &env->flow->state_tree);
+	RB_CLEAR_NODE(&s->tree_node);
+	list_del_init(&s->node);
+}
+
+static void flow_free_state(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	flow_unlink(env, s);
+	bpf_free_verifier_state(env, &s->st, false);
+	kfree(s);
+	env->flow->live_states--;
+}
+
+static void flow_free_list(struct bpf_verifier_env *env, struct list_head *list)
+{
+	struct flow_state *s, *sn;
+
+	list_for_each_entry_safe(s, sn, list, node)
+		flow_free_state(env, s);
+}
+
+/* What a check leaves behind. */
+void bpf_flow_reset(struct bpf_verifier_env *env)
+{
+	struct bpf_flow *flow = env->flow;
+	struct rb_node *n;
+	int i;
+
+	if (!flow)
+		return;
+	while ((n = rb_first_cached(&flow->state_tree)))
+		flow_free_state(env, rb_entry(n, struct flow_state, tree_node));
+	for (i = 0; i < flow->instance_cnt; i++)
+		flow_free_list(env, &flow->instances[i]->waiting_calls);
+	for (i = 0; i < flow->instance_cnt; i++) {
+		flow->instances[i]->group->instances = NULL;
+		kfree(flow->instances[i]);
+	env->mem -= flow->instance_cnt * INSTANCE_BYTES;
+	flow->instance_cnt = 0;
+	flow->last_instance = NULL;
+}
+
+void bpf_flow_free(struct bpf_verifier_env *env)
+{
+	struct bpf_flow *flow = env->flow;
+
+	if (!flow)
+		return;
+	bpf_flow_reset(env);
+	kvfree(flow->pos);
+	kvfree(flow->rank);
+	kvfree(flow->cost);
+	kvfree(flow->bb_starts);
+	kvfree(flow->join_points);
+	kvfree(flow->nr_states);
+	kvfree(flow->instances);
+	kfree(flow);
+	env->flow = NULL;
+}
+
+bool bpf_flow_is_bb_start(struct bpf_verifier_env *env, int insn_idx)
+{
+	return test_bit(insn_idx, env->flow->bb_starts);
+}
+
+/*
+ * States meet only if they have the same hash. The tree sorts them by a half of the hash,
+ * then by the range of one xreg of data_deps. Two ranges with a gap stay apart, but not where
+ * states come around a loop. Two constants, such as 0 and 3, can miss their join.
+ * Returns the first state near @s.
+ */
+static struct flow_state *flow_find(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[s->st.insn_idx];
+	struct loop_stack_entry *e = bpf_top_loop(s->st.frame[0]);
+	u32 first = 0, last = U32_MAX;
+	u64 hash;
+
+	hash = bpf_hash_apart_xregs(env, &s->st, bpf_hash_join_key(env, &s->st) + s->kind,
+				    s->kind == FLOW_PEELED);
+	if (s->kind == FLOW_FUNC_ENTRY && (!e || e->peeled))
+		hash = bpf_hash_args(env, &s->st, hash);
+	if (s->kind == FLOW_AT ? !aux->loop && !aux->callback_loop :
+	    s->kind == FLOW_FUNC_EXIT && !e)
+		bpf_range_of_data_dep(env, &s->st, &first, &last);
+	bpf_add_cost(env, bpf_xreg_cnt(&s->st), BPF_COST_COPY);
+	s->join_key_id = ++env->flow->seq;
+	s->hash = hash;
+	s->first = hash << 32 | first;
+	s->last = hash << 32 | last;
+	return flow_tree_iter_first(&env->flow->state_tree, s->first, s->last);
+}
+
+#define flow_for_each_near(env, s, t, tn)						\
+	for (t = flow_find(env, s);							\
+	     t && (tn = flow_tree_iter_next(t, (s)->first, (s)->last), true); t = tn)
+
+static struct flow_instance *flow_new_instance(struct bpf_verifier_env *env,
+					       struct flow_state *entry)
+{
+	struct bpf_flow *flow = env->flow;
+	struct flow_instance **instances, *instance;
+	u32 cap;
+
+	if (flow->instance_cnt == flow->instance_cap) {
+		cap = 2 * flow->instance_cap + 2;
+		instances = kvrealloc(flow->instances, cap * sizeof(*instances), BPF_VERIFIER_GFP);
+		if (!instances)
+			return NULL;
+		flow->instances = instances;
+		flow->instance_cap = cap;
+	}
+	instance = kzalloc_obj(*instance, BPF_VERIFIER_GFP);
+	if (!instance)
+		return NULL;
+	INIT_LIST_HEAD(&instance->waiting_calls);
+	INIT_LIST_HEAD(&instance->exit_states);
+	INIT_LIST_HEAD(&instance->done);
+	instance->entry_state = entry;
+	env->mem += INSTANCE_BYTES;
+	instance->id = flow->instance_cnt++;
+	flow->instances[instance->id] = instance;
+	return instance;
+}
+
+static bool flow_same_join_key(struct bpf_verifier_env *env, const struct flow_state *t,
+			       struct flow_state *s)
+{
+	/* The tree has a half of the hash. A collision there is random and costs nothing. */
+	if (t->hash != s->hash)
+		return false;
+	if (t->join_key_id == s->join_key_id)
+		return true;
+	bpf_add_cost(env, bpf_xreg_cnt(&t->st) + t->st.acquired_refs, BPF_COST_COPY);
+	if (t->kind != s->kind || t->st.insn_idx != s->st.insn_idx ||
+	    !bpf_same_join_key(&t->st, &s->st))
+		return false;
+	s->join_key_id = t->join_key_id;
+	return true;
+}
+
+/* After flow_find(), unless @s is a call */
+static void flow_insert(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	u32 *nr = &env->flow->nr_states[s->st.insn_idx];
+
+	bpf_charge_state(env, &s->st);
+	if (s->callee)
+		list_add_tail(&s->node, &s->callee->waiting_calls);
+	else
+		flow_tree_insert(s, &env->flow->state_tree);
+	if (s->kind == FLOW_FUNC_EXIT)
+		list_add_tail(&s->node, &env->flow->instances[s->st.instance_id]->exit_states);
+	env->max_states_per_insn = max(env->max_states_per_insn, ++*nr);
+}
+
+static void flow_link(struct bpf_verifier_env *env, struct flow_state *s)
+{
+	flow_insert(env, s);
+	flow_set_pending(env, s);
+}
+
+/* The entry of @loop in the top frame of @st */
+static struct loop_stack_entry *flow_loop_entry(const struct bpf_verifier_state *st,
+						const struct bpf_loop *loop)
+{
+	struct bpf_func_state *frame = st->frame[st->curframe];
+	u32 i = frame->loop_stack_cnt;
+
+	while (frame->loop_stack[--i].loop != loop)
+		;
+	return &frame->loop_stack[i];
+}
+
+/*
+ * @s came around @loop and arrives at @t. Does @s come from @t?
+ *	ret = 0; if (...) { denied++; ret = -EPERM; }
+ *	bpf_for(i, 0, n) { ... } return ret;
+ * Two states enter the loop. What comes around with 0 is for the state with 0. Next to -EPERM
+ * it looks like a number that grew.
+ */
+static bool flow_same_entry(struct bpf_loop *loop, const struct flow_state *t,
+			    const struct flow_state *s)
+{
+	return s->kind == FLOW_FUNC_EXIT ||
+	       flow_loop_entry(&t->st, loop)->entry_id == flow_loop_entry(&s->st, loop)->entry_id;
+}
+
+/*
+ * All states arrive here. @s is
+ * - pruned, if a state subsumes it,
+ * - joined with a state, unless the join rule keeps them apart,
+ * - pending otherwise.
+ * @loop: @s came around it, or @enters its leftover.
+ */
+static int flow_prune_or_join(struct bpf_verifier_env *env, struct flow_state *s,
+			      struct bpf_loop *loop, bool enters)
+{
+	bool log = (env->log.level & BPF_LOG_LEVEL2) && s->kind == FLOW_AT, widen, subsumed;
+	int insn_idx = s->st.insn_idx, prev = s->prev_insn_idx, err = 0;
+	struct loop_stack_entry *e;
+	struct flow_state *t, *tn;
+	bool joined = false, widened = false;
+	struct bpf_loop *leftover_loop;
+
+again:
+	err = err ?: bpf_check_limits(env);
+	if (err)
+		goto free;
+
+	flow_for_each_near(env, s, t, tn) {
+		if (!flow_same_join_key(env, t, s))
+			continue;
+		/* an exit state can get into the function again */
+		leftover_loop = s->kind == FLOW_FUNC_EXIT && t->pending ? NULL : loop;
+		e = leftover_loop ? flow_loop_entry(&s->st, leftover_loop) : NULL;
+		if (bpf_must_keep_apart(env, &t->st, &s->st,
+					e && flow_same_entry(leftover_loop, t, s) ?
+					BPF_JOIN_POINT_HEADER : BPF_JOIN_POINT, e))
+			continue;
+		if (e && e->peeled)
+			leftover_loop = NULL;
+		subsumed = bpf_state_subsumes(env, &t->st, &s->st);
+		if (!subsumed && t->st.speculative != s->st.speculative)
+			continue;
+		if (subsumed) {
+			if (env->log.level & BPF_LOG_LEVEL2)
+				verbose(env, "from %d to %d: pruned\n", prev, insn_idx);
+			err = flow_check_trip_counts(env, t, s);
+			goto free;
+		}
+		/* what grows in a loop is widened, it is not replaced */
+		if (!leftover_loop && bpf_state_subsumes(env, &s->st, &t->st)) {
+			err = flow_check_trip_counts(env, s, t);
+			if (err)
+				goto free;
+			/* it goes on with the leftover that @t started */
+			if (s->kind == FLOW_LEFTOVER)
+				bpf_top_loop(s->st.frame[s->st.curframe])->entry_id =
+				bpf_top_loop(t->st.frame[t->st.curframe])->entry_id;
+			flow_free_state(env, t);
+			joined = true;
+			continue;
+		}
+		joined = true;
+		widened = leftover_loop;
+		widen = !t->pending && !enters;
+		flow_unlink(env, t);
+		err = bpf_states_join(env, &t->st, &s->st, leftover_loop, widen);
+		swap(s->st, t->st);
+		s->st.last_insn_idx = prev;
+		flow_free_state(env, t);
+		/* another state can subsume the join, or have a join with it */
+		goto again;
+	}
+
+	/*
+	 * The state is printed when its turn comes. That says enough about a state that
+	 * is new, and about a state that goes on to the next insn.
+	 */
+	if (prev >= 0 && insn_idx == prev + 1 + bpf_is_ldimm64(&env->prog->insnsi[prev]) &&
+	    !widened)
+		joined = false;
+	if (log && joined)
+		verbose(env, "from %d to %d: %s\n", prev, insn_idx, widened ? "widened" : "joined");
+	flow_link(env, s);
+	return 0;
+free:
+	flow_free_state(env, s);
+	return err;
+}
+
+/* @s is taken. @starts_leftover: the states of FLOW_LEFTOVER are joined, start the leftover */
+static int flow_add(struct bpf_verifier_env *env, struct flow_state *s, bool starts_leftover)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	int cur_idx = env->insn_idx, err;
+	struct bpf_loop *loop = NULL;
+	u32 id_gen = env->id_gen;
+	bool leftover = false;
+
+	env->cur_state = &s->st;
+	env->insn_idx = s->st.insn_idx;
+	s->kind = FLOW_AT;
+	err = starts_leftover ? bpf_flow_start_leftover(env) :
+	      bpf_flow_loop_enter(env, &loop, &leftover);
+	env->cur_state = cur;
+	env->insn_idx = cur_idx;
+	if (err < 0)
+		err = bpf_flow_edge_unproven(env, &s->st, s->st.insn_idx, err);
+	/* a pointer to the packet that moves in the loop got an id */
+	if (!err && env->id_gen != id_gen)
+		err = bpf_renumber_ids(env, &s->st);
+	if (!err && env->path_sensitive) {
+		if (test_bit(s->st.insn_idx, env->flow->join_points))
+			err = bpf_failing_path_was_here(env, &s->st);
+	} else if (!err && loop && flow_loop_entry(&s->st, loop)->peeled) {
+		err = flow_prune_peeled(env, s, loop);
+	}
+	if (err) {
+		flow_free_state(env, s);
+		return min(err, 0);
+	}
+	if (env->path_sensitive) {
+		flow_link(env, s);
+		return 0;
+	}
+	if (leftover)
+		s->kind = FLOW_LEFTOVER;
+	if (starts_leftover)
+		loop = env->insn_aux_data[s->st.insn_idx].loop;
+	return flow_prune_or_join(env, s, loop, starts_leftover);
+}
+
+/*
+ * @st gets to @insn_idx. The flow takes what it has and leaves @st empty.
+ * @again: the insn is checked again, for a part of the values. There is no join.
+ */
+int bpf_flow_deliver(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+		     int insn_idx, int prev_insn_idx, bool again)
+{
+	struct flow_state *s;
+	int err;
+
+	if (insn_idx < 0 || insn_idx >= env->prog->len) {
+		verbose(env, "invalid insn idx %d insn_cnt %d\n", insn_idx, env->prog->len);
+		return -EFAULT;
+	}
+
+	/* the check starts */
+	if (!env->flow->instance_cnt && !flow_new_instance(env, NULL))
+		return -ENOMEM;
+	s = flow_new_state(env, prev_insn_idx);
+	if (!s)
+		return -ENOMEM;
+	s->st = *st;
+	memset(st, 0, sizeof(*st));
+	s->st.insn_idx = insn_idx;
+	s->st.last_insn_idx = prev_insn_idx;
+
+	if (env->path_sensitive && (s->st.infeasible || s->st.speculative ||
+				    bpf_failing_path_hops(env, &s->st) == U32_MAX)) {
+		flow_free_state(env, s);
+		return 0;
+	}
+	err = bpf_clean_verifier_state(env, &s->st);
+	if (err) {
+		flow_free_state(env, s);
+		return err;
+	}
+	if (again) {
+		s->kind = FLOW_AGAIN;
+		flow_find(env, s);
+		flow_link(env, s);
+		return 0;
+	}
+	return flow_add(env, s, false);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d4c52c59c7..710c3113e61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -196,7 +196,6 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_state st;
 	int insn_idx;
 	int prev_insn_idx;
-	/* it goes there only if may_goto in front of prev_insn_idx does, see check_loop_guard() */
 	enum bpf_guard_edge guard_edge;
 	bool again;	/* see bpf_flow_deliver() */
 	struct bpf_verifier_stack_elem *next;
@@ -11949,6 +11948,7 @@ static int split_func_set(struct bpf_verifier_env *env, int regno)
 		branch = push_stack(env, env->insn_idx, env->insn_idx, false);
 		if (IS_ERR(branch))
 			return PTR_ERR(branch);
+		env->head->again = true;
 	}
 	return 0;
 }
@@ -11974,6 +11974,7 @@ static int check_func_callx_set(struct bpf_verifier_env *env, int regno, int *in
 			branch = push_stack(env, *insn_idx, *insn_idx, false);
 			if (IS_ERR(branch))
 				return PTR_ERR(branch);
+			env->head->again = true;
 			continue;
 		}
 		copy = kzalloc_obj(*copy, BPF_VERIFIER_GFP);
@@ -21221,12 +21222,9 @@ static int flow_drain(struct bpf_verifier_env *env)
 
 	while ((elem = env->head)) {
 		env->head = elem->next;
-		if (!err && elem->guard_edge)
-			err = bpf_flow_guard_edge(env, &elem->st, elem->insn_idx,
-						  elem->prev_insn_idx, elem->guard_edge);
-		else if (!err)
+		if (!err)
 			err = bpf_flow_deliver(env, &elem->st, elem->insn_idx,
-					       elem->prev_insn_idx);
+					       elem->prev_insn_idx, elem->again);
 		bpf_free_verifier_state(env, &elem->st, false);
 		kfree(elem);
 	}
@@ -21388,11 +21386,14 @@ static void free_pushed_states(struct bpf_verifier_env *env)
 static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_verifier_stack_elem *elem;
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = true, from_unproven;
+	bool again = prev_insn_idx == env->insn_idx;
 	u32 held;
 
+	mark_verifier_state_scratched(env);
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
@@ -21556,20 +21557,23 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		    bpf_is_mem_insn(insn) && BPF_MODE(insn->code) == BPF_MEM) {
 process_bpf_exit:
 			account_current_path(env);
-			mark_verifier_state_scratched(env);
 			bpf_free_verifier_state(env, state, false);
 			memset(state, 0, sizeof(*state));
 			return flow_drain(env);
 		}
 
+		/* if the insn pushed a part, the current state is a part too */
+		for (elem = env->head; elem; elem = elem->next)
+			again |= elem->again;
 		err = flow_drain(env);
 		if (err)
 			return err;
 
-		if (env->insn_idx < insn_cnt && bpf_flow_is_point(env, env->insn_idx)) {
+		/* the parts of a state meet at the next insn */
+		if (env->insn_idx < insn_cnt &&
+		    (again || bpf_flow_is_bb_start(env, env->insn_idx))) {
 			account_current_path(env);
-			mark_verifier_state_scratched(env);
-			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx);
+			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx, false);
 		}
 	}
 }
-- 
2.55.0

