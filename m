Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793593185;
	b=un3vLeU/C0u0ihe/MOTFK88w6+BigOEgpTaYASM7u6kaHpoZDXfhzEx1aIHJJsVu80Gf
	 lBELLnO8o217DhBepNci1f+Rdz+53F6fZeB8C+9tVKiO5VeTRoWu+JRgmSiZ0J6yyVqQa
	 mmNdMlXLXcTYAV1S8GfC5CqOhz58br69pWJmDeQjbP1gBIlkjKzBGgjq9x8IiaEHJKk+o
	 tZ97OTelJkKA+M7xNhKLuPNg7dIKrI/7kFbJZhEnWnEI0kx8NoBjrGbRpdCPi5raXyMnM
	 ksvx6z4j7XRQYtU1PwqHxI4M71UgAIListtF8Qm4BTQdoUKlfVtS5+EWd6ar3s1zUMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793593185;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4xTl+rSPsDf75lng1GRZp/F3TRHGqZnpTzLlDwrj/xs=;
	b=MRsa++6Cii3Wx/1t0Io66egEikmht5BIH1gnzzoIVyZcKRw1Zd7Tat8Dl8jIHmSGPF1a
	 cG6nkeKECgNuzywk62MQzrqP69ns36o6RzW+2lKhy0boBQGqj78WJUS+GoAJCE4XBdUPy
	 Z48oqaruHSQ/3Y4fwdJ1lvzGl71dweoEeJpui0thtc3ANvl7bRiSI0REbyQ/mTxoErgsi
	 m0/HzkdmVv7X/WKdnFQzFdQGziBgQfz0Cfpw2Y1fzOgqq5Ra8cQ3+jg2t2xvsD1vAVOJN
	 etAcgUf5yjaU6EporS5qcmbrMOyV3bowJ/b5uCB2DU7Xt8sxwmznQOs3+lMK+shNdnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQIANMjI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55177606A337
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQIANMjI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17911F000C1;
	Mon,  2 Nov 2026 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793593184;
	bh=4xTl+rSPsDf75lng1GRZp/F3TRHGqZnpTzLlDwrj/xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQIANMjIV7MGaTjXBos/lLYqZNuX+J1VaGU1GHaQrZx36pbroeI87zN095gFIhmCP
	 FejwIpzV7aT/aDKnd2vC4dwqR2+efgWlBf4Jn/7HfD5+wkh/mLeYypbpDYjcpa9iE3
	 q2rMa0qiVBWmliVOWo4RFvOCozH4VojA+7e2GyCEUMzDmt7SEcnK1Nv/7wzjoAO0x3
	 GxDfyDfklW+gCRNaHoI8AIEfAyq+ut/SIhVhyQVHiU0V7XRQD0AbgaJMBBNOIhuPdk
	 nwMW+vcnHAxApE2LuNJTlfpvH3miLAST0I2pk9lTDOi0S7iSAtMWJ788d23kESJJii
	 a8GAdD4Xhs7HQ==
Message-ID: <sashiko-outbox-192887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Use memfd_create instead of
 mkstemp in d_path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jonathan Bastari Thamrin" <thamrinjonathan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102-d-path-memfd-v1-1-692a5664b36d@gmail.com>
References: <20261102-d-path-memfd-v1-1-692a5664b36d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 04:19:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: deprecated CHECK() used in test_d_path_mem_access()
--

commit 70ec4540d31dab1fed0411808b9f6ef87d380925
Author: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

selftests/bpf: Use memfd_create instead of mkstemp in d_path

This commit replaces mkstemp() in /dev/shm with memfd_create() in
test_d_path_mem_access() so the check_mem_access subtest can run under
vmtest.sh when /dev/shm is not mounted.

> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index 1a2a2f1abf033..0f0150d73262b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c

[ ... ]

> @@ -230,13 +230,12 @@ static void test_d_path_mem_access(void)
> =20
>  	bss =3D skel->bss;
> =20
> -	localfd =3D mkstemp(path_template);
> -	if (CHECK(localfd < 0, "trigger", "mkstemp failed\n"))
> +	localfd =3D memfd_create("d_path_loadgen", 0);
> +	if (CHECK(localfd < 0, "trigger", "memfd_create failed\n"))
>  		goto cleanup;

[Severity: Low]
This isn't a bug, but since CHECK() is deprecated in BPF selftests, should
this updated check in test_d_path_mem_access() use ASSERT_OK_FD() from
tools/testing/selftests/bpf/test_progs.h instead (similar to commit
47687a29b2c3 ("selftests/bpf: Use memfd_create instead of shm_open in
cgroup_iter_memcg"))?

	if (!ASSERT_OK_FD(localfd, "memfd_create"))
		goto cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-d-path-mem=
fd-v1-1-692a5664b36d@gmail.com?part=3D1
