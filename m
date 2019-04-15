Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB29C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511412073F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CegL8Ujf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfDORiP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53028 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfDORiO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id 3so11705638ple.19
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0dmYm9+nEHpqvszkX2uaTkae3FO3I0na87yAXSFM4m8=;
        b=CegL8Ujff6pWbn7SsV+4hZC4derPpkjCBxAlEPS70Jq72xT9S6cEqPA9JVvKQcEM1S
         1NgYiIY8LyGvkHsnesQSDVZu8Y244oo1B/JuTBJSjtCmuYLEZR4+jwLukQck1YgaSjmC
         quqhyrSqm0x2LnjOnNg8bEI17wsEaTyPiPtVyziaV709cjRg4/jZHKeUc1iSANRC5uNo
         DsK0Ztm9ZFS6K0OHlCee4VoPxI23jD5bUDznPSfdjgFjuQRhhKPpilmr8RMlq6okMT8j
         n7pZrWbgocadq22cHNyFLVgOIFSxmEhlgI1CvWeWelts1nDtnQz187amyCkDljATlaLK
         x9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0dmYm9+nEHpqvszkX2uaTkae3FO3I0na87yAXSFM4m8=;
        b=PjEo1yaU0B6P4g3olS4Qe7I1Gn0DyDrRsRsirZA2ktWemDi3y5EW20YIgTPCZ2vk3I
         d2+IoCMU5i1D5ZODT1D0qNEjCSwiQ1Ac9J6IIZg79Hgan//Kw8dXSzll5SwSSk+liH6u
         8bWbJBFpd6zF4iSoZrQv4cDm31T18netOueihGBwv1qlIYisnZaJV3uXTTeX4w6Acmxx
         J/No+NOOSG/Le93cYf8N2vGit33LPcBN+8aaRia7+Z30O9yFMuZxTW7Ix6iU7o2NW5u/
         Cj+g47Re12p9+PYproBOdrV9VT5g+6Nk9bMd9DvYqDY3XC8rnNYSJjSHlh5ebwK6wtP0
         MRtw==
X-Gm-Message-State: APjAAAWMEOAkjKcd2E4K+z+YVChFF0xahd3XoeEjAayLfBc1/UH1hKbk
        aTXFIEfa3iYWnXH4q1S1/j79Acs=
X-Google-Smtp-Source: APXvYqyVwrJFvrSbfUv3GXOKwiHv78fgHfEbB3DpSNvDTqLogfIPipEJzj6wyHONZLXcCnzIfpPRNBQ=
X-Received: by 2002:a17:902:4601:: with SMTP id o1mr971901pld.33.1555349893571;
 Mon, 15 Apr 2019 10:38:13 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:37:59 -0700
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
Message-Id: <20190415173801.257254-5-sdf@google.com>
Mime-Version: 1.0
References: <20190415173801.257254-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 4/6] flow_dissector: handle no-skb use case
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
index 60cdbcde751b..0bfc16d719b5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1277,11 +1277,6 @@ struct bpf_flow_dissector;
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
2.21.0.392.gf8f6787159e-goog

