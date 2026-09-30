Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9113AAF56
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755368; cv=none; b=d2MzJyZYjV18TYWBH5OhFombw1faUILbAiFNU6wkhH4kV20rvsv3hhTCysZm0GFXwxSwqiG7eLm0ZER2okfusJt3t13uIi2MVB5gmwgk6+qedOJJ5trNOHjgpLVL7i5YqUudNQA+qcvr1IY+BJDCuQoEM7LOn3+Vk73uPmFYwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755368; c=relaxed/simple;
	bh=iCR71HtiWHhYAuL9WP1MeO4TuEnkp5OShhme+BPyjAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TolJKJDiB8Xx34cyacEErd69CfAMnWDmJOWm0H2HilQWCu8/RcSpbqUAgfPYStQO3eZBQFtOacMBH59DPUscvzv8aWIcX/AWwI6aYYkPNREeIWGhaJEZC1IB/B1oWrB+fYiNMBJT4bmA5ByVkYCm6TgcCGAKkPcut94agqiaOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rpjul245; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rpjul245"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D961F000FF;
	Wed, 30 Sep 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755367;
	bh=1i4gfw/1znGfxYK0G5krURx/9wbBU9XLh8YFfk+s1dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rpjul245Nu2iwk8RmCUyqd2GPYUw6J12g+GQ7A/nwYaDi196DQQNqYHnCnFnvRjMv
	 r1IyubYA8x6TOGtheF2e98HbXYMOkAq5tVOL5p5rwn0GNctJfy9UhJE6zc+PY3PtMx
	 lYU8Xg5SlIfyX08VtYdUv3VAQNqaK8Y6zVJ22bsSvsHE24YDMYxIE7+DQOT4oANH99
	 k4G2JOl/zCV72IA5H6JkGvf8PwiXQh0u8qiE76oPU96/2R4PKyJPkV7dMLaohafyP+
	 G22LaRFdFMdzUZSU3UzGMZiT6FXdgr4r/Earsvb9FTN37S2KwG0hw0FPx/WXb3JNjr
	 Bh0ZljLb4e2WA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v8 2/4] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: mkoutny@suse.com, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org
In-Reply-To: <20260930075154.189958-3-cui.tao@linux.dev>
References: <20260930075154.189958-1-cui.tao@linux.dev>
 <20260930075154.189958-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:02:46 +0000
Message-Id: <20260930080246.A4D961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: tests exit without calling test__skip() on unsupported devi=
ce
- [Low] bpf: unused array variables in write_cost_model consume stack space
--

commit e990a9d15cbbcc9c7a94ea98646f25abaa1003cf
Author: Tao Cui <cui.tao@linux.dev>
selftests/bpf: add iocost cost model test

This commit adds an iocost cost model test for BPF, including a double-cost
linear HDD formula and a multi-stream sequentiality detection model. It ver=
ifies
attaching, detaching, and cost readbacks on a block device.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..5b7b1282fcb74
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +static int write_cost_model(const char *dev, const char *what)
> +{
> +	char buf[128], line[256], word[256];

[Severity: Low]
Are the arrays line and word needed here? They consume 512 bytes of stack
space but do not appear to be used anywhere in write_cost_model().

> +	FILE *fp;
> +	int err =3D 0;
> +
> +	snprintf(buf, sizeof(buf), "%s %s", dev, what);
> +	fp =3D fopen("/sys/fs/cgroup/io.cost.model", "w");
[ ... ]
> +void serial_test_iocost_model(void)
> +{
> +	struct iocost_model *skel, *second;
[ ... ]
> +	err =3D iocost_model__attach(skel);
> +	if (err =3D=3D -EOPNOTSUPP) {
> +		printf("%s: device is not blk-mq or iocost unavailable, skipping\n",
> +		       __func__);
> +		iocost_model__destroy(skel);
> +		return;

[Severity: Medium]
Without calling test__skip(), the test runner might incorrectly report this
test as PASSED rather than SKIPPED when the device lacks support.

Should this error path call test__skip() before returning?

> +	}
> +	if (ASSERT_OK(err, "attach")) {
[ ... ]
> +void serial_test_iocost_model_streams(void)
> +{
> +	struct iocost_ms *skel;
[ ... ]
> +	err =3D iocost_ms__attach(skel);
> +	if (err =3D=3D -EOPNOTSUPP) {
> +		printf("%s: device is not blk-mq or iocost unavailable, skipping\n",
> +		       __func__);
> +		iocost_ms__destroy(skel);
> +		return;

[Severity: Medium]
Similarly, does this error path also need to call test__skip() so the test
runner knows the execution was skipped rather than successfully passed?

> +	}
> +	if (ASSERT_OK(err, "attach")) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930075154.1899=
58-1-cui.tao@linux.dev?part=3D2
