Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70007395266
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984762; cv=none; b=J6w9iM5Em+T4fAtSx7DrRaf4O4AaUEiiv7HhqtyBTn2XQpNU0jeBySYBD1BXWtAOtb+F+lJOMniREseHO8mLsuvj2qlMlK3c8H71NP0LBwHFLaHaXH+FwdFgAbB+62dyIip5GsJ42/VWCPAzo0lQ3Jc5LHKvLhU5dv+f3k2OnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984762; c=relaxed/simple;
	bh=cv9O9L44NMfm9niv48KteLwvLKPA0wTCBy89NWGOOUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=taBUtIjjU7S2Tmav8aJKuIGxBIIUhkt3TPZ/lHX4LorsXe+eN3Z2/w0LAvHm2QnqjnxIC9ftYik95QdLJ22cLGjdWTHnCmQnogUMWc1c9lQqGCm4Pyt2Fw0ku3psBeu4ZGse8JrGkk/FMeJxg2SHlhMR5BLvZQ57QofcVFSCFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k38eUTYV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k38eUTYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA89C2BCAF;
	Thu, 23 Apr 2026 22:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776984761;
	bh=cv9O9L44NMfm9niv48KteLwvLKPA0wTCBy89NWGOOUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k38eUTYVNFvbVvGdJwxsCvf5AzYJG6N7Abs/BbSlPiHewqhSd+IIRVfoPn7Gos9j3
	 +/hPqzBWm3SBfuwv+fzu5AGqziZB9dX/7zEEPV80zsrOUGR5C9EfJ/YgLfdWnSaF9B
	 nuTFoBO0Zy0H7dOjzERAVqgUJPP2EJGPe6uHLRyXhrqA6SwrkuYqTNN/te0MascXS2
	 21ByxiPpDDLUs4Rt1cLVhrKWlIJgZk0yQsLhvu/5IxwHSN5WGmRbnQ4XLUeLgUAWh/
	 CCoZ1u7FzCGz6ZXF4WVZLyTAimgBHE0dEXv95ufjk4PfZV6JEZ7MobIaxlj8xPzkXh
	 RKwPbut8h2bNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for map-stored
 struct file kptrs
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423152239.4140627-3-utilityemal77@gmail.com>
References: <20260423152239.4140627-3-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:52:40 +0000
Message-Id: <20260423225241.3EA89C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] In `copy_file`, closing an invalid file descriptor overwrites th=
e original error code.
--

commit 975d24d408cdf10dcbd5bc80513a92bbedd7dc6f
Author: Justin Suess <utilityemal77@gmail.com>

selftests/bpf: Add test for map-stored struct file kptrs

This commit adds tests for map-stored struct file referenced kptrs. It
validates that the struct file reference remains valid when the original
file descriptor is closed, and checks that unreferenced struct file
pointers are rejected by the verifier.

> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.=
c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
> new file mode 100644
> index 00000000000000..1f2586a7af9365
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c

[ ... ]

> +static int copy_file(const char *src_path, const char *dst_path, mode_t =
mode)
> +{
> +	char buf[4096];
> +	int src_fd =3D -1, dst_fd =3D -1;
> +	int err =3D 0;
> +
> +	src_fd =3D open(src_path, O_RDONLY | O_CLOEXEC);
> +	if (src_fd < 0)
> +		return -errno;
> +
> +	dst_fd =3D open(dst_path, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC,
> +		      mode & 0777);
> +	if (dst_fd < 0) {
> +		err =3D -errno;
> +		goto out;
> +	}

[ ... ]

> +out:
> +	err =3D close(src_fd) ?: err;
> +	err =3D close(dst_fd) ?: err;

If opening the destination file fails, dst_fd is left as -1, and the code j=
umps
here with err set to -errno. Would calling close(-1) here fail and return -=
1,
causing the ?: operator to overwrite the meaningful error code in err with =
-1?

Should the file descriptors be guarded with a >=3D 0 check before calling
close() to prevent masking the true cause of the failure?

> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423152239.4140=
627-1-utilityemal77@gmail.com?part=3D2
