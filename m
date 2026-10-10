Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279CC26ED3E;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643596; cv=none; b=unWWST3T+ZqXqgV1b0VvsbSqqHD50xM/AcJQoIYZ1UoYtVJHT82vVUunkHFCh5RmJayh0Q9TMdVhJzUk1TFEa7fV1coWvZM7LSo43RtBbwij+/A2I662R8IFGna1AOFSq3VCuP/ud158aPr9RCgQTYosWDaRlX0GEteXrmvcJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643596; c=relaxed/simple;
	bh=O9tReunjV/TkBzh0/rwM2bzREpHWpmAvIoVIbQKSr2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkjcgzhtkChJn3Qv1qYxXpg7SAzMVvqOm4+UrbQ80vyUbRACaMa7PqRf9p12iD8ESdeJstfjjktsArnCWFRoqUQZlGPWIC3RO2JADcYpBwRhvrwJvEtuBxBlGdBijYP7N9otSqjyJ9M4FmnxtRB8X7lBTb3BEMaNEVpVAe1wJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jShDoeX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jShDoeX+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1EE6C2BCB9;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791643595;
	bh=O9tReunjV/TkBzh0/rwM2bzREpHWpmAvIoVIbQKSr2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jShDoeX+4Ae0JXGD5cjFUhXpBZnpbUXOU9KdjKLbSpm95KN6+ct55yXosTdo2cFw+
	 ELGts7nP43D/Izzv9HAMtMmJJxEvLd86MqhzblPv/QBlnMWgKoaEjgImE3cmN3YH+v
	 3w4IHnvzzaVzgQpqWZyjK9tQ7V82ia6CQ9S62nx7jiijycBgIhrXSYqgR9eXE2mJIT
	 piDZKZE+C3p8atQr96qF+bVJah9vPdbMiAFywy/TWcx6sKhFvjI/I4hpfrlKZ9rw6L
	 ZxyUsBma+6i05CMTq8JsFbxBr0mXnD4HhOzMLRkG0IJZ4MZO2yXJmXdUpn/VU0WOxE
	 /OEKIHlSYgf2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D44CA9EBE;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 10 Oct 2026 07:46:28 -0700
Subject: [PATCH net-next v3 1/2] tls: annotate lockless access to
 sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-tls-fix-sk-kcsan-err-v3-1-e28aadeb31ad@proton.me>
References: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
In-Reply-To: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791643590; l=4423;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=oyeMQXlYZ5OEpzoZY0Ba7hIry6yUmLmTMWGSVMly/Fw=;
 b=TMsLvdjn/QacxSqsZGsbKF1rS8ehvGN72WoxHJir1whjEPigAhCuu6YlxACj8x4Oqi7fGocpY
 0RLG+rdbfU6BxVG7YBW0U6+djPd/4r3w7Fufbao22bgzjTBh5yOXFgd
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

kTLS sits on the same struct sock as TCP. do_recvmmsg() and
getsockopt(SO_ERROR) still call sock_error() without the socket lock
and clear sk_err with xchg().

tls_rx_rec_wait() already peeks when data has been copied and consumes
otherwise, but the outer if (sk_err) is an unmarked load. On the
no-data path that check-then-sock_error() window can return 0 after
another thread consumes the error. Call sock_error() once and only
return when it is non-zero; keep READ_ONCE() on the peek path.

tls_sw_sendmsg_locked(), tls_push_data(), bpf_exec_tx_verdict() and
tls_encrypt_done() read sk_err more than once. Fold those unmarked loads
into one READ_ONCE() and use that value as the returned errno. The field is
still not consumed there.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/tls/tls_device.c |  5 +++--
 net/tls/tls_sw.c     | 54 ++++++++++++++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f11d0528fc43..03ce83a9d4e9 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -444,8 +444,9 @@ static int tls_push_data(struct sock *sk,
 	if ((flags & (MSG_MORE | MSG_EOR)) == (MSG_MORE | MSG_EOR))
 		return -EINVAL;
 
-	if (unlikely(sk->sk_err))
-		return -sk->sk_err;
+	rc = -READ_ONCE(sk->sk_err);
+	if (unlikely(rc))
+		return rc;
 
 	flags |= MSG_SENDPAGE_DECRYPTED;
 	tls_push_record_flags = flags | MSG_MORE;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 312e51270f29..a2be1283ca93 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -473,6 +473,7 @@ static void tls_encrypt_done(void *data, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct sock *sk;
+	int skerr;
 
 	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
 		return;
@@ -488,13 +489,15 @@ static void tls_encrypt_done(void *data, int err)
 	sge->offset -= prot->prepend_size;
 	sge->length += prot->prepend_size;
 
+	skerr = READ_ONCE(sk->sk_err);
+
 	/* Check if error is previously set on socket */
-	if (err || sk->sk_err) {
+	if (err || skerr) {
 		rec = NULL;
 
 		/* If err is already set on socket, return the same code */
-		if (sk->sk_err) {
-			ctx->async_wait.err = -sk->sk_err;
+		if (skerr) {
+			ctx->async_wait.err = -skerr;
 		} else {
 			ctx->async_wait.err = err;
 			tls_err_abort(sk, err);
@@ -704,10 +707,14 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	int err;
 
 	err = tls_push_record(sk, flags, record_type);
-	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
-		*copied -= sk_msg_free(sk, msg);
-		tls_free_open_rec(sk);
-		err = -sk->sk_err;
+	if (err && err != -EINPROGRESS) {
+		int skerr = READ_ONCE(sk->sk_err);
+
+		if (skerr == EBADMSG) {
+			*copied -= sk_msg_free(sk, msg);
+			tls_free_open_rec(sk);
+			err = -skerr;
+		}
 	}
 	return err;
 }
@@ -800,10 +807,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	}
 
 	while (msg_data_left(msg)) {
-		if (sk->sk_err) {
-			ret = -sk->sk_err;
+		ret = -READ_ONCE(sk->sk_err);
+		if (ret)
 			goto send_end;
-		}
 
 		if (ctx->open_rec)
 			rec = ctx->open_rec;
@@ -1107,10 +1113,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 	timeo = sock_rcvtimeo(sk, nonblock);
 
 	while (!tls_strp_msg_ready(ctx)) {
-		if (sk->sk_err) {
-			if (has_copied)
-				return -READ_ONCE(sk->sk_err);
-			return sock_error(sk);
+		if (has_copied) {
+			int err = READ_ONCE(sk->sk_err);
+
+			if (err)
+				return -err;
+		} else {
+			int err = sock_error(sk);
+
+			if (err)
+				return err;
 		}
 
 		if (ret < 0)
@@ -1132,10 +1144,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 		 * sk_err here so a connection abort surfaces as the
 		 * actual error rather than a clean EOF.
 		 */
-		if (sk->sk_err) {
-			if (has_copied)
-				return -READ_ONCE(sk->sk_err);
-			return sock_error(sk);
+		if (has_copied) {
+			int err = READ_ONCE(sk->sk_err);
+
+			if (err)
+				return -err;
+		} else {
+			int err = sock_error(sk);
+
+			if (err)
+				return err;
 		}
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;

-- 
2.55.0


