Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A9360ED0
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828764; cv=none; b=GY5g7LiThivQn54rxDQGD9kLUNXE0t+UVNqAWDdDSYIt3229g4rI4F5zqgvrZ6x3BwqyW4VfulE1vj55E1xQk/i9yyey7J8aSVI0FD887XvpO5wFexxaUudPT9GdcaEtBAdmPLFlyCOLucCaDW11dcN14kSNevlT9dU8+5nDyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828764; c=relaxed/simple;
	bh=fJBMH8Re+/a16XyKoiWBtEsZHUm8WhS66cGNkTbvaPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7FHZg8EbPD97brV3a/uodQ1tHkNHWnC9wSa2HokIQtGGQ4fe4bm54X8UcoDcijWygXnVDQwugMAoSk8vjFOS6dfmfjrr96le3e7y35iedkgTPOxHN20Xel/otg0D+x/hgGRDmjb4xOPKzjqCocZ5uJkr18d7YvStsL3ZQz4UEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng8zHRCv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng8zHRCv"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ec6188so10366405ad.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828762; x=1790433562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcD+pc+bKsA4kDM/VVw0TR0Jxvkmi9JTw/C66cTZkm0=;
        b=Ng8zHRCvXiwJGBhXWD+XhulEC1HzxWFDkUDCZCnbyNGdKr19LQ44Q5UcdXyBi6JSKR
         UnxX4SgmvHh46XJq9VSnuwf6e9mXZYNEo6aWkexvjXJ7UdAhaTNgjXbgLl86dVFw5l+R
         wqBkALpUV1c4Ge+ajNVNAPYjdDD8ooUymnxVYEgrXv33W2XNioBLNI6PtFUhOs8jjvJE
         fxkjzXbhfFqbVQ7RUGjNTsjLILbMCer1Xs4X8fTHUFgnA3zoEYcUaP/aFTH+eKzQmSH4
         gzpEAxNTlj/Dc55t7yQ2xjcIJ1xm6noCCdykxeOY9m/zj35S/yFzT4LFeQ1R5DU/fTKG
         umlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828762; x=1790433562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lcD+pc+bKsA4kDM/VVw0TR0Jxvkmi9JTw/C66cTZkm0=;
        b=IUq8/RhWYVF9k1D+pMCgOyqcAHuhqfTlDD9FRTGm0FBdWJVIkyJF9GD/TNSlYHbTVv
         IoE+bmpD3CxxYCfBLle3FJRPm8cS9rX+irg/nGzmlXSZlEUgyHBbNpaFCexj83f1B9BX
         w/6mJZmNgXPEBjWeSeiPHqk+7tRVnsbd/Nh2vPGA2nL+dMRlSh2bTh+B1vkHf7opqIPa
         TkbT4ossGswHCTd8DkGGnmzkoxbWaqZkKeKhZCcKHxBDXrcTyyRBFFXQr9F2b+bY49s7
         8dgQ3WISKsnM35fA6fmi1iylDBzYguSyVIpM6ehyF1qbqgT3+6GSgp/Cuq+DNDauTli0
         1QXA==
X-Forwarded-Encrypted: i=1; AKwUvBxEIA6Omi/zLWgrGK/IxwqjeJgva2sdnBr9bPhpaR4B2YToli3Q7hl3bPZv8XmgJycGPx8=@vger.kernel.org
X-Gm-Message-State: AFuF++ks/MOURn//1V+04Vz0NOZfVii6enJ4DrZsZ/UYFKUirCRTukip
	Zb8RqVFLBMisA5l080UJg5a/VUiNXH9hUHvlAjDzU8oLKpRK4vVXR8az
X-Gm-Gg: AYBFou1IE0fGhNWA+C7PLFfdRszDKpGYALcgReF2eRuS4O1MAQWP4xZQlNR9YeZMTr6
	alCGNmGaU+zRJmDVSbQKbvdWZ/b/KaEYiwiidW17HmagcL1U1daje03GMyuQAZSkSjNC1UjotBt
	dEfol5cLB4NsStwvzf8OcBqCfJdqiNIEUkZD+W0wZVMcaVNdc74lz0ns54ZGXrmysmfbtCROFai
	i8Ax8L8tFHjanSMkXsEJY0tiAuUdRMSYh+yJARKy2qDgDoEC7S4ovOK9yaeJlwY36Y3Khqu9q8M
	9j2aVamn7CEhrSIqcHe+Tirn0jfFKeeUnKwI/noswsQ+i473muH716ZJ/QxrwfTzSUiqTCmUora
	co6SCb0SpIC9+1BiFvY/KKssUEXAibzxZd4vaCJMTaqSreS33oE6qX8cV2IpDlWPHLjF/HrIO+z
	m0GtVLEZT3K0PS+4qbAEeiO9gLZGYfg0ZPSwHHd64+IiVhVZ/8BTymyYyhRDgozpGnw6likaxo0
	2XdlciInUWm1W41iWBejaNY1g8kf3SiwuLxpT2YiN7e/AvOlIyUfPj21NxuAQ1hPNTkXqQ9uRGd
	SjiQV3YYKvJNmOmZK8eX1ewvRheaDynBqxDUPCQyXKaJt6vW9jZXcbJJCU0uEo48hc6W7Q==
X-Received: by 2002:a17:902:db0b:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2ddb16d5a08mr102422195ad.0.1789828762015;
        Sat, 19 Sep 2026 07:39:22 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 9/9] tcp: handle the start time of each split skb in the tx path
Date: Sat, 19 Sep 2026 22:37:32 +0800
Message-Id: <20260919143732.11772-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Segmentation and collapsing create or reuse skbs with a fresh
shared_info, which would otherwise drop the start time recorded
on the original skb.

Handle every TCP path that manipulates the shared hwtstamps:

  - tcp_gso_segment(): handle the gso case. Propagate the same
    gso_skb's start time to every resulting segment.

  - tcp_fragment/tso_fragment(): handle the tso/recovery.. cases.
    Copy the start time onto the second half of the split so both
    fragments keep it.

  - tcp_skb_collapse_tstamp(): handle collapse case. Copy the eaten
    skb's start time onto the survivor.

  - __tcp_retransmit_skb(): handle retrans case - the retransmit
    path __tcp_retransmit_skb->__pskb_copy.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
rx path logic: https://lore.kernel.org/all/20260917132742.87117-1-kerneljasonxing@gmail.com/
---
 include/linux/skbuff.h | 6 ++++++
 net/ipv4/tcp_offload.c | 3 +++
 net/ipv4/tcp_output.c  | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c5347be72ff9..5f01239af191 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5491,6 +5491,12 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 #endif
 }
 
+static inline void skb_copy_start_time(struct sk_buff *dst, struct sk_buff *src)
+{
+	if (static_branch_unlikely(&bpfts_v2_needed_key))
+		skb_hwtstamps(dst)->start_time = skb_hwtstamps(src)->start_time;
+}
+
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize);
 
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 3b1fdcd3cb29..3b33e9f4fbc9 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -201,6 +201,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
 		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
+	skb_copy_start_time(segs, gso_skb);
+
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
 	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
@@ -226,6 +228,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 		th->seq = htonl(seq);
 
 		th->cwr &= ecn_cwr_mask;
+		skb_copy_start_time(skb, gso_skb);
 	}
 
 	/* Following permits TCP Small Queues to work well with GSO :
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6f4dca4a4de9..006157321f49 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1900,6 +1900,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 	tcp_skb_fragment_eor(skb, buff);
 
 	skb_split(skb, buff, len);
+	skb_copy_start_time(buff, skb);
 
 	skb_set_delivery_time(buff, skb->tstamp, SKB_CLOCK_MONOTONIC);
 	tcp_fragment_tstamp(skb, buff);
@@ -2431,6 +2432,7 @@ static int tso_fragment(struct sock *sk, struct sk_buff *skb, unsigned int len,
 	tcp_skb_fragment_eor(skb, buff);
 
 	skb_split(skb, buff, len);
+	skb_copy_start_time(buff, skb);
 	tcp_fragment_tstamp(skb, buff);
 
 	/* Fix up tso_factor for both original and new SKB.  */
@@ -3445,6 +3447,8 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 		TCP_SKB_CB(skb)->txstamp_ack |=
 			TCP_SKB_CB(next_skb)->txstamp_ack;
 	}
+	if (!skb_hwtstamps(skb)->start_time)
+		skb_copy_start_time(skb, (struct sk_buff *)next_skb);
 }
 
 /* Collapses two adjacent SKB's during retransmission. */
@@ -3661,6 +3665,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			nskb = __pskb_copy(skb, MAX_TCP_HEADER, GFP_ATOMIC);
 			if (nskb) {
 				nskb->dev = NULL;
+				skb_copy_start_time(nskb, skb);
 				err = tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC);
 			} else {
 				err = -ENOBUFS;
-- 
2.43.7

