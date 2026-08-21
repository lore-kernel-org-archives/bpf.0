Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677592AEEB
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355498; cv=none; b=FFWfKSnPAx0jWj4UxwVglCf9rBFU8YHhMt4yccVKjBVXi6VLPBrT54n0VUP8wQJyLYPs5tk3QPvqVUFg+n/1/2FB1ycEvFQiSj1HV6BWabn6YRVL4W1XwKXiusffZI7flhfR68SCuO1b4zNudJifcw/AbkcPrMk6gb4YGWwKujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355498; c=relaxed/simple;
	bh=txXi6L0JlJNo4d2wJCl+bKO1lzM1meb6rDXE5Th54fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CttlTWkLj2FXpsI7q7yuIx9clSz5XCrP/KLodyBVxwukpWnP8NWuLC9PNV/Ldrxxh6JQti/zHU7VITwrtgoyRR7MADxCHciO07oGKltqAJgBhhc5OR4d2Iwl8iq6Ijam9QNyLSOE6SX9mq10IX7rA3gMmi2XIgG+6dUulHBS/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fh/OZS8I; arc=none smtp.client-ip=91.218.175.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fh/OZS8I"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=txXi6L0JlJNo4d2wJCl+bKO1lzM1meb6rDXE5Th54fc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787355492; v=1; x=1787960292;
 b=fh/OZS8Iv+JNI8X0PrwdYaD4mKhxHfLtaNlnjKCX46RdaMP0bLOd3vKQy596hOBpqmAcZwLp
 SOrI9bTIqEqV6P01gGOfkld77/TEqspBvAiQPQPq0bFnzTXkiarugwtgPuiNuxwJnmDM9hMWEXV
 7VXVczoGzOe8YPGfzTc1MNE8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.50.189] (67.169.75.212)
	by smtp.migadu.com with ESMTPS id 50af9a6700284e0c;
	Fri, 21 Aug 2026 23:38:11 +0000
X-Mizu-Trace-ID: 50af9a6700284e0c
X-Migadu-Flow: FLOW_OUT
Message-ID: <26177133-4030-4e0b-ae68-0d892cf9ad5b@linux.dev>
Date: Fri, 21 Aug 2026 16:38:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the blocked
 cpuv4 instruction tests for bpf-gcc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
 <20260821201316.1059129-4-vineet.gupta@linux.dev>
 <20260821201922.53F641F000E9@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260821201922.53F641F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/21/26 1:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly added multi-line comment for the gas bug workaround does not follow the required BPF subsystem comment style.
> --
>
> --- Patch [3]: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc ---
> commit 55694625f0a27b85eb77860cd1b4f07749dec04c
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-gcc
>
> This commit enables several blocked BPF CPUv4 instruction tests for bpf-gcc
> by checking specific feature macros instead of relying solely on clang checks.
> It also skips address space cast tests for bpf-gcc as the feature is not
> currently supported, while retaining the existing tests for clang.
>
>> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> index 338e67cd8856a..c7d5a0abff2c3 100644
>> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
>> @@ -299,7 +299,14 @@ __naked void gotol(void)
>>   		"r3 = 24;"
>>   		"if r1 > 0x7 goto +2;"
>>   		"r0 = r2;"
>> +#ifdef __clang__
>>   		"gotol +1;"
>> +#else
>> +		/* gas mis-parses 'gotol +1' as 'goto l+1', same encoding
>> +		 * without the sign (binutils PR gas/34558).
>> +		 */
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred BPF
> subsystem comment style?
>
> The BPF subsystem requires the opening /* to be on its own line:
>
> 		/*
> 		 * gas mis-parses 'gotol +1' as 'goto l+1', same encoding
> 		 * without the sign (binutils PR gas/34558).
> 		 */

Right, I'll fix this in v2.

Thx,
-Vineet

