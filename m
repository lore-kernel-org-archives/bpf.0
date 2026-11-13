Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577564;
	b=Mu0Kj9gJyXDkZlQF0Df10LQ1x6RCXrlD5O53IbwSV5TBcn1kY0gYO05b5qw8nQF/fKeO
	 hIMDHUOexsCLhOzUxEr8+6wmth9VmjSObkl2Bv7mU5pPiBw4yARmO4/917kKQI4uU7bpJ
	 Ui2A6T0JrSLF09ytMJK1aKyVOoDU0RUWgX45hCSwo/mGCqOx8jLsegaEmP2DkXT3PtDJq
	 GgYw9/zB3Hq/85iU/1HHkgdldISGTI2JoAwBI2Xfn92CfEmDUzIcXBS9apFFmYmDIVPaq
	 f1hjFCo5iRsL9xujqqGy1RRF6Jc0Xp/ozKbze9166EczGFhhKZ6yqATyvhAEGhmPBNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5GG8uI5pGVFGK6vDOm4uHQXdvzsDrmWTq8Qe1GlRKpc=;
	b=5VQuVP4Lezo3edqrSvEk+Yd1amgkIp7fGrgXzP9C1rP50Kj+iqFtrn8Uzz8VD7dFAcLh
	 Yq4DIjTrFdh7uWS0kicCvDN7nzLmDutqzeqHk8nE38pTyWpi463QLsmeA3d5755I+RhIJ
	 TkHscOnUhTnPL/Zt0o/wQVq0ybMmEEBwpxPm3dejeraWFVgV/BNI9abMUs1M4BfoJDSFk
	 SHHXcz0XqUggZnO8kXS9B4t/zJojvE3tBMuDsJ3eMNnxwu4VkqSK7azWv4z7XJklG/5LJ
	 Iw9oDikzUI1L3BL07fV9sLPOMnrJ+41o5HPxv8y8CXgFB6Y+FGd9YlQN7kWlg2d86zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV2quZMk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77C606A327;
	Fri, 13 Nov 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV2quZMk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1530C1F000C5;
	Fri, 13 Nov 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577564;
	bh=5GG8uI5pGVFGK6vDOm4uHQXdvzsDrmWTq8Qe1GlRKpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FV2quZMkyGZXAtmhvuVpvmot00AnfMPDSbreLEP1hzKHeVGIOf4JiVqr9bu934G+E
	 okd3Er8nWVHXBOyBmmR9cMO0Rj/I7RJi+CqWZhnF2U2I3w59BrtLXTmXOXAj1CmpLb
	 AYFLYGZ4sDDMzcXq+vZpuIW2ogln+brIqvQvp/TT9uQlNma7w1UMEbWAsQpiKa/w0U
	 8vDggvkz/AjnCxQSoYIyPPKdqmcH7zM0KLamQh0d14zVYZe/xEqYG7Ke7MsGeTv0P5
	 aYdcO5JMM9B5iyW7w0IIYpp5iVq7GqWuqnlfMGxWXJJgJerR56vn2tcFqMrWBaS7J8
	 ZJHCOVecyJvBA==
Message-ID: <sashiko-outbox-212919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/16] selftests/membarrier: Check the memory
 barriers of each thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113131903.157186-16-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
 <20261113131903.157186-16-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:46:03 +0000
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
- [Medium] selftests/membarrier: run_target() pins CPU before
  registering BPF slot
- [Medium] selftests/membarrier: bpf_setup() fails instead of skipping
  on missing BPF configs
- [Low] selftests/membarrier: reset_shared() reuses BPF counter slots of
  exiting tasks
--

commit 3ab38ee940d58df6774d85bc12aa7c4563dfeb02
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/membarrier: Check the memory barriers of each thread

This commit adds the membarrier_test_barrier selftest, which uses BPF
kprobes and the sched_switch tracepoint on x86-64 to count per-thread
memory barriers executed during expedited membarrier commands and context
switches.

> diff --git a/tools/testing/selftests/membarrier/membarrier_test_barrier.c=
 b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
> new file mode 100644
> index 0000000000000..46502d2712425
> --- /dev/null
> +++ b/tools/testing/selftests/membarrier/membarrier_test_barrier.c
> @@ -0,0 +1,1253 @@

[ ... ]

> +static const char *bpf_setup(void)
> +{
> +	struct bpf_program *prog;
> +	libbpf_print_fn_t print;
> +	struct bpf_map *map;
> +	const char *err;
> +
> +	setup_pid =3D getpid();
> +	atexit(bpf_teardown);
> +	if (geteuid())
> +		return "this test needs root";
> +	if (access("/sys/kernel/btf/vmlinux", R_OK))
> +		return "the kernel has no BTF (CONFIG_DEBUG_INFO_BTF)";
> +	kcore_fd =3D open("/proc/kcore", O_RDONLY | O_CLOEXEC);
> +	if (kcore_fd < 0)
> +		return "cannot read /proc/kcore (CONFIG_PROC_KCORE)";
> +	setup_broken =3D true;
> +	bpf_obj =3D bpf_object__open_file(BPF_OBJECT, NULL);
> +	if (!bpf_obj)
> +		return "cannot open " BPF_OBJECT;
> +	if (bpf_object__load(bpf_obj))
> +		return "cannot load the BPF programs";
> +	site_prog =3D bpf_object__find_program_by_name(bpf_obj, "barrier_site");
> +	prog =3D bpf_object__find_program_by_name(bpf_obj, "register_thread");
> +	map =3D bpf_object__find_map_by_name(bpf_obj, "counters");
> +	if (!site_prog || !prog || !map)
> +		return "incomplete BPF object";
> +	register_fd =3D bpf_program__fd(prog);
> +	counters_fd =3D bpf_map__fd(map);
> +	map =3D bpf_object__find_map_by_name(bpf_obj, "site_hits");
> +	hits_fd =3D map ? bpf_map__fd(map) : -1;
> +	/* The exec test case passes these two to the new program. */
> +	if (fcntl(register_fd, F_SETFD, 0) || fcntl(counters_fd, F_SETFD, 0))
> +		return "fcntl failed";
> +	signal(SIGINT, restore_optprobes);
> +	signal(SIGTERM, restore_optprobes);
> +	signal(SIGHUP, restore_optprobes);
> +	if (!set_optprobes('0'))
> +		return "cannot write " OPTPROBES_FILE;
> +	prog =3D bpf_object__find_program_by_name(bpf_obj, "sched_switch");
> +	switch_link =3D prog ? bpf_program__attach(prog) : NULL;
> +	if (!switch_link)
> +		return "cannot attach to the sched_switch tracepoint";

[Severity: Medium]
Does setting setup_broken =3D true before bpf_object__load() and
bpf_program__attach() cause main() to fail instead of skipping when the
kernel lacks required BPF features?

A kernel with CONFIG_DEBUG_INFO_BTF=3Dy and CONFIG_PROC_KCORE=3Dy can still
lack CONFIG_BPF_EVENTS=3Dy (needed to load kprobe/tracing programs and
BPF_MAP_TYPE_TASK_STORAGE) or have BPF JIT disabled (needed to attach
tp_btf/sched_switch).  When bpf_object__load() or bpf_program__attach()
fails for those reasons, setup_broken is already true, so main() exits via
ksft_exit_fail_msg() rather than ksft_exit_skip().

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
> +	if (target->cpu >=3D 0 && pin_to_cpu(target->cpu))
> +		setup_error("sched_setaffinity");
> +	counters =3D map_counters();

[Severity: Medium]
Does calling pin_to_cpu(target->cpu) before map_counters() miss the
lazy-TLB context switch in global_expedited_lazy_tlb?

In global_expedited_lazy_tlb, the child pins itself to cpus[1] and then
cpus[2] so that cpus[1]'s idle thread borrows its mm, and then calls
run_target() with target.cpu =3D cpus[1].  Because pin_to_cpu() migrates the
child back onto cpus[1] before map_counters() runs register_thread to
populate task_slot, the switch from the lazy-TLB idle thread back to the
child on cpus[1] runs while slot_of(next) is still 0:

tools/testing/selftests/membarrier/membarrier_test_barrier.bpf.c:sched_swit=
ch() {
    ...
	slot =3D slot_of(next);
	state->slot =3D slot;
	state->owed =3D 0;
	/* The cases which need a barrier after the store to rq->curr. */
	if (slot && next->mm && prev->mm !=3D next->mm) {
		state->owed =3D OWES_BARRIER;
		count(slot, 1U << MBT_SCHED_IN);
	}
    ...
}

As a result, sched_switch never sets OWES_BARRIER or increments
MBT_SCHED_IN for that lazy-TLB switch.  Calling map_counters() before
pin_to_cpu(target->cpu) registers the thread in task_slot before it
migrates back to cpus[1].

[ ... ]

> +static void reset_shared(void)
> +{
> +	memset(shared, 0, sizeof(*shared));
> +}

[Severity: Low]
Can zeroing shared->next_slot in reset_shared() let an exiting task from a
finished test case clobber the BPF counters of a new thread in the next
test case?

pthread_join() and waitpid() return during do_exit() before the dying task
reaches its final context switch in do_task_dead(), while its task_slot
entry remains attached until free_task().

CPU0                                  CPU1
join_targets() / child_ok()
reset_shared()
  shared->next_slot =3D 0
start_targets()
  map_counters()
    register_thread() (slot 1)
                                      do_exit()
                                        do_task_dead()
                                          __schedule()
                                            sched_switch() (prev slot 1)
                                              count(1, 1U << MBT_SCHED_OUT)
                                              <-- increments new thread's
                                                  counters

Preserving shared->next_slot across reset_shared() avoids reusing counter
slots across test cases.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113131903.1571=
86-1-mathieu.desnoyers@efficios.com?part=3D15
