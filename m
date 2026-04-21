Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293C3A5E90
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763630; cv=none; b=HARPaVXoTAX5hA4GtzJub5sWySSVxyJozDIkIhJRBdLMM5pk7alhgowdxRG7NsaADhmGh2+2S/G7VJr86KUOm4odNLvHeZY/84Nl0hxC7ZNAUmHKhjv+libLacXVryCckT0KolsMsbInCvxqtIWtpl+PEPZBHXQ4TJN6IL7xFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763630; c=relaxed/simple;
	bh=6Syk34H+nIqB0N0wfMBbfjhm3H04x00ALoDFp/BR09I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pChPRidwOpTHkvBzark5O5PvrWdRLZ+6dxS4jQA9YNwmEVAQMiv8wAb7SlAtNCjW/VZ6lAutUQCyhM4f5DLEEmCXQIzeZhyvn9fkSc0tnwf12WLHWzkCogxv75qItHG+hsB4XlO2H1SzyNzc8Slx3kr28AfguzJS/JORFTle2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iYzSkTnt; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iYzSkTnt"
Message-ID: <68114d12-1b7e-48d9-a4a4-214f046ea516@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776763626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cfCFa4zD99fqw39Vc/OUcpIA0cU2QJgGy2SzxNl+DY=;
	b=iYzSkTntx0gvvKigbuHTpo809EhhEXbu0kdjp/Rcf6L+5ll2ihM761eAyjFpGELXjbVJ0V
	SlRYy7psZBqhXfhB/iSUYtF0YTPkuLe1am0vmYBZ4KmcfBAEBPLLj1PxFZyJeSi1on7sCu
	LlILMCzej3B6B5OD//f8dWdkPYCUXnQ=
Date: Tue, 21 Apr 2026 17:26:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs
 sock_map_{unhash,close,destroy}().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Wang Yufen <wangyufen@huawei.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org,
 syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
References: <20260420194846.1089595-1-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260420194846.1089595-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/21/26 3:48 AM, Kuniyuki Iwashima wrote:
> syzbot reported a splat in sock_map_destroy() [0], where psock was
> NULL even though sk->sk_prot still pointed to tcp_bpf_prots[][].
>
> The stack trace shows how badly the path was excercised, see
> inet_release() calls tcp_close(), not sock_map_close() yet, but
> finally reaching sock_map_destroy().
>
> The root cause is a lack of synchronisation.
>
> Even if sk_psock_get() fails to bump psock->refcnt, it does not
> guarantee that sk_psock_drop() has finished, and thus sk->sk_prot
> might not have been restored to the original one.
>
> Commit 4b4647add7d3 ("sock_map: avoid race between sock_map_close
> and sk_psock_put") attempted to address this, but it was insufficient
> for two reasons.
>
> It did not cover sock_map_unhash() and sock_map_destroy(), and
> it missed the corner case where sk_psock() is NULL.
>
> On non-x86 platforms, sk_psock_restore_proto(sk, psock) and
> rcu_assign_sk_user_data(sk, NULL) can be reordered because there
> is no address dependency between sk->sk_prot and sk->sk_user_data.
>
> sk_psock_get() returning NULL implies nothing about sk->sk_prot.
>
> Let's simply retry sk_psock_get() in the unlikely case.
>
> Note that we cannot avoid loop even if we added memory barrier
> in sk_psock_drop() and sock_map_psock_get_checked().
>
> [0]:
> WARNING: CPU: 1 PID: 8459 at net/core/sock_map.c:1667 sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
> Modules linked in:
> CPU: 1 UID: 0 PID: 8459 Comm: syz.0.1109 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
> Code: 8b 36 49 83 c6 38 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 93 62 22 f9 4d 8b 3e e9 79 ff ff ff e8 a6 2b c3 f8 90 <0f> 0b 90 eb 9c e8 9b 2b c3 f8 4c 89 e7 be 03 00 00 00 e8 0e 4e bc
> RSP: 0018:ffffc9000d067be8 EFLAGS: 00010293
> RAX: ffffffff88fb30aa RBX: ffff888024832000 RCX: ffff888024283b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed100862e946 R12: dffffc0000000000
> R13: ffff888024832000 R14: ffffffff995b2208 R15: ffffffff88fb2e20
> FS:  0000555579a7d500(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00002000000048c0 CR3: 000000003713a000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   inet_csk_destroy_sock+0x166/0x3a0 net/ipv4/inet_connection_sock.c:1294
>   __tcp_close+0xcc1/0xfd0 net/ipv4/tcp.c:3262
>   tcp_close+0x28/0x110 net/ipv4/tcp.c:3274
>   inet_release+0x144/0x190 net/ipv4/af_inet.c:435
>   __sock_release net/socket.c:649 [inline]
>   sock_close+0xc0/0x240 net/socket.c:1439
>   __fput+0x45b/0xa80 fs/file_table.c:468
>   task_work_run+0x1d4/0x260 kernel/task_work.c:227
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
>   exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>   syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>   do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f265847ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd158dfbd8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 000000000002ddb0 RCX: 00007f265847ebe9
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f26586a7da0 R08: 0000000000000001 R09: 0000000e158dfecf
> R10: 0000001b30a20000 R11: 0000000000000246 R12: 00007f26586a5fac
> R13: 00007f26586a5fa0 R14: ffffffffffffffff R15: 00007ffd158dfcf0
>   </TASK>
>
> Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
> Fixes: b05545e15e1f ("bpf: sockmap, fix transition through disconnect without close")
> Fixes: d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
> Reported-by: syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/69cec5ef.050a0220.2dbe29.0009.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Thanks,

LGTM.  I reproduced and tested it and the patch fixed the problem.


