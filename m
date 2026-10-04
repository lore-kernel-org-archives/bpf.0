Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471435E931;
	Sun,  4 Oct 2026 04:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791089075; cv=none; b=uGhaKSCXPLJatrNKIcKHpC1xFwV11OkLY/HLGKLV0L7e+2veBS8NnPCAonba5cY9xeGJP1m94ZbtnBGDLGOkUGJEc+Zc1HRyhK860XInIJMZ5L1biUwCU3rgWjFEr6t6iygrYx9SIij0QqGZhxGYVbXno+Vc6JAqil/qJH6vK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791089075; c=relaxed/simple;
	bh=mgCVQ9OkUN6to+zuCrllhKnShEsYYFKs+dhxVzDXexc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qnMW8q5W1mvnLkoMKyAM4sfkzk9y8xW5r3raSjLP+7taEaxwrNdY4BKsrQFzI+kAWMNme0IsqrpzunRBXF7s70pJQerZACLFO6ic65UPVTIAaGfDa1JyvjlsxaVqFRA4FJP/7fBZd8p72kMOuxwPJ5GSlHf/9Cw8MzruecSWbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3L3JZAX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3L3JZAX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B467CC2BCB9;
	Sun,  4 Oct 2026 04:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791089074;
	bh=mgCVQ9OkUN6to+zuCrllhKnShEsYYFKs+dhxVzDXexc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=m3L3JZAX7UMC67VMCDTa97vkz8Yhd5Vso7H96szz9Rx9dkjXj4pBnlC/jshPGrR9g
	 iPvtd2mDK54oQSzTKm8Y3yvtcCALvgT9kIoJwoE2ncZdjSxE342AqR8eXYMJDdTh+c
	 2uuRC/9BQmiine2uf0e1OW6WEOZwnolUsjAuYEXlRbkdDbF18X3Xzsu4RCPPYjJgTW
	 roNDcjQ7xTEpRnTdWDvLYIwXP08/7GdD+Bm8OPdgHQfXaaLiIkdmfYLAxdViW/uqLK
	 kGn5A8WXQi/z15srPk7DPpDiES6wZJdK/wJImbvHQRqBnANWEMB6qBuana4jCtuuc9
	 fDPlO4OGmbqeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F243CA5FF0;
	Sun,  4 Oct 2026 04:44:34 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next v2 0/2] net: annotate remaining lockless
 sk->sk_err accesses
Date: Sat, 03 Oct 2026 21:44:27 -0700
Message-Id: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OzQ6CMBCEX4Xs2TX9AUw8+R6GQ8GtVLQl3Uowh
 He34N3jZOabmQWYoiOGc7FApMmxCz4LdSig642/E7pb1qCEqqUQCtOT0boZecChY+ORYsTaktX
 qVJZWVpDRMVLO7LVX8JTQ05yg+Tn8bh/Upa11y/aOU4if/cEkd+L/2CRRYGuMaI2oaq30ZYwhB
 X98ETTrun4BSirMrdQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791089073; l=1777;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=mgCVQ9OkUN6to+zuCrllhKnShEsYYFKs+dhxVzDXexc=;
 b=P7tWP0I1kn+S0QmhhhpR7E8umLZbnmB+G60n3pK7u8OMYxu2/1OP8qO5IX9Gec1UUcpvHol8g
 YpIblb39Ua7CPbbQr9XNEJiv/cfw/WruUgGOOjtMF/Q6TZ2496+2yXY
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
 net/tls/tls_sw.c          | 54 +++++++++++++++++++++++++++++++----------------
 5 files changed, 44 insertions(+), 24 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20261002-tls-fix-sk-kcsan-err-6fef32744f15

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


