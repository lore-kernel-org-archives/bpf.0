Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6053A8A7;
	Tue, 22 Sep 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076485; cv=none; b=DPa6qpOEOakM2J13ttz7B6r6mbgCUP5PfF0qt/t8ishMvsIG1nG1LQbGTyMx9Fpg7sxhARGqZtvRd6w4w/D4DI01gHfohLJbOEEzmJoNotoYTCfLyaAYZfyY5x9oNVadxCFaug3W0Mu3FDAev6XTtpYiAN6n6v2684/L5UKxGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076485; c=relaxed/simple;
	bh=CheDtPGT6CUHHlaBJ9f3KAka3nMLVUMB6mReXi0hipQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MMCDe1DRCambOJoUD1o/NiOyJzqhE0H4FmjgV3uPN78VoKMlYpDTAI+w6MhmcUy0GsiAt2baDb8wpKv/dgUvW4syRQ8Qhj05lX4bY1ZYvcD52sDNADvCq+zMxLpLeSRCM4uYogXIE2As3rPlPjtPf20VYD/e33bFBljqPT/4EfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqlG5KgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqlG5KgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F61F000FF;
	Tue, 22 Sep 2026 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076483;
	bh=jmt7zs+V/aP1DrWEEkkhmbmYLzFhJlj7okL1TYU2J00=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hqlG5KgVnNK042Ve2Dnah0xoHPOODzk0Qdl4bK0lsru104ycgHcLOEbZ0E9nJyJQq
	 tcRrMzbiwHUrV+aRYGxqg8eP1DcNew8Lj5ZaUcl4Uc3j1mw9T3oQeHdqXGTO4hMZ/+
	 GOaA8yCCSW1W7jRcDpSgBBtGU7MiG9VzTtEcQuIgzZubMh4jkOrUsD2shZ2CQuuRWt
	 YzeLQSEcOGT5dzPp1dHFOo4BOrJ+wH+EsGfDaJ1D+JwEBuiUpRPs1rylJFAJNrb7a9
	 46krrrlfytaMiHb9/IR6BOpYQk5F6bVshZOh5EXHTPQlHzGKWPNF30XrxyF5US6ks8
	 sr9MRyvvn6lOQ==
Content-Type: multipart/mixed; boundary="===============0681645373334310593=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <971df1084475a7ffc9cb1863fb28d7031a56fad62bafc23656dd3a727c92ef30@mail.kernel.org>
In-Reply-To: <20260922101831.192102-4-jiayuan.chen@linux.dev>
References: <20260922101831.192102-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v9 3/3] selftests/bpf: Add a test for arena fault-in under memory.max
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 11:28:01 +0000 (UTC)

--===============0681645373334310593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> new file mode 100644
> index 0000000000000..c76a7eb2f01d9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c

[ ... ]

> +	/*
> +	 * Step 5: fault ARENA_FAULT of arena in, much more than
> +	 * HEADROOM. Once it hits memory.max every further page has to
> +	 * come from reclaiming the page cache. With the fix the
> +	 * fault-in reclaims and all of it succeeds; without it the
> +	 * allocation cannot reclaim and we die on a valid address.
> +	 */
> +	for (i = 0; i < npages; i++)
> +		base[(size_t)i * ps] = 1;
> +	_exit(0); /* fd deliberately kept open until here */
> +}
> +
> +	if (!ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid"))
> +		goto out;
> +
> +	/* The working directory cannot hold a reclaimable page cache. */
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == CHILD_UNSUPPORTED) {
> +		fprintf(stderr, "%s:SKIP:no disk-backed O_TMPFILE in cwd\n", __func__);
> +		test__skip();
> +		goto out;
> +	}
> +
> +	/* A non-zero exit means the child failed to set up; the code says where. */
> +	if (WIFEXITED(status) && WEXITSTATUS(status)) {
> +		ASSERT_OK(WEXITSTATUS(status), "child setup");
> +		goto out;
> +	}
> +
> +	/*
> +	 * With the fix the arena fault-in reclaims the page cache and every
> +	 * fault succeeds, so the child exits 0. Without it the allocation
> +	 * cannot reclaim, fails once the headroom is used up, and the child
> +	 * dies with SIGSEGV on a valid arena address.
> +	 */

This isn't a bug, but since the Step 5 comment 25 lines above already
explains the fixed vs. unfixed outcome (fault-in reclaims and succeeds vs.
allocation cannot reclaim and dies on valid address), would it read better
to keep just one of the two explanations?

> +	if (!ASSERT_TRUE(WIFEXITED(status) && !WEXITSTATUS(status),
> +			 "child faulted the arena in")) {
> +		if (WIFSIGNALED(status))
> +			fprintf(stderr, "child killed by signal %d\n", WTERMSIG(status));
> +		dump_memcg();
> +	}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35716612692
--===============0681645373334310593==--
