Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082D2765F5
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993677; cv=none; b=c1iu3zg2uY9aHD9X+CAqBAQF5sWxhvMqdPHh/+2fJZhkfU4ScwpzLbSF3fXtU6p2apTy18C59HI4E4K6aBw9tLNEx60W6y0fkAnZflzlcOmQZdEwF1GTuqJCjglI7NKLkda9lcXvv8kWREZzCtUH1M2sSrKPSzJ4m/DhBDGUNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993677; c=relaxed/simple;
	bh=MmwOC+ULQrf7xZTmrHCZ3FFc5IBXy/LcfkOJ8n65tSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mnK7Du7UHGaoNyQOwb86oUVD8QVhAEU0ozpD5X+5Wd4eE9wOd2Gv5ytFLwFxfZ/nTjLUyBVAYjDShY8lviHViNiEEHn47s+2Q1Bvv5CHm3187qfoZa9QPVNlnknmMesoQMAvdTXZwBwdpjvjGWZ/a+VkcyjUHueSlLNnpwDRuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKDxDh+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKDxDh+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1441F000E9;
	Thu, 28 May 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779993675;
	bh=qbbPpbfgVHcv6iuT+yl230QNt8sSwknsgKLZ6NVMYm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FKDxDh+cg7Dtp0DXWrAbGTsJLE0jp6SSArgaRD7SD5Mm9caTFUzvJwzb3vdEUuPP2
	 SD2I3edmPHT5ozXwJTJ72MzBsD16l+xz9e2ilG7x2Hn/ZGVSfpg7inKcjmYMXoJnVh
	 Z81kEblFB1Q3l6c91j44HXabSjXlXyi+6+uCTGgZ7atIvaeaMDGYy1zb/L3JSYQt15
	 B8V3UZ4g9zOFcgcIaNXKJDFOziX8xMVZJzhjKkAtqBkXEqoU43ylsG41Et8O/dArOG
	 /iAhg02UH67ewel8/yQpmsc/VBzENaoMOHa1ibFtRck4azYAFOaWj+4O3MknpP1Ys/
	 5uee+asosTPIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 08/11] selftests/bpf: Add basic tests for
 resizable hash map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-rhash-v5-8-7205191b6c57@meta.com>
References: <20260528-rhash-v5-8-7205191b6c57@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:41:15 +0000
Message-Id: <20260528184115.AC1441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing file descriptor validation for `bpf_program__fd(prog)` afte=
r retrieving the program via `bpf_object__find_program_by_name()`.
--

commit 85c8ece43292fc1ae20a51c42265be508a83ec61
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add basic tests for resizable hash map
   =20
Test basic map operations (lookup, update, delete) for
BPF_MAP_TYPE_RHASH including boundary conditions like duplicate
key insertion and deletion of nonexistent keys.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testi=
ng/selftests/bpf/prog_tests/rhash.c
> new file mode 100644
> index 0000000000000..69686bf69ba57
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
[ ... ]
> +static void rhash_run(const char *prog_name)
> +{
> +	struct rhash *skel;
> +	struct bpf_program *prog;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err;
> +
> +	skel =3D rhash__open();
> +	if (!ASSERT_OK_PTR(skel, "rhash__open"))
> +		return;
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err =3D rhash__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);

[Severity: Low]
Does the file descriptor returned by bpf_program__fd(prog) need to be
validated here?=20

Since prog was obtained via the manual lookup API
bpf_object__find_program_by_name(), should we verify the fd is valid (>=3D =
0)
using ASSERT_GE before passing it to bpf_prog_test_run_opts()?

> +	if (!ASSERT_OK(err, "prog run"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(opts.retval, "prog retval"))
> +		goto cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-rhash-v5-0=
-7205191b6c57@meta.com?part=3D8
