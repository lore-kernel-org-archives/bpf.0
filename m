Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D647535E;
	Sat,  3 Oct 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056682; cv=none; b=OgiYz09UERKWLMeZtESYoGIfzcmJTQQquVBNh5xTiyk1+Dt6jgYLXmg2pO19lKyeCT4RcZ97O8c8HIOSbl/ukkKIsMsiD2Cy7nPJFUsLhPgvLQ+eVbsL1Fx29HxYnkD6LeMjKZD5FcyT4co2bBUtl6l9+foh887CWWnn3xGVEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056682; c=relaxed/simple;
	bh=g4FibTd/gJznHS/c6rvIm4rerHyx/fmN12I9YuvF2Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6XQ/TVvu/3IuDl+99XXoBufDbHL6RITSXN/YlYe6L+RGSvXbM4yVIXW7QxoJruT69PIE5MmHisIQmuRCbzSYRnNLozBpMk5sYYTChN5K582Vu9537+H2OyfUvSXArabNv0e9m9temlVU/py/pzkT+QegU/MHAQRko2T2/LqKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rA9UiOek; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rA9UiOek"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JKr8e161014;
	Sat, 3 Oct 2026 19:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XdrDD
	PLMUhxDSlswm2vtJQ08pmne1cPZZuvtAsv708M=; b=rA9UiOekwh9yROZPykBrC
	iffQV7zKPqYgjoEr71sqqCvlFaWkZQCwEuQ04TAlzXjYIxP9qf4WJJW6Xx0KZqdB
	L+MadkLH4wh8ik2Dg1sESyFKrw2O5ZQWNxF4r8KvfgmhYJf7Bn1fW4oInOmuMW9N
	T1vUWyx7UQ59anbjBbagnlXKKnX0P5qQ+ogBIocBcfmrj7VuIsBIrdd2PharmIZc
	wjSyDMkcx66qguYLkAfs2PUo+eGr4iPqsH685WyTbIS9zJZjtsT8r1qM8cUm6Jcv
	zOyFtRqxhgGiDV9a5SDkxFKPwxMWLCenFrQljiK4afB9TNl2T0BPBCHuOAdfc4Yf
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2r9xrev8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:44:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ1VF004998;
	Sat, 3 Oct 2026 19:44:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yyvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:44:15 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEN7012617;
	Sat, 3 Oct 2026 19:44:14 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-8;
	Sat, 03 Oct 2026 19:44:14 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 7/7] selftests/bpf: Add a test verifying inline information
Date: Sat,  3 Oct 2026 20:43:23 +0100
Message-ID: <20261003194323.817885-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261003194323.817885-1-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-ORIG-GUID: SmIlnU1HnmoVOxeL2abyaNLgwQn1bwLn
X-Proofpoint-GUID: SmIlnU1HnmoVOxeL2abyaNLgwQn1bwLn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX+HDW4GbVfulP
 SjzQileXM98z7nCcyhLeRGdfs9ivb++hpozl/iE4sR+o2FZcfX0ywt3fYGuytTtBUDEOnpE6jVk
 aBQSQAu0RZZTjGARBValqZFestdcAjCqV92mEOidgsn9/RM51kkwLivFJ6ndKg4xNxfFQrTC3fW
 AL1RWjY80oJQZ4utL5dgYP5fTzvaSraM0hXCj1Wq7dOOLlp6sHymqIoyO37AvVfxxTuxWK13U+H
 tFwuspwEogBTtxUsCDa/33Nq/7OI9PGHNpDqrCOSA8ijYTmwxWNYL9S2D4swYGgoHU/we1bZZU6
 PoTSVNpE1ylZRKKMHg+xIxCxeJo7w6tTKHoKLekBsJA4Gtpkb4e1zBAG51OK/sQgPLZwxxRiGdd
 1AxLNBQiTubz+loTQXxkm1Kz97KP8EiB7tvZ2L+DG3tDlsbBXVFRqNYAJGgHwnIbL2+70w8uuv2
 3qMh7orHQBhg3U9hVBw==
X-Authority-Analysis: v=2.4 cv=QbrzLcbv c=1 sm=1 tr=0 ts=6ac15b10 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=ulI_AjJ0Bff_GvI0Ah8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX3/DljZQR5Y8S
 SYjHvE5JVI2pcJS7DtXVXSa/Dq2D1Of3Ef08jsX2z/Q6iXaF7lFKAcBuZwk6Xpo/0DosaBwuNyx
 IkiMu3n/6Bvfou74hX6BIrUR8TIo+3adXGpBm8xiywAZUbRizzXB

For bpf_testmod verify that we have inline info for an
__always_inline'd function and it matches reasonable
expectations (a single location parameter encoded in a
register given that it cannot be compile-time optimized).

Also verify that the offset of the LOCSEC descriptor makes
sense, i.e. that it is in the range of the function where
it was inlined.

Because bpf_testmod is treated as an out-of-tree module,
the inline information will be in btf_testmod.inline which
is relocated using bpf_testmod.ko .BTF.base.

Test is skipped if pahole does not encode inline info.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_inline.c     | 110 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 tools/testing/selftests/bpf/trace_helpers.c   |  20 ++++
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
new file mode 100644
index 000000000000..399b931ace7b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+#define BTF_SYSFS_DIR		"/sys/kernel/btf"
+#define BTF_INLINE_SUFFIX	".inline"
+
+/*
+ * For a specific inline site, verify we have the right function,
+ * loc proto and loc param representation and that the offset is
+ * reasonable given the caller where it was inlined.
+ *
+ * Because bpf_testmod is compiled "out-of-tree" we have inline
+ * information in the split BTF directly rather than in btf_testmod.inline.
+ */
+void test_btf_inline(void)
+{
+	struct btf *inline_btf = NULL, *btf = NULL, *vmlinux_btf = NULL;
+	const char *inline_caller = "bpf_testmod_uprobe_write";
+	const char *inline_func = "testmod_register_uprobe";
+	bool skip = false, found_loc = false;
+	const struct btf_loc_param *lp;
+	int locsec_id, func_id, n, i;
+	long caller_addr, base_addr;
+	const struct btf_type *t;
+	struct btf_loc *l;
+	const __u32 *p;
+	int err = 0;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	base_addr = module_get_base_addr("bpf_testmod");
+	if (!ASSERT_NEQ(base_addr, 0, "base_addr_nonzero"))
+		return;
+
+	load_kallsyms();
+	caller_addr = ksym_get_addr(inline_caller);
+	if (!ASSERT_NEQ(caller_addr, 0, "caller_addr_nonzero"))
+		return;
+
+	if (!ASSERT_GT(caller_addr, base_addr, "caller_addr_gt_base_addr"))
+		return;
+	caller_addr -= base_addr;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux_btf"))
+		return;
+
+	btf = btf__parse_split(BTF_SYSFS_DIR "/bpf_testmod", vmlinux_btf);
+	if (!ASSERT_OK_PTR(btf, "bpf_testmod_btf"))
+		goto out;
+
+	inline_btf = btf__parse_split(BTF_SYSFS_DIR "/bpf_testmod" BTF_INLINE_SUFFIX,
+				      btf);
+	err = libbpf_get_error(inline_btf);
+	/* pahole may not have inline BTF feature support. */
+	if (err == -ENOENT) {
+		skip = true;
+		goto out;
+	}
+	locsec_id = btf__find_by_name_kind(inline_btf, "inline.text", BTF_KIND_LOCSEC);
+	if (locsec_id < 0) {
+		skip = true;
+		goto out;
+	}
+	func_id = btf__find_by_name_kind(inline_btf, inline_func, BTF_KIND_FUNC);
+	if (!ASSERT_GT(func_id, 0, "inline_caller_func"))
+		goto out;
+	t = btf__type_by_id(inline_btf, locsec_id);
+	n = btf_vlen(t);
+	for (i = 0, l = btf_locsec_locs(t); i < n; i++, l++) {
+		if (l->func == func_id) {
+			found_loc = true;
+			break;
+		}
+	}
+	if (!ASSERT_TRUE(found_loc, "found_loc"))
+		goto out;
+	if (!ASSERT_GT(l->loc_proto, 0, "loc_proto_id"))
+		goto out;
+	if (!ASSERT_GT(l->offset, 0, "loc_offset"))
+		goto out;
+	t = btf__type_by_id(inline_btf, l->loc_proto);
+	if (!ASSERT_OK_PTR(t, "loc_proto_ptr"))
+		goto out;
+	if (!ASSERT_EQ(btf_vlen(t), 1, "loc_proto_one_param"))
+		goto out;
+	p = btf_loc_proto_params(t);
+	t = btf__type_by_id(inline_btf, *p);
+	lp = btf_loc_param(t);
+	if (!ASSERT_EQ(lp->flags, BTF_LOC_PARAM_REG, "param_is_reg"))
+		goto out;
+	if (!ASSERT_GT(l->offset, caller_addr, "inline_gt_caller"))
+		goto out;
+	/* simple sanity test to roughly ensure inline site still in function */
+	if (ASSERT_LT(l->offset, caller_addr + 256, "inline_in_caller"))
+		goto out;
+out:
+	btf__free(inline_btf);
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+	if (skip)
+		test__skip();
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 93847ca6293b..8b48407ce086 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -802,7 +802,7 @@ static struct testmod_uprobe uprobe = {
 	.consumer.ret_handler = uprobe_ret_handler,
 };
 
-static int testmod_register_uprobe(loff_t offset)
+static __always_inline int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 679008b310d9..bf4cb720e7b8 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -244,6 +244,26 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	return err;
 }
 
+long module_get_base_addr(const char *module)
+{
+	unsigned long long addr, base_addr = 0;
+	char name[500];
+	FILE *f;
+
+	f = fopen("/proc/modules", "r");
+	if (!f)
+		return 0;
+
+	while (fscanf(f, "%s %*s %*s %*s %*s 0x%llx", name, &addr) > 0) {
+		if (strcmp(module, name) == 0) {
+			base_addr = addr;
+			break;
+		}
+	}
+	fclose(f);
+	return base_addr;
+}
+
 #ifdef PROCMAP_QUERY
 int env_verbosity __weak = 0;
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 01c8ecc45627..473508306f79 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -38,6 +38,7 @@ typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
 int load_kallsyms(void);
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
+long module_get_base_addr(const char *module);
 
 struct ksyms *load_kallsyms_local(void);
 struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
-- 
2.43.5

