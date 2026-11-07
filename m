Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022831;
	b=4sENCKaKtWgvPtCNHYRN0qCKXHs3CKz+tgzlBU5SVJEN/T6heDFJqAffPT6LThjfjroJ
	 +Xl6xXL65Spz/0lv4J9qyx638b9equKXSO/QHO2LtHu2hDzWp3QJo4VTkIG5BK7MFNciR
	 ljrbaDuYf+F+0E2aefLbDBE42LpOLne+P+AMVtFyhzzTuMYild5jaE8dOgMoKHVMEZVWg
	 Lq0r9s/tY35tc5ccQ5Lo/AMrEjHOYX150QfZVHjuHuarjLYQL5jDCz4zJEEtPoo9LL/s4
	 z7FbDJ6H0F0FvIG10JeDPgcbG7v4JrKd1lAnaEhnhxPxlL+UQFzlZSsZRKSH8c5Vfeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mSoCEnEt0Rk6ELLKEGVTvgtGcqsZ8oQKuO8osk4Y/dk=;
	b=rPNlfg+0g30Ff6m2i2bCbihBjaG9CgPObl0IgbPUAATqBgdtvBs0nLEXHrsIQo4iBXqy
	 Z1lT2Q/6mL6GTk8WKE5C0w2o+tih4Xvo0k/v37CMVxgOV8to2i/Glm46NbQSrkvR+/Nt8
	 cSPVHsjjRmGpKkZ+O9OBir37MQzOlAziLK/Kwpbi8qQ9UecR0XKVVGD3grZAqfNP+CNpq
	 yI4VqYWScSlDOg2BsCLtNyUUdmyqmbkmei8eaMyKjzDrjonbCRDtax46A7gzw9L9XCx2U
	 scYWdVTXbwqTSYFI/tBQAjVuM6gYz+H3XetKweOhDkK8Au3f886RLs0OcGk+p8F0X9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3oCE9qN;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26349606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26349606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3oCE9qN
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd3310348d2so89173a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022829; x=1794627629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSoCEnEt0Rk6ELLKEGVTvgtGcqsZ8oQKuO8osk4Y/dk=;
        b=A3oCE9qNLyvypEQ7MmpE14b1fg7Vgi2oZQUbpl+YeARslBnt37/3nIFZPzBLQBZnGE
         1g6AMsKF883z8yguqX4M1bzjqlCfl+fkTn7dNijPp14Wpr9Kwpk9725WGFZ8N8a6c7Ju
         0jVeej2o3vKqzsnjyHZxxfITW31pf79cEfMyNbeUHpQy/AmeZvz6FJZB+Pnp5/lW+k2Z
         jn655OrVrRPq5LMe6xnEo+yh3B/TKofqLpnqx7bD/ST0lczZ0CRL08JbAgV0FdeE4AM0
         WxTvNp7j6K7kMJCw2/d5vRhNRwz5QE1Gg+TqOt9DHanPAuGn8Cr1kIe8Cgm9pNnK8Q5m
         TXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022829; x=1794627629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSoCEnEt0Rk6ELLKEGVTvgtGcqsZ8oQKuO8osk4Y/dk=;
        b=Ce1MegO78yOfeDDspESOqCHjcLTjEYAA3rDbBj4hw2eeWrPBMmbpiWhNsvcLfKJIQG
         TEVucorjaS6pAhWRYv4kGJUIOTUz31FWQmpl1jc878z8W6MisZHybyk0af5lMgosZf7l
         1tDjBl/UBxTyTuAqFPA4OMtbF6UcKa5RnK1fP9AfY+WO5vu+gz0t/q9GzhBSTjvaNTsM
         nAeNtxoKczDWmJdtFOxFsCGlY+aGHf2KGcrBbGKud7dXkPo31ncHGMos13xKTJmLZ4Gw
         Hn7Ur/mziGX6mFg1vW+SlpIgtqmwQYV17tJtudNUih281cRKJZNqSG+oNHAROHjSeJU5
         JI7g==
X-Gm-Message-State: APuU4Z9BW/4spIUh31dimKcBtMEBqgLqQ6mkLkRmx5zArzJjyT1CtqlL
	SeYGfFigOc4Bf3+YRjd8qJN0qoXwUXr3xlfDXpzIu9NRRNMB0qbqJnrpujP/yw==
X-Gm-Gg: AYBFou1hE4aQT2DxnzP/vFmr3sFoOUQ1W/mhHRMYQKOLYK/qjvH8THokT7ZiV9YN5FE
	Roqn+GwL4n9vBtQ+EOy1Z9fOv4KoOJhzjHwKIzGYfsdlaWquNpwy69pylvKJsCmL0V0Ys+HZH7E
	p27JjjX55ZSgL8ONg6BTPH096qJnu0O8/JYHlQ+JuAAf7VjTLDKzK3XeEDn6sbAHGW74U9KL+aj
	hJ68b0HhYKHy/oHzMhsaysmV5MrBdFZxFkNiIrsIqzHj7ziAw1SloS99PMz3gNU/d+3Ug0v3Ocn
	0c/lCR1E5hBteDoHO1oxQ4TLOqaLfkvstffT4nq8vU+F4FnS9fMQ4+VeeTguB5MM5FWBTsyXyhp
	XQzHBDSeg9T6tv5GUPkJcpWFd8cb1xTHFguaCGVbeqjkMKfHl1PNpgAwQpW3jGYEww1vszdj2B9
	1xFzNZzuPzvSrqLn+3ZS9WLMK1CZOGpJSCTRn4dIeQgs0wR8MNPfqAsM4qafAJaGNmhbQ61v+Rx
	qtabhIarbmOUAiVctkfLduVmbogpm5KWX75JhOu0SM6S65uOvkF1rJelAp67sh9IId/MI/noNwA
	kVRxpVrYl476daGthehebPKEKKfIODZLQH9h0aUohyKOiVaA3GQjpRXmRSvf5TscGaivkozWPle
	9aqFwZDX38qFgb2FaK7ByTSqCj8+j/1o//7oXmp0RRVH1wsvaCbLCj05L1WoMI3QOeUbnAcZKUz
	A=
X-Received: by 2002:a17:90b:4a89:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3b1061d3224mr593767a91.20.1794022828073;
        Fri, 06 Nov 2026 19:40:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm916457a91.4.2026.11.06.19.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 24/46] bpf: Remove precision tracking
Date: Sat,  7 Nov 2026 03:37:32 +0000
Message-ID: <20261107033758.1547725-25-alexei.starovoitov@gmail.com>
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

Precision tracking is a part of pruning. The verifier followed each path
and stopped a path when a state that it saw before at the same insn covered
the current state. To stop more paths, the comparison ignored a scalar
unless a later check depended on its value. To find these scalars, the
verifier went back from each check through the history of the path and
marked them as precise.

The verifier does not prune paths any more. It joins the states that meet
at the start of a basic block, and the join covers both:

  r1=0 and r1=1 meet      pruning                      join
  ----------------------  ---------------------------  ---------------
  a check depends on r1   r1 is precise,               verify r1=[0,1]
                          verify the two states
  no check depends on r1  drop the second state        verify r1=[0,1]

Each later check sees the full range of r1. Thus the verifier does not have
to find out afterwards which scalars a check depends on, and nothing reads
the marks.

One task of the marks is left. Some checks need a constant, for example the
size for bpf_ringbuf_reserve(), and the join of two constants is a range.
flow_compute_need_const() finds the registers and stack slots that go into
such checks, one time, before the main pass. States that differ in them are
not joined.

Remove the 'precise' bit, backtrack.c, jmp_history, the parent link of
a state and the marks that scalar evolution asks for: 1650 lines. With the
bit gone, __mark_reg_unknown() and bpf_mark_reg_unknown_imprecise() are one
function, bpf_mark_reg_unknown(). __mark_reg_const_zero() does not need
env, and BPF_REGMASK_ARGS has no user.

What user space sees:
 - The log has no "mark_precise:" lines and no 'P' in "R0=Pscalar()".
 - Nothing sets longest_mark_read_walk. veristat and other tools parse the
   statistics line, thus it continues to show "mark_read 0".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  120 +---
 kernel/bpf/Makefile          |    2 +-
 kernel/bpf/backtrack.c       | 1059 ----------------------------------
 kernel/bpf/log.c             |    2 -
 kernel/bpf/scev.c            |   42 +-
 kernel/bpf/states.c          |   11 +-
 kernel/bpf/verifier.c        |  475 ++-------------
 7 files changed, 63 insertions(+), 1648 deletions(-)
 delete mode 100644 kernel/bpf/backtrack.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 902a339b0caf..7ee3e40214b5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -35,8 +35,8 @@ static inline u16 imod(s64 v, u16 step)
 #define BPF_MAX_VAR_SIZ	(1 << 29)
 /*
  * size of tmp_str_buf in bpf_verifier.
- * we need at least 1399 bytes to fit full stack mask representation
- * (in the "-8,-16,...,-2048" form)
+ * The longest text is the list of stack slots of fmt_spis_mask(),
+ * which cuts what does not fit.
  */
 #define TMP_STR_BUF_LEN 1408
 /* Patch buffer size */
@@ -201,9 +201,7 @@ struct bpf_reg_state {
 	 * other registers. Kept outside the metadata union for ID remapping
 	 * during state comparisons.
 	 */
-	u32 map_uid:31;
-	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	u32 precise:1;
+	u32 map_uid;
 };
 
 static inline s64 reg_smin(const struct bpf_reg_state *reg)
@@ -295,10 +293,6 @@ enum bpf_stack_slot_type {
 #define BPF_HALF_REG_SIZE	4
 #define STACK_SLOT_SZ		4
 
-#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
-			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
-			  (1 << BPF_REG_5))
-
 #define BPF_MAIN_FUNC (-1)
 
 #define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
@@ -351,7 +345,6 @@ struct bpf_retval_range {
 struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
-	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/* live, changed by the loop, no summary of how: left to the join at the head */
 	unsigned long forget_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/* [0, max] at the entry, and the loop only clears bits */
@@ -518,44 +511,6 @@ struct bpf_func_state {
 /* What the interpreter has stack for. A longer chain of calls requires the JIT. */
 #define MAX_CALL_FRAMES_INTERP 16
 
-/* instruction history flags, used in bpf_jmp_history_entry.flags field.
- * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.
- */
-enum {
-	INSN_F_STACK_ACCESS = BIT(0),
-
-	INSN_F_DST_REG_STACK = BIT(1), /* dst_reg is PTR_TO_STACK */
-	INSN_F_SRC_REG_STACK = BIT(2), /* src_reg is PTR_TO_STACK */
-
-	INSN_F_STACK_ARG_ACCESS = BIT(3),
-};
-
-/* Registers linked to one jump condition that a history entry can record */
-#define BPF_LINKED_REGS_MAX	5
-
-struct bpf_jmp_history_entry {
-	/* insn idx can't be bigger than 1 million */
-	u32 idx : 20;
-	u32 frame : 5;	/* stack access frame number */
-	/* special INSN_F_xxx flags */
-	u32 flags : 4;
-	u32 : 3;
-	u32 prev_idx : 20;
-	u32 spi : 12;	/* stack slot index */
-	/*
-	 * Scalar registers and spilled scalars linked to the condition of
-	 * this jump, which need precision tracking together when the jump is
-	 * backtracked. Each is packed as 5 bits of frame number, one bit
-	 * telling a register from a stack slot and 10 bits of register or
-	 * slot index, see linked_regs_pack().
-	 */
-	u16 linked_regs[BPF_LINKED_REGS_MAX];
-	u8 linked_regs_cnt;
-};
-
-static_assert(MAX_CALL_FRAMES <= (1 << 5));
-static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
-
 /* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_STATIC_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
@@ -564,7 +519,6 @@ static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
-	struct bpf_verifier_state *parent;
 	/* Acquired reference states */
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
@@ -595,19 +549,8 @@ struct bpf_verifier_state {
 	 */
 	u32 flow_entry;
 
-	/*
-	 * First and last insn idx of this verifier state.
-	 * last_insn_idx is -1 if no instructions have been executed yet.
-	 */
-	u32 first_insn_idx;
+	/* The insn that the state comes from, -1 if no instructions have been executed yet. */
 	u32 last_insn_idx;
-	/* jmp history recorded from first to last.
-	 * backtracking is using it to go from last to first.
-	 * For most states jmp_history_cnt is [0-3].
-	 * For loops can go up to ~40.
-	 */
-	struct bpf_jmp_history_entry *jmp_history;
-	u32 jmp_history_cnt;
 };
 
 /* Number of BPF_REG_SIZE stack slots tracked for the frame so far. */
@@ -957,8 +900,8 @@ struct bpf_insn_aux_data {
 #define MAX_USED_BTFS 64 /* max number of BTFs accessed by one BPF program */
 
 /*
- * Longest line the verifier log can carry: a full stack mask of
- * MAX_BPF_STACK_SLOTS slots, see TMP_STR_BUF_LEN, plus its prefix.
+ * Longest line the verifier log can carry: tmp_str_buf, see
+ * TMP_STR_BUF_LEN, plus its prefix.
  */
 #define BPF_VERIFIER_TMP_LOG_SIZE	2048
 
@@ -1123,14 +1066,6 @@ static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 struct bpf_diag;
 struct bpf_verifier_env;
 
-struct backtrack_state {
-	struct bpf_verifier_env *env;
-	u32 frame;
-	u32 reg_masks[MAX_CALL_FRAMES];
-	unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];
-	u32 stack_arg_masks[MAX_CALL_FRAMES];
-};
-
 struct bpf_id_pair {
 	u32 old;
 	u32 cur;
@@ -1329,8 +1264,6 @@ struct bpf_verifier_env {
 		u32 gotox_edges;
 		bool subprog_jts_ready;
 	} cfg;
-	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
 	/* Per-callsite snapshot of the parent's tracked spill slots for cross-frame fills. */
 	struct spill_snapshot **callsite_at_stack;
 	u32 pass_cnt; /* number of times do_check() was called */
@@ -1352,8 +1285,6 @@ struct bpf_verifier_env {
 	 * memory consumption during verification
 	 */
 	u32 peak_states;
-	/* longest register parentage chain walked for liveness marking */
-	u32 longest_mark_read_walk;
 	/*
 	 * The program's fd_array comes in two shapes, told apart by whether
 	 * the caller passed fd_array_cnt. They are mutually exclusive:
@@ -1582,7 +1513,6 @@ int bpf_check_ext_prologue(struct bpf_verifier_log *log,
 			   const struct bpf_prog *tgt_prog, u32 btf_id);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
-int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
@@ -1633,25 +1563,15 @@ int bpf_find_latches(struct bpf_verifier_env *env, bool flags);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 
-void bpf_clear_jmp_history(struct bpf_verifier_state *state);
 int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 			    const struct bpf_verifier_state *src);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
-int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			 int insn_flags, int spi, int frame, const u16 *linked_regs,
-			 u8 linked_regs_cnt);
-void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
 void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm);
-void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg);
+void bpf_mark_reg_unknown(struct bpf_reg_state *reg);
 int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size);
-void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
-				  struct bpf_verifier_state *st);
 void bpf_clear_singular_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
-int bpf_mark_chain_precision(struct bpf_verifier_env *env,
-			     struct bpf_verifier_state *starting_state,
-			     int regno, bool *changed);
 
 static inline int bpf_get_spi(s32 off)
 {
@@ -1728,31 +1648,6 @@ static inline bool bpf_register_is_null(struct bpf_reg_state *reg)
 	return reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0);
 }
 
-static inline void bpf_bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
-{
-	bt->reg_masks[frame] |= 1 << reg;
-}
-
-static inline void bpf_bt_set_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	__set_bit(slot, bt->stack_masks[frame]);
-}
-
-static inline void bt_set_frame_stack_arg_slot(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	bt->stack_arg_masks[frame] |= 1 << slot;
-}
-
-static inline bool bt_is_frame_reg_set(struct backtrack_state *bt, u32 frame, u32 reg)
-{
-	return bt->reg_masks[frame] & (1 << reg);
-}
-
-static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	return test_bit(slot, bt->stack_masks[frame]);
-}
-
 bool bpf_map_is_rdonly(const struct bpf_map *map);
 struct bpf_func_ptr *bpf_map_func_ptrs(struct bpf_verifier_env *env,
 				       const struct bpf_map *map, u32 *cnt);
@@ -1974,7 +1869,6 @@ static inline int bpf_head_guard_target(const struct bpf_verifier_env *env, int
 
 	return aux->guard_at_header ? aux->guard_to : -1;
 }
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 /* Kinds of member a by-value struct or union may be composed of. */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index ab3ba42596ec..d26c62326e58 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o join.o flow.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
deleted file mode 100644
index a6e69c1f5ff6..000000000000
--- a/kernel/bpf/backtrack.c
+++ /dev/null
@@ -1,1059 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
-#include <linux/bpf.h>
-#include <linux/bpf_verifier.h>
-#include <linux/filter.h>
-#include <linux/bitmap.h>
-
-#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
-
-/* for any branch, call, exit record the history of jmps in the given state */
-int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			 int insn_flags, int spi, int frame, const u16 *linked_regs,
-			 u8 linked_regs_cnt)
-{
-	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
-	size_t alloc_size;
-
-	/* FLOW: nothing looks at the history */
-	return 0;
-
-	/* combine instruction flags if we already recorded this instruction */
-	if (env->cur_hist_ent) {
-		/* atomic instructions push insn_flags twice, for READ and
-		 * WRITE sides, but they should agree on stack slot
-		 */
-		verifier_bug_if((env->cur_hist_ent->flags & insn_flags) &&
-				(env->cur_hist_ent->flags & insn_flags) != insn_flags,
-				env, "insn history: insn_idx %d cur flags %x new flags %x",
-				env->insn_idx, env->cur_hist_ent->flags, insn_flags);
-		env->cur_hist_ent->flags |= insn_flags;
-		env->cur_hist_ent->spi = spi;
-		env->cur_hist_ent->frame = frame;
-		verifier_bug_if(env->cur_hist_ent->linked_regs_cnt != 0, env,
-				"insn history: insn_idx %d has %u linked regs",
-				env->insn_idx, env->cur_hist_ent->linked_regs_cnt);
-		if (linked_regs_cnt)
-			memcpy(env->cur_hist_ent->linked_regs, linked_regs,
-			       linked_regs_cnt * sizeof(*linked_regs));
-		env->cur_hist_ent->linked_regs_cnt = linked_regs_cnt;
-		return 0;
-	}
-
-	cnt++;
-	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p = krealloc(cur->jmp_history, alloc_size, GFP_KERNEL_ACCOUNT);
-	if (!p)
-		return -ENOMEM;
-	cur->jmp_history = p;
-
-	p = &cur->jmp_history[cnt - 1];
-	p->idx = env->insn_idx;
-	p->prev_idx = env->prev_insn_idx;
-	p->flags = insn_flags;
-	p->spi = spi;
-	p->frame = frame;
-	if (linked_regs_cnt)
-		memcpy(p->linked_regs, linked_regs, linked_regs_cnt * sizeof(*linked_regs));
-	p->linked_regs_cnt = linked_regs_cnt;
-	cur->jmp_history_cnt = cnt;
-	env->cur_hist_ent = p;
-
-	return 0;
-}
-
-static bool is_atomic_load_insn(const struct bpf_insn *insn)
-{
-	return BPF_CLASS(insn->code) == BPF_STX &&
-	       BPF_MODE(insn->code) == BPF_ATOMIC &&
-	       insn->imm == BPF_LOAD_ACQ;
-}
-
-static bool is_atomic_fetch_insn(const struct bpf_insn *insn)
-{
-	return BPF_CLASS(insn->code) == BPF_STX &&
-	       BPF_MODE(insn->code) == BPF_ATOMIC &&
-	       (insn->imm & BPF_FETCH);
-}
-
-/* Backtrack one insn at a time. If idx is not at the top of recorded
- * history then previous instruction came from straight line execution.
- * Return -ENOENT if we exhausted all instructions within given state.
- *
- * It's legal to have a bit of a looping with the same starting and ending
- * insn index within the same state, e.g.: 3->4->5->3, so just because current
- * instruction index is the same as state's first_idx doesn't mean we are
- * done. If there is still some jump history left, we should keep going. We
- * need to take into account that we might have a jump history between given
- * state's parent and itself, due to checkpointing. In this case, we'll have
- * history entry recording a jump from last instruction of parent state and
- * first instruction of given state.
- */
-static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
-			     u32 *history)
-{
-	u32 cnt = *history;
-
-	if (i == st->first_insn_idx) {
-		if (cnt == 0)
-			return -ENOENT;
-		if (cnt == 1 && st->jmp_history[0].idx == i)
-			return -ENOENT;
-	}
-
-	if (cnt && st->jmp_history[cnt - 1].idx == i) {
-		i = st->jmp_history[cnt - 1].prev_idx;
-		(*history)--;
-	} else {
-		i--;
-	}
-	return i;
-}
-
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
-						        u32 hist_end, int insn_idx)
-{
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
-		return &st->jmp_history[hist_end - 1];
-	return NULL;
-}
-
-static inline void bt_init(struct backtrack_state *bt, u32 frame)
-{
-	bt->frame = frame;
-}
-
-static inline void bt_reset(struct backtrack_state *bt)
-{
-	struct bpf_verifier_env *env = bt->env;
-
-	memset(bt, 0, sizeof(*bt));
-	bt->env = env;
-}
-
-static inline bool bt_frame_stack_empty(struct backtrack_state *bt, u32 frame)
-{
-	return bitmap_empty(bt->stack_masks[frame], MAX_BPF_STACK_SLOTS);
-}
-
-static inline bool bt_stack_empty(struct backtrack_state *bt)
-{
-	return bt_frame_stack_empty(bt, bt->frame);
-}
-
-static inline bool bt_empty(struct backtrack_state *bt)
-{
-	u32 mask = 0;
-	int i;
-
-	for (i = 0; i <= bt->frame; i++) {
-		mask |= bt->reg_masks[i] | bt->stack_arg_masks[i];
-		if (!bt_frame_stack_empty(bt, i))
-			return false;
-	}
-
-	return mask == 0;
-}
-
-static inline void bt_clear_frame_stack_arg_slot(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	bt->stack_arg_masks[frame] &= ~(1 << slot);
-}
-
-static inline bool bt_is_frame_stack_arg_slot_set(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	return bt->stack_arg_masks[frame] & (1 << slot);
-}
-
-static inline int bt_subprog_enter(struct backtrack_state *bt)
-{
-	if (bt->frame == MAX_CALL_FRAMES - 1) {
-		verifier_bug(bt->env, "subprog enter from frame %d", bt->frame);
-		return -EFAULT;
-	}
-	bt->frame++;
-	return 0;
-}
-
-static inline int bt_subprog_exit(struct backtrack_state *bt)
-{
-	if (bt->frame == 0) {
-		verifier_bug(bt->env, "subprog exit from frame 0");
-		return -EFAULT;
-	}
-	bt->frame--;
-	return 0;
-}
-
-static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
-{
-	bt->reg_masks[frame] &= ~(1 << reg);
-}
-
-static inline void bt_set_reg(struct backtrack_state *bt, u32 reg)
-{
-	bpf_bt_set_frame_reg(bt, bt->frame, reg);
-}
-
-static inline void bt_clear_reg(struct backtrack_state *bt, u32 reg)
-{
-	bt_clear_frame_reg(bt, bt->frame, reg);
-}
-
-static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u32 slot)
-{
-	__clear_bit(slot, bt->stack_masks[frame]);
-}
-
-static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 frame)
-{
-	return bt->reg_masks[frame];
-}
-
-static inline u32 bt_reg_mask(struct backtrack_state *bt)
-{
-	return bt->reg_masks[bt->frame];
-}
-
-static inline unsigned long *bt_frame_stack_mask(struct backtrack_state *bt, u32 frame)
-{
-	return bt->stack_masks[frame];
-}
-
-static inline unsigned long *bt_stack_mask(struct backtrack_state *bt)
-{
-	return bt_frame_stack_mask(bt, bt->frame);
-}
-
-static inline u32 bt_stack_arg_mask(struct backtrack_state *bt)
-{
-	return bt->stack_arg_masks[bt->frame];
-}
-
-static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
-{
-	return bt->reg_masks[bt->frame] & (1 << reg);
-}
-
-/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
-static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
-{
-	DECLARE_BITMAP(mask, 64);
-	bool first = true;
-	int i, n;
-
-	buf[0] = '\0';
-
-	bitmap_from_u64(mask, reg_mask);
-	for_each_set_bit(i, mask, 32) {
-		n = snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i);
-		first = false;
-		buf += n;
-		buf_sz -= n;
-		if (buf_sz < 0)
-			break;
-	}
-}
-
-/* format stack slots bitmask, e.g., "-8,-24,-40" for slots 0, 2 and 4 */
-void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask)
-{
-	bool first = true;
-	int i, n;
-
-	buf[0] = '\0';
-
-	for_each_set_bit(i, stack_mask, MAX_BPF_STACK_SLOTS) {
-		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
-		first = false;
-		buf += n;
-		buf_sz -= n;
-		if (buf_sz < 0)
-			break;
-	}
-}
-
-/* For given verifier state backtrack_insn() is called from the last insn to
- * the first insn. Its purpose is to compute a bitmask of registers and
- * stack slots that needs precision in the parent verifier state.
- *
- * @idx is an index of the instruction we are currently processing;
- * @subseq_idx is an index of the subsequent instruction that:
- *   - *would be* executed next, if jump history is viewed in forward order;
- *   - *was* processed previously during backtracking.
- */
-static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
-{
-	struct bpf_insn *insn = env->prog->insnsi + idx;
-	u8 class = BPF_CLASS(insn->code);
-	u8 opcode = BPF_OP(insn->code);
-	u8 mode = BPF_MODE(insn->code);
-	u32 dreg = insn->dst_reg;
-	u32 sreg = insn->src_reg;
-	u32 spi, i, fr;
-
-	if (insn->code == 0)
-		return 0;
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
-		verbose(env, "mark_precise: frame%d: regs=%s ",
-			bt->frame, env->tmp_str_buf);
-		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
-		verbose(env, "stack=%s before ", env->tmp_str_buf);
-		verbose(env, "%d: ", idx);
-		bpf_verbose_insn(env, insn);
-		verbose(env, "\n");
-	}
-
-	/* If there is a history record that some registers gained range at this insn,
-	 * propagate precision marks to those registers, so that bt_is_reg_set()
-	 * accounts for these registers.
-	 */
-	bpf_bt_sync_linked_regs(bt, hist);
-
-	if (class == BPF_ALU || class == BPF_ALU64) {
-		if (!bt_is_reg_set(bt, dreg))
-			return 0;
-		if (opcode == BPF_END || opcode == BPF_NEG) {
-			/* sreg is reserved and unused
-			 * dreg still need precision before this insn
-			 */
-			return 0;
-		} else if (opcode == BPF_MOV) {
-			if (BPF_SRC(insn->code) == BPF_X) {
-				/* dreg = sreg or dreg = (s8, s16, s32)sreg
-				 * dreg needs precision after this insn
-				 * sreg needs precision before this insn
-				 */
-				bt_clear_reg(bt, dreg);
-				if (sreg != BPF_REG_FP && sreg != BPF_REG_ARENA_SP)
-					bt_set_reg(bt, sreg);
-			} else {
-				/* dreg = K
-				 * dreg needs precision after this insn.
-				 * Corresponding register is already marked
-				 * as precise=true in this verifier state.
-				 * No further markings in parent are necessary
-				 */
-				bt_clear_reg(bt, dreg);
-			}
-		} else {
-			if (BPF_SRC(insn->code) == BPF_X) {
-				/* dreg += sreg
-				 * both dreg and sreg need precision
-				 * before this insn
-				 */
-				if (sreg != BPF_REG_FP)
-					bt_set_reg(bt, sreg);
-			} /* else dreg += K
-			   * dreg still needs precision before this insn
-			   */
-		}
-	} else if (class == BPF_LDX ||
-		   is_atomic_load_insn(insn) ||
-		   is_atomic_fetch_insn(insn)) {
-		u32 load_reg = dreg;
-
-		/*
-		 * Atomic fetch operation writes the old value into
-		 * a register (sreg or r0) and if it was tracked for
-		 * precision, propagate to the stack slot like we do
-		 * in regular ldx.
-		 */
-		if (is_atomic_fetch_insn(insn))
-			load_reg = insn->imm == BPF_CMPXCHG ?
-				   BPF_REG_0 : sreg;
-
-		if (!bt_is_reg_set(bt, load_reg))
-			return 0;
-		bt_clear_reg(bt, load_reg);
-
-		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
-			spi = hist->spi;
-			/*
-			 * Stack arg read: callee reads from r11+off, but
-			 * the data lives in the caller's stack_arg_regs.
-			 * Set the mask in the caller frame so precision
-			 * is marked in the caller's slot at the callee
-			 * entry checkpoint.
-			 */
-			bt_set_frame_stack_arg_slot(bt, bt->frame - 1, spi);
-			return 0;
-		}
-
-		/* scalars can only be spilled into stack w/o losing precision.
-		 * Load from any other memory can be zero extended.
-		 * The desire to keep that precision is already indicated
-		 * by 'precise' mark in corresponding register of this state.
-		 * No further tracking necessary.
-		 */
-		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
-			return 0;
-		/* dreg = *(u64 *)[fp - off] was a fill from the stack.
-		 * that [fp - off] slot contains scalar that needs to be
-		 * tracked with precision
-		 */
-		spi = hist->spi;
-		fr = hist->frame;
-		bpf_bt_set_frame_slot(bt, fr, spi);
-	} else if (class == BPF_STX || class == BPF_ST) {
-		if (bt_is_reg_set(bt, dreg))
-			/* stx & st shouldn't be using _scalar_ dst_reg
-			 * to access memory. It means backtracking
-			 * encountered a case of pointer subtraction.
-			 */
-			return -ENOTSUPP;
-
-		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
-			spi = hist->spi;
-			if (!bt_is_frame_stack_arg_slot_set(bt, bt->frame, spi))
-				return 0;
-			bt_clear_frame_stack_arg_slot(bt, bt->frame, spi);
-			if (class == BPF_STX)
-				bt_set_reg(bt, sreg);
-			return 0;
-		}
-
-		/* scalars can only be spilled into stack */
-		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
-			return 0;
-		spi = hist->spi;
-		fr = hist->frame;
-		if (!bt_is_frame_slot_set(bt, fr, spi))
-			return 0;
-		bt_clear_frame_slot(bt, fr, spi);
-		if (class == BPF_STX)
-			bt_set_reg(bt, sreg);
-	} else if (class == BPF_JMP || class == BPF_JMP32) {
-		if (bpf_pseudo_call(insn) || bpf_is_callx(insn)) {
-			int subprog_insn_idx, subprog = -1;
-
-			if (bpf_pseudo_call(insn)) {
-				subprog_insn_idx = idx + insn->imm + 1;
-				subprog = bpf_find_subprog(env, subprog_insn_idx);
-				if (subprog < 0)
-					return -EFAULT;
-			}
-
-			/* callx calls static subprogs only */
-			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
-				/* check that jump history doesn't have any
-				 * extra instructions from subprog; the next
-				 * instruction after call to global subprog
-				 * should be literally next instruction in
-				 * caller program
-				 */
-				verifier_bug_if(idx + 1 != subseq_idx, env,
-						"extra insn from subprog");
-				/* global subprog always sets R0 */
-				bt_clear_reg(bt, BPF_REG_0);
-				/* and if it does not set R2, main pass would catch it */
-				bt_clear_reg(bt, BPF_REG_2);
-				/* r1-r5 are invalidated after subprog call,
-				 * so for global func call it shouldn't be set
-				 * anymore
-				 */
-				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-					verifier_bug(env, "global subprog unexpected regs %x",
-						     bt_reg_mask(bt));
-					return -EFAULT;
-				}
-				return 0;
-			} else {
-				/* static subprog call instruction, which
-				 * means that we are exiting current subprog,
-				 * so only r1-r5 could be still requested as
-				 * precise, r0 and r6-r10 or any stack slot in
-				 * the current frame should be zero by now
-				 */
-				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-					verifier_bug(env, "static subprog unexpected regs %x",
-						     bt_reg_mask(bt));
-					return -EFAULT;
-				}
-				/* we are now tracking register spills correctly,
-				 * so any instance of leftover slots is a bug
-				 */
-				if (!bt_stack_empty(bt)) {
-					bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
-							   bt_stack_mask(bt));
-					verifier_bug(env, "static subprog leftover stack slots %s",
-						     env->tmp_str_buf);
-					return -EFAULT;
-				}
-				/* propagate r1-r5 to the caller */
-				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
-					if (bt_is_reg_set(bt, i)) {
-						bt_clear_reg(bt, i);
-						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
-					}
-				}
-				if (bt_stack_arg_mask(bt)) {
-					verifier_bug(env,
-						     "static subprog leftover stack arg slots %x",
-						     bt_stack_arg_mask(bt));
-					return -EFAULT;
-				}
-				if (bt_subprog_exit(bt))
-					return -EFAULT;
-				return 0;
-			}
-		} else if (bpf_is_sync_callback_calling_insn(insn) && idx != subseq_idx - 1) {
-			/* exit from callback subprog to callback-calling helper or
-			 * kfunc call. Use idx/subseq_idx check to discern it from
-			 * straight line code backtracking.
-			 * Unlike the subprog call handling above, we shouldn't
-			 * propagate precision of r1-r5 (if any requested), as they are
-			 * not actually arguments passed directly to callback subprogs
-			 */
-			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-				verifier_bug(env, "callback unexpected regs %x",
-					     bt_reg_mask(bt));
-				return -EFAULT;
-			}
-			if (!bt_stack_empty(bt)) {
-				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
-						   bt_stack_mask(bt));
-				verifier_bug(env, "callback leftover stack slots %s",
-					     env->tmp_str_buf);
-				return -EFAULT;
-			}
-			/* clear r1-r5 in callback subprog's mask */
-			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
-				bt_clear_reg(bt, i);
-			if (bt_subprog_exit(bt))
-				return -EFAULT;
-			return 0;
-		} else if (opcode == BPF_CALL) {
-			/* kfunc with imm==0 is invalid and fixup_kfunc_call will
-			 * catch this error later. Make backtracking conservative
-			 * with ENOTSUPP.
-			 */
-			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
-				return -ENOTSUPP;
-			/* regular helper call sets R0 */
-			bt_clear_reg(bt, BPF_REG_0);
-			/* kfunc might also set R2 */
-			bt_clear_reg(bt, BPF_REG_2);
-			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				/* if backtracking was looking for registers R1-R5
-				 * they should have been found already.
-				 */
-				verifier_bug(env, "backtracking call unexpected regs %x",
-					     bt_reg_mask(bt));
-				return -EFAULT;
-			}
-			if (insn->src_reg == BPF_REG_0 && insn->imm == BPF_FUNC_tail_call
-			    && subseq_idx - idx != 1) {
-				if (bt_subprog_enter(bt))
-					return -EFAULT;
-			}
-		} else if (opcode == BPF_EXIT) {
-			bool from_subprog_call, r0_precise, r2_precise;
-
-			/* BPF_EXIT in subprog or callback always returns
-			 * right after the call instruction, so by checking
-			 * whether the instruction at subseq_idx-1 is subprog
-			 * call or not we can distinguish actual exit from
-			 * *subprog* from exit from *callback*. In the former
-			 * case, we need to propagate the precision of the
-			 * return registers, if necessary. In the latter we
-			 * never do that.
-			 */
-			from_subprog_call = subseq_idx - 1 >= 0 &&
-					    (bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) ||
-					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1]));
-
-			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
-			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
-
-			/* Backtracking to a nested function call, 'idx' is a part of
-			 * the inner frame 'subseq_idx' is a part of the outer frame.
-			 * In case of a regular function call, the callee defines the
-			 * return registers R0 and R2, so clear them before checking
-			 * that instructions giving precision to registers R1-R5 have
-			 * been found already. R2 is also an argument register, hence
-			 * it has to be cleared before that check.
-			 * In case of a callback from bpf_loop(), R{1,4} in the calling
-			 * frame would be set as precise and that is correct, and R2
-			 * might be a precise helper argument as well, so leave it set.
-			 */
-			bt_clear_reg(bt, BPF_REG_0);
-			if (from_subprog_call)
-				bt_clear_reg(bt, BPF_REG_2);
-			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
-				verifier_bug(env, "backtracking exit unexpected regs %x",
-					     bt_reg_mask(bt));
-				return -EFAULT;
-			}
-
-			if (bt_subprog_enter(bt))
-				return -EFAULT;
-
-			if (r0_precise)
-				bt_set_reg(bt, BPF_REG_0);
-			if (r2_precise)
-				bt_set_reg(bt, BPF_REG_2);
-			/* r6-r9 and stack slots will stay set in caller frame
-			 * bitmasks until we return back from callee(s)
-			 */
-			return 0;
-		} else if (BPF_SRC(insn->code) == BPF_X) {
-			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
-				return 0;
-			/* dreg <cond> sreg
-			 * Both dreg and sreg need precision before
-			 * this insn. If only sreg was marked precise
-			 * before it would be equally necessary to
-			 * propagate it to dreg.
-			 */
-			if (!hist || !(hist->flags & INSN_F_SRC_REG_STACK))
-				bt_set_reg(bt, sreg);
-			if (!hist || !(hist->flags & INSN_F_DST_REG_STACK))
-				bt_set_reg(bt, dreg);
-		} else if (BPF_SRC(insn->code) == BPF_K) {
-			 /* dreg <cond> K
-			  * Only dreg still needs precision before
-			  * this insn, so for the K-based conditional
-			  * there is nothing new to be marked.
-			  */
-		}
-	} else if (class == BPF_LD) {
-		/* It's ld_imm64 or ld_abs or ld_ind.
-		 * For ld_imm64 no further tracking of precision
-		 * into parent is necessary
-		 */
-		if (mode == BPF_IMM) {
-			bt_clear_reg(bt, dreg);
-			return 0;
-		}
-		/*
-		 * BPF_{IND,ABS} are modelled as two branches:
-		 * - fallthrough;
-		 * - implicit subprogram exit.
-		 * It is necessary to switch current frame if
-		 * implicit subprogram exit branch is backtracked.
-		 */
-		if (mode == BPF_IND || mode == BPF_ABS) {
-			if (bt_is_reg_set(bt, dreg))
-				return -ENOTSUPP;
-			if (subseq_idx != idx + 1)
-				if (bt_subprog_enter(bt))
-					return -EFAULT;
-			return 0;
-		}
-	}
-	/* Propagate precision marks to linked registers, to account for
-	 * registers marked as precise in this function.
-	 */
-	bpf_bt_sync_linked_regs(bt, hist);
-	return 0;
-}
-
-/* the scalar precision tracking algorithm:
- * . at the start all registers have precise=false.
- * . scalar ranges are tracked as normal through alu and jmp insns.
- * . once precise value of the scalar register is used in:
- *   .  ptr + scalar alu
- *   . if (scalar cond K|scalar)
- *   .  helper_call(.., scalar, ...) where ARG_CONST is expected
- *   backtrack through the verifier states and mark all registers and
- *   stack slots with spilled constants that these scalar registers
- *   should be precise.
- * . during state pruning two registers (or spilled stack slots)
- *   are equivalent if both are not precise.
- *
- * Note the verifier cannot simply walk register parentage chain,
- * since many different registers and stack slots could have been
- * used to compute single precise scalar.
- *
- * The approach of starting with precise=true for all registers and then
- * backtrack to mark a register as not precise when the verifier detects
- * that program doesn't care about specific value (e.g., when helper
- * takes register as ARG_ANYTHING parameter) is not safe.
- *
- * It's ok to walk single parentage chain of the verifier states.
- * It's possible that this backtracking will go all the way till 1st insn.
- * All other branches will be explored for needing precision later.
- *
- * The backtracking needs to deal with cases like:
- *   R8=map_value(id=0,off=0,ks=4,vs=1952,imm=0) R9_w=map_value(id=0,off=40,ks=4,vs=1952,imm=0)
- * r9 -= r8
- * r5 = r9
- * if r5 > 0x79f goto pc+7
- *    R5_w=inv(id=0,umax_value=1951,var_off=(0x0; 0x7ff))
- * r5 += 1
- * ...
- * call bpf_perf_event_output#25
- *   where .arg5_type = ARG_MEM_SIZE_OR_ZERO
- *
- * and this case:
- * r6 = 1
- * call foo // uses callee's r6 inside to compute r0
- * r0 += r6
- * if r0 == 0 goto
- *
- * to track above reg_mask/stack_mask needs to be independent for each frame.
- *
- * Also if parent's curframe > frame where backtracking started,
- * the verifier need to mark registers in both frames, otherwise callees
- * may incorrectly prune callers. This is similar to
- * commit 7640ead93924 ("bpf: verifier: make sure callees don't prune with caller differences")
- *
- * For now backtracking falls back into conservative marking.
- */
-void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
-				 struct bpf_verifier_state *st)
-{
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	int i, j;
-
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "mark_precise: frame%d: falling back to forcing all scalars precise\n",
-			st->curframe);
-	}
-
-	/* big hammer: mark all scalars precise in this path.
-	 * pop_stack may still get !precise scalars.
-	 * We also skip current state and go straight to first parent state,
-	 * because precision markings in current non-checkpointed state are
-	 * not needed. See why in the comment in __mark_chain_precision below.
-	 */
-	for (st = st->parent; st; st = st->parent) {
-		for (i = 0; i <= st->curframe; i++) {
-			func = st->frame[i];
-			for (j = 0; j < BPF_REG_FP; j++) {
-				reg = &func->regs[j];
-				if (reg->type != SCALAR_VALUE || reg->precise)
-					continue;
-				reg->precise = true;
-				if (env->log.level & BPF_LOG_LEVEL2) {
-					verbose(env, "force_precise: frame%d: forcing r%d to be precise\n",
-						i, j);
-				}
-			}
-			for (j = 0; j < bpf_stack_nr_slots(func); j++) {
-				struct bpf_stack_state *ss = bpf_stack_slot(func, j);
-
-				if (!bpf_is_spilled_reg(ss))
-					continue;
-				reg = &ss->spilled_ptr;
-				if (reg->type != SCALAR_VALUE || reg->precise)
-					continue;
-				reg->precise = true;
-				if (env->log.level & BPF_LOG_LEVEL2) {
-					verbose(env, "force_precise: frame%d: forcing fp%d to be precise\n",
-						i, -(j + 1) * 8);
-				}
-			}
-			for (j = 0; j < func->out_stack_arg_cnt; j++) {
-				reg = &func->stack_arg_regs[j];
-				if (reg->type != SCALAR_VALUE || reg->precise)
-					continue;
-				reg->precise = true;
-				if (env->log.level & BPF_LOG_LEVEL2) {
-					verbose(env,
-						"force_precise: frame%d: forcing r11%d to be precise\n",
-						i, -(j + 1) * BPF_REG_SIZE);
-				}
-			}
-		}
-	}
-}
-
-/*
- * bpf_mark_chain_precision() backtracks BPF program instruction sequence and
- * chain of verifier states making sure that register *regno* (if regno >= 0)
- * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
- * SCALARS, as well as any other registers and slots that contribute to
- * a tracked state of given registers/stack slots, depending on specific BPF
- * assembly instructions (see backtrack_insns() for exact instruction handling
- * logic). This backtracking relies on recorded jmp_history and is able to
- * traverse entire chain of parent states. This process ends only when all the
- * necessary registers/slots and their transitive dependencies are marked as
- * precise.
- *
- * One important and subtle aspect is that precise marks *do not matter* in
- * the currently verified state (current state). It is important to understand
- * why this is the case.
- *
- * First, note that current state is the state that is not yet "checkpointed",
- * i.e., it is not yet put into env->explored_states, and it has no children
- * states as well. It's ephemeral, and can end up either a) being discarded if
- * compatible explored state is found at some point or BPF_EXIT instruction is
- * reached or b) checkpointed and put into env->explored_states, branching out
- * into one or more children states.
- *
- * In the former case, precise markings in current state are completely
- * ignored by state comparison code (see regsafe() for details). Only
- * checkpointed ("old") state precise markings are important, and if old
- * state's register/slot is precise, regsafe() assumes current state's
- * register/slot as precise and checks value ranges exactly and precisely. If
- * states turn out to be compatible, current state's necessary precise
- * markings and any required parent states' precise markings are enforced
- * after the fact with propagate_precision() logic, after the fact. But it's
- * important to realize that in this case, even after marking current state
- * registers/slots as precise, we immediately discard current state. So what
- * actually matters is any of the precise markings propagated into current
- * state's parent states, which are always checkpointed (due to b) case above).
- * As such, for scenario a) it doesn't matter if current state has precise
- * markings set or not.
- *
- * Now, for the scenario b), checkpointing and forking into child(ren)
- * state(s). Note that before current state gets to checkpointing step, any
- * processed instruction always assumes precise SCALAR register/slot
- * knowledge: if precise value or range is useful to prune jump branch, BPF
- * verifier takes this opportunity enthusiastically. Similarly, when
- * register's value is used to calculate offset or memory address, exact
- * knowledge of SCALAR range is assumed, checked, and enforced. So, similar to
- * what we mentioned above about state comparison ignoring precise markings
- * during state comparison, BPF verifier ignores and also assumes precise
- * markings *at will* during instruction verification process. But as verifier
- * assumes precision, it also propagates any precision dependencies across
- * parent states, which are not yet finalized, so can be further restricted
- * based on new knowledge gained from restrictions enforced by their children
- * states. This is so that once those parent states are finalized, i.e., when
- * they have no more active children state, state comparison logic in
- * is_state_visited() would enforce strict and precise SCALAR ranges, if
- * required for correctness.
- *
- * To build a bit more intuition, note also that once a state is checkpointed,
- * the path we took to get to that state is not important. This is crucial
- * property for state pruning. When state is checkpointed and finalized at
- * some instruction index, it can be correctly and safely used to "short
- * circuit" any *compatible* state that reaches exactly the same instruction
- * index. I.e., if we jumped to that instruction from a completely different
- * code path than original finalized state was derived from, it doesn't
- * matter, current state can be discarded because from that instruction
- * forward having a compatible state will ensure we will safely reach the
- * exit. States describe preconditions for further exploration, but completely
- * forget the history of how we got here.
- *
- * This also means that even if we needed precise SCALAR range to get to
- * finalized state, but from that point forward *that same* SCALAR register is
- * never used in a precise context (i.e., it's precise value is not needed for
- * correctness), it's correct and safe to mark such register as "imprecise"
- * (i.e., precise marking set to false). This is what we rely on when we do
- * not set precise marking in current state. If no child state requires
- * precision for any given SCALAR register, it's safe to dictate that it can
- * be imprecise. If any child state does require this register to be precise,
- * we'll mark it precise later retroactively during precise markings
- * propagation from child state to parent states.
- *
- * Skipping precise marking setting in current state is a mild version of
- * relying on the above observation. But we can utilize this property even
- * more aggressively by proactively forgetting any precise marking in the
- * current state (which we inherited from the parent state), right before we
- * checkpoint it and branch off into new child state. This is done by
- * mark_all_scalars_imprecise() to hopefully get more permissive and generic
- * finalized states which help in short circuiting more future states.
- */
-int bpf_mark_chain_precision(struct bpf_verifier_env *env,
-			    struct bpf_verifier_state *starting_state,
-			    int regno,
-			    bool *changed)
-{
-	struct bpf_verifier_state *st = starting_state;
-	struct backtrack_state *bt = &env->bt;
-	int first_idx = st->first_insn_idx;
-	int last_idx = starting_state->insn_idx;
-	int subseq_idx = -1;
-	struct bpf_func_state *func;
-	bool tmp, skip_first = true;
-	struct bpf_stack_state *ss;
-
-	/* FLOW: there are no precision marks */
-	bt_reset(bt);
-	return 0;
-	struct bpf_reg_state *reg;
-	int i, fr, err;
-
-	if (!env->bpf_capable)
-		return 0;
-
-	changed = changed ?: &tmp;
-	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, starting_state->curframe);
-
-	/* Do sanity checks against current state of register and/or stack
-	 * slot, but don't set precise flag in current state, as precision
-	 * tracking in the current state is unnecessary.
-	 */
-	func = st->frame[bt->frame];
-	if (regno >= 0) {
-		reg = &func->regs[regno];
-		if (reg->type != SCALAR_VALUE) {
-			verifier_bug(env, "backtracking misuse");
-			return -EFAULT;
-		}
-		bt_set_reg(bt, regno);
-	}
-
-	if (bt_empty(bt))
-		return 0;
-
-	for (;;) {
-		DECLARE_BITMAP(mask, 64);
-		u32 history = st->jmp_history_cnt;
-		struct bpf_jmp_history_entry *hist;
-
-		if (env->log.level & BPF_LOG_LEVEL2) {
-			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
-				bt->frame, last_idx, first_idx, subseq_idx);
-		}
-
-		if (last_idx < 0) {
-			/* Consecutive checkpoints can have no instructions between them. */
-			if (st->parent)
-				goto parent;
-
-			/* we are at the entry into subprog, which
-			 * is expected for global funcs, but only if
-			 * requested precise registers are R1-R5
-			 * (which are global func's input arguments)
-			 */
-			if (st->curframe == 0 &&
-			    st->frame[0]->subprogno > 0 &&
-			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
-			    bt_stack_empty(bt) &&
-			    (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) == 0) {
-				bitmap_from_u64(mask, bt_reg_mask(bt));
-				for_each_set_bit(i, mask, 32) {
-					reg = &st->frame[0]->regs[i];
-					bt_clear_reg(bt, i);
-					if (reg->type == SCALAR_VALUE) {
-						reg->precise = true;
-						*changed = true;
-					}
-				}
-				return 0;
-			}
-
-			bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
-			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %s",
-				     st->frame[0]->subprogno, bt_reg_mask(bt), env->tmp_str_buf);
-			return -EFAULT;
-		}
-
-		for (i = last_idx;;) {
-			if (skip_first) {
-				err = 0;
-				skip_first = false;
-			} else {
-				hist = get_jmp_hist_entry(st, history, i);
-				err = backtrack_insn(env, i, subseq_idx, hist, bt);
-			}
-			if (err == -ENOTSUPP) {
-				bpf_mark_all_scalars_precise(env, starting_state);
-				bt_reset(bt);
-				return 0;
-			} else if (err) {
-				return err;
-			}
-			if (bt_empty(bt))
-				/* Found assignment(s) into tracked register in this state.
-				 * Since this state is already marked, just return.
-				 * Nothing to be tracked further in the parent state.
-				 */
-				return 0;
-			subseq_idx = i;
-			i = get_prev_insn_idx(st, i, &history);
-			if (i == -ENOENT)
-				break;
-			if (i >= env->prog->len) {
-				/* This can happen if backtracking reached insn 0
-				 * and there are still reg_mask or stack_mask
-				 * to backtrack.
-				 * It means the backtracking missed the spot where
-				 * particular register was initialized with a constant.
-				 */
-				verifier_bug(env, "backtracking idx %d", i);
-				return -EFAULT;
-			}
-		}
-parent:
-		st = st->parent;
-		if (!st)
-			break;
-
-		for (fr = bt->frame; fr >= 0; fr--) {
-			func = st->frame[fr];
-			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
-			for_each_set_bit(i, mask, 32) {
-				reg = &func->regs[i];
-				if (reg->type != SCALAR_VALUE) {
-					bt_clear_frame_reg(bt, fr, i);
-					continue;
-				}
-				if (reg->precise) {
-					bt_clear_frame_reg(bt, fr, i);
-				} else {
-					reg->precise = true;
-					*changed = true;
-				}
-			}
-
-			for_each_set_bit(i, bt_frame_stack_mask(bt, fr), MAX_BPF_STACK_SLOTS) {
-				if (verifier_bug_if(i >= bpf_stack_nr_slots(func),
-						    env, "stack slot %d, total slots %d",
-						    i, bpf_stack_nr_slots(func)))
-					return -EFAULT;
-
-				ss = bpf_stack_slot(func, i);
-				if (!bpf_is_spilled_scalar_reg(ss)) {
-					bt_clear_frame_slot(bt, fr, i);
-					continue;
-				}
-				reg = &ss->spilled_ptr;
-				if (reg->precise) {
-					bt_clear_frame_slot(bt, fr, i);
-				} else {
-					reg->precise = true;
-					*changed = true;
-				}
-			}
-			for (i = 0; i < func->out_stack_arg_cnt; i++) {
-				if (!bt_is_frame_stack_arg_slot_set(bt, fr, i))
-					continue;
-				reg = &func->stack_arg_regs[i];
-				if (reg->type != SCALAR_VALUE || reg->precise) {
-					bt_clear_frame_stack_arg_slot(bt, fr, i);
-				} else {
-					reg->precise = true;
-					*changed = true;
-				}
-			}
-			if (env->log.level & BPF_LOG_LEVEL2) {
-				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
-					     bt_frame_reg_mask(bt, fr));
-				verbose(env, "mark_precise: frame%d: parent state regs=%s ",
-					fr, env->tmp_str_buf);
-				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
-					       bt_frame_stack_mask(bt, fr));
-				verbose(env, "stack=%s: ", env->tmp_str_buf);
-				print_verifier_state(env, st, fr, true);
-			}
-		}
-
-		if (bt_empty(bt))
-			return 0;
-
-		subseq_idx = first_idx;
-		last_idx = st->last_insn_idx;
-		first_idx = st->first_insn_idx;
-	}
-
-	/* if we still have requested precise regs or slots, we missed
-	 * something (e.g., stack access through non-r10 register), so
-	 * fallback to marking all precise
-	 */
-	if (!bt_empty(bt)) {
-		bpf_mark_all_scalars_precise(env, starting_state);
-		bt_reset(bt);
-	}
-
-	return 0;
-}
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 00cb219e24cd..db496253bf62 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -637,8 +637,6 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	const char *sep = "";
 
 	t = reg->type;
-	if (t == SCALAR_VALUE && reg->precise)
-		verbose(env, "P");
 	if (t == SCALAR_VALUE && tnum_is_const(reg->var_off)) {
 		bpf_verbose_snum(env, reg->var_off.value);
 		return;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 677b64a63be4..de7592424056 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1912,7 +1912,7 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 		return -ENOMEM;
 	env->scev = scev;
 	bpf_mark_reg_known_scalar(&scev->zero_reg, 0);
-	bpf_mark_reg_unknown_imprecise(&scev->unknown_reg);
+	bpf_mark_reg_unknown(&scev->unknown_reg);
 	/* A power of two for hash & (exprs_ht_cnt - 1)` indexing. */
 	scev->exprs_ht_cnt = roundup_pow_of_two(max(256U, DIV_ROUND_UP(env->prog->len, 4)));
 	scev->exprs_ht = kvcalloc(scev->exprs_ht_cnt, sizeof(*scev->exprs_ht), GFP_KERNEL_ACCOUNT);
@@ -3256,30 +3256,6 @@ static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
 		bounds->r64 = r64;
 }
 
-static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 id,
-			     unsigned long *precise_regs)
-{
-	struct scev *scev = env->scev;
-	struct bpf_reg_state *reg;
-	u32 r, order;
-
-	scev->stack_sz = 0;
-	expr_stack_push(scev, id);
-	while (expr_next(scev, &id, &order)) {
-		if (order & DEPTH_LIMIT) {
-			verifier_bug(env, "scev precision marking exceeds expression depth limit");
-			return -EFAULT;
-		}
-		if (!(order & PRE) || !is_reg(scev, id, &r))
-			continue;
-		/* Synthetic values have no spilled register to mark precise. */
-		reg = scev_reg_for_linear(st, r) ?: scev_reg_for_spill32(st, r);
-		if (reg && reg->type == SCALAR_VALUE)
-			__set_bit(r, precise_regs);
-	}
-	return 0;
-}
-
 /*
  * Does @id have no bit that register @r doesn't have at the head of the loop? 'x & e' and the
  * low bits of x lose bits only. 'x >> e', 'x / e' and 'x % e' are not greater than x as well, but
@@ -3434,17 +3410,11 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	 * which iterations it can be taken. The loop ends, at the latest, in an iteration
 	 * in which no back edge can be taken.
 	 */
-	bitmap_zero(iters->precise_regs, REGS_NUM);
 	for (i = 0; i < loop->backedges_cnt; i++) {
 		err = count_backedge(env, cur_func, insn_idx, &loop->backedges[i],
 				     i ? &tmp : iters, &latch, &until);
 		if (err <= 0)
 			return err;
-		err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs) ?:
-		      mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs) ?:
-		      mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);
-		if (err)
-			return err;
 		if (!i) {
 			false_until = until;
 			first = latch;
@@ -3694,16 +3664,6 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 	int insn_idx = st->insn_idx;
 	int err;
 
-	for_each_set_bit(r, iters->precise_regs, REGS_NUM) {
-		if (r < MAX_BPF_REG)
-			bpf_bt_set_frame_reg(&env->bt, st->curframe, r);
-		else
-			bpf_bt_set_frame_slot(&env->bt, st->curframe, r - MAX_BPF_REG);
-	}
-	err = bpf_mark_chain_precision(env, st, -1, NULL);
-	if (err)
-		return err;
-
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
 		if (!scev_reg_alive(env, st, r))
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 343f29b52d79..5935e16730fd 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -5,8 +5,6 @@
 #include <linux/cnum.h>
 #include <linux/filter.h>
 
-#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
-
 /* check %cur's range satisfies %old's */
 static bool range_within(const struct bpf_reg_state *old,
 			 const struct bpf_reg_state *cur)
@@ -182,10 +180,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 				if (lo_live && stype == STACK_SPILL) {
 					if (spill->type != SCALAR_VALUE)
 						continue;
-					/*
-					 * Can't replace with STACK_ZERO, because
-					 * that requires bpf_mark_chain_precision().
-					 */
+					/* keep what is known about the low half */
 					if (bpf_register_is_null(spill))
 						continue;
 					for (j = 0; j < 4; j++) {
@@ -281,8 +276,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise && exact == NOT_EXACT)
-			return true;
 		/*
 		 * Linked register tracking uses rold->id to detect relationships.
 		 * When rold->id == 0, the register is independent and any linking
@@ -394,7 +387,7 @@ static struct bpf_reg_state unbound_reg;
 
 static __init int unbound_reg_init(void)
 {
-	bpf_mark_reg_unknown_imprecise(&unbound_reg);
+	bpf_mark_reg_unknown(&unbound_reg);
 	return 0;
 }
 late_initcall(unbound_reg_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 616a69b4cfb5..85dae0feeb1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -302,11 +302,6 @@ static int arg_from_argno(argno_t a)
 	return -1;
 }
 
-static int arg_idx_from_argno(argno_t a)
-{
-	return arg_from_argno(a) - 1;
-}
-
 /* Normalize helper register numbers and kfunc argument numbers to ABI slots. */
 static u32 arg_slot_from_argno(argno_t a)
 {
@@ -856,15 +851,12 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 				      : reg->id);
 }
 
-static void __mark_reg_unknown(const struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg);
-
 static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	if (!env->allow_ptr_leaks)
 		bpf_mark_reg_not_init(env, reg);
 	else
-		__mark_reg_unknown(env, reg);
+		bpf_mark_reg_unknown(reg);
 }
 
 static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
@@ -1754,13 +1746,6 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
-void bpf_clear_jmp_history(struct bpf_verifier_state *state)
-{
-	kfree(state->jmp_history);
-	state->jmp_history = NULL;
-	state->jmp_history_cnt = 0;
-}
-
 void bpf_free_verifier_state(struct bpf_verifier_state *state,
 			    bool free_self)
 {
@@ -1771,7 +1756,6 @@ void bpf_free_verifier_state(struct bpf_verifier_state *state,
 		state->frame[i] = NULL;
 	}
 	kfree(state->refs);
-	bpf_clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1798,13 +1782,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
-	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
-					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_KERNEL_ACCOUNT);
-	if (!dst_state->jmp_history)
-		return -ENOMEM;
-	dst_state->jmp_history_cnt = src->jmp_history_cnt;
-
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1823,8 +1800,6 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
-	dst_state->parent = src->parent;
-	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
@@ -2094,14 +2069,10 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg)
 	__mark_reg_known(reg, 0);
 }
 
-static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static void __mark_reg_const_zero(struct bpf_reg_state *reg)
 {
 	__mark_reg_known(reg, 0);
 	reg->type = SCALAR_VALUE;
-	/* all scalars are assumed imprecise initially (unless unprivileged,
-	 * in which case everything is forced to be precise)
-	 */
-	reg->precise = !env->bpf_capable;
 }
 
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
@@ -2434,7 +2405,7 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 }
 
 /* Mark a register as having a completely unknown (scalar) value. */
-void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
+void bpf_mark_reg_unknown(struct bpf_reg_state *reg)
 {
 	memset(reg, 0, sizeof(*reg));
 	reg->type = SCALAR_VALUE;
@@ -2443,20 +2414,10 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 	reg_step_reset(reg);
 }
 
-/* Mark a register as having a completely unknown (scalar) value,
- * initialize .precise as true when not bpf capable.
- */
-static void __mark_reg_unknown(const struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg)
-{
-	bpf_mark_reg_unknown_imprecise(reg);
-	reg->precise = !env->bpf_capable;
-}
-
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
-	__mark_reg_unknown(env, regs + regno);
+	bpf_mark_reg_unknown(regs + regno);
 }
 
 static int __mark_reg_s32_range(struct bpf_verifier_env *env,
@@ -2482,7 +2443,7 @@ static int __mark_reg_s32_range(struct bpf_verifier_env *env,
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg)
 {
-	__mark_reg_unknown(env, reg);
+	bpf_mark_reg_unknown(reg);
 	reg->type = NOT_INIT;
 }
 
@@ -3628,19 +3589,7 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].non_stack_access = true;
 }
 
-/* Layout of one packed linked register in the jump history, see linked_regs_pack() */
-#define LR_FRAMENO_BITS	5
-#define LR_INDEX_BITS	10
-#define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
-#define LR_IS_REG	BIT(LR_FRAMENO_BITS)
-#define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)
-#define LR_INDEX_MASK	((1u << LR_INDEX_BITS) - 1)
-#define LINKED_REGS_MAX	BPF_LINKED_REGS_MAX
-
-static_assert(MAX_CALL_FRAMES <= (1 << LR_FRAMENO_BITS));
-static_assert(MAX_BPF_REG <= (1 << LR_INDEX_BITS));
-static_assert(MAX_BPF_STACK_SLOTS <= (1 << LR_INDEX_BITS));
-static_assert(LR_INDEX_OFF + LR_INDEX_BITS <= 16);
+#define LINKED_REGS_MAX	5
 
 struct linked_reg {
 	u8 frameno;
@@ -3664,38 +3613,6 @@ static struct linked_reg *linked_regs_push(struct linked_regs *s)
 	return NULL;
 }
 
-/*
- * Pack linked registers for a jump history entry, one u16 each:
- * - 5 bits frameno
- * - 1 bit  is_reg
- * - 10 bits register or stack slot index
- */
-static void linked_regs_pack(const struct linked_regs *s, u16 *packed)
-{
-	int i;
-
-	for (i = 0; i < s->cnt; ++i) {
-		const struct linked_reg *e = &s->entries[i];
-
-		packed[i] = e->frameno | (e->is_reg ? LR_IS_REG : 0) | (e->spi << LR_INDEX_OFF);
-	}
-}
-
-static void linked_regs_unpack(const struct bpf_jmp_history_entry *hist, struct linked_regs *s)
-{
-	int i;
-
-	s->cnt = hist->linked_regs_cnt;
-	for (i = 0; i < s->cnt; ++i) {
-		struct linked_reg *e = &s->entries[i];
-		u16 packed = hist->linked_regs[i];
-
-		e->frameno = packed & LR_FRAMENO_MASK;
-		e->is_reg  = packed & LR_IS_REG;
-		e->spi     = (packed >> LR_INDEX_OFF) & LR_INDEX_MASK;
-	}
-}
-
 const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 {
 	const struct btf_type *func;
@@ -3725,56 +3642,6 @@ void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 }
 
-/* If any register R in hist->linked_regs is marked as precise in bt,
- * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_regs.
- */
-void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
-{
-	struct linked_regs linked_regs;
-	bool some_precise = false;
-	int i;
-
-	if (!hist || !hist->linked_regs_cnt)
-		return;
-
-	linked_regs_unpack(hist, &linked_regs);
-	for (i = 0; i < linked_regs.cnt; ++i) {
-		struct linked_reg *e = &linked_regs.entries[i];
-
-		if ((e->is_reg && bt_is_frame_reg_set(bt, e->frameno, e->regno)) ||
-		    (!e->is_reg && bt_is_frame_slot_set(bt, e->frameno, e->spi))) {
-			some_precise = true;
-			break;
-		}
-	}
-
-	if (!some_precise)
-		return;
-
-	for (i = 0; i < linked_regs.cnt; ++i) {
-		struct linked_reg *e = &linked_regs.entries[i];
-
-		if (e->is_reg)
-			bpf_bt_set_frame_reg(bt, e->frameno, e->regno);
-		else
-			bpf_bt_set_frame_slot(bt, e->frameno, e->spi);
-	}
-}
-
-int mark_chain_precision(struct bpf_verifier_env *env, int regno)
-{
-	return bpf_mark_chain_precision(env, env->cur_state, regno, NULL);
-}
-
-/* mark_chain_precision_batch() assumes that env->bt is set in the caller to
- * desired reg and stack masks across all relevant frames
- */
-static int mark_chain_precision_batch(struct bpf_verifier_env *env,
-				      struct bpf_verifier_state *starting_state)
-{
-	return bpf_mark_chain_precision(env, starting_state, -1, NULL);
-}
-
 /* check if register is a constant scalar value */
 static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
 {
@@ -3905,8 +3772,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
-	int insn_flags = INSN_F_STACK_ACCESS;
-	int hist_spi = spi, hist_frame = state->frameno;
 	struct bpf_stack_state *ss = bpf_stack_slot(state, spi);
 
 	/*
@@ -3996,28 +3861,14 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && bpf_register_is_null(reg)) ||
-		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
-			/* STACK_ZERO case happened because register spill
-			 * wasn't properly aligned at the stack slot boundary,
-			 * so it's not a register spill anymore; force
-			 * originating register to be precise to make
-			 * STACK_ZERO correct for subsequent states
-			 */
-			err = mark_chain_precision(env, value_regno);
-			if (err)
-				return err;
+		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0))
 			type = STACK_ZERO;
-		}
 
 		/* Mark slots affected by this stack write. */
 		for (i = 0; i < size; i++)
 			ss->slot_type[(slot - i) % BPF_REG_SIZE] = type;
-		insn_flags = 0; /* not a register spill */
 	}
 
-	if (insn_flags)
-		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
-					    hist_spi, hist_frame, NULL, 0);
 	return 0;
 }
 
@@ -4051,10 +3902,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *value_reg = NULL;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	bool writing_zero = false;
-	/* set if the fact that we're writing a zero is used to let any
-	 * stack slots remain STACK_ZERO
-	 */
-	bool zero_used = false;
 
 	cur = env->cur_state->frame[env->cur_state->curframe];
 	min_off = reg_smin(ptr_reg) + off;
@@ -4105,10 +3952,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		if (writing_zero && *stype == STACK_SPILL && bpf_is_spilled_scalar_reg(ss)) {
 			struct bpf_reg_state *spill_reg = &ss->spilled_ptr;
 
-			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
-				zero_used = true;
+			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0)
 				continue;
-			}
 		}
 
 		/*
@@ -4121,10 +3966,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 
 		/* Update the slot type. */
 		new_type = STACK_MISC;
-		if (writing_zero && *stype == STACK_ZERO) {
+		if (writing_zero && *stype == STACK_ZERO)
 			new_type = STACK_ZERO;
-			zero_used = true;
-		}
 		/* If the slot is STACK_INVALID, we check whether it's OK to
 		 * pretend that it will be initialized by this write. The slot
 		 * might not actually be written to, and so if we mark it as
@@ -4142,12 +3985,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		}
 		*stype = new_type;
 	}
-	if (zero_used) {
-		/* backtracking doesn't work for STACK_ZERO yet. */
-		err = mark_chain_precision(env, value_regno);
-		if (err)
-			return err;
-	}
 	bpf_diag_record_scrub_stack(env, state, min_off, max_off,
 				    BPF_DIAG_MOD_VAR_WRITE);
 	return 0;
@@ -4162,21 +3999,18 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
  * read.
  *
  * STACK_SPILL bytes backed by spilled scalar const zeroes are also considered
- * zero bytes. In that case, mark the contributing stack slots precise so
- * pruning cannot reuse a zero-spill state for a later non-zero spill state.
- *
- * Returns an error if precision backtracking fails.
+ * zero bytes.
  */
-static int mark_reg_stack_read(struct bpf_verifier_env *env,
-			       /* func where src register points to */
-			       struct bpf_func_state *ptr_state,
-			       int min_off, int max_off, int dst_regno)
+static void mark_reg_stack_read(struct bpf_verifier_env *env,
+				/* func where src register points to */
+				struct bpf_func_state *ptr_state,
+				int min_off, int max_off, int dst_regno)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	int i, slot, spi;
 	u8 *stype;
-	int zeros = 0, zero_spills = 0;
+	int zeros = 0;
 
 	for (i = min_off; i < max_off; i++) {
 		slot = -i - 1;
@@ -4189,7 +4023,6 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		}
 		if (stype[slot % BPF_REG_SIZE] == STACK_SPILL &&
 		    bpf_register_is_null(&bpf_stack_slot(ptr_state, spi)->spilled_ptr)) {
-			zero_spills++;
 			zeros++;
 			continue;
 		}
@@ -4199,23 +4032,11 @@ static int mark_reg_stack_read(struct bpf_verifier_env *env,
 		/* Any access_size read into register is zero extended,
 		 * so the whole register == const_zero.
 		 */
-		__mark_reg_const_zero(env, &state->regs[dst_regno]);
-		if (zero_spills) {
-			for (i = min_off; i < max_off; i++) {
-				slot = -i - 1;
-				spi = slot / BPF_REG_SIZE;
-				stype = bpf_stack_slot(ptr_state, spi)->slot_type;
-				if (stype[slot % BPF_REG_SIZE] == STACK_SPILL)
-					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
-			}
-			return mark_chain_precision_batch(env, env->cur_state);
-		}
+		__mark_reg_const_zero(&state->regs[dst_regno]);
 	} else {
 		/* have read misc data from the stack */
 		mark_reg_unknown(env, state->regs, dst_regno);
 	}
-
-	return 0;
 }
 
 static void bpf_diag_stack_read_invalid(struct bpf_verifier_env *env, int off, int i, int size,
@@ -4279,9 +4100,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
-	int err;
-	int insn_flags = INSN_F_STACK_ACCESS;
-	int hist_spi = spi, hist_frame = reg_state->frameno;
 	struct bpf_stack_state *ss = bpf_stack_slot(reg_state, spi);
 
 	stype = ss->slot_type;
@@ -4356,18 +4174,13 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				if (spill_cnt == size &&
 				    tnum_is_const(reg->var_off) && reg->var_off.value == 0) {
-					__mark_reg_const_zero(env, &state->regs[dst_regno]);
-					/* this IS register fill, so keep insn_flags */
+					__mark_reg_const_zero(&state->regs[dst_regno]);
 				} else if (zero_cnt == size) {
 					/* similarly to mark_reg_stack_read(), preserve zeroes */
-					__mark_reg_const_zero(env, &state->regs[dst_regno]);
-					insn_flags = 0; /* not restoring original register state */
+					__mark_reg_const_zero(&state->regs[dst_regno]);
 				} else {
-					err = mark_reg_stack_read(env, reg_state, off, off + size,
-								  dst_regno);
-					if (err)
-						return err;
-					insn_flags = 0; /* not restoring original register state */
+					mark_reg_stack_read(env, reg_state, off, off + size,
+							    dst_regno);
 				}
 			}
 		} else if (dst_regno >= 0) {
@@ -4378,10 +4191,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				 */
 				assign_scalar_id_before_mov(env, reg);
 			state->regs[dst_regno] = *reg;
-			/* mark reg as written since spilled pointer state likely
-			 * has its liveness marks cleared by is_state_visited()
-			 * which resets stack/reg liveness for state transitions
-			 */
 		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
 			/* If dst_regno==-1, the caller is asking us whether
 			 * it is acceptable to use this value as a SCALAR_VALUE
@@ -4412,16 +4221,9 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			}
 			return -EACCES;
 		}
-		if (dst_regno >= 0) {
-			err = mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
-			if (err)
-				return err;
-		}
-		insn_flags = 0; /* we are not restoring spilled register */
+		if (dst_regno >= 0)
+			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
 	}
-	if (insn_flags)
-		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
-					    hist_spi, hist_frame, NULL, 0);
 	return 0;
 }
 
@@ -4470,10 +4272,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
 
 	min_off = reg_smin(reg) + off;
 	max_off = reg_smax(reg) + off;
-	err = mark_reg_stack_read(env, ptr_state, min_off, max_off + size,
-				  dst_regno);
-	if (err)
-		return err;
+	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
 	return 0;
 }
 
@@ -4661,8 +4460,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
 	bpf_diag_mod_end(env);
-	return bpf_push_jmp_history(env, env->cur_state,
-				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
+	return 0;
 }
 
 /*
@@ -4700,26 +4498,7 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
 	cur->regs[dst_regno] = *arg;
 	bpf_diag_mod_end(env);
-	return bpf_push_jmp_history(env, env->cur_state,
-				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
-}
-
-static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
-{
-	struct bpf_func_state *caller = cur_func(env);
-	int spi = arg_idx - MAX_BPF_FUNC_REG_ARGS;
-
-	bt_set_frame_stack_arg_slot(&env->bt, caller->frameno, spi);
-	return mark_chain_precision_batch(env, env->cur_state);
-}
-
-static int mark_arg_precision(struct bpf_verifier_env *env, argno_t argno)
-{
-	int regno = reg_from_argno(argno);
-
-	if (regno >= 0)
-		return mark_chain_precision(env, regno);
-	return mark_stack_arg_precision(env, arg_idx_from_argno(argno));
+	return 0;
 }
 
 static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
@@ -5184,14 +4963,8 @@ static int check_map_kptr_access(struct bpf_verifier_env *env,
 			return ret;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
-		if (bpf_register_is_null(val_reg)) {
-			/*
-			 * This store is valid only because the scalar is known to be
-			 * zero. Mark it precise so another scalar cannot be pruned
-			 * against this state.
-			 */
-			return mark_chain_precision(env, value_regno);
-		}
+		if (bpf_register_is_null(val_reg))
+			return 0;
 		if (map_kptr_match_type(env, kptr_field, val_reg, value_regno))
 			return -EACCES;
 	} else if (class == BPF_ST) {
@@ -8275,7 +8048,7 @@ static int check_stack_range_initialized(
 		    (ss->spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
-				__mark_reg_unknown(env, &ss->spilled_ptr);
+				bpf_mark_reg_unknown(&ss->spilled_ptr);
 				for (j = 0; j < BPF_REG_SIZE; j++)
 					scrub_spilled_slot(&ss->slot_type[j]);
 			}
@@ -8473,9 +8246,6 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	if (err && failure)
 		*failure = BPF_MEM_SIZE_FAIL_MEMORY;
 
-	if (!err)
-		err = mark_arg_precision(env, size_argno);
-
 	return err;
 
 size_error:
@@ -8496,7 +8266,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	int size, err = 0;
 
 	if (bpf_register_is_null(reg))
-		return mark_arg_precision(env, argno);
+		return 0;
 	if (known_memory)
 		*known_memory = true;
 
@@ -8526,9 +8296,6 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 					argno_t argno, struct ret_mem_desc *ret_mem)
 {
-	int regno = reg_from_argno(argno);
-	int err;
-
 	if (ret_mem->found) {
 		verifier_bug(env, "only one allocation size argument permitted");
 		return -EFAULT;
@@ -8544,13 +8311,6 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 		return -EINVAL;
 	}
 
-	if (regno >= 0)
-		err = mark_chain_precision(env, regno);
-	else
-		err = mark_stack_arg_precision(env, arg_idx_from_argno(argno));
-	if (err)
-		return err;
-
 	ret_mem->size = reg->var_off.value;
 	ret_mem->found = true;
 
@@ -8560,9 +8320,6 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			     argno_t argno, struct bpf_call_arg_meta *meta)
 {
-	int regno = reg_from_argno(argno);
-	int err;
-
 	if (meta->arg_constant.found) {
 		verifier_bug(env, "only one constant argument permitted");
 		return -EFAULT;
@@ -8573,13 +8330,6 @@ static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg_state
 		return -EINVAL;
 	}
 
-	if (regno >= 0)
-		err = mark_chain_precision(env, regno);
-	else
-		err = mark_stack_arg_precision(env, arg_idx_from_argno(argno));
-	if (err < 0)
-		return err;
-
 	meta->arg_constant.found = true;
 	meta->arg_constant.value = reg->var_off.value;
 
@@ -9322,7 +9072,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 
 	/* mark current iter state as drained and assume returned NULL */
 	cur_iter->iter.state = BPF_ITER_STATE_DRAINED;
-	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
+	__mark_reg_const_zero(&cur_fr->regs[BPF_REG_0]);
 
 	return 0;
 }
@@ -10009,7 +9759,7 @@ static int get_max_map_key(struct bpf_verifier_env *env,
 	int spill_size = 0;
 	int zero_size = 0;
 	int stack_off;
-	int i, err;
+	int i;
 	u8 *stype;
 
 	if (!env->bpf_capable)
@@ -10051,15 +9801,6 @@ static int get_max_map_key(struct bpf_verifier_env *env,
 		/* The lookup can return NULL: nothing depends on the key */
 		return -EOPNOTSUPP;
 
-	/*
-	 * We are relying on the range of the key. So mark as precise
-	 * to prevent pruning on it.
-	 */
-	bpf_bt_set_frame_slot(&env->bt, key->frameno, spi);
-	err = mark_chain_precision_batch(env, env->cur_state);
-	if (err < 0)
-		return err;
-
 	*value = reg_umax(reg);
 	return 0;
 }
@@ -10177,12 +9918,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
-		err = mark_arg_precision(env, argno);
-		if (err)
-			return err;
+	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
 		return 0;
-	}
 
 	err = check_func_arg_nullability(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
@@ -12885,11 +12622,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			return -EINVAL;
 		}
 
-		/* we are going to rely on register's precise value */
-		err = mark_chain_precision(env, BPF_REG_0);
-		if (err)
-			return err;
-
 		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
 		if (!retval_range_within(callee->callback_ret_range, r0)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
@@ -13055,7 +12787,6 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	struct bpf_reg_state *reg;
 	struct bpf_map *map = meta->map.ptr;
 	u64 val, max;
-	int err;
 
 	if (func_id != BPF_FUNC_tail_call)
 		return 0;
@@ -13073,9 +12804,6 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return 0;
 	}
 
-	err = mark_chain_precision(env, BPF_REG_3);
-	if (err)
-		return err;
 	if (bpf_map_key_unseen(aux))
 		bpf_map_key_store(aux, val);
 	else if (!bpf_map_key_poisoned(aux) &&
@@ -13218,45 +12946,27 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 	return &env->insn_aux_data[env->insn_idx];
 }
 
-/* Returns 1 if R4 is a known zero, 0 if it is not, a negative errno on error. */
-static int loop_flag_is_zero(struct bpf_verifier_env *env)
+static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
-	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
-	int err;
-
-	if (!bpf_register_is_null(reg))
-		return 0;
-
-	err = mark_chain_precision(env, BPF_REG_4);
-	if (err)
-		return err;
-	return 1;
+	return bpf_register_is_null(reg_state(env, BPF_REG_4));
 }
 
-static int update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
+static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
 {
 	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
-	int flag_is_zero;
 
 	if (!state->initialized) {
-		flag_is_zero = loop_flag_is_zero(env);
-		if (flag_is_zero < 0)
-			return flag_is_zero;
 		state->initialized = 1;
-		state->fit_for_inline = flag_is_zero;
+		state->fit_for_inline = loop_flag_is_zero(env);
 		state->callback_subprogno = subprogno;
-		return 0;
+		return;
 	}
 
 	if (!state->fit_for_inline)
-		return 0;
+		return;
 
-	flag_is_zero = loop_flag_is_zero(env);
-	if (flag_is_zero < 0)
-		return flag_is_zero;
-	state->fit_for_inline = (flag_is_zero &&
+	state->fit_for_inline = (loop_flag_is_zero(env) &&
 				 state->callback_subprogno == subprogno);
-	return 0;
 }
 
 /* Returns whether or not the given map can potentially elide
@@ -13475,9 +13185,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
 			return -EINVAL;
 		}
-		err = mark_chain_precision(env, BPF_REG_2);
-		if (err)
-			return err;
 		break;
 	case BPF_FUNC_for_each_map_elem:
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
@@ -13495,15 +13202,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = check_bpf_snprintf_call(env, regs);
 		break;
 	case BPF_FUNC_loop:
-		err = update_loop_inline_state(env, meta.subprogno);
-		if (err)
-			return err;
-		/* Verifier relies on R1 value to determine if bpf_loop() iteration
-		 * is finished, thus mark it precise.
-		 */
-		err = mark_chain_precision(env, BPF_REG_1);
-		if (err)
-			return err;
+		update_loop_inline_state(env, meta.subprogno);
 		if (cur_func(env)->callback_depth < reg_umax(&regs[BPF_REG_1])) {
 			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 						 set_loop_callback_state);
@@ -13552,10 +13251,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			bpf_lsm_get_retval_range(env->prog, &range);
 		}
 
-		err = mark_chain_precision(env, BPF_REG_1);
-		if (err)
-			return err;
-
 		if (!retval_range_within(range, r1)) {
 			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
 			return -EINVAL;
@@ -16563,7 +16258,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ret_nregs = mark_kfunc_ret_regs(env, regs, t->size);
 		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
-			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+			__mark_reg_const_zero(&regs[BPF_REG_0]);
 	} else if (btf_type_is_struct(t)) {
 		struct btf_member_path path = {};
 		const char *member_note = "";
@@ -17194,14 +16889,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		/* Taint dst register if offset had invalid bounds derived from
 		 * e.g. dead branches.
 		 */
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
 	if (BPF_CLASS(insn->code) != BPF_ALU64 && !to_scalar) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
 		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
-			__mark_reg_unknown(env, dst_reg);
+			bpf_mark_reg_unknown(dst_reg);
 			return 0;
 		}
 
@@ -17265,7 +16960,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	}
 
 	if (to_scalar) {
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
@@ -18237,7 +17932,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	int ret;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
-		__mark_reg_unknown(env, dst_reg);
+		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
 
@@ -18296,7 +17991,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		if (bpf_insn_is_hmul(insn) &&
 		    (!is_reg_const(dst_reg, false) ||
 		     !is_reg_const(&src_reg, false))) {
-			__mark_reg_unknown(env, dst_reg);
+			bpf_mark_reg_unknown(dst_reg);
 			break;
 		}
 		if (!alu32 && insn->off == BPF_UHMUL) {
@@ -18508,24 +18203,13 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
-				err = mark_chain_precision(env, insn->dst_reg);
-				if (err)
-					return err;
 				off_reg = *dst_reg;
 				return adjust_ptr_min_max_vals(env, insn, insn->src_reg, src_reg,
 							       &off_reg);
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */
-			err = mark_chain_precision(env, insn->src_reg);
-			if (err)
-				return err;
 			return adjust_ptr_min_max_vals(env, insn, insn->dst_reg, dst_reg, src_reg);
-		} else if (dst_reg->precise) {
-			/* if dst_reg is precise, src_reg should be precise as well */
-			err = mark_chain_precision(env, insn->src_reg);
-			if (err)
-				return err;
 		}
 	} else {
 		/* Pretend the src is a reg with a known value, since we only
@@ -19948,7 +19632,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *eq_branch_regs;
 	struct linked_regs linked_regs = {};
 	u8 opcode = BPF_OP(insn->code);
-	int insn_flags = 0;
 	bool is_jmp32;
 	int pred = -1;
 	int err;
@@ -20009,24 +19692,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 
-		if (src_reg->type == PTR_TO_STACK)
-			insn_flags |= INSN_F_SRC_REG_STACK;
-		if (dst_reg->type == PTR_TO_STACK)
-			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		src_reg = &env->fake_reg[0];
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
-
-		if (dst_reg->type == PTR_TO_STACK)
-			insn_flags |= INSN_F_DST_REG_STACK;
-	}
-
-	if (insn_flags) {
-		err = bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, NULL, 0);
-		if (err)
-			return err;
 	}
 
 	/*
@@ -20047,19 +19717,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	pred = is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >= 0)
 		mark_loop_exit_decided(env, this_branch);
-	if (pred >= 0) {
-		/* If we get here with a dst_reg pointer type it is because
-		 * above is_branch_taken() special cased the 0 comparison.
-		 */
-		if (!__is_pointer_value(false, dst_reg))
-			err = mark_chain_precision(env, insn->dst_reg);
-		if (BPF_SRC(insn->code) == BPF_X && !err &&
-		    !__is_pointer_value(false, src_reg))
-			err = mark_chain_precision(env, insn->src_reg);
-		if (err)
-			return err;
-	}
-
 	if (pred == 1) {
 		/* Only follow the goto, ignore fall-through. If needed, push
 		 * the fall-through branch for simulation under speculative
@@ -20090,20 +19747,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
-	/* Push scalar registers sharing same ID to jump history,
-	 * do this before creating 'other_branch', so that both
-	 * 'this_branch' and 'other_branch' share this history
-	 * if parent state is created.
-	 */
-	if (linked_regs.cnt > 1) {
-		u16 packed[LINKED_REGS_MAX];
-
-		linked_regs_pack(&linked_regs, packed);
-		err = bpf_push_jmp_history(env, this_branch, 0, 0, 0, packed, linked_regs.cnt);
-		if (err)
-			return err;
-	}
-
 	other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx, false);
 	if (IS_ERR(other_branch))
 		return PTR_ERR(other_branch);
@@ -20181,15 +19824,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	    type_may_be_null(dst_reg->type) &&
 	    ((BPF_SRC(insn->code) == BPF_K && insn->imm == 0) ||
 	     (BPF_SRC(insn->code) == BPF_X && bpf_register_is_null(src_reg)))) {
-		/*
-		 * For BPF_X the zero is a property of this execution path,
-		 * hence src_reg has to be precise.
-		 */
-		if (BPF_SRC(insn->code) == BPF_X) {
-			err = mark_chain_precision(env, insn->src_reg);
-			if (err)
-				return err;
-		}
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
@@ -20296,7 +19930,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		if (map->map_type == BPF_MAP_TYPE_ARENA) {
-			__mark_reg_unknown(env, dst_reg);
+			bpf_mark_reg_unknown(dst_reg);
 			dst_reg->map_ptr = map;
 			bpf_diag_mod_end(env);
 			return 0;
@@ -20645,10 +20279,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EINVAL;
 	}
 
-	err = mark_chain_precision(env, regno);
-	if (err)
-		return err;
-
 	if (!retval_range_within(range, reg)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
@@ -22014,9 +21644,9 @@ static int push_budget_exit(struct bpf_verifier_env *env)
 		return PTR_ERR(branch);
 	branch->unwound = sub->bail_unwinds;
 	regs = branch->frame[branch->curframe]->regs;
-	__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+	__mark_reg_const_zero(&regs[BPF_REG_0]);
 	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
-		__mark_reg_const_zero(env, &regs[BPF_REG_2]);
+		__mark_reg_const_zero(&regs[BPF_REG_2]);
 	return 0;
 }
 
@@ -23461,7 +23091,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno */,
 			subprog);
-	state->first_insn_idx = env->subprog_info[subprog].start;
 	state->last_insn_idx = -1;
 
 	regs = state->frame[state->curframe]->regs;
@@ -23781,11 +23410,12 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 				env->subprog_info[i].stack_depth);
 		}
 	}
+	/* user space parses this line. There are no read marks. */
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
-		"total_states %d peak_states %d mark_read %d\n",
+		"total_states %d peak_states %d mark_read 0\n",
 		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
 		env->max_states_per_insn, env->total_states,
-		env->peak_states, env->longest_mark_read_walk);
+		env->peak_states);
 }
 
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
@@ -25587,7 +25217,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (!env)
 		return -ENOMEM;
 
-	env->bt.env = env;
 	env->prog = *prog;
 	env->ops = bpf_verifier_ops[env->prog->type];
 	env->stack_limit = bpf_prog_stack_limit(env->prog);
-- 
2.55.0

