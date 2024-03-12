Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF827826B
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252062; cv=none; b=OVpsR7nuvEjUje3ZqQ84pdmBl7zob4TmlwjPwkMLcxmFsJ6ygDdVphL5KlbTcaHUBbs3OZjUGvEzqd058SfsY5joTqYZh77XZPEuUtVo3G/j89HsVrq2vrHpXnLZ+LPohSIFfioxUu1sjJXUgxiBWB+TFwhh4SMRWNlqK4avqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252062; c=relaxed/simple;
	bh=ljlTkC+1t7CBsEC9n2zBl4XCiqW2y/n8jkiJFUpk/x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYajhAYXGp/T6cdIY9Js3uy11qhiz3G8gNEDCSS+bqlmxnyOe9D5dRmtCOGfl5O8N8i75SCs+A7AbkJ+WDBFPEkNr5MP3gUg78ylIlDmfcyxj4MlsHupTtMZXpVKP4wFcpSTkDDIUcrnECdppTJR7dWWmTuWFld+xOw4frP035w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iFmrKp0K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iFmrKp0K"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e959d8bc0so2087689f8f.1
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710252058; x=1710856858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVgRekjeVmTVSGSmqpUK/tynWOatTZjzARzvUjK2puU=;
        b=iFmrKp0KiRXAtUwtjG1ZjIo2pVX4ecg7TNU8XWKdYbdaNPUg3lui64zZQNtbAGuKNY
         8SmxvjJAehjLpZYR+DS0LD2tf3Nih15mCEYcVcODIy2A06MsOwnFgiFotUsnk8XOhnkM
         NQXtsSP7gL0jaEvdbsFXLZaCtRT1E2OWz+/BMHfOS4VGno9YzFXFws6+dCbDMi9c75lA
         0aH21QNj174EhtUV/7hnkXUl8yvDqoDX+sxHkmF+i/84eW6Xwaqd8YSD45IpiYa8XcM6
         6sfXW+9RagkHTQlgpVVa7joR2NnnsbO2RO/O0l3ouq9IVHA1GVX7bqJ5Uea5k4fwer+q
         KeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252058; x=1710856858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVgRekjeVmTVSGSmqpUK/tynWOatTZjzARzvUjK2puU=;
        b=VA7DhtjPYI15eQIXCmKbfwWZFRZylnoC0XWXwJgoko5BXcfp9dCQccGRZn0Sjav1cB
         O6d7qxVV5xhqsxaSFh2aDdLXceWO9jCXE3LNg88iWOsfcehgIm+6N1Gyr/1E9vDm+kHt
         WFBlAUwXSTjGsop5rXAZMuFO2wPJlXcnlqWG7cBReFFIECvbVs45tsEhkg0zWPgEh5UR
         qpgTSf2o3kuTWjEvEWoG/eFuN/ild/kXFbq692T+96baIy7u/90E6exw1c8+6qwsJKBe
         W+mSNdCsDGbSuRxpppOQk84OTz5huxgPD21OAROH5WZpjvjrKK0zRgdHKml+eMAJ3rBb
         HBag==
X-Gm-Message-State: AOJu0Yx8jhcjVTjARZeRD5S/pmZEcGFg9H30i8rlycHiA1mYiLoWgd9r
	/UYinafuLZr8qor/fljCJbN8Pyc9KqIAxQrFOfmBqS+qQVMiN4/r6sblQIlRIQA=
X-Google-Smtp-Source: AGHT+IFx79uEl8zRqMhwjYlsdYfpQpkZc5dYDuvEDYl5HwE/CW51wY775lGt82oDbGdHy2EVYopPPg==
X-Received: by 2002:adf:a390:0:b0:33d:27d4:2fec with SMTP id l16-20020adfa390000000b0033d27d42fecmr6460098wrb.35.1710252058384;
        Tue, 12 Mar 2024 07:00:58 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:6eff:72b5:841b:4654? ([2a02:8011:e80c:0:6eff:72b5:841b:4654])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d424c000000b0033e48db23bdsm9098417wrr.100.2024.03.12.07.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:00:58 -0700 (PDT)
Message-ID: <59db83c6-e16f-40f6-becc-968292d9564f@isovalent.com>
Date: Tue, 12 Mar 2024 14:00:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Fix missing pids during link show
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240311214116.2123875-1-yonghong.song@linux.dev>
 <CAEf4BzYU0R=HxFk0h_4rHdfCD=9hX-8NRSr=eGiND_3p=8Syvg@mail.gmail.com>
 <e4196303-0631-4a08-a544-ade179d41ef8@linux.dev>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <e4196303-0631-4a08-a544-ade179d41ef8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-03-11 23:30 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> 
> On 3/11/24 4:13 PM, Andrii Nakryiko wrote:
>> On Mon, Mar 11, 2024 at 2:41 PM Yonghong Song
>> <yonghong.song@linux.dev> wrote:
>>> Current 'bpftool link' command does not show pids, e.g.,
>>>    $ tools/build/bpftool/bpftool link
>>>    ...
>>>    4: tracing  prog 23
>>>          prog_type lsm  attach_type lsm_mac
>>>          target_obj_id 1  target_btf_id 31320
>>>
>>> Hack the following change to enable normal libbpf debug output,
>>>    --- a/tools/bpf/bpftool/pids.c
>>>    +++ b/tools/bpf/bpftool/pids.c
>>>    @@ -121,9 +121,9 @@ int build_obj_refs_table(struct hashmap **map,
>>> enum bpf_obj_type type)
>>>            /* we don't want output polluted with libbpf errors if
>>> bpf_iter is not
>>>             * supported
>>>             */
>>>    -       default_print = libbpf_set_print(libbpf_print_none);
>>>    +       /* default_print = libbpf_set_print(libbpf_print_none); */
>>>            err = pid_iter_bpf__load(skel);
>>>    -       libbpf_set_print(default_print);
>>>    +       /* libbpf_set_print(default_print); */

I'm taking note to make these logs available when users pass the --debug
flag (https://github.com/libbpf/bpftool/issues/137), there's no reason
to hide them in that case.

>>>
>>> Rerun the above bpftool command:
>>>    $ tools/build/bpftool/bpftool link
>>>    libbpf: prog 'iter': BPF program load failed: Permission denied
>>>    libbpf: prog 'iter': -- BEGIN PROG LOAD LOG --
>>>    0: R1=ctx() R10=fp0
>>>    ; struct task_struct *task = ctx->task; @ pid_iter.bpf.c:69
>>>    0: (79) r6 = *(u64 *)(r1 +8)          ; R1=ctx()
>>> R6_w=ptr_or_null_task_struct(id=1)
>>>    ; struct file *file = ctx->file; @ pid_iter.bpf.c:68
>>>    ...
>>>    ; struct bpf_link *link = (struct bpf_link *) file->private_data;
>>> @ pid_iter.bpf.c:103
>>>    80: (79) r3 = *(u64 *)(r8 +432)       ; R3_w=scalar() R8=ptr_file()
>>>    ; if (link->type == bpf_core_enum_value(enum
>>> bpf_link_type___local, @ pid_iter.bpf.c:105
>>>    81: (61) r1 = *(u32 *)(r3 +12)
>>>    R3 invalid mem access 'scalar'
>>>    processed 39 insns (limit 1000000) max_states_per_insn 0
>>> total_states 3 peak_states 3 mark_read 2
>>>    -- END PROG LOAD LOG --
>>>    libbpf: prog 'iter': failed to load: -13
>>>    ...
>>>
>>> The 'file->private_data' returns a 'void' type and this caused
>>> subsequent 'link->type'
>>> (insn #81) failed in verification.
>>>
>>> To fix the issue, do a type cast from 'void *' to 'struct bpf_link *'
>>> for file->private_data
>>> as in this patch, and the 'bpftool link' runs successfully with 'pids'.
>>>    $ tools/build/bpftool/bpftool link
>>>    ...
>>>    4: tracing  prog 23
>>>          prog_type lsm  attach_type lsm_mac
>>>          target_obj_id 1  target_btf_id 31320
>>>          pids systemd(1)
>>>
>>> Fixes: 44ba7b30e84f ("bpftool: Use a local copy of
>>> BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c")
>>> Cc: Quentin Monnet <quentin@isovalent.com>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> index 26004f0c5a6a..96ffcc4f0e67 100644
>>> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
>>> @@ -100,7 +100,7 @@ int iter(struct bpf_iter__task_file *ctx)
>>>          if (obj_type == BPF_OBJ_LINK &&
>>>              bpf_core_enum_value_exists(enum bpf_link_type___local,
>>>                                        
>>> BPF_LINK_TYPE_PERF_EVENT___local)) {
>>> -               struct bpf_link *link = (struct bpf_link *)
>>> file->private_data;
>>> +               struct bpf_link *link =
>>> bpf_core_cast(file->private_data, struct bpf_link);
>> bpf_core_cast() (i.e., bpf_rdonly_cast()) is newer feature, so relying
>> on it in bpftool will make PID printing not work on older kernels that
>> generally do support iter/task_file iterators.
>>
>>>                  if (link->type == bpf_core_enum_value(enum
>>> bpf_link_type___local,
>> the problem is that we dropped BPF_CORE_READ() here and went with
>> `link->type`. Should we restore BPF_CORE_READ(link, type) here and
>> solve the problem, while also supporting this feature on wider set of
>> kernels? Quentin?
> 
> Good point. Using the latest fancy feature might not be the best way as old
> kernels won't work and this is a strong argument. I will change
> to use BPF_CORE_READ in v2.

Agreed, the whole point of commit 44ba7b30e84f that introduced the issue
was to make bpftool work with older kernels. BPF_CORE_READ sounds like
the right approach, thank you!

