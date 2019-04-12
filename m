Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB07C282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC9C2086D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcDM29WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDLXnO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:43:14 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:47457 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDLXnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 19:43:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id y10so7204129pll.14
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g/cyV4WuoaBHu1NhEP9H46t6Q3YDa19an5EJQmvXrDw=;
        b=fcDM29WJozXSLoDfIhAf9Btf+eP5qWm85QWeTM/CaX3w86p+7j5Xm8l8mhyJRKD2OL
         IXQEy283Lzk+AEutVPJaZuq4ZmhFKJw+ZfUhRlabR4FDceEiZtqiaSnFAnObQ7qpcR+V
         0Kk9nmPcjyoLdckKZHCTStbn1EBvXJZUql8H+YgSvaUf1XPp3fVt4Ad7QGmvws8/eC0r
         pdZy6gPDCSm7hUNUZ9l189aAgVgjoQQ6wkmdyGZkMEIot6LBPhrqMnAE+vrLND4I2/kq
         pnCpi+nF/vqo3NaUiN+YBx+YeUw00um9oSeKlR0rEbw+6B+tw7wXyX5DijZwUJm21+Mm
         j75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g/cyV4WuoaBHu1NhEP9H46t6Q3YDa19an5EJQmvXrDw=;
        b=UNyMe+qscT2E37C95bCmJcR5+rFqSzp5AR7xPfxlrzKzLx+wQAdklogzAv1I3xpy+U
         n5KswrK7E5nvIwtyBXhhOWCh9up/ZT89L3tl9kaNFjJKuiRXzR88bsiN3jZrDXQZwtGG
         vN/jN4XgSZytTzwhAVYqawxs7B2VoIKHUsaW3K1kuQtA+en50VCWg0GThS5IaKnLTIrh
         bHgJ/GzwBs5Oqxnsya5lfCNCcjydcvQeE1kJUIwIddUmJA2MURUQmNHkeiV7/bA3fvI6
         2vxUN/u+q8YhDR2BK9LTvI6VdMkXaMF8FWM0trXeuACGu+C0hkGn6NdJaYaoCr5cO2Cv
         g9Og==
X-Gm-Message-State: APjAAAXyp9WUOUTYVy6TFy4u8/o5pk0E3f5okSZOYizyD4wezseqQCe7
        gTYw3mHmjNcRmyVThOgQtKknSxM=
X-Google-Smtp-Source: APXvYqyB7I24B50P1Co2tyrIxuOgi60uvvbHofUt4JkMGMTklGeptix9J5hm/OFbmRDn94+4E6rgctM=
X-Received: by 2002:a63:7408:: with SMTP id p8mr1168562pgc.56.1555112593248;
 Fri, 12 Apr 2019 16:43:13 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:43:10 -0700
Message-Id: <20190412234310.174978-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next] selftests/bpf: make flow dissector tests more extensible
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rewrite selftest to iterate over an array with input packet and
expected flow_keys. This should make it easier to extend this test
with additional cases without too much boilerplate.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/flow_dissector.c | 197 +++++++++++-------
 1 file changed, 116 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index fc818bc1d729..1a73937826b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 
 #define CHECK_FLOW_KEYS(desc, got, expected)				\
-	CHECK(memcmp(&got, &expected, sizeof(got)) != 0,		\
+	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
 	      desc,							\
 	      "nhoff=%u/%u "						\
 	      "thoff=%u/%u "						\
@@ -10,6 +10,7 @@
 	      "is_frag=%u/%u "						\
 	      "is_first_frag=%u/%u "					\
 	      "is_encap=%u/%u "						\
+	      "ip_proto=0x%x/0x%x "					\
 	      "n_proto=0x%x/0x%x "					\
 	      "sport=%u/%u "						\
 	      "dport=%u/%u\n",						\
@@ -19,53 +20,32 @@
 	      got.is_frag, expected.is_frag,				\
 	      got.is_first_frag, expected.is_first_frag,		\
 	      got.is_encap, expected.is_encap,				\
+	      got.ip_proto, expected.ip_proto,				\
 	      got.n_proto, expected.n_proto,				\
 	      got.sport, expected.sport,				\
 	      got.dport, expected.dport)
 
-static struct bpf_flow_keys pkt_v4_flow_keys = {
-	.nhoff = 0,
-	.thoff = sizeof(struct iphdr),
-	.addr_proto = ETH_P_IP,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IP),
-};
-
-static struct bpf_flow_keys pkt_v6_flow_keys = {
-	.nhoff = 0,
-	.thoff = sizeof(struct ipv6hdr),
-	.addr_proto = ETH_P_IPV6,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
-};
-
-#define VLAN_HLEN	4
+struct ipv4_pkt {
+	struct ethhdr eth;
+	struct iphdr iph;
+	struct tcphdr tcp;
+} __packed;
 
-static struct {
+struct svlan_ipv4_pkt {
 	struct ethhdr eth;
 	__u16 vlan_tci;
 	__u16 vlan_proto;
 	struct iphdr iph;
 	struct tcphdr tcp;
-} __packed pkt_vlan_v4 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_8021Q),
-	.vlan_proto = __bpf_constant_htons(ETH_P_IP),
-	.iph.ihl = 5,
-	.iph.protocol = IPPROTO_TCP,
-	.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
-	.tcp.urg_ptr = 123,
-	.tcp.doff = 5,
-};
+} __packed;
 
-static struct bpf_flow_keys pkt_vlan_v4_flow_keys = {
-	.nhoff = VLAN_HLEN,
-	.thoff = VLAN_HLEN + sizeof(struct iphdr),
-	.addr_proto = ETH_P_IP,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IP),
-};
+struct ipv6_pkt {
+	struct ethhdr eth;
+	struct ipv6hdr iph;
+	struct tcphdr tcp;
+} __packed;
 
-static struct {
+struct dvlan_ipv6_pkt {
 	struct ethhdr eth;
 	__u16 vlan_tci;
 	__u16 vlan_proto;
@@ -73,31 +53,97 @@ static struct {
 	__u16 vlan_proto2;
 	struct ipv6hdr iph;
 	struct tcphdr tcp;
-} __packed pkt_vlan_v6 = {
-	.eth.h_proto = __bpf_constant_htons(ETH_P_8021AD),
-	.vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
-	.vlan_proto2 = __bpf_constant_htons(ETH_P_IPV6),
-	.iph.nexthdr = IPPROTO_TCP,
-	.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
-	.tcp.urg_ptr = 123,
-	.tcp.doff = 5,
+} __packed;
+
+struct test {
+	const char *name;
+	union {
+		struct ipv4_pkt ipv4;
+		struct svlan_ipv4_pkt svlan_ipv4;
+		struct ipv6_pkt ipv6;
+		struct dvlan_ipv6_pkt dvlan_ipv6;
+	} pkt;
+	struct bpf_flow_keys keys;
 };
 
-static struct bpf_flow_keys pkt_vlan_v6_flow_keys = {
-	.nhoff = VLAN_HLEN * 2,
-	.thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
-	.addr_proto = ETH_P_IPV6,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+#define VLAN_HLEN	4
+
+struct test tests[] = {
+	{
+		.name = "ipv4",
+		.pkt.ipv4 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_TCP,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+		},
+		.keys = {
+			.nhoff = 0,
+			.thoff = sizeof(struct iphdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+		},
+	},
+	{
+		.name = "ipv6",
+		.pkt.ipv6 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_IPV6),
+			.iph.nexthdr = IPPROTO_TCP,
+			.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+		},
+		.keys = {
+			.nhoff = 0,
+			.thoff = sizeof(struct ipv6hdr),
+			.addr_proto = ETH_P_IPV6,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+		},
+	},
+	{
+		.name = "802.1q-ipv4",
+		.pkt.svlan_ipv4 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_8021Q),
+			.vlan_proto = __bpf_constant_htons(ETH_P_IP),
+			.iph.ihl = 5,
+			.iph.protocol = IPPROTO_TCP,
+			.iph.tot_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+		},
+		.keys = {
+			.nhoff = VLAN_HLEN,
+			.thoff = VLAN_HLEN + sizeof(struct iphdr),
+			.addr_proto = ETH_P_IP,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IP),
+		},
+	},
+	{
+		.name = "802.1ad-ipv6",
+		.pkt.dvlan_ipv6 = {
+			.eth.h_proto = __bpf_constant_htons(ETH_P_8021AD),
+			.vlan_proto = __bpf_constant_htons(ETH_P_8021Q),
+			.vlan_proto2 = __bpf_constant_htons(ETH_P_IPV6),
+			.iph.nexthdr = IPPROTO_TCP,
+			.iph.payload_len = __bpf_constant_htons(MAGIC_BYTES),
+			.tcp.doff = 5,
+		},
+		.keys = {
+			.nhoff = VLAN_HLEN * 2,
+			.thoff = VLAN_HLEN * 2 + sizeof(struct ipv6hdr),
+			.addr_proto = ETH_P_IPV6,
+			.ip_proto = IPPROTO_TCP,
+			.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+		},
+	},
 };
 
 void test_flow_dissector(void)
 {
-	struct bpf_flow_keys flow_keys;
 	struct bpf_object *obj;
-	__u32 duration, retval;
 	int err, prog_fd;
-	__u32 size;
 
 	err = bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
 			    "jmp_table", &prog_fd);
@@ -106,35 +152,24 @@ void test_flow_dissector(void)
 		return;
 	}
 
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv4",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("ipv4_flow_keys", flow_keys, pkt_v4_flow_keys);
-
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_v6, sizeof(pkt_v6),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv6",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_flow_keys flow_keys;
+		struct bpf_prog_test_run_attr tattr = {
+			.prog_fd = prog_fd,
+			.data_in = &tests[i].pkt,
+			.data_size_in = sizeof(tests[i].pkt),
+			.data_out = &flow_keys,
+		};
 
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v4, sizeof(pkt_vlan_v4),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv4",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("vlan_ipv4_flow_keys", flow_keys,
-			pkt_vlan_v4_flow_keys);
-
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_vlan_v6, sizeof(pkt_vlan_v6),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "vlan_ipv6",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("vlan_ipv6_flow_keys", flow_keys,
-			pkt_vlan_v6_flow_keys);
+		err = bpf_prog_test_run_xattr(&tattr);
+		CHECK_ATTR(tattr.data_size_out != sizeof(flow_keys) ||
+			   err || tattr.retval != 1,
+			   tests[i].name,
+			   "err %d errno %d retval %d duration %d size %u/%lu\n",
+			   err, errno, tattr.retval, tattr.duration,
+			   tattr.data_size_out, sizeof(flow_keys));
+		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
+	}
 
 	bpf_object__close(obj);
 }
-- 
2.21.0.392.gf8f6787159e-goog

