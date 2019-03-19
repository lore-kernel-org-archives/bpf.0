Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD9C4360F
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703F9217F4
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW6T0Btq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCSWUG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:06 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:48904 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfCSWUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:05 -0400
Received: by mail-io1-f73.google.com with SMTP id 186so207798iox.15
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ot4YjTheNksiof68PiocLGjhL7teUjBqTTDotsScvGA=;
        b=hW6T0BtqZIknv5F7vxjL/ozgDsf2H7j7jERccgvv9kIR1r+furQg6xoh2DlXhrLrrY
         vtBBB7oSFXI4hvDtkxwK5xhRIN4M5ll63i4YOYsdbkXiJqVYGLqDr3VYhf6Wv6uzep1/
         /aH9bOBaNUmPzLio5Nzl1lzUZ1ctt1/ZwJv79bOWmdy74zyc7HLPevwZz/23e1t6l/zD
         s66cbbgVwPUQK4RLKT63rzWCMt50iHjOYBe/fzeJhLfwjg+XZOVhhbIRvDekd/gKmXms
         KlR5DXYfkGfl7GR5hgVzbXm2q9txlrQSCIC1oCL4UTSvicceyN2KnGHiSBa3q4jgfews
         uYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ot4YjTheNksiof68PiocLGjhL7teUjBqTTDotsScvGA=;
        b=hp4N6WFox0+VL/M2flN1DFFxJLl0qbsy5O49nHu+AiG7iUrLe1RKj26eCfyvZrHoaC
         VHZvpESkrrhXCrrzTVSyBSgPZwuglAngEtRHXv03qjqSo25a74Pychj41cbZ6LDBy3Yx
         MyPJSkDtTVSBUZhPPLuqjGTFC4HEPRCsTDDs0IHRw8iy2eLeKsonQdDdUW6SCcxpodLs
         Sg8U6m3jY0uklxFaBbIxBngkuiNN5ntbZNLk8t4wavSkiuRKhiJ3+CHem50wjQuI+kMv
         w1jAwDv6Ve9xjO7hJXloYULZxPrFruQTLHkTAbOgyC52IUDR9PCjplyDLKYMJC5xInlh
         Z+NQ==
X-Gm-Message-State: APjAAAXv4cZCoRYyuxyXusNwqEmfmHI/U0kShjiBhPgTC/rgma4atu30
        iaI9XcgLzJMWizSINT53uTRwxU8=
X-Google-Smtp-Source: APXvYqxmRx1w6Z5kz8OG85qiGkgqBtxiz6Mq4hNOg25uYDMArtgsIagYP8J18LXjOP+WIozOG0e9XYs=
X-Received: by 2002:a05:660c:48:: with SMTP id p8mr2809067itk.31.1553034003916;
 Tue, 19 Mar 2019 15:20:03 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:43 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-5-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 4/9] net: flow_dissector: prepare for no-skb use case
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

Create helpers that will be reused by both versions:
* init_flow_keys - initialize flow keys
* clamp_flow_keys - clam flow keys when done

Rename (to have consistent bpf_flow_ prefix):
* __skb_flow_bpf_dissect to bpf_flow_dissect_skb
* __skb_flow_bpf_to_target to bpf_flow_keys_to_target

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/skbuff.h    |  8 +++---
 net/bpf/test_run.c        |  6 ++---
 net/core/flow_dissector.c | 56 +++++++++++++++++++++++++--------------
 3 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4ca4c60cbacb..194dbc2985e5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1278,10 +1278,10 @@ static inline int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 struct net *skb_net(const struct sk_buff *skb);
 
 struct bpf_flow_keys;
-bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
-			    const struct sk_buff *skb,
-			    struct flow_dissector *flow_dissector,
-			    struct bpf_flow_keys *flow_keys);
+bool bpf_flow_dissect_skb(struct bpf_prog *prog,
+			  const struct sk_buff *skb,
+			  struct flow_dissector *flow_dissector,
+			  struct bpf_flow_keys *flow_keys);
 bool __skb_flow_dissect(struct net *net,
 			const struct sk_buff *skb,
 			struct flow_dissector *flow_dissector,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index fab142b796ef..512773a95ad5 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -300,9 +300,9 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	preempt_disable();
 	time_start = ktime_get_ns();
 	for (i = 0; i < repeat; i++) {
-		retval = __skb_flow_bpf_dissect(prog, skb,
-						&flow_keys_dissector,
-						&flow_keys);
+		retval = bpf_flow_dissect_skb(prog, skb,
+					      &flow_keys_dissector,
+					      &flow_keys);
 
 		if (signal_pending(current)) {
 			preempt_enable();
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e13165e7528c..ab43f9bd7ec4 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -629,9 +629,9 @@ static bool skb_flow_dissect_allowed(int *num_hdrs)
 	return (*num_hdrs <= MAX_FLOW_DISSECT_HDRS);
 }
 
-static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
-				     struct flow_dissector *flow_dissector,
-				     void *target_container)
+static void bpf_flow_keys_to_target(const struct bpf_flow_keys *flow_keys,
+				    struct flow_dissector *flow_dissector,
+				    void *target_container)
 {
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_basic *key_basic;
@@ -683,10 +683,32 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 	}
 }
 
-bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
-			    const struct sk_buff *skb,
-			    struct flow_dissector *flow_dissector,
-			    struct bpf_flow_keys *flow_keys)
+static inline void init_flow_keys(struct bpf_flow_keys *flow_keys,
+				  const struct sk_buff *skb, int nhoff)
+{
+	struct bpf_skb_data_end *cb = (struct bpf_skb_data_end *)skb->cb;
+
+	memset(cb, 0, sizeof(*cb));
+	memset(flow_keys, 0, sizeof(*flow_keys));
+
+	flow_keys->nhoff = nhoff;
+	flow_keys->thoff = nhoff;
+
+	cb->qdisc_cb.flow_keys = flow_keys;
+}
+
+static inline void clamp_flow_keys(struct bpf_flow_keys *flow_keys,
+				   int hlen)
+{
+	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, hlen);
+	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
+				   flow_keys->nhoff, hlen);
+}
+
+bool bpf_flow_dissect_skb(struct bpf_prog *prog,
+			  const struct sk_buff *skb,
+			  struct flow_dissector *flow_dissector,
+			  struct bpf_flow_keys *flow_keys)
 {
 	struct bpf_skb_data_end cb_saved;
 	struct bpf_skb_data_end *cb;
@@ -702,13 +724,9 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 
 	/* Save Control Block */
 	memcpy(&cb_saved, cb, sizeof(cb_saved));
-	memset(cb, 0, sizeof(*cb));
 
 	/* Pass parameters to the BPF program */
-	memset(flow_keys, 0, sizeof(*flow_keys));
-	cb->qdisc_cb.flow_keys = flow_keys;
-	flow_keys->nhoff = skb_network_offset(skb);
-	flow_keys->thoff = flow_keys->nhoff;
+	init_flow_keys(flow_keys, skb, skb_network_offset(skb));
 
 	bpf_compute_data_pointers((struct sk_buff *)skb);
 	result = BPF_PROG_RUN(prog, skb);
@@ -716,9 +734,7 @@ bool __skb_flow_bpf_dissect(struct bpf_prog *prog,
 	/* Restore state */
 	memcpy(cb, &cb_saved, sizeof(cb_saved));
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, 0, skb->len);
-	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-				   flow_keys->nhoff, skb->len);
+	clamp_flow_keys(flow_keys, skb->len);
 
 	return result == BPF_OK;
 }
@@ -806,11 +822,11 @@ bool __skb_flow_dissect(struct net *net,
 			attached = rcu_dereference(net->flow_dissector_prog);
 
 		if (attached) {
-			ret = __skb_flow_bpf_dissect(attached, skb,
-						     flow_dissector,
-						     &flow_keys);
-			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
-						 target_container);
+			ret = bpf_flow_dissect_skb(attached, skb,
+						   flow_dissector,
+						   &flow_keys);
+			bpf_flow_keys_to_target(&flow_keys, flow_dissector,
+						target_container);
 			rcu_read_unlock();
 			return ret;
 		}
-- 
2.21.0.225.g810b269d1ac-goog

