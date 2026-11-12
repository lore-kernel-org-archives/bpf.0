Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495989;
	b=lRcltj65vxiiicqp/JY1hp1ovJGN6FtsgLtI4/3pjigBRb09PD1G7uyGeP71u21cA0pf
	 mwbVx5Zh9kR1dg/kD5PKdwZ8m9ZhNzW3rZQ04+fGFS9bEMYTYBvZh74c0gcYVpRFJUgaa
	 3ZuVszj6EFYdgrg3A1Bs2tIeHM8lAIpXNtlEo+wCx8v/abPDNSJvNK+xVKWLoCdXnl4W+
	 1lm+AQXUr0AcEcZy70fw8/4uG7ohlkc4U9j/7idQHvLHDE0hjTEk7dAAiYLTT4K7Qi1N8
	 BZLUjpQJ5Hm2wvuaadLGqeYY8KQCD8yA53IEaASRBxakljUmXEj234QlW6HG3MPBRlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495989;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=N89g4t/mMALSVLoXHEkCFejzYZ4ZVRJdwJdi6jm2Jn0=;
	b=MYDfxS54HGPxL90mPtSp3wTnUsN9ngGaFDNimrOAeiKgcLz5sEMVaRaK+Kgkea7rQxCa
	 z7LHDB9l5sh3FS9RzubL1D9CfeWxdXkxY0sEY5JIVB+GZhDTub92e1yBnuJbp4tVEUjR5
	 DROJuCGUWZ6e7t8xxymD2Qth5m/uv+tMPPk/34WpAcoXIWfyHE7rizDKp4v4s30ybBqDr
	 2HeyvFPqvefC9JLRx+Zf2nAXvbjqOOjcfGBhND1JfnemxnOMixCkWwRLnDVcJA/xuJNCq
	 /ITg+h0cI/B1GA+4fwWHGF/e6AcML+GmZfJ19ZuZ9FaWux8jXKnfmuGihfkWnkEKDpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="z/7qU7Nr";
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07E606A330;
	Thu, 12 Nov 2026 15:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF07E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=z/7qU7Nr
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jQNy32Brhz9syM;
	Thu, 12 Nov 2026 16:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794495979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N89g4t/mMALSVLoXHEkCFejzYZ4ZVRJdwJdi6jm2Jn0=;
	b=z/7qU7NrL3l06UU8hnZW2s4un7PobbSwRqNQIIRfBLRwCHmIJYNj5Nfd96s5WmkRrN7DKE
	cSK+eYWGcETnpz6Snu+Z7go3mv/ogAKI89iz7vjA8ZXgAnkfmlPMbIVW5xoGd5EAn+xMe5
	zvJqKZ1XW5YA5lnyx58+FlZBLKutM6A6kccEzX7L7aafQvuFROJixywxMGfJ8MHnBUTl+K
	eRWrH5QPr5gnL1SS5dHKaMe2XAJq7TSPYs0sPbb4aCY9n7JQzPW97+hUtYiXC9BxZz5Ze/
	uE/7LLAquO+/o8OcbbBGLvG2e4617ItnNdh8nou6MzILJAh0EPOTonFLu1h0Mw==
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
Subject: [PATCH net-next 2/3] tun: don't disable BHs for the XDP program check of every packet
Date: Thu, 12 Nov 2026 16:06:04 +0100
Message-ID: <20261112150612.3866546-3-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jQNy32Brhz9syM

For every packet, tun_get_user() disables BHs and enters an RCU section
only to find out whether an XDP program is attached, which only TAP
devices can have.

Check with rcu_access_pointer() first, in tun_build_skb() too, and enter
the BH-disabled RCU section only with a program attached. A program
attached concurrently could already miss the packets in flight.

-2.3% instructions per 1400-byte packet dropped at the raw table, -3.0%
when written 64 per write() (emulated x86).

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9fc60a73fb96..395923651f31 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1702,13 +1702,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	int pad = TUN_RX_PAD;
 	int metasize = 0;
 	int err = 0;
+	bool xdp;
 
-	rcu_read_lock();
-	xdp_prog = rcu_dereference(tun->xdp_prog);
-	if (xdp_prog)
+	xdp = rcu_access_pointer(tun->xdp_prog);
+	if (xdp)
 		pad += XDP_PACKET_HEADROOM;
 	buflen += SKB_DATA_ALIGN(len + pad);
-	rcu_read_unlock();
 
 	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
 	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
@@ -1725,7 +1724,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog) {
+	if (hdr->gso_type || !xdp) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
 				       pad, metasize);
@@ -1962,7 +1961,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	skb_reset_network_header(skb);
 	skb_record_rx_queue(skb, tfile->queue_index);
 
-	if (skb_xdp) {
+	/* Only TAP devices can have an XDP program: don't disable BHs and
+	 * enter an RCU section for every packet just to find out it's unset.
+	 */
+	if (skb_xdp && rcu_access_pointer(tun->xdp_prog)) {
 		struct bpf_prog *xdp_prog;
 		int ret;
 
-- 
2.56.0

