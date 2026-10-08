Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50061CDFCA
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441899; cv=none; b=eBu58Y2d0yhsfhQbatd8xU5kRuXUnSA9yYVMD7PD5zA563oVURcwnd/EWmDebRtHzD8dIM3kC3lRMJ6izSx22zGdSmqheA8k1aSV/O/gB32Vt8WfFb3V/aaSRvqnX366GtH5Z8sZrm6zhYaLmfSyhkw91ODyDg02Q+WmFrbfIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441899; c=relaxed/simple;
	bh=3O5O7RWkNTLZMYYlMr1ABFr2HnvTSZOG2fhmyvEfBNM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gOswUpOYDu8HRcTwZG3r2UktcnZYCtDzf79WUnCG+1TdnqFQexzJbdHO5uAlwW9lrcU0nfbZcHBMksnwv0QIuY63rbh0xU7t4anFmPsgE1t8uIfFJcKCH6vZIvGXeA0hPTZdzljVIAJ9bZ+VfqG3l91i19lzofnR+5snjp6qtnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4T5EEhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4T5EEhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBD51F000FF;
	Thu,  8 Oct 2026 06:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791441898;
	bh=ARAPb+DIIuHElv3QqJdjhEVi2QCLq2TepVwnhoZ3bV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4T5EEhiNZNBIhRRDhyXJtlS0F+2OXPLDbB6LAWddrKfuFR6NKvmCfv69jEKqKfzi
	 A7ic5SMtHu6MvvAuIq5/wCUa+NqmzzJU3oOCUBNixghFoboNL8mpQd0a5p2L6Hgpa1
	 0muz3PX3XtMD7wXcF9M793yLgI3zJEcCZyr5nVRWVCHM1mEvQPjw4loT8pSV6BUCwm
	 FCELnIn0WGgFjgBtRz6l2JLiveG9/6DBitVpFEy3nYPUa00lXRiuhkOHR7wE7j8vt9
	 CGzGcsPsUFs/lEwPR9dX0N8mW+2Cvg7ZiuB+pLohKqTGHXp1FSxgntPV13ZMCpxcT9
	 kRB+FKcbwh6NA==
Message-ID: <sashiko-outbox-163713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: fix symmetric register-form NULL-pointer
 check in check_cond_jmp_op()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahad Bhuiya" <rahadbhuiya2021@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008063322.530-1-rahadbhuiya2021@gmail.com>
References: <20261008063322.530-1-rahadbhuiya2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:44:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: symmetric NULL check fix is unreachable for unprivileged pr=
ograms
- [Low] bpf: multi-line comments violate subsystem style guidelines
--

commit e76939eba1acc9b00715cb7f09c40f2d50cb02ae
Author: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
   =20
This commit addresses an issue in the BPF verifier where symmetric NULL poi=
nter
checks (e.g., if (0 =3D=3D ptr)) were not propagating the nullness state co=
rrectly.
It adds logic to handle the case where the destination register is zero and
the source register is a nullable pointer, updating the branches accordingl=
y.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 353bde9ae2274..e4ae8f6481620 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18248,6 +18248,26 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  				      opcode =3D=3D BPF_JNE);
>  		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
>  				      opcode =3D=3D BPF_JEQ);
> +	} else if (!is_jmp32 && BPF_SRC(insn->code) =3D=3D BPF_X &&
> +		   (opcode =3D=3D BPF_JEQ || opcode =3D=3D BPF_JNE) &&
> +		   type_may_be_null(src_reg->type) &&
> +		   bpf_register_is_null(dst_reg)) {

[Severity: Medium]
Will this fix be reachable for unprivileged BPF programs?

In unprivileged mode (env->allow_ptr_leaks =3D=3D false), an early security=
 check
in check_cond_jmp_op() rejects conditional jumps where src_reg is a pointer,
unless both operands are packet pointers:

    if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg=
)) &&
        is_pointer_value(env, insn->src_reg)) {
        verbose(env, "R%d pointer comparison prohibited\n", insn->src_reg);
        return -EACCES;
    }

Because this check happens before the newly added block, unprivileged BPF
programs attempting symmetric NULL checks might still be unconditionally
rejected, rendering the fix incomplete for those users.

> +		/* Symmetric case: src_reg is the nullable pointer, dst_reg is
> +		 * a register whose value is known to be zero.  This arises when

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the BPF subsystem
style guidelines?

The BPF guidelines mandate that multi-line comments must have the opening /*
on its own line, with the comment text starting on the subsequent line.

> +		 * the programmer writes the comparison in reversed operand order,
> +		 * e.g. "if (0 =3D=3D map_val)" or "if (r0 =3D=3D map_val)" where r0 h=
as
> +		 * been proven zero by the verifier.
> +		 *
> +		 * The zero is a property of this execution path, so dst_reg
> +		 * must be marked precise before we propagate nullness.
> +		 */
> +		err =3D mark_chain_precision(env, insn->dst_reg);
> +		if (err)
> +			return err;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetri=
c.c b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
> new file mode 100644
> index 0000000000000..475aa3dc3bd25
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Verifier selftests for symmetric register-form NULL-pointer checks.
> + *
> + * The BPF verifier's check_cond_jmp_op() handles "if R =3D=3D 0" NULL c=
hecks by

[Severity: Low]
This isn't a bug, but does this comment also violate the multi-line comment
style for the BPF subsystem?

The opening /* should be on its own line, with the text beginning on the
subsequent line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008063322.530-=
1-rahadbhuiya2021@gmail.com?part=3D1
