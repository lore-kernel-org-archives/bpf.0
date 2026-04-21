Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B232DE6F8
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794792; cv=none; b=kbxx9yd5FrInOAKDfQQayPIDe2Fyjen0qk8fIPrQk6/N8OeChX5taTx6xkiA9OhP4WV0O7lZrZ6IGNppu5q6YqoIx0BZla+PUndIu9WCeejwCJEkjm/EGlHoYjPEvpv2pmXz+/AZ/8QyTcRjZJJ2twP7ZI96iy62pQUzgbEj8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794792; c=relaxed/simple;
	bh=hcQFFF1PrN0XPY+/zAv/1cyKfCndQJKmaImnIOUDDI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0FkbPrgnRpeC+IxkXRWtRLFmdccbRFUyT6CyM9LufHTwlOc4L+utFbPULwEVrJXRDRIre2ea+NpQmSrfDnToCeVQ5w2xgYA3DTHVsu9ryLcR7qMTwl+KCyeKdeRzAzOstjMYC8cbnPJzxWWapbj+UtNVj5pefVN0aW0u5aBOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe75zdXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe75zdXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A44C2BCB0;
	Tue, 21 Apr 2026 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794791;
	bh=hcQFFF1PrN0XPY+/zAv/1cyKfCndQJKmaImnIOUDDI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Xe75zdXhYJsEs2YdLUS6hf1ppj+jum4KiESv1EgZT7o5eH3dgvvQve/eibHX//U3/
	 +3HGzCXpKHV0HO4FuTHCF4pWL6Su+9PGX+t85UV90+AF9skMlWcHbGh+qevP61YdwR
	 mXEF8kIShh2fq+xPdlRQwc+15sNuaO/C8GUWtv6QqcQv3t1KpCpXVtJkcfd3rvGcVT
	 R20pOwHjRDZ5qdFhVvlWtIX4hTbd7EkjQI2/ox9AKloqR9nFNNj1/Z42rsSYKhG/Ey
	 1mp5BGCaukKSlAtrpTZRM27qgwVW4Y6gl1MwyfPzcm0+TIPVSaEI3xOi1Ilefi0Gdm
	 1uexbjfqZaFBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
References: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 18:06:30 +0000
Message-Id: <20260421180631.B0A44C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Incorrect range constructor used for BPF_JSLT (signed less-than), =
causing verifier soundness issues.
--

commit 1fb11732c3d626f4a1777699934aa05d07b7eb56
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: replace min/max fields with struct cnum{32,64}

This commit replaces the independent s64, u64, s32, and u32 min/max fields =
in
bpf_reg_state with two circular number fields, cnum64 and cnum32. It also
refactors how bounds deductions are performed and updates conditional branch
refinements to use circular numbers for set intersections.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e896f5d92a2d..90ed32f064650 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bpf_reg_=
state *reg1, struct bpf_reg_state

[ ... ]

>  	case BPF_JSLT:
>  		if (is_jmp32) {
> -			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), reg_=
s32_max(reg2) - 1));
> -			reg_set_srange32(reg2, max(reg_s32_min(reg1) + 1, reg_s32_min(reg2)),=
 reg_s32_max(reg2));
> +			lo32 =3D cnum32_from_urange(S32_MIN, reg_s32_max(reg2) - 1);
> +			hi32 =3D cnum32_from_urange(reg_s32_min(reg1) + 1, S32_MAX);
> +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
> +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
>  		} else {
> -			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax(r=
eg2) - 1));
> -			reg_set_srange64(reg2, max(reg_smin(reg1) + 1, reg_smin(reg2)), reg_s=
max(reg2));
> +			lo =3D cnum64_from_urange(S64_MIN, reg_smax(reg2) - 1);
> +			hi =3D cnum64_from_urange(reg_smin(reg1) + 1, S64_MAX);
> +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
> +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);
>  		}
>  		break;

Are the unsigned range constructors cnum32_from_urange() and
cnum64_from_urange() correct to use here for a signed less-than comparison?

Passing S32_MIN and S64_MIN into the unsigned constructors might cause them=
 to
evaluate min > max, resulting in invalid or empty ranges being intersected =
with
the registers. Should these use cnum32_from_srange() and cnum64_from_srange=
()
like the BPF_JSLE case does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421-cnums-ever=
ywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com?part=3D3
