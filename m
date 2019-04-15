Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8BC282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A920848
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vD9IXcbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfDORiK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:10 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:39232 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfDORiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:09 -0400
Received: by mail-ot1-f73.google.com with SMTP id q25so9474897otf.6
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vWs4E580BWUE9u6eBKGmmyUjZb++KvbCdv4phoG/BZc=;
        b=vD9IXcbbyhgDapjeal3KxM7d9ZutgVHfN8KLAEgeKjTJT2ex9rzeYagZaSYISpgz75
         1RTXlQ2K2r1sJLRzWIZTMNzJM7IvI3m2YMvTTXSFA/mW6LUsFj3swiM2R+CHiv0P+diM
         L6pslsoc4WTStCjke4Z23nyHb2IZ0ynde4c3YILrc4icEVXJzmZ33qx90G7EC1VgONGa
         /LnKAQ+LYzhBZzhbreM85kdnWUTGyguMq+EIETtJQWRU0MN/ZB09ogRFpTpzj/+MYUdF
         g79n/PBmYFV4zKjBAKnSYNzWnsC4ti+arBgtMPZn9Ya/a2MkGS2l3g/JCui7qS37NA9w
         gbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vWs4E580BWUE9u6eBKGmmyUjZb++KvbCdv4phoG/BZc=;
        b=W8eZgDeyQzemOlc/pgExpD1I5TqI2ccR761J0ZQEs9L1vVwFhSTLKWreqS6gDLXjBm
         CvMIwyRMY3ahd004rsPmgkP+9exIECjozDHhL+6wOn5DBcj5C3aI7VNdk+Kp2jQm6i7s
         fpzz/HHLHNGZfSGdepr8xX5Tz0QF7MSKEXXRqKNqh9da4iCFW2z2UtFRUUsXzuiKBUh6
         B9CsoE2jDgAXJtM+YVnG2JGW5SN3FBs5a1HEpvpMeCrc3AHemua2Hk/5cY3nGkKEo6hK
         1vkuFjrQGKBCbDeVrxOXYMs7AWsUtgnOBgUPYSn0IxTNImOSRnGKC30w7h2wqACO6acK
         SK3w==
X-Gm-Message-State: APjAAAVaQMDynwzcViEEdBLEnesrA1ETxfjimDprqx3Ichu/n5NgW8Vu
        QOoxoKGWVP41ImbRey2rGuDmb1w=
X-Google-Smtp-Source: APXvYqy421m6gHwh+2RL0mqi7k4se6acXd2rXaeQE2K6wtcY099E/RHZbX6C1jJxT6XcIrHcR1+GO64=
X-Received: by 2002:aca:4894:: with SMTP id v142mr6409157oia.30.1555349889172;
 Mon, 15 Apr 2019 10:38:09 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:37:57 -0700
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
Message-Id: <20190415173801.257254-3-sdf@google.com>
Mime-Version: 1.0
References: <20190415173801.257254-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 2/6] bpf: when doing BPF_PROG_TEST_RUN for flow
 dissector use no-skb mode
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

Now that we have bpf_flow_dissect which can work on raw data,
use it when doing BPF_PROG_TEST_RUN for flow dissector.

Simplifies bpf_prog_test_run_flow_dissector and allows us to
test no-skb mode.

Note, that previously, with bpf_flow_dissect_skb we used to call
eth_type_trans which pulled L2 (ETH_HLEN) header and we explicitly called
skb_reset_network_header. That means flow_keys->nhoff would be
initialized to 0 (skb_network_offset) in init_flow_keys.
Now we call bpf_flow_dissect with nhoff set to ETH_HLEN and need
to undo it once the dissection is done to preserve the existing behavior.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 47 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 006ad865f7fb..db2ec88ab129 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -379,12 +379,12 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     union bpf_attr __user *uattr)
 {
 	u32 size = kattr->test.data_size_in;
+	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
 	struct bpf_flow_keys flow_keys;
 	u64 time_start, time_spent = 0;
+	const struct ethhdr *eth;
 	u32 retval, duration;
-	struct sk_buff *skb;
-	struct sock *sk;
 	void *data;
 	int ret;
 	u32 i;
@@ -395,43 +395,31 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (kattr->test.ctx_in || kattr->test.ctx_out)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (size < ETH_HLEN)
+		return -EINVAL;
+
+	data = bpf_test_init(kattr, size, 0, 0);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	sk = kzalloc(sizeof(*sk), GFP_USER);
-	if (!sk) {
-		kfree(data);
-		return -ENOMEM;
-	}
-	sock_net_set(sk, current->nsproxy->net_ns);
-	sock_init_data(NULL, sk);
-
-	skb = build_skb(data, 0);
-	if (!skb) {
-		kfree(data);
-		kfree(sk);
-		return -ENOMEM;
-	}
-	skb->sk = sk;
-
-	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-	__skb_put(skb, size);
-	skb->protocol = eth_type_trans(skb,
-				       current->nsproxy->net_ns->loopback_dev);
-	skb_reset_network_header(skb);
+	eth = (struct ethhdr *)data;
 
 	if (!repeat)
 		repeat = 1;
 
+	ctx.flow_keys = &flow_keys;
+	ctx.data = data;
+	ctx.data_end = (__u8 *)data + size;
+
 	rcu_read_lock();
 	preempt_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		retval = __skb_flow_bpf_dissect(prog, skb,
-						&flow_keys_dissector,
-						&flow_keys);
+		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
+					  size);
+
+		flow_keys.nhoff -= ETH_HLEN;
+		flow_keys.thoff -= ETH_HLEN;
 
 		if (signal_pending(current)) {
 			preempt_enable();
@@ -464,7 +452,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 			      retval, duration);
 
 out:
-	kfree_skb(skb);
-	kfree(sk);
+	kfree(data);
 	return ret;
 }
-- 
2.21.0.392.gf8f6787159e-goog

