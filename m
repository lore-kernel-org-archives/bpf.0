Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682A46C823
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045926; cv=none; b=TaufnE45+6SarJe8Fu8IMDU9AiDdTGmNh7DEA/qvQCAPct3ekB+RbkrAkD1nwZcVxRIsPbCEmSyDb/FncyvQ5yRwIb/YiIOeCsy7rpncZeYrBsMro+WP3FDZU59AAFQbUVGYRd46OxOr9XFslRmexLG88Gi6glsjjat5makuR48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045926; c=relaxed/simple;
	bh=L/Xl+simz73PT/rKoZ4un9cyuHJqpWYrt8RlopZv1Wo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPWZHhdIBZpjGvg7Gx2rLxeEpNMBYjUaFw7zW/zCHJwyAiauKo01FHV0JNQEjLzNzWahla0ZZk5c8MaG3GPYQEN5vpH/sHP/hMsdf9eenKT0dGEZ4nSfBo9sIuVroHu9UBUlaEOaXcdduOwsfKFG0MS0J1IMtUvC6Xo+mB1kY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhwXwmfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhwXwmfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F4A1F000FF;
	Thu, 10 Sep 2026 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045925;
	bh=ryyNJKDIk+8TBZ/PvOQH6/Aoo7Gqq0vOG/86KC2fpDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhwXwmfpJM3CnYgXDGwt5ZIOF6CXD2GfKS855lblrONI8GChz6e7f/E+sucJJuxGB
	 nCVZYtnbo9w0E4MGJDW3lhKHhTEJRaWQk2cZk2AkcgJtRNAD6meMStGS45ebq4qSyJ
	 VOUco4T5vhiTfiiK41W8jNNWjxJMmusxzOxWjgCBo04UT8wC1MoQEaR90OLZrskUCP
	 xFp3gW4+/XzjzOCoJGoHJI03j/YQqoZTbVZeh5AhMSnSx4sIFACMlNhK7fwqrBhRrI
	 BY7jqcyUuW5ymNIQEompJF1Q/U8tli9ARriLldNqAdmGwpuCcQOkKceuifbSsWn01K
	 Yg2ZyA2Ul6NsQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/5] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <20260910125817.223354-3-cui.tao@linux.dev>
References: <20260910125817.223354-1-cui.tao@linux.dev>
 <20260910125817.223354-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:12:04 +0000
Message-Id: <20260910131204.E0F4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test fails to restore the system's global device state if `r=
eadback_model()` fails, causing a resource leak and polluting the system co=
nfiguration.
- [Low] Usage of the deprecated CHECK() macro causes a build error due to a=
 missing 'duration' variable, and violates subsystem guidelines.
--

commit 259f7c8970e8f40f2ac352cd5f7eefb63642bf71
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

Add an example cost model implementing the full builtin linear HDD
formula at double cost, including flush pricing, and a runner which
registers it as a struct_ops and binds it to a device through
io.cost.model with "model=3Diocost_2x", verifying the readback and
restoring "model=3Dlinear" afterwards.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..e9344b13fba98
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> @@ -0,0 +1,193 @@
[ ... ]
> +static int bind_model(const char *dev, const char *name)
> +{
> +	char buf[300], got[64];
> +	int err;
> +
> +	snprintf(buf, sizeof(buf), "%s model=3D%s\n", dev, name);
> +	err =3D write_cost_model(buf);
> +	if (err) {
> +		CHECK(false, "write_model", "write model=3D%s: %s\n", name,
> +		      strerror(err));

[Severity: Low]
Does this code cause a build failure? The deprecated CHECK() macro requires=
 a
'duration' variable in scope, which appears to be missing in bind_model().

Could we use the modern ASSERT_*() macros instead to avoid this build error
and adhere to current selftest guidelines? (This macro is also used further
down in this function).

> +		return -1;
> +	}
> +	err =3D readback_model(dev, got, sizeof(got));
> +	if (err || strcmp(got, name)) {
> +		CHECK(false, "readback_model", "got model=3D%s want %s\n",
> +		      err ? "(none)" : got, name);
> +		return -1;
> +	}

[Severity: Medium]
Does this early return fail to restore the global device state?

If readback_model() fails or returns a mismatched value, the function retur=
ns
early and skips the teardown logic below that restores the 'linear' model.

This leaves the test BPF program actively bound to the system's block device
via sysfs. Because the kernel block layer holds a reference to the active
model, the BPF program cannot be unloaded when destroying the skeleton,
altering system-wide block IO behavior indefinitely.

> +
> +	/* restore the builtin linear model; the write is checked too */
> +	snprintf(buf, sizeof(buf), "%s model=3Dlinear\n", dev);
> +	err =3D write_cost_model(buf);
> +	if (err) {
> +		CHECK(false, "restore_linear", "write model=3Dlinear: %s\n",
> +		      strerror(err));
> +		return -1;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910125817.2233=
54-1-cui.tao@linux.dev?part=3D2
