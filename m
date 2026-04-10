Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAA3AB286
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809716; cv=none; b=NUHNEHOaWw54To/l2c18gXSTHA0YU98GKNz5WsqMIZpfvZ7SH40YEk+3IrNP4uKNbj1K9mnwvptddiFGztKK1/OZsIcmJ6eQaBRcj8g8r3eiqUV7CbSu7QHq3Gw3qoUmTKiq8kYV9G+9jHpNfKd3G+nJ7YQxbOYmph7goIqUSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809716; c=relaxed/simple;
	bh=gE4lFkwrEKvSeJ6XQ+Z6uIsAJEH9uGA9CYINV6kvaSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZapQqZXU1T57JY9uxfcQZcn8daLmkHsMHS5ZNCh1hcUHKVH8TPfvRRfxIE1YPMQHe90DS8htDWyUAVDzusPK6Nl6MUoxjyk3ziGqdb2Xvz8rj5PruJK0T7tCA9l2pAIyHcWBnD2uoTYEzfHbWRxZjAGU6z9WbJCWkqlXsJfL30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfsXVOLa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfsXVOLa"
Message-ID: <28ead0fc-7bd1-462e-a31a-6464d15618cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775809702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZxl2XX58g/sb6s0KAApLQ4EPBEmfJaBHw9XfaoDL0c=;
	b=dfsXVOLagKg6a1W2bBco/2RG7fZodGrVYKXZw2DYC/zE1WiD43QMQq/C0Ls3Ckvba6Pb5V
	8U91HH+bzEgryAgB17sjZ+0bMvqw+1JmJs78s/5ZN2PIO5ypKrowuVnhyW+WVkHr8PcUyA
	4RQ9qE685u4bXgS0XyqaeJRRQQccH9I=
Date: Fri, 10 Apr 2026 16:27:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in
 kernel_clone() via BPF fmod_ret on security_task_alloc
Content-Language: en-US
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jiayuan.chen@linux.dev,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@linux.dev, mattbobrowski@google.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev
References: <20260410061037.149532-2-yangfeng59949@163.com>
 <20260410080335.196379-1-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260410080335.196379-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/4/26 16:03, Feng Yang wrote:
> [...]
>> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
>> +					  struct bpf_retval_range *retval_range)

How about 'range' instead of 'retval_range' like its caller?

>> +{
>> +	unsigned long addr = (unsigned long)prog->aux->dst_trampoline->func.addr;
>> +
>> +	if (within_error_injection_list(addr)) {
>> +		switch (get_injectable_error_type(addr)) {
>> +		case EI_ETYPE_NULL:
>> +			retval_range->minval = 0;
>> +			retval_range->maxval = 0;
>> +			break;
>> +		case EI_ETYPE_ERRNO:
>> +			retval_range->minval = -MAX_ERRNO;
>> +			retval_range->maxval = -1;
>> +			break;
> 
> This refers to the documentation in fault-injection.rst:
> 
> Each error injectable functions will have the error type specified by the
> ALLOW_ERROR_INJECTION() macro. You have to choose it carefully if you add
> a new error injectable function. If the wrong error type is chosen, the
> kernel may crash because it may not be able to handle the error.
> There are 4 types of errors defined in include/asm-generic/error-injection.h
> 
> EI_ETYPE_NULL
>   This function will return `NULL` if it fails. e.g. return an allocated
>   object address.
> 
> EI_ETYPE_ERRNO
>   This function will return an `-errno` error code if it fails. e.g. return
>   -EINVAL if the input is wrong. This will include the functions which will
>   return an address which encodes `-errno` by ERR_PTR() macro.
> 
> EI_ETYPE_ERRNO_NULL
>   This function will return an `-errno` or `NULL` if it fails. If the caller
>   of this function checks the return value with IS_ERR_OR_NULL() macro, this
>   type will be appropriate.
> 
> EI_ETYPE_TRUE
>   This function will return `true` (non-zero positive value) if it fails.
> 
> Restrict EI_ETYPE_ERRNO to only return error codes.
> However, it was noticed that the self-test bpf_testmod_test_read uses 
> ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO); and returns 0, which causes a failure.
> So should returning 0 be considered valid for the EI_ETYPE_ERRNO type, or should the self-test be modified instead?
> 
I think it would be better to add such explanation in code comment.

Thanks,
Leon

