Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C733ADB3;
	Wed, 20 May 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312557; cv=none; b=ic3ricRYn66ze0ZLNMcfQJ9sBjNr3JasfPytv5AEVw9hdQGKNQM0RHm4HVSqyu9B3Z0tK+a7OMJbIwTGLXa4qVtX7qJ096IyibcL6e/gSxffEU/pOHJWldQKJMOR/q2OVfN0cYXqwda9ruPrZZEx1/htOr2XAqZqNaluJlmK9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312557; c=relaxed/simple;
	bh=Cutv9zNDEEDvIK2sIMYaaOAxUw9EBmrcpgZTKE+5w3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKtFn+RcGEQWiaUPhe+LDcFYzMq47KQMSryZ0pQ459hdnKqu5Bxpl4Y1XO0yUx2kYvG0I0NVSKwgFhWY6vQCkR+qXiDyMEERUjompQyLKPdCS2Av0jXQqlbV/1Wcah0JxBSb38WDtg/M23eHnxhuxUnw767iBgCOyLH+NS/FHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQc39hnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQc39hnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE26B1F000E9;
	Wed, 20 May 2026 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779312556;
	bh=+FvKgT5pG95JgT3TscKBF5hGUKTEVSajCnC+nu0Y4WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XQc39hnvCdkTlJIa8y9YfgGkIJQb1cHVaoOkJ7pbNHFepqyzWDGV4Wxa5w7n7maGc
	 X+b9cmNIXD1NNy46RiDLbrSNZKSvWZkVvzOf5pjYkd9GkeQ8uWitOK7rbabbOpRsMR
	 cU2Dzy2Z/oHVXA1L7GHzimHqACLluo7QZV4M3RKQ0VSW0gAsm/ALa1Jg6hl3P+lCuJ
	 2OikXfZRe0W52IcmQMM/se/XYc5GpkRUpXmiQI7394jKgEDAK8kQbIZmBYmRb/oRNk
	 R3bs2GEMBeAjc+i/0X3bVd97RkREIJ/H5nw8+YdfehKMnRuPgqE+f2PNVK0PTE1sZc
	 eCBD5LIKuDCGA==
Message-ID: <210d140d-c78a-47be-8046-caae359db6db@kernel.org>
Date: Wed, 20 May 2026 23:29:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] mm: Add ptep_try_install() for lockless empty-slot
 installs
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260517211232.1670594-2-tj@kernel.org>
 <9ba50fd2-077e-4291-9276-9adb18186873@kernel.org>
 <agtuPrgIDNKSu2Oo@slm.duckdns.org>
 <2f02d90d-cdc9-48ef-abe3-99e00f22595f@kernel.org>
 <297658c4ae2d6e7103f5968efc936224@kernel.org>
 <04b03066-86d3-4c0b-b077-307fd0f3bc9c@kernel.org>
 <5590fd3d-dae1-4070-b52f-bc40982ac678@kernel.org>
 <agyZxmHoueGwBAQg@slm.duckdns.org>
 <CAADnVQJt0p7hSn2G074QZRh2LEdthy3RKYJ9j3w5yeJ-e8UQLw@mail.gmail.com>
 <fb889bfc-af0e-491e-a69f-38c2abf88d22@kernel.org>
 <ag3_qpKObFOLKgbR@slm.duckdns.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ag3_qpKObFOLKgbR@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 20:38, Tejun Heo wrote:
> On Wed, May 20, 2026 at 10:41:15AM +0200, David Hildenbrand (Arm) wrote:
>> And that should be carefully documented.
> 
> Will do.
> 
>>> The fault handler has to install _some_ page and let kernel continue.
>>> Scratch page or arena page doesn't matter. Potentially different CPUs
>>> will see different page. It's not a concern at all.
>>> bpf prog is buggy, but the kernel will continue to work without a glitch.
>>> bpf runtime will disable and unload misbehaving prog.
>>
>> Having one page table walker overwrite a scratch page on race is just rather ...
>> questionable locking design, that just screams for problems long-term, really.
>>
>> At least in apply_range_clear_cb() one could similarly switch to
>> ptep_try_install() to at least have both these paths handle races in a
>> reasonable way. (having to handle when ptep_try_install() is not really implemented)
> 
> Hmm... wouldn't that be more confusing on apply_range_clear_cb() side?
> Whether it maintains the current behavior (if collide with scratch, try
> again with scratch as the original value) or flip the behavior (fail if
> scratch), that extra logic is spurious, and those tend to confuse people as
> they force asking why it has to be that specific way. If the goal is
> documenting the subtlety, wouldn't a detailed comment serve the purpose
> better?

I would let all operations that can happen concurrently work with atomics, not
just a single one.

Alexei correctly concluded that ptep_get_and_clear() might be one option that
should do on x86 and arm64 from a quick glimpse.

> 
>> Anyhow, the documentation of ptep_try_install() must clearly spell out that this
>> must be used very carefully, and only in special kernel page tables, never user
>> page tables. There are likely other scenarios we should document (caller must
>> prevent concurrent page table teardown somehow, and must be prepared to handle
>> races if other code is not using atomics).
>>
>> To highlight that, we should likely consider adding a "kernel" in the name, like
>> "ptep_try_install_kernel()".
>>
>> I am also not sure if "install" is the right terminology and whether it should
>> instead be "ptep_try_set()". (set_pte_at is the non-atomic interface right now)
> 
> So, ptep_try_set_kernel()?

I guess we could do that, but we don't have a lot of existing functions that are
specific to kernel page tables ... only pte_offset_kernel() and
pte_alloc_one_kernel()/pte_free_kernel().

The most important part is getting the documentation right.

We should probably document that code concurrently clearing PTEs should be using
ptep_get_and_clear().

-- 
Cheers,

David
