Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452734BA50
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213626; cv=none; b=MUBccbvtYCcqQSfkFPR+bO0gTQh5qlLr+K5+3pXl0y1SqHLLHdPAlucyyMxbdnELILCVE8l3WmhxDxc5Sv0tX9jXQtOebbslGItXOB3IRzqFGuP6nPgtWZPjEAJsBvFE4QZWsA4lretCOnuBNjMCJ20PfrpCNK/Rol66SHzRG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213626; c=relaxed/simple;
	bh=WpUspO+Gz3+m31nHLT5NVtXRWZab4kvM0luKnWbl/Es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eelUxWMEKwBUZO/9AvVkvq8UN83O0sQJx25PLlV3PBcLuwVtRwIQdLRj4i4owi7W6gz+gSSH2V/QSEHjrExHk4XB3NXna3MJPsAjMOjY+1M1W7s3J0tERV5zO9jf4dhHIGRNuSx2cFO9Y/GzjPRbGaaQBdtgaTjNqT4Ud5C/DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T3K4jyEw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T3K4jyEw"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c0efc7ef797so313693566b.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782213623; x=1782818423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elaSjIGfSwH+Wak0Gp5qRHdd7cauBRR9ppc4J3/+sDI=;
        b=T3K4jyEwW4oa51y28Sbb6tBMcMT7v6VIIdTSepFcgpuaiyWy1swERl6KFQFCHzhyZM
         B76KODWyQLS30ZKWAGDegAI2Pnu+Q2ANPPYtxK/J42+wTLsR0MNlgBRSj7e/TJ4Qi8iL
         3H/3o1TKygR7CXYo3RrD9FFx1hSyrTeRhbcC3+COTqUPJDyLeb4wrllr/ICoZGXuPJ3L
         FKboSsW345HfgFBN8sWcA9mWYREVSxEg/XN7iONa9XkAsEAWDbkAld3fjABVBeBWYC1y
         xnqXroTlV4bW/q6VMrhHV8S82xiEiwKOe9gkPNHGUtYrtqogjAhjd4hQzHW0CgiZTZ4w
         OpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213623; x=1782818423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elaSjIGfSwH+Wak0Gp5qRHdd7cauBRR9ppc4J3/+sDI=;
        b=sfQ015YTHL7O93gsg3mOVqq8BXr4PCgDcJrnPKnzTAlDxfeVajuOUUIcDKVq80xkuE
         0QTwVAWL+AeWl++K5igu5hFgfacyV7n038tTjgPYnhKCxpjsF1dG3qP0i9P7AX5+cl3Y
         494AT1wgoDSnjGchSXrqS4us6egJ3FMlQhFp8Xbp2I5ZFBNN7gr8ljyp0909hXHdWm1p
         Bl9dIJYLhT3ZkSWGIy0ofvoXHxAfKuqrLzF65HpvdP+AiNKLAJeTjMx/sqlKSIDz+5x9
         8FMh4HYlfD7TQZV5Yk1lnU9IVDQ3HR0aKs3D40C+GpG6rInVdIcGwjF+msAJoN4X6Oe5
         aOrA==
X-Gm-Message-State: AOJu0YzrtmYVc4rg7N4QpLoB/pOB8hbGInk8mjjk4/ozOdcwQ8oRbjNL
	udbK7sqRHuZv4MtexuBjRHiqspktQ/BFF+3qd3z8k0fMB6vwclsG8KexJRZEIrvtOF4=
X-Gm-Gg: AfdE7cndy2dN92p5qb5O9XSAX/MFqRG9IS7PqnbMSbyDvqWmV9VqG4t1f62X/3diXy2
	pNQuJsZiJ9znJZNDLNHYRIDvPUUu5QGoQpI6cpnWMVgOIK5ijk9jl8E0aO44EB1AwmcczEbRaWJ
	zydD6saf3lRPL+Q+oMOUXBn9PHYUTChwInmRKPHAzwWoUbwV2CoydCRTTmZZ+7PunCFNyryyk7Q
	hKxTTKulvcaK4e6plHXRul4dgvIChtp6LIV0apBeLkGA+w+XKT0aMnQCs9SW7OF7TRTJvSaygje
	EV4gE7Ezesm3nmsSqboRXMEXw3JryA04osjTbzq1zbuuOOP1BLnDCe/XQKjcTMeGzOvdiyZiAXW
	l2D2cDWitYOuyShgWfDSDDV5yuWkUkEaUJbT7fJa+Kiy+pD1p8bV5QURy2Dbw3kwkI2v6jNBIfJ
	Q82MAUoLwYjrpKnD10
X-Received: by 2002:a17:907:c085:b0:c0d:9172:c8bc with SMTP id a640c23a62f3a-c10902d21afmr125473866b.42.1782213622896;
        Tue, 23 Jun 2026 04:20:22 -0700 (PDT)
Received: from cloudflare.com ([81.15.226.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac9e77sm490232666b.37.2026.06.23.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:20:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 23 Jun 2026 13:20:18 +0200
Subject: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAPFrOmoC/4WOQQ6CMBREr0L+2pq2EjCuvIchhrYfqEJL+gvBE
 O5uwQO4nMy8mVmBMFgkuGUrBJwtWe+SkKcMdFe7Fpk1SYPksuCFlEyNDaP3c6CW0djbyCZnF2Z
 KkRuOPL9qBYkdAzZ2OXofsCMOlwjVz6FJvVDHvXbPdpaiD5/jwiwO4s/aLJhIk8i1KpXiF3XXv
 Z9M09cBz9oPUG3b9gVOTc8G2wAAAA==
X-Change-ID: 20260622-bpf-sk_msg-split-unix-d714d0e048cb
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15.2

Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
completed all code paths related to sockmap-based redirects should be
guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
disabling NET_SOCK_MSG. The implementation of sockmap as a container for
socket references would remain under BPF_SYSCALL.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Handle prot->recvmsg being NULL (Sashiko)
- Elaborate on the end goal in description
- Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com
---
 net/unix/af_unix.c  | 4 ++--
 net/unix/unix_bpf.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..84c11c60c75f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t si
 #ifdef CONFIG_BPF_SYSCALL
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	if (prot != &unix_dgram_proto)
+	if (prot->recvmsg)
 		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return __unix_dgram_recvmsg(sk, msg, size, flags);
@@ -3152,7 +3152,7 @@ static int unix_stream_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	const struct proto *prot = READ_ONCE(sk->sk_prot);
 
-	if (prot != &unix_stream_proto)
+	if (prot->recvmsg)
 		return prot->recvmsg(sk, msg, size, flags);
 #endif
 	return unix_stream_read_generic(&state, true);
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index f86ff19e9764..5289a04b4993 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -7,6 +7,7 @@
 
 #include "af_unix.h"
 
+#ifdef CONFIG_NET_SOCK_MSG
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
 			!skb_queue_empty(&__psock->ingress_skb) ||	\
@@ -94,6 +95,7 @@ static int unix_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	sk_psock_put(sk, psock);
 	return copied;
 }
+#endif /* CONFIG_NET_SOCK_MSG */
 
 static struct proto *unix_dgram_prot_saved __read_mostly;
 static DEFINE_SPINLOCK(unix_dgram_prot_lock);
@@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct proto *prot, const struct proto
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 }
 
 static void unix_stream_bpf_rebuild_protos(struct proto *prot,
@@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct proto *prot,
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+#ifdef CONFIG_NET_SOCK_MSG
 	prot->recvmsg = unix_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
+#endif
 	prot->unhash  = sock_map_unhash;
 }
 



