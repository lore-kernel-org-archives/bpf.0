Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8D414DF4;
	Thu, 23 Jul 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806468; cv=none; b=s3MBcjMmoTJCZ6pPYJo4qG7zZRHUmpaOVCDWQyIZTy9RHwgfgL4dh7XxxixMj+BaBGAnPHoFKTtA66Wy6Z8a9gY4xyTFo3E3a/gFCdHuQ0bUxhhxJk5g7cq+7vKnVJxTSYJNkzMQhHHe6CSIEohZCViHlhyt4+wRmzJU/tolX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806468; c=relaxed/simple;
	bh=q7QSfn1svjV8bV+r7rX2GLXnLuIKfpcbws3UTxfhGJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HAHsA5MlJsYp7ccIgAMUUjaYJvYryRDB35wguq5DHqGLexfQSXVMd5cYf+bUD8PnbIb2so2Q8FmC9v4QQPMjUyQqNTQQ/oGSfBKTF9KQ5KNXkdPUVzjiMGsXWuDYUcRgmSsvyU+HMAdsYx3T1A0OmCEbT78C0xN6ggLwtNij9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=CHshuNTO; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="CHshuNTO"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgo-005wbg-Kp; Thu, 23 Jul 2026 13:34:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=0AmmlvjGNy5/K7p6ltIV59Lu4V7iggZi3FkOoYEgKGs=
	; b=CHshuNTOepdGegak0gbwODiE8/lF5Qho3TsLK2sa9RvBcOxcXJ3SjdVU6fD1gHU9hVLDVN3Q1
	5G7MkLfBvxo2Uby2uWdz+LguMjThir5edfnD/6rUTroimmFgV1QbPAVZBq5S1CskhCGcAm6i+ARhn
	vW9K+nxYP1sQLtUIv3G69F8izahpf4b/lHx34cKEK/NeAv1UHWmIFSbzob9dqpSMFFOa7X3C01E8d
	k9wcGlvEoETZCwKL55tu5bYZbWPa1OTAYDqz6L+AiBtOPT7urCOT6Yppi00DsXh679cJrMfyja8UA
	2LKxMRISspIjo7ihlkYFQcW5xOxUc9fgygdceg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wmrgm-00079x-NC; Thu, 23 Jul 2026 13:34:08 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wmrgU-0060aI-2G;
	Thu, 23 Jul 2026 13:33:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/3] bpf: Fix socket leaks around
 connect(AF_UNSPEC)+listen()
Date: Thu, 23 Jul 2026 13:33:26 +0200
Message-Id: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UDtcAx/RXxIs0xjdS3NNoSxf
 7fq2z0XztnApKgYnJsNiqxqmqYKx0MDfKfpJqhDZfDOd67zPVri+KKMz5TiknHmOoUihoECteL
 6lk9Q7Vxk1PevfIGQR7j+T1vCQ3j+NmHfP+LKBI+AAAAA
X-Change-ID: 20260628-sockmap-lookup-tcp-leak-bdaba3e083c5
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Joe Stringer <joe@wand.net.nz>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

This is a follow-up to Sashiko's report[1].

Several BPF socket helpers acquire a socket reference only when
sk_is_refcounted() == true, and release it, independently, by
re-evaluating sk_is_refcounted() again at the time the release runs. TCP
connect(AF_UNSPEC)+listen() sets SOCK_RCU_FREE on an established socket.
If that happens while a reference is outstanding, the release side sees
sk_is_refcounted() == false and skips the put; the socket is leaked.

unreferenced object 0xffff88811617ce00 (size 3200):
  comm "softirq", pid 0, jiffies 4294848512
  hex dump (first 32 bytes):
    7f 00 00 01 7f 00 00 01 4d 43 02 f6 00 00 00 00  ........MC......
    02 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
  backtrace (crc fb5bd4c8):
    kmem_cache_alloc_noprof+0x53e/0x640
    sk_prot_alloc+0x69/0x240
    sk_clone+0x79/0x1230
    inet_csk_clone_lock+0x30/0x760
    tcp_create_openreq_child+0x34/0x2750
    tcp_v4_syn_recv_sock+0x12e/0x1080
    tcp_check_req+0x447/0x2310
    tcp_v4_rcv+0x1026/0x3c90
    ip_protocol_deliver_rcu+0x93/0x340
    ip_local_deliver_finish+0x356/0x5c0
    ip_local_deliver+0x184/0x4a0
    ip_rcv+0x4f4/0x5b0
    __netif_receive_skb_one_core+0x153/0x1b0
    process_backlog+0x28d/0x1190
    __napi_poll+0xab/0x520
    net_rx_action+0x3f0/0xca0

The approach taken is to make acquire and release unconditional and
symmetric.

Note: TC bpf_sk_assign() has the same issue; it takes a reference only when
sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
destructor it installs) re-checks sk_is_refcounted() independently at
release time. The same connect(AF_UNSPEC)+listen() transition leaks the
socket here too. I'd welcome suggestions on the right way to handle this.

[1]: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (3):
      bpf, sockmap: Use sock_hold() instead of refcount_inc_not_zero() in lookup
      bpf: Extract shared reqsk-to-listener upgrade
      bpf: Unconditionally take socket references in lookup helpers

 net/core/filter.c   | 80 ++++++++++++++++++++++++++---------------------------
 net/core/sock_map.c | 12 +++-----
 2 files changed, 44 insertions(+), 48 deletions(-)
---
base-commit: 94515f3a7d4256a5062176b7d6ed0471938cd51a
change-id: 20260628-sockmap-lookup-tcp-leak-bdaba3e083c5

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

