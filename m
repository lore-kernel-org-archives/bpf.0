Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBC377003;
	Tue,  7 Jul 2026 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398309; cv=none; b=Cqn8KT961s2mf39ZebTkjm2GhScpCpS0Km6JLUQa3vqnXER4zlyPSHRSQSxSn7OS8cmzb8DRySxqOb6rM4Ga4HVFW+3NvSfWBzqeGvCK9AXYmwJYfG3pi0Yq3sbPjccoMMY1KOYaHku3Qow2iSstVUbiRBM5vSQzBulUD3QwPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398309; c=relaxed/simple;
	bh=H/UTfwPtFkHMTQ+Y0z5FIKqj8fGTlva082mWwsonMKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfYRF3exyth3ZcmLdtr0dNl/xqBBTM2ThQ8tO1vSOHZnKJnmEmdIzlqice6HX+B5NCAS1++FH7cDpGhEeppEdKG+xqlz7KPSlRrTikFvt8dbURmiAqOCOUyMnTZ3YVKz/iE8nVEKoJ30Yn5k5vw+pBmsLo0IbBmqIaIaEodaNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=P/4EO+pV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="P/4EO+pV"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMa-00DUhV-JC; Tue, 07 Jul 2026 06:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=k6pzvF+9DJvGdfAv04/qwnJKLXYRbZ1AtZu3Wi0AOZc=; b=P/4EO+pVinHlSYryX09glbxyoD
	sm+yBVSaeaVtmRUHatQ1MrARbi4bJsqc6NgpI8hTVPNpJyKxqfKKa4osnL0QWxHrpIlJS5aov959P
	9NSORf7UKCuuwapNAWk/iCt+pkWPWD+/3Floy8eWghq5Brqa2rjVQSv5WsSD2JRgdd4yMon1BHJKw
	EGsqs9OFY92aYGVQKd3wSS2ZyKW7hirBKp6mlsHHwY+cJ1rGaYUKZkb0g0/R7bWg5s4kCMpFzL+lc
	el63uMGk9SuCegRAi+3KNKAJGjRuMulMjvNG7xtRg2F+q3eMTl9qvaQ8O2yZQ3xV/v3xRvb9MwRTb
	DAKrSHBA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wgxMZ-0004lD-5a; Tue, 07 Jul 2026 06:24:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wgxMQ-00Ctdi-Vd;
	Tue, 07 Jul 2026 06:24:43 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 07 Jul 2026 06:23:57 +0200
Subject: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
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
2.55.0

