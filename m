Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90622157B
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453794; cv=none; b=TMBxK5qqrtXb1MTkBMvkJxzyfxDLyfV1Qgj8Q1vhUCqyz7WBIucn0RJ8s4OsjBepULvtRJOHRzFKs8YfoLOzCnYwPTOwdmqwRqnj9uApAc5a2x3LeEliFWIIw9EieDRdUd73KyFkiwk16PjqD3/VYo9C0hPkbx6UO659KIGPYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453794; c=relaxed/simple;
	bh=VvPj0rQJ+3z3QaZfDLYDQoyIaOpJBWYhGhiM+W+L4mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJmpTjkacC/hH8mrHHme2iF98ePubUidprbK7WUHRgqRm0qVhWHoljdgNalzOLPyJQbV0SJajqxHjxcDS7bC6gNTl2manV38MTQQZuRgi7/G6xxU0z95l7HVfAnliUnPkp8EZW0+93/xhlnmVY4scA1VZbOex6hwUW2as0HYdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2HgXgYm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2HgXgYm"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43992e06b9eso215493f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772453790; x=1773058590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ACTRy9m9DGTE1uM5/GGdszxPz1+1eryLvgjpWOtGUc=;
        b=b2HgXgYmmRxHHdrHG0OdIu8wKssyx6p9HvfQPYJB3F4O1fuhK5hyBudNEehsl50sDG
         V0Kz9OMbkRMHMxbShBQ0+OFhfOXjZkJRLEQDJAhufoEY5tgoU8W7/T6v0TNEc+EIeUrv
         5iTaWG/XIvZT/tAFlS1mCk2Tuyqaxeb2GhxSCov1nVu4lgqSB6Lfyx+iiWVEsSDhxuhF
         191WLj58cDmF9Tgnp/cIp1LAsNPDEP3EcmQQ1m8pIglPm9uUSxJa1B+e61ngxJXmAVEk
         9g9KxYh3n27fgF2HKxn+4Ek+wmw/xNSYfADhKFsPBUJbF0wK3Zv88BTPXuSGZNzxtsys
         xVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453790; x=1773058590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ACTRy9m9DGTE1uM5/GGdszxPz1+1eryLvgjpWOtGUc=;
        b=Ia1Z9Y4350p6pb8HbudZ3TMMnfDKeGaz3lmxNUHdws0zxpMwkcreX2pPtxOHXk+8sG
         duBlzg0SCeIz5X/4Lr+gZEIcdzWH0dpfjGSAR7Voqu43hFXZEUId97XA68CPqxvkPn9g
         spqEwS7Ab+WKXlNVrok8F3t8cx9k62dUiavL1JMjzYcBRNWXlHnGJQlkrMsgZ2SBQFak
         iz9h5sexOpZrkYWDXMMm8xP2Ivx4Y4z8aJyLxYolxHREbnp9WUUXHKw1XRBgLyxb16FB
         pJAoOW8oR5GPS/u5eiiyv95N2v0A/rR3MYgGtlmAZVx6LcTGS0Fpi9+YpDrtw/YZr9KQ
         Qzvg==
X-Forwarded-Encrypted: i=1; AJvYcCVsYQL1Ap8+OGTZ8WDWH8xV7TDLtiQp10iwtfci8629SxwvoQz6T28cGokOt7MrX6h5eew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUcq9FnHbhKpsGKfwHesu20ZDRRC6HDLghjjwHjBEEM8drQgu
	McpcAjFxIaz3Z3JOMS4JY4+XbA09ni09M+QXyvnEwyctouucc7w5N2PtED4YzBIfsIk=
X-Gm-Gg: ATEYQzzJ8+wKzzJD+zykvDbYVShQ8mtUFrCfatoHGWWmOb8OSaZCURf/5E/pMZ92m11
	TgjyWutoZYaakXVWOyvDBMu9S2VD4sDhgM6Hr6493V4vndMCvwo+7IgbFT91xe0GUp4LPmw46W7
	/DIXgRdTrKqK1LsmuAvj39wWSVbkVwfLaTExmS8kU86Tov2m/uvLX/2k+/2ney72zskYbHMpXYX
	QLyOHv0N6B5Qmpgj2gy5AV84mgiLh8SDPGntfEtAMUQ3BaFVIMdn/ByTAfzz9+XO2TEnaPnHBgO
	/rZ5lF9vh8Se+mQgYYq3q/Z4V9LQ6LLPsyrI5SNq7ZerpmPTdK4vu11sIXpKnVVeZhopn9m3DP7
	lyDwu5FOU8IOmHCL7RjjIcNau9gj7OyoHkreIfaCe9rLeur2OWVuk0QNo3TQnVRLlD9tXL6cL+c
	5oz+LHP4R8mIPtGwDaAPrvrqq6hH8ObwS9HUfCHrDY1HvsYVbtiD6BoYAAzg==
X-Received: by 2002:a05:6000:4012:b0:439:bdd7:4258 with SMTP id ffacd0b85a97d-439bdd743a8mr626841f8f.7.1772453789875;
        Mon, 02 Mar 2026 04:16:29 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b130abfasm11790112f8f.34.2026.03.02.04.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 04:16:29 -0800 (PST)
Message-ID: <9b0ae03c-8e93-422d-835c-3d4148a7550f@suse.com>
Date: Mon, 2 Mar 2026 13:16:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/22] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Content-Language: en-US
To: "D, Suneeth" <Suneeth.D@amd.com>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-8-041323d506f7@suse.cz>
 <df5a0dfd-01b7-48a9-8936-4d5e271e68e6@amd.com>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <df5a0dfd-01b7-48a9-8936-4d5e271e68e6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 12:56, D, Suneeth wrote:
> Hi Vlastimil Babka,

Hi Suneeth!

> On 1/23/2026 12:22 PM, Vlastimil Babka wrote:
>> Before we enable percpu sheaves for kmalloc caches, we need to make sure
>> kmalloc_nolock() and kfree_nolock() will continue working properly and
>> not spin when not allowed to.
>> 
>> Percpu sheaves themselves use local_trylock() so they are already
>> compatible. We just need to be careful with the barn->lock spin_lock.
>> Pass a new allow_spin parameter where necessary to use
>> spin_trylock_irqsave().
>> 
>> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
>> for now it will always fail until we enable sheaves for kmalloc caches
>> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>> 
> 
> We run will-it-scale micro-benchmark as part of our weekly CI for Kernel 
> Performance Regression testing between a stable vs rc kernel. We 

Great!

> observed will-it-scale-thread-page_fault3 variant was regressing with 
> 9-11% on AMD platforms (Turin and Bergamo)between the kernels v6.19 and 
> v7.0-rc1. Bisecting further landed me onto this commit
> f1427a1d64156bb88d84f364855c364af6f67a3b (slab: make percpu sheaves 
> compatible with kmalloc_nolock()/kfree_nolock()) as the first bad 
> commit. The following were the machines' configuration and test 
> parameters used:-
> 
> Model name:           AMD EPYC 128-Core Processor [Bergamo]
> Thread(s) per core:   2
> Core(s) per socket:   64
> Socket(s):            1
> Total online memory:  256G
> 
> Model name:           AMD EPYC 64-Core Processor [Turin]
> Thread(s) per core:   2
> Core(s) per socket:   64
> Socket(s):            2
> Total online memory:  258G
> 
> Test params:
> ------------
>       nr_task: [1 8 64 128 192 256]
>       mode: thread
>       test: page_fault3
>       kpi: per_thread_ops
>       cpufreq_governor: performance
> 
> The following are the stats after bisection:-
> (the KPI used here is per_thread_ops)
> 
> kernel_versions      					 per_thread_ops
> ---------------      					 ---------------
> v6.19.0 (baseline)                                     - 2410188
> v7.0-rc1 	                                       - 2151474
> v6.19-rc5-f1427a1d6415                                 - 2263974
> v6.19-rc5-f3421f8d154c (one commit before culprit)     - 2323263

I suspect the bisection gave a wrong result here due to noise. The commit
f1427a1d6415 should not affect anything in this benchmark. The values for
the commit and its parent are rather close to each other, and in the middle
of the range between v6.19.0 and v7.0-rc1 numbers.

What I rather suspect is something we noticed recently - v7.0-rc1 enables
sheaves for all caches, but also removes cpu (partial) slabs. In v6.19 only
two caches (vma and maple nodes) have sheaves, but also cpu (partial) slabs
still behind them, effectively caching many more objects than with either
mechanism alone. will-it-scale-thread-page_fault3 is a benchmark that is
very sensitive to vma and maple nodes allocation performance and notice this.

So unfortunately we now see it as a regression between 6.19 and v7, but it
should be just offsetting an improvement in 6.18 when sheaves were
introduced for vma and maple nodes with this unintended ~double caching.

> Recreation steps:
> -----------------
> 1) git clone https://github.com/antonblanchard/will-it-scale.git
> 2) git clone https://github.com/intel/lkp-tests.git
> 3) cd will-it-scale && git apply
> lkp-tests/programs/will-it-scale/pkg/will-it-scale.patch
> 4) make
> 5) python3 runtest.py page_fault3 25 thread 0 0 1 8 64 128 192 256
> 
> NOTE: [5] is specific to machine's architecture. starting from 1 is the
> array of no.of tasks that you'd wish to run the testcase which here is
> no.cores per CCX, per NUMA node/ per Socket, nr_threads.
> 
> I also ran the micro-benchmark with ./tools/testing/perf record and
> following is the diff collected:-
> 
> # ./perf diff perf.data.old perf.data
> Warning:
> 4 out of order events recorded.
> # Event 'cpu/cycles/P'
> #
> # Baseline  Delta Abs  Shared Object          Symbol
> # ........  .........  ..................... 
> ...................................................
> #
>                +11.95%  [kernel.kallsyms]      [k] folio_pte_batch
>                +10.30%  [kernel.kallsyms]      [k] 
> native_queued_spin_lock_slowpath
>                 +9.91%  [kernel.kallsyms]      [k] __block_write_begin_int
>       0.00%     +8.56%  [kernel.kallsyms]      [k] clear_page_erms
>       7.71%     -7.71%  [kernel.kallsyms]      [k] delay_halt
>                 +6.84%  [kernel.kallsyms]      [k] block_dirty_folio
>       1.58%     +4.90%  [kernel.kallsyms]      [k] unmap_page_range
>       0.00%     +4.78%  [kernel.kallsyms]      [k] folio_remove_rmap_ptes
>       3.17%     -3.17%  [kernel.kallsyms]      [k] __vmf_anon_prepare
>       0.00%     +3.09%  [kernel.kallsyms]      [k] ext4_page_mkwrite
>                 +2.32%  [kernel.kallsyms]      [k] ext4_dirty_folio
>       0.00%     +2.01%  [kernel.kallsyms]      [k] vm_normal_page
>       0.00%     +1.93%  [kernel.kallsyms]      [k] set_pte_range
>                 +1.84%  [kernel.kallsyms]      [k] block_commit_write
>                 +1.82%  [kernel.kallsyms]      [k] mod_node_page_state
>                 +1.68%  [kernel.kallsyms]      [k] lruvec_stat_mod_folio
>                 +1.56%  [kernel.kallsyms]      [k] mod_memcg_lruvec_state
>       1.40%     -1.39%  [kernel.kallsyms]      [k] mod_memcg_state
>                 +1.38%  [kernel.kallsyms]      [k] folio_add_file_rmap_ptes
>       5.01%     -0.87%  page_fault3_threads    [.] testcase
>                 +0.84%  [kernel.kallsyms]      [k] tlb_flush_rmap_batch
>                 +0.83%  [kernel.kallsyms]      [k] mark_buffer_dirty
>       1.66%     -0.75%  [kernel.kallsyms]      [k] flush_tlb_mm_range
>                 +0.72%  [kernel.kallsyms]      [k] css_rstat_updated
>       0.60%     -0.60%  [kernel.kallsyms]      [k] osq_unlock
>                 +0.57%  [kernel.kallsyms]      [k] _raw_spin_unlock
>                 +0.55%  [kernel.kallsyms]      [k] perf_iterate_ctx
>                 +0.54%  [kernel.kallsyms]      [k] __rcu_read_lock
>       0.11%     +0.53%  [kernel.kallsyms]      [k] osq_lock
>                 +0.46%  [kernel.kallsyms]      [k] finish_fault
>       0.46%     -0.46%  [kernel.kallsyms]      [k] do_wp_page
>                 +0.45%  [kernel.kallsyms]      [k] pte_val
>       1.10%     -0.41%  [kernel.kallsyms]      [k] filemap_fault
>                 +0.39%  [kernel.kallsyms]      [k] native_set_pte
>                 +0.36%  [kernel.kallsyms]      [k] rwsem_spin_on_owner
>       0.28%     -0.28%  [kernel.kallsyms]      [k] mas_topiary_replace
>                 +0.28%  [kernel.kallsyms]      [k] _raw_spin_lock_irqsave
>                 +0.27%  [kernel.kallsyms]      [k] percpu_counter_add_batch
>                 +0.27%  [kernel.kallsyms]      [k] memset
>       0.00%     +0.24%  [kernel.kallsyms]      [k] mas_walk
>       0.23%     -0.23%  [kernel.kallsyms]      [k] __pmd_alloc
>       0.23%     -0.22%  [kernel.kallsyms]      [k] rcu_core
>                 +0.21%  [kernel.kallsyms]      [k] __rcu_read_unlock
>       0.04%     +0.19%  [kernel.kallsyms]      [k] ext4_da_get_block_prep
>                 +0.19%  [kernel.kallsyms]      [k] lock_vma_under_rcu
>       0.01%     +0.19%  [kernel.kallsyms]      [k] prep_compound_page
>                 +0.18%  [kernel.kallsyms]      [k] filemap_get_entry
>                 +0.17%  [kernel.kallsyms]      [k] folio_mark_dirty
> 
> Would be happy to help with further testing and providing additional 
> data if required.
> 
> Thanks,
> Suneeth D
> 
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> Reviewed-by: Hao Li <hao.li@linux.dev>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>   mm/slub.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 60 insertions(+), 22 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 41e1bf35707c..4ca6bd944854 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2889,7 +2889,8 @@ static void pcs_destroy(struct kmem_cache *s)
>>   	s->cpu_sheaves = NULL;
>>   }
>>   
>> -static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
>> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
>> +					       bool allow_spin)
>>   {
>>   	struct slab_sheaf *empty = NULL;
>>   	unsigned long flags;
>> @@ -2897,7 +2898,10 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
>>   	if (!data_race(barn->nr_empty))
>>   		return NULL;
>>   
>> -	spin_lock_irqsave(&barn->lock, flags);
>> +	if (likely(allow_spin))
>> +		spin_lock_irqsave(&barn->lock, flags);
>> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
>> +		return NULL;
>>   
>>   	if (likely(barn->nr_empty)) {
>>   		empty = list_first_entry(&barn->sheaves_empty,
>> @@ -2974,7 +2978,8 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
>>    * change.
>>    */
>>   static struct slab_sheaf *
>> -barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>> +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty,
>> +			 bool allow_spin)
>>   {
>>   	struct slab_sheaf *full = NULL;
>>   	unsigned long flags;
>> @@ -2982,7 +2987,10 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>>   	if (!data_race(barn->nr_full))
>>   		return NULL;
>>   
>> -	spin_lock_irqsave(&barn->lock, flags);
>> +	if (likely(allow_spin))
>> +		spin_lock_irqsave(&barn->lock, flags);
>> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
>> +		return NULL;
>>   
>>   	if (likely(barn->nr_full)) {
>>   		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
>> @@ -3003,7 +3011,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>>    * barn. But if there are too many full sheaves, reject this with -E2BIG.
>>    */
>>   static struct slab_sheaf *
>> -barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
>> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
>> +			bool allow_spin)
>>   {
>>   	struct slab_sheaf *empty;
>>   	unsigned long flags;
>> @@ -3014,7 +3023,10 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
>>   	if (!data_race(barn->nr_empty))
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	spin_lock_irqsave(&barn->lock, flags);
>> +	if (likely(allow_spin))
>> +		spin_lock_irqsave(&barn->lock, flags);
>> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
>> +		return ERR_PTR(-EBUSY);
>>   
>>   	if (likely(barn->nr_empty)) {
>>   		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
>> @@ -5008,7 +5020,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>>   		return NULL;
>>   	}
>>   
>> -	full = barn_replace_empty_sheaf(barn, pcs->main);
>> +	full = barn_replace_empty_sheaf(barn, pcs->main,
>> +					gfpflags_allow_spinning(gfp));
>>   
>>   	if (full) {
>>   		stat(s, BARN_GET);
>> @@ -5025,7 +5038,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>>   			empty = pcs->spare;
>>   			pcs->spare = NULL;
>>   		} else {
>> -			empty = barn_get_empty_sheaf(barn);
>> +			empty = barn_get_empty_sheaf(barn, true);
>>   		}
>>   	}
>>   
>> @@ -5165,7 +5178,8 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>>   }
>>   
>>   static __fastpath_inline
>> -unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
>> +				 void **p)
>>   {
>>   	struct slub_percpu_sheaves *pcs;
>>   	struct slab_sheaf *main;
>> @@ -5199,7 +5213,8 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>>   			return allocated;
>>   		}
>>   
>> -		full = barn_replace_empty_sheaf(barn, pcs->main);
>> +		full = barn_replace_empty_sheaf(barn, pcs->main,
>> +						gfpflags_allow_spinning(gfp));
>>   
>>   		if (full) {
>>   			stat(s, BARN_GET);
>> @@ -5700,7 +5715,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>>   	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>>   	struct kmem_cache *s;
>>   	bool can_retry = true;
>> -	void *ret = ERR_PTR(-EBUSY);
>> +	void *ret;
>>   
>>   	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>>   				      __GFP_NO_OBJ_EXT));
>> @@ -5731,6 +5746,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>>   		 */
>>   		return NULL;
>>   
>> +	ret = alloc_from_pcs(s, alloc_gfp, node);
>> +	if (ret)
>> +		goto success;
>> +
>> +	ret = ERR_PTR(-EBUSY);
>> +
>>   	/*
>>   	 * Do not call slab_alloc_node(), since trylock mode isn't
>>   	 * compatible with slab_pre_alloc_hook/should_failslab and
>> @@ -5767,6 +5788,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>>   		ret = NULL;
>>   	}
>>   
>> +success:
>>   	maybe_wipe_obj_freeptr(s, ret);
>>   	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
>>   			     slab_want_init_on_alloc(alloc_gfp, s), size);
>> @@ -6087,7 +6109,8 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>>    * unlocked.
>>    */
>>   static struct slub_percpu_sheaves *
>> -__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>> +__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>> +			bool allow_spin)
>>   {
>>   	struct slab_sheaf *empty;
>>   	struct node_barn *barn;
>> @@ -6111,7 +6134,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>   	put_fail = false;
>>   
>>   	if (!pcs->spare) {
>> -		empty = barn_get_empty_sheaf(barn);
>> +		empty = barn_get_empty_sheaf(barn, allow_spin);
>>   		if (empty) {
>>   			pcs->spare = pcs->main;
>>   			pcs->main = empty;
>> @@ -6125,7 +6148,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>   		return pcs;
>>   	}
>>   
>> -	empty = barn_replace_full_sheaf(barn, pcs->main);
>> +	empty = barn_replace_full_sheaf(barn, pcs->main, allow_spin);
>>   
>>   	if (!IS_ERR(empty)) {
>>   		stat(s, BARN_PUT);
>> @@ -6133,7 +6156,8 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>   		return pcs;
>>   	}
>>   
>> -	if (PTR_ERR(empty) == -E2BIG) {
>> +	/* sheaf_flush_unused() doesn't support !allow_spin */
>> +	if (PTR_ERR(empty) == -E2BIG && allow_spin) {
>>   		/* Since we got here, spare exists and is full */
>>   		struct slab_sheaf *to_flush = pcs->spare;
>>   
>> @@ -6158,6 +6182,14 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>   alloc_empty:
>>   	local_unlock(&s->cpu_sheaves->lock);
>>   
>> +	/*
>> +	 * alloc_empty_sheaf() doesn't support !allow_spin and it's
>> +	 * easier to fall back to freeing directly without sheaves
>> +	 * than add the support (and to sheaf_flush_unused() above)
>> +	 */
>> +	if (!allow_spin)
>> +		return NULL;
>> +
>>   	empty = alloc_empty_sheaf(s, GFP_NOWAIT);
>>   	if (empty)
>>   		goto got_empty;
>> @@ -6200,7 +6232,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>    * The object is expected to have passed slab_free_hook() already.
>>    */
>>   static __fastpath_inline
>> -bool free_to_pcs(struct kmem_cache *s, void *object)
>> +bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>>   {
>>   	struct slub_percpu_sheaves *pcs;
>>   
>> @@ -6211,7 +6243,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>>   
>>   	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>>   
>> -		pcs = __pcs_replace_full_main(s, pcs);
>> +		pcs = __pcs_replace_full_main(s, pcs, allow_spin);
>>   		if (unlikely(!pcs))
>>   			return false;
>>   	}
>> @@ -6333,7 +6365,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>   			goto fail;
>>   		}
>>   
>> -		empty = barn_get_empty_sheaf(barn);
>> +		empty = barn_get_empty_sheaf(barn, true);
>>   
>>   		if (empty) {
>>   			pcs->rcu_free = empty;
>> @@ -6453,7 +6485,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>>   		goto no_empty;
>>   
>>   	if (!pcs->spare) {
>> -		empty = barn_get_empty_sheaf(barn);
>> +		empty = barn_get_empty_sheaf(barn, true);
>>   		if (!empty)
>>   			goto no_empty;
>>   
>> @@ -6467,7 +6499,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>>   		goto do_free;
>>   	}
>>   
>> -	empty = barn_replace_full_sheaf(barn, pcs->main);
>> +	empty = barn_replace_full_sheaf(barn, pcs->main, true);
>>   	if (IS_ERR(empty)) {
>>   		stat(s, BARN_PUT_FAIL);
>>   		goto no_empty;
>> @@ -6719,7 +6751,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>   
>>   	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
>>   	    && likely(!slab_test_pfmemalloc(slab))) {
>> -		if (likely(free_to_pcs(s, object)))
>> +		if (likely(free_to_pcs(s, object, true)))
>>   			return;
>>   	}
>>   
>> @@ -6980,6 +7012,12 @@ void kfree_nolock(const void *object)
>>   	 * since kasan quarantine takes locks and not supported from NMI.
>>   	 */
>>   	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
>> +
>> +	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())) {
>> +		if (likely(free_to_pcs(s, x, false)))
>> +			return;
>> +	}
>> +
>>   	do_slab_free(s, slab, x, x, 0, _RET_IP_);
>>   }
>>   EXPORT_SYMBOL_GPL(kfree_nolock);
>> @@ -7532,7 +7570,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>>   		size--;
>>   	}
>>   
>> -	i = alloc_from_pcs_bulk(s, size, p);
>> +	i = alloc_from_pcs_bulk(s, flags, size, p);
>>   
>>   	if (i < size) {
>>   		/*
>>

