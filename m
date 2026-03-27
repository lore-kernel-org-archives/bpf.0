Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526429BDB1;
	Fri, 27 Mar 2026 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598058; cv=none; b=fmJNBq5VZZx03xcs0MFHwmmu76Nxc1Wsq5QcvBe5p+ErP/pHZp08YzzCQAx6N5ZGMYiY7WAVlFNdgap8fzQaDWegTbWL3FBwb0Yotbt9VY4C2O8hNEJFgPqn86Ajqqeey1k/aISdNlSIgDX/gb2zZnqo5IwFL8bcDFjzsWxFkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598058; c=relaxed/simple;
	bh=fVfnbrCFPbx56fN5k/LPGrEtqO3hIsGVAx/y6wA1wg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSd2APQlEW6XqfhmzBhswwB6tYmvknXQqGPIW4bGlguSbu0ihA3CxXZMop9ay1N4R7J+FtVXFr7lvAoOVfFzEzER2AIXtI3EvdcCo8RfUY0m8MSn7la5BeW+VVzPRmQPfod+ulNyFXUCfnugNk8yxEYt3guO72UZI1z0Zofp0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVPrWOIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVPrWOIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DA0C19423;
	Fri, 27 Mar 2026 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774598058;
	bh=fVfnbrCFPbx56fN5k/LPGrEtqO3hIsGVAx/y6wA1wg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZVPrWOISjGykaGNzIuPtynp7+S7nBx1sHQrIkRq0Ii27psJLu9c27zdY01msai7yk
	 CasYCrJaSnnQZhJLWTdEdFoBZ+kqCk+5JoisOZcZ9nr+duf+gdbONshdbiiQ/JCZU4
	 iWHJcsIJdAfJY30N67YOibmQus+oUA1jknUZLH4QJdfFhxV/N/axs8bRQtFIgY0wEv
	 kenlEZo/d2owb7l+oNs+vmGM3lzJ56F3gh6o3m/s1jH3HVBEFwxvJs7mXCqittnYNX
	 6ks1u+duSS5PGp9aBywxJONjmeVwtvV33w53j0JWZJ55a361bo0Y/ZL6l4jYySTUqh
	 vtGSTFjdYnZsg==
Message-ID: <0f441d8f-d84c-470a-a4cb-0249b15220a2@kernel.org>
Date: Fri, 27 Mar 2026 08:54:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] slab: replace cpu (partial) slabs with sheaves
To: Ryan Roberts <ryan.roberts@arm.com>, Uladzislau Rezki <urezki@gmail.com>,
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
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <eafefe7a-a33b-4102-93cf-fecc33ddf49e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/26 19:50, Ryan Roberts wrote:
> On 26/03/2026 18:24, Vlastimil Babka (SUSE) wrote:
>> On 3/26/26 19:16, Uladzislau Rezki wrote:
>>> On Thu, Mar 26, 2026 at 03:42:02PM +0100, Vlastimil Babka (SUSE) wrote:
>>>> On 3/26/26 13:43, Aishwarya Rambhadran wrote:
>>>>> Hi Vlastimil, Harry,
>>>>
>>>
>>> static bool kfree_rcu_sheaf(void *obj)
>>> {
>>> 	struct kmem_cache *s;
>>> 	struct slab *slab;
>>>
>>> 	if (is_vmalloc_addr(obj))
>>> 		return false;
>>>
>>> 	slab = virt_to_slab(obj);
>>> 	if (unlikely(!slab))
>>> 		return false;
>>>
>>> 	s = slab->slab_cache;
>>> 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
>>> 		return __kfree_rcu_sheaf(s, obj);
>>>
>>> 	return false;
>>> }
>>>
>>> it does not go via sheaf since it is a vmalloc address.
> 
> Isn't vmalloc doing slab allocations for vmap_area, vm_struct, etc, which will
> occasionally go via sheaves though? I had assumed that was the reason of the
> observed regression.

You're right. And in the table Harry fixed up (thanks!) I can see the
regressions are also in tests that don't do kvfree_rcu() but a plain vfree()
so that rules out the overhead of kfree_rcu_sheaf() returning false.

It might be due to sheaf_capacity not matching the capacity of cpu (partial)
slabs. We are working to improve that.

>> 
>> Right so there should be just the overhead of the extra is_vmalloc_addr()
>> test. Possibly also the call of kfree_rcu_sheaf() if it's not inlined.
>> I'd say it's something we can just accept? It seems this is a unit test
>> being used as a microbenchmark, so it can be very sensitive even to such
>> details, but it should be negligible in practice.
> 
> The perf/syscall cases might be a bit more concerning though? (those tests are
> from "perf bench syscall fork|execve"). Yes they are microbenchmarks, but a 7%
> increased cost for fork seems like something we'd want to avoid if we can.

Sure, I tried to explain those in my first reply. Harry then linked to how
that explanation can be verified. Hopefully it's really the same reason.

Thanks!
Vlastimil

> Thanks,
> Ryan
> 
> 
>> 
>>>
>>> --
>>> Uladzislau Rezki
>> 
> 

