Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9F392C2C
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768341; cv=none; b=RXJaD73ehTcRMxhGMqIeToV1oeh3yYz1i0MmRWnM6rxWgxhElSUortOgnM6/Tejm3uMnWjLhhwqdjinkesW7cAE4fovkS6TzhtTNtY1W8TB9cAv1r3j5rMi6fuzFJ97830kiR+cWL5P6nMaXpu4Kv/GmoElefrLDKLSzpimHv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768341; c=relaxed/simple;
	bh=0YwV7q8QwOrCbCUg10mk0OxgyvbbENagu/Ikot8SzLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PD9fyM9+cbYjWKNUThj2TToa+JUP/b05hazT71Ht2UdWYuGN0JXdn7QXD5xY20zkOrG8hS3822bON2Aim9RBE/O3Ira/0D3QhR00BHvPMAE/wO4rGm2Vo5AM50751rnMB7WPdBaCvheXmqWCb5QztAbFeZ7n7ev5nSKBU/QZhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=vAzsUAgO; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="vAzsUAgO"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHMWNr012752;
	Wed, 26 Aug 2026 18:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=IPm/+gWfjWsBrGygU2SFFMD2LzALX8AyOdyVWaEqWks=; b=vAzs
	UAgOP/90aUzl0/hrJ+COHye6q5qF5Oa4w5lMzcjxl74IYp+DJK+oIIholhayMZCv
	NKXqCG75r5zvJXUTx6RHwHrzi5Jhua8nzojFtkAl2iR364Z2uFPct5wKFJ7+Okus
	Ug0IZGJ661XbeiZ9WhW1ezQdYfQOWED+GpZkhr2McS2YDPk8ZfalnLKIfYPFCKLH
	dus8FZok/huocZJxs2GcUNyUqr9vYyHbSnAq2FLuMSNphZ9NS0jJFhCxrtlaDyLQ
	TSTkQqlERvvNNtRBXGBr0zEceQG8jPJDuLVoEiCOTcOiwwmYUNXxRsyVwzDVVZjl
	MznNXIxrnsBy86X4OQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ga4g3ges7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:33 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:31 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Cover BPF program dynamic loading
Date: Wed, 26 Aug 2026 14:18:25 -0400
Message-ID: <20260826181825.1826541-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: fgUGb32DifVDIzpq8EuYQFT5lhkuL7WG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX5n/eT/E9Qdzd
 N7dYkzOq4jw0loKDF1wxpnCKDp4f9OenQBYb/jec+Mvq1EfeVUJR21tngC668lpYKp8UueTkVEk
 0+v9lpFPZfoThKn54PSVIXv5eIGZrSbfBaNDUGAThhYM7Gv2YscgnP5YuzEdq7w3JtJBxEX4iNb
 tzjNb0DBMjgEMsfzcLEKRVmX3CxIQX+K8e2shYB6w5TY3T6jOBksXG2xTTJpJlchf6BL1bvBzbQ
 oECVXfJRPudDQAy3Y0ein1NUE4d1OK4i2FXjOjMVIlN80GtiAHCkblOlIku/2I/RTSkzBEgAhTs
 Ck/7YhJjPtz0mSRPBSlZ6XuEt8+6bh5WSAkQbCFmupy3+IbP2hY+VbUPwespQn/gg8AYRRoueAa
 QiVweaib2MAguEH5k99FDEtlh3KYDRqF74yy2/yJ32M0Gj1JcE6dO0k6VVmb//3n6rafxAIQapr
 IL2aFsoaJatZPu/AQpA==
X-Authority-Analysis: v=2.4 cv=V4xNF+ni c=1 sm=1 tr=0 ts=6a8f2df9 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=QhUhLNbbEPx4FOeRzbMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX+r6J8coVmniR
 bptBi+a4xv+9yx85aaZYMtDDtzkWlXH/6HJ64m2QTMs6euhdTUyHoMq8r02eErWGZDJjv4TfB7B
 O5W+9CRvSrp6U2hkpN1+45Oyi76m2vSHqaNq+lKhGwisA9eiLgmJ
X-Proofpoint-GUID: fgUGb32DifVDIzpq8EuYQFT5lhkuL7WG
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260153

From: Slava Imameev <slava.imameev@crowdstrike.com>

Add load_type and dynamicload tests: the per-program load type enum
(disabled/auto/dynamic) and its transitions, set_autoload() bool/enum
compatibility and autoattach restore on exit from dynamic load, the
full dynamic load/attach/reattach/unload lifecycle, and the
loadtype:dynamic BTF decl_tag as a declarative alternative to an
imperative set_load_type() call.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++++
 .../selftests/bpf/progs/test_dynamicload.c    |  40 ++++
 .../selftests/bpf/progs/test_load_type.c      |  31 +++
 4 files changed, 460 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

diff --git a/tools/testing/selftests/bpf/prog_tests/dynamicload.c b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
new file mode 100644
index 000000000000..799c43034ff9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/dynamicload.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_dynamicload.skel.h"
+
+/* prog4 is tagged __load_dynamic in the source instead of being set
+ * imperatively; verify that an explicit bpf_program__set_load_type() call
+ * before load overrides the tag's declarative default.
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
+	err = bpf_program__set_load_type(skel->progs.prog4, BPF_PROG_LOAD_TYPE_DISABLED);
+	if (!ASSERT_OK(err, "set_load_type_disabled"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog4), BPF_PROG_LOAD_TYPE_DISABLED,
+		       "prog4_load_type_overridden"))
+		goto cleanup;
+
+	/* keep the other dynamic-load-only programs out of the way of this load */
+	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
+	bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DISABLED);
+
+	err = test_dynamicload__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	/* prog4 was never loaded, so it cannot be loaded dynamically either */
+	err = bpf_program__load_dynamically(skel->progs.prog4, 0);
+	ASSERT_ERR(err, "load_dynamically_after_override");
+
+cleanup:
+	test_dynamicload__destroy(skel);
+}
+
+void test_dynamicload(void)
+{
+	struct bpf_link *link;
+	struct test_dynamicload *skel;
+	int err;
+
+	skel = test_dynamicload__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* the __load_dynamic tag alone, with no imperative call, must set
+	 * prog4's load type before it is ever touched below
+	 */
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog4), BPF_PROG_LOAD_TYPE_DYNAMIC,
+		       "prog4_tag_load_type"))
+		goto cleanup;
+	if (!ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog4), "prog4_autoattach"))
+		goto cleanup;
+
+	/* don't load prog1 */
+	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
+
+	/* prog2 is autoload */
+	bpf_program__set_load_type(skel->progs.prog2, BPF_PROG_LOAD_TYPE_AUTO);
+
+	/* prog3 is dynamically loaded */
+	bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
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
+	err = bpf_program__load_dynamically(skel->progs.prog1, 0);
+	if (!ASSERT_ERR(err, "load_dynamically_disabled"))
+		goto cleanup;
+
+	/* prog1 is disabled for load */
+	err = bpf_program__unload_dynamically(skel->progs.prog1);
+	if (!ASSERT_ERR(err, "unload_dynamically_disabled"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__load_dynamically(skel->progs.prog2, 0);
+	if (!ASSERT_ERR(err, "load_dynamically_autoload"))
+		goto cleanup;
+
+	/* prog2 is autoload */
+	err = bpf_program__unload_dynamically(skel->progs.prog2);
+	if (!ASSERT_ERR(err, "unload_dynamically_autoload"))
+		goto cleanup;
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
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (!ASSERT_OK(err, "load_dynamically"))
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
+	/* detach prog3 as test_dynamicload__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
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
+	/* unload prog3 */
+	err = bpf_program__unload_dynamically(skel->progs.prog3);
+	if (!ASSERT_OK(err, "unload_dynamically"))
+		goto cleanup;
+
+	/* reload prog3 */
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (!ASSERT_OK(err, "load_dynamically_reload"))
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
+	/* detach prog3 as test_dynamicload__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
+	if (!ASSERT_OK(err, "link_destroy_reattach"))
+		goto cleanup;
+
+	/* verify regular unload for dynamically loaded program,
+	 * unload prog3 as a regular program
+	 */
+	bpf_program__unload(skel->progs.prog3);
+
+	/* reset the call flags after unload */
+	skel->bss->prog2_called = false;
+	skel->bss->prog3_called = false;
+
+	usleep(1);
+
+	ASSERT_TRUE(skel->bss->prog2_called, "prog2_called");
+	ASSERT_FALSE(skel->bss->prog3_called, "prog3_called");
+
+	/* reloading prog3 must fail as it was unloaded as a regular program */
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	ASSERT_ERR(err, "load_dynamically_after_regular_unload");
+
+	/* run prog4 (declaratively tagged) through the same dynamic
+	 * load/attach/trigger/detach/unload cycle as prog3
+	 */
+	err = bpf_program__load_dynamically(skel->progs.prog4, 0);
+	if (!ASSERT_OK(err, "prog4_load_dynamically"))
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
+	if (!ASSERT_OK(err, "prog4_link_destroy"))
+		goto cleanup;
+
+	err = bpf_program__unload_dynamically(skel->progs.prog4);
+	ASSERT_OK(err, "prog4_unload_dynamically");
+
+	test_dynamicload__destroy(skel);
+
+	/* separate scenario: imperative override of the declarative tag */
+	dynamicload_verify_override();
+	return;
+
+cleanup:
+	test_dynamicload__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/prog_tests/load_type.c b/tools/testing/selftests/bpf/prog_tests/load_type.c
new file mode 100644
index 000000000000..fc91f6666c50
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/load_type.c
@@ -0,0 +1,167 @@
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
+	bpf_program__set_load_type(skel->progs.prog1, BPF_PROG_LOAD_TYPE_DISABLED);
+
+	/* load and attach prog2 */
+	bpf_program__set_load_type(skel->progs.prog2, BPF_PROG_LOAD_TYPE_AUTO);
+	if (!ASSERT_TRUE(bpf_program__autoload(skel->progs.prog2), "prog2_autoload"))
+		goto cleanup;
+
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (!ASSERT_OK(err, "set_load_type_dynamic"))
+		goto cleanup;
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_DYNAMIC,
+		       "prog3_load_type"))
+		goto cleanup;
+
+	/* bpf_program__set_autoload() is a thin forwarder to set_load_type(),
+	 * restricted to AUTO/DISABLED to preserve its original bool on/off
+	 * meaning; it does change the load type of a program that isn't
+	 * currently BPF_PROG_LOAD_TYPE_AUTO.
+	 */
+	err = bpf_program__set_autoload(skel->progs.prog3, false);
+	if (!ASSERT_OK(err, "set_autoload_false"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_DISABLED,
+		       "prog3_load_type_after_false"))
+		goto cleanup;
+
+	err = bpf_program__set_autoload(skel->progs.prog3, true);
+	if (!ASSERT_OK(err, "set_autoload_true"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_AUTO,
+		       "prog3_load_type_after_true"))
+		goto cleanup;
+
+	/* set_autoload() only accepts AUTO/DISABLED, to preserve its original
+	 * on/off meaning; DYNAMIC must go through set_load_type()
+	 */
+	err = bpf_program__set_autoload(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (!ASSERT_ERR(err, "set_autoload_dynamic_rejected"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_AUTO,
+		       "prog3_load_type_unchanged_after_rejected_autoload"))
+		goto cleanup;
+
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (!ASSERT_OK(err, "set_load_type_dynamic_enum"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_DYNAMIC,
+		       "prog3_load_type_after_dynamic_enum"))
+		goto cleanup;
+
+	/* leaving DYNAMIC for AUTO must restore autoattach (regression test for
+	 * the autoattach residue bug: set_dynamicload() clears autoattach, and
+	 * nothing used to restore it on exit)
+	 */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_AUTO);
+	if (!ASSERT_OK(err, "set_load_type_auto"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_AUTO,
+		       "prog3_load_type_auto"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3), "prog3_autoattach_restored"))
+		goto cleanup;
+
+	/* the same residue can relay through DISABLED and resurface on a later
+	 * DISABLED -> AUTO transition, so the fix must cover both exit edges
+	 */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (!ASSERT_OK(err, "set_load_type_dynamic_again"))
+		goto cleanup;
+
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DISABLED);
+	if (!ASSERT_OK(err, "set_load_type_disabled"))
+		goto cleanup;
+
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_AUTO);
+	if (!ASSERT_OK(err, "set_load_type_auto_via_disabled"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog3),
+			 "prog3_autoattach_restored_via_disabled"))
+		goto cleanup;
+
+	/* an out-of-range load type is rejected */
+	err = bpf_program__set_load_type(skel->progs.prog3, (enum bpf_prog_load_type)999);
+	if (!ASSERT_ERR(err, "set_load_type_invalid"))
+		goto cleanup;
+
+	/* change the type back to BPF_PROG_LOAD_TYPE_DYNAMIC for the rest of the test */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DYNAMIC);
+	if (!ASSERT_OK(err, "set_load_type_dynamic_final"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(bpf_program__load_type(skel->progs.prog3), BPF_PROG_LOAD_TYPE_DYNAMIC,
+		       "prog3_load_type_final"))
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
+	/* loaded program type cannot be changed */
+	err = bpf_program__set_load_type(skel->progs.prog3, BPF_PROG_LOAD_TYPE_DISABLED);
+	ASSERT_ERR(err, "set_load_type_after_load");
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
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (!ASSERT_OK(err, "load_dynamically_1"))
+		goto cleanup;
+
+	err = bpf_program__load_dynamically(skel->progs.prog3, 0);
+	if (!ASSERT_OK(err, "load_dynamically_2"))
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
+	/* detach prog3 as test_load_type__destroy doesn't detach dynamically loaded programs */
+	err = bpf_link__destroy(link);
+	ASSERT_OK(err, "link_destroy");
+
+cleanup:
+	test_load_type__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_dynamicload.c b/tools/testing/selftests/bpf/progs/test_dynamicload.c
new file mode 100644
index 000000000000..6f5a5cb89803
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_dynamicload.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+bool prog3_called = false;
+bool prog4_called = false;
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
+SEC("raw_tp/sys_enter")
+__load_dynamic
+int prog4(const void *ctx)
+{
+	prog4_called = true;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
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

