Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310121;
	b=mWJF8tR5A8bG4POOmrEqgliR6R5y+AhiXzTsUVTob6FY6BXSGWNUrEks0uN+2InrqD3n
	 AvOH3kZ9TLcSn1NW9tdWv4/HFTLW0wA1T5jyqCWmKJn/K4otexh6oismo/iSPXwrJjIcW
	 rc/X95nThULkYQ7Yp0uBX+l9O8ndf9rCtSL5ScCPjOfa43f97NFR7/I4RTxAzKgV/X/fb
	 8+/2jOR8BKwbAmZrzj7QW+B3o12vN0S5w8YzAVn1ROCi37EFYVesQFj7BSJq0KLGeZY1T
	 Kqy9utTL+U2kF5zsa+ialGkrGt5l356u6HkMfOAsBFfguHH8toYiFOEzWVL0UDf+fDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1dUwzh02jc/B6xfKV61LBGPqjcEn/x+E+3PAr9v92ok=;
	b=YPj3PsL5jokldNEPnNTnHOtptREu8yXpw+UYdUqW6xHQ2DtyIp4zwXK4j8CuwELggFjj
	 z5B8/zv0lvDci+llqG/7HOxYI3T6LM7d20nkkmQHUGm1cB/cLBNTI+6E2fqu/KVb8B8j6
	 VD/u8yLm7yP+v7QtVMpv1AOuoEJm2AB6sa+kbT2l0ep+QF1EuMpw8lHydTZ4KYZt6+0wV
	 gs0K8FuusmWVWmrt69T7xikZAWaLQpQ4NRd5C18WfCGAPuUlLhZYYIAYIf+7Q4gu1RJHD
	 ypYEd+iNHYPysYSIRvTAQBJLBTXRqgfk0jLg9deVOhwvzENqBWYaNXr+coNu6Oiiewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewnQCV56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FE606A31C;
	Tue, 10 Nov 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewnQCV56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36891F008A1;
	Tue, 10 Nov 2026 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310121;
	bh=1dUwzh02jc/B6xfKV61LBGPqjcEn/x+E+3PAr9v92ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewnQCV56pjccJ+mSl24OJUHX0lbGTGWtYjNmTUlB9P5Svo4DOA9zVUzCEYWUQ4muH
	 ha+k/8AB3l+OP3fmE685NHUw8Yv5v2oSXHM2QSo6Mo8x/YM4BsTZe4m2L2aIMa4CFF
	 VziikpS8cdiX7dZynqFltL8L8klhqXULSCcVHQJE2Vi8IOu71GzojbqcCnPhKVu3Qu
	 liEY/2O6vpjgCTR5JJspE1F2q1C58iqYT52d9wTIGNO3gAOJGHbvCmQnn6Yxg4OhBb
	 fJ3XuXrI5/OpW6Er9l8GTdWEULKsU6aCWp2MHkC0cHj1o2EuSjecaLfbjZQ1Oekgs9
	 3KrZ88XevEW/g==
Message-ID: <sashiko-outbox-206937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] sched/fair: expose cpu.max.runtime to set
 bandwidth runtime directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernand Sieber" <sieberf@amazon.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <9741224b8d2b19760f85c1f854d61f30fa7d9710.1794303670.git.sieberf@amazon.com>
References: <cover.1794303670.git.sieberf@amazon.com>
 <9741224b8d2b19760f85c1f854d61f30fa7d9710.1794303670.git.sieberf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:28:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] sched/fair: distribute_cfs_runtime() IRQ assert fails on
  PREEMPT_RT
- [Medium] selftests/cgroup: hog burns runtime before period start in
  test_cpu
- [Low] selftests/cgroup: missing CONFIG_CFS_BANDWIDTH skip in test_cpu
--

commit bbd8379bd9e3f88e46c648f7388044e945e9df20
Author: Fernand Sieber <sieberf@amazon.com>

sched/fair: expose cpu.max.runtime to set bandwidth runtime directly

This commit adds the cgroup v2 cpu.max.runtime file to read and set
cfs_b->runtime directly, lifts the burst <=3D quota restriction, and adds
cgroup selftests for the new interface.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4cc0caee6265..58e948ed1792f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7421,6 +7421,8 @@ static bool distribute_cfs_runtime(struct cfs_bandw=
idth *cfs_b)
>  	struct cfs_rq *cfs_rq;
>  	struct rq *rq;
> =20
> +	lockdep_assert_irqs_disabled();
> +
>  	guard(rcu)();
> =20
>  	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,

[Severity: Medium]
Does lockdep_assert_irqs_disabled() trigger a lockdep warning on
CONFIG_PREEMPT_RT when distribute_cfs_runtime() is called from
do_sched_cfs_period_timer() or do_sched_cfs_slack_timer()?

init_cfs_bandwidth() sets up cfs_b->period_timer and cfs_b->slack_timer
without HRTIMER_MODE_HARD, so on CONFIG_PREEMPT_RT their callbacks run in
softirq context with hardware interrupts enabled.  Both
do_sched_cfs_period_timer() and do_sched_cfs_slack_timer() release
cfs_b->lock via raw_spin_unlock_irqrestore() before calling
distribute_cfs_runtime(cfs_b), leaving hardware interrupts enabled on
entry.  (distribute_cfs_runtime() itself uses guard(rq_lock_irqsave)(rq)
and scoped_guard(irqsave) around __cfsb_csd_unthrottle() for that reason.)

> diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/se=
lftests/cgroup/test_cpu.c
> index 3456e3e988c68..278d7e16eeb2c 100644
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c

[ ... ]

> +static int test_cpucg_max_runtime(const char *root)
> +{

[ ... ]

> +	cpucg =3D cg_name(root, "cpucg_runtime_test");
> +	if (!cpucg)
> +		goto cleanup;
> +
> +	if (cg_create(cpucg))
> +		goto cleanup;
> +
> +	/* Without a quota there is no runtime to set. */
> +	if (!cg_write_numeric(cpucg, "cpu.max.runtime", runtime_usec))
> +		goto cleanup;

[Severity: Low]
Should the new test_cpucg_max_runtime* tests check whether
cpu.max.runtime exists and return KSFT_SKIP when CONFIG_CFS_BANDWIDTH is
disabled (or add CONFIG_CFS_BANDWIDTH=3Dy to
tools/testing/selftests/cgroup/config)?

cpu.max.runtime is only created under CONFIG_CFS_BANDWIDTH, which
defaults to n and is not listed in tools/testing/selftests/cgroup/config,
so all five tests currently return KSFT_FAIL on kernels built without it.

[ ... ]

> +static int test_cpucg_max_runtime_burst_kept(const char *root)
> +{
> +	int ret =3D KSFT_FAIL;
> +	long burst_before, burst_after, runtime_usec;
> +	char *cpucg;
> +	int pid;
> +
> +	cpucg =3D cg_name(root, "cpucg_runtime_burst_kept_test");
> +	if (!cpucg)
> +		goto cleanup;
> +
> +	if (cg_create(cpucg))
> +		goto cleanup;
> +
> +	/* 10ms per 1s period, and a runtime of 1s to run on. */
> +	if (cg_write(cpucg, "cpu.max", "10000 1000000"))
> +		goto cleanup;
> +	if (cg_write_numeric(cpucg, "cpu.max.burst", 990000))
> +		goto cleanup;
> +	if (cg_write_numeric(cpucg, "cpu.max.runtime", 1000000))
> +		goto cleanup;
> +
> +	struct cpu_hog_func_param param =3D {
> +		.nprocs =3D 1,
> +		.ts =3D { .tv_sec =3D 10, .tv_nsec =3D 0 },
> +		.clock_type =3D CPU_HOG_CLOCK_WALL,
> +	};
> +	pid =3D cg_run_nowait(cpucg, hog_cpus_timed, (void *)&param);
> +	if (pid < 0)
> +		goto cleanup;
> +
> +	/* Run some 300ms, all in one period, and stop. */
> +	if (wait_period_start(cpucg)) {
> +		kill(pid, SIGKILL);
> +		waitpid(pid, NULL, 0);
> +		goto cleanup;
> +	}
> +	burst_before =3D cg_read_key_long(cpucg, "cpu.stat", "burst_usec");
> +	usleep(300000);
> +	kill(pid, SIGKILL);
> +	waitpid(pid, NULL, 0);
> +
> +	/* Write back what is left: the next refill counts the 300ms run. */
> +	runtime_usec =3D cg_read_long(cpucg, "cpu.max.runtime");
> +	if (cg_write_numeric(cpucg, "cpu.max.runtime", runtime_usec))
> +		goto cleanup;
> +	sleep(1);
> +	burst_after =3D cg_read_key_long(cpucg, "cpu.stat", "burst_usec");
> +	if (burst_before < 0 || burst_after - burst_before < 250000)
> +		goto cleanup;

[Severity: Medium]
Can hog_cpus_timed burn most of the 1s cpu.max.runtime before
wait_period_start() returns?

Because cfs_b->period_timer starts with a random offset,
wait_period_start() can wait up to 1s for the first period boundary while
the hog is already running.  When that wait exceeds ~750ms, the refill at
the period boundary only adds the 10ms quota, leaving less than 250ms of
runtime for the measured 300ms window and causing the
burst_after - burst_before < 250000 check to fail.  Writing 1000000 to
cpu.max.runtime after wait_period_start() (or starting the hog after it)
would avoid draining the runtime early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794303670.gi=
t.sieberf@amazon.com?part=3D1
