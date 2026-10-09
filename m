Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B83546F2
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547677; cv=none; b=jbSp1SJXOorEWUUyqMNvGthnDPFnIlWvWFP+FxiQBNpdKLwDLThMSP1OmhWvsfhN3ZsuzOuw/FxzGgh9esRN0NP1gadRxO/+IwVbjvWLmeWxlIBholPcsutMoMZH5yONftCYe+ndbU/TR9/cF23S/TDGKjZfDRbYeHQ9YtWDWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547677; c=relaxed/simple;
	bh=XX6V6S7d3KJeFhpgAI8IrtN/i+4u2vNxIhGw82xbQOI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EV/dVDUcxM+vZb2YWFZLj0h3tst5CzmoURezQi7FwljdDFOGCIclnsgPQZfNUJveVgpnjIkzRIRboV5dqq28lmcUi6xPS7C/kKeeV925SUcb6Ri76POzCNZWqTpeg/zBPkkFPYzMC234PSjm1lVGPrX5nhMA41Zp2qgp6q9abxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtwQlm5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtwQlm5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3CD1F00893;
	Fri,  9 Oct 2026 12:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547672;
	bh=w9njv6tAURKAjuyJG6NRYU81DDCt0smXNby/5kOQ9IE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WtwQlm5dQUfoAGFjzNkoi/QoaIV50f+ba0O5JBhBfqXM18++EtoSXjOOV1LDW/7ey
	 UVbIyV3TsZOpsOiYVE6B8s3bxf5eT8845rqChgZU50v3rdJRBjy+sHjKtm0/hrIuk+
	 QOriSKPvjcK2eKTqHl6YSR/IrxUNTmbv32/O3zI6suctO1uYOq1GNuYhVTz7CfQa0/
	 hlruJzdaiR+pdv6Vvn+aMhxofoY+9NEkUyxu7w952SzbqR3bvgcaVfcTHWlWTVgZPF
	 uT+6hCGvTJrc2zlCuwVBYKeddvMB3k9Go33z2Rixp/DQgkQxa0PcEzWvRwnSS1egql
	 813k0mKMQzTbQ==
Content-Type: multipart/mixed; boundary="===============1212706349099477161=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12bdbe361c0dac1e815745e4394dbac721526b99d0dcd8a6b587086d29bb39ea@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-10-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-10-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/51] bpf: derive global subprog stack liveness from BTF signatures
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:51 +0000 (UTC)

--===============1212706349099477161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: derive global subprog stack liveness from BTF signatures

TL;DR: bpf_global_subprog_stack_access_bytes() likely matches ARG_ANYTHING
where btf_prepare_func_args() assigns ARG_SCALAR, so scalar args may get the
conservative read/write-all result; safe but less precise liveness.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8987c9a69d10..a5456a6e2694 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14571,6 +14571,72 @@ bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn
>  	return info;
>  }
>

[ ... ]

> +struct arg_access_info
> +bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +				      int arg, int insn_idx)
> +{

[ ... ]

> +	switch (base_type(sub->args[arg].arg_type)) {
> +	case ARG_UNUSED:	/* Not an argument slot. */
> +	case ARG_ANYTHING:	/* A scalar, the callee can't dereference it. */
> +		return (struct arg_access_info) {};
                 ^^^^

Can this case ARG_ANYTHING ever match?  btf_prepare_func_args() doesn't
assign ARG_ANYTHING to a subprog argument.  It encodes scalar parameters,
including both halves of a 16-byte struct passed by value, as ARG_SCALAR:

kernel/bpf/btf.c:btf_prepare_func_args() {
    ...
            while (nslots--)
                    sub->args[slots_used++].arg_type = ARG_SCALAR;
    ...
}

do_check_common() and the exception callback check test for ARG_SCALAR too,
and ARG_SCALAR and ARG_ANYTHING are separate values in enum bpf_arg_type.

A scalar argument slot would therefore fall through to the default label,
which returns the conservative result (size = U32_MAX, may_read, may_write)
rather than the empty access described by the comment.

For example, with allow_ptr_leaks the main pass accepts a stack-derived
scalar here:

    r1 = r10
    r2 = r10
    r2 += -8
    r1 -= r2
    call global_func(int x)

Pointer minus pointer becomes an unknown scalar, so the ARG_SCALAR check
passes.  arg_track_alu64() keeps the frame identity (dst->frame ==
src->frame sets dst->off_cnt = 0), so arg_is_fp() is still true for r1.

record_arg_access() then calls record_stack_access() with off_cnt == 0,
which does mark_stack_read_all() and mark_stack_may_write_all() for the
whole caller frame at the call.  Before this patch the callee was analyzed
in context and made no stack accesses through its scalar parameter.

The result is safe but less precise.  More stack slots stay live, every
stack slot may be written at the call, and SCEV can no longer keep
stack-based recurrences across the call.

Should this be case ARG_SCALAR: instead?  That looks sound, since neither
the callee nor an freplace body can dereference a scalar argument.  No later
commit in the series (up to 726d0559f576) changes this.

> +	case ARG_PTR_TO_BTF_ID:
> +		/*
> +		 * Trusted arguments cannot be stack pointers.
> +		 * Untrusted arguments use ARG_IGNORE:
> +		 * probe reads need no caller stack state, writes are prohibited.
> +		 */
> +		return (struct arg_access_info) {};

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============1212706349099477161==--
