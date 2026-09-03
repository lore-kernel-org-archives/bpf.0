Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE14B7140
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446019; cv=none; b=iRXa2TKwdm6Fc6n7N9VrlnWF4DUs1CWdmlq0S8C/YR6M63+LMhKgqN+SfOIQuLq939JgT6hlmaP+OxoWk/RdIUAGqN6nY2G1aoTGRSBAkqUK+cbYK0gsOD1iIzV6x4H/aJQlQpBvkCU2CVARBZ6kFB7/U5WwS6VR0PshIVZw+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446019; c=relaxed/simple;
	bh=rnv/oLrVwSNVF6POKkcgpSLYflhRmY7OzbMCh5mK9Wc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o3af459sPy/aFGp/fV/LBRsxsg2SjhOrP3jTK56Q0uNlitpfqbczl9Hw8VYDViRm4BMry9WdGqrQzuluzAzs2KmUlO+E6X/4lkpeoqTCf9P7CHUC70p8Z0LvhDvqEyK9cCVq3BqUY5fYCPKUj73yvj0CDlKD5D84WQoXxAbXumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcLlbqdM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcLlbqdM"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a1f628b0afso19904961fa.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446007; x=1789050807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+rTuHWP3FLJJqJi26B6Y+AYvIs9JI1Pi3ER/YamNEg=;
        b=VcLlbqdM+QWswEfxoDciHsfTlba5EQ57QT+ug+u4mVahhteGRjsv0gg63LhHpSF7OT
         1V31qBRDxbJr8ghlFrG88lg1ju6x384Dk6mQ4LdS9q18PlbuJXbo+pLnhKsaZ3IKQJRa
         dLQ7i4itdV+vzz1WmilQ+B5LPW8NH6CPty5QvdPmumA2bCJDkSrvFWuK7GwcXoMZbRzJ
         9BoZ4OeY3LkarEG3lusZDgeWU42LzxVEW9dJBC2xpbIjFO0RsKs1Kf0ZTaRE2uSJs8+s
         UiEnnQ5WDaAufltBEj0h52tzrWmQay6thOLXSmVxbVKj6M/q9lOeMa0+dQMmQYWMqDUc
         rDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446007; x=1789050807;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+rTuHWP3FLJJqJi26B6Y+AYvIs9JI1Pi3ER/YamNEg=;
        b=L5q1uqNnoRS6W8/OyG29Zi1vfAkSWRlx05hWDb3AD8dQ00V+Kq9AinVrFTbxb9jIhm
         yR6rXzQcDzWxOFXwGmdoylNBTe3SCopZbeTBDHnpqt17XR1f1r1bv3+jDQ5oeYD4jUbQ
         XhIysm4mhB3VNCZzN9yA9n8IkdU/mQSPxOIAKoOsM9jfynhq1hKo6L118wF87beWYFeB
         CbhdTin2koMaXaR4vXSynpyvpunOGvUmLyjivu+/OVv4WI/TiVM21X9uBZ4seXwhPj+q
         BnEONVuykrGwuCBC2tLiBr0Lvy0PDRF/KtoMi3zL2Lzn9W9GYfZD8Snn5zGjqw5PPdmi
         X6FQ==
X-Forwarded-Encrypted: i=1; AKwUvByvx2V23dxve10cWj1Pj1Ymz91u0e1bMFWnAa/uoZpSMUJXqestny9fmQWP3oxWD7KgHNY=@vger.kernel.org
X-Gm-Message-State: AFuF++ljN9SlOfVlXARb88WHbt+aDZU+umsUMlF5+DQh6YnVneOTj+1w
	y8ECTqLyrX6Cgva5vPOYFWVbWFh1fCKeYzQFcWNg4LISCA9nSld/FkDN
X-Gm-Gg: AYBFou0MqhAfA1CtGgNYMAMi7WZ5OXrqFRcmBsmYXej23DAi6WbMoZ3HIx6xORhrEfA
	40tpw36wSpohH3LDoAPD1iakuFFDOhqbm6ZB2Tw4Eb35MjJFJzbQNd5htRWg7U5+bNxlEpcZujC
	iAoJZhNENiLx8ShV337aSfAvJHUUPzsaa1w4kA+18M67mSh/zqfQ6lF7NLD+tP1l6IcUoMiamDU
	nBiu67+fuEX1pwQJEdm1FRGzcJypLBGi/GAiBIXcAIoaSA5s901dkKtc605kvcNwivy2Hl6tiLg
	yTmJvroRuB1iiVQpbCdw9DsmnBvfUO+JJCyAiPYTLLT67JdATHUdzpsgkVkHnQqjS3mX6Y51lhf
	q0ACZjo7ZeMF5B/KfwP6UylvUQsiHIYk5qTItrM7pE6HLT/3todIaGYuSK6h6QhRkO9uQ6BrP6q
	XWbtCMed85XmZaBtG0BYlImsVReJnnDqBMExBVnLOapueX2djRaJtaccxBV48fV00oCexMwjKs+
	nb9F31vwM6tyuqeDrVPWvNkt0sCARucICopFi7BltlITKw=
X-Received: by 2002:a05:6512:acb:b0:5ae:b969:417d with SMTP id 2adb3069b0e04-5b6154ed888mr258642e87.0.1788446006358;
        Thu, 03 Sep 2026 07:33:26 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:c0df:8063:3b00:b779? ([2a02:8109:a307:d900:c0df:8063:3b00:b779])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b606b1c3e7sm1363929e87.18.2026.09.03.07.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:33:25 -0700 (PDT)
Message-ID: <4adbd22f-886e-4497-a6da-55514a1d5fba@gmail.com>
Date: Thu, 3 Sep 2026 15:33:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Scale multiplexed perf counters
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
 <e4f884edb778504fcfe32060a39e6ac6e7f7244c78388fae803562208887eea0@mail.kernel.org>
 <17835286-3b20-49ec-b5a5-4e5944073282@gmail.com>
Content-Language: en-US
In-Reply-To: <17835286-3b20-49ec-b5a5-4e5944073282@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 7:14 PM, Mykyta Yatsenko wrote:
> 
> 
> On 9/2/26 4:20 PM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> index 90fa2a48cc26a..2280dc4492c06 100644
>>> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>>>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>>>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>>>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
>>> -    the profiling will run up to **UINT_MAX** seconds.
>>> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
>>> +    selected, plain output also reports the average number of cycles per
>>> +    program run.
>>
>> [ ... ]
>>
>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>> index a9f730d407a92..ad6d33f838e3c 100644
>>> --- a/tools/bpf/bpftool/prog.c
>>> +++ b/tools/bpf/bpftool/prog.c
>>
>> [ ... ]
>>
>>> @@ -2185,6 +2200,7 @@ static int profile_parse_metrics(int argc, char **argv)
>>>  static void profile_read_values(struct profiler_bpf *obj)
>>>  {
>>>  	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>>> +	struct bpf_perf_event_value *val;
>>>  	int reading_map_fd, count_map_fd;
>>>  	__u64 counts[num_cpu];
>>>  	__u32 key = 0;
>>> @@ -2209,6 +2225,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>>>
>>>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>>  		struct bpf_perf_event_value values[num_cpu];
>>> +		double scale;
>>>
>>>  		if (!metrics[m].selected)
>>>  			continue;
>>> @@ -2220,9 +2237,22 @@ static void profile_read_values(struct profiler_bpf *obj)
>>>  			return;
>>>  		}
>>>  		for (cpu = 0; cpu < num_cpu; cpu++) {
>>> -			metrics[m].val.counter += values[cpu].counter;
>>> -			metrics[m].val.enabled += values[cpu].enabled;
>>> -			metrics[m].val.running += values[cpu].running;
>>> +			val = &values[cpu];
>>> +
>>> +			metrics[m].val.enabled += val->enabled;
>>> +			metrics[m].val.running += val->running;
>>> +
>>> +			/* This counter has never been scheduled */
>>> +			if (!val->running) {
>>> +				if (counts[cpu])
>>> +					p_info("%s not scheduled on CPU %u; results may be inaccurate",
>>> +					       metrics[m].name, cpu);
>>> +				continue;
>>> +			}
>>> +
>>> +			/* Scale counter values to account for perf event multiplexing. */
>>> +			scale = (double)val->enabled / val->running;
>>> +			metrics[m].val.counter += val->counter * scale;
>>>  		}
>>>  		key++;
>>>  	}
>>
>> Does this change the semantics of the JSON output? Looking at
>> profile_print_readings_json() in prog.c:
>>
>> profile_print_readings_json() {
>>     ...
>>     jsonw_lluint_field(json_wtr, "value",   metrics[m].val.counter);
>>     jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
>>     jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
>>     ...
>> }
>>
>> Before this commit "value" was the raw counter sum and "enabled"/"running"
>> let a consumer apply the correction value * enabled / running itself.
>>
>> After this commit "value" is already scaled (multiplied by enabled/running)
>> while "enabled" and "running" remain as raw sums. If an existing consumer
>> of bpftool -j prog profile applies the documented formula - value * enabled
>> / running - it would now double-scale the result.
>>
>> There is no new field and no version marker letting a consumer distinguish
>> between the two output formats. The changelog says only "Scale resulting
>> values similar to how perf does it" without mentioning the JSON output,
>> and the .rst hunk explicitly scopes its wording to plain output ("When
>> **cycles** is selected, plain output also reports ...").
>>
>> Should the JSON "value" field stay raw to keep the interface stable, or
>> should the scaled/raw split be made explicit with a new "scaled_value"
>> field?
>>
>> The same asymmetry appears in plain output. profile_print_readings_plain()
>> still prints the raw multiplex percentage next to a counter that has
>> already been corrected for that percentage:
>>
>> if (val->enabled > val->running)
>>     printf("(%4.2f%%)", val->running * 100.0 / val->enabled);
>>
>> which reads as if the correction still has to be applied by the reader.
>>
> 
> This is a good point. I don't think we should scale for plain output, but not json.
> But otherwise we potentially break users.
>>

Discussed with Andrii, we'll scale for stdout and keep existing behaviour for the json.

>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33641892894
> 

