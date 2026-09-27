Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F913C141A
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541610; cv=none; b=fKCpBVWnrJ5vxtnbJVLD19ndd6JZj+Wcp44MD3ZsSEm/h2kPU0vhFDNFSALXIAdxJks0/FEHI9Y1Q6FlfXbzEw1M1vhLf9KYmMI52UtosydRa+ySagEFO3oQ81keJiC6oxluDoPFcGQ+DLuhvJPO1bTf4iTLYGqDKJ2soJZ6z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541610; c=relaxed/simple;
	bh=XCE3Jnv15krBsWeOt9PkRX0d/sjX5xq0K+QdWdDMTvo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FrelK8+CBkC3LtujtJqLqbGCiQ41xsRWx66bvbK6RqRhTyen611BrONVGJbQdQ7osjGpuFnNL3HaxCYx0hoCkutgR1lpXuQTZx/aD1bczQuy7mzqj1i9PNlHdtXY2jmQTG/8uUtsL2czCVgo/TLnwnCu9RJwVjkcI+bTHa95MZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6XMfXM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6XMfXM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A181F00893;
	Sun, 27 Sep 2026 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541608;
	bh=11Z9Vnhr/QclVZTlxlbr8w3fGMH22tueGOMJYYirHfY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I6XMfXM3tfjELzrWNAUgcB/b0u2Y60zswML58PFxaoBvgCD61VX8vmxPhqHOXWOZj
	 mmi3FvsXxHewbgxs0LSoYE6scbuoLTQ6bPEW2ayxYx0i8AiGbkTZKT3UketSSjoKm1
	 Xi8WAH++sfOzIqmzDZtuZxEk3U3zH4armSicIdVIy3cjatnWGse7cQhdEklKZcrxP5
	 XOxxRgaghgkl7seADlSxatyQYCIf73ePxM6fBwmSFNNI3+OwXdluSnM4sQ/1xFSdaL
	 XxHYv1c/cRbQdukOT9zM1pCMfNp+aFoJh+RmBDlY1cW8Guh10qoNGIwMOY3Gq7CNqB
	 zfqch4CyM3XXw==
Content-Type: multipart/mixed; boundary="===============2805186730058209274=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6309f2da57dfa21ed271e0a94244f3ff4432b06a3a3cbdfbf45ce85a6b565b9d@mail.kernel.org>
In-Reply-To: <20260926050107.2218786-1-yonghong.song@linux.dev>
References: <20260926050107.2218786-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 12/21] bpf, arm64: Dispatch exception cleanup pads at run time
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:40:08 +0000 (UTC)

--===============2805186730058209274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 3ebcf8c53fb0..c750c520f24d 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c

[ ... ]

> +static bool bpf_unwind_store_ra(unsigned long record, unsigned long caller_fp,
> +				u64 pc, u64 ra)
> +{
> +	struct frame_record *rec = (struct frame_record *)record;
> +	u64 stored = READ_ONCE(rec->lr);
> +
> +	if (system_supports_address_auth() && stored != pc) {
> +		u64 modifier;
> +
> +		if (WARN_ON_ONCE(!bpf_unwind_ra_modifier(record, caller_fp,
> +							 stored, pc, &modifier)))
> +			return false;
> +		ra = bpf_unwind_sign_ra(ra, modifier);
> +	}
> +	WRITE_ONCE(rec->lr, ra);
> +	return true;
> +}

Does this redirect work under CONFIG_SHADOW_CALL_STACK?

When shadow call stack is enabled, a C function epilogue reloads x30 from
the shadow stack rather than from the frame record. For the BPF frame
that called bpf_unwind(), the frame record belongs to bpf_unwind()'s own
C frame:

arch_bpf_stack_walk_ra() is noinline, so kunwind_init_from_caller() sets
fp = __builtin_frame_address(1) inside it.

This means the WRITE_ONCE(rec->lr, ra) above stores the pad address into
a slot that bpf_unwind() never reads back when returning. The sequence
would be:

1. bpf_unwind_rewrite() finds a cleanup record (ctx->cnt == 1) and sets
   *ra = rec->pad
2. The WRITE_ONCE() stores the pad into the frame record
3. bpf_unwind() returns by reading x30 from the shadow stack via x18,
   not from the stacked lr
4. The program returns to the instruction after the call, which is the
   'r0 = 0; exit' that bpf_exc_keep_exits() added
5. The pad never runs

For a concrete example, in the exceptions_cleanup.c selftest, foo3()
calls bpf_preempt_disable(), then a covered bpf_unwind(), and its pad
calls bpf_preempt_enable(). On a kernel with CONFIG_SHADOW_CALL_STACK
enabled, the pad is skipped and the program returns with preemption still
disabled.

The same issue affects any reference acquired before a covered
bpf_unwind() and released in its pad.

Shadow call stack is enabled in configurations like Android GKI builds
(DYNAMIC_SCS on cores without PAC) and other hardened kernels. The
Kconfig help for SHADOW_CALL_STACK says the shadow stack exists "to
protect function return addresses from being overwritten", and it
requires "depends on DYNAMIC_FTRACE_WITH_ARGS ||
DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER" which prevents the
graph tracer from rewriting stacked return addresses.

Nothing in this series tests SHADOW_CALL_STACK, and
bpf_jit_supports_cleanup_pads() returns true unconditionally.

Should the feature be disabled while SCS is active, or should both the
frame record and the shadow stack slot be updated?

> +static bool
> +arch_bpf_unwind_ra_consume_entry(const struct kunwind_state *state, void *cookie)
> +{
> +	struct bpf_unwind_ra_consume_entry_data *data = cookie;
> +	unsigned long record = data->record;
> +	bool seen_first = data->seen_first;
> +	u64 ra = state->common.pc;
> +	bool cont;
> +
> +	/* The record this frame's return address will have come out of. */
> +	data->record = state->common.fp;
> +	data->seen_first = true;
> +
> +	/* The first pc is where the walk runs, not an address it returns to. */
> +	if (!seen_first)
> +		return true;
> +	/* A traced return: the slot holds the tracer's trampoline, not @pc. */
> +	if (state->flags.fgraph || state->flags.kretprobe)
> +		return false;

Can cleanup pads work when bpf_unwind() itself is traced?

bpf_unwind() is traceable: __bpf_kfunc is "__used __retain __noclone
noinline" with no notrace, kernel/bpf/Makefile does not strip
CC_FLAGS_FTRACE from helpers.o, and bpf_unwind is not marked
NOKPROBE_SYMBOL.

When the function graph tracer is active, or a kretprobe or fprobe exit
handler is attached to bpf_unwind, the frame record holds return_to_handler
or __kretprobe_trampoline instead of the actual return address.

kunwind_recover_return_address() then sets flags.fgraph or
flags.kretprobe on the entry for the BPF frame that called bpf_unwind().
This is the first entry the callback acts on after the initial walk
frame, so it returns false immediately:

> +	if (state->flags.fgraph || state->flags.kretprobe)
> +		return false;

This happens before calling consume_entry, so the walk ends having
redirected nothing.

arch_bpf_stack_walk_ra() returns void, so bpf_unwind() cannot tell the
unwind did not happen. The consequences are the same as the SCS case:

1. bpf_unwind() returns through the tracer into the 'r0 = 0; exit' that
   the verifier never explored
2. The outer frames resume at the instruction after their calls instead
   of at their pads
3. Cleanup code in all pads is skipped

For foo3() in exceptions_cleanup.c with bpf_preempt_disable() before
the covered bpf_unwind() and bpf_preempt_enable() in the pad, the
program returns with preemption disabled whenever a privileged user
traces bpf_unwind. References released only in pads leak.

The commit message says the walk "stops there" for such frames but does
not address what happens when all cleanup is skipped.

Should bpf_unwind() be marked notrace and NOKPROBE_SYMBOL, or should
the implementation handle traced returns differently?

[ ... ]

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 475e70653454..2422a1ae1256 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2423,6 +2425,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>  		 * reasons, expects to point to the next instruction)
>  		 */
>  		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
> +
> +		/*
> +		 * Same byte offsets, consumed by the bpf_unwind() walk:
> +		 * turn the cleanup records into native address ranges now that
> +		 * the image is final.
> +		 */
> +		bpf_exc_fill_native_ranges(prog, ctx.offset, ctx.ro_image);
> +
> +		/* Where an unwind sends a frame with no pad. */
> +		prog->aux->epilogue_ip = (u64)ctx.ro_image +
> +					 ctx.epilogue_offset * AARCH64_INSN_SIZE;

The commit message says:

> The JIT half: build the native cleanup table from the JIT's byte offsets
> once the image is final, emit a BTI at each pad head, address the frame
> through the private stack pointer where one is in use, and record the one
> epilogue so a frame the unwind passes over can return straight through it.

Does the sentence "address the frame through the private stack pointer
where one is in use" describe code in this commit?

The diff contains no changes touching priv_sp_used, PRIVATE_SP, or
priv_stack_ptr in arch/arm64/net/bpf_jit_comp.c.

Earlier in this series, commit 88ff94dddf57 ("bpf: Refuse a private
stack for a program with an exception cleanup table") forces
NO_PRIV_STACK in check_max_stack_depth() whenever env->cleanup_info_cnt
is set, so a private stack is never in use when this code runs.

Should that sentence be removed from the changelog since the behaviour is
neither implemented nor reachable?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============2805186730058209274==--
