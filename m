Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197871;
	b=oOwcLq4z9VGPgfVGXmeuShMU5cDgpwrFfBjLXMAzBnp+caj39i4tp4AOKrA8LGZkBlw8
	 /wchYL6+z/a0LC9m+9Q2YsopIlGPPZDP+Sq+c+Qqm6CX3OUvJiv0SO+L0lfcxpwMcaQ2y
	 466oWeibVQETqGtWJnx3jfOSGERB9sEWRdtYaaAYvGXaEqGBF0lhnsq6mOFMDluSj4Ha0
	 cISzrvWwB4N5/tyL5LCBrl2jxvfArgPPyab2WNmoVIpfWx6cKc+dSpjx35i3xq6WB3iaZ
	 LB/f8J6APyVTSrCA06tSJFPgk3JQ+KL7bp+9bT5usl6gw0drGK3VWKDWubSBEPBebHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JDCQoGyHTAim4G5Chm1p51VV8+73gavE69cXQLvfn5k=;
	b=OeA+PddaS/jFdS3p36gaic9jFVM6GENVHYbhp2ZjY3SGkHhbW3Y0dZsDA9toXTANCxP+
	 w1wdACAriNuGet4xHISxvePf+QhzoG1g/elg5OFNM96QXBsujzR1+zJaG9p0dGwqHY/6R
	 +inpOTnkhKVwwkvtcrhuyTcvOJflDRzv/QfoNkliLv8d+hNt1PG8FwIFbj9A7gGrTEfJQ
	 2G9JORe9SKrE+Lty64a5zbzL9Fx98c3CIp7oLLvyuNNVPB+LxTM817x9rcQes2le7T2JB
	 4xzpg22PotAotuip8uPdg0mW8ygzY0DYh5EZR0idmJwdkW58odNpd+H1Fs1OYlict7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W84bZJ4J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB9606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W84bZJ4J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD91F0089F;
	Mon,  9 Nov 2026 04:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197871;
	bh=JDCQoGyHTAim4G5Chm1p51VV8+73gavE69cXQLvfn5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W84bZJ4JIZgmY8m/8JKj9s209gavyePewyxmRKC5R8/jN6EZAtYJJBeyxsvwlM1Jw
	 2PCxzXojctFC/Vt5m5rot/mGfBlYVoIh5I65YVyH0cKDWLuzrkffirmm6HzkCL7mQK
	 0m/rKsZ9vTn5FJaWgTYwifoHSlGbqoQRVopBjY89kJ/nuJ11ezBrO+qu8mCpZ7RPf4
	 en7yQ6lCXLbYXu8SQWeHHeZG52W3PLr2a0fQnlqn9ur5vKpJC/uW9PhzNJLDC9w+4S
	 pTfj7y6r8TawIfmI1TjySjFa0ZmiDyAzGYVBgvzI08B0iq4eC4WQ958liNvxiUL8dm
	 c7v1fnLzyI+yA==
Message-ID: <sashiko-outbox-204400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix unaligned access
 failure in fexit_bpf2bpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109041207.15221-3-yangtiezhu@loongson.cn>
References: <20261109041207.15221-1-yangtiezhu@loongson.cn>
 <20261109041207.15221-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:17:48 +0000
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
- [Low] selftests/bpf: missing Fixes trailer for commit 6dc03dc71387
--

commit 507288d3c1afad0bf83be8f5f5a571a1da547ccc
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

> selftests/bpf: Fix unaligned access failure in fexit_bpf2bpf
>
> When executing "./test_progs -t fexit_bpf2bpf", there are 5 subtest
> failures on platforms where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> is not set, because these platforms lack hardware unaligned access
> support:
>
>   ; tcp->check++; @ test_pkt_access.c:98
>   226: (69) r1 =3D *(u16 *)(r2 +16)
>   misaligned packet access off 2+(0x0; 0x3f)+16 size 2
>   ...
>   libbpf: prog 'test_pkt_access': failed to load: -EACCES
>   libbpf: failed to load object './test_pkt_access.bpf.o'
>
> Instead of skipping these tests entirely, fix this at the source by
> applying a bitmask 'off &=3D ~1' right after the initial range check.
> This explicitly communicates the 2-byte alignment state to pass the
> verifier and run the full fexit_bpf2bpf test matrix.
>
> Before:
>   $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
>   Summary: 0/10 PASSED, 1 SKIPPED, 1/5 FAILED
>
> After:
>   $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
>   Summary: 1/15 PASSED, 1 SKIPPED, 0/0 FAILED
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

[Severity: Low]
This fixes the unaligned packet offset in test_pkt_write_access_subprog()
and new_test_pkt_write_access_subprog().  Should this include:

  Fixes: 6dc03dc71387 ("selftests/bpf: Add test for freplace program with w=
rite access")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109041207.1522=
1-1-yangtiezhu@loongson.cn?part=3D2
