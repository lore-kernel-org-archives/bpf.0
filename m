Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F283DA5A2;
	Fri, 27 Mar 2026 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601930; cv=none; b=KwQ9zEZGPyVcs6kF55KxyWuQwosrOv30Qj1CT+uIT/+VwGNAh5FSaYQXt2LfJS3tGzCyvjbTs5lz2QLUxTScWuBG0sQlPUywBNUpPpIYTbpEyuf5bbisn6A1Aq5qfq7JPidGsS7wgC+sEmyV9Uw1OtRhxxzjrI9gjfPoYirga4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601930; c=relaxed/simple;
	bh=w9IZpSJOAS4xupVv5ms1cnqFWHsSUbKDN08TbS6wjpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrQSZoHgF1sKMIq9/yP/XlhrtnLkJxsFOMYuG986UM8VQwmyesZNM0r5yOkhpNlrWXJsG3Z/xyAHnvD391WnvpfRyMHKYlxYvvtSboHM5UkQlGs5rDyz94cOpqtrRZeU41hG0cAQCAuu7TiWDY1XNeEaI/LI8r91+sO77BYH0lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XJrQMXyI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XJrQMXyI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 762A235A1;
	Fri, 27 Mar 2026 01:58:34 -0700 (PDT)
Received: from [10.57.84.204] (unknown [10.57.84.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72F013F641;
	Fri, 27 Mar 2026 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774601920; bh=w9IZpSJOAS4xupVv5ms1cnqFWHsSUbKDN08TbS6wjpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XJrQMXyI71BNRHhsdQda+oNE2PiV7eEwFLFSK7RpzZZHUphr417U6uqxwzvrYcozq
	 iPX6TB3ViUlE4Fl9RMN1MyjYzjpltbYMotvNelSjcjPnxHFuylaBSSHEAY45HUJdIv
	 rM5LHzPPUiyWj/kFVVhFCnUCEKBKREsor2i8z+qU=
Message-ID: <f100305b-6c56-4499-98a4-6a22f8c49443@arm.com>
Date: Fri, 27 Mar 2026 08:58:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
Content-Language: en-GB
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Aishwarya Rambhadran <aishwarya.rambhadran@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <afe9ba0a-1924-42a8-a9c5-34eec709f883@arm.com>
 <ed58493b-0369-4729-bcf7-bc89f72a7913@kernel.org> <acV36oPNFMgL4puz@milan>
 <ea1cb2a1-b674-4d69-bbf6-00051a0e11df@kernel.org>
 <eafefe7a-a33b-4102-93cf-fecc33ddf49e@arm.com>
 <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2026 07:54, Vlastimil Babka (SUSE) wrote:
> On 3/26/26 19:50, Ryan Roberts wrote:
>> On 26/03/2026 18:24, Vlastimil Babka (SUSE) wrote:
>>> On 3/26/26 19:16, Uladzislau Rezki wrote:
>>>> On Thu, Mar 26, 2026 at 03:42:02PM +0100, Vlastimil Babka (SUSE) wrote:
>>>>> On 3/26/26 13:43, Aishwarya Rambhadran wrote:
>>>>>> Hi Vlastimil, Harry,
>>>>>
>>>>
>>>> static bool kfree_rcu_sheaf(void *obj)
>>>> {
>>>> 	struct kmem_cache *s;
>>>> 	struct slab *slab;
>>>>
>>>> 	if (is_vmalloc_addr(obj))
>>>> 		return false;
>>>>
>>>> 	slab = virt_to_slab(obj);
>>>> 	if (unlikely(!slab))
>>>> 		return false;
>>>>
>>>> 	s = slab->slab_cache;
>>>> 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
>>>> 		return __kfree_rcu_sheaf(s, obj);
>>>>
>>>> 	return false;
>>>> }
>>>>
>>>> it does not go via sheaf since it is a vmalloc address.
>>
>> Isn't vmalloc doing slab allocations for vmap_area, vm_struct, etc, which will
>> occasionally go via sheaves though? I had assumed that was the reason of the
>> observed regression.
> 
> You're right. And in the table Harry fixed up (thanks!) I can see the
> regressions are also in tests that don't do kvfree_rcu() but a plain vfree()
> so that rules out the overhead of kfree_rcu_sheaf() returning false.
> 
> It might be due to sheaf_capacity not matching the capacity of cpu (partial)
> slabs. We are working to improve that.

ACK

> 
>>>
>>> Right so there should be just the overhead of the extra is_vmalloc_addr()
>>> test. Possibly also the call of kfree_rcu_sheaf() if it's not inlined.
>>> I'd say it's something we can just accept? It seems this is a unit test
>>> being used as a microbenchmark, so it can be very sensitive even to such
>>> details, but it should be negligible in practice.
>>
>> The perf/syscall cases might be a bit more concerning though? (those tests are
>> from "perf bench syscall fork|execve"). Yes they are microbenchmarks, but a 7%
>> increased cost for fork seems like something we'd want to avoid if we can.
> 
> Sure, I tried to explain those in my first reply. Harry then linked to how
> that explanation can be verified. Hopefully it's really the same reason.

Ahh sorry I missed your first email. We only added that benchmark from 6.19 so
don't have results for earlier kernels, but I'll ask Aishu to run it for 6.17
and 6.18 to see if the results correlate with your expectation.

But from a high level perspective, a 7% regression on fork is not ideal even if
there was a 7% improvement in 6.18.

Thanks,
Ryan

> 
> Thanks!
> Vlastimil
> 
>> Thanks,
>> Ryan
>>
>>
>>>
>>>>
>>>> --
>>>> Uladzislau Rezki
>>>
>>
> 

