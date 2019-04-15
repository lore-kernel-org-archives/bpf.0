Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F7C282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423020848
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0kyhHIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfDORiM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:12 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53534 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfDORiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:12 -0400
Received: by mail-qt1-f202.google.com with SMTP id 18so16759606qtw.20
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hIVfCFyYUAWbphwx5TAnPMg6i3SnGDgraD+6eeypP0I=;
        b=G0kyhHInGH77uFYEgD1bPsr24iKUNnyNt+GyyT03rG0Maxa4rCgETfOBgREXAc7bXM
         k5DyyW1pcfVesK3w9qbNYaWzJCFWDr8r7xMZTJ+uBIT0LMUgQhdaeYj5SpjnKQ22nmBP
         qKkvxHAJObvDl5jxLb2GkpdPPRtII0FL43/KA6rUIuoOBe+hGF7DQiGT6mxJ1u1nsv0o
         QEolDGxsR+WRN5x+XJyBaoV+yezFEbuxS70r9BhQQJfd4R8AikSNdRyuOHQocCYDWFBl
         drgv99+QK49NFuE30kgMGq6HWoerCimNMnxwmNZi9+edpSP3ZuY+XLOnatgRT3UVDfF9
         EXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hIVfCFyYUAWbphwx5TAnPMg6i3SnGDgraD+6eeypP0I=;
        b=DeWkD9ERZRm+HIaseiXDhQFjJIGxz+S4z1YdkVIyyDj8a3WoRnJEY0Zrnx1BNhxZCq
         gSGZkMLGDOH2IXLRVbbq+OM/ggSFuDDRGhOo7X9/PsxtCQuEGsxpNzNiKBXo02nrjEfd
         knN97MJDm5cwSszAFnaM4uoERn5rxk4qyYWqufx3cy+zHhugYnaaTMZnCttPmxFVRAcW
         beWwo+CxjfiPtJoMlewIJ0bYH22o1VMH9NTc55iVDQ4xRxsIF9SzMIrtxdJwRj3+P6yW
         cscu9Ey9uQO8jxitPt5wut3zh6nveracjDa/4Klxj+aIvBikORw2WXWYc8Ht8MIyeGwe
         K2Bw==
X-Gm-Message-State: APjAAAU55iI2fwu4na4/zKjAMgYEaszOg0LlH05Qe4sLtMgPjFWJ4KRu
        4HaECBGlNiYXw5cF1NT32cLqvT0=
X-Google-Smtp-Source: APXvYqzMcv53UAPw9K0+CM9DTdOaVCUp+KEVRZ3skYAV2RXpRxaD6A0IydcEaV59H5lvZKNrAshtUyk=
X-Received: by 2002:a05:620a:1376:: with SMTP id d22mr9422481qkl.53.1555349891522;
 Mon, 15 Apr 2019 10:38:11 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:37:58 -0700
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
Message-Id: <20190415173801.257254-4-sdf@google.com>
Mime-Version: 1.0
References: <20190415173801.257254-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 3/6] net: plumb network namespace into __skb_flow_dissect
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
 net/core/flow_dissector.c | 27 +++++++++++++++++----------
 net/ethernet/eth.c        |  5 +++--
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4d2365ffa444..60cdbcde751b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1282,7 +1282,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
 			    struct flow_dissector *flow_dissector,
 			    struct bpf_flow_keys *flow_keys);
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(const struct net *net,
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
+	return __skb_flow_dissect(NULL, skb, flow_dissector,
+				  target_container, NULL, 0, 0, 0, flags);
 }
 
 static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
@@ -1301,18 +1302,19 @@ static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
 					      unsigned int flags)
 {
 	memset(flow, 0, sizeof(*flow));
-	return __skb_flow_dissect(skb, &flow_keys_dissector, flow,
-				  NULL, 0, 0, 0, flags);
+	return __skb_flow_dissect(NULL, skb, &flow_keys_dissector,
+				  flow, NULL, 0, 0, 0, flags);
 }
 
 static inline bool
-skb_flow_dissect_flow_keys_basic(const struct sk_buff *skb,
+skb_flow_dissect_flow_keys_basic(const struct net *net,
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
+	if (skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
+					     NULL, 0, 0, 0, 0))
 		skb_set_transport_header(skb, keys.control.thoff);
 }
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ef6d9443cc75..f32c7e737fc6 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -722,6 +722,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 /**
  * __skb_flow_dissect - extract the flow_keys struct and return it
+ * @net: associated network namespace, derived from @skb if NULL
  * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
  * @flow_dissector: list of keys to dissect
  * @target_container: target structure to put dissected values into
@@ -738,7 +739,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
  *
  * Caller must take care of zeroing target container memory.
  */
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(const struct net *net,
+			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container,
 			void *data, __be16 proto, int nhoff, int hlen,
@@ -797,13 +799,17 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
 		struct bpf_prog *attached = NULL;
 
 		rcu_read_lock();
+		if (!net) {
+			if (skb->dev)
+				net = dev_net(skb->dev);
+			else if (skb->sk)
+				net = sock_net(skb->sk);
+			else
+				WARN_ON_ONCE(1);
+		}
 
-		if (skb->dev)
-			attached = rcu_dereference(dev_net(skb->dev)->flow_dissector_prog);
-		else if (skb->sk)
-			attached = rcu_dereference(sock_net(skb->sk)->flow_dissector_prog);
-		else
-			WARN_ON_ONCE(1);
+		if (net)
+			attached = rcu_dereference(net->flow_dissector_prog);
 
 		if (attached) {
 			ret = __skb_flow_bpf_dissect(attached, skb,
@@ -1405,8 +1411,8 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 	__flow_hash_secret_init();
 
 	memset(&keys, 0, sizeof(keys));
-	__skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys,
-			   NULL, 0, 0, 0,
+	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
+			   &keys, NULL, 0, 0, 0,
 			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
 
 	return __flow_hash_from_keys(&keys, hashrnd);
@@ -1507,7 +1513,8 @@ u32 skb_get_poff(const struct sk_buff *skb)
 {
 	struct flow_keys_basic keys;
 
-	if (!skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
+	if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
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
2.21.0.392.gf8f6787159e-goog

