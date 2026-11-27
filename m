Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788856;
	b=sNPaVn/kt6sDwV7Byp5BUtWsGJdwCjEZZy+/ldfAcc8mfd3sWHJ2f+Ai3csQldpwAdv0
	 rHh2++GmZDvOBeyOi4YgtgzYR2MrppbjUkjd1eLje7j+TQjJFR6DQa3xGKLbix3PgvuGq
	 VLw2sj4JnRrx5O4ovwJXtscN+vCmaLUXvUcQ7jWPs24PG6Z0jWJzTzXedOBUcdKOJaa6z
	 qXYOold0E+QzvNDB3gK5xXKgAKTCgfdEUjQxYbhk/1nge7Uc1uBIYRdDb0pADuSbLBHd5
	 2ZC47Hc0fRqHG/cE/HdIUdArnnoRUlplotg+uYl7YZwaD9pYuyJB0kxN9GBICTNvK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788856;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=k2fo81eFplJpgtv+AO8ZwoWQN0C7pqxKh2F1qv8H3hQ=;
	b=iqgYNAgUbOX3PUYCHJCGpnMJd0dKowcrEt8SL4bqAHbcga1+qXa1r9eqFPeCwpsUjj/I
	 771EOf7dRzKmhgss34VteZDooaO6iiHwM2NY3lMbc2vf/VsKvS0YuA3lBgUkrHtxyVe4U
	 arFveHLmSc8YpzpI9ZUVlo4luG6aLvq5fyOnCnoeVXPVh1AVgDPWe4cAsolnZkjStbfcm
	 15427xvYG1o4HcIvw08zOp8oS+AwvRONa7ATb+dIZgSK60DjjAxVthtd6DH4vmhezps7U
	 eky+p9Orhflki5wO6ip9nslieneL1sv0b0QARsPoH4/0k9CjNzLFLiqgreSKUzeg4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=plZVvE60;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3A606A32A;
	Fri, 27 Nov 2026 14:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B3A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=plZVvE60
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jbb4z6vZjz9sqc;
	Fri, 27 Nov 2026 15:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795788852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2fo81eFplJpgtv+AO8ZwoWQN0C7pqxKh2F1qv8H3hQ=;
	b=plZVvE60NB05P0/X6Pwmazg3UbQHAvZEKIWP66m/nKg5UMUeRwo+cTYmxNElzdGGUHv5/X
	D6aTMB/tml8lq9ulno1qvFrfHMTsM59VvADlHeo+NpfBc2liIgJLl0tMwB31zMPZwlug6h
	CnHWvij9Arousc1I/xvvSiErW56vLJCWdCetQBlKsgWW6Ww+LkUhqoU1our4PgaMUKMs/X
	QShhArtCVbS4cyBJgLzCv68c4RJ3AAHU0uQqImmXnroclvtuIpcPBiO93JwNixKKJ6f7oY
	r7jSJUEJWkvPm5yHBc0e7QMjcJG/+T8/5VYtXDN/g9/reTWXpolgND3/DGZjTA==
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
Subject: [PATCH net-next v3 1/3] tun: don't disable BHs for the XDP program check of every packet
Date: Fri, 27 Nov 2026 15:14:03 +0100
Message-ID: <20261127141406.651406-2-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jbb4z6vZjz9sqc

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
index 7894dbdf0369..e2fe7174e438 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1721,14 +1721,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
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
@@ -1745,7 +1744,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 * of xdp_prog above, this should be rare and for simplicity
 	 * we do XDP on skb in case the headroom is not enough.
 	 */
-	if (hdr->gso_type || !xdp_prog) {
+	if (hdr->gso_type || !has_xdp) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
 				       pad, metasize);
@@ -1988,7 +1987,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
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

