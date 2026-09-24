Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F02C027C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272595; cv=none; b=UITS7BBnhdwu+VICoo6Xt+4BynbXcxhRxG+XLnmdYMR75tjpZpELdH7BkoYBVAdVrJPfd0KJLuwqDh1KjKCAhemBwA65yK4b2jCo6x/JrVV3qz8UBzOB6NN7HOfzQPVKl8gJyaW7nhjDtvBSgwpkwKT+Jc2TuPKlwKMM0xJTbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272595; c=relaxed/simple;
	bh=1Z3GIK9JK69BEob7sJkn+sa5PdZoUM271OSbdaQEZKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=EbBLiL1tjkgQN4/2o/Lq8vQ08VXbTVEP0a+4RfakgLYbdZfTZ9hYWp0h3+XzmqTDKIFUvicN2hQ0TbcgP7XcgFg6NX6an0lbVuFibDYpatt7TcIQ6f2+3+LspjyAiXzgp8bAyyw/Tk0zYp8FBOqmv+wRTLk3PK+Dvifyvs4RmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PVi0l/rV; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PVi0l/rV"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so30441a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790272593; x=1790877393; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iHsvgAVqS3N8svn+Nsn6wJq1Nannkg6ktZDlSmNsbBQ=;
        b=PVi0l/rVOCULWxjpIs17ibeXlu3wqMmqGhKeAU1VMEanUfnrs8cmxFbiG39ZeCL6p0
         ahSI7Rlnaz3aYGrorZn6tGwqUeRhbqm2RW4MWyPELY1UgbCzx+ofUG/fFAC2fC34bipk
         q8Zjy0iMtpYYiLy1LUCMpM3n2yXkDen/6MMVNKYIuc97Y49AxMIo2fbphIpK9CqQRwzH
         C5mtf3XBgmBOiB74wYIhU+d1iKRKlBmUuN6iUDGUhELIMTUPbGWey0Ci+ji5LQsQlfMi
         yXLhxfnik/rbblflT/j000MKJqmShaHKYrZRleIyLPLseOF+sk/fzPGqnDTaTLG1iK3Q
         SELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272593; x=1790877393;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHsvgAVqS3N8svn+Nsn6wJq1Nannkg6ktZDlSmNsbBQ=;
        b=N5qLf6k0e7Py00htjPUBkXi5tmkZesvIPKAMzeeU87ke2WWv+5k92xde33SwAdGvkB
         X9i5HkITjkomHnV6JAKtdocmMD5KlkDvQmYuNkCCMILfBTfHJFMYxU/8zQJRMuDtvoaV
         sk1IBdJwFGl9XVhtU7ojIUW/HjkLX9+aa31VygGxsigopgx9+bzEVEQAScHpMl+R8ulQ
         GI3Rozm1JV9URKGAODZ8Ka6Vhw7hziiWnAO9Ngz6rpd1tUWGzBvhTdSXvjFT1u32rNTa
         Ua26fYu/IqOP75j+Y9+grQVo3zG7sPWgrhLspATywAkkB4ZUZXrjyP6AuKlcnRIc2c14
         zSJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI55Vwn3n19aBfJCn5QNG5aqh4I6vWZhZk7KbHIQEbfl35L9eFare0tHCDdvSt7wNv9n4=@vger.kernel.org
X-Gm-Message-State: AFuF++kbCj9GEBkzbjZytYwrZOArmo8uXPAodaM8x7yaZIOX1cG1pTML
	LMaMofH6+CvZ0nXQL0DTCDP5jky1mIdg+pWpseKWqrb7Du3+vyI3x5nlOujYtrzEVRk=
X-Gm-Gg: AYBFou2WnPNJ+vBLum/+tSFLZuabq5jRJl4EMTNWKMItuivN6p599kjXG00RNYLMihi
	Cvx/KCRfPsJZiSc/U+PR100sm6r8ZOVET/vCga7FGaENTJO3Y4ihVjTf+ZzAoEQz0y/HDEfQUGf
	heFUBgzbajRPIakF+O7aT9zEHJZ+RrKVH8oVUUkl7HEgnEi4glEofkJK26CJPpjou9tS6GUVS6P
	tkGrUt3eJByIumIRdpns24O33AYcujlX8zy5IjT1wiFsnfVypZveSWQIEJ9jNV5auA3QZgZjMMr
	5cuze/HBoDsEE+HsYXAw91tLxTV0WAaenVkyGz4DDbJ2vhNEXIHZjGBmSpVdlkNKVAnPgRqDL6i
	h7uxruROSuOAf62f4pQLmwMS9M8clBC/TU7YWVKyDzNKSd2e4jCQHRKowjB+upYiFQRMFIDxZ57
	A+/D1xsMuTrQhPDWX4wfD5P3kjtt7ipGG0I3fLYhaMmrfSoJQ1URyPLVzkX5CPm9SdvLsN1xFI5
	8gCLxwAZFb8JfEuxfE0gLa8xmY3v41ZkClZFsa8x04=
X-Received: by 2002:a17:90b:3c04:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3a098567e0fmr3192816a91.9.1790272592888;
        Thu, 24 Sep 2026 10:56:32 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b498fb12sm179519a91.0.2026.09.24.10.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 10:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 17:56:31 +0000
Message-Id: <DLNQO2KI4P26.3IJRH3BW8EQ13@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation
 path
X-Mailer: aerc 0.21.0
References: <20260924053621.7076-1-emil@etsalapatis.com>
 <20260924053621.7076-2-emil@etsalapatis.com>
 <7fba6431-14ab-45de-99dd-17e38cae2841@linux.dev>
In-Reply-To: <7fba6431-14ab-45de-99dd-17e38cae2841@linux.dev>

On Thu Sep 24, 2026 at 10:11 AM UTC, Jiayuan Chen wrote:
>
> On 9/24/26 1:36 PM, Emil Tsalapatis wrote:
>> The bpf_arena_alloc_pages() function currently only allocates pages
>> inside a spinlock critical section with IRQs off. This forces the use
>> of alloc_pages_nolock() in the BPF allocator, even when the caller is
>> a sleepable BPF function. This in turn causes allocation failures even
>> in cases where falling into the allocator slow path and possibly
>> sleeping would eventually succeed. This can be triggered consistently
>> by heavy BPF arena users like scx.
>>
>> Add a separate arena page allocation path just for sleepable callers.
>> The path preallocates the arena memory to be added to the tree before
>> taking the critical section.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>>   include/linux/bpf.h  |   6 +++
>>   kernel/bpf/arena.c   | 123 ++++++++++++++++++++++++++++++-------------
>>   kernel/bpf/syscall.c |   8 +--
>>   3 files changed, 92 insertions(+), 45 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index e7c5e203eddd..b37e34cf1086 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -720,6 +720,12 @@ void bpf_map_free_internal_structs(struct bpf_map *=
map, void *obj);
>>   int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>>   				   struct bpf_dynptr *ptr__uninit);
>>  =20
>> +static inline bool is_bpf_alloc_nonsleepable(void)
>> +{
>> +	return preempt_count() > 0 || irqs_disabled() ||
>> +		IS_ENABLED(CONFIG_PREEMPT_RT);
>> +}
>> +
>
>
> A runtime check cannot tell whether sleeping is allowed: without
> CONFIG_PREEMPT_COUNT preempt_count() does not see spinlocks or
> rcu_read_lock(), which is why preemptible() is 0 there.
>
> How about passing 'sleepable' down to bpf_map_alloc_pages() instead?
> The verifier already proves it, and the code gets simpler.

Sure, we can keep it there. Afaict what you're proposing is to keep
the can_alloc_pages() call where it is and pass the sleepable flag
down to bpf_map_alloc_pages() instead, where now we're hoisting
can_alloc_pages() up.

>
>
>>   #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>>   void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ig=
n, u32 page_cnt, int node_id,
>>   					  u64 flags);
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index c6369ea5e208..eaeae16bbe7a 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -704,6 +704,27 @@ static u64 clear_lo32(u64 val)
>>   	return val & ~(u64)~0U;
>>   }
>>  =20
>> +static int arena_adjust_tree(struct bpf_arena *arena, long uaddr, long =
page_cnt, long *pgoff)
>> +{
>> +	int ret;
>> +
>> +	/* Special case where user is requesting specific range. */
>> +	if (uaddr) {
>> +		ret =3D is_range_tree_set(&arena->rt, *pgoff, page_cnt);
>> +		if (ret)
>> +			return ret;
>> +		return range_tree_clear(&arena->rt, *pgoff, page_cnt);
>> +	}
>> +
>> +	ret =3D range_tree_find(&arena->rt, page_cnt);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*pgoff =3D ret;
>> +
>> +	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
>> +}
>> +
>>   /*
>>    * Allocate pages and vmap them into kernel vmalloc area.
>>    * Later the pages will be mmaped into user space vma.
>> @@ -721,7 +742,9 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>>   	long alloc_pages;
>>   	unsigned long flags;
>>   	long pgoff =3D 0;
>> +	bool can_sleep;
>>   	u32 uaddr32;
>> +	long addr =3D 0;
>>   	int ret, i;
>>  =20
>>   	if (node_id !=3D NUMA_NO_NODE &&
>> @@ -741,31 +764,38 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
>>   	}
>>  =20
>>   	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>> -	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() c=
an succeed. */
>> -	alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct p=
age *));
>> -	pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_AC=
COUNT, NUMA_NO_NODE);
>> -	if (!pages) {
>> -		bpf_map_memcg_exit(old_memcg, new_memcg);
>> -		return 0;
>> +
>> +	can_sleep =3D sleepable && !is_bpf_alloc_nonsleepable();
>> +	if (can_sleep) {
>> +		alloc_pages =3D page_cnt;
>> +		pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUN=
T);
>> +		if (!pages)
>> +			goto out_memcg;
>> +
>> +		ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>> +		if (ret)
>> +			goto out_free_array;
>> +		data.i =3D 0;
>> +	} else {
>> +		/* Cap allocation size so kmalloc_nolock() can succeed. */
>> +		alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct =
page *));
>> +		pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_A=
CCOUNT,
>> +				       NUMA_NO_NODE);
>> +		if (!pages)
>> +			goto out_memcg;
>>   	}
>> +
>>   	data.arena =3D arena;
>>   	data.pages =3D pages;
>>  =20
>>   	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>>   		goto out_free_pages;
>>  =20
>> -	if (uaddr) {
>> -		ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
>> -		if (ret)
>> -			goto out_unlock_free_pages;
>> -		ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
>> -	} else {
>> -		ret =3D pgoff =3D range_tree_find(&arena->rt, page_cnt);
>> -		if (pgoff >=3D 0)
>> -			ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
>> +	ret =3D arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
>> +	if (ret) {
>> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +		goto out_free_pages;
>>   	}
>> -	if (ret)
>> -		goto out_unlock_free_pages;
>>  =20
>>   	remaining =3D page_cnt;
>>   	uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
>> @@ -773,12 +803,14 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
>>   	while (remaining) {
>>   		long this_batch =3D min(remaining, alloc_pages);
>>  =20
>> -		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero=
 entries */
>> -		memset(pages, 0, this_batch * sizeof(struct page *));
>> +		if (!can_sleep) {
>> +			/* alloc_pages_bulk() only fills in non-zero entries. */
>> +			memset(pages, 0, this_batch * sizeof(struct page *));
>>  =20
>> -		ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
>> -		if (ret)
>> -			goto out;
>> +			ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages)=
;
>> +			if (ret)
>> +				goto out_unmap;
>> +		}
>>  =20
>>   		/*
>>   		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
>> @@ -793,35 +825,50 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
>>   					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
>>   					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
>>   		if (ret) {
>> -			/* data.i pages were mapped, account them and free the remaining */
>> +			/* data.i pages were mapped, account them and free the remaining. */
>>   			mapped +=3D data.i;
>> -			for (i =3D data.i; i < this_batch; i++)
>> -				free_pages_nolock(pages[i], 0);
>> -			goto out;
>> +			if (!can_sleep)
>> +				for (i =3D data.i; i < this_batch; i++)
>> +					free_pages_nolock(pages[i], 0);
>> +			goto out_unmap;
>>   		}
>>  =20
>>   		mapped +=3D this_batch;
>>   		remaining -=3D this_batch;
>>   	}
>> +
>>   	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> -	kfree_nolock(pages);
>> -	bpf_map_memcg_exit(old_memcg, new_memcg);
>> -	return clear_lo32(arena->user_vm_start) + uaddr32;
>> -out:
>> +
>> +	addr =3D clear_lo32(arena->user_vm_start) + uaddr32;
>> +	goto out_free_array;
>> +
>> +out_unmap:
>> +	if (can_sleep)
>> +		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>>   	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
>>   	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> -	if (mapped) {
>> -		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>> -		arena_free_pages(arena, uaddr32, mapped, sleepable);
>> +	if (mapped || can_sleep) {
>> +		if (!can_sleep)
>> +			flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>> +		arena_free_pages(arena, uaddr32, mapped, can_sleep);
>>   	}
>> -	goto out_free_pages;
>> -out_unlock_free_pages:
>> -	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +
>>   out_free_pages:
>> -	kfree_nolock(pages);
>> +	if (can_sleep)
>> +		for (i =3D data.i; i < page_cnt; i++)
>> +			__free_page(pages[i]);
>> +
>> +out_free_array:
>> +	if (can_sleep)
>> +		kvfree(pages);
>> +	else
>> +		kfree_nolock(pages);
>> +
>> +out_memcg:
>>   	bpf_map_memcg_exit(old_memcg, new_memcg);
>> -	return 0;
>> +
>> +	return addr;
>>   }
>>  =20
>>   /*
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 74496fd716d3..d193d84cc33e 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -596,15 +596,9 @@ static void bpf_map_release_memcg(struct bpf_map *m=
ap)
>>   }
>>   #endif
>>  =20
>> -static bool can_alloc_pages(void)
>> -{
>> -	return preempt_count() =3D=3D 0 && !irqs_disabled() &&
>> -		!IS_ENABLED(CONFIG_PREEMPT_RT);
>> -}
>> -
>>   static struct page *__bpf_alloc_page(int nid)
>>   {
>> -	if (!can_alloc_pages())
>> +	if (is_bpf_alloc_nonsleepable())
>>   		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
>>  =20
>>   	return alloc_pages_node(nid,

