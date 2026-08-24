Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF9280018
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547773; cv=none; b=RTXBJ97L2LGBMBhfMU8hafMTrOztXHabK72JYmoKsgbAlovXlQeMkyuul3KQPtFDrgggsMwtug4Vnn4HyEZBVBz/ae0sTW1nQnR7J/GV5iHs255vww0eb99iJANkSqc7dBwnI6eml1FJcsdiZ0teopDF3ftuaR6re0bBOmVzpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547773; c=relaxed/simple;
	bh=k2MEm8TxX/ObvL3bEaNmqF4s53Uqj2jfcYNMEJ2RUKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVGfwPB2hGvh6NYYB4JoaJ8F9HlWqpH645+94Ts5COjFuaB9Yvl6QzsG4OxAvj4t5/dUoK+U2GKAA+k8rxsE2kGFfTjIRsjA0AgOOpLeEbyzpQBUu5oqOkkW36ttuqNe81t50nwM9Y+3AiKXvVGhAGFoEX+uU8+bLKgNZjmlajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IafYWYgC; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IafYWYgC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k2MEm8TxX/ObvL3bEaNmqF4s53Uqj2jfcYNMEJ2RUKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787547769; v=1; x=1788152569;
 b=IafYWYgCJB3VPEdgRMhHTwpqY9o6ga2nEJRuFng4t/6LShhiwZshm5ScmIqfLf/3zglyMjc9
 wvJPH/8VInLsMvbj8ov/iHlduezotClnzFxjC7h/8wRWaWaEECCLbvdh4QzGrI2ww4FJ1ySk5K8
 XTUvKFpyzdm79SKMJYxhfwOc=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 49d1502f963dc72a;
	Mon, 24 Aug 2026 05:02:49 +0000
X-Mizu-Trace-ID: 49d1502f963dc72a
X-Migadu-Flow: FLOW_OUT
Message-ID: <90bbc900-21cd-4dfb-a058-13930378052f@linux.dev>
Date: Mon, 24 Aug 2026 13:02:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260818153202.90714-1-leon.hwang@linux.dev>
 <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
 <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev>
 <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/8/26 01:58, Andrii Nakryiko wrote:
> On Tue, Aug 18, 2026 at 6:44 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 19/8/26 00:15, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>>> index 5671c31085cd..2b69290bcc3e 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>>>
>>> [ ... ]
>>>
>>>> @@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
>>>>      test_global_percpu_data_lskel__destroy(lskel);
>>>>  }
>>>>
>>>> +#define PAGE_SIZE 4096
>>>> +
>>>> +static void test_global_percpu_data_map_resize(void)
>>>> +{
>>>> +    const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
>>>> +    struct test_global_percpu_data *skel;
>>>> +    const int arr_value = -1;
>>>> +    struct bpf_map *map;
>>>> +    int err, prog_fd;
>>>> +    size_t data_sz;
>>>> +
>>>> +    if (sysconf(_SC_PAGE_SIZE) != PAGE_SIZE) {
>>>> +            test__skip();
>>>> +            return;
>>>> +    }
>>>> +
>>>> +    skel = test_global_percpu_data__open();
>>>> +    if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
>>>> +            return;
>>>> +
>>>> +    map = skel->maps.percpu_arr;
>>>> +    skel->percpu_arr->arr[0] = arr_value;
>>>> +    err = bpf_map__set_value_size(map, desired_sz);
>>>
>>> This isn't a bug, but since the guard above already pins the page size to
>>> 4096, would `const __u32 desired_sz = PAGE_SIZE * 2;` read more directly
>>
>> Will change to 'PAGE_SIZE * 2' if the next revision is needed.
>>
>>> here - and is the unguarded `#define PAGE_SIZE 4096` preferable to the
>>> `#ifndef PAGE_SIZE` form used in sockopt.c?
>>
>> No. PAGE_SIZE must be 4096 here.
>>
> 
> can you please elaborate why do we care about specific PAGE_SIZE
> value? it's a bit weird to guard test based on page size...
> 
It is to verify the mmap change in libbpf's bpf_map_mmap_resize() for
percpu data map, like those subtests in global_map_resize.c.

Thanks,
Leon

