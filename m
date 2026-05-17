Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565B381AF
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030673; cv=none; b=mQAI3T8I2WFA/iA3E4gse8xR4WK9nvx9bPEwJ0nanS0hCrjSsk3l4NLRivXOthUdtN5s5KL40W87cV2vTMCPcI6ItUO5SSeCVC5smw6F9scNLfbuBtbCMio1jGZ+a1dLXB9wu8ixwZrvgIhmr3jawmvVLqJSHdJKZzLPpwWu/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030673; c=relaxed/simple;
	bh=utx2lSjDECFzKN9ugdzHWliG9rQgr0YOWYfFmSYrY+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj/5ni4y6WBro4yzPb1QPYOH0UxzO+u0b08u/tlxPu8a9BbUThKa52F3Iz0ek6M2cYcA8fPn+AzDGlrfaZwKiOkz7QcvDkRTNTzcNW8aGJ1ulht44HTTczDmb3f2MMtHhc1qVgQkp00CY02LvKBHcwqXFd8oSDbjAsfdhpxM13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X+17zWAK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X+17zWAK"
Message-ID: <de1af862-6875-4d73-96de-01329c5bcb49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779030668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSNWa6nFHG5+LGazpb/kIv/QwSIdEzJ6XvT2/t6JimM=;
	b=X+17zWAKyOPtgC0zOry3/9YxJQiewodzt1g2+ra5Ki3eCBAVSEL67j6SyLAozQoI1COKjh
	r68rLy/jtPIHZCi4I+eMarFGJqYQ0qNEZp9JjOzDHBAlo6POtJ615n+H8rGNAFFamCpc+G
	OVnJiBsCbnZ3I2OLfeQ0+te+wXC04g4=
Date: Sun, 17 May 2026 08:11:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with
 outgoing stack arguments
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225106.824804-1-yonghong.song@linux.dev>
 <DIKJM7FYGJ9K.2H5U2EPKDENME@gmail.com>
 <d023d1a7-73dd-46eb-b763-3b2004380a8a@linux.dev>
 <DIKSIO0A3O95.1L6CGZBD8YRRE@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIKSIO0A3O95.1L6CGZBD8YRRE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/17/26 12:57 AM, Kumar Kartikeya Dwivedi wrote:
> On Sun May 17, 2026 at 6:55 AM CEST, Yonghong Song wrote:
>>
>> On 5/16/26 5:59 PM, Alexei Starovoitov wrote:
>>> On Fri May 15, 2026 at 3:51 PM PDT, Yonghong Song wrote:
>>>> When a main program with exception_boundary has outgoing stack
>>>> arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
>>>> to correctly restore callee-saved registers, causing a kernel crash.
>>>>
>>>> The x86 JIT allocates the outgoing stack arg area below the
>>>> callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
>>>> When bpf_throw() unwinds, it captures the main program's sp (which
>>>> includes this outgoing area) and passes it to the exception callback.
>>>> The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
>>>> points into the outgoing arg area rather than the callee-saved
>>>> registers, so the pops restore garbage values. Returning to the
>>>> kernel with corrupted callee-saved registers causes a crash.
>>>>
>>>> Fix this by passing the main program's outgoing_rsp as the 4th
>>>> argument to the exception callback. The callback adjusts rsp with
>>>> 'add rsp, rcx' before popping callee-saved registers, correctly
>>>> skipping the outgoing arg area. When outgoing_rsp is 0 (the common
>>>> case), this is a no-op.
>>>>
>>>> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments")
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    arch/x86/net/bpf_jit_comp.c | 9 ++++++++-
>>>>    include/linux/bpf.h         | 3 ++-
>>>>    kernel/bpf/fixups.c         | 1 +
>>>>    kernel/bpf/helpers.c        | 2 +-
>>>>    4 files changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index ceefefb4da21..f4fdceedaad7 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -557,10 +557,15 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
>>>>    			/* Keep the same instruction layout. */
>>>>    			emit_nops(&prog, 3);     /* nop3 */
>>>>    	}
>>>> -	/* Exception callback receives FP as third parameter */
>>>> +	/*
>>>> +	 * Exception callback receives:
>>>> +	 *   rsi = main program's SP, rdx = main program's FP,
>>>> +	 *   rcx = main program's outgoing stack arg area size
>>>> +	 */
>>>>    	if (is_exception_cb) {
>>>>    		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
>>>>    		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
>>>> +		EMIT3(0x48, 0x01, 0xCC); /* add rsp, rcx */
>>> Maybe let's do it on C side like:
>>> bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_adjust, ctx.bp, 0);
>> This sounds better!
>>
>>> Avoids the need to use 'rcx'.
>>>
>>>>    		/* The main frame must have exception_boundary as true, so we
>>>>    		 * first restore those callee-saved regs from stack, before
>>>>    		 * reusing the stack frame.
>>>> @@ -1789,6 +1794,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>>>    	 * Arg 6 goes into r9 register, not on stack.
>>>>    	 */
>>>>    	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
>>>> +	if (bpf_prog->aux->exception_boundary)
>>>> +		bpf_prog->aux->stack_arg_adjust = outgoing_rsp;
>>>>    	emit_sub_rsp(&prog, outgoing_rsp);
>>>>
>>>>    	if (arena_vm_start)
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 242f9597d9ab..2a1616c769a9 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -1735,7 +1735,8 @@ struct bpf_prog_aux {
>>>>    	int cgroup_atype; /* enum cgroup_bpf_attach_type */
>>>>    	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
>>>>    	char name[BPF_OBJ_NAME_LEN];
>>>> -	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>>>> +	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64 stack_arg_adjust, u64);
>>> no need to change this.
>> Indeed, with the above 'ctx.sp + ctx.aux->stack_arg_adjust',
>> the 4th argument does not need any change.
>>
>>>> +	u16 stack_arg_adjust;
>>> this one is still needed, but maybe let's call it stack_arg_sp_adjust?
>> Okay. Will use the stack_arg_sp_adjust.
>>
>>> Looking at arch/arm64/net/bpf_jit_comp.c:590
>>> it doesn't use SP, so should it fine.
>>>
>>> and arm64 seems to work already?
>> I will take a look at arm64 as well.
>>
> Please also remove guards on tests to allow them to run on arm64, once it is
> handled properly.

Done. See
     https://lore.kernel.org/bpf/20260517150702.288031-1-yonghong.song@linux.dev/

No change is needed for arm64. It already can handle exception and stack arg's together.

