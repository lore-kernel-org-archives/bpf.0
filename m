Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA4363C5F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775456; cv=none; b=k+NPaT7yepo4TkdYBCAue94rU3ZJUyNKsJAFrE+xfMTzOVecs6bflrUvq6qS8q3OYBdoFNmYdgfw14Z7qJ32mJ39RnZb37SABJkgnZleUAfLFJHH7wx+/HpUVydjJoxY+xFMRFiDfXbQ3zuzJgqjW2sbMC1W5XOUmmjE6/tBLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775456; c=relaxed/simple;
	bh=qKzCG78rXnwbR2+DEJMz0+GB77CFK4ee24UAPrFGHww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNzEvsIYDqo1INXsP2+nDIBVL+bQhc55Vgo73OQQdCDQjYG1nkIxa/S5CEAOoR1Rp1il0GXITkLHkLwjbBIaU+M55BwqCbOLCOuPjr4Z6Wlrk6cI6NmyufJhGQ/uprJGRjxbpN4wShP8eL17Ypuu8N+N7pymsGjtJmYxXG2llrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kjQlrCyR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kjQlrCyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UWkMdGPK/3JbVoiUkSrII657crlwkc5MW0aVWbkT+QQ=;
	b=kjQlrCyRU3G3z9JMSb92Abh/3zX4wM8Ixxl2ZDzwQvtQ7hGwKjI/GAwWgl/pHc
	nQN8vraJ1kGWfGusLKqCE+GzWS8X6DLYcf7d/YvMYmyE8b2tArOLRGW2NDfY9mBG
	57IjHJ1wOLoViM+pjmk2+fBSn+w8ObOeCx+0weAyJbFDE=
Message-ID: <7c72acfa-888e-4674-bf3a-acfd01ac49bf@163.com>
Date: Mon, 12 Oct 2026 11:23:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add task work BUSY window
 test
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org, martin.lau@kernel.org,
 mason@kernel.org
References: <20261010042132.137430-5-luyun_611@163.com>
 <9e1a4144b2d8dd516b343bd0e58bbae6cc6a8b5f29fbe057b95a2b5e0eb9d4d3@mail.kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <9e1a4144b2d8dd516b343bd0e58bbae6cc6a8b5f29fbe057b95a2b5e0eb9d4d3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vyamUsxqLJfVEA--.55483S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr17KrWDAw1fAFyUKw4kZwb_yoW3GFy5pa
	yft345G398JF1UKF47Xa1DuFyFkwnYyas8Crs3Xry7A3Z0qFn3AryxKFyYq34DurWqyF43
	Za1DZFZ3Cw4DXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi9qXAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwiMW2rMUqiYzQAA3V

在 2026/10/10 13:20, bot+bpf-ci@kernel.org 写道:
>> selftests/bpf: Add task work BUSY window test
> TL;DR: Test issues only, no kernel bug: the /sys/kernel/realtime PREEMPT_RT
> check looks dead (kconfig could skip earlier); helpers duplicate the race
> test; unused counters; redundant fprintf()s.

Thanks for the review! All the points look reasonable.

For v7 I'll:
- use the CONFIG_PREEMPT_RT kconfig extern via skel->kconfig to skip
   before attaching, instead of the /sys/kernel/realtime probe;
- share the status accessors, polling helper/bounds and the value
   layout with the cancellation race test;
- drop the unused ACK_SEEN/TIMEOUT counters (and the stats map with
   them) and the redundant fprintf()s.

I will send v7 shortly.

---

Thanks

Yun Lu


>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> index f9fd9adddfe6..eb0fe51617c5 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> [ ... ]
>
>> @@ -436,3 +438,563 @@ void serial_test_task_work_race(void)
> [ ... ]
>
>> +/*
>> + * Positive confirmation of PREEMPT_RT only: not every RT kernel provides
>> + * this file, and its absence proves nothing.  The definitive check for
>> + * such kernels is the irq_work thread observation inside the BPF program.
>> + */
>> +static bool task_work_busy_rt_confirmed(void)
>> +{
>> +	char buf[2] = {};
>> +	int fd, n;
>> +
>> +	fd = open("/sys/kernel/realtime", O_RDONLY | O_CLOEXEC);
>> +	if (fd < 0)
>> +		return false;
>> +	n = read(fd, buf, sizeof(buf) - 1);
>> +	close(fd);
>> +	return n > 0 && buf[0] == '1';
>> +}
> A subsystem pattern flags this as potentially concerning: the selftests
> guidance is to reuse existing shared test helpers instead of hand-rolling
> file I/O for something that is already provided.
>
> Does any in-tree code provide /sys/kernel/realtime?  Nothing under kernel/
> or init/ in this tree defines it, so task_work_busy_rt_confirmed() would seem
> to always return false, and the early skip in serial_test_task_work_busy()
> would never fire.  The comment above the
> function says "not every RT kernel provides this file", and the commit
> message says the flag is used "when present".
>
> On a PREEMPT_RT kernel the test would then only skip after
> task_work_busy_wait_window() has polled for TASK_WORK_BUSY_POLL_ITERS *
> TASK_WORK_BUSY_POLL_US (more than 2s) and task_work_busy_run_attempt() has
> returned TWB_RT.  The end result is still a skip, so this looks like a dead
> check plus a delay rather than a wrong result.
>
> bpf_experimental.h already declares:
>
>      extern bool CONFIG_PREEMPT_RT __kconfig __weak;
>
> and other prog_tests read kconfig externs through the skeleton, for example
> stacktrace_ips.c:
>
>      if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
>
> Would a kconfig extern in progs/task_work_busy.c, checked through
> skel->kconfig after task_work_busy__open_and_load(), let the test skip up
> front instead?
>
>> +static int task_work_busy_status(struct task_work_busy *skel, int idx,
>> +				 __s64 *value)
>> +{
>> +	return bpf_map_lookup_elem(bpf_map__fd(skel->maps.status), &idx,
>> +				   value);
>> +}
>> +
>> +static int task_work_busy_set_status(struct task_work_busy *skel, int idx,
>> +				     __s64 value)
>> +{
>> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.status), &idx,
>> +				   &value, BPF_ANY);
>> +}
> this isn't a bug, but task_work_busy_status() and
> task_work_busy_set_status() look identical to task_work_race_status() and
> task_work_race_set_status() earlier in this file, apart from the skeleton
> type.
>
> The same applies to other pieces: struct task_work_busy_value has the same
> layout as struct task_work_race_value, TASK_WORK_BUSY_POLL_US,
> TASK_WORK_BUSY_POLL_ITERS and TASK_WORK_BUSY_START_POLL_ITERS have the same
> values (100/20000/50000) as the TASK_WORK_RACE_* macros, and
> task_work_busy_wait_seq() repeats the polling logic of
> task_work_race_check_done().
>
> Both skeletons expose a status map with the same key and value types.  Could
> both tests share helpers that take the status map (or its fd) and a shared
> set of poll constants instead?
>
> [ ... ]
>
>> +	if (!ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_WINDOW, &stat_window),
>> +		       "window stat") ||
>> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_TOTAL, &stat_total),
>> +		       "total stat") ||
>> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_FILTERED, &stat_filtered),
>> +		       "filtered stat") ||
>> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G1_RETRY, &stat_g1r),
>> +		       "gen1 retry stat") ||
>> +	    !ASSERT_OK(task_work_busy_stat(skel, BUSY_STAT_G2_RETRY, &stat_g2r),
>> +		       "gen2 retry stat"))
>> +		goto cleanup;
> this isn't a bug, but are BUSY_STAT_ACK_SEEN and BUSY_STAT_TIMEOUT meant to
> be read here?
>
> The fexit program in progs/task_work_busy.c bumps both counters for every
> closed window, and enum task_work_busy_stat mirrors them, but this function
> reads and prints only WINDOW, TOTAL, FILTERED, G1_RETRY and G2_RETRY.  A
> grep of tools/testing/selftests/bpf finds no userspace reader for ACK_SEEN
> or TIMEOUT.
>
> Could ACK_SEEN be checked against valid and TIMEOUT against missed (or both
> added to the summary line below), or can they be dropped from both enums and
> the BPF program?
>
>> +	fprintf(stderr,
>> +		"task_work_busy: %d/%d valid, %d missed, %d attempts, max_wait %lld ns, windows %llu, adds %llu, filtered %llu, g1_retries %llu, g2_retries %llu\n",
>> +		valid, TASK_WORK_BUSY_ROUNDS, missed, attempts_started,
>> +		(long long)max_wait_ns, (unsigned long long)stat_window,
>> +		(unsigned long long)stat_total,
>> +		(unsigned long long)stat_filtered,
>> +		(unsigned long long)stat_g1r, (unsigned long long)stat_g2r);
> [ ... ]
>
>> +	if (!hard_fail) {
>> +		if (!ASSERT_EQ(stat_window, (__u64)(valid + missed),
>> +			       "window accounting"))
>> +			fprintf(stderr,
>> +				"windows entered %llu, valid %d, missed %d\n",
>> +				(unsigned long long)stat_window, valid, missed);
>> +		if (!ASSERT_GE(stat_total, (__u64)(2 * valid),
>> +			       "task_work_add calls seen"))
>> +			fprintf(stderr,
>> +				"only %llu task_work_add calls for %d valid rounds\n",
>> +				(unsigned long long)stat_total, valid);
>> +		if (valid != TASK_WORK_BUSY_ROUNDS)
>> +			fprintf(stderr,
>> +				"busy coverage: %d/%d valid, %d missed in %d attempts\n",
>> +				valid, TASK_WORK_BUSY_ROUNDS, missed,
>> +				attempts_started);
>> +		if (!ASSERT_EQ(valid, TASK_WORK_BUSY_ROUNDS,
>> +			       "valid busy windows"))
>> +			goto cleanup;
>> +	}
> this isn't a bug, but could the three conditional fprintf() calls in the
> !hard_fail block be dropped?
>
> The summary fprintf() just above already reports valid,
> TASK_WORK_BUSY_ROUNDS, missed, attempts_started, stat_window and stat_total,
> and ASSERT_EQ() and ASSERT_GE() print the actual and expected values on
> failure.  The "busy coverage" message also re-tests the same condition as the
> ASSERT_EQ() that follows it.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38024809478

