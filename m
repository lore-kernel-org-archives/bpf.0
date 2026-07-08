Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887E2E92B3;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529718; cv=none; b=snkXPOJ1Of/ZQi1tv4HvANMYsm15qOU2g0/duUrQxmuHBrBcj2DSxhkVFFzWci/HSxKIdGrSCBwDxx7utAEZSxv8NRUfmLZR/clA7aMMvaTYpwyfvCJiKCVrPyoaQxT95CqJfiqMV6EqKUVHN1Dl58JI3jKV9X5VBdCARmg1d8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529718; c=relaxed/simple;
	bh=wDBgJVh7byKKDcG5YAF3zMsgf+iKvGqcZgLHwa3tySc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/PhpcIN0Tc8yUIflHHmBH6HT2nzM2Vt2aAMBN2fhcjK4W11z63cdf8197cRxK8IRMUt0tUKjtpJd5UYmqV5I53yUJyLX0v3Rp/qiemuQhB5ps0gpCmD7YXVjemfE3F8+u2BnHnfYDB/BNwFUGz9fD1ddDQSyWIPnivltS3pLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcEb3Vep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcEb3Vep"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81E08C2BCC7;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783529718;
	bh=wDBgJVh7byKKDcG5YAF3zMsgf+iKvGqcZgLHwa3tySc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kcEb3VepqAgP8rSwfMtP7hIg3QfaNjD1IW55TW8ur/yxtnzS7ZBcRNpZgZUk3bOrp
	 0Ka50C8W7XisjrZ+L9ORWHm+RXJqOUtRjKvnsy3MA5nEkX8BHV4YHMADLBEJlBMJtX
	 UxcZGPh7yV6moA6K97yTX+hi6fkJcdcDiDyMkvYePXFCZ3Aj6VXuRtl/TLYti6V2ZC
	 g8kqbhNl7KuTTYJwS4dM22NUxHokBnr2+zx1yjgSeucYtvK1Z88ijJkv+4Rdad2fuc
	 UPz2cnq9xrmxHJeN/a64wQsPf/Kuf2/rIFi2sYe8lz7nFw7/1/IfE1T2oKAzUL6Rzt
	 TO8tiCKJUnQag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638AAC44501;
	Wed,  8 Jul 2026 16:55:18 +0000 (UTC)
From: Mattia Meleleo via B4 Relay <devnull+mattia.meleleo.coralogix.com@kernel.org>
Date: Wed, 08 Jul 2026 18:55:00 +0200
Subject: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
In-Reply-To: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Mattia Meleleo <mattia.meleleo@coralogix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783529717; l=2719;
 i=mattia.meleleo@coralogix.com; s=20260707; h=from:subject:message-id;
 bh=D4N+tSAjoH5dTFG44WBAT8vqPF24z62Ilx+djNcKEFU=;
 b=kdQxIpc9JOu5p2KR8zM9Pg2YJWob7Jy1sjFSFyqmquvJCv+4EPgmvQPkP2n6yV9RP9v06wYUe
 2K66uyApw0mDoBFkuawFBayq6fDJIOfMZdFTKvgftik9hhcu8Ltb0AY
X-Developer-Key: i=mattia.meleleo@coralogix.com; a=ed25519;
 pk=cs1zLoe3YDm4bJ7bfbPaZH0lHnd871JyJLiSh2eEzLs=
X-Endpoint-Received: by B4 Relay for mattia.meleleo@coralogix.com/20260707
 with auth_id=857
X-Original-From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Reply-To: mattia.meleleo@coralogix.com

From: Mattia Meleleo <mattia.meleleo@coralogix.com>

tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
counts bytes in ingress_msg. Without a stream/skb verdict program
nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
returns 0 even though read() returns data.

Add tcp_inq() to the reported value when the psock has no verdict
program. The two queues are disjoint, so bytes redirected into
ingress_msg from other sockets stay correctly accounted through
msg_tot_len.

Remove unused sk_psock_msg_inq().

Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
---
 include/linux/skmsg.h | 14 --------------
 net/ipv4/tcp_bpf.c    | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index a8553401b..d5e35f247 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -551,20 +551,6 @@ static inline void psock_progs_drop(struct sk_psock_progs *progs)
 	psock_set_prog(&progs->skb_verdict, NULL);
 }
 
-/* for tcp only, sk is locked */
-static inline ssize_t sk_psock_msg_inq(struct sock *sk)
-{
-	struct sk_psock *psock;
-	ssize_t inq = 0;
-
-	psock = sk_psock_get(sk);
-	if (likely(psock)) {
-		inq = sk_psock_get_msg_len_nolock(psock);
-		sk_psock_put(sk, psock);
-	}
-	return inq;
-}
-
 /* for udp only, sk is not locked */
 static inline ssize_t sk_msg_first_len(struct sock *sk)
 {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f3..8e905b50d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 {
+	struct sk_psock *psock;
 	bool slow;
 
 	if (cmd != SIOCINQ)
@@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 		return -EINVAL;
 
 	slow = lock_sock_fast(sk);
-	*karg = sk_psock_msg_inq(sk);
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock)) {
+		unlock_sock_fast(sk, slow);
+		return tcp_ioctl(sk, cmd, karg);
+	}
+	*karg = sk_psock_get_msg_len_nolock(psock);
+	/* Without a verdict program, ingress data is never diverted to
+	 * ingress_msg: it stays in sk_receive_queue and is read through
+	 * the fallback to tcp_recvmsg(), so account for it like
+	 * tcp_ioctl() does.
+	 */
+	if (!READ_ONCE(psock->progs.stream_verdict) &&
+	    !READ_ONCE(psock->progs.skb_verdict))
+		*karg += tcp_inq(sk);
+	sk_psock_put(sk, psock);
 	unlock_sock_fast(sk, slow);
 
 	return 0;

-- 
Git-155)


