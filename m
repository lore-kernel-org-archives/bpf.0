Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEE2E7369
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644148; cv=none; b=IlQv2hppBQdZTWXn1MzkqM6pZkeyeygMs+c/qZpL+gUXbFE62yc0DWT9dmvWjS/WICcPK5uByLEFpC8JQhJMF5f7hsFXwJ9/cmenK36yryAiJOVbgLUBwfQCoj1uYSh9fuBYvJr1Cy7vjH/y0u2U7L1R4JU/EbyztyrAveCsymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644148; c=relaxed/simple;
	bh=BHB3B51+rXw5/tBw/d8ym0nDhmVNyxpDg66GLey4QkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ8m+Cgi8XsOg3bL68Y2L5//Y+5RjCXyVFVX3mjFztWf5doPWVvTbwYmtOUOLI1K92fJbqOOajUTlxQ9VQjNxFhBbUvO7ZunUmJX1uYWDBG/j0+HdNciPCqWLkzc2burRAAZKd5a8VpNqwYhb5mdSh2CityyjbVb2SgA8D1pPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=i/8EBP4M; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="i/8EBP4M"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKhaM1828981;
	Sat, 10 Oct 2026 14:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=v3DHcKvNhtB0S49xVB6HA7tVagBKeVN5x6dBRdFWJWA=; b=i/8E
	BP4MDoKTPrTMl6tI+V2PxWf+gfjZHx60KJmWUAMCuZ8yYEBG/RQB7ReAXnmiwCef
	bQ+O2YoFaWeRyoKyE1CmH0zX8bFFPJMeiQFcd3R+k9G1IaFre+2D3rjQr4a6sy7k
	uReY9vnyhYJcBbPu5iLg9RqTeNLZeCeIjv+RX8j14S+MjuOlDXWdZKNrULGYEaz6
	XHbvnUTwZiszXlooejF/NHPuecSbew1x3UapjGJAloJltLOLVknHflEQ6xX0beqE
	sTkOD/zwTzFRvbmTcqgsUgIIX3A7xtUKwanChlalqCbU+w4rIIivE40iEptsP2tf
	deRdc/Zglm5nO5jPbg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74uhanbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:04 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:32:03 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 6/7] selftests/bpf: Cover BPF program manual loading
Date: Sat, 10 Oct 2026 10:31:55 -0400
Message-ID: <20261010143156.379864-7-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX+7/iPGA6FGcM
 DgOudtfqZ4dJUWK3CXTNzW3AZRcKwyJWtt0p71U5gKKmE0Ue4z/NmOeYNDAQzfY1O0ahaEX1npn
 lzzXd4kTNjwJ+xfRKAPdFeyxJrAiXJjk5Sqla+YxWZjxqlRgDV1iQfMwj3nLdKL4EsP4c0OxtDd
 4Wby2oSWj0hk3etWSrkX2dJHdCXSKNQKF68pICxe4NSYoVw/DtBbpCrlF0D2SKeXmW1C392rGlN
 rYBxL1tma8srWIHlWXyS1GpR5N6iFGNTbztzFv3jNFFwE4PmgHFoLTCsyimCtl2hxEB1lt68JMI
 JrIhY5TxzUWvaesnSbo2aAm3FLebL6kNkx6vadP9H/hOnfW3lMzu9mxjTZiWhlhVUh1ISyfoWW+
 PAeuvu21nzCmB23X0ULHd+JWvOVUx6E2fwVDEYsPDaTsOm8ZcgrsF7y2nbUAOZW0wmbOzQHb51o
 uY8+UPXWFrr/C00NsSw==
X-Proofpoint-GUID: 7H__gMXD5uOgBT-fKzVBwNdSOH3Rbp9j
X-Authority-Analysis: v=2.4 cv=DOcacCNb c=1 sm=1 tr=0 ts=6aca4c64 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=b8NVzrSy56oiLsuFWlwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX6dKlkaX8aaz+
 d2AKVehQJDhiE02eMCtKElAdwMI9eQgDM7jWTHu8TW/n2CzVWvYJfP2dlaXiEZpZuTTD8395kaN
 ETrmG8ogFRqHC3C60heIH3oMBF7E5ZXyVBGcCXN37LiYCas9tooN
X-Proofpoint-ORIG-GUID: 7H__gMXD5uOgBT-fKzVBwNdSOH3Rbp9j
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100057

Add manual load test covering the manual load/attach/detach/reload
cycle, declarative MANUAL via SEC("!...") and its imperative
override, bpf_object__prepare() alone being sufficient for manual
load, and a deferred load of a module BTF attach target.

Also add a signed_loader test verifying bpf_object__load() fails
with gen loader object and a MANUAL program.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/manual_load.c    | 336 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../selftests/bpf/progs/test_manual_load.c    |  54 +++
 3 files changed, 422 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

diff --git a/tools/testing/selftests/bpf/prog_tests/manual_load.c b/tools/testing/selftests/bpf/prog_tests/manual_load.c
new file mode 100644
index 000000000000..e5bdf7e0f04e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/manual_load.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_manual_load.skel.h"
+
+#define READ_SZ 456
+
+/*
+ * prog4 is marked SEC("!...") in the source instead of being set
+ * imperatively; verify that an explicit bpf_program__set_load_strategy() call
+ * before load overrides the declarative default.
+ */
+static void manual_load_verify_override(void)
+{
+	struct test_manual_load *skel;
+	int err;
+
+	skel = test_manual_load__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog4, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog4),
+		       BPF_PROG_LOAD_STRATEGY_DISABLED, "prog4_load_strategy_overridden"))
+		goto cleanup;
+
+	err = test_manual_load__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/*
+	 * prog4 was overridden to DISABLED, so its load_strategy != MANUAL
+	 * and load() must reject it
+	 */
+	if (!ASSERT_EQ(bpf_program__fd(skel->progs.prog4), -ENOENT, "prog4_not_loaded"))
+		goto cleanup;
+
+	err = bpf_program__load(skel->progs.prog4);
+	ASSERT_EQ(err, -EINVAL, "load_after_override");
+
+cleanup:
+	test_manual_load__destroy(skel);
+}
+
+/*
+ * prog4 is MANUAL via its SEC("!...") marker; verify that
+ * bpf_object__prepare() alone -- without ever calling bpf_object__load() --
+ * is sufficient for bpf_program__load() to succeed, since BTF
+ * loading, map creation, and relocation of MANUAL programs are all
+ * completed by prepare() already.
+ */
+static void manual_load_verify_prepare_only(void)
+{
+	struct test_manual_load *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = test_manual_load__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "bpf_object__prepare"))
+		goto cleanup;
+
+	err = bpf_program__load(skel->progs.prog4);
+	if (!ASSERT_OK(err, "load_after_prepare"))
+		goto cleanup;
+
+	if (!ASSERT_GE(bpf_program__fd(skel->progs.prog4), 0, "prog4_fd_after_prepare"))
+		goto cleanup;
+
+	link = bpf_program__attach(skel->progs.prog4);
+	if (!ASSERT_OK_PTR(link, "attach_after_prepare"))
+		goto cleanup;
+
+	usleep(1);
+
+	if (!ASSERT_TRUE(skel->bss->prog4_called, "prog4_called_after_prepare"))
+		goto cleanup;
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "link_destroy_after_prepare"))
+		goto cleanup;
+
+	bpf_program__unload(skel->progs.prog4);
+	ASSERT_LT(bpf_program__fd(skel->progs.prog4), 0, "prog4_fd_closed_after_unload");
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_manual_load__destroy(skel);
+}
+
+/*
+ * prog5 is disabled at parse time; resolve its attach target against
+ * module BTF via bpf_program__set_attach_target() before switching it
+ * to MANUAL and deferring its load past the bulk bpf_object__load().
+ * Regression test for the module BTF fd/array lifetime.
+ */
+static void manual_load_verify_module_btf(void)
+{
+	struct test_manual_load *skel;
+	struct bpf_link *link;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = test_manual_load__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_program__set_attach_target(skel->progs.prog5, 0,
+					     "bpf_testmod:bpf_testmod_test_read");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog5, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual"))
+		goto cleanup;
+
+	/* keep the other autoload programs out of the way of this load */
+	bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+
+	/*
+	 * bulk load: prog5 itself is skipped (MANUAL), but this is where
+	 * module BTF gets torn down if not correctly deferred
+	 */
+	err = test_manual_load__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/*
+	 * deferred load must still succeed: the module BTF fd cached above
+	 * by set_attach_target() must still be a valid, open fd here
+	 */
+	err = bpf_program__load(skel->progs.prog5);
+	if (!ASSERT_OK(err, "load_module_btf"))
+		goto cleanup;
+
+	link = bpf_program__attach(skel->progs.prog5);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto cleanup;
+
+	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
+	ASSERT_EQ(skel->bss->prog5_sz, READ_SZ, "prog5_sz");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	test_manual_load__destroy(skel);
+}
+
+static void manual_load_verify_main_cycle(void)
+{
+	struct bpf_link *link = NULL;
+	struct test_manual_load *skel;
+	int err;
+
+	skel = test_manual_load__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/*
+	 * the SEC("!...") prefix alone, with no imperative call, must set
+	 * prog4's load strategy before it is ever touched below
+	 */
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog4),
+		       BPF_PROG_LOAD_STRATEGY_MANUAL, "prog4_prefix_load_strategy"))
+		goto cleanup;
+
+	/* don't load prog1 */
+	bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+
+	/* prog2 is autoload */
+	bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEGY_AUTO);
+
+	/* prog3 is manually loaded */
+	bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+
+	err = test_manual_load__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_manual_load__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger the BPF programs */
+	usleep(1);
+
+	ASSERT_FALSE(skel->bss->prog1_called, "prog1_called");
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+	ASSERT_FALSE(skel->bss->prog4_called, "prog4_called");
+
+	/* prog1 is disabled for load */
+	if (!ASSERT_EQ(bpf_program__fd(skel->progs.prog1), -ENOENT, "prog1_not_loaded"))
+		goto cleanup;
+
+	err = bpf_program__load(skel->progs.prog1);
+	if (!ASSERT_EQ(err, -EINVAL, "load_disabled"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__load(skel->progs.prog2);
+	if (!ASSERT_EQ(err, -EINVAL, "load_autoload"))
+		goto cleanup;
+
+	/*
+	 * bpf_program__unload() no longer rejects based on load strategy:
+	 * calling it on prog2 (AUTO, currently loaded and attached) performs
+	 * a full, irreversible unload instead of returning an error
+	 */
+	bpf_program__unload(skel->progs.prog2);
+	ASSERT_LT(bpf_program__fd(skel->progs.prog2), 0, "prog2_fd_closed_after_unload");
+
+	/* load prog3 */
+	err = bpf_program__load(skel->progs.prog3);
+	if (!ASSERT_OK(err, "load"))
+		goto cleanup;
+
+	/* attach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called"))
+		goto cleanup;
+
+	/*
+	 * detach prog3 explicitly: its link is kept in a local variable, not in
+	 * skel->links, so test_manual_load__destroy() has nothing to detach
+	 */
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "link_destroy"))
+		goto cleanup;
+
+	/* reset the call flag after detach */
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+
+	/* unload prog3; MANUAL strategy means its data is retained for reload */
+	bpf_program__unload(skel->progs.prog3);
+
+	/* reload prog3 */
+	err = bpf_program__load(skel->progs.prog3);
+	if (!ASSERT_OK(err, "load_reload"))
+		goto cleanup;
+
+	/* reattach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (!ASSERT_OK_PTR(link, "reattach"))
+		goto cleanup;
+
+	usleep(1);
+
+	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_reattach"))
+		goto cleanup;
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "link_destroy_reattach"))
+		goto cleanup;
+
+	/* reset the call flag after detach */
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+
+	/*
+	 * run prog4 (declaratively marked) through the same manual
+	 * load/attach/trigger/detach/unload cycle as prog3
+	 */
+	err = bpf_program__load(skel->progs.prog4);
+	if (!ASSERT_OK(err, "prog4_load"))
+		goto cleanup;
+
+	link = bpf_program__attach(skel->progs.prog4);
+	if (!ASSERT_OK_PTR(link, "prog4_attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	if (!ASSERT_TRUE(skel->bss->prog4_called, "prog4_called"))
+		goto cleanup;
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "prog4_link_destroy"))
+		goto cleanup;
+
+	bpf_program__unload(skel->progs.prog4);
+
+	test_manual_load__destroy(skel);
+	return;
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_manual_load__destroy(skel);
+}
+
+void test_manual_load(void)
+{
+	if (test__start_subtest("main_cycle"))
+		manual_load_verify_main_cycle();
+
+	if (test__start_subtest("verify_override"))
+		manual_load_verify_override();
+
+	if (test__start_subtest("verify_prepare_only"))
+		manual_load_verify_prepare_only();
+
+	if (test__start_subtest("verify_module_btf"))
+		manual_load_verify_module_btf();
+}
+
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index a0f93756e717..0fbaa2d60aaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -2168,6 +2168,37 @@ static void signed_module_kfunc_rejected(void)
 	run_setup("cleanup", dir);
 }
 
+/*
+ * gen_loader only records programs loaded by bpf_object__load_progs(), which
+ * skips MANUAL ones, so an object with a MANUAL program must fail to load
+ * instead of generating a skeleton whose prog_fd slots no longer line up
+ * with the object's programs
+ */
+static void manual_prog_rejected(void)
+{
+	LIBBPF_OPTS(gen_loader_opts, gopts, .gen_hash = true);
+	struct test_signed_loader *skel;
+	int err;
+
+	skel = test_signed_loader__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_program__set_load_strategy(skel->progs.probe, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual"))
+		goto cleanup;
+
+	err = bpf_object__gen_loader(skel->obj, &gopts);
+	if (!ASSERT_OK(err, "gen_loader"))
+		goto cleanup;
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_EQ(err, -EOPNOTSUPP, "load_rejected");
+
+cleanup:
+	test_signed_loader__destroy(skel);
+}
+
 enum subtest_boot {
 	BOOT_ANY,
 	BOOT_SEALED,
@@ -2211,6 +2242,7 @@ static const struct {
 	{ "signed_map_by_fd_rejected", signed_map_by_fd_rejected, BOOT_SEALED },
 	{ "signed_sparse_fd_array_rejected", signed_sparse_fd_array_rejected, BOOT_SEALED },
 	{ "bpf_keyring_provisioned", bpf_keyring_provisioned, BOOT_UNSEALED },
+	{ "manual_prog_rejected", manual_prog_rejected, BOOT_ANY },
 };
 
 void test_signed_loader(void)
diff --git a/tools/testing/selftests/bpf/progs/test_manual_load.c b/tools/testing/selftests/bpf/progs/test_manual_load.c
new file mode 100644
index 000000000000..6cdbfc21ca37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_manual_load.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+bool prog3_called = false;
+bool prog4_called = false;
+__u32 prog5_sz = 0;
+
+SEC("raw_tp/sys_enter")
+int prog1(const void *ctx)
+{
+	prog1_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog2(const void *ctx)
+{
+	prog2_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog3(const void *ctx)
+{
+	prog3_called = true;
+	return 0;
+}
+
+SEC("!raw_tp/sys_enter")
+int prog4(const void *ctx)
+{
+	prog4_called = true;
+	return 0;
+}
+
+/*
+ * disabled at parse time; its attach target is resolved against module
+ * BTF via bpf_program__set_attach_target() before it is switched to
+ * MANUAL and loaded
+ */
+SEC("?fentry")
+int BPF_PROG(prog5, struct file *file, struct kobject *kobj,
+	     const struct bin_attribute *bin_attr, char *buf, loff_t off, size_t len)
+{
+	prog5_sz = len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

