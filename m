Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2244062D;
	Thu, 27 Aug 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830677; cv=none; b=KInT9ZmK887pYpSMdyv5pozM5x/7XvnaYH8r6HFi3jv4kzpl+AmlSMM7TXyxCu1l3wEYBduXU/BWfzw5pUAJPK9RAAhdWM0sIjX8Xv9CA3rZ/gduJUPmuGIsvMqgQw3VxPV/FTbUjIW4oQDMD/iFajbWmtIpSk5iwDdESsgI33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830677; c=relaxed/simple;
	bh=aECcC3gzgPCmUFC37KnXxUL+ASmvA2eLAUPJl4Y8whw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M/FYRBQrx49WDcHwJlT5SIqpNEFIyc3CTSShkbq1KD7EgEAVv16RxfN6mtQ1wkNIsGvVbV8FtNF2jBvvArhN6ks9UA7OhyrkCjYjJZaCU91aLzX0lxwBjfi+Hw+dbf3WlXs02VOHTu+Dt/imo01ZQRUvAPpVEALtYhxHAtjoSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzNuv0DX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzNuv0DX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691341F00A3A;
	Thu, 27 Aug 2026 11:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830675;
	bh=q3ywZN8bdBnVFQ78mtRW6DYA4krBtKE/BGQc0bJoxdY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VzNuv0DXTALl+ro/Z5WmFFyK5GI+zLD63Uv4qBj8ALg/lbrssRK9yB7qQQ6EYpK2b
	 Jjaa+l3a4xC2YZlPP6TWA/uVglqJloVCfL8dgNoit8LZq3Uy1/QHtvqW+JB7b3kD6E
	 zhYQR9JT3RIR5Cs2p1hP4vOljzifxNnliPeo3hfzMG1WkI75mMujwg4AlJGI9AvrdX
	 L1MDopuK20STnHnTi1HOZBFT35x2FnNbekcVRy5UGoAYCED3HsxJEO3hTMwh/0KcV7
	 wraz0R3uHsA5TvtMsdB+lDYYWY1OD+dnEGbHdPKcDDZbiX94T6aD3/Qg6hwCjAQA4k
	 EdWUMFyR9PFuQ==
Content-Type: multipart/mixed; boundary="===============1642768360297098272=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32fbad9bf062c3b987defaa53cb5f3bf48bbdb87c35013fe7a0923b1caf3927b@mail.kernel.org>
In-Reply-To: <eec9160b702fd6d65631a34f0945230e0845d12b.1787826402.git.zhuhui@kylinos.cn>
References: <eec9160b702fd6d65631a34f0945230e0845d12b.1787826402.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add memcg async reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 11:37:55 +0000 (UTC)

--===============1642768360297098272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..1270d73c9116e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +	wait_ret = waitpid(low_pid, &status, 0);
> +	if (!ASSERT_GT(wait_ret, 0, "low waitpid"))
> +		goto cleanup;
> +	/*
> +	 * The child has been reaped and its PID can already be reused,
> +	 * so mark it to keep cleanup from signaling an unrelated process.
> +	 */
> +	low_pid = -1;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "low exited"))
> +		goto cleanup;
> +	if (WEXITSTATUS(status) != CHILD_EXIT_OK) {
> +		PRINT_FAIL("low child failed at: %s (exit status %d)",
> +			   child_exit_str(WEXITSTATUS(status)),
> +			   WEXITSTATUS(status));
> +		goto cleanup;
> +	}
> +
> +	wait_ret = waitpid(high_pid, &status, 0);
> +	if (!ASSERT_GT(wait_ret, 0, "high waitpid"))
> +		goto cleanup;
> +	/* Same as above: the reaped PID must not be signaled again. */
> +	high_pid = -1;
> +	if (!ASSERT_TRUE(WIFEXITED(status), "high exited"))
> +		goto cleanup;
> +	if (WEXITSTATUS(status) != CHILD_EXIT_OK) {
> +		PRINT_FAIL("high child failed at: %s (exit status %d)",
> +			   child_exit_str(WEXITSTATUS(status)),
> +			   WEXITSTATUS(status));
> +		goto cleanup;
> +	}

The three PRINT_FAIL() calls in run_high_low_workload() omit the trailing
newline, so the failure messages run into whatever is logged next.
PRINT_FAIL() in test_progs.h does not append a newline:

#define PRINT_FAIL(format...)                                                  \
	({                                                                     \
		test__fail();                                                  \
		fprintf(stdout, "%s:FAIL:%d ", __func__, __LINE__);            \
		fprintf(stdout, ##format);                                     \
	})

Since test_progs hijacks stdout into an open_memstream() buffer that is
dumped verbatim, the missing newline concatenates these lines with the
following log output. The dominant convention in prog_tests/ is to
terminate the format string (33 of the ~44 PRINT_FAIL() call sites end
in "\n").

Should these three PRINT_FAIL() calls (the two shown above and the one
after the high_time/low_time comparison) end with "\n"?

> diff --git a/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..b2ca5185150fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

[ ... ]

> +static int reclaim_cgroup(u64 cgroup_id)
> +{
> +	struct cgroup_memcg cm;
> +	int i;
> +
> +	if (get_cgroup_memcg_from_id(cgroup_id, &cm))
> +		return 0;
> +
> +	reclaim_calls++;
> +	for (i = 0; i < RECLAIM_MAX_ITER; i++) {
> +		u64 nr = bpf_proactive_reclaim(cm.memcg, RECLAIM_SIZE);
> +
> +		if (!nr)
> +			break;
> +		reclaimed_bytes += nr;
> +	}
> +
> +	put_cgroup_memcg(&cm);
> +
> +	return 0;
> +}

This isn't a bug, but reclaim_cgroup() is declared to return int but
returns 0 on every path, including the lookup-failure path, and its only
caller discards the value:

reclaim_work_fn() {
	...
	if (should_reclaim_cgroup(...)) {
		reclaim_cgroup(wq_low_cgroup_id);
		bpf_wq_start(&elem->work, 0);
	}
	...
}

The failure to obtain the memcg is therefore indistinguishable from
success. The file already uses void where a helper has no result
(put_cgroup_memcg), so would it make sense to make reclaim_cgroup() void,
or to return -1 on the lookup failure and react to it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33064477499
--===============1642768360297098272==--
