Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9525C804;
	Mon, 24 Aug 2026 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567588; cv=none; b=YllI1M7l4zaAWX/yYlZ/9iwUwCXVSxdTNxoB88SIlr2O4xxy+CJxx12N5L+jcApsyEAPGnOlfQFgpJcaslQb07uekmnQLeT5R0WSyDpTeDrm1Z5SItEQZmjUN+O6118/iGN6GGjPGmVAb0L3gUp7eaSgEucph7UPHUTe3vCYqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567588; c=relaxed/simple;
	bh=OQiI6UYDyIcajlYqcS+P9FdjckXpalzU58XPtlusnKM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o9yCiI0h8LHPMAOX0H2TemDGnl5WyoBKiBDfz9s2vJhMM4GNCjdqL2PuH0LZbdQciTlj2hRDMlNx5jTna+sw9aamWaUL/29Vk3IiehnAydyXHXg9TSae2ByjGJGbnrS1Ouqecoa6/vZhS3zPTLUjIANc5U8ZtLm9f7CBahL6VJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZJHD6zo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZJHD6zo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6961F000E9;
	Mon, 24 Aug 2026 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787567587;
	bh=Jp19kyXAKUO4Zf91dNZ+LWUCCRKlm52z22Ep3C25ing=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bZJHD6zo5u7ME/x5CHE50IbquW7cvVmAqAXYVfbA7qCgsqOXSSJ191oV3g2yvnZkT
	 2wgVp1FBfAotw/yB1mMW6YCKUQGxveTuusW0R98QLkQ9I4cMBRjt+thyUgD2NyMTC4
	 VpTgZsc0JT8RFCjQmCr3R/7Ck3WejpsOTswlmsPLCjnVEnU+3dsfZcb3IoTSlBPS9z
	 tQB7tVu2i5QCY2Ono3i39B2Yhl+l5Ywpe9MBYt0fN06MbDPc5LTjleUeJA7Q5wGz6m
	 2XJBgv/kOZHhpkxvXy6OY+EbmV2xPE03rpuyW97CaXpuOdLbE6vEP3Ya164JMv3WgI
	 Le7KZR/1QyFpQ==
Content-Type: multipart/mixed; boundary="===============5748986139930277636=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cf6bbf8c5fdcb27d803f9464b9c5f8e34c753ecb54c38694a33202fb30ec37e2@mail.kernel.org>
In-Reply-To: <20260824093122.362135-3-jiayuan.chen@linux.dev>
References: <20260824093122.362135-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/4] bpf: arena: allocate the fault-in page outside the lock
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,shuah@kernel.org,bigeasy@linutronix.de,clrkwllms@kernel.org,rostedt@goodmis.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-rt-devel@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 10:33:07 +0000 (UTC)

--===============5748986139930277636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..fa462a0ff1ad 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -489,59 +490,106 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	kbase = bpf_arena_get_kern_vm_start(arena);
>  	kaddr = kbase + (u32)(vmf->address);
>
> +	page = vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * Preallocate outside the lock with a sleepable allocator so it
> +		 * can reclaim and run the memcg OOM killer, which the
> +		 * non-blocking allocator under arena->spinlock cannot. A NULL
> +		 * return is non-recoverable, so fail with VM_FAULT_SIGBUS;
> +		 * VM_FAULT_OOM would be retried by the fault path and can
> +		 * livelock when the charged memcg is not the faulting task's.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page = bpf_map_alloc_page_sleepable(map);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_SIGBUS;
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {

[ ... ]

>  	page = vmalloc_to_page((void *)kaddr);
>  	if (page) {
> +		if (page == arena->scratch_page) {
> +			/*
> +			 * A scratch page marks a hole. Segfault only if the user
> +			 * asked for it; otherwise we could lazy-allocate but
> +			 * choose not to over a hole, so report a bus error.
> +			 */
> +			fault_ret = (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) ?
> +				    VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
> +			goto out_err_locked;
> +		}

This isn't a bug, but could this comment spell out why a scratch-marked
hole is not lazy-allocated even though an untouched hole is? A reader might
wonder why the two cases are treated differently since both are equally
free as far as the range tree is concerned.

>  		/* already have a page vmap-ed */
>  		goto out;
>  	}
>
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
> +		/* User space requested to segfault when page is not allocated by bpf prog */
> +		fault_ret = VM_FAULT_SIGSEGV;
> +		goto out_err_locked;
> +	}
> +
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>
> +	if (!new_page) {
> +		/*
> +		 * Very rare race: the bpf program had allocated a page here, so
> +		 * the lockless probe saw it and we skipped preallocation, but it
> +		 * freed the page before we took the lock. Now we do need one;
> +		 * sleeping is not allowed here, so fall back to the non-blocking
> +		 * allocator and give up if it fails.
> +		 */
> +		ret = bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);

This isn't a bug, but would it be clearer to describe the condition
generically (the lockless probe's result was invalidated before the lock
was taken) rather than naming only the bpf-alloc-then-free case? The
fallback is also reached if the probe observed arena->scratch_page and the
PTE was cleared by arena_free_pages() before the lock was taken, which is
not a bpf program page allocation.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32713810092
--===============5748986139930277636==--
