Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064953;
	b=TQc46eOuaOo0NDsaJvfapTaSWw7Hq2vnBx3Ira4iBCoR10gSrIH5fkvSTVG2NAjNUT5e
	 2EaBghrxei7LxYtyQ5rIygREIVhMENOjKUgtsFWsXkHTeJ4sF8s5ATO/WfqdMY53ahJgL
	 VZmsqnH6/M9rIFwGH3U/o8ikBq+UpDkGLrtYa3l5H2Dj4YIiwPxPoECdXZho+6RNeQcvH
	 zdClQMl+c1FN1ub8dHqd+2AF0v9D7wvBMFNJqFwP+pfHglprd9Vv27xZrxNMW+qaLf0Cf
	 5OmUild8ePKKlMvjIkP1qddjfuwC+t8OAnviaApTklEIhgmC+nRa+ciH7lGCbUpeivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064953;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cRUrKvGLYw0SBRCiu66yBTropVmsa8L0KnbRGAvuHLw=;
	b=laAjiXe6+q9l/g133gi80nyQ73b+Sv3Gizg1++jY+1EcjtoKu95upnRrz4QfbZisfbVr
	 lleu4CkW6fmmG/+9TQRNkRKQmXLruphnykkURriPza3BH8uIhhouKaprlU1f/hOcn4Iql
	 wf5oZxrvShPFY3Azj1394HkUPvdUBlJ2sJS6uAHz+KJzTa2fE0fAsC723sdsye6xjXCWe
	 259HmQ46FqdMz3q3OoW6+16MtRhw3TjLLkXPJa4br7PeRgCB0yCc/Sw2m1wEdDVUVpTJT
	 2tQAJJRPnAjTetCU05fHji8djmPTPQ27j5tFyPmNijP3UHrOO8xrOWKDGfDxDPIDi5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BhLWq+as;
	arc=none smtp.remote-ip=95.215.58.209
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA63606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA63606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BhLWq+as
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YOo0Tn4d/EEveqjJFWxtczfbEXWSwvpjYc33Zhtusa8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795064950; v=1; x=1795669750;
 b=BhLWq+asoX+A0HObQIrfDiDGVqi0oPhQEu8YoiJaiGQQlZvKTQ6oB1FR+eFE8Qdt4E3GRP4F
 X9rVu0hZtaPk5gouxau8GYpL2EZ7v8ZVPorgyL9T8FDkHeh0iuhV5wBw8O1rqZndZohYhv1i0zN
 boBG+vA5crfCQE9GIPKDC5m0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fbdcc30c2a970494;
	Thu, 19 Nov 2026 05:09:10 +0000
X-Mizu-Trace-ID: fbdcc30c2a970494
X-Migadu-Flow: FLOW_OUT
Message-ID: <e3ed9b2d-7778-481b-ba85-2ac3ac5de877@linux.dev>
Date: Wed, 18 Nov 2026 21:09:02 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add preemption recursion
 test for tracing programs
To: mikeba@sentinelone.com, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-4-586376ec3672@sentinelone.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-4-586376ec3672@sentinelone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 3:29 AM, Mike Bazov via B4 Relay wrote:
> From: Mike Bazov <mikeba@sentinelone.com>
> 
> Pin two threads to one CPU. Thread B is SCHED_FIFO and waits for a
> signal that thread A sends from inside the program under test, so B
> preempts A there and enters the same program on the same CPU. Each
> subtest runs 20 rounds and checks in every round that A was inside the
> program when B ran. It is skipped if that never happens, as on a kernel
> that doesn't preempt kernel code.
> 
> - fentry, fentry_s, raw_tp, raw_tp_s, tp_syscall: a program without
>   per-CPU state. Both threads must run it in every round, without
>   recursion misses.
> - *_percpu, percpu_var, this_cpu_ptr, tail_call, may_goto: a program
>   with a per-CPU map, a per-CPU variable, bpf_this_cpu_ptr(), a tail
>   call or timed may_goto. B must be dropped and counted in every
>   round. A constant selects the per-CPU state that the handler
>   touches; with none selected, the same code doesn't mark the program.
> - two_dispatchers: two raw tracepoint programs tail-call one handler.
>   Both threads run it at once, and A checks that the stack buffer it
>   filled before B ran is intact.
> - recursion_raw_tp, recursion_two_hops, recursion_test_run: true
>   recursion is still dropped and counted: directly, through a second
>   program, and from BPF_PROG_TEST_RUN.
> - ext_attach: an extension that uses a per-CPU map can't be attached
>   to a raw tracepoint program that doesn't, while one without can.
> 
> Signed-off-by: Mike Bazov <mikeba@sentinelone.com>
> ---
>  .../selftests/bpf/prog_tests/trampoline_preempt.c  | 352 +++++++++++++++++++++
>  .../selftests/bpf/progs/trampoline_preempt.c       | 258 +++++++++++++++
>  2 files changed, 610 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c b/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c
> new file mode 100644
> index 000000000000..f282fdba5d16
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_preempt.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <pthread.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <sys/prctl.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <test_progs.h>
> +#include "trampoline_preempt.skel.h"
> +
> +#define NR_ROUNDS 20
> +
> +/* The kernel's own "not supported" error, which the libc headers don't have */
> +#ifndef ENOTSUPP
> +#define ENOTSUPP 524
> +#endif
> +
> +/*
> + * Threads A and B are pinned to one CPU. B is SCHED_FIFO and waits for a signal:
> + *
> + *   A: prctl() -> enters the program under test
> + *                 the program sends B the signal
> + *   B:            wakes up and preempts A, which is still inside the program
> + *                 prctl() -> enters the same program on the same CPU
> + *
> + * A program whose recursion is checked per task runs for B too. A program that
> + * keeps per-CPU state keeps the per-CPU check: B's run is dropped and counted
> + * as a recursion miss.
> + */
> +
> +/* The per-CPU state that a program touches, see progs/trampoline_preempt.c */
> +enum { NO_PERCPU, PERCPU_MAP, PERCPU_VAR, THIS_CPU_PTR };
> +
> +enum expect {
> +	B_RUNS,		/* B runs the program, without recursion misses */
> +	B_DROPPED,	/* B's runs are dropped and counted as recursion misses */
> +	B_RUNS_HANDLER,	/* two_dispatchers: dropped by one dispatcher, runs through the other */
> +};
> +
> +/* What threads A and B share */
> +struct ctx {
> +	struct trampoline_preempt *skel;
> +	sigset_t sigset;
> +	int cpu, err_a, err_b;
> +	int overlaps;	/* rounds in which B found A still inside the program */
> +};
> +
> +/* Only timed may_goto keeps its budget per CPU, and only these JITs have it */
> +static bool has_timed_may_goto(void)
> +{
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__) || \
> +	defined(__powerpc64__) || (defined(__riscv) && __riscv_xlen == 64) || \
> +	(defined(__loongarch__) && __loongarch_grlen == 64)
> +	return is_jit_enabled();

Any better precedent for checking this?

> +#else
> +	return false;
> +#endif
> +}
> +
> +static int pin_to_cpu(int cpu)
> +{
> +	cpu_set_t set;
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);
> +	return sched_setaffinity(0, sizeof(set), &set) ? -errno : 0;
> +}
> +
> +/* A enters the program under test, which wakes B from inside it */
> +static void *worker_a(void *arg)
> +{
> +	struct ctx *c = arg;
> +	int i;
> +
> +	c->err_a = pin_to_cpu(c->cpu);
> +	c->skel->bss->tid_a = syscall(SYS_gettid);
> +	for (i = 0; i < NR_ROUNDS && !c->err_a; i++) {
> +		/* Passes every hook that the programs under test are attached to */
> +		if (prctl(PR_SET_NAME, "worker_a"))
> +			c->err_a = -errno;
> +	}
> +	return NULL;
> +}
> +
> +/* B is SCHED_FIFO on A's CPU: A runs only while B waits, and B preempts A as soon as A wakes it */
> +static void *worker_b(void *arg)
> +{
> +	struct sched_param sp = { .sched_priority = 1 };
> +	struct timespec ts = { .tv_sec = 5 };	/* give up if the signal never comes */
> +	struct ctx *c = arg;
> +	int i;
> +
> +	c->err_b = pin_to_cpu(c->cpu);
> +	if (!c->err_b && sched_setscheduler(0, SCHED_FIFO, &sp))
> +		c->err_b = -errno;
> +	c->skel->bss->tid_b = syscall(SYS_gettid);
> +	for (i = 0; i < NR_ROUNDS && !c->err_b; i++) {
> +		while (sigtimedwait(&c->sigset, NULL, &ts) < 0) {
> +			if (errno != EINTR) {
> +				c->err_b = -errno;
> +				return NULL;
> +			}
> +		}
> +		/* B preempted A only if A is still inside the program */
> +		if (*(volatile int *)&c->skel->bss->a_inside)
> +			c->overlaps++;
> +		/* B's own run of the program, while A is preempted inside it */
> +		if (prctl(PR_SET_NAME, "worker_b"))
> +			c->err_b = -errno;
> +	}
> +	return NULL;
> +}
> +
> +/* Load and attach only programs @a, @b and @c. NULL after a failure or a skip. */
> +static struct trampoline_preempt *load_progs(const char *a, const char *b, const char *c,
> +					      int percpu)
> +{
> +	struct trampoline_preempt *skel = trampoline_preempt__open();
> +	struct bpf_program *p;
> +	const char *name;
> +	int err;
> +
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return NULL;
> +	bpf_object__for_each_program(p, skel->obj) {
> +		name = bpf_program__name(p);
> +		bpf_program__set_autoload(p, !strcmp(name, a) || (b && !strcmp(name, b)) ||
> +					     (c && !strcmp(name, c)));
> +	}
> +	skel->bss->sig = SIGUSR1;
> +	skel->rodata->percpu = percpu;
> +	err = trampoline_preempt__load(skel);
> +	/* The kernel or its JIT doesn't support one of the programs */
> +	if (err == -EOPNOTSUPP || err == -ENOTSUPP)
> +		test__skip();
> +	else if (ASSERT_OK(err, "load") && ASSERT_OK(trampoline_preempt__attach(skel), "attach"))
> +		return skel;
> +	trampoline_preempt__destroy(skel);
> +	return NULL;
> +}
> +
> +static const struct subtest {
> +	const char *name;
> +	const char *prog;	/* A enters it; its recursion misses are checked */
> +	int percpu;		/* the per-CPU state that the program touches */
> +	enum expect expect;
> +	const char *prog_b;	/* two_dispatchers: B reaches the handler through this one */
> +	const char *handler;	/* two_dispatchers: the target of both tail calls */
> +} subtests[] = {
> +	/* Each kind of program, without per-CPU state and with a per-CPU map lookup */
> +	{ "fentry",		"on_fentry",		NO_PERCPU,	B_RUNS },
> +	{ "fentry_percpu",	"on_fentry",		PERCPU_MAP,	B_DROPPED },
> +	{ "fentry_s",		"on_fentry_s",		NO_PERCPU,	B_RUNS },
> +	{ "fentry_s_percpu",	"on_fentry_s",		PERCPU_MAP,	B_DROPPED },

Is it worth covering fexit, fmod_ret?

> +	{ "raw_tp",		"on_raw_tp",		NO_PERCPU,	B_RUNS },
> +	{ "raw_tp_percpu",	"on_raw_tp",		PERCPU_MAP,	B_DROPPED },
> +	{ "raw_tp_s",		"on_raw_tp_s",		NO_PERCPU,	B_RUNS },
> +	{ "raw_tp_s_percpu",	"on_raw_tp_s",		PERCPU_MAP,	B_DROPPED },
> +	{ "tp_syscall",		"on_tp_syscall",	NO_PERCPU,	B_RUNS },
> +	{ "tp_syscall_percpu",	"on_tp_syscall",	PERCPU_MAP,	B_DROPPED },
> +	/* The other things that keep a program on the per-CPU check */
> +	{ "percpu_var",		"on_raw_tp",		PERCPU_VAR,	B_DROPPED },
> +	{ "this_cpu_ptr",	"on_raw_tp",		THIS_CPU_PTR,	B_DROPPED },
> +	{ "tail_call",		"on_tail_call",		NO_PERCPU,	B_DROPPED },
> +	{ "may_goto",		"on_may_goto",		NO_PERCPU,	B_DROPPED },
> +	/* Both threads are inside the handler at once, and A's stack must stay intact */
> +	{ "two_dispatchers",	"dispatcher_a",		NO_PERCPU,	B_RUNS_HANDLER,
> +	  "dispatcher_b", "handler" },
> +};
