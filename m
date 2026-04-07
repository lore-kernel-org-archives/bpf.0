Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1B3126AD;
	Tue,  7 Apr 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580731; cv=none; b=fHLOVFEK7F8eZgijqOnKbVack6CogSAVgEFT1ga+iBSlQxd75zilDZVg6KKqF3U076tfvU3f6IUmDC9dLSRZQMkQrhGEhp8p58Z78EKouq1DUmh9EtKgS9mX1g0AwsFbIqw4Lzjb4tVoNwsUWZsTmlhHbjE01osxR4L2WnBOh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580731; c=relaxed/simple;
	bh=ezBnBPLXKIxUnneEKFzMp0A1/SpDTIdE6qmBH641CeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0XKChGTXo8Wa6ayqvHeAVdvPtl3KZl8bgHvHTAoPKPA/fzIAnAQhdcjXxTeGlH4HXz0AJdnWUEY7ZowuKBAMNgwKiCG4iPCf7geI/DqI80O0vllQtWXIYNG5WGIeiAKJ1CLvlooOMv/Cjg07MvG4498uvPFyi4aMLxSHY7J/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=wGP/rt4J; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="wGP/rt4J"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637FdiKA1670846;
	Tue, 7 Apr 2026 16:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=zFGErGaXSnqJyMtPGFcF7uACsJT36t92DDg7zqtExK8=; b=wGP/
	rt4JGOyK8F2gR+FnBBsRweJRMxn7XrFRnKoMXkEAfxaMkBV1tZ4E/bpqL+HX/Tn/
	srqPETG9vlnAgnqAt236b/QTGL6I9m89zZ1TA1DonYYolNocXFUVWO2ldA3JjwFO
	H6GSAgv7eFkjblwGx6yX1ML9Lh+/8PytEfKg+h2A5o8VyRmJ6PsSmEMIsXH23tCT
	URTcim7+J9+0tA6hJeuzMx9zj4uxM4KIrRyaKHf34UjgeAbpq2mKnk/JP8f5jBgk
	mGI1JKAQSSrCUvCLgKdiBKaMqvzsymgUFITQaV82mpAri/JsjNaDdG27hgUOyQ5C
	rQ5pyVKw7KNCFVsIjA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqjm7td-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:51:51 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 16:51:49 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <jolsa@kernel.org>, <ihor.solodrai@linux.dev>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Add tests for kprobe attachment with duplicate symbols
Date: Tue, 7 Apr 2026 12:51:45 -0400
Message-ID: <20260407165145.1651061-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
References: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-GUID: llufCTckZjJtb5Pul0LN48g_tyvY25lr
X-Proofpoint-ORIG-GUID: llufCTckZjJtb5Pul0LN48g_tyvY25lr
X-Authority-Analysis: v=2.4 cv=HJfz0Itv c=1 sm=1 tr=0 ts=69d53627 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=r6pRkrkL-UdkepozQqsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1MCBTYWx0ZWRfX3To5o6kmvGon
 /wSHAsxgq5wGho5G+0fhu5JAH9oUV0QpGIN4cCMkdculaoyrG/lO7TJIKBs8bbZgbLq1H4j0k+A
 WPaSbgBrO6YWTjPhKClvvE1k3vBHvLDDZFqZvvaZ/Z3KcOguSKilMV2XNAE0a/cbOJ66IC6CuOi
 dHPP/Ljlo/YcdpQSQjmXXS2UbqS9YTUwbtAuwm6GIOT2kPKopAfDI2DbqOguPdKHkg6dx/77FYq
 kGY/oBF5/NwGDPVMRIaQG9/VptoGA9RcTmrQgav4R07CZnsWbicMWCjPM+HQFkXwto0OZxR55iN
 ffgkgpDB0iLXV40n4lNpHzwdl/enDQ0nhgGE6t9THVrNaASDFp9UB6NkDae4fmzQCjKbUWZvG8J
 ASTabXtd2AwlQpasrjkJ1bL2V9VGSowgsPgMxiRpHYMX9ajQnwBoSsvTTmUEcHrFEaRH3HquBIn
 Jj9yc55gOTxmxc43/VA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070150

bpf_fentry_shadow_test exists in both vmlinux (net/bpf/test_run.c) and
bpf_testmod (bpf_testmod.c), creating a duplicate symbol condition when
bpf_testmod is loaded. Add subtests that verify kprobe behavior with
this duplicate symbol:

In attach_probe:
- dup-sym-{default,legacy,perf,link}: unqualified attach succeeds
  across all four modes, preferring vmlinux over module shadow.
- dup-sym-module-{default,legacy,perf,link}: MOD:SYM qualification
  (bpf_testmod:bpf_fentry_shadow_test) attaches to the module version.

In kprobe_multi_test:
- dup_sym: kprobe_multi attach with kprobe and kretprobe succeeds.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 68 +++++++++++++++++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 39 +++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 12a841afda68..2d52547c395e 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -197,6 +197,65 @@ static void test_attach_kprobe_legacy_by_addr_reject(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* bpf_fentry_shadow_test exists in both vmlinux (net/bpf/test_run.c) and
+ * bpf_testmod (bpf_testmod.c). When bpf_testmod is loaded the symbol is
+ * duplicated. Test that kprobe attachment handles this correctly:
+ * - Unqualified name ("bpf_fentry_shadow_test") attaches to vmlinux.
+ * - MOD:SYM name ("bpf_testmod:bpf_fentry_shadow_test") attaches to module.
+ *
+ * Note: bpf_fentry_shadow_test is not invoked via test_run, so we only
+ * verify that attach and detach succeed without triggering the probe.
+ */
+static void test_attach_probe_dup_sym(enum probe_attach_mode attach_mode)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct bpf_link *kprobe_link, *kretprobe_link;
+	struct test_attach_probe_manual *skel;
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_dup_sym_open_and_load"))
+		return;
+
+	kprobe_opts.attach_mode = attach_mode;
+
+	/* Unqualified: should attach to vmlinux symbol */
+	kprobe_opts.retprobe = false;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      "bpf_fentry_shadow_test",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_vmlinux"))
+		goto cleanup;
+	bpf_link__destroy(kprobe_link);
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 "bpf_fentry_shadow_test",
+							 &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_vmlinux"))
+		goto cleanup;
+	bpf_link__destroy(kretprobe_link);
+
+	/* MOD:SYM qualified: should attach to module symbol */
+	kprobe_opts.retprobe = false;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      "bpf_testmod:bpf_fentry_shadow_test",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_module"))
+		goto cleanup;
+	bpf_link__destroy(kprobe_link);
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 "bpf_testmod:bpf_fentry_shadow_test",
+							 &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_module"))
+		goto cleanup;
+	bpf_link__destroy(kretprobe_link);
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+}
+
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -559,6 +618,15 @@ void test_attach_probe(void)
 	if (test__start_subtest("kprobe-legacy-by-addr-reject"))
 		test_attach_kprobe_legacy_by_addr_reject();
 
+	if (test__start_subtest("dup-sym-default"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_DEFAULT);
+	if (test__start_subtest("dup-sym-legacy"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LEGACY);
+	if (test__start_subtest("dup-sym-perf"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_PERF);
+	if (test__start_subtest("dup-sym-link"))
+		test_attach_probe_dup_sym(PROBE_ATTACH_MODE_LINK);
+
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
 	if (test__start_subtest("kprobe-sleepable"))
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..d89650e31fd3 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -633,6 +633,43 @@ static void test_attach_write_ctx(void)
 }
 #endif
 
+/* Test kprobe_multi handles shadow symbols (vmlinux + module duplicate).
+ * bpf_fentry_shadow_test exists in both vmlinux and bpf_testmod.
+ * kprobe_multi resolves via ftrace_lookup_symbols() which finds the
+ * vmlinux symbol first and stops, so this should always succeed.
+ */
+static void test_attach_probe_dup_sym(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *syms[1] = { "bpf_fentry_shadow_test" };
+	struct kprobe_multi *skel = NULL;
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+
+	skel = kprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+	opts.syms = syms;
+	opts.cnt = ARRAY_SIZE(syms);
+
+	link1 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
+						      NULL, &opts);
+	if (!ASSERT_OK_PTR(link1, "attach_kprobe_multi_dup_sym"))
+		goto cleanup;
+
+	opts.retprobe = true;
+	link2 = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kretprobe_manual,
+						      NULL, &opts);
+	if (!ASSERT_OK_PTR(link2, "attach_kretprobe_multi_dup_sym"))
+		goto cleanup;
+
+cleanup:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+	kprobe_multi__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -676,5 +713,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("dup_sym"))
+		test_attach_probe_dup_sym();
 	RUN_TESTS(kprobe_multi_verifier);
 }
-- 
2.34.1

