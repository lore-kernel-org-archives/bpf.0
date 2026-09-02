Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB33876BA
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372866; cv=none; b=cWiI2Aa4V54X22/9rU6wg0381Te3rayUjrW5LNJgxVtAOtxR5nmeneNam/6xPeLui5Hoo1+dWCMCyj9ZZLbi0XZD7LDrsJlQemAPI8HKd9SB7irZNnkUlQ+ZSpTHnfxGrRF1EaCDZyonZ+cCOqmuOUqP3flBdogxMswAk9h0a4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372866; c=relaxed/simple;
	bh=JC+oUQPyGanYRmHsk9T1pbgbaEymaePq1HPUC5UPicU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2Dx+qz1jPC4sHXPqSt8wX4/96YHx1C4shRK1iWcfvsSM8zJaqwNNFAHQ/LyJWMyoXHfMBV/sdHnu/KQyIkBHz53PTorcvpxwsn74nSuuVrpwAt095VY8gnMZ5Uv2Fr4kWiiLlGDdFRa3GLrXKwroC5QU2yStke56IsKL7YA/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF7QgFLw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF7QgFLw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441fa5c37so991681f8f.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788372862; x=1788977662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOX96LzgQMuOXvyzFKzh7w79ktA4u+5OoT6rau9u+cY=;
        b=LF7QgFLw/BNgATtxLu7se8RHsIlNlEuRw+vZlF5AjDXfWlZsnEt6t8eqbOMDiP4DRN
         /mli1ocNZjjJaQNOcZWmn4Io31SKpK04IzzLeRFQsR63EXzky7oXGcyZ3zJ2PlpqIfP5
         EkCsGBlhCOJkNpeQWXWc4IiF1z8XHaWbE2TfeDcx8+tqQ7ZtI6KH1FmQ0aiI1v1bDEVd
         TNefmCAypqutnlT+3z8eXUz+Pl8xJRBGnVee0Pamb+jvZold4o7RpViKauIEnWzs62No
         HiaXHPtKI5sEqkEUr+D3vRD40um7Fj6CwGoh2a2LK4PfkNzzdQxrU8XS+sFDn6i0m7hk
         4eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372862; x=1788977662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOX96LzgQMuOXvyzFKzh7w79ktA4u+5OoT6rau9u+cY=;
        b=CNozuz78DLgue5Bjc9DIvs1WAPfyktELUafjIdKyFymHdCBDURkyWWrIaetoEaGnM6
         /lxKd+ZQ6rKKASx07jDOXlcz6lSdaIo4XpPdOsqkpj3VoM3URgJYWy80QzmnTHhbGgb3
         Cv+Pixm+Ql5r5OSsfqu8i9FooBgnviGTWO7Izteq+9wEmPmAO8xDqYgFRdS4rEV3HI9U
         1KTdKGbG3il17FrhDNRwmpZn0UUWS3QX2R3/qtQKDdnDAtkjFrBmYW5rOhmNUOJ253el
         cqTXmtyo5G1U/sVl4zdwOlsbkbi7VLIy8ytfdhlx/ahBvf3XQsqi0QRqZN09ziTYLTnJ
         gVcw==
X-Forwarded-Encrypted: i=1; AKwUvBxjXh6qn/AfBnooGscN9XANd6oED+i8E11tkuMU1l3ey44/AxthUJGYEblTC6c9+W7TVgA=@vger.kernel.org
X-Gm-Message-State: AFuF++m3fssDiTfb0jKW0RXLZYQkNiB7RPCABg8HmS4dqBEPGMc9Gr6s
	tQ+n10G2rBV7Ku82lCMlMQ5e6QHNvbhBeWMmhjtDVTwiJv0Uqps74P/l
X-Gm-Gg: AYBFou11RXY6gE1mIa5VupyINwPCeIRlHkWU2RfOCLNiphXbBmvuE/8J1ihKPnt65fE
	ndfJdzzlgdp1dDCPsgpFOvU5DLOREI19Tj3RQk1q4eTvXn5OdjgeMnKpCPKDXp/BoklHb+HG0Xc
	oy7o7uT/4E08s+CSv9VnzOL51qQgT2JiDh6ULhWiVnRZva/pWB4DU2fVHaGjXQS6bwfJcxAYzXN
	EFu0I7oEMRlj+wB6XchoGc2AVSleXQ8RVRIqY5soyf68w/0dm+ptsWEyhIHvE2CnVPzm8TV8eSE
	ZJvbEbBPtDHG8/dISCk4oFfx0yM6ukH5f9QKMuS7l3G6qsI32NxoSkJ1kQmvaUl6E7ZCg9KlgYv
	kXyEzzeao0KZYehJjzbftC3Ckt99ptrb9iibHr31xwxFLn23QXR3Bo1uxY2hc9yTDEuGsFrxIjm
	TFfi0gumVg9q2d0AIk4W9+HlxtEPb6AqKwhhIaKURi8rUQZbSTqssFjl3pVFP9HihJGR65AbJY
X-Received: by 2002:a05:6000:4716:b0:482:fd9c:3740 with SMTP id ffacd0b85a97d-484913c070emr13029283f8f.22.1788372862072;
        Wed, 02 Sep 2026 11:14:22 -0700 (PDT)
Received: from [10.250.0.54] ([195.11.108.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeacbbsm7578352f8f.30.2026.09.02.11.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:14:21 -0700 (PDT)
Message-ID: <17835286-3b20-49ec-b5a5-4e5944073282@gmail.com>
Date: Wed, 2 Sep 2026 19:14:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Scale multiplexed perf counters
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, qmo@kernel.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
 <e4f884edb778504fcfe32060a39e6ac6e7f7244c78388fae803562208887eea0@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <e4f884edb778504fcfe32060a39e6ac6e7f7244c78388fae803562208887eea0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 4:20 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>> index 90fa2a48cc26a..2280dc4492c06 100644
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
> 
> [ ... ]
> 
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index a9f730d407a92..ad6d33f838e3c 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
> 
> [ ... ]
> 
>> @@ -2185,6 +2200,7 @@ static int profile_parse_metrics(int argc, char **argv)
>>  static void profile_read_values(struct profiler_bpf *obj)
>>  {
>>  	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>> +	struct bpf_perf_event_value *val;
>>  	int reading_map_fd, count_map_fd;
>>  	__u64 counts[num_cpu];
>>  	__u32 key = 0;
>> @@ -2209,6 +2225,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>>
>>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>  		struct bpf_perf_event_value values[num_cpu];
>> +		double scale;
>>
>>  		if (!metrics[m].selected)
>>  			continue;
>> @@ -2220,9 +2237,22 @@ static void profile_read_values(struct profiler_bpf *obj)
>>  			return;
>>  		}
>>  		for (cpu = 0; cpu < num_cpu; cpu++) {
>> -			metrics[m].val.counter += values[cpu].counter;
>> -			metrics[m].val.enabled += values[cpu].enabled;
>> -			metrics[m].val.running += values[cpu].running;
>> +			val = &values[cpu];
>> +
>> +			metrics[m].val.enabled += val->enabled;
>> +			metrics[m].val.running += val->running;
>> +
>> +			/* This counter has never been scheduled */
>> +			if (!val->running) {
>> +				if (counts[cpu])
>> +					p_info("%s not scheduled on CPU %u; results may be inaccurate",
>> +					       metrics[m].name, cpu);
>> +				continue;
>> +			}
>> +
>> +			/* Scale counter values to account for perf event multiplexing. */
>> +			scale = (double)val->enabled / val->running;
>> +			metrics[m].val.counter += val->counter * scale;
>>  		}
>>  		key++;
>>  	}
> 
> Does this change the semantics of the JSON output? Looking at
> profile_print_readings_json() in prog.c:
> 
> profile_print_readings_json() {
>     ...
>     jsonw_lluint_field(json_wtr, "value",   metrics[m].val.counter);
>     jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
>     jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
>     ...
> }
> 
> Before this commit "value" was the raw counter sum and "enabled"/"running"
> let a consumer apply the correction value * enabled / running itself.
> 
> After this commit "value" is already scaled (multiplied by enabled/running)
> while "enabled" and "running" remain as raw sums. If an existing consumer
> of bpftool -j prog profile applies the documented formula - value * enabled
> / running - it would now double-scale the result.
> 
> There is no new field and no version marker letting a consumer distinguish
> between the two output formats. The changelog says only "Scale resulting
> values similar to how perf does it" without mentioning the JSON output,
> and the .rst hunk explicitly scopes its wording to plain output ("When
> **cycles** is selected, plain output also reports ...").
> 
> Should the JSON "value" field stay raw to keep the interface stable, or
> should the scaled/raw split be made explicit with a new "scaled_value"
> field?
> 
> The same asymmetry appears in plain output. profile_print_readings_plain()
> still prints the raw multiplex percentage next to a counter that has
> already been corrected for that percentage:
> 
> if (val->enabled > val->running)
>     printf("(%4.2f%%)", val->running * 100.0 / val->enabled);
> 
> which reads as if the correction still has to be applied by the reader.
> 

This is a good point. I don't think we should scale for plain output, but not json.
But otherwise we potentially break users.
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33641892894

