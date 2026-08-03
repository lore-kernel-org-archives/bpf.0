Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484E3C1091;
	Mon,  3 Aug 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747716; cv=none; b=o+2eHw2KVqAkSgM7Eq1qwE93Uc0zUCD6rMn3ucOpzmOx3svtQB8YREDisynHZ4nJUJDBeQejTsSsF9amDGQExHEV8p1dKTDuT5n4QkH/rDxJ+LmmBYvHXjW3kA2Ao5I5w7LzJxtTYkF2vwivkfR6qGDDTcuDw/0jiFs/ikGVy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747716; c=relaxed/simple;
	bh=OYQWZ1Rq3jJDct9MnaqzOWQDNdnk8i34MWsJ7KFrCYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J0q6f6lvembgau9a7piIQnsJQWS1+DCAchl6QF0HAnawFCd8NE1pCM+AH0hWEcpmGjNYWPIZcVvcPYDrFS6TCCq3qzuAE7ZLLbqm1ylF+cB9LZhiQEj355709YME2duehz7pYQfgvt34a+oXwbyYgn9qVVmHmr3hfmSYpJ/my/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=nOshWfSJ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="nOshWfSJ"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqoYE-003g9M-Kt; Mon, 03 Aug 2026 11:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=rBy6bqDwvwo9+dG2U6PXcupUrsrlG336xuKDiR0Q/LM=
	; b=nOshWfSJDyPGKs6iqNmK0KHGfw89v64HrebFPiLVpiBoUPrJWfOi9tagw3vpDysaJ4y5n6iI2
	Yf+hAzIfRzClQxn9Bz8f0gTNg4Mjqms1318cwnsXUe2KqgrtfA4aAV9KiB8UGxx7rjKVaTS3Fi1s8
	08PwwvjI5E3t5pISkKiweZ8Yn+WXtz3g8ApxQyEdVKjadP0TQpORZDcpBuaACGOiRPdN+9czO7Bjt
	OmK5CmMRDrtme70swq+73jNgx+EMoTbOitfvkyQ5mCg+Is1un1wSbt5NtWqpZtfE+yiip5r9SW7di
	MFUE6Mv8VP4uosMRyeTH+cuDeVyRVjFEonV1fA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqoYE-0003xs-32; Mon, 03 Aug 2026 11:01:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqoXr-00GDCj-Bq;
	Mon, 03 Aug 2026 11:01:15 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf v2 0/2] bpf: Fix socket leaks around
 connect(AF_UNSPEC)+listen()
Date: Mon, 03 Aug 2026 11:00:41 +0200
Message-Id: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBREr0L+2pq2CBJX3MOwaD8fqShtWiAYw
 t0tde1uZjIzb4NA3lCAW7aBp8UEY8do5CkD7NX4IGba6EFyWfJSVixYHN7KsZe1w+zYhFGSGph
 ulVY58SrHAuLaeerMmp7voF0HzS8Ms34STsfnUetNmKz/JP4iUjmhrjL/i1oE40xo3WJRIRXiU
 ntt1zNaaPZ9/wLqkJjs0wAAAA==
X-Change-ID: 20260628-sockmap-lookup-tcp-leak-bdaba3e083c5
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

[1]: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Defer "Use sock_hold() instead of refcount_inc_not_zero() in lookup" to
  bpf-next [John]
- Fix comment style [Sashiko]
- Link to v1: https://patch.msgid.link/20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemb@google.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Joe Stringer <joe@wand.net.nz>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Michal Luczaj (2):
      bpf: Extract shared reqsk-to-listener upgrade
      bpf: Unconditionally take socket references in lookup helpers

 net/core/filter.c   | 83 +++++++++++++++++++++++++++--------------------------
 net/core/sock_map.c |  4 +--
 2 files changed, 45 insertions(+), 42 deletions(-)
---
base-commit: e5fd3f514e27db1f05fbd72ba615d74941e23c51
change-id: 20260628-sockmap-lookup-tcp-leak-bdaba3e083c5

Best regards,
--  
Michal Luczaj <mhal@rbox.co>

