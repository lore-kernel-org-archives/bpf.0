Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAB37D123
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937073; cv=none; b=W0zpo1Mi+GV/RvSyU6Latf4QSYmOt2/BNJclC7j1udINNn20cXRTpUcjnzDduO8a5GmroK8SsEfSHH/Zih5GLA3Kp1cwNszya+pUTyNmFDou6b9uKqV3vw7+iAyq2QGYX9uZvn+J/Cxes3AyVacyPiyqyaP1eSQGJsCxJZJK4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937073; c=relaxed/simple;
	bh=+XM8NrZpV9frpppAHR/b7+OTztkRtZdDDQmmWYtg2/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeQb7c1SoMnsGFyCVME2TNzBV6j5hrFh9f1xlViNCu3glLkZhGTbK9Oxb9dV31k81P8HQipEJ4yK0KvSlzZ5EEORwrAbDCxZsq/q+yTigMWdFOwYUsIUkK6wu83w+RDLmknR/p7YwFTfNT8//x1hsK3nrthpoiME0lY2jt4uSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZeSgMFm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZeSgMFm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so8663595e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787937070; x=1788541870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITCoSjkSluFM54y7ZRq5rJAeJWtnIZBAl+KFdusW1eg=;
        b=AZeSgMFmhgsEQ7+MaunqcaWIK6PAqPNIOhE58IKxMRyAI6kOhcaxT3eoS3pxizzXql
         9UPIBlRAdLpyI9t3/HlOWVsZMuIYbhyNn/G+4FwSsyI4Ku0+zcDOeM8fiTefGmW4i5KV
         TZUqF6TBXnuSauvySZ1Iz6s86lzHeoNyowuEryccX7w2RV+W+nULQEecZIXHG7DVJJED
         MQRUSQZh17lFuL6gvYyGdL+srWVyaIKVVf00yYLS8+SXiWlPhGyksBCRB+r/oCy9RsW4
         qPhSRBSDwgbdak3SrkkBpuPmAWajMRagKZtDg1GIb0+4orw6AiHGkyQFFOXNWhcIAkT3
         d/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787937070; x=1788541870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITCoSjkSluFM54y7ZRq5rJAeJWtnIZBAl+KFdusW1eg=;
        b=PChWN8tPBsOEe1GnBtWk3DsraEtSSrauAikmP+LQY5sunZih+XBj7OTbHC3C3UyC2h
         nMojJB7rX8N2k7P01DhoXFbChrBMufTcKR1owAUr5CXCPr4yhQIW93X2t1J6Md5Jgb03
         W3q1GXEqP24ulD43Ah4tUlqA806OsXuJBJ4w0hQEl922RNn0RY7HJm82xRFGkRPXNPNN
         XRjak0gplHvK61r6XDdjoQfZmW5zu9KX0W9FdxW5375NXO9pBhoeaGfDA+UCF5Ba8V4M
         OhBaXuyn2SSreNnAYG/uBNHjkThDwUtbq9LZx+v+zFFL9MZOAqY+AgRx4btIyyrehmrK
         puNg==
X-Gm-Message-State: AFuF++kVsMEbBGlUzIJ4Ole226o/dfUvcQzKV2/XXE02oFR6Mrf4x+El
	32RMTpD7XhsumVcU4vJxAfLaNXqB0ww9l/QBNoThw02IKN+8TxLnTxoB
X-Gm-Gg: AR+sD13LHT5NTQgXvVgzVdnFFFGvsqo418Rx5LJXzg0fyflyCShkTvJQ7CpwBA5NZ8u
	qbweEocU+Qoyt1tJwAN/ytMutqNmzUb0GFNvDVqlR/KKwVzDoE+EaYIVmzIq7bPOhF0MOr5OqiT
	xRPLOFVh+fAoLoBMepB1xq7OykQQIiGLni2+qy0rzEHl6rxBBp1o9ikMFza1hfu/lSkiZkGRRaR
	2gznB981sHj5KXQYsS/zmapjCv9LRVkcgUL5agPeefPoJOEATOeUO7qhgwDtLm5p4oOpRbP12Ag
	t+n/z7LJ1tP/AgXzOeTTlPoX2Zr10f73p4HVDDq9IwJqXP26oy9ZdTfQepaJSUNDnhdpF4vByia
	yKU+fhVXBX4cmcNiV4Vrmnbao/zhqUfi/Guz/Fb6Z53FM57/D+wXVPMmkupcP917EdpZm3Dnr2Q
	z0+GL4mLlbTqaHnspAyleAvYxx+9/WDTQCYxi2w7cgFUNvvKvEJVkglsL/uSoKG33ao/kpyrKXF
	oXkpDOpY7wtR3++DPdpo45wFXciut83AkRM8O0A/mR1GCId
X-Received: by 2002:a05:600c:3549:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-49b91c57464mr115588315e9.10.1787937069530;
        Fri, 28 Aug 2026 10:11:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c7cfsm70168135e9.11.2026.08.28.10.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 10:11:09 -0700 (PDT)
Message-ID: <02dd6f0b-b4fa-496a-a6b2-ab9d103021c7@gmail.com>
Date: Fri, 28 Aug 2026 18:11:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in
 profiler
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, qmo@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
 <CAEf4BzaKFk9yu10P9bXOE9i=hD8SO+_XfvPbnEBU7cd+eLDVCw@mail.gmail.com>
 <6e864df5-4fd0-4ae5-a8c6-d2abb9f818d7@gmail.com>
 <CAEf4BzamFa3MebxgsBMN4pfgMnwj_Wz21cJpfE2couTVpDUj6A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzamFa3MebxgsBMN4pfgMnwj_Wz21cJpfE2couTVpDUj6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/28/26 5:33 PM, Andrii Nakryiko wrote:
> On Fri, Aug 28, 2026 at 4:01 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 8/28/26 1:30 AM, Andrii Nakryiko wrote:
>>> On Thu, Aug 27, 2026 at 8:29 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Total cycle counts are difficult to compare across workloads with
>>>> different run counts. Report cycles per run to expose the per-invocation
>>>> cost directly.
>>>>
>>>> Example:
>>>> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>>>>
>>>>             423256 run_cnt
>>>>          947413975 cycles              #  2238.39 cycles per run
>>>>          333965846 instructions        #     0.35 insns per cycle
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>>>>  tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>>>>  2 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> index 90fa2a48cc26..2280dc4492c0 100644
>>>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>>>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>>>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>>>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>>>> -    the profiling will run up to **UINT_MAX** seconds.
>>>> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
>>>> +    selected, plain output also reports the average number of cycles per
>>>> +    program run.
>>>>
>>>>  bpftool prog help
>>>>      Print short help message.
>>>> @@ -360,7 +362,7 @@ EXAMPLES
>>>>  ::
>>>>
>>>>           51397 run_cnt
>>>> -      40176203 cycles                                                 (83.05%)
>>>> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>>>>        42518139 instructions    #   1.06 insns per cycle               (83.39%)
>>>>             123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>>>>
>>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>> index a9f730d407a9..8935508f955b 100644
>>>> --- a/tools/bpf/bpftool/prog.c
>>>> +++ b/tools/bpf/bpftool/prog.c
>>>> @@ -2069,9 +2069,9 @@ struct profile_metric {
>>>>         bool selected;
>>>>
>>>>         /* calculate ratios like instructions per cycle */
>>>> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
>>>> +       const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>>>>         const char *ratio_desc;
>>>> -       const float ratio_mul;
>>>> +       const double ratio_mul;
>>>>  } metrics[] = {
>>>>         {
>>>>                 .name = "cycles",
>>>> @@ -2080,6 +2080,9 @@ struct profile_metric {
>>>>                         .config = PERF_COUNT_HW_CPU_CYCLES,
>>>>                         .exclude_user = 1,
>>>>                 },
>>>> +               .ratio_metric = 0,
>>>> +               .ratio_desc = "cycles per run",
>>>> +               .ratio_mul = 1.0,
>>>>         },
>>>>         {
>>>>                 .name = "instructions",
>>>> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>>>>         for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>>>                 struct bpf_perf_event_value *val = &metrics[m].val;
>>>>                 int r;
>>>> +               __u64 ratio;
>>>>
>>>>                 if (!metrics[m].selected)
>>>>                         continue;
>>>>                 printf("%18llu %-20s", val->counter, metrics[m].name);
>>>>
>>>> -               r = metrics[m].ratio_metric - 1;
>>>> -               if (r >= 0 && metrics[r].selected &&
>>>> -                   metrics[r].val.counter > 0) {
>>>> +               r = metrics[m].ratio_metric;
>>>> +               /* r == 0 is a special case for run_cnt */
>>>> +               ratio = r ? metrics[r - 1].val.counter : profile_total_count;
>>>> +               if (metrics[m].ratio_desc && ratio) {
>>>
>>> this ratio_desc-based thing looks suspect. We used to check .selected,
>>> why did you change this?
>>
>> We checked .selected on the metrics[r] (denominator metric), with run_cnt,
>> it does not exist.
>> Checking ratio for zero, merges 2 checks into onet:
>>  - verify no division by zero
>>  - if ratio is not zero, that metric[r] has to have .selected == true,
>> otherwise how did we bump it.
> 
> ok, makes sense, thanks for explaining!
> 
>>>
>>> And tbh, this whole ratio_metric would be much better done with enum,
>>> where you can have -1 as "NO_METRIC", -2 as "RUN_CNT", 0 - cycles, 1 -
>>> instructions, and so on.
>>
>> That'll do. But feels a bit awkward:
>> metrics[] = {
>>   ...
>>   {
>>     ...
>>     .ratio_metric = 1, /* But really mean METRIC_CYCLES which is index 0 */
>>   },
>>   {
>>     .ratio_metric = -1 /* But really mean METRIC_RUN_CNT which is -2 */
>>   }
>> }
>> The core difficulty here is that .ratio_metric default initializes with 0 and
>> stands for NO_METRIC, then all indexes in .ratio_metric are shifted by one.
>> Alternatively we can explicitly set .ratio_metric for every element, but
>> that makes default initialized not safe (.ratio_metric == 0 means cycles, but
>> .ratio_desc is NULL).
> 
> I personally think that explicit .ratio_metric = METRIC_NO_METRIC or
> something like that is just fine to do and not a problem.
> 
> But if that's a problem, I'd still do enum, just make zero a "NO
> METRIC", and shift everything else by one. So basically what we have
> today, but explicitly named (and with small comment next to enum we
> can explain that shift-by-one convention).
> 
> Your choice, my point is that plain numbers make it hard to follow
> what's going on, and really here we have a limited set of explicitly
> connected things, so enum is the way, IMO.
> 

I'll respin with enum, thanks to taking a look.
> 
>>>
>>> then in definition of metrics array you can use explicit
>>>
>>> [METRIC_CYCLES] = { .name = "cycles", ... },
>>> [METRIC_INSNS] = { .name = "instructions", ..., .ratio_metric = METRIC_CYCLES }
>>>
>>>
>>> makes everything consistent, explicit, easier to follow, wdyt?
>>>
>>> pw-bot: cr
>>>
>>>
>>>>                         printf("# %8.2f %-30s",
>>>> -                              val->counter * metrics[m].ratio_mul /
>>>> -                              metrics[r].val.counter,
>>>> +                              val->counter * metrics[m].ratio_mul / ratio,
>>>>                                metrics[m].ratio_desc);
>>>>                 } else {
>>>>                         printf("%-41s", "");
>>>>
>>>> ---
>>>> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
>>>> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>>>>
>>>> Best regards,
>>>> --
>>>> Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>

