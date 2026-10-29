Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313246;
	b=2Rd2nZ+fterVy7LljOqb7mzUoQvJVtTz4oukaJmJKUxUiM1eB3gEzIaNqbP6Dx4mQw5H
	 jS7DG/sQSUqxK5N2n902jtIlwMn7hDX+LowQ/CKH3HOW/QS/6RWUO5ZJIupdsenx8uULM
	 JK/MoSojATkFnD4sH9VtW3SjdSRntiyfFS3wxwyrOUSeo5hjyHIO+M4HO3Mi10yVCHSdR
	 rw1haYq3zrSCydAZmgXezPpZ5DEjOa2qzHRDJU7VHBdBsQumVflYwbt6IdnkHQRDtUFI9
	 eqTJO/ud4sx6WUNenwKKZKGlYZdLcUh1UIR12On+ZeWE82u5xFat1WXRm9yGuRexfQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+g+Rpi3VVk62AOMGZDROosj+5L0jULEmR+Xyk6HJdtA=;
	b=vaIEmTdrz0kOJv7UJ72k3wvrE6LQbLu7ADkdgaxXUq7jByB6ounou5N3pvMtpvQVqKbv
	 0RijxoldRJR7HZLJ4DRdG2nQh/7H0L3XM+h67sNwVSkjyce6HevyBLPSrGuNN/hZMm2da
	 eRTkZw2JrOOYkSpRGRDKUkrOVNe0TzEGfjvZUKda9X2yhkNddJbTGpKbouv6vTyI1X6Ys
	 2BG8VYWgyfjZMY5KS/6jZNWGLQ2Iz5K6Y0PxHRb2YWV/qWCcF9JcAmHzGVzq2x5uIA0Py
	 KvQSbi4uOkTZJq2kc9zAlYWaEtwdPRQL045eWHBa+TKFssOwG0yiyOT8jZ/mLW3qIGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Afim9DSB;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7752606A327
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7752606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Afim9DSB
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXDcZ2715473;
	Thu, 29 Oct 2026 22:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=+g+Rpi3VVk62AOMGZDROosj+5L0jULEmR+Xyk6HJdtA=; b=Afim
	9DSBRWikiiRZoxJ5oU6iQVLbSd5lIqyx3Z6rAJIJaDBztKYjUpX+jEltG6EjiiKk
	Z4KweeeOn24neC0pry2p+Cml0J/mFN6aXGbBYxJbv/kBfpOs/3HLJ58oZRXBq9hY
	C/bigEJIBV9UjG7eFDj+hGu3snP3vfpTmngfbRkQ5W89MUrsojKcBvDTi8JmDEbw
	bkAmuEj/SPP2jq9hiDMXFyw5AJOzg1A3X9tn6X/FN0Rbpiv1b2CstfCUhF2QAHP7
	2aQuiwUqNP/A8V6K7dUum7nStB921cje4YmFsizQD7F6RqjSqcsBpjvgn6Jzs43n
	97PfwKz/sXcWYZP1pg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n85he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:55 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 6/7] selftests/bpf: Cover BPF program load strategies and manual loading
Date: Thu, 29 Oct 2026 18:33:47 -0400
Message-ID: <20261029223348.3730738-7-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: aAS_c27jEoZLzFfBGqsSm3wIumIaJj2y
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3c9d5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=8h8aGV8n4KRRhUVAa5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX1TaoiM82AuxL
 FqCPAhN40XGfXUG8DfwLdsj9Rmyqs9qHeV60R0c2bkPowa3bCD6AHH3VWZuNpS5ce0h2gdAEZdG
 eyB1jD2aWNsax60ofVEk3eOG77ylPacV2ofNl3HGUcuEdazXCbGEmxA8xan2nq3aZLxTWYmmXHC
 MiYslN/nq+XhbeH1ywqopvedS6YcQ80WAAwiQHwRKVMU66QHGQ5Rl7OHs82SEkgm+Lgg8N5hwCM
 FlqnUnF9kudWqUbV+qsDJBf+JB+pVjIm2THGJH/gI6fPex80lTx85PrxswGmNK+CsUXXFVn0FIY
 nYJdxBvJS6TSv6ievGRBlYw6TAESag9UEZ1LTQ+tJspbvZDIiNggFhlvsruz0En4pFs4A0QnDZ4
 1jljdOqSGYigKL9dcIhiTF2NDgAPcecPfk59BDeCKZUFWfG4FxvI4dpmqGur5/1vNW4PCf+rEJH
 3eUEIXY4KAA0dUGeGSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX7O2RTZQqD80N
 fqoaqkJxeY6HTsyPWSgpIohzz4YxUkO8GYciRj+5JiNq7wgjF+IJM1cPEOmVOZbnikG5LtsL8RV
 BM+NFsCefZO6z7RQ2B/OoO/vZpr2kiXyBHWjoZ3iEL022kg+HXr4
X-Proofpoint-ORIG-GUID: aAS_c27jEoZLzFfBGqsSm3wIumIaJj2y
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add manual_load tests covering the load strategy transitions
(DISABLED/AUTO/MANUAL), set_autoload() bool compatibility, the
manual load/attach/detach/reload cycle, declarative MANUAL via
SEC("!...") and its imperative override, bpf_object__prepare() alone
being sufficient for manual load, and deferred loads of a module BTF
attach target and of a program calling a module kfunc.

Also add a signed_loader test verifying bpf_object__load() fails
with a gen loader object and a MANUAL program.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Co-developed-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/manual_load.c    | 507 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../selftests/bpf/progs/test_manual_load.c    |  70 +++
 3 files changed, 609 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

diff --git a/tools/testing/selftests/bpf/prog_tests/manual_load.c b/tools/testing/selftests/bpf/prog_tests/manual_load.c
new file mode 100644
index 000000000000..d574f8776916
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/manual_load.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "kfunc_call_test.skel.h"
+#include "test_manual_load.skel.h"
+
+#define READ_SZ 256
+
+/*
+ * Every transition between DISABLED, AUTO and MANUAL, the bool compatibility
+ * of bpf_program__set_autoload(), and the strategy being fixed once the
+ * object is loaded.
+ */
+static void manual_load_verify_transitions(void)
+{
+	struct test_manual_load *skel;
+	int err;
+
+	skel = test_manual_load__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* don't load prog1 */
+	err = bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled_prog1"))
+		goto cleanup;
+
+	/* load and attach prog2 */
+	err = bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_prog2"))
+		goto cleanup;
+	if (!ASSERT_TRUE(bpf_program__autoload(skel->progs.prog2), "prog2_autoload"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy"))
+		goto cleanup;
+
+	/*
+	 * bpf_program__set_autoload() is a thin forwarder to
+	 * set_load_strategy(), restricted to AUTO/DISABLED to preserve its
+	 * original bool on/off meaning;
+	 */
+	err = bpf_program__set_autoload(skel->progs.prog3, false);
+	if (!ASSERT_OK(err, "set_autoload_false"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3),
+		       BPF_PROG_LOAD_STRATEGY_DISABLED, "prog3_load_strategy_after_false"))
+		goto cleanup;
+
+	err = bpf_program__set_autoload(skel->progs.prog3, true);
+	if (!ASSERT_OK(err, "set_autoload_true"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
+		       "prog3_load_strategy_after_true"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_enum"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy_after_manual_enum"))
+		goto cleanup;
+
+	/* changing the load strategy leaves autoattach alone */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
+		       "prog3_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_default"))
+		goto cleanup;
+
+	bpf_program__set_autoattach(skel->progs.prog3, false);
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_again"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_again"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_kept"))
+		goto cleanup;
+
+	/* restore autoattach to true for the rest of the test */
+	bpf_program__set_autoattach(skel->progs.prog3, true);
+
+	/* an out-of-range load strategy is rejected */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, (enum bpf_prog_load_strategy)999);
+	if (!ASSERT_EQ(err, -EINVAL, "set_load_strategy_invalid"))
+		goto cleanup;
+
+	/* change the strategy back to BPF_PROG_LOAD_STRATEGY_MANUAL for the rest of the test */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_final"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_MANUAL,
+		       "prog3_load_strategy_final"))
+		goto cleanup;
+
+	err = test_manual_load__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/* Post load we cannot update a program's strategy */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	ASSERT_EQ(err, -EINVAL, "set_load_strategy_after_load");
+
+cleanup:
+	test_manual_load__destroy(skel);
+}
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
+	skel->bss->test_pid = getpid();
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
+	skel->bss->test_pid = getpid();
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
+	skel->bss->test_pid = getpid();
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
+	/* unload prog3; only its fd is closed, so it can be loaded again below */
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
+/*
+ * A MANUAL program that calls a kfunc of a module: the module BTF fd sits in
+ * a slot of the fd_array of the object, which has to survive the bulk
+ * bpf_object__load() for the deferred bpf_program__load() to work.
+ */
+static void manual_load_verify_module_kfunc(void)
+{
+	struct bpf_program *prog, *p;
+	struct kfunc_call_test *skel;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = kfunc_call_test__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	prog = skel->progs.kfunc_call_test1;
+	err = bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy"))
+		goto out;
+
+	/* keep the other programs out of the way of this load */
+	bpf_object__for_each_program(p, skel->obj) {
+		if (p != prog)
+			bpf_program__set_load_strategy(p, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	}
+
+	/* the bulk load skips the program, but this is where the fd_array could go */
+	err = kfunc_call_test__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+	if (!ASSERT_LT(bpf_program__fd(prog), 0, "not_loaded"))
+		goto out;
+
+	err = bpf_program__load(prog);
+	if (ASSERT_OK(err, "load")) {
+		ASSERT_GE(bpf_program__fd(prog), 0, "prog_fd");
+		bpf_program__unload(prog);
+		ASSERT_LT(bpf_program__fd(prog), 0, "unloaded");
+	}
+out:
+	kfunc_call_test__destroy(skel);
+}
+
+void test_manual_load(void)
+{
+	if (test__start_subtest("transitions"))
+		manual_load_verify_transitions();
+
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
+
+	if (test__start_subtest("verify_module_kfunc"))
+		manual_load_verify_module_kfunc();
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index e43dba8fed8e..8005cba5bf05 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -2213,6 +2213,37 @@ static void signed_module_kfunc_rejected(void)
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
@@ -2257,6 +2288,7 @@ static const struct {
 	{ "signed_map_by_fd_rejected", signed_map_by_fd_rejected, BOOT_SEALED },
 	{ "signed_sparse_fd_array_rejected", signed_sparse_fd_array_rejected, BOOT_SEALED },
 	{ "bpf_keyring_provisioned", bpf_keyring_provisioned, BOOT_UNSEALED },
+	{ "manual_prog_rejected", manual_prog_rejected, BOOT_ANY },
 };
 
 void test_signed_loader(void)
diff --git a/tools/testing/selftests/bpf/progs/test_manual_load.c b/tools/testing/selftests/bpf/progs/test_manual_load.c
new file mode 100644
index 000000000000..d91d5267a0ed
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_manual_load.c
@@ -0,0 +1,70 @@
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
+__u32 test_pid = 0;
+
+SEC("raw_tp/sys_enter")
+int prog1(const void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
+	prog1_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog2(const void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
+	prog2_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+int prog3(const void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
+	prog3_called = true;
+	return 0;
+}
+
+SEC("!raw_tp/sys_enter")
+int prog4(const void *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
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
+	if ((bpf_get_current_pid_tgid() >> 32) != test_pid)
+		return 0;
+
+	prog5_sz = len;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

