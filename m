Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97F3BD63D
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492433; cv=none; b=NzZoJnFKHZn/smQXzCw2u5107GOx77NY9e0V8nnfuHWRDLPsI+D+6PUQr4rcI91rgAEgG4fc8bbgz0WLna/iFdTX71LxGxt82Z86UpQq+OzW5FsHsuvUqCZcEXM+cbyZGZM3yCHdR2O4jxV6+7WxY6Ks9f704R01tcRJEgJAZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492433; c=relaxed/simple;
	bh=GZ4NrDNTzCbRg7T2sHGbvZtWMZOez+5OwOOwcrRukTE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O1DxJ1UWguhfxJQpzVOwEqEnuDLvN9vPTDsjLqFuA7//z/bF2T6HJQZpkZvbgW/o64fxkxvJfo4uS7V9E6zbNjrWsTa3A2JDN++iG2cuT7qPnXCsfHKifpZHI8o4uX+0rfGb3LoBVgNJithM3xoeLbYofv2BMvpRd8+y3X9NZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgIA4ISj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgIA4ISj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0FC2BCB0;
	Mon, 11 May 2026 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778492433;
	bh=GZ4NrDNTzCbRg7T2sHGbvZtWMZOez+5OwOOwcrRukTE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sgIA4ISjIOOG2WVBoRfpWpWSCKtc49kSso+lc65pASWSWXThyUH3FZAsTWjckNutu
	 V2nUuBZOSAaFDOGarhAui4//89ytcMgwASveCDDp9m1LWT+M9C3AxV3Ista6lLdTxm
	 bTMFtJG6zSliAK+OKfSeHy1ag1kzFcV0Q0F9yaaN6+CpMuf091TVai5Bl/l8IUAooD
	 YdfNcTJZp+zrcH07Qhaczupgg2KPJAbEf55XNqH8JqwfjSDn0W1QONSM6bXWbUgl1y
	 7Nd0bHmHzDcMxPuU3N3p82RuMqS/hqXKTUXeV+OpG8sYungwOWbaTKDmgVpkw0kByK
	 qrMhhTk0p4B+Q==
Content-Type: multipart/mixed; boundary="===============3901398826449329569=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a310c8a6fbd8442e4976bb9b80156376bc6c1fe668ddcf94052822924835949c@mail.kernel.org>
In-Reply-To: <20260511085344.3302-2-mahe.tardy@gmail.com>
References: <20260511085344.3302-2-mahe.tardy@gmail.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,liamwisehart@meta.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 09:40:32 +0000 (UTC)

--===============3901398826449329569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The API consists of four kfuncs:
>
>   bpf_netpoll_create()   - Allocate and set up a netpoll context
>                            (sleepable, SYSCALL prog type only)
>   bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
>   bpf_netpoll_release()  - Release a reference (cleanup via
>                            queue_rcu_work since netpoll_cleanup sleeps)
>   bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
>                            type only for now)

The commit message states bpf_netpoll_send_udp() is "LSM prog type only
for now," but looking at the implementation in bpf_netpoll_kfunc_init(),
the function registers netpoll_kfunc_set using BPF_PROG_TYPE_UNSPEC:

net/core/bpf_netpoll.c:bpf_netpoll_kfunc_init() {
    ...
    ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
                                           &netpoll_kfunc_set);
    ...
}

Per bpf_prog_type_to_kfunc_hook() in kernel/bpf/btf.c, BPF_PROG_TYPE_UNSPEC
maps to BTF_KFUNC_HOOK_COMMON, which makes the kfunc available to ALL BPF
program types, not just LSM.

The check in btf_kfunc_is_allowed() tests BTF_KFUNC_HOOK_COMMON first and
returns true if the kfunc is present there, so any program type (tracing,
kprobe, XDP, sched-cls, etc.) can call bpf_netpoll_send_udp().

Is the commit message stale, or should the registration be
BPF_PROG_TYPE_LSM instead of BPF_PROG_TYPE_UNSPEC to match the stated
design?

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig

[ ... ]

> diff --git a/include/linux/bpf_netpoll.h b/include/linux/bpf_netpoll.h
> --- /dev/null
> +++ b/include/linux/bpf_netpoll.h

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> diff --git a/net/core/Makefile b/net/core/Makefile
> --- a/net/core/Makefile
> +++ b/net/core/Makefile

[ ... ]

> diff --git a/net/core/bpf_netpoll.c b/net/core/bpf_netpoll.c
> --- /dev/null
> +++ b/net/core/bpf_netpoll.c
> @@ -0,0 +1,209 @@

[ ... ]

> +BTF_KFUNCS_START(netpoll_kfunc_btf_ids)
> +BTF_ID_FLAGS(func, bpf_netpoll_send_udp, KF_RCU)
> +BTF_KFUNCS_END(netpoll_kfunc_btf_ids)
> +
> +static const struct btf_kfunc_id_set netpoll_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &netpoll_kfunc_btf_ids,
> +};
> +
> +BTF_ID_LIST(bpf_netpoll_dtor_ids)
> +BTF_ID(struct, bpf_netpoll)
> +BTF_ID(func, bpf_netpoll_release_dtor)
> +
> +static int __init bpf_netpoll_kfunc_init(void)
> +{
> +	int ret;
> +	const struct btf_id_dtor_kfunc bpf_netpoll_dtors[] = {
> +		{
> +			.btf_id       = bpf_netpoll_dtor_ids[0],
> +			.kfunc_btf_id = bpf_netpoll_dtor_ids[1],
> +		},
> +	};
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&netpoll_init_kfunc_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +					       &netpoll_kfunc_set);
> +	return ret ?: register_btf_id_dtor_kfuncs(bpf_netpoll_dtors,
> +						  ARRAY_SIZE(bpf_netpoll_dtors),
> +						  THIS_MODULE);
> +}
> +
> +late_initcall(bpf_netpoll_kfunc_init);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25660780250
--===============3901398826449329569==--
