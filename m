Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60D1C862F;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121498; cv=none; b=YqWF7TmhcpDml84edOVchqMxgsQK941FSiHHUcnTFmdFuCvm3fAR2J5HSR13shLQ3Mas3gq/ZyjiwglCS9kt1OrQ7RrUfr1+K8mJYLPK7MrS8Rm7h+hRI2jaFmsqCoERxld9OJuQqnkNitxfXdJHtjQSEA+ShdiPxFCH+UFiwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121498; c=relaxed/simple;
	bh=pyYP8eRKcqc6MR7CacisEJHZMgzNhkzMKipV7yz/sLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgS8diDcVWUgevNqj5hHHLzKj2cYZscBdAIYiBdArJmmgA7kzvoejPQKLMgNXSHfDKLkGpHdptw8nsOdiF97cdDuPguBnir238WXwV0KHFB8kHRIT7kocqubycLU5ePKXd/SfZ+nG7g3rBovygmt5FKQkWF+bI7tiQR+an0UaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uffQ9TGE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uffQ9TGE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 808E3C2BCFC;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792121498;
	bh=pyYP8eRKcqc6MR7CacisEJHZMgzNhkzMKipV7yz/sLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uffQ9TGEv8+D+OP/cLQ/FoZx+N0FB1mFhEH7eEbtVg93QUii9MyPs8i/nBdhrzmKB
	 /kGDoOWiK7+CIDKkGyI/SHD12KtGoPnUq7M7o3gJjz9XtBLXoTtQYcaF17pgwLduKJ
	 psBOiLZkWjhoWWQQgx3e3C4Rug3pCLvHpmPkX6EuEWgwZGUOmKFN65Hl/mkcVQO0ST
	 pJrimE2q1/+NrOS9uap5UcIyD/PBdQKzVbxne0MgCWxHJoLI7pYvMgnY1E4+YByFEq
	 H6i+Ot9ypj8iNm2B7aqdjn0HniiRr5JxlZ48NMaPT9F1x5gW2BFa0Yqdu4Pc1mTH5t
	 M/Ys7GOYZfYQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA1CC6B2D;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Thu, 15 Oct 2026 20:31:36 -0700
Subject: [PATCH net-next v4 1/2] tls: annotate lockless access to
 sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me>
References: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
In-Reply-To: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121497; l=4856;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=qsAZ1lb5W77oZPuW+SqhhfTHLgTbE4/dTQR+REZ5G/k=;
 b=8gBx0n845uLLD+CtHt23Ru9ccYsUClpxIIVEFQ/lOl1e1vqDnTxsVjn35UiaBwSs8itgSy0FV
 z8hI0EGA0dvCxy0y/7hzCbijnNdSUQiXF03rWM2RwjQvLdemq0D2xLm
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
 net/tls/tls_sw.c     | 51 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 36 insertions(+), 20 deletions(-)

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
index 312e51270f29..4221b2ad3c1d 100644
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
@@ -701,13 +704,17 @@ static int tls_push_record(struct sock *sk, int flags,
 static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 			       u8 record_type, ssize_t *copied, int flags)
 {
+	int skerr;
 	int err;
 
 	err = tls_push_record(sk, flags, record_type);
-	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
-		*copied -= sk_msg_free(sk, msg);
-		tls_free_open_rec(sk);
-		err = -sk->sk_err;
+	if (err && err != -EINPROGRESS) {
+		skerr = READ_ONCE(sk->sk_err);
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
@@ -1098,6 +1104,7 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int ret = 0;
+	int skerr;
 	long timeo;
 
 	/* a rekey is pending, let userspace deal with it */
@@ -1107,10 +1114,14 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 	timeo = sock_rcvtimeo(sk, nonblock);
 
 	while (!tls_strp_msg_ready(ctx)) {
-		if (sk->sk_err) {
-			if (has_copied)
-				return -READ_ONCE(sk->sk_err);
-			return sock_error(sk);
+		if (has_copied) {
+			skerr = READ_ONCE(sk->sk_err);
+			if (skerr)
+				return -skerr;
+		} else {
+			skerr = sock_error(sk);
+			if (skerr)
+				return skerr;
 		}
 
 		if (ret < 0)
@@ -1132,10 +1143,14 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 		 * sk_err here so a connection abort surfaces as the
 		 * actual error rather than a clean EOF.
 		 */
-		if (sk->sk_err) {
-			if (has_copied)
-				return -READ_ONCE(sk->sk_err);
-			return sock_error(sk);
+		if (has_copied) {
+			skerr = READ_ONCE(sk->sk_err);
+			if (skerr)
+				return -skerr;
+		} else {
+			skerr = sock_error(sk);
+			if (skerr)
+				return skerr;
 		}
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			return 0;

-- 
2.55.0


