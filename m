Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7D1A6807
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429376; cv=none; b=ZDd/iZ+nGuRZ6b0P3wWN9PcPCliEeq7Gxav+lQlrP0HEV3x4RKo4tM9ybn6UgxYLbubNgZrmUrzKiSbh6BXPzY/mJWyBJG88ifHUvdFF4gwX+o1M5ewZfHwlSwI4y33bE1GK+qCr5nsYiwsxNqqVhjzwWKE1YrodG9zKcY9PLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429376; c=relaxed/simple;
	bh=8kfpOoVWzL/yAAWhdVNLiW6FPC1C4XsOfBjEH2IxUyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVnaahyoR8tgy7jJBOrsunpLOtoqgVEPD3QNPALAv6hkOPSZiGmWoE3FBVTlQ7J5BFgJgBuQGYhPbqkMtXWzl0CToQFDDWFTjnhuVokhBnqiE2ZieRStUdmChDgI6ugwx2be5azxiDvGd95rPbbcZMd9gTpqMTsOUivwKGI0OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FA1A51zY; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FA1A51zY"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so5662834b3a.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429374; x=1792034174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z09Qg55OlPmVwo/dbEXuu8o3gUbopSQLGlzZiCaqYlg=;
        b=FA1A51zYLEQ65UqccY3ZlYtHSxAHhfcPaYDGY1W1CCgKJXh8xLIGwxN+QS2pHzqFpP
         5bMuXgaXohs6Wyc6g0E65dHAHYnwKZkYAb7pIuoh50u+YvNPCqMxrEaeFMbQps5HiEdU
         5/PgD2v6zg5xqL8KI/MjSAxJptKwkzW8KtFq5uSMupHMvwkNH7X6RlOXxbeanEMJcVDE
         JSMkAqC8QXn8lGqQpkskdrbwewqx0/Ft4JXCViAtzHIlCwBypXAcb9Ftu6GAskMEiyYB
         PQc1w3vw2OYpUcL5WAckSMTUeExKyCOYOLwiy6AQiCwUfF/gs0ZKXCn7bJIIwPEhUwJV
         7GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429374; x=1792034174;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z09Qg55OlPmVwo/dbEXuu8o3gUbopSQLGlzZiCaqYlg=;
        b=ei2hSZpqXhUryaA+JTqVnkMS3zjenOHidxd6EeFUgm45VTFeD9p0MYvFbxIadqhL8E
         iv7RCvnhi2ZZ8OPuvxZWA4otJF4r7MoRNg5W+G1Mwurf7JSm5asD2rGrBesKtRnUuHsx
         1D/BVf8yYdnN48yOPsTdf4hu0ewIlAAX6dk5c0G9HyVfOkEHliJ+IOl1LilePQZx2t3m
         uT2x8QTi6xiDvXHNZ7vdQRb4ciEBmAikvwMxR1lb2a8UwkUW4FYfT9DzdAQ+lZ+RNYIz
         8ej9f+Ger/wnFO7bOcgd+VgErpqT2F3iRlgLUstqY4Nx7s3Vi2PhNdifeL6QCesZP5GK
         T/Bw==
X-Forwarded-Encrypted: i=1; AKwUvByfsH33VgwC9vUZEno0cJy1vjRazYyQf9xHS9Gf6NmoVts9mXLkjZCgWlXIHntrVG+y8aE=@vger.kernel.org
X-Gm-Message-State: AFuF++nAc54jl3L8ee59aaTu9X5qOfGuNKjJk0avPhefIAcT30hwxVax
	L1vDdjGIB65Mcnn06SJUH0TA/IW3zphJMcAq8YwNNLtrVh0zv0zJNKStsD3waOt3m9K/PANpYXI
	FPs/lqg==
X-Received: from pfbem48.prod.google.com ([2002:a05:6a00:3770:b0:889:5c4:4b53])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4197:b0:890:a777:1026
 with SMTP id d2e1a72fcca58-891ae7ecf52mr3904032b3a.0.1791429373262; Wed, 07
 Oct 2026 20:16:13 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:28 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-9-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 08/10] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
to bpf_tcp_ops.

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
so we should not allow calling __tcp_set_rcvlowat() on MPTCP
subflows.

Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.

If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
---
 net/ipv4/bpf_tcp_ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 9a6e1c47d7c0..8182037c4269 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -347,6 +347,9 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock *tp, u32 enable, u32 disab
 	if ((enable & disable) || (enable | disable) & ~BPF_TCP_OPS_FLAG_ALL)
 		return -EINVAL;
 
+	if (sk_is_mptcp((struct sock *)tp) && (enable & BPF_TCP_OPS_FLAG_RCVQ))
+		return -EOPNOTSUPP;
+
 	old = READ_ONCE(tp->bpf_tcp_ops_flags);
 
 	do {
-- 
2.56.0.360.g66cac248cb-goog

