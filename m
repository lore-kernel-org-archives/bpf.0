Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B19367B74
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786688029; cv=none; b=hKDlB8I3YFnbtsYDOK5gFP1khAgUQpv+1rUh8JvPRfLx87JU4CY+td6rGCuNtV9hhAZSCKdAnXLOOK3E6B0kXBGUBY1bcMFR2inKZDKnL0s1e0ppITba87MoTcUtsG9ZgXoI34Cs5nP0VD2rvMJ5uUmfGKh/Kb791v1ymZaUB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786688029; c=relaxed/simple;
	bh=FuO0IsFrqSm3hJjcU5qkQiOf8s6vCVabtTjdKvNtZuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQIHZS1TNofnEviqwwF8CQViuN4xgIiprkQh/6Rg5tF6TmQ7Q56+2QOjqiL2elV+z32bRoLbYBUmijctPt1AarxaSlGLKZcgl/MQLm+7wPMIUgWI31cgHKnDhJ+AOQVSWTQh+l8/qyKUsoN7Tik3Q5Eh8KNCBHDReUj5n985kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YS/T8+OP; arc=none smtp.client-ip=91.218.175.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YS/T8+OP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FuO0IsFrqSm3hJjcU5qkQiOf8s6vCVabtTjdKvNtZuU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786688026; v=1; x=1787292826;
 b=YS/T8+OPdb3i34KuwW7d2bUxLECTz+TIODmPp/Vfldtl54LulPdkCbXoEW1VkagETik4hfl6
 LgC4ELQKouXdjj5k3gji15e8TRHLmDLjkl1WEYNYpksk84uixlJOrVe/NaoHN8fD0Yn12XbU7zy
 pza2BMCnvQSB2fFmqpay3o8A=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 9e1c17c69d3310b7;
	Fri, 14 Aug 2026 06:13:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e45e43e4-3670-4856-abdd-6e2ae594ddd9@linux.dev>
Date: Fri, 14 Aug 2026 14:13:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify
 global percpu data
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260813152324.97937-1-leon.hwang@linux.dev>
 <20260813152324.97937-8-leon.hwang@linux.dev>
 <20260813154243.62D451F000E9@smtp.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260813154243.62D451F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/8/26 23:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test `test_global_percpu_data` fails because `bpf_map__set_value_size()` clears the `.percpu` map's BTF type ID when it encounters a non-array as the last variable in the datasec.
> --
> 
> --- Patch [7]: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify global percpu data ---
> commit 0224e1ae61dc47271ec8a72ac29b073935a25d31
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Add tests to verify global percpu data
> 
> This patch adds a selftest to verify global percpu data map initialization
> and modification using APIs like bpf_map__set_value_size() and
> bpf_map_lookup_elem_flags(). It includes both light and standard skeleton
> tests.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 8466332d7406f..06d163a022dcc 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> [ ... ]
>> +static void test_global_percpu_data_init(void)
>> +{
> [ ... ]
>> +	err = bpf_map__set_value_size(map, desired_sz);
>> +	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
>> +		goto out;
>> +	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "percpu value size"))
>> +		goto out;
>> +	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "percpu BTF value type"))
>> +		goto out;
> 
> [Severity: Medium]
> Will this test fail here because bpf_map__set_value_size() clears the BTF
> type ID? 
> 
> When bpf_map__set_value_size() is called, it attempts to resize the BTF
> datasec. This requires the last variable in the datasec to be an array.
> Because `struct_data` is defined last in the `.percpu` section in the BPF
> program, map_btf_datasec_resize() returns -EINVAL and clears the BTF type
> ID to 0, causing this assertion to fail.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
>> new file mode 100644
>> index 0000000000000..416841cd35692
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> [ ... ]
>> +int nums[7] SEC(".percpu");
>> +bool set SEC(".percpu") = false;
>> +struct {
>> +	char set;
>> +	int i;
>> +	int nums[7];
>> +} struct_data SEC(".percpu") = {
>> +	.set = 0,
>> +	.i = -1,
>> +};
> 
> [Severity: Medium]
> Does placing this struct at the end of the `.percpu` section break the
> BTF resizing logic?
> 
> Could the variables in the `.percpu` section be reordered so that an array
> like `nums` or `cpu_id` is the last variable?
> 

I think I should use a dedicated section to exercise
bpf_map__set_value_size(), e.g.

int arr[1] SEC(".percpu.arr");

Hence, bpf_map__set_value_size() won't fail with new value size
'sizeof(int) * 2'.

Thanks,
Leon

