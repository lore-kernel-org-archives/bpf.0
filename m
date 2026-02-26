Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2D3290D0;
	Thu, 26 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127244; cv=none; b=UJU5VP/wObItjUVRskHr2b5ZXRsqV93DnVf3RNDdELZ+1CH15XrTpNUnBKYmsTnsfzT7jOE5nj2kCDhR5fx5ZKx3u4f7kP8D0i/Wovs5Qylb6CEfrdMmiOb3aB+O5lK5JkXetZb+QiZaiz8Phrd7BMff8I2+suQ1tmWvyEqbzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127244; c=relaxed/simple;
	bh=XVlAj3LMdPWSbE+/WCYsSPdM5sDOQoQoUfzmhRFddzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lo82OFnPUonynOzV2J88Mh9iyW9+NKLipJyT43SiVLSnbaPbTRK1mlqM+JPnPzWTkFqjlCXkql4F1p0rScNGNM/SC+djQ1SJMJuYHHa1jtu1XbN2mijrjy6082G/U7L6OUlmsfc2CwcphhBGuSKqKLI1uLe1JuwV59WFu7vlar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=F4ZbrkEu; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="F4ZbrkEu"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QH1UUD1526465;
	Thu, 26 Feb 2026 17:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=qr67bv4C5wOIS+18aBAfOEWaXysTLF86jVir/HImpp8=; b=F4Zb
	rkEuADoOT9J7RqeVZnQNM35ULouoA0vdylK75Owu313M2NSblY3FXedeQP7q+hqW
	fqF8sXCa6wX/5hYJyB0Sxd+GiAy0nEJvnGCwwxKsPDUAGAyTXdmUOT6d1ZOq5z/r
	CuDD6z1pefPGFjkfljxe9XOSN78Gnmw8Fn4vHS3t/s+X7v6pcFFC39OFnJIDUbIi
	RDNlfG0nKZyEuyAsGy8hD3mfG1cGqVR+OePShUI3Sz8oz6nhawYIuXnys61zeXpf
	Xm7Lxu/veXb5af6ndQVYTykWYtYTn4EFyxGQvFdRE73Px1yo5vM59XUnRb9XB2tB
	jyEWMb7ePmjTLXF3zw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chjkkh1qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:33:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 26 Feb 2026 17:33:46 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v2 3/3] selftests/bpf: add tests for kprobe.session optimization
Date: Thu, 26 Feb 2026 12:33:42 -0500
Message-ID: <20260226173342.3565919-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
References: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=dYaNHHXe c=1 sm=1 tr=0 ts=69a083fc cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=1RrSYoAmGP-V0Qkg3bQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1OCBTYWx0ZWRfX2Vwi7zJuINFV
 rs7+xgAo0Iu7ddL7iwO0uOBUQu015eEpFFpsl8Oc3PxsywOati3CYFucPtlPNhStkpn2k0Cm3tm
 zbDxiS1AiwPg4CQp2iwpz/ibtkuMfs3OHsR8LEanHmD5Q/2Ga/o3UWxxHNT3s4egedDdVtyFNy4
 SwVjZCPjiwyMKrLHC0p1Z2LsLiw3tqymlBxPy64767VtiRtSUadLDISKJ07ylFJVHxNTS9Lm+vH
 0eqBFzPBvKt3vXVI1Svy6ta8uaHLrH0d3W05lbIYmvdz4f1kFvAVpsTWw5jwcGNQ3DZ2biogz30
 6dN39dPCQrW5x5esPeKY9B/jkNm9Z5vTQDQVx4G43Z6+bNXm7DLIJ3KhyAmq6NlGlx7NIEkQ1Ol
 laUVeJZpJMpiX/QOv4837nyXe5NwIV7h4genXhbhoXzoU+ndCQF6t7mvWdl3JgRCUTaqP6nk5hd
 BR8Y2TI0d5vM/ID0YQg==
X-Proofpoint-ORIG-GUID: RA64i6SxA_Or5dHP6Qgmia7Gp4QBBWzM
X-Proofpoint-GUID: RA64i6SxA_Or5dHP6Qgmia7Gp4QBBWzM
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260158

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
index 9caef222e528..ea605245ba14 100644
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

