Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6126ED3E
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643550; cv=none; b=duAYUFkNB/k3RIN3uMkMiXbVGvUVS6Mb3U1t8Pu5h/On4sXMyWmQdiGcBFgqpINGAp/4DtqOFzpX0Rhb9+g50TevOa/T2eVSbuFhygHkV8/IwOToF38zFfRbYFmeu2FBWwUJiH3Ejrs6acwj+ZgPyb7S42n633H7XcBudTQ9dlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643550; c=relaxed/simple;
	bh=GzP2LXZbK7Zwnzre2z+MzXJgyyFv08bRr2vtVNiJN7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snbVaDKUv36P02x/AxR36tS/U7mKxNEFEdjmsd2nnCiAnOLzVhnzEVbbaPAgfQUv/5GXfJkvlQuaYuH0yUKvjn/MOLcJ9t4W/63vrdwgqclQ6g56OwaiHXCNItkNIv2yVWgA1NUrngPrrRetS/PM2J2uOXNuGqum5dpdSfNUPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=cDvIj4MP; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="cDvIj4MP"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKOKf3008652;
	Sat, 10 Oct 2026 14:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=NEeV9ZegWvY9vzjKDeCAoxGWkuaJKVNG78z3Nz2UL40=; b=cDvI
	j4MPUwL66WQvuBUBXSlp3u1Gm2IpjulOD11Sx4AxMlKKMvEqy6sk3i3Z+GzY7zTt
	rFUx4LMOfgDVxFuEwfu2axZEfqNj8u1F/07xarZNb9FIzYhiyTAp+xDPXsooF3In
	TpjHg2odmvMz3EDrdr9/T9gefxbed6So4Px6xfIorBB3Rzd7gI2gmBI+mT1KB7Rh
	OiLOAiAR8nGrKRaced4j/5EaSuypkyrH2QC5pkHIeXOSqJpnXxWQzBYyfszMbjl7
	RPCTdZl/LzIz7wsWjrPkm+Aiy8rLh5SFSJ5psxqnzFSR6b8ixDwrfPpXKoTpsv+e
	at9Fr63Hc0wNooMKhg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4h74ujjua5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:03 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:32:02 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 5/7] selftests/bpf: Cover BPF program load strategy transitions
Date: Sat, 10 Oct 2026 10:31:54 -0400
Message-ID: <20261010143156.379864-6-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX8GoWmNutAvcF
 aVMf4Rw+qTx5eggQzhydVqKe44Q2AtGrbt9wTMz6Q7EHDUvJFgQUTZwtsB5koHTlzIxZtpCA2aV
 0WnQJ2ewFSlfRyCYkOze8QKtxc1BanWbH3AoDeHGxNWwAhPwJwsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfXwY+L81FUuK9s
 IGJFaqjFIlEAmdkjl2s1VvQcVlfKU7Ka/nPbHjHAcHUJy3KoXtykEhKozCLOADjMuLj13uahyNX
 2kQMWEhXY9QDRGzc5Pfb1QQE40cH/RQUpDLvnKLCZmaRyIxfrK1EOm6M043RV3HEEKvozll/4H+
 nUmp2DaQ16BEL1ie+YBd7vsFML1odT55z9Uf1+4CP1esT4ij7E0n3oNRD1sjRKF5gS/X19Cnbp3
 eJV7phxFwiiN14mbjW53HnRVHsyFnhZk6zYCch8D5At7/Gif/qBtgjLxgfcorta8bOhOTEwgEUy
 dTFgi4zxO8T8l0uJvMh3inOSGgJo+b7DssGJiZQ5uB6PY1W0yUVAts+yJJk1iJO7Jq6BFHxF9tX
 JhDlQqwENxTu3p1xk/ftyqg/D9VhPku1cfdjeIFhZhr4IGb55BkCCBKR+09OQT2gHE+PNQZKgSF
 RvkdRPdql3cmg6aRRCQ==
X-Proofpoint-ORIG-GUID: 5o1PdpVfk6oVjq9m7AXSUMbvbnMc1i5H
X-Proofpoint-GUID: 5o1PdpVfk6oVjq9m7AXSUMbvbnMc1i5H
X-Authority-Analysis: v=2.4 cv=btrZl0ai c=1 sm=1 tr=0 ts=6aca4c63 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=zLuxJhxpLnNjXD2GACUA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100057

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

