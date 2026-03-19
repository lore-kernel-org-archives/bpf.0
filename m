Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9E2D8DBB
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963948; cv=none; b=NwvlYvtiF98AXHep7YT7hcodliKGo2ZEAJtxN5ieOqmErEy1tHtqIgDqINaAhGwYLV9i6AiuMWsWnxCLORtphXNKBr65+IDcNt9Qyf7gX1rp1hdwzynJYyf4q4VHYiWxCMHKAV0WLq6jfSgfNsRlxZ/KxjwqzS3vkl97rSppYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963948; c=relaxed/simple;
	bh=we0dHfCoCw2kmkfJPJLdtBskAlc698b2IiWRrCJR4Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iprbzx0lLukX7BW4GQ6afSFLSh2FL5uVrHPXhVzfWcDMtrEtRqa4gvPDDC5UaU4XQ7JhCD09xGa6rflW7CWNoisbnK4ER74o8afSa5gBXog7Lc1OOUb5MtHcHh/VgrbMr0su9kk4/YT7bHopWpGgiTXF48bhtf45TvEDCdDPCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsNVjKSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsNVjKSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FE7C19424;
	Thu, 19 Mar 2026 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773963948;
	bh=we0dHfCoCw2kmkfJPJLdtBskAlc698b2IiWRrCJR4Bc=;
	h=From:To:Cc:Subject:Date:From;
	b=LsNVjKSK1LOX482f4y6OnsPFZEp9GEn6S241DU0GqINMc6sd80kTph5RQzaonCIHw
	 HcDg7lQuf2DAGbkjBukUuWae9h2YoiUUbGUnTfH6h1EZNcDuopENRA6dmmDD9Jrt5L
	 eJ3DLRHc/oFcGaCfxBsyPbY6n5ojvsZo26b/7CD+59sqrM1MP+9dzhI0TFYoVcdufR
	 faEk6t8bTzYpFP/qVjKGzO52h1zMXKdTxLyhVntrBuj/A+s53/a0SXYdxJjGbmHUZT
	 2wigI8bICxVPN1E5olix4dk9GL9AUY9Qppw3I3i43nC1NmR3WdkxD1N8aNw609iJA/
	 7+14dOLKKqq9A==
From: Jakub Kicinski <kuba@kernel.org>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	maze@google.com,
	willemdebruijn.kernel@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 1/2] net: clear the dst when performing encap / decap
Date: Thu, 19 Mar 2026 16:45:30 -0700
Message-ID: <20260319234531.3022634-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
added dst clearing when a BPF program changes the skb protocol
(e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
the L3 protocol actually changes to keep it minimal. As suggested during
the discussion (see Link) encap or decap operation which wraps or unwraps
a same-protocol header may also render the existing dst incorrect - even
if that doesn't result in a crash, just the wrong route for the now-outermost
IP dst.

Make dropping dst unconditional for bpf_skb_change_proto() and all
L3 encap / decap ops.

Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: maze@google.com
CC: willemdebruijn.kernel@gmail.com

CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bpf@vger.kernel.org
---
 net/core/filter.c | 50 +++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2f023999f046..0f8c508c5f8b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3257,13 +3257,6 @@ static const struct bpf_func_proto bpf_skb_vlan_pop_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
-static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
-{
-	skb->protocol = htons(proto);
-	if (skb_valid_dst(skb))
-		skb_dst_drop(skb);
-}
-
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
 	/* Caller already did skb_cow() with meta_len+len as headroom,
@@ -3362,7 +3355,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
-	bpf_skb_change_protocol(skb, ETH_P_IPV6);
+	skb->protocol = htons(ETH_P_IPV6);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3393,7 +3386,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb)
 		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
-	bpf_skb_change_protocol(skb, ETH_P_IP);
+	skb->protocol = htons(ETH_P_IP);
 	skb_clear_hash(skb);
 
 	return 0;
@@ -3440,8 +3433,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
 	 * need to be verified first.
 	 */
 	ret = bpf_skb_proto_xlat(skb, proto);
+	if (ret)
+		return ret;
+
 	bpf_compute_data_pointers(skb);
-	return ret;
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	return 0;
 }
 
 static const struct bpf_func_proto bpf_skb_change_proto_proto = {
@@ -3583,12 +3582,13 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		}
 
 		/* Match skb->protocol to new outer l3 protocol */
-		if (skb->protocol == htons(ETH_P_IP) &&
-		    flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
-			bpf_skb_change_protocol(skb, ETH_P_IPV6);
-		else if (skb->protocol == htons(ETH_P_IPV6) &&
-			 flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
-			bpf_skb_change_protocol(skb, ETH_P_IP);
+		if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
+			skb->protocol = htons(ETH_P_IPV6);
+		else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
+			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
 	}
 
 	if (skb_is_gso(skb)) {
@@ -3616,6 +3616,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
+	bool decap = flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
 	int ret;
 
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
@@ -3638,13 +3639,16 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (unlikely(ret < 0))
 		return ret;
 
-	/* Match skb->protocol to new outer l3 protocol */
-	if (skb->protocol == htons(ETH_P_IP) &&
-	    flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
-		bpf_skb_change_protocol(skb, ETH_P_IPV6);
-	else if (skb->protocol == htons(ETH_P_IPV6) &&
-		 flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
-		bpf_skb_change_protocol(skb, ETH_P_IP);
+	if (decap) {
+		/* Match skb->protocol to new outer l3 protocol */
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
+			skb->protocol = htons(ETH_P_IPV6);
+		else if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
+			skb->protocol = htons(ETH_P_IP);
+
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
-- 
2.53.0

