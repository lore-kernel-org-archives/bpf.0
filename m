Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788863;
	b=1Mcj6rNEztTNVruZKv5FT2CDrX2m3XU09t/8OCjKWeWN/8NlLRy89Rk9IJSZBcLTVwN5
	 GYaxVsMh5+3zklMCqs38A00a8LsvMbaBDdxYwG3DbNdtMG+HrEG1kb1udckw2RIopxxzy
	 m6JVUQ92IbUwMzc+62ya4XmhhGBxQ7+wtqYZCRHCN14IgmOdIl+azP4gC6Gp4k8Ta43Vk
	 IS2MOed+yIFY/e8kMNTti+dbiK5DSHtCOiu0U7FD5gUM9iCNR+8PlrZF6UoD9vDbhXKDm
	 heE8ecg/zBCpAltiGy4fDptSZZmARXx8IH6qlGbZPiH09Xv3oGYxDjc/bzvf1oazB+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788863;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=Yr/lOwbavCvzMFSGLt/oqdC2UadpL6VoEBR9GZXPwFc=;
	b=uM6naug6e03SR2GO25MUwirgPW7TUGGNsRpvaO+TNrxfRnkhjOtW/iw2W4CWLNCyPpMp
	 kLQlTUJzaKxm3HBZEgsABO9PMgClQy+ncs3bIDm/O2OetqWcPVHl7449Ooa06se3e1IKC
	 DWrqs5ZJBQ6GsSdPtsRrzYHhzBq4a97BZxz3CwPaOwUokNSmsUxXEPskKFxzg7/dGNkf9
	 8R2HmAa/C5u7OoLeosGeEWjdZYwFGhs6e95fojNcYzvJVWXsqIkL3/+M8ewOE70HEjv/2
	 Kg2JxWAwz7xuDFozU+DnBc0Q3w5OTaMfhexILJ1mBOc4911UClMcfvwTXZ3LffWDXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pxSsUCiO;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9114606A337;
	Fri, 27 Nov 2026 14:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9114606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pxSsUCiO
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jbb513XwYzFpVL;
	Fri, 27 Nov 2026 15:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795788853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr/lOwbavCvzMFSGLt/oqdC2UadpL6VoEBR9GZXPwFc=;
	b=pxSsUCiO4P05kY3fe7asxL5vrOsJKB/4vVgfheqZ6zLOqIoxZfHczWE/4iattl0WGaml6R
	zM3BXz9FcpP2PcquIvVDR02J4P2QLt5FkERsSeqCqWrd5rdDx2L3ITaWqBoJ3dVcOi07Yp
	UhDcAku+jgZkb6HsvpV4654OR0E0yt2Tyo2L9HLFFPL8M59bEio3IENyvAkCVeqQ2OSVri
	ea/GwCS2NA4J18oqc4wWd7F4p4gG3fZaRoDh/jMR3M+pg4iuwRxOjnSe+DZYVv0ZIw6j3Q
	jIMS7sK2LApi0vVyw3XS1ezsB3nIUutJuQs7BDBKHXMJvzt86Sqm9tGDOxKtAg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 2/3] tun: read tun->flags once in tun_get_user()
Date: Fri, 27 Nov 2026 15:14:04 +0100
Message-ID: <20261127141406.651406-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127141406.651406-1-antonio@mandelbit.com>
References: <20261127141406.651406-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jbb513XwYzFpVL

tun_get_user() reads tun->flags several times. tun_set_iff() can still
rewrite them after attaching a queue, and TUNSETVNETLE/BE can change the
vnet header byte order at any time, so a packet being written can see a
flag change halfway through: the PI header consumed under one IFF_NO_PI
and interpreted under the other, or the vnet header validated in one
byte order and applied to the skb in the other.

Read the flags once, pairing with the WRITE_ONCE() of their writers, and
use that copy throughout, including for the build_skb eligibility check.

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e2fe7174e438..09f31faaced2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1625,10 +1625,10 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 	}
 }
 
-static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
+static bool tun_can_build_skb(unsigned int flags, struct tun_file *tfile,
 			      int len, int noblock, bool zerocopy)
 {
-	if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
+	if ((flags & TUN_TYPE_MASK) != IFF_TAP)
 		return false;
 
 	if (tfile->socket.sk->sk_sndbuf != INT_MAX)
@@ -1823,6 +1823,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	bool frags = tun_napi_frags_enabled(tfile);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	netdev_features_t features = 0;
+	unsigned int flags;
+
+	flags = READ_ONCE(tun->flags);
 
 	/*
 	 * Keep it easy and always zero the whole buffer, even if the
@@ -1832,7 +1835,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	memset(&hdr, 0, sizeof(hdr));
 	gso = (struct virtio_net_hdr *)&hdr;
 
-	if (!(tun->flags & IFF_NO_PI)) {
+	if (!(flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
 			return -EINVAL;
 		len -= sizeof(pi);
@@ -1841,11 +1844,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			return -EFAULT;
 	}
 
-	if (tun->flags & IFF_VNET_HDR) {
+	if (flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 
 		features = tun_vnet_hdr_guest_features(vnet_hdr_sz);
-		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
+		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, flags,
 					     features, from, gso);
 		if (hdr_len < 0)
 			return hdr_len;
@@ -1853,7 +1856,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		len -= vnet_hdr_sz;
 	}
 
-	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
+	if ((flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
 		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
@@ -1875,7 +1878,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
-	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
+	if (!frags && tun_can_build_skb(flags, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
 		 * skb was created with generic XDP routine.
@@ -1929,9 +1932,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	}
 
 	skb->dev = tun->dev;
-	switch (tun->flags & TUN_TYPE_MASK) {
+	switch (flags & TUN_TYPE_MASK) {
 	case IFF_TUN:
-		if (tun->flags & IFF_NO_PI) {
+		if (flags & IFF_NO_PI) {
 			u8 ip_version;
 
 			drop_reason = pskb_may_pull_reason(skb, 1);
@@ -1967,14 +1970,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
-				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
+	if (tun_vnet_hdr_tnl_to_skb(flags, features, skb, &hdr,
+				    (flags & TUN_TYPE_MASK) == IFF_TAP)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
 	}
 
-	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
+	if ((flags & TUN_TYPE_MASK) == IFF_TAP)
 		skb->protocol = eth_type_trans(skb, tun->dev);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
-- 
2.56.1

