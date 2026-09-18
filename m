Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450433A7F4B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722724; cv=none; b=gOP3ZXLhW8IfjrLtkJ4AZcN5WQieoiy3YPF3Gq/g6hRUvvs1oBAXBwe3EgPgkX+xVxLy7AuCCAWg4uTTuGleg+K2ce4RuS+/AEGSRcEOdmE21mDimBp1yKv61rRXBzNyUR6kvrp0JBPQET3rk6hJrPoTDsIqZgLDQLY9swKB8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722724; c=relaxed/simple;
	bh=W5HRxWBoFwrHJISika+Tp4fa+vMLuHYx1UcPZNutiaw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j4EhIU+8A2JUwkUBMDqYs/JlPFEpIRjlxTIhkRT/xbC2uxIxJBaPLVUoLlyvH415g+dDgHWMPXS7QQSVlYji1HlpjIHFguBqWAC2M9sFacPVFXKd0e+aOX5DgVIL/a3ivDkVE9NpPFF466tmf/c2Z9DbTUMNBGu8NWmcFzaZHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3SmGQm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3SmGQm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48071F000FF;
	Fri, 18 Sep 2026 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789722722;
	bh=cRi6NLu4kPzta0aaOwz3SabprnwzXOmevwZK3l9EWOk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K3SmGQm+XYdDfknl97oWZ/0NAMESQwZYMWX04nMDN+8byP36SdRDUq6qbnGAEG32i
	 A6Xv2UImSGHM3PtH5DS6EPNFz8ekYtzpHnrynADjB5kAf3iv1RjtORdTzCOyzOPo6i
	 ligP++QtEhIiMm+ilNrcUemxoXsVK/1eiuXignUTjuXV/HJQhsuuii3RFfpH2yCPmT
	 LT3PRfNfwdse8awLqp9Y5J1bzLNnqFKGvMhoddjsPLsLVeRI9RKwiLpNJ4Yt1wRzaG
	 lY9AbzuMj3H/uEfO1OlUn6b2DWiIW/5ExhZsbivTWcM/fb0jpynr/ODXOesCmBQXSd
	 RLzJAyhhLHRaw==
Content-Type: multipart/mixed; boundary="===============8958580032944694090=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c090f8061c49e646acc2f1e65800b8a15813fecc5dd0d36b0f3913be0c6d47a@mail.kernel.org>
In-Reply-To: <20260918080014.54012-3-luyun_611@163.com>
References: <20260918080014.54012-3-luyun_611@163.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add task work round ownership race test
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 09:12:01 +0000 (UTC)

--===============8958580032944694090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> index 774b31a5f6ca1..6d5e1e97aa3af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c

[ ... ]

> +static int task_work_race_wait_ready(struct task_work_race *skel, __u32 seq)
> +{
> +	int i;
> +
> +	for (i = 0; i < 2000000 / 100; i++) {
> +		__s64 value = 0;
> +
> +		if (!task_work_race_status(skel, RACE_READY_SEQ, &value) &&
> +		    value == seq)
> +			return 0;
> +		if (!task_work_race_status(skel, RACE_DONE_SEQ, &value) &&
> +		    value == seq)
> +			return -EIO;
> +		usleep(100);
> +	}
> +	return -ETIMEDOUT;
> +}

[ ... ]

> +void serial_test_task_work_race(void)
> +{
> +	struct task_work_race_ctx ctx = {};
> +	struct task_work_race *skel;
> +	pthread_t trigger, target;
> +	cpu_set_t allowed;
> +	int cpu, cpu_count = 0;
> +	bool target_started = false, trigger_started = false;
> +	int err, i, key = 0;
> +
> +	if (sched_getaffinity(0, sizeof(allowed), &allowed)) {
> +		ASSERT_OK(-errno, "sched_getaffinity");
> +		return;
> +	}
> +	for (cpu = 0; cpu < CPU_SETSIZE && cpu_count < 2; cpu++) {
> +		if (!CPU_ISSET(cpu, &allowed))
> +			continue;
> +		if (!cpu_count)
> +			ctx.trigger_cpu = cpu;
> +		else
> +			ctx.target_cpu = cpu;
> +		cpu_count++;
> +	}
> +	if (cpu_count < 2) {
> +		printf("%s:SKIP:need two CPUs in the process affinity mask\n",
> +		       __func__);
> +		test__skip();
> +		return;
> +	}
> +
> +	skel = task_work_race__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	if (!ASSERT_OK(task_work_race__attach(skel), "attach"))
> +		goto cleanup;
> +
> +	err = pthread_create(&target, NULL, task_work_race_target, &ctx);
> +	if (!ASSERT_OK(err, "pthread_create target"))
> +		goto cleanup;
> +	target_started = true;
> +	err = pthread_create(&trigger, NULL, task_work_race_trigger, &ctx);
> +	if (!ASSERT_OK(err, "pthread_create trigger"))
> +		goto stop;
> +	trigger_started = true;
> +
> +	while (!__atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE) ||
> +	       !__atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE))
> +		usleep(100);

If neither thread publishes its tid, does this poll terminate?  The
cpu_count < 2 case skips with test__skip(), but if pthread_create()
succeeds yet the thread fails to run or to reach its __atomic_store_n(),
this loop has no iteration cap or timeout so the test would hang rather
than report a failure.

> +	if (!ASSERT_OK(__atomic_load_n(&ctx.setup_err, __ATOMIC_ACQUIRE),
> +		       "thread affinity"))
> +		goto stop;
> +
> +	skel->bss->trigger_tid = __atomic_load_n(&ctx.trigger_tid, __ATOMIC_ACQUIRE);
> +	skel->bss->target_tid = __atomic_load_n(&ctx.target_tid, __ATOMIC_ACQUIRE);

[ ... ]

> +
> +	printf("%s: %d race rounds completed\n", __func__,
> +	       TASK_WORK_RACE_ROUNDS);

This isn't a bug, but could the printf() on the success path and the
'round %d schedule failed: %d' diagnostic on the failure path be removed?
The ASSERT_* calls already record pass/fail state, and the failure
diagnostic writes to stdout while the neighbouring task_work_run()
diagnostics use fprintf(stderr, ...).

> +
> +stop:
> +	__atomic_store_n(&ctx.stop, 1, __ATOMIC_RELEASE);

[ ... ]


The commit message says:

>     Select two CPUs from the process affinity mask and use atomic
>     thread-start/stop handshakes, so the cross-CPU prerequisite is either
>     established or the test is skipped.

Is this description accurate?  When cpu_count < 2 the test does skip with
test__skip() and a reason string.  But when pthread_setaffinity_np() or
pthread_create() fails the test reports a hard FAILURE via ASSERT_OK()
rather than skipping - the affinity-setup prerequisite is not being met,
yet the test is not skipped.

Could either the commit message drop the 'or the test is skipped' claim,
or the affinity/thread-creation failures route to test__skip() with a
reason string like the CPU-count check does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35323947746
--===============8958580032944694090==--
