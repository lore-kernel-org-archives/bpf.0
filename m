Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7D30DD1B;
	Mon,  2 Mar 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482167; cv=none; b=hM1atg/XN3ylebIei8bduECRD8d7SjFPkMUBkGNrvYbS4/IPlNya4KfJwWhYGdAwV3HOdsRg4lQUbMkFiN/4CA7dXJRlzqQMNj8bkwgA/7jf2XhK3O2MidHCev+LJjro/S94eE7Gr0ZSdKIU4OIV4EMT+IpxVZDrc/8McPAQbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482167; c=relaxed/simple;
	bh=qecaczRx59iev9ZlNxkzN7qLhX4m/YEsK+zTFHlJFFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7orOI261HZ/lyJ24LdvA5PPxVE0sg4q+L1y5bBlMOUOm4YyAhIHwEFYR+vHry5iOkEnNXV2eNPzLAA2errevM3YUXdHh8u+v+/1u5bxF1EV4tNILcf4DrWh49K9gjNbV2PKlJJm1QqoOTnjXcdlEUBraSUNHQhA+s+JVK8zH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=vuqM9+F0; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="vuqM9+F0"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GqjqS3120457;
	Mon, 2 Mar 2026 20:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=hWZ12R86R04xykDYYhwyA0mgdUpPBiwyjwMcGTsvgTc=; b=vuqM
	9+F0GkFDyqI51X/wGSX3TecY69O4+XoqnRfkrWXdQAKIZdlMHeleWo24UGBjmLLW
	cInYxPPpb0zoh39pBaYu4BUme4GII1nr+x97pkBOdoDyI7/y3CRTwCmdUIvViKUs
	DQXSqbXPrqs1mo9cg2blBlQQw7hlXIiY/pE52E5mbdpAaloxonbLt8u6CeUVGeBL
	+jlRSYHNt/j2pmB625c2sDrKtRXvi0YO4gjgXFkx8Tjga/GspSSRP3mf5yi/oPCs
	wGIkwPfNrKtbSOgniGn8nE+X0oIMEO3/KbTe7byCr7ouxhGfvkH+GftZI2nVv+kI
	oq5FSdTGd90CwrTmpg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmcm95us1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:08:43 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 20:08:41 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add tests for kprobe.session optimization
Date: Mon, 2 Mar 2026 15:08:37 -0500
Message-ID: <20260302200837.317907-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
References: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=crWWUl4i c=1 sm=1 tr=0 ts=69a5ee4b cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=1RrSYoAmGP-V0Qkg3bQA:9
X-Proofpoint-GUID: sF6HX1Yjou4NtZKOXXPM1WKCGmtXWxVQ
X-Proofpoint-ORIG-GUID: sF6HX1Yjou4NtZKOXXPM1WKCGmtXWxVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX6FiMyavwldD3
 unmWC1cCKodnEZZqdK5LPfrcyrwXKaNQQk1Ql97Cwnfm2ixvUvwPqYZEXngAYLJGmabLU0IBbjA
 bYhVaaCTSUbp1mGb29ZPEkmmXWNlDTgJfMvHXovyqOrSX3rUB88+Fn/svoys1HGY2kUA2ytKJzy
 x7cdaD4BgowLJxVFVhi15wsMw1+Yz9GyHxczCfVG4c8u7BXffdsmuR5y2mNwmnpiblDJFdO2cI7
 RdZScLxvjm7j1KpEuhu4c0G3tNnctx3d1YTZT4kCP5Ds1x+7MmglYp6eVKnA6urblirCho9oAPg
 e8XMQ2AKgWCD06xuo3C498A8kheokcBwSqdYRd+lek5twyfpzNAl8kbpGwFX+tjzXSvLsWPuMQR
 5M4tN6mIFBit/E/qaDDKOIc8c7SsIYx+kiXEJwET2om1NIJui7e7p/7Ygf9TOUeEy1Z7pcaj2+M
 KrPOWCdJGKRAGwkEPow==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020155

Extend existing kprobe_multi_test subtests to validate the
kprobe.session exact function name optimization:

In kprobe_multi_session.c, add test_kprobe_syms which attaches a
kprobe.session program to an exact function name (bpf_fentry_test1)
exercising the fast syms[] path that bypasses kallsyms parsing.  It
calls session_check() so bpf_fentry_test1 is hit by both the wildcard
and exact probes, and test_session_skel_api validates
kprobe_session_result[0] == 4 (entry + return from each probe).

In test_attach_api_fails, add fail_7 and fail_8 verifying error code
consistency between the wildcard pattern path (slow, parses kallsyms)
and the exact function name path (fast, uses syms[] array).  Both
paths must return -ENOENT for non-existent functions.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 33 +++++++++++++++++--
 .../bpf/progs/kprobe_multi_session.c          | 10 ++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index f81dcd609ee9..78c974d4ea33 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -327,6 +327,30 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(saved_error, -E2BIG, "fail_6_error"))
 		goto cleanup;
 
+	/* fail_7 - non-existent wildcard pattern (slow path) */
+	LIBBPF_OPTS_RESET(opts);
+
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
+						     "__nonexistent_func_xyz_*",
+						     &opts);
+	saved_error = -errno;
+	if (!ASSERT_ERR_PTR(link, "fail_7"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -ENOENT, "fail_7_error"))
+		goto cleanup;
+
+	/* fail_8 - non-existent exact name (fast path), same error as wildcard */
+	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
+						     "__nonexistent_func_xyz_123",
+						     &opts);
+	saved_error = -errno;
+	if (!ASSERT_ERR_PTR(link, "fail_8"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -ENOENT, "fail_8_error"))
+		goto cleanup;
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
@@ -355,8 +379,13 @@ static void test_session_skel_api(void)
 	ASSERT_OK(err, "test_run");
 	ASSERT_EQ(topts.retval, 0, "test_run");
 
-	/* bpf_fentry_test1-4 trigger return probe, result is 2 */
-	for (i = 0; i < 4; i++)
+	/*
+	 * bpf_fentry_test1 is hit by both the wildcard probe and the exact
+	 * name probe (test_kprobe_syms), so entry + return fires twice: 4.
+	 * bpf_fentry_test2-4 are hit only by the wildcard probe: 2.
+	 */
+	ASSERT_EQ(skel->bss->kprobe_session_result[0], 4, "kprobe_session_result");
+	for (i = 1; i < 4; i++)
 		ASSERT_EQ(skel->bss->kprobe_session_result[i], 2, "kprobe_session_result");
 
 	/* bpf_fentry_test5-8 trigger only entry probe, result is 1 */
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
index bd8b7fb7061e..d52a65b40bbf 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
@@ -76,3 +76,13 @@ int test_kprobe(struct pt_regs *ctx)
 {
 	return session_check(ctx);
 }
+
+/*
+ * Exact function name (no wildcards) - exercises the fast syms[] path
+ * in bpf_program__attach_kprobe_multi_opts() which bypasses kallsyms parsing.
+ */
+SEC("kprobe.session/bpf_fentry_test1")
+int test_kprobe_syms(struct pt_regs *ctx)
+{
+	return session_check(ctx);
+}
-- 
2.34.1

