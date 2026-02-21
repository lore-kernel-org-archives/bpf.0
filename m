Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63D2F2910
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716769; cv=none; b=STDN1GOqYBWN1P4ObAWX8gaZJ3eQwZSJq8hUvmzLr4UgpzN/Eigum3TZd4QDVaETTk4cgkHOeYFNh20p4tFNU8n1R3YkQH7Yy2hCDDVcwxVYmyN7unupuDiSn3em872Sf6n2BBrdaHyXvj+OT5L/hzby4xJDO+lZ3msF3cVoR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716769; c=relaxed/simple;
	bh=ec6BohS1gLM/Q1ZqnRvT3Aomp2QwhFfnioc2Qzv+QZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqhOiB45iMQ9Ud+16v6HKeqWtX+bO8x0590vqQ5lmEXQzmKNDxH+7rJenihGklcz/B7BkJH5YuvASq1EfvfrGZ1cST3aUKQnL1h7Gs5tDqFmECLTzi84QjMZTIUUZ/Uu97Hh05tEZU+PHLE9doXXfvpoojwLLtJOevigbxXVtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=De1A5G+L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="De1A5G+L"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a944e6336eso218260245ad.0
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 15:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716767; x=1772321567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHxyL9MR5WHIlG3mnYGDsZ6mMi8UdtePTLqzlQr7uPM=;
        b=De1A5G+L889xjXqS+MxsgxWcg4RQh8Q0q0qXCYyMnZULhABEeSe85/ARBybNmQu+9q
         yy+5+fsb+DczTr74o1qHbsqHi6nAcGLfX2YV3G0/Gkh49YfdOMuQlQiROgXml9snI+H/
         Yl18hg8cdw+cuJnYfUhrvLDKSmXxhNiteI955Yr9qsfFcgbJL1LfNEYJPD2G0UAMPeqZ
         PrThF2WcGCTCGWZ8v6+lR/jXxHqkCAb9dW89LbuQFKpBCXZPjDfk1JUxRLfwGuQMXeon
         3AxJ54EFw5IYfNueSLgr1sSzufoWl8/Z8vc+j9drZhdM0iyRs301gTPVTTReSe9Qx4kX
         dfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716767; x=1772321567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHxyL9MR5WHIlG3mnYGDsZ6mMi8UdtePTLqzlQr7uPM=;
        b=k+/L5aijzu1Bka0PxE39p1r5B0WwuK6J+5KSijihHe3OO5CPMOfgGOipLfFJIU3R4V
         5L47kyXGQj4tF6scMhvjOOSTFuajJETFkI3PNYFLVpadwjcXAyQiyTPBFWENdjSgu4XP
         jWj33z8KJbGk3sX/Rm+jqhHDoL6hsmhCu+QIIOf/r90FNRq/wOnEDil8JPfxOaPBhe/P
         Rd77VM36vIAU+Wx2dvlcp3CaI2PZAHl/f1uMUhvjTyrBog+Y/ee2lTLXO82Nh1CTW6Dh
         ErSEBEPv9WaQC7QuWcdaVjfxttkaAYvkErCchzITiXgkhUEjdw2C6rV7Ox29hoWsahey
         PQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDGM7+f3aGVos9j1wqTYV74zr1GnzrVTbTkpLT1dCE4gGSiVLxZ7Y21OebFqERZkVE5xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyra53FgodIRiEKnAtFryfD8bFmNfT0Cmy6NumSF0ddBKiW9kDd
	GcHjlbHFiF3brux9GP5Whus/np9v/GB8V0fcFJCUXGzUuyzstgT9otJ0N3Uvs5nZW8CSpsRSGpN
	E90Ppgw==
X-Received: from pjph2.prod.google.com ([2002:a17:90a:9c02:b0:351:c17:c7b9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f707:b0:295:565b:c691
 with SMTP id d9443c01a7336-2ad74444dc3mr38808295ad.17.1771716767243; Sat, 21
 Feb 2026 15:32:47 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:53 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-7-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported imbalanced sk->sk_forward_alloc [0] and
demonstrated that UDP memory accounting by SOCKMAP is broken.

The repro put a UDP sk into SOCKMAP and redirected skb to itself,
where skb->truesize was 4240.

First, udp_rmem_schedule() set sk->sk_forward_alloc to 8192
(2 * PAGE_SIZE), and skb->truesize was charged:

  sk->sk_forward_alloc = 0 + 8192 - 4240;  // => 3952

Then, udp_read_skb() dequeued the skb by skb_recv_udp(), which finally
calls udp_rmem_release() and _partially_ reclaims sk->sk_forward_alloc
because skb->truesize was larger than PAGE_SIZE:

  sk->sk_forward_alloc += 4240;  // => 8192 (PAGE_SIZE is reclaimable)
  sk->sk_forward_alloc -= 4096;  // => 4096

Later, sk_psock_skb_ingress_self() called skb_set_owner_r() to
charge the skb again, triggering an sk->sk_forward_alloc underflow:

  sk->sk_forward_alloc -= 4240   // => -144

Another problem is that UDP memory accounting is not performed
under spin_lock_bh(&sk->sk_receive_queue.lock).

skb_set_owner_r() and sock_rfree() are called locklessly and
corrupt sk->sk_forward_alloc, leading to the splat.

Let's not skip memory accounting for UDP and ensure the proper
lock is held.

Note that UDP does not need msg->sk assignment, which is for TCP.

[0]:
WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157
Code: 0f 0b 90 e9 58 fe ff ff e8 40 55 b3 f7 90 0f 0b 90 e9 8b fe ff ff e8 32 55 b3 f7 90 0f 0b 90 e9 b1 fe ff ff e8 24 55 b3 f7 90 <0f> 0b 90 e9 d7 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fc
RSP: 0018:ffffc90000147a48 EFLAGS: 00010246
RAX: ffffffff8a1121dc RBX: dffffc0000000000 RCX: ffff88801d2c3d00
RDX: 0000000000000100 RSI: 0000000000000f70 RDI: 0000000000000000
RBP: 0000000000000f70 R08: ffff888030ce1327 R09: 1ffff1100619c264
R10: dffffc0000000000 R11: ffffed100619c265 R12: ffff888030ce1080
R13: dffffc0000000000 R14: ffff888030ce130c R15: ffffffff8fa87e00
FS:  0000000000000000(0000) GS:ffff8881256f8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000700 CR3: 000000007200c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __sk_destruct+0x85/0x880 net/core/sock.c:2350
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Fix deadlock when requeued
v2: Fix build failure when CONFIG_INET=n
---
 include/net/udp.h |  9 +++++++++
 net/core/skmsg.c  | 29 +++++++++++++++++++++++++----
 net/ipv4/udp.c    |  9 +++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 700dbedcb15f..ae38a4da9388 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net *net,
 			       struct sk_buff *skb);
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport);
+
+#ifdef CONFIG_INET
+void udp_sock_rfree(struct sk_buff *skb);
+#else
+static inline void udp_sock_rfree(struct sk_buff *skb)
+{
+}
+#endif
+
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
 /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 96f43e0dbb17..dd9134a45663 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -7,6 +7,7 @@
 
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/udp.h>
 #include <net/tls.h>
 #include <trace/events/sock.h>
 
@@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len, bool take_ref)
 {
 	struct sock *sk = psock->sk;
+	bool is_udp = sk_is_udp(sk);
 	struct sk_msg *msg;
 	int err = -EAGAIN;
 
@@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	if (!msg)
 		goto out;
 
-	if (skb->sk != sk && take_ref) {
+	if (is_udp) {
+		if (unlikely(skb->destructor == udp_sock_rfree))
+			goto enqueue;
+
+		spin_lock_bh(&sk->sk_receive_queue.lock);
+	}
+
+	if (is_udp || (skb->sk != sk && take_ref)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-			goto free;
+			goto unlock;
 
 		if (!sk_rmem_schedule(sk, skb, skb->truesize))
-			goto free;
-	} else {
+			goto unlock;
+	} else if (skb->sk == sk || !take_ref) {
 		/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
 		 * data originates from the socket's own protocol stack. No need to
 		 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
@@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
+
+	if (is_udp) {
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
+
+		skb->destructor = udp_sock_rfree;
+	}
+
+enqueue:
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
 	return err;
+
+unlock:
+	if (is_udp)
+		spin_unlock_bh(&sk->sk_receive_queue.lock);
 free:
 	kfree(msg);
 	goto out;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 422c96fea249..831d26748a90 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 }
 EXPORT_SYMBOL(__skb_recv_udp);
 
+void udp_sock_rfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	sock_rfree(skb);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
-- 
2.53.0.371.g1d285c8824-goog

