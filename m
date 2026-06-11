Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9B3750DB
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154642; cv=none; b=EjvOF6kfeCFZT5L70JcGk0eJbXSjHptxOPBde6pg9oypU8pHBxb/4ofOSMdFfHwiwcJCJZuiprwTj4W0diKgqqNqn6HQKdxkLei+BK4XzLEbzEFvF5uL7DIUE52FgG3b2LyNKmnyXfB97lL2bmdmtPGpjDyc/wFDjFll45Xn7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154642; c=relaxed/simple;
	bh=fmeqGnoJP5VAX6Gpou/zMZPclIDsYsbyeTpEyVTioIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/aNvtvXqsGVou5SP4/NfOOYvTY2I2gRVH5cTFwAHfzyVzYRPo93LM8cwReZjwvmKlKAyjc8Tb73NqCDVoyEODC9sk/7PC466aOruav2MaN3laqreOGf79hA9MlaNHuRVAxOdv6M8guCnwJJ8zx3xHr6RybrUiq+tFe/riQUeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwWR0d3N; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwWR0d3N"
Message-ID: <3046cb92-358f-4e65-a59c-efe07a3df402@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcYFHcKcIYRpR8Vcc4RT54lZ9vZ/GHfSAYoS4O3E5lI=;
	b=FwWR0d3NBbIUKku8KYBfDuXvaVg7zbsmn7DxPDPq/zHD2mPy+0EqPds4DjtSjMf61uPd0x
	PYHW964L+zrXbk57dFpVIXubTaobgLBeQuGnLGws890wXKi7oxA6bmhH71vlL+N6nTnTt9
	m9PAvbbAknEefTghy8Y70bFmnMJiCK8=
Date: Thu, 11 Jun 2026 13:10:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 6/9] selftests/bpf: Add tests to verify global
 percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-7-leon.hwang@linux.dev>
 <20260608152028.93D1F1F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608152028.93D1F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:20, sashiko-bot@kernel.org wrote:
[...]
> 
>> +	/* run on every CPU */
>> +	for (i = 0; i < num_online; i++) {
>> +		__u64 flags;
>> +
>> +		if (!online[i])
>> +			continue;
>> +
>> +		topts.cpu = i;
>> +		topts.retval = 0;
>> +		err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +		ASSERT_OK(err, "bpf_prog_test_run_opts");
>> +		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
>> +
>> +		flags = ((__u64) i << 32) | BPF_F_CPU;
>> +		err = bpf_map__lookup_elem(map, &key, sizeof(key), data, elem_sz, flags);
> 
> [Severity: Medium]
> When looking up a per-CPU map element for a specific CPU using the BPF_F_CPU
> flag, libbpf's validate_map_op() strictly requires that value_sz exactly matches
> map->def.value_size.
> 
> By rounding up sizeof(*data) to a multiple of 8 and passing it as elem_sz
> here, doesn't this make the test brittle?
> 
> It currently passes because the underlying .percpu section happens to be
> exactly 72 bytes (a multiple of 8). If the variables in the BPF program were
> changed such that the section size was 76 bytes, the roundup would yield 80,
> which wouldn't match map->def.value_size and would cause
> bpf_map__lookup_elem() to fail with -EINVAL.
> 
> Could we use the un-rounded size here instead?
> 
Good catch.

Will drop the roundup().

Thanks,
Leon

