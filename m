Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC83CAE94
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714537; cv=none; b=DGE2c7XTmmdRscA50Ey6mCzWZ2jhnhircf9TafHh3Af114n68++t3h9e7HhFoxD7stFvvCYPSKMNlllLI+rkfmv/IsyUmao1x8vettaigiGxsj6lWAW9JLGP/2Faf+NuqMJWIhn93W8USqx1mvkvnIdd0+jJrPlna4U0cnIbRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714537; c=relaxed/simple;
	bh=te2HwPFrLpOIJqimHA/PycOVonEXKgq0rUadGyu339M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mhlyypgs8/KRqq/Wt1hDIu5QeQJW7xlwWFa/zaPXbOjfF1/TLGno8YO5yl5eQGNzfCsWoEPo/D8G7yfOohTAKaT6oTEdLpbpXCUqj59HnWdVfw7J+/0xDNoZwORmuHXxqywPFAzPwjoenE3cXLMrY7Td1TObWk7Uu5vzEARgSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU99be4o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU99be4o"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso6645795a91.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776714532; x=1777319332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7In5TLQTyzqt//BukZty0CWyvxFvOP52OYf38XLtO9w=;
        b=DU99be4oA1kI+AL4DkdToOFNkCVnWaPLHlikH/DVI6Y4CQsIFbJetpK9pLPviZ2/Bp
         XG7ZcrhD4xfi4alD+kBs15BMNSwM2HV9XT7C+LKRMpngwfivw99X4IoZQ3SPKEgqVv7a
         Z9Go1JkJkYnlQ8OcTHe5hA5TbE353hNHWo5DO69YM/SM9b6RwOt8ZEFSueQdqdF+1ptx
         8QCCI0RFVQiwuGECcDs9dhsiroY00gHxSx8DrgS8zoBy8E3s5jhYXsJCbr8Rg396+6dE
         SgRA5sTiTHEIwMOjG/2fjws1j7Wno61+UP7KdaqjlHYK4eqcxArdmOBk37S59M813jE8
         PG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714532; x=1777319332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7In5TLQTyzqt//BukZty0CWyvxFvOP52OYf38XLtO9w=;
        b=TDX1z4jjjIAjB7volL7neUK19l2h1XRhRgOWesIA8Qh7j5AGxd2uZEcNgz55xIdBe8
         jB6snls56roIQgfIfSzPfsPAZL/kvJdxoerYArXSnqUx+4jU9EVbjP5vbF81TO42OPmK
         jXow08/UtaQYjYFG8FAGdE/2NJ5yi9XNoC8p+izU8uEMrUC5rdgDj8bnAbkJ4v0ZLrop
         HhBC/5ve+gr7QLFxUlwcR3dTmeegqle0NKy6GpQ1UQV3svuSifWGmFrv7AbcHQLif+Rx
         TM6y01BvS70otevNtNSbH9ayYJvvvn3K1P0H5mUru/YPqOwyeQ+Dw3Mw3VXsj0s7zn71
         s8dQ==
X-Forwarded-Encrypted: i=1; AFNElJ9buAOlySNi8IwmND3B5LzQb4L04wQZsVVonc9i5EykBaiTGCIkGUoHtJklSkH8c72z9qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bGUNHVqjojgJ5gybRLgPA2eLFlbzHAcJfG300VewoirqUI9F
	vPw6GoSffmpn//yDrn1XYbHuz+Ham6ap6GUPY8a1DtY33niiwt7c0raVBfTCtRK8+Y2v0HElAFJ
	6wG+40A==
X-Received: from pjh13.prod.google.com ([2002:a17:90b:3f8d:b0:35f:be31:1a85])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8a:b0:35e:3e86:e2d1
 with SMTP id 98e67ed59e1d1-361403d9f44mr15254991a91.7.1776714531560; Mon, 20
 Apr 2026 12:48:51 -0700 (PDT)
Date: Mon, 20 Apr 2026 19:48:41 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420194846.1089595-1-kuniyu@google.com>
Subject: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Wang Yufen <wangyufen@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a splat in sock_map_destroy() [0], where psock was
NULL even though sk->sk_prot still pointed to tcp_bpf_prots[][].

The stack trace shows how badly the path was excercised, see
inet_release() calls tcp_close(), not sock_map_close() yet, but
finally reaching sock_map_destroy().

The root cause is a lack of synchronisation.

Even if sk_psock_get() fails to bump psock->refcnt, it does not
guarantee that sk_psock_drop() has finished, and thus sk->sk_prot
might not have been restored to the original one.

Commit 4b4647add7d3 ("sock_map: avoid race between sock_map_close
and sk_psock_put") attempted to address this, but it was insufficient
for two reasons.

It did not cover sock_map_unhash() and sock_map_destroy(), and
it missed the corner case where sk_psock() is NULL.

On non-x86 platforms, sk_psock_restore_proto(sk, psock) and
rcu_assign_sk_user_data(sk, NULL) can be reordered because there
is no address dependency between sk->sk_prot and sk->sk_user_data.

sk_psock_get() returning NULL implies nothing about sk->sk_prot.

Let's simply retry sk_psock_get() in the unlikely case.

Note that we cannot avoid loop even if we added memory barrier
in sk_psock_drop() and sock_map_psock_get_checked().

[0]:
WARNING: CPU: 1 PID: 8459 at net/core/sock_map.c:1667 sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Modules linked in:
CPU: 1 UID: 0 PID: 8459 Comm: syz.0.1109 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:sock_map_destroy+0x28b/0x2b0 net/core/sock_map.c:1667
Code: 8b 36 49 83 c6 38 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 93 62 22 f9 4d 8b 3e e9 79 ff ff ff e8 a6 2b c3 f8 90 <0f> 0b 90 eb 9c e8 9b 2b c3 f8 4c 89 e7 be 03 00 00 00 e8 0e 4e bc
RSP: 0018:ffffc9000d067be8 EFLAGS: 00010293
RAX: ffffffff88fb30aa RBX: ffff888024832000 RCX: ffff888024283b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100862e946 R12: dffffc0000000000
R13: ffff888024832000 R14: ffffffff995b2208 R15: ffffffff88fb2e20
FS:  0000555579a7d500(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000048c0 CR3: 000000003713a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inet_csk_destroy_sock+0x166/0x3a0 net/ipv4/inet_connection_sock.c:1294
 __tcp_close+0xcc1/0xfd0 net/ipv4/tcp.c:3262
 tcp_close+0x28/0x110 net/ipv4/tcp.c:3274
 inet_release+0x144/0x190 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc0/0x240 net/socket.c:1439
 __fput+0x45b/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265847ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd158dfbd8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000002ddb0 RCX: 00007f265847ebe9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f26586a7da0 R08: 0000000000000001 R09: 0000000e158dfecf
R10: 0000001b30a20000 R11: 0000000000000246 R12: 00007f26586a5fac
R13: 00007f26586a5fa0 R14: ffffffffffffffff R15: 00007ffd158dfcf0
 </TASK>

Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Fixes: b05545e15e1f ("bpf: sockmap, fix transition through disconnect without close")
Fixes: d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
Reported-by: syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/69cec5ef.050a0220.2dbe29.0009.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Fix small race window in no-loop-approach.
v1: https://lore.kernel.org/bpf/20260402203754.280844-1-kuniyu@google.com/
---
 net/core/sock_map.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 02a68be3002a..99e3789492a0 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1630,18 +1630,23 @@ void sock_map_unhash(struct sock *sk)
 	void (*saved_unhash)(struct sock *sk);
 	struct sk_psock *psock;
 
+retry:
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
+		if (unlikely(saved_unhash == sock_map_unhash))
+			goto retry;
 	} else {
 		saved_unhash = psock->saved_unhash;
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
+
+		if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
+			return;
 	}
-	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
-		return;
+
 	if (saved_unhash)
 		saved_unhash(sk);
 }
@@ -1652,20 +1657,25 @@ void sock_map_destroy(struct sock *sk)
 	void (*saved_destroy)(struct sock *sk);
 	struct sk_psock *psock;
 
+retry:
 	rcu_read_lock();
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
+		if (unlikely(saved_destroy == sock_map_destroy))
+			goto retry;
 	} else {
 		saved_destroy = psock->saved_destroy;
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		sk_psock_put(sk, psock);
+
+		if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
+			return;
 	}
-	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
-		return;
+
 	if (saved_destroy)
 		saved_destroy(sk);
 }
@@ -1676,32 +1686,33 @@ void sock_map_close(struct sock *sk, long timeout)
 	void (*saved_close)(struct sock *sk, long timeout);
 	struct sk_psock *psock;
 
+retry:
 	lock_sock(sk);
 	rcu_read_lock();
-	psock = sk_psock(sk);
+	psock = sk_psock_get(sk);
 	if (likely(psock)) {
 		saved_close = psock->saved_close;
 		sock_map_remove_links(sk, psock);
-		psock = sk_psock_get(sk);
-		if (unlikely(!psock))
-			goto no_psock;
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
 		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
+
+		/* Make sure we do not recurse. This is a bug.
+		 * Leak the socket instead of crashing on a stack overflow.
+		 */
+		if (WARN_ON_ONCE(saved_close == sock_map_close))
+			return;
 	} else {
 		saved_close = READ_ONCE(sk->sk_prot)->close;
-no_psock:
 		rcu_read_unlock();
 		release_sock(sk);
+
+		if (unlikely(saved_close == sock_map_close))
+			goto retry;
 	}
 
-	/* Make sure we do not recurse. This is a bug.
-	 * Leak the socket instead of crashing on a stack overflow.
-	 */
-	if (WARN_ON_ONCE(saved_close == sock_map_close))
-		return;
 	saved_close(sk, timeout);
 }
 EXPORT_SYMBOL_GPL(sock_map_close);
-- 
2.54.0.rc1.555.g9c883467ad-goog

