Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC394A1E00
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456896; cv=none; b=QvApyFjG9L56JsZzNSPf7l5glL/DtIIbzWed9XBqmBUYd/aKcHXpvxtz4P5z/wKMmSwn2dmTTErqnnMPE+FJgzeV8ZvSVitUsDWAxlrC3I8hA4xYThIR5GI1N1UUaJQgdUzCuhO9Ua0Z8dPFa1WxlrEkSBbbesvWlzoI0a4XWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456896; c=relaxed/simple;
	bh=JeKRfAmmE91MxprxdKAsQfplBSI9p7Xp46i94pnx2xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFd4gEDpzmDsbP2xZUqTsP8/8avi8lZP+ORIiKD3lEXxdm3tyfwOqUXl5223lBZqax/r4j/9wIyXV3R7aF0a1G/IOJAgfcEQZj36mRyECiUmuj9FvDhiydN0l6SwpafLcc1neZdS11EsjxAACgkBMNF+fSUrZtQnMPZrVK0X3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC8J7uQ3; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC8J7uQ3"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2691624eec.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456894; x=1791061694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5jLr1UOPOpYPQnBcdUz4e44kGyYHeunrc1rNWkKIT5Y=;
        b=MC8J7uQ3anLgyydiRrT6l0dvQ1rJ8ok9HMsvX5p4QF3Ije1fNmk64RLyiJwc5aX9OA
         w95IGFGI/clqXyLduukwYkzTezDtc4JNq+/S0aJ0X0BmNAcmCiE20Z2APu0Wc/NeNy2s
         sJJTthDMPWXPSASE8XHndeYpSUNWb4LnQmU0TKwvL5Re4NZa6kPTeG+cJUoaGUn7DX37
         9MKhAr9mI0gzNsD1zuy7TNP3ZbkIbdQZfEmd689NVFQ9EVCY52MyyLCJQHpYYGxGTniq
         qtf78Wg4XvvEfG7w7j80/wzNkRXbln5HrKRshlq2mIp6dt7Q10fuma2H3UiImDls3KYd
         jXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456894; x=1791061694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5jLr1UOPOpYPQnBcdUz4e44kGyYHeunrc1rNWkKIT5Y=;
        b=c5vNskDQ796BxovPsYerzsdqz3KJzK58xMoCZi6fC2eS+EK3JnrtxNRQqqOiue/KoX
         +L0p0i9JwVNdFgAt0z1cDl5CKvlaAr+mCnKX3UMuusBAPiHl6nN3DoE2U9kIMcsj/Reo
         JpifsA0b5bHPnslWl/BEmYcjv3comH1acKNxSTKrUbxxsDNmjgXofTfabMBdoBilRhpt
         JRRC4gLMYlasvUuWHnJTdDltNMUaJLD9+k5HFEI1oJBKDCX1BtEj5bap02aloCXtq7Ma
         6QkICLAZDL3BGJFfMqyjrEUH/6et201lj/fmUYhfHaJ2dpS8luRm3cAylj9tmCAEzfGq
         cfoA==
X-Gm-Message-State: AFq9FYI82wR17V/Lvzk1u5MW9Bvb4e/5QIhkKuErTcDjZFMMzCPvLz3s
	dyUUEWwHRceCnlSWdk9rbqXS7bWjF2jC/1fc3wcGQXlPc5uc0B1qqw1ERW9xYrLZeXo=
X-Gm-Gg: AYBFou3wPVJMgkpBJcybmojK8YydPYLnky/8b3xqRALccIIxMaU+2tMXcQfV6kZc4p7
	MIqdK3ruiMsV1ZTw73tdHy/3MvBeyXaXt3ut2yTD1c2IfZcR6x1qsxvRsWo3Qm0CQONYMuSaL93
	+TqcRuYuld90KhndM4358UMCSbAii1PHBzMuXqWreoTMGrtI8ehVS11EInfGmrHjztiV4LKvkXG
	ZDcAfOSZmnwlBhLcYn2O8IhnD2ihcO+WELiebCI9EuG/OPTLzGgrJDND6KQo1AyP/t5hg6Mkc/c
	cBtmdkWYC4VHVgXTqgEb6QS7h+dweOw0UWNQ21y4mjnh9NSnxlLmDAgRnJGy7HIfOxjkJNgyViU
	h0SxQelw/oOT7oHajfx/1bJLd4MrurSnCvqouC1KzNe878nVJx1SAijaXnblBPYpqA/XtXWr+Qe
	kcL44PL/pES4LwF4X3UgZEfjSHRS1093eTvoJ2PymIi53bFYObCUb67kyHEG9qrfu4a2S3qO9Dc
	bVFlkxGjfphk9dZNxMtHfv1yoUb9LD+
X-Received: by 2002:a05:7301:b0f:b0:342:451b:c0cc with SMTP id 5a478bee46e88-3426fbbef10mr4318105eec.6.1790456893721;
        Sat, 26 Sep 2026 14:08:13 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm17886648eec.25.2026.09.26.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:08:10 -0700 (PDT)
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
Subject: [RFC bpf-next 1/3] bpf: Add PPPoE encap support to bpf_skb_adjust_room
Date: Sat, 26 Sep 2026 17:07:55 -0400
Message-ID: <20260926210757.2152159-2-thisseanzhang@gmail.com>
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

Add a new BPF_F_ADJ_ROOM_ENCAP_PPPOE flag to bpf_skb_adjust_room() so
that a TC BPF program can encapsulate an IPv4 or IPv6 packet into a
PPPoE session header:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE);

The flag reserves room for the fixed-size PPPoE session header (the
6 byte session header plus the 2 byte PPP protocol field) between the
MAC header and the network header, and updates the skb metadata so
that the packet is consistent for later consumers: skb->protocol is
set to ETH_P_PPP_SES and the network header points at the inserted
PPPoE header. The header content itself, as well as the ethertype in
the MAC header, is left for the BPF program to fill in, e.g. via
bpf_skb_store_bytes().

So far a TC program could only add the header bytes manually, which
leaves skb->protocol and friends unchanged, so the skb keeps being
treated as a plain IP packet. In particular, software GSO can select
a segmentation handler based on the stale skb->protocol and process
the encapsulated packet incorrectly.

This pairs with the PPPoE GRO/GSO support in the PPPoE layer, which
registers a GRO/GSO handler for ETH_P_PPP_SES: once skb->protocol is
set correctly, such packets are segmented via pppoe_gso_segment() on
egress.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 net/core/filter.c              | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc0..30481d040 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3036,6 +3036,17 @@ union bpf_attr {
  *		  Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
  *		  L2 type as Ethernet.
  *
+ *		* **BPF_F_ADJ_ROOM_ENCAP_PPPOE**:
+ *		  Encapsulate the packet in a PPPoE session header. Must be
+ *		  used with **BPF_ADJ_ROOM_MAC** mode and *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The room is inserted between the
+ *		  MAC header and the network header, *skb->protocol* is set
+ *		  to **ETH_P_PPP_SES** and *skb->mac_len* is updated
+ *		  accordingly. The PPPoE header itself and the ethertype of
+ *		  the MAC header are filled in by the BPF program, e.g. via
+ *		  **bpf_skb_store_bytes**.
+ *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
  *		  Indicate the new IP header version after decapsulating the
@@ -6323,6 +6334,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc62167..5b204e316 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -47,6 +47,7 @@
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
+#include <linux/if_pppox.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <net/sch_generic.h>
@@ -3583,6 +3584,7 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
+					 BPF_F_ADJ_ROOM_ENCAP_PPPOE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
@@ -3688,6 +3690,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			skb_dst_drop(skb);
 	}
 
+	if (flags & BPF_F_ADJ_ROOM_ENCAP_PPPOE) {
+		/* Network header points at the inserted PPPoE header. */
+		skb->protocol = htons(ETH_P_PPP_SES);
+		skb_reset_mac_len(skb);
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
+
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
@@ -3874,6 +3884,18 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
+	if (flags & BPF_F_ADJ_ROOM_ENCAP_PPPOE) {
+		/* The PPPoE session header has a fixed size and is
+		 * inserted directly after the MAC header.
+		 */
+		if (shrink || mode != BPF_ADJ_ROOM_MAC ||
+		    len_diff != PPPOE_SES_HLEN ||
+		    flags & ((BPF_F_ADJ_ROOM_ENCAP_MASK |
+			      BPF_F_ADJ_ROOM_DECAP_MASK) &
+			     ~BPF_F_ADJ_ROOM_ENCAP_PPPOE))
+			return -EINVAL;
+	}
+
 	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		u32 len_decap_min = 0;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc0..30481d040 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3036,6 +3036,17 @@ union bpf_attr {
  *		  Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
  *		  L2 type as Ethernet.
  *
+ *		* **BPF_F_ADJ_ROOM_ENCAP_PPPOE**:
+ *		  Encapsulate the packet in a PPPoE session header. Must be
+ *		  used with **BPF_ADJ_ROOM_MAC** mode and *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The room is inserted between the
+ *		  MAC header and the network header, *skb->protocol* is set
+ *		  to **ETH_P_PPP_SES** and *skb->mac_len* is updated
+ *		  accordingly. The PPPoE header itself and the ethertype of
+ *		  the MAC header are filled in by the BPF program, e.g. via
+ *		  **bpf_skb_store_bytes**.
+ *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
  *		  Indicate the new IP header version after decapsulating the
@@ -6323,6 +6334,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
 };
 
 enum {
-- 
2.47.3

