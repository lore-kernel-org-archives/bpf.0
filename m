Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C828C1E1E16
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288112; cv=none; b=Q3EMNslfrQhuKlWSZunWHFC/0NA9Ig/L7q3fhyObZX6Rljvv3LY3E10MBfn9/3Oh/uwMtQHnw9BXKqCJ3Upd+F8MPLaxIgLxumC6y098zUnvhd901NhenVjf4lcZ98aIuUBUOCtTuQiIWs9xjHD2RZfKBOzKEuAKgi+E+SIBqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288112; c=relaxed/simple;
	bh=UWEap/EhFEdVY3elCjafX+Rcwlk6PrMGP4X7oAZOq9k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BoL9zKPCit5kkzI2lUhjGSDOPsLhokeZ/E1Nlq2sl0sIa19+ezI5AJjJRgZQ2MHx94m26whU/xyUWntY1lwFQPetqMGLmlDOcE9xiyVAFDIuLmxU+avjglZqGvu/H8YTlfmnSbDC2toViJVKw9Y0BmKoWPytAmSVCzHzQb9ps0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HylDli4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HylDli4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D41F000C4;
	Sun, 18 Oct 2026 01:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288111;
	bh=zlZdcHdvCWtRIdorhkyLpcOxfauIn09Po3GCzqzVhmc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HylDli4TgH3z81v9p4bj5VEwkH4/FZZzCJzilUllrRMUgNnGSmMj/JAp3DIavptvF
	 LHagABfAAEa4RHFLVxgOZTuhsBFRDygjtsFmmmY3+GPYFgrOVRvdz9qHBFDoF29P6I
	 3bGR13wEH2OxiarU9XcSDux5inR71dzVLxkU46bSlvuy8c84eGENY846gLrITBUQLd
	 ktFYliEol7cJ58a45vDvoM4HEXw05sZr1xP1Vwnhz/eEOi4vzUvawWi+AXcCtu4YfN
	 +UJq4K8hYw0gU1yrww3FxuYbkKXfrVZkMsp1FOIvQlPM4/JHrroec+vcAierVMbOZN
	 0PwTsijURZnyg==
Content-Type: multipart/mixed; boundary="===============6465459991306325806=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f36481f4331174e8ce3a76e97d2865b1002fc90ce642c2b1fe19ca154185496@mail.kernel.org>
In-Reply-To: <20261018010246.1643877-2-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Support unwinding via r3
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 18 Oct 2026 01:48:30 +0000 (UTC)

--===============6465459991306325806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Support unwinding via r3

TL;DR:
- Possible wrong r3 after fentry on an unwind subprog (rdx not restored), so
  the verifier may miss a reachable pad
- "unwind" decl_tag matched by prefix, may reject unrelated programs
- Missing diagnostic write record for R3 (nit)

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 11a4e4f87aac..16e847c615bc 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -5025,6 +5025,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
>  
> +bool bpf_jit_supports_unwind(void)
> +{
> +	return true;
> +}
> +
>  const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)

Can the r3 that reaches the caller still be clobbered when fentry is attached
to a subprog that can unwind on x86-64?

prepare_func_exit() only checks that r3 is readable and a scalar at exit:

	err = check_reg_arg(env, BPF_REG_UNWIND, SRC_OP);
	...
	caller->regs[BPF_REG_UNWIND] = *r3;

set_callee_state() copies r1-r5 into the callee no matter how many arguments
the callee declares.  So a static unwind subprog that never writes r3 passes
verification whenever its caller set r3 before the call.  The selftest 'static
subprog doesn't set r3' fails only because its caller leaves r3 uninitialized.
This means r3 does not behave 'like r0', which is NOT_INIT when the callee
starts.

An fentry-only trampoline is built with BPF_TRAMP_F_RESTORE_REGS, and it
restores only the argument slots in the target's func model:

	if (flags & BPF_TRAMP_F_RESTORE_REGS)
		restore_regs(&prog, pos_of_slot, nr_regs, regs_off);

For a static subprog whose BTF passes btf_check_subprog_call(),
func_info_aux[].unreliable stays false, so bpf_check_attach_target() sets
conservative == false and btf_distill_func_proto() uses the real BTF argument
count instead of 5.  If that count is below 3, rdx is never restored.  By then
rdx has been overwritten by __bpf_prog_enter*(), by the fentry prog, and by
__bpf_prog_exit*(), which receives run_ctx in rdx.

For example:

  caller:  r3 = 0; r1 = ...; call S; if r3 != 0 goto pad
  S (static, BTF 'int S(int)', decl_tag "unwind"):
       r0 = r1; exit

The verifier knows r3 == 0 after the call, marks it precise, and never
explores the pad from this path.  If the pad is also reachable from another
path, bpf_opt_hard_wire_dead_code_branches() does not hard-wire the branch, so
it stays in the image.  Once fentry is attached to S, S returns whatever rdx
the trampoline left behind, and the branch can be taken at run time with a
register state the verifier never checked for the pad.

The later extable conversion in this series (f2c9eb1fde9a "bpf, x86: Replace
'if r3 != 0 goto pad' after a call with an extable entry") does not change
this.  An exit not preceded by 'r3 = imm' gets 'test rdx, rdx' plus the
extable lookup, and returns to the pad.  No later commit in the range fixes
it.

The same trampoline behaviour already affects a static subprog that reads an
argument register it did not declare, so this widens an existing gap.  Here,
though, r3 directly decides which landing pads the verifier treats as
reachable.

Would it work to mark r3 NOT_INIT on entry to an unwind subprog when r3 is not
a declared argument (as is done for r0), or to treat unwind subprogs as
conservative for fentry so that all five argument registers are restored?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 63fff641d985..70b2087c7185 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -454,8 +454,26 @@ static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>  	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
> [ ... ]
>  		type = subprog_ret_type(env, subprog);
> -		if (!type || btf_type_is_void(type))
> +		if (!type)
> +			continue;
> +		func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
> +		if (btf_find_next_decl_tag(btf, func, -1, "unwind", 0) > 0) {

Does this match only the tag "unwind"?

btf_find_next_decl_tag() does strncmp(__btf_name_by_offset(btf, t->name_off),
tag_key, strlen(tag_key)), so it matches by prefix.  The other callers rely on
that because they pass key prefixes that end in a delimiter ("arg:",
"exception_callback:") and then parse the value.  Here the key is the full tag
name "unwind" with no delimiter.

Any decl_tag on a subprog whose name starts with "unwind" (for example
"unwind_safe", "unwinding", or a later "unwind:<x>" form) sets
sub->ret_unwind, even though the commit message says only the tag "unwind"
means this.  Such a subprog loaded fine before this patch.  Now:

  1) on every JIT other than x86-64, bpf_check() fails with -ENOTSUPP
     ("JIT does not support unwinding")

  2) on x86-64, prepare_func_exit() and check_global_subprog_return_code()
     require an initialized scalar in R3 at every exit, so a subprog that
     never sets r3 (it is normally scratched by helper calls) is rejected
     with "R3 !read_ok"

  3) tail calls and ld_abs in it are rejected

  4) fexit and freplace can no longer attach to it

  5) jit_required is forced

Would checking the name of the found tag with strcmp() against "unwind" limit
this to the tag llvm emits?

[ ... ]

> @@ -11489,6 +11507,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> [ ... ]
>  
> +		if (env->subprog_info[subprog].ret_unwind)
> +			mark_reg_unknown(env, caller->regs, BPF_REG_UNWIND);

Should this R3 write be wrapped in bpf_diag_mod_begin()/bpf_diag_mod_end()
with BPF_DIAG_MOD_WRITE?

In the global subprog path, every return register write is wrapped that way:
R0, and R2 for a register pair.  The new R3 write in prepare_func_exit() in
this patch is wrapped the same way.

Just before this, clear_caller_saved_regs() -> bpf_diag_record_caller_saved()
logs a BPF_DIAG_MOD_CALLER_SAVED scrub event for R3, and nothing is logged
afterwards.  When a later error involves R3 after a call to a global subprog
that can unwind, the "Causal path" printed by diag_print_mod() ends with:

  R3: call invalidated this caller-saved register; previous value was ...

It never shows that the call wrote an unknown scalar into R3, which can
mislead the user.  R2 in the pair case gets the scrub event followed by a
write event, which is the intended pattern.

This only affects diagnostics, not verification results.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39085585797
--===============6465459991306325806==--
