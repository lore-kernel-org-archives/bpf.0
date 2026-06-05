Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB151A6800
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698533; cv=none; b=S6NAfPKLt/bIKSc9/b7iEJ32Ld7YeQEF4wBnSv1fmWKhIgeW3Y5TQwjSNXHiIHAZZV7ddqh9OV5TvDH/KJHxqX6vjKiqKCE/ZDMAQO2lJuKOcGi3LRIIp5YMc2sn28F16Bd6X8TBTy3KDGeAMcxhrgkK/1gMB4UTApSyi6lpKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698533; c=relaxed/simple;
	bh=PfvHwhDsr6cJ+D1Xx2guqHi6z071UjQM9f/l/h998SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X2rMiMNGRF46/Y43WA0gO4VwQZ3JYJkgtaFRnP0kEsRVlexHKhMa+VH5ZK94VAfWuOpU+XlMGfXI+TJ98FqzD74Y6cEDXpWHArxllqybJ5tvYzmaE/3fTzBBHw34BAPMeqhE5zWAcC4yI/PxsRBdmS/lhXeqZ/fmGjjCmHL6upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ8XAmf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ8XAmf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9351F00893;
	Fri,  5 Jun 2026 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698532;
	bh=WQMIKoBaYSqxmz4YmS9ZR58+hULa4Qu1FtbLdq96M7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZ8XAmf4u8R5mNfXXc4Jxz12KVhUv38v038iBrzJ/gTiNi7rhbO0s6pDrcJW3v3sU
	 XLa6slo+HVe7XIA8E7M7q+hwfS13sORdJFLiB3+nBoy/vKYDzyYOo0KI+VRsUzG5cL
	 A5iqjZR+hQC7NNIidU1kLm5/cnbNrY+Bp+18t4MMz+pmBRqfurlLD8v1CCqTppzwB7
	 8+7VnYCy0UkUqHWjbbh2e2LzWyzKqZD2X+XvPvcUxseuG6rNwFArPqF4yjR2lxRPtA
	 jzkfv826zi+04vgAyGHrTmUg4/qt9equ2by+QpqU67HvK1lwn6yWKP+YXGtphdOqQe
	 2tdonY6S/PJOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: libarena: parallel test
 harness and spmc parallel selftest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605222020.5231-4-emil@etsalapatis.com>
References: <20260605222020.5231-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:28:51 +0000
Message-Id: <20260605222851.EF9351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing file descriptor (FD) validation after manual program loo=
kups.
--

commit f9cb27c914dcd0d4f6eca457c86b2aac266e34a4
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: parallel test harness and spmc parallel selftest

Add a parallel test for the SPMC Lev-Chase workstealing queue. The queue
is built to be wait-free even when there are multiple consumers, and
the parallel selftest provides a signal on whether the queue behaves
correctly when stress tested.

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index 81bdb084c2715..aa2070f8be825 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> @@ -27,6 +27,177 @@ static void run_libarena_test(struct libarena *skel, =
struct bpf_program *prog,
> =20
>  }
> =20
> +static void *run_libarena_parallel_prog(void *arg)
> +{
> +	struct bpf_program *prog =3D arg;
> +
> +	return (void *)(long)libarena_run_prog(bpf_program__fd(prog));

[Severity: Medium]
Should we validate the file descriptor returned by bpf_program__fd here?

The program is manually looked up via bpf_object__find_program_by_name
in run_libarena_parallel_test_workers before being passed to this thread
worker. When using manual lookups instead of auto-generated skeleton fields,
the program pointer could be valid while the underlying program is invalid,
resulting in a negative FD.=20

An ASSERT_GE check for the file descriptor could prevent unexpected behavio=
r.

> +}
> +
> +/* Max suffix is ceil((lg 2^32) / (lg 10)) + sizeof("__") =3D 10 + 2 =3D=
 12. */
> +#define MAX_PARTEST_SUFFIX (12)
> +#define MAX_PARTEST_NAME (1024)
> +#define MAX_PARTEST_PREFIX (MAX_PARTEST_NAME - MAX_PARTEST_SUFFIX)
> +
> +static int run_libarena_parallel_fini(struct libarena *skel, const char =
*name,
> +				      size_t prefixlen)
> +{
> +	char tdname[MAX_PARTEST_NAME];
> +	struct bpf_program *fini_prog;
> +	int ret;
> +
> +	ret =3D snprintf(tdname, sizeof(tdname), "%.*s__fini", (int)prefixlen, =
name);
> +	if (!ASSERT_LT(ret, sizeof(tdname), "partest fini name"))
> +		return -ENAMETOOLONG;
> +
> +	fini_prog =3D bpf_object__find_program_by_name(skel->obj, tdname);
> +	if (!ASSERT_TRUE(fini_prog, "partest fini prog"))
> +		return -ENOENT;
> +
> +	ret =3D libarena_run_prog(bpf_program__fd(fini_prog));

[Severity: Medium]
Does this missing file descriptor check risk passing a negative FD to
libarena_run_prog?

Similar to the above, we manually look up fini_prog. Checking the return
value of bpf_program__fd with ASSERT_GE before using it would align with
the BPF selftest guidelines for manual lookups.

> +	ASSERT_OK(ret, tdname);
> +
> +	return ret;
> +}

[ ... ]

> +static bool libarena_parallel_test_enabled(struct libarena *skel,
> +					   const char *prefix,
> +					   size_t prefixlen)
> +{
> +	struct bpf_program *prog;
> +	char progname[MAX_PARTEST_NAME];
> +	int ret;
> +
> +	ret =3D snprintf(progname, sizeof(progname), "%.*s__enabled", (int)pref=
ixlen,
> +		       prefix);
> +	if (!ASSERT_LT(ret, sizeof(progname), "partest enabled name"))
> +		return false;
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, progname);
> +	if (!prog)
> +		return true;
> +
> +	ret =3D libarena_run_prog(bpf_program__fd(prog));

[Severity: Medium]
Should we verify that the FD returned by bpf_program__fd is non-negative
before executing it?

Because progname is dynamically constructed and manually looked up, we do
not have the same FD validity guarantees as we do for auto-generated
skeleton fields.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605222020.5231=
-1-emil@etsalapatis.com?part=3D3
