Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937235B65D;
	Thu, 24 Sep 2026 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226141; cv=none; b=ga2ZUkpUXp1wbjfzhAcV1vnzoA1EvV3BF+CvTaMD/Sau98Hqa9YquGi9Gb1mGP3wbcFMsukqfxhAlM0fNmGb1lg9g9IUALHxu3vVW/V/r4huKtla6l9eRgjkQttn3T77BaeLW6CKqPED7P+vYcUcxp+Y/h4YpFNDHI4V0M71Qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226141; c=relaxed/simple;
	bh=K1hcWWB0zjvRZpRPrDgIq6rMyz19jNWik4SrurUft+A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AiV8N0AUKAJRrY/4HRVQLdkyRYojsHvsx81kaauqpjpP/PoYij1aQg8D+nC0B+o+3hOicqXQKTAtVSi9ETpCVhIdXvEtoPjLUH98RBNi2PJ1UPXZNhk0ICVy2zla0BxKsL3WVhD43otfpramDI7bmWf3qLqeudbva1TNxQD68R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiI1am/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiI1am/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19541F000FF;
	Thu, 24 Sep 2026 05:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790226139;
	bh=lXNEueqMCRREz5N5CQfkfW8XWDi10Z7xuAbrRSHchSQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kiI1am/1zZpTnT6AGoHTLhMiXC9JBLSCbNvSU5M7JPO8QoiKdxRBHH9YblcEcPN5j
	 56TaAjcDpskHwyVNwfaSHxwsxMHxoRvSgjFKAs0dheI7GyjamX7uMKE2Swzx9c6b35
	 +pePpMV4ml5Pc7sJfMUExEFkuiQTjdQory2R8r2U0miBbitqNf9w2joN7AwPzc6ot/
	 v8V0SGQhBg5ljmk3BKRFu1JMFzkfS2+ZjhQ+hX8RKYslPiymizgIHX0GhPyNuY2ZU+
	 N8ay4u5jKbWI5Cbq/O8Rr7f1VoBMgc30zH0KuGIjKZ0lcO9N2CAaY69AtsaeL6GC/4
	 Q2C75UwjOrJNA==
Content-Type: multipart/mixed; boundary="===============5311084438262854122=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99204600993999e8ff4929b758720dafe0a6c2b4c2d5c1e03ede485e9d2e9747@mail.kernel.org>
In-Reply-To: <de7adb6bafa3b808e29c0630f7ed9a2003e5e447.1790222105.git.zhuhui@kylinos.cn>
References: <de7adb6bafa3b808e29c0630f7ed9a2003e5e447.1790222105.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next 2/2] samples/bpf: Add memcg async reclaim example
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,david@kernel.org,baohua@kernel.org,geliang@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 05:02:15 +0000 (UTC)

--===============5311084438262854122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/samples/bpf/memcg_async_reclaim.h b/samples/bpf/memcg_async_reclaim.h
> new file mode 100644
> index 000000000000..96fe03d12912
> --- /dev/null
> +++ b/samples/bpf/memcg_async_reclaim.h
> @@ -0,0 +1,39 @@

[ ... ]

> +struct reclaim_cfg {
> +	/* Cgroup whose refaults are watched, i.e. the one under pressure. */
> +	__u64 monitor_cgroup_id;
> +	/* Cgroup that gets reclaimed from when the monitor refaults. */
> +	__u64 target_cgroup_id;
> +	/* Refault delta per tick that starts a reclaim round. */
> +	__u64 refault_threshold;
> +	/* Monitor tick period, in nanoseconds. */
> +	__u64 interval_ns;
> +	/* Bytes requested per bpf_wq callback. */
> +	__u64 batch_bytes;
> +	/* Callbacks per reclaim round. */
> +	__u64 max_batches;
                ^^^^

Does this comment accurately describe max_batches? The BPF side does not
count callbacks. It uses max_batches only to size a byte budget and keeps
requeueing until that budget is spent:

samples/bpf/memcg_async_reclaim.bpf.c:reclaim_work_fn() {
    elem->remaining = elem->max_batches * elem->batch_bytes;
    ...
    if (nr >= elem->remaining)
        elem->remaining = 0;
    else
        elem->remaining -= nr;
    if (elem->remaining)
        bpf_wq_start(&elem->work, 0);
}

bpf_proactive_reclaim() limits each pass to MEMCG_CHARGE_BATCH (64 pages),
which is 256 KiB with 4K pages.

With --batch 1M --max-batches 32 each callback reclaims at most about 256
KiB, so the round runs at least 128 callbacks, not 32. A partial reclaim
also adds callbacks. An overshoot, or a zero return that ends the round,
gives fewer.

Two other comments in the same patch describe it correctly: the .bpf.c
comment says "a clamped batch only means a round needs more callbacks,
because remaining is decremented by the bytes actually reclaimed", and the
loader says "One round budgets max_batches * batch_bytes". The header,
which documents the BPF/userspace interface, contradicts both.

The same wording is in the --max-batches help text in
memcg_async_reclaim_user.c.

Suggested wording: "Round budget, in units of batch_bytes."

> diff --git a/samples/bpf/memcg_async_reclaim_user.c b/samples/bpf/memcg_async_reclaim_user.c
> new file mode 100644
> index 000000000000..d5296fd0fab1
> --- /dev/null
> +++ b/samples/bpf/memcg_async_reclaim_user.c
> @@ -0,0 +1,1141 @@

[ ... ]

> +static void session_stop(struct session *s)
> +{
> +	unsigned long long failures, last_err;
> +
> +	if (!s->skel)
> +		return;
> +
> +	ring_buffer__free(s->rb);
> +	s->rb = NULL;
                ^^^^

In bench mode the reclaim_events ring buffer is never consumed, so the
event counters and --verbose output do not work there. s->called,
s->skipped_dying and s->target_gone are only updated from
on_reclaim_event(), and that callback only runs from ring_buffer__poll().

The only caller of ring_buffer__poll() is session_poll(), and the only
caller of session_poll() is do_watch().

do_bench() goes session_start() -> run_workload() -> session_stop(), and
session_stop() calls ring_buffer__free(s->rb) without a final
ring_buffer__consume().

So every bench run prints "events: called=0 skipped_dying=0 target_gone=0"
even when the "total:" line read from .bss shows calls=N > 0.

> +	failures = s->skel->bss->timer_failures;
> +	last_err = s->skel->bss->last_reclaim_err;
> +
> +	printf("\nran for %.1fs\n", now_sec() - s->start);
> +	print_counters(s, "total:");
> +	printf("events: called=%llu skipped_dying=%llu target_gone=%llu\n",
> +	       s->called, s->skipped_dying, s->target_gone);
> +	if (failures)
> +		printf("WARNING: monitor timer rearm failed %llu time(s), reclaim stopped early\n",
> +		       failures);
> +	if (last_err)
> +		printf("WARNING: bpf_proactive_reclaim() last failed with -%llu\n",
> +		       last_err);

The -v option, which usage() lists under "Common options" as "print every
reclaim event", prints nothing in bench mode.

The same missing final drain also drops any watch-mode events that arrive
between the last session_poll() and session_stop().

Should do_bench() poll or consume the ring buffer while the workload runs,
or should session_stop() call ring_buffer__consume(s->rb) before freeing
it?

[ ... ]

> +static int do_watch(struct options *o)
> +{
> +	struct session s = {};
> +	__u64 monitor_id, target_id;
> +	double next_stats, deadline = 0;
> +	int ret = 1;

[ ... ]

> +	while (!READ_ONCE(exiting)) {
> +		double now = now_sec();
> +		int wait_ms;
> +
> +		if (deadline && now >= deadline)
> +			break;
> +
> +		wait_ms = (int)((next_stats - now) * 1000);
> +		if (wait_ms < 0)
> +			wait_ms = 0;
> +
> +		if (session_poll(&s, wait_ms)) {
                    ^^^^

The --duration option is only checked once per statistics interval, so
watch mode can run well past the requested time.

wait_ms is computed only from next_stats and is never clamped to the
deadline. session_poll() keeps calling ring_buffer__poll() in 200 ms
slices until the whole wait_ms is used up, and it only returns early on a
signal or an error.

For example, with the default --stats 10 and --duration 3, nothing is
checked until about 10 s have passed on an idle system, so the program runs
for about 10 s instead of 3 s. With -s 60 -D 5 it runs for about 60 s.

usage() says "-D, --duration SEC    stop after SEC seconds".

Should wait_ms be limited to min(next_stats, deadline) - now?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35955613591
--===============5311084438262854122==--
