Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2EA442B03
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067501; cv=none; b=VCdAnZTWs5o0HLc6rnQYWqKzob/UyRxS0U9drwb4szemclp+Xxo3lU0Nf0Xs3ywJN47/CaMOwdRnnHl7UpCw/ETaW8yeiS7ar4dt2dN75PP8kgOjpuifPD/2Mpv/f4heQw4euOEKtWUTm+mCyi4r+RxsDnx2xZ2o8MDe9NDIp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067501; c=relaxed/simple;
	bh=HbQPx5jqzrM+XvZ163nbHamBbK7yZomA0fkWQvLNmxw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eL18ZKxClN3NTlaAGkQg+7569yahoQtv67zj0K0Qwl0PfRJq7KWUyWnneHqGvpz9AFGSPgDg9SfL9vboieipwPDVp+HPuj3RZlq8XvwIUTXAIVqvtLHpoOYPzNeVeXrH34ut4vi/PXRbaIsgNY4UH2gGeKUicO2U7bZwu8r7ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH6uKnnt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH6uKnnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9AF1F000FF;
	Tue, 22 Sep 2026 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067500;
	bh=cI7XmEHkyoTfHkgl6qUEzmPc7CTrFN4+8cy2xDchC7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OH6uKnntLiTNhMOu+lq++jQXytiVq2dC1tklIaryZrCRWLp8LcTJrMe9rbKV7oUp9
	 Pw1Cy9UmVue+nPhMJAT+UHXdbdKqz8eVoE/NO/sWwysXgex1xWtc2QHbqAXqYR5QZI
	 B2nMegJOv1xNmiT3d8+pFr82FQ5gW4kBX8WT9v7FfKill4D5LHEypq7X3p8BetrKrx
	 q62Bz0M1mGYp+mtZsKzeW4VoAxecb9/YMqbq/DzLeC+9s84qmcf6cCPs26yvgT974b
	 5z6gW/5R83BzFIdSpNu4cI1qHNGIej1BkgVAszKyR+6ZeRG5ooOGTkGMMEwfHH2ONu
	 8tgdGU5krGgug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/sched_ext: Add scx_priority dual-queue priority
 CPU scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: rahadbhuiya <rahadbhuiya2021@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922084557.532-1-rahadbhuiya2021@gmail.com>
References: <20260922084557.532-1-rahadbhuiya2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:58:19 +0000
Message-Id: <20260922085820.3F9AF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] scx: RT tasks misclassified as low priority in is_high_prio()
- [Medium] scx: uninitialized stack memory read in main() on allocation fai=
lure
- [Medium] scx: missing volatile qualifier on exit_req signal flag
--

commit 909c1bfd71282dc986104d5879f86c906eb61d81
Author: rahadbhuiya <rahadbhuiya2021@gmail.com>

tools/sched_ext: Add scx_priority dual-queue priority CPU scheduler

This commit adds scx_priority, a dual-queue priority CPU scheduler using
sched_ext. It separates latency-sensitive/interactive tasks from normal/bat=
ch
tasks, queuing high-priority tasks to a dedicated high-priority DSQ with
boosted time slices.

> diff --git a/tools/sched_ext/scx_priority.bpf.c b/tools/sched_ext/scx_pri=
ority.bpf.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/sched_ext/scx_priority.bpf.c

[ ... ]

> +static bool is_high_prio(const struct task_struct *p)
> +{
> +	/*
> +	 * In the Linux kernel, static_prio maps nice -20..19 to 100..139.
> +	 * Default nice 0 corresponds to static_prio 120. Tasks with nice < 0
> +	 * (static_prio < 120) or real-time policies are prioritized.
> +	 */
> +	return p->static_prio < 120;

[Severity: Medium]
Does this accurately capture real-time tasks as intended by the comment?

Real-time tasks typically have a static_prio of 120 (nice 0), while their
effective prio is between 0 and 99. By checking p->static_prio < 120, would=
n't
real-time tasks be mistakenly classified as low priority and placed in the
standard/batch queue?=20

Should this evaluate p->prio instead to correctly identify tasks with=20
real-time policies?

> +}
> +
> +s32 BPF_STRUCT_OPS(prio_select_cpu, struct task_struct *p, s32 prev_cpu,=
 u64 wake_flags)

[ ... ]

> diff --git a/tools/sched_ext/scx_priority.c b/tools/sched_ext/scx_priorit=
y.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/sched_ext/scx_priority.c

[ ... ]

> +static bool verbose;
> +static sig_atomic_t exit_req;

[Severity: Medium]
Can the program fail to exit gracefully on SIGINT or SIGTERM?

Because exit_req is modified asynchronously in a signal handler and checked
in the main loop, lacking the volatile qualifier might allow the compiler to
optimize and cache the flag. Could this result in an infinite loop?

> +
> +static int libbpf_print_fn(enum libbpf_print_level level, const char *fo=
rmat, va_list args)

[ ... ]

> +static void read_stats(struct scx_priority *skel, __u64 *stats)
> +{
> +	int nr_cpus =3D libbpf_num_possible_cpus();
> +	__u64 *cnts[2];
> +	__u32 idx;
> +
> +	assert(nr_cpus > 0);
> +	cnts[0] =3D calloc(nr_cpus, sizeof(__u64));
> +	cnts[1] =3D calloc(nr_cpus, sizeof(__u64));
> +	if (!cnts[0] || !cnts[1]) {
> +		free(cnts[0]);
> +		free(cnts[1]);
> +		return;
> +	}

[Severity: Medium]
Does this early return leave the stats array out-parameter uninitialized?

If calloc fails under memory pressure, this returns before memset is called
to initialize the stats array to zero.

> +
> +	memset(stats, 0, sizeof(stats[0]) * 2);

[ ... ]

> +	while (!exit_req && !UEI_EXITED(skel, uei)) {
> +		__u64 stats[2];
> +
> +		read_stats(skel, stats);
> +		printf("%-15llu %-15llu %-15llu\n",
> +		       stats[0], stats[1], stats[0] + stats[1]);

[Severity: Medium]
When read_stats returns early on allocation failure, won't this printf
read from the uninitialized stats array on the stack?

> +		fflush(stdout);
> +		sleep(interval);
> +	}
> +
> +	bpf_link__destroy(link);
> +	ecode =3D UEI_REPORT(skel, uei);
> +	scx_priority__destroy(skel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084557.532-=
1-rahadbhuiya2021@gmail.com?part=3D1
