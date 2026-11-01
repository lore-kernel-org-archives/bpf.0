Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502380;
	b=MC+HLZOEjrxk2g91SfnnX1vTMMjIcZUtkatM+BA/sVaIZlFfgaUvTnnI4QdvenJ68GBZ
	 s5iMZLezI5kGUB4Q2hgV9OuOacBlhf1HQHrLODvu6+b+SLlBiixBm/tq/Sux3W/yYFRKj
	 FZigOxcbhn2GJOjWnNyBgI6JNgbH21XDD7x5tA5tEH5e8+4OEWOH+TeGGPVdnmP1fIDmo
	 xJWacIg8O1SxipigZcen3tlmKG1mcBnOyb5i9p1eT3bA+5pR5nqNLg95ZFSs4dyV4YZor
	 eZqiZq80Xi9cQPVS7W+xHP8n8/9PY4DSuDYFqeizn9ZM6vXQz+bqmoudu8I46OrpoQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jmFSdbAcn+YV+KJVOyPMzkTkqcshGgKVHStnjHOPDBA=;
	b=kNG7hs2x3+yabrwTnnbz1kSOYVAF1RaWwkmHUvYAVYg3hsWrh/qqg24IbvciU0Z+YVud
	 3k/NlskZ6WnKox2zGAcpz8VCdSUEBv5GV9Eo8MmZGIwqTDJZ3MmnKFDcKheQ73C+Q18sS
	 PfDA/mY69wTGIxIK9Yf9hwEG53fSQKbfpybWiBVtXMMu37Bp9Ht3RV/+dvluFMxTZiR0m
	 MLqcfvUey/k1Dc/4k2aLUxUz5vOJVDrUoIqOM3EARKXysM9CNu7i1SlmRKFUbzb7yp6S1
	 8yr5n6v7+fvIpzf5RBbhbgYh+uYH0KYh0HRxOjCYKi8s8BNrG0LBWDYTFGUsa8IXG/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Oc/BQcq8";
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51976606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51976606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oc/BQcq8
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so952309a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502378; x=1794107178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmFSdbAcn+YV+KJVOyPMzkTkqcshGgKVHStnjHOPDBA=;
        b=Oc/BQcq83IojQa5UC+aMxTZnFxPMfwEKdJGVfKwnjMJmHgKY9IPWbjU2FVqinajvw/
         wYCr43Sl+xiA5n+uaAuhQlR3u6N93FVUIwwrKkrVcMA3SetpqNCrCyDD+UyUCh4sHsqK
         39nVS+1IIzdjX4ybTE6R2fT21rBRYjHOfW/S1F4r4JpUUYR2RoP9EkrQ+3WPA/S8QYY6
         95qpTXkXv1v3FtVgDlEBe/+hXFJdk6QkDi/wJU5sVrUmOjOvOfpOOKcae5OMyCSFF6o0
         dm3U6BCkNkwbQ8p0sdDedwT5URBposhjqxmIRG9gmfEd0n/3IOc7VTnLPMVIB0RcTNqd
         yMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502378; x=1794107178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jmFSdbAcn+YV+KJVOyPMzkTkqcshGgKVHStnjHOPDBA=;
        b=XD7Ndln0JTMNyCxg1bpcVzNZ4jvJIpjMJ5/yfde2EQjgldYrMcFHA8Q86GTza4NwSy
         ZwGtRiiUcZyTyKuXA3LcQuMk6etiUNrNT8fMbU6feFPC3sc8jZ4cVCUkUiuvwNcAxHvy
         w2E0Lg7fQHxWS6dJdG8pivEHn9qkBqMGsVKALewJ21cdvQwAUMO09wGMTek29NfHtPPn
         nAaNzdGZSwy4Ou+35xCuF9ngXExebmNdn5zPGPcRVl/gPPJPUUFHbBil/8174/0DqwpW
         2McEYRl51Gx2qTx83R7jHEtx3Og/i3+pwegPpRPAckIH1gkNGljwsoePhmR6x89BKl6s
         o+Nw==
X-Gm-Message-State: APuU4Z+eVGGlBeMVOqad2IdYkRsLRJBZiLT9TqbwpmEoA17+hhvoqxWc
	tp5Pah/Vc5xew4ITAhi3BFIW6H1e3/rIZS8ggxYNuvqXZFZafYp349THxzg1cg==
X-Gm-Gg: AYBFou2ZcSP6QehDKau6kKF8sn5Jyx81U+Z7ZOP7SGAvG2orUQtwfzrI9PD14qdkp/4
	1bHnCNFFw+LzyDtUzX1xgKcDbJ6VVTqlLTr1kt8IqqXg6GhAjaB4+6zQ+fpZynlUJdub7QUSoRb
	g2rvey8w4qiSTyoj6TsJv9HmDo2W6Or9qX9tb3NMvRL9QoAxHahHk9nx30Rtq3vB5gzW20zYmQy
	T3xGC4tjk8x4+A5eq5QOja8R7pyMXBE2CIQpe8WrB84X38RNHRX3DZsY5TC/h8BGTzBgAyxv5k/
	U0dkh7tb9bOs3NAriHy6zJeVij3vHbQzvVxQJWwiKxAJLeFt2gxfd+pOPJAl9hd0UXJebwQbbiG
	bteiDeK5arE9BRGzJgSCruDpL/oaS68b2yfZIHXlzJ/Ry6WRJsIm/IqHKJ9vXidNDBbtmURMGQV
	/VjL8aD1/HiDG/nZufFsWQGRqClIRVQ4MeRzT7NmRmXrfefeZaqjhbwXQB9dQFJrQrsWOTxvU9O
	Nux82NB3l5qSgGtYpcoO9QM8LmhQyCSX5xmFyLjmlmjOxqPSHvD2Z4feDqLmA7j/yiHALfG2MBi
	L14ZtCOf+NDnL2bgHURRAohY/xr2ljw2b4FxnmiywxNFGFzD+VJLym87JBiqypIfuFf+j+8lvfB
	nfHdfqEJ3UVzr5Nkwl5/hK88c4Ee6EenkFMgjS3/2Tolz4EFWJ1ldzjHo3Uz9fMlpvujhoK8jAw
	==
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr4743063a91.37.1793502378010;
        Sat, 31 Oct 2026 20:06:18 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm9350215a91.13.2026.10.31.20.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/14] bpf: Support BPF_REG_ARENA_SP in the verifier
Date: Sun,  1 Nov 2026 03:05:07 +0000
Message-ID: <20261101030511.1578690-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

In Rust &local, &heap and &static are the same type of pointer, and the
same insn dereferences all of them. The heap and the statics of a Rust prog
are in arena. Thus a local variable whose address is taken must be in arena
too. Spills and all other local variables stay in the r10 stack.

Add a second stack, in arena. r12 (BPF_REG_ARENA_SP) is its stack pointer.
The stack grows up, and r12 points to the end of the frame of the current
function:

  f:
    r12 += 32                  ; the frame of f, 32 bytes in arena
    *(u64 *)(r12 - 8) = r1     ; a local variable
    r1 = r12
    r1 += -8                   ; its address, a number (scalar)
    call g                     ; g accesses the variable through r1
    exit                       ; the verifier adds 'r12 += -32' here

The verifier tracks neither r12 nor the content of this stack. It does not
track the rest of arena either. r12 holds the low 32 bits of the address,
and the JIT adds the base of the arena. Thus an access through r12 stays in
arena. But the code at the exit of the prog needs r12 to find the stack
that it must give back. Thus accept r12 in 4 insns only:

  r12 += N                           first insn of a function, N % 16 == 0
  rX = r12                           number (scalar): user space address
  rX = *(size *)(r12 - off)          off is not checked against N
  *(size *)(r12 - off) = rX or imm

Only the compiler knows N, the size of the frame. The verifier cannot
calculate it, because callees access the frame through numbers. The frames
of a call chain have 32 Kbyte at most.

The reasons for these rules:

  in this patch                  what was rejected, and why
  -----------------------------  ----------------------------------------
  One 'r12 += N', the first      'r12 -= rX': the depth has no bound.
  insn of a function.            More than one 'r12 += imm': r12 becomes
                                 verifier state.
  The verifier tracks nothing    Tracked slots: each store through a
  in this stack.                 number invalidates them.
  'rX = r12' gives a number.     PTR_TO_ARENA: after a store to memory
                                 and a load it is a number. Then one insn
                                 sees two types.
  The stack grows up, and the    Down, with r12 + off: harder to read.
  offsets are negative, as with
  r10.

Each run takes a stack, see "bpf: Add stacks for programs to arena". The
verifier adds this code to the main prog. busy, size and base are per-cpu:

  entry                                  before each exit

  old = busy++                           if (r12 & BPF_ARENA_STACK_SLOW)
  if (old == 0 && size is sufficient)            bpf_arena_stack_put()
          r12 = base                     else
  else                                           busy = 0
          r12 = bpf_arena_stack_get()
          no memory: return 0

The verifier adds this code before gen_prologue() and gen_epilogue() add
theirs. Thus the prologue of the prog type runs before the prog takes
a stack, and the epilogue runs after each exit, also after 'return 0'.

The usual path has 8 insns at the entry and 4 insns at the exit. The kernel
does not pass r12 to a callback. Thus a callback that uses r12 gets the
same code and takes a stack too. To reject r12 in callbacks is not
possible: real schedulers need it.

Progs without r12 get the same code. A prog that uses r12 in one of its
functions pays in each run: up to 22 more x86 insns, no call, no lock
prefix. The cost on x86-64 (Zen 5), in nsec more than the same prog with
r10:

  each run, hot caches                               0.28 to 2.30
  each run, cold caches and TLB                      45 to 70
  each run that finds the per-cpu stack taken        8.7
  iteration of bpf_loop(), the callback uses r12     17.5 (1.13 -> 18.6)
  call of a function with a frame, load, store       below 0.23

A callback of bpf_loop() always finds the per-cpu stack taken, because the
main prog has it. The verifier also does not inline such a loop.

Limitations:
 - The JIT must report bpf_jit_supports_arena_stack(). No JIT does in this
   patch.
 - The verifier rejects tail calls, because the prog would not give the
   stack back.
 - It rejects extension progs. The code at the entry uses r2-r5, and an
   extension prog has arguments there.
 - It rejects BPF_LD_ABS and BPF_LD_IND. They end the function when the
   offset is not in the packet, and the prog would not give the stack back.
 - It rejects a jump and a gotox to 'r12 += N', because the insn would run
   again.
 - It rejects a struct_ops prog that has a __ref argument. A run without
   a stack is skipped, and nothing would release the argument.
 - It rejects a call and a callx of a callback that takes a stack, because
   the caller would get the r12 of the callee.
 - Nothing can attach to a subprog, because trampolines do not keep r12.
 - The private stack is off, because the x86 JIT has one register for the
   two.
 - bpf_throw() does not give the stack back. The stack stays taken until
   the arena is freed, for all progs of the arena on that cpu. After 17
   throws on a cpu each run there allocates a stack, and each more throw
   loses the pages of one stack. Rust progs unwind and
   do not throw. A slot for r12 in the frame of the main prog does not
   help: an interrupt overwrites it after bpf_throw() drops the frames.

The test "invalid src register in LDX" of test_verifier used r12. Use r13.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |  13 +
 include/linux/filter.h                        |  44 ++++
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/const_fold.c                       |   7 +
 kernel/bpf/core.c                             |  25 ++
 kernel/bpf/fixups.c                           | 226 +++++++++++++++++-
 kernel/bpf/liveness.c                         |   8 +
 kernel/bpf/scev.c                             |   9 +-
 kernel/bpf/verifier.c                         | 193 ++++++++++++++-
 .../selftests/bpf/verifier/basic_stx_ldx.c    |   4 +-
 11 files changed, 526 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1cd0f67a3f49..70ea69a6ff7c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1939,6 +1939,8 @@ struct bpf_prog_aux {
 	 * the page size. 0 when r12 is not used.
 	 */
 	u32 arena_stack_size;
+	/* a callback that takes a stack in arena, like the main program does */
+	bool arena_stack_entry;
 	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recursion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3562e57ebb5e..0342025ae2a7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -784,6 +784,7 @@ struct bpf_insn_aux_data {
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
+	u64 kernel_call:1; /* the verifier emitted this call of a kernel function, imm is final */
 	u64 bb_end:1; /* last instruction of a basic block */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
@@ -939,6 +940,9 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+/* The most that the frames of a call chain take in the stack in arena */
+#define BPF_ARENA_STACK_MAX (32 << 10)
+
 struct bpf_subprog_info {
 	const char *name; /* name extracted from BTF */
 	u32 start; /* insn idx of function entry point */
@@ -952,6 +956,7 @@ struct bpf_subprog_info {
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	u16 arena_stack_depth; /* size of the frame in the stack in arena */
 	u32 insns_total;
 	u32 insns_self;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
@@ -973,6 +978,11 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	bool uses_arena_sp: 1;
+	/* a callback that takes a stack in arena, like the main program does */
+	bool arena_stack_entry: 1;
+	/* a call insn or callx calls it */
+	bool is_called: 1;
 	u8 arg_slot_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
@@ -1075,6 +1085,8 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
+	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
 	 * lists of struct bpf_verifier_state_list.
@@ -2016,6 +2028,7 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
 void bpf_lower_cast_mov(struct bpf_verifier_env *env);
+int bpf_insert_arena_stack(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1b59ec817048..ee851bc4cd5b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -895,6 +895,49 @@ static inline bool is_stack_arg_stx(const struct bpf_insn *insn)
 	       insn->off < 0 && insn->off % 8 == 0;
 }
 
+/*
+ * BPF_REG_ARENA_SP, r12, points to the end of the frame of the function in
+ * the stack in arena, like r10 does in the stack of the program. The stack
+ * in arena grows up. r12 is used in four insns:
+ *   r12 += N                          the first insn of the function
+ *                                     N is a multiple of 16, so is r12
+ *   rX = r12
+ *   rX = *(size *)(r12 - off)
+ *   *(size *)(r12 - off) = rX or imm
+ */
+static inline bool is_arena_sp_adj(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_ADD | BPF_K) &&
+	       insn->dst_reg == BPF_REG_ARENA_SP;
+}
+
+static inline bool is_arena_sp_mov(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+	       insn->src_reg == BPF_REG_ARENA_SP && !insn->off && !insn->imm;
+}
+
+static inline bool is_arena_sp_ldx(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_LDX &&
+	       (BPF_MODE(insn->code) == BPF_MEM || BPF_MODE(insn->code) == BPF_MEMSX) &&
+	       insn->src_reg == BPF_REG_ARENA_SP;
+}
+
+/* st and stx */
+static inline bool is_arena_sp_st(const struct bpf_insn *insn)
+{
+	return (BPF_CLASS(insn->code) == BPF_ST || BPF_CLASS(insn->code) == BPF_STX) &&
+	       BPF_MODE(insn->code) == BPF_MEM &&
+	       insn->dst_reg == BPF_REG_ARENA_SP;
+}
+
+static inline bool is_arena_sp_insn(const struct bpf_insn *insn)
+{
+	return is_arena_sp_adj(insn) || is_arena_sp_mov(insn) ||
+	       is_arena_sp_ldx(insn) || is_arena_sp_st(insn);
+}
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
 struct bpf_skb_data_end {
@@ -1331,6 +1374,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_arena_stack(void);
 bool bpf_jit_supports_local_atomics(void);
 bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..47452ac7277a 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -325,7 +325,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * sreg needs precision before this insn
 				 */
 				bt_clear_reg(bt, dreg);
-				if (sreg != BPF_REG_FP)
+				if (sreg != BPF_REG_FP && sreg != BPF_REG_ARENA_SP)
 					bt_set_reg(bt, sreg);
 			} else {
 				/* dreg = K
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index f9edfde965dc..0e0cad2b4b8e 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -65,6 +65,13 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
 		ci_out[insn->dst_reg] = unknown;
 		return;
 	}
+	/* r12 is outside of it too */
+	if (is_arena_sp_adj(insn) || is_arena_sp_st(insn))
+		return;
+	if (is_arena_sp_mov(insn) || is_arena_sp_ldx(insn)) {
+		ci_out[insn->dst_reg] = unknown;
+		return;
+	}
 
 	switch (class) {
 	case BPF_ALU:
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6f4bcf3c851c..87e4fc2e8545 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3634,6 +3634,12 @@ bool __weak bpf_jit_supports_local_atomics(void)
 	return false;
 }
 
+/* Whether JIT supports BPF_REG_ARENA_SP */
+bool __weak bpf_jit_supports_arena_stack(void)
+{
+	return false;
+}
+
 /*
  * Return TRUE if the JIT lays out frames of up to MAX_BPF_STACK_JIT bytes.
  * Its prologue, epilogue and tail call sequences must encode such frame
@@ -3706,6 +3712,25 @@ __weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 	return 0;
 }
 
+__weak int bpf_arena_stack_init(struct bpf_arena *arena)
+{
+	return -EOPNOTSUPP;
+}
+
+__weak void __percpu *bpf_arena_stack_percpu(struct bpf_arena *arena)
+{
+	return NULL;
+}
+
+__weak u64 bpf_arena_stack_get(struct bpf_prog_aux *aux, u64 busy)
+{
+	return 0;
+}
+
+__weak void bpf_arena_stack_put(struct bpf_prog_aux *aux, u32 base)
+{
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 __weak bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write,
 					unsigned long fault_ip)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index b0f0262e5263..b9848e635083 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -743,6 +743,223 @@ void bpf_lower_cast_mov(struct bpf_verifier_env *env)
 	}
 }
 
+/*
+ * Make BPF_REG_ARENA_SP work. It holds the low 32 bits of the address, which is
+ * what JITs add to the base of arena.
+ *  - the main program takes a stack when it starts and returns it when it exits:
+ *    the stack of the cpu when it's free, without a call.
+ *    See struct bpf_arena_cpu_stack. So does a callback.
+ *    bpf_throw() doesn't return it: the stack stays taken until the arena is freed.
+ *  - a function that has a frame drops it before exit.
+ *  - 'rX = r12' gives the address like user space sees it, as other addresses
+ *    in arena are.
+ * It's done before bpf_convert_ctx_accesses(), so that this code is a part of the
+ * program for gen_prologue() and gen_epilogue(). The prologue runs before the
+ * program takes a stack. The epilogue runs after each exit, also when there is
+ * no stack and the program is skipped.
+ */
+
+#define CPU_STACK_OFF(field) offsetof(struct bpf_arena_cpu_stack, field)
+
+/* reg = this_cpu_ptr(stacks) */
+static struct bpf_insn *emit_arena_stack_percpu(struct bpf_verifier_env *env,
+						struct bpf_insn *patch, int reg)
+{
+	struct bpf_insn ld_stacks[2] = {
+		BPF_LD_IMM64(reg, (__force long)bpf_arena_stack_percpu(env->prog->aux->arena))
+	};
+
+	*patch++ = ld_stacks[0];
+	*patch++ = ld_stacks[1];
+	*patch++ = BPF_MOV64_PERCPU_REG(reg, reg);
+	return patch;
+}
+
+/*
+ * Take a stack at the start of the main program or of a callback.
+ *
+ *	cnt = busy++;
+ *	if (!cnt)
+ *		goto free;
+ * slow:
+ *	r12 = bpf_arena_stack_get(aux, cnt);
+ *	if (r12)
+ *		goto done;
+ *	return 0;
+ * free:
+ *	if (size < what the program needs)
+ *		goto slow;
+ *	r12 = base;
+ * done:
+ *
+ * r0 and r6-r9 are not initialized when a function starts. Neither are r2-r5 in
+ * the main program. A callback has arguments there.
+ */
+static int insert_arena_stack_get(struct bpf_verifier_env *env, int s)
+{
+	struct bpf_insn ld_aux[2] = { BPF_LD_IMM64(BPF_REG_1, (long)env->prog->aux) };
+	int local = bpf_jit_supports_local_atomics() ? BPF_ATOMIC_LOCAL : 0;
+	int ptr = s ? BPF_REG_6 : BPF_REG_2, cnt = s ? BPF_REG_7 : BPF_REG_3;
+	int size = s ? BPF_REG_8 : BPF_REG_4;
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	struct bpf_insn *buf = env->insn_buf, *patch;
+	int jfree, jdone, jslow, slow, free, done, call, i, err, spill = 0, start = sub->start;
+	struct bpf_prog *new_prog;
+
+	if (s) {
+		spill = round_up(sub->stack_depth, BPF_REG_SIZE);
+		sub->stack_depth = spill + MAX_BPF_FUNC_REG_ARGS * BPF_REG_SIZE;
+		if (sub->stack_depth > env->stack_limit) {
+			verbose(env, "no room in the stack of %s() for its arguments\n",
+				bpf_subprog_name(env, s));
+			return -EACCES;
+		}
+	}
+
+	patch = emit_arena_stack_percpu(env, buf, ptr);
+	*patch++ = BPF_MOV32_IMM(cnt, 1);
+	*patch++ = BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH | local, ptr, cnt,
+				 CPU_STACK_OFF(busy));
+	jfree = patch++ - buf;
+	slow = patch - buf;
+	if (!s)
+		*patch++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	for (i = BPF_REG_1; s && i <= BPF_REG_5; i++)
+		*patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_FP, i, -(spill + i * BPF_REG_SIZE));
+	*patch++ = ld_aux[0];
+	*patch++ = ld_aux[1];
+	*patch++ = BPF_MOV64_REG(BPF_REG_2, cnt);
+	call = patch - buf;
+	*patch++ = BPF_EMIT_CALL(bpf_arena_stack_get);
+	*patch++ = BPF_MOV32_REG(BPF_REG_ARENA_SP, BPF_REG_0);
+	if (!s)
+		*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	for (i = BPF_REG_1; s && i <= BPF_REG_5; i++)
+		*patch++ = BPF_LDX_MEM(BPF_DW, i, BPF_REG_FP, -(spill + i * BPF_REG_SIZE));
+	jdone = patch++ - buf;
+	*patch++ = BPF_MOV64_IMM(BPF_REG_0, 0);
+	*patch++ = BPF_EXIT_INSN();
+	free = patch - buf;
+	*patch++ = BPF_LDX_MEM(BPF_W, size, ptr, CPU_STACK_OFF(size));
+	jslow = patch++ - buf;
+	*patch++ = BPF_LDX_MEM(BPF_W, BPF_REG_ARENA_SP, ptr, CPU_STACK_OFF(base));
+	done = patch - buf;
+	*patch = env->prog->insnsi[start];
+	err = bpf_adj_moved_insn(patch++, done);
+	if (err) {
+		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+			env->insn_aux_data[start].orig_idx);
+		return err;
+	}
+
+	buf[jfree] = BPF_JMP_IMM(BPF_JEQ, cnt, 0, free - jfree - 1);
+	buf[jdone] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, done - jdone - 1);
+	/* size is 0 until the stack is allocated */
+	buf[jslow] = BPF_JMP32_IMM(BPF_JLT, size, max(env->max_arena_stack_depth, 1),
+				   slow - jslow - 1);
+
+	/* a jump to the first insn doesn't take the stack again, neither does gotox */
+	new_prog = __bpf_patch_insn_data(env, start, buf, patch - buf, BPF_PATCH_MOVE_TARGET);
+	if (!new_prog)
+		return -ENOMEM;
+	env->prog = new_prog;
+	env->insn_aux_data[start + call].kernel_call = true;
+	return adjust_jmp_off(env->prog, start, done);
+}
+
+int bpf_insert_arena_stack(struct bpf_verifier_env *env)
+{
+	struct bpf_map *arena = (struct bpf_map *)env->prog->aux->arena;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	struct bpf_insn *insn_buf = env->insn_buf, *patch, *insn;
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_insn ld_aux[2] = { BPF_LD_IMM64(BPF_REG_1, (long)aux) };
+	struct bpf_prog *new_prog;
+	int i, cnt, call, cur = 0, err;
+
+	if (!env->uses_arena_sp)
+		return 0;
+
+	/* the caller would get r12 of the callee back */
+	for (i = 1; i < env->subprog_cnt; i++) {
+		if (!subprogs[i].arena_stack_entry || !subprogs[i].is_called)
+			continue;
+		verbose(env, "%s() uses R%d and is both called and a callback\n",
+			bpf_subprog_name(env, i), BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
+
+	/*
+	 * With spare bytes r12 is neither the start nor the end of the stack,
+	 * which may be at 0, so 'rX = r12' is not NULL.
+	 */
+	aux->arena_stack_size = round_up(env->max_arena_stack_depth + 64, PAGE_SIZE);
+
+	for (i = 0; i < env->prog->len; i++) {
+		insn = env->prog->insnsi + i;
+		if (subprogs[cur + 1].start == i)
+			cur++;
+		patch = insn_buf;
+		call = -1;
+
+		if (is_arena_sp_adj(insn)) {
+			insn->code = BPF_ALU | BPF_ADD | BPF_K;
+			env->insn_aux_data[i].zext_dst = true;
+			continue;
+		} else if (is_arena_sp_mov(insn)) {
+			/* rX = addr_space_cast(r12, 1, 0) */
+			if (!(arena->map_flags & BPF_F_NO_USER_CONV)) {
+				insn->off = BPF_ADDR_SPACE_CAST;
+				insn->imm = 1 << 16;
+			}
+			continue;
+		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
+			if (subprogs[cur].arena_stack_depth)
+				*patch++ = BPF_ALU32_IMM(BPF_ADD, BPF_REG_ARENA_SP,
+							 -(int)subprogs[cur].arena_stack_depth);
+			if (!cur || subprogs[cur].arena_stack_entry) {
+				/* r1-r5 are free */
+				*patch++ = BPF_JMP32_IMM(BPF_JSET, BPF_REG_ARENA_SP,
+							 BPF_ARENA_STACK_SLOW, 5);
+				patch = emit_arena_stack_percpu(env, patch, BPF_REG_2);
+				*patch++ = BPF_ST_MEM(BPF_DW, BPF_REG_2, CPU_STACK_OFF(busy), 0);
+				*patch++ = *insn;
+				*patch++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_0);
+				*patch++ = ld_aux[0];
+				*patch++ = ld_aux[1];
+				*patch++ = BPF_MOV64_REG(BPF_REG_2, BPF_REG_ARENA_SP);
+				call = patch - insn_buf;
+				*patch++ = BPF_EMIT_CALL(bpf_arena_stack_put);
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
+			}
+			if (patch == insn_buf)
+				continue;
+			*patch++ = *insn;
+		} else {
+			continue;
+		}
+
+		cnt = patch - insn_buf;
+		new_prog = bpf_patch_insn_data(env, i, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		if (call >= 0)
+			env->insn_aux_data[i + call].kernel_call = true;
+		i += cnt - 1;
+	}
+
+	/* From the last one, so that nothing moves in those that are yet to be done. */
+	for (i = env->subprog_cnt - 1; i >= 0; i--) {
+		if (i && !subprogs[i].arena_stack_entry)
+			continue;
+		err = insert_arena_stack_get(env, i);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
@@ -1458,6 +1675,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->arena_stack_size = prog->aux->arena_stack_size;
+		func[i]->aux->arena_stack_entry = env->subprog_info[i].arena_stack_entry;
 		func[i]->aux->uses_arena_insns = bpf_prog_has_arena_insns(func[i]);
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
@@ -2201,6 +2420,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
+		/* imm is not the id of a helper */
+		if (env->insn_aux_data[i + delta].kernel_call)
+			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			ret = bpf_fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
@@ -2923,7 +3145,9 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 		struct bpf_loop_inline_state *inline_state =
 			&env->insn_aux_data[i + delta].loop_inline_state;
 
-		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
+		/* the callback that takes a stack in arena is not for a call from the program */
+		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
+		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
 			struct bpf_prog *new_prog;
 
 			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index f30ea7b570e6..9d4aa8dab8e5 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1438,6 +1438,11 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	} else if (is_stack_arg_ldx(insn)) {
 		slot = stack_arg_off_to_slot(insn->off);
 		at_out[insn->dst_reg] = (slot >= 0) ? at_stack_arg_entry[slot] : none;
+	} else if (is_arena_sp_adj(insn) || is_arena_sp_st(insn)) {
+		/* at_out[12] is a stack arg slot, not r12 */
+	} else if (is_arena_sp_mov(insn) || is_arena_sp_ldx(insn)) {
+		/* an address in arena, or what is loaded from arena */
+		*dst = none;
 	} else if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_K) {
 		if (code == BPF_MOV) {
 			*dst = none;
@@ -1671,6 +1676,9 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	 */
 	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx(insn))
 		return 0;
+	/* Likewise at[12] is not r12, and the access is to arena. */
+	if (is_arena_sp_st(insn) || is_arena_sp_ldx(insn))
+		return 0;
 
 	switch (class) {
 	case BPF_LDX:
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 7b82fd79f9cc..0a547e634dcc 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -670,6 +670,12 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 	int i, id;
 	s64 imm;
 
+	/* reg2expr[12] is a stack slot, not r12 */
+	if (is_arena_sp_adj(insn) || is_arena_sp_st(insn))
+		return 0;
+	if (is_arena_sp_mov(insn) || is_arena_sp_ldx(insn))
+		goto mark_dst_unknown;
+
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
@@ -1156,7 +1162,8 @@ static void collect_store_base_regs(struct bpf_verifier_env *env,
 	u16 base_regs = 0;
 	u32 r;
 
-	if (size == BPF_W || size == BPF_DW) {
+	if ((size == BPF_W || size == BPF_DW) &&
+	    !is_arena_sp_st(insn) && !is_arena_sp_ldx(insn)) {
 		if ((class == BPF_STX || class == BPF_ST) && insn->dst_reg != BPF_REG_FP)
 			base_regs |= BIT(insn->dst_reg);
 		else if (class == BPF_LDX && insn->src_reg != BPF_REG_FP)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f1eaff892beb..6edecd254932 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5756,6 +5756,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	struct bpf_insn *insn = env->prog->insnsi;
 	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable = false;
+	int arena_depth = 0;
 	int total;
 	int tmp;
 
@@ -5796,6 +5797,24 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	 * tailcall will unwind the current stack frame but it will not get rid
 	 * of caller's stack as shown on the example above.
 	 */
+	/* The kernel calls a callback. It knows nothing about r12. */
+	if (subprog[idx].uses_arena_sp) {
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
+			if (!subprog[tmp].is_cb)
+				continue;
+			subprog[tmp].arena_stack_entry = true;
+			break;
+		}
+	}
+	arena_depth += subprog[idx].arena_stack_depth;
+	if (arena_depth > env->max_arena_stack_depth)
+		env->max_arena_stack_depth = arena_depth;
+	if (arena_depth > BPF_ARENA_STACK_MAX) {
+		verbose(env, "combined size of the frames in the stack in arena is %d. Too large\n",
+			arena_depth);
+		return -EACCES;
+	}
+
 	if (idx && subprog[idx].has_tail_call && depth >= 256) {
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d bytes. Too large\n",
@@ -5984,6 +6003,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
+	arena_depth -= subprog[idx].arena_stack_depth;
 
 	/* pop caller idx from callee */
 	idx = dinfo[idx].caller;
@@ -6012,10 +6032,20 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
 	for (int i = 0; i < env->subprog_cnt; i++) {
 		if (si[i].has_tail_call) {
+			/* the stack in arena wouldn't be returned */
+			if (env->uses_arena_sp) {
+				verbose(env, "tail_calls are not allowed in programs that use R%d\n",
+					BPF_REG_ARENA_SP);
+				kvfree(dinfo);
+				return -EINVAL;
+			}
 			priv_stack_mode = NO_PRIV_STACK;
 			break;
 		}
 	}
+	/* x86 JIT has one register for both */
+	if (env->uses_arena_sp)
+		priv_stack_mode = NO_PRIV_STACK;
 
 	if (priv_stack_mode == PRIV_STACK_UNKNOWN)
 		priv_stack_mode = bpf_enable_priv_stack(env->prog);
@@ -11505,6 +11535,7 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	int err;
 
 	caller = state->frame[state->curframe];
+	env->subprog_info[subprog].is_called = true;
 
 	/*
 	 * Track caller's total stack arg count (incoming + max outgoing).
@@ -20298,6 +20329,11 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	if (env->gotox_tmp_buf->items[0] < subprog_start)
 		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[0],
 						   subprog_start, subprog_end);
+	/* it's the first insn of a function, it would be executed again */
+	if (is_arena_sp_adj(&env->prog->insnsi[env->gotox_tmp_buf->items[0]])) {
+		verbose(env, "jump to the insn that changes R%d\n", BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
 	if (env->gotox_tmp_buf->items[n - 1] >= subprog_end)
 		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[n - 1],
 						   subprog_start, subprog_end);
@@ -20314,12 +20350,64 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 	return INSN_IDX_UPDATED;
 }
 
+/*
+ * r12 is not in regs[]. Only the kernel and 'r12 += N' change it, so it points
+ * to the stack in arena. What is there is not tracked, like the rest of arena.
+ */
+static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_reg_state arena = { .type = PTR_TO_ARENA };
+	argno_t argno = argno_from_reg(BPF_REG_ARENA_SP);
+	struct bpf_reg_state *regs = cur_regs(env);
+	int size = BPF_SIZE(insn->code);
+	int err, value_regno = -1;
+
+	if (is_arena_sp_adj(insn))
+		return 0;
+
+	/* the address of the frame is a number */
+	if (is_arena_sp_mov(insn)) {
+		bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
+		err = check_reg_arg(env, insn->dst_reg, DST_OP);
+		if (!err)
+			bpf_diag_mod_end(env);
+		return err;
+	}
+
+	if (is_arena_sp_ldx(insn)) {
+		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+		if (err)
+			return err;
+		bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
+		err = check_mem_access(env, env->insn_idx, &arena, argno, insn->off, size,
+				       BPF_READ, insn->dst_reg, false,
+				       BPF_MODE(insn->code) == BPF_MEMSX);
+		err = err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
+		if (!err)
+			bpf_diag_mod_end(env);
+		return err;
+	}
+
+	if (BPF_CLASS(insn->code) == BPF_STX) {
+		err = check_reg_arg(env, insn->src_reg, SRC_OP);
+		if (err)
+			return err;
+		value_regno = insn->src_reg;
+	}
+	err = check_mem_access(env, env->insn_idx, &arena, argno, insn->off, size,
+			       BPF_WRITE, value_regno, false, false);
+	return err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
 	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
 	u8 class = BPF_CLASS(insn->code);
 
+	if (is_arena_sp_insn(insn))
+		return check_arena_sp_insn(env, insn);
+
 	switch (class) {
 	case BPF_ALU:
 	case BPF_ALU64:
@@ -21514,6 +21602,86 @@ static int check_insn_fields(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 }
 
+static bool jumps_to_arena_sp_adj(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	if (class != BPF_JMP && class != BPF_JMP32)
+		return false;
+	if (op == BPF_CALL || op == BPF_EXIT || insn->code == (BPF_JMP | BPF_JA | BPF_X))
+		return false;
+	return is_arena_sp_adj(insn + bpf_jmp_offset(insn) + 1);
+}
+
+/*
+ * Find the insns with BPF_REG_ARENA_SP. The sizes of the frames are in the text
+ * of the program.
+ */
+static int check_arena_stack(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *sub = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i;
+
+	for (i = 0; i < env->prog->len; i++, insn++) {
+		if (i == (sub + 1)->start)
+			sub++;
+		/* it would be executed again */
+		if (jumps_to_arena_sp_adj(insn)) {
+			verbose(env, "jump to the insn that changes R%d\n", BPF_REG_ARENA_SP);
+			return -EINVAL;
+		}
+		if (!is_arena_sp_insn(insn))
+			continue;
+		sub->uses_arena_sp = true;
+		env->uses_arena_sp = true;
+		if (!is_arena_sp_adj(insn))
+			continue;
+		if (i != sub->start) {
+			verbose(env, "R%d can be changed by the first insn of a function only\n",
+				BPF_REG_ARENA_SP);
+			return -EINVAL;
+		}
+		if (insn->imm <= 0 || insn->imm % 16 || insn->imm > BPF_ARENA_STACK_MAX) {
+			verbose(env, "invalid size of the frame in the stack in arena %d\n",
+				insn->imm);
+			return -EINVAL;
+		}
+		sub->arena_stack_depth = insn->imm;
+	}
+	if (!env->uses_arena_sp)
+		return 0;
+
+	if (!env->prog->aux->arena) {
+		verbose(env, "R%d can only be used in a program that has an associated arena\n",
+			BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
+	if (!bpf_jit_supports_arena_stack() || !bpf_jit_supports_percpu_insn() ||
+	    bpf_prog_is_offloaded(env->prog->aux)) {
+		verbose(env, "JIT doesn't support R%d\n", BPF_REG_ARENA_SP);
+		return -EOPNOTSUPP;
+	}
+	/* bpf_insert_arena_stack() relies on r2-r5 being free when the program starts */
+	if (env->prog->type == BPF_PROG_TYPE_EXT) {
+		verbose(env, "R%d is not supported in extension programs\n", BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
+	/*
+	 * It ends the function when the offset is out of the packet. bpf_do_misc_fixups()
+	 * emits that exit, after bpf_insert_arena_stack(): the frame wouldn't be dropped
+	 * and the stack wouldn't be returned.
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		if (!env->subprog_info[i].has_ld_abs)
+			continue;
+		verbose(env, "BPF_LD_[ABS|IND] is not allowed in programs that use R%d\n",
+			BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
+	return bpf_arena_stack_init(env->prog->aux->arena);
+}
+
 /*
  * Check that insns are sane and rewrite pseudo imm in ld_imm64 instructions:
  *
@@ -21534,11 +21702,13 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (insn->dst_reg >= MAX_BPF_REG &&
-		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {
+		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn) &&
+		    !is_arena_sp_adj(insn) && !is_arena_sp_st(insn)) {
 			verbose(env, "R%d is invalid\n", insn->dst_reg);
 			return -EINVAL;
 		}
-		if (insn->src_reg >= MAX_BPF_REG && !is_stack_arg_ldx(insn)) {
+		if (insn->src_reg >= MAX_BPF_REG && !is_stack_arg_ldx(insn) &&
+		    !is_arena_sp_mov(insn) && !is_arena_sp_ldx(insn)) {
 			verbose(env, "R%d is invalid\n", insn->src_reg);
 			return -EINVAL;
 		}
@@ -22287,6 +22457,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	/* A run that gets no stack in arena is skipped. Nobody would release the argument. */
+	if (has_refcounted_arg && env->uses_arena_sp) {
+		verbose(env, "program with __ref argument cannot use R%d\n", BPF_REG_ARENA_SP);
+		return -EINVAL;
+	}
+
 	prog->aux->st_ops = st_ops;
 	prog->aux->attach_st_ops_member_off = member_off;
 
@@ -22671,6 +22847,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Cannot attach to a target with arena context arguments\n");
 			return -EOPNOTSUPP;
 		}
+		/* the trampoline and the extension don't preserve BPF_REG_ARENA_SP */
+		if (subprog && aux->arena_stack_size) {
+			bpf_log(log, "Cannot attach to a subprog of a program that uses R%d\n",
+				BPF_REG_ARENA_SP);
+			return -EOPNOTSUPP;
+		}
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
@@ -24053,6 +24235,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_arena_stack(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Find pointers to functions in the read-only maps of the program. */
 	ret = resolve_func_ptrs(env);
 	if (ret < 0)
@@ -24182,6 +24368,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 			sanitize_dead_code(env);
 	}
 
+	if (ret == 0)
+		ret = bpf_insert_arena_stack(env);
+
 	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret = bpf_convert_ctx_accesses(env);
diff --git a/tools/testing/selftests/bpf/verifier/basic_stx_ldx.c b/tools/testing/selftests/bpf/verifier/basic_stx_ldx.c
index 7a0aab3f2cd2..66fde558df33 100644
--- a/tools/testing/selftests/bpf/verifier/basic_stx_ldx.c
+++ b/tools/testing/selftests/bpf/verifier/basic_stx_ldx.c
@@ -28,10 +28,10 @@
 {
 	"invalid src register in LDX",
 	.insns = {
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, 12, 0),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, 13, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "R12 is invalid",
+	.errstr = "R13 is invalid",
 	.result = REJECT,
 },
 {
-- 
2.55.0

