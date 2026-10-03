Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B063AAF54
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056051; cv=none; b=X2uC35J8aHnpgZ38lxiOLx29CdgiccZw4XY0+hkRLMB3Vb8LmHkXjXUhjUe17jV/PLt1eas36AZJpJSF4EM24IztbNmEFyVFPfBc+8bua5SwHKUPkdOFNyNkYxGbrQZTvah5AMsIoPLgJoX6uQKzyedTpUuQtkyov5g2EaAdq2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056051; c=relaxed/simple;
	bh=xRsp2N9Z+8qPpeJznDmWv/uBeHAgNqjbt5JGt05EFNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh0bnrSlq3SiN8T8QPI2j0aXiK0Rsc3yOHZXA+UFr9T1DTWUa8tz0yrzwiFu7npqXXKqk2IFzDhxJuj8+FR3ukgOtLRPf39/qFenvDlXnQEeuFwXOm18VenWR0mmnyiYxG3FVnlULoola/g7KjSvgUq9vpIy/bUVuU7njmqgFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8gaA/tV; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8gaA/tV"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35120d43ecaso315870eec.1
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056049; x=1791660849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvL+/Of+YP/3PYHN30KJwZwXhArUTW+KadtVDQB+A84=;
        b=m8gaA/tVVh29GoraWWTmwFPqW7PbPJ1Qvr8jWB66qcdKSZyefCczyM+1vaol6WIsoN
         Hgr9BfJLs8RlkxlKgXS5nPZAz2C3jBIxW+pC1rfDF6sX7Dbcny/Lv1P81Gi0lisFM2Kt
         /sRWUB38uuWP6YbUL5+r9NXZOk+rjMKUyTYKJHc17kqGdzLKI+D5oFSvz+sLYL48i3qd
         MKAWVTlYbNh7WcPm9xS/X2rlHZUDVNjeyDc8/YrwNXKG9uQ0THyUOUJbZMqEchd6F0WG
         Z6HOULtVDr/AdLl8A3o7fNWRapgr0OKyKRuRG4MWhVgJPc6nSvZyOFZtnuWBBptpbHS8
         Yp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056049; x=1791660849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gvL+/Of+YP/3PYHN30KJwZwXhArUTW+KadtVDQB+A84=;
        b=A1vaFO3DbgIi+pEj9p4TVjqs/WV4s93rd0sS8pJF2UjIsA/m0NQka48HorJYQbXbpA
         auguvr/dipNXZ6WnSeNx80vehPbh+3AYdwM+nEJCYc59ixt5Y/LiKMgY+vsZ9eMSMddE
         yvEQ7SWSHdcaBAURBxdF1Y5JyHvlxSfLxzojPEANsvBv2EuUlV0i0Hc7ggkRjgnxM/jX
         YTZwXlSTl8ytfDF42IY3SxIFsWRkbLAavbtShcVBV6WWplgrAZKwDSJIddvNCAqPKmtV
         JPwFQLGeHx5YIHXtlEaeZiCgVHox+12ps84buOIuGr7DhMwPqH4VJl9b8JO2oPn1WQKU
         em3A==
X-Gm-Message-State: AFq9FYJrBA9OMxLLqLLaSH68n45OK9Maj1vYdk1Sl9R1KLNb9QGaRZJj
	0w8BznEpJo5uiDWxN+4AITrnGTchOkPBzlzhbF0KEf6tpftbTyiqDivIkPoLtAMk0QU=
X-Gm-Gg: AYBFou0xttgDqgXYFY49T/eKzmzClcALHZJSDu13Mz0p9X+OKOMKHK5bllFNhsM5GvX
	11DEUUkly400QMHYcu2awl99djdjolhH1O4jD1Ek67lPWRsFeIohxmFtT5vmSuLoOUZ11V+hJ2g
	XwLy9QJkzDwJ5C96EXKfOVnkakhWcr/nfFhWtc0Z79FKLsQApm075RroasSGbWaKUhRg5vIDFZH
	x/2K9cHDBTgFWtP6Q6GDy9jqBFsKk+d3PlYwhu6SVlTPEC5TX/RVGYyRVa/R9O8CYLZfPCUuNqJ
	oB1cwn0VNxnNA32viouy1Vqr2al83t5tcYmmX/s1U+UPSgg8pxg4nyEvtsuR2D1Qg4K6voGjnvq
	VE8VAaAQkVZmZ6LnLQ3dTFzhwNe2FGq3WCK8JbFNqNn1oepbIWfiR2/XB+TPkBYqUr+I/9lSAqC
	/LIOjTUu0s7p1KerM6YYm4f0EZk4vQl0XouPm8xRNKaYXfRrxefkpUfEQKFpIrlNinDFlmmc/9X
	ZH7Aaswy9wzinsLOebapAZq8DrmkjrW
X-Received: by 2002:a05:7300:d519:b0:340:e422:fd40 with SMTP id 5a478bee46e88-3511141b58amr5927695eec.16.1791056048512;
        Sat, 03 Oct 2026 12:34:08 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm17793271eec.13.2026.10.03.12.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:34:08 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next v2 3/3] selftests/bpf: Add a test for the PPPoE encap/decap adjust_room flags
Date: Sat,  3 Oct 2026 15:33:47 -0400
Message-ID: <20261003193347.1137527-4-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003193347.1137527-1-thisseanzhang@gmail.com>
References: <20261003193347.1137527-1-thisseanzhang@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tc test that exercises the new BPF_F_ADJ_ROOM_ENCAP_PPPOE and
BPF_F_ADJ_ROOM_DECAP_PPPOE flags of bpf_skb_adjust_room().

The encap program is run over plain Ethernet/IPv4 and Ethernet/IPv6
packets. The test checks that the PPPoE session header is inserted
between the Ethernet and network headers, that the PPP protocol and
skb->protocol are correct, and that the payload is preserved. It then
runs the decap program and checks that the original packet and
protocol metadata are restored.

A rejection program exercises calls to bpf_skb_adjust_room() that
the helper must reject: an encapsulation length other than
PPPOE_SES_HLEN, encapsulation in BPF_ADJ_ROOM_NET mode, a negative
encapsulation length, the encap flag combined with a decap flag,
shrinking a PPPoE packet without the PPPoE flag, and decapsulation of a
packet whose skb->protocol is not ETH_P_PPP_SES. Decapsulation of a PPPoE
packet with an unsupported PPP protocol and of a packet too short to
still hold an IP header is rejected as well.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 .../selftests/bpf/prog_tests/tc_pppoe.c       | 254 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/tc_pppoe.c  | 163 +++++++++++
 2 files changed, 417 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_pppoe.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
new file mode 100644
index 000000000..73e602c91
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tc_pppoe.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 ThisSeanZhang */
+
+#include <arpa/inet.h>
+#include <test_progs.h>
+#include "tc_pppoe.skel.h"
+
+/* Ethernet + IPv4 + TCP, 54 bytes in total. */
+static const __u8 ip4_pkt[] = {
+	/* Ethernet header. */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x08, 0x00,
+	/* IPv4 header. */
+	0x45, 0x00, 0x00, 0x28,
+	0x12, 0x34, 0x40, 0x00,
+	0x40, 0x06, 0x00, 0x00,
+	0xc0, 0xa8, 0x01, 0x01,
+	0xc0, 0xa8, 0x01, 0x02,
+	/* TCP header. */
+	0x00, 0x50, 0x1f, 0x90,
+	0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00,
+	0x50, 0x02, 0x10, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+/* Ethernet + IPv6 + TCP, 74 bytes in total. */
+static const __u8 ip6_pkt[] = {
+	/* Ethernet header. */
+	0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+	0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+	0x86, 0xdd,
+	/* IPv6 header. */
+	0x60, 0x00, 0x00, 0x00,
+	0x00, 0x14, 0x06, 0x40,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02,
+	/* TCP header. */
+	0x00, 0x50, 0x1f, 0x90,
+	0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00,
+	0x50, 0x02, 0x10, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+};
+
+#define PPP_SES_HLEN	8
+#define TC_ACT_SHOT	2
+
+static int run_prog(int prog_fd, const void *data_in, __u32 size_in,
+		    void *data_out, __u32 size_out, __u32 *retval,
+		    __u32 *size_out_actual)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = (void *)data_in,
+		    .data_size_in = size_in,
+		    .data_out = data_out,
+		    .data_size_out = size_out,
+	);
+	int ret;
+
+	ret = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (!ret && retval)
+		*retval = opts.retval;
+	if (!ret && size_out_actual)
+		*size_out_actual = opts.data_size_out;
+
+	return ret;
+}
+
+static void test_encap_decap(struct tc_pppoe *skel, const char *subtest,
+			     const __u8 *pkt, __u32 pkt_len, int ethertype,
+			     __u8 ppp_proto)
+{
+	__u8 encap_pkt[128];
+	__u8 decap_pkt[128];
+	__u32 retval, out_len;
+	int ret;
+
+	if (!test__start_subtest(subtest))
+		return;
+
+	skel->bss->encap_proto = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_encap),
+		       pkt, pkt_len, encap_pkt, sizeof(encap_pkt),
+		       &retval, &out_len);
+	ASSERT_OK(ret, "encap test_run");
+	ASSERT_OK(retval, "encap retval");
+	ASSERT_EQ(out_len, pkt_len + PPP_SES_HLEN, "encap pkt len");
+	ASSERT_EQ(skel->bss->encap_proto, htons(0x8864),
+		  "encap skb protocol");
+
+	/* Ethernet header, with the ethertype changed to PPPoE session. */
+	ASSERT_EQ(encap_pkt[12], 0x88, "encap eth h_proto");
+	ASSERT_EQ(encap_pkt[13], 0x64, "encap eth h_proto");
+	/*
+	 * PPPoE session header: ver/type/code, session id, length and
+	 * PPP protocol.
+	 */
+	ASSERT_EQ(encap_pkt[14], 0x11, "encap pppoe ver/type");
+	ASSERT_EQ(encap_pkt[15], 0x00, "encap pppoe code");
+	ASSERT_EQ(encap_pkt[16], 0xde, "encap pppoe sid");
+	ASSERT_EQ(encap_pkt[17], 0xad, "encap pppoe sid");
+	ASSERT_EQ(encap_pkt[18], 0x00, "encap pppoe length");
+	ASSERT_EQ(encap_pkt[19], pkt_len - 14 + 2, "encap pppoe length");
+	ASSERT_EQ(encap_pkt[20], 0x00, "encap ppp proto");
+	ASSERT_EQ(encap_pkt[21], ppp_proto, "encap ppp proto");
+	/*
+	 * The original packet must be shifted unchanged behind the
+	 * new header.
+	 */
+	ASSERT_MEMEQ(encap_pkt + 14 + PPP_SES_HLEN, pkt + 14,
+		     pkt_len - 14, "encap payload");
+
+	skel->bss->decap_proto = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_decap),
+		       encap_pkt, pkt_len + PPP_SES_HLEN, decap_pkt,
+		       sizeof(decap_pkt), &retval, &out_len);
+	ASSERT_OK(ret, "decap test_run");
+	ASSERT_OK(retval, "decap retval");
+	ASSERT_EQ(out_len, pkt_len, "decap pkt len");
+	ASSERT_EQ(skel->bss->decap_proto, ethertype, "decap skb protocol");
+	ASSERT_MEMEQ(decap_pkt, pkt, pkt_len, "decap packet");
+}
+
+static void test_reject(struct tc_pppoe *skel, int case_id,
+			const void *data_in, __u32 size_in, const char *name)
+{
+	__u8 out[128];
+	__u32 retval = 0;
+	int ret;
+
+	if (!test__start_subtest(name))
+		return;
+
+	skel->bss->reject_case = case_id;
+	skel->bss->reject_unexpected = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_reject),
+		       data_in, size_in, out, sizeof(out), &retval, NULL);
+	ASSERT_OK(ret, "reject test_run");
+	ASSERT_EQ(retval, TC_ACT_SHOT, "helper rejected the call");
+	ASSERT_EQ(skel->bss->reject_unexpected, 0, "no unexpected success");
+}
+
+static void test_decap_reject_input(struct tc_pppoe *skel,
+				    const __u8 *pkt, __u32 pkt_len,
+				    const char *subtest)
+{
+	__u8 out[128];
+	__u32 retval = 0;
+	int ret;
+
+	if (!test__start_subtest(subtest))
+		return;
+
+	skel->bss->decap_proto = 0;
+	ret = run_prog(bpf_program__fd(skel->progs.tc_pppoe_decap),
+		       pkt, pkt_len, out, sizeof(out), &retval, NULL);
+	ASSERT_OK(ret, "decap reject test_run");
+	ASSERT_EQ(retval, TC_ACT_SHOT, "helper rejected the call");
+	ASSERT_EQ(skel->bss->decap_proto, 0, "skb protocol unchanged");
+}
+
+void test_tc_pppoe(void)
+{
+	/*
+	 * A PPPoE packet whose PPP protocol is neither IPv4 nor IPv6:
+	 * IP control protocol (0x8021) in this case.
+	 */
+	static const __u8 bad_ppp_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x88, 0x64,
+		0x11, 0x00, 0x00, 0x00, 0x00, 0x28, 0x80, 0x21,
+		0x45, 0x00, 0x00, 0x28,
+		0x12, 0x34, 0x40, 0x00,
+		0x40, 0x06, 0x00, 0x00,
+		0xc0, 0xa8, 0x01, 0x01,
+		0xc0, 0xa8, 0x01, 0x02,
+		0x00, 0x50, 0x1f, 0x90,
+		0x00, 0x00, 0x00, 0x01,
+		0x00, 0x00, 0x00, 0x00,
+		0x50, 0x02, 0x10, 0x00,
+		0x00, 0x00, 0x00, 0x00,
+	};
+	/*
+	 * A PPPoE packet whose payload is too short to still contain a
+	 * full IP header after decapsulation.
+	 */
+	static const __u8 truncated_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x88, 0x64,
+		0x11, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x21,
+		0x45, 0x00,
+	};
+	/* Non-PPPoE IPv4 packet whose bytes 20/21 decode as PPP_IP. */
+	static const __u8 fake_ppp_pkt[] = {
+		0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
+		0x08, 0x00,
+		0x45, 0x00, 0x00, 0x28,
+		0x12, 0x34, 0x00, 0x21,
+		0x40, 0x06, 0x00, 0x00,
+		0xc0, 0xa8, 0x01, 0x01,
+		0xc0, 0xa8, 0x01, 0x02,
+		0x00, 0x50, 0x1f, 0x90,
+		0x00, 0x00, 0x00, 0x01,
+		0x00, 0x00, 0x00, 0x00,
+		0x50, 0x02, 0x10, 0x00,
+		0x00, 0x00, 0x00, 0x00,
+	};
+	__u8 encap_pkt[128];
+	struct tc_pppoe *skel;
+	__u32 retval, out_len;
+
+	skel = tc_pppoe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	test_encap_decap(skel, "encap-decap-v4", ip4_pkt, sizeof(ip4_pkt),
+			 htons(0x0800), 0x21);
+	test_encap_decap(skel, "encap-decap-v6", ip6_pkt, sizeof(ip6_pkt),
+			 htons(0x86dd), 0x57);
+
+	test_decap_reject_input(skel, bad_ppp_pkt, sizeof(bad_ppp_pkt),
+				"decap-bad-ppp-proto");
+	test_decap_reject_input(skel, truncated_pkt, sizeof(truncated_pkt),
+				"decap-truncated");
+	test_reject(skel, 6, fake_ppp_pkt, sizeof(fake_ppp_pkt),
+		    "reject-decap-fake-ppp-proto");
+
+	/*
+	 * Encapsulate a v4 packet once more to get a PPPoE packet as
+	 * input for the "decap without the flag" rejection case.
+	 */
+	ASSERT_OK(run_prog(bpf_program__fd(skel->progs.tc_pppoe_encap),
+			   ip4_pkt, sizeof(ip4_pkt), encap_pkt,
+			   sizeof(encap_pkt), &retval, &out_len),
+		  "encap v4 for reject input");
+
+	test_reject(skel, 1, ip4_pkt, sizeof(ip4_pkt), "reject-encap-len");
+	test_reject(skel, 2, ip4_pkt, sizeof(ip4_pkt), "reject-encap-mode");
+	test_reject(skel, 3, ip4_pkt, sizeof(ip4_pkt), "reject-encap-shrink");
+	test_reject(skel, 4, ip4_pkt, sizeof(ip4_pkt), "reject-flag-mix");
+	test_reject(skel, 5, encap_pkt, sizeof(ip4_pkt) + PPP_SES_HLEN,
+		    "reject-decap-no-flag");
+	test_reject(skel, 6, ip4_pkt, sizeof(ip4_pkt),
+		    "reject-decap-non-pppoe");
+
+	tc_pppoe__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/tc_pppoe.c b/tools/testing/selftests/bpf/progs/tc_pppoe.c
new file mode 100644
index 000000000..b1624f0f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_pppoe.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 ThisSeanZhang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define ETH_P_IP_TEST		0x0800
+#define ETH_P_IPV6_TEST		0x86dd
+#define ETH_P_PPP_SES_TEST	0x8864
+#define PPP_IP_TEST		0x21
+#define PPP_IPV6_TEST		0x57
+
+#define ETH_HLEN_TEST		14
+#define PPPOE_SES_HLEN_TEST	8
+
+#define TC_ACT_OK_TEST		0
+#define TC_ACT_SHOT_TEST	2
+
+/* Selects the bpf_skb_adjust_room() call made by tc_pppoe_reject. */
+int reject_case;
+
+/* skb->protocol as observed after the helper call. */
+int encap_proto;
+int decap_proto;
+
+/*
+ * Set when tc_pppoe_reject observes a call that should have been
+ * rejected by the helper.
+ */
+int reject_unexpected;
+
+SEC("tc")
+int tc_pppoe_encap(struct __sk_buff *skb)
+{
+	__u8 hdr[PPPOE_SES_HLEN_TEST] = {
+		0x11, 0x00,			/* ver, type, code */
+		0xde, 0xad,			/* session id */
+		0x00, 0x00,			/* length, set below */
+		0x00, 0x00,			/* PPP protocol, set below */
+	};
+	struct ethhdr eth;
+	/*
+	 * The PPPoE length field covers everything after the 6 byte
+	 * session header: the PPP protocol field plus the payload.
+	 */
+	__u16 plen = skb->len - ETH_HLEN_TEST + 2;
+
+	hdr[4] = (plen >> 8) & 0xff;
+	hdr[5] = plen & 0xff;
+
+	switch (skb->protocol) {
+	case bpf_htons(ETH_P_IP_TEST):
+		hdr[7] = PPP_IP_TEST;
+		break;
+	case bpf_htons(ETH_P_IPV6_TEST):
+		hdr[7] = PPP_IPV6_TEST;
+		break;
+	default:
+		return TC_ACT_SHOT_TEST;
+	}
+
+	if (bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST, BPF_ADJ_ROOM_MAC,
+				BPF_F_ADJ_ROOM_ENCAP_PPPOE))
+		return TC_ACT_SHOT_TEST;
+
+	encap_proto = skb->protocol;
+
+	if (bpf_skb_store_bytes(skb, ETH_HLEN_TEST, hdr, sizeof(hdr), 0))
+		return TC_ACT_SHOT_TEST;
+
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		return TC_ACT_SHOT_TEST;
+	eth.h_proto = bpf_htons(ETH_P_PPP_SES_TEST);
+	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
+		return TC_ACT_SHOT_TEST;
+
+	return TC_ACT_OK_TEST;
+}
+
+SEC("tc")
+int tc_pppoe_decap(struct __sk_buff *skb)
+{
+	struct ethhdr eth;
+
+	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)))
+		return TC_ACT_SHOT_TEST;
+	if (eth.h_proto != bpf_htons(ETH_P_PPP_SES_TEST))
+		return TC_ACT_SHOT_TEST;
+
+	if (bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN_TEST, BPF_ADJ_ROOM_MAC,
+				BPF_F_ADJ_ROOM_DECAP_PPPOE))
+		return TC_ACT_SHOT_TEST;
+
+	decap_proto = skb->protocol;
+
+	/*
+	 * Restore the ethertype to the protocol of the decapsulated
+	 * payload, as picked by the kernel from the PPP protocol field.
+	 */
+	eth.h_proto = (__be16)skb->protocol;
+	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0))
+		return TC_ACT_SHOT_TEST;
+
+	return TC_ACT_OK_TEST;
+}
+
+/*
+ * Every bpf_skb_adjust_room() call below must be rejected by the
+ * helper; tc_pppoe_reject reports (and fails the test) if one of
+ * them unexpectedly succeeds.
+ */
+SEC("tc")
+int tc_pppoe_reject(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	switch (reject_case) {
+	case 1:
+		/* Encap with a wrong room size. */
+		ret = bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST - 4,
+					  BPF_ADJ_ROOM_MAC,
+					  BPF_F_ADJ_ROOM_ENCAP_PPPOE);
+		break;
+	case 2:
+		/* Encap at the wrong position. */
+		ret = bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST,
+					  BPF_ADJ_ROOM_NET,
+					  BPF_F_ADJ_ROOM_ENCAP_PPPOE);
+		break;
+	case 3:
+		/* Encap with a negative room size. */
+		ret = bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN_TEST,
+					  BPF_ADJ_ROOM_MAC,
+					  BPF_F_ADJ_ROOM_ENCAP_PPPOE);
+		break;
+	case 4:
+		/* Encap flag combined with a decap flag. */
+		ret = bpf_skb_adjust_room(skb, PPPOE_SES_HLEN_TEST,
+					  BPF_ADJ_ROOM_MAC,
+					  BPF_F_ADJ_ROOM_ENCAP_PPPOE |
+					  BPF_F_ADJ_ROOM_DECAP_PPPOE);
+		break;
+	case 5:
+		/* Shrink of a PPPoE packet without the PPPoE flag. */
+		ret = bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN_TEST,
+					  BPF_ADJ_ROOM_MAC, 0);
+		break;
+	case 6:
+		/* Decap of a non-PPPoE packet (plain IP or fake PPP proto). */
+		ret = bpf_skb_adjust_room(skb, -PPPOE_SES_HLEN_TEST,
+					  BPF_ADJ_ROOM_MAC,
+					  BPF_F_ADJ_ROOM_DECAP_PPPOE);
+		break;
+	}
+
+	if (!ret)
+		reject_unexpected = 1;
+
+	return TC_ACT_SHOT_TEST;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

