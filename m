Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E26C282E3
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5131920896
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDQuyTFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDVP4F (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:05 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:49191 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfDVP4F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:05 -0400
Received: by mail-ot1-f73.google.com with SMTP id s22so7620148otk.16
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y+NDWRu+5hbqgUcZT0IIgnXq+oNcbxB5cLxg/SCdY8M=;
        b=IDQuyTFCWpNYx54YtuifE6GsIpcr1C4M+nnuAsprxlUmOEpDr7Z1rHP4S+UPbd4rk6
         UpkMmPSBJVZpkAGh7FmtO/wfk6IFksWBZgjFu5590ZV5iZzRLkE/TsdXtB5J+l9BJnCU
         add+Gf30Xre6UXjfx4MYk+jMh0C6QCNKCXEhTPo87/Ci+m6qI3ou3GlPq2Qmn4YLwHw4
         0j8ZLV8iq9bAXoMH1cGJEtJLRaWrFYHE1q14yYKPxe/98BEXbyLQflmMU+u3RuHX0r64
         foIm2G6hGIRPe9mNU49dRZ0LCvJvJ4sBDIJWrWoUA1AZMMUhjzWiJYoRy8GyT7BL1ix1
         mjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y+NDWRu+5hbqgUcZT0IIgnXq+oNcbxB5cLxg/SCdY8M=;
        b=BC30y6v3atwzeKFzm0LGp/DVH35UMqE3zB6aj2gMka+5vn3+SYxEaylfpiz1Xbbqys
         sU7Dy1HC8v9QyLhYig+qQtzvwYZ5GQDGjbNB1WrtPEbZ66XSQkFjbh1LP8be0tuqIZ3m
         2WQsqyqiYZ8acL9y4UbX19tIqKJQIkuhH3XPQyrAZYcBiJCiCTpQonDHE53n/AP/ItqB
         7Unkpr5+p72bmwBt/UoSSxZuNO0C51fShW7pYs/n4IIg09ZHJ9SpjDsBgFBN3h7VKxPD
         Lz8FUlA4NDuWSRNq58H/jarYKyzgYRDdp6J4MeuuTrrUI6lePyNwolbJ8+uVwO+ee21o
         9e2g==
X-Gm-Message-State: APjAAAWjX4WTG/uJ9UZQ/r4MbepnqhAtsHdJcKmVYT3TPbDtEH5aiXRQ
        aW31X+vCK6ykt08eCWlpPY9zT7c=
X-Google-Smtp-Source: APXvYqzIRC1Rsy30A5EDyDHSjG5pb+ScE+KuB59SiSOUajRSgIBAj6GDZG0N0HbldqfWRcsnLHymAgs=
X-Received: by 2002:a9d:6850:: with SMTP id c16mr12568838oto.226.1555948564430;
 Mon, 22 Apr 2019 08:56:04 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:47 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-5-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 4/9] flow_dissector: handle no-skb use case
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

When called without skb, gather all required data from the
__skb_flow_dissect's arguments and use recently introduces
no-skb mode of bpf flow dissector.

Note: WARN_ON_ONCE(!net) will now trigger for eth_get_headlen users.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  5 ----
 net/core/flow_dissector.c | 52 +++++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ee7d1a85f624..61e2e4678f57 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1279,11 +1279,6 @@ struct bpf_flow_dissector;
 bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		      __be16 proto, int nhoff, int hlen);
 
-struct bpf_flow_keys;
-bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
-			    const struct sk_buff *skb,
-			    struct flow_dissector *flow_dissector,
-			    struct bpf_flow_keys *flow_keys);
 bool __skb_flow_dissect(const struct net *net,
 			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index f32c7e737fc6..fac712cee9d5 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -683,22 +683,6 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 	}
 }
 
-bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
-			    const struct sk_buff *skb,
-			    struct flow_dissector *flow_dissector,
-			    struct bpf_flow_keys *flow_keys)
-{
-	struct bpf_flow_dissector ctx = {
-		.flow_keys = flow_keys,
-		.skb = skb,
-		.data = skb->data,
-		.data_end = skb->data + skb_headlen(skb),
-	};
-
-	return bpf_flow_dissect(prog, &ctx, skb->protocol,
-				skb_network_offset(skb), skb_headlen(skb));
-}
-
 bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		      __be16 proto, int nhoff, int hlen)
 {
@@ -753,6 +737,7 @@ bool __skb_flow_dissect(const struct net *net,
 	struct flow_dissector_key_icmp *key_icmp;
 	struct flow_dissector_key_tags *key_tags;
 	struct flow_dissector_key_vlan *key_vlan;
+	struct bpf_prog *attached = NULL;
 	enum flow_dissect_ret fdret;
 	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
 	int num_hdrs = 0;
@@ -795,26 +780,39 @@ bool __skb_flow_dissect(const struct net *net,
 					      target_container);
 
 	if (skb) {
-		struct bpf_flow_keys flow_keys;
-		struct bpf_prog *attached = NULL;
-
-		rcu_read_lock();
 		if (!net) {
 			if (skb->dev)
 				net = dev_net(skb->dev);
 			else if (skb->sk)
 				net = sock_net(skb->sk);
-			else
-				WARN_ON_ONCE(1);
 		}
+	}
 
-		if (net)
-			attached = rcu_dereference(net->flow_dissector_prog);
+	WARN_ON_ONCE(!net);
+	if (net) {
+		rcu_read_lock();
+		attached = rcu_dereference(net->flow_dissector_prog);
 
 		if (attached) {
-			ret = __skb_flow_bpf_dissect(attached, skb,
-						     flow_dissector,
-						     &flow_keys);
+			struct bpf_flow_keys flow_keys;
+			struct bpf_flow_dissector ctx = {
+				.flow_keys = &flow_keys,
+				.data = data,
+				.data_end = data + hlen,
+			};
+			__be16 n_proto = proto;
+
+			if (skb) {
+				ctx.skb = skb;
+				/* we can't use 'proto' in the skb case
+				 * because it might be set to skb->vlan_proto
+				 * which has been pulled from the data
+				 */
+				n_proto = skb->protocol;
+			}
+
+			ret = bpf_flow_dissect(attached, &ctx, n_proto, nhoff,
+					       hlen);
 			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
 						 target_container);
 			rcu_read_unlock();
-- 
2.21.0.593.g511ec345e18-goog

