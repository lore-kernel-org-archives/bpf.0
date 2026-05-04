Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981F33F361
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928779; cv=none; b=Zq9Yq0HeQrbHAOUlv4m1pa3tKtff+EplSu5OKYMRoNGrE+sPCRJjomJD47QKauo6QGGSq1UG/NR3yXmHiS+K4TX8b9tEBSbLV71XYbqmjkwqJ66+J8uachMyrPhsDcR0NKs+0TGw5XP2ydjhd61xY84N1mzQUdyBsF25lOrH0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928779; c=relaxed/simple;
	bh=t+vSCHW8sXankiqKU0KBJsHXgvrd1DectD2FhYEqlNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AeQv6IhLU1le4fZHB3rl7Plqa2mgeke0cZ2gqU+DpVlAte1AFycAVciLHJaapxW3lmrK51lnOeolDUPuSUrAGzGCZAM1CwD5lpSxrpPtmXUI8hjXMIftlPdcq/nycktaxvnrInVCiydwJ80d/INHB2Xc8IPo78W8PXkTpxVID6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ills+6fq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ills+6fq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36524e2c5dfso1861297a91.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928777; x=1778533577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqMpkiDL5DK8PRDUUfeCWvxInuXlDLXwweDPX2/AgM=;
        b=Ills+6fqXtP2x4NrQJNgHEXv72pgDxqQ1XDWEcYKysIX9wh3s1vkQZom1OjFtV7A2h
         POK8ybLbpGdmcOujQsVcGQojlt6mYkUbzHegCgdbSth38n1Xqlxz7DkiHWTe6qRxvKcV
         +hOqe1k20h8TKBVBqfTL7KJvY7bLGVv37z7QRllSmbbZjnVWRsqFs2nV5X2+NZ3Z7EX1
         dnGKQ+fzwqWO4ybqgswgOszEg5Imge/RXFJt8h3BnVyPPkpcoV4vZVjempnX6/BccHuA
         9lLn+wLosE2+Qe8B6u2kmtloCDiLtREAQT/tb0zRm81Q670hIu6twZIdZfUEZsA5/4CG
         OWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928777; x=1778533577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSqMpkiDL5DK8PRDUUfeCWvxInuXlDLXwweDPX2/AgM=;
        b=fmfy9835ZSjBjG1YEWT//xJdu6Xxmojigf5UtuK3unxryp7Lzp1wLU3/2BGoxlQ7Yw
         qObkTiwUn++ESFHMmvKRBrJhGqj6x+oKFvbd4OYZrkztj61lnO+6ZAkcr78JvumZjPjO
         FsRtEmbNv6PDQrsDk0GUDmnUT7IwkgUZK8ZJL9n7ZWrG06KNArFORegbr3+TPz0cNdA8
         32e7Bfj2DjBuyNDo5y9p69QB/Y/9R+ly6M+lEGYB3apL7+h4tgngc6CxoVnGyFWPenzv
         Yx/VrEwNk7rBO4WwScXCpS7hslwswGA5/hw15jbc8zFAYO/U0bctHe1YpbZ5krpHZ2GJ
         TH3A==
X-Forwarded-Encrypted: i=1; AFNElJ+1vexjpsLGJjTe398cYHuDwQxZFISQ6/xqATWyX/Fk7TfdLY7f/Fylx6xSmShDlto6Mgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIARAJx0dVjwSzCVw+828i/a/dnihUe+7V6mTkm9U17dbmwuD
	Z2I5MM3XY5tyt9/DNuXXbw1EQuDxj+DPn6iI3D4edeqiXLT/Myx1TmnxI8OBuYcEsHB/9k51TMu
	IubE1/A==
X-Received: from plas14.prod.google.com ([2002:a17:903:200e:b0:2ba:1a1e:b2d2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48:b0:35b:a7be:ae47
 with SMTP id 98e67ed59e1d1-365774d3253mr527355a91.21.1777928777100; Mon, 04
 May 2026 14:06:17 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:50 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-4-kuniyu@google.com>
Subject: [PATCH v2 bpf 3/6] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
IPPROTO_TCP, but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

In this case, it would NOT be valid to call sk_is_mptcp() which will
assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
tcp_sk(sk)->is_mptcp.

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v1: https://lore.kernel.org/mptcp/20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org/
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a16672b94e2..4cc16cbeb328 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -14,7 +14,7 @@
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
 		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
 
 	return NULL;
-- 
2.54.0.545.g6539524ca2-goog

