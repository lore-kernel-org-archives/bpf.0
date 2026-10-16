Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04F25B0BB
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108849; cv=none; b=a7JOIZx+iq5yVbwq6kQ17VWU3PO4J5jDCIX0D0QaRK4F9ybrOzee3jFQlG/sppgAEBUCOpUxD3yQ+mQwUCjUn2NhP0xx3LRBSccv7nbYWZ/EaV30sM69gwcRWVBaX9ndkRqr/3RKE78A75m2B8IWiVA+tQ7isJ3SuSkKeef1Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108849; c=relaxed/simple;
	bh=7Lwl4CAU39voS+YeM77V+Rm05A3fQvpYZ3YKKsnmmIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTVny1ZIZ8CSYNlbrG9Es2iIc9RTSnrSwK9NpzmQYDDJPbwNObSDzJh/KgkVCSP8+tvR0T7y39Pv2VTweaQtUwHJKwMIS4wyNkHD005pahrt+30+pjFQVNwrxJS6x/Qp09GYA5qWt9+uRrJFSIunvtIuo7w6iNDXxfjE2/wjcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cx2Avi3u; arc=none smtp.client-ip=91.218.175.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cx2Avi3u"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7Lwl4CAU39voS+YeM77V+Rm05A3fQvpYZ3YKKsnmmIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108846; v=1; x=1792713646;
 b=cx2Avi3uh104xO13R6DTG8jcGHaUwYlayJnEOvLWVGRo0A5FBGZ7kTm/q7dDDLm86kim0t0g
 2IOUN/vfRWbraiCbT9E+jr0NPstkTpqM99d/GdQIvbf2XbGe/JlZBDRvHXYK0NZ2HiAL2S/s5cq
 h0/HtdtweXbSxQRKjj4cc6EU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8a96208c3063a254;
	Fri, 16 Oct 2026 00:00:45 +0000
X-Mizu-Trace-ID: 8a96208c3063a254
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 3/8] bpftool: Apply __bpf_core_pai per record on BTF dump
Date: Thu, 15 Oct 2026 17:00:07 -0700
Message-ID: <20261016000012.2232059-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool wraps the C dump in a clang attribute pragma that applies
preserve_access_index to every struct and union, so field accesses
through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
attribute but not the pragma, so it gets no CO-RE from the header.

Jose proposed replacing the Clang pragmas with per-record attributes
in May 2024 [1]. The declaration attribute support in btf_dump [2]
now provides the per-type control discussed in that thread.

Apply the attribute to each struct and union definition instead, as
kflagged decl tags on the detached BTF copy, rendered by btf_dump. The
tags use the __bpf_core_pai macro, which expands to
preserve_access_index where supported and to nothing under
BPF_NO_PRESERVE_ACCESS_INDEX.

The attribute covers the same records as the pragma, so Clang output
is unchanged.

[1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                       | 34 +++++++++++++++----
 .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++++-----
 .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++++-----
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index cc15989643cf..6182f2c41db0 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1121,6 +1121,24 @@ static struct btf *btf_c_detached_copy(const struct btf *src)
 	return copy;
 }
 
+static int btf_c_annotate_records(struct btf *btf)
+{
+	__u32 i, cnt = btf__type_cnt(btf);
+	int err;
+
+	for (i = 1; i < cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (!btf_is_composite(t))
+			continue;
+		err = btf__add_decl_attr(btf, "__bpf_core_pai", i, -1);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
@@ -1133,6 +1151,10 @@ static int dump_btf_c(const struct btf *btf,
 	if (!copy)
 		return -errno;
 
+	err = btf_c_annotate_records(copy);
+	if (err)
+		goto done_free;
+
 	d = btf_dump__new(copy, btf_dump_printf, NULL, NULL);
 	if (!d) {
 		err = -errno;
@@ -1142,8 +1164,12 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
+	printf("#ifndef __bpf_core_pai\n");
+	printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)\n");
+	printf("#define __bpf_core_pai preserve_access_index\n");
+	printf("#else\n");
+	printf("#define __bpf_core_pai\n");
+	printf("#endif\n");
 	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
@@ -1187,10 +1213,6 @@ static int dump_btf_c(const struct btf *btf,
 			goto done;
 	}
 
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute pop\n");
-	printf("#endif\n");
-	printf("\n");
 	printf("#endif /* __VMLINUX_H__ */\n");
 
 done:
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 5470b2b43229..02c8fe8b4859 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_core_pai
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_core_pai preserve_access_index
+#else
+#define __bpf_core_pai
+#endif
 #endif
 
 #ifndef __ksym
@@ -30,19 +34,15 @@ struct holey {
 	long: 32;
 	long: 32;
 	int tail;
-};
+} __attribute__((__bpf_core_pai));
 
 struct s {
 	int f;
-};
+} __attribute__((__bpf_core_pai));
 
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
 #endif
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute pop
-#endif
-
 #endif /* __VMLINUX_H__ */
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 4310adc2ed51..9b6589d2bda3 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_core_pai
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_core_pai preserve_access_index
+#else
+#define __bpf_core_pai
+#endif
 #endif
 
 #ifndef __ksym
@@ -26,7 +30,7 @@ struct holey {
 	long: 32;
 	long: 32;
 	int tail;
-};
+} __attribute__((__bpf_core_pai));
 
 enum {
 	E0 = 1,
@@ -34,15 +38,11 @@ enum {
 
 struct s {
 	int f;
-};
+} __attribute__((__bpf_core_pai));
 
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
 #endif
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute pop
-#endif
-
 #endif /* __VMLINUX_H__ */
-- 
2.56.0

