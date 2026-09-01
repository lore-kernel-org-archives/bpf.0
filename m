Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15293416D17
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280126; cv=none; b=MuXxAiAIc5B3kJsIGIXD46Wxwogi7UjkR2eJ5p32NDI3F2N5R6n7TxSL6Ches/LFgnPL+X8WZFVWqbQS0eyTHC5cmH3Aa5FA9FOOMWHYXSJO+em2tp+L/RoX8F7DawKHE+SC7MUHvnUIfiklmlidjookfa07lXKd63eGikFIf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280126; c=relaxed/simple;
	bh=DGlQaJouU12Xz0VvfP3P855bPINLw9yX2fuQBgTlc7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlF1eE1Nc8rDwRFpopPjhgidZixjm/1yogDngnMEOvW1Rp+gepTYZr8y1Z4VYGkpDcZkRRyZRdsNCtTMOTjZkcX+TxckZxY2C1XtJg97OnIhl0S/mLjtGBiFC702xE2LYmjzWgHAQQTVQOZnv3wiq3b8pUrJSBMmrDHEPGUdyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZZg3flP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZZg3flP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f96c5b722so75558f8f.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280123; x=1788884923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikPHd4GvjcaF9SVjEjyoAML2KD/nVYuWshwLZ/rccI4=;
        b=VZZg3flP4u9/+YouPjIzIVo5Remr8+ndsKjC4bQ0JOQ9RArLyw9V13hkqcpFAayKQx
         rYR0ErZVwpvh6A2/imER2/Uz7e0yq3K3JzacYNHxbfKzSX8z+THzSNuRsVDMiOlBgmH/
         BNiY6WjpIBDUpOW67obfdCpA0teocHpN63ju1gIt2y3qlydTblfACFSKKD4lAgKYdCla
         bgG+scf1DEUEauYMFRO1hpaexGnKNHRTBuxABfBXxo6WTFtl8D/CzZNuiSI6B1G/jf6a
         rhaRv3AU1D8RHC+i/PqdCWdo1ADuuqDrtPZ3bnyCFenXNLu9vlkZj1GnGjf5CNUgdotT
         Pblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280123; x=1788884923;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikPHd4GvjcaF9SVjEjyoAML2KD/nVYuWshwLZ/rccI4=;
        b=PlRdXHii0x1Qy5izFN8nGk5MIAUoUH+1zCaqybh//aFRPejCi3DM1R+wT8qf19pacF
         1Aikp9IXZpHvHShXpWo/HApOA1HUMd8A1IrkXDb/1e93OgW5/v5AsM/NGeFexDlhxbWU
         TVUvkMD13PVGE80xUWnJw9wU8xzAi+KVxKrRf5njLRbS45mDHyxasI/IrgYxf/pKLR3n
         rr+8aTed7/SYzihq0W9fOh2HYzuKQQUUa+UkknYz0lTq8WC6uPTU4TZSoXI86uasXi3p
         6ygk0vpccxHXDMS7JVq8UFYtbhj5SpOe9lNEvxHB5hXv/InpcVrOOmHSSXMKH8ht3zoH
         XRPg==
X-Forwarded-Encrypted: i=1; AKwUvBxeSkTAL0B+Hrdvz+SRITxCtPsPNL1fhUE7lU1IrakG7kzuLn2ianFy921TkjN4xSRaf/4=@vger.kernel.org
X-Gm-Message-State: AFuF++kjCE7aWO+00dXM97ncNIT4ygM+oLKzQmq3s4DOqIorCAGNvSSW
	bMWPIo2rxBLeLsvQQiTX8W0To7yuPt7GYBkLYr1bRoSLOoGOjs4Niikc
X-Gm-Gg: AYBFou0L8UKudjiu08YZgUtPMcdg3uFjyHdFFlBo8rmfJbxkQO2SK0RvmnYZAr8QSNu
	8jlsjcWAWsVgUWun926VdIoe2XE2CJ6KC3iwPR3MvFbx3YGkiJMsQUbIDYkhjoe3eUfHoo7dEHb
	fF2OGSc7gbkSPMToXYMY6vOHa8Guex0p8u+mmxjYC6qsL/K8SWbkwsmXzc8QsiYj8pYCDYIQNXi
	KmLgCo+Ez1/NAYlsgzoVjXLk73fK2FNauR0WTDd/VymbVd3TaLTL2SbWjpuBKAMuoiqCsXXFSul
	1u8WihTkbpS5cH9v5LFrKyt48wDtsH+neX+CuQ6smIBCAMrsfNEQJFLURf6/gkk3tCJHjPkV2dZ
	XXkzkSWIitj6H5uLf9zSgOpF76e8ngsZiWPQN51dbauiKuPRmVvXjh1HEALIR4AIZqh50LbAMv4
	zRT15uJ3x3x8UGa15/DBWN318WQ8Av5Zi9yu/HQFavzgh+WK8RwVctNjuHT/Z6ybwr6e3CKZ6zr
	uEpZQU3F1UyFspW90LlOMArxw==
X-Received: by 2002:a5d:54c6:0:b0:47f:4919:d5b2 with SMTP id ffacd0b85a97d-48440fcee78mr14457075f8f.1.1788280123032;
        Tue, 01 Sep 2026 09:28:43 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:f403:a537:85fc:d569? ([2620:10d:c092:500::6:3965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3716sm98759f8f.22.2026.09.01.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:28:42 -0700 (PDT)
Message-ID: <02e9a006-4543-479b-aab1-f4310e59aafb@gmail.com>
Date: Tue, 1 Sep 2026 17:28:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Print average cycles per program run in
 profiler
To: Suchit Karunakaran <magneto712003@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com>
 <3258a85d-3578-4982-bd4b-bd516d9bc8b5@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <3258a85d-3578-4982-bd4b-bd516d9bc8b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/28/26 7:46 PM, Suchit Karunakaran wrote:
> Hi,
> 
> On 8/27/26 8:59 PM, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Total cycle counts are difficult to compare across workloads with
>> different run counts. Report cycles per run to expose the per-invocation
>> cost directly.
>>
>> Example:
>> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>>
>>              423256 run_cnt
>>           947413975 cycles              #  2238.39 cycles per run
>>           333965846 instructions        #     0.35 insns per cycle
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>>   tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> index 90fa2a48cc26..2280dc4492c0 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>   bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>       Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>       user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>> -    the profiling will run up to **UINT_MAX** seconds.
>> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
>> +    selected, plain output also reports the average number of cycles per
>> +    program run.
>>     bpftool prog help
>>       Print short help message.
>> @@ -360,7 +362,7 @@ EXAMPLES
>>   ::
>>              51397 run_cnt
>> -      40176203 cycles                                                 (83.05%)
>> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>>         42518139 instructions    #   1.06 insns per cycle               (83.39%)
>>              123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>>   diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index a9f730d407a9..8935508f955b 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -2069,9 +2069,9 @@ struct profile_metric {
>>       bool selected;
>>         /* calculate ratios like instructions per cycle */
>> -    const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
>> +    const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>>       const char *ratio_desc;
>> -    const float ratio_mul;
>> +    const double ratio_mul;
>>   } metrics[] = {
>>       {
>>           .name = "cycles",
>> @@ -2080,6 +2080,9 @@ struct profile_metric {
>>               .config = PERF_COUNT_HW_CPU_CYCLES,
>>               .exclude_user = 1,
>>           },
>> +        .ratio_metric = 0,
>> +        .ratio_desc = "cycles per run",
>> +        .ratio_mul = 1.0,
>>       },
>>       {
>>           .name = "instructions",
>> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>>       for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>           struct bpf_perf_event_value *val = &metrics[m].val;
>>           int r;
>> +        __u64 ratio;
>>             if (!metrics[m].selected)
>>               continue;
>>           printf("%18llu %-20s", val->counter, metrics[m].name);
>>   -        r = metrics[m].ratio_metric - 1;
>> -        if (r >= 0 && metrics[r].selected &&
>> -            metrics[r].val.counter > 0) {
>> +        r = metrics[m].ratio_metric;
>> +        /* r == 0 is a special case for run_cnt */
>> +        ratio = r ? metrics[r - 1].val.counter : profile_total_count;
>> +        if (metrics[m].ratio_desc && ratio) {
>>               printf("# %8.2f %-30s",
>> -                   val->counter * metrics[m].ratio_mul /
>> -                   metrics[r].val.counter,
>> +                   val->counter * metrics[m].ratio_mul / ratio,
>>                      metrics[m].ratio_desc);
>>           } else {
>>               printf("%-41s", "");
>>
>> ---
>> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
>> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>>
>> Best regards,
>> -- 
>> Mykyta Yatsenko <yatsenko@meta.com>
>>
> I think val->counter be normalized for counter multiplexing before dividing by profile_total_count? val->counter contains only the cycles observed while the event was actively scheduled on the PMU, whereas profile_total_count reflects all program invocations across the full duration. When val->running < val->enabled, dividing raw val->counter by profile_total_count undercounts the true cycles per run. Should we apply scaling before computing the ratio like below?
> if (val->running > 0) {
>     double scaled = (double)val->counter * val->enabled / val->running;
>     double cycles_per_run = scaled / profile_total_count;
> }
> 
> We can actually see this in the example:
> 
> 51397 run_cnt
> 40176203 cycles          # 781.68 cycles per run (83.05%)
> Here, 781.68 uses the raw unscaled count during the 83.05% runtime window. If we scale it to 100% estimated coverage, the true cost is closer to ~941.22 cycles per run.
> 

Not sure if it's a good idea to scale just this metric. 
I understand the existing metrics and ratios have the same problem. 
I think we should scale all or none.

bpftool on its own does not use too many PMUs, so most of the time
this problem should not manifest: it only bites when other profiler
is running in parallel. Andrii, Quentin any thoughts on this problem?


