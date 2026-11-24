Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564829;
	b=4shPhM6M51zHmdhjPzCY+1yT5I9PfCU/h04PSiOQ310R0EFbCJmR784S64OQthNexUQx
	 oN8OtPI9v8NYcl6QEJxzHcgE6NXtfNMWIeUIdOUgfgY6iMtarLbkw3RbuAfqv+LFk+hsA
	 fqyzqdhQ2/XriU9xI2EXKaQjJMmisQaYCX1Wqdl06zfhVhHtH7alz4s+gKqleHC6WLfRF
	 dHdGi3Fhvru4JTlRyucjrML0s6DpwiQlCUMsdvQF2xvij5bMt1mQYPTany8Ac2Ytggdkw
	 Pb3gYs+ntP7mFuiRuatvY7HL7rIR/0cyDEfVB+0iNwCIAJOsOmid5c8S8hV0T4eBjcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564829;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=MUSDaOJql8U2lhE9G5LULgroKuZjK1HPW/0+tyWH37A=;
	b=ECM+SCmIcmzFyYt7zbgn6MlLqtTIMZH5m+TRNCpEYgL0/MPMCYbC/x8MqF09ZCGHj7Af
	 I9Ud6rPNmd0znsjiq7DJkSeQTpn/EJpJ4ewCbc3Kuq51WjlKL7ljznPosIcmBLjtnNtTx
	 D9NOqdrPdWFW/ekeXjOhBghgKon5LZD1Hib+eP6qe1pUYOuaypo4g76H5z7gg/LVFqoe3
	 eTSTMSyEhVGx0kUcEC3gDxs9nwKtNwq4smY6r+zzjhpaTe4ktiJ7lOFXQ3xxx3IjVz2+D
	 J/YteWZOa/GFQXXwjmPsIXSxnOsj28xsl1HRUK4va5NSmD3clw1MD6jUs79rafJrFsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=c3KCYSlQ;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460B606A33D;
	Wed, 25 Nov 2026 00:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E460B606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=c3KCYSlQ
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jZ0Dn3j41zNmD3;
	Wed, 25 Nov 2026 01:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUSDaOJql8U2lhE9G5LULgroKuZjK1HPW/0+tyWH37A=;
	b=c3KCYSlQpDeHnvE7WVodU/bktz4NGw0UT3unSnJ+oVAjz74wRW7QzsdJliHWAb67Y213c3
	qCMMO+XCSpYk1nv7fyZ2Q2OPFIbzSBI3gnTqHuuM96dOfNgYDUyejnkTvFPCRqpq8rtCWc
	k6HFgbYMRg6IBTlSYL5llVvRPxfFVyqIBg4sVzlN55N8JmqTFqFuWiSGWbNtKjS3FhPLud
	bMTX3oSRw2egaaiivUmO+5kthex0ijEDSTFee5GtAA7LiGxEcw04xTD59SPjY04+bTSJZd
	VpM8bI8COrxHXp/4BHJ2IllAHoUqPW8TUhlTMEJ+XWzu/cBdZyRWw+VMXJQwvQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
Subject: [PATCH net-next v2 2/2] tun: skip the virtio-net header parsing without IFF_VNET_HDR
Date: Wed, 25 Nov 2026 00:59:56 +0100
Message-ID: <20261124235959.1141963-3-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235959.1141963-1-antonio@mandelbit.com>
References: <20261124235959.1141963-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ0Dn3j41zNmD3

Without IFF_VNET_HDR, tun_get_user() still passes an all-zero header to
tun_vnet_hdr_tnl_to_skb(), which then only resets the MAC header. The
parser is not inlined, so that costs two nested calls per packet. Reset
the MAC header directly, as tap_get_user() already does.

2.0% fewer instructions per 1400-byte UDP packet written and dropped at
the raw table, 1.2% fewer when forwarded (qemu -icount, x86_64).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 408bb0b40348..79aaadd9a2aa 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1951,11 +1951,18 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
-				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
-		atomic_long_inc(&tun->rx_frame_errors);
-		err = -EINVAL;
-		goto free_skb;
+	if (tun->flags & IFF_VNET_HDR) {
+		bool has_eth = (tun->flags & TUN_TYPE_MASK) == IFF_TAP;
+
+		if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
+					    has_eth)) {
+			atomic_long_inc(&tun->rx_frame_errors);
+			err = -EINVAL;
+			goto free_skb;
+		}
+	} else {
+		/* a zero hdr would only reset the MAC header */
+		skb_reset_mac_header(skb);
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
-- 
2.56.1

