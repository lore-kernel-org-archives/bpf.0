Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AB361947
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447278; cv=none; b=p04GgyJAIWoQz+ak3onXsfxQlgPpy9pp0uVjUf6kxpZnsKZCQYszu+ZRnjs0P3T+2wxMCn1L9aEuna9t6zMjB2MUNSeCoFvrlYCROhoYJ6DI/jVU/xzgIgWsK5rYXsEiyJET9g0yaXXayZf0x8Q7ShxUFTnh1rvicQ7F0WPUpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447278; c=relaxed/simple;
	bh=QhtUV3fkpEIXNd0N5wIdYcJlVMJ43d05TUI4ovk8b88=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lnRmdIQ087AxxkLNHJ/B2av4A9j2HIiOCAXaOXaH9UifltdG50s4o2c11VOv3/iEtaabKMYsh7T0iQSLRPEgLbR14rJkqrnOaRIAl8QWtWaeH21FUWm2nzweUnzsKsmbJl3dRR5LihE3gf9ejaKW6Zx3RYP5268c2g+GKX33cwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFjQYvM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFjQYvM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E57F1F000FF;
	Thu,  8 Oct 2026 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447276;
	bh=vIXnedMEVBk3zVzIVGfd80btTHGEOjiWb7p/ZyrFQvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFjQYvM+cK+vL9je5/4MSazk5BKFqoOOqfvpRxtuTI3aVnyjPavRLCvetJ/X9Gq/v
	 XT739BVjstIKr140+YTAIg6tOa2AQsCD5OXdksj1HpIx3T9qEmwG6kSTH06AjP9Lro
	 Gqj6UTIVJiqo+OPVpbEIOJ2MqRA2FWVsLsA6yuTGi5b9Ae/HKUYl13J8y8BQyMMj0/
	 8o3eX/ln6NQF+NvnmVKUym9PTs8GwRDj+/f+9L8+pEI+4XKt9j8c9cYitwWGRVlrzR
	 46rFDWULb7RUY4AjQGrJ3/++DTV+nEK/tDCWgMHsYm7qhtF/fXG7qLU5nfK++1jjJu
	 gHnAvoFJXFt6g==
Message-ID: <sashiko-outbox-163811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 12/23] bpf: Refuse a trampoline that calls a
 subprog that can unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008075101.3001371-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075101.3001371-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:14:35 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: x86 exception unwinder passes wrong return address pointe=
r causing stack corruption
- [High] bpf: Missing trampoline restriction for bpf_throw() leads to NULL =
pointer deref
--

commit 554b5300d0510c78440f3ee71cad1d363c75cfaf
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Refuse a trampoline that calls a subprog that can unwind

This patch refuses fexit, fmod_ret, and fsession trampoline attachments
to subprograms marked with might_unwind, preventing bpf_unwind() from
tripping over unexpected trampoline frames.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 668d811d4e4cb..3692d9b163d43 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21600,6 +21600,22 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
>  				prog_extension ? "Extension" : "Tracing");
>  			return -EINVAL;
>  		}
> +		/*
> +		 * A trampoline that calls its target stays as a frame between a
> +		 * subprog and its caller, and bpf_unwind() cannot walk past it:
> +		 * the frames below would return after their calls rather than at
> +		 * their landing pads. fentry leaves no frame, and the main
> +		 * program's caller is below where the walk stops.
> +		 */
> +		if (aux->func && subprog && aux->func[subprog]->aux->might_unwind &&
> +		    (prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT ||
> +		     prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN ||
> +		     prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION)) {

[Severity: High]
Does this logic also need to check for bpf_throw()?

The patch correctly prevents attachments for bpf_unwind(), which is tracked
by might_unwind. However, bpf_throw() seems to be missed. It uses an
independent might_throw flag which does not appear to be propagated to
bpf_prog_aux or checked here.

If a subprogram calls bpf_throw() and has a tracing program attached
(like fexit), bpf_stack_walker() encounters the trampoline frame. At that
point, bpf_prog_ksym_find() will return NULL, and since ctx->cnt > 0, it ab=
orts
the walk before setting ctx->aux:

kernel/bpf/helpers.c:bpf_stack_walker() {
    ...
    if (!prog)
        return !ctx->cnt;
    ...
}

Because the walk is aborted early, ctx.aux remains NULL, which leads to a
kernel panic when dereferenced later in bpf_throw():

kernel/bpf/helpers.c:bpf_throw() {
    ...
    ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust,
                              ctx.bp, 0, 0);
    ...
}

> +			bpf_log(log,
> +				"Cannot attach fexit, fmod_ret or fsession to %s, which can unwind\n=
",
> +				tname);
> +			return -EINVAL;
> +		}
>  		conservative =3D aux->func_info_aux[subprog].unreliable;
>  		if (prog_extension) {

[Severity: Critical]
I also have a question about the x86 exception unwinding implementation add=
ed
earlier in this series. Can the x86 unwinder corrupt the stack by passing t=
he
wrong return address pointer?

In arch_bpf_stack_walk_ra(), the unwinder passes the current frame's return
address pointer to the callback:

arch/x86/net/bpf_jit_comp.c:arch_bpf_stack_walk_ra() {
    ...
    ra =3D unwind_get_return_address_ptr(&state);
    if (!ra)
        break;
    if (!consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.bp, (u64 *=
)ra))
    ...
}

However, bpf_unwind_rewrite() seems to expect the return address pointer
of the previous frame, so it can make the previous frame return directly in=
to
the current frame's cleanup pad.

By passing the current frame's return address instead, bpf_unwind_rewrite()
overwrites the current frame's return address with its own pad or epilogue:

kernel/bpf/helpers.c:bpf_unwind_rewrite() {
    ...
    rec =3D bpf_exc_pad_for_ip(prog, ip);
    *ra =3D rec ? rec->pad : prog->aux->epilogue_ip;
    ...
}

On x86, this causes the pad to execute after the current frame has already
returned via leave and ret, corrupting the caller's stack frame. For the ma=
in
program, its return address is overwritten with its own epilogue, leading to
a double-epilogue execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008074959.2993=
751-1-yonghong.song@linux.dev?part=3D12
