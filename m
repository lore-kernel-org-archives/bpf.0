Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564447254E
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252966; cv=none; b=ciW/slGlDlQf0yl3CZkk/MZhVkxiypeVPuDbKChzFNSd6jVYu7r6yQYce/nBJslr32UxAO7aoWevQxE+2bQVdUyXFxUN1j+nuMxnWffZzw79/Y2X8+r7m1Rzyga1aZhy1G1FVr1KUTB4pG8wRQ5b9DFeX/hedEtrzzr1I5d+sTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252966; c=relaxed/simple;
	bh=oqElCxMgfCFVBOuEbq8gOvFtkB6FIDBaYC0wyUm7aQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=du0/lf/X4nV0LGeHUnRAUKzyyWUmNm5gVuqzbP+ETpR2+PiAAjB65vrvcxZxglyfVgil+WCcnXzS85za7LxK4Usl9OqWYmTL0bcDwSgd6mR4mHBRnTrGInA9Pz+fuO7cSoBVye456oGzf7YUg+Ae0ckr+QdpzpbkVj3K8bTNGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBoz/o+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBoz/o+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0076E1F000E9;
	Tue,  1 Sep 2026 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252964;
	bh=ehHoIcIuv4tVCrCcHUmbJ3P0f1UHhP66mqt4wo5kjuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kBoz/o+czy95aEyPyGSedYBApA7B9hDcR+FC3EBu6Ao9vL09ZbBlssc9vJnbvnSkd
	 rPhL/GxGnctouseMXyrxfOMnL/l9e03wGfaJ3PJA1h0C+BSTFFBHVNX5JtvlxFtyma
	 eBoJR69p5CfiT0zP+W7OyRqjeDSdp94TiOF5ndDU46XzbXHf5wa0xrrt7eEeLxOuzL
	 BbyjNFZxWo/SarI3DrLMKslq27B1jXztEIarcjyQhOZtL5vAFwggFJ2HyDvVHOIbUJ
	 LV6WWW8XEGiNOfSNJLLt2a1Y1bni+IdbThHgOHCTVJEk63v2rIwyF6Rfxu4lBQZzzr
	 DjIkftD28QUeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Check for flag presence
 in bpf_program__flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901-libbpf-frags-flags-v3-4-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-0-4eb6f14968b0@redhat.com>
 <20260901-libbpf-frags-flags-v3-4-4eb6f14968b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:56:03 +0000
Message-Id: <20260901085604.0076E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL check for `prog` before calling `bpf_program__flags=
()`.
--

commit 05df19ea2fe700cefa5c96da6572795ffbe95855
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Date:   Tue Sep 1 08:46:57 2026 +0000

selftests/bpf: Check for flag presence in bpf_program__flags()

This commit adds assertions to verify that the BPF_F_XDP_HAS_FRAGS and
BPF_F_SLEEPABLE flags are present in bpf_program__flags() when opening BPF
programs that have these flags in their section definitions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> index fce203640f8cf..a894b1ab46f4e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
> @@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
>  		return;
> =20
>  	prog =3D bpf_object__next_program(obj, NULL);
> +	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
> +		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
> +

[Severity: Medium]
Is a NULL check needed for prog here?

If the BPF object file test_xdp_update_frags.bpf.o is valid but contains no
programs (for instance, due to a build issue or a stripped ELF),
bpf_object__next_program() will return NULL. The prog pointer is then passed
directly to bpf_program__flags(), which will unconditionally dereference it
and cause a segmentation fault in the test suite.

Prior to this patch, prog was safely passed down to bpf_program__fd(), which
gracefully handled the NULL by returning -EINVAL and failing the test clean=
ly.
Would it be safer to check prog with ASSERT_OK_PTR() before attempting to
verify its flags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-libbpf-fra=
gs-flags-v3-0-4eb6f14968b0@redhat.com?part=3D4
