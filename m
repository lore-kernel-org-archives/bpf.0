Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057749;
	b=ehJTLV3BZMqXjyb8iX49wZ802eJr+gX9xumiFv8ucClaUcbxbNZNxHCo91o30y/z5xAa
	 7H2h5R/kpLEKZMzllj9BOTQ1fVO2QU6l4IbAH9rINCdX/ImI1TKQ3SMKm9mzvSQva3r6K
	 U8a09md5IEuQfIHVqhIzpm0dY5ACzA0buT4c9awhFPgCOWBPUlh1Cpn+SAdpMlep+I3WA
	 sbN9vm1MiC1YYigIWvXuLocLi4HUi5j35w+n7Djh8dIcwqcFqeR7fmSq8nmgc2blKFugk
	 8NdzUmKkKVGpa1WjJ9X0aIhsPRjOLETMp7/E8ezqBsaPOn3/Jgo04hS0K6WOEQV4xRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HyBEC+Coz7KfomMbkGNYnA+yub51FbLpN4zbRJpkAIo=;
	b=aSl7JrWu+OHrijv1dJLPxHYG42sdv3vRgcuwxF41X4CeCN1tdvm56ThtE2G6D4EBRQzi
	 Q+qnqUw+DVmaogakCaHPYoitihY4hfQz9fQtTXSH0g+L6Sc1PRc2PFQMOz0TNWwbs2tD6
	 Yw64p/XdUAF4zE1bXCQqH227evvyYbxDk+zzcEBi5hX/fnaedFpTV5Rp8q3pEJwNEWCs3
	 0ns7d1clWcakspGWaWsoxudE7g9AvSoOfLpnZ8Azei4Kk+wisiuJUa+uzSP+q37TbFj24
	 ixhYrS6ytB30a1tUIuYQVopA9hVc4vHeD7daY7rXyXUn4Tr6fYwgIwld4mpr8v6AoQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1CLnd4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6DE606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1CLnd4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12751F0089F;
	Sat,  7 Nov 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057749;
	bh=HyBEC+Coz7KfomMbkGNYnA+yub51FbLpN4zbRJpkAIo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=h1CLnd4A+vMuab07obcvPx9quoy6jqFS0+uEXsyGDcwUwnIahahMoorvvr8zHZOA+
	 qOyDTmAuldBbHBm0BAJ3I4FgqCDhY94XOIEeIxm0L37mzeKWnvDCucN6RAaWTROuZN
	 etrarkNjeAJRQ8ovsqlL6cyAMKVAOdTGQyxWM0siadhRU+4WVMDqkSCMjTmhpdJxzZ
	 WBwxNo+z262M7BfQRrf1JHcykj50mxBRJihvkwUDBtzXiwWVTU2l4VuJ34o2aFMcFR
	 goA9+7MsWzRpyZSAJc/q1+vScTFidm6Z2SAnP+EsiK4Iaim9T91y6UX2zX7306AMcc
	 VsnGgC7EjL8/A==
Message-ID: <sashiko-outbox-202908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover RHASH batch cursor loss
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>, bpf@vger.kernel.org
In-Reply-To: <4b4cccc3b706a54ef42ba3c09b40954883661e6a.1794056839.git.hi@tychen.cc>
References: <cover.1794056839.git.hi@tychen.cc>
 <4b4cccc3b706a54ef42ba3c09b40954883661e6a.1794056839.git.hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:22:28 +0000
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
- [Low] selftests/bpf: standalone rhash_batch.c file instead of
  extending rhash.c
--

commit bf9586f48a54e730e2740cce0745ca08b2ddac63
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Cover RHASH batch cursor loss

This commit adds BPF selftests covering normal completion, missing input
cursors, and concurrent deletions for BPF_MAP_TYPE_RHASH batch lookup and
lookup-and-delete operations.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash_batch.c b/tools=
/testing/selftests/bpf/prog_tests/rhash_batch.c
> new file mode 100644
> index 0000000000000..bba9062afd123
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash_batch.c

[ ... ]

> +void test_rhash_batch(void)
> +{
> +	if (test__start_subtest("lookup"))
> +		test_batch(false, false);
> +	if (test__start_subtest("lookup_delete"))
> +		test_batch(true, false);
> +	if (test__start_subtest("lost_lookup_cursor"))
> +		test_batch(false, true);
> +	if (test__start_subtest("lost_delete_cursor"))
> +		test_batch(true, true);
> +	if (test__start_subtest("concurrent_delete"))
> +		test_concurrent_delete();
> +}

[Severity: Low]
This isn't a bug, but could these subtests be added to test_rhash() in
tools/testing/selftests/bpf/prog_tests/rhash.c instead of introducing a
separate file?  rhash.c already houses userspace map syscall and iteration
subtests for BPF_MAP_TYPE_RHASH, and rhash_batch.c does not load a separate
BPF program skeleton.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794056839.gi=
t.hi@tychen.cc?part=3D2
