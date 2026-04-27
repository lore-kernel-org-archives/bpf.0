Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218883B19B1
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333165; cv=none; b=cQEJMmTkqnnhzGssCmcSFDELWXHG/py7gdNSLo/JwgPxXAQmEoxGp3FUjmWUckh4btTl/BB2W52ZcK9bBRNF5Fl1/0MsttIEOmtDk9u2dMsPBu2EkSjVaYAds8lNcOTeiyIwyZkeqb0SssXKjaPlWxDW6lTF/R3I48fsdu1IFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333165; c=relaxed/simple;
	bh=SBucPtcnygklf94lBFIXV7b+NSeIu4GqY8cDlkY3nOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m30OxMVAwp2+6RSAb//9L9OUHIA8njQLctF+0bBRpiq+WpHAubFl8DCQ/Y5UK0PNngp1MvTDUWqbabyVuCa0BowUmtpiVNaOEwZbuR0xajizoLTCDLm0VwBhWKU8Sby9EGf9IeBwnZA/DK6GB4p9j0lIwNuFJE3LSmA+gJhoawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZTOy6pa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZTOy6pa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98511C19425;
	Mon, 27 Apr 2026 23:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333164;
	bh=SBucPtcnygklf94lBFIXV7b+NSeIu4GqY8cDlkY3nOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XZTOy6pajfVljPFQ3rUNJ9uB4TlBncuSpq8UYXVRgT51duH21pNGCIqE2mxioaBXi
	 6gC6DL71xZsPzzokJsHYJ+sVtbIkyFFfq3EvYoPmonDoAoa5NdyB38vllWvRzVAald
	 IT6Gmrmhg5HSVuaxZ3Nu3yZe/hMzBAgWyUdGb/YXtoyx1/ISgU+YjfxUPJMOkLTsQn
	 82ppBhmoFRX/Y1vk/M8U4eOcb7hKuHOUiL1N3eVvNHA2Q6kcmS99zXHxVGE65E0DVg
	 zXHFnHOFBOm1/nzoFdZ/zgtLGqRwA/MyOfrFd3v6zriJcHCFPlGKgsSfaxqIFYGR+c
	 cnesPDnrRbE/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/7] selftests/bpf: Add bench_force_done() for
 early benchmark completion
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-2-puranjay@kernel.org>
References: <20260427232313.1582588-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 23:39:23 +0000
Message-Id: <20260427233924.98511C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Calling non-async-signal-safe POSIX functions in a signal handler =
creates a self-deadlock risk.
- [Medium] Missing state predicate for condition variable causes lost wakeu=
ps, defeating the patch's purpose.
- [Medium] Early benchmark completion passes negative sample counts to repo=
rting functions, yielding NaN outputs.
--

commit 7ae4c67dc4880455d3c6c1f70bd9e8d56eb4e69b
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add bench_force_done() for early benchmark completion

The bench framework waits for duration_sec to elapse before collecting
results. Benchmarks that know exactly how many samples they need can
call bench_force_done() to signal completion early, avoiding wasted
wall-clock time.

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -741,6 +741,13 @@ static void setup_benchmark(void)
>  static pthread_mutex_t bench_done_mtx =3D PTHREAD_MUTEX_INITIALIZER;
>  static pthread_cond_t bench_done =3D PTHREAD_COND_INITIALIZER;
> =20
> +void bench_force_done(void)
> +{
> +	pthread_mutex_lock(&bench_done_mtx);
> +	pthread_cond_signal(&bench_done);
> +	pthread_mutex_unlock(&bench_done_mtx);
> +}
> +

Since bench_force_done() is now exported for concurrent benchmark worker
threads to call directly, could this lead to lost wakeups?

Condition variables are stateless. If a fast-running benchmark finishes and
signals the condition variable before main() reaches its wait statement:

tools/testing/selftests/bpf/bench.c:main() {
    ...
    pthread_cond_wait(&bench_done, &bench_done_mtx);
    ...
}

Will the signal be permanently lost, causing main() to sleep for the full
duration and defeating the goal of the patch?

Also, if a benchmark legitimately completes its target operations and calls
bench_force_done() before the warmup period is fully satisfied:

tools/testing/selftests/bpf/bench.c:main() {
    ...
    if (bench->report_final)
        bench->report_final(state.results + env.warmup_sec,
                            state.res_cnt - env.warmup_sec);
}

Could state.res_cnt - env.warmup_sec evaluate to a negative integer?

Passing a negative sample count to reporting functions might cause
reporter loops to fail bounds checks and yield nan outputs.

>  static void collect_measurements(long delta_ns) {
>  	int iter =3D state.res_cnt++;
>  	struct bench_res *res =3D &state.results[iter];
> @@ -750,11 +757,8 @@ static void collect_measurements(long delta_ns) {
>  	if (bench->report_progress)
>  		bench->report_progress(iter, res, delta_ns);
> =20
> -	if (iter =3D=3D env.duration_sec + env.warmup_sec) {
> -		pthread_mutex_lock(&bench_done_mtx);
> -		pthread_cond_signal(&bench_done);
> -		pthread_mutex_unlock(&bench_done_mtx);
> -	}
> +	if (iter =3D=3D env.duration_sec + env.warmup_sec)
> +		bench_force_done();
>  }

collect_measurements() executes in the context of a timer signal handler.

Posix specifies that pthread_mutex_lock() and pthread_cond_signal() are
not async-signal-safe.

If the timer signal interrupts a thread exactly while it already holds
bench_done_mtx, will the signal handler attempt to acquire the same
non-recursive mutex and cause a self-deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D1
