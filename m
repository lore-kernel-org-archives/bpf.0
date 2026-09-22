Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301D372B4B
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040434; cv=none; b=dQqJq8zMp/+LN0iCL3ERjtb0DVYii8yI3tB2MaLihSdTR3xIVnzd3L7tyYM3a/v4d0SPeOqdEI2rXGPZq3uc9DO46u+4Ahwssxkx2zFW/mlBL6jrvObhhqW8Oy7+UkWtTaBpqw2u0neiQ1SaRHoP9K3Nl2QLkGOsJqD/HfsJd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040434; c=relaxed/simple;
	bh=SxCDKT5k+bRqAOGzOHBytWT+vwnS4e6PngbRaPRUHaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GpgEABo7ZLuQFeXzCJIn3pQhfBhKCspeyOXrHPYofiRgtmhjEBV6IWlHFyF1TUvCX3WdYlchGo2eUASoS81yH4VmgP4y0J7XH1mYMgSiTcr0gsKYs+IcZThiCnkB2ANLJ7q63Ra8ofhPZbGdzBcAVkKoiwsFupHMD+xiiQ0C/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7NEENBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7NEENBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B21C1F00893;
	Tue, 22 Sep 2026 01:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040432;
	bh=ehYGfBPKc3BSdUklUAY02wSJrVw7M8twDOfauG5/DgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7NEENBu5/XdNEu8tOM50fZlXuLJdwAadwQ+IZKjFTnYi2qaoN7/+NOqZpcW4bzc7
	 myZ17/OPYyYs59VmdFt3y1xE9GdTuUNqEcmxEfVOJ8frBgrtyBCJ6W50iwDzhrCDQ7
	 xRr/w/ydtAWSwUViGE+oEyqzv5eT3QayOKCRjaDKPjeTtLR9wvvIS6Fv7KHgRViLEA
	 a41VfUjNwsdr2u3OYuzgOJrpJEvOXE9QRPiL+myC8VjIB0IbxvR6o+m6ZetU+B/xat
	 1NxEg5FT2Lj9iU29aeMLRxKBWc3b7xAt2pSF3/w/nijK2vclZy7eRbVIq/+Km6kqci
	 I5CDoCCGmR6zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 07/17] bpf, x86: Add JIT support for callx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922011323.1298619-8-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
 <20260922011323.1298619-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 01:27:12 +0000
Message-Id: <20260922012712.6B21C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: callx bypasses KCFI due to missing caller-side hash check
--

commit d4dfd1b46a3e02ea97924c833ac04239e01627f1
Author: Alexei Starovoitov <ast@kernel.org>
Subject: bpf, x86: Add JIT support for callx

This commit adds JIT support for BPF indirect calls via the register that
holds the address of the BPF subprog. It introduces the emit_indirect_call
helper to handle the translation using ITS or retpoline thunks.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -749,6 +749,46 @@ static void emit_indirect_jump(u8 **pprog, int bpf_r=
eg, u8 *ip)
>  	*pprog =3D prog;
>  }
> =20
> +static void __emit_indirect_call(u8 **pprog, int reg, bool ereg)
> +{
> +	u8 *prog =3D *pprog;
> +
> +	if (ereg)
> +		EMIT1(0x41);
> +
> +	EMIT2(0xFF, 0xD0 + reg);
> +
> +	*pprog =3D prog;
> +}
> +
> +/* call *bpf_reg */
> +static int emit_indirect_call(u8 **pprog, int bpf_reg, u8 *ip)
> +{
> +	u8 *prog =3D *pprog;
> +	int reg =3D reg2hex[bpf_reg];
> +	bool ereg =3D is_ereg(bpf_reg);
> +	int err =3D 0;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
> +		OPTIMIZER_HIDE_VAR(reg);
> +		err =3D emit_call(&prog, its_static_thunk(reg + 8*ereg), ip);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
> +		EMIT_LFENCE();
> +		__emit_indirect_call(&prog, reg, ereg);
> +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +		OPTIMIZER_HIDE_VAR(reg);
> +		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
> +			err =3D emit_call(&prog, &__x86_indirect_call_thunk_array[reg + 8*ere=
g], ip);
> +		else
> +			err =3D emit_call(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], i=
p);
> +	} else {
> +		__emit_indirect_call(&prog, reg, ereg);

[Severity: High]
Does emit_indirect_call() emit raw indirect branches without KCFI hash
validation?

If KCFI is active, it seems __emit_indirect_call() emits a bare indirect
branch instruction without the preceding caller-side hash check.

If an attacker were able to overwrite a spilled subprogram pointer, could t=
hey
trigger this execution path to jump to an arbitrary kernel address and bypa=
ss
KCFI protections?

> +	}
> +
> +	*pprog =3D prog;
> +	return err;
> +}
> +
[ ... ]
> @@ -4414,6 +4472,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
>  	return prog;
>  }
> =20
> +bool bpf_jit_supports_callx(void)
> +{
> +	/*
> +	 * FineIBT poisons ENDBR at the entry of a JITed function and expects
> +	 * indirect callers to go through the CFI preamble instead.
> +	 * callx doesn't do that yet.
> +	 */
> +	return cfi_mode !=3D CFI_FINEIBT;

[Severity: High]
Can bpf_jit_supports_callx() incorrectly allow indirect calls to be compiled
when KCFI is enabled?

The current logic blocks FineIBT but permits compilation when the CFI mode =
is
CFI_KCFI.

Since emit_indirect_call() does not currently emit caller-side hash checks,
allowing compilation under KCFI seems to introduce uninstrumented indirect
branches into kernel space.

> +}
> +
>  bool bpf_jit_supports_kfunc_call(void)
>  {
>  	return true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922011323.1298=
619-1-alexei.starovoitov@gmail.com?part=3D7
