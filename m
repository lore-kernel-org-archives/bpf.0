Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1422FB965
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533116; cv=none; b=KBBpLZxjxSRm+sHrbm44vPYCaPI93NteOc4ug2so0rHKk9AGRvoj8ppCc8tDveIjnWRNwTAsA3L7IO0TqVlutV9I8G4ZPN2u1OqkB/rtGFSvCO++IL1k4CJQ8bwLCOpBeJsAlfAc+n+KUPt1tJoKxFXJs3sSgnSH9H250e6LZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533116; c=relaxed/simple;
	bh=zSiepFFy3ANzOwfIDHUvMV8TppJoHC+9SYbe44N1xK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIrYplTW7tAqAPxdGl/Jw9VLj79ZAIzo/6VuCzr5BVmNl80IAK9iyRaKQH1rW14/zGzVxmDTQRQL20ewdTBZQ6vAPH0iCQ3cyG2iX6k30lZiUm0f9sgNm7o5ppR6QLzoWAntxViPk9sfZ89I+ZhpCpLQs7V0Ma9Kzwk0by+8w9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTPOJb+D; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oTPOJb+D"
Message-ID: <b98fbda5-1751-4fea-8fc7-587b52aa787a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776533111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwGizqp+7EvMVR/LBDajxWv4r9t2sVBnhf2I/zpaHoU=;
	b=oTPOJb+Diy5K4rVlOKwLXJGWd9IZwuNrMCUvIxkWO12gjsYLZaBvcy+1C6YW4UFBj/MBdk
	95eaFCbsE6KgVZcGRF0RCCfN2dJP8JdysGANWxDLo4Swct4Oi/77lVpZu63fmpADKkhHlB
	l2ER4qV/tjqpD0lCtZPYHAQckUqKDYQ=
Date: Sat, 18 Apr 2026 10:24:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 10/16] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034749.2630580-1-yonghong.song@linux.dev>
 <567ac7cd59c86c94cb33ef18e4e39dec988bf6ef968301ee359f6ee401cbbedf@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <567ac7cd59c86c94cb33ef18e4e39dec988bf6ef968301ee359f6ee401cbbedf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 6:04 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Reject stack arguments if tail call reachable
>>
>> Tailcalls are been deprecated. So reject stack arguments
> This isn't a bug, but there's a grammar error: 'are been' should be
> 'have been' or 'are being'.
>
> The commit message states that "Tailcalls are been deprecated." Is this
> claim accurate?
>
> Based on earlier mailing list discussion, the restriction exists because
> tail calls and stack arguments require incompatible stack frame handling,
> not because tail calls are being deprecated.
>
> Could the commit message be more precise about the actual technical reason
> for the restriction?

Stack arguments and tail calls CAN work together. However, since tail calls
are in deprecation stage, it is not worthwhile to involve stack arguments
and tail calls together.

I will keep commit message as is.

> This commit appears to fix a bug but lacks a Fixes: tag. The suggested tag
> would be:
>
> Fixes: 13ee5d67a7c9 ("bpf: Support stack arguments for bpf functions")
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 7a65b532e84a..739c3127520c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5662,6 +5662,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   				verbose(env, "cannot tail call within exception cb\n");
>>   				return -EINVAL;
>>   			}
>> +			if (subprog[tmp].incoming_stack_arg_depth ||
>> +			    subprog[tmp].outgoing_stack_arg_depth) {
>> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +				return -EINVAL;
>> +			}
>>   			subprog[tmp].tail_call_reachable = true;
>>   		}
>>   	if (subprog[0].tail_call_reachable)
> When the DFS traversal in check_max_stack_depth_subprog() pops a frame to
> return to the caller (moving from a child subprogram back to its parent),
> is the tail_call_reachable variable reset to false?
>
> Looking at the code, tail_call_reachable is initialized at the function
> start but appears to persist across the entire traversal. Consider this
> scenario:
>
> 1. The verifier traverses a subprogram that contains a tail call, setting
>     tail_call_reachable = true
> 2. The traversal returns to the parent (pops the frame via idx =
>     dinfo[idx].caller)
> 3. The traversal then visits a sibling subprogram that uses stack arguments
>
> In this scenario, wouldn't tail_call_reachable still be true from step 1,
> causing the check in the new code to incorrectly reject the sibling
> subprogram even though it has no tail calls in its own call chain?
>
> This could cause false positive rejections of valid BPF programs where one
> subprogram uses tail calls and a completely unrelated sibling subprogram
> uses stack arguments.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

