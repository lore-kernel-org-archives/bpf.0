Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28C3370EC
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 02:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085756; cv=none; b=Ndw2nk1dIr5eq09LP12jSE3kCtuA+cXt1IZd0ECYxAE7ScZL1w1v7i2tx2/mL00EGZjldCfV3GGMS65blgwWAnqf1TPngBmWnylJFEg9Oo7ik4fY9JkVQMi18o4yWqgVCe+rDzntaWUeg2YDwiP1znorPsGjt/M/zhlv3T08DPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085756; c=relaxed/simple;
	bh=UmV3xv7xVf2Zo2jFtRDOFkdl/3JCz++nNgKfRcYOJ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=En9RM5LB7FKir8ftiiF/hSToymlfjy6lxT5X9wjcF8fBkL6FwqDHM93BkQ6NkJ2eBS5t2MZJ2abHZrsQ4fKJML8aPXDbYQfbSbd986NStHreAI6msLeNgHv9ly0YWWVOBLoEnpoNx75ZuHHDg5ZFvPclDPSnOemGsHlCkg3N3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMnNM1St; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMnNM1St"
Message-ID: <11e4c78b-dd7b-44f7-800f-cf64517f4a1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777085743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wl0lrophzi3EeTmlvaWExT7+wFATN1EZSzwT4PC8Lwc=;
	b=XMnNM1StXu64hqnkN6CLPsSarr1RFd7ibE923zPbneYwRMvO6ER9FwL7GJ9sGGMNNjaEQs
	8NICDG8y8nAjz+cwzSzAv5lzuMV+/VdPbdqy3bOTI+Pvsbs/EHyMQ09Otra+31IP+Zp4v/
	Phx//PeVCgBrdoSrr40GRug94lvrAXM=
Date: Sat, 25 Apr 2026 10:55:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: reject overflowing copy + len in
 bpf_msg_push_data()
To: Weiming Shi <bestswngs@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>
References: <20260424191602.1522411-3-bestswngs@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260424191602.1522411-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/25/26 3:16 AM, Weiming Shi wrote:
> When the scatterlist ring is full or nearly full, bpf_msg_push_data()
> enters a copy fallback path and computes copy + len for the page
> allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
> and both are u32, a crafted len can wrap the sum to a small value,
> causing an undersized allocation followed by an out-of-bounds memcpy.
>
>   BUG: unable to handle page fault for address: ffffed104089a402
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   Call Trace:
>    __asan_memcpy (mm/kasan/shadow.c:105)
>    bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
>    bpf_prog_9ed8b5711920a7d7+0x2e/0x36
>    sk_psock_msg_verdict (net/core/skmsg.c:934)
>    tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
>    __sys_sendto (net/socket.c:2206)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
> Add an overflow check before the allocation.
>
> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Tested-by: Xiang Mei <xmei5@asu.edu>
> Tested-by: Xinyu Ma <mmmxny@gmail.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


