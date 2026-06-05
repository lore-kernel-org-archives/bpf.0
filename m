Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7117993
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699868; cv=none; b=t5t8Koq0jK6nzq5V3VMKgwkTTeK1FKYpXoAMSfBoy+aMYHGtuNKCaNW2+ZxmeDZr7ZdUFigZmiS9Fb/SNBNDfweXlZex/sHgB8y4pZ7meHz9G2v1h1N9Vi8PjenbWFfMP+/LUbh3J9+9NBERJ6fwBqmXPU8H0rx1cHhD+ddSesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699868; c=relaxed/simple;
	bh=9OCMw2xIQOJsfqyjtKMiS38OMN/oF4vDfjSccubm93Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R2vbtAdQ7Bn/FttaRZjSoMDN4hhbqsrUDOjqccHHx7iaTq1efNVoEe0PrES3cWwEsr+YL3t0GPEjv6tllMJGj/hl6C+3rnRkd5VqkMmr6yQ3EnRUIb8FIgk8Ridioo2Ak/ddzrB1gvTyjkIK/IMSqpHYNOYbPkbrUvjnF1Ftj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfFb5zOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfFb5zOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCEE1F00893;
	Fri,  5 Jun 2026 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780699867;
	bh=55bF8mG33fX9iN6RP3HHsY6i42kIehqEEV3ILZyYoCk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UfFb5zOIm+7fwjoDXJbSNxniV9sM1cfINGG+KNl2Q5f8rrlKiUg5yauDvxq2Ea4GT
	 K/uoAjmkllpamdDmvcDzWGBMLu9o9VFOxO7s1tMJ0ENcTZOlBK69ZDga15Mb909rvK
	 f8HhJokjiGQtmh67s2fpRPsQhVVkj6FpvyAjhTy1bvJJMwCrmneZqd+SC+5s/jfTKi
	 wh4ZyfHd4qyI/jLDgY2+LlB/rrXMtqFyQlZU44cFdUFkH2+ZETjNUE+YA/omRYAI7H
	 p/8KEzci5yCh4vF+3P8dKcM2/PhLm4wfrE7Tqd/spFavL5VqQdnHe3zC9qHJj7zQI+
	 gvfOK6jE3cQIQ==
Content-Type: multipart/mixed; boundary="===============4103406287450130213=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <15333fdfab876e1549045d6e41a3c740a6b90d41231f65b1ae14123afc651f62@mail.kernel.org>
In-Reply-To: <20260605222020.5231-4-emil@etsalapatis.com>
References: <20260605222020.5231-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: libarena: parallel test harness and spmc parallel selftest
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 22:51:06 +0000 (UTC)

--===============4103406287450130213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
> index 81bdb084c271..61ea68dce410 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c

[ ... ]

> @@ -27,6 +27,177 @@ static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
>
>  }
>
> +static void *run_libarena_parallel_prog(void *arg)
> +{
> +	struct bpf_program *prog = arg;
> +
> +	return (void *)(long)libarena_run_prog(bpf_program__fd(prog));
> +}

Should the file descriptor returned by bpf_program__fd be validated here?

Reviewers in v2, v3, and v4 noted that because prog is manually looked up
via bpf_object__find_program_by_name in run_libarena_parallel_test_workers
before being passed to this thread worker, the program pointer could be
valid while the underlying program is invalid, resulting in a negative FD.
An ASSERT_GE check for the file descriptor could prevent unexpected behavior.

> +
> +/* Max suffix is ceil((lg 2^32) / (lg 10)) + sizeof("__") = 10 + 2 = 12. */
> +#define MAX_PARTEST_SUFFIX (12)
> +#define MAX_PARTEST_NAME (1024)
> +#define MAX_PARTEST_PREFIX (MAX_PARTEST_NAME - MAX_PARTEST_SUFFIX)
> +
> +static int run_libarena_parallel_fini(struct libarena *skel, const char *name,
> +				      size_t prefixlen)
> +{
> +	char tdname[MAX_PARTEST_NAME];
> +	struct bpf_program *fini_prog;
> +	int ret;
> +
> +	ret = snprintf(tdname, sizeof(tdname), "%.*s__fini", (int)prefixlen, name);
> +	if (!ASSERT_LT(ret, sizeof(tdname), "partest fini name"))
> +		return -ENAMETOOLONG;
> +
> +	fini_prog = bpf_object__find_program_by_name(skel->obj, tdname);
> +	if (!ASSERT_TRUE(fini_prog, "partest fini prog"))
> +		return -ENOENT;
> +
> +	ret = libarena_run_prog(bpf_program__fd(fini_prog));
> +	ASSERT_OK(ret, tdname);

Does this risk passing a negative FD to libarena_run_prog?

Reviewers in v2, v3, and v4 raised concerns about passing an unverified
file descriptor. Because fini_prog is manually looked up via
bpf_object__find_program_by_name, the manual lookup API can return a
valid bpf_program pointer even if the program failed to load, which
results in a negative FD. An explicit file descriptor validation such
as ASSERT_GE should be added before using the FD.

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
> +	ret = snprintf(progname, sizeof(progname), "%.*s__enabled", (int)prefixlen,
> +		       prefix);
> +	if (!ASSERT_LT(ret, sizeof(progname), "partest enabled name"))
> +		return false;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, progname);
> +	if (!prog)
> +		return true;
> +
> +	ret = libarena_run_prog(bpf_program__fd(prog));

Should the FD returned by bpf_program__fd be verified as non-negative
before executing it?

The reviewer noted in v4 that because progname is dynamically constructed
and manually looked up via bpf_object__find_program_by_name, it does not
have the same FD validity guarantees as auto-generated skeleton fields.
FD validation should be added to prevent passing a negative FD.

> +	if (ret == -EOPNOTSUPP)
> +		return false;
> +	if (!ASSERT_OK(ret, progname))
> +		return false;
> +	return true;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27043406243
--===============4103406287450130213==--
