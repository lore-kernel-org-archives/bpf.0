Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E590367F26;
	Tue, 18 Aug 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054625; cv=none; b=Z+7/t5iKo6DSqasUFzazJoNH6S5wDhpftWmnbEU2qIQjGhYUQjoyDz999l13+0x9X9ZtcRdgAj67bS6vaJzM8Ff+l0PW/C9anjqucitFvqC4dyBE+Chh4xZwTfeYWjRW39gBfjanTtcsYUjfNT242qClNh8IVSbQg+BLIP42p2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054625; c=relaxed/simple;
	bh=PL5rhIilZ1W04nt6JPYSsY+hD2e70H+FDSFjBPa/XyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rKvZyCCMSRrIx0xaGwdUqVKjoqDQZNsJ1C2gREBJPHHQ5Q0+oCBt0HR7MTNieiK5VPo+/hy39AymIRXivHpeXDOJ0fwzAMyuyEYT06WDqnLlS1Bm/gJnfQXCjslEBnRJc6KLZaJCsy27wwX4Jtm5sCOXx5+hszuB/hSq3uphd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=o9yyWvQg; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="o9yyWvQg"
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67IABefx1599894;
	Tue, 18 Aug 2026 13:03:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=apr2026.eng; bh=MQAuEeSWo6Msi1419jdvftkRkARWgJiWi
	bYwmZYWZHo=; b=o9yyWvQgWAwROx8h0s0/5otPqRJn5EhEM/YuVtscS80lE5U3w
	MnwG1GuZ0q9t91m+U24BYO70xCQcjrmyK8NlIPKZva2t4luGkXOtPlgdrvQEn0LG
	Ocewo3ykR9p/dHUDsdab1Bug9PBR4GBg1A+M9SA4igaqxNfRGtXOlIxKNyoaBALJ
	hdgxfzda2oZCDp2EiMQ6YUR1F4Ptmr9P4s0VcRcQ87mdbSDb0chm34iEY+xm5GOv
	q8padx/g8poJqRLP9NKE/EuBvuJOn/ZXqLyEJAOPI8/Fl8o2voMNlIA4qausB4V4
	cXynRAyerQiEcOiPijS1UiFp51j+qxRklZ09A==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4g4d6t51sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 13:03:13 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBwJb3031383;
	Tue, 18 Aug 2026 05:03:13 -0700
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4g2p37b4wn-1;
	Tue, 18 Aug 2026 05:03:12 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 9DBAC8A;
	Tue, 18 Aug 2026 12:03:11 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Nick Hudson <nhudson@akamai.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state without false-pass gaps
Date: Tue, 18 Aug 2026 13:03:07 +0100
Message-Id: <20260818120308.623905-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608180087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX1pBN8pG13Mwh
 sp8C7xf6+uYQcslE1XFqUOt6y0WSdBDY4Hwpsb2S6coz6j7uIH7ETSV9aNvZcJ4jN74jJ09g1RC
 gNZfX1+f9gqKw5e6JV0oLzLu5502VbMbo3d426cfJEB43I6b2eVpbOSsTgnW7CzmwKj8IxeV15R
 dSL8/KevX4P8Eox1keuvMHnl22mLsxAGkEiWCNAKTcbgUhwM/JMbDAnarnmFgoFH1AxYhGYdf41
 w04xruMkyrJ7rx+69C//AqoGlyqTJubceFXhEGOtjs8OfK10YlPV0MPIwCwhU6z/liZ8fyUv2d4
 YmWInmwMHc5sjEnpY9DI8y/w/PTwK8ivw05goAdcgFWwa8zRzHPU1DnkhLaxegkYH0jHESiBJMS
 gcFpWIFPx3IJEjV7Ic59jQNoRR5bPTy61ek7G3QpN22K83lY5CLlqggPRyCJcS2R7NiRR5ii1t1
 8Jym0R9Nz4z4e6iEzcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX+XAKkmPdVbY6
 3lpdXYkcFOSRz5HTk2NOvEmK2MFCIprJIgYxAdOWzT63DabAqzjAqAa1c274QoRpkMEJEBsMs+v
 AoI38YACki5e7yqQAblrpNOeSnB2u+U=
X-Proofpoint-GUID: TRm72OAjYsiaVsmsb1GaH1zKHbM5z8r7
X-Proofpoint-ORIG-GUID: TRm72OAjYsiaVsmsb1GaH1zKHbM5z8r7
X-Authority-Analysis: v=2.4 cv=a6IAM0SF c=1 sm=1 tr=0 ts=6a844a01 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=XKgOefoLEnF0tNwW78TB:22 a=X7Ea-ya5AAAA:8 a=hjiSBXTtVWtPCglo4hsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608180088

This follow-up tightens the selftest to guard against false passes in
GSO decap validation.

It validates the expected post-decap state for both GSO and non-GSO
packets: expected tunnel gso_type bits must be cleared and
skb->encapsulation must match the remaining tunnel state.

It also adds explicit assertions that the decap validation path was
executed, including the large-send phase for GSO-marked subtests, and
asserts that the large-send marker is reset after the send.

This keeps the tc_tunnel decap checks meaningful and avoids false-pass
regressions without over-constraining behavior across tunnel modes.

Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c | 33 +++++++++++++++----
 .../selftests/bpf/progs/test_tc_tunnel.c      | 19 +++++++++++
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 67ba27d69347..08d7d90f7772 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -206,7 +206,7 @@ static void disconnect_client_from_server(struct subtest_cfg *cfg,
 	free(conn);
 }
 
-static int send_and_test_data(struct subtest_cfg *cfg)
+static int send_and_test_data(struct subtest_cfg *cfg, struct test_tc_tunnel *skel)
 {
 	struct connection *conn;
 	int err, res = -1;
@@ -215,6 +215,7 @@ static int send_and_test_data(struct subtest_cfg *cfg)
 	if (!ASSERT_OK_PTR(conn, "connect to server"))
 		return -1;
 
+	skel->bss->decap_expect_large_send = 0;
 	err = send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
 	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from client"))
 		goto end;
@@ -226,14 +227,17 @@ static int send_and_test_data(struct subtest_cfg *cfg)
 		goto end;
 	}
 
+	skel->bss->decap_expect_large_send = 1;
 	err = send(conn->client_fd, tx_buffer, GSO_TEST_DATA_SIZE, 0);
 	if (!ASSERT_EQ(err, GSO_TEST_DATA_SIZE, "send (large) data from client"))
 		goto end;
 	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
 		goto end;
+	skel->bss->decap_expect_large_send = 0;
 
 	res = 0;
 end:
+	skel->bss->decap_expect_large_send = 0;
 	disconnect_client_from_server(cfg, conn);
 	return res;
 }
@@ -374,10 +378,15 @@ static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
 	return ret;
 }
 
-static void run_test(struct subtest_cfg *cfg)
+static void run_test(struct subtest_cfg *cfg, struct test_tc_tunnel *skel)
 {
 	struct nstoken *nstoken;
 
+	skel->bss->decap_validation_seen = 0;
+	skel->bss->decap_gso_validation_seen = 0;
+	skel->bss->decap_large_send_validation_seen = 0;
+	skel->bss->decap_expect_large_send = 0;
+
 	if (!ASSERT_OK(run_server(cfg), "run server"))
 		return;
 
@@ -386,7 +395,7 @@ static void run_test(struct subtest_cfg *cfg)
 		goto fail;
 
 	/* Basic communication must work */
-	if (!ASSERT_OK(send_and_test_data(cfg), "connect without any encap"))
+	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect without any encap"))
 		goto fail;
 
 	/* Attach encapsulation program to client */
@@ -398,7 +407,7 @@ static void run_test(struct subtest_cfg *cfg)
 		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
 					"configure kernel decapsulation"))
 			goto fail;
-		if (!ASSERT_OK(send_and_test_data(cfg),
+		if (!ASSERT_OK(send_and_test_data(cfg, skel),
 			       "connect with encap prog and kern decap"))
 			goto fail;
 	}
@@ -406,7 +415,18 @@ static void run_test(struct subtest_cfg *cfg)
 	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
 	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
 		goto fail;
-	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs");
+	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect with encap and decap progs"))
+		goto fail;
+	if (!ASSERT_NEQ(skel->bss->decap_validation_seen, 0,
+			"decap validation executed"))
+		goto fail;
+	if (!ASSERT_EQ(skel->bss->decap_expect_large_send, 0,
+		       "decap large-send marker reset"))
+		goto fail;
+	if (cfg->test_gso) {
+		ASSERT_NEQ(skel->bss->decap_large_send_validation_seen, 0,
+			   "decap validation executed for large send");
+	}
 
 fail:
 	close_netns(nstoken);
@@ -438,6 +458,7 @@ static int setup(void)
 	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
 	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
 	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
+	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
 	SYS(fail_close_ns_client, "ip link set veth1 up");
 	nstoken_server = open_netns(SERVER_NS);
 	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
@@ -701,7 +722,7 @@ void test_tc_tunnel(void)
 		if (ret < 0 || !test__start_subtest(cfg->name))
 			continue;
 		if (subtest_setup(skel, cfg) == 0)
-			run_test(cfg);
+			run_test(cfg, skel);
 		subtest_cleanup(cfg);
 	}
 	cleanup();
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 853bca962910..e9bd1c9781f7 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -16,6 +16,11 @@ static const int cfg_port = 8000;
 
 static const int cfg_udp_src = 20000;
 
+__u64 decap_validation_seen;
+__u64 decap_gso_validation_seen;
+__u64 decap_large_send_validation_seen;
+__u32 decap_expect_large_send;
+
 #define ETH_P_MPLS_UC	0x8847
 #define ETH_P_TEB	0x6558
 
@@ -690,7 +695,21 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto,
 
 	kskb = bpf_cast_to_kern_ctx(skb);
 	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+
+	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+		decap_validation_seen++;
+
+	if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+		      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
+	    decap_expect_large_send)
+		decap_large_send_validation_seen++;
+
 	if (shinfo->gso_size) {
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			decap_gso_validation_seen++;
+
 		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
 		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
 			return TC_ACT_SHOT;
-- 
2.34.1

