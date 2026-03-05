Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAE37AA68
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710069; cv=none; b=WcrCwGmhG2paa67IJJGBr/BHutPnbF0I3DYxqSw3bpXm1iuHIoAQ2cUOC23SFjY3dA2z+FyqyN/7tFWOnXpldhoLQI4IDC3ww0YMNHoyCvYLsS3WlzTwAwuOkqeyK2VL85/8Fmjs1e751PNiv58Y/n8Lld5a4s6EhcHHPZw5E1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710069; c=relaxed/simple;
	bh=iKymPhGye+cdouPYHEN4Jj1ZVauyxKfTUpLBhyIibSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIWfK3LnNCto6R2+R+VNVjEUZ166S1zku/yNJkn/XAbT1ZjElQ8mqGpIOPLhfOB7c05xzzGgrWAk/gdF/BdMwdn9Mb2tOiP6+2EUxX6X9Jk54jFMbA+sLAk+4JQZEfmiwgXYp84gz1dF7zcqcYJo11tnxIfW8DWsvm5fv+qo08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KSTdVSdW; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KSTdVSdW"
Date: Thu, 5 Mar 2026 19:27:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772710065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHjZWEDNZiaOFtzpXckHo29DrJiIVSf/NVQLIvzdp8=;
	b=KSTdVSdWRmB7yZA+a+76H3J3y3dQADu0L8rlCDriCP5RZsblmF5JEK2QCkX6+z/3W8AKNT
	FmFlvI1sdTqm4EZlZXVqcd3uuWfycODchR7jXX5tu7UErTuGIbdm7sZNqjs5WYhL5ZiEQV
	BkW7ebD7LinBngwLy07gXI7UDptmaXI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 1/6] sockmap: Annotate sk->sk_data_ready() for
 UDP.
Message-ID: <3vjijl45ah2i666j5fkaekvu2uxgw3q2jtg6rs7y24gffbsesz@fkvdvr37ju7v>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-2-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 21, 2026 at 11:30:48PM +0800, Kuniyuki Iwashima wrote:
> syzbot reported data race of sk->sk_data_ready(). [0]
> 
> UDP fast path does not hold bh_lock_sock(), instead
> spin_lock_bh(&sk->sk_receive_queue.lock) is used.
> 
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_data_ready().
> 
> Another option is to hold sk->sk_receive_queue.lock in
> sock_map_sk_acquire() if sk_is_udp() is true, but this is
> overkill and also does not work for sk->sk_write_space().
> 
> [0]:
> BUG: KCSAN: data-race in __udp_enqueue_schedule_skb / sk_psock_drop
> 
> write to 0xffff88811d063048 of 8 bytes by task 23114 on cpu 0:
>  sk_psock_stop_verdict net/core/skmsg.c:1287 [inline]
>  sk_psock_drop+0x12f/0x270 net/core/skmsg.c:873
>  sk_psock_put include/linux/skmsg.h:473 [inline]
>  sock_map_unref+0x2a5/0x300 net/core/sock_map.c:185
>  __sock_map_delete net/core/sock_map.c:426 [inline]
>  sock_map_delete_from_link net/core/sock_map.c:439 [inline]
>  sock_map_unlink net/core/sock_map.c:1608 [inline]
>  sock_map_remove_links+0x228/0x340 net/core/sock_map.c:1623
>  sock_map_close+0xa1/0x340 net/core/sock_map.c:1684
>  inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
>  __sock_release net/socket.c:662 [inline]
>  sock_close+0x6b/0x150 net/socket.c:1455
>  __fput+0x29b/0x650 fs/file_table.c:468
>  ____fput+0x1c/0x30 fs/file_table.c:496
>  task_work_run+0x130/0x1a0 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
>  exit_to_user_mode_loop+0x1f7/0x6f0 kernel/entry/common.c:75
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
>  do_syscall_64+0x1d3/0x2a0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff88811d063048 of 8 bytes by task 23117 on cpu 1:
>  __udp_enqueue_schedule_skb+0x6c1/0x840 net/ipv4/udp.c:1789
>  __udp_queue_rcv_skb net/ipv4/udp.c:2346 [inline]
>  udp_queue_rcv_one_skb+0x709/0xc20 net/ipv4/udp.c:2475
>  udp_queue_rcv_skb+0x20e/0x2b0 net/ipv4/udp.c:2493
>  __udp4_lib_mcast_deliver+0x6e8/0x790 net/ipv4/udp.c:2585
>  __udp4_lib_rcv+0x96f/0x1260 net/ipv4/udp.c:2724
>  udp_rcv+0x4f/0x60 net/ipv4/udp.c:2911
>  ip_protocol_deliver_rcu+0x3f9/0x780 net/ipv4/ip_input.c:207
>  ip_local_deliver_finish+0x1fc/0x2f0 net/ipv4/ip_input.c:241
>  NF_HOOK include/linux/netfilter.h:318 [inline]
>  ip_local_deliver+0xe8/0x1e0 net/ipv4/ip_input.c:262
>  dst_input include/net/dst.h:474 [inline]
>  ip_sublist_rcv_finish net/ipv4/ip_input.c:584 [inline]
>  ip_list_rcv_finish net/ipv4/ip_input.c:628 [inline]
>  ip_sublist_rcv+0x42b/0x6d0 net/ipv4/ip_input.c:644
>  ip_list_rcv+0x261/0x290 net/ipv4/ip_input.c:678
>  __netif_receive_skb_list_ptype net/core/dev.c:6195 [inline]
>  __netif_receive_skb_list_core+0x4dc/0x500 net/core/dev.c:6242
>  __netif_receive_skb_list net/core/dev.c:6294 [inline]
>  netif_receive_skb_list_internal+0x47d/0x5f0 net/core/dev.c:6385
>  netif_receive_skb_list+0x31/0x1f0 net/core/dev.c:6437
>  xdp_recv_frames net/bpf/test_run.c:269 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:350 [inline]
>  bpf_test_run_xdp_live+0x104c/0x1360 net/bpf/test_run.c:379
>  bpf_prog_test_run_xdp+0x57b/0xa10 net/bpf/test_run.c:1396
>  bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4703
>  __sys_bpf+0x4c0/0x7b0 kernel/bpf/syscall.c:6182
>  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
>  __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6272
>  x64_sys_call+0x28e1/0x3000 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0xffffffff847b24d0 -> 0xffffffff84673410
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 23117 Comm: syz.8.5085 Tainted: G        W           syzkaller #0 PREEMPT(voluntary)
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> 
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Reported-by: syzbot+113cea56c13a8a1e95ab@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e1.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/skmsg.c | 4 ++--
>  net/ipv4/udp.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index ddde93dd8bc6..75fa94217e1e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1296,7 +1296,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
>  		return;
>  
>  	psock->saved_data_ready = sk->sk_data_ready;
> -	sk->sk_data_ready = sk_psock_verdict_data_ready;
> +	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
>  	sk->sk_write_space = sk_psock_write_space;
>  }
>  
> @@ -1308,6 +1308,6 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
>  	if (!psock->saved_data_ready)
>  		return;
>  
> -	sk->sk_data_ready = psock->saved_data_ready;
> +	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
>  	psock->saved_data_ready = NULL;
>  }
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index b96e47f1c8a2..422c96fea249 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1787,7 +1787,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  		 * using prepare_to_wait_exclusive().
>  		 */
>  		while (nb) {
> -			INDIRECT_CALL_1(sk->sk_data_ready,
> +			INDIRECT_CALL_1(READ_ONCE(sk->sk_data_ready),
>  					sock_def_readable, sk);
>  			nb--;
>  		}
> -- 
> 2.53.0.371.g1d285c8824-goog
> 

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
