Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ABB35A384;
	Fri,  5 Jun 2026 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691561; cv=none; b=Jv9Of5AODjgHha1NrJ8+7M1ZCiLGaKmaanMV+/A2H+T5RZcaE92csCI37ro02NwM79xI0e1+gEy9r3x/4DNGErtvS3fjE7hedbMip4rs56dWKxGjWdfcXefAeTkL2wEQWtLVW19rOxe1sciitpaB0ny4wxzkPnxGJwISfTZkDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691561; c=relaxed/simple;
	bh=NOr3sLn8ml8PxjQyMnmg5WPYzqqFvlk9UDfAyaCi6SQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MY+8E124W4OrXI50doUecIcCrhFlO0x3K12w0poVk+pUVfpuncWY8G1UXTSDNaiaq/hYWDufc/c4/k2vUzEtE2vtTxqHNeNdiLBoprr/i+1mZ9AEVPRoTKwBP7NYtJawyCaIwhtWFr3K3x+1UgRJWvlhPs3OB1axA1ifrNYAewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtCCuBgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtCCuBgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE91F00893;
	Fri,  5 Jun 2026 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691560;
	bh=XGLEaN3OJMQhCvnj9qhtVcIbH9JPM97JNW+jgz34NuE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FtCCuBgo83aBhHrP39PSSutyLg6sQ215I0O6f050athuStJV3PZLqkHniMNJNljFs
	 uBPImcVvU7TFx/N18Ore+majIFy1615zdeNUTTTSaK1IR9kzm9TqOipnhPzqYOHiJr
	 3ZQFncuWnJgECGkJC/juUPjPCaqWnxlRScxdFjfCPHnrpV2I8iUW+pb+RPLgFuerQy
	 H/7ArHbKrWMdlNhlGhUbyUh0jAWSy+0/B/z+itKgmS09FxrSK//LbpL6wgRTWdnXFA
	 kOeH+5fra1efD7Jt0fWnDQdl7IYpCtG96wzXnlo8vtzXzyM3Ztnr1QN3UYrbr/L8ys
	 0oLYy/lfCNzwg==
Content-Type: multipart/mixed; boundary="===============6384902267417285087=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9fb35b7fb9c478cd4002535547886f16cbdb95995ecfa297b701576e4b5f52ec@mail.kernel.org>
In-Reply-To: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
References: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,juntong.deng@outlook.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 20:32:40 +0000 (UTC)

--===============6384902267417285087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..890202361b53 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,6 +2912,9 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>  {
>  	struct task_struct *p;
>
> +	if (in_interrupt())
> +		return NULL;
> +

Does this check fully prevent the crash during task exit?

While this prevents the crash when an interrupt preempts an exiting task, it
appears it might not protect synchronous BPF tracing programs (like kprobes or
sched_switch tracepoints) executing in task context during do_exit().

Once __unhash_process() has cleared thread_pid, in_interrupt() returns false
in task context, but task_active_pid_ns(current) is still NULL. Wouldn't the
crash still occur in find_task_by_vpid() -> find_task_by_pid_ns() ->
find_pid_ns() -> idr_find(&NULL->idr)?

Additionally, in_interrupt() returns true in normal task context whenever
bottom-halves are disabled, such as inside a spin_lock_bh() region. Will this
cause bpf_task_from_vpid() to unexpectedly fail for valid tracing programs
attached to living tasks that happen to be holding a BH-disabled lock?

Could we verify the namespace directly instead to avoid these issues, perhaps
by checking if task_active_pid_ns(current) is NULL?

>  	rcu_read_lock();
>  	p = find_task_by_vpid(vpid);
>  	if (p)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27037807660
--===============6384902267417285087==--
