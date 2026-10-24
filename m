Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806336;
	b=sLgi8ZG+yNeOuXoALbirgFsyMssGE9ANW7KLcsID3X3r3vOAP+B+69V5QUSPeNxyDPRg
	 +VpzVKF+DBz72Lw4qHE2IWga2s7Zy/ZwTpYsn7eOrRzA/8N6OCYaNwoV64f++xYn/T78U
	 RNi8oiD01DdrKtGfbBP/0SdmPyNUkobJ+9encDirPkBQnOs0chWBjiGXU0LoUqzfillKt
	 kxfq4TJPQjd2JYnPPHnDGkM3MXrNtvG6kKFSrQbKDefZWMe9A9yE8LWR1T3OHo/QQH+mA
	 RkrBwaALwllBzEGawC2kxROTPjHewEbb//4j+fpyASa6wW70eLeBUkLyADjhhueLK0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NEeV9ZegWvY9vzjKDeCAoxGWkuaJKVNG78z3Nz2UL40=;
	b=yk6m9s7niNtK6RmS4lKT3HtEoOpHJ0eP8zM8BzTWxSzkQfYdfNMpDVdiHh05NlzCgGXU
	 d1le1tbzntnrbP+Nh92VaDEscgTXuqeq839jM5Pv7bnA4hc+bsL1y8Ry7DBeR5Tg5lQZf
	 VSmGQtvMCx1mQ2uMGVJvZGUROHL5ufFDO+wLKkSF0t9844lQ7zJJZVQGadPTuAB/QbuNV
	 MW/90kIzVKEjQhc7xO314xwiL4RakbyXiueNf1nXytnf77LGE4UNvU/1s6IIzODEa6ClQ
	 HaEMMkbQER1Zc/xYOHDR3vmnwg2qu+0XHO3Q2G0Vb65/8Fh9T/KsF+ai1I2SceweIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=bY1Y0F0E;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A9D606A337
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A9D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=bY1Y0F0E
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NJQG5Q2992813;
	Sat, 24 Oct 2026 01:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NEeV9ZegWvY9vzjKDeCAoxGWkuaJKVNG78z3Nz2UL40=; b=bY1Y
	0F0E3qSYiJG2zLYkRiiGHr4MAL+yuNHKbcR9WhSipDLL7fRBcEhYdafXHIal0aew
	ce1hoGRC9BKQ9N9bSovs82gp50+WvN2350t+zMfn2Js8oN+LFMe72py2qsz44aIU
	Httgh3Kbz0Pf68H+UxfyL5s5ch6w7t+Bzq1qVEYaNRCaeqDxARHKKqSusAcFwBcY
	1s2Q0e6TFAzgcmGxRCAT6XNnZc3nHhl/aQy8PP8u5wQ1UYhGmd3GabfYQDeT+QwE
	rm0FpVXNzcsw5ipkKBwMSos/48UTqMSHdev41t0bUpnHf2cOQREhXEQ02txYrEPo
	T+kerEOMLnG38L89xA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hg1teux9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:23 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:21 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 5/7] selftests/bpf: Cover BPF program load strategy transitions
Date: Fri, 23 Oct 2026 21:45:12 -0400
Message-ID: <20261024014514.2959514-6-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=HaiB3SE8 c=1 sm=1 tr=0 ts=6adc0db3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8
 a=zLuxJhxpLnNjXD2GACUA:9
X-Proofpoint-GUID: 3bU-5cEEyEWIUXnPpyXit25WVHTynT0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX3wTY13s+9zt5
 1B7OeKSwc92QHYonY2QKwL0YWCC+2qmK/i7Qdi77wp66OjpXmpdTI4s4cgvk8yDgs+I6h39Upc4
 BjGrcyoiI+FSHoQZgYuL8JXqKEw1I3f2QLEmj6BZHSgYyXWAOLgM7NIhkRUTbrLwmNsYFe/OrGL
 a5jDnIkCJzDzWIAOGthgK53hROrehBJaqjN9dKFWMW7vTSvYwmcIv6zQG4w8o9p9BBRPiLeyUyN
 G1ODFG4wNM39iq8tisGC8b3VLkpZtrewW9glfNqdbi5A/bcCyTiJrf7QaKpao6PZWZg9P4pAhb+
 d5C1f5CQnXRnBVsQ98Ljp0BiiVNqxFbN0hRQy4djpgkJuXTf/NuysTdHelqqeSjCpgBHu2aCg9E
 XvB2yigzn4uwCq3U1sgo8FwuUb1pr1NqCc6kr+/cDQ0pCQOwkn+dIXwr6B5oddjKapnB24o/YvL
 Psi0R2VrODA9iXeYqfA==
X-Proofpoint-ORIG-GUID: 3bU-5cEEyEWIUXnPpyXit25WVHTynT0n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX3szTK7VcJpsZ
 Pfcf96yLwRuBqGAHRjF9aA2+8M2aNeDUcwWNpPtk26PF/9T9i6xxbeeP1EeLk2wktsO4YBD8zhq
 eHlpHabhp3D1Do2cp3ufDSEAkU8C+Zt3Ai9QMpM78W7B93j03SMt
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add load_type test covering load strategy transitions
(DISABLED/AUTO/MANUAL), set_autoload() bool/enum compatibility
and the manual load/attach cycle after the object is loaded.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/load_type.c      | 154 ++++++++++++++++++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++++
 2 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..7e344c0b0445
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,154 @@
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
+	/* Test post loaded behaviors */
+	err = test_load_type__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/* Post load we cannot update a program's strategy */
+	err = bpf_program__set_load_strategy(skel->progs.prog3, BPF_PROG_LOAD_STRATEGY_DISABLED);
+	ASSERT_EQ(err, -EINVAL, "set_load_strategy_after_load");
+
+	err = test_load_type__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	/* Post load only AUTOLOAD program is expected to run */
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
+	/* Post explicit load and attach, MANUAL program is also expected to run */
+	if (!ASSERT_TRUE(skel->bss->prog3_called, "prog3_called_again"))
+		goto cleanup;
+
+	/*
+	 * detach prog3 explicitly: its link is kept in a local variable, not in
+	 * skel->links, so test_load_type__destroy() has nothing to detach
+	 */
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

