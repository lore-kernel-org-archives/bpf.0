Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806335;
	b=tXAwg8dQT1Lefv2qgZ5tRhEpUxQ33uVWSQcDsgkolSljtMGwmFw24lC4u0xr4ApLnlHh
	 lwc49ZNFbJYbPYTcTGU5kcVVb7hJuLNGDPTYoaANzjMiZjTBKGnx/0mw6eNmOiTabL5UA
	 eixJ168fKdD3j997/CQDtx6DNI5MfWVfQXoGSiKjzSTJvslRa8g9MwoXyiGyqFfZgabEw
	 dSQUaC+adqUF8WZx0Rd+F1WdGcS2gFdHhry4lnrnpleE9ChO6O/ZlXBBgr5NS/JPXfHuN
	 +4abWdig+CaAOQ3niReaWPZTMu9VzouRdGwRKBPhVySVSkh/ovQ5eAinz7jhkemaEiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x3e7oQD++pk53RFYjBKcyXMImRqQR7GXIGBBZBwmwkY=;
	b=t+TWyz9mzrfFY/gijtnUL5AtO+ULrSaGdto36pkgfyQwz09ORC+Y1EBUC6WWdQsmXZB8
	 MlYYuAicB1EF3zjPupC1YwcZS1Wr7w4ExkDuPeZIlGAZESY8ZWF777ME8d8LfCPcbadAx
	 UIn0HnfdUUupbbW8NdosvaU+Ifc1zu55RWxCHr54m2Toe8/ysGVSwprwO/gJQTv8SBCPg
	 fdh3wITkLj5a3d1alj/zloy5LnAsMedLlLvaFmXkv2XrV9W0PPkgLPglOK5ST4lxZh8YP
	 ofqRPg73cGIB4GiKAvNRRArX5tfGzgNoTQY+tf8vlyIolHfhSU4A+uNF8qR0jxd1XyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=gd18ykAZ;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39604606A321
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39604606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=gd18ykAZ
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O1UJgM2781820;
	Sat, 24 Oct 2026 01:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=x3e7oQD++pk53RFYjBKcyXMImRqQR7GXIGBBZBwmwkY=; b=gd18
	ykAZyFy4djZ0iAjjIsWhAJeuJIE//+bQtHy9Ii0wa4ODuVisrxrqgi+bslr8Iucz
	1JZi9yUYpxJhHrHhoY8RO0FI6wgdacmi6IQ+gfbe0T4/BcXP2oMMTWdQ8UzNmYte
	SgWVCxQPu34MHimcYNMSRDa9DztizWG6GT+iuVXxAWnTniymaB9CtPs3tP2kAEFY
	ADPTnyb9o3qqWJoOP3Disy2pp+T0z3/ZQEWMdvm6yO8lu5uaxbFLi8BGIj2ZRrV0
	uIWXLADu+Hqb3WQwk8/x6k3MxGBfBbQSyTWrVpC/59XcQ1Gwut2Sr2iyK4O1So4U
	1BVGWJyZXRRIKiHMPA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hfw3249ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:24 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:22 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 6/7] selftests/bpf: Cover BPF program manual loading
Date: Fri, 23 Oct 2026 21:45:13 -0400
Message-ID: <20261024014514.2959514-7-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH007.crowdstrike.sys (10.100.11.74) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX5wnrVglr/uiP
 u8XfPPguOy+WMG2WekULeZrLcm4MoX6dvpHL7t49q9CAfDw6nilTL5BmUY+ni+z+j5krjgVEwrr
 Cs3oZVUWMPPNatH4oEWo4XgfrgJ8u40VGCVxLV0E2Pu89HZ5UUsu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX/bzEfmK+hZQ7
 O69vnh+ttjEdMeYw7XBMVi6bsw4VuPp2U7OwPVYMnXxDmA65AVANGpJ87Smz9PZTUjBD4qkceyC
 X5ANVZgD3BeEs1xwzo/7gmoW6dR7FQSuJydzsj3arYJyo6jPl3BCM0z+sXgyorsjfgcfqCUeQu9
 M9Lvb6rt5v0+5b7mkUo4pyvyOlJHVTlvtc/LgWebdMFQ/2chOHLFLKquL0dCfyk/E+ioeQkAlgF
 0pprB7tS5pEk80AY+IExe4b56wPzguranCcJEBTPmFuA6i28oAzMp673m6Mmb6geeySX/hFvIFe
 LuOKZcaTYYF0yg4b6PQwDPQa80tbGizdM53e8wXTMFphxuzajZFKJkfjDahYHU1LjiTaMW7zPUz
 THP1n7/MAYI7rttpdVeJ90/jkr2pHcwB2Q164kOgG2I2Ows4Sk+Iim6g7b12WSUx5i7DiMrYQOd
 2wNG3o09/5FpcM03xEQ==
X-Proofpoint-GUID: bntvhjbELT1hFIRgXGS2yl9QidFZ3671
X-Proofpoint-ORIG-GUID: bntvhjbELT1hFIRgXGS2yl9QidFZ3671
X-Authority-Analysis: v=2.4 cv=OoPaWC/t c=1 sm=1 tr=0 ts=6adc0db4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=DGEMoOLgL6qaxSF4CT0A:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

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

