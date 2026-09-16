Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA344457AC
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589241; cv=none; b=HoNtBPKRreDl3/HP/g9Espte47bg1bGKxboP2+OXSfuaHFQH0GHLSK4Hy3tI9/PW2recg/SgeM2bMlJiDC9bEntfR7TcJ7+cFMmjY5dbFfcXApZAvZ7aEdSLg1OfK9inEYvwbtisyD2zcYMJoLjlGK3CvG5rIiOi8Qp1Giscrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589241; c=relaxed/simple;
	bh=ZsJAViSgE3F6kL6E0Mr8dZispJ99twDScJrcflVHcyU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nljGhq9LhW3Hscnd9Kz3tNTCxhPuFq2EHOTyMxodWamZthWFwO/ibeB6Wy2teJjqRFK2HBl2e/BMu2I8ikwNqLSr1BBslAgLddLU/ZeOxrHJ3+wDOUTvKk19qZuRoqT1zgvtX35zdtxpVHe83HQkmra+I+w7nGs4Kr8xcbfSKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVoYpLKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVoYpLKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA3C1F00898;
	Wed, 16 Sep 2026 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589226;
	bh=djS2j9CbemM7qmvG7OdyTF65lVUtI+yUhObOseOkw3k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JVoYpLKLQ9tyjxQmzdAVxBVkq8eh6ywG36J8LfSJrWXmribh8TLhWowRNLOZkaUo4
	 M57ExlnaoHNEKxWjbusJzOvK1/sO0BXQbh7+a3/WDoNh9YK7XA3Em/Faa8Q9hYlOA+
	 Eh9QHIDLnlvJ2S0kZlnprPZPZOFB36Vf2w/Ga9pSAoVtfzB0sNyUfEmWE+TavPF0Cy
	 wqbaxZ6CgpYAFW+2ivI61f0pbniXBVxKokCICF3FOjxD5BbdQO0yt0cWq2O1KPwiRM
	 QDeTb9YNDQAY6elAo0w//cy0LVxDrWWuOfssg/VJRIxzmqlEiyf3tDpJCGmxOmc2cG
	 S41dVKYgDSImA==
Content-Type: multipart/mixed; boundary="===============1292836920261369331=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45f230f151d8a4861fcc31a300dca3ce1f7559857d6dce5b32d35977bfaf0e30@mail.kernel.org>
In-Reply-To: <20260916-bpftool_cyles_per_run-v4-1-f2de02c480d5@meta.com>
References: <20260916-bpftool_cyles_per_run-v4-1-f2de02c480d5@meta.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Accept zero perf counter snapshots
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 20:07:05 +0000 (UTC)

--===============1292836920261369331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit e6ed198f75f0f993908fe2507feab24a456f9c16
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> Date:   Wed Sep 16 12:26:40 2026 -0700
>
>     bpftool: Accept zero perf counter snapshots
>
>     A perf counter can be zero at fentry when PMU multiplexing has
>     not scheduled the event. Do not reject that sample.
>
>     Use enabled time to distinguish a successful snapshot. Read
>     directly into the per-CPU map value.
>
>     Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

This looks like a bug fix for the prog profile command. Should this include
a Fixes: tag pointing to the commit that introduced the original validation
logic?

  Fixes: 47c09d6a9f67 ("bpftool: Introduce \"prog profile\" command")

> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> index f48c783cb9f7..6685e7252fb5 100644
> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> @@ -45,28 +45,21 @@ const volatile __u32 num_metric = 1;
>  SEC("fentry/XXX")
>  int BPF_PROG(fentry_XXX)
>  {
> -	struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
>  	u32 key = bpf_get_smp_processor_id();
>  	u32 i;
>
> -	/* look up before reading, to reduce error */
>  	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> +		struct bpf_perf_event_value___local *reading;
>  		u32 flag = i;
> -
> -		ptrs[i] = bpf_map_lookup_elem(&fentry_readings, &flag);
> -		if (!ptrs[i])
> -			return 0;
> -	}
> -
> -	for (i = 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> -		struct bpf_perf_event_value___local reading;
>  		int err;
>
> -		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
> -						sizeof(reading));
> +		reading = bpf_map_lookup_elem(&fentry_readings, &flag);
> +		if (!reading)
> +			return 0;
> +		err = bpf_perf_event_read_value(&events, key, (void *)reading,
> +						sizeof(*reading));
>  		if (err)
>  			return 0;
> -		*(ptrs[i]) = reading;
>  		key += num_cpu;
>  	}

Does merging these loops introduce measurement error? The original code
performed all map lookups before any perf event reads, so the
bpf_perf_event_read_value() calls that start each metric's measurement
window ran back to back with no map operations between them.

After this change, each iteration inserts a bpf_map_lookup_elem() call
between successive bpf_perf_event_read_value() calls. The counter for
metric i is computed as after_i - before_i, where before_i is now captured
later than it was. That extra delay from the interleaved lookups gets
counted as part of the profiled program in fexit_update_maps():

tools/bpf/bpftool/skeleton/profiler.bpf.c:fexit_update_maps() {
    diff.counter = after->counter - before->counter;
    ...
    accum->counter += diff.counter;
}

This produces a systematic inflation of reported cycles for all but the last
metric. The magnitude is small because percpu-array lookups are inlined, but
the commit message only mentions reading directly into the map value, not
removing the error-reduction ordering.

A comment later in the file still documents this principle:

/* read all events before updating the maps, to reduce error */

Should the pre-lookup pass be kept to preserve measurement accuracy, or
should the commit message and the remaining comment be updated to reflect
the new trade-off?

> @@ -80,7 +73,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
>
>  	before = bpf_map_lookup_elem(&fentry_readings, &id);
>  	/* only account samples with a valid fentry_reading */
> -	if (before && before->counter) {
> +	if (before && before->enabled) {
>  		struct bpf_perf_event_value___local *accum;
>
>  		diff.counter = after->counter - before->counter;

The switch from checking counter to checking enabled looks correct for this
file. However, there's a second copy of this profiler in the tree at
tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c that still uses the old
test:

tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c:fexit_XXX() {
    ...
    if (before && before->counter) {
        diff.counter = after.counter - before->counter;
        ...
    }
}

That function is a near-verbatim copy of fexit_update_maps() and would drop
samples whenever the fentry counter snapshot is zero, which is the exact bug
described in this commit message.

Should perf's copy be fixed in this series, or is there a reason to leave it
unchanged?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35141110446
--===============1292836920261369331==--
