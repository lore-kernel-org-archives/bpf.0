Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDB30C177
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056043; cv=none; b=ovJgsGKY6apqb2OgE/XbvhE0N/HB5zIY7bPtswdbP+FgOfzGZpkHiJgjRLJKgjmOH7BRMUFfwhvd7lQ668qqBRnLI33PJm7LdZtu+krxz8z1Bnjk1HrtjP9O4bP0+Y4SdXtreDr9SQyCAeNXREUgZ/pRWTyn0ZwY/RKW+oORscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056043; c=relaxed/simple;
	bh=pOpGUUE8/iC5VeIUXiYiZltZf7SXseEJIVjAXm60gcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb9TZERkTNGLR3yocKfz0LqTSCmFW5B3l0WQMjat8E9kSDhVi+BikgzgDrEJ9WmojW0ii46N/Qqxo7J73Pzx08q4m6TeTout9QRizvBZ1aWEfzFvzqdEQUal/d7X5UDu9ZntQerp7qI4HxPPr70Ap1BH8C3P//h5OEeX5QbC4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2/dZTfF; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2/dZTfF"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-351224e684dso160280eec.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056041; x=1791660841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ljrdbbuL76o1sOfSaF6MaNRBRjSL76gjJ1aZd9gTWM=;
        b=F2/dZTfFbddcv96XzMZ1JBXwdCJklBE5rJiYJt7+QMVa10oadmlyebUgASPGVIbw3o
         q9+fHeWCTWo1CyxXGyT7l+q89HALLcqCxxm4RYAFEL50JK2oNlBub8p6D4ErXghHxOWj
         tmh7SsUkJcmES5rVbRptCUkwgKO3Y0pwrhLcnQDFGUDduig+8BeZ0tSUwwbRHAGuv+51
         tRsU4aE857r4R9+KfBtnaIo18erNv+8UAmXZt0LnnMOQ6jpedimr2nBAXKqgmYz6q3EX
         Z1BL+FapFvKxl90vzuh2yEMw9T0B4oEBOy6L8UUAY0cKP/4IgkAredqCFeBggKiGMCjM
         7xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056041; x=1791660841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ljrdbbuL76o1sOfSaF6MaNRBRjSL76gjJ1aZd9gTWM=;
        b=chPjRBiLRpWbVOnQkNYnOeDHGcSh+6dPXRTkEC82GBuHxVVDFLzLKkwt1g90TzbXPL
         r2FiE5oYE5Yb/giqyRWlX8jOLNM6/UkULudFD1c/58P6ipOVykuSWP84RpkUhOrVqggI
         +KvXzbl+oqGAJJztRbGjccCXKu88hqMIzcbj6x0U0vSymDqUTRbp//dJSQAvet6ZY6ut
         KnY3uhIp4Lz9EhvzHF02Vz2ipHq5sQI13vzGLQKFDe05+PtJ5TpvWENcgV+DoWj6B0sp
         HbanLaH784U8qSrtp4hi2hGH3ichAQevc/dHc5ov7CI9yazZy2r1M5h6TxGeKvGs4CY1
         8G4A==
X-Gm-Message-State: AFq9FYJtYTzfp+YeBbERLupKXaeRHwOLAyW4jOvHzmRh+uGfZATWc+Ro
	FSK0qtkIfS+AtJZ1mCvvNPUtQ5dVFZkEPQe5AY3Ni1adWUc45tKqzNihokAGUnypOes=
X-Gm-Gg: AYBFou0fTuCl4r4fnZdQ1E84X3kWZSsu5i/jJ0hsHXdhRfwze2lGbBv2SbFFBZ3PYyt
	GKakOQjgaay1BY9QbLNG9G5kVHM0teT9txIcKAuyL67svzh+vQiGVtyOaVLNTArNp60s++tx09H
	zMj1QvVMGN3zou60GzFdFOb9X1sEbmbvi5RL1dwsPozSf2VWkJFMhEf6IcnY8lo89V2V7egE7rl
	I3GK41ZaxpnrWiXBF6ISjEGx+SSwntX6e5+YMeWwQIjfHpLtFQCntqszzWC/pXRM9RcATa46Ram
	ksafFJPwtO3lsUcjQI/rloUL61eAjePRbV0l7Nkv8Wuz1zwjF5riNDZmmMU0PC7V8LQjHNRSpB+
	UEVZEJOaiKneZ09MSxqQl/i5M6J+eeSPkj4bRMxq9jTNHb4+kP1eu5D8wp2WZaZjPFa4SmLBJro
	JeRzYA3+tcGC1CCLxW+w5Qq/mF2hUHUKPNnCrpU9c0QboV7b/1IFQ9F8BlFUKl5cDq84WKvb7gD
	L3lMSabzhYviKme5yfLMmgBB4puSbk1vVKrx4Cm02Y=
X-Received: by 2002:a05:7301:7d09:b0:34e:6ffa:ad6c with SMTP id 5a478bee46e88-35111544b8amr3675218eec.40.1791056040651;
        Sat, 03 Oct 2026 12:34:00 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm17793271eec.13.2026.10.03.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:34:00 -0700 (PDT)
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
Subject: [RFC bpf-next v2 1/3] bpf: Add PPPoE encap support to bpf_skb_adjust_room
Date: Sat,  3 Oct 2026 15:33:45 -0400
Message-ID: <20261003193347.1137527-2-thisseanzhang@gmail.com>
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

Add a new BPF_F_ADJ_ROOM_ENCAP_PPPOE flag to bpf_skb_adjust_room() so
that a TC BPF program can encapsulate an IPv4 or IPv6 packet into a
PPPoE session header:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE);

The flag inserts eight bytes between the MAC and network headers: the
six-byte PPPoE session header followed by the two-byte PPP protocol
field. It then updates the skb metadata, including skb->protocol and
skb->mac_len. The BPF program remains responsible for filling in the
PPPoE header and the Ethernet ethertype, for example with
bpf_skb_store_bytes().

Previously, a TC program could add the header bytes manually, but the
skb would continue to be treated as a plain IP packet because its
protocol metadata was unchanged. With the stale skb->protocol, software
GSO may select a non-PPPoE segmentation handler and process the packet
incorrectly.

This makes the skb metadata compatible with the PPPoE GRO/GSO handlers
registered for ETH_P_PPP_SES. The PPPoE GRO/GSO support must be built in
or loaded before receive-side GRO or software GSO uses those handlers.

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

