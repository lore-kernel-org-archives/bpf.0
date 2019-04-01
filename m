Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC268C4360F
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC7E2146E
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjkQsOmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfDAU5k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:57:40 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51275 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfDAU5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Apr 2019 16:57:40 -0400
Received: by mail-qk1-f201.google.com with SMTP id d131so9626714qkc.18
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y3TliTs0aijbDRothocX4Y57zxWLII5xm2hIPwHkEEU=;
        b=fjkQsOmwiA5ldjdUvwVFCLBmObZ2DpeeFjw7rAdxfJwI/7mF0Nlti2Q8wcj4/tlSuK
         e2QzJwArejjqZznS1kk/CXEfFQ7jEhd5CETnYHgsXk8nHn2XPA9Kb7iA0xF1LGHaG15X
         p9U8BKzM4sjP81LAuBud9JjtXz9Cet5xWtiKjDepfNIriG9hSb9m1QQ0L8gBdgtOz4/F
         E0R23tkDadxVRvMgqMXrwhn/PRUb7zf9uY4ldIisbiYQDN2vmt1k7kzSPhDC1F//aUEM
         TMTMLBntuNfqQmqjr/PsXDM+UMKAM+VN40vFe/QRlAqvuvUSNZTboLPbbSXH14bl36et
         jSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y3TliTs0aijbDRothocX4Y57zxWLII5xm2hIPwHkEEU=;
        b=JRwilY68lZUprKeikNTDS6nkluj+D/STevPRgxNUwcdlKMdjUMvWwIMnb4HlIz1YO6
         OiKEVbb9YM2TAIlocGRclJmhK99ZnMYWxJ0aH4A6yFUSlH06JeT6IPCH+P5VZgzSmaKE
         itNMqyKe+c7XsDS/clSxgKSx/6HUxmvUdTPki7/dUAdkCTA6dzuoP9tCew/vVj2L8xT7
         9Qd7IJOvmoSr+exVvbeSVRpk0QkHfZfDsDwDtMQJEPTqfdkJq/pzKeAIdcXPnUXwyZmx
         jh7v262QoEhn3IJFO1WsxPTPPvhfA+S+UHXisQO5KX6GGsF8QjeFt9UNbe/ZY1yA++t+
         maPQ==
X-Gm-Message-State: APjAAAVqPq0llKEKhJdhIpFe6u+tDdZNevJ3bD+0fLjuvKyV/3sOzg69
        kyv2bUiPC8/XazmvFC+br0PmJuw=
X-Google-Smtp-Source: APXvYqyrRMfXToIRB+kOvCmmQYYj3GHefWISrBHhcFvvtWdG5RJshMfG4XGsSwphZUGEjpMmvoxgtbQ=
X-Received: by 2002:ac8:304d:: with SMTP id g13mr7554825qte.44.1554152259386;
 Mon, 01 Apr 2019 13:57:39 -0700 (PDT)
Date:   Mon,  1 Apr 2019 13:57:30 -0700
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Message-Id: <20190401205734.4400-2-sdf@google.com>
Mime-Version: 1.0
References: <20190401205734.4400-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf 1/5] selftests/bpf: fix vlan handling in flow dissector program
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

When we tail call PROG(VLAN) from parse_eth_proto we don't need to peek
back to handle vlan proto because we didn't adjust nhoff/thoff yet. Use
flow_keys->n_proto, that we set in parse_eth_proto instead and
properly increment nhoff as well.

Also, always use skb->protocol and don't look at skb->vlan_present.
skb->vlan_present indicates that vlan information is stored out-of-band
in skb->vlan_{tci,proto} and vlan header is already pulled from skb.
That means, skb->vlan_present == true is not relevant for BPF flow
dissector.

Add simple test cases with VLAN tagged frames:
  * single vlan for ipv4
  * double vlan for ipv6

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 68 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_flow.c  | 15 ++--
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index bcbd928c96ab..fc818bc1d729 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -39,6 +39,58 @@ static struct bpf_flow_keys pkt_v6_flow_keys = {
 	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
 };
 
+#define VLAN_HLEN	4
+
+static struct {
+	struct ethhdr eth;
+	__u16 vlan_tci;
+	__u16 vlan_proto;
+	struct iphdr iph;
+	struct tcphdr tcp;
+} __packed pkt_vlan_v4 = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_8021Q),
+	.vlan_proto = __bpf_constant_htons(ETH_P_IP),
+	.iph.ihl = 5,
+	.iph.protocol = IPPROTO_TCP,
+	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+	.tcp.urg_ptr = 123,
+	.tcp.doff = 5,
+};
+
+static struct bpf_flow_keys pkt_vlan_v4_flow_keys = {
+	.nhoff = VLAN_HLEN,
+	.thoff = VLAN_HLEN + sizeof(struct iphdr),
+	.addr_proto = ETH_P_IP,
+	.ip_proto = IPPROTO_TCP,
+	.n_proto = __bpf_constant_htons(ETH_P_IP),
+};
+
+static struct {
+	struct ethhdr eth;
+	__u16 vlan_tci;
+	__u16 vlan_proto;
+	__u16 vlan_tci2;
+	__u16 vlan_proto2;
+	struct ipv6hdr iph;
+	struct tcphdr tcp;
+} __packed pkt_vlan_v6 = {
+	.eth.h_proto = __bpf_constant_htons(ETH_P_8021AD),
+	.vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
+	.vlan_proto2 = __bpf_constant_htons(ETH_P_IPV6),
+	.iph.nexthdr = IPPROTO_TCP,
+	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+	.tcp.urg_ptr = 123,
+	.tcp.doff = 5,
+};
+
+static struct bpf_flow_keys pkt_vlan_v6_flow_keys = {
+	.nhoff = VLAN_HLEN * 2,
+	.thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
+	.addr_proto = ETH_P_IPV6,
+	.ip_proto = IPPROTO_TCP,
+	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+};
+
 void test_flow_dissector(void)
 {
 	struct bpf_flow_keys flow_keys;
@@ -68,5 +120,21 @@ void test_flow_dissector(void)
 	      err, errno, retval, duration, size, sizeof(flow_keys));
 	CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
 
+	err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v4, sizeof(pkt_vlan_v4),
+				&flow_keys, &size, &retval, &duration);
+	CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv4",
+	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+	CHECK_FLOW_KEYS("vlan_ipv4_flow_keys", flow_keys,
+			pkt_vlan_v4_flow_keys);
+
+	err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v6, sizeof(pkt_vlan_v6),
+				&flow_keys, &size, &retval, &duration);
+	CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv6",
+	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+	CHECK_FLOW_KEYS("vlan_ipv6_flow_keys", flow_keys,
+			pkt_vlan_v6_flow_keys);
+
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index 284660f5aa95..f177c7a6a6c7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -119,10 +119,7 @@ static __always_inline int parse_eth_proto(struct __sk_buff *skb, __be16 proto)
 SEC("flow_dissector")
 int _dissect(struct __sk_buff *skb)
 {
-	if (!skb->vlan_present)
-		return parse_eth_proto(skb, skb->protocol);
-	else
-		return parse_eth_proto(skb, skb->vlan_proto);
+	return parse_eth_proto(skb, skb->protocol);
 }
 
 /* Parses on IPPROTO_* */
@@ -336,15 +333,9 @@ PROG(VLAN)(struct __sk_buff *skb)
 {
 	struct bpf_flow_keys *keys = skb->flow_keys;
 	struct vlan_hdr *vlan, _vlan;
-	__be16 proto;
-
-	/* Peek back to see if single or double-tagging */
-	if (bpf_skb_load_bytes(skb, keys->thoff - sizeof(proto), &proto,
-			       sizeof(proto)))
-		return BPF_DROP;
 
 	/* Account for double-tagging */
-	if (proto == bpf_htons(ETH_P_8021AD)) {
+	if (keys->n_proto == bpf_htons(ETH_P_8021AD)) {
 		vlan = bpf_flow_dissect_get_header(skb, sizeof(*vlan), &_vlan);
 		if (!vlan)
 			return BPF_DROP;
@@ -352,6 +343,7 @@ PROG(VLAN)(struct __sk_buff *skb)
 		if (vlan->h_vlan_encapsulated_proto != bpf_htons(ETH_P_8021Q))
 			return BPF_DROP;
 
+		keys->nhoff += sizeof(*vlan);
 		keys->thoff += sizeof(*vlan);
 	}
 
@@ -359,6 +351,7 @@ PROG(VLAN)(struct __sk_buff *skb)
 	if (!vlan)
 		return BPF_DROP;
 
+	keys->nhoff += sizeof(*vlan);
 	keys->thoff += sizeof(*vlan);
 	/* Only allow 8021AD + 8021Q double tagging and no triple tagging.*/
 	if (vlan->h_vlan_encapsulated_proto == bpf_htons(ETH_P_8021AD) ||
-- 
2.21.0.392.gf8f6787159e-goog

