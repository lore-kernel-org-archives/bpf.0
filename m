Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30373FF883
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181749; cv=none; b=XowiwnYaVS3R9tOg9RzucmxhoTnmyh4b1irYdCV9EvHMslbStVtNZwkDIOEzYSUTBOPytmrPzs3MIb/Y398BLOBc4foKZLvH7MdFB7ZQuoXFdirZAZ/+u875r6xCdzMNkOZUFvdi9PWDynPdN7moD8l2TbKFE6zR7wPHI5wn1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181749; c=relaxed/simple;
	bh=6WXBZx7VybXZO8Cs9zZYKTlYHZd+/hJLPbSgYZdQM9I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Pw8OiHwW2/22yDAYGL2Rk82x7UErtcIuK4uqZ69JzlK2YJhjm7PYXmvU6XH7fptZt91jXIU1oZx634YEmvE6PgJBetCtVe5XOcVqxscC0vVIb3FWQyS9K5yamocaXqGG4Z/cRvrECMbl8O8YNR+TC7T75gmSduA4jbAGCjRC5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNXUPvV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNXUPvV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED231F000C7;
	Fri, 16 Oct 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181746;
	bh=Uj2Pq64qQUSTylua47xgcdAGd10Sm5jKHU353VcXw/M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RNXUPvV9t6wa6kujXmjGBUSM32h+XvInrtxfmqh55KTrvX77L9i/9BEWJjPP7WsII
	 GHu3DBYkLZuKlCno6+roHqkbC6sYprtF4G5ldQCryPoXLSlI3wE4o4PXfRGlyWsJT5
	 L+NzFJkzCgTtTysZKOKpvr4BLOnufmDnVUVvl5xRb6tuUoCR7EuSDRr1/VvDPKNdHL
	 1rmyHv+O61w5hlo/bYOP3gjxrt/IMn7O4djuVzqsklLNyKn58Qc6enxVPhMttKxPN8
	 rQLX++O4ygp1QUaj1wXyHxE0uw9mEzLfvJ5OHevDZc48P/t0GB0CVf0fji908B4XgI
	 UgQUTWKtMWPew==
Content-Type: multipart/mixed; boundary="===============6884090553511571779=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10734759ee92e0a600e07197216a9279c32918329ce45c729f9301d8109594c5@mail.kernel.org>
In-Reply-To: <20261016193703.9203-4-emil@etsalapatis.com>
References: <20261016193703.9203-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Fix arena race between page free and alloc leading to incoherency
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,nickolay.lysenko@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 20:15:45 +0000 (UTC)

--===============6884090553511571779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix arena race between page free and alloc leading to incoherency

TL;DR: arena_prepare_zap() holds every mapper's mmap_lock during a free, so
with ~45+ processes mapping the arena it may exceed lockdep's MAX_LOCK_DEPTH
and disable lockdep; it may also stall mmap/munmap in those processes.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index dde887dac596..dd9f322ad57f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -925,154 +1025,301 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt

[ ... ]

> +/*
> + * Prepare the arena to zap user mappings during a free. The arena
> + * mutex protects against arena_vm_close(), per-mm state, and
> + * serializes frees. The mm locks protect the PTEs from being
> + * replaced while the page table walks are in progress.
> + *
> + * A BPF program can get here while tracing a free that holds arena->lock,
> + * and while holding an mmap_lock itself, so it only trylocks. The deferred
> + * free worker does neither. It passes @busy and waits for arena->lock, and
> + * gets back the pinned mm of a contended mmap_lock to wait on once it holds
> + * nothing.
> + */
> +static bool arena_prepare_zap(struct bpf_arena *arena, struct mm_struct **busy)
> +{
> +	struct vma_list *vml;
> +	struct mm_struct *mm;
> +
> +	if (busy)
> +		mutex_lock(&arena->lock);
> +	else if (!mutex_trylock(&arena->lock))
> +		return false;
> +
> +	/* We can only have a single VMA per mm for the arena. */
> +	list_for_each_entry(vml, &arena->vma_list, head) {
> +		mm = vml->vma->vm_mm;
> +		/* Exiting MMs cannot start faults; exit_mmap() drops their PTEs. */
> +		if (!mmget_not_zero(mm))
> +			continue;
>  
> -		mmap_read_lock(mm);
>  		/*
> -		 * Re-resolve: while we waited the VMA could have been unmapped
> -		 * and a different mapping installed at the same address.
> +		 * Do trylock to avoid ABBA with arena_vm_close()
> +		 * (arena lock->mmap read lock vs mmap write lock -> arena lock).
>  		 */
> -		vma = find_vma(mm, vm_start);
> -		if (vma && vma->vm_start == vm_start &&
> -		    vma->vm_file && vma->vm_file->private_data == &arena->map)
> -			zap_vma_range(vma, uaddr, size);
> -		mmap_read_unlock(mm);
> -		mmput(mm);
> +		if (!mmap_read_trylock(mm)) {
> +			if (busy)
> +				*busy = mm;
> +			else
> +				mmput_async(mm);
> +			arena_finish_zap(arena, true);
> +			return false;
> +		}
>  
> -		mutex_lock(&arena->lock);
> +		vml->mm = mm;
>  	}

Can this run out of lockdep held_locks slots when many processes map the
same arena?

arena_prepare_zap() keeps one mmap_read_trylock() held per vml, and
arena_free_span() holds all of them until arena_finish_zap(), across
wait_for_faults(), flush_tlb_kernel_range() and zap_pages().  The old
zap_pages() took one mmap_read_lock(mm) at a time and dropped it before
taking the next.

Nothing limits how many processes can mmap the arena.  arena_map_mmap()
only requires the same address and size, and remember_vma() adds a vml for
each mapping.  A successful mmap_read_trylock() still records a held_lock
entry, and no nest_lock groups these acquisitions, so each one takes a slot
in current->held_locks.  The task already holds arena->lock, plus the
rcu_read_lock_trace() map for a sleepable program, or the workqueue lockdep
maps when running from arena_free_worker().

With roughly 45 or more mappers, __lock_acquire() would hit:

    if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
        debug_locks_off();
        ...
        print_lockdep_off("BUG: MAX_LOCK_DEPTH too low!");

since MAX_LOCK_DEPTH is 48.  On a kernel with lockdep enabled that prints a
splat with a stack dump and turns lockdep off for the rest of the boot.

Both free paths reach this for any range that has kernel PTEs:

    bpf_arena_free_pages() -> arena_free_pages(sleepable=true) ->
        arena_free_span() -> arena_prepare_zap()

    arena_free_worker() -> arena_free_span() -> arena_prepare_zap()

Is there a way to bound the number of simultaneously held mmap locks, or to
annotate them so the depth stays constant, the way mm_take_all_locks() does
with down_write_nest_lock(..., &mm->mmap_lock)?

Holding every mapper's mmap_lock also stalls mmap, munmap and mprotect in
all of those processes for the whole wait, flush and zap of each free,
where the old code held one process's lock at a time.

The later commits in the series (ca10da87ab2e "bpf: Retry arena faults when
the arena lock times out" and 1de87c301552 "selftests/bpf: Add arena
allocation race tests") do not change arena_prepare_zap().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38957479108
--===============6884090553511571779==--
