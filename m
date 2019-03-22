Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E131C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9D21874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrL6vBbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCVT7Y (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:24 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33166 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfCVT7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:23 -0400
Received: by mail-qk1-f201.google.com with SMTP id n64so2951931qkb.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jH0DlmYOrPLzdCF4EJswlZVCC4FyVOkDDeXR1ZVl/Bg=;
        b=NrL6vBbTqieLVt6hFgPPIBw8EvPNvKBj5FAmaaaMpo06gzqLZdq7TKtgwxcLkP8Owo
         xULEMR7A+cB4ddroNSZrgoYPqsRELMDvq9j3yFUL/kecUn9UWHa1Oow58ks3TsJcSBWE
         AEYB8DVpK34MPKYgZ1lO/fY4Bq/VIUpukn+JTVKaej+qpmHursx0ueiLRNRLO+SjpH4y
         0qPIKJeDBMycmzl6gq6TEw8eX4niNCYFvosItcdBipw71Zsgzjwh5Roe4iV44KEsvDdZ
         CmEZuAYCjBoJZGxxjFgclGMYRtf+JblTEDudetpYyCQFObRtqRbemimxZY5RgwV1slHp
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jH0DlmYOrPLzdCF4EJswlZVCC4FyVOkDDeXR1ZVl/Bg=;
        b=sFs7Ty6z+jzcotgir3up1LUsAdkOv2t1Anp2NKeydKu8Ko4r2XLsYqsDnSOryhwLdV
         kCwwkIQpyY3VFhZkDnU2LGBkxc1myNahi9jrrBUSmkrwkVDVHDrDfYsJme8hJzEKof9h
         YsO4PqyyaB4iR68VYCczZdQ9Uslkl0yl0Fu8044mKwMSVXH7W+wBC1QEk8SOJ+pEg4t/
         Y43cn4cojtIvLisg8MS9ZiHl3ZWabNd5j/u4bgkQBTISMf+fQFt5j1qMzDToOVQRdZHS
         uzeMEKto1vuOOuGkWfagOlnmL6jtjYnaUdU+o6yZ/yJD5ewXQsSK1MQUJWLcYOY2TqRv
         q8BA==
X-Gm-Message-State: APjAAAX+QqqP2Xcff56o+MPRA7ZaT27IfShyicPAhuVg/NB3PFOoQ3su
        gpiUHVfcTDpNPx8khsE2bVnu1i4=
X-Google-Smtp-Source: APXvYqzucqbpCDur83kyNkdSzUNaI2jao4VFcX6PkuVqpE707bKxGsQeppScn9D2ggSAPYlFYcozA3s=
X-Received: by 2002:a37:6381:: with SMTP id x123mr9586832qkb.110.1553284762372;
 Fri, 22 Mar 2019 12:59:22 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:59:01 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-7-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
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
 net/core/flow_dissector.c | 54 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1e2e4a9330af..ec8ebafe333f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -683,26 +683,6 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
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
-		.protocol = skb->protocol,
-		.vlan_tci = skb->vlan_tci,
-		.vlan_proto = skb->vlan_proto,
-		.vlan_present = skb->vlan_present,
-		.data = skb->data,
-		.data_end = skb->data + skb_headlen(skb),
-	};
-
-	return bpf_flow_dissect(prog, &ctx, skb_network_offset(skb),
-				skb_headlen(skb));
-}
-
 bool bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 		      int nhoff, int hlen)
 {
@@ -754,6 +734,7 @@ bool __skb_flow_dissect(const struct net *net,
 	struct flow_dissector_key_icmp *key_icmp;
 	struct flow_dissector_key_tags *key_tags;
 	struct flow_dissector_key_vlan *key_vlan;
+	struct bpf_prog *attached = NULL;
 	enum flow_dissect_ret fdret;
 	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
 	int num_hdrs = 0;
@@ -796,26 +777,37 @@ bool __skb_flow_dissect(const struct net *net,
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
+				.protocol = proto,
+			};
+
+			if (skb) {
+				ctx.skb = skb;
+				ctx.protocol = skb->protocol;
+				ctx.vlan_tci = skb->vlan_tci;
+				ctx.vlan_proto = skb->vlan_proto;
+				ctx.vlan_present = skb->vlan_present;
+			}
+
+			ret = bpf_flow_dissect(attached, &ctx, nhoff, hlen);
 			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
 						 target_container);
 			rcu_read_unlock();
-- 
2.21.0.392.gf8f6787159e-goog

