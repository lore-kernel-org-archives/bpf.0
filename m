Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79A3DB316
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389542; cv=none; b=ripq8xl6C5l1jO+O+6Hzpx1oz2qk8HW64qo6S3v73IY7n9taWTrwWID+XtFP4Oy99nmPSJ4wR+Dg6ln3e7zKbf2Zz4mWaz19f/MMrU98c0B8O2WNjJGdY1dhQVhmf1hz38Tb9rsbdUbh+Ebp4PBGkXgDCoPtBXAQ/kQxMV/vjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389542; c=relaxed/simple;
	bh=FNG04f44WqCQliyw/4q0oXm7FC1JT372ShkEDIrYKgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKDkvXS131tWyK5GOFIGbq+1KdIT61quahrjKgZGTW3oklNNEaaUb42MhVaYvbfq0Y0ld9LHAzns1FZ+zbpfndU7N64wOqB94oQPuldY6ktWYIk3lI7zJu/V49BsahVMYtmi283/iuFyxpdtmw5spSXmeZVb/6djHylVsqH0BVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MELyQU31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MELyQU31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5729E1F000E9;
	Mon, 10 Aug 2026 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389541;
	bh=N93d1RNXXzdbHLTdcifY5yFQio8rgVMCrqisPGQPpI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MELyQU31OUNBnJ46GnMMKgT/nMciRyjINEQb1dKMiw2Q2RdaxiI3WaTprs7XmXK/z
	 awfai/3dLD5/xelk3UgZDkCq7YgXd8h0N3HsCNZnh2j/UgAhtgwhNNpdvtczPLH5sy
	 608oOSceW3lyNAoywqgSc5A4loiZi1664pekMYbJ8y6NMsQ8hZtbgw2wbFgjYG1IVn
	 oIKFEhfa2YYD+pFM4Vev5/tCkQgrtzDH36c3Wwqiy6eSW8stRCSQzTls0Zv6sdXGWg
	 ihqHQsfL2HuSI5Bxzbg8If4WpfOWttdxyzwleIYJiLt2Ikkw5BnJCDgmdksfxA1sGz
	 rhxor+bYmpU2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB
 (extended register)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810190922.3408757-3-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 19:19:00 +0000
Message-Id: <20260810191901.5729E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The encoder for ADD/SUB (extended register) fails to reject `UXT=
X` and `SXTX` extensions when generating a 32-bit variant, which results in=
 an UNALLOCATED instruction.
--

--- Patch [2]: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB (e=
xtended register) ---
commit 286e3f9944297bcaa48fe3c90eb0bde9f1e85a33
Author: Tejun Heo <tj@kernel.org>

arm64: insn: Add encoder for ADD/SUB (extended register)

This commit adds the aarch64_insn_gen_add_sub_extended_reg() function to the
insn library to support encoding the extended-register form of ADD and SUB
instructions. It is modeled on the shifted-register generator and uses the
existing IMM_6 field for the option and imm3 fields.

> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index 37ce75f7f1f08..e70ac02385153 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c

[ ... ]

> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
> +					  enum aarch64_insn_register src,
> +					  enum aarch64_insn_register reg,
> +					  enum aarch64_insn_extend_type extend,
> +					  int shift,
> +					  enum aarch64_insn_variant variant,
> +					  enum aarch64_insn_adsb_type type)
> +{

[ ... ]

> +	switch (variant) {
> +	case AARCH64_INSN_VARIANT_32BIT:
> +		break;

[Severity: Medium]
Should this case validate that the extend parameter is not UXTX or SXTX?

The ARM Architecture Reference Manual indicates that for 32-bit extended
register operations (sf =3D=3D 0), the option field values 011 (UXTX) and
111 (SXTX) are UNALLOCATED and lead to an UNDEFINED exception at execution
time.

Adding a bounds check here to return AARCH64_BREAK_FAULT would mirror the
existing 32-bit validation checks in aarch64_insn_gen_add_sub_shifted_reg()
and aarch64_insn_gen_data1().

> +	case AARCH64_INSN_VARIANT_64BIT:
> +		insn |=3D AARCH64_INSN_SF_BIT;
> +		break;
> +	default:
> +		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
> +		return AARCH64_BREAK_FAULT;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810190922.3408=
757-1-puranjay@kernel.org?part=3D2
