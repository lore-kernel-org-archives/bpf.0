Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1252F12E
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183892; cv=none; b=t7Eam1y36mBSzv2eiZ8eDtVXzfvOYSJcLF7ma21CEgnZsTm2vj6tD+MaTkGY87Gpa94YWvjyQ5TZDHUdAbjjP1hkWKCj1+hdMFeajGPi5WzgprMcZAFhYLe4TTOWpVyBBP2U306EyouTttt+i8X6JoV5eHc3Jc+Q4XXHLgdqS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183892; c=relaxed/simple;
	bh=g6pQPHncZpT85Ujw+LjzGUWASkzhj1+KQQmPLkxDfyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dco+pmbaituPDnFubiUqwzpcPqBJeW5YwPfdieN9NMVdOxn1XZLYhvTAj42c4LX3yJSz8H6mR3HjJ5l9vFNujvBKIvdbLF1gVwgGCdKTnfv4aOCga4n80aTYJL1XQzEZD1dDUE/EJKjQfS9eTvY9h9osxC2H0Mg7IlDeF5alztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS5S8AiM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS5S8AiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680941F000E9;
	Mon, 31 Aug 2026 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183890;
	bh=sWAf7a3qoF8lGO1IR5+UpedhK7j6M4K4hqF5siKvFIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NS5S8AiMtUV5XSYqIvBrGfcGI0xfZ5r+ysSZ9sZ3U9a0E6k7BaXWY9PZCXSvcmOfK
	 HRMrhZxPxMLeMrC+5cXG2ApiUQgtPbUOhTeLwGYJiqePbuoP3IO8E6433TdSyr3ur1
	 uek6GNsWs9d9L1mV1h2Zi2XhcKXaB8qNpaAdt3Agr5xy2m0IS1x2W9V3yINtzOfRrD
	 4KePsHXFpHlxPzBAPQXoZ9fk42LYZIRh+WPpnstoPlivDx7fGYs3x6cTczC9uW5KIb
	 wNFLJc96oO6+CMKEfXcazS+GRfBSXbOPyB5riF5ZSLZ3tGc51cV1K2RY1pCGN2W8iH
	 9G0PZfaIKToIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence
 in bpf_program__flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831132648.65843-2-toke@redhat.com>
References: <20260831132648.65843-1-toke@redhat.com>
 <20260831132648.65843-2-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:44:49 +0000
Message-Id: <20260831134450.680941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing NULL pointer check on the result of bpf_object__next_pro=
gram() causes a potential test crash.
--

commit 357b58adee859a9375d4063d6f64aa4a923e7790
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

bpf: selftests: Check for flag presence in bpf_program__flags()

This commit adds checks to verify that the BPF_F_XDP_HAS_FRAGS and
BPF_F_SLEEPABLE flags are correctly exposed by bpf_program__flags(). It
introduces assertions in multiple selftests immediately after retrieving
the BPF program structures.

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
What happens if bpf_object__next_program() returns a NULL pointer here?

The prog pointer is passed directly to bpf_program__flags(), which
unconditionally dereferences it. While the object file is expected to conta=
in
programs during normal builds, if it does not, could this cause the test su=
ite
to hard crash with a segmentation fault instead of failing gracefully?

Prior to this patch, a NULL prog would be handled more safely, as the later
call to bpf_program__fd() explicitly checks for NULL and returns an error
code.=20

Does it make sense to add a check like ASSERT_OK_PTR(prog, "prog") before
accessing its flags?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831132648.6584=
3-1-toke@redhat.com?part=3D2
