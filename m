Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895A2BE03C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678818; cv=none; b=DSITk/3Dmm85BS/P/rW46VZ8Kj3OIJcQUOYrTO0zo0xXeDBVITDNhhPkhiQbm7EWdH6mUqmEXui6VfRJcGuc1y/hWWBEXEVfizlZljq/6cf1MPSt5AzYvreLG7aSh/C3wCIFjiWTLJx+cxUg1vs3Jw57edGi4DuW8wZDG4taD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678818; c=relaxed/simple;
	bh=0Y9DnF8DCVs+ioD7NcPTPeoVg18OUuK/6dYly9D/WG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMHCb1r+oS850VeWTvj9+Q6tBas7flwcnJdQQyvWqvWMd8X1mlskysP4bKfdu5cYnauk8h3comtro374gyDAudxQIMNqOPaR8Z6dfkS8DwqspuBEhmGdm2Qs6pf0Lkg6FSrBWXOEpBRxK8cJiHD97ieKN5SfbRNqJ/nY51TuviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/4NuLNw; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/4NuLNw"
Message-ID: <e3e1f8dd-e0f4-4f9c-85cd-22c58571eca7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780678813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+F6dCr7Ekcj7JdRJunNsiqbCtUyFgwJwQx1YoPJlqU=;
	b=l/4NuLNwt3gUNWHC7gQ2meNcKVu6H1AIA4TjaYHxNTH216dZp+KcsmLV4HTLZXAYpU9ZeB
	VpBwIHzIMYX8aCZsaaG0C6pPt3hORH1xg/MXIsI8Jb7n08OCv7prdLLiSX/flKKkSW0Xiy
	sV3+24/3uR2x8fi8SHKFGsGf8/GosOQ=
Date: Fri, 5 Jun 2026 09:59:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Content-Language: en-GB
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Juntong Deng <juntong.deng@outlook.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/3/26 1:42 PM, Sechang Lim wrote:
> bpf_task_from_vpid() looks up a task in the pid namespace of the
> current task, via find_task_by_vpid():
>
>    find_task_by_vpid(vpid)
>      find_task_by_pid_ns(vpid, task_active_pid_ns(current))
>        find_pid_ns(nr, ns) -> idr_find(&ns->idr, nr)
>
> cgroup_skb programs run in softirq, which may interrupt a task that is
> itself in do_exit(). Once that task has passed
> exit_notify() -> release_task() -> __unhash_process(), its thread_pid is
> cleared, so task_active_pid_ns(current) returns NULL and find_pid_ns()
> dereferences &NULL->idr:
>
>    BUG: kernel NULL pointer dereference, address: 0000000000000050
>    RIP: 0010:idr_find+0x11/0x30 lib/idr.c:176
>    Call Trace:
>     <IRQ>
>     find_pid_ns kernel/pid.c:370 [inline]
>     find_task_by_pid_ns+0x3b/0xe0 kernel/pid.c:485
>     bpf_task_from_vpid+0x5b/0x200 kernel/bpf/helpers.c:2916
>     bpf_prog_run_array_cg+0x17e/0x530 kernel/bpf/cgroup.c:81
>     __cgroup_bpf_run_filter_skb+0x12b/0x250 kernel/bpf/cgroup.c:1612
>     sk_filter_trim_cap+0x1dc/0x4c0 net/core/filter.c:148
>     tcp_v4_rcv+0x18d1/0x2200 net/ipv4/tcp_ipv4.c:2223
>     </IRQ>
>     <TASK>
>     do_exit+0xa63/0x1270 kernel/exit.c:1010
>     get_signal+0x141c/0x1530 kernel/signal.c:3037
>
> Bail out when current has no pid namespace.
>
> Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>   kernel/bpf/helpers.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..4646a915bf98 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2913,6 +2913,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>   	struct task_struct *p;
>   
>   	rcu_read_lock();
> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}

In softirq context, I think we should return NULL for this kfunc.
Your above fix solves crash problem. But even not crash, the
below task 'p' may not be user expected since the 'current' (and
its namespace) is random.

Maybe we can do:

+	if (in_interrupt())
+		return NULL;
+
	rcu_read_lock();
	...

In bpf selftest task_kfunc_success.c, all programs are 'syscall'
programs which garantees process context.

>   	p = find_task_by_vpid(vpid);
>   	if (p)
>   		p = bpf_task_acquire(p);

