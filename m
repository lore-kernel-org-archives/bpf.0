Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084A1DFFD
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548094; cv=none; b=Hk9UKK2YAsBtEOmf1Yxe7muumxA5Tit9cwL44nXLH5iNZ0FiTrvNxcXGTUwu9dXaPoe0E7fk7ih0RVbv6C443LV3L4UHWYApWWQOpnrmh0WbpApEvKms9CFcOtjCuR+eRiD7c/C7OFI4viNrERGxfgRIBR/JWm5/JDnANnLEHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548094; c=relaxed/simple;
	bh=nLbMCMKhQ/r5qpnQ2hhpRdCzVqVF6gqaAIRA+IEICfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HZfPNCzesGECW47ucI/f6dASMdZKhxzSqgdxHqYdCif0d8alq7f1QUKapXPeJJnHb5KwzmahTHzxBWIdwFSdhXAlcDhkcdeR28ndlzgl6sNcpPzZ7HxxykB64XFrxCASSiay1z7mm98/LYB8xm0A1CsYUYkcHrH8EPH9RiIy4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGmYovDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGmYovDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6081F00AC4;
	Sat,  1 Aug 2026 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548093;
	bh=4f5Uqufa0+WCjDlgNQ65sPstrlUhZA7ykD3K0q9KhAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGmYovDNWVNLLY9ups/rol78sjg0TQyhwL8hhGlDL17owSru/hEO2tByygyzlZfe0
	 CzGHfRSVQByUrSOQnNL9ogzzOmz0DCFzSaHgj6ed/ZtDlsdxJJXyGW/RaItp8ji11W
	 2B/6hOkGLL60gK/Dod1yKTCnoGx+dZ7FwKmS0Vt1TreykXtMiuYAr/5PEvsSWWLqR6
	 QDNJGKaqM+tk2oTPE5VK8HuhfdE0FHSJPcOJwQiLQKXN+8hR7aqNMp9/4gml70S+ok
	 yTKhCifVI7bIdwXxrvDguiXtaNr6QMCL4pfLsr/IrPI0NhhRDRTZoBjsK3+dQxa+dg
	 cDKH/KbeZXtRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] bpf: simplify the bpf_is_reg64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v2-4-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
 <20260731-static-zext-v2-4-da4aa161e8c5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 01:34:52 +0000
Message-Id: <20260801013453.2B6081F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `bpf_is_reg64()` incorrectly identifies 32-bit `BPF_PROBE_MEM` and=
 `BPF_PROBE_MEM32` loads as 64-bit defining instructions, bypassing explici=
t zero-extensions.
- [Low] Stale comment referencing a deleted parameter of `bpf_is_reg64`.
--

--- Patch [4]: [PATCH bpf-next v2 4/5] bpf: simplify the bpf_is_reg64() ---
commit ee97fd37754941b6dd81dccf5f68e7f82c74ea6d
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: simplify the bpf_is_reg64()

This patch simplifies the bpf_is_reg64() function by removing unused
parameters and code paths related to BPF_JMP instructions. It also
streamlines the condition expressions for identifying 64-bit registers.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 6125598d16a84..ac0a388b40218 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -44,6 +44,42 @@ static int insn_def_regno(const struct bpf_insn *insn)
>  	}
>  }
> =20
> +/*
> + * For use only in combination with insn_def_regno() >=3D 0.
> + * Returns TRUE if the destination register operates on 64-bit,
> + * otherwise return FALSE.
> + */
> +static bool bpf_is_reg64(struct bpf_insn *insn)
> +{
> +	u8 class =3D BPF_CLASS(insn->code);
> +	u8 mode =3D BPF_MODE(insn->code);
> +	u8 size =3D BPF_SIZE(insn->code);
> +	u8 op =3D BPF_OP(insn->code);
[ ... ]
> +	/* non 64-bit loads */
> +	if (class =3D=3D BPF_LDX && mode =3D=3D BPF_MEM && size !=3D BPF_DW)
> +		return false;

[Severity: High]
Does this condition miss BPF_PROBE_MEM and BPF_PROBE_MEM32 loads?

Because this check strictly matches the BPF_MEM mode, it seems these other
32-bit load modes would bypass this check and fall through to returning tru=
e.

Could this cause bpf_insn_def32() to inappropriately return -1, skipping
necessary zero-extension for architectures that rely on explicit BPF_ZEXT_R=
EG
patching? If so, the upper 32 bits might contain garbage data, potentially
leading to out-of-bounds memory accesses if the register is later used in an
address calculation.

> +
> +	/* atomics, see insn_def_regno() */
> +	if (class =3D=3D BPF_STX && size !=3D BPF_DW)
> +		return false;
[ ... ]
> @@ -623,7 +659,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_veri=
fier_env *env,
>  			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
>  			 *       here.
>  			 */
> -			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
> +			if (bpf_is_reg64(&insn)) {

[Severity: Low]
This isn't a bug, but should the comment directly above this call be removed
as well?=20

It references a fourth parameter that has been deleted by this patch, which
could be confusing for future readers.

>  				if (class =3D=3D BPF_LD &&
>  				    BPF_MODE(code) =3D=3D BPF_IMM)
>  					i++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v2-0-da4aa161e8c5@gmail.com?part=3D4
