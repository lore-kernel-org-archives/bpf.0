Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45D3A783A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907837; cv=none; b=e0nTJc86LBN5IgixF+cWA9qk3EMSUzyNbk6rfk2Dssc1vZxFbE/NVSh3nAohCZJQaZgN+EgezUqo7c0tih4cbog3vsuJIkIqbwOamQvl8Z2jUdMtxdciDuDFCliSnz6lf4vaPuGPP44S/NeF/oNFoFgy3ajwGFxGfRlnTtxX7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907837; c=relaxed/simple;
	bh=cj3zNWgdYDcRxz1oligwgpnRSh482psQj978G9+dUyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPHqtyNuXD3JpDUzHWES7b62eTekUicNn/HDITdJantaFhnH1c5qSF1N7LFUuvuPwGbIxpe5uuXxNfeYZWPLdmsH3Aa9R5SOrgBpz50hN1N+7p1MJYyYvIp2f1cz4J8D92QhPNFK0c5VkNdJkSGc/2TcPSPJDP4dCtFd5R4U9iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXT5AaNP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXT5AaNP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b250d3699aso48820445ad.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907833; x=1775512633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl/sKXd+rVvwtX4lspRuwpIWSFPNegapjZdLWrBkKwk=;
        b=aXT5AaNP7PWnwgOWanQq5fX25aALBAXrc7l/nTTIyvat4BxYxREaDt0IHtR9SH4hS4
         HnJStd7g6h6o5nHjMG4bVF77MzRvAlTkaE0d0X94oinzmdhp5OW8tWBxb9wwDnLUymgt
         KTxJmAOVsEjmNUJ6BFN5bRx9gXMq/Jl+Qe6c/R/dM6sbGWzPTIg0voyOOv6gjD5XzmFQ
         sEE+gddS7v4cxXzczl6zDeaIejdviFljFz4EXhm6Fn6NuvQaj9ayinc0PBHbWJeXY70E
         s3nZrkSO+MhkKm/Cb5t+khZ+SaYLIRNh4DWMWTK8d0Pp7EvMBxiEe1urapwdx+pH4Dz0
         EpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907833; x=1775512633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl/sKXd+rVvwtX4lspRuwpIWSFPNegapjZdLWrBkKwk=;
        b=guCsY9lAXbMquGIlUMyPpS59TbaCgVZqgXkFMFyjvzGBIc8/ag/OUQLduRlkAfNlDj
         LRCk5EQCf7gcdIAjNLUsV1YINBPMZbOT2jIk8Xs7Yk7qBNHsckt6ja3vtSCfModB3Dhw
         mhgK1PzH+gc783Og5Jeo9PROm/4kESsFXXtrxwbobxeVp4i+ncBLB+ls7+vGc87X8aej
         Kcfy6QG0gqAnARbio1XMOTYOa7hPFhB2fC3YFMdX9PftlEcbzDgmlcglXLxFSgSNaGw2
         pwwk9cSBEvQ00PcUNKbtjQE7YubtRO0hQ/VYiJYx8J4LxLzf2mxfyMOFpaipqagXboiC
         NQuw==
X-Forwarded-Encrypted: i=1; AJvYcCUgq+9rVL24jERTVmABLqV3aolCa6sRtffG4jiPyOpKKBmjWBtI2R02G3JVTebJOA36t34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfpVEvP9SDRvKEn7QDdioc3hkwG9gc7ewRIlVO5vuwjOFEAwH
	j4I7akSZsm9B0Y+PnJUynCHd3kYSyP3CTtGEwwNcA1+faZssxbmBl0tJsnn5KFTxFzvIIyuWU5o
	Tbw==
X-Received: from plbbi11.prod.google.com ([2002:a17:902:bf0b:b0:2b0:663c:53a9])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c7:b0:2b2:5503:1b8d
 with SMTP id d9443c01a7336-2b255032776mr45644885ad.6.1774907832572; Mon, 30
 Mar 2026 14:57:12 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:02 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-3-jrife@google.com>
Subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the
 4-tuple hash
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, previously connected sockets stay in the 4-tuple hash after
__udp_disconnect if the socket was bound to a specific port or port:addr
pair. This is benign if inet_daddr/inet_dport are cleared as well, since
lookups matching the old 4-tuple will not find this socket in the hash.
To maintain the same behavior as before if inet_daddr/inet_dport are not
cleared in __udp_disconnect, always remove a socket from the hash on
disconnect or abort to prevent a lookup for the original 4-tuple from
finding the socket.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d91c587c3657..6e5ba2ce9314 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2235,10 +2235,20 @@ int __udp_disconnect(struct sock *sk, int flags)
 }
 EXPORT_SYMBOL(__udp_disconnect);
 
+static int udp_disconnect_unhash4(struct sock *sk, int flags)
+{
+	struct udp_table *udptable = udp_get_table_prot(sk);
+
+	udp_unhash4(udptable, sk);
+	__udp_disconnect(sk, flags);
+
+	return 0;
+}
+
 int udp_disconnect(struct sock *sk, int flags)
 {
 	lock_sock(sk);
-	__udp_disconnect(sk, flags);
+	udp_disconnect_unhash4(sk, flags);
 	release_sock(sk);
 	return 0;
 }
@@ -3254,7 +3264,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	udp_disconnect_unhash4(sk, 0);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.1118.gaef5881109-goog

