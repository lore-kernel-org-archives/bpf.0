Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FB28E0
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334711; cv=none; b=P6KmiDvdfOZoi/ci1RHpxU2XxKwPLHII24gNXQxk/l0ChWKoDwnNzYQ5Th/3BDdMDYiucaal4JSX1KDKKU4htO6A1/IDopLQVREXYD6xFk/9cFbkpBoakGGF/n661bauxns5tY00rzPTTJcyXd1UnOY6+AgZXfxyPbCEdqbMZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334711; c=relaxed/simple;
	bh=FNweYSuExRe3DrBc5WDiKEVcw19Yqc619K6CQj5Pyj0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gUuPqaRJDUjxowvqMq442B3gF+CGYfwmOMMvxGF5lJAUc01B2svoGniikPyaHqGWEA/7AYs9uMdYoyllGR6XETF++nnoZBDrP51m0nfBKpBkF2IKBDygCPgTOU0sZWfuhkVUlak1i+wH5zgtQrQ/I4FOlAUNJJhqKqj7fyssyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS0s2c7w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS0s2c7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCE3C19425;
	Tue, 28 Apr 2026 00:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334711;
	bh=FNweYSuExRe3DrBc5WDiKEVcw19Yqc619K6CQj5Pyj0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IS0s2c7wggJEngg0LeUzEPuqt5F4gC39M09LDiCi7/JQZ7V8Q9mXSmk5BoGS2u0E/
	 paZzSP+YD0+kmtE8ijQsLW3ln09Tb2aqivBpxOFXFDtxDOJQvexU8VoUmm7vhUhKZo
	 Pk66HReCBjP4cV9NPWNf8R6w0moePmJDYzJKd+yjElzRgXj1IA4MQp/Jbp3wqZziBh
	 4dzCx2+N4i/QmIkNrBePr2HAMig9dULWfnjeOye5CEpSoG8NwUbg6lnXWuSlKyadtv
	 RK6GZtQA/h750xtsAIowEAjAJoehYV6blA1UwVf45ORpn+TD7scIHNxYb5ACtZbw0V
	 dDJM0JcS81aaw==
Content-Type: multipart/mixed; boundary="===============6119424021509097937=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e77ed1ac93e28f5ecb073ea7dbb4c009c81104148c3bb22a78d096e92b0656f@mail.kernel.org>
In-Reply-To: <20260427232313.1582588-2-puranjay@kernel.org>
References: <20260427232313.1582588-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 1/7] selftests/bpf: Add bench_force_done() for early benchmark completion
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 00:05:10 +0000 (UTC)

--===============6119424021509097937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 029b3e21f438..47a4e72208d6 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -741,6 +741,13 @@ static void setup_benchmark(void)
>  static pthread_mutex_t bench_done_mtx = PTHREAD_MUTEX_INITIALIZER;
>  static pthread_cond_t bench_done = PTHREAD_COND_INITIALIZER;
>
> +void bench_force_done(void)
> +{
> +	pthread_mutex_lock(&bench_done_mtx);
> +	pthread_cond_signal(&bench_done);
> +	pthread_mutex_unlock(&bench_done_mtx);
> +}
> +

Is it safe to use pthread_mutex_lock() and pthread_cond_signal() here
given that collect_measurements() calls bench_force_done() from a
SIGALRM signal handler (sigalarm_handler)?

If the signal interrupts a thread that is already holding bench_done_mtx
(for example, a worker thread executing bench_force_done()), the signal
handler will attempt to lock the same mutex:

Thread context:
    bench_force_done()
        pthread_mutex_lock(&bench_done_mtx);  // lock acquired
        [SIGALRM arrives]

Signal handler context:
    sigalarm_handler()
        collect_measurements()
            bench_force_done()
                pthread_mutex_lock(&bench_done_mtx);  // deadlock

This causes a self-deadlock because pthread_mutex_lock() and
pthread_cond_signal() are not async-signal-safe according to POSIX.

Could an async-signal-safe mechanism like an atomic flag with sem_post()
be used instead?

This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/


Could this code lose wakeups because the condition variable is signaled
without a shared state predicate?

If a worker thread completes quickly and calls bench_force_done() before
main() reaches pthread_cond_wait(), the signal will be lost because POSIX
condition variables do not retain state:

Worker thread:
    bench_force_done()
        pthread_cond_signal(&bench_done);  // signal sent

Main thread (not waiting yet):
    [still in setup]
    pthread_cond_wait(&bench_done, &bench_done_mtx);  // misses signal

This would cause main() to block for the full timer duration, defeating
the purpose of bench_force_done(). Should a boolean flag be added to
track the done state?

This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/


>  static void collect_measurements(long delta_ns) {
>  	int iter = state.res_cnt++;
>  	struct bench_res *res = &state.results[iter];
> @@ -750,11 +757,8 @@ static void collect_measurements(long delta_ns) {
>  	if (bench->report_progress)
>  		bench->report_progress(iter, res, delta_ns);
>
> -	if (iter == env.duration_sec + env.warmup_sec) {
> -		pthread_mutex_lock(&bench_done_mtx);
> -		pthread_cond_signal(&bench_done);
> -		pthread_mutex_unlock(&bench_done_mtx);
> -	}
> +	if (iter == env.duration_sec + env.warmup_sec)
> +		bench_force_done();
>  }

[ ... ]

What happens if bench_force_done() is called before the warmup period
fully elapses?

In main(), the final sample count passed to bench->report_final() is
calculated as:

    state.res_cnt - env.warmup_sec

If state.res_cnt is strictly less than env.warmup_sec, the resulting
negative count will bypass the iteration loops in the report_final
callbacks (like ops_report_final()), leaving aggregate variables at zero.

Would subsequent calculations divide by zero and corrupt the benchmark
summary?

This concern was raised in the v1 and v2 reviews by Sashiko AI on lore:
https://lore.kernel.org/bpf/20260420124120.13970C19425@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25025533577
--===============6119424021509097937==--
