Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8924D9901
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452166; cv=none; b=RvD7I2jCk3FS4Jh9DXiGtETR94wh9pRzFfV3ROQx1dzMVuFUE/7k4L/cP6xuknV6U1A/A7ZZTXMP6UBK2CGBh5Uou9oSxZr8hpAfhUnA2rDv0vgB1pQRxty+OE60PBzV8sEOLRJG96jQq6qx42Srxrb3XAnHFZWiYtAIAlInEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452166; c=relaxed/simple;
	bh=WE6nwL7/s1SCVsKUymt32XGT+TxeHufmfteqPKoslJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdxuM1Zvv6aUi8KLLKWgbAM2k0kwm1JjjHC4Yo1T+LbP6B4CDGjy5phgSpaA90dLvAu9pTwQcjNAwe9ZkYeMem70uOvpeBOh8L7FUnQ9jKvQ9RfX55TNefmGoAqSnu1p3xpPZkzSah+v33kGsVepfaiBCZMnASCXWHB5CiGGbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+a74cCC; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+a74cCC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WE6nwL7/s1SCVsKUymt32XGT+TxeHufmfteqPKoslJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788452161; v=1; x=1789056961;
 b=m+a74cCCtNnqi4Gzwi2xk79Bls5Pz8zWsjIugbok1VL8HhFtPt1Nf4wnMViLB4Hg+AOtRb/3
 BeL8rW+fQj6VB4YrXM6pOh75ObpVaGDNrWuDXe8G6hqKBVfhN9Db4jyvFpfEzJF1DD6rnUhKW0E
 yu0PS8FiZhmf015MKgdDOBJ0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 434fb9388ecb7cb6;
	Thu, 03 Sep 2026 16:16:01 +0000
X-Mizu-Trace-ID: 434fb9388ecb7cb6
X-Migadu-Flow: FLOW_OUT
Message-ID: <aa362c9a-b9ac-42cb-96e0-6b66bd64fcbe@linux.dev>
Date: Thu, 3 Sep 2026 09:15:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Scale multiplexed perf counters
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, qmo@kernel.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org
References: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
 <e4f884edb778504fcfe32060a39e6ac6e7f7244c78388fae803562208887eea0@mail.kernel.org>
 <17835286-3b20-49ec-b5a5-4e5944073282@gmail.com>
 <4adbd22f-886e-4497-a6da-55514a1d5fba@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <4adbd22f-886e-4497-a6da-55514a1d5fba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-03 7:33 a.m., Mykyta Yatsenko wrote:
> 
> 
> On 9/2/26 7:14 PM, Mykyta Yatsenko wrote:
>>
>>
>> On 9/2/26 4:20 PM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>> index 90fa2a48cc26a..2280dc4492c06 100644
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
>>>
>>> [ ... ]
>>>
>>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>> index a9f730d407a92..ad6d33f838e3c 100644
>>>> --- a/tools/bpf/bpftool/prog.c
>>>> +++ b/tools/bpf/bpftool/prog.c
>>>
>>> [ ... ]
>>>
>>>> @@ -2185,6 +2200,7 @@ static int profile_parse_metrics(int argc, char **argv)
>>>>   static void profile_read_values(struct profiler_bpf *obj)
>>>>   {
>>>>   	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
>>>> +	struct bpf_perf_event_value *val;
>>>>   	int reading_map_fd, count_map_fd;
>>>>   	__u64 counts[num_cpu];
>>>>   	__u32 key = 0;
>>>> @@ -2209,6 +2225,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>>>>
>>>>   	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>>>>   		struct bpf_perf_event_value values[num_cpu];
>>>> +		double scale;
>>>>
>>>>   		if (!metrics[m].selected)
>>>>   			continue;
>>>> @@ -2220,9 +2237,22 @@ static void profile_read_values(struct profiler_bpf *obj)
>>>>   			return;
>>>>   		}
>>>>   		for (cpu = 0; cpu < num_cpu; cpu++) {
>>>> -			metrics[m].val.counter += values[cpu].counter;
>>>> -			metrics[m].val.enabled += values[cpu].enabled;
>>>> -			metrics[m].val.running += values[cpu].running;
>>>> +			val = &values[cpu];
>>>> +
>>>> +			metrics[m].val.enabled += val->enabled;
>>>> +			metrics[m].val.running += val->running;
>>>> +
>>>> +			/* This counter has never been scheduled */
>>>> +			if (!val->running) {
>>>> +				if (counts[cpu])
>>>> +					p_info("%s not scheduled on CPU %u; results may be inaccurate",
>>>> +					       metrics[m].name, cpu);
>>>> +				continue;
>>>> +			}
>>>> +
>>>> +			/* Scale counter values to account for perf event multiplexing. */
>>>> +			scale = (double)val->enabled / val->running;
>>>> +			metrics[m].val.counter += val->counter * scale;
>>>>   		}
>>>>   		key++;
>>>>   	}
>>>
>>> Does this change the semantics of the JSON output? Looking at
>>> profile_print_readings_json() in prog.c:
>>>
>>> profile_print_readings_json() {
>>>      ...
>>>      jsonw_lluint_field(json_wtr, "value",   metrics[m].val.counter);
>>>      jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
>>>      jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
>>>      ...
>>> }
>>>
>>> Before this commit "value" was the raw counter sum and "enabled"/"running"
>>> let a consumer apply the correction value * enabled / running itself.
>>>
>>> After this commit "value" is already scaled (multiplied by enabled/running)
>>> while "enabled" and "running" remain as raw sums. If an existing consumer
>>> of bpftool -j prog profile applies the documented formula - value * enabled
>>> / running - it would now double-scale the result.
>>>
>>> There is no new field and no version marker letting a consumer distinguish
>>> between the two output formats. The changelog says only "Scale resulting
>>> values similar to how perf does it" without mentioning the JSON output,
>>> and the .rst hunk explicitly scopes its wording to plain output ("When
>>> **cycles** is selected, plain output also reports ...").
>>>
>>> Should the JSON "value" field stay raw to keep the interface stable, or
>>> should the scaled/raw split be made explicit with a new "scaled_value"
>>> field?
>>>
>>> The same asymmetry appears in plain output. profile_print_readings_plain()
>>> still prints the raw multiplex percentage next to a counter that has
>>> already been corrected for that percentage:
>>>
>>> if (val->enabled > val->running)
>>>      printf("(%4.2f%%)", val->running * 100.0 / val->enabled);
>>>
>>> which reads as if the correction still has to be applied by the reader.
>>>
>>
>> This is a good point. I don't think we should scale for plain output, but not json.
>> But otherwise we potentially break users.
>>>
> 
> Discussed with Andrii, we'll scale for stdout and keep existing behaviour for the json.

Hi Mykyta.

I think for json we can just add new fields, for example "value_scaled".

This way existing consumers are unaffected, while new/updated consumers
have a way to opt-in.

This seems to be an established pattern for json output changes, see:
   74fc8801edc2 ("bpftool: Show map IDs along with struct_ops links.")
   bf06c9393493 ("bpftool: Dump map id instead of value for map_of_maps 
types")

> 
>>> ---
>>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>>
>>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33641892894
>>
> 

