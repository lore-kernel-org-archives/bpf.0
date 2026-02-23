Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF63793CC;
	Mon, 23 Feb 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883495; cv=none; b=pL2ykPTCbv+b0PjOSydPZaCiMDQ5hJ30a1ESM9ZxIl0cvguCT/nI45hEa8HOnDzODBMlsiONEeYovBNEzQnW+enFdoaTfec21E5G4yACnQOOHLiR3yDtoM7H9J0oUtmSYm50173/nj3TzY43aAEXP9nJEdodUg+hkrRwJSHfAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883495; c=relaxed/simple;
	bh=luLybBIllBJeKI/2gPUmQFHEwPWnxVPVcj5gEcxK9dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vrp1Z6cpB4+ljQ26HMTcFV+brsMm651USu+1QR2ed7pdZYXrxZQTvDijh+hKw9gBMd+kqjd8zNijbxUlakkYO8wySkzr+nHB+DX1bwNq16/A5gChY0QyBflKhhX6p5PoeFKy7UV/6Bm2ltIN/b3CD7lAU9Kbooe0egkCXT0HVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=sztM1+0l; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="sztM1+0l"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJYa64853227;
	Mon, 23 Feb 2026 21:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=jmf0tOk7r6iw1oIhlYqvclh71A0XSJPpTJBlirPgU98=; b=sztM
	1+0lsdpCu69XD+9PSk6GZOsbOuMEfWTAQvFQXiPpPPyizCfte+WOXQIPgp+EXLaw
	M/yrXe+lSZyVYXQppb1NhJMUkClVrprJcPnIv/d475Z9TRQEHJpJauLKN4NMlXNU
	9ilzcF18xyaAhzMFOiQLwiNWcDYBKqGioEBHawLR79Ow5c9AW+jm/VdAHpPRc6nm
	SjWzughAOVf7YGF5h1H0EWyhBc3XKL8reooLWFg/9gnXFyk1zZ3seZIId/2MbKXk
	mE2RGmjgLr46LXN30zbKTEp2AKQsFzZ5/880jQTEGk2PkWqLNxiCvFNk+zoUbqmD
	AmODVCVkBN/FemSulA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cfqxwf4q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 21:51:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 21:51:17 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: add tests for kprobe.session optimization
Date: Mon, 23 Feb 2026 16:51:13 -0500
Message-ID: <20260223215113.924599-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: tJGj19SoycN4_Gl1197yKo4YLG1K0ISO
X-Authority-Analysis: v=2.4 cv=TJhIilla c=1 sm=1 tr=0 ts=699ccbd7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=sePHRR2GmHM8PN9yvpMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5MCBTYWx0ZWRfX4nWRzke/SG3Q
 5+Bs9empDqL9iB1Qdds8y6zHYRrO/M2/rDO+fxnOpayABtz+jaldjW8bYsofKe6MaxPNGPtVmQv
 NdKWBol8wASCeD+fwZhSEdziIvwT7VpfrUtY7c77s7aZJo3fFLUeB/FQ9aqKO+HsMUeIFK6vgzS
 LRN3qtb2HxJtfD4tXS+Zjlfb9s0426EutMtYhH9+Bm8OLgnbgyGyHlfEq+LOJp8jEylhv1xVdc+
 TgXMrpTgT9dIypcZQn1kbMCiDXQ0R7wkh9Wy6bgTZujoycKU1rj7tKX44rXdHcB3Qqw+IblqUxw
 vvKQ+3U90RO+l7TG7sR0c8qgzzkjpp3GwDRtPWrKn1C3Se5jv0SCTtNEfTFiUYV+++Os/O3t0Na
 k+Lo79vQM07JjKU3HbFEycrq6+DUWxyQIUvoqzr0jdJOZzWANt5K3LG2m8R0bVnxdfsGsA8X7ZB
 5PEDzj9Dv3+8jJiAAGQ==
X-Proofpoint-GUID: tJGj19SoycN4_Gl1197yKo4YLG1K0ISO
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230190

Add two new subtests to kprobe_multi_test to validate the
kprobe.session exact function name optimization:

test_session_syms: Attaches a kprobe.session program to an exact
function name (bpf_fentry_test1) to verify the fast syms[] path
works correctly.  Validates that both entry and return probes fire.

test_session_errors: Verifies error code consistency between the
wildcard pattern path (slow, parses kallsyms) and the exact function
name path (fast, uses syms[] array).  Both paths must return -ENOENT
for non-existent functions, protecting against future changes that
could break API consistency.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 76 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_errors.c   | 27 +++++++
 .../bpf/progs/kprobe_multi_session_syms.c     | 45 +++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_errors.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 9caef222e528..62f7959858a9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -8,6 +8,8 @@
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
+#include "kprobe_multi_session_syms.skel.h"
+#include "kprobe_multi_session_errors.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
 #include "bpf/libbpf_internal.h"
@@ -400,6 +402,76 @@ static void test_session_cookie_skel_api(void)
 	kprobe_multi_session_cookie__destroy(skel);
 }
 
+static void test_session_syms_skel_api(void)
+{
+	struct kprobe_multi_session_syms *skel = NULL;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	skel = kprobe_multi_session_syms__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session_syms__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = kprobe_multi_session_syms__attach(skel);
+	if (!ASSERT_OK(err, "kprobe_multi_session_syms__attach"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	/* Test 1: Both entry and return should fire */
+	ASSERT_EQ(skel->bss->test1_count, 2, "test1_count");
+	ASSERT_TRUE(skel->bss->test1_return, "test1_return");
+
+cleanup:
+	kprobe_multi_session_syms__destroy(skel);
+}
+
+static void test_session_errors(void)
+{
+	struct kprobe_multi_session_errors *skel = NULL;
+	struct bpf_link *link_wildcard = NULL;
+	struct bpf_link *link_exact = NULL;
+	int err_wildcard, err_exact;
+
+	skel = kprobe_multi_session_errors__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_session_errors__open_and_load"))
+		return;
+
+	/*
+	 * Test error code consistency: both wildcard (slow path) and exact name
+	 * (fast path) should return the same error code (ENOENT) for non-existent
+	 * functions. This protects against future kernel changes that might alter
+	 * error return values.
+	 */
+
+	/* Try to attach with non-existent wildcard pattern (slow path) */
+	link_wildcard = bpf_program__attach(skel->progs.test_nonexistent_wildcard);
+	err_wildcard = -errno;
+	ASSERT_ERR_PTR(link_wildcard, "attach_nonexistent_wildcard");
+	ASSERT_EQ(err_wildcard, -ENOENT, "wildcard_error_enoent");
+
+	/* Try to attach with non-existent exact name (fast path) */
+	link_exact = bpf_program__attach(skel->progs.test_nonexistent_exact);
+	err_exact = -errno;
+	ASSERT_ERR_PTR(link_exact, "attach_nonexistent_exact");
+	ASSERT_EQ(err_exact, -ENOENT, "exact_error_enoent");
+
+	/*
+	 * Verify both paths return identical error codes - this is critical for
+	 * API consistency and prevents user code from breaking when switching
+	 * between wildcard patterns and exact function names.
+	 */
+	ASSERT_EQ(err_wildcard, err_exact, "error_consistency");
+
+	kprobe_multi_session_errors__destroy(skel);
+}
+
 static void test_unique_match(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
@@ -645,6 +717,10 @@ void test_kprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
+	if (test__start_subtest("session_syms"))
+		test_session_syms_skel_api();
+	if (test__start_subtest("session_errors"))
+		test_session_errors();
 	if (test__start_subtest("unique_match"))
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_errors.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_errors.c
new file mode 100644
index 000000000000..749d43b35bc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_errors.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Test error code consistency between fast and slow paths for non-existent functions */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Test 1: Non-existent wildcard pattern (slow path)
+ * This uses pattern matching with kallsyms parsing and should fail with ENOENT
+ */
+SEC("kprobe.session/__impossible_test_func_xyz_wildcard_*")
+int test_nonexistent_wildcard(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+/*
+ * Test 2: Non-existent exact function name (fast path)
+ * This uses syms[] array and should fail with ENOENT (normalized from ESRCH)
+ */
+SEC("kprobe.session/__impossible_test_func_xyz_exact_123")
+int test_nonexistent_exact(struct pt_regs *ctx)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c
new file mode 100644
index 000000000000..6a4bd57af1fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Test kprobe.session with exact function names to verify syms[] optimization */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+/* Results for each function: incremented on entry and return */
+__u64 test1_count = 0;
+
+/* Track entry vs return */
+bool test1_return = false;
+
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+	return 0;
+}
+
+/*
+ * Test 1: Exact function name (no wildcards) - uses fast syms[] path
+ * This should attach via opts.syms array, bypassing kallsyms parsing
+ */
+SEC("kprobe.session/bpf_fentry_test1")
+int test_kprobe_syms_1(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	test1_count++;
+
+	/* Check if this is return probe */
+	if (bpf_session_is_return(ctx))
+		test1_return = true;
+
+	return 0;  /* Always execute return probe */
+}
-- 
2.34.1

