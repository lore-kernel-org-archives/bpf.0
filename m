Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257399;
	b=rqTYbX65gt2LHPJp5S9idZdOE16l3CT185ncMJs4tiwvHAs4cNvlNj8PSXhjvNLC2IRx
	 yk4nPbyh3vHpY7RxAOEceONGHbT/3b8BNFr0+ZuY7qqMl5qNuU6WOBPAAzkOLkS76wCqj
	 QPMsLA17/5UpU4TkbwBY7zf6aor9aB9tePwqlY5KpLyU40WKvBQ9IdlcFBtVsvx/SM+Ae
	 Bw7D6cCb7oht/ge0TmyxHLdmR9nK104AzAXciKM2MqES2hHst8l2aXkTNkfiAdvqTwZM+
	 tZEkeJG/ObN28nujDvaWcLL8HlzG5+jtksp0KOSrfsWsI6mnQPsLWQgXW7C40Rm6Law==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257399;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zlgphkCqUOZkfZTPFhVitOlLwkz+8/Rg7msqF4mZoQ4=;
	b=PXjRxOzT0OTIilSM/sf91rmw/kilhqHUVPzRQuVFhFE70owxVjXnf3ckJxPdqxBaO6a4
	 LImQSfVGkRSrDOpKjbl3m8q/nfj5BWHtEHnKZwyMhCyPFaXKvmwzqmcLdk2MLoQFkrlEr
	 X5y3OQLXgwYhrnn+k1+ojQEgHkKFMMx3Bvg8wySd6jGH03A3Bza4JQmttPwvg/wL45KK0
	 53yZ43Uxv26Dhi+v0sBQXToqH1SrKaAI1olZbfrwdaZtWQCAFYKBXx4R4JraknVW4AlqU
	 so0yXE6Aye0aauOB/0qgJ7Ob/5zeoUqrhqo7zqUH7T8P+mRO8Y+R6AhXFXOjlKubtqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r+xZIPVZ;
	arc=none smtp.remote-ip=91.218.175.31
Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA366606A325
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA366606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r+xZIPVZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HgIwESM6dA8y7hBlduhrBhg1MrV+gTYGCx00jHwO1zM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257396; v=1; x=1795862196;
 b=r+xZIPVZntMgruveRXrMHRx6VL3mJk16+8co4hPmOfW29AyOICxLNgTKFYf91JebG0N6Rj0g
 nbqxni+y6C8J/oEMWLaZGfJVsqOB9uBhzGodgqRGObbAAvIK81G829aHUscE18gOQ7tdpqfpySt
 Sm9yqFsP0uBbRsYEKgg4Qm48=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1a40ebd3524503a;
	Sat, 21 Nov 2026 10:36:36 +0000
X-Mizu-Trace-ID: f1a40ebd3524503a
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	Michal Luczaj <mhal@rbox.co>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 09/11] bpf, sockmap: Fix apply_bytes when a redirect sends only a part
Date: Sat, 21 Nov 2026 18:30:10 +0800
Message-ID: <20261121103222.88209-10-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An sk_msg prog can parse the header of an application message and call
bpf_msg_apply_bytes() with the message length. The verdict then covers
the whole message, and the prog runs again at the next header:

  +-----+-----------+-----+-------+-----+------
  | hdr |   body    | hdr | body  | hdr | ...
  +-----+-----------+-----+-------+-----+------
  ^                 ^             ^
  prog: apply(len1) prog: apply(len2)
                                  prog: apply(len3)

For SK_REDIRECT, tcp_bpf_send_verdict() takes tosend bytes off
apply_bytes before the redirect. But the redirect can send only a part:
the ingress target can't get more memory, or the egress target has no
send buffer left. The rest stays in msg, or goes back to the user who
sends it again. The verdict has already used up these bytes, so the prog
runs on the rest, in the middle of a message:

  +-----+-----------+-----+-------+------
  | hdr |   body    | hdr | body  | ...
  +-----+-----------+-----+-------+------
  |<- apply(len1) ->|
  |<-- sent -->|
               ^
               prog runs here and takes body as a header

From then on the message boundaries are wrong.

Give back the bytes that were not sent, and keep the verdict while
apply_bytes is not 0. The bytes of a cork that fails are freed and
reported as sent, so they stay used.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv4/tcp_bpf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index da9caccfede79..25f222b569ec8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -449,7 +449,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 {
 	bool cork = false, enospc = sk_msg_full(msg), redir_ingress;
 	struct sock *sk_redir;
-	u32 tosend, origsize, sent, delta = 0;
+	u32 tosend, origsize, sent, apply, delta = 0;
 	u32 eval;
 	int ret;
 
@@ -518,6 +518,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		redir_ingress = psock->redir_ingress;
 		sk_redir = psock->sk_redir;
 		sock_hold(sk_redir);
+		apply = psock->apply_bytes;
 		sk_msg_apply_bytes(psock, tosend);
 		if (!psock->apply_bytes) {
 			/* Clean up before releasing the sock lock. */
@@ -540,10 +541,6 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 					    msg, tosend, flags);
 		sent = origsize - msg->sg.size;
 
-		if (eval == __SK_REDIRECT)
-			sock_put(sk_redir);
-		sock_put(sk_redir);
-
 		lock_sock(sk);
 		sk_mem_uncharge(sk, sent);
 		if (unlikely(ret < 0)) {
@@ -566,6 +563,21 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			msg = NULL;
 			ret = 0;
 		}
+		/*
+		 * Bytes that were not sent and come back, in msg or in the
+		 * next sendmsg(), are still covered by the verdict.
+		 */
+		if (apply && sent < tosend && !cork) {
+			psock->apply_bytes += tosend - sent;
+			if (eval == __SK_REDIRECT) {
+				psock->eval = eval;
+				psock->sk_redir = sk_redir;
+				eval = __SK_NONE;
+			}
+		}
+		if (eval == __SK_REDIRECT)
+			sock_put(sk_redir);
+		sock_put(sk_redir);
 		break;
 	case __SK_DROP:
 	default:
-- 
2.43.0

