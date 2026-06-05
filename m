Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADC276049;
	Fri,  5 Jun 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667901; cv=none; b=X9HNyGMbiErgEfF9Dc+JErQ6KnHu5qFZMV+mM69H8Arw132+p0jjzMjDpvJlq47dnGrHJ0GJdbWW1JGiuf8X2XbeMVjUvitmljMBpmuD1cFNotCv5zRVQ0HmNA9jj9+I9PkQJG935cwC19tW7OGf5DkQT6BrQOqJf0cWo4rPMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667901; c=relaxed/simple;
	bh=xrlImWJFzlIaTqN1YuNwP27nkWdDmiAnJPwtTkTW2IM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fefgJHn8dbklzTMty4xyEeeUlHffmQp2VYYEqiGqRZ/6TSgnpZJ4VSpeBJ3iweWfgZRYEs1ClMDdwjwaZCrzcm8+m4i3WwAPGWHlUIefupFKvmX8j39NsFvoRrE9g6AvafO8QsMlFMOA4rGVu091wBc/AM31xU9CfYWSN4/HI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtyJoF/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtyJoF/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6411F00893;
	Fri,  5 Jun 2026 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667900;
	bh=iFiBgihzxTIcIefkmfguY8aCenZkCut06yAd5MnG0e0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LtyJoF/nqHPhRcG1ipl3oWz92LV5ZiMyBvT93yAoKLU41yt1A4oUdP+xKvKBiJQ1M
	 vKW63lXTF8zj01mi+j//uM6ZGl8GKPhcsFr1k8mzl1hL4mbx966rIkVU3f4evSA3pW
	 3Cy3sExB3XK+/sB/sFMDS78JqBtsGHIXlAL2rfQRZbALBxjfzx/fKPtgIlIvWuI2tQ
	 qWs6qE6YZIyVlNyuXPD8vIdsaph6Gi2TTqqpzOLx9zcykD/9dpAQRVbKOao8yyZ9QV
	 sQohotvm0TNiAlr6qx+URufEZpvjXhsgIDsFDekvabG3B3k23pAjwMeT1Qg/IQwMPD
	 +4x5fqbuEA+8w==
Content-Type: multipart/mixed; boundary="===============3883667746176801568=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2477c8e0c9c7bd57d5c396b9486ae1a8b3c4368b779a2911c3f579c4d6696d9e@mail.kernel.org>
In-Reply-To: <20260605130601.2699172-1-mayamatuszczyk@google.com>
References: <20260605130601.2699172-1-mayamatuszczyk@google.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Run test_perf_branches more than 1 time
From: bot+bpf-ci@kernel.org
To: mayamatuszczyk@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com
Cc: mattbobrowski@google.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,mayamatuszczyk@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 13:58:19 +0000 (UTC)

--===============3883667746176801568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> index 0a7ef770c487..153afcdc082e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c

[ ... ]

> @@ -85,19 +76,35 @@ static void test_perf_branches_common(int perf_fd,
> +	/* Make up a bunch of branch events until we time out or bpf prog sets a flag
> +	 * that it caught a valid event. To be completely sure that required_size_out,
> +	 * written_stack_out or written_global_out writes and reads won't get
> +	 * reordered by anyone in a way that would fail this test, use atomic
> +	 * operations
> +	 */

This isn't a bug, but a prior automated review on v2 noted these new
multi-line comments keep text on the same line as the opening /*, while
the BPF subsystem style usually wants the opening /* on its own line.

The same applies to the in-loop comment and the cpu0 pinning comment in
test_perf_branches().

> +	for (i = 0; i < 100000000; ++i) {
> +		/* This technically should be an atomic load with acquire
> +		 * ordering, but we don't want to clog up memory bus while
> +		 * spinning
> +		 */
> +		if (READ_ONCE(skel->bss->valid) > 0)
> +			break;
>  		++j;
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> index 05ac9410cd68..9806414cebc4 100644
> --- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c

[ ... ]

> @@ -40,14 +37,14 @@ int perf_branches(void *ctx)
>  	required_size_out = required_size;
>  	written_stack_out = written_stack;
>  	written_global_out = written_global;
> -	valid = 1;
> +	__atomic_add_fetch(&valid, 1, __ATOMIC_RELEASE);

Does this still emit the intended release barrier in the BPF program?

A prior automated review on v2 raised this and it does not look like it was
answered.  Because the return value of __atomic_add_fetch() is discarded,
the Clang BPF backend can lower this to a relaxed BPF atomic add (without
BPF_FETCH), which on weakly-ordered architectures would carry no release
ordering.

If that happens, could the stores to required_size_out, written_stack_out
and written_global_out be observed by the waiter after the store to valid,
so that the check_good_sample()/check_bad_sample() readers see valid > 0
but read stale outputs?

In this specific test the waiter pins itself to cpu0 and the perf event
follows the task, so the BPF producer and the userspace consumer run on the
same CPU and the reordering cannot actually be observed here.  Is relying on
that co-location intended, or would an explicit fetching/relaxed form make
the ordering contract clearer?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27017486169
--===============3883667746176801568==--
