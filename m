Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC563B14DE;
	Mon, 10 Aug 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368007; cv=none; b=rk8r7bMwTyJFJXqIW/d+F0j322ctAlx85/lICS/BmAWhFFSxvgGDFIHA1jtTYdZf0+o3qIXddWTMILHCCH1crL5RdkSS6CNETse3QCGyJ1j7mLtrJUCZlZtW4KfJXLJtx2Fy/4HoQphvS9NnqOVfD6GtICUypHmIA7jwKUWU4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368007; c=relaxed/simple;
	bh=23n7xNC0wK5ZUHggYjdx8rmCopX+e5uhX04mNc2+sd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Du9ISgUUc5+soVYZE63iv9X14y+sN5K5ytmWbGaw/Z5Z5iefW1KGAwmh/saXzOJx+gb8AbK8WCCTASKWi5SMX0Z15a2lEpE9q6CmUEsEh4wumvwTcT6VP+nwLq3zK2zgsKRbaQlAbkqI1LddFBsvrQKgM0fdqyPqTCrNMYVoia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsI5BaBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsI5BaBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D1F1F00A3A;
	Mon, 10 Aug 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368005;
	bh=CWZbcJZd01Rh3SjqaHYZ8Ee+dXAZQOE2onsgdhR5pbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bsI5BaBHTmDAgytN/JS299plhBl85drxk50UvEYDr+Azx2jePdMB1s7GsiN+BFxDJ
	 2cLXdBAoWav1pW8cU5bGpXwYdKknihwjuy0Z+yvb0aQVijJQKFqdMK8yvikr24VTr6
	 aw6zCVkEa0ucldtCWjSK/2ddK6LFTSIzHVCx+3OwE+X1Iqas3Fmr9J5Yyn335S9FYy
	 41nZnmSUgxSj0TCFk5kE+4lRZ2VN/HzsTPpchKFxYFx8tuZ+/ab3ljZs7oijdNnLwv
	 7w8dQXwnqRyK+IQhgxMlAMbOFe3ewlq27r/t6ZuCI7juFDfLOkKBcsE6zWJizoTSQ/
	 jBvbKOvZEkxDg==
From: Puranjay Mohan <puranjay@kernel.org>
To: sashiko-reviews@lists.linux.dev, chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
In-Reply-To: <20260810100047.946191F00A3A@smtp.kernel.org>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
 <20260810094634.2723213-4-chenyuan_fl@163.com>
 <20260810100047.946191F00A3A@smtp.kernel.org>
Date: Mon, 10 Aug 2026 14:19:58 +0100
Message-ID: <m2ecg66rk1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] A race condition between dropping the arena spinlock and flushing the TLB allows concurrent reallocation and stale TLB access, leading to an information leak.
> --
>
> --- Patch [3]: [PATCH bpf-next v2 3/3] bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker ---
> commit d52cc998404e8cd2b8a37ee307bab5c587ce8336
> Author: Yuan Chen <chenyuan@kylinos.cn>
>
> bpf, arena: check range_tree_set return in arena_free_pages and arena_free_worker
>
> arena_free_pages() and arena_free_worker() now handle range_tree_set()
> errors. arena_free_pages() aborts the free on error, and
> arena_free_worker() moves range_tree_set() before PTE clearing so that a
> failed tree update leaves the PTEs intact instead of freeing pages that
> the arena free tree does not track.
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7b6847200b431..4597d9becb97a 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -881,7 +881,12 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>>  	if (ret)
>>  		goto defer;
>>  
>> -	range_tree_set(&arena->rt, pgoff, page_cnt);
>> +	ret = range_tree_set(&arena->rt, pgoff, page_cnt);
>> +	if (ret) {
>> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>> +		return;
>> +	}
>
> [Severity: High]
> This is a pre-existing issue, but does marking the range as free here,
> before dropping the spinlock and flushing the TLB, create a race condition?
>
> If CPU 1 calls arena_free_pages(), marks the pages as free via
> range_tree_set(), clears the PTEs, and drops the spinlock:
>
>         ret = range_tree_set(&arena->rt, pgoff, page_cnt);
>         ...
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>
> Before CPU 1 executes flush_tlb_kernel_range(), could CPU 2 allocate the
> same virtual address via bpf_arena_alloc_pages() and populate new PTEs? 
>
> If CPU 2 (or another CPU) previously accessed this virtual address, its
> TLB might still point to the old physical page. Writes to this address
> would then incorrectly modify the old physical page.
>
> CPU 1 would then flush the TLB and free the old physical page to the buddy
> allocator, potentially leaking sensitive data to other processes.
>
> [ ... ]
>
>> @@ -1004,11 +1009,18 @@ static void arena_free_worker(struct work_struct *work)
>>  		kaddr = arena_vm_start + s->uaddr;
>>  		pgoff = compute_pgoff(arena, s->uaddr);
>>  
>> +		/*
>> +		 * Mark the range as free before clearing PTEs so that
>> +		 * if the range tree update fails we leave the PTEs
>> +		 * intact, avoiding an unrecoverable state where pages
>> +		 * are freed but the arena free tree does not track them.
>> +		 */
>> +		if (range_tree_set(&arena->rt, pgoff, page_cnt))
>> +			continue;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same race
> condition exist here in the asynchronous worker?
>
> The worker marks the range as free via range_tree_set() and drops the
> spinlock:
>
>         if (range_tree_set(&arena->rt, pgoff, page_cnt))
>                 continue;
>         ...
>         raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>
> Before iterating the list again to call flush_tlb_kernel_range(), this
> seems to expose the old physical pages to the same concurrent reallocation
> race window as arena_free_pages().
>

Both these issues are real and I am working on a fix for these. I
already saw them while fuzzing the BPF JITs through litmus tests.

Will post the patch soon.

Thanks,
Puranjay
