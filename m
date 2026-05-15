Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBB3321A7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863221; cv=none; b=IQbtJLiiB5ciPC7r5dkvcqHI3+Som++bIiIEY/MW8bkBDRSWWUKzxUCNsS407xQr77v0prTkyfN2+ZxfousyFWGU+op8E1gQjkAOLNEvvW25XpR8pSn0fMOfh06elnoLAdRVEa9dXdJGJmK9+ntF/bPxfKjsP8zt/ZvIMcQUwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863221; c=relaxed/simple;
	bh=vfptBbJElZ3Op7RaU6ED5TpNfMzlrdsbJQRKcutL+3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coD0N9FripxD3IVDRtZ6LxynBAhHWPbu7efz+wH7e49SLr0wMZfXRP81jsEiXORaNf2zsYvinqv3iTPaZGuhIWv1RzUVcXKIermcML11SjeCuid6CqDl4zLY3foeM2/F0EdpPw0egyVNR8w1jeulwrm+oJe80mnkhhePMKQCsFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amTkad5a; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amTkad5a"
Message-ID: <862c4eb6-c1ba-4570-beda-2baaec63d904@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778863207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ELEz5GLh6Ex/92yMj17L1f58o+Y+p7rGA5o60AYmfc=;
	b=amTkad5aVcPB6UGHqSnCEyHZdgGITW04bXtwlTCM1B91i4GfFmwFERiXPOwvE289PiooTl
	EpGbg5k+kCAECWO8oNjOhzKUJcFO0lpmuUIqflTCJXSdP84ufeLkjUEvAaYvykylF0xNHJ
	dLvW5dz52xmW+IGXWHaEkPTR/GYMirY=
Date: Fri, 15 May 2026 09:39:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 15/25] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045109.2392108-1-yonghong.song@linux.dev>
 <20260515032335.C4FE4C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515032335.C4FE4C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 5:23 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Order-dependent verification allows invalid programs combining tail calls and stack arguments to bypass checks.
> - [High] Exception and async callbacks bypass the new stack argument and tail call restriction.
> --
>
> commit 807349b213e40b7418c45dc1ae2cee5695bf101d
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments if tail call reachable
>
> This patch updates the BPF verifier to reject programs that combine tail calls
> with stack arguments, as tail calls are deprecated. It hooks into the call
> depth traversal to fail verification if stack arguments are present in a
> call chain that can reach a tail call.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a363811aec7a0..47df3f40a71cf 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5267,14 +5267,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   	 * this info will be utilized by JIT so that we will be preserving the
>>   	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>>   	 */
>> -	if (tail_call_reachable)
>> +	if (tail_call_reachable) {
>>   		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>>   			if (subprog[tmp].is_exception_cb) {
>>   				verbose(env, "cannot tail call within exception cb\n");
>>   				return -EINVAL;
>>   			}
>> +			if (subprog[tmp].stack_arg_cnt) {
> Can this check be bypassed depending on the order of subprogram calls?

No.

>
> If a main program calls subprogram A (which uses stack args) and then
> subprogram B (which has a tail call), it seems subprogram A might be
> evaluated first when tail_call_reachable is false, bypassing this check.
>
> When subprogram B is evaluated, it sets tail_call_reachable to true,
> which propagates to the main program.
>
> When the main program finishes, only the main program's stack_arg_cnt is
> checked, allowing the program to pass verification.

But in this case, main program stack_arg_cnt is not 0, so -EINVAL will return.

> If the calls were reversed, subprogram A would inherit the true state and
> be correctly rejected.
>
> Does this sequence allow invalid programs to bypass the safety check?
>
>> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +				return -EINVAL;
>> +			}
>>   			subprog[tmp].tail_call_reachable = true;
>>   		}
>> +	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt) {
> Does this fallback check miss exception and async callbacks?

This check does not deal with exception and async callbacks.

>
> By explicitly checking !idx and subprog[0], it appears to assume the main
> program is the only call graph root.
>
> Since exception and async callbacks are verified independently as their own
> root programs (where idx > 0), would a callback that contains a tail call,
> uses stack arguments, and makes no BPF-to-BPF calls bypass both the primary
> tail_call_reachable check and this fallback check?

As far as I know, callback and exception prog are not allowing tail call.
For example:
                 if (subprog[sidx].is_async_cb) {
                         if (subprog[sidx].has_tail_call) {
                                 verifier_bug(env, "subprog has tail_call and async cb");
                                 return -EFAULT;
                         }
			...
		}

...
         if (tail_call_reachable) {
                 for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
                         if (subprog[tmp].is_exception_cb) {
                                 verbose(env, "cannot tail call within exception cb\n");
                                 return -EINVAL;
                         }
			...
		}
	}

>
>> +		verbose(env, "tail_calls are not allowed in programs with stack args\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	if (subprog[0].tail_call_reachable)
>>   		env->prog->aux->tail_call_reachable = true;

