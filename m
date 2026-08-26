Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7922B594
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707263; cv=none; b=hnqwAb+aKohCOB9wm1EbPlZaGqCHYxpXssHIEVfxXIofG3lx9s8WXN9YE3ux7zSmD+j686Bzyg8ZhxEmMywUIXnhEf1+cslUzASQnX0OIVVycg/wyCxweaFoKTwWwjDN1S4Dfki+ANn4vN6xLx5+PbhC18evgEyBTGW9IOh4Tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707263; c=relaxed/simple;
	bh=bz61J4YOFg11l1sMxw5vCXVYmj4NA/d7KtZsdIpszek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ie1784ZCOx6t3u4+vqsCWGL+nIuI6xeQ7g7r4S9pISEpdF8XU05KstQdThMEfmo8cS+kUe1JdhlGd3XyiGJcWAbCmAJPH5W0N3xpOUuX/icjkf4gXXmpkqqQQU0P1YUMMjz1prSnOmLPK2n0FMTIZQ4TraTKLKqxJHCE+zviAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEOG/ZRM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEOG/ZRM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-395cf2535acso515037a91.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707262; x=1788312062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ahNP6I/2SnsCaDqpAftcnvuu1z4RoYXIL+nfdxKNNk=;
        b=XEOG/ZRMGKzs+he1BZ4lTAb0qnbJBC1uscvRpc2EXZpImyICAouiWNugJMXuNPpHZP
         SZiIyFwCc1D154R9FeWPKI8UgcXAv/UCM8qPQmZTF4x9Q0ouRkaUx4FJzjflncb2p8jI
         IEeeDRR2dJy+wsmtP3G3ujoTtH0KdThA0fS9DvQJpqafURauGuIqsbw5BjQXrjo0rpRi
         u6TZx1dNqe1zApNFc820xWZSD1hoAdAGBi1NHGh2Ibs+vqnC5ypM1UBM/l4uW6rzvS/H
         KyA/ER+BqdY3RMhHAoAZYuMfrOvbMy3AUKDF2Z1nO7fc7f9gf+ta9Mevhnz+bc7K620V
         OoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707262; x=1788312062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ahNP6I/2SnsCaDqpAftcnvuu1z4RoYXIL+nfdxKNNk=;
        b=FpgS49uMH6hRR7MqztE7CuRtj93LTc9H9U4kziWz9uGYm+BaQVndNxbIoi7J5MzdNi
         e9aDhiacs7qpwEoDbedaFna9BB9UPWrIRM0vMe0gkXVZzfHjsEvLnKPIGAI9EKKYEFha
         F4DjVUrHlJ8V9wU4KOdg5oCWeRNGLHvKEo2zvkYv70k6Zi8+O4fYQYfc4VDtkyVW6Cwz
         B41nUItKiym6q+ZbJBkHOYC0ok7vLf2b9Sm+yWGXFZOfelVs9qcaJazK6ggPPquoCLmG
         c/l0lOkMmV4+/ScruYN8KTyJHqkjVLd9bBhuTrbO0+LEpqL4E15ghF7ZXFLh9MAx4YQq
         rDsQ==
X-Gm-Message-State: AFuF++muLQU5Vc1cKDVzIaZb+6m/T9EGnvL7Ka9S3kgvLMWw+3PASTpL
	MBFbv/WGbf11ci/02fkiiYGAD5E1tc/A6ER2Cazwi1tqjQlKVZtZ4oO5
X-Gm-Gg: AR+sD10cETphI9jmF1P3lHtFx56oAkTa6lRWZ++4hDFW4r9kthivCeRfEOK/Y1fCD0f
	ZyDiZBwFROs3RIdel/l/2ZwaReaHM+Cx0eyFJFRwLrFyQeB7PIklU6c/jfPCUjzK7KFmocfZ6HY
	ySKs8aWVqM4hQ71Qiw2xrbtP8AEsqlppLqg8HoKPQpGL139GUhZ3SpZD3rzSeqhrTEr4fmjkEXs
	AaxVqNe45s8ka9qytAYj4CoKFaVMhOyfQ9IaP/enuKA1jU90m71Z/DQOFKPzSMCji6Xey9NWrTh
	E8lDAHHs6HSK9iBcdhzsY9Kaan8P7V/FaZUW7RMiFuyKrfDGtSrJ1FOMJ6WdnnttoeRLpTdWykZ
	JmeX/QQNF0UXCYmTsg1kSoBdRkAriLU6b0x4WIU4/MFZgfHlTBCfwrL9e2padTId4Wr14bpJPmr
	+MHE4HiBKHTCPcvi/+AE14l9jU+8er77SiUEGNuW4s1azE6QypZs4PClDFZdBiCYivA7ckEA8wQ
	4vB09h5+KZeVZp72MUts6krjOkdL0w7XaGKSGd/4RamUCg2sGZZyu8TCcaVArrLCmREkg0Wqkts
	X2puw7C6uWI6KGn0NlfNQgj93b0rT/QCZ67Bedo=
X-Received: by 2002:a17:90a:d407:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3966d8528c7mr3397729a91.7.1787707261638;
        Tue, 25 Aug 2026 18:21:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.38.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39662c80d6csm2795631a91.1.2026.08.25.18.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:21:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: [PATCH net] xsk: set network header on skb at generic transmit
Date: Wed, 26 Aug 2026 09:20:52 +0800
Message-Id: <20260826012052.51028-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When constructing an skb in the XSK generic transmit path, neither
xsk_build_skb() nor xsk_build_skb_zerocopy() calls
skb_reset_network_header(). After __finalize_skb_around(), the
network_header offset defaults to 0 (pointing to skb->head). The
subsequent skb_reserve(skb, hr) moves skb->data forward by hr bytes,
but leaves network_header still at 0. This makes skb_network_offset()
return a negative value (-hr).

When such an skb reaches a tunnel driver like ipgre_xmit(), the call
chain pskb_inet_may_pull() -> pskb_network_may_pull_reason() computes:

    pskb_may_pull_reason(skb, skb_network_offset(skb) + nhlen)

The negative int from skb_network_offset() is implicitly promoted to
unsigned int, wrapping around to a huge value. This triggers the
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason().

Call trace from syzkaller:
  ipgre_xmit+0x958/0xcd0 net/ipv4/ip_gre.c:658
  __netdev_start_xmit include/linux/netdevice.h:5400
  netdev_start_xmit include/linux/netdevice.h:5409
  __dev_direct_xmit+0x4b6/0x730 net/core/dev.c:4942
  __xsk_generic_xmit net/xdp/xsk.c:1079
  xsk_generic_xmit+0x277a/0x40a0 net/xdp/xsk.c:1120

Fix this by calling skb_reset_network_header() in the common path to
cover both the copy and the zerocopy cases, so that network_header
points at skb->data and skb_network_offset() returns 0.

Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..2077bb6299ca 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 {
 	int err;
 
+	skb_reset_network_header(skb);
+
 	err = xsk_skb_destructor_set_addr(skb, addr);
 	if (unlikely(err))
 		return err;
-- 
2.43.5

