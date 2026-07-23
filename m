Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A53CAE84
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788821; cv=none; b=Pno+Dv0nM0yQ72foqMgNMMJUqPX6nGOQfiuG7ItUjDsFJajRInq7gZ6AahTRaxqfERrTCXspll5ulRDUlAttyVCWUzCwIgI1d0mdQeXvETM4sMSOkoPSINtMJ3eEpAFJIiohfsYCbJ58nerg4qZC8B2ijz7kExRamZmM++Q75es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788821; c=relaxed/simple;
	bh=vJ1xTy38/B9HXOGqa99ACh1zYIVMO2W3JED19+muYoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyUCBUNB8VWw1lg0ZZWrhkY6RY5jAvicXPVIqxkBjuFbJB4Kzkqq718h9KzrIhp7GDpIdi0Q35wstwtyXMlCCc9Wow/JSYkxP3SQXX4F6NrsCAwfBQvqFJa+XMd4zlpPwB3XWxC7lFi64zy5FzQi7pqJ5Z3hB//GHnHyh6xiOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqlIWeUa; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqlIWeUa"
Message-ID: <b8a9b824-8d29-44cf-95f5-41c81cb69be4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784788816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u68ncj0FS9TyaF5Yiq/0B7W/FiFynVL8Rn612V6ihZI=;
	b=SqlIWeUaQlPTzRu2XOBM99hqgkdNh5QhwtJWkn/yNzVof0KlOliC383V8fkBlZ1jNde9X1
	J0GdAJznw8V3vDNduAKuIbYkQj7aBydhgbZ3Z6VUUeXY/qGCvBeiSwBUQfDgi/KgRCWMHx
	PjW/19fMsUhiOW9NZxodoLwI1X9lIdQ=
Date: Thu, 23 Jul 2026 14:39:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Report the real error from
 libarena parallel workers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260723061347.398591-1-jiayuan.chen@linux.dev>
 <20260723062443.D491B1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260723062443.D491B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/23/26 2:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Skipping `-EINTR` completely causes interrupted tests to falsely pass.
> --
>
> --- Patch [1]: [PATCH bpf-next v2] selftests/bpf: Report the real error from libarena parallel workers ---
> commit a35a4526e56449664def8e15919986cc43126b84
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> selftests/bpf: Report the real error from libarena parallel workers
>
> This commit updates the error collection logic in the libarena parallel
> tests to skip -EINTR. The goal is to ensure the real failure is reported
> rather than losing it when another worker thread bails out early.
>
> Link: https://github.com/kernel-patches/bpf/actions/runs/29867905253/job/88764463566
> Link: https://github.com/kernel-patches/bpf/actions/runs/29878191901/job/88794845824
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
>> index df7e4b8dc3945..daade4150af66 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> [ ... ]
>
>> @@ -118,7 +119,22 @@ static int run_libarena_parallel_test_workers(struct libarena *skel,
>>   			continue;
>>   		}
>>   
>> -		err = err ?: (long)thread_ret;
>> +		worker_err = (long)thread_ret;
>> +
>> +		/*
>> +		 * A worker that bails out because another one already gave up
>> +		 * reports -EINTR. It is collateral damage that carries no
>> +		 * information, so skip it entirely: never let it become the
>> +		 * reported error, and don't log it either.
>> +		 */
>> +		if (!worker_err || worker_err == -EINTR)
>> +			continue;
>> +
>> +		if (!err)
>> +			err = worker_err;
> [Severity: Medium]
> If all worker threads return -EINTR due to a process-wide signal, such as a
> global CI timeout or user SIGINT, does this loop leave err initialized to 0
> and falsely report the test as passed?


The bpf_prog_test_run_syscall() path has no way to return -EINTR; a 
worker returns -EINTR only
when test_abort is true, and test_abort is never set without another 
worker returning the
real error, so the workers can never all return -EINTR.

And even if some future signal-based exit were added to the syscall 
path, by then correctness
is already moot....


