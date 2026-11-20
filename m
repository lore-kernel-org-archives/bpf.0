Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160729;
	b=2gpHOq7+n2tg+cSDVsTBcHzSMZr1LmCQQDFk0Sc7Pn2MzPHp11xW0jQ47RtweKs07Zmt
	 MxFg6budZjB8tgqrtn/ArekuOn5D5nQQumZT9ntSZa5BROKHs3L3JyFIm4/1yGxxDaEir
	 uhJnUA0qC08PGpIPregcYFodtV+gHx1vCa6yOjwz+D3Oprxg1xt3BAo3ubYCTPVmz2yBX
	 1bzpbwhc0pPHbe38OdZ7GuWa3iw+0lDUtOnQp2JDzgjLQsclTWU5Sr7mCYOzapSXBAohw
	 51XknKsqugV5emDZNzKriMGcNBRkf/+P7T5sKyd1Wxi3isNJek1jCFzke1/z5233hbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zinc1Lt2XjZ7XEZUye69nMSKaHU+8lpKqd9qrI8ZiPE=;
	b=vLXdSTr9XDnzsc17hzt7noj9SJHTPz0n7zc/EBO8gxrVUvr05J91qJHw8ocwHoWkpOIU
	 /+9NhvStq25dHyTWwzoDEM17XXu57szV4I7bYPtLXXpgdrr+VkNNUjd2Nu1uPPQy9hs2L
	 MbHAg/DJUR1xojCwVCwN5ngYgVUnO3wam7h5x2MjxX/WRF+gkgTDYC3yWrtGY6fEbDrGY
	 C0ldsGvPlvQzzr0oE8X67GlOiCsAELmLLp7JXMINGtUS3n1bIXrMrBIxzpNyfbsq3Qto5
	 eP+DKvN0r1jNPVpjgxtGNFnoTqiByItyXItIZNhV3uNFpFCwtlzUvLCNFOzcMGiWaOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KrFTnF4G;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FD606A330
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7FD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KrFTnF4G
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so346646b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160728; x=1795765528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zinc1Lt2XjZ7XEZUye69nMSKaHU+8lpKqd9qrI8ZiPE=;
        b=KrFTnF4G7UM/2Sq2ft6paiXRL31/R71qzr0bsqWwXyIZ75sGA/KCINqZXzvUIapLid
         JT3kLKIM6a4VJyb04HAiylfScNpeLcOx5u5jJ1pMLcZ0Y/P9KSoo59HlDVqHUsuByjxX
         uVREjFwCvRC33x6qIg7vzL6j9OVnr4Ty20CtLY4QkARyYMbAyQZMdCG6W1Oc3KR6nXsR
         wSeiy6EPDQTBKoO3Q4LbO7bB88IDNIv1sv4a44YfAW6/A6dnakeiesikptA3BxIFakwv
         e9ppeluqbXKD4iIP1KCuO4+05o7RgrPnv0X/lGzwzWI38+u0kKYmNVFFw4yh06QWrR6e
         zU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160728; x=1795765528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zinc1Lt2XjZ7XEZUye69nMSKaHU+8lpKqd9qrI8ZiPE=;
        b=qi6gvolnBO2weQCgq/20YL5D1lRlFDAE2KJoNx16cbB0pJ6lUq1P6p1ALkzHKnik8C
         XE57jaP+/8ZoWyWiptBmthrfH8PFiuUjmljt5aOwGZwanMMH0J3Am3ign3YiGP/yWJ5Z
         sYQDVTJzXJ3tSicRu8LlDFIwrraMDf9BarsLu7+XjEy6ZrmqayJ8qzP6gF99rMM8KheH
         2umXivc99DQbHmHnnSPqhuRBev/jJany1TCEX/hbkeHhYGW0/ofQ5Gi5iWnNEo9cq7Fg
         lNUflRtLdW4sjmub+5s5Nr9EbVB/KrQaU3/Y+fpwHJo+edgHdciYJFhxS1iWxqOKZcTQ
         Ei9Q==
X-Gm-Message-State: APuU4Z+C1IPUDCYtGIvjjUCe+bQVJf8vv+ctL2KA8Itx+ITiOJ0vY9OX
	B1IRS8acFbJADqAV1n8IGtMbIU/cm2lOphCas31b4EJ9MH3Y3GZQ+ayz1nRdug==
X-Gm-Gg: AZFdTZdWqLSgkvaj9hEZmyKPA2PKfey0Snq8YQ22J9veVOT1WmjCP0ocnsVJvouNxkI
	pQzbs2AENlFn9mFVuk7DjpMWLUXI1kCGnxV/PCd6yua68+PaGEn6RuR3HfQtTCjskXr+l+XjGul
	eO9noeOEiaTR0xsRFJVBYy9onzUW0niOY1HILNNvyok3Pu2y9sdp2tRNa39MyNsdYioki//PSGl
	MWBDEzJks7THdFQ9QaTlqOdyQxgHygOFtZfztoMMa92H40e2iECt7F2SCnTej6r16kQC1TPp5dM
	bXwCOMEaOfWOZ9uJ2p8/Lx6l1crB2gqaYnqueMnmob2ojApDQhXw9tpIpndOGTCSGt/iAbfdEzO
	v+w6ownNbkisS1V7My9blQ2VH8Xa8LgEdFDcZ6ZrJD2h/uDa3U9anPhM6SRDCbSXVJGUircaMv/
	nS/Mrfw0fAbeZeQpaOjq2sEyn17k16MZ/Wx66kxTyMYUhVeNXkDybKMAA09QZrIOFgK2CkLYdxX
	4cdGZt8k58EZSZMDXAcBKX2DUlQ/6qPiaZWU+gfQaQOjZodAtscYsbyWgroGmCqzesMG68Q6V5+
	9wmcb/TOOhHF7r9/vT9fxkafr5itnxBz2/PS+X6TCbL3h85wQo+gFu1Lc8bXI4o2jn5XttaDGCM
	1v13078vfindKlBJRwk+Es6QjpjTznIDrRMm4ICHQtkdwvPija4nI9uQYDI2K6Jfd14ww+PRNyt
	I=
X-Received: by 2002:a05:6a00:4b03:b0:874:705d:f649 with SMTP id d2e1a72fcca58-8c87ce34a4bmr1909949b3a.43.1795160727045;
        Thu, 19 Nov 2026 23:45:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c908a56acfsm472876b3a.23.2026.11.19.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/49] bpf: Check fixups in the main pass and keep a snapshot of them
Date: Fri, 20 Nov 2026 07:41:41 +0000
Message-ID: <20261120074430.2704488-10-alexei.starovoitov@gmail.com>
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

The main pass writes fixups for the code that rewrites the program: the
type of a pointer at a load, the mask of an add, the depth of a stack.
The main pass will run more than once, and a join can make a path that
the program does not have:

  r7, r8 = 0, 0 or 1, 5       join: r7 = 0..1, r8 = 0..5
  if r7 != 0 goto out
  if r8 == 0 goto out
  call f                      only the join gets here

The next pass must not see what this path wrote. Put what a pass
writes in groups: bpf_insn_fixups and bpf_env_per_pass. save_snapshot()
copies them, with subprog_info, func_info_aux, the prog and fields of
prog->aux. Each pass starts from the snapshot.

Some checks ran after the main pass. That is too late for another pass.
Move them:

  to the insn          a tail call with two maps, a load of an arena
                       member and of something else, a missing kfunc,
                       bpf_override_return() and a map of programs
  check_after_pass()   the depth of the stack, the prologue of an
                       extension, r12 in a callback that is called too,
                       the slots of stack arguments

The check for room for the arguments of an arena stack entry goes away.
The frame is empty at the entry, so R1-R5 wait there.

An insn has one fixup for all states. A second one is an error, see
fixups_differ(). pass_cnt counts the calls of do_check(): rename it to
check_cnt.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  60 +++++----
 kernel/bpf/fixups.c          | 104 ++--------------
 kernel/bpf/verifier.c        | 227 ++++++++++++++++++++++++++++-------
 3 files changed, 230 insertions(+), 161 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 333ab842333..e40e4be6cf8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -764,6 +764,8 @@ struct bpf_loop {
 };
 
 struct bpf_insn_aux_data {
+	/* What a pass writes for the rewrite of the insn. Each pass starts from the snapshot. */
+	struct_group_tagged(bpf_insn_fixups, fixups,
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
 		struct bpf_map_ptr_state map_ptr_state;
@@ -795,15 +797,8 @@ struct bpf_insn_aux_data {
 	};
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
-	/*
-	 * Per-instruction summary of stack slots in the current frame
-	 * that this instruction may write to.
-	 */
-	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
-	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
-	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
-	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	u32 seen; /* this insn was processed by the verifier at env->check_cnt */
 	u64 nospec:1; /* do not execute this instruction speculatively */
 	u64 nospec_result:1; /* result is unsafe under speculation, nospec must follow */
 	u64 zext_dst:1; /* this insn zero extends dst reg */
@@ -813,12 +808,7 @@ struct bpf_insn_aux_data {
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
-	u64 bb_end:1; /* last instruction of a basic block */
 	u64 loop_guard:1; /* may_goto is added in front of this instruction */
-	u64 guard_place:1; /* it's the place for may_goto if the loop needs one */
-	u64 guard_at_header:1; /* there is no better place than the head of the loop */
-	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
-	u64 guard_unset_reg:1; /* where it goes a register is read that is not set here */
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
@@ -837,20 +827,35 @@ struct bpf_insn_aux_data {
 	u64 arena_member:1;
 	u64 arena_member_nullable:1;
 	u64 non_arena_load:1;
+	u64 indirect_target:1; /* if it is an indirect jump target */
+	u64 non_stack_access:1; /* instruction can access non-stack memory */
+	);
+
+	/* what one pass gives to the next pass, see bpf_flow_new_pass() */
+	u32 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
+	u32 guard_unset_reg:1; /* where it goes a register is read that is not set here */
 
 	/* below flags are initialized once */
+	u32 bb_end:1; /* last instruction of a basic block */
+	u32 guard_place:1; /* it is the place for may_goto if the loop needs one */
+	u32 guard_at_header:1; /* there is no better place than the header of the loop */
 	/* true if instruction is a call to a helper function that
 	 * accepts callback function as a parameter.
 	 */
-	u64 calls_callback:1;
-	u64 indirect_target:1; /* if it is an indirect jump target */
-	u64 non_stack_access:1; /* instruction can access non-stack memory */
+	u32 calls_callback:1;
 	/* true if some jump or call instruction targets this instruction */
-	u64 jump_target:1;
+	u32 jump_target:1;
 	/* it can read or write the frame of a caller, in a call with a known callee */
 	u32 reads_outer:1;
 	u32 writes_outer:1;
+	/*
+	 * Per-instruction summary of stack slots in the current frame
+	 * that this instruction may write, may read, and that are live before it.
+	 */
+	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
 	DECLARE_BITMAP(may_read_mask, MAX_BPF_STACK_SLOTS);
+	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);
+	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (arg_track) */
 
 	unsigned int orig_idx; /* original instruction index, initialized once */
 	/* registers alive before this instruction. */
@@ -1184,13 +1189,23 @@ struct bpf_verifier_env {
 	u64 max_cost, max_mem;
 	u64 pass_max_cost;		/* see bpf_undo_precision() */
 	bool aborted;			/* a thaw does not take it back */
+	/* What a pass writes. Each pass starts from the snapshot. */
+	struct_group_tagged(bpf_env_per_pass, per_pass,
 	int err;			/* the first error */
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool restart;			/* see bpf_flow_next_is_no_bound() */
 	bool guards_late;		/* see bpf_flow_loop_gets_guards() */
-	u32 loop_entry_cnt;		/* see loop_stack_entry.entry_id, callback_entry_id */
+	bool seen_direct_write;
+	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
+	bool seen_stack_slice;
+	bool seen_exception;
+	bool sleepable_async_cb;
+	u32 id_gen;			/* used to generate unique reg IDs */
+	u32 max_stack_depth;		/* maximum combined stack depth */
 	u32 max_arena_stack_depth;	/* of all call chains */
+	u32 loop_entry_cnt;		/* see loop_stack_entry.entry_id */
+	);
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	struct bpf_map **used_maps;	/* array of map's used by eBPF program */
 	struct btf_mod_pair *used_btfs;	/* array of BTF's used by BPF program */
@@ -1202,7 +1217,6 @@ struct bpf_verifier_env {
 	u32 used_map_cnt;		/* number of used maps */
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 insn_array_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_ARRAY */
-	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
 	int exception_callback_subprog;
 	bool explore_alu_limits;
@@ -1215,12 +1229,8 @@ struct bpf_verifier_env {
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
-	bool seen_direct_write;
-	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
-	bool seen_stack_slice;
 	/* a global function is verified for BPF_FUNC_CTX_NO_RCU_LOCK */
 	bool no_rcu_read_lock;
-	bool seen_exception;
 	bool signature;
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
@@ -1267,12 +1277,10 @@ struct bpf_verifier_env {
 	} cfg;
 	/* Per-callsite snapshot of the parent's tracked spill slots for cross-frame fills. */
 	struct spill_snapshot **callsite_at_stack;
-	u32 pass_cnt; /* number of times do_check() was called */
+	u32 check_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
 	u32 insn_processed;
-	/* maximum combined stack depth */
-	u32 max_stack_depth;
 	/* stack budget of the program, see bpf_prog_stack_limit() */
 	u32 stack_limit;
 	/* total verification time */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index bd47a38c7bc..f8f439b3e41 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -841,7 +841,7 @@ static void keep_funcs_with_addr_taken(struct bpf_verifier_env *env)
 			continue;
 		memcpy(insn + t, &trap, sizeof(trap));
 		aux_data[t].zext_dst = false;
-		aux_data[t].seen = env->pass_cnt;
+		aux_data[t].seen = env->check_cnt;
 	}
 }
 
@@ -963,17 +963,11 @@ static int insert_arena_stack_get(struct bpf_verifier_env *env, int s)
 	int size = s ? BPF_REG_8 : BPF_REG_4;
 	struct bpf_subprog_info *sub = &env->subprog_info[s];
 	struct bpf_insn *buf = env->insn_buf, *patch;
-	int jfree, jdone, jslow, slow, free, done, i, spill = 0;
+	int jfree, jdone, jslow, slow, free, done, i;
 
-	if (s) {
-		spill = round_up(sub->stack_depth, BPF_REG_SIZE);
-		sub->stack_depth = spill + MAX_BPF_FUNC_REG_ARGS * BPF_REG_SIZE;
-		if (sub->stack_depth > env->stack_limit) {
-			verbose(env, "no room in the stack of %s() for its arguments\n",
-				bpf_subprog_name(env, s));
-			return -EACCES;
-		}
-	}
+	/* the arguments wait in the frame, nothing is there yet */
+	if (s)
+		sub->stack_depth = max(sub->stack_depth, MAX_BPF_FUNC_REG_ARGS * BPF_REG_SIZE);
 
 	patch = emit_arena_stack_percpu(env, buf, ptr);
 	*patch++ = BPF_MOV32_IMM(cnt, 1);
@@ -984,7 +978,7 @@ static int insert_arena_stack_get(struct bpf_verifier_env *env, int s)
 	if (!s)
 		*patch++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	for (i = BPF_REG_1; s && i <= BPF_REG_5; i++)
-		*patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_FP, i, -(spill + i * BPF_REG_SIZE));
+		*patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_FP, i, -i * BPF_REG_SIZE);
 	*patch++ = ld_aux[0];
 	*patch++ = ld_aux[1];
 	*patch++ = BPF_MOV64_REG(BPF_REG_2, cnt);
@@ -993,7 +987,7 @@ static int insert_arena_stack_get(struct bpf_verifier_env *env, int s)
 	if (!s)
 		*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 	for (i = BPF_REG_1; s && i <= BPF_REG_5; i++)
-		*patch++ = BPF_LDX_MEM(BPF_DW, i, BPF_REG_FP, -(spill + i * BPF_REG_SIZE));
+		*patch++ = BPF_LDX_MEM(BPF_DW, i, BPF_REG_FP, -i * BPF_REG_SIZE);
 	jdone = patch++ - buf;
 	*patch++ = BPF_MOV64_IMM(BPF_REG_0, 0);
 	*patch++ = BPF_EXIT_INSN();
@@ -1025,15 +1019,6 @@ int bpf_insert_arena_stack(struct bpf_verifier_env *env)
 	if (!env->uses_arena_sp)
 		return 0;
 
-	/* the caller would get r12 of the callee back */
-	for (i = 0; i < env->subprog_cnt; i++) {
-		if ((i && !subprogs[i].arena_stack_entry) || !subprogs[i].is_called)
-			continue;
-		verbose(env, "%s() uses R%d and is both called and a callback\n",
-			bpf_subprog_name(env, i), BPF_REG_ARENA_SP);
-		return -EINVAL;
-	}
-
 	/*
 	 * With spare bytes r12 is neither the start nor the end of the stack,
 	 * which may be at 0, so 'rX = r12' is not NULL.
@@ -1217,25 +1202,6 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return bpf_patch_list_commit(env);
 }
 
-/*
- * The prologue takes the context from R1, and it can clobber R2-R5. An
- * extension gets the arguments of the function that it replaces.
- */
-static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
-{
-	const struct bpf_subprog_info *sub = &env->subprog_info[0];
-	int i, cnt = min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
-
-	if (!cnt || sub->args[0].arg_type != ARG_PTR_TO_CTX)
-		return false;
-
-	for (i = 1; i < cnt; i++)
-		if (sub->args[i].arg_type != ARG_SCALAR)
-			return false;
-
-	return true;
-}
-
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -1248,7 +1214,7 @@ static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
  * __arena arguments. A __nullable member keeps NULL as NULL, tested on the
  * full kernel address, and so does a probed load, which reads as 0 when it
  * faults. Returns the number of insns in @buf, 0 when the insn loads no such
- * member, or an error when it does so on some paths only.
+ * member.
  */
 static int arena_member_fixup(struct bpf_verifier_env *env, int idx, struct bpf_insn *insn,
 			      struct bpf_insn *buf)
@@ -1259,10 +1225,6 @@ static int arena_member_fixup(struct bpf_verifier_env *env, int idx, struct bpf_
 
 	if (!aux->arena_member)
 		return 0;
-	if (aux->non_arena_load) {
-		verbose(env, "an insn loads an arena pointer member on one path and something else on another\n");
-		return -EINVAL;
-	}
 
 	base = bpf_arena_get_kern_vm_start(env->prog->aux->arena);
 	buf[cnt++] = *insn;
@@ -1318,17 +1280,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
-			if (env->prog->type == BPF_PROG_TYPE_EXT &&
-			    !ext_prog_takes_prologue(env)) {
-				verbose(env,
-					"Extension writing packet data must take ctx and scalars only\n");
-				return -EINVAL;
-			}
-			if (env->prog->type == BPF_PROG_TYPE_EXT &&
-			    bpf_check_ext_prologue(&env->log,
-						   env->prog->aux->dst_prog,
-						   env->prog->aux->attach_btf_id))
-				return -EINVAL;
 			env->prog->aux->has_prologue = true;
 			/* the prologue ends with the first insn of the program */
 			if (verifier_bug_if(memcmp(&insn_buf[cnt - 1], env->prog->insnsi,
@@ -1412,8 +1363,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			   env->insn_aux_data[i].arena_member) {
 			/* an acquire load of an __arena member is rewritten like a plain load */
 			cnt = arena_member_fixup(env, i, insn, insn_buf);
-			if (cnt < 0)
-				return cnt;
 			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
 			if (IS_ERR(insn))
 				return PTR_ERR(insn);
@@ -1511,8 +1460,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			}
 
 			cnt = arena_member_fixup(env, i, insn, insn_buf);
-			if (cnt < 0)
-				return cnt;
 			if (!cnt)
 				continue;
 			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
@@ -1987,21 +1934,9 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	struct bpf_prog *prog = env->prog;
 	struct bpf_insn *insn = prog->insnsi;
-	int depth;
+	int i, depth;
 #endif
-	int i, err = 0;
-
-	for (i = 0; i < env->subprog_cnt; i++) {
-		struct bpf_subprog_info *subprog = &env->subprog_info[i];
-		u16 outgoing = subprog->stack_arg_cnt - bpf_in_stack_arg_cnt(subprog);
-
-		if (subprog->max_out_stack_arg_cnt > outgoing) {
-			verbose(env,
-				"func#%d writes %u stack arg slots, but calls only require %u\n",
-				i, subprog->max_out_stack_arg_cnt, outgoing);
-			return -EINVAL;
-		}
-	}
+	int err = 0;
 
 	if (env->prog->jit_requested &&
 	    !bpf_prog_is_offloaded(env->prog->aux)) {
@@ -2736,11 +2671,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * index &= array->index_mask;
 			 * to avoid out-of-bounds cpu speculation
 			 */
-			if (bpf_map_ptr_poisoned(aux)) {
-				verbose(env, "tail_call abusing map_ptr\n");
-				return -EINVAL;
-			}
-
 			map_ptr = aux->map_ptr_state.map_ptr;
 			insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
 						  map_ptr->max_entries, 2);
@@ -3355,17 +3285,16 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 	return bpf_patch_list_commit(env);
 }
 
-/* Remove unnecessary spill/fill pairs, members of fastcall pattern,
- * adjust subprograms stack depth when possible.
+/*
+ * Remove unnecessary spill/fill pairs, members of fastcall pattern.
+ * check_max_stack_depth() has adjusted the stack depth of subprograms.
  */
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 {
-	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	u32 spills_num;
-	bool modified = false;
 	int i, j;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
@@ -3376,13 +3305,6 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 				*(insn - j) = NOP;
 				*(insn + j) = NOP;
 			}
-			modified = true;
-		}
-		if ((subprog + 1)->start == i + 1) {
-			if (modified && !subprog->keep_fastcall_stack)
-				subprog->stack_depth = -subprog->fastcall_stack_off;
-			subprog++;
-			modified = false;
 		}
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ef8e45a399c..e43a3dd9a39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6019,6 +6019,12 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	int s, ret;
 
 	find_subprog_properties(env, true);
+	/* see bpf_remove_fastcall_spills_fills() */
+	for (s = 0; s < env->subprog_cnt; s++)
+		for (int i = si[s].start; i < si[s + 1].start && !si[s].keep_fastcall_stack; i++)
+			if (env->insn_aux_data[i].fastcall_spills_num)
+				si[s].stack_depth = -si[s].fastcall_stack_off;
+
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
 			/* the stack in arena wouldn't be returned */
@@ -7501,6 +7507,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
+static int fixups_differ(struct bpf_verifier_env *env, const char *msg);
+
 static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
@@ -7545,12 +7554,13 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * may share the insn, see save_aux_ptr_type(). Record a load that did
 	 * not produce an arena pointer from an __arena member, the only load
 	 * through a kernel struct pointer that does, next to the one
-	 * check_arena_member_load() records, so that arena_member_fixup() can
-	 * tell when the paths disagree.
+	 * check_arena_member_load() records. Fail if the insn has both.
 	 */
 	if (!err && !(base_type(src_reg_type) == PTR_TO_BTF_ID &&
 		      regs[insn->dst_reg].type == PTR_TO_ARENA))
-		env->insn_aux_data[env->insn_idx].non_arena_load = true;
+		cur_aux(env)->non_arena_load = true;
+	if (!err && cur_aux(env)->arena_member && cur_aux(env)->non_arena_load)
+		return fixups_differ(env, "an insn loads an arena pointer member on one path and something else on another");
 	err = err ?: save_aux_ptr_type(env, src_reg_type,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
@@ -8959,7 +8969,6 @@ static bool is_bpf_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_rbtree_add_kfunc(u32 func_id);
 static int get_bpf_res_spin_lock_kfunc_flags(const struct bpf_call_arg_meta *meta);
-static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env);
 static int process_irq_flag(struct bpf_verifier_env *env,
 			    struct bpf_reg_state *reg, argno_t argno,
 			    struct bpf_call_arg_meta *meta);
@@ -11316,7 +11325,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		if (IS_ERR(async_cb))
 			return PTR_ERR(async_cb);
 		if (is_async_cb_sleepable(env, insn))
-			mark_sleepable_async_cb(env);
+			env->sleepable_async_cb = true;
 		callee = async_cb->frame[0];
 		callee->async_entry_cnt = state->frame[0]->async_entry_cnt + 1;
 
@@ -11611,7 +11620,7 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	 * This is needed so the JIT knows how much stack arg space to allocate.
 	 * The callee can load less than its prototype has, and the caller can still store
 	 * all of it. Count the slots of the prototype only as far as the caller has stored
-	 * them: compilers store in front of the call. bpf_fixup_call_args() rejects the rest.
+	 * them: compilers store before the call. check_after_pass() fails for the rest.
 	 */
 	caller_info = &env->subprog_info[caller->subprogno];
 	callee_incoming = bpf_in_stack_arg_cnt(callee_info);
@@ -12406,6 +12415,7 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
 	struct bpf_map *map = meta->map.ptr;
+	bool other;
 
 	if (func_id != BPF_FUNC_tail_call &&
 	    func_id != BPF_FUNC_map_lookup_elem &&
@@ -12437,12 +12447,13 @@ record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EACCES;
 	}
 
-	if (!aux->map_ptr_state.map_ptr)
-		bpf_map_ptr_store(aux, meta->map.ptr,
-				  !meta->map.ptr->bypass_spec_v1, false);
-	else if (aux->map_ptr_state.map_ptr != meta->map.ptr)
-		bpf_map_ptr_store(aux, meta->map.ptr,
-				  !meta->map.ptr->bypass_spec_v1, true);
+	other = aux->map_ptr_state.map_ptr && aux->map_ptr_state.map_ptr != map;
+	/* the index is masked for one map */
+	if (func_id == BPF_FUNC_tail_call && other &&
+	    (bpf_map_ptr_unpriv(aux) || !map->bypass_spec_v1))
+		return fixups_differ(env, "tail_call abusing map_ptr");
+	if (other || !aux->map_ptr_state.map_ptr)
+		bpf_map_ptr_store(aux, map, !map->bypass_spec_v1, other);
 	return 0;
 }
 
@@ -12613,6 +12624,14 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 	return &env->insn_aux_data[env->insn_idx];
 }
 
+/* An insn has one fixup for all states. The state that was here first can be wrong too. */
+static int fixups_differ(struct bpf_verifier_env *env, const char *msg)
+{
+	verbose(env, "%s\n", msg);
+	bpf_note_fixups_differ(env);
+	return -EINVAL;
+}
+
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
 	return bpf_register_is_null(reg_state(env, BPF_REG_4));
@@ -12940,6 +12959,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 		break;
 	}
+	case BPF_FUNC_override_return:
+		/* see bpf_check_tail_call() */
+		for (i = 0; i < env->used_map_cnt; i++) {
+			if (!map_type_contains_progs(env->used_maps[i]))
+				continue;
+			verbose(env, "bpf_override_return() and a map of programs are used\n");
+			return -EINVAL;
+		}
+		break;
 	case BPF_FUNC_per_cpu_ptr:
 	case BPF_FUNC_this_cpu_ptr:
 	{
@@ -15523,9 +15551,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct btf *desc_btf;
 	int id;
 
-	/* skip for now, but return error when we find this in fixup_kfunc_call */
-	if (!insn->imm)
-		return 0;
+	if (!insn->imm) {
+		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
+		return -EINVAL;
+	}
 
 	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
 	if (err == -EACCES && meta.func_name) {
@@ -16290,7 +16319,7 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 	 * rewrite/sanitize them.
 	 */
 	if (!vstate->speculative)
-		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
+		env->insn_aux_data[env->insn_idx].seen = env->check_cnt;
 }
 
 static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *insn, int reason)
@@ -17642,10 +17671,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 			 * prevent zext from being set if the instruction has
 			 * been previously called with non-arena registers.
 			 */
-			if (aux->prevent_zext) {
-				verbose(env, "same insn cannot be used with and without arena pointer\n");
-				return -EINVAL;
-			}
+			if (aux->prevent_zext)
+				return fixups_differ(env, "same insn cannot be used with and without arena pointer");
 
 			/*
 			 * 32-bit operations zero upper bits automatically.
@@ -17661,10 +17688,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 
 	/* Prevent the instruction from being used with arena pointers (see above). */
 	if (env->prog->aux->arena && BPF_CLASS(insn->code) == BPF_ALU64) {
-		if (aux->needs_zext) {
-			verbose(env, "same insn cannot be used with and without arena pointer\n");
-			return -EINVAL;
-		}
+		if (aux->needs_zext)
+			return fixups_differ(env, "same insn cannot be used with and without arena pointer");
 
 		aux->prevent_zext = true;
 	}
@@ -17937,10 +17962,8 @@ static int check_addr_space_cast(struct bpf_verifier_env *env, struct bpf_insn *
 	}
 
 	/* it's either wX = wY or rX = rY, see bpf_lower_cast_mov() */
-	if (aux->cast_mov && aux->cast_arena) {
-		verbose(env, "same addr_space_cast insn cannot be used with a number and with a pointer\n");
-		return -EINVAL;
-	}
+	if (aux->cast_mov && aux->cast_arena)
+		return fixups_differ(env, "same addr_space_cast insn cannot be used with a number and with a pointer");
 	return 0;
 }
 
@@ -20129,8 +20152,7 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 			 */
 			*prev_type = merge_ptr_types(type, *prev_type);
 		} else {
-			verbose(env, "same insn cannot be used with different pointers\n");
-			return -EINVAL;
+			return fixups_differ(env, "same insn cannot be used with different pointers");
 		}
 	}
 
@@ -22026,7 +22048,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	int ret, i;
 
 	env->prev_linfo = NULL;
-	env->pass_cnt++;
+	env->check_cnt++;
 
 	state = kzalloc_obj(struct bpf_verifier_state, BPF_VERIFIER_GFP);
 	if (!state)
@@ -22186,7 +22208,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 	 * Accumulate their total counts as total counts of the main or
 	 * global subprog hosting the async call.
 	 * Start from the saved total of earlier contexts: adding to the current
-	 * total would count this pass's synchronous paths twice.
+	 * total would count the synchronous paths of this check twice.
 	 */
 	sub->insns_total = old_insns_total + (env->insn_processed - insn_processed);
 	return ret;
@@ -22277,6 +22299,134 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
+/* What a pass writes outside of the states */
+struct bpf_snapshot {
+	struct bpf_env_per_pass env;
+	struct bpf_prog_aux aux;
+	struct bpf_insn_fixups *insns;
+	struct bpf_subprog_info *subprogs;
+	struct bpf_func_info_aux *funcs;
+	struct bpf_prog prog;
+};
+
+static void copy_snapshot(struct bpf_verifier_env *env, struct bpf_snapshot *snapshot, bool save)
+{
+	bool has_callchain_buf = env->prog->has_callchain_buf;
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_subprog_info *sub;
+	int i;
+
+#define COPY(kept, live)	(save ? ((kept) = (live)) : ((live) = (kept)))
+#define COPY_AUX(field)		COPY(snapshot->aux.field, aux->field)
+	COPY(snapshot->env, env->per_pass);
+	COPY(snapshot->prog, *env->prog);
+	/* it is taken once */
+	env->prog->has_callchain_buf = has_callchain_buf;
+	COPY_AUX(max_ctx_offset);
+	COPY_AUX(max_pkt_offset);
+	COPY_AUX(max_tp_access);
+	COPY_AUX(max_rdonly_access);
+	COPY_AUX(max_rdwr_access);
+	COPY_AUX(min_rdwr_write);
+	COPY_AUX(max_rdwr_write);
+	COPY_AUX(stack_depth);
+	COPY_AUX(tail_call_reachable);
+	COPY_AUX(jits_use_priv_stack);
+	COPY_AUX(kprobe_write_ctx);
+	for (i = 0; i < env->prog->len; i++)
+		COPY(snapshot->insns[i], env->insn_aux_data[i].fixups);
+	for (i = 0, sub = env->subprog_info; i < env->subprog_cnt; i++, sub++) {
+		/* the sum over all passes */
+		snapshot->subprogs[i].insns_total = sub->insns_total;
+		snapshot->subprogs[i].insns_self = sub->insns_self;
+		COPY(snapshot->subprogs[i], *sub);
+	}
+	for (i = 0; aux->func_info_aux && i < aux->func_info_cnt; i++)
+		COPY(snapshot->funcs[i], aux->func_info_aux[i]);
+#undef COPY_AUX
+#undef COPY
+	bpf_add_cost(env, env->prog->len, BPF_COST_XREG);
+}
+
+static struct bpf_snapshot *save_snapshot(struct bpf_verifier_env *env,
+					  struct bpf_snapshot *snapshot)
+{
+	size_t insns = array_size(env->prog->len, sizeof(*snapshot->insns));
+	size_t subprogs = env->subprog_cnt * sizeof(*snapshot->subprogs);
+
+	if (!snapshot) {
+		snapshot = kvmalloc(sizeof(*snapshot) + insns + subprogs +
+				    env->prog->aux->func_info_cnt * sizeof(*snapshot->funcs),
+				    BPF_VERIFIER_GFP);
+		if (!snapshot)
+			return NULL;
+		env->mem += insns + subprogs;
+		snapshot->insns = (void *)(snapshot + 1);
+		snapshot->subprogs = (void *)snapshot->insns + insns;
+		snapshot->funcs = (void *)snapshot->subprogs + subprogs;
+	}
+	copy_snapshot(env, snapshot, true);
+	return snapshot;
+}
+
+static void restore_snapshot(struct bpf_verifier_env *env, struct bpf_snapshot *snapshot)
+{
+	copy_snapshot(env, snapshot, false);
+}
+
+/*
+ * The prologue takes the context from R1, and it can clobber R2-R5. An
+ * extension gets the arguments of the function that it replaces.
+ */
+static int check_ext_takes_prologue(struct bpf_verifier_env *env)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[0];
+	int i, cnt = min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+	struct bpf_prog *prog = env->prog;
+
+	if (prog->type != BPF_PROG_TYPE_EXT || !env->ops->gen_prologue ||
+	    !env->ops->gen_prologue(env->insn_buf, env->seen_direct_write, prog))
+		return 0;
+	for (i = 0; i < cnt; i++)
+		if (sub->args[i].arg_type != (i ? ARG_SCALAR : ARG_PTR_TO_CTX))
+			break;
+	if (!cnt || i < cnt) {
+		verbose(env, "Extension writing packet data must take ctx and scalars only\n");
+		return -EINVAL;
+	}
+	if (bpf_check_ext_prologue(&env->log, prog->aux->dst_prog, prog->aux->attach_btf_id))
+		return -EINVAL;
+	return 0;
+}
+
+/* What the pass found about functions and about the program has to be consistent */
+static int check_after_pass(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	u16 outgoing;
+	int i, err;
+
+	err = check_max_stack_depth(env) ?: check_ext_takes_prologue(env);
+	if (err)
+		return err;
+	for (i = 0; i < env->subprog_cnt; i++, sub++) {
+		/* the caller would get r12 of the callee back */
+		if (env->uses_arena_sp && (!i || sub->arena_stack_entry) && sub->is_called) {
+			verbose(env, "%s() uses R%d and is both called and a callback\n",
+				bpf_subprog_name(env, i), BPF_REG_ARENA_SP);
+			return -EINVAL;
+		}
+		outgoing = sub->stack_arg_cnt - bpf_in_stack_arg_cnt(sub);
+		if (sub->max_out_stack_arg_cnt > outgoing) {
+			verbose(env,
+				"func#%d writes %u stack arg slots, but calls only require %u\n",
+				i, sub->max_out_stack_arg_cnt, outgoing);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /*
  * What it took to verify a static subprog on its own is not in insns_total of its callers.
  * Add it, once per caller. The main prog and global subprogs have all of it already.
@@ -23656,11 +23806,6 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, desc_idx;
 	bool near_call;
 
-	if (!insn->imm) {
-		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
-		return -EINVAL;
-	}
-
 	*cnt = 0;
 
 	/* insn->imm has the btf func_id. Replace it with an offset relative to
@@ -24336,16 +24481,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		ret = bpf_insert_loop_guards(env);
 
 skip_full_check:
-	/* might decrease stack depth, keep it before passes that
-	 * allocate additional slots.
-	 */
+	/* instruction rewrites happen after this point */
 	if (ret == 0)
 		ret = bpf_remove_fastcall_spills_fills(env);
 
-	if (ret == 0)
-		ret = check_max_stack_depth(env);
-
-	/* instruction rewrites happen after this point */
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
 
-- 
2.55.0

