Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F626ED25
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944948; cv=none; b=YnNKpLnCplvir4Hb2rc9CL8dfO/fVsHMHunWwC/mdRAVM5MzfZyjygPjdejRKNUq3TPF+lDsyXFmTpTkp1unNevJPvzoAuKwer5vwqrfoyFJfQMDf9XPg7jOmcps6zIPutghJccN4WLVtnkU69GNMCGCmCxDKS2des3MPp3eW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944948; c=relaxed/simple;
	bh=edYORkjFyYnqqst/z28/6mhlt7fBZ3FpZIWJ6nX/YQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5T7mU4pOsdJBbL2OOjlwHUTu0PrWNUdEmDcij2tZvF8gLCVrukFeVCoxc5I/uDXdwkQdkArUFhACvpdXsg5S0VWYlBwQSORnp/DMt4ysMaHy9i9M/VDXzPhyXuHFlrYjNhJypz0pt4S1oyKT2NL6agXBTDlHbuPptr3i1M4YvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E9CkeoDx; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E9CkeoDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=sUfINQLXwT6OAD3ZvjxuxslcnmdQOXIEzGCOPZeS8po=;
	b=E9CkeoDxBMiBjUF4N/XTg+kxsba0/Ygluuaz3snHzGJoAEbSukDtIkfCtxMrCt
	TNiiCHdpdjBQgR1XyLAm+vxBLxiG4ZP2x5fZBQMmnw122UiQNPaWOQqQcr8Ow/83
	MSf/gJc1CPqVBvjQvnXy4etJRypuycb3nsnDeJQ8lJQBg=
Received: from [10.193.191.26] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD335peBupp3_wJBQ--.10622S2;
	Thu, 23 Apr 2026 19:45:37 +0800 (CST)
Message-ID: <66f97339-5ad1-480d-a039-e719deca2611@163.com>
Date: Thu, 23 Apr 2026 19:45:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
To: Eduard Zingerman <eddyz87@gmail.com>, Yazhou Tang
 <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com, Tianci Cao <ziye@zju.edu.cn>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
 <f44bd13fc40718dfba7a4074a74fa94c4705672e.camel@gmail.com>
From: shenghao yuan <shenghaoyuan0928@163.com>
In-Reply-To: <f44bd13fc40718dfba7a4074a74fa94c4705672e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD335peBupp3_wJBQ--.10622S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF18Cr4Uuw1DCFWrCrW7urg_yoW3WF1kpF
	WrK3W0qw1kJ343C3s2yws7XF40yFWrJa1UJw1rJ3yvvws8twn2qryfKw4Yka4xu3s3J34j
	vFyYvwnrZ3WYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UewZcUUUUU=
X-CM-SenderInfo: xvkh0w5kdr53ldqqmjqy6rljoofrz/xtbCzgOur2nqBmPDNQAA3c

Hello Eduard,

On 2026/4/23 3:05, Eduard Zingerman wrote:
> On Wed, 2026-04-22 at 22:50 +0800, Yazhou Tang wrote:
>> Hi Eduard, Alexei, and everyone,
>>
>> On 4/21/26 6:28 PM, Eduard Zingerman wrote:
>>> This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
>>> verifier by a pair of circular numbers (cnums): one for 64-bit domain
>>> and another for 32-bit domain. Each cnum represents a range as a
>>> single arc on the circular number line, from which signed and unsigned
>>> bounds are derived on demand. See also wrapped intervals
>>> representation as in [1].
>>>
>>> The use of such representation simplifies arithmetic and conditions
>>> handling in verifier.c and allows to express 32 <-> 64 bit deductions
>>> in a more mathematically rigorous way.
>>>
>>> [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
>> Thanks for the great RFC. Replacing the heuristic min/max bounds with
>> a rigorous cnum domain is a fantastic step forward for the verifier.
> 
> Hi Yazhou,
> 
> Thank you for the response! Collaboration is most definitely welcome.
> Alexei is positive about this RFC, so we have a way forward.
> 
>> We had previously considered proposing a similar replacement of
>> the range tracker with wrapped interval analysis (wint), based on
>> the same TOPLAS'15 paper. However, we held off, fearing the added
>> complexity might be rejected. That's why we are thrilled to see
>> this RFC and would love to contribute to this effort:
>>
>> 1. Implementation of division, modulo, and other missing ALU ops
>>
>> We noticed the discussion regarding the complexity of div/mod on cnum.
>> We have previously implemented [1] the full suite of abstract operations
>> for wint in Rust (including add/sub/mul/div/mod and bitwise ops).
>> This was built for potential integration into Solana BPF and is
>> heavily inspired by a recent paper [2].
>>
>> [1] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust
>> [2] https://dl.acm.org/doi/pdf/10.1145/3728905
>>
>> The algorithms for div and mod are indeed complex but entirely viable.
>> We are very interested in collaborating to port these extended ALU
>> operations into the kernel C implementation.
> 
> Could you please elaborate which algorithms you have in mind.
> It appears that [2] is about sign-aware tnums not wrapped intervals.
> The Rust code for [sdiv] looks similar to the algorithm described in
> the TOPLAS'15 [1].
> 
> [sdiv] https://github.com/OpenSourceVerif/Wrapped-Interval-for-Rust/blob/master/src/wrapped_interval.rs#L985
> 
> 

I think Yazhou meant that we could translate the Rust implementation (reproducing
the TOPLAS'15 algorithm) to C for the cnum domain. But we could try to implement
a simplified vesion of [sdiv] in the TOPLAS'15 paper to better suit the
real-world production scenarios.

>> 2. Machine-checked proofs via theorem prover(s)
>>
>> While CBMC is excellent for checking bounded C-level implementation
>> details and catching integer bugs, model checking is inherently
>> constrained by its bounds.
>>
>> To complement this, we have used the Rocq theorem prover to provide
>> deductive, algebraic proofs for the soundness and completeness of
>> wint's operations over int64. This is still a work in progress;
>> currently, we have completed the proofs for:
>> - the soundness and completeness of wint's add and sub operation
>> - the soundness of wint's join operation
>>
>> We believe this can strengthen the theoretical foundation of cnum.
>>
>> We are also exploring the use of Z3 to automate the soundness proofs
>> for these abstract operations. Furthermore, we are actively researching
>> the soundness of the reduced product between tnum and wint (cnum),
>> which we hope will eventually serve as the theoretical guarantee
>> for the safe collaboration between tnum and cnum in the verifier.
> 
> That's a bit of a mess on my side at the moment.
> Not married to CBMC-based proofs, just happen to understand the
> notation and it was easy to write CBMC proofs for basic cnum
> operations. I did not try to prove anything about precision, only
> soundness, here is what I have:
> - https://github.com/eddyz87/cnum-verif/blob/master/cbmc_cnum32.c
>    This were easy for CBMC to prove
>    - from_{u,s}range()     32-bit domain
>    - {u,s}{min,max}()      32-bit domain
>    - intersect()           32-bit domain
>    - cnum32_from_cnum64()
>    - cnum64_cnum32_intersect()
> - https://github.com/eddyz87/cnum-verif/blob/arithm-ops-2/cbmc_helpers8.c
>    I tried to verify full mul operation using cbmc and hoped that use of the
>    8-bit domain would make it faster to converge. Some of the operations
>    below can be moved to 32/64-bit domains w/o risking solver timing out.
>    - add
>    - union
>    - cut
>    - check_mul_chunk
> - https://github.com/eddyz87/cnum-verif/blob/arithm-ops/cbmc_helpers8.c
>    - negate
> - https://github.com/eddyz87/cnum-verif/blob/arithm-ops-2/main.c
>    - mul -- in the function's current form CBMC is not able to process
>      it quickly even in 8-bit domain. Idk if I can make it work by
>      adding more contracts or moving the sorting phase to a separate
>      function with additional contract.  So far, I just have a
>      brute-force verification for all possible combinations of 8-bit
>      intervals.  It finishes in a couple of minutes on a 192 core
>      machine :)
> 
> Tldr, CBMC proved to be easy to use for primitive operations on cnums
> (probably generalizes to other SMT based checkers, but CBMC consumes
> unmodified C code which is extremely convenient).
> The combination of primitive operations, such as `mul` turned out to
> be harder to prove. (But I am by no means an expert when it comes to
> these tools).
> 

Thanks for sharing the details of your current verification setup.

Let me clarify a few points:
1) CBMC-based proofs – These are very good are useful.
2) Our verification approach - We (Yazhou, Tianci, me and other members in our term)
    will use Z3 and Rocq to prove the soundness of (the existing and future)
    cnum operations before the code is merged upstream.
    The proofs will be open-sourced at [3], and the primary purpose is to
    build greater confidence that the cnum implementation is safe.
    We will maintain these proofs continously, and no extra maintenance burden
    are added to the Linux eBPF community (like learn or use Z3/Rocq).

[3] https://github.com/OpenSourceVerif/open-verified-artifacts

Brief comparison of the three techniques for clarity:
- CBMC: Very user-friendly and allows quick checks. However,
   it cannot guarantee full soundness for cnum because it is bounded and
   cannot explore all possible cases (hence "bounded" verification).
   I am also very interested in CBMC for cnum, especially given
   the timeout issues you experienced.

- Z3 solver: Less user-friendly, but it can explore all possible cases
   using mathematical theories when the search space is not too large.
   For cnum, I believe operations like  cnum64-add/union/negate/etc could be proven in Z3.
   Not sure for the current cnum64-mul operations which looks complicated,
   maybe Z3 timeout on it. For example, in our recent experiments on the
   tnum_sdiv/smod (the algorithm from [2]), Z3 easily solved the 8-bit version
   but timed out after 24 hours on a 256-core server (1.5TB memory)
   for the 64-bit version.

- Rocq prover: Quite difficult to use and requires significant manual effort,
   but it is the most powerful tool.
   We can use it to prove the remaining cases that Z3 cannot handle.

> Thanks,
> Eduard


Looking forward to your thoughts.
ps: Could we send PRs to [4] firstly once we have new cnum implementations?

[4] https://github.com/eddyz87/bpf/

Best wishes,
Shenghao

