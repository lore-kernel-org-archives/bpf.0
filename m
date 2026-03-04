Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A563A872B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622930; cv=none; b=cyut5YtHVQ6lLGWy7zfvBV6K562fhtPk0ZwhuCWAzfvMtzxSHckzlGZ/8S8eKIXYmFlKEJUTfaotyrd5DWM4vIdS2W/hNbZJ4bUfp/TeQ4BOYviGx1RwOhe2TkYRa8s4b77NN3yDPJwIXes/Y5AA6iYqSE//yTPh/+W7X2+zIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622930; c=relaxed/simple;
	bh=Fm9MITMvzrN1bUK+Cme/hMncR+Mx97/eQMgmDiY3OnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnYeLOvsxrWD932BfcKnpCdd8HP+TRNq/jnEjEz/d9e/YqZdawBsQCnO36GpSWFsNV3nIpodtOuo7KzIeQ/FIltsXiq980z1f+oW9ddsPDq1zjFncnzvfNyL6ToiPOFKEGnQaH57UR79EFxP+8sQyvFKj8Y7TNDMLwWLH3CevUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJP51iPG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJP51iPG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab46931cf1so49567455ad.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772622928; x=1773227728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=IJP51iPGjup+j/RGhv+o6t42qfu8tehPxMqi1B2EJ9w65puYXEZ3RozxehdAx61+z8
         EcuMbbIPDgUJIy8ez6gaO3EuSEDA/Sqa+UhNC+DbIh6q0m1Rilj83NYNADMN6z8hI2+1
         r5axXNN3TRtY8hX+uVoF8VJuwNupY9S0v0RdNrvkX7PNBk450TOUhzAUhGcwx22jAaLm
         R2fFGENWHr9B7Bi1Ear2xECBMBp1y1YR0zNjoPr41zJsQ4gP4eCEzOtTaVoZZ7ZwvLro
         fpDklSkafcdmaM3nw6dSkG+BLmYK5cYGYXQRSj4Cm9qx2bKjuPo/Zz4/qWRXBrquZ/NT
         qPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772622928; x=1773227728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N0PSv0aNw5FsNqlrwbndBAJxWxb/es8/Rr+uh7lYSE=;
        b=VJzS2BVOwYYV543GAIFN6Pjb/WwZtscJdRemjPub2p8l5Dtb42t9NK3dGOcmY8zWCx
         05oHN63yHVuChas9681wrebgq09tnctzSgh3HkWyszn52Z0PHx3vpzDj54Itn0XQWUMc
         F9ki2GyePntIEQfrzJjplufyi0cqnVhIwDWo1zUgi8VeiEiO1NKS4ZQMVhCa8A/9HsYD
         v51ROzACSHE7tMOxg3hOy2wQLJixv0mXt80xEgOeOzedD3LfeBDq96tne4dIncaYDbGU
         qZpmsm86URK9v/saaPgZQXZDn0ICuOuYi861oapXTGYBQLBs55sa4x7bcU0sM4IN36In
         lPjg==
X-Forwarded-Encrypted: i=1; AJvYcCVrYHwDFoJ01ZiSiuBaX/gTH8f4FgekTXe/h2RahSI75ppryTa+VxTOvsoAh0bZ+M45jgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt91ARGyT4OSn8c0RsD9u+WjiZCNkxWB/e0TYDb7v1Lt9G3Yoi
	BML3/asLr6k3+Yx+5rt9Qq7uQEnXnCLwNHO0LiCOEDr/vkJ5mgRjuKLv
X-Gm-Gg: ATEYQzyGLJvV24mb9cC/rAAaZ7OPmE7pt1AaTQjX7u0FSSR3xo7fiHCs7bpxKH0csiU
	DggVcIqxsu3+PFVEknkyr3pW6Ubiz2OggHeTgxG1Pl1R9lqALymvDXSgWRVOyO2aBRTFU/hgsQh
	pKtLCLCKRdeg2z/4o2EIrqUMsX5qpTRv7zAQyVvTJ6QPWKafDoOwL+fML64dbzezgcd0xsFE/cl
	w9Nus080ZhqCMzhE5ftLA6CvnM/ryC2YJYQv7JSdQmiNaFFkxe46xvysMo9Rfru0mt3X/I+OnMW
	UNye0TstFgHlQwV1vYAt4fYS92Ab/UGchrNEpVDZW7zqe5IG+BFCnBVaBC3tfJjAOZB59JQkSfa
	3nPQO3eUNN7FUdHujg4UAvzjlMAX0hS7fB7VWiLMsTqZtZaPoW0F6JPUWjBCONkLGW0H7EH6sBB
	YTAtEmscFQqIagpdNnL/cJs+k0BPDlmRSc5HGRbVDMpjV2JXXDd3/xHdJGd/uVJXoly9xS3cYSQ
	3LCqP/VIhOr
X-Received: by 2002:a17:902:ce0a:b0:2ad:b213:feba with SMTP id d9443c01a7336-2ae6adcbc04mr14171985ad.5.1772622928153;
        Wed, 04 Mar 2026 03:15:28 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4651e409sm127226495ad.44.2026.03.04.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:15:27 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 20:15:17 +0900
Message-Id: <20260304111517.2088694-1-kmta1236@gmail.com>
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

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
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
