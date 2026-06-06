Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F22260580
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780715652; cv=none; b=SKb7V83vHtKKfvww84GklCujuCPEjdzyWeclvktu4JaNWTzuqxw9t/YkCMl0ABY9bjmy4u7Zx2d4Nzkw9WsFD+aTET7HdwivhyB5yA4c6cf4AeCJ/HbgbsLJfVYN0s39CTNJz67bI9oRYWhptz+L+jaDQBcb+p/76RuYsEULMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780715652; c=relaxed/simple;
	bh=iayPXeRDx4bptS8lrpuvf71AArNJuJx8dsbghhdCJTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8M5f3XqSYsmjLxMtkKezxzzFgxy85romZGeSu1JwbRGUG3tyi+ddj8e4Fq36xMOTWEgn6vizXjsb+V56iBPyg3n8l77GVS7jFnZv5DMo2Jq+QGleOijtDyo8MBET3wTL9J7HW1NIow7mFCQpEuJYqkpvQ7gscRtsbjbhmzwzqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e888DbjG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e888DbjG"
Message-ID: <eb0be293-abee-40bd-a969-2f3f8ba77544@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780715639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA8+k+1A3lk7gcQ4XS5Pc2M7Y9W4EaTWIRMqRmuq0X0=;
	b=e888DbjGCf+ROh8ojYOltqaxHNz37lzYQx8RiLMe+LwK1/9TiLo249YALeXfqwDWyPH9xF
	PE/r1UAM4GNYCQdVIZ8Kr/TQZIuhq8oI28szyJCKDjytRdZCCNq+lSNsu5odCPlqmuCk1D
	yg1BNbGQcOI4EpCOLKGCc2dp96RFcSM=
Date: Fri, 5 Jun 2026 20:13:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Content-Language: en-GB
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Juntong Deng <juntong.deng@outlook.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/26 1:04 PM, Sechang Lim wrote:
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
> Return NULL when called from interrupt context.
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>   - Reject calls from interrupt context (Yonghong Song)
>
> v1:
>   - https://lore.kernel.org/bpf/20260603204206.773482-1-rhkrqnwk98@gmail.com/
>
>   kernel/bpf/helpers.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..890202361b53 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,6 +2912,9 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>   {
>   	struct task_struct *p;
>   
> +	if (in_interrupt())
> +		return NULL;
> +

AI suggested we should have

  	rcu_read_lock();
+ if (!task_active_pid_ns(current)) { + rcu_read_unlock(); + return 
NULL; + }  	p = find_task_by_vpid(vpid);

too. I was aware of this in v1 and throught it is very unlikely
as the tracing prog will need to hook into a few functions
after current->thread_pid to be NULL and we may skip it.

But the unlikely does not mean it won't happen, so let us
just add your change in v1 as well. With this,

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>   	rcu_read_lock();
>   	p = find_task_by_vpid(vpid);
>   	if (p)

