Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42EF41F7D4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206193; cv=none; b=gFHPfFPkAKAbG1PjwDBq2ZmJOa6BkG8/dm+PayFEs7FSgP92hC7ZP2bXWeCvFQFRX2B+HO6lwi/j/5ayBhnsQeU/wwnnzdZ7tDjocoVobOFMYuWmCVlkbwS1dBveaPfEsjAuu5LXCb27zAcxxFswsEPy6NIXSb5+0kGHOt+pN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206193; c=relaxed/simple;
	bh=oHaMkkKXj/g7xHcSySm+QrizH/y1ibzpL07oN9MFF6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ml/gfnyLTx4AvR4xtt/QAsy090AGyxC87IX1tHKV8G/dJm2dr7FquJQQsqikJMcNlTBEn7Vqcj6cxSCSSjDDkTTgurCUTdozU4HAlVEWmStGeesIqlebntbB0GORRV2fnk2du8r3h5zFmf1eRSC8gdE+nwg5H1mf2LUmSSEfgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OS/wfnVi; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OS/wfnVi"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NK436q405551;
	Wed, 23 Sep 2026 23:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=qhyH1Od7uiO7xuQnFMz2liGeh3+5RR5AjAWM9Xxi5lI=; b=OS/w
	fnVixBB7d+gsUatOb/+hTheS+/bxaf1BkTUw2ExK7v6LCXcIXPnz2g/tDIkmoluK
	Cgz0hCojlyt/E3IgHMV85f6c/sMcSA4Y3ccxnTEAbPPVrehbkqACMkEy5bkCSpwS
	3sYqMR8+MY2nCHV+err+32pgQ9EGYV6uz7JFwSbqP6DywIMXgi7GdtcQZ3YU5NIX
	0d8oXLBCBZpTTWRJXJfhB0oM5QvSsKJvEs0iAYon9vBuoVscav/IHLydVUHHnePk
	Khsk//iuTF9H4i3IRFSyUXEoKiL82KjNjiAJ3if9ZzJZ4fL+Mnt4kpNbg7cU5cW5
	IeG0kLh5LPQ75Gy85Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gv0wedf72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:46 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 7/8] selftests/bpf: Cover BPF program manual loading
Date: Wed, 23 Sep 2026 19:29:38 -0400
Message-ID: <20260923232939.1886328-8-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=eJKGH3p1 c=1 sm=1 tr=0 ts=6ab460ec cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=4y-TBdc6oaJg1_D2HkUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX6AS4jzkmATm8
 WgrBY1t9uw7hLjyjieiKH1PoQBtXYUhhPVTZTyRizx4UtcvGCbqADheU02suWQvw0/ldzvSoZtz
 7EAgm0XL98zvfRB0rQk/JVFcYac+o/mPuq1UAzdSuf6UqeiCMqIz
X-Proofpoint-GUID: rvwQrfIsOOzoTQiWJKzAQN4BIPeFsvV1
X-Proofpoint-ORIG-GUID: rvwQrfIsOOzoTQiWJKzAQN4BIPeFsvV1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfXzU60klc//zGP
 ItZylgRWGEjiXqzogUo1swp5P1LBS9ZxqR5TFsohdeMvlxEIaF16x9hVkVfvNnS8jEyX5Iyx6mU
 Kqlc7OVJYRf2XDRlDIftiDtLJ2cuXhoyKu/naq1G4bSZwZ1zySUErkPnZmADC1nD2JWevalZBvd
 wciQSNOAqdVc2mBQAP8/UCQ45Kyr7BTxzHLHbSvD9o9EZIGdJjM2OmeKeqIZZQLQqmpYzvbSUTg
 2GVjADjLLAzT/bPrf3eQCPAXoyyfrFfelEcQ3vbbOSgFgaSiUe1FKDB6wTefAfQHKefLiIdz0o8
 wRY2Gl69TAbQbCT7Q8AJcPEdE5CTr2wPs7DthfeQ/S/no8KkPD52WaDB9p6nyg5X6aoFIlMUX+M
 fzLtI7okms1NF5Xn4v03/QsvcpVNMAB4y5YJyL39rSGjJG3HB+DkbppqIAJlV3tpzCG3qk4uWGD
 l+a70yGWHmWq+6QA3fw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230095

Add dynamicload test covering the manual load/attach/detach/reload
cycle, declarative MANUAL via SEC("!...") and its imperative
override, bpf_object__prepare() alone being sufficient for manual
load, and a deferred load of a module BTF attach target. Also add
a signed_loader test verifying bpf_object__gen_loader() rejects
objects with a MANUAL program.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/dynamicload.c    | 365 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  28 ++
 .../selftests/bpf/progs/test_dynamicload.c    |  54 +++
 3 files changed, 447 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
new file mode 100644
index 000000000000..eaaa3e8bd54a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_dynamicload.skel.h"
+
+#define READ_SZ 456
+
+/*
+ * prog4 is marked SEC("!...") in the source instead of being set
+ * imperatively; verify that an explicit bpf_program__set_load_strategy() call
+ * before load overrides the declarative default.
+ */
+static void dynamicload_verify_override(void)
+{
+	struct test_dynamicload *skel;
+	int err;
+
+	skel = test_dynamicload__open();
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
+	/*
+	 * disable prog1/prog3 (also autoload by default) so this load only
+	 * has to succeed for prog2 and the disabled prog4; prog2 loading is
+	 * irrelevant to the assertion below and is left alone
+	 */
+	err = bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog1"))
+		goto cleanup;
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog3"))
+		goto cleanup;
+
+	err = test_dynamicload__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/*
+	 * prog4 was overridden to DISABLED, so its load_strategy != MANUAL
+	 * and load() must reject it
+	 */
+	err = bpf_program__load(skel->progs.prog4);
+	ASSERT_ERR(err, "load_after_override");
+
+cleanup:
+	test_dynamicload__destroy(skel);
+}
+
+/*
+ * prog4 is MANUAL via its SEC("!...") marker; verify that
+ * bpf_object__prepare() alone -- without ever calling bpf_object__load() --
+ * is sufficient for bpf_program__load() to succeed, since BTF
+ * loading, map creation, and relocation of MANUAL programs are all
+ * completed by prepare() already.
+ */
+static void dynamicload_verify_prepare_only(void)
+{
+	struct test_dynamicload *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = test_dynamicload__open();
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
+	/*
+	 * bpf_program__unload() is void now: for a MANUAL program it only
+	 * closes the fd and retains func_info/line_info/subprogs so the
+	 * program can be reloaded later.
+	 */
+	bpf_program__unload(skel->progs.prog4);
+	ASSERT_LT(bpf_program__fd(skel->progs.prog4), 0, "prog4_fd_closed_after_unload");
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_dynamicload__destroy(skel);
+}
+
+/*
+ * prog5 is disabled at parse time; resolve its attach target against
+ * module BTF via bpf_program__set_attach_target() before switching it
+ * to MANUAL and deferring its load past the bulk bpf_object__load().
+ * Regression test for the module BTF fd/array lifetime bug: without
+ * deferring the module BTF fd/array close for MANUAL programs, the fd
+ * cached in prog->attach_btf_obj_fd is closed by the bulk load's
+ * cleanup before this deferred load runs, causing a deterministic
+ * -EINVAL.
+ */
+static void dynamicload_verify_module_btf(void)
+{
+	struct test_dynamicload *skel;
+	struct bpf_link *link;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = test_dynamicload__open();
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
+	err = test_dynamicload__load(skel);
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
+	test_dynamicload__destroy(skel);
+}
+
+static void dynamicload_verify_main_cycle(void)
+{
+	struct bpf_link *link = NULL;
+	struct test_dynamicload *skel;
+	int err;
+
+	skel = test_dynamicload__open();
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
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog4), "prog4_autoattach"))
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
+	err = test_dynamicload__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_dynamicload__attach(skel);
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
+	err = bpf_program__load(skel->progs.prog1);
+	if (!ASSERT_ERR(err, "load_disabled"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__load(skel->progs.prog2);
+	if (!ASSERT_ERR(err, "load_autoload"))
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
+	/* reset the call flags */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_FALSE(skel->bss->prog1_called, "prog1_called");
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
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
+	/* detach prog3 as test_dynamicload__destroy doesn't detach manually loaded programs */
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "link_destroy"))
+		goto cleanup;
+
+	/* reset the call flags after detach */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
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
+	/* detach prog3 as test_dynamicload__destroy doesn't detach manually loaded programs */
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "link_destroy_reattach"))
+		goto cleanup;
+
+	/* reset the call flags after detach */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
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
+	test_dynamicload__destroy(skel);
+	return;
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_dynamicload__destroy(skel);
+}
+
+void test_dynamicload(void)
+{
+	if (test__start_subtest("main_cycle"))
+		dynamicload_verify_main_cycle();
+
+	if (test__start_subtest("verify_override"))
+		dynamicload_verify_override();
+
+	if (test__start_subtest("verify_prepare_only"))
+		dynamicload_verify_prepare_only();
+
+	if (test__start_subtest("verify_module_btf"))
+		dynamicload_verify_module_btf();
+}
+
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index a0f93756e717..0648816e3d50 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -2168,6 +2168,33 @@ static void signed_module_kfunc_rejected(void)
 	run_setup("cleanup", dir);
 }
 
+/*
+ * a program marked MANUAL is invisible to gen_loader's program count (it is
+ * skipped by bpf_object_load_progs()), so bpf_object__gen_loader() must
+ * reject the whole object up front instead of silently generating a
+ * skeleton whose prog_fd slots no longer line up with the object's programs
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
+	ASSERT_ERR(err, "gen_loader_rejected");
+
+cleanup:
+	test_signed_loader__destroy(skel);
+}
+
 enum subtest_boot {
 	BOOT_ANY,
 	BOOT_SEALED,
@@ -2211,6 +2238,7 @@ static const struct {
 	{ "signed_map_by_fd_rejected", signed_map_by_fd_rejected, BOOT_SEALED },
 	{ "signed_sparse_fd_array_rejected", signed_sparse_fd_array_rejected, BOOT_SEALED },
 	{ "bpf_keyring_provisioned", bpf_keyring_provisioned, BOOT_UNSEALED },
+	{ "manual_prog_rejected", manual_prog_rejected, BOOT_ANY },
 };
 
 void test_signed_loader(void)
diff --git a/tools/testing/selftests/bpf/progs/test_dynamicload.c b/tools/testing/selftests/bpf/progs/test_dynamicload.c
new file mode 100644
index 000000000000..6cdbfc21ca37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dynamicload.c
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

