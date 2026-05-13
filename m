Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545073EF64E
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669238; cv=none; b=LYWQgH889Ge3iHut3LmY8B0wMHUydcSrXcCYP1x1yQBD8I0ERd9KwUp6zDop5zHpAtE/XVsce8tg5gOLOJyIprhItNk2pd0v7KCiOPn5x/oaOnZrJPXYl85KjiELKgICr1Psg9aorLj5ASHT1uAezQJIk6QA6pJx0Xo171JXUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669238; c=relaxed/simple;
	bh=dXLxbNPalh9BinE4v3c6XluxckBFqdkhLBxXr5Zg9ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0R/QJqIk2MxeNvBLLvjeS/1TZZKfHqz1bl6+lJ6eSKuAdbNazQqU0iz12UajW+oIo4oVlFkE/iAMUttjaWEZKox+YFcDJ+KaMYUu8ZvWhvppPbAf5nbcFeDre/0Z2WOupMsJ8P0U2yNIP3MQH/J5JIvyfwKRCqE9+u9V8LFxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzku67et; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzku67et"
Message-ID: <b22790b4-1e33-4cab-bc2f-92cf7fd60bfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778669235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZn7mDUuUwZBxanWI5PRAtYoPoBs6MShsXX3PbgHKRY=;
	b=hzku67etNdPijPCUcjfRPn0AZrTsJ9pKgpzjlsiu3M9LFqm2fbFHfOgiPf2gyl0awy1asW
	6ZDRACOH4DoXxuzmZ9wKERGrhftQnm+inyajzJs6hwHT0ghTA/PF5IBBcOi+7ZF0UIAxuQ
	elkqJtk0ak3W3z5i1sS9blDBIkpbgZo=
Date: Wed, 13 May 2026 18:47:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 8/8] selftests/bpf: Add tests to verify map
 create failure log
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260511152817.89191-9-leon.hwang@linux.dev>
 <20260513003358.55836C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260513003358.55836C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/5/26 08:33, sashiko-bot@kernel.org wrote:
[...]
>> +static void test_invalid_numa_node(void)
>> +{
>> +	const char *msg = "Invalid numa_node.\n";
>> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
>> +		    .map_flags = BPF_F_NUMA_NODE,
>> +		    .numa_node = 0xFF,
> 
> Is it possible for this test to fail spuriously on large systems? If the
> test runs on a machine with 256 or more NUMA nodes where node 255 is
> online, the kernel validation will pass. 
> 
> The map creation might then fail for another reason, skipping the expected
> log message and causing the test to fail.
> 
> Would a value like 0xFFFFFFFE (avoiding NUMA_NO_NODE) be more reliable to
> ensure it exceeds nr_node_ids?
> 

Practically, NUMA nodes number wouldn't be >=255.

Instead of 0xFFFFFFFE, better to get possible numa node number from
/sys/devices/system/node/possible, like libbpf_num_possible_cpus() to
get possible cpu number.

>> +	);
>> +
>> +	test_map_create_array(&opts, msg);
>> +}
> 
> [ ... ]
> 
>> +static void test_invalid_token_fd(void)
>> +{
>> +	const char *msg = "Invalid map_token_fd.\n";
>> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
>> +		    .map_flags = BPF_F_TOKEN_FD,
>> +		    .token_fd = 0xFF,
> 
> Could this also cause an unexpected test failure if file descriptor 255
> happens to be an open BPF token in the test runner? 
> 
> It looks like test_invalid_btf_fd uses -1 to guarantee an invalid file
> descriptor. Does it make sense to use -1 here as well?
> 

Make sense.

Will post a follow-up patch to use -1 here.

Thanks,
Leon

>> +	);
>> +
>> +	test_map_create_array(&opts, msg);
>> +}
> 

