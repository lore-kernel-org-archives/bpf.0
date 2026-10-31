Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483789;
	b=DzSyKkSAOxVFbTlFcTKSiK/w/5BW4j4NxFdXWL9ZHAYtpFkSsltfEEgdVwLaw9P3fJSI
	 JKiBAuIFsm/ViCMQYS3PdtlhD03Plx4qOWa+udpxp2K+czvFyx8qKIhNlr4buQZ89LNdF
	 7tqkHOOVbEMJt8XAu0g+FJbOkenpeWqqaJcqNFSQm+ZaGD8QL1E74eDa9lhi7YUjXWexC
	 3Sn1yuB9Ex0+dpXMuWGqS12CGQyXHGZKzr4VqUl0G2eqmUFHl4xY6buHdhFSgEWWeZymV
	 ucpi3A+3oknEPOc1wlpxrz3PoCgwRU23sS+Bs3/BPpahIXQcT+jDyFPH5YaLuP7Z3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sPMXXVE9+hyzDELuzZVZCB60voqk86ZCB7bJHpDJSjY=;
	b=lrSzur++7o8q+K2WEfviK59dtNcIVsor92+WnJLRRw7DJqlKbrCUosubGCV3ukHtyHDr
	 k+t15roOi6G0aw5mPG+5hDSCcp40Dmp95zL2iAAdncd3zYZGhgY6q75Ut7LB1S7LKzByp
	 GObaFfKDO+f2s+UFsIPvoEvUV/06MI2RzKe2xdQW/y00d+xXP5XSlkdXiuWj4EI5MQ9CZ
	 mRT8rWpYSKUfe8xRli2KgU67W68PPulgIcLM6n/JMYNKZk8MHHbOiw7Vx71sRYSCAHEwr
	 +dDaS8Qr9H+C/VrWQVSSUEqOuoi6BiJ3s6icNjxipY59nsxi2tVpuBTpEe/9Zq/ND7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fo6Jp+jr;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDE606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8FDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fo6Jp+jr
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1500525a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483788; x=1794088588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sPMXXVE9+hyzDELuzZVZCB60voqk86ZCB7bJHpDJSjY=;
        b=Fo6Jp+jrSAaLbKfraTgX2VBRy0PS20mh092w5lFxsg720oG+W2IhVGU/SSvA9TpWWP
         cLZTlgybzBgoO5B9lnWvjxeE9tfaQd8Yy2LFipmdEAPT1IqJGgOq9SitGGw8+GJf1yBW
         xpq62yKMMp5qSQyqkboKHIiWtMkL8zGnztUmAKvEq5360zcg6+eXFcqCsU0XLeUGNXE2
         +LepEXhXNgDE5eFLIRpv2P/GE/2jVG3Lf/fDDJUzTaC5zfngU7T512u+JhkYH+BDEZBR
         I5g0lS92FAZLov9RlTUISv2EYi4Ti6g90eLUxx4HlsHCMfCoRwZDsC8thvTzIJnfqwoS
         +Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483788; x=1794088588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sPMXXVE9+hyzDELuzZVZCB60voqk86ZCB7bJHpDJSjY=;
        b=UfisC/abhWtXsqrFAytsbjsuEwTDai6JKxEKPxkXoXt2JqkNwoyayKM/N+dYIRPUJM
         GGz6I5XZGUjxqOUZQ/WiND4yW9JJkxV39b3XDtAg6ybBiuZHRwmxWTXiFYtzfr2kLuH4
         2k+v0D4iR11FLD//5A0HzBVtqqkAUUSNElsRDrNYfviw7M3tJskG6kN9ybVsCxW4fB+A
         zpvCSPQjdUvL3gsy34NOCRePolVfUwhjeW//nIdh/VgwD5pLjGlhc0o0iMXXw5cGTVvK
         YbttDAMhZTsJKR/8uQ1306vfamymwIZRLTRoneSwuYdgG8/WAs/bv+A393RqQ6mf3TUi
         Vdgw==
X-Gm-Message-State: AFq9FYKN8lzbXlNDU1ecILlYQvA3xLOwWkcwCs9WXn749fbY/If+yMmB
	nHxcwgFfJD17r8Wo0vgpZ0Fqi3ahHokJF0IyUBvJI4iU9jwmHbiGD5c7hwZKhw==
X-Gm-Gg: AYBFou20wKDCKpQoI4vU7wSWh3r/Uh8flnlpsmis8D54Xu5gCqEgiYawTPAT97T0bde
	Fthe04JFTUfgjc/EfgoIJc1HNE/kJocLJuW8x4KG5HCVRgTIY1JmPzeU444qrE1J3rQjUUS36YB
	xcHMLsfoHedGSvyYcsE+AukoBh0e2ItGgMltp8LSLpv+sM09reVkTBtKGmVck3dE51x42kZMSKk
	nG+GHoUGSteTIES0h6I7cJ61boc9Y68+cS6uAgn2wIRyAxw3J45rTiplbwJgjPSdbf0JUnExh+3
	HFB7/aXBv6i00//3xXe7JP9e9hJgKC6QWcPXj670HsdJP5wFsjatdPX+0AKKR9o4cPnNjHq9Pvx
	bGubdAs4PmRCn82bL4nnljiz9arpGD3mwz+83y+Qru+erQ9WeDxdYTEyGmQ39Zo2cnFGjpVFOYJ
	ikGRTyB++Zkz7i3sYxzhWFXVBTC7DFEOIQQUbDzs7zrBiNp3HVXfO9hBzy8rPT0H+zPnjQujUNY
	kgoH5kixatBlSuvNSgL8jm2HjKZ0GWI3PVz4x7pVG4Uy11LFMzZcVAhRMpMyfhGXiA3hNCwUne5
	uju7ermBFVjIuJTITm97x0UUXm6zZXFimoABZBq4jtzoaeR+TbhM/PTGxzS9FO8vV/j6IEkKEXs
	2Hy1DOlp7+1SNJsf36VDgCbt01VTIwl9ywodLEV8YSPEkcbpiaWnlIcaJPkMnpPu3Cyu+ULnEDA
	==
X-Received: by 2002:a17:90b:4b92:b0:3ac:86a0:5766 with SMTP id 98e67ed59e1d1-3ae897fb684mr4697603a91.63.1793483787867;
        Sat, 31 Oct 2026 14:56:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f5dcc3sm4657063a91.3.2026.10.31.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 7/9] bpf: One may_goto time slice per prog invocation
Date: Sat, 31 Oct 2026 21:55:41 +0000
Message-ID: <20261031215543.682284-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
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

The count and the timestamp of may_goto are in the stack frame. So the
limit of 250 ms is for one call of a subprog, not for one invocation of the
prog, and loops that nest across calls multiply it. These 9 insns cause a
soft lockup:

  main:                 sub:
  1: call sub           1: may_goto 2f
     may_goto 2f           goto 1b
     goto 1b            2: r0 = 0
  2: r0 = 1                exit
     exit

Use one count and one timestamp for all may_goto of a prog, in per-cpu
memory of the prog. The main prog sets them in its first insns. When the
time is up each loop ends at its next may_goto, in any function.

  rX = address of the count
  rX = &(void __percpu *)(rX)
  r12 = *(u64 *)(rX +0)
  if r12 == 0x0 goto target
  r12 -= 1
  if r12 != 0x0 goto pc+2
  r12 = rX
  call arch_bpf_timed_may_goto
  *(u64 *)(rX +0) = r12

rX is a register that is dead at the may_goto. When all ten are live R0 is
saved in the stack.

An async callback can interrupt the prog on the same cpu. So its caller
sets count and timestamp, and puts the old values back at the end. A second
invocation of the prog on the same cpu gives more time to the first one.

  x86-64 (Zen 5), nsec                             before  after
  iteration, empty loop                             0.36    0.44
  iteration, the body takes 4 cycles                0.89    0.89
  call of a subprog and 1 iteration                 1.21    1.16

The 56 progs of scx with may_goto get 1.7% more JITed code and use 25% less
stack.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                           |   2 +
 include/linux/filter.h                        |   8 ++
 kernel/bpf/core.c                             |  33 +++++
 kernel/bpf/fixups.c                           | 125 ++++++++++++------
 kernel/bpf/helpers.c                          |  19 ++-
 .../bpf/progs/verifier_bpf_fastcall.c         |  74 ++++++-----
 .../selftests/bpf/progs/verifier_may_goto_1.c |  32 +++--
 7 files changed, 202 insertions(+), 91 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ff0436781293..01d5c79b487e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1916,6 +1916,8 @@ struct bpf_prog_aux {
 	const char *attach_func_name;
 	struct bpf_prog **func;
 	struct bpf_prog_aux *main_prog_aux;
+	/* main prog: there when the prog has timed may_goto */
+	struct bpf_timed_may_goto __percpu *timed_may_goto;
 	void *jit_data; /* JIT specific data. arch dependent */
 	struct bpf_jit_poke_descriptor *poke_tab;
 	struct bpf_kfunc_desc_tab *kfunc_tab;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 98254742ae37..4f0cd67caccb 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -758,9 +758,15 @@ struct bpf_prog_stats {
 	struct u64_stats_sync syncp;
 } __aligned(2 * sizeof(u64));
 
+/*
+ * Per-cpu memory of a prog. All may_goto of one invocation of the prog use it. An invocation is
+ * one call from the kernel into the main prog, with the subprogs and sync callbacks it reaches.
+ */
 struct bpf_timed_may_goto {
 	u64 count;
 	u64 timestamp;
+	/* the async callback that has set count and timestamp, see bpf_timed_may_goto_save() */
+	void *owner;
 };
 
 struct sk_filter {
@@ -1328,6 +1334,8 @@ u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
+void bpf_timed_may_goto_save(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
+void bpf_timed_may_goto_restore(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7cf37690d41f..3b02aafba4c5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -292,6 +292,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		kfree(fp->aux->poke_tab);
+		free_percpu(fp->aux->timed_may_goto);
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
@@ -3643,6 +3644,38 @@ u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 	return BPF_MAX_TIMED_LOOPS;
 }
 
+/*
+ * The main prog sets count and timestamp in its first insns. A call of an async callback is an
+ * invocation of its own too, but it can interrupt an invocation of the prog on this cpu, or go on
+ * next to one that is preempted. So its caller sets count and timestamp, and puts the old ones
+ * back at the end. Not when another invocation has set them in the meantime: they are for that
+ * one now.
+ * The caller has disabled migration.
+ */
+void bpf_timed_may_goto_save(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved)
+{
+	struct bpf_timed_may_goto *cur;
+
+	if (!prog->aux->timed_may_goto)
+		return;
+	cur = this_cpu_ptr(prog->aux->timed_may_goto);
+	*saved = *cur;
+	cur->count = BPF_MAX_TIMED_LOOPS;
+	cur->timestamp = 0;
+	cur->owner = saved;
+}
+
+void bpf_timed_may_goto_restore(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved)
+{
+	struct bpf_timed_may_goto *cur;
+
+	if (!prog->aux->timed_may_goto)
+		return;
+	cur = this_cpu_ptr(prog->aux->timed_may_goto);
+	if (cur->owner == saved)
+		*cur = *saved;
+}
+
 /* for configs without MMU or 32-bit */
 __weak const struct bpf_map_ops arena_map_ops;
 __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5cbab55d84be..66b9d1d9e961 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1803,6 +1803,50 @@ static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
 	return cnt + tail_cnt;
 }
 
+/*
+ * Timed may_goto. All may_goto of a prog use one count and one timestamp: per-cpu memory of the
+ * prog, set in the first insns of the main prog, and by the callers of async callbacks.
+ * @reg holds the address. It is a register that is dead at the may_goto, or R0 that is saved at
+ * @save_off in the stack.
+ */
+static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off,
+				 struct bpf_timed_may_goto __percpu *tmg, int reg, int save_off)
+{
+	struct bpf_insn ld_tmg[] = { BPF_LD_IMM64(reg, (__force unsigned long)tmg) };
+	int cnt = 0, jmp, tail_cnt = save_off ? 6 : 5;
+
+	if (save_off)
+		insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, reg, save_off);
+	insn_buf[cnt++] = ld_tmg[0];
+	insn_buf[cnt++] = ld_tmg[1];
+	insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(reg, reg);
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, reg, 0);
+	if (save_off) {
+		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
+		jmp = cnt++;
+		insn_buf[jmp] = BPF_JMP32_A(off >= 0 ? off + tail_cnt : off - jmp);
+	} else {
+		jmp = cnt;
+		off = off >= 0 ? off + tail_cnt : off - jmp;
+		if (off == (s16)off) {
+			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
+		} else {
+			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
+			insn_buf[cnt++] = BPF_JMP32_A(off >= 0 ? off : off - 1);
+		}
+	}
+	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+	/* AX is the argument and the return value */
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_AX, reg);
+	insn_buf[cnt++] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, reg, BPF_REG_AX, 0);
+	if (save_off)
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
+	return cnt;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -1825,6 +1869,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	u16 stack_depth_extra = 0;
 	/* arch_bpf_timed_may_goto() takes and returns AX in a cpu register: for JITs only */
 	bool timed_may_goto = prog->jit_requested && bpf_jit_supports_timed_may_goto();
+	struct bpf_timed_may_goto __percpu *tmg = NULL;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn *patch = insn_buf;
@@ -2081,39 +2126,27 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
-			int stack_off_cnt = -stack_depth - 16;
-			/*
-			 * AX is used as an argument to pass in the pointer to
-			 * count and timestamp, and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
-			 */
-			struct bpf_insn tail[] = {
-				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
-				BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 3),
-				BPF_MOV64_REG(BPF_REG_AX, BPF_REG_10),
-				BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt),
-				BPF_EMIT_CALL(arch_bpf_timed_may_goto),
-				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt),
-			};
-
-			/*
-			 * Two 8 byte slots, depth-16 stores the count, and
-			 * depth-8 stores the start timestamp of the loop.
-			 *
-			 * The starting value of count is BPF_MAX_TIMED_LOOPS
-			 * (0xffff).  Every iteration loads it and subs it by 1,
-			 * until the value becomes 0 in AX (thus, 1 in stack),
-			 * after which we call arch_bpf_timed_may_goto, which
-			 * either sets AX to 0xffff to keep looping, or to 0
-			 * upon timeout. AX is then stored into the stack. In
-			 * the next iteration, we either see 0 and break out, or
-			 * continue iterating until the next time value is 0
-			 * after subtraction, rinse and repeat.
-			 */
-			stack_depth_extra = 16;
+			u16 live = env->insn_aux_data[i + delta].live_regs_before;
+			int reg, save_off = 0;
+
+			/* a register that is dead here holds the address of the count */
+			for (reg = BPF_REG_0; reg <= BPF_REG_9; reg++)
+				if (!(live & BIT(reg)))
+					break;
+			if (reg > BPF_REG_9) {
+				reg = BPF_REG_0;
+				save_off = -stack_depth - 8;
+				stack_depth_extra = 8;
+			}
+			if (!tmg) {
+				tmg = alloc_percpu_gfp(struct bpf_timed_may_goto,
+						       GFP_KERNEL_ACCOUNT);
+				if (!tmg)
+					return -ENOMEM;
+				prog->aux->timed_may_goto = tmg;
+			}
 			prog->jit_required = 1;
-			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
-					      tail, ARRAY_SIZE(tail));
+			cnt = may_goto_expand_timed(insn_buf, insn->off, tmg, reg, save_off);
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2734,24 +2767,36 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
-		int delta = timed_may_goto ? 2 : 1;
 		int subprog_start = subprogs[i].start;
 		int stack_slots = subprogs[i].stack_extra / 8;
-		int slots = delta, cnt = 0;
+		/* an invocation begins, see bpf_timed_may_goto_save() for async callbacks */
+		bool main_prog = tmg && !i;
+		int cnt = 0;
 
-		if (!stack_slots)
+		if (timed_may_goto ? !main_prog : !stack_slots)
 			continue;
-		/* We need two slots in case timed may_goto is supported. */
-		if (stack_slots > slots) {
+		if (stack_slots > 1) {
 			verifier_bug(env, "stack_slots supports may_goto only");
 			return -EFAULT;
 		}
 
 		stack_depth = subprogs[i].stack_depth;
 		if (timed_may_goto) {
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
+			struct bpf_insn ld_tmg[] = {
+				BPF_LD_IMM64(BPF_REG_0, (__force unsigned long)tmg)
+			};
+			int count_off = offsetof(struct bpf_timed_may_goto, count);
+			int timestamp_off = offsetof(struct bpf_timed_may_goto, timestamp);
+			int owner_off = offsetof(struct bpf_timed_may_goto, owner);
+
+			/* R0 has nothing at the entry */
+			insn_buf[cnt++] = ld_tmg[0];
+			insn_buf[cnt++] = ld_tmg[1];
+			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
 						     BPF_MAX_TIMED_LOOPS);
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
 		} else {
 			/* Add ST insn to subprog prologue to init extra stack */
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
@@ -2778,7 +2823,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		 * to insn after BPF_ST that inits may_goto count.
 		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, cnt - 1));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 58e357302850..2b75f7ba07a5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1222,6 +1222,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
 	struct bpf_map *map = READ_ONCE(t->cb.map);
+	struct bpf_prog *prog = READ_ONCE(t->cb.prog);
+	struct bpf_timed_may_goto saved;
 	void *value = t->cb.value;
 	bpf_callback_t callback_fn;
 	void *key;
@@ -1229,7 +1231,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	BTF_TYPE_EMIT(struct bpf_timer);
 	callback_fn = rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_bh_held());
-	if (!callback_fn || !map)
+	if (!callback_fn || !map || !prog)
 		goto out;
 
 	/* bpf_timer_cb() runs in hrtimer_run_softirq. It doesn't migrate and
@@ -1242,8 +1244,10 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	key = map_key_from_value(map, value, &idx);
 
+	bpf_timed_may_goto_save(prog, &saved);
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
 	/* The verifier checked that return value is zero. */
+	bpf_timed_may_goto_restore(prog, &saved);
 
 	this_cpu_write(hrtimer_running, NULL);
 out:
@@ -1254,6 +1258,8 @@ static void bpf_wq_work(struct work_struct *work)
 {
 	struct bpf_work *w = container_of(work, struct bpf_work, work);
 	struct bpf_async_cb *cb = &w->cb;
+	struct bpf_timed_may_goto saved;
+	struct bpf_prog *prog;
 	struct bpf_map *map;
 	bpf_callback_t callback_fn;
 	void *value = cb->value;
@@ -1267,14 +1273,17 @@ static void bpf_wq_work(struct work_struct *work)
 
 	map = READ_ONCE(cb->map);
 	callback_fn = READ_ONCE(cb->callback_fn);
-	if (!callback_fn || !map)
+	prog = READ_ONCE(cb->prog);
+	if (!callback_fn || !map || !prog)
 		goto out;
 
 	key = map_key_from_value(map, value, &idx);
 
 	migrate_disable();
 
+	bpf_timed_may_goto_save(prog, &saved);
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	bpf_timed_may_goto_restore(prog, &saved);
 
 	migrate_enable();
 out:
@@ -4593,6 +4602,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx,
 static void bpf_task_work_callback(struct callback_head *cb)
 {
 	struct bpf_task_work_ctx *ctx = container_of(cb, struct bpf_task_work_ctx, work);
+	struct bpf_timed_may_goto saved;
 	enum bpf_task_work_state state;
 	u32 idx;
 	void *key;
@@ -4614,8 +4624,10 @@ static void bpf_task_work_callback(struct callback_head *cb)
 	key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
 
 	migrate_disable();
+	bpf_timed_may_goto_save(ctx->prog, &saved);
 	ctx->callback_fn((u64)(long)ctx->map, (u64)(long)key,
 			 (u64)(long)ctx->map_val, 0, 0);
+	bpf_timed_may_goto_restore(ctx->prog, &saved);
 	migrate_enable();
 
 	bpf_task_work_ctx_reset(ctx);
@@ -4855,6 +4867,7 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	struct bpf_rcu_head_kern *rh = container_of(rcu, struct bpf_rcu_head_kern, rcu);
 	bpf_callback_t callback_fn = rh->callback_fn;
 	struct bpf_prog *prog = rh->prog;
+	struct bpf_timed_may_goto saved;
 	struct bpf_map *map = rh->map;
 	void *value, *key;
 	u32 idx;
@@ -4866,7 +4879,9 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
 	smp_store_release(&rh->armed, 0);
 
 	rcu_read_lock_dont_migrate();
+	bpf_timed_may_goto_save(prog, &saved);
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	bpf_timed_may_goto_restore(prog, &saved);
 	rcu_read_unlock_migrate();
 
 	bpf_prog_put(prog);
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index faedf36eef2a..d908298b9fc7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -903,27 +903,28 @@ __naked void unconditional_jump_to_fill(void)
 SEC("raw_tp")
 __arch_x86_64
 __log_level(4)
-__msg("subprog 0 (may_goto_interaction_x86_64) main {{.*}} stack 24")
-/* may_goto counter at -24 */
-__xlated("0: *(u64 *)(r10 -24) =")
-/* may_goto timestamp at -16 */
-__xlated("1: *(u64 *)(r10 -16) =")
-__xlated("2: r1 = 1")
+__msg("subprog 0 (may_goto_interaction_x86_64) main {{.*}} stack 8")
+/* may_goto counter and timestamp */
+__xlated("0: r0 = ")
+__xlated("2: r0 = &(void __percpu *)(r0)")
 __xlated("...")
-__xlated("4: r0 = &(void __percpu *)(r0)")
+__xlated("6: r1 = 1")
+__xlated("...")
+__xlated("8: r0 = &(void __percpu *)(r0)")
 __xlated("...")
-/* may_goto expansion starts */
-__xlated("6: r12 = *(u64 *)(r10 -24)")
-__xlated("7: if r12 == 0x0 goto pc+7")
-__xlated("8: r12 -= 1")
-__xlated("9: if r12 != 0x0 goto pc+3")
-__xlated("10: r12 = r10")
-__xlated("11: r12 += -24")
-__xlated("12: call unknown")
-__xlated("13: *(u64 *)(r10 -24) = r12")
+/* may_goto expansion starts, r0 and r1 are live */
+__xlated("10: r2 = ")
+__xlated("12: r2 = &(void __percpu *)(r2)")
+__xlated("13: r12 = *(u64 *)(r2 +0)")
+__xlated("14: if r12 == 0x0 goto pc+6")
+__xlated("15: r12 -= 1")
+__xlated("16: if r12 != 0x0 goto pc+2")
+__xlated("17: r12 = r2")
+__xlated("18: call unknown")
+__xlated("19: *(u64 *)(r2 +0) = r12")
 /* may_goto expansion ends */
-__xlated("14: *(u64 *)(r10 -8) = r1")
-__xlated("15: exit")
+__xlated("20: *(u64 *)(r10 -8) = r1")
+__xlated("21: exit")
 __success
 __naked void may_goto_interaction_x86_64(void)
 {
@@ -947,25 +948,26 @@ __arch_arm64
 __arch_riscv64
 __arch_loongarch
 __log_level(4)
-__msg("subprog 0 (may_goto_interaction) main {{.*}} stack 24")
-/* may_goto counter at -24 */
-__xlated("0: *(u64 *)(r10 -24) =")
-/* may_goto timestamp at -16 */
-__xlated("1: *(u64 *)(r10 -16) =")
-__xlated("2: r1 = 1")
-__xlated("3: call bpf_get_smp_processor_id")
-/* may_goto expansion starts */
-__xlated("4: r12 = *(u64 *)(r10 -24)")
-__xlated("5: if r12 == 0x0 goto pc+7")
-__xlated("6: r12 -= 1")
-__xlated("7: if r12 != 0x0 goto pc+3")
-__xlated("8: r12 = r10")
-__xlated("9: r12 += -24")
-__xlated("10: call unknown")
-__xlated("11: *(u64 *)(r10 -24) = r12")
+__msg("subprog 0 (may_goto_interaction) main {{.*}} stack 8")
+/* may_goto counter and timestamp */
+__xlated("0: r0 = ")
+__xlated("2: r0 = &(void __percpu *)(r0)")
+__xlated("...")
+__xlated("6: r1 = 1")
+__xlated("7: call bpf_get_smp_processor_id")
+/* may_goto expansion starts, r0 and r1 are live */
+__xlated("8: r2 = ")
+__xlated("10: r2 = &(void __percpu *)(r2)")
+__xlated("11: r12 = *(u64 *)(r2 +0)")
+__xlated("12: if r12 == 0x0 goto pc+6")
+__xlated("13: r12 -= 1")
+__xlated("14: if r12 != 0x0 goto pc+2")
+__xlated("15: r12 = r2")
+__xlated("16: call unknown")
+__xlated("17: *(u64 *)(r2 +0) = r12")
 /* may_goto expansion ends */
-__xlated("12: *(u64 *)(r10 -8) = r1")
-__xlated("13: exit")
+__xlated("18: *(u64 *)(r10 -8) = r1")
+__xlated("19: exit")
 __success
 __naked void may_goto_interaction(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 2de1ae144ac9..20152a15ca36 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -88,19 +88,25 @@ __arch_s390x
 __arch_arm64
 __arch_riscv64
 __arch_loongarch
-__xlated("0: *(u64 *)(r10 -16) = 65535")
-__xlated("1: *(u64 *)(r10 -8) = 0")
-__xlated("2: r12 = *(u64 *)(r10 -16)")
-__xlated("3: if r12 == 0x0 goto pc+7")
-__xlated("4: r12 -= 1")
-__xlated("5: if r12 != 0x0 goto pc+3")
-__xlated("6: r12 = r10")
-__xlated("7: r12 += -16")
-__xlated("8: call unknown")
-__xlated("9: *(u64 *)(r10 -16) = r12")
-__xlated("10: r0 = 1")
-__xlated("11: r0 = 2")
-__xlated("12: exit")
+/* the main prog sets count, timestamp, owner */
+__xlated("0: r0 = ")
+__xlated("2: r0 = &(void __percpu *)(r0)")
+__xlated("3: *(u64 *)(r0 +0) = 65535")
+__xlated("4: *(u64 *)(r0 +8) = 0")
+__xlated("5: *(u64 *)(r0 +16) = 0")
+/* may_goto, r0 is dead */
+__xlated("6: r0 = ")
+__xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("9: r12 = *(u64 *)(r0 +0)")
+__xlated("10: if r12 == 0x0 goto pc+6")
+__xlated("11: r12 -= 1")
+__xlated("12: if r12 != 0x0 goto pc+2")
+__xlated("13: r12 = r0")
+__xlated("14: call unknown")
+__xlated("15: *(u64 *)(r0 +0) = r12")
+__xlated("16: r0 = 1")
+__xlated("17: r0 = 2")
+__xlated("18: exit")
 __success
 __naked void may_goto_batch_2(void)
 {
-- 
2.55.0

