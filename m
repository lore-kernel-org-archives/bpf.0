Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC283A168B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456900; cv=none; b=MRJy40tWmmYJc7LKtE77HebNHFZAbaClbX1OYWcrkAOaBbDyq6GPIOZmqTmmJN+IztfaYSry3NjrXJ9lSQ7C0VdZMfeK5AWjSEp/BFyKsXx8lojikzwg11A9wK/wJkcAh2Bs2XLkPLF5XtVDbFkdqPzcIssY9BDtzvJThQWBOgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456900; c=relaxed/simple;
	bh=ejk5Gsi9zXwe2+g0ywfpYwOEQvhNFY43DOuBImBTrQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECx7Md7+GTsAtUP1sWLuU1Aif3qoaXg7+UGxoOTAiChDdQUuzBejTzisU7Ol725p+jEVfx6YAvDp7GQL1fPbvOnbLgKTHcw/Ai5G1hZAGEgdcyD5yxJHc9X0u4k+WIlFaa+Tcmx/8776yphn0rfLYIQtA0YWPuYstiSUMLy7f94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWOzsMHv; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWOzsMHv"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so1633820c88.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456898; x=1791061698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFhEzdBq+cy3bpmTMq9OGxf6c4yjq3H6JpuiidJvbl4=;
        b=aWOzsMHvvPYcGBDVrs/g5SvOFXBt+eAnTfFdBDw0yogAoR0Vd+aJT2YtMiOK5juBnY
         8cVyi59W/i2zVlUPxYy/eNoXT+O28Di7PYS4pal0dmgjomBjSJ9uz/xDE6szxn+1VrUG
         gqQ+xCJp0ESmVGn3FiIXbcxcOzj6uX5lhcNIKzwS9dRVXaJwa6CcmsBX3s3RWAgdZzyp
         RoE832p16H+Naym6qwJBGIdFG2ICO/eEy+WxbtECo19gP9fOT0CLBJi4hD4TKF3O0yWl
         8SUSUH6TIsjTAfq8GGCd57JzmiWi/vET0ZlESb3zkYGocRo60HEh+qoEX7anEYLwbEsT
         T63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456898; x=1791061698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFhEzdBq+cy3bpmTMq9OGxf6c4yjq3H6JpuiidJvbl4=;
        b=F406oaIt8BxkvtCFQLzBFAFXpLwF7s13O7wjEJJTcz0j2PCwqiDa1pf1psLKPf6V2s
         KM6atS/zJldLVyQvc96D1mZcnOrPL2QqrZj8APYCor4OXW4cUBDg5dGMy2qMhfdgp6a0
         5hr2frzo4at72B0jUXxOF/1F4WGLvXwe0L58nDbtXieKh0LFtxlAyfVdZlh00enFQjOD
         YZ7bDeR0vcy/qBsuSyFlwwJ/pH5ZJPmNKWJCKenT3IaReqUbKqsGj7pxn1SELFUktDJC
         slCpprdAcb0lNpWkSIX9ppunLbpes47YirnQq/gy/h5CJXUzXxy++4zcNAP2dOvW5gTk
         PxhQ==
X-Gm-Message-State: AFuF++njxI2ZwwfRGogYPO0rs89Yv85n/TQGixqspCzk7BYZkpu91nFD
	7F7uWWzhk/rMKUH+miaGPjx9adch7ejoj6dw6kdaKi7SsmlM7b2ejr8X87gpmIh3Z/E=
X-Gm-Gg: AYBFou2e8+hNAa8ifbLqqnPPd/RWoUlqQqHZGbbYXWc29afAlKrAtjpOdn2GZGF1rsN
	9rp7oOYT3eTFyio+qaG1VR2HSsWfhNlfNWhYm9FJb6pKYiFoR4XEhwswra1+mWF5aJumlxauKCx
	isdkHt27zNIaQnSilnxSa7Lrjw/pJeEB/lG1c+hCmnObZAsWVRORX6Na0TiKVN1p8CNdvn0D8U0
	EniG/ET+b4ykZo4lJHkJepx+VkcgPMrZwIXjVCsD8ah7rQbOC2SXWs4K5ly1BkoNP13ROG9gq5e
	shA6b4Yv+uGTW9w1xhRj4itxlBx5f3NjMLnofW7dTk4xPX6rlaVPGwWF7puOhOjTf7mLzlY9KJ6
	1GVDdbkikfj8C9fFMZ59ltGLrbtGcG7nt4Lo4EA+VvuvJVUvp6g/FhHskoLTjozQqxBJHTFPtwO
	KoiwbWk55CR8Svj1kiXJByZZFZb0NMvAvlFN/h4ihEKbbE/zgg3egPGtLVh82ilKBbpdPWVeSb5
	xM5biDtRE26e/Dw6S+HR9sEwpP+auv4
X-Received: by 2002:a05:701b:2902:b0:143:56f8:dc5 with SMTP id a92af1059eb24-146cfec877bmr3840332c88.23.1790456898462;
        Sat, 26 Sep 2026 14:08:18 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm17886648eec.25.2026.09.26.14.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:08:16 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: ThisSeanZhang <thisseanzhang@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@openwrt.org>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next 2/3] bpf: Add PPPoE decap support to bpf_skb_adjust_room
Date: Sat, 26 Sep 2026 17:07:56 -0400
Message-ID: <20260926210757.2152159-3-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260926210757.2152159-1-thisseanzhang@gmail.com>
References: <20260926210757.2152159-1-thisseanzhang@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF_F_ADJ_ROOM_DECAP_PPPOE flag to bpf_skb_adjust_room() so
that a TC BPF program can decapsulate a PPPoE session packet:

    bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_DECAP_PPPOE);

The flag removes the fixed-size PPPoE session header between the MAC
header and the network header, and derives the new skb->protocol from
the PPP protocol field, so that the skb is consistent for later
consumers again (ETH_P_IP or ETH_P_IPV6; a payload with any other PPP
protocol is rejected).

bpf_skb_adjust_room() currently rejects any packet whose skb->protocol
is neither ETH_P_IP nor ETH_P_IPV6, so a PPPoE session packet cannot
be handled at all: no BPF helper can remove the header bytes, and no
helper can update skb->protocol afterwards. A TC program thus cannot
turn a PPPoE frame into a plain IP packet while keeping the skb
metadata consistent for later processing.

This is the counterpart of BPF_F_ADJ_ROOM_ENCAP_PPPOE introduced in
the previous patch.

Also sync mac_len after removing the header: on flows where a packet
that was encapsulated on the same host re-enters TC ingress without
passing through the receive path (e.g. bpf_redirect with
BPF_F_INGRESS), mac_len may still cover the removed PPPoE header.
The reset mirrors what pppoe_gso_segment() does for its segments.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/uapi/linux/bpf.h       |  9 +++++
 net/core/filter.c              | 69 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h |  9 +++++
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 30481d040..d4d3c5976 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3071,6 +3071,14 @@ union bpf_attr {
  *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
  *		  or IPv4-in-IPv6).
  *
+ *		* **BPF_F_ADJ_ROOM_DECAP_PPPOE**:
+ *		  Decapsulate a PPPoE session header. Must be used with
+ *		  **BPF_ADJ_ROOM_MAC** mode and a negative *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The PPP protocol field determines
+ *		  the new *skb->protocol* (**ETH_P_IP** or **ETH_P_IPV6**);
+ *		  a payload with any other PPP protocol is rejected.
+ *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
  *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
@@ -6335,6 +6343,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
+	BPF_F_ADJ_ROOM_DECAP_PPPOE	= (1ULL << 14),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 5b204e316..46986a84e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -48,6 +48,7 @@
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
 #include <linux/if_pppox.h>
+#include <linux/ppp_defs.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <net/sch_generic.h>
@@ -3590,7 +3591,8 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 
 #define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
-					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_PPPOE)
 
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
@@ -3724,6 +3726,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
 	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
+	__be16 inner_proto = 0;
+	u32 inner_len = 0;
 	int ret;
 
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
@@ -3742,6 +3746,33 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (unlikely(ret < 0))
 		return ret;
 
+	if (flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) {
+		u16 ppp_proto;
+
+		if (unlikely(!pskb_may_pull(skb, off + PPPOE_SES_HLEN)))
+			return -ENOMEM;
+
+		/* PPP protocol field follows the PPPoE session header. */
+		ppp_proto = get_unaligned_be16(skb->data + off +
+					       sizeof(struct pppoe_hdr));
+		switch (ppp_proto) {
+		case PPP_IP:
+			inner_proto = htons(ETH_P_IP);
+			inner_len = sizeof(struct iphdr);
+			break;
+		case PPP_IPV6:
+			inner_proto = htons(ETH_P_IPV6);
+			inner_len = sizeof(struct ipv6hdr);
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+
+		/* A full inner L3 header must remain after decapsulation. */
+		if (skb->len - off - PPPOE_SES_HLEN < inner_len)
+			return -EINVAL;
+	}
+
 	ret = bpf_skb_net_hdr_pop(skb, off, len_diff);
 	if (unlikely(ret < 0))
 		return ret;
@@ -3757,6 +3788,13 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			skb_dst_drop(skb);
 	}
 
+	if (flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) {
+		skb->protocol = inner_proto;
+		skb_reset_mac_len(skb);
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
+
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
@@ -3869,9 +3907,13 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
-	if (unlikely(proto != htons(ETH_P_IP) &&
-		     proto != htons(ETH_P_IPV6)))
+	if (unlikely(flags & BPF_F_ADJ_ROOM_DECAP_PPPOE)) {
+		if (proto != htons(ETH_P_PPP_SES))
+			return -ENOTSUPP;
+	} else if (unlikely(proto != htons(ETH_P_IP) &&
+			    proto != htons(ETH_P_IPV6))) {
 		return -ENOTSUPP;
+	}
 
 	off = skb_mac_header_len(skb);
 	switch (mode) {
@@ -3885,9 +3927,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	}
 
 	if (flags & BPF_F_ADJ_ROOM_ENCAP_PPPOE) {
-		/* The PPPoE session header has a fixed size and is
-		 * inserted directly after the MAC header.
-		 */
+		/* Fixed-size header, inserted after the MAC header. */
 		if (shrink || mode != BPF_ADJ_ROOM_MAC ||
 		    len_diff != PPPOE_SES_HLEN ||
 		    flags & ((BPF_F_ADJ_ROOM_ENCAP_MASK |
@@ -3920,6 +3960,23 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
 			return -EINVAL;
 
+		/* PPPoE decapsulation is mutually exclusive with the
+		 * other decapsulation types.
+		 */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) &&
+		    (flags & (BPF_F_ADJ_ROOM_DECAP_MASK &
+			      ~BPF_F_ADJ_ROOM_DECAP_PPPOE)))
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_PPPOE) {
+			/* Fixed-size header; require a full inner L3 header. */
+			if (mode != BPF_ADJ_ROOM_MAC ||
+			    len_diff_abs != PPPOE_SES_HLEN)
+				return -EINVAL;
+
+			len_min = sizeof(struct iphdr);
+		}
+
 		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
 			len_decap_min += bpf_skb_net_base_len(skb);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 30481d040..d4d3c5976 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3071,6 +3071,14 @@ union bpf_attr {
  *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
  *		  or IPv4-in-IPv6).
  *
+ *		* **BPF_F_ADJ_ROOM_DECAP_PPPOE**:
+ *		  Decapsulate a PPPoE session header. Must be used with
+ *		  **BPF_ADJ_ROOM_MAC** mode and a negative *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The PPP protocol field determines
+ *		  the new *skb->protocol* (**ETH_P_IP** or **ETH_P_IPV6**);
+ *		  a payload with any other PPP protocol is rejected.
+ *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
  *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
@@ -6335,6 +6343,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
+	BPF_F_ADJ_ROOM_DECAP_PPPOE	= (1ULL << 14),
 };
 
 enum {
-- 
2.47.3

