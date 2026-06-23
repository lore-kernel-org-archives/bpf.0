Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E03438BA;
	Tue, 23 Jun 2026 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240407; cv=none; b=tW0wGZ/OfasknzKlZ2GF1+3xopGXN+m9oiR0GNxSMIUzH248iL2A3hkI0XYZk9YUQ+sAx5IHGeu75vKY4dp0MWxwEN+ZTNNuKwXxOHW3TUrtQ36LevLfyYhTJ3mruesLCnP+eky52RXzSHRljbObsjQHUUObEajK8MzLmr5INh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240407; c=relaxed/simple;
	bh=Ugv8Xcg+Bdw9caH96novsq2SDDNdO66plvCRhVsE79o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPFhceEBoSd42oJr10L3eXWqJENOA6qUx0UoYTQ3Ef8cZ8QB4Erl32cD67aDEHBLQxCkR+H3yDl3GMN/p2aRyHdqHuCzarUepg1EDV4i2Ks55FJovvbZTpUaLZXbpNhjsnwS+1cq3HGBH//fpqtLvvr3RCXPJTm3GU3WUnmPYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=oqKStg6n; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="oqKStg6n"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wc5Td-001WVA-Bv; Tue, 23 Jun 2026 20:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=apboAO3qKM56/EFEUq4EWGvShNo26Ky6LQz3ESgxAzE=; b=oqKStg6nbAh/CgngXdAr8vH4QI
	hi0/UVEphW25NQvMOulCOJlhUZmxPWLTc+yu9Zm654O+kR5CXTgohE9C3CELWezxrUhHi8ISjT5L+
	A/rQXIe7rvQhaScEZnH5/+ptNpqdSGOQk8l1oGVtxtM9j98lqKPICzou9kLA6zNh9KZ6Ys64gldr/
	xz/CUlr9fW3jtiIO0msfWBjmbIsARf1Ltz/9nmyKMVeMNsebu2q5H88ORIcieVR6gEDDq6g5mxawT
	ebMWE22/C6XkcxWWJ9632xJbzrUT1ciohCWnLTsRsu4WujWUapJV+8KTxdWOk0NjHV1JpGMADGJgQ
	N0MWmpcw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wc5TX-0006Rv-9r; Tue, 23 Jun 2026 20:03:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wc5TP-00GZY0-VB;
	Tue, 23 Jun 2026 20:03:48 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 23 Jun 2026 20:03:09 +0200
Subject: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on
 lookup-bind-release
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
In-Reply-To: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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

Maintain balanced refcounts across sk lookup/release: (re-)set
SOCK_RCU_FREE on proto update to treat the socket (whether bound or
unbound) as not requiring a refcount increment on (a RCU protected) lookup.

Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Note: this issue is related to commit 67312adc96b5 ("bpf: reject unhashed
sockets in bpf_sk_assign").
---
 net/ipv4/udp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index ad57c4c9eaab..970327b59582 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	if (sk->sk_family == AF_INET6)
 		udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
 
+	/* Treat all sockets as non-refcounted, regardless of binding state. */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	sock_replace_proto(sk, &udp_bpf_prots[family]);
 	return 0;
 }

-- 
2.54.0

