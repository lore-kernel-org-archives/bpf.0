Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42223655CC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863327; cv=none; b=cJZJnztYE8HtHR09Uu0GKM4/5Oq6QuNhEjI0UYE0vbg86qFl4V5jX2Dmf68w6L+ThzXQ5DfDayyPpvQrshm8dcW/anCS+FWaCjOkmvTsuMK9UDokh2lMgZpkElgiXRM9YVMucx8UTmaSlgXg34I+Tbn0sTItz0SweuV0QSE6N/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863327; c=relaxed/simple;
	bh=62drjeh5dhAX/g/y6JkPlxuQsyJVC0xvC0LkIPsZR7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+5VN8WocMWLFtiUq4r+YycYmkE6bOIlWMqiBgxgLEDJsltztJ2VMWw0vp4bA5iVb1tU2KHcdR5W8SFuQIGueADkiHQUODawlUYQfjnwNxhbX3GpcN5eTxRFpSs/6DrUZuSpS8lg1Ni3zUBKclgu08+HiRHeT+tfflxoX9+LkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZLO+/dkx; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZLO+/dkx"
Message-ID: <26e1b9f7-e504-4d32-9558-91efcf21b69a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778863323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foXbL4lx3pZAD18PZXJ65fNyqmyO/YG6ferThXGW978=;
	b=ZLO+/dkxm7udcXF6eM4qpTCa1F3qLYYv/MFmTsyeIP+KvieAF7r42DaDQ3nF9PBKq9InUY
	jo2umvAZOI1hjHVxCmC636APv+rmfdGLobPGEEzQUR0IcysCqbAWWhjWR2JlmvBcGf4eJD
	FANY33blPVIY3x/e2MboAAA3MP1Vz00=
Date: Fri, 15 May 2026 09:41:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 16/25] bpf: Disable private stack for x86_64
 if stack arguments used
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045114.2392291-1-yonghong.song@linux.dev>
 <20260515052828.B53C0C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515052828.B53C0C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 7:28 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Hardcoding architecture-specific JIT register limitations into the generic BPF verifier.
> --
>
> commit d388190c12c82279caa212e6edeefb82d873dd00
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Disable private stack for x86_64 if stack arguments used
>
> This commit disables private stack support on x86_64 when stack arguments
> are used, because x86-64 uses R9 for both the private stack frame pointer
> and arg6. Other architectures have enough registers to support both.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 47df3f40a71cf..745e13cfb54d6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5163,7 +5163,10 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>>   	}
>>   
>>   	subprog_depth = round_up_stack_depth(env, subprog[idx].stack_depth);
>> -	if (priv_stack_supported) {
>> +	if (IS_ENABLED(CONFIG_X86_64) && subprog[idx].stack_arg_cnt) {
> Is it appropriate to hardcode host architecture macros like
> IS_ENABLED(CONFIG_X86_64) directly into the core verifier logic?
>
> This isn't a bug, but it introduces architecture-specific constraints into the
> generic BPF verifier. Would it be better to handle this by querying JIT backend
> capabilities via a generic API (e.g., passing stack argument requirements to a
> JIT capability checker) so the verifier remains architecture-agnostic?

Disabling private stack support in verifier sounds better. We do have
two cases of '#ifdef CONFIG_X86_64' in verifier.

>
>> +		/* x86-64 uses R9 for both private stack frame pointer and arg6. */
>> +		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
>> +	} else if (priv_stack_supported) {
>>   		/* Request private stack support only if the subprog stack
>>   		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
>>   		 * avoid jit penalty if the stack usage is small.

