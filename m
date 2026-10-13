Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC752ED2E
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914284; cv=none; b=R8idDQjRRy1hpBCrC23nWsXTzg2ICmv1hTWvHaqeYy8XrJGuLtNg1h4RwBWTOncvXt4DafygKNVqZVr5IBOoyZ0ivAS42+OR58Xah35qXsizANoMejomdgg+reSAXCJlHveVe9YsmVD/J9z9gteyP8TjxO9HzXosSKrxpwHPaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914284; c=relaxed/simple;
	bh=6OTnQr4NKh8VeYh740biBUTM4aIJFO4XIjKnayuldhI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cMR/Vkw7w9RqRJjLLsj/8HAfOipfCFtisMM8HqhniE7RrOtoQWhu0SQtUKZs+Oo7BUxder565B7tIzMccxSnY77E9UMo0GK0zGea7gxINUZKoqvYZ+aHcGGBp/oWNiwrF9a4ELC0yM2ov2TaqRHWSulYZWY41JQwpVUxkbBmNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsvs/vD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsvs/vD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187971F000FF;
	Tue, 13 Oct 2026 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914282;
	bh=dKI6UlEH73P/hO3pmnIcDH00bt2AKqIXs9cXmBq9dJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tsvs/vD2ChckQcK7YLRgznSvZ9uCdvgcKzw0kiRIZdMoXRQhtTgdfoVb4HO3xPz6B
	 GMVtLTifCL5mtouWK/ePaaQkrUqPxpg86/+X74KMULxVMxs1ZvJtW95EtDKhWRXyZO
	 oYcMtWoSzotSJ3+N2DsPCBw+cD+kXi3RKqnuTy4AvpPrpdNzkpO6KVlxlqzEqNm7QA
	 1L7MflXVvMU06Adfc/TigzECY13yo7YIxJaFK2y+c9DA1+BwOaw16Sa3aZTvwOObwB
	 K23TZ2CMyk7B8HoZia76SPr2QzQd/wFoG0xjmDMftAmkebDBtQweTcZu0pkJZ1mtxp
	 2DLzysjln8DkQ==
Message-ID: <sashiko-outbox-170282@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 14/18] bpf, x86: Multiply by 3, 5 and 9 with
 lea
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261013171230.523677-15-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
 <20261013171230.523677-15-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:58:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf, x86: R12 ignored as SIB index, bypassing arena base
--

commit 67afba40c1efdd0d3dc72afceed029446b9b3578
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf, x86: Multiply by 3, 5 and 9 with lea

The commit converts BPF multiplication by 3, 5, and 9 into x86 lea
instructions. It adds a scale parameter to emit_insn_suffix_SIB to
support the scale factor in the SIB byte.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4e9c6bbe93d0c..d1c22ae90fcc6 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1163,17 +1163,22 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_=
reg, u32 val_reg, int off)
>  	*pprog =3D prog;
>  }
> =20
> -static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u=
32 index_reg, int off)
> +/*
> + * Emit the suffix for addressing *(ptr_reg + (index_reg << scale) + off)
> + * and val_reg, with a SIB byte
> + */
> +static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u=
32 index_reg, int off,
> +				 u8 scale)
>  {
> +	u8 sib =3D (scale << 6) | add_2reg(0, ptr_reg, index_reg);
        ^^^^

[Severity: Critical]
Does this code silently drop the arena base pointer if index_reg is
X86_REG_R12?

When index_reg is X86_REG_R12 (which has a value of 4), the SIB index field
becomes 100b. On x86-64, an index of 100b is interpreted as 'no index
register', so the CPU completely ignores the R12 base.

For BPF programs utilizing arena memory (e.g., via BPF_PROBE_MEM32),
functions like emit_ldx_r12(), emit_stx_r12(), and emit_st_r12() explicitly
pass X86_REG_R12 as the index register to emit_insn_suffix_SIB().

Because the R12 index is ignored, the kernel will incorrectly dereference
the user-provided 32-bit offset directly instead of adding it to the arena
base. This could allow a BPF program to read and write arbitrary user-space
memory, bypassing arena bounds.

>  	u8 *prog =3D *pprog;
> =20
>  	if (!off && !base_needs_disp(ptr_reg)) {
> -		EMIT2(add_2reg(0x04, BPF_REG_0, val_reg),
> -		      add_2reg(0, ptr_reg, index_reg) /* SIB */);
> +		EMIT2(add_2reg(0x04, BPF_REG_0, val_reg), sib);
>  	} else if (is_imm8(off)) {
> -		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_r=
eg) /* SIB */, off);
> +		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), sib, off);
>  	} else {
> -		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, i=
ndex_reg) /* SIB */, off);
> +		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), sib, off);
>  	}
>  	*pprog =3D prog;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013171230.5236=
77-1-daniel@iogearbox.net?part=3D14
