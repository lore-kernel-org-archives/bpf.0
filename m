Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E7C282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2672D2077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOlzQS5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfDVP4T (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:19 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:35511 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfDVP4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id q127so10757230qkd.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2fq2MMPORxZhGH38KpOKAFN5yOd/xNa7oBRTzknpJ5U=;
        b=AOlzQS5hX8Sxxlt6DzU4QY7DhZ10GmA8QHZdxC1/MKhcyARpADOThQ1o4WiyzK+BsI
         xylyEbiILqNE+O+eFqQ0pprc3BnF7WoAcAWxadDu7RfkqPq1ySDi6tbHDwWDbvrGu/E2
         IC1TqZthvWti7++0uXrAohOb+j6sGyfLTj60xEpXuU8/iEN6r/K8RtSUJ+YIH0ycqc2Z
         duHx6iXY1rOpoNlpEeOR80+4DIu6qYMXvzcV9+Eaflp3HvFJxe2IWw3u5UUmszYvqhR5
         iJg86poR+nDiAauKoN8MKKwYIpGtvQKN9OZeIAK82zsRMlAbB4WuRmpwacQl+nRueTvy
         Ri+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2fq2MMPORxZhGH38KpOKAFN5yOd/xNa7oBRTzknpJ5U=;
        b=r2LzWoqXEonLjcWftJ5V2yYqVJvLoV+a8hlAznrKmi/GyfKqAxktd+73xMeTU/WD/l
         hxmnjOU9A+3PoJku3Lb5YxUDuUft+U8vNw2MZ1ekJzVPE3YzPBO+UPVFhy3cH7m/rsVZ
         jv+c72WxTc9dGy0lz4lacQD/wQBspisV2sbacVW9duubuPN8eizqlbya5vazfb+Nib6H
         mW9pn9XBvHUjYc51pvzuzuTvFwjvkujfLvjrSLaX5nIw4BRyZ6v+La/x77EzO+TJ+vyS
         gYzF8qCC3sXi39VIN32ODyHC9Ekx7h5rDvX3mGk7OZzf2NZ2cF//C1+EoPQq3haPJDJd
         BZ0w==
X-Gm-Message-State: APjAAAXl9j3fJCuHJXE1WkSVWxOzQ/UaDKECdwEtSwBOBizgQkL+p350
        SGG1kXej4x/6qzEOqjryutMTaps=
X-Google-Smtp-Source: APXvYqzss4K0+engY8HcqG8cPrN2suej+CR1oahbqo1xVwsaoC4kAtlThrrk8z+hWVs8kY4PIOTtmwM=
X-Received: by 2002:a0c:9e9a:: with SMTP id r26mr16061457qvd.57.1555948578271;
 Mon, 22 Apr 2019 08:56:18 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:52 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-10-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 9/9] bpf/flow_dissector: don't adjust nhoff by
 ETH_HLEN in BPF_PROG_TEST_RUN
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

Now that we use skb-less flow dissector let's return true nhoff and
thoff. We used to adjust them by ETH_HLEN because that's how it was
done in the skb case. For VLAN tests that looks confusing: nhoff is
pointing to vlan parts :-\

Warning, this is an API change for BPF_PROG_TEST_RUN! Feel free to drop
if you think that it's too late at this point to fix it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c                            |  3 ---
 .../selftests/bpf/prog_tests/flow_dissector.c | 23 ++++++++-----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index db2ec88ab129..8606e5aef0b6 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -418,9 +418,6 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 		retval = bpf_flow_dissect(prog, &ctx, eth->h_proto, ETH_HLEN,
 					  size);
 
-		flow_keys.nhoff -= ETH_HLEN;
-		flow_keys.thoff -= ETH_HLEN;
-
 		if (signal_pending(current)) {
 			preempt_enable();
 			rcu_read_unlock();
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 51758a0ca55e..8b54adfd6264 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -82,8 +82,8 @@ struct test tests[] = {
 			.tcp.doff = 5,
 		},
 		.keys = {
-			.nhoff = 0,
-			.thoff = sizeof(struct iphdr),
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct iphdr),
 			.addr_proto = ETH_P_IP,
 			.ip_proto = IPPROTO_TCP,
 			.n_proto = __bpf_constant_htons(ETH_P_IP),
@@ -98,8 +98,8 @@ struct test tests[] = {
 			.tcp.doff = 5,
 		},
 		.keys = {
-			.nhoff = 0,
-			.thoff = sizeof(struct ipv6hdr),
+			.nhoff = ETH_HLEN,
+			.thoff = ETH_HLEN + sizeof(struct ipv6hdr),
 			.addr_proto = ETH_P_IPV6,
 			.ip_proto = IPPROTO_TCP,
 			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
@@ -116,8 +116,8 @@ struct test tests[] = {
 			.tcp.doff = 5,
 		},
 		.keys = {
-			.nhoff = VLAN_HLEN,
-			.thoff = VLAN_HLEN + sizeof(struct iphdr),
+			.nhoff = ETH_HLEN + VLAN_HLEN,
+			.thoff = ETH_HLEN + VLAN_HLEN + sizeof(struct iphdr),
 			.addr_proto = ETH_P_IP,
 			.ip_proto = IPPROTO_TCP,
 			.n_proto = __bpf_constant_htons(ETH_P_IP),
@@ -134,8 +134,9 @@ struct test tests[] = {
 			.tcp.doff = 5,
 		},
 		.keys = {
-			.nhoff = VLAN_HLEN * 2,
-			.thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
+			.nhoff = ETH_HLEN + VLAN_HLEN * 2,
+			.thoff = ETH_HLEN + VLAN_HLEN * 2 +
+				sizeof(struct ipv6hdr),
 			.addr_proto = ETH_P_IPV6,
 			.ip_proto = IPPROTO_TCP,
 			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
@@ -238,9 +239,6 @@ void test_flow_dissector(void)
 	 * We use a known path in the net/tun driver that calls
 	 * eth_get_headlen and we manually export bpf_flow_keys
 	 * via BPF map in this case.
-	 *
-	 * Note, that since eth_get_headlen operates on a L2 level,
-	 * we adjust exported nhoff/thoff by ETH_HLEN.
 	 */
 
 	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
@@ -262,9 +260,6 @@ void test_flow_dissector(void)
 		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
 		CHECK_ATTR(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);
 
-		flow_keys.nhoff -= ETH_HLEN;
-		flow_keys.thoff -= ETH_HLEN;
-
 		CHECK_ATTR(err, tests[i].name, "skb-less err %d\n", err);
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
 	}
-- 
2.21.0.593.g511ec345e18-goog

