Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8AEEA8
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897342; cv=none; b=MB6pNHVLYsE5PPjDOAk7BK1gL3Fi1AqAK2IiBDOsGFiin5ZNX9rXpYlCZu8bzHsW9FWC/7cr75bFLsXEw0BNKHswnwVMgbcT3Eyosoc6I/reQHJkF+HuFUjAFW3z4eGMXiyzMHH8/g5lvasjBUSPQ1hQbiignfesg83f6Y84M58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897342; c=relaxed/simple;
	bh=y+mJ1HXnv5NYZRtUwHjiZPac81J7u7FEbFFH3q7zkqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl+cxsxLNkRJXkwo336UHVAT2vE3kDslcTQVV41/ymk8ltGosqLyG6DIwUAh7lffYEW0jfIO2MLwdkQZfzkS5vH5ioMKZtHWqSBBoUbAhTHbcp6O/KpNroXNlgcLi0gmrf7IN7uJGuU5uWY70zIiwshk1KNL8QZrR5v8ja/A+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OyR5zI9H; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OyR5zI9H"
Message-ID: <b89c1f53-2ba8-4b70-9058-fcc59eda40d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780897338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5ntvAPtl29747l3/yszg83JHhSsUZDw64t/HzACw7Y=;
	b=OyR5zI9H3itlVcp0CNOQoyp1w42jq+WnYobfDtewaMS2WXNlOi5dsHpwY81vJzIK/HxdvM
	TylQoPXigQR1KPTQXeAorPonnhnVW3iF9cPk7GsK8DI8unKAOKta7m5lOJcO7snoqcLJkb
	BYYV/xOnLj3drQ02zF7oy8PhyllZhy4=
Date: Mon, 8 Jun 2026 13:42:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
Content-Language: en-US
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Juntong Deng <juntong.deng@outlook.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 13:00, Sechang Lim wrote:
> bpf_task_from_vpid() looks up a task in the pid namespace of the
> current task, via find_task_by_vpid():
> 
>   find_task_by_vpid(vpid)
>     find_task_by_pid_ns(vpid, task_active_pid_ns(current))
>       find_pid_ns(nr, ns) -> idr_find(&ns->idr, nr)
> 
> cgroup_skb programs run in softirq, which may interrupt a task that is
> itself in do_exit(). Once that task has passed
> exit_notify() -> release_task() -> __unhash_process(), its thread_pid is
> cleared, so task_active_pid_ns(current) returns NULL and find_pid_ns()
> dereferences &NULL->idr:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000050
>   RIP: 0010:idr_find+0x11/0x30 lib/idr.c:176
>   Call Trace:
>    <IRQ>
>    find_pid_ns kernel/pid.c:370 [inline]
>    find_task_by_pid_ns+0x3b/0xe0 kernel/pid.c:485
>    bpf_task_from_vpid+0x5b/0x200 kernel/bpf/helpers.c:2916
>    bpf_prog_run_array_cg+0x17e/0x530 kernel/bpf/cgroup.c:81
>    __cgroup_bpf_run_filter_skb+0x12b/0x250 kernel/bpf/cgroup.c:1612
>    sk_filter_trim_cap+0x1dc/0x4c0 net/core/filter.c:148
>    tcp_v4_rcv+0x18d1/0x2200 net/ipv4/tcp_ipv4.c:2223
>    </IRQ>
>    <TASK>
>    do_exit+0xa63/0x1270 kernel/exit.c:1010
>    get_signal+0x141c/0x1530 kernel/signal.c:3037
> 
> Bail out when current has no pid namespace.
> 
> Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v4:
>  - Drop the in_interrupt() check. (Kumar Kartikeya Dwivedi)
>  - Switch to guard(rcu)() and drop the explicit rcu_read_unlock(). (Leon
>    Hwang)
> 
LGTM:

Acked-by: Leon Hwang <leon.hwang@linux.dev>

