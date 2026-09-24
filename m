Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418643B71A0
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229432; cv=none; b=p6AO1NazxcHbBzis/2GXDyNjnS2RBFK3iw0JDR6sM5Cat3EsEZJ3YpOOFjVAFsPUzb427/k9KUl81jr0dEndnQfuTmL+tY49VOwiKpHM9uZgzHTYiK1myJZIq1Nc8MJs1DZFiXFH2qPKEvT7McUgx22F+2SouCDlzsmr4Czyung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229432; c=relaxed/simple;
	bh=IW3s5y1ntACCzL35xFQXKY1yEPLhhl9zpbNoqlX+GZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxtdcUL7OSqIxc21lbYUve+Jjmo0UDHnDzsZKKSJe6y+DDyUhVGRmSMgqSAW8jXc6/46dcEks+lgpVI2pJhl1tyTz1P8xpOQi1UZPIXLHpm01AsSk5EpszfoR7ZY/315GmzuYr4QZqxueZB/8jBU4UhOaHSgJ3DBTjv5rf9267A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbVBAXue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbVBAXue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FD61F00899;
	Thu, 24 Sep 2026 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229430;
	bh=a9v25GfLqTbT4GFV3yvvHWEXVFDVp9URsvlMdkSRL90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SbVBAXuekDUwbJ9OurUqVWVaz7LsfU28DNP2ZidHD7pMP7KE5DZ6d6LHSbL/gXcUG
	 cFpa4w9N71fI1Uith/DyJESaJRHwTZMAuJN/BZ7EKPUtonNxyRqwLRj5RMuOxLfwqr
	 Kvfa0d8uWivDGotLVDV5BUlBpqgBtVpmmyzcFxOmEpl0+KFc18YdYpN8sABECZ6Mk2
	 EwRl7BEn/pgQGYU0t2jlBgPoLuuDUAQLoXKcxHpHCImqyn/RPU+8So6jK8+SEzDtmO
	 gPLcQe/J7cmXIhzvEtg8ulpZYPWuUNj0D7lUxc2jRAeEDUPILUT7g5Xt7TPK6qxurF
	 ph1TZ2g9yc1rA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 2/4] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org, mkoutny@suse.com
In-Reply-To: <20260924054549.2271705-3-cui.tao@linux.dev>
References: <20260924054549.2271705-1-cui.tao@linux.dev>
 <20260924054549.2271705-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:57:10 +0000
Message-Id: <20260924055710.80FD61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: endianness bug when writing 64-bit device ID to 3=
2-bit dev field
--

commit d5f4da7dcc6342f2064a4e05e68659fc439deaa1
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

Add an example cost model implementing the full builtin linear HDD
formula at double cost, and a test which attaches it to one device:
the dev member of the struct_ops is written through the map's
initial value before load, as hid_bpf tests do with hid_id, and
attaching the struct_ops attaches the model to the device.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..156c75367af05
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> @@ -0,0 +1,182 @@
[ ... ]
> +void serial_test_iocost_model(void)
> +{
> +	struct iocost_model *skel, *second;
> +	unsigned int maj, min;
> +	__u64 *ops_dev, *sdev;
> +	int err;
> +	char model[32], *dev;
[ ... ]
> +	/* dev is the first member of struct iocost_model_ops */
> +	ops_dev =3D bpf_map__initial_value(skel->maps.iocost_2x, NULL);
> +	if (!ASSERT_OK_PTR(ops_dev, "initial_value")) {
> +		iocost_model__destroy(skel);
> +		return;
> +	}
> +	*ops_dev =3D makedev(maj, min);

[Severity: Medium]
Will this 64-bit write cause an endianness issue on big-endian architecture=
s?

Since the first member dev of struct iocost_model_ops is a 32-bit dev_t,
casting the pointer to __u64 * and writing a 64-bit value will place the
actual device ID into the trailing padding on big-endian systems, leaving t=
he
dev field as 0. Could this cause the test to fail by attaching to the wrong
device or being rejected by the kernel?

[ ... ]
> +		/* a second model on the same device fails with -EBUSY */
> +		second =3D iocost_model__open();
> +		if (ASSERT_OK_PTR(second, "second_open")) {
> +			sdev =3D bpf_map__initial_value(
> +					second->maps.iocost_2x, NULL);
> +			if (!ASSERT_OK_PTR(sdev, "second_initial_value"))
> +				goto out_destroy;
> +			*sdev =3D makedev(maj, min);

[Severity: Medium]
Does this have the same 64-bit write endianness issue on big-endian systems
as the first model?

[ ... ]
> +void serial_test_iocost_model_streams(void)
> +{
> +	struct iocost_ms *skel;
> +	unsigned int maj, min;
> +	__u64 *ops_dev;
> +	int err;
> +	char model[32], *dev;
[ ... ]
> +	ops_dev =3D bpf_map__initial_value(skel->maps.iocost_ms, NULL);
> +	if (!ASSERT_OK_PTR(ops_dev, "initial_value")) {
> +		iocost_ms__destroy(skel);
> +		return;
> +	}
> +	*ops_dev =3D makedev(maj, min);

[Severity: Medium]
Does this also share the same 64-bit write endianness issue for the 32-bit
dev field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924054549.2271=
705-1-cui.tao@linux.dev?part=3D2
