Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48C2C10F03
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9607A21874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL/xG331"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCVT7V (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:21 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:38310 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCVT7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:20 -0400
Received: by mail-ot1-f74.google.com with SMTP id u18so1743788otq.5
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=udfBlFNHYVoHjsXQPsiDskquXHY7YonlB34FIokADEM=;
        b=PL/xG331onuuVjiMP78wq/Rl1t1gM5QIm5Tdh99HYCB93SVWJluYY4sg9/CfToy9E5
         mr6V+F5FeEIq6Rpv53syGZiYxGN62wF3agpWcQD++Ox0tO7bhQbQIeI/pbixT3w/KLUW
         V5Yy39+H5qtJZWHmtNZi552ORgGmAEIYlP16zloZT/md2QapQxL/EF5I0bahzNpfhKte
         W8aAAXNKnXVy0aSQX2IzGPw1RKi0NjhcP9fsvngBhmSmOWQVlhK6ipISmyXcMUA+AMpL
         wgNgPWRXHMTnmMXQ3RVJr9H6pZ3jffxgHyngyZwqKJ+Rmo6+AbqRBqvFLWlh/RgaQFcO
         Ijig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=udfBlFNHYVoHjsXQPsiDskquXHY7YonlB34FIokADEM=;
        b=adRkzpiU7/VXoxr2m1OEnD544PynW2O+5wfdA/MBvnTI7+vnk4Wl7ovtEcOtCUemvk
         663fHbwnCV6nIXHLN59oHfP2kAovbbezNE7uhwQanAVGFCYeTePjjfZwg1gIqDCmVVlJ
         /ZgAxaRDU8m2ftlipduHApzNKEoX/gfiQZuqG1l8C1bCTMn5ZjkN0xxSrBuhsomko947
         yIT1EPpRGLbZifDkosRXU1Bhqp9aO+bmet673DgC2Q9rWjRoAz7OVniByrlER0dgF+5s
         4E7IGpvrLAhj7Zt0f8XHoZkobNkG4la9JaoK0yJPs3p8I7zD5DdTrVQgKiW+jRXFGWpE
         yEQg==
X-Gm-Message-State: APjAAAVATMTIw3iNrFNGiIfNPz3sckGGZavuKN5RrZPl8kGuT5ULsmaN
        /mRi3MLqYjmHqxWBCQ8P4qmVcZc=
X-Google-Smtp-Source: APXvYqx3uVN4cxoV/ns3xMlEK56lz+nXBTxksfVARWewZom9GXtquvCJQle2YZWw4zxzKrsh4bWHny0=
X-Received: by 2002:aca:5956:: with SMTP id n83mr3087957oib.2.1553284759605;
 Fri, 22 Mar 2019 12:59:19 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:59:00 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-6-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 5/8] net: plumb network namespace into __skb_flow_dissect
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
index a62149af940b..f2daefc5ba20 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1284,7 +1284,8 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 			    const struct sk_buff *skb,
 			    struct flow_dissector *flow_dissector,
 			    struct bpf_flow_keys *flow_keys);
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(const struct net *net,
+			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container,
 			void *data, __be16 proto, int nhoff, int hlen,
@@ -1294,8 +1295,8 @@ static inline bool skb_flow_dissect(const struct sk_buff *skb,
 				    struct flow_dissector *flow_dissector,
 				    void *target_container, unsigned int flags)
 {
-	return __skb_flow_dissect(skb, flow_dissector, target_container,
-				  NULL, 0, 0, 0, flags);
+	return __skb_flow_dissect(NULL, skb, flow_dissector,
+				  target_container, NULL, 0, 0, 0, flags);
 }
 
 static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
@@ -1303,18 +1304,19 @@ static inline bool skb_flow_dissect_flow_keys(const struct sk_buff *skb,
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
 
@@ -2494,7 +2496,8 @@ static inline void skb_probe_transport_header(struct sk_buff *skb)
 	if (skb_transport_header_was_set(skb))
 		return;
 
-	if (skb_flow_dissect_flow_keys_basic(skb, &keys, NULL, 0, 0, 0, 0))
+	if (skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
+					     NULL, 0, 0, 0, 0))
 		skb_set_transport_header(skb, keys.control.thoff);
 }
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 3b35fc35f583..1e2e4a9330af 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -725,6 +725,7 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 /**
  * __skb_flow_dissect - extract the flow_keys struct and return it
+ * @net: associated network namespace, derived from @skb if NULL
  * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
  * @flow_dissector: list of keys to dissect
  * @target_container: target structure to put dissected values into
@@ -739,7 +740,8 @@ bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
  *
  * Caller must take care of zeroing target container memory.
  */
-bool __skb_flow_dissect(const struct sk_buff *skb,
+bool __skb_flow_dissect(const struct net *net,
+			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
 			void *target_container,
 			void *data, __be16 proto, int nhoff, int hlen,
@@ -798,13 +800,17 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
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
@@ -1406,8 +1412,8 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 	__flow_hash_secret_init();
 
 	memset(&keys, 0, sizeof(keys));
-	__skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys,
-			   NULL, 0, 0, 0,
+	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
+			   &keys, NULL, 0, 0, 0,
 			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
 
 	return __flow_hash_from_keys(&keys, hashrnd);
@@ -1508,7 +1514,8 @@ u32 skb_get_poff(const struct sk_buff *skb)
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

