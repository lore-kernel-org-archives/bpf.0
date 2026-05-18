Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5C3E92B7
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092680; cv=none; b=pPTJXrAWD9AXZN8Yuth0WxSvTYQG/4GGY6IuS1cxF+AaS41GRLdzxDlwynF5NFC4x1jIBFcmZqnOB7nZ0ZLxvxXLNVrrFH9jOxrQQ2wdaBcpslnTXi43HVmVXxJtZiWKqd4izymbcmHwAmsHgDZpys0cLm7RXbM95YkPIV+0v94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092680; c=relaxed/simple;
	bh=Jkc6LVVtFSgsvJtOAuT2zcOAGRr/hkZce5UzLzUwX+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7vducNSldIrjvDRwW1921J/Uk6sBnrdC8TcevKGnkaUdh+eBsB20Out+4YFZpmohB6Q4S4hPeyzGX1p/I0t3p+0j00W16M/vne9CphSL6c7EaiPC5jJNAj8d+xRPO24ATFhQj3pe6ly1hz3cSDPfawffKa9ozwcREA1vNM0gK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpy7W49k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpy7W49k"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36643b96b99so1876436a91.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092678; x=1779697478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Piiu4CLk9tYF8O+ZNuJG88LykfnzhUDaL0nTx5+fqDc=;
        b=Fpy7W49khIzzfiDJuWu5ot+AycQkJqbFJmp+bfAawleOYIoTaSKfEc3uSs4gssKOAJ
         m4tQnrBL+xn1LPocWYw2ooVIujWRtuTN7SDUUEd81LoXe1gWWfTSgP5C9gbwxP74hTDI
         FDqzuMSvUp01mjkePv1gmDoPkW4HEo1kMu+aGOqgV5gpZLRha58FgLB+ln+Hnu2LV0ae
         WaAciPsxHFj8gL2h3qbQV0cAYkv/1/vUmGvKQdaBgc8t2K2b9Xjrf1XAO4t0rCpGP12N
         nb80vHNwLDLb217UoS0nr8pAhtcsZZXXOzOCCwr1o0GfXdUd5gHJPDvlTrRhWpaJbFav
         IJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092678; x=1779697478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Piiu4CLk9tYF8O+ZNuJG88LykfnzhUDaL0nTx5+fqDc=;
        b=r+ybnpBbMNZxmPkRAC8FILCTy6N133kOIdjw0thasVHtBUEWGQgyrzBV260wJ05rLB
         Uka8lvxzUzlpNXyCdFEw1i6G9+UeAisjDDi1cI7YCf2BiU4rT/8bIQF+6Q29CXTDxQkI
         9/zjySw3K3r7J2rrYk8D750Ud+2c1k6DaFknnlGggrN7h9MQYnc0QibqEfZvoMdz5yT9
         RMng31cpOirPxevXPQbJy4h27pzVQ6Nug/IvLEiBm1HqPcqkJuJ3zr0/h3UAzZcnF4vH
         e4UO2/LOAcM2seIcJ90xgPUl0F6DPzuC+ISbBhHYm4tLD9nH3LdwUVfmlA11IovMMVy9
         eK9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RLO5+VQgoPTMIOmOvr6uqrY+yEoA9ETc8Q6YQBh4+an6ubC0SsBZy+tA3Y1ip934JYYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdlTnUmJz7d/s/urOtoOnyE24xofi4lfuaHW0neZUEhHOZAKB
	t66CYd0V52QKFoaa1DGb12QOdF7aP7ddaXbC+MeGM0m8zKkpdGtX8Jm4
X-Gm-Gg: Acq92OEU65JZJmiL++XvtnS3BSEiuzAfg2VhAeNT5YrG2MpjeJrqxUjF7n3jt8ESiGr
	GivIWnm1MfOPbtiaa+BhyASF25ATv6lMpD3Db1/qHQELSk8QnH24qhBXXyaI/MfaFP0q6uIyVTE
	3D3pcFar6M90F48WFBDnk+xFjjnOdwffEtWIZbjPZhKAtSnSxwh64nXN10DY2na1jeFR3CobvfP
	YXJr94VHUz8H4oQTHwqpfDCrbrpbXiigg1uC9giEJcrun1NGiNyeO6TVQ4URqlHURt2F0Di0zXm
	h3wc/rw+jc4EjhOF3jcn+gdM2h7jWcMHB7ACyFd7/NKLdnhD4xjOhXWAQEgr8CR5/wXOd/fiKwo
	BVIa7zrDnkcm1aK3KsSB+6n/D34uGV4yw7xzs7mWsrgbfxY6TLyZWCv4wsZUCPxMoYvRANQl2E5
	+b5W7l7Rp6A7mUkeg7E7Jxel4WGvM0r2pl7G1h36lsGf3v8tAf/HF/A8R/UNQyqpzVDdbH++EMj
	teKVGa7mfaDquAZ5sJMhbhBdI6f3QxeKVSPXs3c
X-Received: by 2002:a17:90b:58cb:b0:368:ea0c:1b75 with SMTP id 98e67ed59e1d1-369519cdf58mr13816301a91.6.1779092678357;
        Mon, 18 May 2026 01:24:38 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:37 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
Date: Mon, 18 May 2026 16:23:43 +0800
Message-Id: <20260518082344.96647-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add two if statements to accurately isolate bpf timestamping and so
timestamping. They can work respectively.

As to so_timestamping, only add a loose condition via report flags
to avoid duplicate strict checks that is done in tcp_recv_timestamp()
and performance impact. If the loose condition is hit,
tcp_recv_timestamp() is able to handle the exact case and doesn't
hamper the existing timestamping feature.

Make it work in TCP protocol.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 21ece4c71612..64c69bb3578a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 	release_sock(sk);
 
 	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
-		if (cmsg_flags & TCP_CMSG_TS)
-			tcp_recv_timestamp(msg, sk, &tss);
+		if (cmsg_flags & TCP_CMSG_TS) {
+			u32 tsflags = READ_ONCE(sk->sk_tsflags);
+
+			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
+				bpf_skops_rx_timestamping(sk, &tss,
+							  BPF_SOCK_OPS_TSTAMP_RCV_CB);
+			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
+			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
+			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
+				tcp_recv_timestamp(msg, sk, &tss);
+		}
 		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
 			msg->msg_inq = tcp_inq_hint(sk);
 			if (cmsg_flags & TCP_CMSG_INQ)
-- 
2.43.7

