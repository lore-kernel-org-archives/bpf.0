Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936847;
	b=rVRsUtzd+YX2bAjuk2uR6wjV7JQIoYrpRihxQvm0OMJ/iUuGfgW+msRQVT7ORY33BWD5
	 4Zrjnu0V4sJuQwn6UAvX3ZHHPCGJvu9ZpIYlRC6cKP1OI80Qn7rFauQ38myO1++8JcbLs
	 nIKF9Y9JMFgKFdJGnzTAWNjnzjceSPh8/frxCF6JmEfLxSbbn35XfGuO+XjVpcq0VBVYU
	 OOfZjvVFC+WtIKarpKxRHyj+8kD5P66Ig7RedhV7ka/S4ahAVXb/dz0C9euSnUdpshXCR
	 mm6X1dNY/jJ/fneQl6jiNBJ2PKIcJnUgT9B00O0+SWhF3b9yDoj00bQyihDBdUUjVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936847;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KSEliCBKFQDlUzmaiONudogZ5dbLDLiz4TEYZErAMiA=;
	b=2lqTB8JriSj8EmWIOL83s5isT1dWO49ewwF1jLu9/y2KifuGj/DJFUIysVTCqVLtY9Y6
	 VjRE9IvIfO4CT3MkzxXMyoxUHZiDzdZ9VqYV8CssZyRsOgxIKmXbWdXwbpTXmIJ3MSeQm
	 x/q3L6tnbnIMDB+cmUu4/GcdBceYJXsWxJLeiITXl9VkI6cGmGDeHpFt7nurEAwisy1hI
	 /+uZp8pB5vsNq17Ej1X9724z65CzJVJtw3xsaWopm+6uGE+BKPmgjC6wj1b7uGWya+7M7
	 dfTIQ3FNL4+fqx2bqouuDIuzzQHPjIpu24s1PnMXOMGgWktoXRukGCuzrmEz1GVNgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+vEfZTg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2D606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+vEfZTg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB961F000C5;
	Tue, 17 Nov 2026 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936847;
	bh=KSEliCBKFQDlUzmaiONudogZ5dbLDLiz4TEYZErAMiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+vEfZTgGjnIKYyYctxWInjGSvlnsrS1lV50J1oW8zRFBN1Eaj8ZmZhQu6Bz9jPKl
	 cclfMqNaoLBNkiwZm4u0yFEDYA7HGU2lJQbFpOs6405zMlOiQ6Kb9DKj1KJ3zJnuTz
	 Ng/mT2I7lDCO0P0IygFSXF5UQ6uU33RF6XdRHIdnvrtVOujMmw1BJuyElbK6vTwHvh
	 irzdq9oJylG9s320Jg3RHoAMGl3u8pRxfUgoVWYLVJvN5DxRokBQZBOPDqbkZ1l1ds
	 nCNZxTwQzh9kQJw8QEUCJ++1ZCwgEPkX0LM5DZsflJdghvzOhrq1CYOjm2/rHZ3Hps
	 zobdLT9PxXxjg==
Message-ID: <sashiko-outbox-219240@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261117172341.3152407-1-ryan.roberts@arm.com>
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:34:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: non-standard multi-line comment style in ___bpf_prog_run()
--

commit ac6a06b7dc1000d82907323434c2003bed5a8873
Author: Ryan Roberts <ryan.roberts@arm.com>

arm64: Mitigate Spectre v1 in the BPF interpreter

This commit renames spec_bar() to barrier_nospec() on arm64 so that the BPF
interpreter emits a speculation barrier for BPF_NOSPEC, while avoiding
unnecessary barriers in uaccess paths where user pointers are already maske=
d.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fc8b133c15f90..adf7ba0cdb06c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2251,14 +2251,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct=
 bpf_insn *insn)
>  	/* ST, STX and LDX*/
>  	ST_NOSPEC:
>  		/* Speculation barrier for mitigating Speculative Store Bypass,
> -		 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
> -		 * rely on the firmware mitigation as controlled via the ssbd
> -		 * kernel parameter. Whenever the mitigation is enabled, it
> -		 * works for all of the kernel code with no need to provide any
> -		 * additional instructions here. In case of x86, we use 'lfence'
> -		 * insn for mitigation. We reuse preexisting logic from Spectre
> -		 * v1 mitigation that happens to produce the required code on
> -		 * x86 for v4 as well.
> +		 * Bounds-Check Bypass and Type Confusion.
>  		 */

[Severity: Low]
This isn't a bug, but BPF code uses the multi-line comment style where the
opening /* goes on its own line with the comment text starting on the next
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117172341.3152=
407-1-ryan.roberts@arm.com?part=3D1
