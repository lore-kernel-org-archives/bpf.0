Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0C367F48
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687993; cv=none; b=Ue2T3iOXa2aSw7Go4upflVivGubRMBb2BZ3BcW66NL6EOttJCta6iMOQkRhI/w7cp4lRKOagv4rjOyPj4dW510R595Mi3/fqNSOq/Si43PdOJplbook/aPaWckatwAbM3PENdpVcmFl+gOPF6L1QD9Y0dEY8vibekrIYEfxPhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687993; c=relaxed/simple;
	bh=jRdatzKGF+JgMC8SA9lbNju/wpQVRGbEKDwXHp0Pkoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOxEyhpE2mjYhI7IZ4xGEPzzP+Puwiv+gtR38+dEyAcxBUb6aIyGa7Zn+bb0cBxtG6gn7F11ul9ZHjmUtSzq14waU9xK4ETbeUN6Qy55M5kR/eJIV0MGRZRhsqZlMtWCDfrRQWamwlIzfoQ6bR1S2nwVwTDxwGJqZ59Pox58plI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkZlOh3s; arc=none smtp.client-ip=91.218.175.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkZlOh3s"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jRdatzKGF+JgMC8SA9lbNju/wpQVRGbEKDwXHp0Pkoo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786687990; v=1; x=1787292790;
 b=rkZlOh3szdsxeFNyBhbQiPvrwih5kmdUAbPMcIpTaf44tNmrD16+HzrfEsOnYWI/6zMPyHml
 iXdarpTp6e/iZI0/qisR1ZeuQQl89vtKHnapZOdMw6L0+Px1c607ZdkcIm9SDQ2QVpR8m07KKm1
 HhqHm9meE1pIhVl49zJnxuT0=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id cbc6b606c2f8da0b;
	Fri, 14 Aug 2026 06:13:10 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <56384749-0b87-4aee-b30e-8a8a629f84a0@linux.dev>
Date: Fri, 14 Aug 2026 14:13:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify
 global percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260813152324.97937-8-leon.hwang@linux.dev>
 <0ffc09de1b26ea2a7bf3015a63307a134259c376347b778b71706b9830dcd185@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <0ffc09de1b26ea2a7bf3015a63307a134259c376347b778b71706b9830dcd185@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/8/26 00:26, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index 8466332d7406f..06d163a022dcc 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> 
> [ ... ]
> 
>> @@ -60,3 +63,188 @@ void test_global_data_init(void)
>>  	free(newval);
>>  	bpf_object__close(obj);
>>  }
>> +
>> +static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_fd, int *runp)
>> +{
>> +	struct test_global_percpu_data__percpu *data = NULL;
>> +	int i, err, key = 0, num_online, run = 0;
>> +	__u64 args[2] = {0x1234ULL, 0x5678ULL};
>> +	size_t data_sz;
>> +	bool *online;
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		    .ctx_in = args,
>> +		    .ctx_size_in = sizeof(args),
>> +		    .flags = BPF_F_TEST_RUN_ON_CPU,
>> +	);
> 
> This isn't a bug, but does the raw_tp ctx need to be passed here, given
> the program ignores it?

Good catch.

Will drop the 'args'.

> 
> [ ... ]
> 
>> +static void test_global_percpu_data_init(void)
>> +{
>> +	struct test_global_percpu_data__percpu init_value = {};
>> +	struct test_global_percpu_data__percpu *init_data;
>> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
>> +	struct test_global_percpu_data *skel = NULL;
>> +	size_t init_data_sz;
>> +	struct bpf_map *map;
>> +	int prog_fd, err;
> 
> [ ... ]
> 
>> +	map = skel->maps.percpu;
>> +	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
>> +		goto out;
>> +
>> +	init_value.data = 2;
>> +	init_value.nums[6] = -1;
>> +	init_value.struct_data.i = 2;
>> +	init_value.struct_data.nums[6] = -1;
>> +	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
>> +	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
>> +		goto out;
>> +
>> +	init_data = bpf_map__initial_value(map, &init_data_sz);
>> +	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
>> +		goto out;
>> +
>> +	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
>> +	ASSERT_EQ(init_data->set, init_value.set, "init_value set");
>> +	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_value struct_data.i");
>> +	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6],
>> +		  "init_value struct_data.nums[6]");
> 
> This isn't a bug, but should init_value.set be given a non-zero value,
> and nums[6] checked, so these assertions can actually distinguish a broken
> copy?

Will update 'init_value.set = 1;' and check 'nums[6]'.

Thanks,
Leon

