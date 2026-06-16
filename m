Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BA3B6C15
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605094; cv=none; b=kP9FgchWmGPtVG4g4wn1esbejYu+SNfVKR/MJpwgSfrJaQJmJiinTPlkPofXxN2j7sdkCynpVSkA6n7TgtM/Lybprb47g3t4GTUucnkUfoImmTOOGcmyroU5IHJ0rjyok1sWbTqEFX5qpv88qyU7iumgr9RO29h4MvuFFKh9z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605094; c=relaxed/simple;
	bh=3QBXNRR+lpk/cTHgy6WA5onJYnTv+CN3GKz98njmQr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VARmKtBfGcz/QVZU4BAm/TOom73EaE7cK8XmTp2Xc1VJ378Z6+4tWMD8pvzXdHJQpDhXHBjZCBdq+rThGYMOGe8uW3AQegBH4mo3E+4KkGByN6XTQZjjWT+VP4fZjIug4Mqy6xkKA7JRbsp/UldhvkEdZTp+xBOr/WjGmy6uuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCo5nJTh; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kCo5nJTh"
Message-ID: <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781605081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//o9T+LjbxLcDoBTIq4I5DoHUWaRbI9D0OLgPAgmSYE=;
	b=kCo5nJTh/ptmf2R66/yT4SEqUf6cTJ5CThld/XxO9GFHiDUCVR/PVQnZBN41M45Q3n9CRM
	YQNqdpmQWWufWb7JEhP6TgsAUs8NznrRrF+7nCr3T2p0hoqiJe9wPmee8UXFiJcfHSJii1
	XmHggHbRWvHMGUZXiTVJMys1LDpgte4=
Date: Tue, 16 Jun 2026 18:17:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
To: Sechang Lim <rhkrqnwk98@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/16/26 5:11 PM, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
> sk_callback_lock for write to stop the strparser and verdict, giving the
> lock order stab->lock -> sk_callback_lock.
>
> The opposite order comes from an SK_SKB stream parser. On RX,
> sk_psock_strp_data_ready() holds sk_callback_lock for read while running
> the parser. The verdict redirects the skb to egress, where a sched_cls


The commit message is wrong. A verdict does not redirect to egress
synchronously — sk_psock_skb_redirect() only queues the skb and
schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
context, not under sk_callback_lock.


> program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>
>    WARNING: possible circular locking dependency detected
>    7.1.0-rc6 Not tainted
>    ------------------------------------------------------
>    syz.9.8824 is trying to acquire lock:
>    (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>    but task is already holding lock:
>    (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>
>    -> #1 (clock-AF_INET){++.-}-{3:3}:
>           _raw_write_lock_bh
>           sock_map_del_link net/core/sock_map.c:167
>           sock_map_unref net/core/sock_map.c:184
>           sock_map_update_common net/core/sock_map.c:509
>           sock_map_update_elem_sys net/core/sock_map.c:588
>           map_update_elem kernel/bpf/syscall.c:1805
>
>    -> #0 (&stab->lock){+.-.}-{3:3}:
>           _raw_spin_lock_bh
>           __sock_map_delete net/core/sock_map.c:421
>           sock_map_delete_elem net/core/sock_map.c:452
>           bpf_prog_06044d24140080b6
>           tcx_run net/core/dev.c:4451
>           sch_handle_egress net/core/dev.c:4541
>           __dev_queue_xmit net/core/dev.c:4808
>           ...
>           tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701


I guess it is an ACK. What is the actual purpose of a sched_cls program 
calling

sockmap delete on the TX path of an ACK? If there is no real use case 
for it, this is

just broken BPF usage, not a kernel bug worth this change.


