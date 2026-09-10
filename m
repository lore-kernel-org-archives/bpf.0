Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725939FCBF
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058094; cv=none; b=I7meFw9YBA0AmC/EXaoAcdcuZManknKLC4538t32zYmZ6Cv4+iVnxjyh/TZNO6hHH1s91ugA6PM/jxRBd1ggz/UiKuQKjo66HQ/rxiNZN/AjQPac35kbrc3lhS4oHwGRTIcBx3R7lFbmDTav0qmxifOMmh9QGPsTZ2EPTdlH39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058094; c=relaxed/simple;
	bh=X9Iy7hSBE5pCV8p/t9zK4mUsU/nW08NRiITj2SOEF6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZyJT411fqlod774wZTqPAlrLA0KFbymAA/tQ6rPE5hPYBoTbicXn04pLwLQu09ITS7PeetrjzFNkvejRCgMxj2AdL9WftGN6eQZXyuVUCWEl/2eI2lnUHlBz5MKVHNKkXZS0M2Ed4cdPPenY1HEOV6iZ5qzFGTpm4f8myPH30IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JshJs5yg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JshJs5yg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220CC1F000FF;
	Thu, 10 Sep 2026 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058092;
	bh=CIfFMcpG8JjysrWJS30E/IhNCbV3F7kV413t3UD22TQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JshJs5ygXgUt1gUh83Glz9FTm+ZVSGv3h2ZVN9ue7zXuPjsRuiHKjnt0cZwVRFzGM
	 kNHRAD5blXt/sXw4LTJuOEvSf+JSdFbra5tVhpgC33ikBsaWTg1TPYgxolf7pKuavS
	 BMNRCHK22Ynl+nW5/BOp1ra0hTOU/BTIRKT22Evm5n5h+I2CNEX6Y5lN48iR63vMPr
	 5yv6TIGHiM/Sm7HxnCGXe8RFXVNTV4Ku/D5m5ATk99LbdDVn6YQLqTWOHRF569gFtj
	 DPsDYuBxWIW7a7lRiYPLlq79nGgEuMo7dQUyVz5X6inyJP+Q+LhRRi6v4si/iTbTjV
	 t+LPX+Zw7SvqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/1] xsk: use a 32-bit compare in xsk_map_gen_lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
References: <cover.1789056660.git.zhilinz@nebusec.ai>
 <7d2cb8e8dfaa9eb8fdff85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:34:51 +0000
Message-Id: <20260910163452.220CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses a 64-bit sign-extension bounds check bypass in=
 `xsk_map_gen_lookup` by replacing `BPF_JMP_IMM` with `BPF_JMP32_IMM`, but =
fails to apply the exact same necessary fix to identical vulnerable pattern=
s in `kernel/bpf/arraymap.c` and `kernel/bpf/fixups.c`. `BPF_JMP_IMM` sign-=
extends its 32-bit immediate argument to 64 bits before performing the comp=
arison. A `max_entries` value >=3D `0x80000000` becomes a large negative nu=
mber in a 64-bit context, meaning the unsigned `BPF_JGE` check against a ze=
ro-extended 32-bit index will never jump, skipping the bounds check entirel=
y.
--

commit c7773394d23ffdacd886a0d61cfe827025fc2bfb
Author: Zhiling Zou <zhilinz@nebusec.ai>

xsk: use a 32-bit compare in xsk_map_gen_lookup

This commit fixes a bounds check bypass in xsk_map_gen_lookup() by
switching to a 32-bit compare for the max_entries check. BPF immediates
are sign-extended to 64 bits, which previously caused large max_entries
values to become large negative numbers in a 64-bit context, bypassing
the bounds check.

Cc: stable@vger.kernel.org

> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index 3bff346308d0f..bf00d6463c191 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -124,7 +124,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, st=
ruct bpf_insn *insn_buf)
>  	struct bpf_insn *insn =3D insn_buf;
> =20
>  	*insn++ =3D BPF_LDX_MEM(BPF_W, ret, index, 0);
> -	*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
> +	*insn++ =3D BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);

[Severity: High]
This is a pre-existing issue, but while you are fixing this sign-extension
bounds check bypass here, should the exact same fix be applied to identical
vulnerable patterns in kernel/bpf/arraymap.c and kernel/bpf/fixups.c?

For example, in kernel/bpf/arraymap.c:array_map_gen_lookup():

	*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
	*insn++ =3D BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
} else {
	*insn++ =3D BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
}

The same pattern exists in kernel/bpf/arraymap.c:percpu_array_map_gen_looku=
p():

	*insn++ =3D BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
	*insn++ =3D BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
} else {
	*insn++ =3D BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
}

And also in kernel/bpf/arraymap.c:array_of_map_gen_lookup() as well as
kernel/bpf/fixups.c:fixup_bpf_calls() for tail calls.

Since BPF_JMP_IMM sign-extends its 32-bit immediate argument to 64 bits,
a max_entries value >=3D 0x80000000 becomes a large negative number in a
64-bit context.=20

This means the unsigned BPF_JGE check against a zero-extended 32-bit index=
=20
will never jump, skipping the bounds check entirely. For array maps with=20
bypass_spec_v1 =3D=3D true, does this completely bypass memory bounds check=
s?

Similarly, for tail calls in fixup_bpf_calls(), does this bypass the
architectural bounds check and defeat the speculative execution mitigation
since the bound check branch is never taken for out-of-bound indices?

>  	*insn++ =3D BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_sock *)=
));
>  	*insn++ =3D BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, xsk_map=
));
>  	*insn++ =3D BPF_ALU64_REG(BPF_ADD, ret, mp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7d2cb8e8dfaa9eb8fdf=
f85156987a60960787dc3.1789056660.git.zhilinz@nebusec.ai?part=3D1
