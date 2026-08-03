Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B613349CFD
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795697; cv=none; b=j5K4xNBnVxE/I9xQ4cGtOo3fPm5j/LdtHKLG+cHH+E4EGunF/cgPtQu8cB5wPcQfowV8LkTHfoacf35BIhWhcr5IXQM4UsVRBej4hbwiqvj/yocSsdbgS0Rhm/Ld8gAkqf1nbP4Th0Yl6u4nR608dD8Qrgqyf0c6GWbE7qCUQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795697; c=relaxed/simple;
	bh=TB9OTYzBc41us5CbNFvZjA5Cy8MgnUi8rMMh3ufAiWU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SMqydZtlfcNazdZTAgfhcxgr66Mnn8zehkiM3LjXozvn5bXi/V4gY9GK/lP1FsM3fAUXNHiNeA55M3spn7JXv+wBRy814DKD+jGG7xLWONYTh4XsP21fdzsMQKiDXug3DDncfwDwvkMxhaHzWTqDrWXzZV/luEpmbSJQv8yoLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gle7xGE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gle7xGE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B4D1F00A3A;
	Mon,  3 Aug 2026 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795695;
	bh=JX+17OzcudNy0tV1piPiLzTWjIwJNC1DEO77o+Ls1e8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gle7xGE28yYv0aPtF48kB8SlNKyGhN7a6lzrfCetFboKbswtmTBswcAmyGiqnq1O9
	 v00LZR68EA+etjyXL5EsaYR7VdHR3XiDmPu2hfC8zMnow1taTsI+6dT0ZgFbyLNxLK
	 MWiwHeAfTKyWZ6pRarWBwlclBsT8wpz/13fBikhsNC2ATJNWMyMb3dM9cnDa11sbn1
	 +lyVyf7UW/fxpOOz73bBiSUGg7rSW9K0MxBHuIxMgieQNop6hl01BK0271vstW+WZX
	 EVZuYkCdfLtlAZ2ifO3em0wZAIPHiTwK8eQ1sF8b8hlZon+ZfJthhueJz2/Qe4DY3o
	 e/QW0XxnzxGqQ==
Content-Type: multipart/mixed; boundary="===============6623590544793985245=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa27c03a75e22229f58d1ccdce161e05fb274645e3072cdd591201f14b4f1cc3@mail.kernel.org>
In-Reply-To: <20260803210149.296496-9-jolsa@kernel.org>
References: <20260803210149.296496-9-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 08/12] bpf: Remove trace_in argument from __bpf_get_stack
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,chen.dylane@linux.dev,info@starlabs.sg,contact@arnaud-lcm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 22:21:34 +0000 (UTC)

--===============6623590544793985245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index cdeb6c2e50da0..976c4e4c1af66 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -933,6 +929,32 @@ const struct bpf_func_proto bpf_get_task_stack_sleepable_proto = {
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
> +	trace->nr = min_t(u32, trace->nr, max_depth);
> +
> +	if (trace->nr < skip)
> +		return -EFAULT;
> +
> +	nr_trace = callchain_store(trace, buf, elem_size, flags);
> +	return callchain_finalize(buf, size, nr_trace, elem_size, flags, false /* !may_fault */);
> +}

This isn't a bug, but would naming this variable trace_nr match
__bpf_get_stack() and the callchain_*() parameters it feeds?

Looking at __bpf_get_stack():

kernel/bpf/stackmap.c:__bpf_get_stack() {
	u32 trace_nr, elem_size, max_depth;
	...
	trace_nr = callchain_store(trace, buf, elem_size, flags);
	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
}

And the shared helpers both expect trace_nr:

kernel/bpf/stackmap.c:callchain_store(struct perf_callchain_entry *trace, ...) {
	for (i = skip; i < trace_nr; i++) {
		...
	}
	return trace_nr - skip;
}

kernel/bpf/stackmap.c:callchain_finalize(void *buf, u32 size, u32 trace_nr, ...) {
	u32 copy_len = trace_nr * elem_size;
	...
}

The new helper uses nr_trace for the same role, making the two otherwise
parallel functions read differently.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30854471987
--===============6623590544793985245==--
