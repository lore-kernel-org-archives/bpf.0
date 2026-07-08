Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD67401A2E
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499324; cv=none; b=OWRgvc+XXgj7HPmvetm3nb6UmEqhOjpL7W4o0+yvoxxBqR2r21iXcMc6f/cYxajobSwbd3ZyFd3iczrS4uisJUzJz6pQpQtLx9Sf0C0BRa9Z7X3avqGfqmJWuvWkXD43kQrHkVQikN0GykbYW847fnQTmEaZYr84FlSePvftkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499324; c=relaxed/simple;
	bh=3yP9LSetzvy1l9yUXk/RqagviFiyPzjb8NXMn2DOY/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OghGVNCsibxaj5iV2TMJf1kCjYXBTlHTNwlDCY1OqQV84yB8i1fKpxvRRa2wsg/dO92bbtqYH32PbhyT+MRQCxrvv2VNsWYufGRto/DuvqS3Nu8oqQ1ikB2zjQFpjUuUSHjN5kxiLblnBm3QkoVzfunbJ626X0XVEFVo4Pk5kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAoCZmpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAoCZmpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7C1F00A3A;
	Wed,  8 Jul 2026 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783499321;
	bh=xBpSDCXB3jFyDYIRf7k2ZwU9oEsjeEzm+I3HY99eUok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAoCZmpV0G66UFBLkQ80uDfdGqL0LShR6kQnvzX7JIK28//JOPMIVk8MC7sLNHYli
	 AnoleyGq56V7nWxYy52E48KUGj0quWYNI+qi1hr0Ps5LDQVk5Vwlh6h3L9PZ5VKiM4
	 cAAsdTDAYRLy9fiDu7f9L+c7i4qHZ9EQpyqUf1fp4x2lG0pq89hKqbGU5gMLVIToMR
	 Pm6YC/onUtiNvRKXGFUCGuA3Va7+qq1IZhak0urgG1r5f4da80ItbpxsY+mB0AQxqs
	 TbiInLj0QnEPM8y6uJk4FMYrba2HH71qS6DRCbqavA1IuUglu3yhzV2jBR0MLhq625
	 kulHB99I5t69g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-10-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-10-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:28:41 +0000
Message-Id: <20260708082841.9FF7C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Test fails spuriously on default kernels due to missing verifica=
tion of the kasan_multi_shot requirement.
- [Low] The variable `nsize` is assigned but never used, constituting dead =
code.
--

--- Patch [10]: [PATCH bpf-next v4 10/10] selftests/bpf: add tests to valid=
ate KASAN on JIT programs ---
commit c15c25b993ae0bc70091046fa0c6b2bb1e71d099
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add tests to validate KASAN on JIT programs

This patch adds a basic test runner to load and run BPF programs that
trigger memory management bugs to validate KASAN instrumentation.
It runs various memory access tests and checks kernel logs for the expected
KASAN splat, requiring the kernel to be configured with kasan_multi_shot.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 0000000000000..f006b92ee131a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c

[ ... ]

> +static int check_kasan_report_in_kernel_logs(char *buf, struct test_ctx =
*ctx,
> +					     bool is_write, int size)
> +{
> +	char access_log[READ_CHUNK_SIZE];
> +	char *kasan_report_start;
> +	int nsize;
> +
> +	snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_SLAB_UAF,
> +		 ctx->prog_tag[0], ctx->prog_tag[1], ctx->prog_tag[2],
> +		 ctx->prog_tag[3], ctx->prog_tag[4], ctx->prog_tag[5],
> +		 ctx->prog_tag[6], ctx->prog_tag[7], ctx->prog_name);

[ ... ]

> +	kasan_report_start =3D strstr(buf, access_log);
> +
> +	if (!kasan_report_start)
> +		return 1;
> +
> +	nsize =3D snprintf(access_log, READ_CHUNK_SIZE, KASAN_PATTERN_REPORT,
> +			 is_write ? "Write" : "Read", size);

[Severity: Low]
This isn't a bug, but the variable nsize is assigned here and never used.
Should this assignment be removed to avoid dead code?

> +
> +	if (!strstr(kasan_report_start, access_log))
> +		return 1;
> +
> +	return 0;
> +}

[ ... ]

> +void test_kasan(void)
> +{
> +	struct kasan_write_val val;
> +	struct test_spec *test;
> +	struct test_ctx *ctx;
> +	struct kasan *skel;
> +	__u32 key =3D 0;
> +	int i, ret;
> +
> +	ctx =3D calloc(1, sizeof(struct test_ctx));
> +	if (!ASSERT_OK_PTR(ctx, "alloc test ctx"))
> +		return;
> +
> +	if (!is_jit_enabled() || !get_kasan_jit_enabled()) {
> +		test__skip();
> +		goto end;
> +	}

[Severity: Medium]
Since the commit message notes that the kernel must run with the
kasan_multi_shot configuration, what happens if this parameter is missing?

Could this test fail spuriously on default kernels where multi-shot is
disabled, since it doesn't verify if kasan_multi_shot is active before
triggering multiple reports?

> +
> +	skel =3D kasan__open();
> +	if (!ASSERT_OK_PTR(skel, "open prog"))
> +		goto end;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D10
