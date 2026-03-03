Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6954EA392
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557273; cv=none; b=SlzgyEaAMhVtAU2h7y3mc1/vU0NrJIK2G0UCgP2e76ZfuHDgwiXN67prmNtGPx6kBKGkgteqS5N/fjbbIg4tY7v/kHIBsmYAEV0UTRr94MU90dJ8f5gGdOmtxfkr2BUbCREXz5yUwe6M94+7f96pDkj8Pgo1/9VZk1E+0rW7i6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557273; c=relaxed/simple;
	bh=+xr/8cP1YmUhYlqNJcGc2rtUKBHvlfAXWLvjH6aqTzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vgb0HEWgmOoXlfe/zvOaKcEQeB/qpFSMzSgV/gP4iqp+lvj552+hbYZRFP0nvbupyuG6RT3+7WTJTWaE+dzVlPoLn2MyYMbZByYa7H5GuDYZCtL6qmBj5z2PEwe3bJG2r+qJFaaWKCiXllMuordSsdlhmmZM8sJvUfZhPo140W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8uCb1tZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8uCb1tZ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70f137aa4aso3464551a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772557271; x=1773162071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjQGo/Bm/mzaEwWNBUTkUEEoY/bSeVQ1lxMEw0MvYk4=;
        b=W8uCb1tZd9dREQeElLfg9eOBISvtDGVh21QhjyOMruc0SM4SDjCTb0pOEnWMZ1yk5X
         GoXnvaP3GejhlEZo35qQydSy2EJmALJZlOq4OZ6smE6b5sS89J8y76JhEubygAa93Cmk
         jhK+IvbX5sv/Ik/r/Z8ZqiFTgcGicrIoKQCS9RM+BYaucyfSkAfMo/W/GO1Vc68m0x1/
         hTf9+zuWCvXOU3lnwit8AK6ksSA8X8Ma0rIreMip/tHnFradFUu/mpQdJPShYCzIUrg7
         gUHZDy9D4C8axhxIRnTKMPM/JAl4XMm93lY9mMM846pcT9Tj1mjKf9uR3i1/jGOP36/w
         EVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557271; x=1773162071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjQGo/Bm/mzaEwWNBUTkUEEoY/bSeVQ1lxMEw0MvYk4=;
        b=N3n0+bdlbMsRMPHX0nNa82twhUB13u39dM1geRUSxmkqGsK3xRIPlUMMWcz3ysEFHj
         0Anbxkp2Qx2xwddpQ5AMfDqw3bZe9QU0tUzX39jadvVeEYPgKUiR713x+CuV7r+nNQn2
         nKfD8tJxGkBOadXXZXsFEpXeWglzrUUXU/6/VuBx+IzfOnNzujK/pFM+gImtgCItPHmD
         cqM2/CpdZHlnDJ/50FZq/lbPeUCWGGiHg9rkjhFuUvOC4lhIzUo0x5cycRZPmBxd3NL/
         NnsfkHeKNlHQng7Hjicb7ndEJ9GrYQZfJ4MUsS+EWeEl5IUQf7LifM3xfzGpN9ND2yqh
         IP/w==
X-Forwarded-Encrypted: i=1; AJvYcCULtyifxqmb5UTeVxsphqORpMpalsux3w8wb4KxtX+eY5+82I/BM2O47wykWB1WGKF8kko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqK/a0WHFfS3T8OtTV42Qnsu0KIm05PmKacoqwjAavXjFdCSz
	IaQ3zksWbfzK+nqDw0qhXyOewAf7sOe4JE0NXTEXGR0ZAW4o4/TwMIP866yG7AiRA5WvnDs0zBA
	8jA==
X-Received: from pgkc18.prod.google.com ([2002:a63:ef52:0:b0:c6e:22cb:d319])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f0a:b0:38e:676a:f3e
 with SMTP id adf61e73a8af0-395c3a5f7cbmr15863153637.29.1772557270810; Tue, 03
 Mar 2026 09:01:10 -0800 (PST)
Date: Tue,  3 Mar 2026 17:01:02 +0000
In-Reply-To: <20260303170106.129698-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303170106.129698-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303170106.129698-2-jrife@google.com>
Subject: [PATCH net-next v2 1/2] udp: Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Currently, udp_abort() invokes __udp_disconnect() which clears out
socket fields like inet_daddr and inet_dport. This makes fields like
dst_ip4, dst_ip6, and dst_port useless inside cgroup/sock_release BPF
hooks following an abort on a connected UDP socket, since they'll always
equal zero. This differs from the behavior for TCP sockets where a
cgroup/sock_release hook will see the address and port that the socket
was connected to at the time it was aborted. This causes issues in
Cilium where a sock_release hook is used to perform map maintenance when
sockets are released, since Cilium actively destroys connected UDP
sockets in some cases.

Make the behavior consistent between TCP and UDP sockets by not clearing
out these fields in udp_abort(). Instead, just unhash the socket, mark
its state as TCP_CLOSE, and preserve the state of the other fields.

Fixes: f5836749c9c0 ("bpf: Add BPF_CGROUP_INET_SOCK_RELEASE hook")
Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..01a0a0fbcd56 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3247,7 +3247,9 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	sk->sk_state = TCP_CLOSE;
+	sk->sk_prot->unhash(sk);
+	sk_dst_reset(sk);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.473.g4a7958ca14-goog

