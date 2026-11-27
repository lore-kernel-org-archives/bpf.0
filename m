Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776856;
	b=a5DcIzyX1OuZYkSQTkddkFsdl90lDQSrLgRuJLG1fqEU1kG8j5CnKmryYf1Pd7rJ+/40
	 ZS1L2BTqe8QAWSg4gJW/innKWis9zfkaFTZlvoy5bMW0n94e7pZYMkxwte1PXYpeLJi2K
	 I+pyT5MQml1laWvQwC3cHsobwAZasQ9ET4AhQTr2JUm8wc3o2Cnujghrm6DW86PxTn3uV
	 SVo8Oz1//3mDa4i6e65h6B5jV5sG1Cvcq+oY/yENLiOsH3TfHEQZPlwpbwAl/2hXVr88M
	 X2RPDRT4kuXvAF9VU8SIvhszECfv1V/zzoCQimnVxcsH6rJH2DzwwKdXJApKAwXGuVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8A+EQrzJxMOhp05uqIiyAdwIGwBoCs9Lfd8U4FtouNs=;
	b=M3cVdKTUt72xCaSlL92gQb0zIx2+vVBqagAduF+vYTreKA2vvl5oNmEYfjnv3Woze7Q6
	 5PNMk45BkPVvl0rFSgI5CseX5QBpRNH0W6t0uDu31D4zWwjE7jjKjoEYT2dZ5qYQsWPa7
	 FPuoRI5W5F1C8Kp6ubLnbBOP+5Ow05HE0dK+h5RigI8tIgR4fpMyHibynUJeSuDO4yJry
	 d/B+OW7ynp433DGzf1wimxpA5zjt2RLl/id9c3LxlzqApIUB11Kl0ulULm8JdSHp/r8+M
	 ih/UlthTd1OZUgj+Rk4ESbodhooaGxn0pL1gThm6Bg+/dytc+bfsaFmckQ3fn7csCuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=roQiyCLR;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CA606A31E
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 196CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=roQiyCLR
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so1886876c88.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776855; x=1796381655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8A+EQrzJxMOhp05uqIiyAdwIGwBoCs9Lfd8U4FtouNs=;
        b=roQiyCLRC4uvpI5vicgQSn0D6YDyr292LYaiB4arRewxkM5Kko8Be0nR+WndvstWOF
         qUxf8uhP7eGSO9j/ADZoYb6YeHrZk11DlnJTD1p/K+VC4ELbctqXUHFFy5L3iVFlpUyH
         l2mG+tdARplQCQrasDGvJAVDkcvG96MUEEz8EwD8FLTbmTZf36jgpqF55mhWtu8rfPMe
         ovKCgBMixV6+0uL61QLUJRnAkAZn6y5JmldEPDa6FbDPUuutuC5Hb6Q5yde/oAu2PChD
         sAQAi8JdcC1lV3a3xNPR8OdzRW56V79t44RyhhP8SwaSxuxt0iFbOJ8WpLVQuSeIr2Zm
         cm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776855; x=1796381655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8A+EQrzJxMOhp05uqIiyAdwIGwBoCs9Lfd8U4FtouNs=;
        b=iJIfLOx81RF7Y0IAjVqylXjXaihVRBhJLabMWHbXNWYW/9Arfsx1q7Nb1m3ni2mimx
         kV7sVmcaLPLxBb6LByCpgXrbI1Ugn3q0uDSiANVQvc93K+IQFi+FUQ7b4eQFAZtIkpvG
         nESXndXFR7CtrWlFBgmb6PriHT14Vb+ZfMrk5xhIyIRfem4DYa6HkmiMQeFB4NMShgTF
         JYtL5uzN+2G/PLPtnsUtuB0XIXDXogUePXAAkjFgnAfmGS4e6ezMa6TLOdLU9yVtaA29
         6UayN6xs5j9QFUH9AgqZWUEGtzN1DYYLI4jjBrFyQbxQQoQt07cKhjwR+Z1iV3So5ffA
         5S+Q==
X-Forwarded-Encrypted: i=1; AL+hErGvYXwhgVJ+Nrq+etmZ4rn3ss9DJfIzCWDAOE3hPNxeH7Uf9yr8uAmSadn4IKwimyBp1As=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lcfbmsWSJhss6zyhiaMgC0fN/dGczy8zKw+Zuu0oEDrPBrMGI
	lUdKrTdXDSWFapKuMp5fCFmfXUfKECwzLS7GSLiTBIwFBLJUG5/BVUD3
X-Gm-Gg: AZFdTZcMnvJrtvaUjiEYfyqAHtDr/lAiGC/AyyYmwfFF/DZeXWcQp6+PO4SphLYx5Bj
	eGFccX9yZWSK6WHRQ2hEhrjFIforjD0Z8aUkZsoco3gwZh42jclzpOlrZ/BGx+2en67KK7lPcUc
	2Cqr+b6eVcdk5PX740YWO8qtA4RvErmpdaK5zvzAPoL5A5CLQBPD7syyxTZ86qd0b48BOz0CvTs
	QZsaz13LqPR2lFGwfDgZ9nAGNYy0t7Alwe2CZChRe4C7YMmkVOIwh/WjivSaAWBmzEK0WODtYqs
	knu8romv6YW+g1PUzlK8+MCOHcHKvhG17YAAn5jTolqYIP9O+2giuSFXCEPGspI0pcnfp9lLOH7
	Wf3+uA7RuzNCRDGvkm25m9oPMbUnDKq//g4uHZgxFXRAaMbbpjOziLvisJEp0NCS76esoIiJE1P
	0ludZdriJSSHXlMEiXFGPpt4QSr69sw1Cvm08DsnZ5eCTEpKFgJJkjTk+VqnZY6y2S9bbpXqaKY
	9Rd29wrndVRAjebilMwRvWrQsXRjYIi9ZxoUXFGnen+gPpleXLNZZkIrYbt5cp3clnoI5bOuEsU
	aJPZH+fZReb97ekNWAGcudgj6QfW1EQ8AUuZucRtUXnMcDX+LAnUfq/GJdPYuDD24N3BXd2QlZP
	ie/h493c9oUQBh4Wv86wolPw5vGYCWo3UtCDTRWZFzDYjmbonMKctcgNYtIZRiiXYjJe+lz68
X-Received: by 2002:a05:7022:3f01:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1b55689f73amr27029644c88.7.1795776855158;
        Fri, 27 Nov 2026 02:54:15 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm54992326c88.2.2026.11.27.02.54.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 02:54:14 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: willemb@google.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	bjorn@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] xsk: fill in header offsets for TX checksum offload
Date: Fri, 27 Nov 2026 18:53:47 +0800
Message-ID: <20261127105347.72997-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261127105347.72997-1-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
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
ip_summed are set.

However skb->protocol stays 0, the offload never actually reaches
the hardware and checksum ends up being computed in software every time
(please see skb_checksum_help() in xsk path):
1. harmonize_features() strips the checksum features on devices.
2. ice_features_check() rejects the frame on NETIF_F_HW_CSUM capable ice.

The frame layout comes from user space, and request.csum_start is
already the offset of the L4 header from the start of the frame, so the
transport header is known exactly.

Only the L2 length has to be found, by parsing the Ethernet header and,
when present, the VLAN tag stack. skb_header_pointer() is used for that,
so it works for frames whose data is not in the linear part of the skb.

skb->protocol is set to the outer ethertype, as the rest of the stack does
for in-band VLAN tags, so skb_vlan_tagged() and vlan_features_check()
keep seeing the tags. can_checksum_protocol() and the drivers get the L3
type through vlan_get_protocol(). The mac header is anchored by
__dev_direct_xmit() in the previous patch.

A frame whose L2 header cannot be parsed, whose L3 type is not IPv4 or
IPv6, or whose csum_start does not leave room for an L3 header cannot be
described to the hardware, so it keeps being checksummed in software
exactly as before.

The patch is based on Maciej suggestion: 1) do not rely on mac header that
probe in AF_PACKET uses, 2) use skb_header_pointer and walk vlan tags to
inspect the accurate location of each field that existing drivers
possibly use.

[1]: https://lore.kernel.org/all/arKm5gCaERk6MaGA@boxer/

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/xdp/xsk.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 52d538160e0a..8f566996a6dd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -11,8 +11,12 @@
 
 #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
 
+#include <linux/if_arp.h>
+#include <linux/if_vlan.h>
 #include <linux/if_xdp.h>
 #include <linux/init.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
@@ -1027,9 +1031,48 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 
 static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
 {
-	if (unlikely(pool->tx_sw_csum &&
-		     skb->ip_summed == CHECKSUM_PARTIAL))
+	struct ethhdr eth_buf, *eth;
+	int nhoff = ETH_HLEN;
+	unsigned int l3_min;
+	__be16 proto;
+
+	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
+		return 0;
+
+	if (unlikely(pool->tx_sw_csum))
+		return skb_checksum_help(skb);
+
+	if (unlikely(skb->dev->type != ARPHRD_ETHER))
+		return 0;
+
+	eth = skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
+	if (unlikely(!eth))
+		return skb_checksum_help(skb);
+
+	proto = eth->h_proto;
+	if (eth_type_vlan(proto)) {
+		proto = __vlan_get_protocol(skb, proto, &nhoff);
+		if (unlikely(!proto))
+			return skb_checksum_help(skb);
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		l3_min = sizeof(struct iphdr);
+		break;
+	case htons(ETH_P_IPV6):
+		l3_min = sizeof(struct ipv6hdr);
+		break;
+	default:
 		return skb_checksum_help(skb);
+	}
+
+	if (unlikely(skb_checksum_start_offset(skb) < nhoff + l3_min))
+		return skb_checksum_help(skb);
+
+	skb->protocol = eth->h_proto;
+	skb_set_network_header(skb, nhoff);
+	skb_set_transport_header(skb, skb_checksum_start_offset(skb));
 
 	return 0;
 }
-- 
2.43.7

