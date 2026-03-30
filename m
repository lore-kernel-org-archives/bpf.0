Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA62ECEAE
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907838; cv=none; b=VGALm8ipFa8gaufbOj6BjnFM6/KiKBG1SkB2ZZ06CIYrMG7iEyOiHjyHGSPdNZDuWabGFJJl6cf+wMKaJqj56YsF+p4PYOlHgu5uAvb6DEZvlB0B61Wms0ghFLeGqYCpxmCXNoRDBgo8BY3yqlb55LK0r6HaJm9wgupG7T4NL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907838; c=relaxed/simple;
	bh=MZhxXerGlASDsfcGK3gTBWWhreUnNcrpdb47N1l6ULA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lywTfh4kWt7pZdb5nL26foJQVgxyneAEaj0imeXrWW8BxuE60onp2+NoOjJn7dp0vOS666JRr+uDb5ETe6nWgPMllcw+Siw6fEXvyhkwIK8eNYkErzEIbcGBsqca2pYnFo7PF1myv4QmWctiX+d3d9nKJd82+GfzbRSNFAd8uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrKyccM5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrKyccM5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829b7ed8964so4622328b3a.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907834; x=1775512634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ09Hs2Uy/7LGsQS5aliSwwfndVhkXSmLIoOZ9aoz80=;
        b=rrKyccM50WiqwBpIm4WfKvcUdWtSYfKXaX/tJgrhdisSp6ZYcyplhtlOP+JumdEfpQ
         na4BSlXiUEZQplL07wCnJKfKi2RJl/DMFYjJxFD/+MAwoYQAfTPnx5Glny560b1gYiUT
         EY0lDTZbVZ0/WyvDACzf5oKVapmahstZrVu/ocupTCtHlU8qV0jm8im+Nkv6Rqo7JT3z
         EHTSjzQIbpJwt5Zi3T15qy9iAwChDlCZ0TJBi8CeaZYpqjwQlzkQToAe8hnLpgFFwWny
         Gz8ieFf/V87QRPMJij5MI2BmA5vGkz27hvJEejC5+TpfYXGtWnvWkz+IPwhZ8Co8jAoM
         +Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907834; x=1775512634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ09Hs2Uy/7LGsQS5aliSwwfndVhkXSmLIoOZ9aoz80=;
        b=HWV7HjUpp0yd43Z328S+yDwNhxF6NIFAKcas7joMMhoA663LpOzNk/OO1UgXZKA4dp
         ExHKxnGc26hugbRwdFFMHDH8DWyaia/FmGhNdh0aLj+h+A04uB+tk9AGGU83SsKMql1M
         znjFV4b7g/dE6bYleRXsHz4J+yOkKT6sL2bx2tq9RHVZIWeRwTtlr0rQtBcKeHNNqBlJ
         dGDepKqlhV7LMpWH0760VSdWdecxLPRoHSJe8n/aRnEKS30KfjvU8boe9W+qvtyCnQ61
         g8iDxTaQnV+RMxlaBkhcpPqtJZg6k/JiqYmaxWTe21aH9g9Z9kmisJbARKRAXotQMX4L
         4iIw==
X-Forwarded-Encrypted: i=1; AJvYcCUFnYEv78uDmLixXENdQkjTNvKrfz1QWPAjUkFEB/pFPdZ5bVbfIHcVrtntj71ppdpRVYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrXpPKI+j/mye601JdtBtN1PJXleehdeMR/AzTX1agIowlWH0
	25n+nv+wP3+2TsbPBTMMjVAeq0I+TkH9zTWM4PeOcig28XGbq4Lz1JRuGn7BUpni/S4kNHJwT1v
	Ajg==
X-Received: from pfwp34.prod.google.com ([2002:a05:6a00:26e2:b0:829:9e78:35e9])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4993:b0:82c:d7c4:4c69
 with SMTP id d2e1a72fcca58-82cd7c452ecmr469214b3a.3.1774907834342; Mon, 30
 Mar 2026 14:57:14 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:03 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-4-jrife@google.com>
Subject: [PATCH net-next v3 3/4] udp: Preserve destination address info after abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

For explicit disconnections using connect(AF_UNSPEC) behavior remains
unchanged while udp_abort now avoids clearing inet_daddr and inet_dport.
This is safe to do without changing behavior elsewhere, since lookups
only consult these fields if the socket is currently connected (sk_state
== TCP_ESTABLISHED). The behavior of getpeername doesn't change w.r.t.
aborted sockets, since it returns -ENOTCONN as long as sk_state ==
TCP_CLOSE. Behavior of BPF socket iterators and /proc/net/udp /do/
change with both now seeing the non-cleared daddr+dport pair after
an abort. Behavior of BPF socket lookup helpers which invoke
__udp*_lib_lookup don't change, since the result of compute_score should
be the same as before.

Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6e5ba2ce9314..043496a249ca 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2207,7 +2207,7 @@ static int udp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return res;
 }
 
-int __udp_disconnect(struct sock *sk, int flags)
+static int ___udp_disconnect(struct sock *sk, int flags, bool clear_dest)
 {
 	struct inet_sock *inet = inet_sk(sk);
 	/*
@@ -2215,8 +2215,10 @@ int __udp_disconnect(struct sock *sk, int flags)
 	 */
 
 	sk->sk_state = TCP_CLOSE;
-	inet->inet_daddr = 0;
-	inet->inet_dport = 0;
+	if (clear_dest) {
+		inet->inet_daddr = 0;
+		inet->inet_dport = 0;
+	}
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
@@ -2233,14 +2235,19 @@ int __udp_disconnect(struct sock *sk, int flags)
 	sk_dst_reset(sk);
 	return 0;
 }
+
+int __udp_disconnect(struct sock *sk, int flags)
+{
+	return ___udp_disconnect(sk, flags, true);
+}
 EXPORT_SYMBOL(__udp_disconnect);
 
-static int udp_disconnect_unhash4(struct sock *sk, int flags)
+static int udp_disconnect_unhash4(struct sock *sk, int flags, bool clear_dest)
 {
 	struct udp_table *udptable = udp_get_table_prot(sk);
 
 	udp_unhash4(udptable, sk);
-	__udp_disconnect(sk, flags);
+	___udp_disconnect(sk, flags, clear_dest);
 
 	return 0;
 }
@@ -2248,7 +2255,7 @@ static int udp_disconnect_unhash4(struct sock *sk, int flags)
 int udp_disconnect(struct sock *sk, int flags)
 {
 	lock_sock(sk);
-	udp_disconnect_unhash4(sk, flags);
+	udp_disconnect_unhash4(sk, flags, true);
 	release_sock(sk);
 	return 0;
 }
@@ -3264,7 +3271,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	udp_disconnect_unhash4(sk, 0);
+	udp_disconnect_unhash4(sk, 0, false);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.1118.gaef5881109-goog

