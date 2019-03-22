Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01BC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97421874
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MywmCXGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCVT7T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:19 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33343 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVT7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:18 -0400
Received: by mail-vk1-f202.google.com with SMTP id x200so1274041vkd.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R/qlnN5swd6KNpS40/ENO5jEHr+yfMZHtHoN2nA1GH4=;
        b=MywmCXGOSxduco3tzSSrEQJ9LT7/DfTkFr82xbRfAKYP1T7GhQFUSTPg3XL0FOdP3z
         b2y/SM1lHtdf4pibNSsAnFbEVDf/fX8cMUMKuMwpkqVVItFdqWEaraVHUBzSTZOYY/Ik
         A+NWJF2FDmnBW3ZAirMNkfPIVK/l/fH7xWP0MFJY2czrWMmZoL+kS63FHYhNTMdcNdE6
         CfoKoSEyy0oxrVlKUkvFAVrpMrgSY+oXAc7JTrrO2yufKnZXTpd9dPPJa06USS4AbZdL
         EF1jZXhnjO9QSaDFgYAyLRQ+8qsF1mnhTEgNoNv6eya+Borw9SJVV1eFYBqh4y00xfIe
         sLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R/qlnN5swd6KNpS40/ENO5jEHr+yfMZHtHoN2nA1GH4=;
        b=BhTCYTJODNseAR28SYad0OgSpAG3SDOHs2gS68Z/69sXDZOAuPH83uRNzQcYzBo5ea
         WitJtqsV8U7D9ZQ67XsAHgtu2QrXNx3iHVYGSAmRDzTDM/xVH4vEkud/tthC/RIRHN4Q
         TkKjMrX4EF5ehuQPf1R2VwCUOHY0dLv0PxIHxCdzJFe+HGCQ/vCoe2R7Ns42RrLJ8S2T
         YNvpmmBvP5Yzinl7a/N4dJLjvTDV6wscocglf/h1biUpbX19Wk8PwccvAsJurLgA/qsV
         iRQyKMgsPi8i1OQhEHdjlekaGB5I3vn+Y5XG2RpJJIC4gV+6GlSpDFi5Hjgy2EcITcnz
         VqGA==
X-Gm-Message-State: APjAAAVrflrFsTVxL8O1KSOzXQac8/D4R9R4hbtlsMp6ToZWYlSIfVoS
        FPfEH2sCtPIOLY1G5vMdilIsHmQ=
X-Google-Smtp-Source: APXvYqw8eG8ing9MdB5OiT9sHLij91UR8whLDGKsKKQ5EjNNof+tA/OqF5hU7FcoSl/qW4IsEzKnrlw=
X-Received: by 2002:a1f:ae91:: with SMTP id x139mr7474312vke.67.1553284756968;
 Fri, 22 Mar 2019 12:59:16 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:58:59 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-5-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 4/8] bpf: when doing BPF_PROG_TEST_RUN for flow
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
index 7444ca87abf4..ce7341c473a2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -249,12 +249,12 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
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
@@ -262,43 +262,31 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (prog->type != BPF_PROG_TYPE_FLOW_DISSECTOR)
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
+	ctx.protocol = eth->h_proto;
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
+		retval = bpf_flow_dissect(prog, &ctx, ETH_HLEN, size);
+
+		flow_keys.nhoff -= ETH_HLEN;
+		flow_keys.thoff -= ETH_HLEN;
 
 		if (signal_pending(current)) {
 			preempt_enable();
@@ -331,7 +319,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 			      retval, duration);
 
 out:
-	kfree_skb(skb);
-	kfree(sk);
+	kfree(data);
 	return ret;
 }
-- 
2.21.0.392.gf8f6787159e-goog

