Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926841D63F;
	Fri,  2 Oct 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926171; cv=none; b=SrQ5Olunh4jQJJgNXIUoJe1qoe2+/maObzQLDXVFB1UX1M4KLro9s611vtHRxuI44ZVSvgyw4iQwxpr78jhw5ZzUYa3qwztoLJh+qe+lYgshaNKAiRcJoUkZwzZ7ymA9d5igkNVW3DV0SjZZEBJa/eGA0RRBC+NkC84i4/c9Pno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926171; c=relaxed/simple;
	bh=bWyQfeX71ilQHixe/9sqba14iFwH0RQ1faMsz8q6KyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G1gZy/R3DLBc1i52u6vBTz9I/lzTc7nlH3hRm2esUxY0A4QuXDy5anEl8jc/qE2egm6qlqWdDQeKNo6TcfF+M4fy8kUlwcjBCZ5F5UMS5QAw3DTnQ9zdGzZpcrxBX7mulN3gPYVE1+TIXC+hSqB3g4XN+yfjV4U8Abx9QjdKayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcwM6PjP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcwM6PjP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E82ACC2BCF4;
	Fri,  2 Oct 2026 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790926171;
	bh=bWyQfeX71ilQHixe/9sqba14iFwH0RQ1faMsz8q6KyA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dcwM6PjPEVRnz8VKba/yKmvz2GvQ1/wIsp49RKt7ozKXxerw5gunzuWiuBJG+Lpi+
	 q75fnvUovM/YHJoYxr4P/3IENDo14OtFBfesCL6T6/FL85YOtzIOL7yIL5H8GGUC9b
	 +4deP8ZGhwPp6kRzpu6C86wjBC56Nh06paVyWU3+06h9I50lmypg+fYPBG1WnHQtJZ
	 jjzKxu70b6QUset6sp6E9h2QgdnXLz8W0z25S72ul0kl+z0vr057E0FLbwtzB9Ijo3
	 3eXC23rgD6oTS9y5kZsSo09HIyUfNypSqvBjBOj9aKod3a2LF8yykRfEqFVNe54MzU
	 BwaojHcU2R5bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2088CA5FD9;
	Fri,  2 Oct 2026 07:29:30 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Subject: [PATCH net-next 0/2] net: annotate remaining lockless sk->sk_err
 accesses
Date: Fri, 02 Oct 2026 00:29:25 -0700
Message-Id: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswdJWiv4K+JDjRuNlVPuUimU/
 nujPg67MwsZNMPo2Cyk+GTLL6ngdw3F+yA3cL5WpuBC750LXJ7GKc9sI4/RBmGocp+Q2nDouuT
 3VNW3on5+2RMJCgvmQuf/YtPlgVi+VVrXDQ+kfdyCAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790926169; l=1570;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=bWyQfeX71ilQHixe/9sqba14iFwH0RQ1faMsz8q6KyA=;
 b=n7AbEmcF849oLECZ/6IMFaBiEcWOo2t8+xKvvUBfrCxj29n/qy0t9wSEJXIjepbJf5aydqgjT
 BDf57TJc/dBA5LmO1hPA9KJtq2KDfdb7BBcRtKT3AfcCe9nAX04277X
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
Quanye Yang (2):
      tls: annotate lockless access to sk->sk_err
      net: annotate lockless writes to sk->sk_err

 include/linux/skmsg.h     |  2 +-
 net/core/skbuff.c         |  5 +++--
 net/strparser/strparser.c |  2 +-
 net/tls/tls_device.c      |  5 +++--
 net/tls/tls_sw.c          | 45 ++++++++++++++++++++++++++++++---------------
 5 files changed, 38 insertions(+), 21 deletions(-)
---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20261002-tls-fix-sk-kcsan-err-6fef32744f15

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


