Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A63B14DE
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945580; cv=none; b=s+faUxCOMV9LlCI7qayIPt2CcuxE0cROW+TYzLJRzcbSzWvge1r6CMfdmQjgc9gDR4vz+ALDWEnAA3LtNvEUBWrjZQb7C9PLYWLP1rJljBoglglHCvqD8qDSJAAehUBfRcEdp13qDg9z8cnJGu+TvRHyieYFKDc0/gSKqfZ4qFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945580; c=relaxed/simple;
	bh=AANUG2Fkiony31zysc7K1vyEm4d3ES6no5aVP8yMNjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8BmCIA7kACr5ov93Uh9PYRjUUmRT/ew3NWH8ZEUHNh2uq0DmIkiGyirbOtnExTabmMGagsySnFy6HBFBjvBhSrRHOpUd/UvQMkh4eg8sH5c03n6daE32Ozworzkmu8JL7ggjkyEmJR0hm1OjPajCgMtH0cMgJSqQCyELWcTpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfSMsm/3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfSMsm/3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482dbe4d247so3121838f8f.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788945574; x=1789550374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AHDOad1N4UeccxVypy7aIabm5nwKXZpXx1x5dAIbqI=;
        b=HfSMsm/3XsP9U0nAMZX6G4DzBWSdqtSqWUIm0eQNj8cHdqR/aVc35mgDd25bNBXXt2
         7RKzrO/h/irf11PAn8kL5s6l2mBwoOJUuL8mkkw2/OEDxgrmw4MutveXnvRH8/SlCDqD
         OBPgKEnrh84YOL03jymR+XjvOUCpe1p/RdyrsesVAGyhHqXiawzyapDLJrjg0Ud1K0Hw
         KzMgliRVV0lAYal7kkLqvrG2hvaEe5GssaXFzuulSYWKjkdf2TGx3IbXkxDsTxLQpcWU
         6+5vur2o+Y/8bWhdRNiGLjGahFaXxtS+E5RgY+nxrySkKkqTfrN9tJovyWt7hTgwxN35
         oZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788945574; x=1789550374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AHDOad1N4UeccxVypy7aIabm5nwKXZpXx1x5dAIbqI=;
        b=FUTmtcquOt/C2oSoMTP6jGghaPx5s3HtG9lPbysaVez8VYnSB9RjsubcHk+QaKNjV5
         JelB9N6MVFyv17om1t7d9x7imkqyWQe7VISlRNiWpa+HlIxyRhgn6lMRo5b3PxjipifS
         XoBlsrnpHWyru9ss+WgHH/+ifyXVSO0RfiNnWmDqrKjOHbHQ2EUGmmt9YSGG2mxZxSj2
         psVcl/Vri2cgDqA1mnOByDBC0BgdGL7IK+7NvmVqPBmAgaJqW7LEr60OP/qGDiaOdJdj
         OI9OH+vSBy0B/fsOeXf2lZLhsEu8smswwBELq+6UeuAbYc1uFI7TxeBOtfgv6EVspmzW
         eZOA==
X-Gm-Message-State: AFuF++lchEnEm5Hj3laRikBJYpD81wXnX4z8SD7VOAZNZ3AlFn/a9JV9
	oo0O+OP6M30CHWEw7plwQk/cErCfrYBbRDHToXOXMf/h5lTVzUWOprA9
X-Gm-Gg: AYBFou3gl7+yzPwXqbK+B4+ag9CgV5y1coWJjfxVHnPuEF5nDRaurcHmy8Oe0HNh3C+
	X2WDvV8b0zE41jvJ0flBypOcS6HFh0UqFhxim+txJMXaTuQkxWIMfxmq6IxlSsj/HN1S07WLHz5
	9ZQrlxt5ckUnv8GvRjIO46T6jyhdirVFlmAsuKc1taDGE0VBwsT3UeixFparJ7W7471a1AQi3mT
	MgWarXN3/NYUicchn0DKEf22kLZ9xFt4JOewgZaetJEEe706jXLbv6prjgsWv7EVEj0XAj0ESOj
	xz7E40YtJ7uZ/hnlYVp5TPNNSvnL2819VxIVHK/3UL83fDKqKpnx044+xfZcIaqc4vyZ88HF/zs
	7un9vVqiEKL4EwGYRZr86WaqSv3rdt28c3205BvqQT0LzZDnVYvBRUUXZt4FBsZahmF8ERgNcBg
	h7hiR2LnTLa/hIUeyMB5hq9Js2upzlKbS2Gy1cwSRMYffGnNQ6pDtEh4s9I68TbwNosOSS9qeqw
	5yHgGMxNaRsRGHJmXyrsfRBzGFXFdSK6P9YtIMRZJeDCIID6g4swwJSaGU=
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr593719355e9.6.1788945573356;
        Wed, 09 Sep 2026 02:19:33 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3? ([2a02:8109:a307:d900:dabd:d9e2:64b7:dfc3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm373554075e9.9.2026.09.09.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 02:19:32 -0700 (PDT)
Message-ID: <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com>
Date: Wed, 9 Sep 2026 10:19:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot
 state
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
 <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
> On Tue, Sep 8, 2026 at 7:27 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> A perf counter can be zero at fentry. PMU multiplexing can schedule the
>> event during the BPF program. The old counter check then drops a valid
>> sample.
>>
>> Use an armed flag to track each successful fentry snapshot. Reset all
>> flags before new reads. The fexit path clears each flag when it consumes
>> the snapshot.
>>
>> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> index f48c783cb9f7..6c654bd9b346 100644
>> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
>> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
>>         __u64 running;
>>  } __attribute__((preserve_access_index));
>>
>> +struct profile_reading {
>> +       struct bpf_perf_event_value___local value;
>> +       bool armed;
>> +};
>> +
>>  /* map of perf event fds, num_cpu * num_metric entries */
>>  struct {
>>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>> @@ -21,7 +26,7 @@ struct {
>>  struct {
>>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
>>         __uint(key_size, sizeof(u32));
>> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local));
> 
> this is not a bug, but... ;)
> 
> 
> struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
> ___local variant?...
> 
> 
>> +       __uint(value_size, sizeof(struct profile_reading));
>>  } fentry_readings SEC(".maps");
>>
>>  /* accumulated readings */
>> @@ -45,7 +50,7 @@ const volatile __u32 num_metric = 1;
>>  SEC("fentry/XXX")
>>  int BPF_PROG(fentry_XXX)
>>  {
>> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
>> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
>>         u32 key = bpf_get_smp_processor_id();
>>         u32 i;
>>
>> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
>>                 ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
>>                 if (!ptrs[i])
>>                         return 0;
>> +               ptrs[i]->armed = false;
>>         }
> 
> this is preexisting, but why do we have two separate loops: first
> lookup up fentry_readings pointers, and then separately a) reading
> perf counters into local variable just to b) immediately copy it into
> map_value.
> 
> can you try simplifying this and doing bpf_perf_event_read_value()
> into ptrs[i] directly? all within the same loop?
> 
> it might have been some verifier issue, not sure, but I think this
> should work just fine
> 
>>
>>         for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
>> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
>>                                                 sizeof(reading));
>>                 if (err)
>>                         return 0;
>> -               *(ptrs[i]) = reading;
>> +               ptrs[i]->value = reading;
>> +               ptrs[i]->armed = true;
>>                 key += num_cpu;
>>         }
>>
>> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
>>  static inline void
>>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>>  {
>> -       struct bpf_perf_event_value___local *before, diff;
>> +       struct profile_reading *before;
>> +       struct bpf_perf_event_value___local diff;
>>
>>         before = bpf_map_lookup_elem(&fentry_readings, &id);
>>         /* only account samples with a valid fentry_reading */
>> -       if (before && before->counter) {
>> +       if (before && before->armed) {
> 
> this is such an unlikely situation that I wouldn't even bother
> "fixing" it, tbh. alternatively we can check enabled or running for
> zero, I don't think realistically enabled can be zero if we actually
> captured it an fentry

Here we check before->counter for 0, substituting by enabled or running
will still have the same risk of dropping the first sample.

I could reproduce it by: 
1. make PMU busy with 4 events to force multiplexing
2. then quick profile for 1 second
Result: first sample gets dropped, because measurement
at fentry is 0. This is not a huge deal by itself, but the fix is simple enough,
in my opinion, to make it worth. For a pocket change we get clearer flow:
fentry arms the counter, fexit disarms it. 
We have the same code in perf, I thought it would be nice to have this change 
there (more choice of sparse events, subsecond timeouts possible)
> 
> pw-bot: cr
> 
> 
>>                 struct bpf_perf_event_value___local *accum;
>>
>> -               diff.counter = after->counter - before->counter;
>> -               diff.enabled = after->enabled - before->enabled;
>> -               diff.running = after->running - before->running;
>> +               before->armed = false;
>> +               diff.counter = after->counter - before->value.counter;
>> +               diff.enabled = after->enabled - before->value.enabled;
>> +               diff.running = after->running - before->value.running;
>>
>>                 accum = bpf_map_lookup_elem(&accum_readings, &id);
>>                 if (accum) {
>>
>> --
>> 2.53.0-Meta
>>

