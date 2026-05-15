Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C33F39FF
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867171; cv=none; b=rnAXgcJ474gF4/m02u/vYpKtgCtXsoUhHs0+zImaKO/f1lVasDsylv5RAaNEK4vw0UyXq+cWq4u6I+wZ1l463ddlXXIp9HFsfzEh4yU8iFRq+MR+S92f6MqrOlOz/BOkWCZuAMHmrbassqkDOx8OkoAQDiTpZ3uRHhhd4gPzEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867171; c=relaxed/simple;
	bh=xEo2BO1ioxpPF3nA8Kp8VT/ugq3fnBQGnnX9c0uWoDA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HDktDvDbiHwVD9BQqpARE/aa74C5D8srP194J7P1TxSN1pGTcnoVay/iCMrHz8nMjZLw6XRerr3Mf/MpZZ66zsF7Dl1NjANf1Y8DdeZyWlX+7McrpHRE1OC53lpcx0WRSyn5AT41r22HbY3mCav7bgd43no3ZTofyU1pNhFMg64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CnTRvV43; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CnTRvV43"
Message-ID: <20bb1a25-4b5b-4d92-8096-fbc325cdf88d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778867164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDCUI61NloXWC5/c0LqvvRCmngM2rOxuLUzEkoa/lNc=;
	b=CnTRvV431xlWe1BUJ5UO1btiOFiEu3tUFBbo2A30SgEeNuuywrSKvtwsh3Gbu00X6jS0BD
	ZQaJQpMZlfUDXaJoQ1QhTeP34wFUzkZDoL9d+tq4GXTQot7dLj9SztuXhKOObdgZFp01UQ
	2P/A1Pskh6udRqlqfBvZazjOL62eYA0=
Date: Fri, 15 May 2026 10:45:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH RFC bpf-next 2/2] selftests/bpf: Add LoongArch support for
 get_preempt_count()
To: Tiezhu Yang <yangtiezhu@loongson.cn>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260420111516.19982-3-yangtiezhu@loongson.cn>
 <20260420133532.4973DC2BCB4@smtp.kernel.org>
 <800726d7-7f09-40ee-a3ae-faf879364bdf@loongson.cn>
Content-Language: en-US
In-Reply-To: <800726d7-7f09-40ee-a3ae-faf879364bdf@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/20/26 5:47 PM, Tiezhu Yang wrote:
> On 2026/4/20 下午9:35, sashiko-bot@kernel.org wrote:
>> Sashiko AI review found 1 potential issue(s):
>> - [High] BPF programs including `bpf_experimental.h` will fail to compile on LoongArch due to a non-existent `thread_info` field in `struct task_struct`.
>> -- 
>>
>> commit 82453686fe5eacd9f219e2a050dc016b297cfc79
>> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> selftests/bpf: Add LoongArch support for get_preempt_count()
>>
>> This commit adds LoongArch support for get_preempt_count() in the BPF
>> experimental helpers. It enables bpf_in_interrupt() and related macros to
>> work properly on LoongArch systems.
>>
>>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>>> index e5c039bc44cb4..5847bbf12d240 100644
>>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>>> @@ -507,6 +507,8 @@ static inline int get_preempt_count(void)
>>>       return bpf_get_lowcore()->preempt_count;
>>>   #elif defined(bpf_target_riscv)
>>>       return bpf_get_current_task_btf()->thread_info.preempt_count;
>>> +#elif defined(bpf_target_loongarch)
>>> +    return bpf_get_current_task_btf()->thread_info.preempt_count;
>>
>> Will this compile successfully on LoongArch?
>>
>> Since LoongArch does not select CONFIG_THREAD_INFO_IN_TASK, struct
>> thread_info is allocated on the kernel stack rather than being embedded
>> within struct task_struct. Because of this, the generated BTF and vmlinux.h
>> for LoongArch will not contain a thread_info field in task_struct.
>>
>> Could this lead to a compiler error indicating that there is no member named
>> thread_info in struct task_struct when building BPF selftests?
> 
> As mentioned in the cover letter, it needs to apply the kernel patch
> "LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK" [1] before testing.

Hi Tiezhu,

I think it makes sense to include the selftests changes in the
series implementing CONFIG_THREAD_INFO_IN_TASK for loongarch [1].

With respect to riscv part of this, I suggest you drop it unless you
have the means to run the tests. Landing without any testing is silly.

Also I think you may drop the RFC tag. AFAIU you're trying to bring
loongarch to parity with mainstream arch-es, and that shouldn't be
controversial.

Thanks.

[1] https://lore.kernel.org/bpf/20260428072021.7289-1-yangtiezhu@loongson.cn/

> 
> [1] https://lore.kernel.org/loongarch/20260420102907.4617-1-yangtiezhu@loongson.cn/
> 
> Thanks,
> Tiezhu
> 

