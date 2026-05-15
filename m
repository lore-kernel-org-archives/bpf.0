Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60E3B19DE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862798; cv=none; b=CN0DrFV584o89724KzLdEt8AoChWfSQ2efutLskrxJCGPXcGFmktXEe9xv29l63yV6t2djxRLqHfwZCiXit6OmrOW+GV0woxmD3+S/cJxV/ek3LGMxCDaf1DYUTHLgHlX4eirxLx0tHxrw05C2VaH326xqU6nzlq9w8qPRGjWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862798; c=relaxed/simple;
	bh=IlGixFbfRDoV12DNI4ZX35ww/iI+9lcKpkhf85RaDHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9qJWy/F/iUfXJZqA8FHKA1p46BcwzzN5WxMntzJykxMoHOP2tw/TQPWP8CsIf26XFTyM0vGSv//6ZOKdAdcnYVO/cpOnbAKqx1MZ4dNj43Vs2RbcavcrAve0TdZDHrpcaA/7y/La/1CmdWRWrreUEZTbfFy2abvhYC9pxL95kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kAQmDMxx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kAQmDMxx"
Message-ID: <fbc29c8b-be9d-49ec-8ade-c79a9efe7ecd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778862793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drp7QNKaM6BxsdAfgd/PjwZpYiyRLNLMpP06rVSJC9I=;
	b=kAQmDMxxtBnPAgbyyx3j75Q8ZD9POm+WmcNn0hnkTpuzqXddHVkEyR8Y5AhSPz0H2Rt4bu
	3/XzeZi+VnMOmHVYwtfvz6bwv4ILjymZ4pYuSiZB+klB8WEGKvtJxU5Z0J5ABnxMA5P1kG
	BV66yqujFIDOlS3vbBMC96VsPlYPlhU=
Date: Fri, 15 May 2026 09:33:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 12/25] bpf: Prepare architecture JIT support
 for stack arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260513045054.2390945-1-yonghong.song@linux.dev>
 <20260515003033.57358C2BCB3@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260515003033.57358C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 2:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Returning `-EFAULT` for an unsupported JIT feature causes a misleading syscall error.
> --
>
> commit 468549a72b25192a0a4df32e6475b6634931dde6
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Prepare architecture JIT support for stack arguments
>
> This commit adds bpf_jit_supports_stack_args() to allow architectures to
> indicate support for stack arguments. It rejects BPF functions with more
> than 5 parameters at verification time if the architecture lacks this
> support.
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index ec3fb8c8f4eef..3d8080eba5445 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -7886,8 +7886,14 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   			MAX_BPF_FUNC_ARGS, tname, nargs);
>>   		return -EFAULT;
>>   	}
>> -	if (nargs > MAX_BPF_FUNC_REG_ARGS)
>> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +		if (!bpf_jit_supports_stack_args()) {
>> +			bpf_log(log, "JIT does not support function %s() with %d args\n",
>> +				tname, nargs);
>> +			return -EFAULT;
> Does returning -EFAULT here cause a misleading error for userspace?
>
> The function documentation states that -EFAULT is reserved for internal
> verifier bugs to abort verification, while unsupported features or invalid
> arguments typically return -EINVAL or -EOPNOTSUPP (which is used elsewhere
> in this function for unsupported type tags).
>
> Since returning -EFAULT propagates to the bpf() system call and typically
> indicates a bad address, it might confuse userspace loaders like libbpf.
> Would -EINVAL or -EOPNOTSUPP be more appropriate here?

-EFAULT here is necessary. Otherwise, later on, the verification/jit will
proceed and it may cause incorrect results. Note that -EINVAL/-EOPNOTSUPP
won't prevent further verification/jit.

>
>> +		}
>>   		sub->stack_arg_cnt = nargs - MAX_BPF_FUNC_REG_ARGS;
>> +	}
>>   
>>   	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
>>   		bpf_log(log, "global function %s has %d > %d args, stack args not supported\n",

