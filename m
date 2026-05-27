Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80A405C34;
	Wed, 27 May 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886783; cv=none; b=ONmKp8zi95QIKUypr4C/UyMsjRU2K110ac5JhaXQe77P8/kgJTiwMbEjYR3SOyfMCkoEeK0b6qDqyuDaJE85L5zs5OkJnhmjZ1OOpcuOPhAYo7o4mA4Z97kkkmcTFGMSpdpUwjqRVjCCWtacIZnFNklazST1vTT+n9jdArzKf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886783; c=relaxed/simple;
	bh=gDNbNJvF3n4HXsDNq3wVrTdHhYalYYmP9I9jMnVPZrI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NXjVm0mc5nv8Kn/1466Jvt5JPtlKMXlsNljsokeO7dg043IUrmg+La/IRAxj6s7I0SJqZ/7BEN9oZLKHq408KoxRKDSAIqu8TIrFtFVJSqaPxTDMYAd5Z/oUMsINQZ6R1m1dnH34RIyVlOk/f2JxvwZJknd1yPQOAZnOaxTrLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofpBF2sL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofpBF2sL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E98F1F000E9;
	Wed, 27 May 2026 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886781;
	bh=ehlTY2EY+S3QAxLdXYjy1OhIA40v3dl4BmS3oTFwxGI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ofpBF2sL0Swe58Mw4zVsmtXGt7yGQ6/DURr6knXozHapWz769lGYQe1xWBU7SBEHs
	 rLJanz5EtjRLY6KO74eBRZIsOquVz6xlYKNwPmPi0qBsKEODq+hF2EcgwKxFW+HBu6
	 fekLa7lMbcWJ4U03WT/9ZGnHwOgDmfsRk5PGeHhEtuqDlUAHPqKDfZVpKq2ZYk0FX0
	 bJqq9bbwCXtfuZSJAcd0QtFtRbhQQAqlPLWux6XFUDbIHQf0WShHOmOFLyUaMW5uMh
	 fnY8zADKKlgrYCvW2G9E8XQvDxhPsZdHyNkSbnegHAb97iOGV64UllhtJYlqs06NVL
	 qTSq570jNR6Mw==
Content-Type: multipart/mixed; boundary="===============8621049861589849500=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e50641fd2a74ad9d6e150c203487d727c900237a07ca8528806f2c6917c0b524@mail.kernel.org>
In-Reply-To: <20260527113951.46265-5-jolsa@kernel.org>
References: <20260527113951.46265-5-jolsa@kernel.org>
Subject: Re: [PATCHv6 bpf-next 04/29] bpf: Use mutex lock pool for bpf trampolines
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 12:59:41 +0000 (UTC)

--===============8621049861589849500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1c6863ce89e0..db89b3a591fa 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a4298a25d4ba..df7634de0ca2 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -30,6 +30,35 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
>  /* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
> +/*
> + * Keep 32 trampoline locks (5 bits) in the pool so trampoline_lock_all()
> + * stays below MAX_LOCK_DEPTH.  Each pool slot has a distinct lockdep
> + * class because trampoline_lock_all() takes all pool mutexes at once;
> + * otherwise lockdep would report recursive locking on same-class mutexes.
> + */
> +#define TRAMPOLINE_LOCKS_BITS 5
> +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> +
> +static struct {
> +	struct mutex mutex;
> +	struct lock_class_key key;
> +} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
> +
> +static struct mutex *select_trampoline_lock(struct bpf_trampoline *tr)
> +{
> +	return &trampoline_locks[hash_64((u64)(uintptr_t) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
> +}

[ ... ]

> @@ -99,12 +128,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
>  	 *   cleanup_direct_functions_after_ipmodify
>  	 *
>  	 * In both cases, direct_mutex is already locked. Use
> -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> -	 * (something else is making changes to this same trampoline).
> +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
> +	 * (something else holds the same pool lock).
>  	 */
> -	if (!mutex_trylock(&tr->mutex)) {
> -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> -		 * some progress.
> +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> +		 * makes some progress.
>  		 */
>  		msleep(1);
>  		return -EAGAIN;

With 32 trampolines sharing pool locks, can mutex_trylock fail spuriously
when an unrelated trampoline holds the same bucket?

If the trylock fails, the function returns -EAGAIN. Could this mean
concurrent ftrace or kprobe registrations might randomly fail due to false
sharing in the pool?

Also, when the upcoming tracing_multi feature locks all 32 mutexes at once,
wouldn't that deterministically abort any concurrent ftrace IPMODIFY
registrations system-wide?

Finally, if this trylock failure happens during unregistration, could
ftrace cleanup routines ignore the -EAGAIN, potentially leaving the
BPF_TRAMP_F_SHARE_IPMODIFY flag permanently set and corrupting the
trampoline state?

Reference: https://lore.kernel.org/bpf/20260418035227.168AEC19424@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686
--===============8621049861589849500==--
