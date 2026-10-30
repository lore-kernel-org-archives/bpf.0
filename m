Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361724;
	b=G2VmRMGHl4IpNXyzetTUoKSvnW16+C00rqq02p2jxvnQWV1nXm68ewZ+VEds5nrzjSaM
	 afJqQ8qDbgJFnlT7cU/2wXzN8hrhLnCiUf0ddEZ0KCAWOjc9M7SgsMmM4CtmWKOwXbsDj
	 9M6B/zc0DmHNkDXvUZgiFGR9PK/R6U6nz7EZ3GNtQFnyHDxGQM2Rnlxx1OOqRbGXlvX72
	 8bfRTDUa1nNELyrd+n/kGCG+lu3TCKoNsN1FQQFjjZP6wsHKqs276jZJ4PjUY6hrcfOLs
	 8pBRBsQKsjNUpaQi81wJT5mKuOGTvO4CxgJFSMYMWwg6sMESXnr/TeWlDfbTqc8UWkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
	b=Tje+YZKxPfEStWx2QVWmMwduxJYpYya14P/kzsiRHmfRxCO/IyqmeXinEYBrFYZQ7AZn
	 CUhFKpetlbKU8t7XgLcWYpUf1+qXwpUKPQ7w0gKQ99AAYAh019qz79axDspK8Zb85Mea/
	 N8SAim1dSbxczk7vqgg79pQx4nbB4AbtwZ0otbE/ibBCNX/mt/0KXn2IidIIKL8pv6LM/
	 SJU3KLO+dlgip+NcpZQ1RrX7VneclDwa9/ie+W2q6b1zIJNZN7kZlrPwGDiP3vQs/oPp3
	 Zqp7/rWmv4zF7QJBKSdBr9E+ciKyR8B3rtuNMZeIvR0abC9egfWR8Gqz6tMVP+ABssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SoATSqHh;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E4606A339
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751E4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SoATSqHh
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c169ae1cb26so279782866b.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361723; x=1793966523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
        b=SoATSqHhNdt8D1MGQLHZVmM4HEw2QSRyz0+xv2QOvOIvvsrp61UemHu4d4HzeWJlmK
         gyQjAWsXG9o9fwhfY4sDB3nOhlW3WbdOk1t+EJpaySIpUpy9kwgHLe8H14lN4LpixI/z
         3BllxnxMspkwrl96oek3fSjfktCgSS24flB5i6n2vsFWZyFVuDTIgfavGE1A0UqMXrHD
         3mPFypXoFwUh+QDchVDdajrUpv/UXA2kDF3LzvCS2crZc7biw41ATJD3rFrh7adfnRKt
         sUax+NJC+M9nNIoSRl7970O9BDXdkSpgLitCa4lSSFBoDwSNtyP5mWy5mVZlPdrmNH4B
         diyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361723; x=1793966523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
        b=Z79UI7bw27TTbuQW7YvGAPl/RGyhwD0g8/UglMrCZrXgmXZpBNsGodunBQAsGIoNWX
         EE/U9Gs4GJMVT1qqQmXq37Q9pyi4mcrpJ3JRoP/+0sEtYT404yrSGonjYYC2UqtKq8IB
         f0y33ORvaJ28uLSpPrJVkkMCw+QN0HKqP4/2Sgvrr811l3+pezDPUJkSuwUg6r0zEs1M
         Ts/OI+yJ8eahTpe5G3Hbw5GW3e4Gfwh8GIX/xlgVOWu98/CsJRn5NnGtfcJXxOCyE9JC
         DplVBKhbyHDb/mBPmM12e/cMH0w+DQ0Q3E0+jJTupeJydlwSERBb++phKBGLnGZxb6zy
         XUvg==
X-Gm-Message-State: AFq9FYL19MQTQH+hkj/t8jo38oxHlEOtnFt+4GDRjGIQh9BZvVtNgMKD
	6Rsuuh2VyEyOpzDG88ttnQTwE42Ltf2n2FYjVljFjC0MeChdO3zKNainj1cKAMW9s40=
X-Gm-Gg: AYBFou3ZxuEn1un65ZOx4ztVw1LderS8VK+WWfyQ1C0+ALujDk2k5gBKgGaSf02yuk6
	64zvh+/yXhVeEORO24SGN8/gsscbJ4YqwGxzloHuPNbdldxOhI/hkJkzvjRdVxvx86A5qbuh7OW
	ShdGtrYUuO8mIUWrlOmIywbjVk0TI14jCBw2Jfhd+B8SRrnwSI6iyjCGo0MhYsrAa7RAU4u9ybS
	+UQYvL80NUzn2MAV9pL5hCCvMbiAKCs1o3Hwai/EGWPfzCLS1ZCBFhEjMwLubdmxRh6GwIqQJ2u
	KhZB36hNrt78nxUJeo9GReIfbGduUXmxrjqQDqvu7msiFtZuICm+Kga3R2zZUloOuOXF4Qv3lIt
	pSHqf2Gy8x/R6vZJZm8xpFnxUAOFQ0nymEOclNTZHquFqU+Kyodp70MO0OzrqlHc9FEar+vQK7w
	7k1UJAoOkv/NbPOGbhe/8rp8yLoYoawyNQnCF5CqTmo13NDhnZEm/eEbkyZ2EUcQf08eqzYe43b
	WIR3e6HHykkWjadJXuUGhXtoe0a7lNzXsB4yVMilCpFg8qQ8F0x77cD253EQBl/C1i7x4ciRAtN
	wFJ8Rn69bGG7oBxhw/ET8e36APKupfX5KCS5jQ==
X-Received: by 2002:a17:907:9615:b0:c21:5cd6:3e49 with SMTP id a640c23a62f3a-c4ca7a697a3mr192464266b.9.1793361722443;
        Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe1003fsm59104966b.44.2026.10.30.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 30 Oct 2026 13:01:54 +0100
Subject: [PATCH bpf-next 2/2] bpf, sockmap: Fix psock update-side data
 races on sk->sk_prot and progs
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-next-v1-2-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

The update side of the sockmap psock lifecycle has several unsynchronized
accesses to sk->sk_prot and psock prog state that KCSAN flags when the
new update-vs-delete race selftest runs. The fix comes from Alexei [1]:

* sock_map_link() installed psock programs and called sock_map_init_proto()
  before taking sk->sk_callback_lock, racing a concurrent teardown's
  tcp_bpf_update_proto() write of sk->sk_prot. Take the write_lock early,
  before psock_set_prog() and sock_map_init_proto(), and drop the
  psock->saved_data_ready gating from prog detection (it is re-checked
  under the lock before stopping progs).

* sock_map_del_link() read psock->saved_data_ready outside the lock. Move
  the saved_data_ready check under write_lock_bh(&sk->sk_callback_lock)
  so prog teardown is serialized against the proto restore.

* sock_map_psock_get_checked() and sock_map_sk_is_suitable() did plain
  sk->sk_prot reads. Convert to READ_ONCE() to mark the intentional racy
  read against the WRITE_ONCE() swap in sock_replace_proto().

With these changes the sock_map_link/psock_set_prog side of the reported
KCSAN splats is silenced; the remaining teardown-vs-core-TCP pairings
are the separate read-side annotation problem.

[1] https://lore.kernel.org/bpf/DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 057e2f3c0265..efe49551caba 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -152,11 +152,11 @@ static void sock_map_del_link(struct sock *sk,
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);
 
-			if (psock->saved_data_ready && progs->stream_parser)
+			if (progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && progs->stream_verdict)
+			if (progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && progs->skb_verdict)
+			if (progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
@@ -164,8 +164,11 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
-	if (strp_stop || verdict_stop) {
-		write_lock_bh(&sk->sk_callback_lock);
+	if (!strp_stop && !verdict_stop)
+		return;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	if (psock->saved_data_ready) {
 		if (strp_stop)
 			sk_psock_stop_strp(sk, psock);
 		if (verdict_stop)
@@ -173,8 +176,8 @@ static void sock_map_del_link(struct sock *sk,
 
 		if (psock->psock_update_sk_prot)
 			psock->psock_update_sk_prot(sk, psock, false);
-		write_unlock_bh(&sk->sk_callback_lock);
 	}
+	write_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_map_unref(struct sock *sk, void *link_raw)
@@ -202,7 +205,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -284,6 +287,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}
 
+	write_lock_bh(&sk->sk_callback_lock);
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 	if (stream_parser)
@@ -298,11 +302,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	 */
 	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0) {
+		write_unlock_bh(&sk->sk_callback_lock);
 		sk_psock_put(sk, psock);
 		goto out;
 	}
 
-	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
 		if (sk_is_tcp(sk))
 			ret = sk_psock_init_strp(sk, psock);
@@ -536,7 +540,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
-	return !!sk->sk_prot->psock_update_sk_prot;
+	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
 }
 
 static bool sock_map_sk_state_allowed(const struct sock *sk)

-- 
2.43.0

