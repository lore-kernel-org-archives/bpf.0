Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522533;
	b=1d50EDZemUheyK5VFLp7VEDf7sEEGxmHj+lNr8wWChGS1cFKlfX0Hrj31TqUDgNMr37g
	 qICQub/Wg3gAd46zT8Vn/hLC17R/ct7Pxv0tus4IfEGoXOHrdfA+hDF6K9VMHSZYvkyVb
	 hR/WAITIJd6QgM3SoTYWhYS6Xa4PA5ogMV61GDKGnSKZApmnPzhgKfsPqcqydJdPcoQPQ
	 WiqNWS6a8GPBnEfqqLl89fe8IzcjrDY1M7jfO4h4m+esTmnzuHcX4Ab8eNtGLfmn4xwoJ
	 fhCD44FcoLKP0brtZhtsMYc5l/repL3Re4f/YszqJesWsaQlhD6cpbEG+fosgx6f7wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522533;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=0Hw/79qPEYaev+f6sHyspRcMvZ/yCBD7eK46ft+KnMM=;
	b=JEQJgQBCDClQ2yTncVeet+NfFEins3onR1qNDO7nJxeFgVpKVgYfQOqzmwCO1QQtx905
	 y0jr5T3ym8m/z7aVQk1hmgvybNdom7hep4P7VCTorlSHGL2qSeDdYJy4PxQm1B4aNn3QA
	 2reL9e3J7Xaqyfu1nsLaX3ZSL48t8x0N7h2my+NNzMHJGzjvI2jPu2QCciUOIUs4IqjuF
	 uILoq/LFV+Fzr8w1cD9Ief0M5x8QECdEU/oC3mcuUOiiGRiqu9UX1UcZDiza/HZsnpasA
	 Q2ETECnnxIHf+WOsJviuBNrUyMzmUVu1VGzlYj43FjG9Y3X3sP6AT2p38su0GB0vg5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4R7HYrO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06001606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4R7HYrO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B821F000C9;
	Tue, 20 Oct 2026 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522532;
	bh=0Hw/79qPEYaev+f6sHyspRcMvZ/yCBD7eK46ft+KnMM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A4R7HYrOsBhXJwtIbp3frf7ytWn5CeRJ12GSWgYOIHdfSpJI1ZxG/4ucoKJfzdAF7
	 /EmizjMIwUT+r2lmhSp3ykOd+rr4fLbeUVP2WTTdbodos5qx4gj9vjeULC9zKpMyG/
	 YDFDD+UUMLjVajinIwfUPIsk3AT0GstnCin7DV6aONV5oJuBeKAattDXHDAk7dqGr6
	 vhnZZ4shVLn32FQP7wB2WIyhrG5YPy3YyKntlhGSbUwFJJRAA4wGjZCwRMvVHxH0iW
	 OfJCuhZA01FDbE4lZvOnOqxd3+FS28MCPmgju9/Soerl0fZLsKgLNiaql/ZDvNWnda
	 oQOO/VMLDS4LA==
Content-Type: multipart/mixed; boundary="===============5108569627596291362=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d77e239b1d4ce28269711313492d11ff18851fbe0459472cdfb1050efd6e744e@mail.kernel.org>
In-Reply-To: <20261020181320.1284798-4-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/6] bpf, arm64: Support unwind_goto and unwind_exit
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:55:32 +0000 (UTC)

--===============5108569627596291362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Support unwind_goto and unwind_exit

TL;DR: In arm64 JIT, unwind_exit in an exception callback may return into an
unverified unwind_goto pad (via extension or tail call), possibly allowing
type confusion and out-of-bounds kernel memory access.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 1d5f4cf88d33..b3efe0668e86 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1221,6 +1227,76 @@ static int add_exception_handler(const struct bpf_insn *insn,
[ ... ]
> +static long bpf_unwind_fixup(u64 lr)
> +{
> +	const struct exception_table_entry *e;
> +
> +	e = search_bpf_extables(ptrauth_strip_kernel_insn_pac(lr) - 1);
> +	/*
> +	 * The verifier made sure that unwind_goto follows a call in a prog. When
> +	 * the kernel called an async or an exception callback, it's exit.
> +	 */
> +	return e ? e->fixup : 0;
> +}

[ ... ]

> @@ -1806,8 +1882,18 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
>  	/* function return */
>  	case BPF_JMP | BPF_EXIT:
> +		if (bpf_is_unwind_exit(insn) && bpf_prog_can_unwind(ctx->prog)) {
> +			emit_unwind_exit(ctx);
> +			break;
> +		}
>  		/* Optimization: when last instruction is EXIT,
>  		   simply fallthrough to epilogue. */
>  		if (i == ctx->prog->len - 1)

Can this unwind_exit land in a pad that the verifier never checked, when it
is emitted for an exception callback?

The verifier treats unwind_exit in an exception callback as a plain exit
(process_bpf_exit_full() -> check_return_code()), so prepare_func_exit()
never checks for an unwind_goto at that call site.  The JIT doesn't follow
that rule.  An exception callback is func[i] with func_idx != 0, so
bpf_prog_can_unwind() returns true and emit_unwind_exit() is emitted.  The
comment in bpf_unwind_fixup() ("When the kernel called an async or an
exception callback, it's exit") then relies on search_bpf_extables()
failing.

An exception callback has no frame record of its own.  build_prologue()
does "mov x29, x2", and x2 is ctx.bp from bpf_stack_walker(), which is the
FP of the first func_idx == 0 frame.  So the "ldr x0, [x29, #8]" in
emit_unwind_exit() reads the return address of the main prog that threw,
not an address in bpf_throw().  That address is in BPF code in at least two
supported setups:

1. Extension.  Prog P calls global foo() as "call foo; unwind_goto pad".
   Extension E replaces foo().  freplace is a B from foo's patch site
   (bpf_arch_text_poke(), BPF_MOD_JUMP), so E's frame record LR is the
   return address in P after "bl foo".  E calls bpf_throw() and has
   __exception_cb(cb), and cb ends with "r0 = 0; unwind_exit".  Extensions
   with exception callbacks are used in progs/exceptions_ext.c.

2. Tail call.  P's subprog s tail-calls Q.  On arm64 Q runs on s's frame
   record (emit_bpf_tail_call() branches past the FP/LR push), so Q's
   exception callback reads the return address in P after "bl s".

In both cases search_bpf_extables() finds the entry that
add_unwind_exentry() created for P's unwind_goto, and the callback's
epilogue adds .fixup to LR and returns into P's pad.

Is that path checked anywhere?  In case 1, check_unwind_insns() sets
prog->aux->can_unwind from subprog_info[0] only, so an unwind_exit in E's
exception callback doesn't count.  The bpf_check_attach_target() check
"Extension program can unwind, while original does not" then lets E replace
a foo() that cannot unwind, and check_func_call() never pushes the unwound
branch for that call.  In case 2, check_helper_call() models a taken tail
call as a normal return only.

The unwind_goto and its extable entry survive whenever the pad is reached
from another path, for example another jump or another call whose callee
does unwind, because bpf_opt_hard_wire_dead_code_branches() keeps it:

    if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen)
            continue;

At runtime the pad then runs with r6-r9 and the stack as they were at the
"call foo" or "call s" site, plus r0 from the callback, while the verifier
only checked the pad with the states from its other predecessors.  Could
that mismatch allow type confusion, for example a register that is a scalar
at the call site but a map value pointer on the verified path into the pad,
and from there an out-of-bounds kernel memory access?

The commit message statement "the offset is 0 when the kernel called the
subprog as a callback" and the comment in bpf_unwind_fixup() don't appear to
hold for exception callbacks.

Would it work to treat unwind_exit as exit when
ctx->prog->aux->exception_cb is set, for example:

    if (bpf_is_unwind_exit(insn) && bpf_prog_can_unwind(ctx->prog) &&
        !ctx->prog->aux->exception_cb)

or else to make the verifier and the attach check account for unwind_exit
in exception callbacks?

The x86 JIT in 9fa54d36ee99 ("bpf, x86: Support unwind_goto and
unwind_exit") uses the same condition,
"src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog)".  No fix for
this was found in the rest of the series (c1df16f0ed1d..72e419bb0b07), which
only adds selftests, and those cover the exception callback case only for a
non-extension main prog.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39474515830
--===============5108569627596291362==--
