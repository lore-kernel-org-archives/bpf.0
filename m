Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509346;
	b=XmPxhURhPjPOZCjZeaQMbo2fu8Yh7ReEuONZ5p5YDuqJwY8KWVdmRtKaCjCMplaiU9H9
	 zu+mjK38S42hE//AnnaiYJVjrMTUll6daKXbaq4GgmcTV7M2XOYhRP0IHTclztpjYDM8C
	 uTg0qZE7f7uXkQMSAyAgzp2oNltO95zKVPmMG9/sTWfQHWQAgDCnbzVhbKsrrl3LiEdXb
	 lfXA+ngkscjanVsMleDYNDC5OhixbHn1JjYS+3Hx0CVXNlCyRzFLzWw1i5OrgJ+CyzkT7
	 7WRpMp1F9xaaBaFDzZgLotpkKmgNk/GL/qhFKl9wyFEyK+EPeUaPMuzLEp0IV441Oxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
	b=x3Sz37t/LEfYaQUpsHQWAc6wcHn88p0+/fK4Bo3rRqwlMMdt0tqz1ol2QCscA5+jIWOo
	 5Vg5qzF9vQcLKx2UurBc9pwwloc51XqfsSOkOxdjt8w+9OP+TFSunnC3iasfPZyMD2Vjv
	 /Ce30fTCmQUXoh78dM6+M73eA1H87oqlLzZJ88ihv561SJFHIwitApAZpNSjc1k20XYoA
	 DsnN+pKj3nDKWgxG4UD9olMF0x8pOmfZuXyz//tIbGp3EZ2L+851sk8tPz+InjW66TMez
	 TMXUA/j70iF1NJqTuz/dpNq2Y5n7eUlmZaOo8XVd+44MQ1DmP8t+FRgYF9+081JMOZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiDm7SXd;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BF606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82BF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiDm7SXd
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so1993144eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795509344; x=1796114144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
        b=BiDm7SXd0FZcFuAA7mPowtUz3t+gCus/FpUals00iUR4Rxq1X/PCGRPOVzYmxWGTNb
         xlKvf0OVES+TriacQ3hV0ZEpcmwwBCvZN5n4FftfaDUe+hT4ovb7jSxT1LNNHHOak3pS
         D94SVu4y6lKy7GPZoPb3xfKghkpcWBO0EuzHJJh+uNQYhmtpAqLwJTPf2ku2BV8xEkzF
         XFH6DrPQyG7BeJ5VCd8vSnflV1pG0X5XLhLbVX+t+kPpaav0nFulscHdrO3hoTO8ORmf
         sBpbcmVViHjrmYtufIy+YhsFVKodxa7IhJsjzSmUR8RCH031avwKieiIHIRnHgTgDFan
         1itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509344; x=1796114144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvPBfBZyrWo/IURjWNoOSH2bYaPSh+KUwqyaCMmfae4=;
        b=HPQ3mllE7CY1+2G6ZPvSVeMnrsPAx9iYNoTARy4vsI9Wyfaum2usVMVuKt/rp9Rvoo
         GF6bbcVXp+dHAVH5vicBFZsqo55pPjSHHmzIaFjI16A/kREjLsNTRtkkR1854LWGUN84
         ZqFCeuP54BgH8eUYh12Zk0Cm9g7d3GbO4wW71JoEB13wqiEGUrYR9syowViQTJobBh9z
         TWL7fvmBEBEYTSyL1dhKwt/6tcy5SE4c1j/3L8B3IUzC4nW2OSyRs8ECAY8LYS9Pl9F9
         s5AUTraS7Y0YF/XYv8GkRCGbZbz3n30rO6rY0IMnsqdH+jXjyUmjkACrpMfH8AqEKKLn
         xmEg==
X-Forwarded-Encrypted: i=1; AL+hErFo6sTZcNG7WP+Hy5sxMQAZvNqfE2EiSw7wXZxFrk0RW26B8+JD+ZCIy1KXquLkyy/8XVQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UDiHGmXf50feo8AGeWIEAUxsaa0yCHyybpicarMBmMuhXuMcw
	cy5IQZ2JYkC21AnmDRotCWOigSjzdcOc5kz5H3I9Ud4g+FnawAIejMkr
X-Gm-Gg: AZFdTZfLhrGuMzwbpCsbnxXqxrcFyNv9h7mIMHCe/4F6gBlkNctZCWp5MLRvpzWkwWn
	19KHRS0TL2siqbof+DwhWq5UhYk6XjlMz7btIeiYCXN99PdxKuh9t3OeScNLODiVR3dAuYlgd4J
	MpIIHC7JwfAfQStloLJTiMNJcSC6kU1lk3iYDzvM0PXWil+zAfGtUo1NEBK8sqTdLA9X8vS01Ya
	5tFTnIjedi0V5N8+RSRGwTxCAEMSTkOHOsy3uTT0AB+rrEUVMYV8jCB6Opsfv4ZUrLdog1Td1UO
	36JnorOCV6n/C6hOTv6bnsIBm1znH1IhfHe0MU2UhTbilapawf2rVgo7/Fd+AGxj7U5mX+/7QHe
	HUqnOMGYwWFE8wOVXvKD2AQ13X/qfgDcxiC5PEFwkRBg9+yRk2SiUVNfhwonfcjwaHBo7sekiaH
	COy/cV646mPfg+9qNefG6G7SB0lsQfj2d1olFnnPD5k5BL1j/izgyBJCmud2oYrZCoiupVDMc7C
	VS7jXS1OE+57lJfPWYjF3UFA9zR+CzphFG2gmFFuYwTXBmMHIBwDRu169/bRVkb+bhJIhSu85ln
	3D9mF6dnAc0OVvopPC3uIkLcqgsALMRklJIFadDaeuGGCMtZXrSWs8EmFo7o+BMt85DHqlQZeb2
	wYM2ox+zASf7I+uoR9bgE4KXlH85AdyIuM7oirWbFa9ZuNKftO5ScWuOLEgm7kW/25afddVkDiF
	0jlRk+OiQuFCI8A6Tn9Q4=
X-Received: by 2002:a05:7301:c016:b0:386:5adb:ac01 with SMTP id 5a478bee46e88-3865adbb1aemr14055119eec.24.1795509343906;
        Tue, 24 Nov 2026 00:35:43 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm50849718eec.10.2026.11.24.00.35.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 00:35:42 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] xsk: fill in header offsets for TX checksum offload
Date: Tue, 24 Nov 2026 16:35:20 +0800
Message-ID: <20261124083520.45547-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
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

An XDP_TXMD_FLAGS_CHECKSUM request is turned into an skb carrying
CHECKSUM_PARTIAL by xsk_skb_metadata() where csum_start/csum_offset/
ip_summed are set, which will be handled in the csum offload like
ice_tx_csum(). Drivers like ICE do read network_header/transport_header
fields which actually point to the wrong place, leading to wrong action.

The frame layout comes from user space, and request.csum_start is
already the offset of the L4 header from the start of the frame, so the
transport header is known exactly. Only the L2 length has to be found,
by parsing the Ethernet header and, when present, the VLAN tag stack.
skb_header_pointer() is used for that, so it works for frames whose data
is not in the linear part of the skb. Also, initialize skb->protocol
because of some drivers (e.g. mana_start_xmit()) using it.

A frame whose csum_start points into the L2 header disagrees with its
own metadata, so it is rejected and dropped instead of being handed to
the driver with a layout it cannot use.

Only Ethernet framing is parsed while other device types keep existing
behaviour.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
V1
Previous discussions: https://lore.kernel.org/all/arKm5gCaERk6MaGA@boxer/
The patch is based on Maciej suggestion: 1) do not rely on mac header that
probe in AF_PACKET uses, 2) use skb_header_pointer and walk vlan tags to
inspect the accurate location of each field that existing drivers
possibly use.
---
 net/xdp/xsk.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 52d538160e0a..7c846f02972e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -11,6 +11,8 @@
 
 #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
 
+#include <linux/if_arp.h>
+#include <linux/if_vlan.h>
 #include <linux/if_xdp.h>
 #include <linux/init.h>
 #include <linux/sched/mm.h>
@@ -1027,10 +1029,37 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
 {
-	if (unlikely(pool->tx_sw_csum &&
-		     skb->ip_summed == CHECKSUM_PARTIAL))
+	struct ethhdr eth_buf, *eth;
+	int nhoff = ETH_HLEN;
+	__be16 proto;
+
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return 0;
+
+	if (unlikely(pool->tx_sw_csum))
 		return skb_checksum_help(skb);
 
+	if (unlikely(skb->dev->type != ARPHRD_ETHER))
+		return 0;
+
+	eth = skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
+	if (unlikely(!eth))
+		return -EINVAL;
+
+	proto = eth->h_proto;
+	if (eth_type_vlan(proto)) {
+		proto = __vlan_get_protocol(skb, proto, &nhoff);
+		if (unlikely(!proto))
+			return -EINVAL;
+	}
+
+	if (unlikely(skb_checksum_start_offset(skb) < nhoff))
+		return -EINVAL;
+
+	skb->protocol = proto;
+	skb_set_network_header(skb, nhoff);
+	skb_set_transport_header(skb, skb_checksum_start_offset(skb));
+
 	return 0;
 }
 
-- 
2.43.7

