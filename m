Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC5C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BABD2175B
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FaewJX4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCSWUV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:21 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38553 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCSWUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:01 -0400
Received: by mail-yw1-f74.google.com with SMTP id i203so384217ywa.5
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RtFBOfRjXxOXFxr+WEOUUYnF/E0jFwz0u/b1PbVBgEg=;
        b=FaewJX4y1rcWTg8W8SkHef685GEmft7tb+MDejdLC9zm15DVPiwflCvpiQ1eoFHNuw
         mCupaCCUcQ/1NEvze3aQIjH0hZOASmizpE7n9Z2fYOrfeIW9Wv7xeNh+HBeFa0ZPJDlU
         G2f2JMLjRRwSvQgcp3OMJv9TOrVqgfls1n0DvCn0+hOMcmsZZuglwr3qnX2pSaxROC6B
         m+hC1xHrGBrhhYfpDgUKMGy+scJShTNjieSO8E5rf7nvmDvj2D6XbItsU/L9haVAIH+d
         8suDpjw8IUAd9AIoMm5EUfUWEY4td/qengsApLuHtDgJ3S0S/NFS1ReoX8nmtmndva84
         8Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RtFBOfRjXxOXFxr+WEOUUYnF/E0jFwz0u/b1PbVBgEg=;
        b=e7c5+bTO4JWj/zIEBXe10yLD9mgCmG5bVmPlmdb5AKmJ1ca0IS91vo/4jVPw0Dk+mO
         b8aEmLz0E54RtA1qrsHSGChdDGjGZ6NNwf1yfW1m6rswIDdOCjKwn1d+dAv67sin86ls
         apXBJ8mRNqwJwrsvGAx9O9i2mUMiLQv0mhm5Bhn+pX7AgMH4pTZ3PdrHombJIsx6Gy7z
         RsrRizCPXA7djF5HMtaLRQ/RENir39LKEGEbSqC8AbQbUPAj8CF3KIbpUTHpXXyfAuQi
         TpvcuLuCLZ7cI+hxfsieAcIJgybBzeX1uVIzcCwvq3qZbQhGLHRGO0ICtIqnV+eYCz+Q
         wQ1A==
X-Gm-Message-State: APjAAAUmpAK1MIO+Xd9TsKs7fh7f61Jx/TvvTm6U79mqCLoaB/dy1t/4
        Ps/BSjsnxLYFOkzJ81rRW62ZydI=
X-Google-Smtp-Source: APXvYqxEg6CA2xtVKQoj/GDga1ICQIsG1659HnBFCukWZVDntmUidOorQYH1XOfVgnPDGTcGE8o5Xuw=
X-Received: by 2002:a25:bb8c:: with SMTP id y12mr1342804ybg.89.1553033999965;
 Tue, 19 Mar 2019 15:19:59 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:42 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-4-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 3/9] net: plumb network namespace into __skb_flow_dissect
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This new argument will be used in the next patches for the
eth_get_headlen use case. eth_get_headlen calls flow dissector
with only data (without skb) so there is currently no way to
pull attached BPF flow dissector program. With this new argument,
we can amend the callers to explicitly pass network namespace
so we can use attached BPF program.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    | 19 +++++++++++--------
 net/core/flow_dissector.c | 22 +++++++++++-----------
 net/ethernet/eth.c        |  5 +++--
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 75e1d4d73cca..4ca4c60cbacb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1282,7 +1282,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
 			    struct flow_dissector *flow_dissector,
 			    struct bpf_flow_keys *flow_keys);
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(struct net *net,
+			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container,
 			void *data, __be16 proto, int nhoff, int hlen,
@@ -1292,8 +1293,8 @@ static inline bool skb_flow_dissect(const struct sk_buff *skb,
 				    struct flow_dissector *flow_dissector,
 				    void *target_container, unsigned int flags)
 {
-	return __skb_flow_dissect(skb, flow_dissector, target_container,
-				  NULL, 0, 0, 0, flags);
+	return __skb_flow_dissect(skb_net(skb), skb, flow_dissector,
+				  target_container, NULL, 0, 0, 0, flags);
 }
 
 static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
@@ -1301,18 +1302,19 @@ static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
 					      unsigned int flags)
 {
 	memset(flow, 0, sizeof(*flow));
-	return __skb_flow_dissect(skb, &flow_keys_dissector, flow,
-				  NULL, 0, 0, 0, flags);
+	return __skb_flow_dissect(skb_net(skb), skb, &flow_keys_dissector,
+				  flow, NULL, 0, 0, 0, flags);
 }
 
 static inline bool
-skb_flow_dissect_flow_keys_basic(const struct sk_buff *skb,
+skb_flow_dissect_flow_keys_basic(struct net *net,
+				 const struct sk_buff *skb,
 				 struct flow_keys_basic *flow, void *data,
 				 __be16 proto, int nhoff, int hlen,
 				 unsigned int flags)
 {
 	memset(flow, 0, sizeof(*flow));
-	return __skb_flow_dissect(skb, &flow_keys_basic_dissector, flow,
+	return __skb_flow_dissect(net, skb, &flow_keys_basic_dissector, flow,
 				  data, proto, nhoff, hlen, flags);
 }
 
@@ -2492,7 +2494,8 @@ static inline void skb_probe_transport_header(struct sk_buff *skb)
 	if (skb_transport_header_was_set(skb))
 		return;
 
-	if (skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
+	if (skb_flow_dissect_flow_keys_basic(skb_net(skb), skb, &keys,
+					     NULL, 0, 0, 0, 0))
 		skb_set_transport_header(skb, keys.control.thoff);
 }
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index bb1a54747d64..e13165e7528c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -725,6 +725,7 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 
 /**
  * __skb_flow_dissect - extract the flow_keys struct and return it
+ * @net: associated network namespace
  * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
  * @flow_dissector: list of keys to dissect
  * @target_container: target structure to put dissected values into
@@ -739,7 +740,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
  *
  * Caller must take care of zeroing target container memory.
  */
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(struct net *net,
+			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container,
 			void *data, __be16 proto, int nhoff, int hlen,
@@ -797,14 +799,11 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
 		struct bpf_flow_keys flow_keys;
 		struct bpf_prog *attached = NULL;
 
-		rcu_read_lock();
+		WARN_ON_ONCE(!net);
 
-		if (skb->dev)
-			attached = rcu_dereference(dev_net(skb->dev)->flow_dissector_prog);
-		else if (skb->sk)
-			attached = rcu_dereference(sock_net(skb->sk)->flow_dissector_prog);
-		else
-			WARN_ON_ONCE(1);
+		rcu_read_lock();
+		if (net)
+			attached = rcu_dereference(net->flow_dissector_prog);
 
 		if (attached) {
 			ret = __skb_flow_bpf_dissect(attached, skb,
@@ -1406,8 +1405,8 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 	__flow_hash_secret_init();
 
 	memset(&keys, 0, sizeof(keys));
-	__skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys,
-			   NULL, 0, 0, 0,
+	__skb_flow_dissect(skb_net(skb), skb, &flow_keys_dissector_symmetric,
+			   &keys, NULL, 0, 0, 0,
 			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
 
 	return __flow_hash_from_keys(&keys, hashrnd);
@@ -1508,7 +1507,8 @@ u32 skb_get_poff(const struct sk_buff *skb)
 {
 	struct flow_keys_basic keys;
 
-	if (!skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
+	if (!skb_flow_dissect_flow_keys_basic(skb_net(skb), skb, &keys,
+					      NULL, 0, 0, 0, 0))
 		return 0;
 
 	return __skb_get_poff(skb, skb->data, &keys, skb_headlen(skb));
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index f7a3d7a171c7..1e439549c419 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -136,8 +136,9 @@ u32 eth_get_headlen(void *data, unsigned int len)
 		return len;
 
 	/* parse any remaining L2/L3 headers, check for L4 */
-	if (!skb_flow_dissect_flow_keys_basic(NULL, &keys, data, eth->h_proto,
-					      sizeof(*eth), len, flags))
+	if (!skb_flow_dissect_flow_keys_basic(NULL, NULL, &keys, data,
+					      eth->h_proto, sizeof(*eth),
+					      len, flags))
 		return max_t(u32, keys.control.thoff, sizeof(*eth));
 
 	/* parse for any L4 headers */
-- 
2.21.0.225.g810b269d1ac-goog

