Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CE39B4BF;
	Fri, 26 Jun 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506238; cv=none; b=aLRBT8UjBExYQqo6XguJoxr7uaN5MakRvfTjU8OLzun6T+6yNayzK1Az7Jlfqnqn1czn4qnRZASMQcVp0giGWMm11Yv4GccehhrR1Jtc7KQJSOn3Rbh8jHg/r8gFyYg+h+RwPzitr3z3V1aOror5Fk0XOrNcQdcJiv8gPiLZVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506238; c=relaxed/simple;
	bh=y3d2tRj3eLpPjwbyJgsYnyG6o2I6rzqFEpYVM6LwR/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdpKpf6Sq9ScBTLLtSLZCkoVpTI7bVUY4uGDzEePV7AoJg0DgAjhLwI4Q9BCgHD7RN3eGceCPAAhuX05CbSedo6abHhr3IyL6Xt6RG/n9ljbNQDT517z+mPOJx/4svMk2Q1qu/wak9WqdA4Taj89m1YXnSVuLY7y8HVRlpzwep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RX7Uf/Lg; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RX7Uf/Lg"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIJ-00AoOa-S3; Fri, 26 Jun 2026 22:36:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=YlCHFZHnuvGA17tuVPsSxdhDuw7YPvkItswTJ1C9Gug=; b=RX7Uf/Lgux1uTVa+8rWYi0dTOo
	YXZ3nOZV/FXAZPiz36pu0HF1QzXgzSRbipzb9mwNTYQ29gK4cg2Lu5rKRiBseC25o+yhsS2oVjN+a
	O5VKNXnsR0dRLaVxc1uofmqHZxye22Ik51LgLY1m478K9VnpYF6TbkEOm2MEh1NbTR3wzg06xDHnk
	n8eopPCSyM8AbPHftcIs/oe8ZbgGc/SdpRCTVvFyxW8udZpToCyuwDppWK2VulkktxJj1jSkGGpO4
	gJwgR3ksWqs+KQ/aSHO1mEo1aKqDSXABe1dR+Fw2Q4OOWKAmigAoHgAH6sAMIFJYHJqgFjYEVVeo4
	IXoZ4cGw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdDIH-0006SC-Dl; Fri, 26 Jun 2026 22:36:57 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdDI9-006anB-0b;
	Fri, 26 Jun 2026 22:36:49 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 26 Jun 2026 22:36:29 +0200
Subject: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
sk_is_refcounted(unbound) = true, while sk_is_refcounted(bound) = false.

Because sockmap accepts unbound UDP sockets, a BPF program can increment a
socket's refcount via lookup. If the socket is subsequently bound, the
transition from unbound to bound causes bpf_sk_release() to skip the
decrement of the refcount, causing a memory leak.

unreferenced object 0xffff88810bc2eb40 (size 1984):
  comm "test_progs", pid 2451, jiffies 4295320596
  hex dump (first 32 bytes):
    7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
    02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace (crc bdee079d):
    kmem_cache_alloc_noprof+0x557/0x660
    sk_prot_alloc+0x69/0x240
    sk_alloc+0x30/0x460
    inet_create+0x2ce/0xf80
    __sock_create+0x25b/0x5c0
    __sys_socket+0x119/0x1d0
    __x64_sys_socket+0x72/0xd0
    do_syscall_64+0xa1/0x5f0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Instead of special-casing for refcounted sockets, reject unhashed UDP
sockets during sockmap updates, as there is no benefit to supporting those.
This effectively reverts the commit under Fixes, with two exceptions:

1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
   handler for BPF sockmap usage"), the proto::unhash BPF handler is not
   reintroduced.

Historical note: this issue is related to commit 67312adc96b5 ("bpf: reject
unhashed sockets in bpf_sk_assign").

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index c60ba6d292f9..9efbd8ca7db8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 {
 	if (sk_is_tcp(sk))
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
+	if (sk_is_udp(sk))
+		return sk_hashed(sk);
 	if (sk_is_stream_unix(sk))
 		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
 	if (sk_is_vsock(sk) &&

-- 
2.54.0

