Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BA3E8C60;
	Fri, 27 Feb 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224884; cv=none; b=BJcvGjNcEzhvylV06KS9Hu9myTr23FsON9SeSa0N1CdMXhMWF3BgCteM4qrBbXcTmLK7x8hoWXX2jxSgRAw4j//7c8E+AhN/fheRCmrjtOY2NjlZD1uECnyXzkflKwaWB5Nxq+Ai/NfLbQwXaBm1EfP4h0pv/fK42NcPlNIoUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224884; c=relaxed/simple;
	bh=PqeSef1XKBuYkYRL23ZxtFD4mEqge36yXJhNJeImv/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZoF8TKXy0S9OiJxExVOmu+HKYwKRaRq3xcKUfZ9xY+UueR3CJoDsSpgEa7KjAaY8pMnPe57MvAXKVVMulo/yYCHVH4LNKTJrtNV+x8i0ETWRCtt86tGW2Vl+keMnf3boHatSay62V8CX11jGRTvNBxDQymFD52CAid609SuxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Y6VibbEz; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Y6VibbEz"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RJloPZ1207999;
	Fri, 27 Feb 2026 20:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=jaJi9z74+/HfDTsp2cI+woR2xun4zEMNkYzbrWyMhug=; b=Y6Vi
	bbEz/FZyZ9+r6GBp0p4eouOAAkMIVLepVuwHJPrO0NhdHu1aKtpLlJOJkpuE6xrS
	NsDcGYIO96Xt5DcKCHpVL+HwxQ63swNB0Y1896Rn7S66F3sPbOIhhWyisLdMNvZ2
	Gmg8L8W1PmrzDiIezev/QjZxisAmkTTpZm+Z1CbSIykCXbcam4h1EKTYZ7gAppwA
	fCxzlHVFlwdN7XzZA07LSdEYQhFFJ28Lggt56wWOPQmPvSuGxsX6z477yxFgw/TV
	V3WuioHvRSKWtmpn9C/7nfDMZTw0psnPKQgdDbuVfSMFKOlwsE69ljxRM+GxjXbg
	PnALiWms1CrkE/XSDQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ck3s6k348-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 20:40:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:40:56 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v3 3/3] selftests/bpf: add tests for kprobe.session optimization
Date: Fri, 27 Feb 2026 15:40:52 -0500
Message-ID: <20260227204052.725813-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: XI78iC6c7sGf8mXxSQXmjQnzyFZdilU0
X-Proofpoint-ORIG-GUID: XI78iC6c7sGf8mXxSQXmjQnzyFZdilU0
X-Authority-Analysis: v=2.4 cv=Dboaa/tW c=1 sm=1 tr=0 ts=69a20159 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=1RrSYoAmGP-V0Qkg3bQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MiBTYWx0ZWRfX5qgbePB0irw4
 jPmRMOllMOYS75E+10YmYCi2SM1y2ut7wsQ1WZgYhr5OALOsO9S7tWv5hh7FS81OR1lEbySHTui
 r0HrzhcBHYKLvJ1oJgokcLvocHSqDPf5kzjKHw20/AWvO5KHVoqJziqIALjfdwLjvmiyhxQr0+i
 z6oOSop0Pwhzhy6kr4pVOKnTfpc0a/iy14Dmy5p+bus5Z5o8L8A+psogaYo+7IiAo6O4b4yYGSN
 8mD2xR9HpqfBpJq2PPFcRU+PT9YzdOT/vNPuPzuy8qE+G01UsdHgzzAPh8t4AQx4rFdbfMzojeU
 6wRA24wIKupzbCXqj6DFYqBinuH3/HFK/taAL8odP45u+zJG37y5GpRh40oe7iyVYwWrlz5F7EI
 z3Z0pSRh3nDxwu7eY4Pjn4jY/MOBoilVzBh2y7GycQeY1D+ZpGrzAyjFnqeLloN6dAbvvLHJ6iU
 eZrFqGYZR9CR25vWuIA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270182

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

