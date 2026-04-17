Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A46231A23
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391612; cv=none; b=LLjjWaYEI13LyehhuYbU4pgnJmYWyhbLiONJFHqrt3F1MEiUECDv6HEA2UZSNwBR1OxOszK9i081cabZHBzrmAivl4/bJU3zUjhSXXiwF9nGTKZk6KiVV1vLSj3YetMk8KkhvTWcGo1NFA7WXLApWWiNRFgfGh7BCyTMcXSFKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391612; c=relaxed/simple;
	bh=IgaENIdhWhvAOTEAWBv+mmptGFaaCY3lf7A25U2Ievo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4/KY4UyPi8/xfGecatfb8SaGJoOMCEM/WtveJmWcqw2/4AmcZfHwAqVU3EnngYcnLgm8NgDFrz/BBpqFOaZKkTXiJDXU9ae5r1X4GQvfoYEzwA9RGLe75QYpsFPhmmsnA0a66pfGY8M0FTvLAS7LdtdT9/KtY05maPtz8i2H3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MTmnaMS5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MTmnaMS5"
Message-ID: <d4460398-2f11-42e3-80d1-588931ea2f17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776391608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQJbJ5Z0KhaIA3bQwoWMT/+Xairtq16m8wHI3nTbmos=;
	b=MTmnaMS5QAEiYpbTp8Eae3a6QiIpDMISvMjXCrgIeM9NEbt9cLGr1crAr0bDVl/1J9vL3F
	DAIIqpBXfjv5IHFtxqTZbTCRRRh54Kt3dIyFXZ5anOGFk4TEHK0qTgfKwz8FsYUbPzvrvr
	e3VlZsZZKSf5AtkQvtS0dNEIyUM/wCs=
Date: Fri, 17 Apr 2026 10:06:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 7/8] selftests/bpf: Add tests to verify global
 percpu data
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260414132421.63409-8-leon.hwang@linux.dev>
 <20260414214525.589E8C2BCB6@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260414214525.589E8C2BCB6@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/4/26 05:45, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The tests use the raw CPU ID to index into the densely packed `percpu_data` array, which will cause an out-of-bounds read and test failures on systems with sparse CPU masks.
> --
> 
> commit a7c2685b539ebc816cdb05decab1d7a8a4e1328e
> Author: Leon Hwang <leon.hwang@linux.dev>
>     
> selftests/bpf: Add tests to verify global percpu data
>     
> This commit adds new selftests to verify the behavior of global percpu data
> by checking map initial values, struct pointers, and looking up elements from
> global percpu data maps.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> +static void test_global_percpu_data_init(void)
>> +{
> 
> [ ... ]
> 
>> +	err = bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
>> +				   elem_sz * num_cpus, 0);
>> +	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
>> +		goto out;
>> +
>> +	for (i = 0; i < num_online; i++) {
>> +		if (!online[i])
>> +			continue;
>> +
>> +		data = (void *)percpu_data + elem_sz * i;
> 
> Will this logic cause an out-of-bounds read on systems with sparse CPU masks?
> 
> When reading a per-CPU map using bpf_map__lookup_elem(), the kernel packs the
> per-CPU values densely into the output buffer by iterating over the possible
> CPU mask.
> 
> The test allocates num_cpus (the total count of possible CPUs) elements for
> the output buffer, but then iterates over the raw CPU IDs using i and uses i
> as an index into the densely packed array.
> 
> On systems with sparse CPU masks (for example, where CPUs 0 and 100 are
> possible/online), num_cpus will be 2. When the loop reaches i = 100, it
> appears it will attempt to access percpu_data + elem_sz * 100, reading past
> the bounds of the allocated memory.
> 
> Could we maintain a separate index counter that increments only for possible
> CPUs to match the kernel's dense packing behavior?
> 
> [ ... ]
> 
>> +static void test_global_percpu_data_lskel(void)
>> +{
> 
> [ ... ]
> 
>> +	err = bpf_map_lookup_elem(map_fd, &key, percpu_data);
>> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
>> +		goto out;
>> +
>> +	for (i = 0; i < num_online; i++) {
>> +		if (!online[i])
>> +			continue;
>> +
>> +		data = (void *)percpu_data + elem_sz * i;
> 
> Does this loop have the same bounds checking issue as mentioned above?
> 
> If i is a raw CPU ID on a system with a sparse CPU mask, this calculation
> could exceed the bounds of the percpu_data buffer.
> 

Yep, agree with the review.

Instead of lookup values across all possible CPUs, it should lookup
value on specified CPU using BPF_F_CPU, because the test only runs on
online CPUs.

Thanks,
Leon

