Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64001EFFB7
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787203; cv=none; b=SIOfgEM4LVthtDBPXE5DkasaM8D6DDJ82P7BzLpyOSnYoMnnLl47yTE6WNMJR2JCwKzLQt9rjIJsTLcjztJlblO6aMVkTZQICiufW+4XueqZKgLdPwvptdetFiwOUnv9Im0aETZULiDP7apve/m9jow/YAZZjvUyl0IQ2C7/+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787203; c=relaxed/simple;
	bh=8TR77XdvcHb1Tzb/M9hdpNjmbFWOrLW48VyTEnOCX3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ilRLPwyO/JYT/qOd62YTudmNWvP2TkdjNsvvXeyDr9bK4hsQsaFoBzXgO31gnE/bb/YAsPk+wkY4uo/ijWUHeiT27+RW8bfyOLMG+dmNc9F4UI/hXTCZUpnEcysAgrm/SrUJ2SgXblSfyQqOudD8w6Hw0f3Vs5tf/VNuLj6tKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbLBXMZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbLBXMZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F4D1F000E9;
	Tue, 30 Jun 2026 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782787202;
	bh=v9WpjZYG8mhfP1LN4yEtiVBhed2pxZW/qe6Wg/3tZ2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbLBXMZlk1JI/p5wVju4ezI7SLx1FwUJjljsqO1UuIRmByS1dn3AcgkkEjbrc8VdF
	 lJ0prXh/1U5i6zMahpqDASsPnomh0gUsP90XItQpVCJ+LnaJIepd0Asya3Otv5EdFJ
	 y214AzBjgJfRqueRKswXJwXaigcV0LHoBxbDDpMc6kLa+6KHLAsu/DRbzkN9sTPUgE
	 kkCySGZICQv3NrMDwyJU7PJ1g9PTBxDAmnFd0OAll8FcGCXD98e2MTbUDN00i7xeb/
	 xGrJY1abzrrYAU8BodNhHxtM3jJaUIwxtBrQTM1q5oYiO4HbkQKKJHSukF7ev5IaWR
	 yn7kOZ/adOQlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] LoongArch: BPF: Refactor jump offset calculation
 in tail call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630022705.11536-4-yangtiezhu@loongson.cn>
References: <20260630022705.11536-1-yangtiezhu@loongson.cn>
 <20260630022705.11536-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 02:40:01 +0000
Message-Id: <20260630024002.26F4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Spurious JIT compilation failure for large BPF programs with tail =
calls due to invalid jump offset calculation in the first JIT pass.
--

commit c7d3e2cbf4a615b76ec73b1fff169ff7f13381b9
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Refactor jump offset calculation in tail call

This patch modifies the jump offset calculation in emit_bpf_tail_call()
to use an absolute target reference anchor based on the next instruction
offset, ensuring immediate offsets land precisely on instruction boundaries.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
[ ... ]
> @@ -310,12 +306,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
int insn)
[ ... ]
>  	off =3D offsetof(struct bpf_array, map.max_entries);
>  	emit_insn(ctx, ldwu, t1, a1, off);
>  	/* bgeu $a2, $t1, jmp_offset */
> +	jmp_offset =3D ctx->offset[insn + 1] - ctx->idx;
>  	if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
>  		goto toofar;

[Severity: High]
Does this calculation cause large BPF programs to fail JIT compilation duri=
ng
the first pass?

During the first JIT pass, ctx->offset[insn + 1] is not yet populated and w=
ill
be 0. As a result, jmp_offset evaluates to -ctx->idx.=20

If ctx->idx exceeds 32767 for a large program, jmp_offset will fail the 16-=
bit
bounds check inside emit_tailcall_jmp(), causing JIT compilation to abort
prematurely.

Previously, jmp_offset used a small relative offset which safely fit within
the 16-bit limit during the initial pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630022705.1153=
6-1-yangtiezhu@loongson.cn?part=3D3
