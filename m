Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564827;
	b=TNxkL6T0Sud/hXDcVT9W9ct9L65qfhsLKJXboGK3jrfz1niJCCLtd62s26Y6A0Aiz2Nw
	 dNoXcJAUOw44prUSyguphzj9W+tJBmRnn308c7g+aut6YwpoikrIg+5AmM0gBKc9db8ur
	 2PKBRSihCsjq3hndlWwmNCDoR56hGuo/O0MQW7LfNg6phoUS4PqxHo7epaSn/gJa6AnJF
	 zzf3eTY0K+ucK0sLYNZ7LcUiy4Wna5xbSuYVzZTHlKVaQIAufRB1iAx9+bVjNf/Ko+Cva
	 l95GszXUB1SWuYkJWe9JorJVaaXAkL7HL3flo7LpGS7wR7t/0MqfuusO9/Bb4q1NbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564827;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=lYWA6Dn1Ozo2Fpdh1kuMR949zyRpuOO8QwqpcIF7OX0=;
	b=b4Y0dkvzs7o/gkaV6QE6+gCHkTiYQ+tVRkyYSu37KD538pAl3CCqzD6+qcaTEVb1kiTV
	 KwwC3cHxymgi6BKvgV79xQUfvzCy85U1tLNLTptydFwm0XxOgzoebvKae60/z+Wiht2y6
	 pvfUFHGn4wRvnnJhKRTCAjbZkxbo4ecmhHkprvb827rxww5tGWPnatET1zGr9gh0+Aaha
	 T1d9gmzgMpzA8dn6l4R4Y2IQq00Gd2ONipsYCk3kDAi8/VzqbPYi4Hwcu2tx4dgFiI2LS
	 SntJGlqqNQ9U0ReTkLxt0dG5CtmZnfxkD9xg8wIugSiPZV191qsJ9EJp7E6MM6n54iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=mkwnD3cR;
	arc=none smtp.remote-ip=195.10.208.52
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0C606A323;
	Wed, 25 Nov 2026 00:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A0C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=mkwnD3cR
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jZ0Dl15GPzLmXL;
	Wed, 25 Nov 2026 01:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYWA6Dn1Ozo2Fpdh1kuMR949zyRpuOO8QwqpcIF7OX0=;
	b=mkwnD3cRzcpJDG04SmA+wf9BlnJp6lq+11sq2ROFnw8zX82CJWMHrn451fDrdIqWb1+dhl
	h2nlsWwHM5K0WHJEpMUa+sJijV6/Q4Ova7FReNGXQ1bLHfn2EPa3eKa/JPEgnL3rF2UnaM
	Zq2x8gLbf91YtbTjp267VaYO2aeZJNaWV7kizGSTLd6Cad7wWPg5AonpZhxPzkDu62hn22
	DLHnCIh11JmR4XY9vFjcZIK7HuYPAAi67u872GPP+Z8VmRWtDKSVXrM67GgU/OCahz3q44
	zS1E2FLKDkYlZLSzhAdfbNM/YO2m96WIuGQVLxf2eXkRd2GQE4CLOmso/bvDBw==
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
Subject: [PATCH net-next v2 0/2] tun: trim per-packet work on the write path
Date: Wed, 25 Nov 2026 00:59:54 +0100
Message-ID: <20261124235959.1141963-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ0Dl15GPzLmXL

Profiling a link-bonding daemon that writes every packet to a tun device
showed tun doing per-packet work its packets do not need:

1. a BH-disabled RCU section, only to check for tun's XDP program, which
   only TAP devices can have
2. the parsing of an all-zero virtio-net header without IFF_VNET_HDR

Together they cut the instructions per 1400-byte UDP packet written to a
TUN device by 3.2% when an iptables raw-table rule drops it on ingress,
and by 1.9% when it is forwarded to a dummy device. Counted under qemu
-icount on x86_64, with ERMS/FSRM hidden so that user copies are not
counted per byte; the counts include the syscall, so tun's own share of
the saving is larger. The tun selftests pass.

v2:
- Drop the patch that stopped probing the transport header: tc ematches
  and generic XDP rely on it (Sashiko)
- Rename the XDP check variable, which shadowed another one (Sashiko)
- Patch 2: adapt to the has_eth argument tun_vnet_hdr_tnl_to_skb()
  gained in 73e08d50eb13
- Rebase on net-next and re-measure

v1: https://lore.kernel.org/netdev/20261112150612.3866546-1-antonio@mandelbit.com/

Antonio Quartulli (2):
  tun: don't disable BHs for the XDP program check of every packet
  tun: skip the virtio-net header parsing without IFF_VNET_HDR

 drivers/net/tun.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)


base-commit: a4c450594f5d1dc0fc4daacfb95d40554d99dead
-- 
2.56.1

