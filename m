Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937115;
	b=NENah9CAaz8oeMHpqYtuXecm0FTeSvr4/s5slxJPDWb7n9TqmfBf/5F2B5nbKPnZcy8m
	 LJwIpSQnR0xveOKeHk9XLv/UngEAjSIofOaeeIQ3UWJMkIZBwR88fSEb1Mp+2iKpB+Q6l
	 +P6XyftjK2XjTITP44pc86AZHUoKPugFHxxW0OHJMPuB1H+xLM01ghZPe+jHpVB5N3O1F
	 iiQuyn6EclQNwLnY54Dq4yXEnvL1xDYq6jlJQdMuBY95L+g/bg9qYePHhHbWn3TygqJrC
	 Wi1hwHtkHXXEdCfU/jvLiAlnxLG879o5JsGvj4gOyMf2N5TORQc3pepru6vy9l9A0FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r5QlFxwtAqkkYJLtKZXocd+o8SMZ+YJnK4iDL5CHg+0=;
	b=DFZnoW2TwQlYpEX1+eQnxUU+ULFuy/6lZ1Zk+i8l0YZOqSQ2Y7hKa6rRn6l6IKvzO3Vz
	 dGThZgeADyu8AzdvpKQ4+ltRox03agk90RpPWKSPpy246hIYG+q24D1TfUpPY1CEJtDov
	 2uY8fM79r5DVLK2ISo1E6TwcrrEGV6k8KeFPz+ya4tQOzEGs+kYebvMRYxmjI+zdVAKmk
	 K2sSQ1ghDAs3XOYZ4KZPlBwi1eWFCMT9WcCwLao/aBwzHGe7z2MsOk0SDZsIk+/JTLd7R
	 ENGnc+7TCNCmuIdCcsHbldwDSuhXn9SaI7UxphLWSfx1WWp9F4ZmGbKFrHjqGibCbfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6Iw1tVE;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFC606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6AFC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6Iw1tVE
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so112894a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937114; x=1794541914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5QlFxwtAqkkYJLtKZXocd+o8SMZ+YJnK4iDL5CHg+0=;
        b=W6Iw1tVE+LHrVGgVtanRPabokACqK4/qvvDRENuOAwlXfQNozM86UZRqJQ59Teddu+
         epa1RDJZYwPilyxXrOGj9OnmRa7AnvluRe37GjcK3RRaT4e3S4WdCIaRxryLpWIv5tzK
         353RiErFRWmDg8sVPN8hNhWAAqlv44HiltOmzt6wQwCDgbKKoOVe8Mr8gWAoEO0QJw6m
         8g+og4H0wqxfhT2sg3Nx9ddN0UeC5oNSco1xE8AfsnJXAA3qEAnO2kv77p6o4BPPZM+5
         nxzF2iJWcx473OE6IiDBTj+9QBhk55aAwatzMJ8EBEhecR4cdKIHOF6Vd+OJtZs+4Ho4
         50og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937114; x=1794541914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5QlFxwtAqkkYJLtKZXocd+o8SMZ+YJnK4iDL5CHg+0=;
        b=MeSPPffp6SVCwsT4FNkfjqyqm+hX7n55Ok7AqRRQ0LCfc9t7hAD/m9DQG7eBrtKf4q
         qNJ6DuVVv0hIDub/zoJF6SP4vz6nLfLQPo1yvMcLrhMggvs/KySlQCMUPvuMyzvWIfRS
         WUrtdYN63mo1hGm8FzjPNn1+n4fRY0K834sipLcEmjdz4GnbOEnA8hNb1cFhJEVdbQRX
         RwRG6mMM+ZQpnC7NE4dWyRlxflUPO0UOFj1amNUNP1EpwFaLyqqxo9lGE/YrRrj5genK
         FQdNEsdRjKIMHlgjhqZZ2VISylZllyrdOS71k6ao03c1vaGnmmZaPNqcu9870lbNLlrX
         6MHg==
X-Gm-Message-State: APuU4Z9bNPpZ1h43IWKOG5djBjyy21bG1TEkGhroFMET7n+t7muvIM4a
	tulh9QP2H4/HVSJO4yc50pCNQrS79yfo9vyqERAKdQ4ysYPWdVm69jweQ971Yg==
X-Gm-Gg: AYBFou2pmE4n4vjo/1s/Y8I6PD2mEkfLMEBsQBDFH+66xzhMPTA2DiUeqXtp3QD5GBv
	VnfVAchifO0TiXxlSagTg/2pM8XAz4MahtQaaJteA3Mz17MGQAjdCfNw+QyPO2orZPaKQ3qeeP4
	b0Q790Klag7J1bQIBGKo6rp/KuUec92srtFgtW9DPNij7/OAlVIfX/O3OJh7hGkrnyk2IGILChi
	p+PszrnCs0taC41mFKVy2hKL5kKNjg+GnDjpPzaEIKhQ/las9zi8t5Dx13Lfh6xHY4u2qFU21wq
	QsG0D0/h6yKF+WzjJMfzTpK1lb6ZuVXVyE0D86G/IOlI5kfRu0m7WoKFe9WAx5L3jflAoT41Eui
	DSbXeCPtSaymWfxYNykhx4AcIg2S3Z4C3LBpV/1BuFYWl/eyxrpTqe1AFmSlfKJ+kXapcxPahBT
	yPYPV6UAsJCbDd2eTH1Bo6l0o0A8fdGk00GzyonvGljXDYvWnNvGi2OaBvrLMBagTz++yzVgGWr
	N+MQixutdPIG+/ucckxnrCID/9yo46vPM0cIj+1H7wn75Meg7q/J1Fn6Gu4VeT1aDhkRv4MH2MD
	Y4PVrqE13gCbuTu/JqdOAPAVlFMOaIsaHXmGWSIuI2vGH9S0VRwE26D0amOZu2Nrc0nZ+sa6mxv
	v5K3cicn4Zf9KF3WExtwvjCvuBw7yddZu1ASb6s90PtHolspZXmmYz1NV+SEmX10tkq6WSY31wg
	==
X-Received: by 2002:a17:90b:57ce:b0:3b0:d070:3c46 with SMTP id 98e67ed59e1d1-3b0db6e04eemr966761a91.12.1793937114147;
        Thu, 05 Nov 2026 19:51:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c66fe1sm1493835a91.7.2026.11.05.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:51:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 07/45] bpf: Add the data structures of the main pass over the control flow graph
Date: Fri,  6 Nov 2026 03:50:31 +0000
Message-ID: <20261106035111.3315285-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

The verifier follows each path of a prog from the entry to exit. It ends a
path early only where an earlier path left a state that covers the current
one. A live value that differs from path to path defeats that. Then the
work grows with the number of paths, not with the size of the prog:

  for b in bytes { h = (h ^ *b as u64).wrapping_mul(0x100000001b3); }

In this FNV hash h is a new number in each iteration, so no state covers
the next one. Branches that set different values do the same to C code.

  insns processed                                     today   this series
  rust-bpf   hash_fnv_bytes                         1000001 *         160
  rust-bpf   scx_qmap/qmap_init_cids                 131088 *         196
  selftests  test_verif_scale3/balancer_ingress      821107         57155
  scx        scx_eevdf/eevdf_dispatch                350041         15199
  Cilium     bpf_host/cil_to_netdev, Oct 2026         64658          7472
  * "BPF program is too large", "The sequence of 8193 jumps is too complex"

flow.c is a new main pass: a data-flow analysis over the control flow
graph that runs to a fixpoint. Where two paths meet, it joins their states
into one state that covers both: r1=1 and r1=5 give r1=[1,5]. At the head
of a loop it widens what grows: h becomes an unknown scalar, and one more
pass over the body ends the loop. A join can lose a fact that a later check
depends on. Thus a basic block has a set of states, not one state:

  a state arrives at a basic block        the verifier
  a state of the set covers it            drops it
  it has a join with a state of the set   replaces that state with the join
  all other cases                         adds it to the set

The verifier verifies a block with each new state of its set and sends the
results to the successors of the block. The pass ends when no set has a new
state. The check of one insn does not change.

Add the head comment, the limits and the data structures:

  struct flow_state   a state in a set, or the state of a call that waits
  struct flow_set     the states at one insn
  struct flow_entry   the calls that wait for a subprog, its exit states
  struct flow_need    what the checks after an insn depend on

The limits are on states and grow with the prog. For a prog of N insns:
1024 at an insn, 16 * N + 4096 at a time, 256 * N + 64K in all.
Nothing builds flow.c until its last function is there.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c | 181 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 kernel/bpf/flow.c

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
new file mode 100644
index 000000000000..01681957855d
--- /dev/null
+++ b/kernel/bpf/flow.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The main pass of the verifier as a fixpoint over the control flow graph.
+ *
+ * Every insn that starts a basic block has a set of states. The state that
+ * arrives there is
+ * - dropped, if it is within a state of the set,
+ * - joined with a state of the set, if there is a join, see bpf_states_join(),
+ *   that doesn't make up what neither of them has, see flow_join_makes_up(),
+ * - added to the set otherwise.
+ * What is new in the set is pending. Pending states are processed in the order
+ * of the program in which a loop is done with before what follows it, see
+ * flow_compute_order(). The pass ends when nothing is pending.
+ *
+ * Loops. The state that enters a loop is made to stand for all iterations with
+ * what scalar evolution knows about the loop, see bpf_flow_loop_enter().
+ * The state that comes back to the loop head is expected to be within it.
+ * If it is not, the two are joined, what grew is forgotten, and the loop is
+ * done again.
+ *
+ * Functions. A static function that gets nothing but numbers and pointers to
+ * what is not the stack is verified on its own, for the states at its entry
+ * and not for every chain of calls. The call waits. What comes out of the
+ * function goes to all calls that wait for the states it comes from.
+ */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/jhash.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+/*
+ * States at an insn that have no join: kinds of values, references, chains of calls.
+ * A state that arrives is compared with those that it may be related to, see flow_may_relate().
+ * At worst that is all of them, and the work is the square of it.
+ */
+#define BPF_FLOW_MAX_STATES	1024
+/*
+ * All states in the sets at a time: that many for every insn of the prog, and some. Not counted:
+ * calls that wait, what came out of a function, the states that loops were entered with.
+ */
+#define BPF_FLOW_LIVE_PER_INSN	16
+#define BPF_FLOW_LIVE_BASE	4096
+/* All states that were ever there. It bounds the work by the size of the prog. */
+#define BPF_FLOW_TOTAL_PER_INSN	256
+#define BPF_FLOW_TOTAL_BASE	65536
+/*
+ * What comes out of a function is joined that many times. Then it is widened, like what
+ * comes back to a loop head: the exit states have to stop changing.
+ */
+#define BPF_FLOW_MAX_JOINS	16
+/* With fewer states at an insn it's faster to compare them than to look at their shapes. */
+#define BPF_FLOW_MIN_SHAPES	8
+/* bpf_loop() with that many iterations at most is walked. */
+#define BPF_FLOW_MAX_CALLBACKS	8
+/* What a callback returns to the helper with is joined that many times before it is widened. */
+#define BPF_FLOW_CALLBACK_JOINS	4
+
+enum flow_cycle {
+	FLOW_NO_CYCLE,
+	/* what grew is forgotten */
+	FLOW_CYCLE,
+	/* after a while. A flag that a callback sets doesn't grow any further. */
+	FLOW_CALLBACK_CYCLE,
+};
+
+/* See flow_may_relate() */
+enum flow_word {
+	FLOW_CHAIN,
+	FLOW_CTX,
+	FLOW_LAYOUT,
+	FLOW_PTRS,
+	FLOW_OFFS,
+	FLOW_SHAPE_WORDS,
+};
+
+struct flow_shape {
+	u32 word[FLOW_SHAPE_WORDS];
+	/* how much of the packet is checked, the sum over the pointers to the packet */
+	u32 pkt_range;
+	/* what comes after FLOW_CTX is computed */
+	bool places;
+};
+
+struct flow_state {
+	struct bpf_verifier_state st;
+	/* states at the insn, see struct flow_set, calls of struct flow_entry */
+	struct list_head node;
+	struct rb_node rb;		/* pending states */
+	int prev_insn_idx;
+	u32 seq;
+	struct flow_shape shape;
+	u16 joins;
+	bool pending;
+	/* the order of pending states, see flow_set_pending() */
+	u8 key_len;
+	u32 key[MAX_CALL_FRAMES + 1];
+};
+
+/* what came out of a function that is verified on its own */
+struct flow_exit {
+	struct list_head node;
+	struct bpf_verifier_state st;
+	u16 joins;
+};
+
+/*
+ * Every call that waits makes an entry of the function: the state at its first insn and what
+ * becomes of it. Entries whose states met are one set: what comes out of the function for one of
+ * them is for the calls of all of them. One entry stands for the set and has its lists.
+ */
+struct flow_entry {
+	struct flow_entry *up;		/* towards the one that stands for the set: up == itself */
+	struct list_head calls;		/* struct flow_state: the calls that wait */
+	struct list_head exits;		/* struct flow_exit: what came out */
+};
+
+struct flow_func {
+	int exit_idx;			/* all exits are compared as if they were here */
+};
+
+/* States at an insn, in the order in which they came. */
+struct flow_set {
+	struct list_head list;
+};
+
+struct flow_united {
+	u32 a, b;
+};
+
+struct flow_kept {
+	struct list_head node;
+	struct bpf_verifier_state st;
+};
+
+/* What the checks ahead of an insn look at, see enum flow_need_kind */
+struct flow_need {
+	u64 slots;			/* of the stack, fp-8 is bit 0 */
+	u16 regs;
+};
+
+/* see flow_compute_need_const() */
+enum flow_need_kind {
+	FLOW_NEED_ARG,
+	FLOW_NEED_STACK_OFF,
+	FLOW_NEED_PTR_OFF,
+	FLOW_NEED_JUMP,
+	FLOW_NEED_VALUE_OFF,
+	FLOW_NEED_BASE,
+	FLOW_NEED_JUMP_ALU,
+	FLOW_NEED_KINDS,
+};
+
+struct bpf_flow {
+	/* computed once */
+	u32 len;			/* of the prog during the pass */
+	u32 nr_funcs;
+	u32 *pos;			/* place of the insn in the order */
+	u32 *rank;			/* callers go first */
+	struct flow_need *need[FLOW_NEED_KINDS];
+	unsigned long *point;		/* insn starts a basic block */
+	unsigned long *keep;		/* states that were processed are compared with */
+
+	/* of the pass */
+	struct flow_set *states;	/* per insn */
+	struct flow_set *enter;		/* per insn: the states that enter the loop at its head */
+	u32 *nr_states;			/* per insn: the two sets are counted together */
+	struct rb_root_cached pending;
+	struct flow_func *funcs;
+	struct flow_entry **entries;	/* bpf_verifier_state.flow_entry is the index, 0 is none */
+	u32 entry_cnt, entry_cap;
+	struct flow_united *united;
+	u32 united_cnt, united_cap;
+	struct list_head kept;
+	struct bpf_verifier_state tmp;
+	u32 seq;
+	u32 live_states;
+};
-- 
2.55.0

