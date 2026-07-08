Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF8390228
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522073; cv=none; b=fIFKuwqAO9Omv1NQRgfFVmAY83qxNkQBIWnOStGYsOxfeBB899xFmkIR1EtIpD+eZelLC5n/35nj20ZxoxGjiRfbidOa0r/s7c7eld0Fn03YkWn5cggI8ytJan1gJIBv6xySS87lHI2k92bW2+x1tF3cLWIxv5OtbbVQbNvvPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522073; c=relaxed/simple;
	bh=YmjQx4atfVw6+lafnnHnNilMma8VwSAdVBri3N2n9+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ZGJKWiEL726RIFm9GH4zRKJw0WkIPc8nmkIberLTHK7cLs6MThrnTx/I3J8H8+NlX3T7LatwVh8DCmwP8ffuTZL/2Hfie3JrDl2y4PQE8rNuvlqiVdSDCz0ZJQd09/ocq6em+muYXMVk+lb1M2syny1v1bvBJQ/U6L5NW3ZXjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pEAM0LtW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pEAM0LtW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8F47CC8F452;
	Wed,  8 Jul 2026 14:48:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98A1660339;
	Wed,  8 Jul 2026 14:47:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D107C11BC1702;
	Wed,  8 Jul 2026 16:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783522070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jFdbisRPKTRylapm7Tnzw1nhQbLz3Y0BP5aXIMzlsUU=;
	b=pEAM0LtWBxngOCEsa3VItT6CTgF58OFxbJSL2KSGoLrhaZtKOdMwjX80OU6hVkQ4scOY77
	f48Xt2UXBCVuVPEKfZGybShD8O0dV1rw/S0oO2rAxIeAFdZNTZy/O8CA1FmqM6YCQK8RJ8
	bSedQhxoiJSsWQGzafFg2vtOt4FsFDPUCuMnlJZN86wjA82V8muZuN85sC6K5QPeNdxAw7
	H4Qzj/4NofDzp14TADv0rhzuQoibkcz/uvvpmgYstkiKfIlKLl6wE0Xe7Rs52LMVqOPQtH
	kx3yNq0LZcGBgx+JmFDhCdinp0LJaT9KD9wsfxFS9XNed50l1B8vMHi28PsJ/A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:47:49 +0200
Message-Id: <DJT9T3MEILYQ.2KNU0Q7RKM3SW@bootlin.com>
Subject: Re: [PATCH bpf-next v4 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-10-d5c177ab8227@bootlin.com>
 <20260708082841.9FF7C1F00A3A@smtp.kernel.org>
In-Reply-To: <20260708082841.9FF7C1F00A3A@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:28 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Test fails spuriously on default kernels due to missing verifi=
cation of the kasan_multi_shot requirement.
> - [Low] The variable `nsize` is assigned but never used, constituting dea=
d code.
> --
>
> --- Patch [10]: [PATCH bpf-next v4 10/10] selftests/bpf: add tests to val=
idate KASAN on JIT programs ---
> commit c15c25b993ae0bc70091046fa0c6b2bb1e71d099
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> selftests/bpf: add tests to validate KASAN on JIT programs
>
> This patch adds a basic test runner to load and run BPF programs that
> trigger memory management bugs to validate KASAN instrumentation.
> It runs various memory access tests and checks kernel logs for the expect=
ed
> KASAN splat, requiring the kernel to be configured with kasan_multi_shot.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/test=
ing/selftests/bpf/prog_tests/kasan.c
>> new file mode 100644
>> index 0000000000000..f006b92ee131a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
>
> [ ... ]
>
>> +static int check_kasan_report_in_kernel_logs(char *buf, struct test_ctx=
 *ctx,
>> +					     bool is_write, int size)
>> +{
>> +	char access_log[READ_CHUNK_SIZE];
>> +	char *kasan_report_start;
>> +	int nsize;
>> +
>> +	snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_SLAB_UAF,
>> +		 ctx->prog_tag[0], ctx->prog_tag[1], ctx->prog_tag[2],
>> +		 ctx->prog_tag[3], ctx->prog_tag[4], ctx->prog_tag[5],
>> +		 ctx->prog_tag[6], ctx->prog_tag[7], ctx->prog_name);
>
> [ ... ]
>
>> +	kasan_report_start =3D strstr(buf, access_log);
>> +
>> +	if (!kasan_report_start)
>> +		return 1;
>> +
>> +	nsize =3D snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_REPORT,
>> +			 is_write ? "Write" : "Read", size);
>
> [Severity: Low]
> This isn't a bug, but the variable nsize is assigned here and never used.
> Should this assignment be removed to avoid dead code?

I'll rather add an ASSERT on it.

>> +
>> +	if (!strstr(kasan_report_start, access_log))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>
> [ ... ]
>
>> +void test_kasan(void)
>> +{
>> +	struct kasan_write_val val;
>> +	struct test_spec *test;
>> +	struct test_ctx *ctx;
>> +	struct kasan *skel;
>> +	__u32 key =3D 0;
>> +	int i, ret;
>> +
>> +	ctx =3D calloc(1, sizeof(struct test_ctx));
>> +	if (!ASSERT_OK_PTR(ctx, "alloc test ctx"))
>> +		return;
>> +
>> +	if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
>> +		test__skip();
>> +		goto end;
>> +	}
>
> [Severity: Medium]
> Since the commit message notes that the kernel must run with the
> kasan_multi_shot configuration, what happens if this parameter is missing=
?
>
> Could this test fail spuriously on default kernels where multi-shot is
> disabled, since it doesn't verify if kasan_multi_shot is active before
> triggering multiple reports?

The current test design assumes that kasan_multi_shot is not enabled by
the test itself but by the CI runner. This is actually already the case
for the BPF CI. But maybe having a SKIP instead of FAIL is more friendly
for anyone trying to run the tests and forgetting to enable
kasan_multi_shot (some additional doc have been requested and added
since first revision, but I guess the check would not hurt).

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

