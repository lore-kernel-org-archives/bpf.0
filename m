Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497037C900
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602789; cv=none; b=knAeVL3qgHuU3/lrNraBD+EKGe0/7Zl9fV0UuDhRPf/N6/u5jl2GYyDyub9cdE8xQffD3TmL7MeaR4oOpabrQ3vwyraH2yoj2y8FDjzSBurPMHj7BiCugm3cEUz31XXzQEKjdwbS4Vh4/iifg7qMmtbn/n+FCzyeNN68lyrNoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602789; c=relaxed/simple;
	bh=dd5rpigs8f/4x3ODO9ldllk8EvDxjO0sd65Ja1LqU74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSRfxas+hU7douBVhKz2kxeaBKv6nKCCbp0/NKOG/xo/XdfMMyhmGKaY0B+GL6mnCAUlIWLfEXMX2eQ0T/1DDEL4zwL61ROxxmuB78iXlvYg9hy/ompY7GXCZw2Vor8PbHVGAIfY6VMWg4U/ra7b6f823E/ksZiTjD6xL2tpSQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLub8a+3; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLub8a+3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dd5rpigs8f/4x3ODO9ldllk8EvDxjO0sd65Ja1LqU74=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791602784; v=1; x=1792207584;
 b=LLub8a+3FFpEilN9inRcR9sE1mM+7AjfVNtMtVZ/939dcZRP7S2dlfWtX4sI4LrF5gjJ3+s2
 xrZBCJ51PW0EmVVd7qkJQzEcEpCIUYQhl34nZIZNPv+wO49QQD1g4dJq+LZbFSE+yNSWoCb8di4
 A5yTC3U+KXAU066xnJ96fKy0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9c20416fa2a6921;
	Sat, 10 Oct 2026 03:26:24 +0000
X-Mizu-Trace-ID: c9c20416fa2a6921
X-Migadu-Flow: FLOW_OUT
Message-ID: <75475cb1-7f53-499a-8eb5-3b9a9dec6fd2@linux.dev>
Date: Fri, 9 Oct 2026 20:26:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 07/11] bpf: Introduce REF_TYPE_FRAME in the
 verifier
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
 <20261009202759.50520-8-ihor.solodrai@linux.dev>
 <sashiko-outbox-166059@kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <sashiko-outbox-166059@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-09 1:48 p.m., sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] bpf: UAF due to dropped parent_id in dynptr_from_mem for frame-scoped args
> --
> 
> commit 19d3a1bd15552653b24ece884c759a788c6abaf9
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Introduce REF_TYPE_FRAME in the verifier
> 
> This commit introduces REF_TYPE_FRAME to track references owned by a callee
> frame. It allows a set_callee_state_fn to anchor an argument to a reference
> which is dropped when the frame is popped.
> 
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index c51083c761cf2..54a4f440c33b3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -272,15 +272,13 @@ struct bpf_stack_state {
>>   };
>>   
>>   struct bpf_reference_state {
>> -	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
>> -	 * default to pointer reference on zero initialization of a state.
>> -	 */
>>   	enum ref_state_type {
>>   		REF_TYPE_PTR		= (1 << 1),
>>   		REF_TYPE_IRQ		= (1 << 2),
>>   		REF_TYPE_LOCK		= (1 << 3),
>>   		REF_TYPE_RES_LOCK 	= (1 << 4),
>>   		REF_TYPE_RES_LOCK_IRQ	= (1 << 5),
>> +		REF_TYPE_FRAME		= (1 << 6),
>                  ^^^^^^^^^^^^^^
> 
> [Severity: Critical]
> Does this new reference type get ignored when the verifier checks if a register
> is referenced?
> 
> In kernel/bpf/verifier.c, find_reference_state() explicitly skips any
> reference type other than REF_TYPE_PTR:
> 
> kernel/bpf/verifier.c:find_reference_state() {
> ...
> 	for (i = 0; i < state->acquired_refs; i++) {
> 		if (state->refs[i].type != REF_TYPE_PTR)
> 			continue;
> 		if (state->refs[i].id == id)
> 			return true;
> 	}
> ...
> }
> 
> Because find_reference_state() ignores REF_TYPE_FRAME, reg_is_referenced()
> returns false for frame-scoped arguments.

Yes, this is intentional.

> 
> Could this lead to a regression if a callback passes a frame-scoped reference
> (like a PTR_TO_MAP_KEY array key or ringbuf dynptr slice) to a constructor
> like bpf_dynptr_from_mem() to create a local dynptr?

No, bpf_dynptr_from_mem() accepts only PTR_TO_MAP_VALUE.
check_helper_call() rejects other types:

	case BPF_FUNC_dynptr_from_mem:
		if (regs[BPF_REG_1].type != PTR_TO_MAP_VALUE) {
			[...]
			return -EACCES;
		}
		break;

> 
> When check_helper_call() processes the constructor, reg_is_referenced()
> returns false, which leaves meta->ref_obj.id as 0:
> 
> kernel/bpf/verifier.c:check_helper_call() {
> ...
> 	if (reg_is_referenced(env, reg))
> 		update_ref_obj(&meta->ref_obj, reg);
> ...
> }
> 
> Later, mark_stack_slots_dynptr() sets the dynptr's parent_id to this 0:
> 
> kernel/bpf/verifier.c:mark_stack_slots_dynptr() {
> ...
> 		/* Track parent's id if the parent is a referenced object */
> 		parent_id = ref_obj->id;
> ...
> }
> 
> This strips the dynptr of its frame-scoped lifetime tie. When the callback
> exits, release_frame_references() won't invalidate the dynptr because its
> parent_id is 0.
> 
> Can the caller then extract a pointer from the dynptr using bpf_dynptr_data()
> and access memory after the callback frame is destroyed?
> 
> Is it possible that pointer cast functions like bpf_skc_to_tcp_sock() also
> suffer from the exact same logic flaw because they rely on
> find_reference_state(..., meta.ref_obj.id)?

No, bpf_skc_to_tcp_sock() requires ARG_PTR_TO_BTF_ID_SOCK_COMMON. Its
compatible register types, listed in btf_id_sock_common_types, exclude
the frame-scoped arguments introduced by this series.

> 

