Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792971945;
	b=Yo5mDd/YtTLo92aMceRzm875fdanFe2AkWAQgLE7eJhMUJwu6wcQz13hey2sQXKzGyeQ
	 u658CUAafcTYMkT0gow0LNfkW+1Z0RvW6GBC67FZfRuHV+fDhysTIYWKD/Xh+K3oXWVrf
	 niyJupzNOQJdNA7p3ROKK2RDGWk0sw54PrXKpax4AEvn3AEk5rV2YGPhZWUux09RSVAMt
	 Rwn2x6Y8w6J6iE+yEa9O94MkQ7zyRK5DZWBb2RFdkzFK1s5OAyOW5MO1Nx89A3m/H3vYI
	 DvMXbydnULkEMEJGsYx7QM+qYGCZ4Ve0O5n9dOYyOsp1CniibpVnV2GxPU7E1hh+D4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971945;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vuNoKJQhKwFEYoYDrBeFBAdFshlRv+mGsc6F55GADDo=;
	b=GB9W2hREm5P8KjIH8q8wgLdZMoRzkA4ICa4MzqffJAfeE1pd6bhm1roYTcv7/IfDuT7Y
	 jaO+NY1M1t3+Hxx+ERMaaQx92Pcawe2U0+2qAE4a35m2v8P2FMT2zW1WBcjf/CC47znvv
	 b/ElGtXyaV3W1MtBYLUhglHQBPFE1PJy/4kvf4QNSL7cuf8F6uHZMbMzlofZiwid0kqxE
	 0VRNRfyTlAzbeDcei0W69OVoQ4xI1ey3re6A6L0qRdgmxf13y1qb/anBXHn7ZmUTm3FO+
	 5Ysgcssm3fJYr7xVmFBqX94xM+m95iaFnlZfMbFxfZXHHQ5KRntJLUBC1qdtojWyV0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi4Es+mX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201F606A31B;
	Sun, 25 Oct 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi4Es+mX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792971944;
	b=q/WK6olmnDLwftS+R3/Rr1U9Azyk4W/Y4NLB/4QaRugF8tRRLNg2DYyz+whmZCE7oUHe
	 Wo3FNQr2ho6v7GPoHx/71+Roq99LhFkl9I2WGVqazUxBxFpdZ5RGsJzCWd0miMocBEXYQ
	 Oh7G9vraNIVAYimG+scJlMLojJofxTIKnfy0v/MG4Z71lXxd+Mbi9+4Gu5BjlpjpWwiZP
	 zb6y98TfWcAWaXK2drKJx8zq9a1IvCFssmiiJAeFXbCzfGpFBLfx8G6VQfaswfjgcK+qQ
	 anmtdW35ogzOVFlbLRaFyVIPbA0uzDtchXZvj9LA2ET2hX8yE85UWaIMGheugxJNT1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792971944;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vuNoKJQhKwFEYoYDrBeFBAdFshlRv+mGsc6F55GADDo=;
	b=MyvHWyVjNaDaRH7XPJfsJqhC+eR2fJGp95HV5OLAYKrWRRmnT/hn6gZzOMFvNWO3yuTt
	 sXWcjcpmO3PVGifJAd+9eOjD4TmnSLw8DQ/pa0r6cHd2O//IvZ/PX7HL3oYi2vbucXSBi
	 YxOQw1k49cTtRz06buy2mufl3qxlS2q42uir5EyJc3aitNyDoI5O26ZEoILdA1PEseJFR
	 rVNPmaY3gKRKS4bUrVswgeb/my3OEYKj9iMewCf68BD4W59hQPNQ19dXRcn7w97QBZXTt
	 SUoGVTtBQ8nZBuYa8h3U2Q8nqJ36WCKqh26r1FFfT12J+7oy2zg3apikbi3S+M+IrsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EC9861F01828;
	Sun, 25 Oct 2026 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971944;
	bh=vuNoKJQhKwFEYoYDrBeFBAdFshlRv+mGsc6F55GADDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zi4Es+mXVJ16X1hZoscjxn+XceaYUy2vlidLzKPs864tvDVOJ8UGVPzK4xyususd/
	 ocf5WdvkN9NWArQ+K5m2x0Mqeg+v6f/bTd/NFG9HyeRbklI8flkVXIT+oxZdheQNTw
	 PtKf481uS6UWnZ9/gtT0gAbTQ4qFqAf00eHM4mzq0ZUoWC8bhh0e493vDy8ZV/eplJ
	 XmxOCFGwah7Q/ps0SZq/vwa6EzVg4xzA5WPsDFxvwBO3i7Gxf2h8ZfQqv1p3vuNobT
	 KWi/JT7Mlv3jqxwdpHFw6iC+Rc1HjkUXNLIm9x4MrKAKpIL2u8uqmagksruZTrkNWM
	 bRkRt3xVW5gpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75EF944B1F;
	Sun, 25 Oct 2026 23:45:43 +0000 (UTC)
From: Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org>
Date: Sun, 25 Oct 2026 16:41:57 -0700
Subject: [PATCH bpf 1/2] bpf, sockmap: Stop reporting EPIPE on zero-length
 skb redirect
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
In-Reply-To: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Eli Skeggs <kernel@eliskeggs.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792971941; l=2155;
 i=kernel@eliskeggs.com; s=20261021; h=from:subject:message-id;
 bh=tMsJNHGrPmApxQR/k04sdDxy9WoPcaNMSS8fSsBnQhE=;
 b=aqOQiUQEIH5hPFtqejVgawPtZtjmbWIer2omhEGNDqEVU8Wi6bSfPUeGRerJbm9UpJT86HvRe
 5QQD3b2EqgpCCK7UqRblzXI9yZLAkfs46dNpxxTr6MuytG4PjkHfCJZ
X-Developer-Key: i=kernel@eliskeggs.com; a=ed25519;
 pk=38k+FqQ3STTnr2H4HZ7IEseBOHWRDYVhvyMmQlB51gc=
X-Endpoint-Received: by B4 Relay for kernel@eliskeggs.com/20261021 with
 auth_id=1252
X-Original-From: Eli Skeggs <kernel@eliskeggs.com>
Reply-To: kernel@eliskeggs.com
Content-Transfer-Encoding: 7bit

From: Eli Skeggs <kernel@eliskeggs.com>

A FIN can arrive on a packet with no data. In that case, tcp_read_skb()
produces an empty skb, and the attached BPF stream_verdict program may
choose to redirect the skb to another socket. Further data redirected to
that socket from any socket gets dropped, and the target socket starts
reporting EPIPE. A userspace application may see that EPIPE and decide
the socket is no longer usable. For a BPF-based proxy, this can break a
bidirectional stream, truncating the response instead of leaving the
socket half-open.

Prior to the introduction of tcp_read_skb(), tcp_read_sock() never
passed a zero-length skb to its actor, sk_psock_verdict_recv(). When a
redirected skb landed in sk_psock_backlog(), it was always non-empty.
tcp_read_skb() deviated from the historical behavior by passing any
zero-length skbs to recv_actor(), exposing this latent bug by adding
zero-length skbs to a queue that hadn't previously received them.  When
sk_psock_backlog() encounters a zero-length skb, it interprets ret == 0
as a hard error, reports EPIPE, and clears the transmit flag.

Treat a return of 0 as success when there is no data to send, while
continuing to fail on a 0 return with residual bytes. The loop exits
without incident on an empty skb, and the skb gets cleaned up as usual.
On an ingress redirect, the empty message is still queued as before, but
the target socket no longer reports EPIPE.

Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
Signed-off-by: Eli Skeggs <kernel@eliskeggs.com>
---
 net/core/skmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f9b2e3486cfb 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -716,7 +716,7 @@ static void sk_psock_backlog(struct work_struct *work)
 			if (!sock_flag(psock->sk, SOCK_DEAD))
 				ret = sk_psock_handle_skb(psock, skb, off,
 							  len, ingress);
-			if (ret <= 0) {
+			if (ret < 0 || (!ret && len)) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
 					/* Restore redir info we cleared before */

-- 
2.56.0


