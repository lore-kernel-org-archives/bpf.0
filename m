Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E24362133
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 05:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660071; cv=none; b=Fz2fl/TxiUDGCYqsYmLFPrXi48MZPnidKlhAp4xfOY4XAAsBBuuyQ63TSci+ZhzeakbQUWfkuJPI/h6MWozxb+yqmtSelGovAiOuOyViDXp4V/MgGHIAldmS/DjLUlQteTts0zLkB9vCpRWi6hJnHNVob5znLdzmPalgrVuOYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660071; c=relaxed/simple;
	bh=qmAhORncCqlDELzyg1dAzDeCtszb+slYEusDi5zdwmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzwHM/yb6BtIN1g6ED2+qzkHAnJZ2Wi+44hr98aDkCxzu5YIzpA0Uw9qvObf9f1kfPVaOIewz9Mk+6KTiqn3QO4q/xYlup2L1A+xZW0pu4WV1W4HhGxZl0TLUEVqpolABNytBECPdJFG7tTMZXux0XtCPVMGtWwSulN4HLBulJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPThhYkJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPThhYkJ"
Message-ID: <e9edcf6c-de35-44f2-b835-3206bd4e6109@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783660067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YC8+hcGtP9KfCJINuRXcNx9Vn7G7d5hms6jjH60ddwg=;
	b=qPThhYkJTRiBIXDDYHv0mBu5UjV2o1hbWxKFzvNRxL74ByKlgBZzMPohVAl7qyh0hkoZF4
	n1nOSBL9YX4/9SZpCObb0BbVyq7QkfBUwGL90phTVIwtfx3vPmEN+G57wAMEynYMFD58Qy
	PNXkkSmT4ITl42WMDI9DGjf9kA48kJ8=
Date: Thu, 9 Jul 2026 22:07:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the
 R0:R2 register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <20260708201010.2158718-1-yonghong.song@linux.dev>
 <d4ec45ab714f14870749f5ada1afe44fea49a83c.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <d4ec45ab714f14870749f5ada1afe44fea49a83c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 1:30 PM, Eduard Zingerman wrote:
> On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 73dc3ee879de..819a97d25173 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2676,7 +2676,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>   		goto finalize;
>>   
>>   	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -	    bpf_prog_has_kfunc_call(fp))
>> +	    bpf_prog_has_kfunc_call(fp) || fp->aux->ret_reg_pair)
> This has a conflict with one of the very recent bpf-next commits.
> While reading locally I fixed the conflict by removing this hunk
> and adjusting bpf_ret_reg_pair_mark() as below.

Indeed, once jit_required is available in fp->aux, I can remove
ret_reg_pair things.

>
>>   		jit_needed = true;
>>   
>>   	if (!bpf_prog_select_interpreter(fp))
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index fcbf532159a5..ca8b2f436c20 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -453,6 +453,15 @@ bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>>   	return false;
>>   }
>>   
>> +static bool bpf_ret_reg_pair_mark(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	if (!bpf_ret_reg_pair(env, subprog))
>> +		return false;
>> +
>> +	env->prog->aux->ret_reg_pair = true;
> Added:
> 	env->prog->jit_required = true;
>
>> +	return true;
>> +}
>> +
> You probably would want to do the same in v2.
>
> [...]

