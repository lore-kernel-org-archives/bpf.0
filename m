Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B73EC827;
	Fri,  2 Oct 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926171; cv=none; b=HC2HBj2riHqIwdy/3gsEpvCZCAMyPmwO1FpTBCRzHz9Zt6XCCN4+VSP/5oobcW6xi9H3fovOsiS8PwtehPmR5qwAoUzRPSPrqKve4UCeZi1Yr7c97nFPvWpRQ/EQdZSiEm300KSDf3UlqpHKotyjbmSvU1h1UTIfIma+IyujEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926171; c=relaxed/simple;
	bh=6Y3dlpFGa461QBaBxmaBncwIGSGhXZ3gZSfbmo+fsvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O58l/PDFzxjo5Px3oXqlosgBvcYkigCOtoHA4ltwFfFLy+LoNncG36ICI3qC4P5q2jEuxPd+CVzBTda/oHmtVYPKk/ESORgqIVwt9saQZkxAOQyRzSwejeb/9tBlTUS3PZmRgBiddp0vO7bbWeSN0OuKUDq18geRZ8DYv5aHmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRuhBR1h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRuhBR1h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2B5AC4AF0B;
	Fri,  2 Oct 2026 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790926171;
	bh=6Y3dlpFGa461QBaBxmaBncwIGSGhXZ3gZSfbmo+fsvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CRuhBR1hbGkunuEDqELLqiAxF0K0bi2d18ECxlzqxaCEEx/Z9EBQjOSmkUDVKOao9
	 8yd6JWsvuOGUuXilcUb/aOpjibm9gpWbwKclmlyLfXMssqsbHTRPZ4PEvMH6wFGLgj
	 rB5Sr5va/iq2j4opfgQZ/G+IpyVKBPcl80rHhk0KJgyNCs9xhtVBj3mAYzykoU/E+5
	 0wVTlM4Viy7PU61+zR6Prs9lfzwl+PGnKfTrrk6mHS5ixQGgyYXrVKOOHXThVU+ygz
	 gdvYkTeh2Y6dPwPb1+juYnPhW6uhqJy3WCjDOEUg0EQzDUkc7OrZ1LRI9xO87mgxOA
	 iTQCpEi9uCV8Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FC2CA5FC4;
	Fri,  2 Oct 2026 07:29:30 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 02 Oct 2026 00:29:26 -0700
Subject: [PATCH net-next 1/2] tls: annotate lockless access to sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-tls-fix-sk-kcsan-err-v1-1-baa0ba056323@proton.me>
References: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790926169; l=3578;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=LMfz0Ko/WUbg2rvhAtu5WXHXJFwXRIoUgNbSBodEF28=;
 b=sR7rZhv2KIpRIkKdxusU5igOqsj6jtbIKe7tzDdlJKxzdHnlM3VLvQXc99fcwOJUhmrEGPUsn
 OzMS+LWWn2ZCKUAg7NUEHDG8hrrYQc2+SZ3qbUcmDwSvjdic92oO+de
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

tls_sw_sendmsg_locked(), tls_push_data() and bpf_exec_tx_verdict()
read sk_err twice. Fold those unmarked loads into one READ_ONCE()
and use that value as the returned errno. The field is still not
consumed there.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/tls/tls_device.c |  5 +++--
 net/tls/tls_sw.c     | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 17 deletions(-)

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
index d1ad31986cf2..12e4458b44bb 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -704,10 +704,14 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
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
@@ -800,10 +804,9 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
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
@@ -1107,10 +1110,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
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
@@ -1132,10 +1141,16 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
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


