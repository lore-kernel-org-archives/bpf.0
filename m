Received: from mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCE3B71D6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564683; cv=none; b=kiTeB0FWcpotG2+cfXL6MT6PZvMylYQONTuIjG4RiwBL9nnvxJcfwFuT6FAHbXUgpG3BC6boXs9SrzL9Oit2+vQXDIo/8ndJOU2eSiWvcolwCj9QNKj2Ezl2o5SD/8f8EemGd1v2EpwKEa9MEsRJb7IOwsldeqzie/8yglJn2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564683; c=relaxed/simple;
	bh=tte+tOazSKFbgiuBdk0SlwZ7ABZperORPF00Son0gpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6JtHtPttAprHRgUk0HAQ5AbsdQJWhoJmStPF8gv4MVerBgNeKG21Ss3SgGBf31pUbAuWbJQKQVcHMdXPBaJrPehrCQShsgMWbQZ4GgzrRNvVwoeSqyy111EkN2uRS+CaZrGzyaEzr90q/btCT0OqLB7pCZc9S9W77mpw4KnSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqDSdyJT; arc=none smtp.client-ip=91.218.175.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqDSdyJT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tte+tOazSKFbgiuBdk0SlwZ7ABZperORPF00Son0gpw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791564679; v=1; x=1792169479;
 b=pqDSdyJT/zLm/ZWB8ZyzJDB+U+hCymDoHZfXTtvRCxfnuzJ+5w/LBufCw0gfFahAduR4tk7b
 dCigFXkXkIUAUJrccthxHKVJ7LLNTTOSRp/CiOSDoLFN3ds32GP2mR6mIqevb6EqtFFFsMZW33K
 RO7ks+9s1/Xx77zwlh8l8zto=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0d2a5a1f762400ce;
	Fri, 09 Oct 2026 16:51:18 +0000
X-Mizu-Trace-ID: 0d2a5a1f762400ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <9bdd26b6-9c31-4dc5-bcc3-6484a45f9dac@linux.dev>
Date: Fri, 9 Oct 2026 18:51:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 14/24] bpf, x86: Dispatch exception cleanup
 pads at run time
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041559.31116-1-yonghong.song@linux.dev>
 <sashiko-outbox-164841@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164841@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/26 6:32 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: Exception unwinder cleanup pad executes in caller's stack frame context
> --
>
> commit 9d03eddc4bc6be397e72d866390a80929337af59
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, x86: Dispatch exception cleanup pads at run time
>
> Add what bpf_unwind() relies on to send each frame of a program to its
> landing pad or its epilogue on x86-64. This includes arch_bpf_stack_walk_ra(),
> aux->epilogue_ip assignment, and bpf_exc_fill_native_ranges() call.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 083fcd6cf15b7..d434871b5a11c 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -3279,6 +3280,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   			seen_exit = true;
>>   			/* Update cleanup_addr */
>>   			ctx->cleanup_addr = proglen;
>> +			/* Where an unwind sends a frame with no pad. */
>> +			bpf_prog->aux->epilogue_ip = (u64)image + proglen;
>>   			if (bpf_prog_was_classic(bpf_prog) &&
>>   			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
>>   				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
>>   					return -EINVAL;
>>   			}
>>   			/* Deallocate outgoing args 7+ area. */
>>   			emit_add_rsp(&prog, outgoing_rsp);
>>   			if (bpf_prog->aux->exception_boundary) {
>>   				pop_callee_regs(&prog, all_callee_regs_used);
>>   				pop_r12(&prog);
>>   			} else {
>>   				pop_callee_regs(&prog, callee_regs_used);
>>   				if (arena_vm_start)
>>   					pop_r12(&prog);
>>   			}
>>   			EMIT1(0xC9);         /* leave */
>>   			bpf_prog->aux->ksym.fp_end = prog - temp;
>>   
>>   			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
> [Severity: High]
> Does this execute the cleanup pad in the wrong stack frame context?
>
> During exception unwinding, arch_bpf_stack_walk_ra() walks the stack and
> yields the return address pointer (ra) for the current frame N, which
> points to the instruction in frame N-1.
>
> In bpf_unwind_rewrite(), *ra is overwritten with the address of frame N's
> cleanup pad or epilogue_ip:

We should be okay. Here, the address is from frame N-1 and the address is
filled in frame N. Not as in the above mentioned that the overwritten with
the address of frame N's cleanup pad or epilogue_ip.

>
> kernel/bpf/helpers.c:bpf_unwind_rewrite() {
>      ...
>      rec = bpf_exc_pad_for_ip(prog, ip);
>      *ra = rec ? rec->pad : prog->aux->epilogue_ip;
>      ...
> }
>
> This forces frame N to jump to its cleanup pad when it returns.
>
> However, the JIT epilogue executes "leave" before "ret". The "leave"
> instruction completely tears down frame N's stack and restores frame N-1's
> stack pointer and frame pointer.
>
> The "ret" instruction then pops the modified return address and jumps
> to frame N's pad. As a result, the pad executes while frame N-1's context
> is active.
>
> Can this cause any stack accesses inside the pad (using rbp, mapped to r10
> in BPF) to incorrectly access frame N-1's stack variables, leading to
> memory corruption, use-after-free, or garbage reads during cleanup?
>

