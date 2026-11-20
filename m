Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207937;
	b=QMgz7GzXlkuzEj9iG9NOMOF/ft4InKatUl9SBiYYzl4MuSsgpZn5sYwkdpe2uBYhUyY7
	 EYE2eyQMEWCPIbT2YW4k2TpUmG6OGLDL+TKQJshaLdWyuYyd0r5uqeDLdeyL3w63Wy2Sx
	 Wsho7qLo/4gg2hELRSMpudOE+JO67MefWI0bl4JCJXsrnkOwf5EB1b1/QBNcr3uLATcH8
	 nqAu8Skb9i5tHuQUyPqMH7irbQrX4o7Azsaq6VntmhLhCbwZWRHS/kPZVwMcmVQEhM1Bf
	 9BDDS1n5JqXWhcdOsLBHemVsUtiDW93Ly9/QzUyLBFwR/QYlQiceHWfZbUvTcbVpG/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W4/tRSCMX79PnJr/MM9rxal+6QJN2GuXBEMVp+makGw=;
	b=M8gpoLC7uTzVnfiUGkccAAX7JOU2d56EHPmc99JLeEG4Cl9UY1DajNxj2flap+itsZGg
	 dm85emBhXyEM4jh8SHEELGaSn8bD5758J0VlAMR2tU/nvnfFZRbz5qsDN8xFMeXuzFiXw
	 SH7C9xiHBt9gWu+1BGoiiJR1t6HhOEiU4V4M6DB65PtDHCqoLCwvs9LnTPktApKd2O2Wm
	 mIjI4A8CUbTRDoswFu1MZcYS2/zi2QIsG9u9Ixsor6TQswKaN1Arv7lTv4JoyEBBsLSRf
	 r5ufJf2GO3oWi087vSziZ3MQw2HhtLhfvO513phnyK5IOpT8UiHu3XIpcK0qtpfc4ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oy3Xt2nK;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B022606A681
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B022606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oy3Xt2nK
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f045b921caso7186655ad.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207934; x=1795812734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4/tRSCMX79PnJr/MM9rxal+6QJN2GuXBEMVp+makGw=;
        b=oy3Xt2nKsnqr9y0RQdz5BbDsonl4KeEKPRkS64tOGb8Tz4oyUQXalRi54ViyD7B56a
         rSdFgdJ/jZORaAtW4LCvdb60E4R51p1hW5SdmF9loq1XIwAnaPja8DOR4O7ms16YLuCc
         EWGwR4eaUNYwVkla0RB73wbgrfvFZ53m5GZf5a5vQhvhKcnsVzLM0MVOhelhbCjl1oj/
         P4sdenrkK2rkKhog04yv5Aw87jvdCqZMWXQOeBEwCZRnLbt+HR/4Z9+5FX18tJe1obPX
         G/s+CzytFfj2XCFvQv3w4AXfeHI5uKDGeN9BB2mfHmVOVSvYJ7Ewfuzz7TE+3/U9HLN6
         0xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207934; x=1795812734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4/tRSCMX79PnJr/MM9rxal+6QJN2GuXBEMVp+makGw=;
        b=EDuxHY3nHDRK5mjUCBhkhbfKAdZiqjvrIwbfpYf3k2k07bwQwL7l4Cnyy51XDBDNHB
         hZY6HVIPJDeO/AWUeePa5VtGM9jJQ+b32BilFJYkgwOqrO2xk85WiZv+0HDwD5WYviZN
         9JJG57SVZu/byf6OydjMYs/rDdVFrkcNWkfY8XNv7x8r56wyUeI0xjQqnB4xjqLnM2yw
         nMlI7fQsg/pyuJ4DdICJ1Bb7JRbYLdC9fwAsKDvgrP/UAEiAsm0qHVjqVrFoER1+Vcz0
         dat1+/420TRdBYrmomE6YGf1GwguUz8Qvgq/kb0j+b0KDft7Hp15pXISnr83DHtc4tfq
         CCnw==
X-Gm-Message-State: APuU4Z8tKh9hHYm8FHWnCShNlXo9dXIFhPBfzhpymNbrDYL0Ger+Eqtd
	9EqZjV9wOq38jX+woP1meSLrX8BuD7ptxBTvDp1kIa8AJw7lhqLlVglQAYO87A==
X-Gm-Gg: AZFdTZfrtk4s08kOjdDr6JmkXnqO8oUV0LMQQ+kHsBSngZ0uSLKhK/KhyY0uSWYXrLh
	nRhIYjU/swBYFCcrr5bEKDZDwDC4+Qp1Ngtgl7VWZBfsbb07QrFo34GFpB7NTmWXFzQS7erItaT
	nAfib7fOruczWtGyxjWgfFbVhuItTH+GC/jS9hSu9kLXjR82oqBxhv6SUC5clXyBWV2rGwzcDFp
	Z13ns19iTd31ha5p9ofrT86DMFhwnx1pN5k3dWv2MDCd7p/Huxy2iYFUkM+Q+EdFckbTP9M+Igz
	3Y1GT0rjxUEinQqOhG2x9HTpg+heNHRb8thtMVHRqZq6mvoIJsqKdlA7Js6nuCbYYqQCTNoMxd0
	5eNx3BSS/5pTBTA30l/y4Gf6QTOogwnzS3VI7f/jevG40SXLCAMx0SUGjyBt9V714JLTF8SttK2
	J28/Fbn1KOcPMKyvUVfMl9P7bA2rJkKImEqDxr+7Vq8wv1gfR41h6+yHIe5dbYdenkz9yutgImK
	nlWCs28Iw1eda7kb60PjiLTXjaKUDSgrEKNARztaabFFnPwB0D9xr8WCY7n6+XyegswBN6yu9yi
	M6+jDPRJIb74PU3h7G9DwCeSMtZM7t4+rsnvsSfa5qd+uEIYx2Ldp6n24MDIAVclih+COl73WPu
	EPXRtsrHkO6XvgkDhhgxDxWkz7/nLZDcQqdTyYoLwqKOjTpo0X9hMK/AcCBZ+p2F/iXtbdrAElw
	==
X-Received: by 2002:a17:90b:5109:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3b41c9bc501mr3707784a91.64.1795207933216;
        Fri, 20 Nov 2026 12:52:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8e93asm5518427a91.11.2026.11.20.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:52:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 22/49] bpf: Continue a pass after an unproven insn
Date: Fri, 20 Nov 2026 20:49:30 +0000
Message-ID: <20261120204959.614908-23-alexei.starovoitov@gmail.com>
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

A pass stops at its first error. A program with many insns that need
precision then takes one pass for each insn. Let the pass find all of
them:

  r0 = *(u64 *)(r2 + 0)    unproven; r0 = unknown, from_unproven
  r4 = *(u8 *)(r0 + 0)     unproven because of r0: not a new error
  r5 = *(u8 *)(r7 + 0)     unproven: noted too

skip_unproven_insn() continues as if the insn is proven. Such a pass
accepts nothing: env->err keeps the first error, and the log ends there.
If the insn is a call that changes what is held, the path ends.

bpf_note_unproven_insn() notes what the next pass needs: the insn, the
calls that lead to it, and the suspect loops of the state. A loop is a
suspect if it made a value imprecise. The pass ends early when all
unproven insns of the last pass are unproven again.

Two errors have no state that caused them:

  fixups differ        The first state is gone. The insn remembers the
                       suspect loops of its states. If a speculative
                       state was first, the insn gets a barrier.
  check_after_pass()   bpf_find_unproven_after_pass() takes the calls
                       and the insns that set the depth of a stack.

Small fixes that this needs:
- A join can make an unset stack argument: -EINVAL, not -EFAULT.
- An unproven call does not mark a global function as unreliable.
- The log does not skip a slot if it starts at the main dynptr slot.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  25 ++++-
 kernel/bpf/Makefile          |   1 +
 kernel/bpf/log.c             |   3 +-
 kernel/bpf/precision.c       | 142 +++++++++++++++++++++++
 kernel/bpf/precision.h       |  39 +++++++
 kernel/bpf/verifier.c        | 211 +++++++++++++++++++++++++++++++----
 6 files changed, 397 insertions(+), 24 deletions(-)
 create mode 100644 kernel/bpf/precision.c
 create mode 100644 kernel/bpf/precision.h

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bded3a774be..3b1ff5cb61c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -95,6 +95,8 @@ struct scalar {
 	u16 step;
 	/* Not a part of the value: it grew once at a loop header, see join_range() */
 	bool grew_once;
+	/* The value comes from an unproven insn (its check failed), see skip_unproven_insn() */
+	bool from_unproven;
 };
 
 /* The struct scalar that is an anonymous member of *@p */
@@ -646,7 +648,7 @@ static inline u32 bpf_stack_nr_slots(const struct bpf_func_state *frame)
 
 /*
  * Stack slot @spi of @frame, covering bytes [fp - (spi + 1) * 8, fp - spi * 8).
- * The caller must ensure spi < bpf_stack_nr_slots(frame), see bpf_grow_stack_state().
+ * The caller must ensure spi < bpf_stack_nr_slots(frame), see grow_stack_state().
  */
 static inline struct bpf_stack_state *bpf_stack_slot(const struct bpf_func_state *frame, u32 spi)
 {
@@ -891,6 +893,7 @@ struct bpf_loop {
 	/* while bpf_loop_per_pass.cost is not above @budget: */
 	u64 budget;
 	u32 max_peel_cnt;	/* peel up to this trip */
+	bool disjoint_apart;	/* disjoint values in data_deps stay apart, also in the leftover */
 	);
 	bool partitioned;	/* the last partition was for this loop */
 	struct bpf_loop_per_pass this_pass;
@@ -944,6 +947,7 @@ struct bpf_insn_aux_data {
 		u64 call_num;	/* any of these, or the offset of a refcount */
 	};
 	struct btf_struct_meta *kptr_struct_meta;
+	u64 suspect_loops; /* of the states that got here */
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->check_cnt */
@@ -957,7 +961,9 @@ struct bpf_insn_aux_data {
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
 	u64 guard_unwinds:1; /* it leaves the subprog */
+	u64 speculative_first:1; /* a speculative state came to it first */
 	u64 call_recorded:1; /* see record_call_fixup() */
+	u64 pessimized:1; /* see bpf_partition_for_pessimized() */
 	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -984,6 +990,7 @@ struct bpf_insn_aux_data {
 	/* what one pass gives to the next pass, see bpf_flow_new_pass() */
 	u32 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
 	u32 guard_unset_reg:1; /* where it goes a register is read that is not set here */
+	u32 non_speculative_first:1; /* speculative states end here, their fixups did not fit */
 
 	/* below flags are initialized once */
 	u32 bb_end:1; /* last instruction of a basic block */
@@ -1136,6 +1143,7 @@ struct bpf_subprog_info {
 	u32 exit_idx;
 	u32 callx_edge; /* 1 + the first of its env->callx_edges, 0 if none */
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
+	u32 deepest_insn; /* the insn that set stack_depth */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u16 arena_stack_depth; /* size of the frame in the stack in arena */
@@ -1349,6 +1357,8 @@ struct bpf_verifier_env {
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
 	bool path_sensitive;		/* no joins, see run_path_sensitive() */
+	bool for_log;			/* the verdict is known, see do_check_all() */
+	struct bpf_precision *precision;
 	u64 cost, mem;			/* see bpf_check_limits() */
 	u64 max_cost, max_mem;
 	u64 hash_seed;			/* see bpf_hash_join_key() */
@@ -1358,10 +1368,13 @@ struct bpf_verifier_env {
 	/* What a pass writes. Each pass starts from the snapshot. */
 	struct_group_tagged(bpf_env_per_pass, per_pass,
 	int err;			/* the first error */
+	u32 err_insn;
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
+	bool extra_values;		/* a state can have constants that no run has */
+	bool new_linear_xreg;		/* see bpf_same_insns_unproven() */
 	bool seen_direct_write;
 	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
 	bool seen_stack_slice;
@@ -1671,6 +1684,13 @@ int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st
 
 bool bpf_xreg_in_deps(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 		      u32 fr, u32 xregno);
+void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx);
+void bpf_note_unproven_insn(struct bpf_verifier_env *env,
+			    const struct bpf_verifier_state *st, u32 idx);
+bool bpf_insn_is_unproven(struct bpf_verifier_env *env);
+void bpf_note_fixups_differ(struct bpf_verifier_env *env);
+void bpf_find_unproven_after_pass(struct bpf_verifier_env *env);
+bool bpf_same_insns_unproven(struct bpf_verifier_env *env);
 /*
  * The two limits of the verifier, for the whole load. The unit of cost is one step of a scan,
  * about a dozen insns of the CPU. Memory is the bytes of states and tables at a time.
@@ -1718,6 +1738,8 @@ int bpf_flow_place_guards(struct bpf_verifier_env *env);
 /* verifier.c, for flow.c */
 int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge_loop,
 			bool *starts_leftover);
+int bpf_flow_edge_unproven(struct bpf_verifier_env *env, struct bpf_verifier_state *st, u32 idx,
+			   int err);
 #define BPF_EXIT_NEEDS_CALLER	1	/* verify the call in the frames of the caller */
 int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		    const struct bpf_verifier_state *exit, int call_idx);
@@ -1735,7 +1757,6 @@ void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
 void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
 void bpf_mark_reg_unknown(struct bpf_reg_state *reg);
-int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size);
 
 static inline int bpf_get_spi(s32 off)
 {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f05ccfce45c..bb2841387d4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_in
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-$(CONFIG_BPF_SYSCALL) += equation.o
+obj-$(CONFIG_BPF_SYSCALL) += precision.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 8a905f4df9b..dfe40d86677 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -751,7 +751,8 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			break;
 		case STACK_DYNPTR:
 			/* skip to main dynptr slot */
-			i += BPF_DYNPTR_NR_SLOTS - 1;
+			if (!reg->dynptr.first_slot)
+				i += BPF_DYNPTR_NR_SLOTS - 1;
 			reg = &bpf_stack_slot(state, i)->spilled_ptr;
 
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
new file mode 100644
index 00000000000..6aa54c656a7
--- /dev/null
+++ b/kernel/bpf/precision.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+
+#include "precision.h"
+
+/* The insn at @idx is unproven because it reads a value from another unproven insn */
+void bpf_note_reads_from_unproven(struct bpf_verifier_env *env, u32 idx)
+{
+	__set_bit(idx, env->precision->this_pass.bad_read_insns);
+	__set_bit(idx, env->precision->err_insns);
+}
+
+/* The access at @idx is unproven because of its address, whatever it loads or stores */
+static bool bad_address(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u32 idx)
+{
+	const struct bpf_func_state *f = st->frame[st->curframe];
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	u8 class = BPF_CLASS(insn->code);
+	const struct bpf_reg_state *base;
+
+	if (insn->src_reg >= MAX_BPF_REG || insn->dst_reg >= MAX_BPF_REG ||
+	    (class != BPF_LDX && class != BPF_ST &&
+	     (class != BPF_STX || f->regs[insn->src_reg].type != SCALAR_VALUE)))
+		return false;
+	base = &f->regs[class == BPF_LDX ? insn->src_reg : insn->dst_reg];
+	if (base->type != PTR_TO_STACK)
+		return !tnum_is_const(base->var_off);
+	return reg_smin(base) < -(s64)env->stack_limit - insn->off ||
+	       reg_smax(base) > -insn->off - bpf_size_to_bytes(BPF_SIZE(insn->code));
+}
+
+/* The insn at @idx is unproven in @st */
+void bpf_note_unproven_insn(struct bpf_verifier_env *env,
+			    const struct bpf_verifier_state *st, u32 idx)
+{
+	struct bpf_subprog_info *sub = bpf_find_containing_subprog(env, idx);
+	struct bpf_precision *prec = env->precision;
+	const struct loop_stack_entry *e;
+	u32 i, fr;
+
+	if (!sub)
+		return;
+	for (fr = 0; fr <= st->curframe && st->frame[fr]; fr++) {
+		e = st->frame[fr]->loop_stack;
+		for (i = 0; i < st->frame[fr]->loop_stack_cnt; i++, e++)
+			e->loop->this_pass.has_unproven |= (e->peeled || e->loop->disjoint_apart) &&
+							   !(st->suspect_loops &
+							     ~e->loop->suspect_bit);
+	}
+	for (i = st->curframe; i > 0 && st->frame[i]; i--)
+		__set_bit(st->frame[i]->callsite, prec->this_pass.call_insns);
+	/* the state does not know who called */
+	__set_bit(st->frame[0] ? st->frame[0]->subprogno : sub - env->subprog_info,
+		  prec->this_pass.unproven_funcs);
+	/* peeling comes first: it helps only for the suspect loops of this state */
+	if (!__test_and_set_bit(idx, prec->this_pass.unproven_insns)) {
+		prec->last_unproven_left -= test_bit(idx, prec->last_unproven_insns);
+		prec->this_pass.suspect_loops |= st->suspect_loops;
+		if (idx == env->err_insn)
+			prec->this_pass.first_suspect_loops |= st->suspect_loops;
+	}
+	if (!st->frame[0] || !bad_address(env, st, idx))
+		__set_bit(idx, prec->bad_value_insns);
+	if (!st->holds_too_much)
+		__set_bit(idx, prec->err_insns);
+	for (i = BPF_REG_0; st->frame[0] && i < BPF_REG_FP; i++)
+		if ((env->insn_aux_data[idx].use_regs & BIT(i)) &&
+		    !test_bit(idx, prec->bad_read_insns_done) &&
+		    st->frame[st->curframe]->regs[i].type == NOT_INIT)
+			__set_bit(idx, prec->this_pass.bad_read_insns);
+}
+
+/* The state that set the fixup is gone. The leftover of a loop possibly made it up. */
+static void suspect_loops_of_insn(struct bpf_verifier_env *env, u32 idx)
+{
+	env->precision->this_pass.suspect_loops |= env->insn_aux_data[idx].suspect_loops;
+	if (!env->err)
+		env->precision->this_pass.first_suspect_loops |=
+			env->insn_aux_data[idx].suspect_loops;
+}
+
+/* The current insn has a fixup that does not fit the current state */
+void bpf_note_fixups_differ(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[env->insn_idx];
+
+	suspect_loops_of_insn(env, env->insn_idx);
+	if (aux->speculative_first && !env->cur_state->speculative)
+		aux->non_speculative_first = env->precision->new_nospec = env->imprecise = true;
+}
+
+bool bpf_insn_is_unproven(struct bpf_verifier_env *env)
+{
+	return !env->path_sensitive &&
+	       test_bit(env->insn_idx, env->precision->this_pass.unproven_insns);
+}
+
+static void note_unproven_after_pass(struct bpf_verifier_env *env, u32 idx)
+{
+	static const struct bpf_verifier_state no_state;
+
+	bpf_note_unproven_insn(env, &no_state, idx);
+	/* no check failed, so the failing path cannot end here */
+	__clear_bit(idx, env->precision->err_insns);
+	suspect_loops_of_insn(env, idx);
+}
+
+/* check_after_pass() found an error. Which insns caused it? */
+void bpf_find_unproven_after_pass(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = env->prog->insnsi;
+	u32 i;
+
+	for (i = 0; i < env->subprog_cnt; i++)
+		note_unproven_after_pass(env, env->subprog_info[i].deepest_insn);
+	for (i = 0; i < env->prog->len; i++, insn++, aux++) {
+		if (aux->pessimized) {
+			note_unproven_after_pass(env, i);
+		} else if (aux->seen && (bpf_calls_function(env, i) || is_stack_arg_st(insn) ||
+					 is_stack_arg_stx(insn))) {
+			__set_bit(i, env->precision->this_pass.call_insns);
+			suspect_loops_of_insn(env, i);
+		}
+	}
+}
+
+/*
+ * All unproven insns of the last pass are unproven again, so the pass can stop. It continues if
+ * it added to linear_xregs: later trips can show that the xreg is not linear.
+ */
+bool bpf_same_insns_unproven(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+
+	return env->for_log || (prec->last_unproven_left == 1 && !env->new_linear_xreg &&
+				test_bit(env->insn_idx, prec->last_unproven_insns) &&
+				!test_bit(env->insn_idx, prec->this_pass.unproven_insns));
+}
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
new file mode 100644
index 00000000000..23980622006
--- /dev/null
+++ b/kernel/bpf/precision.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* What precision.c and failing_path.c share */
+#ifndef __BPF_PRECISION_H
+#define __BPF_PRECISION_H
+
+#include <linux/bpf_verifier.h>
+
+/* What a pass finds about its errors */
+struct precision_per_pass {
+	/* bitmaps of insns */
+	unsigned long *unproven_insns;
+	unsigned long *call_insns;		/* lead to unproven insns, or write what is held */
+	unsigned long *bad_read_insns;		/* unproven because of an unreadable xreg */
+	unsigned long *unproven_funcs;		/* of functions */
+	u64 suspect_loops, first_suspect_loops;	/* of the unproven states, of the first one */
+};
+
+struct bpf_precision {
+	/* this pass, and the last pass whose partition was kept */
+	struct precision_per_pass this_pass, last_pass;
+	unsigned long *bad_value_insns;		/* unproven, its value is possibly the cause */
+	unsigned long *last_unproven_insns;	/* in the last pass */
+	unsigned long *bad_read_insns_done;
+	u32 last_unproven_left;		/* last_unproven_insns whose check did not fail again */
+	bool new_nospec;
+
+	/* The path-sensitive run */
+	unsigned long *err_insns;		/* insns at which the failing path can end */
+};
+
+static inline bool bpf_calls_function(struct bpf_verifier_env *env, int idx)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+
+	return bpf_pseudo_call(insn) || bpf_is_callx(insn) ||
+	       env->insn_aux_data[idx].calls_callback || bpf_is_async_callback_calling_insn(insn);
+}
+
+#endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3edc91b8852..6da1a0f5b44 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1488,7 +1488,7 @@ static int resize_reference_state(struct bpf_verifier_state *state, size_t n)
 /* Possibly update state->allocated_stack to be at least size bytes. Also
  * possibly update the function's high-water mark in its bpf_subprog_info.
  */
-int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
+static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
 	size_t old_n = bpf_stack_nr_slots(state), n;
 
@@ -1506,8 +1506,10 @@ int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *st
 	state->allocated_stack = size;
 
 	/* update known max for given subprogram */
-	if (env->subprog_info[state->subprogno].stack_depth < size)
+	if (env->subprog_info[state->subprogno].stack_depth < size) {
 		env->subprog_info[state->subprogno].stack_depth = size;
+		env->subprog_info[state->subprogno].deepest_insn = env->insn_idx;
+	}
 
 	return 0;
 }
@@ -1832,15 +1834,12 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 	return 0;
 }
 
-static bool error_recoverable_with_nospec(int err)
+/*
+ * A check failed, so the insn is unproven in this state. The program is not rejected: a later
+ * pass can prove the insn. This pass continues, to find the other unproven insns.
+ */
+static bool error_is_recoverable(int err)
 {
-	/* Should only return true for non-fatal errors that are allowed to
-	 * occur during speculative verification. For these we can insert a
-	 * nospec and the program might still be accepted. Do not include
-	 * something like ENOMEM because it is likely to re-occur for the next
-	 * architectural path once it has been recovered-from in all speculative
-	 * paths.
-	 */
 	return err == -EPERM || err == -EACCES || err == -EINVAL;
 }
 
@@ -4403,7 +4402,7 @@ static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_fu
 				nargs, spi + 1);
 			bpf_diag_stack_arg_uninit(env, env->insn_idx, nargs, spi,
 						  callee_name, arg_name);
-			return -EFAULT;
+			return -EINVAL;
 		}
 	}
 
@@ -7051,7 +7050,7 @@ static int check_stack_access_within_bounds(
 	/* Note that there is no stack access with offset zero, so the needed stack
 	 * size is -min_off, not -min_off+1.
 	 */
-	return bpf_grow_stack_state(env, state, -min_off /* size */);
+	return grow_stack_state(env, state, -min_off /* size */);
 }
 
 static bool get_func_retval_range(struct bpf_prog *prog,
@@ -7598,6 +7597,8 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		src_reg_type |= PTR_UNTRUSTED;
 	}
+	/* a fill copies it from the slot, see mark_from_unproven(); dst can be src */
+	regs[insn->dst_reg].from_unproven = regs[insn->src_reg].from_unproven;
 
 	/*
 	 * check_stack_read_fixed_off() may refine the modification's origin to
@@ -11358,9 +11359,9 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 	err = btf_check_func_arg_match(env, subprog, btf);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
-	 * In such cases mark the function as unreliable from BTF point of view.
+	 * Mark a static function as unreliable from BTF point of view. The other call is unproven.
 	 */
-	if (err)
+	if (err && !bpf_subprog_is_global(env, subprog))
 		prog->aux->func_info_aux[subprog].unreliable = true;
 	return err;
 }
@@ -12765,6 +12766,7 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 static int fixups_differ(struct bpf_verifier_env *env, const char *msg)
 {
 	verbose(env, "%s\n", msg);
+	bpf_note_fixups_differ(env);
 	return -EINVAL;
 }
 
@@ -20710,6 +20712,33 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+/* Does the insn read what an unproven insn made up? Then what it writes is made up too. */
+static bool reads_from_unproven(struct bpf_verifier_env *env)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	int i;
+
+	for (i = BPF_REG_0; env->err && i < BPF_REG_FP; i++)
+		if ((cur_aux(env)->use_regs & BIT(i)) && regs[i].from_unproven)
+			return true;
+	return false;
+}
+
+static void mark_from_unproven(struct bpf_verifier_env *env, int idx, bool from_unproven)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	int i;
+
+	/* a fill has what was spilled */
+	if (!from_unproven && BPF_CLASS(env->prog->insnsi[idx].code) == BPF_LDX)
+		return;
+	for (i = BPF_REG_0; env->err && i < BPF_REG_FP; i++)
+		if (env->insn_aux_data[idx].def_regs & BIT(i))
+			regs[i].from_unproven = from_unproven;
+}
+
+static void note_error(struct bpf_verifier_env *env, int err);
+
 static u32 held_cnt(const struct bpf_verifier_state *st)
 {
 	return st->acquired_refs + st->active_rcu_locks + st->active_preempt_locks;
@@ -20897,6 +20926,11 @@ static int check_held_in_leftover(struct bpf_verifier_env *env,
 	verbose(env, "loop at insn %d acquires more than it releases\n", entry->loop->header);
 	env->imprecise |= !env->err;
 	st->suspect_loops |= entry->loop->suspect_bit;
+	st->holds_too_much = true;
+	if (bpf_same_insns_unproven(env))
+		return -EINVAL;
+	note_error(env, -EINVAL);
+	st->holds_too_much = false;
 	st->max_held_cnt = st->max_held_cnt ?: held_cnt(st);
 	return held_cnt(st) > st->max_held_cnt;
 }
@@ -21232,6 +21266,20 @@ static bool is_error_of_state(struct bpf_verifier_env *env, int err)
 	return err != -ENOMEM && err != -EINTR && !env->over_limit && !env->bug;
 }
 
+/* The pass has an error. The log ends with the first error. */
+static void note_error(struct bpf_verifier_env *env, int err)
+{
+	if (!is_error_of_state(env, err))
+		return;
+	if (!env->err) {
+		env->err = err;
+		env->err_insn = env->insn_idx;
+		env->log.level = 0;
+	}
+	if (!env->path_sensitive)
+		bpf_note_unproven_insn(env, env->cur_state, env->insn_idx);
+}
+
 /* An error in a speculative state is no error */
 static bool nospec_ends_path(struct bpf_verifier_env *env,
 			     const struct bpf_verifier_state *st, int err)
@@ -21239,6 +21287,104 @@ static bool nospec_ends_path(struct bpf_verifier_env *env,
 	return st->speculative && err < 0 && is_error_of_state(env, err);
 }
 
+/* @st cannot take the edge to or from @idx. Returns 1 if only its path ends. */
+int bpf_flow_edge_unproven(struct bpf_verifier_env *env, struct bpf_verifier_state *st, u32 idx,
+			   int err)
+{
+	bool last;
+
+	if (nospec_ends_path(env, st, err)) {
+		need_nospec(env, idx);
+		return 1;
+	}
+	swap(env->insn_idx, idx);
+	last = !error_is_recoverable(err) || env->path_sensitive || bpf_same_insns_unproven(env);
+	swap(env->cur_state, st);
+	if (!env->path_sensitive)
+		note_error(env, err);
+	env->cur_state = st;
+	if (last)
+		return err;
+	env->insn_idx = idx;
+	return 1;
+}
+
+/* The call releases, locks, or makes a dynptr, an iterator or an irq flag */
+static bool call_writes_held(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	const struct bpf_func_proto *fn = NULL;
+	struct bpf_kfunc_desc *desc;
+	enum bpf_arg_type type;
+	int i;
+
+	if (bpf_helper_call(insn)) {
+		bpf_get_helper_proto(env, insn->imm, &fn);
+	} else {
+		desc = find_kfunc_desc(env, insn->imm, insn->off);
+		fn = desc ? &desc->proto : NULL;
+	}
+	for (i = 0; fn && i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		/* nothing is held for a pointer that an unproven insn made up */
+		if (cur_regs(env)[BPF_REG_1 + i].type == SCALAR_VALUE)
+			continue;
+		type = fn->arg_type[i];
+		if (arg_type_is_release(type) || (arg_type_is_dynptr(type) && (type & MEM_UNINIT)))
+			return true;
+		switch (base_type(type)) {
+		case ARG_PTR_TO_SPIN_LOCK:
+		case ARG_PTR_TO_RES_SPIN_LOCK:
+		case ARG_PTR_TO_IRQ_FLAG:
+		case ARG_PTR_TO_ITER:
+		case ARG_PTR_TO_LIST_NODE:
+		case ARG_PTR_TO_RB_NODE:
+			return true;
+		default:
+			break;
+		}
+	}
+	return false;
+}
+
+/*
+ * Continue as if @insn is proven, to find the other unproven insns of the pass.
+ * If it changes what is held, the next errors follow from this one, so the path ends.
+ * Returns 0 if the path continues.
+ */
+static int skip_unproven_insn(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	struct bpf_func_state *frame = cur_func(env);
+	struct bpf_reg_state *regs = cur_regs(env);
+	u16 def = cur_aux(env)->def_regs;
+	u8 class = BPF_CLASS(insn->code), *type;
+	int i, spi;
+
+	if (bpf_insn_is_cond_jump(insn->code))
+		return PTR_ERR_OR_ZERO(push_stack(env, env->insn_idx + insn->off + 1,
+						  env->insn_idx, false));
+	if (class == BPF_LD || ((class == BPF_JMP || class == BPF_JMP32) &&
+				!bpf_helper_call(insn) && !bpf_pseudo_kfunc_call(insn)))
+		return PROCESS_BPF_EXIT;
+	if (class == BPF_JMP && call_writes_held(env, insn))
+		return PROCESS_BPF_EXIT;
+	/* what it stores can be read */
+	for_each_set_bit(spi, cur_aux(env)->may_write_mask, bpf_stack_nr_slots(frame)) {
+		type = bpf_stack_slot(frame, spi)->slot_type;
+		for (i = 0; i < BPF_REG_SIZE; i++)
+			if (type[i] == STACK_INVALID || type[i] == STACK_POISON)
+				type[i] = STACK_MISC;
+	}
+	for (i = BPF_REG_0; i < BPF_REG_FP; i++) {
+		if (!(def & BIT(i)))
+			continue;
+		if (class == BPF_JMP && i)
+			bpf_mark_reg_not_init(env, &regs[i]);
+		else
+			mark_reg_unknown(env, regs, i);
+	}
+	leave_callback(frame);
+	return 0;
+}
+
 static void free_pushed_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_stack_elem *elem;
@@ -21256,7 +21402,7 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	bool do_print_state = true;
+	bool do_print_state = true, from_unproven;
 
 	for (;;) {
 		struct bpf_insn *insn;
@@ -21333,10 +21479,12 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		}
 
 		sanitize_mark_insn_seen(env);
+		insn_aux->suspect_loops |= state->suspect_loops;
 		prev_insn_idx = env->insn_idx;
 
 		/* Sanity check: precomputed constants must match verifier state */
-		if (!state->speculative && insn_aux->const_reg_mask) {
+		if (!state->speculative && !env->err && !env->extra_values &&
+		    insn_aux->const_reg_mask) {
 			struct bpf_reg_state *regs = cur_regs(env);
 			u16 mask = insn_aux->const_reg_mask;
 
@@ -21359,14 +21507,18 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		/* Reduce verification complexity by stopping speculative path
 		 * verification when a nospec is encountered.
 		 */
+		if (state->speculative && insn_aux->non_speculative_first)
+			need_nospec(env, env->insn_idx);
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
+		insn_aux->speculative_first |= !insn_aux->seen;
 
 		err = check_loop_guard(env) ?: check_recursion_guard(env);
 		if (err)
 			return err;
 
 		bpf_equations_before_insn(env);
+		from_unproven = reads_from_unproven(env);
 		fixups = insn_aux->fixups;
 		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
 		if (nospec_ends_path(env, state, err)) {
@@ -21380,12 +21532,29 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			need_nospec(env, prev_insn_idx);
 			free_pushed_states(env);
 			goto process_bpf_exit;
+		} else if (error_is_recoverable(err) && !env->path_sensitive) {
+			env->insn_idx = prev_insn_idx;
+			if (bpf_same_insns_unproven(env))
+				return err;
+			if (from_unproven)
+				bpf_note_reads_from_unproven(env, prev_insn_idx);
+			else
+				note_error(env, err);
+			err = skip_unproven_insn(env, insn);
+			if (err < 0)
+				return err;
+			if (err)
+				goto process_bpf_exit;
+			mark_from_unproven(env, prev_insn_idx, true);
+			env->insn_idx++;
 		} else if (err < 0) {
 			return err;
 		} else if (err == PROCESS_BPF_EXIT) {
 			goto process_bpf_exit;
 		} else if (err == INSN_IDX_UPDATED) {
 		} else if (err == 0) {
+			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
+				mark_from_unproven(env, prev_insn_idx, from_unproven);
 			env->insn_idx++;
 		}
 
@@ -22683,12 +22852,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 
 	ret = do_check(env);
 out:
+	if (ret && !env->err)
+		note_error(env, ret);
 	account_current_path(env);
-	if (!ret) {
-		if (pop_log)
-			bpf_vlog_reset(&env->log, 0);
-		bpf_diag_event_log_restore(env, 0);
-	}
+	if (!ret && pop_log)
+		bpf_vlog_reset(&env->log, 0);
+	bpf_diag_event_log_restore(env, 0);
 	free_states(env);
 
 	/*
-- 
2.55.0

