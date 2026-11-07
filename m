Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022726;
	b=CQ/XmTaIOsgmX2N150U4ycA8I/ViIypeZ2v3HCynIIUsByzHlGmUulMoRzbATdPOkQlO
	 lm1PZ0W6NTYKaRndRo0MAfsqgKian+M4+Y9aW9BY5xbauxi7MnmbN8/bjogu9YdtzjmRw
	 TzxANGvIHLZUnP5nLpa/ElecQ2t1AUhtVgP9cNKieckxsakCODmWa590yRQsTmrMG48t9
	 Kr1y+QGRkZFRTvGBYaKr5dyFAgzdgLyXTeZJf9/qSoqDc9lddV7Pqe1QioY3pQYtGe8va
	 cTZaC5ykxI4hZvdgmlriJzHL7isXWWZAFB6a3FMXUW2RBeGwUBNKET34hntU0uI1+LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dxyY/J+db74GZB14Falgfk+ndVyxCu15I2o8HjB7kUc=;
	b=1NJNk7KCXDkkTms5eZxhWglfyZkEk94PB5VUfLP1Iu0eW1NBAtgt8o7Lat7MeUs8W+R0
	 5GezRbtWgdfghMsLdnI9NQb7cuujZgnx56fNtXw9898KZq3P72T5HrdiTHBMi0HPvsOe8
	 5TrxyxgUQxHCS35tPwwehTtUVWAMcH/u3V9uiQwal0Iij2msni+jdF2SE7sHzjM97C4Li
	 tsBM5oCGqrH4kyH9PSBel4iyOfBaZ7d+LWu7PTVGVExfgKO9j+lnel8Lm47gXTuI8ABAm
	 V6eIwbqHHSwIvaAv4T0AagslVyWl08lOoVuUUZFJvAXNEZpP+dN2DzRia0w3WxCTJng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+VZhDWW;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912B606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0912B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f+VZhDWW
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06454116eso626261b3a.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022725; x=1794627525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxyY/J+db74GZB14Falgfk+ndVyxCu15I2o8HjB7kUc=;
        b=f+VZhDWW1awJ9vpQUFPFb8CL6GAl/KJyskA7BHFMvVVmNFams2f+0moGN/a0TSC+0T
         9WwZ0yUsyfVPxnjdt9PtxLMriFgGwotMz0KFOS+dGAigdHVP/WsU/scQPFEYngwwpqqW
         Ocyt+3jefqbJrwsOn0ff6meOFn5MKn9ltO/f4IUMt1Nk/Kf6nRWPPN2+SunUzHSiWXqF
         Sc6cunSmMGNXmwIBM7UAF8Phgt7YtN7HEuypc0D29zzy8xi/rxj2uQ+UFoCEtkUvlPUh
         9uM/yYIxQylsH9aIPd/nvUxSwZyOjT5ECMLGqTVbjsuvM3wiWWJvRCpJruvewbyKUgKa
         IMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022725; x=1794627525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxyY/J+db74GZB14Falgfk+ndVyxCu15I2o8HjB7kUc=;
        b=BuCqN4CCWcsnVdPNlhGBOB86GHsjuqcjdvKKHwljAcWzOp/S0zbiJgqJb93FMRMdao
         vPSYoC2bsOLjg+Cewdi1MHqbI8H2qLLKjJ5erq0M5yNCCgQYOt3KGddT6QdKo9sx3cW4
         GyOph4q8e9IUfo4mp9srxVCYHvJ8dm68nbz4VA93l/ZlBd4sqD2noPb8Oe5XsJy+TOFS
         ZM7TKdRftYkAUKM7n78RgAN/Fu8apiPbj+zDkz6EPcRs58H+smPpr8t2BypJCPKppSl6
         fZiDrNkOdJJNFjbZYRL/ndcqkTEuriHcyBUtuP64z1tZYHTpZ9d+SXtVVjledcZZb5wu
         lwTg==
X-Gm-Message-State: APuU4Z+O5zYQrpmbQH7KODLNjD3Cu0GzJFriUGgA/QBNAqD07X3ao6Ud
	cbA+CSqcW6BM764twMj2bMERqA9ZIrcYvdIHlpz70BEQ4g5IHcXRrsxqKqNcOg==
X-Gm-Gg: AYBFou1CY6EOIjxzJ2oOX9sBV8ad92K0VNoozcNU5CdNaLUJ3KCPIB0PzczGsr/PgpM
	Fd/US3gCJlOj25cZiOGwuc6CPYVkO4BB8xnWvvhVFTWQWHYd6b6POCQt18dol3nqJAExX2/pfkR
	aO3wW2etA1RfvYcOo54Xm8ANuUV5WLohFJaxgQ3q0qz6CkFOeXSPg//pewi8u/ggr1ofuSDpAAN
	LoQKDCSK4Tc8G5C8yevRUC/DhU2xmylzP37uPz9yhzO+aJSq3R3SP+no3WejJTLZDSHqUG0JdKo
	PVwbnCGoj/eSONowDE/VarSlR+KEsvlo1ii8lsTnbbry6AWzbhEJJqzLi0Y39EDvS+aN+XjlwA3
	Dfgp6fwp78LTyevnB1a31NXIoQs+Sd34Cgh4fUNLNrtxDwq7S5RDpL3Wr1t69edfeZZmCvLONOS
	8GXXpQ1kvkmqRfzEKJJmExRA87R6E7VJH4kaXEmyxFUvuP23LEoBRTcD0pDI4lBaoDZtC34Z79X
	Gmmo5h9TiSrrhNI0EvBqv02PAphi2PanRG1CIMBgpx5Qi9tsfRWfUN06tiK/X6NqyamKEUX5Iv2
	3MRJCbx/oBRPPLmlQRqid6XBmpJ0t16fcKyRCA/tKrFrth/5k2cUjOM6tdkRVAK/P578+GzGSrl
	yX81SdVRXtsspzg+2V3h1TV9uJn2enznRMR9VhTZzTY2ZUvnPvRS+Sr7b9vwyM9ZTLDgPbnAfIA
	==
X-Received: by 2002:a05:6a00:140b:b0:8a0:3336:4b45 with SMTP id d2e1a72fcca58-8b37aa9f637mr4522457b3a.12.1794022725031;
        Fri, 06 Nov 2026 19:38:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b356c2c5a5sm1078565b3a.7.2026.11.06.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 07/46] bpf: Add the data structures of the main pass over the control flow graph
Date: Sat,  7 Nov 2026 03:37:15 +0000
Message-ID: <20261107033758.1547725-8-alexei.starovoitov@gmail.com>
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
  scx        scx_eevdf/eevdf_dispatch                350041         15322
  Cilium     bpf_host/cil_to_netdev, Oct 2026         64658          7538
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

