Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6014052BB;
	Fri,  4 Sep 2026 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521135; cv=none; b=s9X8S9RIU15DkHNmHOIePoWRP+HmqrcUpnrhervzL+GPVZL/Bj6Oqr2qnGFJaeiErBtsJQtAkVdaUo+G5y+2i4sWJ71yfiiL56eg9dmVLeTupwxuh1kE/8jwcre4mKZO5M+Vu+DOKeEoqvyBdbfYnG82tK2ZYoRd+FwK+194V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521135; c=relaxed/simple;
	bh=1pvyWnrQxIwi2JPXOXJev5rAjKEXQJNnU8aT39OlX+8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cDRApWYiyeST6PbmY6awqUdhqv+Ijw2l6d8OT8Y6tDN3H04qawjVJlN8aobq/xE1PkerztUZVCULRQJc5qz2l77mCvgqzg2TvpKoTMTrvUwiv/tzWH2sbTh0llGmLmNEDEBRPW/65QJRHSsNd93cVIhvmdcG4k9QP9PAXnsn4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNate+tZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNate+tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6171F00A3E;
	Fri,  4 Sep 2026 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521134;
	bh=g0Hx9IkcnC9yI6FW6UAfMW2/eWJ/9yUrVjzbboHYdGE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oNate+tZINO21Z6rg2gAhqOHaOa7D1PgqzmZzm2o6lRjp3omI6uQffc0CGFaskXlf
	 Wtl9cu5fXZANV+j+tFjFoM/rb2zKKBP3PDs8HNLSyPixA5Utz0GTLtzZE8aZmEZMSP
	 yGovCdsGIfXGKPTFJ8G9MOsyI45QuD9S/HxSp0+0mzh583UhGvOm+P1+xM2f1KVXo/
	 GbYVXXFJa4E4bJxc4tWnr16zdzIYL0NkN6jEQ4mzNU0nvdApj0myCN8t9dWvLiWc2I
	 VSHVUruLva3cE0Vij86eSa3ANebkNzkL92AoYKz6n18YK+pANCVPisCpvycPJFPUNz
	 lVxRqTKgIkqBw==
Content-Type: multipart/mixed; boundary="===============8006556704449721133=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9c166c8436f504519e6c236cf6c6c1c08981610fc3b9ff6c47c7cd084e304de8@mail.kernel.org>
In-Reply-To: <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
References: <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 11:25:33 +0000 (UTC)

--===============8006556704449721133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..92f35ba66309e 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/memcontrol.h>
> +#include <linux/swap.h>
>  #include <linux/bpf.h>
>
>  __bpf_kfunc_start_defs();

[ ... ]

> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes, clamped to
> + *         MEMCG_CHARGE_BATCH (64 pages)
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + *
> + * @size is clamped so that one call is a bounded unit of work, matching
> + * the memory.high workqueue fallback in high_work_func(). To reclaim
> + * more, call this kfunc repeatedly instead of passing a larger @size.
> + *
> + * This kfunc is restricted to BPF_PROG_TYPE_SYSCALL to ensure it runs
> + * in a clean process context. The SYSCALL program can schedule the
> + * actual reclaim work via bpf_wq or timers, which also execute in
> + * safe process context (workqueue, task_work).

Does the kernel-doc accurately describe when this kfunc can be called?

The doc says "bpf_wq or timers" can call this kfunc and attributes "safe
process context (workqueue, task_work)" to both. bpf_timer callbacks run
in softirq context (HRTIMER_MODE_REL_SOFT in kernel/bpf/helpers.c), not
process context, and the verifier rejects the documented pattern:

kernel/bpf/verifier.c:is_async_cb_sleepable() {
    /* bpf_timer callbacks are never sleepable. */
    if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_timer_set_callback)
            return false;

which then causes check_kfunc_call() to reject the KF_SLEEPABLE kfunc:

    if (sleepable && !in_sleepable(env)) {
            verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
            return -EACCES;

So a bpf_timer callback calling bpf_proactive_reclaim() fails verification
regardless of the program being marked sleepable.

The commit message says "A SYSCALL program can still drive reclaim
asynchronously through bpf_wq or task_work callbacks", and the block
comment above BTF_KFUNCS_START(bpf_memcontrol_reclaim_kfuncs) says "The
bpf_wq and task_work callbacks that a SYSCALL program schedules run as the
same program type". Only the kernel-doc substitutes "timers" for
task_work, so the three descriptions disagree.

The follow-up selftest (5ed7b6799588 "selftests/bpf: Add memcg async
reclaim test") demonstrates the actual constraint: its bpf_timer callback
wq_timer_cb() only calls bpf_wq_start()/bpf_timer_start(), and
bpf_proactive_reclaim() is called solely from the bpf_wq callback
reclaim_work_fn().

Could "or timers" be dropped (or reworded to "a bpf_timer callback can
only kick a bpf_wq; the kfunc itself must be called from the bpf_wq or
task_work callback") so the kernel-doc matches both the verifier and the
other two descriptions in the patch?

> + *
> + * When reclaim is driven from a bpf_wq, call this kfunc once per
> + * callback and requeue the same work item for the next batch rather
> + * than looping inside the callback: a long-running callback stalls
> + * other work on the shared workqueue, and because lru_lock is held with
> + * interrupts disabled the resulting contention also delays IPI
> + * handling. Give each target memcg its own bpf_wq item, so that
> + * reclaiming one memcg neither serializes behind nor piles up on top of
> + * another. Deciding whether to submit the next batch is up to the BPF
> + * program, which can stop at any point, e.g. once the target cgroup is
> + * dying.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33864052510
--===============8006556704449721133==--
