Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1D38A2BE
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141243; cv=none; b=bM6WVkXZJkrbTrRF75dEM3v00pdkAfo4Gryp+EM97dsO/yzh/VYnpsHtcamWrPJCngY+ISnN5OjjwgZnLO44UlA7M8/Y/YGwQLIb4+ZVMNg9PAcYt3ALmmxE5R2LnBhnedA5v2L3bmjiHGF8dFXn1tAJcunfzBmLGpc92RJpmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141243; c=relaxed/simple;
	bh=eXRRNMVyb3VQEc6g2dIHH/XaQIiC52yN6oZ9hChahqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTYDG8cGPgH9nz6cBJ731MDKq/oDZdrwR+SyiE3+ak+uAKJRlniKOUeccZZoSL0KMB6FMy0rfCgox3UhTo9Tro1Vj29eqXZjsFfDdAMUaBWBpyjQTiCkBZ4AaUb3GnY7Ji0KfMktO9CNo403Z7epQZpzb8aq4qPgmWOiij5wzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+Eyv/JF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+Eyv/JF"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AAInqw1627924;
	Tue, 10 Mar 2026 11:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=frX0Xxr5t9MGcjBSJHaod9X5gAQAC
	Oih6uo+ihaZgJ8=; b=b+Eyv/JFifzLP1QVnnHmXDiaCl9o4S7nJPIXSgx04NNBl
	PRQumCfmP5e3kXesPAWe1Pjye8YK6SYL2o+pxdv59kJmlpEBEVclwJDZxV9xQhsE
	eaNXN9AWXS7hi0w95oAMpk16S9NyezlHZsXniujFxm4iGbz4Ostvx+2BoWAwMO5a
	MZBSAgPavlgeo6J/RcF1FV7viyUzfxOVzCZTRlvfUSl44TFF3OHnZaGXKLLF9u/o
	Ik57k7/iFT0Q9u/V0/zZBZyKe6E0amK31CUbU8sUmZ8zqkSIw5hTqqtg3bhNfDPo
	IKrQGhZq++YJNgDlmmvD4xW78BHB9oUez76rSkaGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmps2mm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 11:13:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAvjoa020274;
	Tue, 10 Mar 2026 11:13:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafdy5cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 11:13:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62ABDWlv031966;
	Tue, 10 Mar 2026 11:13:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-109.vpn.oracle.com [10.154.49.109])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4crafdy5b4-1;
	Tue, 10 Mar 2026 11:13:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, alibuda@linux.alibaba.com, yanjun.zhu@linux.dev,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Colm Harrington <colm.harrington@oracle.com>
Subject: [PATCH bpf] selftests/bpf: Handle !CONFIG_SMC in bpf_smc.c
Date: Tue, 10 Mar 2026 11:13:29 +0000
Message-ID: <20260310111330.601765-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100096
X-Authority-Analysis: v=2.4 cv=IJQPywvG c=1 sm=1 tr=0 ts=69affcde b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=661rb-2e5EOglZhnmb0A:9 cc=ntf
 awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5NiBTYWx0ZWRfXwLtFL8VZtZ1V
 IIICULOVYRROjxf4xQycEUEsBWTLde1S1CKJhoFyUgCVGIcunn8qxhaBocZlOfMTLCCa12aemsu
 90D5+/zYyOzQmPH0e+KQUVfgOxW5AMbX+Kcrp11BUbf2RRv6zsO+JLEcqUdyZ4obKd58Jmegd9f
 u/DGyFS+h6eQZvwwXGC1WMYHj36WsSa8SD5G5NNrl32RdzmwThzQc9BTHwiA6hgce2o7WZnwkE9
 6phFIjf4jCgNXnkvjgwK9HBQ+cQJyBc6YldxXxDKvvIVTY9yBmOIYz/GnLml8I602K6EuYEPeXr
 hg0N+LnMs4mtpbfV6y2KGFbYXLHY2na4UVYTdldGMoFsqXIPft3fBHNUdTkroY1yulPcDsyml8b
 HQk+94AQFNu/Vw3zwsjaEwHn9wdji/Smb+7BbfvgQ3eF7j7R1wcY0PFkbNW3zVRltXgzHeIDYVX
 yn2/IP+Qx0hbwGzSv9dJrmFhBUmWpx2DDZzHaVYM=
X-Proofpoint-GUID: EAS_JQMxLcEf8dhbZeqhCpxFO-awuMvr
X-Proofpoint-ORIG-GUID: EAS_JQMxLcEf8dhbZeqhCpxFO-awuMvr

Currently BPF selftests will fail to compile if CONFIG_SMC
is not set.

Use BPF CO-RE to work around the case where CONFIG_SMC is
not set; use ___local variants of relevant structures and
utilize bpf_core_field_exists() for net->smc.

The test continues to pass where

  CONFIG_SMC=y
  CONFIG_SMC_HS_CTRL_BPF=y

but these changes allow the selftests to build in the absence
of CONFIG_SMC=y.

Also ensure that we get a pure skip rather than a skip+fail
by removing the SMC is unsupported part from the ASSERT_FALSE()
in get_smc_nl_family(); doing this means we get a skip without
a fail when CONFIG_SMC is not set:

$ sudo ./test_progs -t bpf_smc
Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

Reported-by: Colm Harrington <colm.harrington@oracle.com>
Fixes: beb3c67297d9 ("bpf/selftests: Add selftest for bpf_smc_hs_ctrl")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/test_bpf_smc.c   |  6 ++--
 tools/testing/selftests/bpf/progs/bpf_smc.c   | 28 +++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
index de22734abc4d..40d38280c091 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_smc.c
@@ -131,8 +131,10 @@ static bool get_smc_nl_family_id(void)
 		goto fail;
 
 	ret = recv(fd, &msg, sizeof(msg), 0);
-	if (!ASSERT_FALSE(msg.n.nlmsg_type == NLMSG_ERROR || ret < 0 ||
-			  !NLMSG_OK(&msg.n, ret), "nl_family response"))
+	if (msg.n.nlmsg_type == NLMSG_ERROR)
+		goto fail;
+	if (!ASSERT_FALSE(ret < 0 || !NLMSG_OK(&msg.n, ret),
+			  "nl_family response"))
 		goto fail;
 
 	nl = (struct nlattr *)GENLMSG_DATA(&msg);
diff --git a/tools/testing/selftests/bpf/progs/bpf_smc.c b/tools/testing/selftests/bpf/progs/bpf_smc.c
index 70d8b08f5914..6263a45bf006 100644
--- a/tools/testing/selftests/bpf/progs/bpf_smc.c
+++ b/tools/testing/selftests/bpf/progs/bpf_smc.c
@@ -8,6 +8,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+#ifndef SMC_HS_CTRL_NAME_MAX
+#define SMC_HS_CTRL_NAME_MAX 16
+#endif
+
 enum {
 	BPF_SMC_LISTEN	= 10,
 };
@@ -18,6 +22,20 @@ struct smc_sock___local {
 	bool use_fallback;
 } __attribute__((preserve_access_index));
 
+struct smc_hs_ctrl___local {
+	char name[SMC_HS_CTRL_NAME_MAX];
+	int (*syn_option)(struct tcp_sock *);
+	int (*synack_option)(const struct tcp_sock  *, struct inet_request_sock *);
+} __attribute__((preserve_access_index));
+
+struct netns_smc___local {
+	struct smc_hs_ctrl___local *hs_ctrl;
+} __attribute__((preserve_access_index));
+
+struct net___local {
+	struct netns_smc___local smc;
+} __attribute__((preserve_access_index));
+
 int smc_cnt = 0;
 int fallback_cnt = 0;
 
@@ -88,8 +106,14 @@ int BPF_PROG(smc_run, int family, int type, int protocol)
 
 	task = bpf_get_current_task_btf();
 	/* Prevent from affecting other tests */
-	if (!task || !task->nsproxy->net_ns->smc.hs_ctrl)
+	if (!task) {
 		return protocol;
+	} else {
+		struct net___local *net = (struct net___local *)task->nsproxy->net_ns;
+
+		if (!bpf_core_field_exists(struct net___local, smc) || !net->smc.hs_ctrl)
+			return protocol;
+	}
 
 	return IPPROTO_SMC;
 }
@@ -110,7 +134,7 @@ int BPF_PROG(bpf_smc_set_tcp_option, struct tcp_sock *tp)
 }
 
 SEC(".struct_ops")
-struct smc_hs_ctrl  linkcheck = {
+struct smc_hs_ctrl___local  linkcheck = {
 	.name		= "linkcheck",
 	.syn_option	= (void *)bpf_smc_set_tcp_option,
 	.synack_option	= (void *)bpf_smc_set_tcp_option_cond,
-- 
2.39.3

