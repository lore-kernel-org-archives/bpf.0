Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403283;
	b=dWmElYDNOIWOw/H621fh9IHbFwyjNiKLw97fobjMLx3xv+jD+HQS40ZtNadgtDeJ/oct
	 2aHvq7IrJD0wZuIqQJLnFcTYcnG0q6gkpxE+NaJeGW10KW+BxJEXAEQfFdUwP3HYiNpOI
	 gAbTOSElMdxgtW7F9NJq9hp5mgTybl078Z8MI3S7aiXea3ydrGZUAXkjfjnthG144RV8z
	 r1zaplSUUk5NZjZL29+9EaEGValzL2zQlZY0Oba126fIcQhrxgvBlz2yNEozxoEV3IaRt
	 V/pYnFF+f2dxNjgMNZB+YWe8ynzBe3GZw+/WLgzu61HTn+uHaBa7iaLScW2XC2wALqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403283;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jZvjQvVeoI3Kg8mtWiz0bvNLqUllQv+dL5RS6q+lszw=;
	b=vjgXExDn9YTMw8GX0g6G5PSlOrzwmV6hUCu6gUOKiq9YHTv0zyGv82zhecTXR9D8cahF
	 /ESGkjlWo2fEDrGa1cQzFDsFVtG2EqcnTaDCjqB9vqaMfwcNTkIzK6kPYgJHklsNMyeJA
	 8eMau6dIhiSqGG5XF1L/CILuzyWzw0/M9j8Dc7ZsuNkehGOTD+zat510uBFmTuaRbTk2k
	 iBqriYgPCimcXlnVN518VO9uYJO2uiKGET21IVL8aNGncRu5ZixwzvOZPO3KTXsTHnrsK
	 urdM1sc8dShnB3VwwCJvhF+3y2j/binfMQj/aFXEhjIQeMQambc95Zymq7aj7ebLOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="NvoW+B/D";
	arc=none smtp.remote-ip=91.218.175.17
Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDE606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NvoW+B/D
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KAKyl8fnGYa1yLe6G6nJ+Wty6KRGC8SDMgrDisgIb6s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403280; v=1; x=1794008080;
 b=NvoW+B/DPY3udyfqVLm+sW4uyy3Rkvc23TJQAFgx8GvDS+EwFIc625VzmpygXJqjdDVNU5Mj
 pu0u0Mb6yVp7xLdVsxg2jiTroubeaVZkk44+6yWygdZEfHlmaTkJK0qyRLnSvOKX8Nhp8a0+2WS
 l+q6YZ3xcRcaPYdXiMYnwY/o=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f8b8da8ebfed274b;
	Fri, 30 Oct 2026 23:34:40 +0000
X-Mizu-Trace-ID: f8b8da8ebfed274b
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
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 08/13] bpftool: Apply __bpf_relocatable per record on BTF dump
Date: Fri, 30 Oct 2026 16:33:50 -0700
Message-ID: <20261030233355.1836749-9-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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

bpftool wraps the C dump in a clang attribute pragma that applies
preserve_access_index to every struct and union, so field accesses
through vmlinux.h types get CO-RE relocations. GCC-BPF supports the
attribute but not the pragma, so it gets no CO-RE from the header.

Jose proposed replacing the Clang pragmas with per-record attributes
in May 2024 [1]. The declaration attribute support in btf_dump [2] now
provides the per-type control discussed in that thread.

Apply the attribute to each struct and union definition instead, as
kflagged decl tags rendered by btf_dump. Add the tags to a split BTF
over the input, so the input stays read-only. The tags use the
__bpf_relocatable macro, which by default expands to
__attribute__((preserve_access_index)) if the compiler supports it.

Programs built with Clang are unchanged.

GCC-BPF programs can now get CO-RE relocations from vmlinux.h. The
selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX, so it is
not affected yet.

[1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                       | 60 +++++++++++++++----
 .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
 .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
 3 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 94237befec67..5f5c054d7366 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1123,26 +1123,65 @@ static int btf_c_fixup_legacy_arena_tags(struct btf *btf)
 	return 0;
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
+		err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int dump_btf_c(struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct sort_datum *datums = NULL;
-	struct btf_dump *d;
+	struct btf_dump *d = NULL;
+	struct btf *split;
+	size_t ptr_sz;
 	int err = 0, i;
 
 	err = btf_c_fixup_legacy_arena_tags(btf);
 	if (err)
 		return err;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-	if (!d)
+	split = btf__new_empty_split(btf);
+	if (!split)
 		return -errno;
 
+	/* btf__new_empty_split() does not inherit the base pointer size */
+	ptr_sz = btf__pointer_size(btf);
+	if (ptr_sz)
+		btf__set_pointer_size(split, ptr_sz);
+
+	err = btf_c_annotate_records(split);
+	if (err)
+		goto done;
+
+	d = btf_dump__new(split, btf_dump_printf, NULL, NULL);
+	if (!d) {
+		err = -errno;
+		goto done;
+	}
+
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
+	printf("#ifndef __bpf_relocatable\n");
+	printf("#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)\n");
+	printf("#define __bpf_relocatable __attribute__((preserve_access_index))\n");
+	printf("#else\n");
+	printf("#define __bpf_relocatable\n");
+	printf("#endif\n");
 	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
@@ -1165,10 +1204,10 @@ static int dump_btf_c(struct btf *btf,
 				goto done;
 		}
 	} else {
-		int cnt = btf__type_cnt(btf);
+		int cnt = btf__type_cnt(split);
 
 		if (sort_dump)
-			datums = sort_btf_c(btf);
+			datums = sort_btf_c(split);
 		for (i = 0; i < cnt; i++) {
 			int idx = datums ? datums[i].index : i;
 
@@ -1181,20 +1220,17 @@ static int dump_btf_c(struct btf *btf,
 				goto done;
 		}
 
-		err = dump_btf_kfuncs(d, btf);
+		err = dump_btf_kfuncs(d, split);
 		if (err)
 			goto done;
 	}
 
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute pop\n");
-	printf("#endif\n");
-	printf("\n");
 	printf("#endif /* __VMLINUX_H__ */\n");
 
 done:
 	free(datums);
 	btf_dump__free(d);
+	btf__free(split);
 	return err;
 }
 
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 5470b2b43229..f2389e3dceed 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_relocatable
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_relocatable __attribute__((preserve_access_index))
+#else
+#define __bpf_relocatable
+#endif
 #endif
 
 #ifndef __ksym
@@ -30,19 +34,15 @@ struct holey {
 	long: 32;
 	long: 32;
 	int tail;
-};
+} __bpf_relocatable;
 
 struct s {
 	int f;
-};
+} __bpf_relocatable;
 
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
 #endif
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute pop
-#endif
-
 #endif /* __VMLINUX_H__ */
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 4310adc2ed51..549045677a45 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_relocatable
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_relocatable __attribute__((preserve_access_index))
+#else
+#define __bpf_relocatable
+#endif
 #endif
 
 #ifndef __ksym
@@ -26,7 +30,7 @@ struct holey {
 	long: 32;
 	long: 32;
 	int tail;
-};
+} __bpf_relocatable;
 
 enum {
 	E0 = 1,
@@ -34,15 +38,11 @@ enum {
 
 struct s {
 	int f;
-};
+} __bpf_relocatable;
 
 
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

