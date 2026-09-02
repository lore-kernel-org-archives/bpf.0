Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57F4A484E
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362425; cv=none; b=rOQdT7AIgfWBcKLMve4ZT028JKXykeEwZksxawp+QhlPFDvYu8B/7v5LDSWOqSQitE/bm5nfFsvx91WylR3l8Ue5uOt4li8HVcDjKfHZswr/1JWYC3IKcL/s0LZlxpL1lNIRnFjYwgwvVIu7ZVYaYRLa6BWC+uRFmuaaxYE1MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362425; c=relaxed/simple;
	bh=t4B+MT/QHSyTq3OHyMsljyJxzLVDHPdc8+Lg6z0HNy4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NR1tZTJukH4owVkX4jHmkUiS2EB2eSFH4HMz8c23E6Dl0wAm15IjuvoMzOzdl63qvWR3V9mgszIRjVh2OXbufibN5TA9PUzYFdKZGwnAZJSFcQ8zMjJBEM/AKLcAVkFGdAlzZUwfAKmDP6nzOSXLI2SN2+cRChf1azfsvcjWjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9vgRYtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9vgRYtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C6F1F000E9;
	Wed,  2 Sep 2026 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362423;
	bh=UyLuL0+MRhVIqJj6nQreYr3X2gfQ103btaemLeqH/GQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M9vgRYtZBsK8zbNelP0cnDEFbTrwwzLWKtIj51xp94hYoRpjBmavhz+/20uUPCkmr
	 R09bczbtmvI0MzDZWp4DRFf556d07Qg/JqsdWaM9ccL2IwnndzFY96Os/BflO9ewXT
	 nYng9FvOQenKiuzs3x8zbgoiplzf1Loyqkvi+Et6XAt9MdtgSphrAf47YOaQHOApLg
	 IPK38fF2+d+MO5TG6kp88y0mz+C3giXjgeeTSI1U1wW+aqfyEfqyANzI1H6vf2/2eL
	 JvUbhSgzr/xEu80ZSEW00Az8yY7cBlmpWyMHY13UpPj4R7BIA3SA15yMWXMTcrHvdL
	 UXPoZx10U8OQw==
Content-Type: multipart/mixed; boundary="===============0621049722044299201=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4f884edb778504fcfe32060a39e6ac6e7f7244c78388fae803562208887eea0@mail.kernel.org>
In-Reply-To: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
References: <20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Scale multiplexed perf counters
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 15:20:22 +0000 (UTC)

--===============0621049722044299201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 90fa2a48cc26a..2280dc4492c06 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -217,7 +217,9 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
>  bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
>      Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
>      user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
> -    the profiling will run up to **UINT_MAX** seconds.
> +    the profiling will run up to **UINT_MAX** seconds. When **cycles** is
> +    selected, plain output also reports the average number of cycles per
> +    program run.

[ ... ]

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a92..ad6d33f838e3c 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[ ... ]

> @@ -2185,6 +2200,7 @@ static int profile_parse_metrics(int argc, char **argv)
>  static void profile_read_values(struct profiler_bpf *obj)
>  {
>  	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
> +	struct bpf_perf_event_value *val;
>  	int reading_map_fd, count_map_fd;
>  	__u64 counts[num_cpu];
>  	__u32 key = 0;
> @@ -2209,6 +2225,7 @@ static void profile_read_values(struct profiler_bpf *obj)
>
>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
>  		struct bpf_perf_event_value values[num_cpu];
> +		double scale;
>
>  		if (!metrics[m].selected)
>  			continue;
> @@ -2220,9 +2237,22 @@ static void profile_read_values(struct profiler_bpf *obj)
>  			return;
>  		}
>  		for (cpu = 0; cpu < num_cpu; cpu++) {
> -			metrics[m].val.counter += values[cpu].counter;
> -			metrics[m].val.enabled += values[cpu].enabled;
> -			metrics[m].val.running += values[cpu].running;
> +			val = &values[cpu];
> +
> +			metrics[m].val.enabled += val->enabled;
> +			metrics[m].val.running += val->running;
> +
> +			/* This counter has never been scheduled */
> +			if (!val->running) {
> +				if (counts[cpu])
> +					p_info("%s not scheduled on CPU %u; results may be inaccurate",
> +					       metrics[m].name, cpu);
> +				continue;
> +			}
> +
> +			/* Scale counter values to account for perf event multiplexing. */
> +			scale = (double)val->enabled / val->running;
> +			metrics[m].val.counter += val->counter * scale;
>  		}
>  		key++;
>  	}

Does this change the semantics of the JSON output? Looking at
profile_print_readings_json() in prog.c:

profile_print_readings_json() {
    ...
    jsonw_lluint_field(json_wtr, "value",   metrics[m].val.counter);
    jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
    jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
    ...
}

Before this commit "value" was the raw counter sum and "enabled"/"running"
let a consumer apply the correction value * enabled / running itself.

After this commit "value" is already scaled (multiplied by enabled/running)
while "enabled" and "running" remain as raw sums. If an existing consumer
of bpftool -j prog profile applies the documented formula - value * enabled
/ running - it would now double-scale the result.

There is no new field and no version marker letting a consumer distinguish
between the two output formats. The changelog says only "Scale resulting
values similar to how perf does it" without mentioning the JSON output,
and the .rst hunk explicitly scopes its wording to plain output ("When
**cycles** is selected, plain output also reports ...").

Should the JSON "value" field stay raw to keep the interface stable, or
should the scaled/raw split be made explicit with a new "scaled_value"
field?

The same asymmetry appears in plain output. profile_print_readings_plain()
still prints the raw multiplex percentage next to a counter that has
already been corrected for that percentage:

if (val->enabled > val->running)
    printf("(%4.2f%%)", val->running * 100.0 / val->enabled);

which reads as if the correction still has to be applied by the reader.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33641892894
--===============0621049722044299201==--
