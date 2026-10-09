Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE73B2AA;
	Fri,  9 Oct 2026 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513468; cv=none; b=hULFEaOyLoC5PzdaE/j8icv2FdsNSk3QdR/mYD+L2C1QtS46LnfRCpOXqmKc0nesl8g3whFkiWVWzA7LCXbFP/j1JYgeWL+sX6PxOMF2FELQgF9ln6GsWGDHpWSlpObMmeeq3p0WABdcONp3yVLxJ3IyrihNulZNivOOpSy0vEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513468; c=relaxed/simple;
	bh=nkxmcpQbB30sOxQhpFULZ3PgROG/KOe4HdGDVr1Af3A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sfBBi/1IDoHr9yHVeXU8IwJHbXicEVuuD8S2LlJeA4pPEC81c/Go7OoDNsf9/U3jGhtCSu8kh7bB4XpgH8g2Aa+WN8hKKydzIddlhWHUCsF8lnTsNlFBKDOWMOG9KvnZvROSb745y23nNwOeIC8YYoOjWj4LCiJNbG8waBzEAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmxQNCx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmxQNCx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA871F000FF;
	Fri,  9 Oct 2026 02:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513467;
	bh=ECWPECOg55vyFl4RvaVtzcf5mpLzZCVvdP85q4yqmJ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OmxQNCx242sjrbQ0AEKBZWgyDgJelPh633m6mbgM/D0Kf68ek1QtxEjcQeCJVuEPC
	 udrZAMLFq4ewHQXG77UGiUo1MZav5JSbwCLVvq2vAY51LP3PVTRRim6tEEXVcQWIf2
	 mFmAnFGDYv9ECzIperz8E4hfwDdvSBU4Qv7I4SCDzJcAvZlgePRkRYJCiuOsDb4O0o
	 3hpPIVVqWa1IMQwBo+S7+CNTEPqtqwIh7oRmZN/FL/XaGiFUCWUcjCmi6Fv0EfuS0b
	 N79IovlMrOAxorbToLZ+yK6//B9zvpqxi/tzg/5IaWZVdrAhWsDrLCZV1Th4HDXKJP
	 k9oM10PotVsDQ==
Content-Type: multipart/mixed; boundary="===============2783192399388812591=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <895e3fd053ba93b849a81ecc54b4aaaf7f244dfdc0f354a01ac6e89a2400bfc3@mail.kernel.org>
In-Reply-To: <20261009-selftests-bpf-libarena-nr-cpus-v1-2-e726ccc66fc6@gmail.com>
References: <20261009-selftests-bpf-libarena-nr-cpus-v1-2-e726ccc66fc6@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Skip libarena on kernels with too many possible CPUs
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 02:37:45 +0000 (UTC)

--===============2783192399388812591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Skip libarena on kernels with too many possible CPUs

TL;DR: Nit only: the libarena selftest skips silently on too many possible
CPUs; suggests printing a reason first, as arena_spin_lock.c does, though
leaving it may be acceptable.

> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
> index daade4150af6..070a08856ee0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c

[ ... ]

> @@ -240,6 +240,15 @@ void serial_test_libarena(void)
>  	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
>  		goto out;
>
> +	/* Skip on kernels with more possible CPUs than arena spin locks support */
> +	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
> +	if (ret == -EOPNOTSUPP) {
> +		test__skip();
> +		goto out;
> +	}
> +	if (!ASSERT_OK(ret, "arena_buddy_reset"))
> +		goto out;
> +

This isn't a bug, but a subsystem guideline flags a test that skips for a
missing capability without printing any reason.

When arena_buddy_reset returns -EOPNOTSUPP, this path calls a bare
test__skip(), so the test log shows SKIP with nothing indicating why.  The
explanation only exists in the source comment above the call.

The sibling prog_tests/arena_spin_lock.c prints a reason before skipping
for the same condition:

    printf("%s:SKIP: CONFIG_NR_CPUS exceed the maximum supported by arena spinlock\n",
           __func__);
    test__skip();

Would it make sense to print a similar message here before test__skip()?

On the other hand, test__skip() takes no message argument, and the existing
skip in run_libarena_parallel_test() for a disabled parallel test is also
bare, so leaving it as is may be acceptable.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37873620927
--===============2783192399388812591==--
