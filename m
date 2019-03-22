Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F6C4360F
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1076218D3
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TK0f0rn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCVXkd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:40:33 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55841 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfCVXkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 19:40:33 -0400
Received: by mail-pf1-f202.google.com with SMTP id h15so3728776pfj.22
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kaFNt4drXY8Ri1z9COrHkNJcAac+VrmyY76kwGaQXDI=;
        b=TK0f0rn0uFkJEsP9F2lqu19GF7d+dbQIlNXTqSQlzaQw/XTzZE/Qby6xh+XgFS8ybG
         t7lo/+L3GlzBk/pELA06VGak1qCwqIZ3+s9t5JGQFrTTNp2Syh/O0NEINnxlF9mhfPKr
         fXnJ07PzibSLhY7oLqGOPmC+ykV4EpjLh8Wi/9KtBrxVDp1No146plDC6XTdWoa1Dr4a
         od+DmRFpTfH7nCCvL5Z4cVBaxOdZPYr7rJrOkNeYDekAZpDFks4/YrxzoaYU5H+Vg/Zp
         Rrn0uhkVGHwzyErMXegdDlMh8KM5IOpvqOBjCx1jpKLwSeriJXwGaWKndiUhbB+yfmdM
         M4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kaFNt4drXY8Ri1z9COrHkNJcAac+VrmyY76kwGaQXDI=;
        b=DSuf4Jc5GZIlVJqBfUU1uWqCBGUHUQMcVedF580jgUK5kB0Zuw29mSdiYNq9h888bu
         M8zQ7HNpoAZxGQNOjs8AMI+fjl7axspVC8TboXZx0KiB7nwGCR72s8BQR+0xQ7CCJAPi
         UPXPr2JXg4vsUoEu9gl65wn+tNPxZiK6YpsejEeTdaI3yzzgcP9HOIsM656hS3pRC9be
         RItchZWXl/n4VDLC9bHDr5p67TUOglz5zeZfzrTTOG/JQnFlqViO565/GZ3IWum34d92
         lwQR+rbFtdfBl/nytyPr7lsfbE1D8G2U42UtMVYF6PwTSRNsLWbQErVp9gDyGz6u8+M8
         nqCg==
X-Gm-Message-State: APjAAAVoHTl0hLelUsvZ/+MAOBTsgwazTIw/S8MF9mkhjCt3j3Ccht0o
        zNu3om57AB8N3qnySPTWujAY5nfR
X-Google-Smtp-Source: APXvYqy+83+83ayEnQn5zhKEp5BI6p5ewdsPpo4prtFSkyUDKNOxA+oIEGl7gpZ95w3TTslwvJgLSHTp
X-Received: by 2002:a63:31ce:: with SMTP id x197mr11584199pgx.69.1553298031190;
 Fri, 22 Mar 2019 16:40:31 -0700 (PDT)
Date:   Fri, 22 Mar 2019 16:40:19 -0700
In-Reply-To: <20190322234019.229181-1-posk@google.com>
Message-Id: <20190322234019.229181-2-posk@google.com>
Mime-Version: 1.0
References: <20190322234019.229181-1-posk@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 2/2] selftests: bpf: tc-bpf flow shaping with EDT
From:   Peter Oskolkov <posk@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a small test that shows how to shape a TCP flow in tc-bpf
with EDT and ECN.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../testing/selftests/bpf/progs/test_tc_edt.c | 109 ++++++++++++++++++
 tools/testing/selftests/bpf/test_tc_edt.sh    |  99 ++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_edt.c
 create mode 100755 tools/testing/selftests/bpf/test_tc_edt.sh

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cdcc54ddf4b9..77b73b892136 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -53,7 +53,8 @@ TEST_PROGS := test_kmod.sh \
 	test_xdp_vlan.sh \
 	test_lwt_ip_encap.sh \
 	test_tcp_check_syncookie.sh \
-	test_tc_tunnel.sh
+	test_tc_tunnel.sh \
+	test_tc_edt.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
diff --git a/tools/testing/selftests/bpf/progs/test_tc_edt.c b/tools/testing/selftests/bpf/progs/test_tc_edt.c
new file mode 100644
index 000000000000..3af64c470d64
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_tc_edt.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdint.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/pkt_cls.h>
+#include <linux/tcp.h>
+#include "bpf_helpers.h"
+#include "bpf_endian.h"
+
+/* the maximum delay we are willing to add (drop packets beyond that) */
+#define TIME_HORIZON_NS (2000 * 1000 * 1000)
+#define NS_PER_SEC 1000000000
+#define ECN_HORIZON_NS 5000000
+#define THROTTLE_RATE_BPS (5 * 1000 * 1000)
+
+/* flow_key => last_tstamp timestamp used */
+struct bpf_map_def SEC("maps") flow_map = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(uint32_t),
+	.value_size = sizeof(uint64_t),
+	.max_entries = 1,
+};
+
+static inline int throttle_flow(struct __sk_buff *skb)
+{
+	int key = 0;
+	uint64_t *last_tstamp = bpf_map_lookup_elem(&flow_map, &key);
+	uint64_t delay_ns = ((uint64_t)skb->len) * NS_PER_SEC /
+			THROTTLE_RATE_BPS;
+	uint64_t now = bpf_ktime_get_ns();
+	uint64_t tstamp, next_tstamp = 0;
+
+	if (last_tstamp)
+		next_tstamp = *last_tstamp + delay_ns;
+
+	tstamp = skb->tstamp;
+	if (tstamp < now)
+		tstamp = now;
+
+	/* should we throttle? */
+	if (next_tstamp <= tstamp) {
+		if (bpf_map_update_elem(&flow_map, &key, &tstamp, BPF_ANY))
+			return TC_ACT_SHOT;
+		return TC_ACT_OK;
+	}
+
+	/* do not queue past the time horizon */
+	if (next_tstamp - now >= TIME_HORIZON_NS)
+		return TC_ACT_SHOT;
+
+	/* set ecn bit, if needed */
+	if (next_tstamp - now >= ECN_HORIZON_NS)
+		bpf_skb_ecn_set_ce(skb);
+
+	if (bpf_map_update_elem(&flow_map, &key, &next_tstamp, BPF_EXIST))
+		return TC_ACT_SHOT;
+	skb->tstamp = next_tstamp;
+
+	return TC_ACT_OK;
+}
+
+static inline int handle_tcp(struct __sk_buff *skb, struct tcphdr *tcp)
+{
+	void *data_end = (void *)(long)skb->data_end;
+
+	/* drop malformed packets */
+	if ((void *)(tcp + 1) > data_end)
+		return TC_ACT_SHOT;
+
+	if (tcp->dest == bpf_htons(9000))
+		return throttle_flow(skb);
+
+	return TC_ACT_OK;
+}
+
+static inline int handle_ipv4(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	struct iphdr *iph;
+	uint32_t ihl;
+
+	/* drop malformed packets */
+	if (data + sizeof(struct ethhdr) > data_end)
+		return TC_ACT_SHOT;
+	iph = (struct iphdr *)(data + sizeof(struct ethhdr));
+	if ((void *)(iph + 1) > data_end)
+		return TC_ACT_SHOT;
+	ihl = iph->ihl * 4;
+	if (((void *)iph) + ihl > data_end)
+		return TC_ACT_SHOT;
+
+	if (iph->protocol == IPPROTO_TCP)
+		return handle_tcp(skb, (struct tcphdr *)(((void *)iph) + ihl));
+
+	return TC_ACT_OK;
+}
+
+SEC("cls_test") int tc_prog(struct __sk_buff *skb)
+{
+	if (skb->protocol == bpf_htons(ETH_P_IP))
+		return handle_ipv4(skb);
+
+	return TC_ACT_OK;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tc_edt.sh b/tools/testing/selftests/bpf/test_tc_edt.sh
new file mode 100755
index 000000000000..f38567ef694b
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_tc_edt.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test installs a TC bpf program that throttles a TCP flow
+# with dst port = 9000 down to 5MBps. Then it measures actual
+# throughput of the flow.
+
+if [[ $EUID -ne 0 ]]; then
+	echo "This script must be run as root"
+	echo "FAIL"
+	exit 1
+fi
+
+# check that nc, dd, and timeout are present
+command -v nc >/dev/null 2>&1 || \
+	{ echo >&2 "nc is not available"; exit 1; }
+command -v dd >/dev/null 2>&1 || \
+	{ echo >&2 "nc is not available"; exit 1; }
+command -v timeout >/dev/null 2>&1 || \
+	{ echo >&2 "timeout is not available"; exit 1; }
+
+readonly NS_SRC="ns-src-$(mktemp -u XXXXXX)"
+readonly NS_DST="ns-dst-$(mktemp -u XXXXXX)"
+
+readonly IP_SRC="172.16.1.100"
+readonly IP_DST="172.16.2.100"
+
+cleanup()
+{
+	ip netns del ${NS_SRC}
+	ip netns del ${NS_DST}
+}
+
+trap cleanup EXIT
+
+set -e  # exit on error
+
+ip netns add "${NS_SRC}"
+ip netns add "${NS_DST}"
+ip link add veth_src type veth peer name veth_dst
+ip link set veth_src netns ${NS_SRC}
+ip link set veth_dst netns ${NS_DST}
+
+ip -netns ${NS_SRC} addr add ${IP_SRC}/24  dev veth_src
+ip -netns ${NS_DST} addr add ${IP_DST}/24  dev veth_dst
+
+ip -netns ${NS_SRC} link set dev veth_src up
+ip -netns ${NS_DST} link set dev veth_dst up
+
+ip -netns ${NS_SRC} route add ${IP_DST}/32  dev veth_src
+ip -netns ${NS_DST} route add ${IP_SRC}/32  dev veth_dst
+
+# set up TC on TX
+ip netns exec ${NS_SRC} tc qdisc add dev veth_src root fq
+ip netns exec ${NS_SRC} tc qdisc add dev veth_src clsact
+ip netns exec ${NS_SRC} tc filter add dev veth_src egress \
+	bpf da obj test_tc_edt.o sec cls_test
+
+
+# start the listener
+ip netns exec ${NS_DST} bash -c \
+	"nc -4 -l -s ${IP_DST} -p 9000 >/dev/null &"
+declare -i NC_PID=$!
+sleep 1
+
+declare -ir TIMEOUT=20
+declare -ir EXPECTED_BPS=5000000
+
+# run the load, capture RX bytes on DST
+declare -ir RX_BYTES_START=$( ip netns exec ${NS_DST} \
+	cat /sys/class/net/veth_dst/statistics/rx_bytes )
+
+set +e
+ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero \
+	bs=1000 count=1000000 > /dev/tcp/${IP_DST}/9000 2>/dev/null"
+set -e
+
+declare -ir RX_BYTES_END=$( ip netns exec ${NS_DST} \
+	cat /sys/class/net/veth_dst/statistics/rx_bytes )
+
+declare -ir ACTUAL_BPS=$(( ($RX_BYTES_END - $RX_BYTES_START) / $TIMEOUT ))
+
+echo $TIMEOUT $ACTUAL_BPS $EXPECTED_BPS | \
+	awk '{printf "elapsed: %d sec; bps difference: %.2f%%\n",
+		$1, ($2-$3)*100.0/$3}'
+
+# Pass the test if the actual bps is within 1% of the expected bps.
+# The difference is usually about 0.1% on a 20-sec test, and ==> zero
+# the longer the test runs.
+declare -ir RES=$( echo $ACTUAL_BPS $EXPECTED_BPS | \
+	 awk 'function abs(x){return ((x < 0.0) ? -x : x)}
+	      {if (abs(($1-$2)*100.0/$2) > 1.0) { print "1" }
+		else { print "0"} }' )
+if [ "${RES}" == "0" ] ; then
+	echo "PASS"
+else
+	echo "FAIL"
+	exit 1
+fi
-- 
2.21.0.392.gf8f6787159e-goog

