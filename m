Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31442342CB1
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532289; cv=none; b=tj47vAopjLuHPKG516X30xJ36I/FH5xjG9fnaZiRV27n2oWeK1UAHH0bwXQ3Tnphyspb4yBMM9dh/SVKXIjBTUKuhANP7Wu4Mk3lFal2gK7hzfvB2Cb5d42zmKBSly3+paHfpmfZ6hisc/QJjQHIcPJpxH98tCxsoHOq1ANPPLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532289; c=relaxed/simple;
	bh=j8x8rSyHICY5qcHKtJbgh2Wkn2gcq92t1omfvouCwNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rq3JOwxuecZg/PR2FoTuDTS8BF1JfEjYaj3nHvQKeMTWhINW+mDgg1BC7QGNPkSgRIvrC1n1XUfwNYs1jyOh3g06VLqwj8wleVh/lKMKPhyuGm6/NgcgO5wRLjFF6ORBe0eRjDtWzMR4BFzL3UoV1hlfcgfpQKq9ItJa6QhWTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp3LHtWE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp3LHtWE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae50a33ff8so16140615ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772532287; x=1773137087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfAHCrUtdxDkRhQeZ2MUII7KbpuuMok/pw78xOx4c/E=;
        b=Zp3LHtWEy5JRZlPE3D/tWYPg0dJztNAv2cZuWiNM+sC5ZXdDR3thyjofDAwC8uogeH
         ltlzDBS9Rk9XX2gxJqbUlciYSjDfYsZpfyvIvX3jyQEQszcV6t6vQldfaJi9a04mRGpQ
         g+IqbZtoedBfHGsj6CXHuEphXP0qEQENY8FDQOKIUr6NPbTqi9SlT2utpV9kdFpiIXH7
         Serl/WejCaRVQECECjn1fqAwXV/OWqc93B3j4tNpeMH6qbJx3FIz3Ek1nmuGtaj1hwyX
         2/rKfUqntNQdNHYplhxzLoNQ2H4JrAGMcLjFolrawycNCy58IFT242BZU0VJLRZG5pZO
         NOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532287; x=1773137087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfAHCrUtdxDkRhQeZ2MUII7KbpuuMok/pw78xOx4c/E=;
        b=POU6KL5Dn+I/oY2zMS81zz23Jw1AU0xV5UaHdCilsq4Pnkzr06ibvE+Wyz1H8zdri/
         XHqgM1L1a5tTmFiu3t0kZVkE8hIJK2sIAw51IFFpEaVQcmcG2tr/CsUJii/bpVQdji8S
         lFRUXT4kIvVTdreRhPNm6o4rx0o1ok/EAwjXwuygjL5ywYFIPOsGicWn+PpeZonhdpU5
         uiAUxSvDYXgEb0cG7WqvTPKDxPA7/fqvBRiYcul088ETYxowDntBLlzllUEIqEqYMYie
         I3f903eK0+/rriKqXp7+QEpBTmqYPU/Q8//5aWir99M0H1veC7GVY54UUp/O4bR4Nj2K
         /eJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqyF1cfZlCBdUGaJfumR+J04YY/HlqJ4h5NwWXASXBoqObw0h/lZQU5Z1/3UZ/ZQYT66Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXg0BGHtMQL8ImMSpCqzhsTbg5p3q6qieUoHVqWf0gx5Vs+Vy
	JabTcuyWSQYk0wJPsn83xnJrC7nqI4uwCcrcO3mWofYUxI+HFzCmc6eG
X-Gm-Gg: ATEYQzyyBZx9AJu99cQvEoUrTISpEEVYUGjNDwhJGKPb2Q6unO3gnFP/PLKO+8ZEdNm
	xh/g6cO2gixDpRPMxh+PXovLlQeJ43nr6b7virIHQoCcFa/glbqPzmopgBvS4TdZBJG+IjyKPvu
	ANL5olLyC2/jXr8GJDYQakH5xLguHXIwdmpsTvnIg9xJ8WZrLrgikvIFllN2HJJn+xp5V6vNxhB
	l1DoHhL+qVMgbc+GCToX6UzrX5frg+jAmpaGp8WqK2HpH3t4A5d/AwwAKoKpV7RgqwtIItYdvR1
	RdNjddMUpXMT4ngyYk7GEr+i3o0k3ksuUwFLoaTR6y8RfFeASixU+UEkKPvZMRqQfu6RgaKf19n
	8ZGKtgrxYaN5RVJBmHMkGZiKula8CFWL0HNNKakxHz3R2lqFSvoPqD0rb67eK/f2K9bvV0s09rr
	oxDSVC17nhkdZCCrzieX1aCXngkO3Vn0pxGxMlWWlm/8eYYFK2TZ+Hdj9KUL5JD37VKr5KAK1VU
	gAVoyPhk1y+
X-Received: by 2002:a17:902:c951:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2ae2e3e3e93mr154800025ad.5.1772532287501;
        Tue, 03 Mar 2026 02:04:47 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b5813sm166283095ad.63.2026.03.03.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:04:47 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Tue,  3 Mar 2026 19:04:39 +0900
Message-Id: <20260303100439.3172296-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use struct_group() to group the three fields in tcp_out_options that are
read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
(mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
with a targeted memset of only that group.

struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
CONFIG_MPTCP=y (typical distro config). Every remaining field is either
assigned before first use by tcp_established_options()/tcp_syn_options(),
or gated behind its OPTION_* flag in tcp_options_write(). This memset
runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
bytes to 4 bytes reduces per-packet overhead on the hot path.

Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):

  Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
  After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)

Also add opts->options = 0 at the top of tcp_syn_options(), which
already used |= without a prior clear. tcp_established_options() already
clears opts->options at its top.

Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d..63ee037f46e50 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -429,14 +429,19 @@ static void smc_options_write(__be32 *ptr, u16 *options)
 }
 
 struct tcp_out_options {
+	/* Following group is cleared in __tcp_transmit_skb() */
+	struct_group(cleared,
+		u16 mss;		/* 0 to disable */
+		u8 bpf_opt_len;		/* length of BPF hdr option */
+		u8 num_sack_blocks;	/* number of SACK blocks to include */
+	);
+
+	/* Caution: following fields are not cleared in __tcp_transmit_skb() */
 	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
 	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
 	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
 	u8 hash_size;		/* bytes in hash_location */
-	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
@@ -965,6 +970,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
 	bool timestamps;
 
+	opts->options = 0;
+
 	/* Better than switch (key.type) as it has static branches */
 	if (tcp_key_is_md5(key)) {
 		timestamps = false;
@@ -1549,7 +1556,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 
 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts, 0, sizeof(opts));
+	memset(&opts.cleared, 0, sizeof(opts.cleared));
 
 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {

base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
-- 
2.34.1

