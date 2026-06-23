Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201E395AE2
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187348; cv=none; b=GIMWmKtGRNhDTgkvLTsE0Jtxco3o6yY1Y9Y0xDuHqvHgwobxPYz7fE11dFty6mU1Zr0bnRm5WaGfABU4wxRhrHBnAL+Ro+MGNEh0helgiffoAQUQxP/gDTgxZZTRFLi1+IGa3DzFb8yBzA7QWnhs1nM7SEDfouFd2/+nPUhbwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187348; c=relaxed/simple;
	bh=gC+x3bLyquHaqQmGbYE4OgUlquaRcTOjfeWsV9kkjcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrF00ZSCjeXQak3GCoOsdUzCjjmgkEHLjAGaOCDwxGJGyyjF65uZCT6PvJZdXpdLz0SSqCXBsSnfmKdVaNIUPJly5VtiWHk4I8V6izbzP1/+Z3OcecLQNMs9m/ZQXSYV4e99mLWnX2Y5IrGPIZlRN8SrxVyEPA1Odetb+IuWSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b9sNQBXG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9sNQBXG"
Message-ID: <79c14f81-0917-45dd-af0f-689d470b5370@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782187333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yyhWihU4F9oxjORa8tgNZtkTOGS9vxpGomp6i3QeT4=;
	b=b9sNQBXGCfz2YAh3K4YFviUOpk5206Xsy7S8LJ/LdE2YL+7nTuWVrbn2lsUpwyiKdvYm+Z
	Rh3SV4kOHtgKt/IO8XN50OLxK7IxUkwR06wTW8opuVHt2sgRP/rkiag9CecSc4XzUqFLbx
	JTRZydnjYbKaRF53/NrfUUMS/NyZ8Hs=
Date: Tue, 23 Jun 2026 12:02:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 08/11] selftests/bpf: Add tests to verify
 global percpu data
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260622143557.22955-9-leon.hwang@linux.dev>
 <eebc3e5edf723fd9c43307225efa00263590db7b56f385d384ff9b3f0220dd78@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <eebc3e5edf723fd9c43307225efa00263590db7b56f385d384ff9b3f0220dd78@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/6/26 23:24, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 8466332d7406..ea7e4e3d91cf 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> @@ -60,3 +63,184 @@ void test_global_data_init(void)
>> +
>> +static void test_global_percpu_data_init(void)
>> +{
>> +	struct test_global_percpu_data__percpu init_value = {};
>> +	struct test_global_percpu_data__percpu *init_data;
>> +	int key, prog_fd, err, num_cpus, num_online, i;
>> +	struct test_global_percpu_data *skel = NULL;
>> +	__u64 args[2] = {0x1234ULL, 0x5678ULL};
>> +	size_t init_data_sz;
>> +	struct bpf_map *map;
>> +	bool *online;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		    .ctx_in = args,
>> +		    .ctx_size_in = sizeof(args),
>> +		    .flags = BPF_F_TEST_RUN_ON_CPU,
>> +	);
>> +
>> +	num_cpus = libbpf_num_possible_cpus();
>> +	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
>> +		return;
>> +
>> +	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
>> +	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
>> +		return;
> 
> This isn't a bug, but num_cpus is only read by the ASSERT_GT guard and is
> never used afterwards; the per-CPU loop is driven entirely by num_online
> from parse_cpu_mask_file().  Is the libbpf_num_possible_cpus() check needed
> here, or is num_online sufficient?  The same pattern appears in
> test_global_percpu_data_lskel().
> 

Will drop the unused "num_cpus".

> [ ... ]
> 
>> +static void test_global_percpu_data_lskel(void)
>> +{
> 
> [ ... ]
> 
>> +		flags = ((__u64) i << 32) | BPF_F_CPU;
>> +		err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
>> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
>> +			goto out;
>> +
>> +		ASSERT_EQ(data.data, 1, "data.data");
>> +		ASSERT_TRUE(data.run, "data.run");
>> +		ASSERT_EQ(data.nums[6], 0xc0de, "data.nums[6]");
>> +		ASSERT_EQ(data.struct_data.i, 1, "struct_data.i");
>> +		ASSERT_TRUE(data.struct_data.set, "struct_data.set");
>> +		ASSERT_EQ(data.struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
>> +	}
> 
> This isn't a bug, but this post-run assertion block duplicates the one in
> test_global_percpu_data_init() almost verbatim; the two loops share the same
> online-CPU iteration, the same bpf_prog_test_run_opts setup, and the same six
> data.* checks, differing only in the lookup call (bpf_map_lookup_elem_flags()
> vs bpf_map__lookup_elem()).  Could the six data.* checks be factored into a
> shared helper taking the looked-up value?
> 

Good catch.

Will factor out a helper for the whole 'for' block.

Thanks,
Leon

