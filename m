Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755511;
	b=smKP++FIwA+iGtxrAvKOKQN7vi5CDElaT8ZyxaWk4ZP4s+JYa6JQPftYzEp8bvsa8SeS
	 xKZIBXEHzFar/35SOaxdvhGv9ZfeewdGjrsiJtO1XCE7ET3q+DG0wV/EzIFSzg5D8getV
	 qzNhu70tJh6YWfy/WhdNJhs32dAzGxjt2sbf+rxK6i+JW0/NIgY8h9Cj4eqXNRpj5lSxv
	 1WKJnyg3Ki+rbW4yfGfJZ3fO04II1h6pkRywz0q6W7Alds4asabFkRyDO6UrJhSEzIDpm
	 nNF8m8HA7Eu5NHRtXySu5EwnuX7B+51jg2ddadcK0ePCqJMvbcO/YHScCJTb3XuNfoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oAx3qfT6CO23moUbI0127dgLhfhAX6CnMEcCUyHRmvg=;
	b=pzLq3fvaN/TOVvDfmHKuyAvgWAxWMh9AN9wu8P4ZMsEv+aA2ZBxgpWtcMgPBZIv7qyd0
	 zY13s5OqYCWUK7u1wI6rhpv1HBcqmNN0mbbfNws/8mHrHnP3z4LPH4cs9Vp1ZfXhDwfkA
	 QjTkt80xFKnk6l31vvNgkQrKalgt64OIFSsDQZGoBkByzh4cogj/XDCr+R1sagSTBtQJ8
	 jOKPCxeiN3gZmE62xTmfB+8ss3VS+EM+lrY4Bmg6qtRVbWmW8Y8AW+oJH3Ot1x8WWHhSn
	 SNeCaNf9xNaXUbklZFEMb15DeKqYrjZo7v38TQnFz5LKjvlm+iDKvwMDqDAyJXHNOWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="sMbG/B19";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33EC606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33EC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMbG/B19
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so113871a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755510; x=1794360310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAx3qfT6CO23moUbI0127dgLhfhAX6CnMEcCUyHRmvg=;
        b=sMbG/B19JmdC2YUxkqQlbi3DjMgIfwqGRO5Ed/dGDA0iQISe70yv+nwwS6hDDhfroO
         tHzx8d2rb9seoT/nO8jK5WRgDXYsZS/td85ljBe+eVoVw0bC/fTy7F+PpgMAAjsuobh9
         dr66FbNawHGli9osNeUqRPD2UeRCIqTSRZ+Oxx8IvR76nQw/ge0TOmxPPP8GRWNBTIAE
         pJYUpovtv3HGhV3xM/xm0dzAXMfhQL5j82o/7WzUxgM4QJBVaJ1puwQ8nYqcMs7FXUVy
         PECmckVPYCCWnGkROZwc0LND52Zrs4qdphL/NyVNqROuVsKZx3zMFLQLBVSLdlcG7/nK
         4VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755510; x=1794360310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oAx3qfT6CO23moUbI0127dgLhfhAX6CnMEcCUyHRmvg=;
        b=foyWBOHh2mX2tDU9qwOcCrvOGbu6qzGGsx+48+nhhKnVuksOrn8AoqWS76BO4KSd0B
         xh28hADq537egelcJeyMHjZf4vgCqAB3C6xx19SX+HOoRU6QDP0q3IwUIzalNly33wRY
         D0gptsF/m3DUvyHLwHr1vq5iyCYMRmn8p0yjqGQmXeek+cRTsISIfUbuIpJ0byV80weE
         OstSN5qeCvZHKV3m6UZSYoxZ2moLXnMCIYEQenotNP0hXsZvjm6e2QD9xPGzIvM4wk0v
         QGgvr5fo2cTR7Jx71eA1i7SCrds621VSyBGPPjgUk8v6Yx+5YiuQ0HA/dLwAjar12rGN
         1zOA==
X-Gm-Message-State: APuU4Z+A6Pil5OOlI55YwAx5jNj0RYH33lCWc8BpRJgzPLxy3+xngA1s
	KHV5/Hxk7rpAJ3ozy7u2se/cB/grO0GonmfprcKYXG83WQrqnZpvn3pI7CQatw==
X-Gm-Gg: AYBFou0Gf+S6c7l38TqPl8T4w/QpEZG7wbrz3rO/ozX+OO3wbxoQbF61hlbuu6xZ6dc
	d+LCx1Gt70Gi5XeF+FMm2E51SexfAlLh209hUTW/Jsj8745H/Lwb/UbueEFbhJ/xlsiBH4qfqOW
	/PkenzxM2ma018Auj/cdm5HjT8HySpL08Rr2s2H2cynsPDh0sSQJRb3u2jo2qGEKZUKAWFL2znJ
	QHdpuz4FNi9JuKfSQex+ny4S/JjBZ5k0ZwFKa1BAVlPSqlEfTV1AMdSRizOXkdJ0PYCOcRgue6U
	GutN+h8YBI3hCQ8l3jay0jnaa08fMkJK4ok3UHaTx3zKkZITx7YEszctU5gikUfY+BknxS6rP53
	noonroBnMK/2ATZi5xpE2sJGwXnWdZCTipC8JdeZizf8QgNCnpo65TDI5cnWbI9/Yxvx6j/BKvA
	qWxdCtleloyhqZgpSNGFBVjgmkzB/6LEcDY9RnB05iwZIvoJZtEntq2iPTPD2uBBLg4429+yJal
	C13FPylOOy5Z96KNnyl+REJiRJYHsRWaBuwBllXuH7rjGOYuCzGafmHMqS72vVaFdy8KLZkzVkW
	JNEUpvKycCiCx7j90M+IJLhqDfTasGNNOqMCCSQzccqLIOLNqEEbKCrkD0a1vHHAE5lXF/neu9X
	wslQh+uc56a4pEmyLvYoBibzUfMnnSW8QZU+nERrwuI8pi4r57z6ZACAInULYZ4yY6Ggh1tu+aX
	hrFnpUjKXm4ouzhwYUozY=
X-Received: by 2002:a17:90b:2fd0:b0:3ac:af8b:6f3 with SMTP id 98e67ed59e1d1-3ae898149e2mr11008415a91.52.1793755509654;
        Tue, 03 Nov 2026 17:25:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e1d3esm6558968a91.3.2026.11.03.17.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:25:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 11/14] bpf: Support BPF_REG_ARENA_SP in the verifier
Date: Wed,  4 Nov 2026 01:23:57 +0000
Message-ID: <20261104012401.1354861-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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
 - It rejects a call of the main prog, and a call and a callx of a callback
   that takes a stack, because the caller would get the r12 of the callee.
 - Nothing can attach to a subprog, because the x86 trampoline does not
   keep r12.
 - The private stack is off, because the x86 JIT has one register for the
   two.
 - bpf_throw() does not give the stack back. The stack stays taken until
   the arena is freed, for all progs of the arena on that cpu. After 17
   throws on a cpu each run there allocates a stack, and each more throw
   loses the pages of one stack. Rust progs unwind and do not throw.

may_goto sets is_called in struct bpf_subprog_info for a function that BPF
code calls, and for a callback of a helper other than bpf_loop() and
bpf_for_each_map_elem(). Such a callback can take a stack. A function that
BPF code calls cannot. Give these callbacks a bit of their own,
is_other_cb. may_goto examines the two bits.

The test "invalid src register in LDX" of test_verifier used r12. Use r13.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |  14 +-
 include/linux/filter.h                        |  59 +++++
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/const_fold.c                       |   7 +
 kernel/bpf/core.c                             |  25 +++
 kernel/bpf/fixups.c                           | 202 +++++++++++++++++-
 kernel/bpf/liveness.c                         |   8 +
 kernel/bpf/scev.c                             |   9 +-
 kernel/bpf/verifier.c                         | 194 ++++++++++++++++-
 .../selftests/bpf/verifier/basic_stx_ldx.c    |   4 +-
 11 files changed, 516 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5c059a05f89d..acc8e0050cde 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1949,6 +1949,8 @@ struct bpf_prog_aux {
 	 * the page size. 0 when r12 is not used.
 	 */
 	u32 arena_stack_size;
+	/* a callback that takes a stack in arena, like the main program does */
+	bool arena_stack_entry;
 	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recursion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9ae6e109d211..f5a4fe8a58fe 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -944,6 +944,9 @@ enum priv_stack_mode {
 	PRIV_STACK_ADAPTIVE,
 };
 
+/* The most that the frames of a call chain take in the stack in arena */
+#define BPF_ARENA_STACK_MAX (32 << 10)
+
 struct bpf_subprog_info {
 	const char *name; /* name extracted from BTF */
 	u32 start; /* insn idx of function entry point */
@@ -957,6 +960,7 @@ struct bpf_subprog_info {
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	u16 arena_stack_depth; /* size of the frame in the stack in arena */
 	u32 insns_total;
 	u32 insns_self;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
@@ -973,7 +977,9 @@ struct bpf_subprog_info {
 	bool is_exception_cb: 1;
 	/* bpf_loop() or bpf_for_each_map_elem() call it in a loop */
 	bool is_loop_cb: 1;
-	/* BPF code, another helper or a kfunc call it */
+	/* another helper or a kfunc calls it */
+	bool is_other_cb: 1;
+	/* a call insn or callx calls it */
 	bool is_called: 1;
 	bool args_cached: 1;
 	/* true if the return value is passed in the R0:R2 register pair */
@@ -982,6 +988,9 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	bool uses_arena_sp: 1;
+	/* a callback that takes a stack in arena, like the main program does */
+	bool arena_stack_entry: 1;
 	u8 arg_slot_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
@@ -1145,6 +1154,8 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
+	bool uses_arena_sp;		/* the program has insns with BPF_REG_ARENA_SP */
+	u32 max_arena_stack_depth;	/* of all call chains */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
 	 * lists of struct bpf_verifier_state_list.
@@ -2092,6 +2103,7 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
 void bpf_lower_cast_mov(struct bpf_verifier_env *env);
+int bpf_insert_arena_stack(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7b730b6488ec..a58ad2318412 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -599,6 +599,21 @@ static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = BPF_CALL_IMM(FUNC) })
 
+/*
+ * The same in code that the verifier emits before bpf_do_misc_fixups(). That pass
+ * takes imm of a call for the id of a helper. This value in off, which is 0 in the
+ * call of a helper, says that imm is final. The pass clears it.
+ */
+#define BPF_KERNEL_CALL	1
+
+#define BPF_EMIT_KERNEL_CALL(FUNC)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_CALL,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = BPF_KERNEL_CALL,			\
+		.imm   = BPF_CALL_IMM(FUNC) })
+
 /* Kfunc call */
 
 #define BPF_CALL_KFUNC(OFF, IMM)				\
@@ -901,6 +916,49 @@ static inline bool is_stack_arg_stx(const struct bpf_insn *insn)
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
@@ -1337,6 +1395,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_arena_stack(void);
 bool bpf_jit_supports_local_atomics(void);
 bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2d6535f271a6..b9653965e525 100644
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
index 1466a85c2b1a..8df24e6f7c1f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3880,6 +3880,12 @@ bool __weak bpf_jit_supports_local_atomics(void)
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
@@ -3984,6 +3990,25 @@ __weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
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
index eb5756cbc7e5..fe8899c65240 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -729,6 +729,195 @@ void bpf_lower_cast_mov(struct bpf_verifier_env *env)
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
+	int jfree, jdone, jslow, slow, free, done, i, spill = 0;
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
+	*patch++ = BPF_EMIT_KERNEL_CALL(bpf_arena_stack_get);
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
+
+	buf[jfree] = BPF_JMP_IMM(BPF_JEQ, cnt, 0, free - jfree - 1);
+	buf[jdone] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, done - jdone - 1);
+	/* size is 0 until the stack is allocated */
+	buf[jslow] = BPF_JMP32_IMM(BPF_JLT, size, max(env->max_arena_stack_depth, 1),
+				   slow - jslow - 1);
+
+	/* a jump to the first insn doesn't take the stack again, neither does gotox */
+	return bpf_patch_list_insert(env, sub->start, buf, done);
+}
+
+int bpf_insert_arena_stack(struct bpf_verifier_env *env)
+{
+	struct bpf_map *arena = (struct bpf_map *)env->prog->aux->arena;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	struct bpf_insn *insn_buf = env->insn_buf, *patch, *insn;
+	struct bpf_prog_aux *aux = env->prog->aux;
+	struct bpf_insn ld_aux[2] = { BPF_LD_IMM64(BPF_REG_1, (long)aux) };
+	int i, cur = 0, err;
+
+	if (!env->uses_arena_sp)
+		return 0;
+
+	/* the caller would get r12 of the callee back */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		if ((i && !subprogs[i].arena_stack_entry) || !subprogs[i].is_called)
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
+
+		if (is_arena_sp_adj(insn)) {
+			insn->code = BPF_ALU | BPF_ADD | BPF_K;
+			env->insn_aux_data[i].zext_dst = true;
+		} else if (is_arena_sp_mov(insn)) {
+			/* rX = addr_space_cast(r12, 1, 0) */
+			if (!(arena->map_flags & BPF_F_NO_USER_CONV)) {
+				insn->off = BPF_ADDR_SPACE_CAST;
+				insn->imm = 1 << 16;
+			}
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
+				*patch++ = BPF_EMIT_KERNEL_CALL(bpf_arena_stack_put);
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
+			}
+			if (patch != insn_buf)
+				*patch++ = *insn;
+		}
+
+		if (patch != insn_buf) {
+			insn = bpf_patch_list_add(env, i, insn_buf, patch - insn_buf);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
+		}
+		/* Not before the insn is rewritten: the list takes a copy of it. */
+		if (subprogs[cur].start == i && (!cur || subprogs[cur].arena_stack_entry)) {
+			err = insert_arena_stack_get(env, cur);
+			if (err)
+				return err;
+		}
+	}
+	return bpf_patch_list_commit(env);
+}
+
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
 	int insn_cnt = env->prog->len;
@@ -1423,6 +1612,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->arena_stack_size = prog->aux->arena_stack_size;
+		func[i]->aux->arena_stack_entry = env->subprog_info[i].arena_stack_entry;
 		func[i]->aux->uses_arena_insns = bpf_prog_has_arena_insns(func[i]);
 		func[i]->aux->used_maps = env->used_maps;
 		func[i]->aux->used_map_cnt = env->used_map_cnt;
@@ -2201,6 +2392,11 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			goto next_insn;
+		/* imm is not the id of a helper */
+		if (!insn->src_reg && insn->off == BPF_KERNEL_CALL) {
+			insn->off = 0;
+			goto next_insn;
+		}
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			ret = bpf_fixup_kfunc_call(env, insn, insn_buf, i, &cnt);
 			if (ret)
@@ -2703,7 +2899,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		bool main_prog = tmg && !i;
 		/* only a helper calls it, in a loop that ends when it returns 1 */
 		bool loop_cb = tmg && i && subprogs[i].is_loop_cb && !subprogs[i].is_called &&
-			       !subprogs[i].is_async_cb;
+			       !subprogs[i].is_other_cb && !subprogs[i].is_async_cb;
 
 		if (timed_may_goto ? !main_prog && !loop_cb : !stack_slots)
 			continue;
@@ -2879,7 +3075,9 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 		struct bpf_loop_inline_state *inline_state =
 			&env->insn_aux_data[i].loop_inline_state;
 
-		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
+		/* the callback that takes a stack in arena is not for a call from the program */
+		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
+		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
 			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
 			err = inline_bpf_loop(env, i,
 					      -(stack_depth + stack_depth_extra),
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 1a4cfb575077..f9e80e39c4f0 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1440,6 +1440,11 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -1673,6 +1678,9 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	 */
 	if (is_stack_arg_stx(insn) || is_stack_arg_st(insn) || is_stack_arg_ldx(insn))
 		return 0;
+	/* Likewise at[12] is not r12, and the access is to arena. */
+	if (is_arena_sp_st(insn) || is_arena_sp_ldx(insn))
+		return 0;
 
 	switch (class) {
 	case BPF_LDX:
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 06dee7e421ea..093dd6fdcfe5 100644
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
index 488ee53561be..d834575f2628 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5792,6 +5792,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	struct bpf_insn *insn = env->prog->insnsi;
 	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable = false;
+	int arena_depth = 0;
 	int total;
 	int tmp;
 
@@ -5832,6 +5833,24 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
@@ -6020,6 +6039,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		return 0;
 	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
 		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
+	arena_depth -= subprog[idx].arena_stack_depth;
 
 	/* pop caller idx from callee */
 	idx = dinfo[idx].caller;
@@ -6048,10 +6068,20 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
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
@@ -11476,7 +11506,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	    (insn->imm == BPF_FUNC_loop || insn->imm == BPF_FUNC_for_each_map_elem))
 		env->subprog_info[subprog].is_loop_cb = true;
 	else
-		env->subprog_info[subprog].is_called = true;
+		env->subprog_info[subprog].is_other_cb = true;
 
 	/* for callback functions enqueue entry to callback and
 	 * proceed with next instruction within current frame.
@@ -20366,6 +20396,11 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
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
@@ -20382,12 +20417,64 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
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
@@ -21582,6 +21669,86 @@ static int check_insn_fields(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -21602,11 +21769,13 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 
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
@@ -22355,6 +22524,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
 
@@ -22770,6 +22945,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Cannot attach to a target with arena context arguments\n");
 			return -EOPNOTSUPP;
 		}
+		/* x86: the trampoline and the extension don't preserve BPF_REG_ARENA_SP */
+		if (subprog && aux->arena_stack_size) {
+			bpf_log(log, "Cannot attach to a subprog of a program that uses R%d\n",
+				BPF_REG_ARENA_SP);
+			return -EOPNOTSUPP;
+		}
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
@@ -24162,6 +24343,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_arena_stack(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Find pointers to functions in the read-only maps of the program. */
 	ret = resolve_func_ptrs(env);
 	if (ret < 0)
@@ -24291,6 +24476,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

