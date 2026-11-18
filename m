Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014507;
	b=jAG89oBAP9LZtEwmER94lfnPkLN9m83m8qYJ5yp8JjGmwfGfMFch24oem/dnbN9Rw+Y9
	 Bgl1D6+snypxiMZFzSIzRfrIR5irYaDWiSiZIwBgi9TZh9kvpucFImjllMS+jBYG1pYE9
	 d7H06QHEyhKWE7sTOiLIEQeFUYAvV/dJs0whJMAneqZMURexkoc901/lAN5U0l3R6OiO3
	 5MQeuRLkPzuUPZbiSiErbKrttraqLNXYz79FQt9U26Ws0OZH7u5ohmddARCmsBG46QXxl
	 motTnb7rA+q26cFJ6ey0o0SHO9Mpg2O/Esh+Hb08DiAJq4nOBi9+s7z3gd7BtAP5fBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014507;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=3rSKKcOzFng0M9AKi0Z2RIUayRVuSQJhfFNu/CcXx+U=;
	b=owSS5MBt9yXaLXTy0bc7aDbVbW4O75tEIWSMfUcBgJqeVDDVQnY9CbPhh15q66eQOBzh
	 T6T1zeGXwCpm+TiC8VBVIJI5zZ5wu22ULWhYoahONTWlIXB8KiZrW+DEFBZElPNqJvqLE
	 sxCK0QIbBHQop4PPvG1xsxEX0J+wOj1ws5LMOQX+4oxthbuIzYuXWWe470gygK9VUfQUO
	 sixgwBFWgGK13ZKGOJ+n6j/cWVu7oAqcqaO1Uhd9Z88SltdCGWKYMI/AKmCuWeBx4FQHJ
	 7qX8mD3e05R75GSD2HBZ6yIskTKPTJMmQsrLjSMSl3V+ysG6gI+uEiIIOLpgs2q0BEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3xclmsb+;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=TaDp+HIK;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDF606A320;
	Wed, 18 Nov 2026 15:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CDF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3xclmsb+;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=TaDp+HIK
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7YVF012194;
	Wed, 18 Nov 2026 16:07:39 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A2A23122959;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rSKKcOzFng0M9AKi0Z2RIUayRVuSQJhfFNu/CcXx+U=;
	b=3xclmsb+zxqlhvQfMDj3Puqn3aGRXjz21i/9qBTDpILExopU1Wd+RaR96cBUu7DcRhpYDJ
	SEBKNoW/xXp8+SBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rSKKcOzFng0M9AKi0Z2RIUayRVuSQJhfFNu/CcXx+U=;
	b=TaDp+HIKBw03D7Xbt1f21mhkTcN/5cZTIuBFVHVWAkyUw+HFvyC+UUEKsFVSwzwO4uSfn+
	6ypZza93DN+e9s2gBIYSvFBImaaZIIP7He6TPIyDFA3dDw1j9iEgMpaEv9arfG/e/2gks0
	Pc3ed50cPwH5K91Mwqu/QzFhPy15ESY7QT7hKXYxjW1B5j/uazxNiJQOjImQv08mqecjmm
	B5lcNSPsQlYGf85O8CPcA0T9StfwQUDqiWuorUE21+CxmB9dkMxKvKD+BVpVngthr/P69B
	L1b3KHDBIahx4YFPHMosNTxQkg4Jxb4YilmT29rKTTzRs61aV1aIQD07uJE2Fg==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>, Hangbin Liu <hangbin.liu@linux.dev>,
        Justin Iurman <justin.iurman@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v2 6/6] selftests: seg6: add test for skb checksum with CHECKSUM_COMPLETE
Date: Wed, 18 Nov 2026 16:02:51 +0100
Message-Id: <20261118150251.65-7-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118150251.65-1-andrea.mayer@uniroma2.it>
References: <20261118150251.65-1-andrea.mayer@uniroma2.it>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Add a selftest for received packets with CHECKSUM_COMPLETE that the SRv6
code processes before they are delivered on the same node. The test checks
that, after the node changes the packet, UDP does not read a wrong
skb->csum.

The test uses a host and a router connected through a veth pair. Since veth
does not provide CHECKSUM_COMPLETE, a tc ct action on the router computes
skb->csum in software.

The host sends a UDP datagram to the router along five paths: no SRH (the
reference), an SRH with local segments, End.B6.Encaps with End.DT6, End
with the next-csid flavor, and End.BPF. Each datagram is expected to be
delivered, not dropped as a checksum error. Without the previous patches,
every path except the reference fails. With them, every path passes.

The host also sends a control datagram. It checks that the test detects a
wrong skb->csum after a change to the packet. After the ct action, a BPF
program on the router changes the Flow Label of the control datagram
without updating skb->csum, and UDP must drop it. If UDP accepts it, the
paths above may report a false pass, and the test fails.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/srv6_csum_complete.bpf.c    |  65 ++
 .../selftests/net/srv6_csum_complete_test.sh  | 627 ++++++++++++++++++
 3 files changed, 693 insertions(+)
 create mode 100644 tools/testing/selftests/net/srv6_csum_complete.bpf.c
 create mode 100755 tools/testing/selftests/net/srv6_csum_complete_test.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baea3e7f0f8f..46fa754bf0e9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -94,6 +94,7 @@ TEST_PROGS := \
 	sctp_ifwdtsn.sh \
 	sctp_vrf.sh \
 	skf_net_off.sh \
+	srv6_csum_complete_test.sh \
 	srv6_encap_lookup_l3vpn_test.sh \
 	srv6_end_dt46_l3vpn_test.sh \
 	srv6_end_dt4_l3vpn_test.sh \
diff --git a/tools/testing/selftests/net/srv6_csum_complete.bpf.c b/tools/testing/selftests/net/srv6_csum_complete.bpf.c
new file mode 100644
index 000000000000..281b0361f976
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_csum_complete.bpf.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Andrea Mayer <andrea.mayer@uniroma2.it>
+ */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/pkt_cls.h>
+#include <linux/seg6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+/* On the tc ingress, skb->data points to the Ethernet header */
+#define TC_IPV6_OFF		ETH_HLEN
+/* Byte with the lowest 8 bits of the Flow Label */
+#define TC_FLOW_LBL_OFF		(TC_IPV6_OFF + \
+				 offsetof(struct ipv6hdr, flow_lbl) + 2)
+/* Bit of the Flow Label changed in the control datagram */
+#define CTRL_FLOW_LBL_BIT	0x01
+
+/* In End.BPF, skb->data points to the IPv6 header, followed by the SRH */
+#define SRH_TAG_OFF		(sizeof(struct ipv6hdr) + \
+				 offsetof(struct ipv6_sr_hdr, tag))
+/* Value written in the SRH Tag, test case (vi) */
+#define SRH_TAG			0x1234
+
+/* Test case (v) of srv6_csum_complete_test.sh. The program runs on the tc
+ * ingress of rt, after the ct action, only for the control datagram. It
+ * changes one bit of the Flow Label, without updating the receive checksum
+ * (skb->csum). The Flow Label is not part of the UDP checksum, which stays
+ * correct. UDP must drop the datagram because the receive checksum no longer
+ * matches the packet.
+ */
+SEC("tc")
+int ctrl_flow_label(struct __sk_buff *skb)
+{
+	__u8 lbl;
+
+	/* Read the byte with the lowest 8 bits of the Flow Label */
+	if (bpf_skb_load_bytes(skb, TC_FLOW_LBL_OFF, &lbl, sizeof(lbl)))
+		return TC_ACT_SHOT;
+
+	lbl ^= CTRL_FLOW_LBL_BIT;
+
+	/* Write the byte back, flags 0 do not update the receive checksum */
+	if (bpf_skb_store_bytes(skb, TC_FLOW_LBL_OFF, &lbl, sizeof(lbl), 0))
+		return TC_ACT_SHOT;
+
+	return TC_ACT_OK;
+}
+
+/* Test case (vi), the End.BPF program writes the SRH Tag */
+SEC("lwt_seg6local")
+int end_bpf_tag(struct __sk_buff *skb)
+{
+	__u16 tag = bpf_htons(SRH_TAG);
+
+	if (bpf_lwt_seg6_store_bytes(skb, SRH_TAG_OFF, &tag, sizeof(tag)))
+		return BPF_DROP;
+
+	return BPF_OK;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/srv6_csum_complete_test.sh b/tools/testing/selftests/net/srv6_csum_complete_test.sh
new file mode 100755
index 000000000000..d72a13041d80
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_csum_complete_test.sh
@@ -0,0 +1,627 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# author: Andrea Mayer <andrea.mayer@uniroma2.it>
+
+# This test checks the receive checksum of an SRv6 packet that is processed and
+# then delivered on the same node. The node changes the Segments Left and the
+# destination address of the packet, and can also change the Hop Limit.
+#
+# The receive checksum (CHECKSUM_COMPLETE) is the checksum of the whole packet,
+# kept with the received packet. When the node changes the packet, it must also
+# update this sum, or discard it.
+#
+# Network topology
+# ================
+#
+# The test uses a host (hs) and a router (rt) connected through a veth pair. In
+# each test case, hs sends one UDP datagram to an address of rt.
+#
+# +--------------------+                    +--------------------------+
+# |        hs          |                    |           rt             |
+# |                    |                    |                          |
+# |  veth-hs           +--------------------+ veth-rt                  |
+# |  fd00::1/64        |                    | fd00::2/64               |
+# |  tx checksum off   |                    | tc ingress: ct, then bpf |
+# +--------------------+                    |                          |
+#                                           | lo: fc00::1 ... fc00::4  |
+#                                           |     cafe::1 ... cafe::6  |
+#                                           +--------------------------+
+#
+# Receive checksum
+# ================
+#
+# veth does not provide the receive checksum. For this reason, a tc ct action
+# runs on the ingress of rt. The ct action checks the UDP checksum, and in this
+# way computes the receive checksum in software. If the receive checksum does
+# not match the packet, UDP drops the datagram as a checksum error.
+#
+# The ct action computes the receive checksum when hs computes the UDP checksum
+# in software, before the datagram crosses the veth. For this reason, hs has
+# transmit checksumming off.
+#
+# Each datagram is longer than 76 bytes, UDP header included. For datagrams of
+# 76 bytes or less, UDP computes the checksum again from the packet, and accepts
+# the datagram even with a wrong receive checksum.
+#
+# UDP counters
+# ============
+#
+# Each datagram goes to a port with no listener. If the UDP checksum check
+# passes, rt counts the datagram in Udp6NoPorts. If it fails, rt counts it in
+# Udp6InCsumErrors.
+#
+# Control datagram
+# ================
+#
+# A control datagram checks that the test detects a wrong receive checksum after
+# a change to the packet. After the ct action, a tc bpf filter on rt changes one
+# bit of its Flow Label, without updating the receive checksum. The Flow Label
+# is not part of the UDP checksum, which stays correct. UDP must drop the
+# datagram because the receive checksum no longer matches the packet. If UDP
+# accepts it, the test cannot detect a wrong receive checksum. The other test
+# cases may then pass even when their receive checksum is wrong, and for this
+# reason the test fails.
+#
+# Routes and tc filters
+# =====================
+#
+# hs: encap (main table)
+# +---------+-----------------------------------------------------+
+# | dst     | action                                              |
+# +---------+-----------------------------------------------------+
+# | cafe::1 | via fd00::2                                         |
+# | cafe::2 | encap seg6 mode inline segs fc00::1,fc00::2         |
+# | cafe::3 | encap seg6 mode inline segs fcbb:0:0200::           |
+# | cafe::4 | encap seg6 mode inline segs fcbb:0:0100:0200::      |
+# | cafe::5 | encap seg6 mode inline segs fc00::3,fc00::4         |
+# | cafe::6 | encap seg6 mode inline segs fc00::b0,fcbb:0:0200::  |
+# +---------+-----------------------------------------------------+
+#
+# rt: SRv6 behaviors (main table)
+# +------------------+------------------------------------------------+
+# | SID              | action                                         |
+# +------------------+------------------------------------------------+
+# | fcbb:0:0100::/48 | End flavors next-csid lblen 32 nflen 16        |
+# | fcbb:0:0200::/48 | End.B6.Encaps srh segs fc00::d6                |
+# | fc00::d6         | End.DT6 table 255 (local)                      |
+# | fc00::b0         | End.BPF, the program writes the SRH Tag        |
+# +------------------+------------------------------------------------+
+#
+# rt: tc ingress of veth-rt
+# +-------+------+---------------------------------------------------+
+# | chain | prio | filter                                            |
+# +-------+------+---------------------------------------------------+
+# | 0     | 1    | matchall, action ct, goto chain 1                 |
+# | 1     | 1    | flower dst_ip fc00::3, goto chain 2               |
+# | 2     | 1    | bpf, changes one bit of the Flow Label            |
+# +-------+------+---------------------------------------------------+
+#
+# Test cases
+# ==========
+#
+# hs applies the SRv6 Policies in inline mode, i.e. the original destination
+# becomes the last SID of the SID List.
+#
+#   i) cafe::1, no SRH, used as a reference.
+#
+#  ii) cafe::2, SID List=fc00::1,fc00::2,cafe::2
+#      fc00::1 and fc00::2 are addresses of rt. rt processes the SRH twice. Each
+#      time, it also decrements the Hop Limit.
+#
+# iii) cafe::3, SID List=fcbb:0:0200::,cafe::3
+#      End.B6.Encaps advances the SRH and adds an outer IPv6 header with an SRH.
+#      The outer header goes to the End.DT6 SID fc00::d6, which removes it.
+#
+#  iv) cafe::4, SID List=fcbb:0:0100:0200::,cafe::4
+#      End with the NEXT-C-SID flavor changes the DA to the next C-SID,
+#      fcbb:0:0200::. Then the datagram follows the same path as in (iii).
+#
+#   v) cafe::5, SID List=fc00::3,fc00::4,cafe::5, control.
+#      The tc flower filter matches the first segment, fc00::3, and the tc bpf
+#      filter changes the Flow Label. Then rt processes the SRH as in (ii).
+#
+#  vi) cafe::6, SID List=fc00::b0,fcbb:0:0200::,cafe::6
+#      End.BPF writes the SRH Tag. Then the datagram follows the same path as in
+#      (iii).
+#
+# In the test case (v), the datagram is expected to be dropped as a checksum
+# error. In all the other test cases, the datagram is expected to be delivered
+# on rt.
+
+# shellcheck source=lib.sh
+source lib.sh
+
+readonly IPv6_RT_NETWORK=fd00
+readonly IPv6_DST_NETWORK=cafe
+readonly SID_LOCATOR=fc00
+readonly CSID_BLOCK=fcbb:0
+readonly CSID_LBLEN=32
+readonly CSID_NFLEN=16
+readonly CSID_BLOCK_FUNC_LEN=$((CSID_LBLEN + CSID_NFLEN))
+readonly B6_FUNC=0200
+readonly CSID_FUNC=0100
+readonly DT6_FUNC=d6
+readonly BPF_FUNC=b0
+readonly DUMMY_DEVNAME=dum0
+readonly UDP_PORT=9
+readonly UDP_PAYLOAD_LEN=200
+readonly WAIT_TIMEOUT_SEC=5
+
+# destination of the control datagram on the veth, test case (v)
+readonly CTRL_DST="${SID_LOCATOR}::3"
+# tc chain of the flower filter that selects the control datagram
+readonly CTRL_CHAIN=1
+# tc chain of the bpf filter that changes the Flow Label
+readonly BPF_CHAIN=2
+
+readonly BPF_FILE=srv6_csum_complete.bpf.o
+readonly BPF_TC_SEC=tc
+readonly BPF_END_SEC=lwt_seg6local
+
+# return values of check_udp_delivery()
+readonly UDP_DELIVERED=0
+readonly UDP_LOST=1
+readonly UDP_CSUM_ERROR=2
+
+SETUP_ERR=1
+
+ret=${ksft_skip}
+nsuccess=0
+nfail=0
+
+print_log_test_results()
+{
+	printf "\nTests passed: %3d\n" "${nsuccess}"
+	printf "Tests failed: %3d\n"   "${nfail}"
+
+	# when a test fails, the value of 'ret' is set to 1 (error code).
+	# Conversely, when all tests are passed successfully, the 'ret' value
+	# is set to 0 (success code).
+	if [ "${ret}" -ne 1 ]; then
+		ret=0
+	fi
+}
+
+log_section()
+{
+	echo
+	echo "################################################################################"
+	echo "TEST SECTION: $*"
+	echo "################################################################################"
+}
+
+cleanup()
+{
+	cleanup_all_ns
+
+	# check whether the setup phase was completed successfully or not. In
+	# case of an error during the setup phase of the testing environment,
+	# the selftest is considered as "skipped".
+	if [ "${SETUP_ERR}" -ne 0 ]; then
+		echo "SKIP: Setting up the testing environment failed"
+		exit "${ksft_skip}"
+	fi
+
+	exit "${ret}"
+}
+
+# add on hs the SRv6 Policy for cafe::<id>, in inline mode
+# args:
+#  $1 - destination id
+#  $2 - segments, comma separated
+set_hs_policy()
+{
+	local dstid="$1"
+	local segs="$2"
+
+	ip -netns "${NS_HS}" -6 route add "${IPv6_DST_NETWORK}::${dstid}/128" \
+		encap seg6 mode inline segs "${segs}" \
+		via "${IPv6_RT_NETWORK}::2" dev veth-hs
+}
+
+setup_hs()
+{
+	ip -netns "${NS_HS}" link set veth-hs up
+	ip -netns "${NS_HS}" addr add "${IPv6_RT_NETWORK}::1/64" \
+		dev veth-hs nodad
+
+	# with transmit checksumming on, conntrack on rt does not compute the
+	# receive checksum
+	ip netns exec "${NS_HS}" ethtool -K veth-hs tx off >/dev/null
+
+	# routes to the SIDs, used after the SRH is inserted
+	ip -netns "${NS_HS}" -6 route add "${SID_LOCATOR}::/16" \
+		via "${IPv6_RT_NETWORK}::2" dev veth-hs
+	ip -netns "${NS_HS}" -6 route add "${CSID_BLOCK}::/${CSID_LBLEN}" \
+		via "${IPv6_RT_NETWORK}::2" dev veth-hs
+
+	# test case (i), the reference, no SRH
+	ip -netns "${NS_HS}" -6 route add "${IPv6_DST_NETWORK}::1/128" \
+		via "${IPv6_RT_NETWORK}::2" dev veth-hs
+
+	# the SRv6 Policies of the test cases (ii) to (vi)
+	set_hs_policy 2 "${SID_LOCATOR}::1,${SID_LOCATOR}::2"
+	set_hs_policy 3 "${CSID_BLOCK}:${B6_FUNC}::"
+	set_hs_policy 4 "${CSID_BLOCK}:${CSID_FUNC}:${B6_FUNC}::"
+	set_hs_policy 5 "${SID_LOCATOR}::3,${SID_LOCATOR}::4"
+	set_hs_policy 6 "${SID_LOCATOR}::${BPF_FUNC},${CSID_BLOCK}:${B6_FUNC}::"
+}
+
+setup_rt()
+{
+	local dstid
+	local dev
+
+	ip -netns "${NS_RT}" link set veth-rt up
+	ip -netns "${NS_RT}" addr add "${IPv6_RT_NETWORK}::2/64" \
+		dev veth-rt nodad
+
+	# local segments of the test case (ii)
+	ip -netns "${NS_RT}" addr add "${SID_LOCATOR}::1/128" dev lo nodad
+	ip -netns "${NS_RT}" addr add "${SID_LOCATOR}::2/128" dev lo nodad
+	# local segments of the test case (v)
+	ip -netns "${NS_RT}" addr add "${SID_LOCATOR}::3/128" dev lo nodad
+	ip -netns "${NS_RT}" addr add "${SID_LOCATOR}::4/128" dev lo nodad
+	for dstid in 1 2 3 4 5 6; do
+		ip -netns "${NS_RT}" addr add \
+			"${IPv6_DST_NETWORK}::${dstid}/128" dev lo nodad
+	done
+
+	for dev in all veth-rt lo; do
+		ip netns exec "${NS_RT}" sysctl -wq \
+			net.ipv6.conf."${dev}".seg6_enabled=1
+	done
+
+	# SRv6 behaviors used by the test cases (iii), (iv) and (vi)
+	ip -netns "${NS_RT}" -6 route \
+		add "${CSID_BLOCK}:${CSID_FUNC}::/${CSID_BLOCK_FUNC_LEN}" \
+		encap seg6local action End flavors next-csid \
+		lblen "${CSID_LBLEN}" nflen "${CSID_NFLEN}" dev veth-rt
+	ip -netns "${NS_RT}" -6 route \
+		add "${CSID_BLOCK}:${B6_FUNC}::/${CSID_BLOCK_FUNC_LEN}" \
+		encap seg6local action End.B6.Encaps \
+		srh segs "${SID_LOCATOR}::${DT6_FUNC}" dev veth-rt
+	ip -netns "${NS_RT}" -6 route add "${SID_LOCATOR}::${DT6_FUNC}/128" \
+		encap seg6local action End.DT6 table 255 dev veth-rt
+	ip -netns "${NS_RT}" -6 route add "${SID_LOCATOR}::${BPF_FUNC}/128" \
+		encap seg6local action End.BPF endpoint obj "${BPF_FILE}" \
+		sec "${BPF_END_SEC}" dev veth-rt
+
+	tc -netns "${NS_RT}" qdisc add dev veth-rt clsact
+	# the bpf filter changes the Flow Label of the control datagram
+	tc -netns "${NS_RT}" filter add dev veth-rt ingress \
+		chain "${BPF_CHAIN}" prio 1 protocol ipv6 \
+		bpf object-file "${BPF_FILE}" section "${BPF_TC_SEC}" \
+		direct-action
+	# the control datagram goes to the bpf filter
+	tc -netns "${NS_RT}" filter add dev veth-rt ingress \
+		chain "${CTRL_CHAIN}" prio 1 protocol ipv6 \
+		flower dst_ip "${CTRL_DST}" \
+		action goto chain "${BPF_CHAIN}"
+	# every packet goes to the ct action, which computes the receive
+	# checksum, then to the chain of the flower filter
+	tc -netns "${NS_RT}" filter add dev veth-rt ingress prio 1 \
+		protocol ipv6 matchall \
+		action ct pipe action goto chain "${CTRL_CHAIN}"
+	ip netns exec "${NS_RT}" sysctl -wq \
+		net.netfilter.nf_conntrack_checksum=1
+}
+
+setup()
+{
+	setup_ns NS_HS NS_RT
+
+	ip -netns "${NS_HS}" link add veth-hs type veth \
+		peer name veth-rt netns "${NS_RT}"
+
+	setup_hs
+	setup_rt
+
+	# testing environment was set up successfully
+	SETUP_ERR=0
+}
+
+# print the value of a counter of rt in /proc/net/snmp6
+# args:
+#  $1 - counter name in /proc/net/snmp6
+get_rt_udp6_counter()
+{
+	local name="$1"
+
+	ip netns exec "${NS_RT}" cat /proc/net/snmp6 | \
+		awk -v k="${name}" '$1 == k { print $2 }'
+}
+
+# number of datagrams that UDP on rt counted in Udp6NoPorts or Udp6InCsumErrors
+get_rt_udp6_received()
+{
+	echo $(( $(get_rt_udp6_counter Udp6NoPorts) +
+		 $(get_rt_udp6_counter Udp6InCsumErrors) ))
+}
+
+check_hs_rt_connectivity()
+{
+	ip netns exec "${NS_HS}" ping -c 1 -W 1 "${IPv6_RT_NETWORK}::2" \
+		>/dev/null 2>&1
+}
+
+check_and_log_hs_rt_connectivity()
+{
+	check_hs_rt_connectivity
+	log_test_expected $? 0 "Connectivity: hs -> rt"
+}
+
+connectivity_tests()
+{
+	log_section "IPv6 connectivity test between host and router"
+
+	check_and_log_hs_rt_connectivity
+}
+
+# Send one UDP datagram from hs to a port with no listener on rt.
+# args:
+#  $1 - destination id
+# return:
+#  - UDP_DELIVERED if rt counts the datagram as delivered
+#  - UDP_CSUM_ERROR if rt drops it for a bad checksum
+#  - UDP_LOST if the datagram cannot be sent, or if it does not arrive
+check_udp_delivery()
+{
+	local dstid="$1"
+	local noports
+	local payload
+	local errors
+	local recv
+	local dst
+
+	dst="${IPv6_DST_NETWORK}::${dstid}"
+	noports="$(get_rt_udp6_counter Udp6NoPorts)"
+	errors="$(get_rt_udp6_counter Udp6InCsumErrors)"
+	recv=$((noports + errors))
+	payload="$(printf '%*s' "${UDP_PAYLOAD_LEN}" '')"
+
+	# send the datagram with the /dev/udp redirection of bash
+	if ! ip netns exec "${NS_HS}" bash -c "printf '%s' '${payload}' > \
+			/dev/udp/${dst}/${UDP_PORT}"; then
+		return "${UDP_LOST}"
+	fi
+
+	# wait until rt counts the datagram in Udp6NoPorts or Udp6InCsumErrors
+	if ! slowwait "${WAIT_TIMEOUT_SEC}" until_counter_is \
+			">= $((recv + 1))" get_rt_udp6_received >/dev/null; then
+		return "${UDP_LOST}"
+	fi
+
+	if [ "$(get_rt_udp6_counter Udp6InCsumErrors)" -ne "${errors}" ]; then
+		return "${UDP_CSUM_ERROR}"
+	fi
+
+	if [ "$(get_rt_udp6_counter Udp6NoPorts)" -ne "$((noports + 1))" ]; then
+		return "${UDP_LOST}"
+	fi
+
+	return "${UDP_DELIVERED}"
+}
+
+# check the delivery of a datagram to cafe::<id> and log the result
+# args:
+#  $1 - destination id
+#  $2 - expected return value of check_udp_delivery()
+#  $3 - description of the path
+check_and_log_udp_delivery()
+{
+	local dstid="$1"
+	local expected="$2"
+	local desc="$3"
+
+	check_udp_delivery "${dstid}"
+	log_test_expected $? "${expected}" \
+		"UDP: hs -> ${IPv6_DST_NETWORK}::${dstid} (${desc})"
+}
+
+udp_delivery_tests()
+{
+	log_section "UDP delivery test with CHECKSUM_COMPLETE"
+
+	check_and_log_udp_delivery 1 "${UDP_DELIVERED}" "no SRH"
+	check_and_log_udp_delivery 2 "${UDP_DELIVERED}" "SRH, local segments"
+	check_and_log_udp_delivery 3 "${UDP_DELIVERED}" "End.B6.Encaps, End.DT6"
+	check_and_log_udp_delivery 4 "${UDP_DELIVERED}" \
+		"End next-csid, End.B6.Encaps, End.DT6"
+	check_and_log_udp_delivery 5 "${UDP_CSUM_ERROR}" "control, csum error"
+	check_and_log_udp_delivery 6 "${UDP_DELIVERED}" \
+		"End.BPF, End.B6.Encaps, End.DT6"
+}
+
+test_dummy_dev_or_ksft_skip()
+{
+	local test_netns
+
+	setup_ns test_netns
+
+	modprobe dummy &>/dev/null || true
+	if ! ip -netns "${test_netns}" link add "${DUMMY_DEVNAME}" \
+			type dummy; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: dummy dev not supported"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${test_netns}"
+}
+
+test_iproute2_supp_or_ksft_skip()
+{
+	if ! ip route help 2>&1 | grep -qo next-csid; then
+		echo "SKIP: Missing SRv6 next-csid flavor support in iproute2"
+		exit "${ksft_skip}"
+	fi
+}
+
+test_kernel_supp_or_ksft_skip()
+{
+	local test_netns
+
+	setup_ns test_netns
+
+	ip -netns "${test_netns}" link add "${DUMMY_DEVNAME}" type dummy
+	ip -netns "${test_netns}" link set "${DUMMY_DEVNAME}" up
+
+	if ! ip -netns "${test_netns}" -6 route \
+			add "${CSID_BLOCK}::/${CSID_LBLEN}" encap seg6local \
+			action End flavors next-csid dev "${DUMMY_DEVNAME}" \
+			2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: SRv6 next-csid flavor not supported"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${test_netns}"
+}
+
+test_veth_tx_csum_off_or_ksft_skip()
+{
+	local test_netns
+
+	setup_ns test_netns
+
+	if ! ip -netns "${test_netns}" link add veth-t0 type veth \
+			peer name veth-t1 2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: veth dev not supported"
+		exit "${ksft_skip}"
+	fi
+
+	# setup_hs() turns off transmit checksumming on veth-hs. If it stays on,
+	# conntrack does not compute the receive checksum and the test cannot
+	# see the error.
+	ip netns exec "${test_netns}" ethtool -K veth-t0 tx off >/dev/null 2>&1
+
+	if ! ip netns exec "${test_netns}" ethtool -k veth-t0 | \
+			grep -q "^tx-checksumming: off"; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: Cannot turn off transmit checksumming on veth"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${test_netns}"
+}
+
+test_bpf_file_or_ksft_skip()
+{
+	if [ ! -f "${BPF_FILE}" ]; then
+		echo "SKIP: Missing ${BPF_FILE}, run 'make' first"
+		exit "${ksft_skip}"
+	fi
+}
+
+test_tc_or_ksft_skip()
+{
+	local test_netns
+
+	setup_ns test_netns
+
+	ip -netns "${test_netns}" link add "${DUMMY_DEVNAME}" type dummy
+
+	if ! tc -netns "${test_netns}" qdisc add dev "${DUMMY_DEVNAME}" \
+			clsact 2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: tc clsact qdisc not supported"
+		exit "${ksft_skip}"
+	fi
+
+	if ! tc -netns "${test_netns}" filter add dev "${DUMMY_DEVNAME}" \
+			ingress chain "${BPF_CHAIN}" protocol ipv6 \
+			bpf object-file "${BPF_FILE}" section "${BPF_TC_SEC}" \
+			direct-action 2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: tc bpf filter not supported"
+		exit "${ksft_skip}"
+	fi
+
+	if ! tc -netns "${test_netns}" filter add dev "${DUMMY_DEVNAME}" \
+			ingress chain "${CTRL_CHAIN}" protocol ipv6 \
+			flower dst_ip "${CTRL_DST}" \
+			action goto chain "${BPF_CHAIN}" 2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: tc flower filter or goto chain action not supported"
+		exit "${ksft_skip}"
+	fi
+
+	if ! tc -netns "${test_netns}" filter add dev "${DUMMY_DEVNAME}" \
+			ingress protocol ipv6 matchall \
+			action ct pipe action goto chain "${CTRL_CHAIN}" \
+			2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: tc matchall filter or ct action not supported"
+		exit "${ksft_skip}"
+	fi
+
+	# setup_rt() turns on nf_conntrack_checksum. If it is off, conntrack
+	# does not check the UDP checksum and does not compute the receive
+	# checksum. The test cannot see the error.
+	if ! ip netns exec "${test_netns}" sysctl -wq \
+			net.netfilter.nf_conntrack_checksum=1 2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: nf_conntrack_checksum sysctl not available"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${test_netns}"
+}
+
+test_end_bpf_or_ksft_skip()
+{
+	local test_netns
+
+	setup_ns test_netns
+
+	ip -netns "${test_netns}" link add "${DUMMY_DEVNAME}" type dummy
+	ip -netns "${test_netns}" link set "${DUMMY_DEVNAME}" up
+
+	if ! ip -netns "${test_netns}" -6 route \
+			add "${SID_LOCATOR}::${BPF_FUNC}/128" encap seg6local \
+			action End.BPF endpoint obj "${BPF_FILE}" \
+			sec "${BPF_END_SEC}" dev "${DUMMY_DEVNAME}" \
+			2>/dev/null; then
+		cleanup_ns "${test_netns}"
+		echo "SKIP: SRv6 End.BPF not supported"
+		exit "${ksft_skip}"
+	fi
+
+	cleanup_ns "${test_netns}"
+}
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "SKIP: Need root privileges"
+	exit "${ksft_skip}"
+fi
+
+# required programs to carry out this selftest
+require_command ip
+require_command tc
+require_command ethtool
+require_command ping
+require_command sysctl
+require_command awk
+require_command grep
+
+test_dummy_dev_or_ksft_skip
+test_iproute2_supp_or_ksft_skip
+test_kernel_supp_or_ksft_skip
+test_veth_tx_csum_off_or_ksft_skip
+test_bpf_file_or_ksft_skip
+test_tc_or_ksft_skip
+test_end_bpf_or_ksft_skip
+
+set -e
+trap cleanup EXIT
+
+setup
+set +e
+
+connectivity_tests
+udp_delivery_tests
+
+print_log_test_results
-- 
2.43.0

