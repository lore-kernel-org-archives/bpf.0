Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C433F4DD0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641956; cv=none; b=Y0mng7/dKFQeT3pBwU5tossek/ToHvgtuKgcrC8Qu7Go5bxdQ4CCEqty9RwafHqOURpaj80Ilvs4bqJ3YLbCiFOcmEXahRoNBrOm12p6XfJyHDv6B8/2vfOeWSc3WOulowhsXKgghtPr7TPEAVuBgWdVxuX81P5mddbKiO2BBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641956; c=relaxed/simple;
	bh=EW07pdor8tRDVVoEW86JaIKSo+iFvIoBguY1ofdNHtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jcd8pIX4NLaEkSVD69oQXCU69Qv3wUCk9NzZJQStIYXt5L7AjHr2LoJfWQMIoDx8z2oM8tFZAQf7p6+4IbUPGKxJpIvJJl4kAGGIDVOPn5PLTyuTH1piN5ZS2Tcarsn7+ToDbVjpv9MUviAgNgH4H1zGunhh3z0XnMPRA38VofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLQ4M15I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLQ4M15I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467DA1F00893;
	Fri,  5 Jun 2026 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641953;
	bh=OBvKEBhd1KnqDSy4UCCV/LF/X+PtMY0+zmzypfxB8MU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GLQ4M15IJ75/sjPTotXP4+HZj/OUIFCaSgVBMHON4Hmeheu/YyAHuLvQA1b+FqDYe
	 e+Jr91Tg+RiFuN4jKlW43NvluiOXv+9cJUyVt+SOhtfq2h2P8pZipafA6+mKXl2s5g
	 Ut6N1DxncjzcEScQorQXMMEkeJ8kbQM13mLB9IxwZmgxTsPCdLfDu6i6miuAyiHl0/
	 MWeeAdRq4FeDscMENxOaudlVEH2qnjjFjmAnMaMEMFbQ1uO2N+VgONdOShyd6m2q1X
	 ZqfzgyfMnPuBVoeVpouLe/Igt+fM0OoVIVhWGBZ0Bcv3XGnCIInAtTlLSDRl9Q1htq
	 LkD8/hcFVDIPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/17] bpf: Report Memory Safety bounds
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-10-memxor@gmail.com>
References: <20260605063412.974640-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:45:52 +0000
Message-Id: <20260605064553.467DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Diagnostic message for `BPF_DIAG_MEM_NEGATIVE_MIN` prints a larg=
e positive number instead of a negative number when `reg_smin(reg)` is `S64=
_MIN` and `off` is negative, due to signed 64-bit integer wrap-around.
--

commit 176ba692cb9724623bf456ca5401c93a61c5ea8d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Memory Safety bounds errors

This commit augments check_mem_region_access() range-proof failures with Me=
mory
Safety reports. The existing terse verifier messages remain in place for
compatibility while the new report adds the failed proof, source context,
causal path, and guidance.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 920ac17758c20..0abe1ab19d252 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> +void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_i=
dx,
> +				int regno, const char *reg_name,
> +				const char *type_name,
> +				enum bpf_diag_mem_bounds_kind kind,
> +				int off, int size, u32 mem_size,
> +				const struct bpf_reg_state *reg)
> +{

[ ... ]

> +	switch (kind) {
> +	case BPF_DIAG_MEM_NEGATIVE_MIN:
> +		scnprintf(proof, sizeof(proof),
> +			  "The smallest possible offset is %lld, below 0",
> +			  reg_smin(reg) + off);
> +		break;

[Severity: Medium]
Will this print a contradictory positive number instead of a negative one w=
hen
reg_smin(reg) is S64_MIN and off is negative?

Looking at the caller in check_mem_region_access(), it triggers the
BPF_DIAG_MEM_NEGATIVE_MIN diagnostic if reg_smin(reg) =3D=3D S64_MIN:

kernel/bpf/verifier.c:check_mem_region_access() {
    if (reg_smin(reg) < 0 &&
        (reg_smin(reg) =3D=3D S64_MIN ||
         ...)) {
        bpf_diag_report_mem_bounds(..., BPF_DIAG_MEM_NEGATIVE_MIN, ...);
    }
}

If off is negative, reg_smin(reg) + off will underflow S64_MIN and wrap aro=
und
to a huge positive number like 9223372036854775807. The diagnostic output m=
ight
then read something confusing like:
"The smallest possible offset is 9223372036854775807, below 0"

Unlike the max bounds case which correctly handles wrapping, the min bounds
case appears to evaluate this unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D9
