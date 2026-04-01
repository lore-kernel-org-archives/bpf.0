Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051936B06F
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042011; cv=none; b=qwjNbmQ6vvUMh81OxCz3gbwxGbPNztWi0LQpAIpqlGG4s8eIu9fTuvKfVFBSZleWqjOtHMzpEORTeDlJ2E2s0pAVnnzMPJitXkxjHlU2tHDoI0Yxykhn4gWnJOy75/omi4Q1+EdiDUiZx3cmvRbyaRSg5K/qBmKOMJhfhZQJ/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042011; c=relaxed/simple;
	bh=+EMaqmV5IGyRb6aXl8/mlfL+Ehdt6ysva3usNERfTSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmEa7mr6FwW/yUwZcZejnV9WxG+hVJUpgnFYPXpDeLrVlRqmCXAAPM0qp09pIKdscKB4XAhzOMvZU652O+cDxhdJS/71Q19hjROg9K5PkmZAaZDf+uBEO6lpVBexxASeR5/5ddINvoQPclminxlWMGdGEwf/vheQObsRW8zlVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKWUgFTj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKWUgFTj"
Message-ID: <0a06dbbe-1039-48dc-8fa1-331dac63559c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775042007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCdKZSxuAD+d/u0f+cnJAQd8hizdkeJxdxVPMULokRQ=;
	b=HKWUgFTjS42Gua+FSdX6+neyu9OP/spCiUK9iyVwSNKQNsZS7qJnpGTiSBU3DVFSSfA6/+
	Y5kYGafC1umHXuY9uPEUNHTj98XiHTK/yr7Moc51ZQdsZSxKthTZxmanFg+fr1/Zc4ZpbY
	aQU3MHcX7LNAnQwiw8B9ixUvzujKr4g=
Date: Wed, 1 Apr 2026 19:13:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf] sockmap: Fix use-after-free of sk->sk_socket in
 sk_psock_verdict_data_ready().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com
References: <20260401005418.2452999-1-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260401005418.2452999-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/1/26 8:54 AM, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free of AF_UNIX socket's sk->sk_socket
> in sk_psock_verdict_data_ready(). [0]
>
> In unix_stream_sendmsg(), the peer socket's ->sk_data_ready() is
> called after dropping its unix_state_lock().
>
> Although the sender socket holds the peer's refcount, it does not
> prevent the peer's sock_orphan(), and the peer's sk_socket might
> be freed after one RCU grace period.
>
> Let's fetch the peer's sk->sk_socket and sk->sk_socket->ops under
> RCU in sk_psock_verdict_data_ready().
>
> [0]:
> BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
> Read of size 8 at addr ffff8880594da860 by task syz.4.1842/11013
>
> CPU: 1 UID: 0 PID: 11013 Comm: syz.4.1842 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xba/0x230 mm/kasan/report.c:482
>   kasan_report+0x117/0x150 mm/kasan/report.c:595
>   sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
>   unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2482
>   sock_sendmsg_nosec net/socket.c:721 [inline]
>   __sock_sendmsg net/socket.c:736 [inline]
>   ____sys_sendmsg+0x972/0x9f0 net/socket.c:2585
>   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2639
>   __sys_sendmsg net/socket.c:2671 [inline]
>   __do_sys_sendmsg net/socket.c:2676 [inline]
>   __se_sys_sendmsg net/socket.c:2674 [inline]
>   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2674
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7facf899c819
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007facf9827028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007facf8c15fa0 RCX: 00007facf899c819
> RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000004
> RBP: 00007facf8a32c91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007facf8c16038 R14: 00007facf8c15fa0 R15: 00007ffd41b01c78
>   </TASK>
[...]
>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Reported-by: syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/69cc6b9f.a70a0220.128fd0.004b.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> ---
>   net/core/skmsg.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 3261793abe83..6187a83bd741 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1267,17 +1267,20 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
>   
>   static void sk_psock_verdict_data_ready(struct sock *sk)
>   {
> -	struct socket *sock = sk->sk_socket;
> -	const struct proto_ops *ops;
> +	const struct proto_ops *ops = NULL;
> +	struct socket *sock;
>   	int copied;
>   
>   	trace_sk_data_ready(sk);
>   
> -	if (unlikely(!sock))
> -		return;
> -	ops = READ_ONCE(sock->ops);
> +	rcu_read_lock();
> +	sock = READ_ONCE(sk->sk_socket);
> +	if (likely(sock))
> +		ops = READ_ONCE(sock->ops);
> +	rcu_read_unlock();
>   	if (!ops || !ops->read_skb)
>   		return;
> +
>   	copied = ops->read_skb(sk, sk_psock_verdict_recv);
>   	if (copied >= 0) {
>   		struct sk_psock *psock;
