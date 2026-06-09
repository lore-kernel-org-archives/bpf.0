Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB63341062
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017694; cv=none; b=Sl1w/GHvzxZ4JMBLV37jGrZPI5sjunUMKBylXOGnWzkbGstcB69OXOgEi1rnr+oRIBFXOzSrGmfUjll4qjs2+CplE7vzowxcSus+4uBrXH42JJWcUq+XVf7enI0FBf2OP20JKdj+zgoPTBsHb8CHKdqd+FEknM2/6ZWtDqe/1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017694; c=relaxed/simple;
	bh=o4BkTr9793bjq7EpNhsjKTlQqZ70r9EvtSYnZ8R2KOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mbg9VTA7+k35UMgYj3BFQaKFothVfNuouTf5Jd/zRMVvoQFZhRUNLrFlX6dYDcDc3mnUSUy/y+nx0VBDO0B9fdeJho6xDxRQ5mDxvdZE3Kb5+2GGGeEsUUahR2iyhGoPsTRQzvU3E1OuGY5PkTkRwXqd66C0n2uq0sOIIEO58Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Inwb9xTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Inwb9xTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387981F00893;
	Tue,  9 Jun 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017693;
	bh=XaiVkTAGjszZUV/XZUSjht8kXMxZUDDMXiTk0yYVRV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Inwb9xTN6WjjTCJag5JKlrHd/ZtfS8VW5lNy8aP2DxoCSAUX5xOccCz/7diNfh6h9
	 K5zqF2K/tAJsSRF0djucRDYyJlcRzp/7NZREtR9IxkzF/5pcPfOFYylwqkuKtMTJJ+
	 U9fIDSAXYO8fxMd1tJxdMvuk2sWes/x+a0wJrQI64gjg3RKn4bJIYzNcVTj3aDpAv3
	 EHGoz+OPIuu3VIE8ID3CzdhbBrncyIbIZW/uZLRNGlcyCZp1I9KE1tLqs8CHwf2XA3
	 E8PwABe2cv1FusF9JU+vhrDu9thU9cQed0fiiWJ5zzRdYcsSzIYsIPlnoHoahKhWlE
	 /86xKf/95TYXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover scalar addition from
 rdonly untrusted memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-2-e6212e274155@mails.tsinghua.edu.cn>
References: <20260609-f01-03-scalar-add-bpf-next-v1-2-e6212e274155@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:08:12 +0000
Message-Id: <20260609150813.387981F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly added selftest only verifies the rejection of `BPF_ADD` w=
ith untrusted pointers, missing coverage for other vulnerable ALU operation=
s.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the verifier=
 incorrectly allows scalar operations (like BPF_SUB, BPF_AND, BPF_XOR) with=
 untrusted pointers, leading to arbitrary kernel memory read/write vulnerab=
ilities.
--

commit f35b72689eaa4c1dd4c68b268d4611d79f672994
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover scalar addition from rdonly untrusted memory

This commit adds a BPF verifier selftest for scalar addition with
rdonly_untrusted_mem. It checks if the verifier properly rejects adding an
untrusted memory value to a scalar destination.

> diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/t=
ools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> index 5b4453747c230..303b8ed3e70b6 100644
> --- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> +++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
[ ... ]
> @@ -77,6 +77,23 @@ int offset_not_tracked(void *ctx)
>  	return s;
>  }
> =20
> +SEC("socket")
> +__failure
> +__msg("R1 tried to add from rdonly_untrusted_mem to scalar")
> +__naked void scalar_add_not_ok(void)
> +{
> +	asm volatile ("r1 =3D 0;"
> +	"r2 =3D 0;"
> +	"call %[bpf_rdonly_cast];"
> +	"r1 =3D 0;"
> +	"r1 +=3D r0;"

[Severity: Critical]
This is a pre-existing issue, but the verifier incorrectly allows scalar
operations like subtraction, bitwise AND, and XOR with untrusted pointers,
leading to arbitrary kernel memory read/write vulnerabilities.

In kernel/bpf/verifier.c:adjust_reg_min_max_vals(), the check explicitly
tests for addition:

	if (opcode =3D=3D BPF_ADD &&
	    base_type(src_reg->type) =3D=3D PTR_TO_MEM &&
	    (src_reg->type & PTR_UNTRUSTED)) {
		verbose(env, "R%d tried to add from %s to scalar\n", ...);

For other ALU operations, the verifier delegates to
adjust_ptr_min_max_vals(), which returns early:

	if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM &&
	    (ptr_reg->type & PTR_UNTRUSTED))
		return 0;

This early return bypasses all opcode validation and leaves the destination
register unmodified as a scalar value with its original bounds. At runtime,
the register receives the result of the pointer arithmetic and can be used
to bypass bounds checks.

Could the verifier be updated to properly reject all invalid ALU operations
on untrusted pointers?

[Severity: Low]
Is it possible to expand this selftest to cover other ALU operations?

Because the verifier code currently ignores operations other than addition,
adding tests like scalar_sub_not_ok or scalar_xor_not_ok would ensure these
operations are also correctly rejected and expose the missing verifier chec=
ks.

> +	"r0 =3D 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_rdonly_cast)
> +	: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-f01-03-sca=
lar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn?part=3D2
