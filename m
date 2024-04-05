Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43E6AB6
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712282750; cv=none; b=kPMG2mSqaKUhWmSjqlaQa2gjYX/nl+P3AvS5jj+gipvU5HEHgwME1W/WZYEByWUnaXGW4/BYmUpfWD19q+P5ix4uZZREKb9I550Bl1gFOtwgJiSMB7VQV3cBDauIMPiO03sfk0RS+Rm0oXoF8TGP81ZLLYh8Evvkh/y6S7y9SFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712282750; c=relaxed/simple;
	bh=CeHK7QfX2NfxOkxESHDFtNRVNskyWKE9tXe7xRen0jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9Yk4NT/fEHpdaztyns8ym0IxjbzvEpL1qRxu1h1GyKAw7Fu8vOFBzTTy318tqpB6cmZCHn4PBMVntPNx+R6zAowbrxs4i4dpMdSMJ2PQupOXiVt8FYsVjTLUI8jyBVAPXSm6B++eWcNnRvnfZew3bgWJn54KTi+QFjrWYv2CUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I4Q1Rl/e; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I4Q1Rl/e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712282745; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5QAoJWYjZFTVzC2tcpPyfactIxEIKRCtRCRnHqL3Pkc=;
	b=I4Q1Rl/euh17R5wEhiErqG4lZnWA29HTkmijr2E5zG5bVMjvQ6eBGTdbgJpKpsurxYvq6PBX3eAArTMYt4CwGuF9C0pmP1EZ3UWe7GmjJ37dPCKZRXeZb60jafruunc5DYHXsnq/0srpuM3bnQMO1wIz+t0DipCBDe00yyTfnqw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3vaWn-_1712282743;
Received: from 30.15.232.154(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3vaWn-_1712282743)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 10:05:44 +0800
Message-ID: <38dc466c-f020-4c73-9135-6e419b0ae3ff@linux.alibaba.com>
Date: Fri, 5 Apr 2024 10:05:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add test for
 bpf_for_each_map_elem() with different maps
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, xuanzhuo@linux.alibaba.com
References: <20240402061615.48894-1-lulie@linux.alibaba.com>
 <20240402061615.48894-4-lulie@linux.alibaba.com>
 <b1a41645-6002-4c78-99b7-0df3be2611e5@linux.dev>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <b1a41645-6002-4c78-99b7-0df3be2611e5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/5 06:35, Yonghong Song wrote:
> 
> On 4/1/24 11:16 PM, Philo Lu wrote:
>> A test is added for bpf_for_each_map_elem() with either an arraymap or a
>> hashmap.
>> $ tools/testing/selftests/bpf/test_progs -t for_each
>>   #93/1    for_each/hash_map:OK
>>   #93/2    for_each/array_map:OK
>>   #93/3    for_each/write_map_key:OK
>>   #93/4    for_each/multi_maps:OK
>>   #93      for_each:OK
>> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> ---
>>   .../selftests/bpf/prog_tests/for_each.c       | 67 +++++++++++++++++++
>>   .../selftests/bpf/progs/for_each_multi_maps.c | 49 ++++++++++++++
>>   2 files changed, 116 insertions(+)
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/for_each_multi_maps.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c 
>> b/tools/testing/selftests/bpf/prog_tests/for_each.c
>> index 8963f8a549f2..61c5e064f89c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/for_each.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
>> @@ -5,6 +5,7 @@
>>   #include "for_each_hash_map_elem.skel.h"
>>   #include "for_each_array_map_elem.skel.h"
>>   #include "for_each_map_elem_write_key.skel.h"
>> +#include "for_each_multi_maps.skel.h"
>>   static unsigned int duration;
>> @@ -143,6 +144,70 @@ static void test_write_map_key(void)
>>           for_each_map_elem_write_key__destroy(skel);
>>   }
>> +static void test_multi_maps(void)
>> +{
>> +    struct for_each_multi_maps *skel;
>> +    __u64 val, array_total, hash_total;
>> +    __u32 key, max_entries;
>> +    int i, err;
>> +
>> +    LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +        .data_in = &pkt_v4,
>> +        .data_size_in = sizeof(pkt_v4),
>> +        .repeat = 1,
>> +    );
>> +
>> +    skel = for_each_multi_maps__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"))
>> +        return;
>> +
>> +    array_total = 0;
>> +    /* left last element as empty */
>> +    max_entries = bpf_map__max_entries(skel->maps.arraymap) - 1;
> 
> Any particular reason you skip the last element?
> 

No actually, I will remove it in the next version.

Thanks for your comments Yonghong! I will send a next version soon.
