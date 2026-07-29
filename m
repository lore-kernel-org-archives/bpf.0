Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081044839F
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319083; cv=none; b=V9x1w28zKJSTZHUIvy5Iro+cd2wyWzzO03b5daBz7dwd6ve0l+MNSPwiyFrKv9knt+iSS/rQ1XYlcQsr5n0srkV4pzkf9SgWEq2aJBVGPcfsowU7wAbTsqOpCvC4P5QVDEX/4XeRyXj6lvqOtYXnVmq4dkVJvRXrS8ev25dMi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319083; c=relaxed/simple;
	bh=/vkHOvrSdE1XD77RGdrurVoGVg9W/cr10pUJ7z7TnxM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZRt6wR8i0EeQsW6LiIjLG7HZ70xzczd7fniTe5dtBz4CTeQ4/HV+oZXwnFZspnW/7E++nB64zzuXR62VHNr9i8f3EaGgNH0q2UVyb+gq6Gxf2J0h4JrJXeeQie5Krru/lBj5Az5TrokIJa+dUJwR5sXscHI/DFv2UCdnmD3627o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBOD3Qoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBOD3Qoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C811F00A3A;
	Wed, 29 Jul 2026 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785319082;
	bh=BCjJN3WKXsVeKrUhfD8vKdTKbbJaS93afpCSNvUexBw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YBOD3QoqZd9/bdfujDiQDPaVa8q50vHo48j5BEO9jVPR+JGOgODIC3/5belxBp7jQ
	 1tm9gre0XAI3Stsb6oSlebUfeLoS/F2GhWnBuagQJEljmevxDwcWeFJVP0y5dwBgXx
	 890QLfN0l128Y+ecb+ErWeA/KXIC/dvAIJTTTNVvihpNmkv+9J2f3nBjnR/bxw5Quk
	 IdqmJ55z4wks07QiDJ2+JWSkasvlIg8eJPnvkjvN69gw1jTWDBjicD/bgc3kNWbE95
	 k/Dj3McOeMS/E7qp7yVj5zblQw89mhr+dI7QvMxTqVhc6daZKjRm3kmu7J4KCbq52B
	 X05ld7b00LW4A==
Content-Type: multipart/mixed; boundary="===============3554013861586486022=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b53a6a1aed6bb8192fe8b3acf267510f50633566078bb011411a863182f14de@mail.kernel.org>
In-Reply-To: <20260729083807.1588544-10-jolsa@kernel.org>
References: <20260729083807.1588544-10-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 09/11] bpf: Remove trace_in argument from __bpf_get_stack
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 09:58:01 +0000 (UTC)

--===============3554013861586486022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 875f530f3597e..bdf48a7ad2e80 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -783,7 +783,6 @@ static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
>  }
>
>  static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> -			    struct perf_callchain_entry *trace_in,
>  			    void *buf, u32 size, u64 flags, bool may_fault)
>  {
>  	bool user_build_id = flags & BPF_F_USER_BUILD_ID;

[ ... ]

> @@ -936,6 +932,33 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
>  	.arg4_type	= ARG_ANYTHING,
>  };
>
> +static int __bpf_get_stack_pe(struct perf_callchain_entry *trace, void *buf, u32 size,
> +			      u64 flags)
> +{
> +	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
> +	u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
> +	bool user = flags & BPF_F_USER_STACK;
> +	u32 elem_size, max_depth, nr_trace;
> +	bool kernel = !user;
> +
> +	if (kernel && user_build_id)
> +		return -EINVAL;
> +
> +	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
> +	if (unlikely(size % elem_size))
> +		return -EINVAL;
> +
> +	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);

This isn't a bug, but could the flags/elem_size/max_depth prologue be
shared with __bpf_get_stack too, in the same spirit as the
callchain_store()/callchain_finalize() helpers?

The new __bpf_get_stack_pe reproduces the validation sequence from
__bpf_get_stack line for line: the kernel && user_build_id rejection,
the elem_size selection and size % elem_size check, and the
stack_map_calculate_max_depth() call.  The four locals (user_build_id,
skip, user, kernel) are derived from flags the same way.

The patch factors callchain_store()/callchain_finalize() out for
sharing but leaves this second block duplicated, so a future change to
the flag validation would need updates in both places.

> +	trace->nr = min_t(u32, trace->nr, max_depth);
> +
> +	if (trace->nr < skip)
> +		return -EFAULT;
> +
> +	nr_trace = callchain_store(trace, buf, elem_size, flags);
> +	return callchain_finalize(buf, size, nr_trace, elem_size, user_build_id,
> +				  user, false /* !may_fault */);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30437558115
--===============3554013861586486022==--
