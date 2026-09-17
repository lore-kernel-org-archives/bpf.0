Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7134EF158
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677053; cv=none; b=cQtG3yoqjIvmpGRNlBicwKTp5e+wHAIum1xoHJMg7BCFum6QWBM2xfeFLh4bcTYxGlD2YtAdMPhj5JGQbU1wcpCLS54BPNZrvVLJ7IJvqDoPOkH5iqjWcVzI7OVJGczG+rXW/cawpjaYm9hZOjwU8nw6OxVqVoC7LYa+RN2gcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677053; c=relaxed/simple;
	bh=mmq2K/PfIku/sx4Rri7dK64UAGPNSD87Z7NBVL9nqiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbPwOqJ+rkzOuoN5oUPJ5yDwCGaHoHbf46JgsZwqo9thdomJWKD5tBAJIZni+1qPz3icz5Bc2mlkK4C+g4VAu1eMO8kAUnULj5B/VBy6z1oCnZmvO38bjuA26KvIIOV4sYJWzllTBfue7Nr3I9tNNWNO/a156WgE7VEHalqi/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=uLVgyY9y; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="uLVgyY9y"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HI1UkX3637466;
	Thu, 17 Sep 2026 20:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=xU73o30GF+jScR4swQupjXjnl/i4qCgH2DdGXZJZBUo=; b=uLVg
	yY9yeEIQSDbim9pIMYKBPolR0gAH4dhjCaLoLhFF9PlOQ89KjFvF7HfCLSBmdZUX
	KjefesFj3F/EPwyadmAfL9evdYwc9cEJBM3AgacWQd3C9NmetzA+7+VL8Cj1Z3Qu
	KEEYiBjdeIxIvxjD6yUTTiUPw/nmfOXbNS4a5b0Uztp3c7dxPMe+cRbZ1ahzC/8/
	KXh9uY/TLAgRhPW59ywNqUh8wc2SsUJGJsimaaLAgsgiCQmc+25vkjjS+CnmhrES
	nY+ffb7G4REnN49ZiFGMsWWTptIGxkhXnEhOHSHYbZWreMKc0QDrHRVciyHWH+1r
	V4xMIypLAmAIznw7Wg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gqyajng0p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:46 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Cover BPF program load strategy transitions
Date: Thu, 17 Sep 2026 16:30:39 -0400
Message-ID: <20260917203040.3150212-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX6fQEt1CJh373
 Q7Zc8SZaOP9vRrauIxTBJHWwJZSpBMf7WpyW8XlhzoE9MpCJcVU78KJyTTaODpPH3tAkPl+hz+p
 b7bkoDPDfj6DPLLfWYw8mO7qQFmtLCuNumllnGroUmNfd3G7M0o6
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6aac4df8 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=tUMMhYJZuGEAUDIm3hcA:9
X-Proofpoint-ORIG-GUID: -PC1Nrkpdta1xjSqbFPjnAC1LPR9HmJb
X-Proofpoint-GUID: -PC1Nrkpdta1xjSqbFPjnAC1LPR9HmJb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX5JDibLn+6dNk
 +PeFIdVOl+mgSEO5FgO+i6acXBt5AQ0EG91YRxw8iyb0bfZjhIn0E5msPT17XjS2KvLCrH899Qe
 gtsPBSUFn9J8U3ey2natX+3D5/BoKReaHhEYC71uWEP7N5tX8q75iOtqx5WujEEaeUnL8w+Rb4f
 UzEXivsAp05v9415pal/bgGOPxZKi4eFqomu3Uvk1uEdxEx9tQVyDuMK8CiP1mbDs5v+ux1J0c9
 Jc2FxTJThDJoxXIo5PuSQoPkLDJbxdbnuL5KXO+/qSwXTheQy8v/kXR4Uw9T5lNF6Wkplk7EG3q
 hV6sGG+jOZP2FlwxtID9K0q8Xr64rMM04XrRYS2scoM+PsopLOcPvcoTJ/kf2tRQjzFP7Ga+Ube
 gRwERFC0+gSfPhRHXLQ2Jr1mL+MX6zBnYqB+FNAebkU5RrdtIaNrMzGL+BQCaUPzeVU2+reEdZH
 qsfUNctX3MgHsJ+hzaQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170294

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add load_type test covering load strategy transitions
(DISABLED/AUTO/MANUAL), set_autoload() bool/enum compatibility,
autoattach restore on leaving MANUAL, and the manual load/attach
cycle after the object is loaded.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/load_type.c      | 157 ++++++++++++++++++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++++
 2 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..55ca53685863
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_load_type.skel.h"
+
+void test_load_type(void)
+{
+	struct bpf_link *link;
+	struct test_load_type *skel;
+	int err;
+
+	skel = test_load_type__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* don't load prog1 */
+	bpf_program__set_load_strategy(skel->progs.prog1, BPF_PROG_LOAD_STRATEGY_DISABLED);
+
+	/* load and attach prog2 */
+	bpf_program__set_load_strategy(skel->progs.prog2, BPF_PROG_LOAD_STRATEGY_AUTO);
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
+	err = bpf_program__load_manually(skel->progs.prog3);
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
+
+cleanup:
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

