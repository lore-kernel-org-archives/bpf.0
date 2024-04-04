Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF96F07D
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270168; cv=none; b=esLhmqouB//XQGRpDQV5Z8jFE7iyiyfVYXmS05pLAnJl2aOhUENY592PRkcBo9iTJgk3h0aE2cVdOCDGnditVz9nkUMEzTCyEzCPXouI34Q/uhmAKMcrjFm2oKp2H/EVEvGipItfWxBRBAmJTpBYAYvnFghI91lChMyKgxUaY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270168; c=relaxed/simple;
	bh=jljRRkU4o2XG2vV2VhgVhPe5RtoHBNNJGYuUc6pKd84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erllijCmlCC+j2K74ZaMmnNoPkoHZFm7+jx0/eAlYzqQSzOYcgOE8rIlmkAXknwuDTKH0kAB7xjWXIxd8l9IezvTaLVIi6UWydntEIPC5YJwBWZYROzUbnjQKTSBE281z7pLDJour4G3k/odwGLBfJPiBYauJ/wsxNyu1ipvkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dr2YSzDT; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dr2YSzDT"
Message-ID: <b1a41645-6002-4c78-99b7-0df3be2611e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712270165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0YAvO/jWY9SAfod0YLdhPl5jh1As9xjrBHzP1as5AM=;
	b=dr2YSzDTp3os69HQVlqryA2e8aBfCz7k7yGfb3iBT7KzSDdho8eAeXzXhxdI6bj7uaqvVc
	70lVIh3C3fBQph7wkJQSsan/R4xldpSJBYRobmILHlQxFxCF4VUYF/H9yY+HmnkJ0dvFo7
	SUJjcJlSOqaT6j8JklWC22EhWgOMoDU=
Date: Thu, 4 Apr 2024 15:35:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
Content-Language: en-GB
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
 <20240402061615.48894-4-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240402061615.48894-4-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 11:16 PM, Philo Lu wrote:
> A test is added for bpf_for_each_map_elem() with either an arraymap or a
> hashmap.
> $ tools/testing/selftests/bpf/test_progs -t for_each
>   #93/1    for_each/hash_map:OK
>   #93/2    for_each/array_map:OK
>   #93/3    for_each/write_map_key:OK
>   #93/4    for_each/multi_maps:OK
>   #93      for_each:OK
> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   .../selftests/bpf/prog_tests/for_each.c       | 67 +++++++++++++++++++
>   .../selftests/bpf/progs/for_each_multi_maps.c | 49 ++++++++++++++
>   2 files changed, 116 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
> index 8963f8a549f2..61c5e064f89c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
> @@ -5,6 +5,7 @@
>   #include "for_each_hash_map_elem.skel.h"
>   #include "for_each_array_map_elem.skel.h"
>   #include "for_each_map_elem_write_key.skel.h"
> +#include "for_each_multi_maps.skel.h"
>   
>   static unsigned int duration;
>   
> @@ -143,6 +144,70 @@ static void test_write_map_key(void)
>   		for_each_map_elem_write_key__destroy(skel);
>   }
>   
> +static void test_multi_maps(void)
> +{
> +	struct for_each_multi_maps *skel;
> +	__u64 val, array_total, hash_total;
> +	__u32 key, max_entries;
> +	int i, err;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		.data_in = &pkt_v4,
> +		.data_size_in = sizeof(pkt_v4),
> +		.repeat = 1,
> +	);
> +
> +	skel = for_each_multi_maps__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"))
> +		return;
> +
> +	array_total = 0;
> +	/* left last element as empty */
> +	max_entries = bpf_map__max_entries(skel->maps.arraymap) - 1;

Any particular reason you skip the last element?

> +	for (i = 0; i < max_entries; i++) {
> +		key = i;
> +		val = i + 1;
> +		array_total += val;
> +		err = bpf_map__update_elem(skel->maps.arraymap, &key, sizeof(key),
> +					   &val, sizeof(val), BPF_ANY);
> +		if (!ASSERT_OK(err, "array_map_update"))
> +			goto out;
> +	}
> +
> +	hash_total = 0;
> +	max_entries = bpf_map__max_entries(skel->maps.hashmap) - 1;

ditto.

> +	for (i = 0; i < max_entries; i++) {
> +		key = i + 100;
> +		val = i + 1;
> +		hash_total += val;
> +		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
> +					   &val, sizeof(val), BPF_ANY);
> +		if (!ASSERT_OK(err, "hash_map_update"))
> +			goto out;
> +	}
> +
> +	skel->bss->data_output = 0;
> +	skel->bss->use_array = 1;
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
> +	if (CHECK(err || topts.retval, "ipv4", "err %d errno %d retval %d\n",
> +		  err, errno, topts.retval))
> +		goto out;

Let us use ASSERT_* macros here. In this case, you can do
	ASSERT_OK(err, "bpf_prog_test_run_opts");
	ASSERT_OK(opts.retval, "retval");
There is no need to goto out, we can continue testing below.

> +
> +	ASSERT_EQ(skel->bss->data_output, array_total, "array output");
> +
> +	skel->bss->data_output = 0;
> +	skel->bss->use_array = 0;
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
> +	if (CHECK(err || topts.retval, "ipv4", "err %d errno %d retval %d\n",
> +		  err, errno, topts.retval))
> +		goto out;

Do two ASSERT_OK similar to the above.

> +
> +	ASSERT_EQ(skel->bss->data_output, hash_total, "hash output");
> +
> +out:
> +	for_each_multi_maps__destroy(skel);
> +}
> +
> [...]
