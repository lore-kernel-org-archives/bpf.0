Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3763AFCF8
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948110; cv=none; b=OTzt9a5Zpw6UNSxdacYwm0GMC5LgEaCOKp2N8P4KuWyzD3ZbaG7CkfFGGRPL+Od2XGLTl8/73pae9l833UMP8D5tECZ7+0Oe5wx/FdgQJhIWxRW/qHvJsMpSHrV1/t//iIVLdy7ZBIIATbrXDL/LDdTV4cpiE9AYYD/fgP9WiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948110; c=relaxed/simple;
	bh=fLCW866umXO4Gn7teaCvFnw/Ft7dtha1aZ8qqLg65vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpEVOrSjGZxRnzpJkKJGLhNZ9Gj7sckncQnpZh8P1mEyntBvgFObMXcE5kBXFjGEJKiV5wHTdtAygQwHIiL0SFiuN7gj2RUMPxsei1TI719Ezy38+KISB414dqPjg7+y6432l2xx5wVrZzQ2ZqfeSxs5D23XmFbIJeYwHWgM/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=woD0iqEG; arc=none smtp.client-ip=95.215.58.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="woD0iqEG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fLCW866umXO4Gn7teaCvFnw/Ft7dtha1aZ8qqLg65vg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786948106; v=1; x=1787552906;
 b=woD0iqEGRr6q929Wjxk1yM8XXnfdf5eYKJWkrr7ami+TMW+37ev/C5ZAryPdBQzsrD+g3f/7
 KpXBMGs6TlnbSo4FFxBo+bTXCENeLNCEmkRLRCTlBgmn2ZiLvqNt1o/UhuOBtACT3aM+rzoCviD
 /VETfjefxDFsVryrFCJipQkE=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 6a9a30d04e066ce2;
	Mon, 17 Aug 2026 06:28:26 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <9de86d80-59f9-45cb-a684-42ec7d2831b9@linux.dev>
Date: Mon, 17 Aug 2026 14:28:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260814173206.93082-5-leon.hwang@linux.dev>
 <49f1c39a9af6f07357e66657ca1020e57684036626ef1f180a803f148f8eefe4@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <49f1c39a9af6f07357e66657ca1020e57684036626ef1f180a803f148f8eefe4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/8/26 02:24, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 7d6bda909295..2f0dbeb88934 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> @@ -126,11 +123,11 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
>>  static void test_global_percpu_data_init(void)
>>  {
>>  	struct test_global_percpu_data__percpu init_value = {};
>> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
>>  	struct test_global_percpu_data__percpu *init_data;
>> -	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
> 
> Does multiplying by 2 here break the test on 64K page systems?
> 
> Per-CPU array value sizes are capped by the kernel:
> 
>   /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>   if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
>           return -E2BIG;
> 
> in kernel/bpf/arraymap.c:array_map_alloc_check(), where PCPU_MIN_UNIT_SIZE
> is defined as:
> 
>   #define PCPU_MIN_UNIT_SIZE  PFN_ALIGN(32 << 10)
> 
> which equals max(32768, PAGE_SIZE).
> 
> The old code was safe by construction: desired_sz == PAGE_SIZE <=
> PFN_ALIGN(32768) == PCPU_MIN_UNIT_SIZE. Doubling it breaks that:
> 
>   PAGE_SIZE  4096 -> limit 32768, request   8192  OK
>   PAGE_SIZE 16384 -> limit 32768, request  32768  OK (exactly at limit)
>   PAGE_SIZE 65536 -> limit 65536, request 131072  -E2BIG
> 
> On kernels built with 64K pages (arm64 CONFIG_ARM64_64K_PAGES, ppc64)
> bpf_map__set_value_size() still succeeds (it is purely userspace
> bookkeeping), all four assertions that follow it pass, and then map
> creation fails inside test_global_percpu_data__load():
> 
>>  	err = test_global_percpu_data__load(skel);
>>  	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
>>  		goto out;
> 
> The "global_percpu_data/init" subtest fails, and test_percpu_data_on_cpus()
> is never reached. That is a new failure introduced by this patch (with
> desired_sz == PAGE_SIZE the same configuration created a 65536-byte per-CPU
> value, which is exactly at the limit and accepted).
> 
> Note that the neighbouring resize test in global_map_resize.c deliberately
> does not scale a per-CPU map by page size for this reason. At line 46 it
> uses:
> 
>   new_sz = sizeof(skel->data_percpu_arr->percpu_arr[0]) *
>            libbpf_num_possible_cpus();
> 
> A size that is independent of PAGE_SIZE would still force the mmap region
> to move, which is what the new skel->percpu_arr reassignment and the
> arr[0] == -1 check are there to exercise, without hitting the per-CPU
> allocator bound.
> 

To avoid breaking the test on 64K page systems, run the resize subtest
only on 4K page systems.

From maintenance view, I think it's better to add a dedicated subtest to
test bpf_map__set_value_size() for percpu data. Then, it will be able to
skip the subtest when sysconf(_SC_PAGE_SIZE) != 4K.

Thanks,
Leon

