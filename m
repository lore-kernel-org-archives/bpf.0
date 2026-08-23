Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4F31715D;
	Sun, 23 Aug 2026 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497835; cv=none; b=RxddL0Xz2RwrtSb9XcrG5pV/dCEbYNcGsGZlPcX45t82YfOyw/i0Drl5K2thSbd7TpGzppv9igO3KwAEqe5gyRmTIb3apwEtQvQ2eK/jszxMUfYlNeUrxSLfRPGbKuVh5zbAQR0Kv+6DlxXEUPfUv6Obb6mV1W1W805t/sEAENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497835; c=relaxed/simple;
	bh=cNGViKUeLrqguxUzckyDJnzMV+iy2eGG1Qyg4wP1PEE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PpfDA3d5HJTZb48x3YpcSIsbYyGeVcmfxeInGW74EV/nqk0ctjV+p7OIo59JzaLtnsRepvU/XTuYgbuAR21MjZ05cmLHhTKIZNcimgMWWUSX6ju1r7sNJJDB/mc4TnTvgkk3ucwlBFXKHi2hNh6azGTWDemmatF+yzaKphvAQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6EdGqkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6EdGqkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49451F000E9;
	Sun, 23 Aug 2026 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787497834;
	bh=tWlaAE1Q6qksw44SENj+z/BNOCBz/g85rWYVaEo/HyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c6EdGqkTY21kWz3sGyCOAp7r9R7iCuAQOsc7iFCZ5a53O6BUltDNSBFdP2zywIXws
	 eb66UJ9dbKAr5HwAcWEeP2inE7rijogKuHEmdskErXS0Eksa7P+iciRQaXmibJ4xmd
	 KwYfcOLn38dGLgBFEajIWZV7lE8rDStBxxcYuIVnawmXrlQaP5bYndcNlbayppkuHK
	 YfYkaexo08bGwW/NR+4buMgSTFqMmzxiQE+I/Mnu9GXWVM6y9dvh71pH+kversV5bj
	 rRexQYEn49axl3eodHkQ+WRC8IwfuwOHA035u0lXzwrFFOskQQtoBVUgbNSsXt9ott
	 QWJietj8HVrkQ==
Content-Type: multipart/mixed; boundary="===============3192848384867124340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da5a6c614e37c974f920293a9abf7b97a00874340c7b599b004d5404bd92745b@mail.kernel.org>
In-Reply-To: <c5a79efbd3cb52cc0668ab50db5379c907cfe6a6.1787492521.git.shijianlin11@foxmail.com>
References: <c5a79efbd3cb52cc0668ab50db5379c907cfe6a6.1787492521.git.shijianlin11@foxmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: cover stream capacity and partial read edge cases
From: bot+bpf-ci@kernel.org
To: shijianlin11@foxmail.com,bpf@vger.kernel.org,memxor@gmail.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@chromium.org,sdf@falco.dk,haoluo@google.com,jolsa@kernel.org,emil@tsalapatis.com,pulehui@huawei.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 15:10:33 +0000 (UTC)

--===============3192848384867124340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
> index e4e9374309e2..9a21f055d80a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c

[ ... ]

> +void test_stream_partial_read(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct stream *skel;
> +	int ret, prog_fd;
> +	long page_size;
> +	char *page, *buf;
> +	char rest[8] = {};
> +
> +	skel = stream__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +		return;
> +
> +	prog_fd = bpf_program__fd(skel->progs.stream_syscall);
> +	ret = bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_OK(ret, "ret");
> +	ASSERT_OK(opts.retval, "retval");
> +
> +	page_size = sysconf(_SC_PAGESIZE);
> +	page = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (!ASSERT_NEQ(page, MAP_FAILED, "mmap")) {
> +		stream__destroy(skel);
> +		return;
> +	}
> +	/* Leave only the first page mapped so a straddling copy faults. */
> +	ASSERT_OK(munmap(page + page_size, page_size), "munmap second page");
                     ^^^^

Should this munmap() be gated like the other setup steps?  The mmap() above
returns early on failure, but this munmap() just records the result and
continues.

If the unmap fails, page + page_size stays mapped, copy_to_user() in
bpf_stream_read() no longer faults, and the first bpf_prog_stream_read()
returns 3 instead of 1.  The test then reports confusing failures
('partial bytes: actual 3 != expected 1' and 'remaining bytes: actual 0
!= expected 2') that point away from the real cause.

Also, the trailing cleanup only unmaps the first page:

> +	munmap(page, page_size);
> +	stream__destroy(skel);
> +}

so the still-mapped second page would be leaked for the remainder of the
test-runner process.  Would gating it the same way as the surrounding
checks work here?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32645868670
--===============3192848384867124340==--
