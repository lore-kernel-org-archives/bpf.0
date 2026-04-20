Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46ED1A680F
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688880; cv=none; b=P+ozcL1VOW9vgq0luwQao+SCDWS4c4cRwHts4ThNIsqruAYKNnhHk0OEMiWPh1K6xITEusSLaxUPBHZXJUU7ZEbtZqCPTrfB28la50mVgAnqMUhzY3J6/zgHBs7GdChidQP9hefjziSsp90WKtxYG1akNFClkC/pNhbVpMcDKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688880; c=relaxed/simple;
	bh=T8fzYAAbvg4wavQiXO9Naw9WmdJrqWpkGWIiHphaY+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lyWV0EUo+LH1p88StXSzFAH9QfH+ZvKKmx/C9DMF7/c000pyWc348OwxHaadytFiMOBjngRWDUA40K9FRdlz6Zuag9qgiTgOxTRJdUJ/4MiZ8AIY4kdNg4DTrEfy2iEGwAwcNmz4/mzvwk4eaeV9MRS+ByvfqTRTanP+VoQTANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue6w4meu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue6w4meu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13970C19425;
	Mon, 20 Apr 2026 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776688880;
	bh=T8fzYAAbvg4wavQiXO9Naw9WmdJrqWpkGWIiHphaY+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ue6w4meul0EAgIkNguRxLNJU9d/YyqMldxr3Cc/PDxQCxwkQ5rJUxCUzGjMkmapb1
	 clq1zOLy7XzIvGxp88pMFrHEVoyYmw2YFnrEZTvI7hGdI6VOl7JU/dTmTxouf15L4I
	 YxY9jdB5GVwY3QB0JCeAzlGwDFX2wgiGhPYGKs6diCgj5R08Lo000x5oZz/O9k91mQ
	 B9jebxBdEX3Tgwn1E13jXbvNduAI4RBKiksSIP+34bgHmrwHD3U08aSrtBRtb4Btwj
	 WEmVLj0d1uc1wOWU0z++ddy2Xga++eqNVMgxjMnowzHsz8ddX/BdV9tVSe9FzPxizt
	 9Z1+poxm6JD+Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/6] selftests/bpf: Add bench_force_done()
 for early benchmark completion
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-2-puranjay@kernel.org>
References: <20260420111726.2118636-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 12:41:19 +0000
Message-Id: <20260420124120.13970C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] bench_force_done() introduces lost wakeups and spurious wakeups be=
cause it signals a condition variable without a shared state predicate.
- [High] Early termination via bench_force_done() can pass a negative sampl=
e count to report_final(), leading to division by zero.
- [High] Potential deadlock and undefined behavior due to locking a non-asy=
nc-signal-safe mutex inside a signal handler.
--

commit 892d0b6cc51abbb9999e78aaf1cd4e37a1a9bcfc
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add bench_force_done() for early benchmark completion

This commit introduces bench_force_done() to allow benchmarks to signal
early completion. It avoids waiting for the full duration_sec when a
benchmark has already collected the necessary samples.

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c

[ ... ]

> @@ -741,6 +741,13 @@ static void setup_benchmark(void)
>  static pthread_mutex_t bench_done_mtx =3D PTHREAD_MUTEX_INITIALIZER;
>  static pthread_cond_t bench_done =3D PTHREAD_COND_INITIALIZER;
> =20
> +void bench_force_done(void)
> +{
> +	pthread_mutex_lock(&bench_done_mtx);

Is it safe to lock this mutex here considering collect_measurements() is
called from a SIGALRM handler?

If the signal interrupts a thread that is already holding bench_done_mtx
(like a worker thread executing bench_force_done()), the signal handler
will attempt to lock the same mutex and cause a self-deadlock.

Since pthread_mutex_lock() and pthread_cond_signal() are not
async-signal-safe, should an async-signal-safe mechanism like an atomic
flag with sem_post() be used instead?

> +	pthread_cond_signal(&bench_done);

Could this introduce lost wakeups or spurious wakeups because the condition
variable is signaled without a shared state predicate?

If a worker thread completes quickly and calls bench_force_done() before
main() reaches pthread_cond_wait(), the signal will be lost because POSIX
condition variables do not retain state. This would cause main() to block
for the full timer duration.

Also, if main() waits without a while loop checking a condition flag, could
a POSIX spurious wakeup arbitrarily terminate the benchmark prematurely?

> +	pthread_mutex_unlock(&bench_done_mtx);
> +}

What happens if bench_force_done() is called before the warmup period fully
elapses?

In main(), the final sample count passed to bench->report_final() is
calculated as:

state.res_cnt - env.warmup_sec

If state.res_cnt is strictly less than env.warmup_sec, the resulting
negative count will bypass the iteration loops in the report_final
callbacks (like ops_report_final()), leaving aggregate variables at zero.

Would subsequent calculations divide by zero and corrupt the benchmark
summary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D1
