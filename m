Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB63019BA
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162279; cv=none; b=rDtBW0yaNvw7nU7ihn588aLRL267NlG2UBjLQgG1AYuyBkdsd7QBw2w4Gj9fIIodZ8Cnt432DBzvJ43OuEICaf3ADYlu7Yc9UgFGLOtOZgQbaRrcVyKj8I3aSWMxYCOceEWAgoAMpt9OClB5H6OE3yP1cc7tr4zgAoc0K2lGuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162279; c=relaxed/simple;
	bh=K6UeDia9sanUos9Mjkr7NnkAAtxeMCfMlhzE78+/mUE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kvcmj1tP90uhuZkfzWXJpZyVMqw1B0XOTCUywE8Z/lFkovSYvuuBcCyb9tT+fnzOjRO+R2VUqSpVmrPJSYTRb8OC3+6MvhffXu6poFeRmCjIwQDt7/d/KH/euN9yzPUbBpBw1X78vX6KVmNBbZh2M90GcAtQvxKJ+ku+GwSw9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfMOSW6g; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfMOSW6g"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a88a2704fso598874b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775162277; x=1775767077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iY/+kUa2oeDqlEImeMTWfoVrRsju1NxUYvhxVqSs/RM=;
        b=QfMOSW6gfuGVgC/hlU6fSFblYOqiou/cB5dqEUPxvcAs8EFCWJXhNU6iPTcMA0x+ib
         sQS/tQBpeX4u/X/P/pa/ka9ukUQRKgGlboMN0oEgBCXHZkd/t4hn4TED5mOLlIfM5/tz
         RaN7AvxE2E/F3oijTPk/XAlIQvQ21hkReKLIUpqolJHF1l8JA7vSSXWpyyT/HEzEFYmz
         UYuvwpHs5Z6n9uprXf/v9YJLP5syZT130ofCTfSw500izSCufzuEPrcN4csQuPZ0shgH
         iIKGQZIzOl+Iq9+3+hzMAo5dKzlPW1IdnwPqF12VYdgF53YkmsVbZBnwzi2LlVvyHVGn
         jQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162277; x=1775767077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iY/+kUa2oeDqlEImeMTWfoVrRsju1NxUYvhxVqSs/RM=;
        b=JgVSmxC6bEfrGNFieSUiegZBp6QsDT1PpoPRRo4SQbC2TDiCMmElcD6n9bS8NmIscR
         9Sl/ucsG/eFANdb+OWtQ5b+FsvQ9UzfHcm/NQxCCw6RoG8htU8YzJ4wHy1klaK3YSFJJ
         HcWMThqBOGBAMMZo8U+xjymJiiq6ckhxH3dTCJ8VXclNefjQdFEHb1/DCDuio6mRWYAz
         7hCzeQ1um0b7uZ3n+Bfab5s6HwHxux/fIaauZDhfoz+PCxw+t6OsKij3HzZ1i0zze27+
         WBwAiGoZV63RrOn4BcjpnGLiwDRv3B38yMsCNxtL2P6BE7Qr5h9/RFow4gSzM5vezIWh
         EDKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3S7X1CI/X5Z3Np2jQJjimRYdaf14Fd3a7xZQhCebckF4rkXyFAHetf8Yn5TCB1qAFoIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvY3cCBvHgqgnPKS6qKg1+FfkWLRFcBSJ72udZgF4ryIs14dyR
	P0aZ24SJeXf6Gpj1Z+fpuo/HjbEVx/0nwKWtVUtudJS62COrA2aEYAgv5XL6lSkUVEULur+m/+d
	EV5rvZg==
X-Received: from pfcg17.prod.google.com ([2002:a05:6a00:23d1:b0:82c:70d1:f303])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f6:b0:82c:7420:82bf
 with SMTP id d2e1a72fcca58-82d0dbfef49mr399978b3a.19.1775162277181; Thu, 02
 Apr 2026 13:37:57 -0700 (PDT)
Date: Thu,  2 Apr 2026 20:37:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402203754.280844-1-kuniyu@google.com>
Subject: [PATCH v1 bpf] sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Wang Yufen <wangyufen@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	syzbot+b0842d38af58376d1fdc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported a splat in sock_map_destroy() [0], where psock was
NULL even though sk->sk_prot still pointed to tcp_bpf_prots[][].

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

sk_psock_get() returning NULL implies nothing about sk->sk_prot,
and we need a synchronisation.

The possible options would be:

  1) Put smp_wmb() and smp_rmb() properly
  2) Put sk_callback_lock locking dance in the unlikely case
  3) Retry sk_psock_get() in the unlikely case

1) sounds straightforward but at the expense of the normal
path for the super unlikely race.  The stack trace shows how badly
the path was excercised, see inet_release() calls tcp_close(),
not sock_map_close() yet, but finally reaching sock_map_destroy().

3) could be lightweight but risk an unbounded loop in case the
psock could hit WARN_ON_ONCE() below, so 2) seems preferable.

Let's add the locking dance in sock_map_psock_get_checked() and
use it in sock_map_{unhash,close,destroy}().

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
 net/core/sock_map.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b0e96337a269..54bd5e3378c7 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -200,15 +200,25 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 
 	rcu_read_lock();
 	psock = sk_psock(sk);
-	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
-			psock = ERR_PTR(-EBUSY);
+
+	if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
+		if (likely(!psock))
 			goto out;
-		}
 
-		if (!refcount_inc_not_zero(&psock->refcnt))
-			psock = ERR_PTR(-EBUSY);
+		/* sock_map_init_proto() has not finished yet. */
+		psock = ERR_PTR(-EBUSY);
+		goto out;
 	}
+
+	if (likely(psock && refcount_inc_not_zero(&psock->refcnt)))
+		goto out;
+
+	/* sk_psock() being NULL or psock->refcnt being 0 does not
+	 * guarantee that sk_psock_restore_proto() has finished.
+	 */
+	read_lock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
+	psock = ERR_PTR(-EBUSY);
 out:
 	rcu_read_unlock();
 	return psock;
@@ -1631,14 +1641,15 @@ void sock_map_unhash(struct sock *sk)
 	struct sk_psock *psock;
 
 	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (unlikely(!psock)) {
+	psock = sock_map_psock_get_checked(sk);
+	if (IS_ERR_OR_NULL(psock)) {
 		rcu_read_unlock();
 		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
 	} else {
 		saved_unhash = psock->saved_unhash;
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
+		sk_psock_put(sk, psock);
 	}
 	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
 		return;
@@ -1653,8 +1664,8 @@ void sock_map_destroy(struct sock *sk)
 	struct sk_psock *psock;
 
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
-	if (unlikely(!psock)) {
+	psock = sock_map_psock_get_checked(sk);
+	if (IS_ERR_OR_NULL(psock)) {
 		rcu_read_unlock();
 		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
 	} else {
@@ -1678,13 +1689,10 @@ void sock_map_close(struct sock *sk, long timeout)
 
 	lock_sock(sk);
 	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (likely(psock)) {
+	psock = sock_map_psock_get_checked(sk);
+	if (!IS_ERR_OR_NULL(psock)) {
 		saved_close = psock->saved_close;
 		sock_map_remove_links(sk, psock);
-		psock = sk_psock_get(sk);
-		if (unlikely(!psock))
-			goto no_psock;
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
@@ -1692,7 +1700,6 @@ void sock_map_close(struct sock *sk, long timeout)
 		sk_psock_put(sk, psock);
 	} else {
 		saved_close = READ_ONCE(sk->sk_prot)->close;
-no_psock:
 		rcu_read_unlock();
 		release_sock(sk);
 	}
-- 
2.53.0.1213.gd9a14994de-goog

