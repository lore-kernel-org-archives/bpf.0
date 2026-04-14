Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB878C9C
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776205946; cv=none; b=RZh3hNPLrhadQk9f1/mt1lj1v3muPyTvItfLciTll8iVCvAhu7sGDSnoosjG4fQlE7iuEsRzvvSiUkjK43RRzIAxBFvqjeNh1IkGC6VBFivo9xUaHJGe6+xxeOOTU7imyWCPa996CMMwa+LDguelRY5arqA1knsmkluHzrRiZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776205946; c=relaxed/simple;
	bh=JDjucrccZJ4jaoBl6VRCYs3Pd8PofuPPwCwAw+P1z4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peSC3YgLHm5dWEew/qdMFcpjv7poNvYSotVZQSjbev6P5+zXSSV5ohfJpjY318kYywEk+j8ds6PphLLeN1WIWZjt1cuKhxA7GbDzLy8wwJRsBz2oN6AZ6J+AG/luQnjs+Tak6JDcOFffiK62XJbsbeySkRncQ/H+U5a4rJ8/I8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT6MauOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT6MauOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB55C19425;
	Tue, 14 Apr 2026 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776205945;
	bh=JDjucrccZJ4jaoBl6VRCYs3Pd8PofuPPwCwAw+P1z4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hT6MauOJvf3VHnjdvephnDTAHqpbADVbtYGZXCjPgYX9ktTNMgqIoxJfrRPayPgeV
	 GFZwLoULOwCcWqw1qg3Gf3w4JgbWZzxWZryScqBExiftzM3Lm+QynYjmeHFyKz4rHO
	 6nlsHeYhL11+61w+Vyq7mcxOZNPUe/oVSChJhpRwtXz3D0iRksdCN2MeEjkILgArpi
	 JGgyHI9gctAtcxhhEsG5cLsk71qdi+NcF3aUAb8aKTwdcurCBoeDB13upYiwwReIpC
	 Kyie5SW7XzRhMSUzSdEWJ0XW+7dacF8g/ODCVkDMJxWoumSHEu5KNHoeq+9dVhjwpC
	 Vvj9AbQPo3g3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: Fix up btf/invalid test for
 extended kind
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-7-alan.maguire@oracle.com>
References: <20260414195019.684531-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:32:25 +0000
Message-Id: <20260414223225.BDB55C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The selftest uses a hardcoded BTF kind value of 32 (0x20000000) to =
test for an 'Invalid kind', which introduces test fragility.
--

commit bc86ba6ba24921947f8757ebe8a56756c77195e9
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Fix up btf/invalid test for extended kind

With extended kinds, 32 becomes a valid (but not used) BTF info kind value;
fix up the test to check for the "Invalid kind" rather than "Invalid btf_in=
fo"
message.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 054ecb6b1e9f1..07b1ee0eba372 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -1924,7 +1924,7 @@ static struct btf_raw_test raw_tests[] =3D {
>  },
> =20
>  {
> -	.descr =3D "invalid BTF_INFO",
> +	.descr =3D "invalid BTF kind",
>  	.raw_types =3D {
>  		/* int */				/* [1] */
>  		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
>  		BTF_TYPE_ENC(0, 0x20000000, 4),

Since the reason for extending the kind field was to support more than 32
kinds, does using a hardcoded kind value of 32 (0x20000000) introduce
fragility into this selftest?

Once kind 32 is eventually implemented in the kernel, this test might
spuriously fail. To make the test robust against future additions, should
this use the maximum 7-bit value (127, i.e., 0x7f000000) or another
dynamically guaranteed invalid kind?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D6
