Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDF260580
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 23:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370852; cv=none; b=W6EdU7jQDd1l15zvA0blLikKeL8nohKxfPMtGREB56uXp4KFhVdgqeFM4fIHgvLHqMvS2RFWGDcX6hSakfD96wH1CvXEoKbdEflM/2IYbIDG8zRUrIiVMbjD0+h/yCssxFBbLvJdjcvWcul2yrttbVCMpmUQF8bf9QI5P8fqH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370852; c=relaxed/simple;
	bh=fZp2PFJJAnBaNXnIodTPiCY3HfzveyNPIaZmF0/pRto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi3aENZy4045/T/gNTqnopIbYN3jMybC35yVJ0evN1BDhoPIUCgXIn2CW133TsJdjtqZovZQjCRQ9vAQTfmyOIFqB38GILHbJwlatzS5lPJqv07u5xoEnaYOyLJX4qdeORMdru7uJutxS3TjrgrOpYosjeI78+Rj5heClHPY2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qjLfFglR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qjLfFglR"
Message-ID: <aaa45c92-d8dd-42be-8569-e3abaddffa22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771370848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3PL4+vuvrWhTslRypNTa3ipy/HPHV3MfgKQlMWnh7M=;
	b=qjLfFglRSuJJiXeW4/f92y7jqLtLqtETo8rTwZqZ6Ue19DRHeP4uDVXDMl/D+MDfpYzjks
	A3k2rrTns8KSs2P8Dzgb21rIcpsZmpT+LMyjVNVcUvGUqM27csIi9Ri2MOfiThccD8kmv1
	jOYk52PhyFROb28lXmqjdfEqaQmz1yI=
Date: Tue, 17 Feb 2026 15:27:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 13/14] selftests/bpf: Fix out-of-bounds array
 access bugs reported by ASAN
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-14-ihor.solodrai@linux.dev>
 <59f6faf52bd77c01a96f495eea3c7389c3455b50.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <59f6faf52bd77c01a96f495eea3c7389c3455b50.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/12/26 5:11 PM, Eduard Zingerman wrote:
> On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
>> - kmem_cache_iter: remove unnecessary debug output
>> - lwt_seg6local: change the type of foobar to char[]
>>   - the sizeof(foobar) returned the pointer size and not a string
>>     length as intended
>> - verifier_log: increase prog_name buffer size in verif_log_subtest()
>>   - compiler has a conservative estimate of fixed_log_sz value, making
>>     ASAN complain on snprint() call
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
>> b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
>> index 6e35e13c2022..399fe9103f83 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
>> @@ -104,11 +104,8 @@ void test_kmem_cache_iter(void)
>>  	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
>>  		goto destroy;
>>  
>> -	memset(buf, 0, sizeof(buf));
>> -	while (read(iter_fd, buf, sizeof(buf)) > 0) {
>> -		/* Read out all contents */
>> -		printf("%s", buf);
>> -	}
>> +	while (read(iter_fd, buf, sizeof(buf)) > 0)
>> +		; /* Read out all contents */
> 
> Nit:
>   -       while (read(iter_fd, buf, sizeof(buf)) > 0) {
>   +       while (read(iter_fd, buf, sizeof(buf) - 1) > 0) {
> 
>   And keep the log?

AFAIU it's not necessary for the test, it seems to be a debug print.

There is an exact copy of this loop without printf in dmabuf_iter.c.

> 
> [...]

