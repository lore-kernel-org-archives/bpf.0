Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DD7483809;
	Tue,  1 Sep 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281976; cv=none; b=jFWlCSBGJcGN8d1AlSjAqNbp3/rTesymuFLBpEx0GGu1RRoJy7JKyGkIz0fs4HaO8HRA1Ashydj9OhobGnTnHLbj+Gk/P6ZgQ6OTj7ekGQRuFFH3jdbKPrp3SrDxfHjxUFFaIcYgg1G9eOe34Z/o/xFNMttQbMNsw5/InhqNCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281976; c=relaxed/simple;
	bh=IrtAgmA69cKeqMVdTVBk9rNSorkZIkkXsj9Mo/YSbk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np5fvoPXazQ2HlITnlSfduN4xOeYSxGZegOih7ER+4ShuXSYzO8yfLHU7NPOJ0L+UoKL/q89nIRA/IS7ClGskme2amByREL9n191UarEosyG2pz8hjYRh82NObtonLrkKqfOiaE3BBfAMMuOf8CfTuWOA+duLU4+6PK/aOLeYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=amQ+IrBK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amQ+IrBK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EMIwe4023903;
	Tue, 1 Sep 2026 16:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aXfE7
	56mEw0GRvAvIX7JVjyBGZ8ZcBWgeZNvNa/0jDQ=; b=amQ+IrBKZvrPON+sIIxEe
	DWG3VB6Lg7JOf1c8uoAuUZRBOd3zD7A5g/cJAgsIOi2vGaZ05kJ8gBNwgZBSZc3K
	6W8fweDSGZY3akDE13WjoyrUfj4NFKRwXQIMu2t9U8zAcHBzexjxl4Z3ZL/vp2QM
	jdWrqtnB6yLl1pEIWeVK+xLPUfojcA8zju4wqIUS6mE43eNxcojIPxuAk3R3MRf7
	Nq6rm4zw+p8G/BMe5y0xJZh1BYbS8LlMjO/Co8AH3Xs+PlsJDd+E3wDlKw0KkHuH
	b0L2FS/+kVsBQPL2ieYGaPvtY59E5BghDTyloF7uXaODXYWjDxPMq2LvYw4oaWo0
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72d3ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjVYi001920;
	Tue, 1 Sep 2026 16:59:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg9dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:07 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WR011129;
	Tue, 1 Sep 2026 16:59:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-19;
	Tue, 01 Sep 2026 16:59:06 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 18/18] selftests/bpf: Add a test verifying inline information
Date: Tue,  1 Sep 2026 17:57:57 +0100
Message-ID: <20260901165757.801449-19-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX/hAWA7nmGLNv
 jNfmlCknB3wPWI/3KscbFSnoMk0zCgjdw7WE59wgKtbM7pq+erqykFWRFToKBdoUG+N8WQ66arv
 +MUwJkogzpJrvlrtxkA+yvuDI6pEvLRvI9fEp9UWRFCaYCzIh6kW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX+j53/Aio/lMt
 9LyXsxiLnZd1DzWcZRGoaOuRYz+UM0R2/cjzxEe3/lsNtxmolB5Su+VcZahd8xhzKvLNhkiAsn/
 qPguQqfcpxF0djHZA0hwuD3a6ubD746Yaj7zyVJtQJJJSd0t8OR5pumev9ULyeN/5g3jLJHJycV
 KfTAm0KHhNVj5C1uHm2WOCKjLq0jyYsBImOCs30B4yg06Ig+BCTlZT1e4uqQdaZcm9hDdkwWWrD
 UTaafK1BiIw6g4bAJxs3S0KeaST0F7mgojMp7xQC/NKO0ay1HmIF5f/d5oNzb7pAoBKxB59ZBne
 SSgESvrkI7Hojer6OZCvOebKj/+I0Pv8hyeqZFXgp+5Q1kbmVHiqgUvJA/SkZMH7ErK2SgpsArh
 1u5CW4j03C1d8A4QKQF/gcnytw31NCnRbThQMEIwdCIoeI+46m4emziudRrDX7Sp8qhSSCRBryT
 DlEjYT3G+Zar5czJHfIN7zw4/xpGUGsVIL4RD9sM=
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a97045c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=ulI_AjJ0Bff_GvI0Ah8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: DXD63WDQ7G7UkbJ1VT4I52KOrd1KHW-3
X-Proofpoint-ORIG-GUID: DXD63WDQ7G7UkbJ1VT4I52KOrd1KHW-3

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
index 000000000000..8e0a85f6c698
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
+	locsec_id = btf__find_by_name_kind(inline_btf, ".text", BTF_KIND_LOCSEC);
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
index 2380b6cbdead..09d910d5e312 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -750,7 +750,7 @@ static struct testmod_uprobe uprobe = {
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

