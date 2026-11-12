Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495987;
	b=JcNgYHRtIEO1RnobhGm7AJ34Lz1r1O2VRPfA4AQomMHxhmde7O4RhMTfRzkw1yU1hLAE
	 AN/0FIqwDAnZ4MDGX+48oysZAq79n9b0joUGg85HVfQmqvZAsCbXrJhsZbDbK/0hTkP9W
	 7VfdvBGpISuuE1Ih2iXNDAdv6PGu+PdALu4fXJqpdmigJ+9+fD9kNEXsMUD/JFoQrl+cv
	 7pqEO3TEy/eidrUhSGrEkpe00lngIR2dqAX9FLzQqNBhPPOnw8aNYTaC2B4kIeaSxcODn
	 sIBaTSrmQWPxY40X6dTbudePOmyYlV2S8E/6QqBhpJowcSLhRim5podV8pmEzzYf4Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495987;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=zkh3wWzLr/WZwVrpT9eotF1ouZu/Lpfc/r7pJH4exFo=;
	b=xcPB4jxAI4tmCbPUaNiLJrzzNGjr8PmCTL471hkjrxAl1Kg0IVorSnoMYwFoGFghzx7J
	 2mV6tkQ8X2Qfo3TEYcZG5qXP0w8lZxGQHDhtVBC7EbGS2Jvi950+5j/TmvTg8s/xefqF+
	 TEoixCcQlDnYeFfrmuFxsHiyK/14mQ3TvAzMhOMkoz0LicRn/scrjTEECUhpeIxyB+wFx
	 /bKEwtSlH3pAgqkK3e2aN6PptWLYqCKMgBy4fblM53OxXR2TkP56EDzvB1hWf+Y2sszT0
	 UClh0W2tf1PSp9uKhSO4BaKEj55RoK9J6WPUiZMEn3Q0YNtdhK/WQp2MnUxwB5OP5dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pD1f2rOl;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03722606A321;
	Thu, 12 Nov 2026 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03722606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=pD1f2rOl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jQNy04GhszFpkp;
	Thu, 12 Nov 2026 16:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794495976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zkh3wWzLr/WZwVrpT9eotF1ouZu/Lpfc/r7pJH4exFo=;
	b=pD1f2rOlz6NG/8fmy+eFxKkaJRSQ0yq8O8dY0UlEaFsMV653YNqEZDTOKo00RRrTPRBYWv
	biQvK3k7YPWjPMMfNRXZH/w8rBqB5cVyWqzrswoB/UMtMvJqNNBNYw0YvFmcHrrA+GAbpv
	54o3F4+GiwdKeYagsdr8lIKMDVo94yb3Xv74Mfgpmhdj9GiPI6XBd3dt03g//nN0PSP7Wt
	WmnWxd1igtilnijjyeAE4X4YvdkO767LABt1e+7i1U9RKIGKPxxHAjokS/ekXd63feHLI2
	fZ4YFLbKWfQfNS5B7BD7g9iRUB82A8UEFqqyqeipALEDjkyF1XzVtU0XVXeJOA==
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
Subject: [PATCH net-next 0/3] tun: trim per-packet work on the write path
Date: Thu, 12 Nov 2026 16:06:02 +0100
Message-ID: <20261112150612.3866546-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jQNy04GhszFpkp

Profiling a link-bonding daemon on an embedded router (Cortex-A7), which
injects every packet with a write() to a tun device, showed tun doing
per-packet work its packets do not need:

1. a flow dissector run, only to set the transport header
2. a BH-disabled RCU section, only to check for an XDP program, which
   only TAP devices can have
3. the parsing of an all-zero virtio-net header without IFF_VNET_HDR

Per 1400-byte packet written and dropped at the raw table, instruction
counts (qemu -icount) drop by 6.5% for 1 (Cortex-A7), 2.3% for 2 and
1.6% for 3 (x86). The tun selftests pass.

Antonio Quartulli (3):
  tun: don't probe the transport header of packets written by userspace
  tun: don't disable BHs for the XDP program check of every packet
  tun: skip the virtio-net header parsing without IFF_VNET_HDR

 drivers/net/tun.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.56.0

