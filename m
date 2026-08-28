Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940E37A4AF
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914867; cv=none; b=lKUkFP8Vltg/JGPRdnsSzxaFeqQIywS+V1P0XWgwbJe55I80FZdm27zQsSSX/SMsyZyE0pxrr/XCNXU0/10vtcLKjNpmVIQnFs5SJo49bHJkMhuxDzwBWhzcwyIneJQuCZ1hWRDqOpH/hewEomFUSy+1OzmCk+h3eOUouYCbSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914867; c=relaxed/simple;
	bh=5clv33U8CkRMAdY37sotifXmC3NTWyEi1yvXVmCiDbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6h3JYNiqkn0L9vKFWrn0z1zc3akbBnicHBmA+TwyhrVwepKzqPDdVTvP2/jP9y5z6CAh+V6GvIUIK4PvM/sZwjeLj91lRKXvzDaQRA7P36OxyyLO4hD1RTn6NyM9L+/HLYRDPPMOXXuCf2IzMfbW/g4QyxPpfscCFwJ1r2EH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d09g672s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d09g672s"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482ddbc11aaso588706f8f.3
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787914861; x=1788519661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mav/GCMPaxuLmqRGjogsNX49q9AwPyFdN8uYBS4WVyk=;
        b=d09g672sfKNW3JSft6aqKq0X3uXx9mnSyW+piwEMGLJESAwZZaokGNpUj/o+zwRFFE
         Ko57nVN03OdokiFiKi2fQc1sNaVcCeZdd2QZpziEiaoSfJt75CPlGhveQ/TbPjcMUtyE
         XUlC1S8zvvfPlVOiLPL3KpiFMmPlOByesC7oPCoKusdZta9vJw9L08nwhLC5ODgz5OrI
         lN58gKX5Dbvme8WT06ZA/VHyegSnbAE63H5Wj7tQH9iY/hS3bqe3qu63xy7OY9/RmF57
         +zdTJ1p/c+TMrUO6sj9qBOysozmlxUOF+2B+I6hPN1MzRcQy4yGrJu0Tz7vuIVrk4Kuc
         rIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787914861; x=1788519661;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mav/GCMPaxuLmqRGjogsNX49q9AwPyFdN8uYBS4WVyk=;
        b=ZAW6nedadEl2MVW/GmG5eu0OEV/h30bbm0fFluHyHMCvt7PcBPGtgiFxLhVe2oQWYY
         8FPG7VhRcXou6g0+kJv14qXiPRm7ezBFqmDbc9eXJ5pcAvciJj+VGw4Pa/oUiN3c4bUy
         O2x6rtcliXov4s+ddkz8oUvgEDpOjET3gfhaezdqWyhldZtGfa4ImuqxdC6+1WLnud+S
         yvf6Tc5M1yekaGZN5phYe0QiLHQ8P7NulZWJnvvdJzbnAVzBMHAAJrtz7aza8u1xBu/3
         OrvCYJ4R7UHrmHVt0Ref+sJZS4nwgF8zQ0x/oEjNSmS04/0JoXZlhAwe9hBnl4sTDTaT
         FU5w==
X-Gm-Message-State: AFuF++l8jvYFT477O0jVy8d4lxo3t9wToa5LwrCo7iKzT8n9JbLCQC9E
	nFKsVQhydNNVjyZavGbeNm4YzHfwmunp7u7inFC1hXYvm2Ar16DXDVDD
X-Gm-Gg: AR+sD13qwXY19WtPlbhpkyNJ9khP6Px6cc5Z8Dsv7FObDLluyxry9XldB7uDuYJbvOe
	rwdn+lhXvV668Dj6ZXlOq17JicJm6c4snjdcORRveja7zE6hQm5ExbnyZfxIm6nc1DqPbr4UFEe
	fPl5gKoQ8Mt7kjgqSTIdC8hOHfu/aDcsq0UimYqbhsxVBoTbeb0MiZjzALXIEKv+/6Knkx0HzMz
	cciEXdZA+b2d41q6hpZIJKFc8AYXmqznF8WtygsV6qIud1mj6ZzmdF0UhMUU7aSn98ltNlii9PR
	wCmQX8Ue/mBBnS89BKkI2nGOH+en3Ii/Cx1V5A7TIzdRi9jISdm9gvlJrcrY7dV1OgxSIXEqyrn
	g6uXjACI6c5R3vJA/Xg4A9e9mRZnVX35lzDD49yEBzKWHDBDRPhQQF4lvdmk2Y9to9Vsk4P4Hwa
	Apcq3/n53BfviOPUJsCtQ2x0Bvifl0JoG63X71sDU2spLBKt6QR/09VkSv15jXgwtN7jwqa3Yv4
	2b2immJZ96qDidi2yM4ImUWldH89EZkKOapGiR4OX9EsRCLEqmqrf6iVls=
X-Received: by 2002:a05:6000:310e:b0:482:984d:fdd2 with SMTP id ffacd0b85a97d-482f79ff052mr8177060f8f.20.1787914860667;
        Fri, 28 Aug 2026 04:01:00 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fba3cf65sm6703589f8f.0.2026.08.28.04.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 04:01:00 -0700 (PDT)
Message-ID: <6e864df5-4fd0-4ae5-a8c6-d2abb9f818d7@gmail.com>
Date: Fri, 28 Aug 2026 12:00:59 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzaKFk9yu10P9bXOE9i=hD8SO+_XfvPbnEBU7cd+eLDVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/28/26 1:30 AM, Andrii Nakryiko wrote:
> On Thu, Aug 27, 2026 at 8:29 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Total cycle counts are difficult to compare across workloads with
>> different run counts. Report cycles per run to expose the per-invocation
>> cost directly.
>>
>> Example:
>> sudo ./bpftool prog profile name mprog duration 15 cycles instructions
>>
>>             423256 run_cnt
>>          947413975 cycles              #  2238.39 cycles per run
>>          333965846 instructions        #     0.35 insns per cycle
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  6 ++++--
>>  tools/bpf/bpftool/prog.c                         | 18 +++++++++++-------
>>  2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> index 90fa2a48cc26..2280dc4492c0 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>> -    the profiling will run up to **UINT_MAX** seconds.
>> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
>> +    selected, plain output also reports the average number of cycles per
>> +    program run.
>>
>>  bpftool prog help
>>      Print short help message.
>> @@ -360,7 +362,7 @@ EXAMPLES
>>  ::
>>
>>           51397 run_cnt
>> -      40176203 cycles                                                 (83.05%)
>> +      40176203 cycles          # 781.68 cycles per run                (83.05%)
>>        42518139 instructions    #   1.06 insns per cycle               (83.39%)
>>             123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index a9f730d407a9..8935508f955b 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -2069,9 +2069,9 @@ struct profile_metric {
>>         bool selected;
>>
>>         /* calculate ratios like instructions per cycle */
>> -       const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
>> +       const int ratio_metric; /* 0 for run_cnt, 1 for index 0 (cycles) */
>>         const char *ratio_desc;
>> -       const float ratio_mul;
>> +       const double ratio_mul;
>>  } metrics[] = {
>>         {
>>                 .name = "cycles",
>> @@ -2080,6 +2080,9 @@ struct profile_metric {
>>                         .config = PERF_COUNT_HW_CPU_CYCLES,
>>                         .exclude_user = 1,
>>                 },
>> +               .ratio_metric = 0,
>> +               .ratio_desc = "cycles per run",
>> +               .ratio_mul = 1.0,
>>         },
>>         {
>>                 .name = "instructions",
>> @@ -2256,17 +2259,18 @@ static void profile_print_readings_plain(void)
>>         for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>                 struct bpf_perf_event_value *val = &metrics[m].val;
>>                 int r;
>> +               __u64 ratio;
>>
>>                 if (!metrics[m].selected)
>>                         continue;
>>                 printf("%18llu %-20s", val->counter, metrics[m].name);
>>
>> -               r = metrics[m].ratio_metric - 1;
>> -               if (r >= 0 && metrics[r].selected &&
>> -                   metrics[r].val.counter > 0) {
>> +               r = metrics[m].ratio_metric;
>> +               /* r == 0 is a special case for run_cnt */
>> +               ratio = r ? metrics[r - 1].val.counter : profile_total_count;
>> +               if (metrics[m].ratio_desc && ratio) {
> 
> this ratio_desc-based thing looks suspect. We used to check .selected,
> why did you change this?

We checked .selected on the metrics[r] (denominator metric), with run_cnt,
it does not exist.
Checking ratio for zero, merges 2 checks into onet:
 - verify no division by zero
 - if ratio is not zero, that metric[r] has to have .selected == true, 
otherwise how did we bump it.
> 
> And tbh, this whole ratio_metric would be much better done with enum,
> where you can have -1 as "NO_METRIC", -2 as "RUN_CNT", 0 - cycles, 1 -
> instructions, and so on.

That'll do. But feels a bit awkward:
metrics[] = {
  ...
  {
    ...
    .ratio_metric = 1, /* But really mean METRIC_CYCLES which is index 0 */
  },
  {
    .ratio_metric = -1 /* But really mean METRIC_RUN_CNT which is -2 */
  }
}
The core difficulty here is that .ratio_metric default initializes with 0 and 
stands for NO_METRIC, then all indexes in .ratio_metric are shifted by one.
Alternatively we can explicitly set .ratio_metric for every element, but
that makes default initialized not safe (.ratio_metric == 0 means cycles, but
.ratio_desc is NULL).
> 
> then in definition of metrics array you can use explicit
> 
> [METRIC_CYCLES] = { .name = "cycles", ... },
> [METRIC_INSNS] = { .name = "instructions", ..., .ratio_metric = METRIC_CYCLES }
> 
> 
> makes everything consistent, explicit, easier to follow, wdyt?
> 
> pw-bot: cr
> 
> 
>>                         printf("# %8.2f %-30s",
>> -                              val->counter * metrics[m].ratio_mul /
>> -                              metrics[r].val.counter,
>> +                              val->counter * metrics[m].ratio_mul / ratio,
>>                                metrics[m].ratio_desc);
>>                 } else {
>>                         printf("%-41s", "");
>>
>> ---
>> base-commit: 23ff631b3b8b1452dfe933ee21f96321a9c5e209
>> change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7
>>
>> Best regards,
>> --
>> Mykyta Yatsenko <yatsenko@meta.com>
>>

