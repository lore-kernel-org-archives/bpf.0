Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FF3A2576;
	Fri, 10 Apr 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806578; cv=none; b=gKuIduQyZAS56vVGY3bo+lPVgx1vgGGvj/yC5hkY+2gB5ASSFT9BvZX9dItE20NKEMAfTZid8wSD3UzxCV3VIv/SK55QpWw7hyWqtr9wvc8ZoOusp+pmZ3vY91S2YzZfBANXMzJNUYlv0wZyxbfRhISYT+8Hkk6YMG8DD4xu6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806578; c=relaxed/simple;
	bh=GXk9eSKR2fAZhBNKaNkd1J00KOZhy7M9XAgU5JqznSw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aqZ0PdGq57t1lhyoxlI/8BT65qPW5nXi+MqR93rjHGXhKX6Z9kbWSo7JAK584C2q3VHynm0K8v2D8ECHX3JME6HBTPit9OgIQL1sXXCxQ2ZzrRTLkKfbvhKRvxL9vDlUXo2kCJMO8pNd5l7Dlc3PUAvmFHenUmnajkwls2Gg7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wvlqa6vG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvlqa6vG"
Message-ID: <d9c721c4-5054-4bc5-8af9-eaf83fb75c4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775806574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7LPlF2yQjMlJLqzmL4sSJ6Up/TuVse9elXtx20XvlA=;
	b=wvlqa6vG7thz21xi4WT2DnkXzdhc2/GwKK5SR36e/7GW+68h6ZsJ5+/xBqcIB/wFIjehTX
	NheczVyHCe8xcounMIlTtt8B5XR1BVQcjyTiZ8wQeeQn2iSxc3zdy5T3KiUC0ibB19mYZj
	dFS+G3gfkEom+LHF5bhWNdpb+GZHY9s=
Date: Fri, 10 Apr 2026 15:36:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in
 kernel_clone() via BPF fmod_ret on security_task_alloc
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 mattbobrowski@google.com, jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260410061037.149532-1-yangfeng59949@163.com>
 <20260410061037.149532-2-yangfeng59949@163.com>
 <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
In-Reply-To: <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/4/26 15:21, Leon Hwang wrote:
> On 10/4/26 14:10, Feng Yang wrote:
>> From: Feng Yang <yangfeng@kylinos.cn>
>>
> 
> [...]
> 
>> +
>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>> +{
>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>> +	 */
>> +	if (!check_non_sleepable_error_inject(btf_id) &&
>> +	    within_error_injection_list(addr))
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
>> +{
>> +	if (within_error_injection_list(addr) ||
>> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
>> +		return 0;
>> +
>> +	return -EINVAL;
>> +}
> 
> Why did you move them here? Seems that you didn't use them.
> 
>> +
>> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
>> +					  struct bpf_retval_range *retval_range)
> 
> NIT: code format issue here.
> 

Sorry about this. It is false. I was misled by thunderbird.

> Thanks,
> Leon
> 
>> +{
> [...]
> 

