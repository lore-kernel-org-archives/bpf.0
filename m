Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605663;
	b=x24G5fpQBQ/Sv5kGDngb9Rv9SKYdVkwFROV4w9wRv8X2KDUFXykMsgDeeVeAAwgIFgEo
	 IW2V7sCKhhe+t7ajgiDS0dBJ1RS24YEeOETFQEadZ94Kwk4d3tZi6aoHlj025zwu1Ubw4
	 lLOF77ImexkfDNowJOUQicGMrlSwYiWY0HHHFiOVLjD/tWrq3XDUB+VRXkKfOff+n9Hj6
	 BFlaPMGjZvT/gSX10dTYY52mcEJC2s6UA1DGLzrb6uvxbPA4FeLTyEM2iOXeQHd1Kh3Xh
	 PyLLspiXYnA1DGizkKllMODpbNzpsmZT/A4w0H6d+cg7UIa9Y0UrK/8MTmo6MgD/4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oCgdXacNiuc3ZNoKXuKQpjlL6bS8CfCTR69+W4H94lI=;
	b=lSx41G8CLbLJuegU4hqGDN3ChV4IFpykZ320CQ9Y77Q/XyicqUlaYWDtxj9sDN3m5Yi8
	 gjSm8givEYWTlhgbnZzL0SuzlTHq4u9vYIL9woxEJzQw9qhCPaMOAS2AnivYg7XcSTi9D
	 g89VXT0XuO0dCnBy+toZGMGAF0f8iZ1FGfWUePQsW3ChZMqp3hxVy2nU8okK5/fNMqflS
	 2NKavX0caY4P0gBGGcbDdABxqfCF50ilbntdJ+H4rIln1a0MgnnxF1yFco4b9d57M6ca1
	 F3HqhTJeE9X+ggfD0XJGlFuB2xNzkaDHeXj/FIShPMvgAP1O87tudVigibFbKW/n7dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqAM1euM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D38606A337
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqAM1euM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A012F1F00A18;
	Mon,  2 Nov 2026 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605662;
	bh=oCgdXacNiuc3ZNoKXuKQpjlL6bS8CfCTR69+W4H94lI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RqAM1euMk/D9zbaSGFziFPZhCVDhc4WLfobd29iOMHfccm6K/NqWIrnUe+ezRFQeY
	 1OhlGAOH6M9Wi6tzrSKTDLIZ7i2li8ItnWSJtP+JX2UjgaNe2xfPBgPdk8RuAvoDzj
	 WnLZ1QGL3CFJGn58wR6Y22Lfn/KpNR57HUFM1Cd4+qSAfnLliknpLUra2rBaDAYpy3
	 9WR+uNwICsg8KbDIbPrDy5jjr0EvQKqdCWZ5pIP8YfQx274GNOH/XmuCR5hqoeiG8Y
	 N5ayJlCOoMr4iwqjfdlNRimtzVGJ/BBlKJdv++plQr27IF952yIPE7nvq3oHiNAWaw
	 tx1HMb6VRTOZw==
Message-ID: <sashiko-outbox-193047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add a selftest for program
 allocation/freeing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261102073439.6822-3-emil@etsalapatis.com>
References: <20261102073439.6822-1-emil@etsalapatis.com>
 <20261102073439.6822-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 07:47:42 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/bpf: standalone stress binary bypasses test_progs and =
kselftest
- [Medium] selftests/bpf: hardcoded 64-CPU check and contiguous CPU IDs in =
pin_cpu()
- [Medium] selftests/bpf: 64 KiB stack in run_threads() below PTHREAD_STACK=
_MIN
- [Low] selftests/bpf: commit message omits deadlock details and test design
--

commit f26b450586e3e82488cb0fdfca492b1cd1920f9b
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Add a selftest for program allocation/freeing

This commit adds a standalone stress test under tools/testing/selftests/bpf/
that repeatedly loads 65,536 socket filter programs across 64 CPUs, closes
them from CPU 0 under SCHED_FIFO, and spawns 1,024 waiter threads.

>     selftests/bpf: Add a selftest for program allocation/freeing
>    =20
>     Add a selftest that stresses BPF program allocation/free
>     paths.
>    =20
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

[Severity: Low]
This isn't a bug, but the commit message only states that a selftest is
added without explaining the underlying kernel bug mechanism or why the
workload in run_burst() is structured this way.

Could the commit message be expanded to describe the deadlock scenario being
tested (such as deferred __bpf_prog_put_noref() work items saturating CPU 0=
's
system_percpu_wq max_active limit while blocked on pack_mutex and starving
the vmalloc purge_vmap_node work item), the rationale for the multi-phase
workload parameters in run_burst(), and why the binary is placed in
TEST_GEN_PROGS_EXTENDED?

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 93c707116fad0..e59e07c4bd121 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -137,6 +137,7 @@ TEST_KMOD_TARGETS =3D $(addprefix $(OUTPUT)/,$(TEST_K=
MODS))
> =20
>  # Compile but not part of 'make run_tests'
>  TEST_GEN_PROGS_EXTENDED =3D \
> +	bpf_prog_free_stress \
>  	bench \
>  	flow_dissector_load \
>  	test_cpp \

[Severity: Medium]
By adding bpf_prog_free_stress only to TEST_GEN_PROGS_EXTENDED without a
corresponding runner in TEST_PROGS or prog_tests/, neither make run_tests
nor BPF CI (test_progs) will ever execute this test.

In addition, tools/testing/selftests/bpf/bpf_prog_free_stress.c defines a
standalone main() that reports status via printf() and err()/errx(), and
reimplements program loading in load_prog() via raw syscall(__NR_bpf,
BPF_PROG_LOAD, ...) instead of using libbpf's bpf_prog_load() and either
test_progs ASSERT_*() macros (like existing stress tests in prog_tests/ such
as task_work_stress.c, fexit_stress.c, and bpf_mod_race.c) or kselftest.h
ksft_* reporting helpers.

Should this test be integrated as a test_progs subtest under prog_tests/ (or
use libbpf's bpf_prog_load() and kselftest.h reporting if kept standalone)?

> diff --git a/tools/testing/selftests/bpf/bpf_prog_free_stress.c b/tools/t=
esting/selftests/bpf/bpf_prog_free_stress.c
> new file mode 100644
> index 0000000000000..8c761845c7032
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_prog_free_stress.c
> @@ -0,0 +1,184 @@

[ ... ]

> +#define LOAD_CPUS 64
> +#define PROGRAMS 65536
> +#define WAITERS 1024
> +#define DEFAULT_DURATION_SEC 5
> +
> +static int fds[PROGRAMS];
> +static const struct bpf_insn insns[] =3D {
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +};
> +
> +static void pin_cpu(int cpu)
> +{
> +	cpu_set_t mask;
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(cpu, &mask);
> +	if (sched_setaffinity(0, sizeof(mask), &mask))
> +		err(EXIT_FAILURE, "sched_setaffinity CPU%d", cpu);
> +}

[ ... ]

> +static void *load_worker(void *arg)
> +{
> +	int cpu =3D (uintptr_t)arg;
> +	int first =3D cpu * (PROGRAMS / LOAD_CPUS);
> +	int i;
> +
> +	pin_cpu(cpu);
> +	for (i =3D first; i < first + PROGRAMS / LOAD_CPUS; i++)
> +		fds[i] =3D load_prog();
> +	return NULL;
> +}

[ ... ]

> +static void run_threads(int count, void *(*worker)(void *))
> +{
> +	pthread_t threads[WAITERS];
> +	pthread_attr_t attr;
> +	int i;
> +
> +	check_pthread(pthread_attr_init(&attr), "pthread_attr_init");
> +	check_pthread(pthread_attr_setstacksize(&attr, 64 * 1024),
> +		      "pthread_attr_setstacksize");

[Severity: Medium]
In run_threads(), does setting a hardcoded 64 KiB stack size via
pthread_attr_setstacksize(&attr, 64 * 1024) fail with EINVAL on architectur=
es
where PTHREAD_STACK_MIN is larger than 64 KiB?

For example, on powerpc64le (where PTHREAD_STACK_MIN is 131072) or aarch64
with 64 KiB pages, pthread_attr_setstacksize() returns EINVAL when the
requested size is smaller than PTHREAD_STACK_MIN, causing check_pthread() to
abort the test with EXIT_FAILURE on the first burst.

Could this clamp the stack size to at least PTHREAD_STACK_MIN?

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	struct rlimit limit =3D { PROGRAMS + 1024, PROGRAMS + 1024 };
> +	long duration =3D parse_duration(argc, argv);
> +	long start;
> +	int round =3D 0;
> +
> +	setvbuf(stdout, NULL, _IOLBF, 0);
> +	if (sysconf(_SC_NPROCESSORS_ONLN) < LOAD_CPUS)
> +		errx(EXIT_FAILURE, "need at least %d online CPUs", LOAD_CPUS);

[Severity: Medium]
What happens in main() and load_worker() when this test runs on systems with
fewer than 64 online CPUs, or on systems with at least 64 online CPUs where
CPU IDs 0 through 63 are not all online and permitted by the process's CPU
affinity mask?

First, main() exits with EXIT_FAILURE when sysconf(_SC_NPROCESSORS_ONLN) <
LOAD_CPUS (64), or when unprivileged calls to setrlimit(),
sched_setscheduler(), or BPF_PROG_LOAD fail. Per kselftest policy, missing
environment or hardware prerequisites should skip rather than fail. Moreove=
r,
since __purge_vmap_area_lazy() in mm/vmalloc.c queues asynchronous purge wo=
rk
onto system_percpu_wq whenever nr_purge_nodes >=3D 2, could the test scale =
to
the number of available CPUs in the affinity mask and only skip when fewer
than 2 CPUs are available?

Second, load_worker() passes the worker index 0..LOAD_CPUS-1 directly to
pin_cpu(cpu), while main() and load_waiter() hardcode pin_cpu(0). Because
sysconf(_SC_NPROCESSORS_ONLN) only checks the total count of online CPUs,
sched_setaffinity() in pin_cpu() will fail with EINVAL if any CPU in 0..63 =
is
offline or excluded by the current cpuset or taskset affinity mask. Could
main() query sched_getaffinity() at startup and map workers onto the set of
usable CPU IDs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102073439.6822=
-1-emil@etsalapatis.com?part=3D2
