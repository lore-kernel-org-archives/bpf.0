Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467535E1A5;
	Sun,  4 Oct 2026 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791089075; cv=none; b=Oj20Hkq+mO1+f2anWb40zI5UeAKFT1EWmj+JxGa+Uc6irOsaYIY1bfUSclLpIcMTY/fwBBLe5VzI0/INGkQB9gIyU/QZzcpdPLExyXwAu8dhHD59CK526YrrlrrMIpGqta4jIie0OpipzwRHSItZZFi5tiqsfQcWhbwrmwmXYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791089075; c=relaxed/simple;
	bh=yB+Gsd7Dl7Ne+LVo07wkRc5lbxAzREHOV8fv6KSJ7cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAip7BCqfSM9iqKy2SDLdnEIuiomwB8N5f5dZSYVz6TlQAdQWvg9K5RXBLTGAQt0IYZlqOkPA9Ox/qXz7g6IUeu2rH50dpEFItjyvBJINM8b50dwwCo4MVIw1C23YX3+Z/V9taXjF1tCTbms0MgYqBD/7rHK4kdW6nryme2kyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td4HJI/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td4HJI/m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF99EC2BCC7;
	Sun,  4 Oct 2026 04:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791089074;
	bh=yB+Gsd7Dl7Ne+LVo07wkRc5lbxAzREHOV8fv6KSJ7cY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Td4HJI/m6SPwG3nqGNisMsSB2lJTwyMtVa3kWZNuOcStF6PRbcgTyRaMeWNgWciM5
	 yOuhh60AKk9qyR3WGhfl1hl/NU8AnUWcTQ0cfphuzfbwKRKbSaaTfK6LZxlKccJ3fJ
	 o6e/3DC4KZDl//Q0kEm7Z6dw0zgrx9Cj3xlDlqj4DCB0AnHIXttcq/iPlzD/MTcrms
	 ClFw9QrNPtpVYpHnab4FMboUD74jdGXjyMOTWkxWIlU94hk5RD6uTBWdO07lq00uLL
	 4vPJrVYxKIptRZqlM6m5HdelRagmZu6Dz9O/t6rSVqlsImIr+CLxwe7aY1EsDrGN9u
	 V8YSYcfpneMPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE69CA5FEF;
	Sun,  4 Oct 2026 04:44:34 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 03 Oct 2026 21:44:28 -0700
Subject: [PATCH net-next v2 1/2] tls: annotate lockless access to
 sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-tls-fix-sk-kcsan-err-v2-1-e939a2ebdd56@proton.me>
References: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me>
In-Reply-To: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791089073; l=4423;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=lD627TrCJ/WGmhVF5M6Bs3NBsQRK+GkiaQwEBpEpZF4=;
 b=S8SgYyYCQkWELc5/I/Hg3hNwn5qIsgqO48o6lCmJ9Lwz3RRMiUvELbRYXQOPMxIbKL2rAJvJk
 4irKq2FDNcvDyucKDPbuQUrqn13AwTcDLls/Dl142FJMiefleqz7CVk
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
index d1ad31986cf2..d85d0c1ff546 100644
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


