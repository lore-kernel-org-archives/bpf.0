Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18A421A09
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902057; cv=none; b=ASAotfZIeOwD/9MCGTn4gloBq3Vo7jg5eqnMLcaopOUjUT6TnggCKtWtZxiCzyNGNT9jzcVhXBpSLVcBNCoeh3ExyWSOyyzVUOTlJWBgA1A/AcM3p3KaXcs889itGGZkyiWGNgGd9y9dtGoK/0oD9wp9Lz3kBr1Py2wrwFHcxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902057; c=relaxed/simple;
	bh=CgXx3XsK+YsxJOor6z1ZG9/r6iUkmC83qoiP/dqiJx0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDxwG5V+w/ztAPL29PRvHA1Av36Z4fc9TUVzBqnyHUbEoR5BoMQn3wnzqXUvJIDROoOvD6eww0l08FAWOm9Bj92aLhAUowJ3BFJQBqaCaNr6cM5Ug/QuhsflkMnD2Y6ah8wTBdsU+kEd6n5jDk24ENLq7n1FEZIugYuBpOXaglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7BODbPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7BODbPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1C1F00A3A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902054;
	bh=tkcwsdyoYkRsq8sGaJHKTaXAEvfHnzzZkllyWp7S8fw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=I7BODbPPmoS2LjNRwTtEw5zc3NFQDRCCYU3RN9b3ahMziE9HCI/p56m/xlisTQFNA
	 iXRozMuwmaxf6mJzxAwjmL2M4R3sQ5LHoVQFJ3YoflPp6Tbc2c2FWwX7Tnks34BTqF
	 Aw7nhNf3x/MqospvoXKNFQHoEutmNLCsFHR33Jb96wSfMutYsudbYjDq310LVUOHDZ
	 bftbCLFeHjRWS+jO4kk5x1D9WG2SGxCbdP+BwvKutquXmW+Gp+ot7Q3Tw7RmAOolOP
	 yPYkirmzYHYyd9ahwBzplg8xCsi277rm2zcG6jGQ0wrwyej7aRCVt5dJDeQ96IwD0D
	 ybGsZ2Wgofjsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260701-kasan-v3-10-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-10-bd09bb942d86@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:34:13 +0000
Message-Id: <20260701103414.03E1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized stack memory is passed to the kernel via bpf_prog_=
test_run_opts, causing potential information leaks and triggering MSAN warn=
ings.
- [Medium] The KASAN report parser is susceptible to spurious failures due =
to kernel log interleaving.
--

commit e974c567c6b3da1ae6e1c27c442840d9bd396091
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add tests to validate KASAN on JIT programs

This patch adds a basic KASAN test runner that loads and test-runs BPF prog=
rams
designed to trigger memory management bugs. The test captures kernel logs a=
nd
ensures the expected KASAN splat is emitted by searching for the correspond=
ing
first lines in the report.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 0000000000000..ff070c39eaac1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c

[ ... ]

> +static int check_kasan_report_in_kernel_logs(char *buf, struct test_ctx =
*ctx,
> +					     bool is_write, int size)
> +{
> +	char *access_desc_start, *access_desc_end, *tmp;

[ ... ]

> +	/* Find next line */
> +	access_desc_start =3D strchr(kasan_report_start, '\n');
> +	if (!access_desc_start)
> +		return 1;
> +	access_desc_start++;
> +
> +	access_desc_end =3D strchr(access_desc_start, '\n');
> +	if (!access_desc_end)
> +		return 1;
> +
> +	nsize =3D snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_REPORT,
> +			 is_write ? "Write" : "Read", size);
> +
> +	tmp =3D memmem(access_desc_start, access_desc_end - access_desc_start,
> +		     access_log, nsize);

[Severity: Medium]
Could this fail if other kernel components interleave log messages between =
the
KASAN header and the access description?

The parser assumes the exact next newline-delimited block contains the acce=
ss
description. However, the report_lock used by KASAN internally only seriali=
zes
KASAN reports with each other, not with general printk output from other CP=
Us
or contexts. If another component prints a message precisely between the KA=
SAN
header and the access description, the search bounds might be restricted to=
 an
unrelated interleaved log line, causing memmem() to fail and making the test
flaky.

> +
> +	if (!tmp)
> +		return 1;
> +
> +	return 0;
> +}

[ ... ]

> +static void exec_subtest(struct test_ctx *ctx, struct test_spec *test,
> +			 int access_size, bool on_stack)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct bpf_prog_info info;
> +	uint8_t buf[ETH_HLEN];

[Severity: Medium]
Should buf be initialized before being passed to bpf_prog_test_run_opts()?

Uninitialized stack memory from the test executable is assigned to
topts.data_in and leaked into the kernel space via copy_from_user():

	topts.data_in =3D buf;
	ret =3D bpf_prog_test_run_opts(bpf_program__fd(ctx->prog), &topts);

This uninitialized access can trigger userspace dynamic analysis tools such=
 as
MemorySanitizer (MSAN) when running the BPF selftests, causing spurious test
suite failures.

> +	int ret, prog_fd;
> +	__u32 info_len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-kasan-v3-0=
-bd09bb942d86@bootlin.com?part=3D10
