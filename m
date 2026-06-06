Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099653ACEFB
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750628; cv=none; b=np/ilgy3ahL1WZ2hwLyGVQWMikHMmGeB2E/wkT70AEdPJwujSBfoPRtSkAli9DsYgAy3mrpH6DTMEjDFZfbAOGXK076NdTcbAbDFNFKuu/p6nfU3RLMhQf4zt44bK1KD6CuFRpXuPO/B9UqwC8gQSu/I2iLYZqFn4n8J4HOoLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750628; c=relaxed/simple;
	bh=EEfuUIRIHT7+HzTGt/LJoT4ekM8V7IbAAtYGFsM3/DA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/0qJagdJEoRWYKi3wdgKL5l7OJNZPxFIyuuP7e07xpGD7U89Mq9sR2WnpjMW0walnyP3hKzwoFTGa3BNXUS4j4V2Wsk8akIS2qSEsFuRPaleItpEA4urEZYqvFZVAYP7br+/IYukICDwW9PRREtTeeeWBIqPdNkQIQF5VaxYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx38Ust/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx38Ust/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8861F00893;
	Sat,  6 Jun 2026 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780750626;
	bh=1/25LaGfLZ9I75Fyz56ZqqKNRD2zWLTHCdhysYZcOwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx38Ust/y/3Y5KTrzTSFZkiKIPbFJYRZ5KQfWljcib4ttmbuj+EzqGN8jPpRlDqTS
	 WMm2xVI3nFO6Bx18yifjSKhs5uGGRkwZLMZqkYRNPKpHqmFli5EDrbV1eHzKr2FBrk
	 Sk8Il6aHD2I+nRvrLLGvftrnUkrqwX5C7gFOX45sCQZ/vWG2VLAIPKOm2TTwhOZWpS
	 oXSpl8LdgdDOfXCp4pkWTWTOh9f4b8FNClNi3GqniwYBcrUvBrsFKpFeHgaNnSWc9v
	 lmWmhfTE1o9pgGDs5uwbhXaoSSh6HjkxmeijVmb3vyi7H7jtU+H6eSx/sGnZ1n/s2S
	 UmVk+wkIZMwdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv8 bpf-next 21/29] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606123955.345967-22-jolsa@kernel.org>
References: <20260606123955.345967-22-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:57:06 +0000
Message-Id: <20260606125706.6E8861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The selftest relies on undefined libbpf APIs, leading to compilatio=
n failures.
--

commit 71b9bc6b97c3cb1e6333868f2e7bc66a92fb6084
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing multi skel/pattern/ids attach tests

This patch adds tests for tracing_multi link attachment using various libbpf
APIs including skeleton, function pattern, and BTF IDs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/too=
ls/testing/selftests/bpf/prog_tests/tracing_multi.c
> new file mode 100644
> index 0000000000000..f333b2514b345
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
[ ... ]
> +static void test_link_api_pattern(void)
> +{
> +	struct tracing_multi *skel;
> +
> +	skel =3D tracing_multi__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
> +		return;
> +
> +	skel->bss->pid =3D getpid();
> +
> +	skel->links.test_fentry =3D bpf_program__attach_tracing_multi(skel->pro=
gs.test_fentry,
> +					"bpf_fentry_test*", NULL);

[Severity: Low]
Does this cause a build failure? bpf_program__attach_tracing_multi() does n=
ot
appear to be defined in tools/lib/bpf/ or anywhere else in the tree in this
patch.

[ ... ]
> +static void test_link_api_ids(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);

[Severity: Low]
Is struct bpf_tracing_multi_opts missing from this patch? Using this
undefined structure will likely lead to an incomplete type error during
selftest compilation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606123955.3459=
67-22-jolsa@kernel.org?part=3D1
