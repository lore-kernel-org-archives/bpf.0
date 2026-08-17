Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639A27D786;
	Mon, 17 Aug 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976430; cv=none; b=d3gi00ri3IWbjrZry3kJRMZjSjyTkquJnDk7GYWq43FAg+s77A93E8Pd/8zi2MeSNlyhiBmOzmPoRStWTCV7L98AkHM+Mzsmwd8Jmg3FU5Q2yhYdaZnaTEZ51yW2xbctq7c5cPpzmJgqLBUpnSl4ecsheoDQbVLISSTH8rxaOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976430; c=relaxed/simple;
	bh=8M/aIqelAoUOCteDkUInmpDkioDQLoSr2gHe45HSDJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di+/f+F8g+um/S/vLdXFgcTd4Nuj75JzhwFOWGt/I48CmObl4/BchFcYKj076syVEIzQ1OJZ5s5iQfgOaj3Rgq5VAFkjqaN9lsxExxLHZFoEuZA363TmQDzvmkI5DI31efjMQLt1nzVcFznKbyHRYvA0jPObnMDwpgJhFPUPfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jeP/0zu1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jeP/0zu1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ifdNIG+S04K40CHHKlWPcFgMS63d5NVSCS3KIOPTPyM=; b=jeP/0zu1Z7VrvpPfPLre7/ni75
	5PhbBFMNvHKHy4QXXXhnHmMyZj5z+t9UaOAjAXUcQ4KtzVI5Z1fH1/wRMqIScTMb6THKLtGrIiPXj
	K4z4JC40HGFMyWFDSNMoAFopw+WLngILjWENRAPMS3sLq1Ikg45Y1E3sjLIl+K36Ast+nO0OQ303g
	FF7BrDdBam0CYHiH5Gw9LYdW5I3nOWTEDxXPtI8eebkvoGj86QIahcLeJHq/2WvwKuANQu/MTJElV
	GExvzRolzNYUryo9A2ZMsIUZ0BcBjKbpuMmKcOC1GeiSxra551cW5hM3tXY765iUIMIKLu1VzSKna
	OjL7RMRg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvyCK-000OYK-1T;
	Mon, 17 Aug 2026 16:20:20 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvyCJ-000GIJ-2t;
	Mon, 17 Aug 2026 16:20:19 +0200
Message-ID: <3694dac0-3ba7-4d1c-8a1e-7f590baf649f@iogearbox.net>
Date: Mon, 17 Aug 2026 16:20:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: make sure allocation in
 arch_bpf_trampoline_size() is writable
To: Mike Rapoport <rppt@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Leon Hwang <leon.hwang@linux.dev>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
 <20260716-execmem-x86-rox-bpf-v0-v3-4-4e76158c01c5@kernel.org>
 <an8r7EODLIL-bZM3@krava> <aoF7f3lH_rz7mxSR@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aoF7f3lH_rz7mxSR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

On 8/16/26 10:57 AM, Mike Rapoport wrote:
> On Fri, Aug 14, 2026 at 04:53:32PM +0200, Jiri Olsa wrote:
>> On Thu, Jul 16, 2026 at 10:51:38AM +0300, Mike Rapoport (Microsoft) wrote:
>>> arch_bpf_trampoline_size() allocates a buffer to get actual size required
>>> for a trampoline.
>>>
>>> This buffer must be in the module address space because
>>> __arch_prepare_bpf_trampoline() calculates  rel32 offsets relatively to
>>> that buffer.
>>>
>>> In preparation for enabling ROX mode for EXECMEM_BPF make sure that the
>>> allocated memory is writable.
>>>
>>> Add bpf_jit_alloc_exec_rw() wrapper for execmem_alloc_rw() and use it for > buffer allocation in arch_bpf_trampoline_size().
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>   arch/x86/net/bpf_jit_comp.c | 5 ++---
>>>   include/linux/filter.h      | 1 +
>>>   kernel/bpf/core.c           | 5 +++++
>>>   3 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index de7515ea1bea..b2feec81e231 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -3703,13 +3703,12 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>>>   	int ret;
>>>   
>>>   	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
>>> -	 * This will NOT cause fragmentation in direct map, as we do not
>>> -	 * call set_memory_*() on this buffer.
>>>   	 *
>>>   	 * We cannot use kvmalloc here, because we need image to be in
>>>   	 * module memory range.
>>> +	 * Since it must be writable use bpf_jit_alloc_exec_rw().
>>>   	 */
>>> -	image = bpf_jit_alloc_exec(PAGE_SIZE);
>>> +	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
>>
>> hi,
>> this change (this particular patch plus possibly others in this set) is
>> causing tracing_multi attachment bench slowdown
>>
>> the benchmark allocates huge number of trampolines and I'm seeing extra
>> arch_bpf_trampoline_size code paths in the attached perf profile
>>
>> I'm not that familiar with the allocator, but following hack makes the
>> benchmark ok again:
>>
>> 	diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> 	index 6a94370a2448..bbff3c9c6681 100644
>> 	--- a/kernel/bpf/core.c
>> 	+++ b/kernel/bpf/core.c
>> 	@@ -1130,7 +1130,7 @@ void *bpf_jit_alloc_exec(unsigned long size)
>> 	
>> 	 void *bpf_jit_alloc_exec_rw(unsigned long size)
>> 	 {
>> 	-	return execmem_alloc_rw(EXECMEM_BPF, size);
>> 	+	return execmem_alloc(EXECMEM_MODULE_DATA, size);
> 
> This is fine on x86 because all execmem types live in the same 2G
> range. Other architectures may have _BPF and MODULE_DATA in different
> ranges, e.g arm64 and some configurations of powerpc.
> 
>> 	 }
>> 	
>> 	 void bpf_jit_free_exec(void *addr)
>>
>>
>> I still need to do more checks, but I'm wondering if we could actually fix
>> this by not allocating image data in arch_bpf_trampoline_size at all..
>> and just teach __arch_prepare_bpf_trampoline to survive NULL image data
>> and just return the size in such case
> 
> Since bpf_jit_alloc_exec_rw() is only used by
> x86::arch_bpf_trampoline_size() I think we can directly allocate from
> _MODULE_DATA there and drop bpf_jit_alloc_exec_rw(), like (build tested
> only) patch below does.
> 
> If/when other architectures would implement arch_bpf_trampoline_size(),
> they'll probably need to deal with this differently.
Mike, could you send this as a regular patch to bpf list, so it can go
through BPF CI?

Thanks,
Daniel
