Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B5844D6A1;
	Tue, 19 May 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183657; cv=none; b=e9GPSbBYTfK+4/8YnccMyp3DXKS6uD4eR9qu257yBwsekR7uPAFsveksVPzohumVern1kGUQgdt8SyPTM10sePZRBsyygMrpJBqhlnFmS5kTvXzIN0OifALzec5LDdpwUbH9I88xFrI56nTgpOeu1D77q2tLn8QSJgHFd808hCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183657; c=relaxed/simple;
	bh=fkmrgQQrDeNLvc7UDu335ZGUAhYjlNgB6Tk2RSRZEeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uMxpPFGv0QawgmqixL3cLQye6ZhT4jhH/isKz/dJdVHSTRf3pw3VLGAaKbH0M/+PasNxqDv/rEAakzYMFtfdLk26dJxnIno8qjSmC7WHXHCj4JmpiGk6CqTty6pTv0q1EOPDHwV3K5qPQAN1OyQRuCBFdvXzddkTRJ27hkder3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhx90dnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhx90dnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5028DC2BCB3;
	Tue, 19 May 2026 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779183655;
	bh=fkmrgQQrDeNLvc7UDu335ZGUAhYjlNgB6Tk2RSRZEeY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uhx90dnE2FxSA1Q+pm9JvVN1iC6B44MyYb2rgxqeF/jFZZvJnGvxX/RrMmMGlpiAD
	 z8QqfdXed3V1eWPHiuooTxUNB0Y/uXpHXH2nmVTBz5KeS04T0iSmkIemcc+0zlm/eh
	 QxDDEW7LtG49E+rRDf0qC8dnFLgvsJVtnbB8BVSEqOluCl9EU6lTqHYSC4/hNSq4vr
	 BYeaMktKuUf+zZNNuqvZzyH3EVXZyJTQeiac2BnOHdR3Vm2JDTjWSAUCk+maErkUhZ
	 Fis5VxTYy5VHxo24pyKKrgJsaIvBZ3cIu4NEeBEmEY34qRWOaG+VRXfqU40Mn0njLS
	 n7tmGSmkK0D3g==
Message-ID: <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
Date: Tue, 19 May 2026 11:40:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot
 installs
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>
 <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org>
 <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 11:05, David Hildenbrand (Arm) wrote:
> On 5/19/26 10:58, Tejun Heo wrote:
>> Hello, David.
>>
>> On Tue, May 19, 2026 at 10:00:39AM +0200, David Hildenbrand (Arm) wrote:
>>> Is that really possible? I'd much rather prefer to trylock and retry, unless
>>> that can really result in deadlocks. But I have the feeling that such deadlocks
>>> should be impossible here.
>>
>> I'm not well versed in either mm or BPF, so the BPF folks will have a
>> better take. But here's a scenario that seemed plausible to me:
>>
>> 1. A bpf prog calls bpf_arena_alloc_pages() on its arena. The kernel
>>    takes arena->spinlock via raw_res_spin_lock_irqsave().
>> 2. Under the lock, the alloc path goes through bpf_map_alloc_pages()
>>    -> alloc_pages_node(), which fires trace_mm_page_alloc().
>> 3. A BPF tracepoint program on mm_page_alloc that shares the arena
>>    starts running with the lock still held.
>> 4. The tracepoint program calls a kfunc, passing an arena pointer
>>    one entry past the array it meant to touch.
>> 5. The kfunc dereferences. The kernel-side address is unbacked, so
>>    the CPU faults.
>>
>> trylock + retry at 5 would A-A deadlock.
> 
> Okay, so removing that specific tracepoint (or rather, any tracpoints under the
> lock) would solve the problem, right?
> 
>>
>>> For example, staring at apply_range_set_cb(), what prevents:
>>>
>>> (1) apply_range_set_cb() finding pte_none(ptep_get(pte)
>>> (2) apply_range_set_scratch_cb() succeeding ptep_try_install()
>>> (3) apply_range_set_cb() overwriting the pte with set_pte_at()
>>>
>>> Between (2) and (3) CPUs could access the scratch PTE.
>>
>> Scratch only gets installed when BPF passes an unallocated arena
>> address to the kernel side, which is itself the violation, reported
>> through the program's BPF stream. Behavior at that addr is then
>> undefined. For scx, the scheduler should be aborted and torn down.
>>
>> The only requirements are that the kernel doesn't oops and the
>> violation gets caught. Beyond that, behavior at the address is
>> unspecified, and which installer wins the race doesn't matter as
>> long as kernel integrity holds.
> 
> You'll have inconsistent TLB state.
> 
> I really don't like that approach.
> 
> We should really try to just take the lock, and remove any code under the lock
> that could trigger such unpleasant deadlocks.
> 
> Is that feasible?
> 

... or can we run into similar problems with kprobes? (I am obviously no bpf
expert ...)

-- 
Cheers,

David
