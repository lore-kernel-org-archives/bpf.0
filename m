Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78213DDDC3;
	Wed, 19 Aug 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124884; cv=none; b=oKTr06D5RI2KEm1MfSOalt31Vwv9SFGOzLi81gjOWi3R7H/TvteZfthTfK181SjqcX3MPr3RTB2y39QjCM2r3jCPMt8VN37p5Cb6OgxW8oKUv4AYDuEoqqhNR18U1bGh7xLMTDoUphvPLUXjgvkInSeNS9eHJsZ8up8WjhpinoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124884; c=relaxed/simple;
	bh=MKPP02KZ2cjY0XspJUvLQSavTzRLzUgsKkXCz/lB+q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trIWKWdmYVa/gL3ZFXoWYMsrIgSHR6SOfvOF0cEj8CarWqfRxFDkmX2axMH5F8Svxn76JqEO4X76+E1BVjqeMY8HtsVhB/yTffFd44Ra6PwZYFDizHnQ9HwtG3+ULUkwWGDE7viEjpcJP9yyyQaQHJxboY2Xewp1L93VkPEBeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=N24VMv5l; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="N24VMv5l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wY63s86MM9Q+c8EzOvOTqgqOkCEoxYfm2xQ6dvqM5SE=; b=N24VMv5lN2P4fuGmtn2MdTLZHq
	ZBWn6n5hMm05oz/6lBD7jYe5lMQ2DLRcvLJHJ+LA2BW8qflvBCidHxJwke3jKhBEXyUjpwyAWVAFB
	yWPVrlgNkPTVyqCgMsMIwXThu8EvZmOQiOQy5AVXvgdXV0644Z93gEKkyY9SvNtc2mCrB9aViW3k3
	W1i8h+PuFw8OR0aUwuwdUQm7HaIQSD5hPei3MnEGGLt1+lZl3zEzcZHxa8eplvirFVlombS7KOjV3
	ohm7f2SZ/V5qpc4kRNTT1A7eGnZjnnTF7wRkHEzhtQ1kvx4iUGa4MXDj2+M+Z/DcP3D03sE5qGk2D
	Lduf1eHw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wwaoa-0002LS-1p;
	Wed, 19 Aug 2026 09:34:24 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wwaoY-000P6L-1L;
	Wed, 19 Aug 2026 09:34:23 +0200
Message-ID: <6d22da00-06ff-4f75-8cf0-3e34189ceda9@iogearbox.net>
Date: Wed, 19 Aug 2026 09:34:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
 EXECMEM_MODULE_DATA
To: Mike Rapoport <rppt@kernel.org>, bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, eddyz87@gmail.com, mingo@redhat.com,
 memxor@gmail.com, song@kernel.org, tglx@kernel.org, emil@etsalapatis.com,
 hpa@zytor.com, jolsa@kernel.org, john.fastabend@gmail.com,
 martin.lau@linux.dev, yonghong.song@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, olsajiri@gmail.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260818130510.3110054-1-rppt@kernel.org>
 <9b5c48df2b9e1f49191a459c822608751240e2243ae0cebb96bae0939037aadc@mail.kernel.org>
 <aoVQYYzUt_eCG4Ek@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <aoVQYYzUt_eCG4Ek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28096/Tue Aug 18 08:27:40 2026)

On 8/19/26 8:42 AM, Mike Rapoport wrote:
> On Tue, Aug 18, 2026 at 02:07:23PM +0000, bot+bpf-ci@kernel.org wrote:
>>>      x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
>>>
>>>      Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
>>>      number of trampolines [1].
>>>
>>>      The slowdown caused by extra protection changes in execmem_alloc_rw() and
>>>      execmem_free().
>>>
>>>      With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
>>>      are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
>>>      W+NX and execmem_free() resets them back to ROX.
>>>
>>>      The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
>>>      that only needs a temporary writable buffer in the modules address space.
>>>
>>>      On x86 executable memory and module data are constrained to the same
>>>      address range, so x86::arch_bpf_trampoline_size() can directly use
>>>      execmem_alloc(EXECMEM_MODULE_DATA)
>>>
>>>      Replace the call to bpf_jit_alloc_exec_rw() with a call to
>>>      execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
>>>      drop bpf_jit_alloc_exec_rw() helper.
>>>
>>>      Reported-by: Jiri Olsa <olsajiri@gmail.com>
>>>      Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
>>>      Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
>>               ^^^^^^^^^^^^
>>
>> The Fixes tag references commit f0334294a428, which does not exist in
>> this repository. Should this be:
>>
>>    Fixes: 5bf02dbf39fa ("bpf, x86: Make sure allocation in arch_bpf_trampoline_size() is writable")
> 
> Argh, checked the log on a wrong branch.
> 
> Can you folks fix it up when applying or you'd need v3?

Yeap, we'll do, np.

>> That commit introduced bpf_jit_alloc_exec_rw() and the performance issue
>> being addressed here.
> 

