Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A483624BF;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643596; cv=none; b=O3aQRgqW+YHguBQpk1nOmqu8JkdJ9sUMBjN0g8dJxkDvpesnLsId1VytG5jlZVh9NNUBeAEQNr7SEqe5NxAHZPLbNQiiAcmaXXLYIzJ8Mt3pXE120F9pAtDRYrJ0uki/u+o39jacMeHPavN6311BLCIFSxOz3fKKf+72u30tME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643596; c=relaxed/simple;
	bh=1+ZzSayVIBmhXvsoWcGH5TOxPUv9kk3pCN6x3PwkR9Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=esYqdjJBQyg8PJzpfCMfA5uJ3Qzz/MlaNUSzUtnWzxZvMBDBHjyYnMveubWoL1WdRuzqBpwoUSyTNsaQ4HrAw1/7HhYzBngyyYf+koD2BcLR3vZkOAm8SPWswNUd/fzeSr6peNCVGdajtOF/j//eFXTBFFtd5OZsPL6nnKyzreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC5mXkVr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC5mXkVr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5204C2BCF7;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791643595;
	bh=1+ZzSayVIBmhXvsoWcGH5TOxPUv9kk3pCN6x3PwkR9Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kC5mXkVrJTFodgjrb0ELsIfFfGcIvEDLHc8FH2bUvvD8vnEWrkKENPZOY7pW+9epJ
	 /tSDObUNUl04Nw5sD9Ds0U3OTnjUQT7bfXQmFw0B83uWWVg89DtEicoKg2ymmFVlt6
	 yQzKs54bicpFCQXM6Fca2DElSoj9ReOLUrBR5r/QfCXwaUQ85zEPUz406vzi4LyXJI
	 m3tgQjsB160Iebey5cBO5Hf/75mGvOblJ9JqN2r+HwUaLPoNr/F13oO//V+urJnooT
	 nD3e6DvMaJWJ6aRQsVRFz5xBnRqZi/1ppopEiQZ3Mqm2mfdNZ6IJOSnQxv+pOe75Wi
	 nBXa0IQV2RaaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940CFCA9EC1;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next v3 0/2] net: annotate remaining lockless
 sk->sk_err accesses
Date: Sat, 10 Oct 2026 07:46:27 -0700
Message-Id: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBREr2K69pv2F2pw5T2MiwIfqWhL2kowh
 LtbcMNGl5OZeTMTC+QNBXbaTczTYIJxNgm537Gq1fZGYOqkGXJUgnOE+AjQmBFCB10VtAXyHlR
 DjcRjljUiZ6nae0qZFXthliJYGiO7fp3wKu9UxYW6ZFsTovPv9cEg1sb/sUEAh1JrXmqeK4ny3
 HsXnT08aZ0YcAuRPyCYIFTIQiOVdZ2rLWSe5w+q/XezGQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791643590; l=2099;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=1+ZzSayVIBmhXvsoWcGH5TOxPUv9kk3pCN6x3PwkR9Q=;
 b=lccbEbihQ2wVzgOvHYkd02J3zLYLv5cyZfzpTp6Iwluf/u91B8gMd9+Yvj5p+koTJDZ5Ca9FI
 D5d63aaLSGrAXw+p5YXLcyTBExgWTLNOvVDzm9/YwDd838iBsYJ54xU
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
 net/tls/tls_sw.c          | 54 +++++++++++++++++++++++++++++++----------------
 5 files changed, 44 insertions(+), 24 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-tls-fix-sk-kcsan-err-6fef32744f15

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


