Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1412C534
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799002; cv=none; b=QWkzZ6soP5ruu7pygbNhYpvjhgwBrMfedg00aqd7uS9xR4qvTa3InbhyPIOka+D91Ecyzo0+FPEPmbCrjQTL43dGwqke0oL7BYP+mo1jyT5w0Jcu2a+wGNb0s2Jli6v2b8saAfsbw/Mb05h9Tlb4MRuGit39b4HISQp/s4VtNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799002; c=relaxed/simple;
	bh=xJqyqp9h9wkId19hDSG0WgUjmpZ1FeEpQZ1ulEXH6ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjf+/sai0iAASVuq2tLxr0WKoHNw66tgvhcQ2FY4yilcLZLE8blGJvToBlk0QCXIfZHEU43uggfk0egiiGVt/0SrfEo15Jt2D6SM5VR4jwlnKHukpklRv+wbUsx1laRthbdj8U91BRVB6zP3HByy6ppMVbqOuWzeztGadAspPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tmoz29zS; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tmoz29zS"
Message-ID: <2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778798998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcFOYxoDcm2bi5wa7yl5VopgovEayWGRP+z4Ok8jnN4=;
	b=Tmoz29zS65jSGiFsJ5F1RJVkkDobdMZaQGkcasqOjp2NFkoQU6EvI+vzogdtp6FVwKKIOX
	OnZGsALUAkDsMH3uer0MRjnJ8iSFZb2Nt0MTx4RkcA+dzf51WnkuHCnYPb24895C8/aCjU
	2lGAmnzoLAV9YQHVnptcDeQFuh4MlNU=
Date: Thu, 14 May 2026 15:49:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-3-ihor.solodrai@linux.dev>
 <agYzuDIJszA_7rp3@linux.dev> <8b83f690-c962-48e5-a557-dea03e4cdf2d@linux.dev>
 <agZG6XF41paiPjgm@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <agZG6XF41paiPjgm@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 3:14 PM, Shakeel Butt wrote:
> On Thu, May 14, 2026 at 02:31:58PM -0700, Ihor Solodrai wrote:
>> On 5/14/26 1:47 PM, Shakeel Butt wrote:
>>> On Thu, May 14, 2026 at 11:47:26AM -0700, Ihor Solodrai wrote:
>>>> Sleepable build ID parsing can block in __kernel_read() [1], so the
>>>> stackmap sleepable path must not call it while holding mmap_lock or a
>>>> per-VMA read lock.
>>>>
>>>> The issue and the fix are conceptually similar to a recent procfs
>>>> patch [2].
>>>>
>>>> Resolve each covered VMA with a stable read-side reference, preferring
>>>> lock_vma_under_rcu() and falling back to mmap_read_trylock()
>>>
>>> Why trylock()? Why not just reuse the mechanism introduced in [2]? That is
>>> abstract out the mechanism introduced in [2] in mm core and reuse it.
>>
>> v1 used mmap_read_lock() as the fallback, but Puranjay pointed out [1]
>> that stackmap can be called when the caller already holds
>> mmap_lock. 
> 
> Can you exapnd on the scenario where caller already holds mmap_lock? Is this
> code path can be taken from bpf programs and bpf programs can be attached at
> functions/code-paths already holding the mmap_lock?

Exactly. For example, tracing BPF programs may attach to mm internals, and
there are also BPF iterators over VMAs (i.e. SEC("iter/task_vma")). And
probably other use-cases.

Bottom line is we can't assume it's safe to take mmap_lock in a code path
reachable from a BPF program.

> 
>> So I changed to trylock since v2, similar to non-sleepable
>> path.
>>
>> AFAIU this means that the common mechanism needs to support trylock
>> behavior as in stack_map_lock_vma() in this patch.
>>
>> Do you think this is worth factoring out of stackmap.c?
> 
> Do you think we will need similar handling at more places in future
> (particularly in bpf world) then it makes sense to factoring out now? Otherwise
> we can wait until we are sure.

Honestly, I don't know. IMO we shouldn't prematurely generalize a piece of
code with a single user. But I just may be unaware of the others.

> 
>>
>> [1] https://lore.kernel.org/bpf/m25x611s17.fsf@kernel.org/
>>
> 
> 
> 

