Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572426;
	b=jDCSXnbeuqa7TILhnHQYTBaorGYa9ITXAI4E6VEz5JE5Zfw7wIH2xKILVzvEr7rBP9bY
	 6sqtiCxndWByPyB25OuIe7qKJxndPPlC/ekFltK+FngiVFDw7Yg56tFxjKd8cPIuF9RuJ
	 Snq5YiltDbwEBzLs5FqETcdgd49oD+Y4FdJwfvKqY03pnjNbVNQ5HCpYcHyzTSdt9JrK7
	 mZUchCR4vcgEg1/xwyp9T3DKavDT15qzQoDxCzD4+nDVA6lrrLehr2wchFPlIRMU/BNHk
	 PAzs++Mo24t7d3lbb7tyt04o8JYEDthDvsNUn7pQSpHziM8F93ixU9hl61302zjWbKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572426;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vAqWv8bsyi5TpmBulDBXfTj2PEkk5Y5ETscVn3jW4/w=;
	b=Qqn1MSLI4atrGHxRwHl2hUpI1MF0G3+YbtdeWCV4XAP+JSKFu48acy2004v+CfFOeBA8
	 MiP72ztgzOu6KV5XaRbikTabwbJXO+SeYbGxrDi3tZIymlATFYJ5iFgEXp3LSX9g2oMJp
	 gSRSqa41T5OrBxEmu06qi3JVi0+CFQt9TqCkRkvRD/YD7GNMKseqKdozi0usBG/mnGKxl
	 cBU7TcGXnVabssp0NQME3NtwqC5/mnam7C0r3TkV0maClPfapfipZdqehgGZnQBRHjwzn
	 6DUe2hR2uqMcFk3rv8pw+BWyJPKsNz1F9A9Oandc8kUDrSspoRHmij5LdgACy7oXzQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q0YOuSN9;
	arc=none smtp.remote-ip=91.218.175.89
Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD5606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63DD5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q0YOuSN9
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Uu+MF4k/XPRdgtrg1+8GpdGclTwHLQi1ao8WZ2m/lkI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795572422; v=1; x=1796177222;
 b=Q0YOuSN9Gm459VIL5wjmhH/aBSsjEMpBtILBoVwJLT9I0/ENkT1dhkGtnpp/59R04Kjf1EDW
 vSFMAfHoraQitZ7mgKDV+jMV0qWWxNSlINgtDen/fZA5i2+QfcW05RZoHd+n5Mex3uuNgn7U8Dl
 yhylTNZ217p6AoUNgshke+1Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f11d5d7012f9701;
	Wed, 25 Nov 2026 02:07:01 +0000
X-Mizu-Trace-ID: 2f11d5d7012f9701
X-Migadu-Flow: FLOW_OUT
Message-ID: <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
Date: Tue, 24 Nov 2026 18:06:55 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: mikeba@sentinelone.com, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Martin Kelly <martin.kelly@crowdstrike.com>,
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 tyler.wilson@crowdstrike.com
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 3:29 AM, Mike Bazov via B4 Relay wrote:
> fentry, fexit, raw_tp and syscall tracepoint programs can be preempted
> while they run, but their recursion check is a per-CPU counter:
> 
>   task A enters prog on CPU 0       prog->active = 1
>   task A is preempted inside prog
>   task B enters prog on CPU 0       dropped, counted as recursion miss
> 
> Nothing recursed, but B's event is lost. Since 7.0, x86 and arm64 have
> only lazy and full preemption, so this happens on stock kernels. Our
> fentry/fexit probe on inet_sendmsg() and inet_recvmsg() loses 9,254 of
> 8 million runs under HTTP load on a 4-CPU VM. With the series it loses
> none.
> 
> The series checks recursion per task instead: a program is recursing
> only if the current task is already inside it.
> 
> v2 did that for every program, which breaks a program that uses a
> per-CPU map as scratch space: the second task overwrites its buffer,
> and nothing counts that. So in v3 the verifier marks the programs that
> keep per-CPU state, and those keep the per-CPU counter and behave
> exactly as today:
> 
>   - per-CPU maps, bpf_this_cpu_ptr(), bpf_per_cpu_ptr()
>   - tail calls: the target has no recursion check of its own
>   - timed may_goto: its budget is per CPU
>   - a private stack
> 
> Trade-offs:
> 
> - Marked programs are not fixed. A program with a per-CPU map or a
>   tail call loses runs to preemption as it does today.
> - The verifier can't see everything. A program that keeps per-CPU
>   slots of its own, like array[bpf_get_smp_processor_id()], is not
>   marked. Today the counter keeps its runs apart. With the series two
>   runs can write one slot, and nothing counts that.
> - raw_tp is about 2% slower in bench, see the table below. fentry and
>   fexit are within noise.
> - Tracing, raw_tp and tracepoint programs lose the private stack
>   (patch 1). It is already unsafe for them: two raw_tp programs that
>   tail-call one handler let two tasks share its stack today. A program
>   with two 2000-byte frames no longer loads.
I see how removing private stacks would avoid the corner case issues 
mentioned. In the common case though, programs with a combined stack 
size above the limit will start being rejected after this change (as
you noted). But for programs that still load, they'll lose the safety
of the  overflow/underflow checks private stacks include.

I explored an idea for making private stacks concurrency-safe regardless
of entry path or recursion model. The concept is changing from per-prog
per-cpu private stacks to a per-prog per-cpu pool of private stacks. The
pool consists of a fixed number of slots. A free slot is acquired at
invocation time and released on exit. This allows concurrent tasks on
the same CPU to each get their own private stack. So it would fix the
existing corruption and eliminate the need for marking private stacks.
Private stacks could then be used with the new per-task per-prog
recursion guard. The pool size is limited so exhaustions are counted.

The patch below is a proof of concept scoped only to x86_64 trampolines.
It was validated with the bpftrace prog that precedes the patch, along
with jited assembly dump to inspect the new private frame API calls.
Overhead measured was roughly 60ns, but this was just a first take and I
believe it can be optimized especially in the JIT area. If it makes
sense, this could be integrated into the series or sent as a follow-up.

kfunc:vmlinux:__x64_sys_getpgid
/comm == "bpf-test-main" || comm == "bpf-test-waker"/
{
    @entered = count();
    @entered_tid[tid] = count();

    if (comm == "bpf-test-main") {
        @main_active[cpu] = 1;
    } else if (@main_active[cpu])
        @overlap_entries = count();
    }

    $i = 0;
    $last = nsecs;
    // bounded work to increase preemption window
    while ($i < 10000) {
        $last = nsecs;
        $i++;
    }

    if (comm == "bpf-test-main") {
        @main_active[cpu] = 0;
    }

    @last_ts[tid] = $last;
    @completed_tid[tid] = count();
}

-- 8< --
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Date: Fri, 20 Nov 2026 21:23:55 -0800
Subject: [PATCH bpf-next] bpf, x86: concurrency-safe private stacks

Private stacks currently exist on a per-prog per-cpu basis. Since the
proposed recursion guard allows different progs to run concurrently
(in the scheduler sense) on the same CPU, corruption would occur on
the private stacks.

This patch is an idea for concurrency-safe private stacks. Achieve
this safety by changing to a new paradigm. Instead of a per-prog
per-cpu basis, use a new per-prog per-cpu pool of stacks. Programs
acquire an available "slot" on invocation. The slot serves as an index
into the pool of private stacks. This gives the program the ability
to use separate private stacks per-invocation up to a fixed limit.
When available slots are exhausted, a counter is incremented and the
program is skipped. Note this is not the same counter as the existing
recursion_misses.

Signed-off-by: JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c  | 136 +++++++------------
 include/linux/bpf.h          |  37 +++++-
 include/linux/bpf_verifier.h |   4 +
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/core.c            |   1 +
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/priv_stack.c      | 247 +++++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c      |   4 +
 kernel/bpf/verifier.c        |  15 +++
 9 files changed, 352 insertions(+), 95 deletions(-)
 create mode 100644 kernel/bpf/priv_stack.c

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 458ddcf87c48..f63150a69e9f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2039,22 +2039,39 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 	*pprog = prog;
 }
 
-static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
+static int emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog, u8 *ip)
 {
-	u8 *prog = *pprog;
-
-	/* movabs r9, priv_frame_ptr */
-	emit_mov_imm64(&prog, X86_REG_R9, (__force long) priv_frame_ptr >> 32,
-		       (u32) (__force long) priv_frame_ptr);
+#ifdef CONFIG_BPF_SYSCALL
+	u8 *prog = *pprog, *start = prog;
+	u64 prog_addr = (u64)bpf_prog;
 
-#ifdef CONFIG_SMP
-	/* add <r9>, gs:[<off>] */
-	EMIT2(0x65, 0x4c);
-	EMIT3(0x03, 0x0c, 0x25);
-	EMIT((u32)(unsigned long)&this_cpu_off, 4);
-#endif
+	/* Save the return value and arguments 1-5 */
+	EMIT1(0x50);		/* push rax */
+	EMIT1(0x57);		/* push rdi */
+	EMIT1(0x56);		/* push rsi */
+	EMIT1(0x52);		/* push rdx */
+	EMIT1(0x51);		/* push rcx */
+	EMIT2(0x41, 0x50);	/* push r8 */
 
+	/*
+	 * Pass this function's prog pointer to bpf_priv_stack_frame() in
+	 * order to obtain the private frame pointer. Store it in R9.
+	 */
+	emit_mov_imm64(&prog, BPF_REG_1, prog_addr >> 32, prog_addr);
+	if (emit_rsb_call(&prog, bpf_priv_stack_frame, ip + (prog - start)))
+		return -EINVAL;
+	emit_mov_reg(&prog, true, X86_REG_R9, BPF_REG_0);
+
+	/* Restore the registers */
+	EMIT2(0x41, 0x58);	/* pop r8 */
+	EMIT1(0x59);		/* pop rcx */
+	EMIT1(0x5a);		/* pop rdx */
+	EMIT1(0x5e);		/* pop rsi */
+	EMIT1(0x5f);		/* pop rdi */
+	EMIT1(0x58);		/* pop rax */
 	*pprog = prog;
+#endif
+	return 0;
 }
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
@@ -2076,10 +2093,6 @@ static int jmp_distance(const int *addrs, int i, int off, int moved)
 #define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
-/* Memory size/value to protect private stack overflow/underflow */
-#define PRIV_STACK_GUARD_SZ    8
-#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
-
 static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 				    struct bpf_prog *bpf_prog)
 {
@@ -2391,10 +2404,9 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	int insn_cnt = bpf_prog->len;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
-	void __percpu *priv_frame_ptr = NULL;
+	bool use_priv_stack = bpf_prog->aux->priv_stack_offset;
 	u16 out_stack_arg_cnt, outgoing_rsp;
 	u64 arena_vm_start = 0, user_vm_start = 0;
-	void __percpu *priv_stack_ptr;
 	int i, excnt = 0;
 	int ilen, moved, proglen = 0;
 	u8 *ip, *prog = temp;
@@ -2410,11 +2422,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 	stack_depth = bpf_prog->aux->stack_depth;
 	out_stack_arg_cnt = bpf_out_stack_arg_cnt(env, bpf_prog);
-	priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
-	if (priv_stack_ptr) {
-		priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
+	if (use_priv_stack)
 		stack_depth = 0;
-	}
 
 	/*
 	 * Follow x86-64 calling convention for both BPF-to-BPF and
@@ -2525,15 +2534,18 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 */
 	if (bpf_prog->aux->exception_boundary)
 		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp +
-						     (priv_frame_ptr || arena_sp_save ? 8 : 0);
+						     (use_priv_stack || arena_sp_save ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
 
-	if (priv_frame_ptr)
-		emit_priv_frame_ptr(&prog, priv_frame_ptr);
+	if (use_priv_stack) {
+		err = emit_priv_frame_ptr(&prog, bpf_prog, image + (prog - temp));
+		if (err)
+			return err;
+	}
 
 	ilen = prog - temp;
 	if (rw_image)
@@ -2559,7 +2571,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		u32 jmp_op = BPF_OP(insn->code);
 		s32 cmp_imm;
 
-		if (priv_frame_ptr) {
+		if (use_priv_stack) {
 			if (src_reg == BPF_REG_FP)
 				src_reg = X86_REG_R9;
 
@@ -3384,14 +3396,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 					ip += prog - start;
 				}
 			}
-			if (priv_frame_ptr) {
+			if (use_priv_stack) {
 				push_r9(&prog);
 				ip += 2;
 			}
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
-			if (priv_frame_ptr)
+			if (use_priv_stack)
 				pop_r9(&prog);
 			if (arena_sp_args)
 				emit_sub_rsp(&prog, 8);
@@ -3416,19 +3428,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			 * of a subprog there is no need to pass
 			 * tail_call_cnt_ptr in rax.
 			 */
-			if (priv_frame_ptr) {
+			if (use_priv_stack) {
 				push_r9(&prog);
 				ip += 2;
 			}
 			if (emit_indirect_call(&prog, insn->dst_reg, ip))
 				return -EINVAL;
-			if (priv_frame_ptr)
+			if (use_priv_stack)
 				pop_r9(&prog);
 			break;
 
 			/* unwind_goto. The verifier expanded may_goto. */
 		case BPF_JMP | BPF_JCOND:
-			if (!priv_frame_ptr) {
+			if (!use_priv_stack) {
 				err = add_unwind_exentry(bpf_prog, image, rw_image, &excnt,
 							 addrs[i - 1], addrs[i + insn->off]);
 				if (err)
@@ -4737,35 +4749,6 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
 }
 
-static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
-{
-	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
-	u64 *stack_ptr;
-
-	for_each_possible_cpu(cpu) {
-		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
-		stack_ptr[0] = PRIV_STACK_GUARD_VAL;
-		stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;
-	}
-}
-
-static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
-				   struct bpf_prog *prog)
-{
-	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
-	u64 *stack_ptr;
-
-	for_each_possible_cpu(cpu) {
-		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
-		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
-		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL) {
-			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
-			       bpf_jit_get_prog_name(prog));
-			break;
-		}
-	}
-}
-
 struct x64_jit_data {
 	struct bpf_binary_header *rw_header;
 	struct bpf_binary_header *header;
@@ -4782,9 +4765,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 {
 	struct bpf_binary_header *rw_header = NULL;
 	struct bpf_binary_header *header = NULL;
-	void __percpu *priv_stack_ptr = NULL;
 	struct x64_jit_data *jit_data;
-	int priv_stack_alloc_sz;
 	int proglen, oldproglen = 0;
 	struct jit_context ctx = {};
 	bool extra_pass = false;
@@ -4805,21 +4786,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			return prog;
 		prog->aux->jit_data = jit_data;
 	}
-	priv_stack_ptr = prog->aux->priv_stack_ptr;
-	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
-		/* Allocate actual private stack size with verifier-calculated
-		 * stack size plus two memory guards to protect overflow and
-		 * underflow.
-		 */
-		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 8) +
-				      2 * PRIV_STACK_GUARD_SZ;
-		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERNEL);
-		if (!priv_stack_ptr)
-			goto out_priv_stack;
-
-		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
-		prog->aux->priv_stack_ptr = priv_stack_ptr;
-	}
 	addrs = jit_data->addrs;
 	if (addrs) {
 		ctx = jit_data->ctx;
@@ -4979,11 +4945,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
 out_addrs:
 		kvfree(addrs);
-		if (!image && priv_stack_ptr) {
-			free_percpu(priv_stack_ptr);
-			prog->aux->priv_stack_ptr = NULL;
-		}
-out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
@@ -5071,8 +5032,6 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct x64_jit_data *jit_data = prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
-		void __percpu *priv_stack_ptr;
-		int priv_stack_alloc_sz;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs),
@@ -5088,13 +5047,6 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
-		priv_stack_ptr = prog->aux->priv_stack_ptr;
-		if (priv_stack_ptr) {
-			priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 8) +
-					      2 * PRIV_STACK_GUARD_SZ;
-			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_sz, prog);
-			free_percpu(prog->aux->priv_stack_ptr);
-		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
 
@@ -5112,7 +5064,7 @@ bool bpf_jit_supports_exceptions(void)
 
 bool bpf_jit_supports_private_stack(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_BPF_SYSCALL);
 }
 
 bool bpf_jit_supports_arena_stack(void)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b7fe3629e073..04d99d96e46a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -44,6 +44,7 @@ struct bpf_verifier_log;
 struct perf_event;
 struct bpf_prog;
 struct bpf_prog_aux;
+struct bpf_priv_stack_pool;
 struct bpf_map;
 struct bpf_arena;
 struct sock;
@@ -1914,6 +1915,9 @@ struct bpf_prog_aux {
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
+	/* main_prog_aux owns the pool. subprogs must use main_prog_aux->priv_stack_pool. */
+	struct bpf_priv_stack_pool *priv_stack_pool;
+	u32 priv_stack_offset;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
 	struct bpf_trampoline *dst_trampoline;
@@ -2778,11 +2782,37 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog_array **new_array);
 struct bpf_prog *bpf_prog_dummy(void);
 
+struct bpf_priv_stack_reservation {
+	void *slot_base;
+	struct bpf_priv_stack_pool *pool;
+	unsigned long *busy;
+	unsigned int slot;
+};
+
 struct bpf_run_ctx {
 	struct bpf_run_ctx *outer_run_ctx; /* non-null when nested */
 	struct bpf_prog *prog;
+	struct bpf_priv_stack_reservation priv_stack;
 };
 
+#ifdef CONFIG_BPF_SYSCALL
+void bpf_priv_stack_free(struct bpf_prog_aux *aux);
+void *bpf_priv_stack_frame(struct bpf_prog *prog);
+bool bpf_priv_stack_acquire(struct bpf_prog *prog,
+			struct bpf_priv_stack_reservation *res);
+void bpf_priv_stack_release(struct bpf_priv_stack_reservation *res);
+#else
+static inline bool bpf_priv_stack_acquire(struct bpf_prog *prog,
+			struct bpf_priv_stack_reservation *res)
+{
+	return true;
+}
+
+static inline void bpf_priv_stack_release(struct bpf_priv_stack_reservation *res)
+{
+}
+#endif
+
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	const struct bpf_prog_array_item *prog_item;
@@ -2808,8 +2838,11 @@ static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx, s
 
 #ifdef CONFIG_BPF_SYSCALL
 	old_ctx = READ_ONCE(current->bpf_ctx);
-	new_ctx->prog = prog;
-	new_ctx->outer_run_ctx = old_ctx;
+	if (new_ctx) {
+		new_ctx->prog = prog;
+		new_ctx->outer_run_ctx = old_ctx;
+		new_ctx->priv_stack = (struct bpf_priv_stack_reservation){};
+	}
 	barrier();
 	WRITE_ONCE(current->bpf_ctx, new_ctx);
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f45c18b3cfa2..178f5dfeeaa5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1113,6 +1113,7 @@ struct bpf_subprog_info {
 	u32 exit_idx;
 	u32 callx_edge; /* 1 + the first of its env->callx_edges, 0 if none */
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
+	u32 priv_stack_offset; /* frame end within an invocation slot */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
 	u16 arena_stack_depth; /* size of the frame in the stack in arena */
@@ -1812,6 +1813,9 @@ static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 		prog->aux->saved_dst_prog_type : prog->type;
 }
 
+int bpf_priv_stack_alloc(struct bpf_prog_aux *aux, struct bpf_subprog_info *subprog_info,
+	u32 subprog_cnt);
+
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 {
 	switch (resolve_prog_type(prog)) {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index d26c62326e58..388362849e65 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o check_btf.o flow.o join.o priv_stack.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2f0c9e246876..f072a923b284 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -290,6 +290,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	if (fp->aux) {
 #ifdef CONFIG_BPF_SYSCALL
 		bpf_prog_stream_free(fp);
+		bpf_priv_stack_free(fp->aux);
 #endif
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 4d9b67981520..4f9a53b1ae1a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1765,6 +1765,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 
 		func[i]->aux->name[0] = 'F';
 		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
+		func[i]->aux->priv_stack_offset = env->subprog_info[i].priv_stack_offset;
 		if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
 			func[i]->aux->jits_use_priv_stack = true;
 
diff --git a/kernel/bpf/priv_stack.c b/kernel/bpf/priv_stack.c
new file mode 100644
index 000000000000..05a1ba9bce13
--- /dev/null
+++ b/kernel/bpf/priv_stack.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 CrowdStrike
+ *
+ * BPF concurrency-safe private stacks
+ * Guard handling adapted from arch/x86/net/bpf_jit_comp.c
+ */
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/cpu.h>
+#include <linux/overflow.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+#include <linux/vmalloc.h>
+
+#define BPF_PRIV_STACK_GUARD_VAL	0xEB9F12345678eb9fULL
+#define BPF_PRIV_STACK_GUARD_SZ	8
+#define BPF_PRIV_STACK_NR_SLOTS	4
+/* limit private stack slots to single word */
+static_assert(BPF_PRIV_STACK_NR_SLOTS > 0 && BPF_PRIV_STACK_NR_SLOTS <= BITS_PER_LONG);
+
+struct bpf_priv_stack_cpu {
+	unsigned long busy;
+	void *slots;
+};
+
+struct bpf_priv_stack_frame {
+	u32 start;
+	u32 end;
+};
+
+struct bpf_priv_stack_pool {
+	struct bpf_priv_stack_cpu __percpu *priv_stack_cpu;
+	atomic64_t exhaustions;
+	u32 slot_size;
+	u32 nr_frames;
+	struct bpf_priv_stack_frame frames[];
+};
+
+static void priv_stack_pool_free(struct bpf_priv_stack_pool *pool)
+{
+	if (pool->priv_stack_cpu) {
+		int cpu;
+
+		for_each_possible_cpu(cpu)
+			kvfree(per_cpu_ptr(pool->priv_stack_cpu, cpu)->slots);
+		free_percpu(pool->priv_stack_cpu);
+	}
+
+	kfree(pool);
+}
+
+static void __priv_stack_guards(struct bpf_priv_stack_pool *pool, bool init)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct bpf_priv_stack_cpu *priv_stack_cpu;
+
+		priv_stack_cpu = per_cpu_ptr(pool->priv_stack_cpu, cpu);
+		for (size_t slot = 0; slot < BPF_PRIV_STACK_NR_SLOTS; slot++) {
+			void *slot_base = priv_stack_cpu->slots + (pool->slot_size * slot);
+
+			for (int i = 0; i < pool->nr_frames; i++) {
+				struct bpf_priv_stack_frame *frame;
+				u64 *low, *high;
+
+				frame = &pool->frames[i];
+				if (!frame->end)
+					continue;
+
+				low = slot_base + frame->start;
+				high = slot_base + frame->end;
+
+				if (init) {
+					*low = BPF_PRIV_STACK_GUARD_VAL;
+					*high = BPF_PRIV_STACK_GUARD_VAL;
+				} else if (*low != BPF_PRIV_STACK_GUARD_VAL ||
+					   *high != BPF_PRIV_STACK_GUARD_VAL) {
+					pr_err("BPF private stack guard corrupted: cpu %d slot %zu func %d\n",
+						cpu, slot, i);
+				}
+			}
+		}
+	}
+}
+
+static void priv_stack_guards_init(struct bpf_priv_stack_pool *pool)
+{
+	__priv_stack_guards(pool, true);
+}
+
+static void priv_stack_guards_check(struct bpf_priv_stack_pool *pool)
+{
+	__priv_stack_guards(pool, false);
+}
+
+int bpf_priv_stack_alloc(struct bpf_prog_aux *aux, struct bpf_subprog_info *subprog_info,
+	u32 subprog_cnt)
+{
+	struct bpf_priv_stack_pool *pool;
+	struct bpf_priv_stack_cpu *priv_stack_cpu;
+	gfp_t gfp = bpf_memcg_flags(GFP_KERNEL);
+	u32 size = 0;
+	size_t bytes;
+	int i, cpu, ret;
+
+	/* TODO - arm64 jit private stack pool */
+	if (!IS_ENABLED(CONFIG_X86_64) || !aux->jits_use_priv_stack)
+		return 0;
+
+	pool = kzalloc_flex(*pool, frames, subprog_cnt, gfp);
+	if (!pool)
+		return -ENOMEM;
+
+	for (i = 0; i < subprog_cnt; i++) {
+		struct bpf_subprog_info *sub;
+		u32 frame_size, end;
+
+		sub = &subprog_info[i];
+		if (sub->priv_stack_mode != PRIV_STACK_ADAPTIVE)
+			continue;
+
+		frame_size = round_up((u32)sub->stack_depth, 8) + (BPF_PRIV_STACK_GUARD_SZ * 2);
+		if (check_add_overflow(size, frame_size, &end)) {
+			ret = -E2BIG;
+			goto out_free;
+		}
+
+		pool->frames[i].start = size;
+		pool->frames[i].end = end - BPF_PRIV_STACK_GUARD_SZ;
+		sub->priv_stack_offset = pool->frames[i].end;
+		size = end;
+	}
+
+	if (!size) {
+		kfree(pool);
+		return 0;
+	}
+
+	pool->nr_frames = subprog_cnt;
+	pool->slot_size = size;
+	bytes = (size_t)size * BPF_PRIV_STACK_NR_SLOTS;
+
+	pool->priv_stack_cpu = __alloc_percpu_gfp(sizeof(*priv_stack_cpu), __alignof__(*priv_stack_cpu), gfp);
+	if (!pool->priv_stack_cpu) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	/* Keep large backing arrays out of the size-limited percpu allocator. */
+	for_each_possible_cpu(cpu) {
+		priv_stack_cpu = per_cpu_ptr(pool->priv_stack_cpu, cpu);
+		priv_stack_cpu->slots = kvzalloc_node(bytes, gfp, cpu_to_node(cpu));
+		if (!priv_stack_cpu->slots) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	priv_stack_guards_init(pool);
+	aux->priv_stack_pool = pool;
+	aux->priv_stack_offset = subprog_info[0].priv_stack_offset;
+
+	return 0;
+
+out_free:
+	priv_stack_pool_free(pool);
+	return ret;
+}
+
+void bpf_priv_stack_free(struct bpf_prog_aux *aux)
+{
+	struct bpf_priv_stack_pool *pool = aux->priv_stack_pool;
+
+	if (!pool)
+		return;
+
+	priv_stack_guards_check(pool);
+	priv_stack_pool_free(pool);
+	aux->priv_stack_pool = NULL;
+}
+
+bool notrace bpf_priv_stack_acquire(struct bpf_prog *prog,
+				  struct bpf_priv_stack_reservation *res)
+{
+	struct bpf_priv_stack_cpu *priv_stack_cpu;
+	struct bpf_priv_stack_pool *pool;
+	unsigned long available;
+	unsigned int slot;
+
+	pool = prog->aux->main_prog_aux->priv_stack_pool;
+	if (!pool)
+		return true;
+
+	priv_stack_cpu = this_cpu_ptr(pool->priv_stack_cpu);
+	for (;;) {
+		available = ~READ_ONCE(priv_stack_cpu->busy) & GENMASK(BPF_PRIV_STACK_NR_SLOTS - 1, 0);
+		if (!available) {
+			atomic64_inc(&pool->exhaustions);
+			return false;
+		}
+		slot = __ffs(available);
+		if (!test_and_set_bit_lock(slot, &priv_stack_cpu->busy))
+			break;
+	}
+
+	res->slot_base = priv_stack_cpu->slots + (size_t)slot * pool->slot_size;
+	res->busy = &priv_stack_cpu->busy;
+	res->slot = slot;
+	/* Publish the pool associated with the new reservation. */
+	barrier();
+	WRITE_ONCE(res->pool, pool);
+
+	return true;
+}
+
+void notrace bpf_priv_stack_release(struct bpf_priv_stack_reservation *res)
+{
+	if (!res->pool)
+		return;
+
+	clear_bit_unlock(res->slot, res->busy);
+	res->pool = NULL;
+	res->slot_base = NULL;
+}
+
+/*
+ * Find the invocation's reserved slot and return the prog's
+ * private frame pointer.
+ */
+void *notrace bpf_priv_stack_frame(struct bpf_prog *prog)
+{
+	struct bpf_priv_stack_pool *pool = prog->aux->main_prog_aux->priv_stack_pool;
+	struct bpf_run_ctx *ctx;
+
+	/* Nested run contexts may sit above owning reservation. */
+	for (ctx = READ_ONCE(current->bpf_ctx); READ_ONCE(ctx->priv_stack.pool) != pool;
+	     ctx = ctx->outer_run_ctx)
+		;
+
+	return ctx->priv_stack.slot_base + prog->aux->priv_stack_offset;
+}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 44a73766aa98..c8e3f8ca3416 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1355,6 +1355,9 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 		}
 	}
 
+	if (!bpf_priv_stack_acquire(prog, &run_ctx->run_ctx.priv_stack))
+		return 0;
+
 	return bpf_prog_start_time();
 }
 
@@ -1393,6 +1396,7 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
+	bpf_priv_stack_release(&run_ctx->run_ctx.priv_stack);
 	rcu_read_unlock_migrate();
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39f1c6eb1131..3ec159520f33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5331,6 +5331,16 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	if (!bpf_jit_supports_private_stack())
 		return NO_PRIV_STACK;
 
+	/* TODO - arm64  and other types */
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		if (prog->sleepable || prog->type != BPF_PROG_TYPE_TRACING)
+			return NO_PRIV_STACK;
+		if (prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		    prog->expected_attach_type == BPF_TRACE_FEXIT)
+			return PRIV_STACK_ADAPTIVE;
+		return NO_PRIV_STACK;
+	}
+
 	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
 	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
 	 * explicitly.
@@ -25260,6 +25270,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 								     : false;
 	}
 
+	if (ret == 0 && !bpf_prog_is_offloaded(env->prog->aux) &&
+			env->prog->jit_requested) {
+		ret = bpf_priv_stack_alloc(env->prog->aux, env->subprog_info, env->subprog_cnt);
+	}
+
 	if (ret == 0)
 		ret = bpf_fixup_call_args(env);
 
-- 
2.56.1
