Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EE3B52FE
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411520; cv=none; b=frwS55paHTvBn6DRyMeXL1HAf3tAc/fokQRbWxnjacEtpMT4qSG26WTF2vfu7XyPjW+lKBzwUilmlQIgQrYH9wH+4mFfhhdq2r3X1Z2UYXiu0for8cjaS/B6COJ4cb0yqx40Eo1WwH8kyHtjLz3gQRo7YDwdFz71dQiI/dp1ECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411520; c=relaxed/simple;
	bh=rY5EfCMgXzCeUQgzMVbghzxGoo1P1KQkynKve+Sv1Pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i+DwhR+MFmY1roHfzN8y1CjsfKLrcF9IuTMWDws5O6HM14oqr4CQtqyN0OFkQrDnnPMp310CkvkMBFNho4wYyzG/SnKBl9AzyK/7FXRAgpS4TZ5BWcW2YMUYzf3iFrDpoARQ3z7n45pTTGBw/AZQjbz1WzvvRrqcv9J9sGuBv44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqOwnaAf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqOwnaAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C861EC2BCAF;
	Tue, 28 Apr 2026 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777411519;
	bh=rY5EfCMgXzCeUQgzMVbghzxGoo1P1KQkynKve+Sv1Pk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eqOwnaAfRd2OFe5lc4619SWrwGw6EDGt5ThBIRJOV7BypjIHxW9abzi1HWcgfdR5T
	 bbiuItKzazQ4FhRDB0QTfRIRFIwFJanI1UrtWggwB9+HizayEa8KhUMDQDL1OjfmPI
	 /nEB+1TnyxXHx4Yu5DYooAfHYZ7eFObGiY2tF2csXGcp/HEmWavZDrHui4p0LisFCC
	 kAoThTuiirQOigzzbXfgOHZtQu5TKjO17BSYnhfFIuPOX4Co/+8snAz5hcOQEMEPWx
	 VXOX8uJpX4a4n4Ujom6kQXDcxyTXcLo+06jFGXoCV6OcbkxwvJuYR5AbmWKmNS2nZc
	 CyLj9DPixsFLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] LoongArch: BPF: Inline
 bpf_get_smp_processor_id() helper
Reply-To: sashiko@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428072021.7289-4-yangtiezhu@loongson.cn>
References: <20260428072021.7289-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 21:25:19 +0000
Message-Id: <20260428212519.C861EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The inlined `bpf_get_smp_processor_id` helper uses a sign-extending=
 load (`ldw`) instead of a zero-extending load (`ldwu`).
--

commit 537ce2d4859db91089b968d6b560566858b53b6f
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Inline bpf_get_smp_processor_id() helper

This commit inlines the bpf_get_smp_processor_id() helper into a single
load instruction on LoongArch. It accesses the thread_info which is always
available in the thread pointer register.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index b93b67d22c26..b1c6194c4099 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -1154,6 +1155,12 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
>  			break;
>  		}
> =20
> +		/* Implement helper call to bpf_get_smp_processor_id() inline */
> +		if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_get_smp_proces=
sor_id) {
> +			emit_insn(ctx, ldw, regmap[BPF_REG_0], LOONGARCH_GPR_TP, TI_CPU);

Does this code need to use a zero-extending load (ldwu) instead of a
sign-extending load (ldw)?

The C implementation of bpf_get_smp_processor_id() returns a u64, meaning
the 32-bit smp_processor_id() result is zero-extended to 64 bits.

While CPU IDs are small positive integers so sign-extending and
zero-extending produce the same result in practice, using the
zero-extending ldwu would strictly match the BPF calling convention and
original C helper semantics.

> +			break;
> +		}
> +
>  		ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
>  					    &func_addr, &func_addr_fixed);
>  		if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428072021.7289=
-1-yangtiezhu@loongson.cn?part=3D3
