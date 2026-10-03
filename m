Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D8382F28
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056046; cv=none; b=qpBVGqZZK0iT3gxToJJlk7CLIr48vS2zv6pMDe19vm0YW4vJ0slFj4khR8c5FM02s9/WJHTp6V9t/CjdwW7IF+L3LWaAt7I2AD5eFvQA1kqlLSm6oIzsVXFFipXKxQhoMszI6U3+59j1hZUez0kiHNas1s7Ag2iRKdAjYuP92GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056046; c=relaxed/simple;
	bh=6fHC9n0bhYHkBnFANiNRpA19ZjWW09asru6QSEbqfYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll6nUouUZ0WpfwBNsX4lqbb8ogEIj7axLPW/7hFV9u0bgN4Am3Zf9P6VOVME75alWPne8OQbr0bLaem708IOZb2lbB9Z9vbJ106HIZKocWw5+omvD6KCKDBmzInxLmDs1Sxk6RfH6NIx1rsq07sQ6camP9kPDxeIRMJeSGlcvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7mqFOyC; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7mqFOyC"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b3a9cd8edso229594eec.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056044; x=1791660844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIf/xF2c0If4aig7ELzVd0sq+HEvYp843uNztYLAcDE=;
        b=k7mqFOyCnHf25O4GMcsmpNYH4RWdpLGQOhbwmMQbHcWXmmG3ZFyuyljf01Ugl1oSWN
         uMeAKNKW15OMZkxQitQg0vNQ+5TLA5GjAJAAKa2n/YE87crEt3niC0Qro+DdFbHYhvIh
         Rg16K9dQMt9pwkb3aTMH+u9+uK6jUYS22vLe/EPs9xat0cj0EJZowhZcRJOoMy/p7HhZ
         khdvpQe+1kscfC6zvudq1GtWMzpQyx0c5qE/TdljaGI8AWanRO5lAHWmmr54p3ek+sNP
         g6+smoobJfPiQzNQ+n+3Hhi44jz9ujxuts+PU94sk5relkCs1H2XUq2NrS+CgF2Led/T
         Y9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056044; x=1791660844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIf/xF2c0If4aig7ELzVd0sq+HEvYp843uNztYLAcDE=;
        b=0DdadHD8aVws3XMgV8ZXfdUzW4L0eTxiDJrLdAf+4zveYGYJgCdaRMmDTDs4drur+3
         rmt98thOwPT29dZt/2yAOXu0CZfnivoQ7tziYEaQw0nSX+uh2h5oj+GoqRPdYYroK16r
         bn6T5+qYDoaxZfML6CHbKC0dtlH3V9P9CFjNVRSh7HuJgnoDU/6xtkitCSGUedSwltV/
         f5jO2Tlf1RFNp+1g2yy6hn2fkfIJRqBkHulPzRPvqVK5a9/NFrAJpaiUzj47QhxE92H2
         mbAuMHxf1jmfNphOZ0Mdf5Gfh1vLJH7Wye8Lw2RfqKB5h0C95kvXlOE/NsXDaPdVsmMy
         0+PQ==
X-Gm-Message-State: AFq9FYI1+yJpfg3dXZjCobtA0MacQ6As7Ek4j9aMu0zv3B4qO3sv0uNh
	kkaDR8a6z/5hvK0S//gMlIjLOg+/aLpMiFvA8lj9uXKCPHXpI/a0ovfz3vAGTQ3XR5w=
X-Gm-Gg: AYBFou2nb90plkk5955zvbzjZjg8rjXe1QGn9o1IQJ3Nprycgu66aO2AhMBDRiCHG0o
	JaT/Q928E1nwne8NmNLuNpRCOHnt3Rxn3+jwXTIYTy9gVYTS5tKA4IC/AzvihWhyxJGRnXtKD0T
	GWWV/LBZWNU17l093c0BNnSZQjEsCnGgX0H9g/TOL3/IrlMbll+1f6l5B0G8924mSvWoXdyDqdh
	2na4A82KUGtgY9os+P+cef0EW5HBmcHkBPEGZAu5UDbWo0t7DD/rOW+fFFTT4U2jwPCCoGfgppM
	vWyk6PL/mUkvJqB31kK4o6DUQPzcrvl0NIlIVRjLNi3zpCNthl08FYT/GzjbB6vOy1Ve5661ri5
	8iYqyseKVMRMRFo7TOr5clKgQdoW9tWSFOneFpnmgZs8KvGfI4Z5ZNkBAXV1ZFeKAiQDSZiG/5H
	At7Pa2HN17nZ0z20LWS2jcBH5/Nri0ARrq+1x8ran2Ut162h1mPx5oPCg/GgWMUj6rDy3AerF5B
	lM4PLW5Qfy9/F8e7EJaQO/IiUpj1k/N
X-Received: by 2002:a05:693c:20ca:10b0:34c:5841:3e12 with SMTP id 5a478bee46e88-34f2186556bmr6709000eec.9.1791056044067;
        Sat, 03 Oct 2026 12:34:04 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm17793271eec.13.2026.10.03.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:34:03 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next v2 2/3] bpf: Add PPPoE decap support to bpf_skb_adjust_room
Date: Sat,  3 Oct 2026 15:33:46 -0400
Message-ID: <20261003193347.1137527-3-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003193347.1137527-1-thisseanzhang@gmail.com>
References: <20261003193347.1137527-1-thisseanzhang@gmail.com>
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

The flag removes the six-byte PPPoE session header and the following
two-byte PPP protocol field between the MAC and network headers. It
restores consistent skb metadata for later consumers: the PPP protocol
field selects ETH_P_IP or ETH_P_IPV6, and any other PPP protocol is
rejected.

Before this patch, bpf_skb_adjust_room() rejected PPPoE packets because
it only accepted ETH_P_IP or ETH_P_IPV6 in skb->protocol. A TC program
therefore could not remove the PPPoE header and restore the inner
protocol metadata with the existing helper.

This is the counterpart to BPF_F_ADJ_ROOM_ENCAP_PPPOE introduced in
the previous patch and restores plain IPv4 or IPv6 skb metadata after
PPPoE decapsulation.

The flag also resets mac_len after removing the header. On flows where
a packet encapsulated on the same host re-enters TC ingress without
passing through the receive path, mac_len may still include the
removed PPPoE header. The reset mirrors what pppoe_gso_segment() does
for its segments.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/uapi/linux/bpf.h       | 10 +++++
 net/core/filter.c              | 69 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 10 +++++
 3 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 30481d040..52a509060 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3071,6 +3071,15 @@ union bpf_attr {
  *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
  *		  or IPv4-in-IPv6).
  *
+ *		* **BPF_F_ADJ_ROOM_DECAP_PPPOE**:
+ *		  Decapsulate a PPPoE session header. Must be used with
+ *		  **BPF_ADJ_ROOM_MAC** mode and a negative *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The PPP protocol field determines
+ *		  the new *skb->protocol* (**ETH_P_IP** or **ETH_P_IPV6**);
+ *		  a payload with any other PPP protocol is rejected. The Ethernet
+ *		  type in the MAC header is left for the BPF program to restore.
+ *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
  *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
@@ -6335,6 +6344,7 @@ enum bpf_adj_room_flags {
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
index 30481d040..52a509060 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3071,6 +3071,15 @@ union bpf_attr {
  *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
  *		  or IPv4-in-IPv6).
  *
+ *		* **BPF_F_ADJ_ROOM_DECAP_PPPOE**:
+ *		  Decapsulate a PPPoE session header. Must be used with
+ *		  **BPF_ADJ_ROOM_MAC** mode and a negative *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The PPP protocol field determines
+ *		  the new *skb->protocol* (**ETH_P_IP** or **ETH_P_IPV6**);
+ *		  a payload with any other PPP protocol is rejected. The Ethernet
+ *		  type in the MAC header is left for the BPF program to restore.
+ *
  *		When using the decapsulation flags above, the skb->encapsulation
  *		flag is automatically cleared if all tunnel-specific GSO flags
  *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
@@ -6335,6 +6344,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
+	BPF_F_ADJ_ROOM_DECAP_PPPOE	= (1ULL << 14),
 };
 
 enum {
-- 
2.47.3

