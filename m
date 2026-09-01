Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2E32E7F20
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251616; cv=none; b=b9DCLojAo1YM1yWqJZxoS1dS6jqCOItYpB8afCnotfMGw07fTb4HfwyhF2JBYWDw1BAzT5v+SIZ1sHDBG55BKfVWokhAhDx23oje+a0HsYutXLrmmSFVDcDhkY+q4JRRnVx++LkfL/6P0/iIrqpZveg+XHomJM3cxIe9cY96IGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251616; c=relaxed/simple;
	bh=7KCYYPGqpmRxNWWjzwtBvJRWE67e0WRdOEM93VIEuxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GC+MMi3NqSjCRX4cmzXPpmCgHJKasOIM7cmC0/7c53JE8DJd3xjZAlXgGJLJnUrwxOvlcKNr9/uFMVM41zJqKD167Sms3uAhhAx+uzh5tV594BqhAcQrJzTVVvYQRgDFbbLvWfUzmUKqSqpb1UG6xcF9EuCQFLcmc757dRRw1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4c/caT2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4c/caT2"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1ceadbd16so4917765a12.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788251614; x=1788856414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RiEALvjPEuEOIdvB+bOx1YYVXmJ76RxpCYaG+WNrEhY=;
        b=i4c/caT2K76RYYa7eZrrFF9ML6TNI4T6HsJXHyR5bvnQ98ts0x91T4hmL9mByrHVuF
         O0V67Vw0suxmq3fRmfD9SGju8QiSZ9K1BHCwFRht7z/2lpufpm+VophS/n5L4vDPAyq6
         jeJ9MadyFRJ5tfWKAJnsISr6y5m6T+TF1zV6hi/XD4Wfzqm4KgmUZKnGxds+RT9SVJ6m
         PJ1WFr8rgaf6bMOWW11I6P77w/LRqEDzRzgMTPLMJYemzP6PuDwQPs3A32+TtruWVsfB
         foG820/5cUavaU6Vy8r+YBUZ/yoLsRQUg5zjxUOksStyTx3DeSZhrhJaO91OIRloHmId
         uxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251614; x=1788856414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RiEALvjPEuEOIdvB+bOx1YYVXmJ76RxpCYaG+WNrEhY=;
        b=gveSxGpg8a7u6hA4grUNZxCTtY62j3nASh7GdozU2IwOrZ3JSwa1jw4e7Z7+7S/TT1
         6foQSmfGOpoR3G2B38a3pp62rw2R8BhdmYPs7c0jZlT48R7//9P45AZraPV9FSV7VAk2
         +bPcuHHQzTzrqZeYLzp2uYn/bF0QmgsZb/IndIwexNlHemBUI6zsW/eGOO7RZmmCKe/O
         SFO/8/534a/qOma1cZkwWyVfKsnMz7FHkTB8JoGggGnKExyadFwi2KTFXvo5fZFujmbK
         Lang9dI1SxJwU4975sBTn6MIfxVb/6I5h5YAQpchYMRMGUHqcfFcSZ4plWWtZskw4yKY
         Q72w==
X-Gm-Message-State: AFuF++kesDMisSo6jpA8DSf3y6wprxy9hXhwCCZWlDyVhvirtosbWIoC
	wky2XzALUxY//kbHrdM3h08+74C9xMyrYt72d8hXAvuB+cizzM9m9cxF
X-Gm-Gg: AYBFou1c0TOviDW+JESlWabHqt+0SaPla5UaOa9FqWQP2K8zCXaexORQn0OE0eTxwV9
	D3jJvuHgvxiUWwNO6srSF6SPcSs6sYtloOBHBSHy/x9ZSdmf2Rc2YZiahhw/GP/FKCXqXwHq5WB
	6tjojDLdinvI9UIPchdbhdIGJPuUzVe8Wz0QisDuOw5QwA54olaQAZyWKQMckpHhmiYjNNjJbc/
	GG1XATMXEP77D9j4vOlqAt3zN5kq5qFwaRg+h8gHg5A4PM5vpezjP39wFJEO8z7awlV+lilknG2
	3cGq3SbG6fdOeazBYo6UQDjikcsXVXCNniVy8LZjGMRlWXVr8ih7L8cPOzJEbGNgZRTUoZ6GYVg
	I093H/0dNpFug+kBtV9Zu2h6ShdBpi9zwAcrXi6OQDaQwGYIn1aCh82y5zM3B6Zte9CgGoe6LA4
	Pf+i515gPuYAaWDX7wfaCjkgIHbWoLQXiAREO3Reki1rxsLYuSOLMP10gEmMDVKU2/dM2Wx3OcH
	UXrMOeja5vGha1AGN1jwITAB+sWeD2U3b6HUis9Nk0McZEuYX9W+WkogP4ZY8jcZ/y/mJhbfaWS
	HmBUudWhd/9zHBdNwc/1dC9UE7w6geComW4VRrVkQiG5NCeIHA==
X-Received: by 2002:a17:90b:530c:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-396d0d4c43amr50193467a91.3.1788251614426;
        Tue, 01 Sep 2026 01:33:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm4656501a91.11.2026.09.01.01.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:33:33 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: [PATCH net v2] xsk: set network header on skb at generic transmit
Date: Tue,  1 Sep 2026 16:33:25 +0800
Message-Id: <20260901083325.3445-1-kerneljasonxing@gmail.com>
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

Reset the network header so skb_network_offset() is valid (0). Note this
anchors it at the start of the frame (L2 for an ethernet device), which
is the same convention AF_PACKET uses on TX. Unlike AF_PACKET, AF_XDP
does not need to locate the real L2/L3 boundary or probe the transport
header: an AF_XDP frame is always a complete, opaque L2 blob from
userspace. AF_PACKET only cares about the boundary because it can cook an
L2 header itself (SOCK_DGRAM) and supports GSO/checksum offload; none of
that applies here, where the frame is sent as-is via __dev_direct_xmit().
So resetting the network header is enough to restore the invariant and
avoid the crash.

Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V2
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
1. add more clarification about why we don't probe the header like packet at
the end of the commit message (Jakub)
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

