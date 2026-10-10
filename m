Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017882F7F0A
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609643; cv=none; b=thBEW+9V6G3M+5VyjMrLyHnFHrc/tCvBySXPqcfQTE9i0IAellwAUAdjEy1y43LnbsDUPtz99Kv81Ga8MqBCW9ONFGb7Zwn4XV3dnNqWGpE0DfaIHRA3YuPKerwMadT6b/RVwSA0LTYv6WgS2PRjyifmYYtL63xnITUL24cLMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609643; c=relaxed/simple;
	bh=XMwS2YXlDU7Fp1Xs/tKOk3io5m8yp9aOGObGFPtNSeg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WgOdNwGVLToVGCYyJ/l738GSG18thr8nAg07Y+DsLlvhruvO1H4hsbwbqAAGcxYygdGdU6Sm2NUSJm5NF2vcuCO538krD5Cgxucm8sc7P7W24F/DOzuDtWAPyxCKMeTM1Dbx0+oYcy3dMm/82FTS3qNCCJJUJc2MbDF6knO5AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4zHUuhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4zHUuhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D354A1F000FF;
	Sat, 10 Oct 2026 05:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609641;
	bh=jMJTy6OTbENKP8xMI+4JWP16frs8g4p+/FjdYqAyvzM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=b4zHUuhjQRBWpfOgJpe+zQ1DeJuSw2j/BaxjGhUYaPerdGoxhxsymH67MdEWd1o6N
	 PcT5HlmCr2+vKiKNzUaRmSEejRMWDviXDCTucOSa50tlpv8pPYO72HVzpH8OYi9stF
	 w77mhjIOFtJU2Djw+HYhV5mHOIjlwK6F4U4B7eOujMTCeijkuGn92hGrePUlos+T1X
	 A2552EhTKlJiWWiuf1vYjDlYJ2YDxYJ6FRtje2Qhpc4jkEijOFWAjY8NtBjqnSq4Ft
	 otd+RfbM0fzzyekk9cjJUnxWQs2Di50QpB8flE0iQoNv4acvzpX6z2cZT9GZlRh3nw
	 +Ip2e3Jp1fSMw==
Content-Type: multipart/mixed; boundary="===============0289728930593542809=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e1a4144b2d8dd516b343bd0e58bbae6cc6a8b5f29fbe057b95a2b5e0eb9d4d3@mail.kernel.org>
In-Reply-To: <20261010042132.137430-5-luyun_611@163.com>
References: <20261010042132.137430-5-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add task work BUSY window test
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 10 Oct 2026 05:20:39 +0000 (UTC)

--===============0289728930593542809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add task work BUSY window test

TL;DR: Test issues only, no kernel bug: the /sys/kernel/realtime PREEMPT_RT
check looks dead (kconfig could skip earlier); helpers duplicate the race
test; unused counters; redundant fprintf()s.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> index f9fd9adddfe6..eb0fe51617c5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c

[ ... ]

> @@ -436,3 +438,563 @@ void serial_test_task_work_race(void)

[ ... ]

> +/*
> + * Positive confirmation of PREEMPT_RT only: not every RT kernel provides
> + * this file, and its absence proves nothing.  The definitive check for
> + * such kernels is the irq_work thread observation inside the BPF program.
> + */
> +static bool task_work_busy_rt_confirmed(void)
> +{
> +	char buf[2] = {};
> +	int fd, n;
> +
> +	fd = open("/sys/kernel/realtime", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return false;
> +	n = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	return n > 0 && buf[0] == '1';
> +}

A subsystem pattern flags this as potentially concerning: the selftests
guidance is to reuse existing shared test helpers instead of hand-rolling
file I/O for something that is already provided.

Does any in-tree code provide /sys/kernel/realtime?  Nothing under kernel/
or init/ in this tree defines it, so task_work_busy_rt_confirmed() would seem
to always return false, and the early skip in serial_test_task_work_busy()
would never fire.  The comment above the
function says "not every RT kernel provides this file", and the commit
message says the flag is used "when present".

On a PREEMPT_RT kernel the test would then only skip after
task_work_busy_wait_window() has polled for TASK_WORK_BUSY_POLL_ITERS *
TASK_WORK_BUSY_POLL_US (more than 2s) and task_work_busy_run_attempt() has
returned TWB_RT.  The end result is still a skip, so this looks like a dead
check plus a delay rather than a wrong result.

bpf_experimental.h already declares:

    extern bool CONFIG_PREEMPT_RT __kconfig __weak;

and other prog_tests read kconfig externs through the skeleton, for example
stacktrace_ips.c:

    if (!skel->kconfig->CONFIG_UNWINDER_ORC) {

Would a kconfig extern in progs/task_work_busy.c, checked through
skel->kconfig after task_work_busy__open_and_load(), let the test skip up
front instead?

> +static int task_work_busy_status(struct task_work_busy *skel, int idx,
> +				 __s64 *value)
> +{
> +	return bpf_map_lookup_elem(bpf_map__fd(skel->maps.status), &idx,
> +				   value);
> +}
> +
> +static int task_work_busy_set_status(struct task_work_busy *skel, int idx,
> +				     __s64 value)
> +{
> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.status), &idx,
> +				   &value, BPF_ANY);
> +}

this isn't a bug, but task_work_busy_status() and
task_work_busy_set_status() look identical to task_work_race_status() and
task_work_race_set_status() earlier in this file, apart from the skeleton
type.

The same applies to other pieces: struct task_work_busy_value has the same
layout as struct task_work_race_value, TASK_WORK_BUSY_POLL_US,
TASK_WORK_BUSY_POLL_ITERS and TASK_WORK_BUSY_START_POLL_ITERS have the same
values (100/20000/50000) as the TASK_WORK_RACE_* macros, and
task_work_busy_wait_seq() repeats the polling logic of
task_work_race_check_done().

Both skeletons expose a status map with the same key and value types.  Could
both tests share helpers that take the status map (or its fd) and a shared
set of poll constants instead?

[ ... ]

> +	if (!ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_WINDOW, &stat_window),
> +		       "window stat") ||
> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_TOTAL, &stat_total),
> +		       "total stat") ||
> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_FILTERED, &stat_filtered),
> +		       "filtered stat") ||
> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G1_RETRY, &stat_g1r),
> +		       "gen1 retry stat") ||
> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G2_RETRY, &stat_g2r),
> +		       "gen2 retry stat"))
> +		goto cleanup;

this isn't a bug, but are BUSY_STAT_ACK_SEEN and BUSY_STAT_TIMEOUT meant to
be read here?

The fexit program in progs/task_work_busy.c bumps both counters for every
closed window, and enum task_work_busy_stat mirrors them, but this function
reads and prints only WINDOW, TOTAL, FILTERED, G1_RETRY and G2_RETRY.  A
grep of tools/testing/selftests/bpf finds no userspace reader for ACK_SEEN
or TIMEOUT.

Could ACK_SEEN be checked against valid and TIMEOUT against missed (or both
added to the summary line below), or can they be dropped from both enums and
the BPF program?

> +	fprintf(stderr,
> +		"task_work_busy: %d/%d valid, %d missed, %d attempts, max_wait %lld ns, windows %llu, adds %llu, filtered %llu, g1_retries %llu, g2_retries %llu\n",
> +		valid, TASK_WORK_BUSY_ROUNDS, missed, attempts_started,
> +		(long long)max_wait_ns, (unsigned long long)stat_window,
> +		(unsigned long long)stat_total,
> +		(unsigned long long)stat_filtered,
> +		(unsigned long long)stat_g1r, (unsigned long long)stat_g2r);

[ ... ]

> +	if (!hard_fail) {
> +		if (!ASSERT_EQ(stat_window, (__u64)(valid + missed),
> +			       "window accounting"))
> +			fprintf(stderr,
> +				"windows entered %llu, valid %d, missed %d\n",
> +				(unsigned long long)stat_window, valid, missed);
> +		if (!ASSERT_GE(stat_total, (__u64)(2 * valid),
> +			       "task_work_add calls seen"))
> +			fprintf(stderr,
> +				"only %llu task_work_add calls for %d valid rounds\n",
> +				(unsigned long long)stat_total, valid);
> +		if (valid != TASK_WORK_BUSY_ROUNDS)
> +			fprintf(stderr,
> +				"busy coverage: %d/%d valid, %d missed in %d attempts\n",
> +				valid, TASK_WORK_BUSY_ROUNDS, missed,
> +				attempts_started);
> +		if (!ASSERT_EQ(valid, TASK_WORK_BUSY_ROUNDS,
> +			       "valid busy windows"))
> +			goto cleanup;
> +	}

this isn't a bug, but could the three conditional fprintf() calls in the
!hard_fail block be dropped?

The summary fprintf() just above already reports valid,
TASK_WORK_BUSY_ROUNDS, missed, attempts_started, stat_window and stat_total,
and ASSERT_EQ() and ASSERT_GE() print the actual and expected values on
failure.  The "busy coverage" message also re-tests the same condition as the
ASSERT_EQ() that follows it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38024809478
--===============0289728930593542809==--
