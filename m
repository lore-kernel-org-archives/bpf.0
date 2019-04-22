Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB9FC282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B002077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6vKvtBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfDVP4P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:15 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39932 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbfDVP4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:14 -0400
Received: by mail-pf1-f202.google.com with SMTP id c64so7860971pfb.6
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HwS8I54lO56IfesuDelg/DNQiKJA0C936RWpWXr86FE=;
        b=L6vKvtBbyrFyTpm2JPfAQVkxY5+Rjazn6TZ07Jnejt6/X5u6POtys/CiRQ0KklPnQY
         cmG5rfU35OJECHZeLr8/xsNw09GmiVmDiVRhNcqfgxsPJLc4uKhgXhLUx5woB+Fc4cOp
         aWn2hoURsmJZDF30oefiWNv6eT62cuV0SbY4pX4MCc9G0x/vLYXZFloYOxU3IbuQWM4Z
         guyMue6g4W1O/wPa1+l8OkK77uaf7+Y2P/7ffb7JIVOO8JfWfLpRBdzmp2iL/9psIfqB
         3hEizkpsRbYbX+ew3KugjVx60+5KGrK6S4OWAGeyzLi+mZVqL1YrHq54DqLtHB0BmeLr
         TT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HwS8I54lO56IfesuDelg/DNQiKJA0C936RWpWXr86FE=;
        b=L01Yo14K2kHrMt9DHIhzBwj/Zo+JoIHrsws+lHS21JPR94v312xejoTc0TIDIRdAMr
         5ID6B5WW++uvj4VH8mzZ4n4nx5bX7/c+01kVos/eycrxct9zhPslOareTfiMJR5xeQh+
         nROQiIJ4ahKxkROQ0alFQ+Dfc4sYHubv5IeiQAVnJ7Gyrr5RaU03DI2Db6LvYMl++Rq5
         4fqMfMJUoELqAVA0px6eqtZ1kqiY92uzgad9O0MysBWyrUuBJzd674gb3Upcc+Ctems1
         SeAOM00uqJrRONqKseVDqpbKXkTrDtaFDdjyzDWYn+O6MU/KXKQvhu1w9sUV9pVLMTeZ
         7fFA==
X-Gm-Message-State: APjAAAUWvve+MCHHj3mZ2Nl+5BKBpTRL6+Kv1DmF7+BjUcwcen/TITgB
        gFUie8c97h3n8s6KMMpzzsqgjxs=
X-Google-Smtp-Source: APXvYqw2qbxDGtj1vzQjyRWg9n5oX3LqTj5VNf3btoEqNT+v0N9RF9PsMEeJ3IQoVKXoIZfai0jiQ0Y=
X-Received: by 2002:a65:6108:: with SMTP id z8mr19567079pgu.106.1555948573036;
 Mon, 22 Apr 2019 08:56:13 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:50 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-8-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: run flow dissector tests in
 skb-less mode
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

Export last_dissection map from flow dissector and use a known place in
tun driver to trigger BPF flow dissection.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/flow_dissector_load.c       |   2 +-
 .../selftests/bpf/flow_dissector_load.h       |  16 ++-
 .../selftests/bpf/prog_tests/flow_dissector.c | 102 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/bpf_flow.c  |  79 +++++++++-----
 4 files changed, 165 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/flow_dissector_load.c b/tools/testing/selftests/bpf/flow_dissector_load.c
index 7136ab9ffa73..3fd83b9dc1bf 100644
--- a/tools/testing/selftests/bpf/flow_dissector_load.c
+++ b/tools/testing/selftests/bpf/flow_dissector_load.c
@@ -26,7 +26,7 @@ static void load_and_attach_program(void)
 	struct bpf_object *obj;
 
 	ret = bpf_flow_load(&obj, cfg_path_name, cfg_section_name,
-			    cfg_map_name, &prog_fd);
+			    cfg_map_name, NULL, &prog_fd, NULL);
 	if (ret)
 		error(1, 0, "bpf_flow_load %s", cfg_path_name);
 
diff --git a/tools/testing/selftests/bpf/flow_dissector_load.h b/tools/testing/selftests/bpf/flow_dissector_load.h
index 41dd6959feb0..eeb48b6fc827 100644
--- a/tools/testing/selftests/bpf/flow_dissector_load.h
+++ b/tools/testing/selftests/bpf/flow_dissector_load.h
@@ -9,10 +9,12 @@ static inline int bpf_flow_load(struct bpf_object **obj,
 				const char *path,
 				const char *section_name,
 				const char *map_name,
-				int *prog_fd)
+				const char *keys_map_name,
+				int *prog_fd,
+				int *keys_fd)
 {
 	struct bpf_program *prog, *main_prog;
-	struct bpf_map *prog_array;
+	struct bpf_map *prog_array, *keys;
 	int prog_array_fd;
 	int ret, fd, i;
 
@@ -37,6 +39,16 @@ static inline int bpf_flow_load(struct bpf_object **obj,
 	if (prog_array_fd < 0)
 		return ret;
 
+	if (keys_map_name && keys_fd) {
+		keys = bpf_object__find_map_by_name(*obj, keys_map_name);
+		if (!keys)
+			return -1;
+
+		*keys_fd = bpf_map__fd(keys);
+		if (*keys_fd < 0)
+			return -1;
+	}
+
 	i = 0;
 	bpf_object__for_each_program(prog, *obj) {
 		fd = bpf_program__fd(prog);
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 126319f9a97c..51758a0ca55e 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include <error.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
 
 #define CHECK_FLOW_KEYS(desc, got, expected)				\
 	CHECK_ATTR(memcmp(&got, &expected, sizeof(got)) != 0,		\
@@ -140,13 +143,73 @@ struct test tests[] = {
 	},
 };
 
+static int create_tap(const char *ifname)
+{
+	struct ifreq ifr = {
+		.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_NAPI | IFF_NAPI_FRAGS,
+	};
+	int fd, ret;
+
+	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0)
+		return -1;
+
+	ret = ioctl(fd, TUNSETIFF, &ifr);
+	if (ret)
+		return -1;
+
+	return fd;
+}
+
+static int tx_tap(int fd, void *pkt, size_t len)
+{
+	struct iovec iov[] = {
+		{
+			.iov_len = len,
+			.iov_base = pkt,
+		},
+	};
+	return writev(fd, iov, ARRAY_SIZE(iov));
+}
+
+static int ifup(const char *ifname)
+{
+	struct ifreq ifr = {};
+	int sk, ret;
+
+	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+
+	sk = socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return -1;
+
+	ret = ioctl(sk, SIOCGIFFLAGS, &ifr);
+	if (ret) {
+		close(sk);
+		return -1;
+	}
+
+	ifr.ifr_flags |= IFF_UP;
+	ret = ioctl(sk, SIOCSIFFLAGS, &ifr);
+	if (ret) {
+		close(sk);
+		return -1;
+	}
+
+	close(sk);
+	return 0;
+}
+
 void test_flow_dissector(void)
 {
+	int i, err, prog_fd, keys_fd = -1, tap_fd;
 	struct bpf_object *obj;
-	int i, err, prog_fd;
+	__u32 duration = 0;
 
 	err = bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
-			    "jmp_table", &prog_fd);
+			    "jmp_table", "last_dissection", &prog_fd, &keys_fd);
 	if (err) {
 		error_cnt++;
 		return;
@@ -171,5 +234,40 @@ void test_flow_dissector(void)
 		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
 	}
 
+	/* Do the same tests but for skb-less flow dissector.
+	 * We use a known path in the net/tun driver that calls
+	 * eth_get_headlen and we manually export bpf_flow_keys
+	 * via BPF map in this case.
+	 *
+	 * Note, that since eth_get_headlen operates on a L2 level,
+	 * we adjust exported nhoff/thoff by ETH_HLEN.
+	 */
+
+	err = bpf_prog_attach(prog_fd, 0, BPF_FLOW_DISSECTOR, 0);
+	CHECK(err, "bpf_prog_attach", "err %d errno %d", err, errno);
+
+	tap_fd = create_tap("tap0");
+	CHECK(tap_fd < 0, "create_tap", "tap_fd %d errno %d", tap_fd, errno);
+	err = ifup("tap0");
+	CHECK(err, "ifup", "err %d errno %d", err, errno);
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_flow_keys flow_keys = {};
+		struct bpf_prog_test_run_attr tattr = {};
+		__u32 key = 0;
+
+		err = tx_tap(tap_fd, &tests[i].pkt, sizeof(tests[i].pkt));
+		CHECK(err < 0, "tx_tap", "err %d errno %d", err, errno);
+
+		err = bpf_map_lookup_elem(keys_fd, &key, &flow_keys);
+		CHECK_ATTR(err, tests[i].name, "bpf_map_lookup_elem %d\n", err);
+
+		flow_keys.nhoff -= ETH_HLEN;
+		flow_keys.thoff -= ETH_HLEN;
+
+		CHECK_ATTR(err, tests[i].name, "skb-less err %d\n", err);
+		CHECK_FLOW_KEYS(tests[i].name, flow_keys, tests[i].keys);
+	}
+
 	bpf_object__close(obj);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
index 75b17cada539..81ad9a0b29d0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_flow.c
+++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
@@ -64,6 +64,25 @@ struct bpf_map_def SEC("maps") jmp_table = {
 	.max_entries = 8
 };
 
+struct bpf_map_def SEC("maps") last_dissection = {
+	.type = BPF_MAP_TYPE_ARRAY,
+	.key_size = sizeof(__u32),
+	.value_size = sizeof(struct bpf_flow_keys),
+	.max_entries = 1,
+};
+
+static __always_inline int export_flow_keys(struct bpf_flow_keys *keys,
+					    int ret)
+{
+	struct bpf_flow_keys *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&last_dissection, &key);
+	if (val)
+		memcpy(val, keys, sizeof(*val));
+	return ret;
+}
+
 static __always_inline void *bpf_flow_dissect_get_header(struct __sk_buff *skb,
 							 __u16 hdr_size,
 							 void *buffer)
@@ -109,10 +128,10 @@ static __always_inline int parse_eth_proto(struct __sk_buff *skb, __be16 proto)
 		break;
 	default:
 		/* Protocol not supported */
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 	}
 
-	return BPF_DROP;
+	return export_flow_keys(keys, BPF_DROP);
 }
 
 SEC("flow_dissector")
@@ -139,8 +158,8 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 	case IPPROTO_ICMP:
 		icmp = bpf_flow_dissect_get_header(skb, sizeof(*icmp), &_icmp);
 		if (!icmp)
-			return BPF_DROP;
-		return BPF_OK;
+			return export_flow_keys(keys, BPF_DROP);
+		return export_flow_keys(keys, BPF_OK);
 	case IPPROTO_IPIP:
 		keys->is_encap = true;
 		return parse_eth_proto(skb, bpf_htons(ETH_P_IP));
@@ -150,11 +169,11 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 	case IPPROTO_GRE:
 		gre = bpf_flow_dissect_get_header(skb, sizeof(*gre), &_gre);
 		if (!gre)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		if (bpf_htons(gre->flags & GRE_VERSION))
 			/* Only inspect standard GRE packets with version 0 */
-			return BPF_OK;
+			return export_flow_keys(keys, BPF_OK);
 
 		keys->thoff += sizeof(*gre); /* Step over GRE Flags and Proto */
 		if (GRE_IS_CSUM(gre->flags))
@@ -170,7 +189,7 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 			eth = bpf_flow_dissect_get_header(skb, sizeof(*eth),
 							  &_eth);
 			if (!eth)
-				return BPF_DROP;
+				return export_flow_keys(keys, BPF_DROP);
 
 			keys->thoff += sizeof(*eth);
 
@@ -181,31 +200,31 @@ static __always_inline int parse_ip_proto(struct __sk_buff *skb, __u8 proto)
 	case IPPROTO_TCP:
 		tcp = bpf_flow_dissect_get_header(skb, sizeof(*tcp), &_tcp);
 		if (!tcp)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		if (tcp->doff < 5)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		if ((__u8 *)tcp + (tcp->doff << 2) > data_end)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		keys->sport = tcp->source;
 		keys->dport = tcp->dest;
-		return BPF_OK;
+		return export_flow_keys(keys, BPF_OK);
 	case IPPROTO_UDP:
 	case IPPROTO_UDPLITE:
 		udp = bpf_flow_dissect_get_header(skb, sizeof(*udp), &_udp);
 		if (!udp)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		keys->sport = udp->source;
 		keys->dport = udp->dest;
-		return BPF_OK;
+		return export_flow_keys(keys, BPF_OK);
 	default:
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 	}
 
-	return BPF_DROP;
+	return export_flow_keys(keys, BPF_DROP);
 }
 
 static __always_inline int parse_ipv6_proto(struct __sk_buff *skb, __u8 nexthdr)
@@ -225,7 +244,7 @@ static __always_inline int parse_ipv6_proto(struct __sk_buff *skb, __u8 nexthdr)
 		return parse_ip_proto(skb, nexthdr);
 	}
 
-	return BPF_DROP;
+	return export_flow_keys(keys, BPF_DROP);
 }
 
 PROG(IP)(struct __sk_buff *skb)
@@ -238,11 +257,11 @@ PROG(IP)(struct __sk_buff *skb)
 
 	iph = bpf_flow_dissect_get_header(skb, sizeof(*iph), &_iph);
 	if (!iph)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	/* IP header cannot be smaller than 20 bytes */
 	if (iph->ihl < 5)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	keys->addr_proto = ETH_P_IP;
 	keys->ipv4_src = iph->saddr;
@@ -250,7 +269,7 @@ PROG(IP)(struct __sk_buff *skb)
 
 	keys->thoff += iph->ihl << 2;
 	if (data + keys->thoff > data_end)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	if (iph->frag_off & bpf_htons(IP_MF | IP_OFFSET)) {
 		keys->is_frag = true;
@@ -264,7 +283,7 @@ PROG(IP)(struct __sk_buff *skb)
 	}
 
 	if (done)
-		return BPF_OK;
+		return export_flow_keys(keys, BPF_OK);
 
 	return parse_ip_proto(skb, iph->protocol);
 }
@@ -276,7 +295,7 @@ PROG(IPV6)(struct __sk_buff *skb)
 
 	ip6h = bpf_flow_dissect_get_header(skb, sizeof(*ip6h), &_ip6h);
 	if (!ip6h)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	keys->addr_proto = ETH_P_IPV6;
 	memcpy(&keys->ipv6_src, &ip6h->saddr, 2*sizeof(ip6h->saddr));
@@ -288,11 +307,12 @@ PROG(IPV6)(struct __sk_buff *skb)
 
 PROG(IPV6OP)(struct __sk_buff *skb)
 {
+	struct bpf_flow_keys *keys = skb->flow_keys;
 	struct ipv6_opt_hdr *ip6h, _ip6h;
 
 	ip6h = bpf_flow_dissect_get_header(skb, sizeof(*ip6h), &_ip6h);
 	if (!ip6h)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	/* hlen is in 8-octets and does not include the first 8 bytes
 	 * of the header
@@ -309,7 +329,7 @@ PROG(IPV6FR)(struct __sk_buff *skb)
 
 	fragh = bpf_flow_dissect_get_header(skb, sizeof(*fragh), &_fragh);
 	if (!fragh)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	keys->thoff += sizeof(*fragh);
 	keys->is_frag = true;
@@ -321,13 +341,14 @@ PROG(IPV6FR)(struct __sk_buff *skb)
 
 PROG(MPLS)(struct __sk_buff *skb)
 {
+	struct bpf_flow_keys *keys = skb->flow_keys;
 	struct mpls_label *mpls, _mpls;
 
 	mpls = bpf_flow_dissect_get_header(skb, sizeof(*mpls), &_mpls);
 	if (!mpls)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
-	return BPF_OK;
+	return export_flow_keys(keys, BPF_OK);
 }
 
 PROG(VLAN)(struct __sk_buff *skb)
@@ -339,10 +360,10 @@ PROG(VLAN)(struct __sk_buff *skb)
 	if (keys->n_proto == bpf_htons(ETH_P_8021AD)) {
 		vlan = bpf_flow_dissect_get_header(skb, sizeof(*vlan), &_vlan);
 		if (!vlan)
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		if (vlan->h_vlan_encapsulated_proto != bpf_htons(ETH_P_8021Q))
-			return BPF_DROP;
+			return export_flow_keys(keys, BPF_DROP);
 
 		keys->nhoff += sizeof(*vlan);
 		keys->thoff += sizeof(*vlan);
@@ -350,14 +371,14 @@ PROG(VLAN)(struct __sk_buff *skb)
 
 	vlan = bpf_flow_dissect_get_header(skb, sizeof(*vlan), &_vlan);
 	if (!vlan)
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	keys->nhoff += sizeof(*vlan);
 	keys->thoff += sizeof(*vlan);
 	/* Only allow 8021AD + 8021Q double tagging and no triple tagging.*/
 	if (vlan->h_vlan_encapsulated_proto == bpf_htons(ETH_P_8021AD) ||
 	    vlan->h_vlan_encapsulated_proto == bpf_htons(ETH_P_8021Q))
-		return BPF_DROP;
+		return export_flow_keys(keys, BPF_DROP);
 
 	keys->n_proto = vlan->h_vlan_encapsulated_proto;
 	return parse_eth_proto(skb, vlan->h_vlan_encapsulated_proto);
-- 
2.21.0.593.g511ec345e18-goog

