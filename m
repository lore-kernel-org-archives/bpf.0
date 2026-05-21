Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698913E9286
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371629; cv=none; b=PwReCHcUOHUqV97hxs5uD8gEq5y/tFKWXV/CsjI+0Q26UQNKMpwjr2vE7OUUfkUXm3+wezfcNXMlTyBRLCqMa68aLeWFyO68fcI2lnQ+o8k3PFdrc13jZwVvM+2Efrjduv6VKVdEuxY04TcOxhkO/NvF+YR+qW09GRIa1fV4ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371629; c=relaxed/simple;
	bh=sPvR+qunGDGOG6xiEtGhN6/caa7iP7K0rRsIBTE3Hac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0Xc9c9tM7xsXrnSmZez9DKRRpRZl3JMxwFPoC62JPmpa/G0sxTxDXWFPo/lili5c4GwykGGrlbkdIRMcVS5xZg96e1NFT1bVxPWGf/5XvJJTsfHrBh06faMpC4pi2N6gSZ8ErLAq6n/eCkaYBwBbuJgUmEDaITJskam1qM+ZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8VrGpVH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8VrGpVH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c827313dac0so3261741a12.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371628; x=1779976428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYYe6B1gyz3MHLfiW9GccKcqGYxd6tgMsc5Vb+al0Fg=;
        b=p8VrGpVH1iE5ze+XGWF5KZhNA4/bZJ40oYT2/ENt4/3YoTgoZY8Z0Azb/Jl1OF+yBz
         mUkkF4M3Msvoxjxwwa5UA4nKgvhxlgnAs8bPbC2mz7Ue67zSRmBmLUFwkQOoN8AhvOzA
         kdT5pWdWX7XCKSdrNP69sMJvROaQZWTNVcfRjIfJXwvWvnAK3N49MKyf/Ust/WfRZmK3
         ojB/n70PJDAwguXVplVTfA0N+SwzxkTI9NM04AvV2A8itX/PrTeLSZ+2+qVv1ms73295
         YrCvKiBsylC0tOF+K1I3ytxpTM42ZISiRrTbj4RODdAEgwxNxZ5+tk7UA4ITulWAd8Pr
         I71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371628; x=1779976428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYYe6B1gyz3MHLfiW9GccKcqGYxd6tgMsc5Vb+al0Fg=;
        b=XWFe9T7CTwEfPnggni+D5eRGGc2NiZGeuO2BCTee+PEzLTX7Im6+gXywUfQ5Ed9msn
         oDHt+bM7wGU0J9ss9viuDucdQuDIMFZSw+VCmP3hvwOk+cwnxgKvGJhdChbz7Mzz5ofr
         0LKkaNst7hna1R37q4uX4RfX+xL3cioHBvOQMAHeu83oQI8F5eHDLi7M81yrTIS4ZLGb
         D7nHxsMBhe3kVYBM/0MfEGEdzbPO5xNe7HntQHaRBjCrkKlYpLFmh3FVr1Y35KJ6vtzk
         r2GGW3t/B9AJT+VLpKFJNa3JO3uWp4GZcL6CQ7WeVrimOhcLZzbYiJ+ad34qBdBqlW1f
         1hYg==
X-Forwarded-Encrypted: i=1; AFNElJ/X9Xwk3/Qvx6F5BmY+B5OEjMxe0jR2FD8380QsebvjAQzu0c1bnzIPDcZe64bnf5RYvkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1x3QE5ocsQ1hhbfp1FzyQx3lu5PvFNsnDvC2j88Dm1ERSS9B
	X/nCARpR6P2zRE1edHpJmM7UWpZ6wkxjkNrzGf8q4Bbn4laGaGYJJExo
X-Gm-Gg: Acq92OHGAn9LzUTusqj0J48QYr3+qYOPMiw9Pj7wL97DtLDM+BeWRNQ6TNJdAMQVuCx
	tjtsKOeTjCylO/YTo7wHYYI5R6M+QfEdcqdK8i82+25E/xOkAQ+e4DaRg90aMd1CrRuxpO2Tx3T
	2FUJQNfwzPtgQyOpP/VvTaeiB7th8xFMg6j7eMNE3WsljFmqU7wy+a7o1ClqGlFYONza/FIBwI5
	pCpjki59LB/PiqxV2m31dvUH8Q4Z/5m3JsW1548xpc2ZiWl+JFxJZw5YOki26wFrKfEkDu6XTnZ
	I2yPN9zkzzNDKOApdWewKJQhWKJsOPtzBu3f2aJijQkt0U4u5xLhoTy+g0dm00tpe1yCAalsc7O
	zYon6hoohmRxo9i1EnzRwO53nYr6iK/FicQTBpaxy1jEHR/CnqoeNjz2srKWYSzv46DenAF6bqW
	Ini0vgSF1m/b7VCCdbRVuXW6N6Ct8+FRgAufSTz6Vplzc2zp87Mye/JguUOLUMrX1KOpG7T88sJ
	PdPmABsQM4Rwon2muz2b6yVL6r3GA0iLPFdRQ3hVw==
X-Received: by 2002:a17:903:2f90:b0:2b9:6cde:c34b with SMTP id d9443c01a7336-2bea229bfc6mr30322615ad.15.1779371627790;
        Thu, 21 May 2026 06:53:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
Date: Thu, 21 May 2026 21:52:43 +0800
Message-Id: <20260521135244.40869-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
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
 net/ipv4/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 21ece4c71612..7ad3561dc8cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
+		bpf_skops_rx_timestamping((struct sock *)sk, tss,
+					  BPF_SOCK_OPS_TSTAMP_RCV_CB);
+
+	if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
+	    !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	    !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
+		return;
+
 	if (tss->ts[0]) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			struct timespec64 tv = ktime_to_timespec64(tss->ts[0]);
-- 
2.43.7

