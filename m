Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A96430789
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206204; cv=none; b=q9UrITZ6lvMe1A2Tz7w/480jr4AXyTQFaSG0vcFa0kxrCoOcGiCRe7WLjkZVSTWwYSBKxURl0tbkmeBkrrxOx9JRfozjw1SZJw7vrW5qerCObXXLmOmDeqfanEkQhb+uYX0r9fEZYDQY1jSLUP+biGXXgaUUMvUTKeiCo9Yjw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206204; c=relaxed/simple;
	bh=jPVdH7lC9yGLileBibv68iojRBG0PKzGsgHM5JqshG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ra1EUAmNWgePvMlZksBLZxZU99+dmp2TMS1n8o+HB0zOfMNH45QtMoRqlR0t8wdaNa0ZdfqNVcpjNYpN67NrmYUVZ30Q5pfJ+6kyyVqjF+JiLgh20xsI+jUvzbndg/BzP0u4oE3UnI0QmP/AyWyQ3WRv5sNuvDoz/up/CzIyEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=eMF3LyP7; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="eMF3LyP7"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKgAIM429241;
	Wed, 23 Sep 2026 23:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ofrgA7+C5IrVcD/kglLRCKM4CJgAIIQ9hkEVxZ1eXvo=; b=eMF3
	LyP7TzF1OXqCKkuTZF4VzP1egcc5Ju5A5WwWe1Af6eRLmtB+rBUyvmVdMchf6tR3
	oCe8nuvhOgjLYDNR2yiSyKDXr4eqnpXxvg/LZdLJMWeplU4utSREBGUE8T4NLLOs
	L2O3+MHBqirVC/xyjXyLRAjUQZIkZJEEBEYKimOt0oQ9dpFI90KM2eldXE/McrmC
	bWO1ghYXaRR81w5uqg07OoeY4UMxebLOQSop/bjoUXSgIWDmDqJKboD+O/XqDAK2
	EfpNdk/tsb0fUqk2D+XKGZ7AHUMXsou7T4CrE/eWxphJaV5zV2iNe8BXnlmu5Nz5
	Rt9jiLjrmuCPSxaAKA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gvp1r0dn5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:47 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:45 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 6/8] selftests/bpf: Cover BPF program load strategy transitions
Date: Wed, 23 Sep 2026 19:29:37 -0400
Message-ID: <20260923232939.1886328-7-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX7zd4kjWy+xfP
 uiWQJpaTS/bGLekUm3/2wQls0eC32pW9yhrIAfixL9vQi53QaZhGD14SKuy7N4DQy1eVPLc3sue
 OI8ZCC0ucyBpfinRHGzBL5z79va+omiUi1LiqluDejGFnAx8UK2B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX1T7+TH30Bwk3
 Cpd+YmPKveHdPYmzVsTCivBqAQeANmugy4Jh/9c08+vQwoCMfW55QbZWdkiKbVF+ksXSyHx9i6M
 OlHfkPyo9PqK7AkTzpyuGSnOY16No8BZXcr9BL7d6SdvGHWzjS40pUPAixwhGNNU+ueQQWfMw2v
 ZXgpJxeBkS7BERhq4OKB68YMFFMHJZ/px5otdQteqMHJwufMww+z041rE41wAu1FDDvp1gc4MMW
 lYm2C8+PV8IYWxCxHYeTBkp6Kt9y7VsITZBoNshNVCa3NTdwDk2nalD9JBbT8Nies54riyxhsx4
 M0csH3DM/wL2F+CV6dc17xp/4AB+RLmncCW8BjPaE3ttlZ1duTQEkmm1JQCbWO6PRYZJv8qxbcW
 exBdckRwDwfbouB7kw9ydOyIcB2pILtI9U1X2GXoHgy3Agq07KjFnaDLA9+KJmxfw/EcMkdWSJc
 SojFbWy45K1xrlnPVXg==
X-Authority-Analysis: v=2.4 cv=YOcKWhGx c=1 sm=1 tr=0 ts=6ab460eb cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=2RqsA8kddDwN3QNLqicA:9
X-Proofpoint-ORIG-GUID: Lw_Kx7DDtPgbqi6L9QdEam-ZaQaKypFY
X-Proofpoint-GUID: Lw_Kx7DDtPgbqi6L9QdEam-ZaQaKypFY
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230095

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add load_type test covering load strategy transitions
(DISABLED/AUTO/MANUAL), set_autoload() bool/enum compatibility,
autoattach restore on leaving MANUAL, and the manual load/attach
cycle after the object is loaded.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/load_type.c      | 190 ++++++++++++++++++
 .../selftests/bpf/progs/test_load_type.c      |  31 +++
 2 files changed, 221 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..67813a8c7646
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_load_type.skel.h"
+
+void test_load_type(void)
+{
+	struct bpf_link *link = NULL;
+	struct test_load_type *skel;
+	int err;
+
+	skel = test_load_type__open();
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
+	 * original bool on/off meaning; it does change the load strategy of
+	 * a program that isn't currently BPF_PROG_LOAD_STRATEGY_AUTO.
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
+	/*
+	 * leaving MANUAL for AUTO must restore autoattach (regression test for
+	 * the autoattach residue bug: set_load_strategy(MANUAL) clears autoattach, and
+	 * nothing used to restore it on exit)
+	 */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_strategy(skel->progs.prog3), BPF_PROG_LOAD_STRATEGY_AUTO,
+		       "prog3_load_strategy_auto"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_restored"))
+		goto cleanup;
+
+	/*
+	 * confirm the restore also holds across a MANUAL -> DISABLED -> AUTO
+	 * round-trip: AUTO and DISABLED share one guard keyed off the source
+	 * strategy being MANUAL, so autoattach is already restored at the
+	 * MANUAL -> DISABLED step, not by a separate DISABLED -> AUTO one
+	 */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_again"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	if (!ASSERT_OK(err, "set_load_strategy_disabled"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_via_disabled"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3),
+			 "prog3_autoattach_restored_via_disabled"))
+		goto cleanup;
+
+	/*
+	 * discriminate the restore from a hard-coded `true`: force autoattach
+	 * to false before entering MANUAL, then confirm AUTO restores it back
+	 * to false rather than unconditionally re-enabling it
+	 */
+	err = bpf_program__set_autoattach(skel->progs.prog3, false);
+	if (!ASSERT_OK(err, "set_autoattach_false"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(err, "set_load_strategy_manual_for_false_restore"))
+		goto cleanup;
+
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_AUTO);
+	if (!ASSERT_OK(err, "set_load_strategy_auto_for_false_restore"))
+		goto cleanup;
+
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog3),
+			  "prog3_autoattach_restored_false"))
+		goto cleanup;
+
+	/* restore autoattach to true for the rest of the test */
+	err = bpf_program__set_autoattach(skel->progs.prog3, true);
+	if (!ASSERT_OK(err, "set_autoattach_true_again"))
+		goto cleanup;
+
+	/* an out-of-range load strategy is rejected */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, (enum bpf_prog_load_strategy)999);
+	if (!ASSERT_ERR(err, "set_load_strategy_invalid"))
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
+	err = test_load_type__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog2), "prog2_autoattach"))
+		goto cleanup;
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach"))
+		goto cleanup;
+
+	/* loaded program strategy cannot be changed */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	ASSERT_ERR(err, "set_load_strategy_after_load");
+
+	err = test_load_type__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	ASSERT_FALSE(skel->bss->prog1_called, "prog1_called");
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+
+	err = bpf_program__load(skel->progs.prog3);
+	if (!ASSERT_OK(err, "load_manually"))
+		goto cleanup;
+
+	/* attach prog3 */
+	link = bpf_program__attach(skel->progs.prog3);
+	if (!ASSERT_OK_PTR(link, "attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_again"))
+		goto cleanup;
+
+	/* detach prog3 as test_load_type__destroy doesn't detach manually loaded programs */
+	err = bpf_link__destroy(link);
+	ASSERT_OK(err, "link_destroy");
+	link = NULL;
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	test_load_type__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_load_type.c b/tools/testing/selftests/bpf/progs/test_load_type.c
new file mode 100644
index 000000000000..3d9b81691d7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_load_type.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+bool prog3_called = false;
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
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

