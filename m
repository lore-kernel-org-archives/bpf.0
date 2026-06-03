Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5A32573F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494061; cv=none; b=QdbZmLYgB/nomRTx5VPAKt8CSx0YTbZJKaahQLtdpeYm/MQTd8ylL+4SiSAZBxSJ/pDvbxv4JOeVZQc711rPMmm6Eb9/wF1FLsXj/Ys1SqW8Qexzcou4o8YZRp7H4BSHqiinvrKEP+RJUII+s/2JmzHICXwyGbi8GeD1eLd3iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494061; c=relaxed/simple;
	bh=cO86uRMiUmt5TGTEwbu1Lbs1mm93/+uNvrjze3ldqMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=koBa9pTRvrZoXlH48ybLzEmtbzBJIewD9Y2XB6Wbbp9U0AlOixlNMMDhbQJa1mTQcchFOIH/ulgOtoxoO9fK45rNT40G7ak33fSlO/bOh9ZpjPgWI6olCsiXWpfgl42uRTOKQmrKQew+S5JaS2o0yDtUO6dBhZQJT0CFDjcpDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM5GaNB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM5GaNB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E71F00893;
	Wed,  3 Jun 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780494060;
	bh=muUlEMJmgGH/rQGcXOfVz1jKz4CF8oU8LRiXalgLanE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SM5GaNB2N/9enyFCUHJQiqpix4Rhmq6FRh0RmMel/lMr0os0/reNerDZa4PHXQFNg
	 jYma42RxsahtqW/vstTHxOCgIPBdNQFuS6dlhIuwnzR++0XqHr8s4GnavjWGroyLeY
	 S0uFU0t87Q7DvWKTLYmfIQEfegFjEqkjjPHOwlziSEIgVnHRKPHc0fbPKWF9+IEz+n
	 qBnItlADv4ramJC0pb2mny+e6/INIx/JuBIloHMNy2rh79v1ZUamuJuRcVyymudga4
	 YQAZqbXCI1oyRmikm/0ifHAJUHJ2Mj5/+fpn6ww10ckNIa6wmkv8NAtHho/SIHDlRs
	 VdKP/B0Gyg2oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 21/29] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-22-jolsa@kernel.org>
References: <20260603110554.29590-22-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 13:40:59 +0000
Message-Id: <20260603134059.D02E71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces tests using new libbpf APIs and section defini=
tions (`bpf_program__attach_tracing_multi`, `struct bpf_tracing_multi_opts`=
, `fentry.multi`) that are not present in the tree.
--

commit 51532d297dcd0ba4ad28dece86396b88a934e780
Author: Jiri Olsa <jolsa@kernel.org>
Subject: selftests/bpf: Add tracing multi skel/pattern/ids attach tests

Adding tests for tracing_multi link attachment via all possible libbpf
apis - skeleton, function pattern and btf ids.

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
Is the bpf_program__attach_tracing_multi() function implemented in the tree?
I couldn't find its definition in the libbpf headers, which might cause a
build failure when compiling the selftests.

[ ... ]

> +static void test_link_api_ids(void)
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);

[Severity: Low]
Does struct bpf_tracing_multi_opts exist in the current libbpf headers?
This instantiation seems to rely on a structure that is missing from the tr=
ee.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_attach.c b/t=
ools/testing/selftests/bpf/progs/tracing_multi_attach.c
> new file mode 100644
> index 0000000000000..332d0a423a430
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach.c

[ ... ]

> +__u64 test_result_fentry =3D 0;
> +__u64 test_result_fexit =3D 0;
> +
> +SEC("fentry.multi/bpf_fentry_test*")
> +int BPF_PROG(test_fentry)

[Severity: Low]
Is the fentry.multi section prefix supported by the current version of
libbpf? Using an unrecognized section might cause libbpf to fail when loadi=
ng
the object.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-22-jolsa@kernel.org?part=3D1
