Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9064C4360F
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99032183E
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcFRCZn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCSWUN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:13 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33049 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfCSWUM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:12 -0400
Received: by mail-pg1-f201.google.com with SMTP id y1so532548pgo.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0YbiokuD7mcfeLNVd8EwsFglMqhzlcAVUChF2fLflaU=;
        b=JcFRCZn566Qs8elxcn1nOs0dSV6FfJwyJK4VVHfJ0Wm86xgpaK34z3+hsVY4nDsiSB
         YsZMlHyC6MAvA2ZdBeN/oI0GVLbnE8pMBKBbLvQ4mCzml33K3DQoP8kKI8TEAkvqc3Dp
         wUabccu2kdsH2J/jPhRa86/lT6QqXomHP2U3Rcp8I4H0BKI7HTlRzJsXAgERRd0w9xZY
         Oxccre3o67uY/b/2PcydSVdRlJSpIWttZ2zSUmxx5LnkkQCE7th22KYDsoa+n7nbGiiI
         hVL2Orl6x7sSQWpysK8HAl3PclvI8E7k/Z/lTIy4bDDIS6ajMnSnpZK32l7+Qs37/mYR
         9URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0YbiokuD7mcfeLNVd8EwsFglMqhzlcAVUChF2fLflaU=;
        b=fM6ztsP1dCyntuorQoi7AOpfbuv/nOsL/a2JBEXuAcwafHf3ejaoy8AJulyngcwrBh
         GznTzXmhATbAPKynLfI3JjjUynH70tusXscxfL2qsItjuazgzeO8AthiONekGEQwMPBE
         GuhN1eWDdx8igyLb50coal11TRbF85eybUuPo3wWgKztgK16dwlvuNoH0+Ecs/dFgd/i
         C4LnlhNyoIt55xZ1CbaPH7gRSgdYKeybDurJX4z4n/N10ROZZg8iOe64Mj5JWf8e0eyN
         SRyPDiWKSKdKNQAhaAm9q7g5wHbwXR74SabeiWKeYZC/d3EUddHB8QdQqilR7ZfQ2qdu
         1aHw==
X-Gm-Message-State: APjAAAUwdltjwOD8dOdPWXmP87MBkMd7z+aPUByvDVonQSfO/u5GOMnr
        W5lzmpxLZqlTKHeCHuc6gfHhspg=
X-Google-Smtp-Source: APXvYqwpmBJEDcUXg5+km60N6MdyQl5WVr3dNBvFsjBWpWz8yUYCTaSBq2+vq8r/QfSrMVPCtpjO8z0=
X-Received: by 2002:a17:902:18a:: with SMTP id b10mr7287182plb.139.1553034011552;
 Tue, 19 Mar 2019 15:20:11 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:46 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-8-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 7/9] bpf: when doing BPF_PROG_TEST_RUN for flow
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

Now that we have __flow_bpf_dissect which works on raw data (by
constructing temporary on-stack skb), use it when doing
BPF_PROG_TEST_RUN for flow dissector.

This should help us catch any possible bugs due to missing shinfo on
the per-cpu skb.

Note that existing __skb_flow_bpf_dissect swallows L2 headers and returns
nhoff=0, we need to preserve the existing behavior.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 48 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 512773a95ad5..90f7eaf129c6 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -252,10 +252,8 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	u32 repeat = kattr->test.repeat;
 	struct bpf_flow_keys flow_keys;
 	u64 time_start, time_spent = 0;
-	struct bpf_skb_data_end *cb;
+	const struct ethhdr *eth;
 	u32 retval, duration;
-	struct sk_buff *skb;
-	struct sock *sk;
 	void *data;
 	int ret;
 	u32 i;
@@ -263,35 +261,14 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
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
-
-	cb = (struct bpf_skb_data_end *)skb->cb;
-	cb->qdisc_cb.flow_keys = &flow_keys;
+	eth = (struct ethhdr *)data;
 
 	if (!repeat)
 		repeat = 1;
@@ -300,9 +277,13 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	preempt_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		retval = bpf_flow_dissect_skb(prog, skb,
-					      &flow_keys_dissector,
-					      &flow_keys);
+		retval = bpf_flow_dissect(prog, data, eth->h_proto, ETH_HLEN,
+					  size, &flow_keys_dissector,
+					  &flow_keys);
+		if (flow_keys.nhoff >= ETH_HLEN)
+			flow_keys.nhoff -= ETH_HLEN;
+		if (flow_keys.thoff >= ETH_HLEN)
+			flow_keys.thoff -= ETH_HLEN;
 
 		if (signal_pending(current)) {
 			preempt_enable();
@@ -335,7 +316,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 			      retval, duration);
 
 out:
-	kfree_skb(skb);
-	kfree(sk);
+	kfree(data);
 	return ret;
 }
-- 
2.21.0.225.g810b269d1ac-goog

