Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDAEC282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E113E2077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwJY+Sw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfDVP4B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:01 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:51892 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDVP4A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:00 -0400
Received: by mail-ot1-f73.google.com with SMTP id 64so7604908ota.18
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IMa+IJQb/rcGX6ys0L2fnGAYnlLUJpE1UQMAmRFOl3w=;
        b=OwJY+Sw8dtlEV4kqNX5hTivplTfMCsCxs3UmtFfcPdGvLgiDIyjv9wvi+F1h1lflw5
         HgDLBFDsZwy7W4GZ2uqUjXVaC8rnFMAbfwUcfr7UOzOhjxw+SgkX3jcAVrmiTn/Yi7Yp
         NDZ73Fg7uDljSxnY3ZBWWUd8288dlkF8uj997NxejSHRZdDlGsJqggEQpHoR3C+lUVKC
         O62vHzjIdo5N35d0DeIpjV6mHQssk0u9P6M7Qywt30s776blSZN+pDen3eAV4Km4EVoy
         K4xPsr+FsyZ7ehEdked2a+Mac1imLx0h5snTjEgDj8fTvRmdubVwiYS04h2GvuLYYViY
         GxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IMa+IJQb/rcGX6ys0L2fnGAYnlLUJpE1UQMAmRFOl3w=;
        b=JxtKJLPtEgTdiL5U3SS0g3gLUJ6wiKa7zQmaDMvKg+56utWFzYYzCpJtIpLjDnLfbL
         D2vBDXhh1LpCrHKaWU6swM7YBAvXMUsa5hgm/dFMYmA34WCAlizktdXDEKTTJAzhcrEz
         hMcerxzNWxkqe8OpC7XaV5lEmgHbW9U11fI6eU0kXrMGHnHLK5snip7lAb1Yv/wV16hg
         4Fm9gxOoZVZj8KP8+rAQbxpafO3BDFQmDEjAqKxGLMwGQj5x06E3oehzenrKGmvHnC7T
         oDCkGp8KruylDj2wcqgBk4HLIF0wG78c7hoKLZWwgfYgCLA+PBcC1H6ebunHpsNumx+n
         pK0A==
X-Gm-Message-State: APjAAAVve4UDzM4SDyUft3yLu9vTnIV7PQVj7KgHJ7dyOSTWuL6m7VEy
        vfEZA05vPHgaptTkNNUqCxwxFHM=
X-Google-Smtp-Source: APXvYqwVHw7pDsL1+S7xI21lT/OTLkcGlzBmnbieoOlVSvCW1fZSErt58510vvNLvMUeTkcIhl1G0ss=
X-Received: by 2002:aca:60c2:: with SMTP id u185mr11135764oib.99.1555948559629;
 Mon, 22 Apr 2019 08:55:59 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:45 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-3-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 2/9] bpf: when doing BPF_PROG_TEST_RUN for flow
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
2.21.0.593.g511ec345e18-goog

