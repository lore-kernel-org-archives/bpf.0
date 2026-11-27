Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806905;
	b=BVsw/XPlAvGU5RYPA1+oofBxeHVoPltkeSbNZZStisEfIypRaYo67wuG0fdpCE1i5k3J
	 vX2trjBna01SD1Wmdj5AavZN7sYjl5nI5vi3BYFi57YLT+2XMpUCGqEYj0WoKfE6BpBA4
	 dND7qb2HkuAZKLmhpuq6Yefv3ExF8kfdHLjiFyAYhk5Wpyb/YWJLxgeoRE9ERfdDgMsSl
	 afSPhow7QDSGb3a53flTrnr+Cf3QrJjJ+Dbq2XPZlc8HUyS+UAO9jN11ul2bUM0KNKGtF
	 VTN6JZ6nU3tP5sSMPK45svG3qKQ60UaJmUOCk+3AnSXR8z/8NTIOxphjmhiiHPHIKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jAnxInstWAEYfpFdPtL2H+hnJItNJfdtmS8iAUb+HoM=;
	b=WwHpANYaU8neMFNpUUOvC8ZF/h/ALBE6uC0+co1IOMBW/QqUj7sw0ByaAVIZXTyMhRYb
	 rmKTm7zK0714ucZ87Pdw2NYu/YF+z4beM1serQyW9NvoZWOLM068Ad0EwoaTlOllnCqMR
	 6WoXyI5cgx+4Skf5tN50+idPaK4QtEV4gs2IWphfyUgCnR7QMLohaL0exVkLRCKrH+ZX0
	 ZmbgLaBZpJL1TPWifCJ4KZbkM9GKoPzDSEu0AKXDx6umXo4WcSLsXL0fXgbn8tfUP8VEK
	 QA7hLQddvpSHHKQ4l3QXRx/VWAVAiypv/QtJqLYa9UDV9PhA2HIgM/vG1W5m32V8bIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI8dm56R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD12606A31C;
	Fri, 27 Nov 2026 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI8dm56R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314851F000C1;
	Fri, 27 Nov 2026 19:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795806904;
	bh=jAnxInstWAEYfpFdPtL2H+hnJItNJfdtmS8iAUb+HoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WI8dm56RbbjT3V0hDSEHBTm6t3SDktFubL6Pz4EfjRpTXSIHEO+FRWRSeqw5InVRA
	 Q67uTOjDvPqm9NH/SsHpD1D5frJTSpwAjHMjlMlUJzUAc1F1xu32A5zrUmKKEhaOmO
	 vOZQx8ziqZpSvWmoZ/uQaF+nnoaHmqW2RckeWTWVXwvo+1Ck+uNFCYGIE8pnR6ziFO
	 kTNAgVbD/3MXmwXoBMAUIua3kftzGao3InIX9UbdYoFhX9ZXuVa548gFUnD0L2HN9a
	 2FDmxZC4HMqwUH32SsjRgkACrenr4ro1Z+a0gvLISsNqWl8FGR9BjWrmZZcKtI32MO
	 nREO+F6RzFhTQ==
Message-ID: <sashiko-outbox-238151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/16] selftests/membarrier: Check the memory
 barriers of each thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261127185822.158216-16-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
 <20261127185822.158216-16-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 19:15:03 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/membarrier: run_target() reads missed-barrier stat
  before sched-out
--

commit 2ae7bc75d862920739dabb87323389a8eebbf751
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/membarrier: Check the memory barriers of each thread

This commit adds membarrier_test_barrier, a BPF- and kprobe-based selftest
that counts per-thread memory barriers executed in the membarrier syscall,
IPI handlers, and scheduler paths.

> diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.c=
 b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
> new file mode 100644
> index 0000000000000..88c5dbf5d7c79
> --- /dev/null
> +++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
> @@ -0,0 +1,1270 @@

[ ... ]

> +/* Run the checks of a target. */
> +static void run_target(const struct target *target)
> +{
> +	struct target_stats *stats =3D &shared->stats[target->idx];
> +	const uint64_t *counters;
> +	long deadline =3D now_ms() + target->ms;
> +	unsigned long checks =3D 0;
> +	uint64_t first_ipi, first_sched_in;
> +
> +	/*
> +	 * Register before moving to the CPU. The BPF program then sees
> +	 * the target scheduled in there, as in the lazy TLB test case.
> +	 */
> +	counters =3D map_counters();
> +	if (!counters) {
> +		setup_error("register_thread");
> +		atomic_fetch_add(&shared->ready, 1);
> +		return;
> +	}
> +	if (target->cpu >=3D 0 && pin_to_cpu(target->cpu))
> +		setup_error("sched_setaffinity");
> +	atomic_fetch_add(&shared->ready, 1);
> +	while (!atomic_load(&shared->registered) && !atomic_load(&shared->stop))
> +		sched_yield();
> +	first_ipi =3D counter(counters, MBT_IPI);
> +	first_sched_in =3D counter(counters, MBT_SCHED_IN);
> +	while (!atomic_load(&shared->stop)) {
> +		if (check_call(counters, stats) && target->thread_exit &&
> +		    !(++checks % 16)) {
> +			pthread_t thread;
> +
> +			if (pthread_create(&thread, NULL, thread_nop, NULL) ||
> +			    pthread_join(thread, NULL))
> +				setup_error("thread exit");
> +		}
> +		if (target->ms && now_ms() >=3D deadline)
> +			break;
> +	}
> +	atomic_fetch_add(&stats->ipis, counter(counters, MBT_IPI) - first_ipi);
> +	atomic_fetch_add(&stats->sched_in,
> +			 counter(counters, MBT_SCHED_IN) - first_sched_in);
> +	atomic_fetch_add(&stats->sched_in_missed,
> +			 counter(counters, MBT_SCHED_IN_MISSED));
> +}

[Severity: Medium]
Can run_target() read MBT_SCHED_IN_MISSED before the target thread has
scheduled out to flush state->owed?

In membarrier_test_barrier.bpf.c, sched_switch only increments
MBT_SCHED_IN_MISSED when the CPU leaves the thread on a subsequent
context switch:

tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c:sched_swit=
ch() {
	...
	/* The CPU leaves the thread which it last switched to. */
	if (state->owed & OWES_BARRIER)
		count(state->slot, 1U << MBT_SCHED_IN_MISSED);
	count(slot_of(prev), 1U << MBT_SCHED_OUT);
	...
}

In global_expedited_lazy_tlb, shared->registered is already 1 when
run_target() is called, so after pin_to_cpu(target->cpu) switches the
child in after the idle thread on cpus[1], the child spins in user space
for ROUND_MS and reads MBT_SCHED_IN_MISSED while still running on cpus[1].
If the child is not preempted during that round, the schedule-out on
cpus[1] only happens at _exit(0) after run_target() has already recorded
stats->sched_in_missed, so a missing scheduler barrier on that switch-in
will go undetected.

Also, sampling first_sched_in after pin_to_cpu(target->cpu) subtracts out
the MBT_SCHED_IN increment from that initial migration onto target->cpu
when computing stats->sched_in.  Should first_sched_in be read before
pin_to_cpu(), and should run_target() force a schedule-out (e.g. via
sched_yield() or migrating off target->cpu) before reading
MBT_SCHED_IN_MISSED?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127185822.1582=
16-1-mathieu.desnoyers@efficios.com?part=3D15
