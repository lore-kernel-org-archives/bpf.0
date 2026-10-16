Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70F2D0614;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121498; cv=none; b=kZPLG9+6oQsDL8UZIQBmq0XuylOB8pr3aOK7kRZGC1Zb+e84I6KZLlcRq+0k+xXHkzqLtjGkxgV6Z5QW0/Z+QZiP92Tn7+7frJW+0eOPInobwLXnqFWEPNqyhZu8Sy9cJOWvPyjq3YkPnMfuA0ktIKAtqlNOW8fmStympGYMpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121498; c=relaxed/simple;
	bh=tJxl6szbEu/sixUPfjPjMWFV7t5uJftR95+/Px8Swc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5aTKnpMV49Wv/1sA79FArp6npPtzNcdGhdh1uxXP0Q1YUZsQfMt+wT+BJuJ9W3y+zhURsX2MrzHSUBjSshSr50jaARURk6cVi+TP7S10Gi2emWQjAAu4DkodhY0rqWcPtwtUeQYRd2o3g42toPz70hL0cBFMtSuiaQj/DS6dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLqN/1Hu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLqN/1Hu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59BABC2BCF5;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792121498;
	bh=tJxl6szbEu/sixUPfjPjMWFV7t5uJftR95+/Px8Swc8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RLqN/1HuQgFl0+yy+g4Bmk0hoN8g6yp3OdfDUemPNng/oodBA9draTuXr5ZCNFb09
	 QIc7aN0QNteJT6cH4X2T/RGuTbu2IWt1Kdtkx8c5ipyt0I0bKExqxZ76Nzs7qcCCo+
	 SC/jBVFFBlUsgwN6BTQYuCSDFar9ejQmXsWbU9VYAkemdom7MCM7WccZ0U05gtkf0c
	 th2p+pKJ3iwY3vja7/06ZPKoZqV+lI+WhRjX06sMBa557OhDOYXqr61UsY4iOjfDZ3
	 VOtEduMdP/ToTwvv+6aySz5aKWrwmbjfpmSxlopRgM7tDIhrclWnTKC7+br7bdd6se
	 H/pS8D/VNyigg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DBCC6B38;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next v4 0/2] net: annotate remaining lockless
 sk->sk_err accesses
Date: Thu, 15 Oct 2026 20:31:35 -0700
Message-Id: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSQ7CMAwF0KugrDFKnLYMK+6BWDiNC2FIURIqE
 OrdScumQoLll+33/RKRg+MoNrOXCNy56FqfQzGfifpI/sDgbM4CJVZKSoR0idC4B8QznOtIHjg
 EqBpuNC6LolGlyKe3wHlnZHfCcwLPjyT2n0m8mxPXaVCH3aOLqQ3P8YNOjRf/yzoFEgyRNCTLS
 qPe3kKbWr+48ljR4RTRPxDMCK/1mpCNtWX1jegJouQPRA8IrogsG63ITpG+798rrVNlXgEAAA=
 =
X-Change-ID: 20261002-tls-fix-sk-kcsan-err-6fef32744f15
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121497; l=2335;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=tJxl6szbEu/sixUPfjPjMWFV7t5uJftR95+/Px8Swc8=;
 b=rfObpSk8GQeJLi5fzl0oFdpqlw6AcSh1a0WtbkL3Jaya4s6iGA/Se9EulONiXZ2ocdERruI/b
 ZYC37w4PGurBqPVtHWjI/mSuQgpLWcZ7OLzMqAz0no38FoS41TIBVxr
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

The TCP/MPTCP series that annotated lockless sk_err peeks and
consumes is in net-next. Paolo asked for the same treatment on
kTLS and on the unmarked writers that still race those readers.

do_recvmmsg() and getsockopt(SO_ERROR) still call sock_error()
without the socket lock. kTLS is a ULP on that same struct sock,
so tls_rx_rec_wait() has the same peek-versus-consume split, and
the send path still does a double unmarked load.

sock_dequeue_err_skb() can store sk_err from MSG_ERRQUEUE before
lock_sock(). strp_abort_strp() and sk_psock_report_error() write
the same field on the TCP/TLS and sockmap paths.

Patch 1 annotates the TLS readers and consumes sk_err once on the
no-data path. Patch 2 pairs the remaining writers with WRITE_ONCE().
No extra ordering is added; ICMP error-queue overwrite semantics
are unchanged.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/

Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Changes in v4:
- tls_rx_rec_wait() / bpf_exec_tx_verdict(): declare skerr at function
  scope (Jakub Kicinski)
- Patch 2: unchanged
- Link to v3: https://patch.msgid.link/20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me

Changes in v3:
- rebase on net-next after the net merge
- refresh WRITE_ONCE() in strp_abort_strp() after the strparser
  refactor (Jakub Kicinski)
- Patch 2: carry Reviewed-by from Eric Dumazet
- Patch 1: unchanged
- Link to v2: https://patch.msgid.link/20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me

Changes in v2:
- tls_encrypt_done(): fold the three unmarked sk_err loads into one
  READ_ONCE()
- Link to v1: https://patch.msgid.link/20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me

---
Quanye Yang (2):
      tls: annotate lockless access to sk->sk_err
      net: annotate lockless writes to sk->sk_err

 include/linux/skmsg.h     |  2 +-
 net/core/skbuff.c         |  5 +++--
 net/strparser/strparser.c |  2 +-
 net/tls/tls_device.c      |  5 +++--
 net/tls/tls_sw.c          | 51 ++++++++++++++++++++++++++++++-----------------
 5 files changed, 41 insertions(+), 24 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-tls-fix-sk-kcsan-err-6fef32744f15

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


