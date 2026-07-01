Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA43F4DF1
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901179; cv=none; b=qACFnAAJ0796SyPxOtkiEX8mzaTugGWeaQ68nPe1Qe+RSMW1YwvBJHpzOXF14OpAfvXX4+M9arnWZ9OS9rBiFhwbA3lk/eWkvVMH9PxtsSkGRxvu5eFiyU6ZSxzUXdsOEJpq6V42gLxVg6hPgeLR8e296Rfg/PgeSywBeIYkS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901179; c=relaxed/simple;
	bh=iie/leU6lL0yQkTS7f6rdHxyIdpGbutb9lv8aUuj9NU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mb4Xge2tzYxvEWInAi1SOyqqu4Mf09lev5OKE+/DrV+OYVKSSsnd5m93ba6waFn8cExPzYvn8ybfcyqpFKxZJIYQqM1qLqf3SFj9NoqFxASI3uwHm+lbjoHzXVtoRBF7kLG85157NPUXbVQBmYcNVXlUPm+/R64ry82WoUj1KCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXRVuNx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXRVuNx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D731F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782901177;
	bh=v1yVwv+VLlNNhd6qQ5OcdF5thM4bWcbCvcb/4f3T9vI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QXRVuNx2tIOdL5QgQh2y9c1I7iPgEll75RAvFZl/WN0vxEY7JS3DdRREg/QTIDL2H
	 5/ErIflcZJd0ERRPP8MzxW2s0eguhNi/v4oow0B447n5xbIbiLrS3me3lrwxsyvct7
	 Szt2DPd1AsEMfN3JewANt5b/1pv6b07zES7RBEwKU7PlOU5jQvtUPkzSL3FNzMBvkw
	 J7VazhVCyDa1M7bVAjEqkhEVh1f2MYiYklgn/ZUNvPR+tSehY0ysD0WeQM6vUwS+cz
	 +mq2qgp6sJuq3z4fclx29lFZRpio0ip4jeERCLqahFhSZ1swqVwDG6FrAEKks+JDmh
	 1RtTxPDt+FXWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 02/10] bpf: mark instructions accessing
 program stack
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-2-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-2-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:19:37 +0000
Message-Id: <20260701101937.86D731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `is_mem_insn` helper incorrectly excludes `BPF_ATOMIC`, causin=
g inline atomic operations to bypass KASAN checks.
- [Medium] Early return in `adjust_insn_aux_data` bypasses KASAN marking fo=
r 1-to-1 patched memory instructions.
--

commit 90d3117a6d0883383f557efe547dcd0c0e5bc53a
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

In order to prepare to emit KASAN checks in JITed programs, JIT compilers
need to be aware about whether some load/store instructions are targeting
the bpf program stack, as those should not be monitored. The verifier marks
instructions depending on whether they access memory other than the stack,
taking care to shift instruction marking when the verifier patches
instructions.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 1f340211b65c2..0b58a02a71795 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -152,6 +152,17 @@ static int get_callee_stack_depth(struct bpf_verifie=
r_env *env,
>  }
>  #endif
> =20
> +static bool is_mem_insn(struct bpf_insn *insn)
> +{
> +	if (BPF_MODE(insn->code) !=3D BPF_MEM &&
> +	    BPF_MODE(insn->code) !=3D BPF_MEMSX)
> +		return false;

[Severity: High]
Does this logic inadvertently exclude BPF_ATOMIC operations from KASAN boun=
ds
checking?

When bpf_kptr_xchg is inlined into an atomic exchange (via fixup_bpf_calls(=
)),
the verifier replaces the CALL with a BPF_ATOMIC instruction. Because this
function specifically requires BPF_MEM or BPF_MEMSX, it returns false for
BPF_ATOMIC.

Consequently, the newly generated atomic operation inherits
non_stack_access =3D false from the original CALL instruction. The JIT will=
 then
assume the map value access is a stack access and skip KASAN instrumentatio=
n.
Could this be updated to include BPF_ATOMIC?

> +
> +	return BPF_CLASS(insn->code) =3D=3D BPF_ST ||
> +		BPF_CLASS(insn->code) =3D=3D BPF_STX ||
> +		BPF_CLASS(insn->code) =3D=3D BPF_LDX;
> +}

[ ... ]

> @@ -183,7 +194,19 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
>  		/* Expand insni[off]'s seen count to the patched range. */
>  		data[i].seen =3D old_seen;
>  		data[i].zext_dst =3D insn_has_def32(insn + i);
> +		if (i =3D=3D off + insn_off_in_patch) {
> +			data[i].non_stack_access =3D data[off + cnt - 1].non_stack_access;
> +			data[off + cnt - 1].non_stack_access =3D false;
> +		} else if (is_mem_insn(insn + i)) {
> +			data[i].non_stack_access =3D true;
> +		}
>  	}
> +	/*
> +	 * Last slot instruction could be a newly generated
> +	 * BPF_ST/BPF_LDX/BPF_STX
> +	 */
> +	if (is_mem_insn(insn + off + cnt - 1) && insn_off_in_patch !=3D cnt - 1)
> +		data[off + cnt - 1].non_stack_access =3D true;

[Severity: Medium]
What happens when a non-memory instruction is replaced with a single memory
instruction (i.e., cnt =3D=3D 1)?

Looking at adjust_insn_aux_data(), there is an early return if cnt =3D=3D 1:

	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);

	if (cnt =3D=3D 1)
		return;

Since this new logic is placed after the early return, if a non-memory
instruction (like a helper call) is replaced 1-to-1 with a memory instructi=
on
(e.g., BPF_LDX_MEM for bpf_get_func_ip), it skips evaluating is_mem_insn().

The newly generated instruction would then blindly inherit
non_stack_access =3D false, causing the JIT to skip KASAN bounds checks.

Is it possible to move the 1-to-1 handling before the early return, or
explicitly check it there?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D2
