Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA742AA9
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307641; cv=none; b=uJoaJ36QEvz1HXKJpSxkbvJVjguCUp0tcG4t3/f0e9qUlezINBKoDZS5lSjVXy1BpmBX4kVvuZWjWtVvww7lpBoZc5Gv3JuLSMnWSbev1OweRZVrkBrT+IpN7p3WdrD6yo91qT6warqXCl2h68qZlk4+zcz3DQI0S6VBwfvv4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307641; c=relaxed/simple;
	bh=37337YsOxuaGMVuOpCoKLwl07samA36icPiQF75AM+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTTGD0hJiI49M5ORUKoVmZDGNsryA8jUI2ubAXP+160oh7YYW/FkivdKQzMZ7phO9x41DohmiX3ES+ws+v95hfXbE+5EDJpoLY0cf4PpgSFvHxbvCABZY5UBTonRIqHZhzhds6yFvezYnYl0g7qhp/6wrIKMtNCmmWNbtVauJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMT8vvec; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMT8vvec"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482dd6ee390so477297f8f.3
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788307638; x=1788912438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5SEgSFChnORI9uJCS4IoToikSK6zzXUugq6ShDbcPU=;
        b=pMT8vvechOa/AL5T6r7KHYir3nccaLvyJRqOvcXcy/tROt1qxCOjgiywUvaKU0HlCD
         Jo9QSR5zlwArIsvxHiJ+BdXKNqqa7Ct05wc8NVdICG7KBCeAklLCo5kJF8cstFUYhc2y
         FgVXsBJdrZyCEggTMjUk8Ushug1G7KhxTxR1sceqtMRaD2hIatEiQZIzmmT6+ZkQk6pR
         1dQZ+sIjGSGuGkYRJEAmybvsoAhvqGgxZEbOEEoYwSGlCcyzw/ZpQwwn6YBMog8GoxX4
         IlA8bxBCWyPDPXdbPJeA8V1rPk0z/jjmAu7Er7G0K11Bon7pu0OoMtO3NaiNrKEMN03x
         IkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788307638; x=1788912438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5SEgSFChnORI9uJCS4IoToikSK6zzXUugq6ShDbcPU=;
        b=UnIV+k8WYI134fhC693L3drNI9u8Mrw67m9HICtZaCEd9dF/DSxcOEHv1Xga4foY/x
         yxt7BNQlOvVN/RDW3EYxomM4VlJPf5ABq1OL0pxVSoBlzP0Huofn5L8HqH4BAPJYqpdu
         v+6Y2E8TkLQKb0aGtB1EvJs3Ph80jvw6/2vUCV9gEhdjCbrMV+FwzefrzSPMSCfQnWw3
         EdnJY6CjaK8lrpiPoFUD4uwXqWvdrfIDKFTt150OildTqlbAF4PzawbiAQ862t4ky+MY
         3dgcKJGABZJpOwYXfq9Oxl2LYST5pBN6rDYs+LiYZOfJWIaQ+Ox0LWn44jR3RU/vGkde
         trqg==
X-Forwarded-Encrypted: i=1; AKwUvBxug2cz9TRowhxpZd71RFu/CPZLbX8oLc8tqV3WgxiBVJ2BE4M2jdyytXjiIC6veUCKq+A=@vger.kernel.org
X-Gm-Message-State: AFuF++lgVhjAUeHs7LWW5fQ89/1Aq5ZtqTxsPZAS1NA1jWYddmjRNQFu
	Gt79ZQqNLI15Cah1nnIYFouRMuTjMlgnobwTjRMDsHdTECG85kdrCWV5
X-Gm-Gg: AYBFou3WDELm1qjVWuQz7LqNFr3a/Ft9PqSvmbn91GeUC8r6+lRyoFzxx60cmABpUw2
	ywXxVWj247EVd/pd8pAInwErK4fFX3DJCbhNILB8iCPW8A6ATFehGwkMKcN5pCHXEAIcG9cfcJa
	iYzl6KApwLk/K0Jfr7HtH9ia5830HlCmSL/gOIvHMwdNAGBb/NkBAE8Oh5RCIsXe8MJ9s2RC2iL
	+mlq60N4IKuxZGoZ82k/qFbaAtojpsooJpVcGj1prwoEOjvRFacvWut2TaEFxA81qzcqIJkHfwn
	xjRWK1KjwFCLuCYGc8a8JngC8G2EZD/eokUTB6iSJ3ISsGIMuBo2aPJAUscJihY51br2dCpU4DP
	rZPh4yumeeLUvevNmCeMwQna/AtdpjBmvgyc0X2uuNPM5akvATCre7Z9OhsxgWraWjrS9WFSv59
	Uk53LXc8Cax0W4o3QzbWYrjeR32klSLI5hUbcv0ntuSbWqSDDLc69fq+EeD+FYmljGbEPUbGCE3
	ayrAMByaKEUd9oXpjY8yuiT26iX/l3w/+3Nat+0zbHIJJKq
X-Received: by 2002:a05:6000:4b19:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-48488f0961bmr1375158f8f.12.1788307637570;
        Tue, 01 Sep 2026 17:07:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3840sm2421505f8f.17.2026.09.01.17.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 17:07:15 -0700 (PDT)
Message-ID: <d16d329b-9b1c-47e9-ac02-3185abff2b7a@gmail.com>
Date: Wed, 2 Sep 2026 01:07:12 +0100
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
Cc: Suchit Karunakaran <magneto712003@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
 <3258a85d-3578-4982-bd4b-bd516d9bc8b5@gmail.com>
 <02e9a006-4543-479b-aab1-f4310e59aafb@gmail.com>
 <CAEf4BzY_TdLFKHG2QTtf2R7LHbzs61-kzMe1W3JFdvgOthMWNw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzY_TdLFKHG2QTtf2R7LHbzs61-kzMe1W3JFdvgOthMWNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/26 12:51 AM, Andrii Nakryiko wrote:
> On Tue, Sep 1, 2026 at 9:28 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 8/28/26 7:46 PM, Suchit Karunakaran wrote:
>>> Hi,
>>>
>>> On 8/27/26 8:59 PM, Mykyta Yatsenko wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Total cycle counts are difficult to compare across workloads with
>>>> different run counts. Report cycles per run to expose the per-invocation
>>>> cost directly.
>>>>
>>>> Example:
>>>> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>>>>
>>>>              423256 run_cnt
>>>>           947413975 cycles              #  2238.39 cycles per run
>>>>           333965846 instructions        #     0.35 insns per cycle
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>   tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>>>>   tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>>>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> index 90fa2a48cc26..2280dc4492c0 100644
>>>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>>>   bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>>>       Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>>>       user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>>>> -    the profiling will run up to **UINT_MAX** seconds.
>>>> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
>>>> +    selected, plain output also reports the average number of cycles per
>>>> +    program run.
>>>>     bpftool prog help
>>>>       Print short help message.
>>>> @@ -360,7 +362,7 @@ EXAMPLES
>>>>   ::
>>>>              51397 run_cnt
>>>> -      40176203 cycles                                                 (83.05%)
>>>> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>>>>         42518139 instructions    #   1.06 insns per cycle               (83.39%)
>>>>              123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>>>>   diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>> index a9f730d407a9..8935508f955b 100644
>>>> --- a/tools/bpf/bpftool/prog.c
>>>> +++ b/tools/bpf/bpftool/prog.c
>>>> @@ -2069,9 +2069,9 @@ struct profile_metric {
>>>>       bool selected;
>>>>         /* calculate ratios like instructions per cycle */
>>>> -    const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
>>>> +    const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>>>>       const char *ratio_desc;
>>>> -    const float ratio_mul;
>>>> +    const double ratio_mul;
>>>>   } metrics[] = {
>>>>       {
>>>>           .name = "cycles",
>>>> @@ -2080,6 +2080,9 @@ struct profile_metric {
>>>>               .config = PERF_COUNT_HW_CPU_CYCLES,
>>>>               .exclude_user = 1,
>>>>           },
>>>> +        .ratio_metric = 0,
>>>> +        .ratio_desc = "cycles per run",
>>>> +        .ratio_mul = 1.0,
>>>>       },
>>>>       {
>>>>           .name = "instructions",
>>>> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>>>>       for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>>>           struct bpf_perf_event_value *val = &metrics[m].val;
>>>>           int r;
>>>> +        __u64 ratio;
>>>>             if (!metrics[m].selected)
>>>>               continue;
>>>>           printf("%18llu %-20s", val->counter, metrics[m].name);
>>>>   -        r = metrics[m].ratio_metric - 1;
>>>> -        if (r >= 0 && metrics[r].selected &&
>>>> -            metrics[r].val.counter > 0) {
>>>> +        r = metrics[m].ratio_metric;
>>>> +        /* r == 0 is a special case for run_cnt */
>>>> +        ratio = r ? metrics[r - 1].val.counter : profile_total_count;
>>>> +        if (metrics[m].ratio_desc && ratio) {
>>>>               printf("# %8.2f %-30s",
>>>> -                   val->counter * metrics[m].ratio_mul /
>>>> -                   metrics[r].val.counter,
>>>> +                   val->counter * metrics[m].ratio_mul / ratio,
>>>>                      metrics[m].ratio_desc);
>>>>           } else {
>>>>               printf("%-41s", "");
>>>>
>>>> ---
>>>> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
>>>> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>>>>
>>>> Best regards,
>>>> --
>>>> Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>> I think val->counter be normalized for counter multiplexing before dividing by profile_total_count? val->counter contains only the cycles observed while the event was actively scheduled on the PMU, whereas profile_total_count reflects all program invocations across the full duration. When val->running < val->enabled, dividing raw val->counter by profile_total_count undercounts the true cycles per run. Should we apply scaling before computing the ratio like below?
>>> if (val->running > 0) {
>>>     double scaled = (double)val->counter * val->enabled / val->running;
>>>     double cycles_per_run = scaled / profile_total_count;
>>> }
>>>
>>> We can actually see this in the example:
>>>
>>> 51397 run_cnt
>>> 40176203 cycles          # 781.68 cycles per run (83.05%)
>>> Here, 781.68 uses the raw unscaled count during the 83.05% runtime window. If we scale it to 100% estimated coverage, the true cost is closer to ~941.22 cycles per run.
>>>
>>
>> Not sure if it's a good idea to scale just this metric.
>> I understand the existing metrics and ratios have the same problem.
>> I think we should scale all or none.
>>
>> bpftool on its own does not use too many PMUs, so most of the time
>> this problem should not manifest: it only bites when other profiler
>> is running in parallel. Andrii, Quentin any thoughts on this problem?
>>
>>
> 
> we should scale all pmu metrics, IMO. In our production this is
> actually an almost guaranteed fact that we'll have PMU multiplexing.

Thanks!

