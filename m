Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8D3CB8FC
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119388; cv=none; b=N6Ciz+Igl+XdvdFSqfgoh9H+ADwxqhbfVR6Uw43UK9RZmjrVURcExtI2LpietZVahYQpZjZwsw9K0jJnnpmBL9pJPuilLr6XRc3kMTTPTu8HLoCQwGATPqeZ1Gre3cWyTq1ZD+EGO9YE7H9LjLsq4QmU5g+Y8JeMOwLRVlxzsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119388; c=relaxed/simple;
	bh=VPj10a2KdjINbWZBWoSj7dkWP9AWbiMLl29nHh2g710=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sth79eFMubZjVLWnpjE7oL7n2DBSDzfc8ANjePVux+AFD8Q0PiP4ZBu2W/625pf5j0owYhz2GI8tLKE8ICrwv702CwNwZZtBDj5zs/1Tf/R+YVcdVnUuJjals+ECahVXXA5olF5VnIRs2cexuFfQgpdgNZ0WJv0+/rD/2huw3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VikWEERN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VikWEERN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2141F000E9;
	Wed, 19 Aug 2026 06:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119386;
	bh=zOZ7ySciJzXmIqLE6O90JFYSQ9clSDatdlocBcQGJKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VikWEERN1uYMMU8ZYNm0Oj4qpwdG138ICyFO4JFjbD2yfZ3EpaRy7pJmYq+K5632j
	 iFno1D8PYGVLZ+AS5ruQCtO6e7RhAMZbP95lYrHQZBCLb45QRIA/HjxWYewNBDYUMU
	 AtcdF3gIEbLfLzw4CCp/nFeEEBT5wUruqG8odTygpwApTyPFq+hlKWghTVJ7ZFGWVq
	 7zckopGvfwBHle5XkKqgNyBuVIZqek/cSB5YsR/mvj/Y4B8tXjQVlPm8cA2ncl81rs
	 V0It8vlgeW5JtFwJf/X9/M9x/JzUAtvup9bdm6VnEkwEBMRpn3tMrBZnuEg/XM8Nbx
	 b45Y5iDCKf3fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 04/10] bpf: Handle R2 as a return register
 in precision backtracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260819055259.3295829-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
 <20260819055259.3295829-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:03:06 +0000
Message-Id: <20260819060306.6F2141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the required BPF subsystem style.
--

--- Patch [4]: [PATCH bpf-next v7 04/10] bpf: Handle R2 as a return registe=
r in precision backtracking ---
commit 827448f59c95b01086f128d7ec2894a154de5092
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Handle R2 as a return register in precision backtracking

This commit updates precision backtracking to treat R2 as a return register
alongside R0 at call/return boundaries. It clears R2 unconditionally when
evaluating subprograms or kfuncs, and samples it before callback paths clear
R1-R5.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index a2b18a9f1694c..653db80bcc47b 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c

[ ... ]

> @@ -520,7 +524,25 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>  		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise, r2_precise;
> +
> +			/* BPF_EXIT in subprog or callback always returns

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style? The opening /* is usually required to be on its own line.

> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former
> +			 * case, we need to propagate the precision of the
> +			 * return registers, if necessary. In the latter we
> +			 * never do that.
> +			 */
> +			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
> +
> +			/* Sample the return registers before the callback

[Severity: Low]
This isn't a bug either, but the same formatting question applies here. Sho=
uld
the opening /* be on its own line for multi-line comments?

> +			 * handling below clears R1-R5.
> +			 */
> +			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> +			r2_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819055239.3293=
449-1-yonghong.song@linux.dev?part=3D4
