Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154C3C9437
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498778; cv=none; b=niXD66ZYPZWQUSc92P1SdIcOq77X4hg/cxgTJZo8QVcuvghWXlL0pYlEDQajgB3wNCvQt1T3S8MhG13UmkCqLewvEc4Pu2X6Ls/UCTStnPjP4PcRfd6PIGMoDIZLX14CDJELEpqgg0ih26zRwWmS74pBk4Tp7Kw+kUnZpllYCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498778; c=relaxed/simple;
	bh=ZqjyHpoZxj4A9lGv+6a5nebKq+YVsH9Su6TbhSKxWWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FB5gdJHo4pGWjdGw+rVa4HSIpJlP+Vo2xFDXoMbyXN3p3CmJxXY4qpxpcn1e03B7ireQx4cPMWeXq/ckSkqsZCLOXg3W614OrgTXoxI5xQRqlrXotYrn3VIMfKaitBgjxqEnCXESeH/qVp7oetIXJ1sGKQIWRqJiaPPDCTiSkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPiBPyWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPiBPyWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5031F000E9;
	Wed,  8 Jul 2026 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498777;
	bh=M6fEIXABjTeHUm4zfmqm6Mev/4PSVxethKf2VzS8Dio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KPiBPyWya8xI2ip6YwwuaIT3XfxHBYf4Eek/YIIcafm2xgg43bMvo/0qLQ32uK4oO
	 qyXsb9cDHcO+C69mB856ICdxF5QELqtQS1BzSOe5ROf7rmjyWlbBf9wYSMGG52BA+F
	 FburVemfQPUIJ8+U+OzyYmZLq6nFy7cvtwKBeUlbjzUeEpWoT6hq7zrNWgX/Fnww0K
	 4NzPsfm+VOspmUoy+rClb34xFNY9xp+ar78RSotenQ8lKCPHIMIiITVeu2xbuVnszN
	 e99xNaxya2wjmz5jVG4TT3o/VdxPEkdR93HsyJE+vL6V3k0Ab7/ProcLHCB5HRLuJq
	 vZUTnDo3HgS+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/10] bpf: propagate original instruction
 offset when patching program
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-1-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-1-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:19:36 +0000
Message-Id: <20260708081937.5D5031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect or inconsistent calculation of `insn_off_in_patch` cau=
ses loss or misassignment of `aux_data`.
- [Medium] A single `insn_off_in_patch` integer is insufficient to propagat=
e KASAN memory markings to patches that emit multiple memory accesses.
--

--- Patch [1]: [PATCH bpf-next v4 01/10] bpf: propagate original instructio=
n offset when patching program ---
commit 6ebaaf2368d2745f393ec38eb53d5857d5ec62b8
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: propagate original instruction offset when patching program

When the verifier patches an ebpf program with bpf_patch_insn_data, it
then calls adjust_insn_aux_data to make sure that insn_aux_data takes
into account the newly inserted patch.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12a8a4eb757f1..f515fc9669ce2 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -856,16 +862,20 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_en=
v *env)
>  			if (!ops->convert_ctx_access)
>  				continue;
>  			convert_ctx_access =3D ops->convert_ctx_access;
> +			insn_off_in_patch =3D 0;

[Severity: Medium]
Will this properly track context accesses that are converted into multiple
chained memory loads?

By relying on a single integer to track the offset, it seems we might fail =
to
account for multi-load patches emitted by ops->convert_ctx_access() (for
example, reading skb->dev followed by dev->ifindex). The secondary memory
accesses will receive zeroed aux_data and lack the required KASAN
non_stack_access marking.

Additionally, since the original instruction is completely replaced here, d=
oes
it make sense to unconditionally assign its aux_data to the first generated
instruction, which might not even be the actual memory access?

>  			break;

[ ... ]

> @@ -1464,7 +1475,7 @@ static int add_hidden_subprog(struct bpf_verifier_e=
nv *env, struct bpf_insn *pat
>  	 * ones for the hidden subprog. Hence all of the adjustment operations
>  	 * in bpf_patch_insn_data are no-ops.
>  	 */
> -	prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
> +	prog =3D bpf_patch_insn_data(env, env->prog->len - 1, patch, len, -1);

[Severity: Medium]
Is it intentional to pass -1 for the offset here?

Since the original instruction is explicitly preserved in the patch buffer
in bpf_do_misc_fixups():

	*patch++ =3D env->prog->insnsi[insn_cnt - 1];

Passing -1 to bpf_patch_insn_data() will cause the aux_data associated with
that instruction to be lost.

[ ... ]

> @@ -1743,7 +1765,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  				*patch++ =3D BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
>  			cnt =3D patch - insn_buf;
> =20
> -			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf,
> +						       cnt, -1);

[Severity: Medium]
In this pointer arithmetic rewrite, the original ALU instruction is preserv=
ed
in the patch buffer (*patch++ =3D *insn).

Should we calculate and pass its exact offset inside the patch buffer inste=
ad
of passing -1, which discards its aux_data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D1
