Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4754CF4A;
	Wed,  9 Sep 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979467; cv=none; b=MsODsXwMaQqK02As345xtEnICuAfsHuqrV3Fz6qz9klZAJK03wV0k5BFdV6lu8BdDzpe3IhmDne7TchU+dnsiHZwNMXVOmts83s6Dxhyun5pRBIeUzDIiCXMBPZpDKEpgFS0U9/y/0E055iC/CdgN2Qvj7TK2j8OaaMJ5b9lILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979467; c=relaxed/simple;
	bh=yx3kW8mnl57Mg3lDykYsVoHfF6AiK790x8Z8xp3hnKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZp6pK7gxraPsq8LkqBTHzLNxs54z4LggIvVdNnCNrIfYWzu2aRRHRiQOWDlcXjXb2bs+SB2g0Gw9RXYzYTfM6H2lDtcyAKeaJvbjLzMNMG/WcHN2hpw//F5TI+G2pJQ7orcnVPQyT+4NWhg06QMmAXHP7WJjoYhnYhDDH9NwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmFMTWga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmFMTWga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BCF1F00893;
	Wed,  9 Sep 2026 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979465;
	bh=odX1zZCMj//RWnW4dIH8XAW37PB7bVhckACika/nxLY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HmFMTWgaCWppy1pnBtDD8G1ymqMJs8O3xokkTQ3D6myghJ6he1lf6cLF4YgQa7foX
	 qdhYmptdRDKaIihfPOGkbFrj1clnFD+DByE+QBewCng9HqWGVDbcO1hI+iB8EOCoyA
	 UgOvD02Sg6RMFJdcTfEJi6xVkX7OwTmmTJFawj0QXoyZce8+SIZYqA2jNzI+F9qpIW
	 BEDW46RGOQhswMzPhfs0Pc4GDYRVX8pf73r3LeRcolXtgyRNLWPf1B0ybJcCmW1gQg
	 CnU6rW3ec0q459mhDPEAlIdEh3o6ilbDtboNaKEEhtYM4RUktbIYgD4p9QlRIqcTVR
	 GEAehHCiCq03Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80ED7CE086B; Wed,  9 Sep 2026 11:44:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:44:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Brian Vazquez <brianvv@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH bpf-next v2] bpf: Avoid soft lockup in
 __htab_map_lookup_and_delete_batch()
Message-ID: <3a256369-ad51-4241-89e3-5fe82be5c54b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-htab-batch-resched-v2-1-0cb529d8f95a@toxicpanda.com>

On Wed, Sep 09, 2026 at 05:51:04PM +0000, Josef Bacik wrote:
> From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
> 
> __htab_map_lookup_and_delete_batch() has no rescheduling point. The
> batch count bounds how many entries are copied out, not how many
> buckets are visited, so one BPF_MAP_LOOKUP_BATCH call can walk the
> map end to end. The empty-bucket fast path is worse: it stays inside
> a single rcu_read_lock() / bpf_disable_instrumentation() section for
> any run of consecutive empty buckets.
> 
> That holds up on small maps, but it falls apart at scale. On a
> 144-CPU arm64 host running a CONFIG_PREEMPT_NONE kernel, periodic
> BPF_MAP_LOOKUP_BATCH calls against an LRU hash map with 16,777,216
> buckets held a CPU inside the batch op for 77+ seconds and triggered
> the soft lockup watchdog.
> 
> Commit 75134f16e7dd ("bpf: Add schedule points in batch ops") fixed this
> same problem in the generic batch ops, but not in this htab-native path,
> which every htab-based hash map variant uses for its lookup[_and_delete]
> batch ops.
> 
> Complete that fix here. Leave the critical section after 64 consecutive
> empty buckets, call cond_resched_tasks_rcu_qs(), and resume at the saved
> bucket cursor. No locks are held at that point, and resuming from the
> cursor is already the function's behavior for non-empty buckets. Add the
> same call to the per-bucket loop after copy_to_user(), where every lock
> has been dropped. cond_resched_rcu() is not enough here: sleeping with
> bpf_prog_active elevated makes tracing programs on that CPU silently
> skip their invocations.
> 
> Plain cond_resched() is not enough either. It is a no-op under PREEMPT
> and PREEMPT_LAZY, the only models arm64 and x86 have offered since
> commit 7dadeaa6e851 ("sched: Further restrict the preemption modes").
> It is also never a Tasks RCU quiescent state, in any model: the
> reschedule counts as a preemption. The walking task stays a holdout and
> stalls every synchronize_rcu_tasks() caller, ftrace and BPF trampoline
> teardown included, until the syscall returns [1].
> cond_resched_tasks_rcu_qs() is the usual tool for that [2]. It reports
> the quiescent state at each yield and still reschedules as
> cond_resched() does on PREEMPT_NONE and PREEMPT_VOLUNTARY kernels.

Just confirming that cond_resched_tasks_rcu_qs() is needed to permit
Tasks RCU grace periods to make progress, so thank you for that!

							Thanx, Paul

> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Link: https://lore.kernel.org/bpf/20260715215314.44423f47@fangorn/ [1]
> Link: https://lore.kernel.org/bpf/9d444098-7c03-4163-af12-bd0a79a51443@paulmck-laptop/ [2]
> Assisted-by: LLM
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> Changes in v2:
> - Use cond_resched_tasks_rcu_qs() at both yield points so the walk
>   also reports a Tasks RCU quiescent state, and explain why in the
>   commit message
> - Put the opening /* of both comments on its own line (sashiko review
>   on v1)
> - Cc Paul E. McKenney and Rik van Riel, whose thread the message cites
> - Rebase onto bpf-next
> - Link to v1: https://lore.kernel.org/bpf/20260709-b4-htab-batch-resched-v1-1-ad7a6b3b4513@linux.dev
> ---
>  kernel/bpf/hashtab.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6f331c80130d..a72dc5b9f184 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1772,6 +1772,12 @@ static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
>  						 flags);
>  }
>  
> +/*
> + * Max consecutive empty buckets to walk in one RCU +
> + * instrumentation-disabled section before rescheduling.
> + */
> +#define HTAB_BATCH_EMPTY_RESCHED 64
> +
>  static int
>  __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  				   const union bpf_attr *attr,
> @@ -1793,6 +1799,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	unsigned long flags = 0;
>  	bool locked = false;
>  	struct htab_elem *l;
> +	u32 empty_cnt = 0;
>  	struct bucket *b;
>  	int ret = 0;
>  
> @@ -1971,12 +1978,21 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	}
>  
>  next_batch:
> -	/* If we are not copying data, we can go to next bucket and avoid
> -	 * unlocking the rcu.
> +	/*
> +	 * If we are not copying data, we can go to next bucket and avoid
> +	 * unlocking the rcu. Bound the walk though: after
> +	 * HTAB_BATCH_EMPTY_RESCHED consecutive empty buckets, fully exit
> +	 * the critical section (no locks are held here) and reschedule.
>  	 */
>  	if (!bucket_cnt && (batch + 1 < htab->n_buckets)) {
>  		batch++;
> -		goto again_nocopy;
> +		if (++empty_cnt < HTAB_BATCH_EMPTY_RESCHED)
> +			goto again_nocopy;
> +		empty_cnt = 0;
> +		rcu_read_unlock();
> +		bpf_enable_instrumentation();
> +		cond_resched_tasks_rcu_qs();
> +		goto again;
>  	}
>  
>  	rcu_read_unlock();
> @@ -1990,11 +2006,13 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	}
>  
>  	total += bucket_cnt;
> +	empty_cnt = 0;
>  	batch++;
>  	if (batch >= htab->n_buckets) {
>  		ret = -ENOENT;
>  		goto after_loop;
>  	}
> +	cond_resched_tasks_rcu_qs();
>  	goto again;
>  
>  after_loop:
> 
> ---
> base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
> change-id: 20260708-b4-htab-batch-resched-1bce8304766d
> 
> Best regards,
> --  
> Josef Bacik <josef@toxicpanda.com>
> 
