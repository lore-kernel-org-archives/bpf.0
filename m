Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708355;
	b=HV436vaSU2morgXKOa33rX0BKbq54XzB8tD09aksJVZ7weNGVNq76DferTSSxHMY1Ep3
	 nk2jevbMKAFxMZ2cU5mAurWkCh9c3gb1g4wTKJP84rS2uLAUAaWHSj2R8JThdmaOQdSix
	 oI0uhPo0Xm1UhvcccJB9mIl84uaZ76sDqNxoNUV4074/42QznKanrZYTZ3yzGA90N/azj
	 qL1tgAgxMLaC/FUoVaXqrs8Tn8IOSHAou2oZgORRwsyZNT3lNiKebd89k/+pQfi5yPnpQ
	 2vJM4qdBa8MD2Pqdkb4QInz7GlryPTGl1+gQWbuLv2gJz2+UjzwQlKEo7ewMT6PKXRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x3e7oQD++pk53RFYjBKcyXMImRqQR7GXIGBBZBwmwkY=;
	b=LGOFC2iTD63ZDCAyh4jO9rYJIMbU3lFQBagh1mLZ4WDJH8Y8DE5GCMv65OjzEOHM9loF
	 R2aCj4PuihHwhnG42mtd78600jtkX5gtb5pt1wV9bR0QA9rolFnnzFOKobjK2vTp6Y90R
	 5+EcRf4I8cSmL2eaCzOtSP8zBVlsmYYvPlxlB9UIFjXunUe0RTwZhIKW/aGh0FmfDmARC
	 OlluHkHR+I3QFH4OR1XYOiLSeBRmxWOZ8Q60GUKILWUllXd43sfxBAdrU5k0mKpm7DdEH
	 YAHO3S4wBAgQc4oiYAv+m3pomSqG7W4+VvV2N0FeHHKXAvg9NTd9pcRHEWPyFIzlB2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Ozo+VP6l;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C0606A326
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=Ozo+VP6l
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHMLZE796650;
	Thu, 22 Oct 2026 22:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=x3e7oQD++pk53RFYjBKcyXMImRqQR7GXIGBBZBwmwkY=; b=Ozo+
	VP6lvIOyWpj8ov9nVrAlFbp/a/atyCq0WjQ2eZM8t2ppteav4kUmScrXvYid//96
	xjsLfI08vG+lFK8KPLmkqnGVltrQ8Q9QxAOArw8RuS2ewDte7WceCY+WlNGRHO5x
	Dumr7AldiggCKPDMWuwLdVAwhseR+FArRPKai7sb5Sh5nlJTqVFshUELpQNMIUmk
	gh1vWHVLbq1jHn/uPBHcdxHrTeLULA4pVeSGoTRnV/joazuEhW9o5zTTuUNx1jbu
	nL0MuP1a22TBSmGse8/bkxhOx/PzHV3prKgw0EpmJ7tSzNNF2DJdDG2eBby+UCFw
	uMHaZ5x2ntOhFNyMRg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hf97jmr3p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:20 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:19 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 6/7] selftests/bpf: Cover BPF program manual loading
Date: Thu, 22 Oct 2026 18:32:11 -0400
Message-ID: <20261022223212.1217849-7-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
References: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH015.crowdstrike.sys (10.100.11.67) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX0Vz9JFWADTII
 j8Jtrt/osdtLUdWI0nJfxYXJ0uGbHrfnRe1gkwIBY1zBSKrKXez2s9bJC7bVwsFAZuUCzdgi/34
 ASHmJ5S9gwrPUb35aXDY7d2f7fa0eduDwUOxcx1wCE35P7GAIRaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfXwVp2XUZkF4Ej
 sdk44b/8/0Habv27n3/dMqdGgihl7Pj+V779BTbbuvEncKJDS510YxcgCglwpdQoJOQ6m4PksVC
 PFXQ+agsGvE/wb2gZb978OSHHLzmmgRZgCJVG1MsOLHwHTUy7oqiQGS2H9ShWN0mTDu5nM24sR5
 kJvrUNiotEsnaBeL+dQaoEC0JLGoTWEVwNhS8zd+RweOcjlDhtw3oXMWw+6CrAvRzpAiMB4mF1f
 zQ3XM4oMB7t3VVIj7QBgXvH+nPP749rLKIFMoUTed4Crjcs6aQwv4bPvXR9J6OZ5oObKP7xhubj
 NjEQF6QogFt1RXBSqAFuI5sSxQc987hjNESTwqv+avR1upwbPl/4CKcEaRAsZrhUCWzsh4GMvud
 oT1ROs9ypFnURX7jWA1zjU6s3uPNXxW0KOmdc4z4vsqC9gQ5/P8CyZhJXaX0mKyVx/m6ruV4ccq
 j3ORdv7rplGoLWM3XSw==
X-Proofpoint-GUID: 12vOF2fGtSrx9ngFiMDLRbvU7uHBOEJg
X-Proofpoint-ORIG-GUID: 12vOF2fGtSrx9ngFiMDLRbvU7uHBOEJg
X-Authority-Analysis: v=2.4 cv=EYFd0/mC c=1 sm=1 tr=0 ts=6ada8ef4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=DGEMoOLgL6qaxSF4CT0A:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220089

Add manual load test covering the manual load/attach/detach/reload
cycle, declarative MANUAL via SEC("!...") and its imperative
override, bpf_object__prepare() alone being sufficient for manual
load, a deferred load of a module BTF attach target and test of a
program calling a module kfunc.

Also add a signed_loader test verifying bpf_object__load() fails
with gen loader object and a MANUAL program.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/manual_load.c    | 393 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../selftests/bpf/progs/test_manual_load.c    |  70 ++++
 3 files changed, 495 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

diff --git a/tools/testing/selftests/bpf/prog_tests/manual_load.c b/tools/testing/selftests/bpf/prog_tests/manual_load.c
new file mode 100644
index 000000000000..78a7b2904a76
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/manual_load.c
@@ -0,0 +1,393 @@
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

