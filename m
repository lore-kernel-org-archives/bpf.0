Received: from mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512973603D3
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103863; cv=none; b=E/gG8Vournl4XPqBrCN8fS3l7iGxYtN8n9Fpw1f486JpigMDxUENWGRHDok/C57aGxAHCuP7M+eKn4TydWx5YtCwbkI69EdGx4IiB0iXtbIaVf+cLW32idxROOXSLNbQIwUThsz6+zgiHY82zBVoWe4Z+sbJQ2cexJsV3x14Bw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103863; c=relaxed/simple;
	bh=dz5A4sctYbARLpdNgcUYQ80SJTmDzvQs4bCQgtkuEcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTyNiaiOHvOQymfUXwfhEvNRdPzWq3BJ/eqJaL5x1FRJfqQVcNRZvUGVt9g5/4GaubN28tLVOO/ShZb/Rbuni92ND/wM3xjtF8QF/6UJI4Xb+o0oHghRl2m9hcc+QmYXCIZ+H3m7O/8XRDLHyJO49E+tVXUoGwdWIsgLelTORfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=My0gWCGh; arc=none smtp.client-ip=91.218.175.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="My0gWCGh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dz5A4sctYbARLpdNgcUYQ80SJTmDzvQs4bCQgtkuEcQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787103858; v=1; x=1787708658;
 b=My0gWCGhQqxEHEtunLhJGH5eYBanII+KbSnaQDoDu1WOlLvmRY1fkvK8EzUqHJDZ5pRPr8xI
 ZQC/j/ecDsruByjByWorir7ffEEW450tspeBzA4jIWsYD8Yxc3x6vhDq41Fi00KW4SRXNUqMt0w
 LkEQrxk97GW8T9RIzJDPfy48=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (118.201.124.118)
	by smtp.migadu.com with ESMTPS id 5369898abe028d4b;
	Wed, 19 Aug 2026 01:44:18 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev>
Date: Wed, 19 Aug 2026 09:44:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260818153202.90714-1-leon.hwang@linux.dev>
 <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/8/26 00:15, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 5671c31085cd..2b69290bcc3e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> @@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
>>  	test_global_percpu_data_lskel__destroy(lskel);
>>  }
>>
>> +#define PAGE_SIZE 4096
>> +
>> +static void test_global_percpu_data_map_resize(void)
>> +{
>> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
>> +	struct test_global_percpu_data *skel;
>> +	const int arr_value = -1;
>> +	struct bpf_map *map;
>> +	int err, prog_fd;
>> +	size_t data_sz;
>> +
>> +	if (sysconf(_SC_PAGE_SIZE) != PAGE_SIZE) {
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	skel = test_global_percpu_data__open();
>> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
>> +		return;
>> +
>> +	map = skel->maps.percpu_arr;
>> +	skel->percpu_arr->arr[0] = arr_value;
>> +	err = bpf_map__set_value_size(map, desired_sz);
> 
> This isn't a bug, but since the guard above already pins the page size to
> 4096, would `const __u32 desired_sz = PAGE_SIZE * 2;` read more directly

Will change to 'PAGE_SIZE * 2' if the next revision is needed.

> here - and is the unguarded `#define PAGE_SIZE 4096` preferable to the
> `#ifndef PAGE_SIZE` form used in sockopt.c?

No. PAGE_SIZE must be 4096 here.

> 
>> +	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
>> +		goto out;
>> +	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "bpf_map__value_size"))
>> +		goto out;
>> +	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "bpf_map__btf_value_type_id"))
>> +		goto out;
>> +
>> +	skel->percpu_arr = bpf_map__initial_value(map, &data_sz);
>> +	if (!ASSERT_EQ(data_sz, desired_sz, "data_sz"))
>> +		goto out;
>> +	if (!ASSERT_OK_PTR(skel->percpu_arr, "skel->percpu_arr"))
>> +		goto out;
> 
> This isn't a bug, but would it read more consistently with
> test_global_percpu_data_init() to check ASSERT_OK_PTR(skel->percpu_arr)
> before ASSERT_EQ(data_sz, desired_sz)? The block this replaces checked
> pointer-then-size, and the surviving test_global_percpu_data_init() at the
> same file still does pointer-then-size.

Unnecessary to keep consistent for their order. This is a really minor
readability concern.

Thanks,
Leon

