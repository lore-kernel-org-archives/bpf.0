Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788864;
	b=MKcCLLe868FaK/FYqtjDBeurfweFspWaA28S29oRnHdt14GZFKsewQQJJnMEtIgK91Fb
	 DFvFklLd1BAAVSgrhBiF/RNWH7kwgF1AW4ok5iQttkfS3PHxWa63Wo6ym4um8g8AhgnyN
	 VMQ2bH3uyIU5aK5lgnk5VegEtUCvpB7mcqyKblQE7lv2s6sBxOc+LbljHyde+syB8BEGy
	 wIulxGgqWl2eMsiD3qGzV+IgkElF0O/Mskyh71xb7lWlol816lgVKqZOdqqY9O/IJK6TS
	 KeIt0X1cBY8G2KYXAgexsqrxF46p/KTymWSfs6l9OWIhNpAHtgjfimKdSKGNWXUNmEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788864;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=gWmlZS2QEdndqaaG1v0KNH/Xqwd52KcDv0A7eCgo+VI=;
	b=NtBixonUb6k+t21P1yRI8opDtTUO9M6Qhbi4rYFX0Es8R+IgL/theiLQtyhuR0JZOUVN
	 /ZesGY0dsmcthtHHuRp2VEgQ6TvtdG0sgYan38kN7jE/IHeSMQ6yjyufuVAmfbRbkBbLl
	 Rs55d+siXDKAlQaSRQ6ecq7OVAW4A6n4s27hiAmwi1jTNmlyeNMFo1cnVvyxHaKP0A8+g
	 ngX8S8yNWC8NbnaWpR0mVRbOtX/Txgg/XDwdw/Q52tO/AuT0wuPN6pEGs55BNKh3OWXWx
	 0/GxgnNwIvVTwpcqUc7yddiRNt48/zG3/mMNzsIarcafZYxfKgpxOX56BBbVIKCPIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=VI8QU8qU;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85923606A685;
	Fri, 27 Nov 2026 14:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85923606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=VI8QU8qU
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jbb530l8mz5vdq;
	Fri, 27 Nov 2026 15:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795788855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWmlZS2QEdndqaaG1v0KNH/Xqwd52KcDv0A7eCgo+VI=;
	b=VI8QU8qUATvQCAUolKhM2vpwhS/noVVlQAVMhWsvzfu7mP6a7OUPoo2OgJIaNasesc+UEr
	OQWympo7Bj/EijtA5eWwdZjL4wp/Kvg1iM59gZfCIu0taU7hxzk+z+82oRwLz0QX40f/F5
	DaKSqtW5JWXUYG0YBlUIMSph9o7HVFs13LNQ8CnIXN4kA20/eaDTBcWQQ3LVzkoKNuL+7K
	hUwepVBPEzo45KRd8PDPUFqDjPfGdEHPnUFATx/ei4Q2ICuw0lU5HWRYEMC18euOI5q9V/
	dC1dbNbEAeaW68QPVSC/qKVufOI0xxKHCNZT9/H9lnR5WcbajLLqi+bwW09Nbg==
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
Subject: [PATCH net-next v3 3/3] tun: skip the virtio-net header parsing without IFF_VNET_HDR
Date: Fri, 27 Nov 2026 15:14:05 +0100
Message-ID: <20261127141406.651406-4-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jbb530l8mz5vdq

Without IFF_VNET_HDR, tun_get_user() still passes an all-zero header to
tun_vnet_hdr_tnl_to_skb(), which then only resets the MAC header. The
parser is not inlined, so that costs two nested calls per packet. Reset
the MAC header directly, as tap_get_user() already does. The check uses
the same copy of the flags that decided whether the header was read.

1.9% fewer instructions per 1400-byte UDP packet written and dropped at
the raw table, 1.1% fewer when forwarded (qemu -icount, x86_64).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 09f31faaced2..a644fab4321f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1970,11 +1970,18 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(flags, features, skb, &hdr,
-				    (flags & TUN_TYPE_MASK) == IFF_TAP)) {
-		atomic_long_inc(&tun->rx_frame_errors);
-		err = -EINVAL;
-		goto free_skb;
+	if (flags & IFF_VNET_HDR) {
+		bool has_eth = (flags & TUN_TYPE_MASK) == IFF_TAP;
+
+		if (tun_vnet_hdr_tnl_to_skb(flags, features, skb, &hdr,
+					    has_eth)) {
+			atomic_long_inc(&tun->rx_frame_errors);
+			err = -EINVAL;
+			goto free_skb;
+		}
+	} else {
+		/* a zero hdr would only reset the MAC header */
+		skb_reset_mac_header(skb);
 	}
 
 	if ((flags & TUN_TYPE_MASK) == IFF_TAP)
-- 
2.56.1

