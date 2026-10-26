Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986810;
	b=ytf/WAl/k0fZiK5gboDVDfX0xOh9dqY6srjaeckYSXQCGRFHwOt8kUkAZlAdA2d51cvm
	 EcSk2ckVxkV2ZoqORADUPHpaucaihjNBLU8mfIhu1P+8WxalisFZAmHNgeQM0vSGZlroy
	 XNgY+/oMsOWnfoRG7yMIfG/6jfDUViTOMRsuSMexC/d8G9GkBviVkmJnLKWQXVQqewdDd
	 S6dTbBAhNMogbSeixIs/cccFtZJCYsLIyJnZ1L8o2ia9hBPN1gNRsBTEy7Aw8r43N7KUD
	 oFnH+Q8CsIL9vrc9mfRRh9/wdx9aUhXKZZkY6T37YADaT+qjJtiQX7UtJnxNNvzM5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986810;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=RM3U1JPVNWZzFcO52r5gXadmTf1gzKE2ThX/sVAvO10=;
	b=1NgNdB1hsPpXTMMfibBRQFlp+lzDAQWqLRxvE1iwHSrKn6GXkpr4I2GGkBqpYFuav0bt
	 Z4yfBPqUzsgKL72MfNiTJ2ag6+27mjh8iZyntM3kH9AnoKMPWqi8RAd8mXbAdzflTQLKl
	 tuFg9LzyaDPCiOmlEX5LnvzzKkVIZCx0Gy03iTxPKe+8jj5mt/ghs7aD2JvFlMyH8xQFT
	 rpLm0HsYKHZcCT4Da/oLy2/f5Ak9YoT0FelXA6DQRGZ9XiMTluCGMKj+GDbCBtQ2Mj2ex
	 6qe5Fkvnzd12um6nsFQsonGNqRhRKXbFrlG+nYOHNc5Wf+1YtO4p95Giwn1bPuhZKuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNkC36va;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078CF606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QNkC36va
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF7F1F01825;
	Mon, 26 Oct 2026 03:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986809;
	bh=RM3U1JPVNWZzFcO52r5gXadmTf1gzKE2ThX/sVAvO10=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QNkC36vay4I+9A/9pJeReAqJH9Ivk3DR+3skf9aYpNDf5XigJ8gMBPeNZX/rTu1FI
	 mwFQ08Aa25Jvum60eBQD3GHtqsPdc88n3937179wEVTjLeG4LQyb477XRGuFLxVR8G
	 mepnXxx5RBbesZWjJK+6gezlBx4arpg3LXshyi3SgUeCu3DcEcCRTVQj9qqIwkUA2v
	 uAqqVOLqISvwCrm6UmF4m4IvESsDlARA7eRhg1T9H/+cC3NohurLhJ9Yl1pIVrHvSu
	 O7MCs3/2x3KCK74kOOL5Z/LJ8NuV8afGce5WS+FDdY1lEiARGv4zpvowNFVLFigFEa
	 oIBT5Fek25xNA==
Content-Type: multipart/mixed; boundary="===============3389731255897803126=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e7da490fc544f07c593dc12149ae5df9f27a71c8f8af592e470bd822d14a57d6@mail.kernel.org>
In-Reply-To: <20261026025943.404450-51-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-51-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 50/81] bpf: Add may_goto to the loops that the verifier marks
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:29 +0000 (UTC)

--===============3389731255897803126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add may_goto to the loops that the verifier marks

TL;DR:
- append_budget_exit() swap() may clear indirect_target on a gotox target,
  possibly causing a missing-ENDBR/BTI fault
- Loop guards inserted for offloaded (nfp) programs never reach the NIC, so
  unbounded loops may run unguarded

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 6a591c954c31..937274c164e8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -393,6 +393,222 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)

[ ... ]

> +static int append_budget_exit(struct bpf_verifier_env *env, int s)
> +{
> +	struct bpf_subprog_info *sub = &env->subprog_info[s];
> +	int last = (sub + 1)->start - 1, n = 0, i;
> +	struct bpf_prog *new_prog;
> +	struct bpf_insn buf[4];
> +
> +	for (i = max_t(int, sub->start, last + 1 - BPF_GUARD_NEAR); i <= last; i++)
> +		if (guard_leaves_subprog(&env->insn_aux_data[i]))
> +			break;
> +	if (i > last)
> +		return 0;
> +
> +	buf[n++] = env->prog->insnsi[last];
> +	buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	if (bpf_ret_reg_pair(env, s))
> +		buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
> +	buf[n++] = budget_exit_insn(env, sub);
> +	new_prog = bpf_patch_insn_data(env, last, buf, n);
> +	if (!new_prog)
> +		return -ENOMEM;
> +	env->prog = new_prog;
> +	/* the original insn is the first one of the patch, not the last one */
> +	swap(env->insn_aux_data[last], env->insn_aux_data[last + n - 1]);
> +	for (i = last + 1; i < last + n; i++)
> +		env->insn_aux_data[i].seen = 1;
> +	return n - 1;
> +}

Can this swap() move indirect_target off the original last insn of the
subprog and onto the appended exit?

bpf_patch_insn_data() uses BPF_PATCH_KEEP_TARGET, and adjust_insn_aux_data()
has already put the original aux into the last slot of the patch.  It also
already relocates the flag that belongs to the first slot:

	if (mode == BPF_PATCH_KEEP_TARGET && data[off + cnt - 1].indirect_target) {
		data[off].indirect_target = 1;
		data[off + cnt - 1].indirect_target = 0;
	}

non_stack_access is moved the same way, through the memcmp() against
original_insn.

So before the swap(), insn_aux_data[last] is the new entry with
indirect_target = 1, and insn_aux_data[last + n - 1] is the original aux
with indirect_target = 0.  The swap() exchanges them as whole structs, so
the original insn at 'last' ends up with indirect_target cleared, and the
appended 'exit' or 'unwind_exit' ends up with it set.

A gotox jump table entry that pointed at 'last' still points there, because
adjust_insn_arrays() is called with first = off + 1.  Nothing marks indirect
targets again after the main pass, since mark_indirect_target() is only
called from check_indirect_jump().  The JITs emit ENDBR (x86) or BTI J
(arm64) only where bpf_insn_is_indirect_target() is true, and gotox is
emitted as a plain indirect jump.

This looks reachable once check_loop_guard() starts setting loop_guard:

- A subprog, for example the main prog, has a loop that is not counted.
- The guard leaves the subprog (loop_guard && !guard_no_unwind) and is
  within BPF_GUARD_NEAR insns of the end, so append_budget_exit() appends
  'r0 = 0; exit'.
- The last insn of the subprog (exit, ja or gotol, see check_subprogs()) is
  one of the targets of a gotox jump table, for example a switch case that
  returns with r0 already set and jumps straight to the final exit.

When gotox takes that entry on a CPU with kernel IBT, the jump lands on an
insn without ENDBR, which would be a #CP fault ("Missing ENDBR" and BUG() in
do_kernel_cp_fault()).  With arm64 BTI it would be a BTI exception in the
kernel.  I did not see a later patch in the series that changes
append_budget_exit() or adjust_insn_aux_data().

Should indirect_target (and non_stack_access) stay on 'last' after the swap,
for example by swapping them back, or by copying them from
data[last + n - 1] and clearing them there?  Alternatively, only the fields
that adjust_insn_aux_data() did not already relocate could be moved.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 32b256bc1513..c3fac4586c92 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24393,6 +24393,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret == 0 && env->callx_edges)
>  		ret = sort_subprogs_topo(env);
>
> +	if (ret == 0)
> +		ret = bpf_insert_loop_guards(env);
> +
>  	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
>  		ret = bpf_prog_offload_finalize(env);
>

Is it ok to run bpf_insert_loop_guards() for offloaded programs, and before
bpf_prog_offload_finalize()?

For an offloaded (nfp) program, nfp_bpf_verifier_prep() calls
nfp_prog_prepare(nfp_prog, prog->insnsi, prog->len) before the main pass.
That copies every insn into the device's own meta list with meta->n set to
the original index.  nfp_bpf_translate() -> nfp_bpf_jit() then compiles only
from that meta list, so insns added later to env->prog->insnsi never reach
the NIC.  instr_cb[] in nfp/bpf/jit.c has no entry for BPF_JMP | BPF_JCOND,
so the nfp_verify_insn() opcode check that would reject may_goto never runs
on the added insns.

nfp_bpf_finalize() ends with nfp_bpf_insn_flag_zext(nfp_prog,
env->insn_aux_data), which tests aux[meta->n].zext_dst.
bpf_insert_loop_guards() calls bpf_patch_insn_data(), and
append_budget_exit() adds 'r0 = 0; exit' at the end of subprogs.  Both move
insn_aux_data, so meta->n no longer indexes the right entry for any insn
after the first insertion.

check_loop_guard(), added by 0535bc235aed ("bpf: Verify programs as a
fixpoint over the control flow graph"), sets aux->loop_guard and has no
bpf_prog_is_offloaded() check.  The series does consider offload when it
computes bail_unwinds:

    si[s].bail_unwinds = si[s].can_unwind ||
                         (s && ... && bpf_jit_supports_unwind() &&
                          !bpf_prog_is_offloaded(env->prog->aux));

so an offloaded program is expected to get the 'r0 = 0; exit' form of the
guard.  bpf_check() at the series tip (51224d16c11b) still calls
bpf_insert_loop_guards() right before bpf_prog_offload_finalize().

Once 0535bc235aed is applied, an offloaded XDP/TC program (nfp supports
backward jumps since 854dc87d1a7b "nfp: bpf: support backward jump") with a
loop that the verifier cannot count was rejected before the series.  Now it
looks like it is accepted because the verifier relies on the added may_goto
to stop the loop at run time.  On the NIC it runs with no guard, so a loop
that never ends there could stall the device datapath.  That conflicts with
the commit message premise that "the kernel must stop such a loop at run
time".  Independently, the zext flags that the NIC JIT uses would come from
the wrong insns.

The comment further down in bpf_check(), "instruction rewrites happen after
this point", also no longer holds, since it marks the point up to which
insn indices match the loaded program.

At this commit the call is a no-op because nothing sets loop_guard yet.  It
becomes reachable with d42f1667f490 / 0535bc235aed, and I did not see a
later commit in the series that addresses it.

Should a loop that needs a guard be rejected when bpf_prog_is_offloaded()
(for example in check_loop_guard(), or by failing in
bpf_insert_loop_guards())?  Or at least, should the insertion move after
bpf_prog_offload_finalize() so that the aux indices nfp reads stay valid?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============3389731255897803126==--
