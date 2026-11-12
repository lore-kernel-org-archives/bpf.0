Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495987;
	b=GTZzqA5ZJ4mpnlOpobVwiXllR9RDGgStLaIkKF7AGpaC9oJOwtnYlsR3nBmotgjwb7sq
	 JRaJZzEe/RYHt5RmFbT9Jt4fX/usJ36y3qDOs91ycHUhP6abCz8OizCn+EIwCSz/pwQme
	 ugL84U9nepjt6ekWtMQkrF71mZwgT0w8YN4DfQikjBFedOXSUqBFqtwQlwW2CwAxPFOe5
	 HX7ulabImwZHnF1wCzLAN27yE+/IWmQMmYU/WCK1sGfVL/jFF+/YHkJUuriwMfn0lUTty
	 ADSn/MEpn71lTKnnwWNPv90ZouaxWY8inxqEjY8WToWIMbj2Ru1j7mO3soFeBAFmpBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495987;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=laK0kWFJEsw7C69ZvNRo76sT8cC2CLNNT+pm452UcSs=;
	b=g05ZJIjxOB7DybWyMNFoO9CpSh47MHbqHlyHiLaluAfBOgs1o843M7sKJRBJlFL8mn4R
	 pPqubJ4JEQ/VR/vLL7fuOhyXM+7NgsYqr51yacLgjULsX2E3La+10rXvQx5dkiut4zSQV
	 03Ym0lry+VCuU2uNfZq+939FpUOg/SQVEY3xcaiC/9MlEqyFEwPudwqIZnCK17e7Y3G07
	 EUcFgKG2fGC5mJ9bNI2pwSyb/UGW5Jg1Ju4QtzIop1gQddJH+4o4Rxb5ret7Xd2XlsgME
	 /kSlJoVZ2JyVcV+0AXjpw7ubcaMFwvTFdDCkegAn21D6pLttdqD89Az0TGK6XiO3Caw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=aQKX1mN9;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7306606A333;
	Thu, 12 Nov 2026 15:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7306606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=aQKX1mN9
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jQNy16SK5zLm09;
	Thu, 12 Nov 2026 16:06:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794495977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laK0kWFJEsw7C69ZvNRo76sT8cC2CLNNT+pm452UcSs=;
	b=aQKX1mN9tXzJQGvUd1yC8jpr5E0UhZ2/SEAEUDgm+lB02QxHujxSTsfhL0Q9Z0sqVXvSFr
	iiaRFfzjl57FemQmO1mC5W0vVXW7EHqkror0QMUWkRUKNpywlj+n0udvYIvi3efyXMfAIJ
	fTfmZ2bJk4u+QKC3tiPdG/cM9cfJ7W7rOzxc76a8dTlFWln6rVnr5vi4VbUPRYZXLQbIuL
	S9tQxYHgKIsXvnYcMSW61115XHwJ1JxPuX5FGAGBp2n3klzOIeowM7nEWhMsXqT3CP80mz
	trXJQHaQ5gTcbHEPm0njsnFCC4zrdXZffPFiv1K2Zjkqx/m6vENUGhUkhPQadQ==
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
Subject: [PATCH net-next 1/3] tun: don't probe the transport header of packets written by userspace
Date: Thu, 12 Nov 2026 16:06:03 +0100
Message-ID: <20261112150612.3866546-2-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jQNy16SK5zLm09

tun_get_user() runs the flow dissector on every written packet only to
set the transport header. Packets that need it early already get it:
skb_partial_csum_set() for NEEDS_CSUM, __virtio_net_hdr_to_skb() for
GSO. For the rest, the IPv4/IPv6 receive paths set it, as for packets
from NICs.

Drop the probe: ~200 fewer instructions per 1400-byte packet, -6.5%
when dropped at the raw table, -2.4% through conntrack and NAT
(emulated Cortex-A7).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8920c797acfd..9fc60a73fb96 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1960,7 +1960,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		net_zcopy_complete(NULL, msg_control, false);
 
 	skb_reset_network_header(skb);
-	skb_probe_transport_header(skb);
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-- 
2.56.0

