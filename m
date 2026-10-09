Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A945563C;
	Fri,  9 Oct 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545074; cv=none; b=U+VJKKX85txWO3u01tC9zfhNUmxlbm4a/mQclU+pdEO5gVe0bemsNyFntXHeLNRWfgbfQWBpPAsVjVMfnxmns6dD+lh4IGxl/ENwtjxUqzRIRU89ti8OM7JP42NEtUST1r213eTKUZpYfB8y85UXVdsZbCWj+Rfll1RO2hmcCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545074; c=relaxed/simple;
	bh=JTOAe0WMVeMIfFPb9biGr/1hyvAxGzlIzCkCUbkikqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yb+WUv4eqRiiWYEzONv8GVdyVVZe2jUwD12RS16s1aNwEVgX+C/G61Wmok4a5gqytiEehxNHltgsEmwS7jj1L0grNucqfLvjUtwgo1f5v/2Ti9xMb1o0lD8LOpdEqBr0piB6KHbJ3YW2xFqX6AtSy+hPv2fHLruGyIdMBcBQYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOonaN69; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOonaN69"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698K9hqt1377913;
	Fri, 9 Oct 2026 11:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=y66z2
	bLOwa85XnfgLXjz5KVIShSicVkgR4cQw0Jd7Oc=; b=AOonaN69m6l9D3yKS/eWz
	YBRB63c/LpgkwV0pXfcgSVfAWn47hJxnoWCfNT7n8yskvdUWHxs189QRm2FTeIcG
	jBkdfv4GcSnmm67XmKWyK5jCozDilihbKYDbmbjoRuBSI7RTx/qfLuSaysKedmIi
	+LORfF1X3RQsptjYCfNmI7whAElGcuE7CokXzXN6sMx7lpLdmISX+Lea+99YBA++
	ushNd5P0kN57xqbNPnE6fWB8Pisn3l+Znk5Avq9a9FmDL5eIB9JRQdTGgSYO2xwg
	kGAFzRCk6Uy96DVV6FErdEEr+xExaUIeEjQcI2tt9/ZIvd0VmIf3qvQFKBs8ERd7
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xeyb0jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLjSX039833;
	Fri, 9 Oct 2026 11:23:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsngy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:53 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRke006543;
	Fri, 9 Oct 2026 11:23:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-8;
	Fri, 09 Oct 2026 11:23:52 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 7/7] selftests/bpf: Add a test verifying inline information
Date: Fri,  9 Oct 2026 12:23:24 +0100
Message-ID: <20261009112324.1442319-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-ORIG-GUID: pxBHudGmAU0hDe0in06RlnXT3Vid6ap-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX9h/94Vi3nobv
 Y4AtBOT/r7Og1z0sfpzt17ggS68svUPPTNoX4ofIOgydvH3hQmG+HuruAEVkaVLEOqhcFcdqTLk
 diEW/es5ws5OxoXZ0YD8Lj/oBvkdNlqT04Hdc9mmJtQteUXkd7HQ
X-Proofpoint-GUID: pxBHudGmAU0hDe0in06RlnXT3Vid6ap-
X-Authority-Analysis: v=2.4 cv=e6mT2qp/ c=1 sm=1 tr=0 ts=6ac8ceca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=3OloApC0oWR4td_TvfEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX/ejD/da9gQQL
 8XSSNdnQ8SRMD21g5uOqrYHDBvgM4x6kMjFqzO8Wj4gbd/x3n/aNLG4tzAddWbIwcf4LnM3gjvX
 JGs42ZEsOY4SqIg7dFJjMWN0g0/DAJubQGYZVPE+CeAvq14epwket/w2Va8gts3x2jxqIo5FYMR
 reG/5WEKnFFXfYxKzvUqzhLkmxFgisxqklQNAjOyk/ZtoL4NqlU9poREy6k4DBGxDAykPwwJQud
 qEg02qSFoW6OaHk5LtzIEhPcXQPt5+FibRCr4fRmw3zLfONIIKc4Lw1FKukWmwpYiEmnOITSodT
 fg56MP2Mfd8HGz/e7mV6TpaGAfiWpdLfY2IKyxgfX6ln0VXWBh1yXHa0fzFyKAeJQs6saf1UneM
 WaLNgzb6l2W5R/6cwmkNFLSwUiOTLTah62AIJdA5W0cSgLDwkLOC2HOAH+szryaHfbwAa7aUw57
 rNckpRkWFWTplyhPEF4tBULaKikpGx/5T4QhtRCc=

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
 .../selftests/bpf/prog_tests/btf_inline.c     | 113 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  11 +-
 tools/testing/selftests/bpf/trace_helpers.c   |  20 ++++
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 4 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
new file mode 100644
index 000000000000..d88fab6429b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
@@ -0,0 +1,113 @@
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
+ */
+void test_btf_inline(void)
+{
+	struct btf *inline_btf = NULL, *btf = NULL, *vmlinux_btf = NULL;
+	const char *inline_caller = "bpf_testmod_test_write";
+	const char *inline_func = "testmod_inline_len";
+	unsigned long long caller_addr, base_addr;
+	bool skip = false, found_loc = false;
+	const struct btf_loc_param *lp;
+	int locsec_id, func_id, n, i;
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
+	if (!ASSERT_OK(kallsyms_find(inline_caller, &caller_addr),
+		       "find_inline_caller"))
+		return;
+	if (!ASSERT_NEQ(caller_addr, 0, "caller_addr_nonzero"))
+		return;
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
+	if (!ASSERT_OK(err, "parse_inline_btf"))
+		goto out;
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
+	if (!ASSERT_GT(*p, 0, "loc_proto_has_loc_param"))
+		goto out;
+	t = btf__type_by_id(inline_btf, *p);
+	if (!ASSERT_OK_PTR(t, "loc_param_ptr"))
+		goto out;
+	lp = btf_loc_param(t);
+	if (!ASSERT_TRUE(lp->flags & BTF_LOC_PARAM_REG, "param_has_reg"))
+		goto out;
+	if (!ASSERT_GT(l->offset, caller_addr, "inline_gt_caller"))
+		goto out;
+	/* simple sanity test to roughly ensure inline site still in function */
+	if (!ASSERT_LT(l->offset, caller_addr + 512, "inline_in_caller"))
+		goto out;
+out:
+	btf__free(inline_btf);
+	btf__free(btf);
+	btf__free(vmlinux_btf);
+	if (skip)
+		test__skip();
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 93847ca6293b..b4f0af2aeca4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -735,6 +735,13 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 EXPORT_SYMBOL(bpf_testmod_test_read);
 ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
 
+static __always_inline size_t testmod_inline_len(size_t len)
+{
+	/* Keep an instruction in the inline site without changing len. */
+	asm volatile("" : "+m"(len));
+	return len;
+}
+
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -743,7 +750,7 @@ bpf_testmod_test_write(struct file *file, struct kobject *kobj,
 	struct bpf_testmod_test_write_ctx ctx = {
 		.buf = buf,
 		.off = off,
-		.len = len,
+		.len = testmod_inline_len(len),
 	};
 
 	trace_bpf_testmod_test_write_bare_tp(current, &ctx);
@@ -802,7 +809,7 @@ static struct testmod_uprobe uprobe = {
 	.consumer.ret_handler = uprobe_ret_handler,
 };
 
-static int testmod_register_uprobe(loff_t offset)
+static __always_inline int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 679008b310d9..f3a1d627699d 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -244,6 +244,26 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	return err;
 }
 
+unsigned long long module_get_base_addr(const char *module)
+{
+	unsigned long long addr, base_addr = 0;
+	char name[500];
+	FILE *f;
+
+	f = fopen("/proc/modules", "r");
+	if (!f)
+		return 0;
+
+	while (fscanf(f, "%499s %*s %*s %*s %*s 0x%llx", name, &addr) == 2) {
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
index 01c8ecc45627..eb0d0d9804d6 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -38,6 +38,7 @@ typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
 int load_kallsyms(void);
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
+unsigned long long module_get_base_addr(const char *module);
 
 struct ksyms *load_kallsyms_local(void);
 struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
-- 
2.43.5

