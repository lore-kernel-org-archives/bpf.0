Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564828;
	b=pYAAdsrrJyQ8C1a+LYm8PNWc6uckwPB/ASXoYTnIi+8g3Re7Y5lJWCGEQEjO41W1jHhb
	 /VrbxDiHprLr0OJEBEkkwkz9masJviDNKzwKRRXIt2eCS4fG2Ba4pWZ28w/1bXM1Gqr0m
	 +nmoHvpkBd6bjn5ddMbdJLc4+FTCRqDm69/IUMdpkvTnK4Muy8T0ByWTdlxiRpuBmJKQU
	 p0TWpQgFGqoUnfaJbD+5yhUK/gEC24XNrKz3bfehq+hHAQ6/f8OQpw2EFTVnFaW3AdohD
	 U/2pA0Qh3hCSm3xb2WCDJ0TIV3FE06Orp25fY3MZzHD9hLylVVTsCDvc06XpOFodUHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564828;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=2m3OpPdUjA4WrVEr6vJeg6i0tYglHyIViTuYZp2tBU0=;
	b=0EAYB19HcQ1VweOp2YRjkUPfvwtZYXw1nGcsFsTyacSIniMkkdJruFyqqVr1ohDXSg3P
	 bW+cT3KkZOvLjYqCYGuaxc1GIFAJQisDvmLleNLJCFCl2a1OZZudig3RoYyLI108Igmop
	 y9g1k2nwyEg7VK8gBCRw6I6soxklEFhtNDVhjl5ZXCF0pIV+L/Dztc4N3XuPTjZdCPy5G
	 D/aOL80QiVOR/IsuVDeKfjrf1DCKcovOArltZR/0QrgylkyWkOY+VRWROOXlR4Akj9CSg
	 5FHIyVw7SLX7sucmLPX974Q4m15dFIu2yBDg7kegHiHPg/PH5OcZoI7JA6tyuIZGUEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=J4dXMJX7;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1C606A327;
	Wed, 25 Nov 2026 00:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31B1C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=J4dXMJX7
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jZ0Dl5f1dz5wsf;
	Wed, 25 Nov 2026 01:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2m3OpPdUjA4WrVEr6vJeg6i0tYglHyIViTuYZp2tBU0=;
	b=J4dXMJX7xVhCGS2LRLoPlsPlO5fOy01uKy03tplpGf1ELXzDjenyycpQIq4VTjRBPlCObl
	90a2Vzm8B7at+z365X5UHorviRZV2nkW6ySS7GOZVWD4QckthDsEFHkM5d+qdMqD+8jCS7
	xlvZwxDa7aGSPCocVqpsM00Ne6mWHzoaYgeF/cGH6VF5BrIAD2DEmxRFDNGJir28zyRh8T
	M+dRVN7AViwzeF11NvRTgiTbvWC02FsTf8I0a6Zs1gRkE9aCSJo8T2pFgtYP0sum3hE/qQ
	PzUZjIbJNzeZmV26wYcmP8AbwoVnJxNcPHfesL9TsaAINHsneBo/Y5YAnFftlw==
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
Subject: [PATCH net-next v2 1/2] tun: don't disable BHs for the XDP program check of every packet
Date: Wed, 25 Nov 2026 00:59:55 +0100
Message-ID: <20261124235959.1141963-2-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ0Dl5f1dz5wsf

For every packet, tun_get_user() disables BHs and enters an RCU section
only to find out whether tun's XDP program is attached, which only TAP
devices can have. tun_build_skb() takes the RCU read lock for the same
NULL test.

Test the pointer with rcu_access_pointer() instead, and enter the
BH-disabled RCU section in tun_get_user() only with a program attached.
A program attached concurrently could already miss the packets in
flight.

1.2% fewer instructions per 1400-byte UDP packet written and dropped at
the raw table, 0.7% fewer when forwarded (qemu -icount, x86_64).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 76a5ac2359b9..408bb0b40348 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1709,14 +1709,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	size_t copied;
 	int pad = TUN_RX_PAD;
 	int metasize = 0;
+	bool has_xdp;
 	int err = 0;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog)
+	has_xdp = rcu_access_pointer(tun->xdp_prog);
+	if (has_xdp)
 		pad += XDP_PACKET_HEADROOM;
 	buflen += SKB_DATA_ALIGN(len + pad);
-	rcu_read_unlock();
 
 	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
 	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
@@ -1733,7 +1732,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog) {
+	if (hdr->gso_type || !has_xdp) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
 				       pad, metasize);
@@ -1972,7 +1971,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	skb_probe_transport_header(skb);
 	skb_record_rx_queue(skb, tfile->queue_index);
 
-	if (skb_xdp) {
+	/* Don't disable BHs and enter an RCU section for every packet only
+	 * to find that no program is attached, the common case.
+	 */
+	if (skb_xdp && rcu_access_pointer(tun->xdp_prog)) {
 		struct bpf_prog *xdp_prog;
 		int ret;
 
-- 
2.56.1

