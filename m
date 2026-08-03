Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339B30D3E2
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739428; cv=none; b=IdJJLI+nUxbPbLviNpFnIxVotbk+gV53ArnDWfTTsh3urz8CjVnpesyxOFpbcicsAR1LQtGopm80J51oZWFOhaYolVl6mmEkyxUmsRrhmpX13xbAZ5zmphhdj2O1EDMLEDgmnEICx9koNOO8WjczfoUPOtFU0Oq6/ISLqXkpv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739428; c=relaxed/simple;
	bh=/IXFnkIU02YmqKjji2itI86qHp2ZAhnisPPE2dP2oxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXEsRTj6Gdgz/XCMHJ3CbiRw9eZD8jqojVcypc9RbtsSZMWPf6YMYMWpjgfuzVITR145Ys9QbBDGYCBkzJtyb520/R5WQK1SeocgvU6oNDL0WRhj0Ech8U9Cv8xF/2ZsK6rMATP0UvIVla+LdCjsOKZFiO8FA7VjELWZtio+5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IAC8rZrj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IAC8rZrj"
Message-ID: <354f214b-bd81-49b6-9642-ddfbaa936694@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785739414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0j68PxZwezHySspr399yaQDfTTXgvfFRGwajE306dg=;
	b=IAC8rZrjT8wnrsVPSpUasD5cq6pLEC0v3eunktmPfRCLRtpoLIjw8S6fvhy7JeLceN+qLq
	E2JFu8J2VJATh1HabZGBoLuF5zdExcK8HqvBRY0CgBwFJ8b+Y8gPoLDVmeWVwnKS7+W+1n
	0SpNnsqlppOYcy2s2ygxbYMKb/oRkrc=
Date: Mon, 3 Aug 2026 14:43:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page
 outside the lock
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-3-jiayuan.chen@linux.dev>
 <DK9T753AD314.1K18DTGBR7OYN@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DK9T753AD314.1K18DTGBR7OYN@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/28/26 9:22 AM, Emil Tsalapatis wrote:
> On Mon Jul 27, 2026 at 2:24 AM EDT, Jiayuan Chen wrote:
>> arena_vm_fault() allocated the page while holding arena->spinlock, so it
>> could only use the non-blocking allocator. Once the memcg is at
>> memory.max that allocation just fails, the fault turns into
>> VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
>> arena address. Hitting memory.max is routine (e.g. page cache from
>> reading a big file), so this kills innocent processes.
>>
>> Preallocate the page before taking the lock, like do_anonymous_page()
>> does, so the allocation can sleep and go through reclaim and the OOM
>> path, and return VM_FAULT_OOM on failure so the memcg OOM handler runs
>> instead of a fake segfault. Also tidy up the error labels.
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 63 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 34f023a537fe..22a41e3c53b8 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	struct bpf_map *map = vmf->vma->vm_file->private_data;
>>   	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
>>   	struct mem_cgroup *new_memcg, *old_memcg;
>> -	struct page *page;
>> +	struct page *page, *new_page = NULL;
>> +	vm_fault_t fault_ret;
>>   	long kbase, kaddr;
>>   	unsigned long flags;
>>   	int ret;
>> @@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>>   	kbase = bpf_arena_get_kern_vm_start(arena);
>>   	kaddr = kbase + (u32)(vmf->address);
>>   
>> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>> +	page = vmalloc_to_page((void *)kaddr);
>> +	if (!page) {
>> +		/*
>> +		 * Preallocate outside the lock so the allocation can sleep and go
>> +		 * through reclaim (both memcg and global), the way do_anonymous_page()
>> +		 * does. Under arena->spinlock only the non-blocking allocator is
>> +		 * available, which never reclaims.
>> +		 *
> Can you add here that we're in process context which is why we make an
> explicitly sleepable call? That also strengthens the explanation of why
> we want to preallocate in the first place.
>
>> +		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
>> +		 * meaningful if the OOM machinery was actually engaged. A failure
>> +		 * from the non-blocking allocator engages nothing, so the fault
>> +		 * would be retried forever.
>> +		 */
>> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>> +		new_page = bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>> +		if (!new_page)
>> +			return VM_FAULT_OOM;
>> +	}
>> +
>> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>>   		/* Make a reasonable effort to address impossible case */
>> -		return VM_FAULT_RETRY;
>> +		fault_ret = VM_FAULT_RETRY;
>> +		goto out_err;
>> +	}
>>   
>>   	page = vmalloc_to_page((void *)kaddr);
>>   	if (page) {
>> -		if (page == arena->scratch_page)
>> +		if (page == arena->scratch_page) {
>>   			/* BPF triggered scratch here; don't lazy-alloc over it */
>> -			goto out_sigsegv;
>> +			fault_ret = VM_FAULT_SIGSEGV;
>> +			goto out_err_locked;
>> +		}
>>   		/* already have a page vmap-ed */
>>   		goto out;
>>   	}
>>   
>> +	/*
>> +	 * The lockless probe was racy: it saw a page, so nothing was
>> +	 * preallocated, but the re-check under the lock finds it gone - a
>> +	 * concurrent free must have run in between. There is nothing to
>> +	 * install and we cannot allocate under the lock, so retry the fault
>> +	 * and preallocate next time.
>> +	 */
>> +	if (!new_page) {
>> +		fault_ret = VM_FAULT_RETRY;
>> +		goto out_err_locked;
>> +	}
>> +
>>   	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>>   
>> -	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
>> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
>>   		/* User space requested to segfault when page is not allocated by bpf prog */
>> -		goto out_sigsegv_memcg;
>> +		fault_ret = VM_FAULT_SIGSEGV;
>> +		goto out_err_locked_memcg;
>> +	}
> Let's hoist this further up, I don't see why we're waiting to get so
> much into handling the fault before checking if we're even allowed to
> do it in the first place.
>
>>   
>>   	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
>> -	if (ret)
>> -		goto out_sigsegv_memcg;
>> -
>> -	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
>> -	/* Account into memcg of the process that created bpf_arena */
>> -	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>>   	if (ret) {
>> -		range_tree_set(&arena->rt, vmf->pgoff, 1);
>> -		goto out_sigsegv_memcg;
>> +		fault_ret = VM_FAULT_OOM;
> Can you add a comment that VM_FAULT_OOM is because the only way clearing
> the tree can fail is if there is a failed range allocation?
>
>> +		goto out_err_locked_memcg;
>>   	}
>> +	struct apply_range_data data = { .arena = arena, .pages = &new_page, .i = 0 };
>>   
>>   	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
>>   	if (ret) {
>>   		range_tree_set(&arena->rt, vmf->pgoff, 1);
>> -		free_pages_nolock(page, 0);
>> -		goto out_sigsegv_memcg;
>> +		fault_ret = VM_FAULT_SIGSEGV;
>> +		goto out_err_locked_memcg;
>>   	}
>>   	flush_vmap_cache(kaddr, PAGE_SIZE);
>>   	bpf_map_memcg_exit(old_memcg, new_memcg);
>> +	/* new_page was consumed */
>> +	page = new_page;
>> +	new_page = NULL;
>>   out:
>>   	page_ref_add(page, 1);
>>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +	if (new_page)
>> +		free_pages_nolock(new_page, 0);
>>   	vmf->page = page;
>>   	return 0;
>> -out_sigsegv_memcg:
>> +
>> +out_err_locked_memcg:
>>   	bpf_map_memcg_exit(old_memcg, new_memcg);
>> -out_sigsegv:
>> +out_err_locked:
>>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> -	return VM_FAULT_SIGSEGV;
>> +out_err:
>> +	if (new_page)
>> +		free_pages_nolock(new_page, 0);
>> +	return fault_ret;
> The out_err label is used only once. Can we replace the label with
> the code itself, even if this means some mild duplication? Four
> different labels are too many imo.
>
>>   }
>>   
>>   static const struct vm_operations_struct arena_vm_ops = {
> pw-bot: cr



Sorry for the delay. I missed this mail earlier...

Everything makes sense.

