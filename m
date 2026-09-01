Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52027488211;
	Tue,  1 Sep 2026 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283341; cv=none; b=Fxn6UL84cbNnbX9bI58VOz4mos7eWOtNUnbGv6PlWs2ZEuYNq9fsMiL/isEr23FFW4NjFqppb16dqNaGg9yJrXHR+YDNS8pL5njMK7cMfqy2O8x9SqeApG+7+BjIzmcH8K7RWxyioRpoYeeXEEj6FSfNSxig2XAa/ETIvoLpdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283341; c=relaxed/simple;
	bh=wvMJR/pVvmvUQB9or3iSeQpdUXx8+3V1Bm+JelxSuZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8moiWu7xlmMwgEnx/vYxNZvti5HUplg6UvsTKPMjfX02n3gRV+qcmpHHe1Y93UkoNJNPQYV+UdJKopWhdYzru3EkEMelVPj6DVe/+5mvUsI0db8LXzwNDOT3UvHH9mpuX95XxJSsy7NOgYd1UHOEcx25wkPur07KrGmpPSAQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMQRZmc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMQRZmc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4E1F00A3A;
	Tue,  1 Sep 2026 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283340;
	bh=N+bu/zQ8qcaMGTKhcUpjVMJUs3r4r4ts/+kJZ0QpGSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMQRZmc3GsDqC6X++/5ZwbGY3af4W0G2EvO8UbAwc5rbjo5XlqjC7oYifJx63GQ1D
	 MoWtOiG7hgACIx5/YexqfsZmGKvYxJBivoxtLVbfdJWb2ivOqihp7Pp6JK0nDyUBfl
	 66GbNXWKuiK9jnDlTiuU7tPtvg/Ku2ribeRUQgi2Us5Ve0G3pOE46NwWuN0e/Mz3eZ
	 0yzprzS46qbrtDM4qgVWMmKsmbSEF1va7l8yONjZjwZuEBbyEwvQZ9O9rblrvCGQ5a
	 lXndrNnaomZpiaotv7ai3z65z4GPnAM3aMnGeNuxC8ORZ98GbuL7IQvA4NePylUnFU
	 etaDINieyn6Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 17/18] selftests/bpf: Test BTF sysfs inline
 representations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-18-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-18-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:22:19 +0000
Message-Id: <20260901172219.B6F4E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of `module_btf` when a module does not have a corres=
ponding `.inline` sysfs file.
--

commit ae17979b11eeb1a7bef7bec7a8817be3cb2cd64a
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test BTF sysfs inline representations

This commit adds a selftest to validate BTF sysfs inline representations for
the kernel and modules. It parses the base BTF, module BTF, and inline BTF=
=20
files to ensure proper loading and relocation across different scenarios.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_sysfs.c
> index 3923e64c4c1d0..97eccfd7c1344 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
[ ... ]
> +static void test_btf_inline_sysfs_all(void)
> +{
[ ... ]
> +	while ((dentry =3D readdir(dir)) !=3D NULL) {
[ ... ]
> +		if (!base_btf) {
> +			module_btf =3D btf__parse_split(btf_path, vmlinux_btf);
> +			err =3D libbpf_get_error(module_btf);
> +			if (err) {
> +				/* A module can be unloaded while its sysfs entry is iterated. */
> +				if (err =3D=3D -ENOENT)
> +					continue;
> +				ASSERT_OK(err, "parse_module_btf");
> +				continue;
> +			}
> +			base_btf =3D module_btf;
> +		}
> +		if (stat(inline_path, &st)) {
> +			err =3D errno;
> +			if (err =3D=3D ENOENT)
> +				continue;

[Severity: Medium]
Does this code leak module_btf?

In test_btf_inline_sysfs_all(), when a module is parsed successfully but
lacks a corresponding .inline sysfs file, stat() fails with ENOENT and this
path calls continue. Since this ends the loop iteration early, the
btf__free(module_btf) at the bottom of the loop is bypassed.

> +			ASSERT_OK(err, "stat_inline_btf");
> +		}
> +		inline_btf =3D btf__parse_split(inline_path, base_btf);
> +		err =3D libbpf_get_error(inline_btf);
> +		if (!err)
> +			btf__free(inline_btf);
> +		ASSERT_OK(err, "parse_inline_btf");
> +		btf__free(module_btf);
> +	}
> +	closedir(dir);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D17
