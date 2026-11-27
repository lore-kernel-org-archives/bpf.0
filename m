Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788855;
	b=11YpTSsnwEizG8d5nVVpRVjHdSplvEIrK3ajST21vtwuq7Qp7IMHw5OGtHRyuIaWaYlM
	 7W7tDPHLdaSi3MdCaLLoaIqbM9B3n7/fvarM1KRrw135EfMv/c/hIF04Fdn4vw8E5S2gu
	 aQAL+5ZuzCUueQQt9JpY9H73cm7zlczrmPMg5H0x2Aa9mxPDj/5ZCSg6Rz3bWJrzbcCG5
	 oYUWijyOHSUC9mf5u9nbdiB8L1QYgQJ/s1+j7ghn8GyK/fS6KAhgPz9+giEyToPOIfOpP
	 me7HyXjQyaP5DjplGLtJrMbnbkssRuplgCtODSgWr/XUt7BpMMba8U+9IgvQaPietLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788855;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=Rsmts2EOzDPxmWrjfgARbxt81aNFkdaXSifeh0H+Uew=;
	b=bcZ6GhsWU8DE6+yG9+spWFqSDAzNA+YDwWdRUEnKAkR+eHLLeNEkHnB0V8/M4HTL5mv8
	 0AEIIiGcnqJJE2jXjsYp8djk0G5HSqnoUPQibns2jKWFEpmN8SH5f+QhHuCl5zXw+EZmT
	 hFZrIAkjbMy8QaPd9FAAVCdr6YLxlzLC+kpa9zJ71z2m7Ni4JjorDM9EAYALks7teUzRV
	 V0h4WF/i0mQDsDCSCif0gY6q2ATUsoS2AbDeTW9mseuwSn7K1q/vMQ8S6ONnEKlcjbRKh
	 lKiTCIP+CKOu0HyVZXHjsbddgO33PvYsFL2a8/5tQbDHekRLt8mAir0884zYoEJFxqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZLOqBDrF;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C7606A31C;
	Fri, 27 Nov 2026 14:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZLOqBDrF
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jbb4y3BkQzKm3t;
	Fri, 27 Nov 2026 15:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795788850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rsmts2EOzDPxmWrjfgARbxt81aNFkdaXSifeh0H+Uew=;
	b=ZLOqBDrFq1+3MTlewRBAHX3k9p4L/oiUOtXAI5Wjz2Qhn/G8Hhgp5o27tm+Xj2I2N1CHo4
	jGbCQV7hoMhT8zNLJwBr7MeXukBq9uXoi47Q0mZO57n2QKgORYTP8+BcBEAtlng+But54O
	ltm0XVookLBSytpNF8WoVW2mFOqSjNSKGTzPXXlCdF9BKaCNGPta3wBl9PKfcdVM8lzTVp
	cynVxnpSYRaNpH8psLqXDHgGQpFP/PCr+4EjzE4DrZHv3ExpryEPKOMoTXbkwWdA29oubf
	fPiaH2P36WREc8m4QkCphfWRqzBBkNENGfh6z223av/mV3XHm+oC05hYmoF9Zg==
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
Subject: [PATCH net-next v3 0/3] tun: trim per-packet work on the write path
Date: Fri, 27 Nov 2026 15:14:02 +0100
Message-ID: <20261127141406.651406-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
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
X-Rspamd-Queue-Id: 4jbb4y3BkQzKm3t

Profiling a link-bonding daemon that writes every packet to a tun device
showed tun doing per-packet work its packets do not need:

- patch 1: a BH-disabled RCU section, only to check for tun's XDP
  program, which only TAP devices can have
- patch 3: the parsing of an all-zero virtio-net header without
  IFF_VNET_HDR

Patch 2 reads tun->flags once in tun_get_user(), so that patch 3 and the
existing checks all see the same flags. The other paths read each flag
only once and are left as they are.

Together they cut the instructions per 1400-byte UDP packet written to a
TUN device by 3.3% when an iptables raw-table rule drops it on ingress,
and by 1.9% when it is forwarded to a dummy device. Counted under qemu
-icount on x86_64, with ERMS/FSRM hidden so that user copies are not
counted per byte; the counts include the syscall, so tun's own share of
the saving is larger. The tun selftests pass.

v3:
- Add patch 2, reading tun->flags once in tun_get_user(), and base the
  vnet header check on it (Willem)

v2: https://lore.kernel.org/netdev/20261124235959.1141963-1-antonio@mandelbit.com/
- Drop the patch that stopped probing the transport header: tc ematches
  and generic XDP rely on it (Sashiko)
- Rename the XDP check variable, which shadowed another one (Sashiko)
- Patch 2: adapt to the has_eth argument tun_vnet_hdr_tnl_to_skb()
  gained in 73e08d50eb13

v1: https://lore.kernel.org/netdev/20261112150612.3866546-1-antonio@mandelbit.com/

Antonio Quartulli (3):
  tun: don't disable BHs for the XDP program check of every packet
  tun: read tun->flags once in tun_get_user()
  tun: skip the virtio-net header parsing without IFF_VNET_HDR

 drivers/net/tun.c | 54 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 21 deletions(-)


base-commit: f89726ffabef1b08c52e6163b7ab94b0d5f15503
-- 
2.56.1

