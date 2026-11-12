Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495989;
	b=CT9xduHh4CbqfNMsnQeHWnpny0NH5QMo2f3KSY96BnQBQxVwPA2zdu7YhF3GtC0UHs6g
	 OEhm0BwH1RwvA1IrTWvnpvjVjDVxQvmQUGh00/UTrfSYhzdOFn5zRPLkLdg7UrPyioBbP
	 E7j1OyrNdHQt8Y3rkhr5H2fw/rpZQBLc2VPtbr0bMh8Dn7ZpDJJ29FUIum54Hhj0kN/bG
	 ciwaQ0OjcgEcrqDWF8RpdW/EMupIj3cyWX7cyH2aIA5BObjHSHRB/voL+1obzQf6Fh7m2
	 tyA5X2qb1+hjNPDr9T9oEMV8TXqgJdlOiMgkSJhdjPJTFMIrbeDikH7VNBJjAqrbacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495989;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=95BXVUjFXeYf/sH6PjXF/vGeySat62hqJ4TRbbkb8/c=;
	b=sdw5s7vVs4tyJqrh+HGSmQnEODuBRkqu2qZpvrSQD3lQedVnXb85Z2VEvLLh0Cvbf4h6
	 Phoa+ZvSvMdDUKjT230hytKuMIVJEKEdwvAS7WH7NHdwn4MfnE5lxTvyUEXdbxVd6eUSx
	 P5nSLciBlmbEi9//FDS6yar+jiDJYgxuqtlWV2eQ+5xYgeeDEvKo5qg8yHRnDxf2853pf
	 iYrm59YEOWPNHa/xvXBk3BFmEEDiD+mjqGOo665AzK6jXCinxoWDEL4gOs1Z2+8DkoYmD
	 HkSusth1vKP23d/uCijnYfX/z55iAxY/lipDCw2guQFrnyri+AuaKU5QNj0sMKYvapQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Fyuo3k8z;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA68606A335;
	Thu, 12 Nov 2026 15:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA68606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Fyuo3k8z
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jQNy45Qbhz5vbs;
	Thu, 12 Nov 2026 16:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794495980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95BXVUjFXeYf/sH6PjXF/vGeySat62hqJ4TRbbkb8/c=;
	b=Fyuo3k8zN40l0/XYRMvaRJKSoUOaimKbCF6FjxYfpz/SUKRA/AblMHr0w121zSKpv3b1A2
	gUiM5CFgv1JcF88VU3ox3bcrRPJGf84hOFAsYtEOWUT+lljdONbg2iv9l/vrnwvwhpuMoR
	7yWGZnTnGBPAqjelnXxyIzFk8FJirnFheywdR4/F6YAhVIzt/4ZKiNUHDOno9N8rFHnwnf
	0NXn1qw4kl35yCNEjGACjC1HCUpnEDRye/mY1uTvEr3nc+DYiBAq+H091DdLPVO28QI1kx
	GhAhGXNaoO+Ebej/YjT+ZJWCxZPqg/MvhDCfg/iK67r9hXzkMzB6lo4CWZv/qw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
Subject: [PATCH net-next 3/3] tun: skip the virtio-net header parsing without IFF_VNET_HDR
Date: Thu, 12 Nov 2026 16:06:05 +0100
Message-ID: <20261112150612.3866546-4-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112150612.3866546-1-antonio@mandelbit.com>
References: <20261112150612.3866546-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jQNy45Qbhz5vbs

Without IFF_VNET_HDR, tun_get_user() still passes an all-zero header to
tun_vnet_hdr_tnl_to_skb(), which then only resets the MAC header. Do
just that.

-1.6% instructions per 1400-byte packet dropped at the raw table, -2.2%
when written 64 per write() (emulated x86).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 395923651f31..38f9da1ab462 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1943,7 +1943,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		break;
 	}
 
-	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
+	if (!(tun->flags & IFF_VNET_HDR)) {
+		/* all a zeroed header would do */
+		skb_reset_mac_header(skb);
+	} else if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
-- 
2.56.0

