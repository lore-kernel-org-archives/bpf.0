Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B92D0292
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154141; cv=none; b=OQzYxUPVnFcMunJVKjyHI3Ldblpn9wldR0ifykJRTy+ZacSQ3lzI5AyDb17i5r+BHCYfjNu59OejwU94qDQHkoo6oPPs7SIhlga36EOdg+rU/h7OuIRhtVP1rQhvhd/mHhkWd4oQT+yp2qVTNoBJ0Gr4XAK5y+MmWja0hwnDIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154141; c=relaxed/simple;
	bh=YcZxo2VHRx1ZgOD2I7EZXV3zjuDfZ63iTAZsri6kQzQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O26ZWwE1TONI+jqmbP6xm0VQ7uYXuQQqMATz67XUKHC+1g1zhtEe9OGkjgeX/GVLsOGOBoH3YUItOUuE4HgfnVqwIw/tPwWu2ScAsgbM7MbkwAJzrsa+0mxkdyJHyVUDpl/CCWsy5JFdJF8tAmXJ8rPKOyPwrZ4pS0xhAmCo8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvCAmIMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvCAmIMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194631F000E9;
	Wed, 15 Jul 2026 22:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784154140;
	bh=mvyNmCCx1vlVlAg8q7kUMcNEArc5dOHs7DJnj76SuSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvCAmIMI9w1CjpSn7Y51C6ZDR+0BP8+BVODLe1AkePgkMpHnZ65USYtUcrb6H5vTZ
	 MEIRbaN6zNRLS9mUeHEu8JPPcrKxvEQUh7fQdFswJmgn27gBQQvP3REGWJ+xhkaW++
	 /l95VJt1GoK4u12RKXW57FOn1NjGzqw+xPCK6YNloNDiaLyU99dyWc9OJAD5BnHEjV
	 jB5Yiahh6TawHOFDWrmb+uryyzNWB7kg/GZ2iPMUam7nus0UgovKGxF2ljuAH+T2N2
	 tBf2Ae8XoGvkRf/LK+xqJnWsWgeE5CKh3NdsyLzTurG+IpZAMfJ5jQsu6AZzrsyGqp
	 ya3yHUnxRoLCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/9] bpf: Support __arena and
 __arena_nullable on struct_ops stub arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715220052.1590783-3-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
 <20260715220052.1590783-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:22:19 +0000
Message-Id: <20260715222220.194631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] EXT (freplace) and TRACING (fentry/fexit) programs attached to=
 struct_ops programs bypass defensive checks and `ctx_arg_info` inheritance=
, causing them to incorrectly verify arena pointers as trusted kernel point=
ers (`PTR_TO_BTF_ID`).
--

--- Patch [2]: [PATCH bpf-next v1 2/9] bpf: Support __arena and __arena_nul=
lable on struct_ops stub arguments ---
commit 592a1abca0acd2ddc98e47619cf772faa71d7c0d
Author: Tejun Heo <tj@kernel.org>

bpf: Support __arena and __arena_nullable on struct_ops stub arguments

This patch adds support for the __arena and __arena_nullable suffixes on
struct_ops callback arguments. The trampoline automatically converts the
kernel pointer to an arena pointer when saving arguments, allowing the BPF
program to dereference it directly.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 6eadf64f7ec90..56759891eab79 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -688,6 +736,22 @@ static int bpf_trampoline_update(struct bpf_trampoli=
ne *tr, bool lock_direct_mut
>  		goto out;
>  	}
> =20
> +	/*
> +	 * Arena ctx args are converted only by the struct_ops indirect
> +	 * trampoline, which dispatches to a single known prog. Generic
> +	 * trampolines can mix progs with different arenas, so no conversion
> +	 * is possible here. Not reachable today: only struct_ops progs get
> +	 * arena ctx args and they never ride generic trampolines.
> +	 */
> +	for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
> +		for (i =3D 0; i < tnodes[kind].nr_nodes; i++) {
> +			if (bpf_prog_has_arena_ctx_arg(tnodes[kind].nodes[i]->link->prog)) {
> +				err =3D -ENOTSUPP;
> +				goto out;
> +			}
> +		}
> +	}

[Severity: Critical]
Will this defensive check be bypassed for FENTRY/EXT programs attached to
struct_ops programs?

When an FENTRY or EXT program attaches to a struct_ops program, it does not
inherit ctx_arg_info from its target in bpf_check_attach_target(). Because
the attaching program lacks ctx_arg_info, bpf_prog_has_arena_ctx_arg()
would return false here, allowing the attachment to proceed instead of
returning -ENOTSUPP.

If this check is bypassed, could the attaching FENTRY/EXT program evaluate
the argument as a standard PTR_TO_BTF_ID? Since the generic FENTRY
trampoline receives the already-converted, user-controlled arena offset from
the struct_ops caller, this might allow an attaching program to treat an
untrusted offset as a trusted kernel pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715220052.1590=
783-1-memxor@gmail.com?part=3D2
