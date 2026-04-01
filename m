Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69A230264
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004866; cv=none; b=Ttt0tkJiT1yiV4LvJwYh2U/QLVKOdo+sS/1cvViEkdUE/VNr8pbJPp30u7l6AWLqys+LDu7WivVyk0inatrog5BioqYE/bnYlYZltqFY7ebvRQt7QTW2XHhzWc2pznwdD2iCCdOfGynLg7vkXz82cDZ1X4fiq9704BGmwxI++pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004866; c=relaxed/simple;
	bh=tX0nIUjtLQJ2shGr6GObNUwB/I/RDo+zxGCoTBv9OSk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uYzeMD1Jg8VF9xLGLgGdiDXSa/+m0MnZgiwPRc2SmaZnPlYBQvuSC8aRv/ExJEmvWXYyvQdkV4emRGIkm2EeEU6qLuNLQQXjq7t6rJC6SYpeHeR3/uspzgiGNMyKrcwgNzBzoJeJbD6GE5L38KnrbzJgZ/Mt7Ho/g9fkQ3EU890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQwk3CTf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQwk3CTf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c714cb672so3562698b3a.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775004861; x=1775609661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e9WJp97hv4LSl5Cv39KDRDRVZuQGlFifioMUhJvIsZk=;
        b=gQwk3CTfEtSRk6EgW73R1IyYHt3Z1JiVW+SPrAO1V5BEgw9Gtfa3u0pFcg9m2fCmwo
         MiKC/V7ZBIB84KBX6E2qwnI1IhfawhmD3IcL0P3LTx5nPMEgtGfX7E/O06eQSNRgh+y5
         3ukpXRAdAPXKYt0XwKpS796etakpla8ub36+eekDawrXeoj9pXd4Ts8mq0ajCwPOxzQd
         2JwCHezzCJ96T8Y3j3LmiDmW5KQiYy5T0WoJom56rWYpr3zTLTAjz5jjaOeDlEKzdlrg
         Xc/uA06ZDOKb4Cj+u+77UXq1hEFS8Bp14KYY7i0rPXa+KUMlieSXArZpbwfPiITzHJR7
         zYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775004861; x=1775609661;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9WJp97hv4LSl5Cv39KDRDRVZuQGlFifioMUhJvIsZk=;
        b=SlzdfV0UGq3b4byOHH3KAyvJcQRYD+3iO8TB5hFQ1K2LuE9vR/jdK0mcK5ri5DGvtQ
         8rNOdVGgpOH/tY2VGc6eqDJKryDIN4vv1bAcwUzc+gXu5kXLMmDNLwVn0gQnb602uKCt
         KVnb6W+oh4z2cmLHzG9E/Os/6pXMAU9AGfUHa6EtQjSWOhRfvNk2/pCmFRnlBL8AWQwL
         aDgu0PvasDyC+iQfAGQL3non3oAapMquv10hAnlC+C1No+dhSY4RKqcq+IAjX7ivKIbE
         rXxgIH25SJ1xDNffygbXMdy/GPzF5QlWX0nXsfaSEgnptNB2NlCs7i8BaO435cvdJn23
         nFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3gce7vtYBjgepgJ9J7Cb1rYTUw2hbhhDnIBegzz2oUtsAviiGhO3FW/CU6ycfXFkFJY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjoq256OFUk2elR2ljqQlUNqs7rsqS49TTLX3DHXBWmu7Myd9z
	mfpufces6b9MPLA15u+hdbcIgtBQNlEKmhKXmy8PiTPugOcOwWwBEsz4PU3SzHFvw+aPCIch2Hh
	/ZKZXbg==
X-Received: from pfbfk3.prod.google.com ([2002:a05:6a00:3a83:b0:82c:213e:7964])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188f:b0:82c:d6d3:31a1
 with SMTP id d2e1a72fcca58-82ce89b9465mr1724889b3a.29.1775004861262; Tue, 31
 Mar 2026 17:54:21 -0700 (PDT)
Date: Wed,  1 Apr 2026 00:54:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401005418.2452999-1-kuniyu@google.com>
Subject: [PATCH v1 bpf] sockmap: Fix use-after-free of sk->sk_socket in sk_psock_verdict_data_ready().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free of AF_UNIX socket's sk->sk_socket
in sk_psock_verdict_data_ready(). [0]

In unix_stream_sendmsg(), the peer socket's ->sk_data_ready() is
called after dropping its unix_state_lock().

Although the sender socket holds the peer's refcount, it does not
prevent the peer's sock_orphan(), and the peer's sk_socket might
be freed after one RCU grace period.

Let's fetch the peer's sk->sk_socket and sk->sk_socket->ops under
RCU in sk_psock_verdict_data_ready().

[0]:
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
Read of size 8 at addr ffff8880594da860 by task syz.4.1842/11013

CPU: 1 UID: 0 PID: 11013 Comm: syz.4.1842 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 sk_psock_verdict_data_ready+0xec/0x590 net/core/skmsg.c:1278
 unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2482
 sock_sendmsg_nosec net/socket.c:721 [inline]
 __sock_sendmsg net/socket.c:736 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2585
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2639
 __sys_sendmsg net/socket.c:2671 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7facf899c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007facf9827028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007facf8c15fa0 RCX: 00007facf899c819
RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000004
RBP: 00007facf8a32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007facf8c16038 R14: 00007facf8c15fa0 R15: 00007ffd41b01c78
 </TASK>

Allocated by task 11013:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4538 [inline]
 slab_alloc_node mm/slub.c:4866 [inline]
 kmem_cache_alloc_lru_noprof+0x2b8/0x640 mm/slub.c:4885
 sock_alloc_inode+0x28/0xc0 net/socket.c:316
 alloc_inode+0x6a/0x1b0 fs/inode.c:347
 new_inode_pseudo include/linux/fs.h:3003 [inline]
 sock_alloc net/socket.c:631 [inline]
 __sock_create+0x12d/0x9d0 net/socket.c:1562
 sock_create net/socket.c:1656 [inline]
 __sys_socketpair+0x1c4/0x560 net/socket.c:1803
 __do_sys_socketpair net/socket.c:1856 [inline]
 __se_sys_socketpair net/socket.c:1853 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1853
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kmem_cache_free+0x187/0x630 mm/slub.c:6295
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Reported-by: syzbot+2184232f07e3677fbaef@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/69cc6b9f.a70a0220.128fd0.004b.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 3261793abe83..6187a83bd741 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1267,17 +1267,20 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-	const struct proto_ops *ops;
+	const struct proto_ops *ops = NULL;
+	struct socket *sock;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
-	if (unlikely(!sock))
-		return;
-	ops = READ_ONCE(sock->ops);
+	rcu_read_lock();
+	sock = READ_ONCE(sk->sk_socket);
+	if (likely(sock))
+		ops = READ_ONCE(sock->ops);
+	rcu_read_unlock();
 	if (!ops || !ops->read_skb)
 		return;
+
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
-- 
2.53.0.1118.gaef5881109-goog

