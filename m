Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F773AD537
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669555; cv=none; b=Aq0LMfWXopZeSlj29nra7wmu24dKE8h2Xdly6Th/OmG2B/7Bi2SBO+kUXaOvUv7caIqB+A2fUcmMsghK8jjdla3VA1QVDTMnmEYYJ987M4poJ27SU2dlE0PYZ2xz/w73rh4KMXenP2IUe/8XEWMG00jQ2gVlizbvdwjUeUpNuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669555; c=relaxed/simple;
	bh=BPk3oyYnV6F6ChCVwWgj4sqVrj5w6TF8TJz6O6DUPjc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jh6Hqy/VxM/C5xdc3qnEMoMgS63+4G/eh5jjadR8XrXWt3gUhgWWdjOLYVjXRT7/YX3K9aDcXqn5mMGhuKyqYTZ0ZPJhsdYt6J1H/l/qu15Ha3PNIYwR9dtSix2Zgn6HLX0ky6AFTLXEnvWpRLyPTjSbwgHytaNGpjYvn5JAwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGcOz5jY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGcOz5jY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A7C1F000FF;
	Tue, 29 Sep 2026 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669552;
	bh=xGo9cWS+HTZrzLFsoooXQNkLs9maKGEPlaiU5Z79SFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iGcOz5jYUK6+0B7oC/THBcXytoR3QTeqEaXjPZjiEbyI3wgju0VI18NdP2OHm0Htq
	 NOiCM1NtY+zRka35kwQVv026yt1Dw0q6yP5eTlTIJU/jv/0gfWO8L/J4AE3AIA+f8w
	 8aIuthY+Hw8Ke9abnNHZxUOCLj6kJnuzueVJYrp+IvtiSI9OhG2n9PzT+fK5aUEmYb
	 sxmuK65DFbTx74IonT//MEZfI/+0CplWRZWnVj1BtZOtcmAEeImWUCcuRwoRHBK5Nk
	 z5aoQqc7cjRm0UA7hWlTRJNfGmrJM0dN5bbZoFm3rufzJ6eec3vvULJsYb1K/6hzl0
	 1fPk8SLv4vtSw==
Content-Type: multipart/mixed; boundary="===============4939061171438555515=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9ea45b3f464aec62edb4a2797fe3450bae63a2d6c24666af13731730f89f39e8@mail.kernel.org>
In-Reply-To: <20260929072800.113129-4-luyun_611@163.com>
References: <20260929072800.113129-4-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add task work scheduling race test
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 08:12:31 +0000 (UTC)

--===============4939061171438555515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add task work scheduling race test
>
> Exercise task-work scheduling and callback execution on different CPUs
> while userspace reuses or deletes the associated map value.  Run 1500
> rounds rotating through context reuse, deletion after the callback has
> recorded its generation, and deletion racing with scheduling.
>
> Publish the scheduling result and its generation in one packed value, so
> userspace does not rely on ordering between separate map slots.  Record
> callbacks in separate per-generation slots so an earlier callback cannot
> satisfy a later round's completion check.
>
> Retry transient -EBUSY results while the context is unavailable for
> reuse.  In the deletion-race case, allow -ENOENT if the element is
> removed before a retry finds it.
>
> Choose two CPUs from the process affinity mask and skip if fewer than
> two are available.  Bound the thread-start wait, report thread creation
> and affinity failures, and stop the worker threads with an atomic
> handshake.
>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

This isn't a bug, but could the changelog say which of the preceding fixes
this test is meant to cover, and which interleaving each variant targets,
instead of listing implementation details like the bounded thread-start
wait and the atomic stop handshake?

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_work.c b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_work.c
> @@ -5,10 +5,14 @@
>  #include <stdio.h>
>  #include "task_work.skel.h"
>  #include "task_work_fail.skel.h"
> +#include "task_work_race.skel.h"
>  #include <linux/bpf.h>
>  #include <linux/perf_event.h>
>  #include <sys/syscall.h>
>  #include <time.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <unistd.h>

[ ... ]

> +static void *task_work_race_trigger(void *arg)
> +{
> +	struct task_work_race_ctx *ctx = arg;
> +	int err;
> +
> +	err = task_work_race_pin_cpu(ctx->trigger_cpu);
> +	if (err)
> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
> +	__atomic_store_n(&ctx->trigger_tid, syscall(__NR_gettid),
> +			 __ATOMIC_RELEASE);
> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
> +		getppid();
> +	return NULL;
> +}
> +
> +static void *task_work_race_target(void *arg)
> +{
> +	struct task_work_race_ctx *ctx = arg;
> +	int err;
> +
> +	err = task_work_race_pin_cpu(ctx->target_cpu);
> +	if (err)
> +		__atomic_store_n(&ctx->setup_err, err, __ATOMIC_RELEASE);
> +	__atomic_store_n(&ctx->target_tid, syscall(__NR_gettid),
> +			 __ATOMIC_RELEASE);
> +	while (!__atomic_load_n(&ctx->stop, __ATOMIC_ACQUIRE))
> +		getppid();
> +	return NULL;
> +}

This isn't a bug, but could the trigger and target threads share one
function with a small per-thread argument (cpu and tid pointer)? And could
the repeated 2000000 / 100 poll bound become a named constant, like
TASK_WORK_RACE_ROUNDS?

[ ... ]

> +		err = task_work_race_check_done(skel, seq);
> +		/*
> +		 * Variant 2 deletes the element right after READY, so losing
> +		 * the race against the scheduling kfunc is a valid outcome:
> +		 * the schedule itself fails with -EBUSY (ctx already FREED),
> +		 * and the retry on the next tracepoint invocation fails with
> +		 * -ENOENT because the element is gone.  Either way the round
> +		 * exercised the deletion paths; a later variant 0 round
> +		 * recreates the element.
> +		 */
> +		if (variant == 2 && (err == -EBUSY || err == -ENOENT))
> +			err = 0;

This isn't a bug, but can err actually be -EBUSY here, given that
race_sched_work() returns without publishing RESULT on -EBUSY? If not,
could the condition just check -ENOENT?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/task_work_race.c b/tools/testing/selftests/bpf/progs/task_work_race.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_work_race.c

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36538172291
--===============4939061171438555515==--
