Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA71382376;
	Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807368; cv=none; b=K5yp3eaFkJ628r0y4fRlf0vB0OMAfkEsZwDFW7K+DohPBIxm5OvecWwtHqBYRqbmQDIUw8Hdvne5eFOdQM339Lu0Sck7UqU8/23WZGp6Pc+oIomr5k7kUGllZBwMCt/hCeLRO3Nj9NUhYxTs9YMYVxSpPiv6Coq62QXHr8ssFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807368; c=relaxed/simple;
	bh=uaJFwjdRmpFN/xI3cisi1DaPKIKpl3UvzXNtHT0bvow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmYS8s5voIbJ0xutDrsk424CNgDQfm44aIfJZqO3c3Z0S948kB4uu+7e2OEOnDE7g1LJh2Ns8EBTb72p3pk9i/S3vJA4xEK9crL+qORmEug0xcHDMNxwvkJV+ljAea68576pWYthSENuryBe39MGU+gM2brvYGDBOxcn2zFBXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPwEGgXx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPwEGgXx"
Message-ID: <8fd076d2-af88-4e35-8009-797132511063@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775807364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuXmWc7VPa/96/GMK6oj/uTrk9w1IxAFjk3Dw9LK8Bw=;
	b=aPwEGgXxL9rOoa/yN6knkZRlgLFpZlEDdUvs8lj3a2W7OBNPv5q5TrGSZGfDR2sfg/JKgt
	vJjck9y56ahjOpMfxiidZyVcok9YliM7Jar1xD9gW5ePGjr6YacQWv12SWU46rNRa1lcXz
	xnUrRZuwbwpzqytkqcOzUXHDYK2Ux/w=
Date: Fri, 10 Apr 2026 15:49:15 +0800
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
 song@kernel.org
References: <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
 <20260410074039.187816-1-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260410074039.187816-1-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/4/26 15:40, Feng Yang wrote:
> On Fri, 10 Apr 2026 15:21:26 +0800 Leon Hwang wrote:
>> On 10/4/26 14:10, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>
>> [...]
>>
>>> +
>>> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
>>> +{
>>> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
>>> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
>>> +	 */
>>> +	if (!check_non_sleepable_error_inject(btf_id) &&
>>> +	    within_error_injection_list(addr))
>>> +		return 0;
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
>>> +{
>>> +	if (within_error_injection_list(addr) ||
>>> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
>>> +		return 0;
>>> +
>>> +	return -EINVAL;
>>> +}
>>
>> Why did you move them here? Seems that you didn't use them.
> 
> Because CONFIG_FUNCTION_ERROR_INJECTION is directly reused here,
> and the function has_arch_syscall_prefix is intended to be used.
> 

You can declare the function instead. No?

But, the function has_arch_syscall_prefix was not used in your new code?

Thanks,
Leon

