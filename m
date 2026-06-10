Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921E3290C9
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103047; cv=none; b=YM0gYv38GuUIl3IF2To1ZGEs6kVbTWjQvV9r5lNmj4iaCo7NNP0YQJCuafQ0XTlYRc1uS0vuqY2zpwyg7h2Cly/SuHkjkYL5Ze11fysSzsx55MzUVt5N4JLDzTv/xPyuwKhzbu/yQGdN7p7M2RDezTG7CHndzqInb6JE6ZMExtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103047; c=relaxed/simple;
	bh=bwjOrdwOq6GBr2rSKLojDESFkX457LTwh9tp9RsZS/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIvrrOKx9Tp1mxeiUL6igPLoY/YbNJkfMaQPypg+UxRkiKElwjbFAymdqbIVveBuR93BxZgg58JM/v1WTBYZMDEOIl/emHnrCAqbIeU2mL+VtZDoFq332aDXITLsrPUGEqYhgiRrnUy714H6t9Qg5SM+kC4Z5dFFcfXTtej80T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9o2G+Bc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9o2G+Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3D11F00893;
	Wed, 10 Jun 2026 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103046;
	bh=UnSzCGwE7kJeN0Dotnn8VSjr1oJyqj61jMscNsFxQ34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9o2G+Bc2xZEW2Is0ce9MOpyN+YwCeMFF/qlSEuTLo6rem6MUrbWUb5AEICbkBKft
	 dvGPjV6GzbPGCA+pVkcdibrMf+PoJpWszOTaZkFfOyXp0ClThy5yoRGQrcuU+JiXow
	 VL2oSbS3vAX74y2Qb8H4NEP4UD/L3bKReYhvsq8GCzFdoHfkJKingpZ086wJSKYliU
	 ultMECeQjjkk3f2RX62QKG6nOWTDDrygbG7SBlIlcQb9qGPQ+BiwNrqlh0SCGxcowb
	 H+1I2Q8JpHZnTO46xUNxvY3AuAsgm+edwB5JqGPo0plWj3HrZeu1eKIOeo2QaCVuhl
	 qk/9KSQWVtWsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 4/6] selftests/bpf: Add uprobe_multi path_fd
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610143627.804790-5-jolsa@kernel.org>
References: <20260610143627.804790-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 14:50:45 +0000
Message-Id: <20260610145046.1D3D11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The selftest references a nonexistent struct member `path_fd` and a=
n undeclared flag `BPF_F_UPROBE_MULTI_PATH_FD`, which will cause a compilat=
ion error.
--

commit e5937d581d08ece9671b371d37fb6cd0d497b692
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add uprobe_multi path_fd test

This commit adds a uprobe_multi link API selftest that opens /proc/self/exe
and passes the resulting descriptor through opts.uprobe_multi.path_fd with
BPF_F_UPROBE_MULTI_PATH_FD set.

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 56cbea280fbd2..ffcf3c92f0474 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c

[ ... ]

> @@ -757,6 +758,65 @@ static void test_link_api(void)
>  	__test_link_api(&child);
>  }
> =20
> +static void test_link_api_path_fd(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +	const char *resolve_path =3D "/proc/self/exe";
> +	int prog_fd, link_fd =3D -1, path_fd =3D -1;

[ ... ]

> +	path_fd =3D open(resolve_path, O_RDONLY);
> +	if (!ASSERT_GE(path_fd, 0, "path_fd"))
> +		goto cleanup;
> +
> +	opts.uprobe_multi.path_fd =3D path_fd;
> +	opts.uprobe_multi.offsets =3D offsets;
> +	opts.uprobe_multi.cnt =3D ARRAY_SIZE(syms);
> +	opts.uprobe_multi.flags =3D BPF_F_UPROBE_MULTI_PATH_FD;

[Severity: Low]
Does this code reference an API that hasn't been introduced yet?

The struct field path_fd is not a valid member of uprobe_multi within
struct bpf_link_create_opts in the libbpf headers, and the
BPF_F_UPROBE_MULTI_PATH_FD macro is undeclared.

Because the patch doesn't include the corresponding kernel or libbpf
changes, it looks like this will cause a compilation error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610143627.8047=
90-5-jolsa@kernel.org?part=3D1
