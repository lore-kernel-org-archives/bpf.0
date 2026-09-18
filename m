Received: from mail-qv2-f29.google.com (mail-qv2-f29.google.com [74.125.230.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975194F30F2
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743012; cv=none; b=eylRQ5aUqzxDccbdG0TS6lt/M5mdWc+8E9PbqYc1sXji2ZVRR+O9icjpJtbGiXLuP64jgE0Jn4gbFBq2Dc5Dh/NyRkCypyEHi8fpWpQbNAwMfwPuDn5R9r+GfG+Pq40+nthDG0F7Geza5JVZhpQNGXzJCTHUHiaKkRi8rGBVWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743012; c=relaxed/simple;
	bh=yHC4KMZfT4OhoIiDiBb7tvVf2glio0Mt2yiw+oyROR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmeXLXmQ6npUFlU8vad7tFaF4zvT5MBaAnaR/st5v08Mv+TONitSTeQG/CAwI2CE65K5psqzXCsKdrO/SH30hrXRismupEXn95X9K+s2vlEm80US9um40mpWbp7opEPMiRtS195fMFW2CFO4wqaRQvDrDzU1mTz1Jfjs9/Olnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=b78r88H9; arc=none smtp.client-ip=74.125.230.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="b78r88H9"
Received: by mail-qv2-f29.google.com with SMTP id 6a1803df08f44-90cdfc9b6ebso7635286d6.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743001; x=1790347801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q8bPS+4IlAeB++9fkK/U7jkDL1GJ1oJuOJz5hfsv6cg=;
        b=b78r88H97DF1G0qP3sv8vq2q58aKMFn6U+t5yLyoQS3cUzgR2c7/5J+MdNLfwNrjOf
         qt/+pm8mfiDp+Yhgkqa+4Zs3xNn0t8EkJQ+Vv0s2sFsdcJ5y+E91StgZ0yB6VXKtXOi+
         noZkC9N/mwsfxNpwLmPQByKufIxpZ0sXzrpNUc9y3VzIXXQlWPqZAQToo1rzR1bVqFKs
         8I9grE1W3Z6mCUvSZJwMt5ckflHsGR7Lc8q7DdiveRzQt41FxpktEPFEaJJEfk6DuKRc
         ePMWMgtTDE3hLwP5sGoS0IlQG7TSq/Dr8FXT1ypZXuatglcfDth8v+0cMoIe4i4oFhDm
         sOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743001; x=1790347801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8bPS+4IlAeB++9fkK/U7jkDL1GJ1oJuOJz5hfsv6cg=;
        b=zp2MklG/gFSNmcsdS8jaiOU/O2sLtZDd/BnR7alQ1kWDvnBB3ig9snvDfX4BK0SZ3V
         smwrOjG54ApNkmcztw0bC9rmKm5ICBZz8jjCrXHh4KAge7b91NESLvd7dsXkLYtbLGb+
         a0GH5AwI+0oW1q2Bt/uiPqZalOqr7Q+JbueF2NeFUGgMP0jmswlnaN4EwKH7tKsZ+/67
         bBdMtS7A6dqndXLlxV6JSgBlqoRqjFHCAOaBdF1rGrXNB1Y2hXGEdZsZ4Udn0iR5z6la
         tpnaNNLOWDz0OttopHGindBvm2allV9+8z9YG4luJ5Cb9UxOEeRNJ2O45p0omIQS8ZJn
         lHYA==
X-Forwarded-Encrypted: i=1; AKwUvBzOB3dCeD1jYOlDzda6rGt0zqQVoRHrb0L+x1SqhCuArO6RTwgpeV8i5rEWJVCTyHVamdY=@vger.kernel.org
X-Gm-Message-State: AFuF++mhpdpYk0jB9Qh7KmelKfe+xN3OKCutQeI/h5g12y3HXbLawOO7
	DaeRh/6XJ3gLVDcDAFA2K2PS9V1pLUrevYxHKqwKq+3BpufDObBKvMDFfXbg5ZmuIUk=
X-Gm-Gg: AYBFou2DhrdxAT1JuCB6HL2AHuwPcZ7R+18JoQGNsZdnSc0BAx0dN2jVgMPyPNhi55r
	pWZ8kNomanMOOJMjSqFNMQKrxpKRUxZ/nL4bzdwDDA5hQ30xmIkYS2BsNw6c51ozcN9pX36sr4u
	W0SPS4AE+zD0Dp+kqMqDQIfUHHAYdQumBxU3Ly3lHeKKwo7X4BzB00pWmyouuZiKEWR80nwE+sO
	7DCCgOxq1mJKYGpcXt76/eK6tOMQthBTIU/naJ1a5PSC09g7uYbFU6U3FCM7sfr4tNIw/IoiQZ6
	yQlRJIjoqnFCceDGSri7J+i7x1mA0MHyimccKl7bbPBEv81D+TMjWA9kp9kwFWaeyRNpCstRiI3
	9Ari0gEf8/K0BuS1Q6aNomRKXsj5H3iP8Hu+uDOsZ6maAacJZnm9VjdRHaig6nvFebK3QGOpsVJ
	6zgXP7j2W4smGNugRgt72ytTkpOLiePIy69GSdwpJ1Sl1bzpwnIfv3UlOBixM674Q+4fLnTNdWD
	MPkhM4uxclcLMsXOrtSaqqlFh08fZFxz1ckuZTAc5F0yaE7ieM2q/VO
X-Received: by 2002:a05:620a:a2c1:20b0:93b:e9d2:5ece with SMTP id af79cd13be357-93be9d25ee8mr69803785a.39.1789743000697;
        Fri, 18 Sep 2026 07:50:00 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e95a4asm151763985a.18.2026.09.18.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:28 +0000
Subject: [PATCH RFC v4 09/13] bpf, arm64: Take a Tasks Trace reader in the
 trampoline around its call-outs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-9-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=7138;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yHC4KMZfT4OhoIiDiBb7tvVf2glio0Mt2yiw+oyROR0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMextWmuyzGMJVeNI8yxyv6Z0gZzWAgn/7KthFAEN2WlTA4mSkVfiREApm3yp97Xx2XO4eWHESm
 TkxgsjmQ6cwg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Same scheme as x86: have the arm64 BPF JIT open-code rcu_read_lock_trace()
and rcu_read_unlock_trace() in the trampoline, one reader from after the
callee-saved registers are stored to just before the original function
is called (covering __bpf_tramp_enter() and the fentry/fmod_ret programs)
and a second from just after it returns to just before those registers
are restored (covering the fexit programs and __bpf_tramp_exit()), with
the original function itself outside both and pinned by im->pcref.  The
second reader is entered before ip_after_call and the fmod_ret cbnz
lands past it still holding the first, so exactly one is held on every
path; trampolines without an original call get a single reader.

The sequence mirrors entry-ftrace.S: current via sp_el0,
trc_reader_nesting bumped, and for the outermost reader the SRCU-fast
per-CPU counter incremented LL/SC and the counter pointer stashed in
trc_reader_scp (plus the dmb when CONFIG_TASKS_TRACE_RCU_NO_MB is not
set).  x10-x15 are scratch at every emission point.  Nothing is emitted
on other configurations.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/arm64/net/bpf_jit_comp.c | 90 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c18e005a41db..87f9d53caf2c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -14,6 +14,7 @@
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/slab.h>
 
 #include <asm/asm-extable.h>
@@ -2591,6 +2592,74 @@ static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, bool nullab
 	emit(A64_SUB(0, dst, src, base_lo), ctx);
 }
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() for the
+ * trampoline, see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the equivalent macros
+ * in arch/arm64/kernel/entry-ftrace.S.  The SRCU-fast per-CPU increment is an
+ * LL/SC add on this CPU's counter; being migrated between reading the per-CPU
+ * offset and the store-exclusive only means another CPU's counter is
+ * incremented atomically instead, which SRCU sums over anyway.  Uses x10-x15,
+ * which are scratch at every emission point, and the flags.
+ */
+static void emit_trace_rcu_reader(struct jit_ctx *ctx, bool lock)
+{
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+	const int nesting = offsetof(struct task_struct, trc_reader_nesting);
+	const int scp = offsetof(struct task_struct, trc_reader_scp);
+	const bool mb = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB);
+	const u8 tsk = A64_R(10), n = A64_R(11), tmp = A64_R(12);
+	const u8 ctr = A64_R(13), addr = A64_R(14), val = A64_R(15);
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE));
+	/* LDR/STR (immediate, unsigned offset) ranges */
+	BUILD_BUG_ON((nesting & 3) || nesting >= SZ_16K || (scp & 7) || scp >= SZ_32K);
+
+	emit(A64_MRS_SP_EL0(tsk), ctx);			/* current */
+	emit(A64_LDR32I(n, tsk, nesting), ctx);
+	if (lock) {
+		emit(A64_ADD_I(0, tmp, n, 1), ctx);
+		emit(A64_STR32I(tmp, tsk, nesting), ctx);
+		/* interrupted a reader: done */
+		emit(A64_CBNZ(0, n, 12 + mb), ctx);
+		/* scp = rcu_tasks_trace_srcu_struct.srcu_ctrp; current->trc_reader_scp = scp */
+		emit_addr_mov_i64(ctr, (u64)&rcu_tasks_trace_srcu_struct.srcu_ctrp, ctx);
+		emit(A64_LDR64I(ctr, ctr, 0), ctx);
+		emit(A64_STR64I(ctr, tsk, scp), ctx);
+	} else {
+		emit(A64_SUB_I(0, n, n, 1), ctx);
+		/* still nested: just store the count */
+		emit(A64_CBNZ(0, n, 11 + mb), ctx);
+		/* outermost: pick up scp before an interrupt can see nesting == 0 */
+		emit(A64_LDR64I(ctr, tsk, scp), ctx);
+		emit(A64_STR32I(A64_ZR, tsk, nesting), ctx);
+		if (mb)
+			emit(A64_DMB_ISH, ctx);
+	}
+	/* this_cpu_inc(scp->srcu_locks / srcu_unlocks) */
+	if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		emit(A64_MRS_TPIDR_EL2(addr), ctx);
+	else
+		emit(A64_MRS_TPIDR_EL1(addr), ctx);
+	emit(A64_ADD(1, addr, addr, ctr), ctx);
+	if (!lock)
+		emit(A64_ADD_I(1, addr, addr, offsetof(struct srcu_ctr, srcu_unlocks)), ctx);
+	emit(A64_LDXR(1, val, addr), ctx);
+	emit(A64_ADD_I(1, val, val, 1), ctx);
+	emit(A64_STXR(1, val, addr, tmp), ctx);
+	emit(A64_CBNZ(0, tmp, -3), ctx);
+	if (lock) {
+		if (mb)
+			emit(A64_DMB_ISH, ctx);
+		/* 1: */
+	} else {
+		emit(A64_B(2), ctx);
+		/* 2: */
+		emit(A64_STR32I(n, tsk, nesting), ctx);
+		/* 3: */
+	}
+#endif
+}
+
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		      const struct btf_func_model *m, const struct arg_aux *a,
 		      bool for_call_origin, bool is_struct_ops, u64 arena_base)
@@ -2854,6 +2923,16 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
+	/*
+	 * Tasks RCU keeps this image alive only while we are a Tasks Trace
+	 * reader; the instructions before this point (and after the final
+	 * unlock) are covered by the irq-exit IP check.  One reader spans
+	 * __bpf_tramp_enter() and the fentry/fmod_ret progs, a second one the
+	 * fexit progs and __bpf_tramp_exit(); the original function runs
+	 * outside both, with the image pinned by im->pcref instead.
+	 */
+	emit_trace_rcu_reader(ctx, true);
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* for the first pass, assume the worst case */
 		if (!ctx->image)
@@ -2898,12 +2977,20 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* the original func takes kernel addresses, never converted ones */
 		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops, 0);
+		emit_trace_rcu_reader(ctx, false);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
 		emit(A64_RET(A64_R(10)), ctx);
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
+		/*
+		 * Second reader.  Taken before ip_after_call so that the branch
+		 * to the epilogue patched in at teardown is inside it too; the
+		 * fmod_ret early exit lands past this still holding the first
+		 * reader, so either way exactly one is held.
+		 */
+		emit_trace_rcu_reader(ctx, true);
 		/* reserve a nop for bpf_tramp_image_put */
 		im->ip_after_call = ctx->ro_image + ctx->idx;
 		emit(A64_NOP, ctx);
@@ -2945,6 +3032,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(ctx, bargs_off, a->regs_for_args);
 
+	/* Remaining instructions are covered by the irq-exit IP check. */
+	emit_trace_rcu_reader(ctx, false);
+
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
 	emit(A64_LDR64I(A64_R(20), A64_SP, regs_off + 8), ctx);

-- 
2.55.0

