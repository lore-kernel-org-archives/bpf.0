Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002D46B5
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677840; cv=none; b=b5hAq/FMFzPdXR3dnaFXOs3YaByLexpqf6R2lBW9IY8y6RNfK6MSJQ3SUChqDZ1zNASIamAolTxDaqEZyaP4MC5BPWXlOrJ8zKTHiymcnDu0c3de1/lhM7vce02/qlF8WhtutCgDaj7Iq0PsyC0StbyT8TRNTOl0c5OKD/eJ+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677840; c=relaxed/simple;
	bh=KJrGWC9qcRPY59iBcTX6nUVjltKd5Md5FdfXV0UJjF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7P2LlviKFvAW3Jzv3AnNJSze23+TrfCV2NbmQ84q+ZohYoWpwiyJV1l6D/4QHb/thKE8REcewSaj85fzqiCr8nt/JHrG8PZevgXz/20iNkEe2qt3Q6NB+U4pUzXaqOJlILYATF/30/47K7z4DaAh8SDouNSgGCQQmqhGc1bQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIak2M76; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIak2M76"
Date: Thu, 5 Mar 2026 10:30:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772677836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8IAhsCTPaaj49fw0EkRaGxHy6m09MppnBlqhQd5DSh4=;
	b=vIak2M76ZjO6Y/YCDIrXDHHXLMRoIWi/ffz1M/m/6MkMOTCad+3cwY0umDCtM39A+SSoup
	I3zERGx0GrX9XoodkyX6mf/iDwEYs7qX56EXh4uEs5cPOFWTS5zTO0vjMqsgpIqmIAxl1j
	sfgRgE7IN6r6tFi8NCyqWHvGSAssssA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in
 udp_bpf_recvmsg().
Message-ID: <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 21, 2026 at 11:30:50PM +0800, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0]
> 
> sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> but its processing is lockless.
> 
> Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> multiple threads could touch the same sk_msg.
> 
> For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock.
> 
> Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> commit accidentally removed it.
> 
> Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
> 
> Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> an option due to copy_page_to_iter() in sk_msg_recvmsg().
> 
> [0]:
> BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/skmsg.c:428
> Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
> 
> CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>

[...] 
> Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/udp_bpf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 779a3a03762f..b07774034a91 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -52,7 +52,9 @@ static int udp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret = udp_msg_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret = udp_msg_has_data(sk, psock);
>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> @@ -81,6 +83,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		goto out;
>  	}
>  
> +	lock_sock(sk);
>  msg_bytes_ready:
>  	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
>  	if (!copied) {
> @@ -92,11 +95,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  		if (data) {
>  			if (psock_has_data(psock))
>  				goto msg_bytes_ready;
> +
> +			release_sock(sk);
> +
>  			ret = sk_udp_recvmsg(sk, msg, len, flags, addr_len);
>  			goto out;
>  		}
>  		copied = -EAGAIN;
>  	}
> +
> +	release_sock(sk);
> +
>  	ret = copied;
>  out:
>  	sk_psock_put(sk, psock);
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

LGTM.

One minor observation for a possible follow-up:
psock_has_data() is checked before lock_sock(), which leaves a TOCTOU window.

If the BPF verdict path consumes the skb from the UDP receive queue and redirects it to
psock->ingress_msg between the check and sk_udp_recvmsg(), the thread may block in
__skb_recv_udp() while data is already available in the psock.

Moving lock_sock() before the psock_has_data() check (as the original code
did before 9f2470fbc4cb) would narrow this window, similar to how
__tcp_bpf_recvmsg() acquires lock_sock() upfront. But that can be a
separate patch.
