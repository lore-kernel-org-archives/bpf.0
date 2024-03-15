Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC65B5A1
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546298; cv=none; b=cx0g7raGgTSS6/GqnBu8LkF5+71dkc8NiLlMmj+fuBMAot452Fk6Ok8FQuW18qBb9jH//WiPc9dCkZeD0HnnuaBvgVuJvdVJJNmLEuoVEKxp+1YW9Tjprnw/iFJfiniNKnFrxOb9M0BvCbuZtrA9S8chAFWnMgWdVD61MzJulR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546298; c=relaxed/simple;
	bh=qOaSDvcuk8FZ4RaOhV/4AETFA1PmBA/195+ZD7zlk3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwiJWjYGX9e7Ap/wIETSOcYh2QFwSY//vSEEIWrrdMv9rbOyIRFehKlD8GpMjC74axXpoDWE3xjhOVjEyxVkftVMK/xy1IgE1k1gZrkpcATtgqOsSNtTPzP/g9JbsF9Nb5gLGb85BI5mczjEDy5IGF/eB6lj0Zkgn2RJYBG9log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/DwxDnm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/DwxDnm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f24f447cso29204907b3.2
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710546295; x=1711151095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InZ0SV8VdKl1DWxyMvv5E0CpX/Sg9kd6khfXrpoR4XY=;
        b=b/DwxDnmDcZ/kYa9CvuLUZSBKqfpTVunZ0Fx5DDG0O1tohVfuwvTV3yZ74F+t0HrVp
         yr4r5d7SC8gA6I5nP0zDuh8V37W14LBH+KUI2erXOQ9PQwfy+W0k3FN4WxrxZGjHGiv1
         vbFHGUmNbyyvGI79BMh7GCrOe93cXVcz28bxCI2WPt64LKD3ZlrkhKAL2fwvVR+JAA6o
         hSbBBJ9KZ6yPG7btBhlrzRmEItYjgTvJ9AJCwH26kREM+uYaIdl18hBmlay16HlqaPhl
         gGWfCJbRVfkW3ljo20Y+YiEii7/loXNBHIFIl7iwDTUzL/iOtdDo7wD0o6Egcz6YL3/0
         FkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710546295; x=1711151095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InZ0SV8VdKl1DWxyMvv5E0CpX/Sg9kd6khfXrpoR4XY=;
        b=rwXDqqQlpcZdag4fq2eh3pkUPHecaTiiLm8OXDn74rjiDl54HEIkXN/FxIQ0JdqadC
         vKgTd1Bt15lBjg9D7x4zGMl6PNL/ivD/U2vovNrzGH7r0yx3aCCJWjNGdFRJCHst9Jey
         tQgg7IrDFuAxNQxUO0WDN1GX/dnhMHSgqSTBl5yARdCjBwZvxeYTF1gcVn7cKgPjp6jC
         69egAD8Oc1tczmdfxIyw6M7nWVof+pJ46iDtQt2QhCRtQJpdUStGlqYc4/Bo1pah9yBL
         /6qsqJhsBWew9XWUIlCHZEQkYMg9mvH5P5lvebB12WZoeXdADf85c5ugn12mHGoUkZJj
         zANg==
X-Gm-Message-State: AOJu0YxXFkr1XyNmlUsmsLxtdvx7QqXGChFr5ASYU0GKrQ4hVk6l1uDg
	93G7o0EqdD99ghiJ6L9Ym4vGjwd5ursAGj7yS1OzSdVdH6mKJH2P
X-Google-Smtp-Source: AGHT+IFa1bibpC/qsfJ/5VMM2x4dtBqKd+LisKNrS3voBHFhddJc355bs4Qdiqp3XqFPwfNZITfQDQ==
X-Received: by 2002:a0d:c243:0:b0:60a:37fb:7a4c with SMTP id e64-20020a0dc243000000b0060a37fb7a4cmr5032122ywd.5.1710546295359;
        Fri, 15 Mar 2024 16:44:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e725:878a:b2f4:624? ([2600:1700:6cf8:1240:e725:878a:b2f4:624])
        by smtp.gmail.com with ESMTPSA id z7-20020a81ac47000000b00607b9efdf49sm940378ywj.2.2024.03.15.16.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:44:55 -0700 (PDT)
Message-ID: <521a3085-c98e-404f-a30e-d981dc2cd674@gmail.com>
Date: Fri, 15 Mar 2024 16:44:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] Ignore additional fields in the
 struct_ops maps in an updated version.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240313214139.685112-1-thinker.li@gmail.com>
 <CAEf4BzYXe8xbB5BH97ggYzokdFjqAv5Zuz_MRV9fyzCt+yJJvQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYXe8xbB5BH97ggYzokdFjqAv5Zuz_MRV9fyzCt+yJJvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/14/24 13:59, Andrii Nakryiko wrote:
> On Wed, Mar 13, 2024 at 2:41 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> According to an offline discussion, it would be beneficial to
>> implement a backward-compatible method for struct_ops types with
>> additional fields that are not present in older kernels.
>>
>> This patchset accepts additional fields of a struct_ops map with all
>> zero values even if these fields are not in the corresponding type in
>> the kernel. This provides a way to be backward compatible. User space
>> programs can use the same map on a machine running an old kernel by
>> clearing fields that do not exist in the kernel.
>>
>> For example, in a test case, it adds an additional field "zeroed" that
>> doesn't exist in struct bpf_testmod_ops of the kernel.
>>
>>      struct bpf_testmod_ops___zeroed {
>>          int (*test_1)(void);
>>          void (*test_2)(int a, int b);
>>          int (*test_maybe_null)(int dummy, struct task_struct *task);
>>          int zeroed;
>>      };
>>
>>      SEC(".struct_ops.link")
>>      struct bpf_testmod_ops___zeroed testmod_zeroed = {
>>          .test_1 = (void *)test_1,
>>          .test_2 = (void *)test_2_v2,
>>      };
>>
>> Here, it doesn't assign a value to "zeroed" of testmod_zeroed, and by
>> default the value of this field will be zero. So, the map will be
>> accepted by libbpf, but libbpf will skip the "zeroed" field. However,
>> if the "zeroed" field is assigned to any value other than "0", libbpf
>> will reject to load this map.
>>
>> ---
>> Changes from v1:
>>
>>   - Fix the issue about function pointer fields.
>>
>>   - Change a warning message, and add an info message for skipping
>>     fields.
>>
>>   - Add a small demo of additional arguments that are not in the
>>     function pointer prototype in the kernel.
>>
>> v1: https://lore.kernel.org/all/20240312183245.341141-1-thinker.li@gmail.com/
>>
>> Kui-Feng Lee (3):
>>    libbpf: Skip zeroed or null fields if not found in the kernel type.
>>    selftests/bpf: Ensure libbpf skip all-zeros fields of struct_ops maps.
>>    selftests/bpf: Accept extra arguments if they are not used.
> 
> I applied the first two patches and dropped the third one, as I don't
> think it's actually testing any new condition. What I actually had in
> mind is more along the following lines:
> 
> $ git diff
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 098776d00ab4..9585504ce6b5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -103,6 +103,8 @@ static void test_struct_ops_not_zeroed(void)
>          if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>                  return;
> 
> +       skel->struct_ops.testmod_fn_proto->test_2 = skel->progs.test_2;
> +
>          err = struct_ops_module__load(skel);
>          ASSERT_OK(err, "struct_ops_module_load");
> 
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> index 86e1e50c5531..d3e0f941c16c 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -68,3 +68,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
>          .test_1 = (void *)test_1,
>          .test_2 = (void *)test_2_v2,
>   };
> +
> +struct bpf_testmod_ops___diff_fn_proto {
> +       /* differs from expected void (*test_2)(int a, int b) */
> +       void (*test_2)(int a);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___zeroed testmod_fn_proto = {
> +       .test_2 = (void *)test_2_v2,
> +};

It is an interesting combination. The newer versions usually have more
arguments although it is not always true. But, you used the old version
of a type intentionally. Most people would do opposite, right?

How about to use a version with more arguments than what the kernel
expected, but assign a function pointer with fewer arguments?  For example,

SEC("struct_ops/test_2_arg3v")
void BPF_PROG(test_2_arg3v, int a, int b, int c)
{
     ......
}

struct bpf_test_ops___new_fn_proto {
     void (*test_2)(int a, int b, int c);
};

SEC(".struct_ops.link")
struct bpf_testmod_ops___new_fn_proto testmod_fn_proto = {
     .test_2 = (void *)test_2_arg3v
};

Basically, we don't check signatures of function pointers so far.
We have the ability to *decrease* the number of arguments.

> 
> 
> see how bpf_testmod_ops___diff_fn_proto defines test_2 callback with
> an incompatible signature, but at runtime we are switching the program
> to the one that the kernel actually expects. This is the scenario
> (incompatible struct ops type definition) that I wanted to test and
> make sure it works.
> 
> I quickly checked that it does work because libbpf doesn't enforce any
> type signature (which is both good and bad, but it is what it is). It
> would still be nice to have a selftest added with an incompatible
> struct_ops type which is "fixed up" by setting thhe correct program
> instance. Consider for a follow up.
> 
> 
>>
>>   tools/lib/bpf/libbpf.c                        |  24 +++-
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 103 ++++++++++++++++++
>>   .../bpf/progs/struct_ops_extra_arg.c          |  49 +++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   |  16 ++-
>>   4 files changed, 186 insertions(+), 6 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c
>>
>> --
>> 2.34.1
>>
