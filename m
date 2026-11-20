Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160399;
	b=TW2NiibpZb9NPUAEJ2nbT16bQFhGygqL6EJ0JIlwAnvAyDgI5MKIWIqI11YqaSNTwH8d
	 5OuJUUmEq/f9g6mOdZc8ouCTSyQtxhiZaUbxKm/81CQ3bG+OquDkhzEOLA7Js4D1vsuUD
	 D5RghctAQQ395xPrK2VTOlID0p866CftPFZOOM70acYG4Gbrkqm4+PuC5kXU2/OZ8nzzQ
	 I9OEcultXD+M4XW5W/Tn+LGDJaL5o9jzlw4Pbes5yDnwZqXmKQFpTuPbhqm2oU0nCs21I
	 UFoa/eWStvfvu1WLppPJxgDzifvTWpFfEQpXoP2QqDe7trrrP7fZMV/+EOuHW8IT3PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
	b=pChOjGV2lVL8T2vrU2Sbt0ekPKjcanWwHIL4POxZb4P+OYRKlPBNp/b6vAhrLjglki5n
	 cYqECqrUK7rSDKVCFFD7mWk9DAyPAs1gqJ4xaCm/Xqq4tqRMCaaPX5IwiW4/u66D6s1Kn
	 ++C4LKzOntNcaBVt8OKR9kZDtbvfcc/p47+7Lw5bCVWI9Z1lKRc7ixr12sXjaD6B+fQ63
	 WHg3vRelO4sB7dfqn57sVJJLjtjtitPCX2d3uxTduZSSrrWsHUWckf6TR3vCn+QEWRwAs
	 EauTW6ystVMo3UGJCOTixB/Dtm5gXFt5zR0+l3bkmelcuZehNhQMsoZr8ny7M9XvK5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RG8t87Z7;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE130606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE130606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RG8t87Z7
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-385d8a00598so426262eec.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160398; x=1795765198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
        b=RG8t87Z7Z4ZkaeUQYwGbRWVes3PlJ9c1jMrnlHUNMrOp0w5G6vi/d7Bd8p0IQm5wwi
         3hTOuQV1/cxn1TULStIq3x6tYI8z1/tH9ONYhTCiT7Knh5SGjq5NnSsDlS23DuhKirep
         +0MiaZctbhZdloL/vvKhRpppDFypIIYKIu8emtcpzavAUhUv/9qc+6GnukGnczf1uPOS
         G/qWZnXwzCs3D5B5EcO00c0cjRvzn7aep9z4OboyxVwlSGmhZNOSuIQ0NX2Z+zUadCwP
         GJeHqlpdLAnD3sPW7vGc5gRgsGpteYXlG2SzwbvPU/HZV+9n5HMYmo58NiVbd1V5xmFL
         Lvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160398; x=1795765198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/FH6II3bslDs5YBNTy7AYo6WlPjw5hNbX6vP68QInA=;
        b=Y7hXN1VV7Ngcz/6ClpZ5AUO/3lFPj5LzfrpLdS1h2rj1UU+/aPCEDw2JWFEV12Nodt
         7sgIVoaOeGa9aMtFaKp4YV4b4H1GHaqZXVbtzRQ3zClFnsaAS2Xnru5djmVm9zQ3iIfS
         WfdZmFGOMy2XGMF32Y9D6sYhQGyh/ko2NPOLKJfMxBE6G6S3FtjxIs+yohM5zESfkIDT
         9lmK+6lrsFQRI+1NcmmQmB8bs1GCHl9lFtRS1Wkow0IkcqD8NRJYC5S5XQLzzKvxJeF9
         YesFraNw1O7taWutg8sbWeZZB3syv/iAXvJrtY5vbGOOA6v7kos97qu+QF+6PM2ZulgT
         eQBg==
X-Forwarded-Encrypted: i=1; AL+hErGwZfOtNfjN2yYSk03JnafVvh1C8/tpfoq6v8OtBDDRxEK3Z/eJ7X8Uxz3ziZahagK6FUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X6Ui9sjLlcOC7xMUJFN0RcmsGHe4HPMv6Abg1+sZdlvUmmEsh
	nroB3GQWUncRcpqb9MOxO/x1KksRKQz/6QFMtFD2CRouAeMZIne5ww+h
X-Gm-Gg: AZFdTZfQXIbNM+WIzaBkLqvB7lW6lsHBF5OHr5J/Zu1ALdMdR6ivail/DfvrfoCpsRb
	ahv1Yco5SWkA9ShygSXN3qblMz0nvtCLS2HZbkIjFNHWfT8/uxdQXKYOlvJ9oy6BCOieUAjBQu6
	qxPv0OJmf6bDCGh3q9hTyO18t8I+uXbzfmF1cxgFVni4hmT0wTp8gz3taBa6HczIl6BvVqFbShO
	EOEh84RcGWSAW51Io8Qd8fsrrV+iXb3y0EmRoUpu2gLpNr/F4tl4kdMJuuns3StA886tSnx0iB0
	FjdMJbMkSHFYoYfqGzfeA91ZLodEqwSIOCMOFHXs8iOXIj0MnpVA61ZZY2qGTXj0N/lGz3SaKHm
	4jCdIASU0KgLbTy6ELUJ7yRNE+75+tyuBGO5/BxkSs4hF0RzxIrJAwR4UjTvDmN7rjSLKFGfa2T
	/HHvI8q0NGeft6SYu8LDG8eJT2CNi2okLLQ4ZoxHAc3FQb3ePLtSS69wYK12Js9bu0xwh1Bf9p+
	PjVY9Pmer5QH5k+D/LUNgkxThj8v8hBFBR5OjjExXQFyACqS1TxEXYGaU6PobDqL0eYIWLRFN+X
	SEQIDcOuP+T+LVto5bjOO4F3/pJ3z4aYhtQAS1HYvZA5q9v0gu1KObFQ9Uk4Lg4SpgjReU/DcK3
	qnYDpYL3+t3TSzxBBjL5jp+Ixjl5xKRhA1Nvcz+fm0Xi0O/s+3DUv+trPpw==
X-Received: by 2002:a05:7300:601e:b0:376:6aea:ab with SMTP id 5a478bee46e88-3856c5b58e2mr1958638eec.3.1795160397725;
        Thu, 19 Nov 2026 23:39:57 -0800 (PST)
Received: from localhost.localdomain ([38.58.103.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm6326640eec.11.2026.11.19.23.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 23:39:56 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	alobakin@pm.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org,
	James Sawyer <jamessawyer@outlook.com>,
	syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: [PATCH net v4] xsk: set network header on skb at generic transmit
Date: Fri, 20 Nov 2026 15:39:17 +0800
Message-ID: <20261120073917.63158-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
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

Reset the network header so skb_network_offset() is valid (0). For the
non-CHECKSUM_PARTIAL case, unlike AF_PACKET, AF_XDP does not need to
locate the real L2/L3 boundary: an AF_XDP frame is always a complete,
opaque blob from userspace. So resetting the network header is enough
to restore the invariant and avoid the crash.

Note this is not sufficient for CHECKSUM_PARTIAL skbs, where drivers
derive the L2/L3 split from the header offsets for checksum offload;
that will be handled separately after this patch.

Fixes: 3914d88f7608 ("xsk: Respect device's headroom and tailroom on generic xmit path")
Cc: stable@vger.kernel.org
Reported-by: James Sawyer <jamessawyer@outlook.com>
Reported-by: syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V4
Link: https://lore.kernel.org/all/20260902121028.74092-1-kerneljasonxing@gmail.com/
1. use the one-liner change to fix non csum case at a minimum. As for
   csum, since the blamed commit is different, I plan to cook a patch to
   fix that[1].
2. revise the commit message accordingly.
3. add James reported-by tag since he spotted this and sent this in
   private.
[1]: https://lore.kernel.org/all/CAL+tcoB8f7H1ptcEk1iVH065AcUNPEL2V1gKoJacwr3zndfPWA@mail.gmail.com/

V3
Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@gmail.com/
1. remove the misleading description about af_packet

V2
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
1. add more clarification about why we don't probe the header like packet at
the end of the commit message (Jakub)
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f22f9a2cdbbe..52d538160e0a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -948,6 +948,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 {
 	int err;
 
+	skb_reset_network_header(skb);
+
 	err = xsk_skb_destructor_set_addr(skb, addr);
 	if (unlikely(err))
 		return err;
-- 
2.43.7

