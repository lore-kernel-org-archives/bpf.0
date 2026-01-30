Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B529C351
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763133; cv=none; b=Sut0PomOVWIP5JAzA+VLyZnOIgy7l5absd4zUlAi9n1F0sHFrZ55drLRAJz32vUyoQaOjivXUOQtXdGZsqFpsOOTwduZYANG5FKab6m1Iz5QsRwVDeUkzcBYe57GZj8Avh683lf2HyFQDoZJj/T9ftvi/uRi6ERqGNwXgkIj9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763133; c=relaxed/simple;
	bh=ZyE6q8qaCwA1cnQxLUqeWB4clV9Esbr7QZdGKH29Ql8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKvS+vcU77DM5WEfoDtnMWKYt/TenCYqsgkErb31CTPXhPTRjcflhFhECpnJY9wEf8XzEUlwNaHg/koIfXwxgEISdLU3YZjXkDIhl2uIe4OD8IVgON7U8bKcQs/DKY74Xg72SKEnNTlFc5GBV6hsnjJ23Atz3gOh46Pr8QN56d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DzUO0nyQ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzUO0nyQ"
Message-ID: <d41c3d60-09e8-4f49-a8f4-5fe4f7db37e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769763127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzebeRHNp1eoG2TGXuhH+wS5qx/tkXDfLd7wIqfPoHI=;
	b=DzUO0nyQ4D6Ry9YyRaYB6DuR9NoLU0nTDvJEX+KMRDVVtVZug9WXKFwAf3SrSvBBOsn68h
	jXN9X1pbdSMVi6J+0GCyCxltGpvq4g7/HJxtx8Y+ic4hd7rBarm1tDYR8y5p9weHjsCSoI
	AgsT6ucJKlBZ55VxdmTYu+4CUDZg9l4=
Date: Fri, 30 Jan 2026 16:51:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove RCU lock for perf callchain buffer
To: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260128165710.928294-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20260128165710.928294-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/29 00:57, Tao Chen 写道:
> As Andrii suggested, BPF can guarantee perf callchain buffer won't
> be released during use, for bpf_get_stack_id, BPF stack map will
> keep them alive by delaying put_callchain_buffer() until freeing time
> or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold
> these buffers alive again, until freeing time which is delayed until
> after RCU Tasks Trace + RCU grace period.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c1..2e682d8697b 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,9 +460,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   
>   	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>   
> -	if (may_fault)
> -		rcu_read_lock(); /* need RCU for perf's callchain below */
> -
>   	if (trace_in) {
>   		trace = trace_in;
>   		trace->nr = min_t(u32, trace->nr, max_depth);
> @@ -473,11 +470,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   					   crosstask, false, 0);
>   	}
>   
> -	if (unlikely(!trace) || trace->nr < skip) {
> -		if (may_fault)
> -			rcu_read_unlock();
> +	if (unlikely(!trace) || trace->nr < skip)
>   		goto err_fault;
> -	}
>   
>   	trace_nr = trace->nr - skip;
>   	copy_len = trace_nr * elem_size;
> @@ -493,10 +487,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		memcpy(buf, ips, copy_len);
>   	}
>   
> -	/* trace/ips should not be dereferenced after this point */
> -	if (may_fault)
> -		rcu_read_unlock();
> -
>   	if (user_build_id)
>   		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>   

Hi Andrii,

I send this patch as a separate submission, and I'm not sure when the 
patchset will be merged. After this merged, i will update v9. Is it ok?

The previous patchset:
https://lore.kernel.org/bpf/CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com/

And i also saw Qing reported a syzbot issue recently.
https://lore.kernel.org/bpf/20260128084538.1889001-1-wangqing7171@gmail.com/

-- 
Best Regards
Tao Chen
