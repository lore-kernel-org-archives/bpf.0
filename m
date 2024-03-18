Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1F58AA0
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796143; cv=none; b=WJPNHBjuP3NotG2rYl1A7cVVPlCsBS4CGWABrPmP72J3IrWEnnPELO9mnoTxllGf9YXVTPJ16XCwOi3yLALnw3BU1podVKU3TcFAGwDX123sNNUHBOOXsDmDY2hvgBr/NhtXFL/XA0mS5+5V9C2P3jQ4GeGw3wLBkYEZspKkhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796143; c=relaxed/simple;
	bh=HuCSeXiuAzTZ7D74b/QYMf6lv9srkuzyR7I1alyP2hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDqpL4EFzhUBp9zw4FlJz/iPRFcxY/+jvCfIar57ijktzcNxLz2ETHuI/Gmqk9K3eVws2LGs29iBb+RjP570lr8x39RUG/cm1fBFqzMz8gNzmao/1a46gTNwdp1TLLaD+2Ow2+5ZmgkFYpswu/wwtEouEqBhMaldCi6+S+Hd3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEJbBKGZ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEJbBKGZ"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso4535720276.2
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796140; x=1711400940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvRo3OCOrFyjVUNG0LT6QNAJnPZo+CAj0WsCRNd8SXo=;
        b=WEJbBKGZt6x5B4x/dZQXqHFqNbjTFCx+BAFQmJQhkjT3nesl27zop5/Tf+zU/xMhfH
         CFK6DFaTHcqSWzPpjh2QWa5DTTcipsQVJN0EkhzuTX++2lKEdWgqXhN5p9X1APr6OzLe
         YzhfF9gf2J7PFnUETjr988KIXss+jEWyVG9pAKwdlS3jzH0tlr+1HBPIDFqlGXp4QOAd
         E7QOm0wCUYovF3gE9rMNhcr/83WpQC86UyD4MAZWzcamRwY3mWCN/Vay1yngYZFxjxn3
         UbAJn1DrftwUI1i6FXmx87NueFIKK9x3jaYouicAvSUb//ZYBBMNlU8VReiT0Tzb/ZQ/
         pd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796140; x=1711400940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvRo3OCOrFyjVUNG0LT6QNAJnPZo+CAj0WsCRNd8SXo=;
        b=EFGyYFbe4bgGbYszmStV2HcelabcoVSVFw3rHzEzF3wzIqzFlYjz8Aji2uN/EN0D0Z
         S7i14pmLpGuJZSjZ0XHPjbRItEcfn5xHBROOkZRFvh6gQYvZEctC/VI7z5TKaHWinhC3
         xYUzzjYDJEreK9OGlt1kX3VYkkJqT8OM3Dbt/Mk0HJGZekSCHFvkn4icw+m+vzXPAznL
         I5msu9MQ0p9YgkU0rh9zhdOO6R5AesyxSFy+Ka+ikq+zjhtYtcVlsRUUj6g0USLZBWp5
         Dos3lTPoMkDdCyPbHXoFHqxr3MyHpB3WTs2d0XU1Eiu4rGw/eG84huetlsoxvnze2cOX
         KJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCXiPja+rnrdWGT1AVCVMAtFNejn+MtlWkNlKkR8ALQN/clM2UgkSX9wHDMr3NmL9Y9z5QIV1IiZJEh/ACoHkLfdDvkU
X-Gm-Message-State: AOJu0YyjoModxXBILFFsSHqtU2PQd2C4b7/s1hpxhEt8ppPt9gJ+PZTk
	5o2MU+P7TxyoePtJVY3WWNmNbz7UbNLpnd3mo/H7u1o+8OWHMBr3
X-Google-Smtp-Source: AGHT+IEqHNwPq7Hp47f/AoI6WgO1oUqcFrz32myBwOc+mShvhOgarj4Tf1f8SlWfJOUaCpI856ZJDg==
X-Received: by 2002:a5b:ecc:0:b0:dc6:be64:cfd1 with SMTP id a12-20020a5b0ecc000000b00dc6be64cfd1mr265338ybs.36.1710796140387;
        Mon, 18 Mar 2024 14:09:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a81c:ef79:19ac:b1c9? ([2600:1700:6cf8:1240:a81c:ef79:19ac:b1c9])
        by smtp.gmail.com with ESMTPSA id s39-20020a25aa2a000000b00dcc70082018sm2009349ybi.37.2024.03.18.14.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:09:00 -0700 (PDT)
Message-ID: <26b97230-eee9-468b-b262-a12562f767d3@gmail.com>
Date: Mon, 18 Mar 2024 14:08:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] Ignore additional fields in the
 struct_ops maps in an updated version.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, kuifeng@meta.com
References: <20240313214139.685112-1-thinker.li@gmail.com>
 <CAEf4BzYXe8xbB5BH97ggYzokdFjqAv5Zuz_MRV9fyzCt+yJJvQ@mail.gmail.com>
 <521a3085-c98e-404f-a30e-d981dc2cd674@gmail.com>
 <CAEf4BzbpGDfoHYFrKGS7sabW=XxNm83Lt5mYt1LpBSy6vjZ+eg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbpGDfoHYFrKGS7sabW=XxNm83Lt5mYt1LpBSy6vjZ+eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/24 11:34, Andrii Nakryiko wrote:
> On Fri, Mar 15, 2024 at 4:44 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 3/14/24 13:59, Andrii Nakryiko wrote:
>>> On Wed, Mar 13, 2024 at 2:41 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>
>>>> According to an offline discussion, it would be beneficial to
>>>> implement a backward-compatible method for struct_ops types with
>>>> additional fields that are not present in older kernels.
>>>>
>>>> This patchset accepts additional fields of a struct_ops map with all
>>>> zero values even if these fields are not in the corresponding type in
>>>> the kernel. This provides a way to be backward compatible. User space
>>>> programs can use the same map on a machine running an old kernel by
>>>> clearing fields that do not exist in the kernel.
>>>>
>>>> For example, in a test case, it adds an additional field "zeroed" that
>>>> doesn't exist in struct bpf_testmod_ops of the kernel.
>>>>
>>>>       struct bpf_testmod_ops___zeroed {
>>>>           int (*test_1)(void);
>>>>           void (*test_2)(int a, int b);
>>>>           int (*test_maybe_null)(int dummy, struct task_struct *task);
>>>>           int zeroed;
>>>>       };
>>>>
>>>>       SEC(".struct_ops.link")
>>>>       struct bpf_testmod_ops___zeroed testmod_zeroed = {
>>>>           .test_1 = (void *)test_1,
>>>>           .test_2 = (void *)test_2_v2,
>>>>       };
>>>>
>>>> Here, it doesn't assign a value to "zeroed" of testmod_zeroed, and by
>>>> default the value of this field will be zero. So, the map will be
>>>> accepted by libbpf, but libbpf will skip the "zeroed" field. However,
>>>> if the "zeroed" field is assigned to any value other than "0", libbpf
>>>> will reject to load this map.
>>>>
>>>> ---
>>>> Changes from v1:
>>>>
>>>>    - Fix the issue about function pointer fields.
>>>>
>>>>    - Change a warning message, and add an info message for skipping
>>>>      fields.
>>>>
>>>>    - Add a small demo of additional arguments that are not in the
>>>>      function pointer prototype in the kernel.
>>>>
>>>> v1: https://lore.kernel.org/all/20240312183245.341141-1-thinker.li@gmail.com/
>>>>
>>>> Kui-Feng Lee (3):
>>>>     libbpf: Skip zeroed or null fields if not found in the kernel type.
>>>>     selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
>>>>     selftests/bpf: Accept extra arguments if they are not used.
>>>
>>> I applied the first two patches and dropped the third one, as I don't
>>> think it's actually testing any new condition. What I actually had in
>>> mind is more along the following lines:
>>>
>>> $ git diff
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> index 098776d00ab4..9585504ce6b5 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> @@ -103,6 +103,8 @@ static void test_struct_ops_not_zeroed(void)
>>>           if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>>>                   return;
>>>
>>> +       skel->struct_ops.testmod_fn_proto->test_2 = skel->progs.test_2;
>>> +
>>>           err = struct_ops_module__load(skel);
>>>           ASSERT_OK(err, "struct_ops_module_load");
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c
>>> b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>>> index 86e1e50c5531..d3e0f941c16c 100644
>>> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
>>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>>> @@ -68,3 +68,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>>>           .test_1 = (void *)test_1,
>>>           .test_2 = (void *)test_2_v2,
>>>    };
>>> +
>>> +struct bpf_testmod_ops___diff_fn_proto {
>>> +       /* differs from expected void (*test_2)(int a, int b) */
>>> +       void (*test_2)(int a);
>>> +};
>>> +
>>> +SEC(".struct_ops.link")
>>> +struct bpf_testmod_ops___zeroed testmod_fn_proto = {
>>> +       .test_2 = (void *)test_2_v2,
>>> +};
>>
>> It is an interesting combination. The newer versions usually have more
>> arguments although it is not always true. But, you used the old version
>> of a type intentionally. Most people would do opposite, right?
>>
>> How about to use a version with more arguments than what the kernel
>> expected, but assign a function pointer with fewer arguments?  For example,
> 
> It doesn't matter. I wanted to check that libbpf doesn't enforce type
> signatures. Whether it's more or fewer arguments doesn't really
> matter. In practice users will need to supply the correct BPF program
> that would be verified by the kernel, and that's what I cared about:
> whether libbpf will allow users to achieve that.

Now I got it!

> 
>>
>> SEC("struct_ops/test_2_arg3v")
>> void BPF_PROG(test_2_arg3v, int a, int b, int c)
>> {
>>       ......
>> }
>>
>> struct bpf_test_ops___new_fn_proto {
>>       void (*test_2)(int a, int b, int c);
>> };
>>
>> SEC(".struct_ops.link")
>> struct bpf_testmod_ops___new_fn_proto testmod_fn_proto = {
>>       .test_2 = (void *)test_2_arg3v
>> };
>>
>> Basically, we don't check signatures of function pointers so far.
>> We have the ability to *decrease* the number of arguments.
>>
>>>
>>>
>>> see how bpf_testmod_ops___diff_fn_proto defines test_2 callback with
>>> an incompatible signature, but at runtime we are switching the program
>>> to the one that the kernel actually expects. This is the scenario
>>> (incompatible struct ops type definition) that I wanted to test and
>>> make sure it works.
>>>
>>> I quickly checked that it does work because libbpf doesn't enforce any
>>> type signature (which is both good and bad, but it is what it is). It
>>> would still be nice to have a selftest added with an incompatible
>>> struct_ops type which is "fixed up" by setting thhe correct program
>>> instance. Consider for a follow up.
>>>
>>>
>>>>
>>>>    tools/lib/bpf/libbpf.c                        |  24 +++-
>>>>    .../bpf/prog_tests/test_struct_ops_module.c   | 103 ++++++++++++++++++
>>>>    .../bpf/progs/struct_ops_extra_arg.c          |  49 +++++++++
>>>>    .../selftests/bpf/progs/struct_ops_module.c   |  16 ++-
>>>>    4 files changed, 186 insertions(+), 6 deletions(-)
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c
>>>>
>>>> --
>>>> 2.34.1
>>>>
