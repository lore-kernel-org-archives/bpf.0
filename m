Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B35733E;
	Tue,  7 Apr 2026 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594431; cv=none; b=OeW5YCTigpIGqbng9Y0xkZNzG6XMIt6AmIcIVULzBPKeDmtgjgzhnYRNr+99jFODN6jpZO/mnruiB2Nvd5DZwRprT35Xt831IM7CT5ezb8cfrIjHFUo/i3flVKOQCylBaS4WgV1uDrIhjZMHw3ZgmdFNbJB9AMl07kIt96oLHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594431; c=relaxed/simple;
	bh=vyMq0u2rGMtvlqhSUVN3PMQzZqLQi4uPFh6854qWLHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLu61ftsXS3awhODqk9tMbeEqyAGhC8oWRbUoPrYrRGfLJiX0ux4lbwQ7JVVPxcUkoGG+0hWko2A7A6wCQikB+uN5b+YBiyVf9rqOW5nbOO5aV1Rc+PhQVVKtdirFycFVMgopgT7P9ykeKDfFx+ph3bz+9loc9hxFSC7HNv3Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=qs0DZeRk; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="qs0DZeRk"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637KGDqS3555466;
	Tue, 7 Apr 2026 20:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=sEU01usxppBkpPJ0cwFxst4UqH9nWpfzWUk0/pg3RPo=; b=qs0D
	ZeRkffVg5VlUu5dwkXuGFth4DL6owKFAkkUo7Ry9LWdpr1UQzkytfeTcstQCWhKt
	lhVo2qLyT6CsvcLGvozUyYslmAzOeyGu3WwQIb9tc6kHJjnyxf41NvFIJIDtJ5ZG
	0BZ/ZXmDOZZTHr4jf/ggBlx9W4Oz4wPREdlz1b7cGFZhOjaR+rALktIr8IgSKQsH
	VUIHpkNljL5uUUy5//8orrILIw42LSRu3WwJBvT+vXhHwmnRfjDEL+oxcoqW28Up
	BA22FBmq3WoeUTXaIk/Tr/1ezU03UZuEMr4rruamS9iPARJ49NvyDVSlNIBGyAZo
	X527yP265C0OZP+e7A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqgwhv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:39:17 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 20:39:15 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: Add tests for kprobe attachment with duplicate symbols
Date: Tue, 7 Apr 2026 16:39:12 -0400
Message-ID: <20260407203912.1787502-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
References: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OCBTYWx0ZWRfX0G0VfhGliqVw
 9EPFuqqbye0wE+3Oy9FhMIF4FygS/iAvm42mL43Pf0/FhV1ReuvAsKCf+VOBv1Ze36yqN2nNfZA
 KZwwA3H+luvGLkJY9lVZUpnN8S1r2lsR/w4Hw7ObUwH/2tRGKMIO5LksUCDYZ5rc3SFAFIW2ozl
 M4+3pmcyX6rDJo2QbR1WMsCS7wYS/bYHC1DMqtxRjLXkKy7l+xR56SmZ5GmXT2K1xhQQlQ3bFJ7
 6UdyZEYV8cwO4GKwfYrV+kK6dQgfgT1yjtyU7ybCEiEmFrwGA9dwRxlayLThtFmLey5mSBr2/aU
 4O8NLuxozyrvL2bpCOjwo+zu2KgJlEkUWLFaBKeARYOUOKIJm7grc/XnyfhJBwtXlAS1AZ83FRY
 yvHC/70RJxWy0LSNZRqPePoJdS+eXz7cpJpeiQmHib/aAAjZV1K6Fd3New8ahcSHwadrsGfF1Dk
 GtmRGJE0+71aDNvjYhQ==
X-Proofpoint-ORIG-GUID: MRESKq4OJim_uIyveiYDzC5a1qbOvzbI
X-Proofpoint-GUID: MRESKq4OJim_uIyveiYDzC5a1qbOvzbI
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=69d56b75 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=r6pRkrkL-UdkepozQqsA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070188

bpf_fentry_shadow_test exists in both vmlinux (net/bpf/test_run.c) and
bpf_testmod (bpf_testmod.c), creating a duplicate symbol condition when
bpf_testmod is loaded. Add subtests that verify kprobe behavior with
this duplicate symbol:

In attach_probe:
- dup-sym-{default,legacy,perf,link}: unqualified attach succeeds
  across all four modes, preferring vmlinux over module shadow.
- MOD:SYM qualification attaches to the module version.

In kprobe_multi_test:
- dup_sym: kprobe_multi attach with kprobe and kretprobe succeeds.

bpf_fentry_shadow_test is not invoked via test_run, so tests verify
attach and detach succeed without triggering the probe.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 69 +++++++++++++++++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 40 +++++++++++
 2 files changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 12a841afda68..e8c1a619e330 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -197,6 +197,66 @@ static void test_attach_kprobe_legacy_by_addr_reject(void)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/*
+ * bpf_fentry_shadow_test exists in both vmlinux (net/bpf/test_run.c) and
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
@@ -559,6 +619,15 @@ void test_attach_probe(void)
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
index 78c974d4ea33..20ddff6812e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -633,6 +633,44 @@ static void test_attach_write_ctx(void)
 }
 #endif
 
+/*
+ * Test kprobe_multi handles shadow symbols (vmlinux + module duplicate).
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
@@ -676,5 +714,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("dup_sym"))
+		test_attach_probe_dup_sym();
 	RUN_TESTS(kprobe_multi_verifier);
 }
-- 
2.34.1

