Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99482C10F12
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F345217F9
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEt8oQ9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCSWUK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:10 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:54652 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfCSWUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:10 -0400
Received: by mail-io1-f74.google.com with SMTP id i24so194314iol.21
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XSwbV3MMuRoJYVEcPeJNFfeZCsxx6d/I5lnTofCaiJ4=;
        b=aEt8oQ9KUwvXwsehv5wRHYYZci/T1jvPy2WPdXdIoNKUWybizY4EcgQBaLwkM8Qgec
         6F+THlquytwBxY+WT2+ckpDsaLlFjRkYailVIa7jNC+zLIP0puSv1RmReGPY0upWpzKb
         d4DTOG9hTmSufTSTRc0QvttNs0Fo+kZKobcPvYjtgBpJVLHc4En8FIU0L/726JCdD5dL
         V7aXo4hsOYe/xQo76zLrtgR5MiFOQEwQwVR+7B8m++BBqEdsXR4+C7OyGX2Ra6HAOsBo
         DgkE1GpWtq0Xe1Hb5lJg0gZN/Yt4+80FYhQjmSrbcjAYPPwmgPfnYkZxu9RpL/ejlrEE
         8kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XSwbV3MMuRoJYVEcPeJNFfeZCsxx6d/I5lnTofCaiJ4=;
        b=cLBl3Zb34HllM32r7N6u+miQd6KImuGigtbR9/R/OL0imEG01G3CFmuDV13+2eXsj1
         1n68jh2Z/DUbcULAZNPYwTA8Z9IyIARdsbsvJsxXIf5LO4X/MSReaEVoj3UcQ2WF+kpQ
         H8pGKj5TNS35FlIWbiVu+1TyXY30SbLpAdEK2RRpUwWiIqXB8Pt9PmjghXu1PvEdwJ+c
         ZJFDyOrGiKiEc2P3bFDSgxg0N3QTx4EKAJZgyV4tk8GJO6qr7DC9HCAGAxG99FYc/BLY
         4ap7LzzBdjI76eJSB1sKq2qPW8QLFhwVZPMIrjy0T8N9Kg162X0UBWBmif/oiARydt35
         SADA==
X-Gm-Message-State: APjAAAU8ormm+UYwl1SVQitfPXKL8/8pr2mzd/wCpcYZL9QpLSAMd7Gy
        ynrKoENE0cmZlZIgPcWdnQuS7SQ=
X-Google-Smtp-Source: APXvYqyiNjb03vueFM1rSOwAt9OpgfBgvxRIAjSkFggBMOf9TgOMogBMgqLcuLpIpgMzZdGwHiDpyYo=
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr2847619itb.5.1553034009129;
 Tue, 19 Mar 2019 15:20:09 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:45 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-7-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 6/9] net: flow_dissector: handle no-skb use case
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

When flow_dissector is called without skb (with only data and hlen),
use temporary per-cpu skb (which has a linear chunk of data passed
to the flow dissector). This should let us handle eth_get_headlen
case where only data is provided and we don't want to (yet) allocate
an skb.

Since this per-cpu skb doesn't allocate its own data, we can't
add shinfo and need to be careful to avoid any code paths that use
it. Flow dissector BPF programs can only call bpf_skb_load_bytes helper,
which doesn't touch shinfo in our case (skb->len is the length of the
linear header so it exits early).

bpf_flow_dissect can be called only by eth_get_headlen from softirq and task
contexts:
* NIC drivers call it from .ndo_start_xmit/.ndo_change_mtu/napi->poll (softirq)
* TUN driver calls it from fops->write_iter/proto_ops->sendmsg (task)

We protect per-cpu skb by using local_bh_enable/disable, and WARN_ON if
called from interrupt context.

Note: WARN_ON_ONCE(!net) will now trigger for eth_get_headlen users.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  5 +++
 net/core/flow_dissector.c | 69 +++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 194dbc2985e5..e8e0f650af0a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1282,6 +1282,11 @@ bool bpf_flow_dissect_skb(struct bpf_prog *prog,
 			  const struct sk_buff *skb,
 			  struct flow_dissector *flow_dissector,
 			  struct bpf_flow_keys *flow_keys);
+bool bpf_flow_dissect(struct bpf_prog *prog,
+		      void *data, __be16 proto,
+		      int nhoff, int hlen,
+		      struct flow_dissector *flow_dissector,
+		      struct bpf_flow_keys *flow_keys);
 bool __skb_flow_dissect(struct net *net,
 			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index ab43f9bd7ec4..accf1ed460ec 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -739,6 +739,43 @@ bool bpf_flow_dissect_skb(struct bpf_prog *prog,
 	return result == BPF_OK;
 }
 
+static DEFINE_PER_CPU(struct sk_buff, bpf_flow_skb);
+
+bool bpf_flow_dissect(struct bpf_prog *prog,
+		      void *data, __be16 proto,
+		      int nhoff, int hlen,
+		      struct flow_dissector *flow_dissector,
+		      struct bpf_flow_keys *flow_keys)
+{
+	struct bpf_skb_data_end *cb;
+	struct sk_buff skb_head;
+	struct sk_buff *skb = &skb_head;
+	u32 result;
+
+	if (WARN_ON_ONCE(in_irq()))
+		return false;
+
+	local_bh_disable();
+	skb = this_cpu_ptr(&bpf_flow_skb);
+	skb->len = 0;
+	__init_skb_data(skb, data, hlen);
+	__skb_put(skb, hlen);
+	skb->protocol = proto;
+
+	init_flow_keys(flow_keys, skb, nhoff);
+
+	cb = (struct bpf_skb_data_end *)skb->cb;
+	cb->data_meta = skb->data;
+	cb->data_end  = skb->data + skb_headlen(skb);
+
+	result = BPF_PROG_RUN(prog, skb);
+
+	clamp_flow_keys(flow_keys, hlen);
+	local_bh_enable();
+
+	return result == BPF_OK;
+}
+
 /**
  * __skb_flow_dissect - extract the flow_keys struct and return it
  * @net: associated network namespace
@@ -770,8 +807,10 @@ bool __skb_flow_dissect(struct net *net,
 	struct flow_dissector_key_icmp *key_icmp;
 	struct flow_dissector_key_tags *key_tags;
 	struct flow_dissector_key_vlan *key_vlan;
-	enum flow_dissect_ret fdret;
 	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
+	struct bpf_prog *attached = NULL;
+	struct bpf_flow_keys flow_keys;
+	enum flow_dissect_ret fdret;
 	int num_hdrs = 0;
 	u8 ip_proto = 0;
 	bool ret;
@@ -811,28 +850,30 @@ bool __skb_flow_dissect(struct net *net,
 					      FLOW_DISSECTOR_KEY_BASIC,
 					      target_container);
 
-	if (skb) {
-		struct bpf_flow_keys flow_keys;
-		struct bpf_prog *attached = NULL;
+	WARN_ON_ONCE(!net);
 
-		WARN_ON_ONCE(!net);
+	rcu_read_lock();
 
-		rcu_read_lock();
-		if (net)
-			attached = rcu_dereference(net->flow_dissector_prog);
+	if (net)
+		attached = rcu_dereference(net->flow_dissector_prog);
 
-		if (attached) {
+	if (attached) {
+		if (skb)
 			ret = bpf_flow_dissect_skb(attached, skb,
 						   flow_dissector,
 						   &flow_keys);
-			bpf_flow_keys_to_target(&flow_keys, flow_dissector,
-						target_container);
-			rcu_read_unlock();
-			return ret;
-		}
+		else
+			ret = bpf_flow_dissect(attached, data, proto, nhoff,
+					       hlen, flow_dissector,
+					       &flow_keys);
+		bpf_flow_keys_to_target(&flow_keys, flow_dissector,
+					target_container);
 		rcu_read_unlock();
+		return ret;
 	}
 
+	rcu_read_unlock();
+
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct ethhdr *eth = eth_hdr(skb);
-- 
2.21.0.225.g810b269d1ac-goog

