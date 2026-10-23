Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794455;
	b=WuiZhBZGrFLsfQnru3/BZ0hvNq7v60h2hge3MqdqQQdJrt0YHrRETxYl9yUjuMR6NVya
	 D2nNkv9tMEiCo63fE+b0GQsXswFLcr6CgvRcA8+q03lvIviDGEgqOAv0C8J/EiuPeKIjU
	 uIiKFnhD/syzvvQ8K2KbhzG6olnr6O69fnq3G1j3wj11SO39W4ou+TqxgJNxBkIHcfXLm
	 WDjAzVxxB3V2i0tw273M1/v+Tjo0DO0waD0I1KvjvkXeXJWk4tg7T9SoT9wu0pntJmAEB
	 Kiig3MOKrEtXowvAMzNbpRlDffdAYjhvC23aWLV+Qccc11e6DNoLTt+4edNHzwTAtlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794455;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q5AF+XFDjk7butA7mSCRTc7j88RDHvfQWk0fB+6qECg=;
	b=AOs/4sVVPgfV2uBD2I1W+hUVFT7/wqfux2TrpTi11FWjCkIJAzRlNoRT1SGbnjoB1v5c
	 bNGc64wHo0V3lmbwJyFYo47E+F5tsK5vCHWrsCjImCUDZ/fliyBBbvYh6mcHoKusUHDYs
	 ofdDYan404yZR7bcWQJ3cYvUv7mIMWQyS8MdEDu6uy9sLeqXLXLjKXcaeScbPw96JxwRZ
	 C5Rn+g0Ghmmyw+ULaj/Aj/+NUDugJ0taA6UixFuJEjJutQBUvifiUxj6lA6c1SPwC3DSc
	 I15iprsijoaiJJ4+XIxVfSJk/ZqwwwKQ+/qqMSzlVGizAkYSCGI0+MVb50LDpNKUpCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="NxNE9/CX";
	arc=none smtp.remote-ip=95.215.58.144
Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3B606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C3B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NxNE9/CX
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JIv66zWdN2zwBdjUXFLXICOWFDvMbcDXpyD1GitV5ys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794452; v=1; x=1793399252;
 b=NxNE9/CXn2cMg1JQKIw8RwT+EaQ2xnDwDw0wAk8oCd4j1xAGXAwS9utVqoETekm4w0iBQ4Wq
 hP/TQ5RpGPtArXm+GsIZpr//YCFuotpJjQlZduq8I8mZFoTTOuabkRF9+B9lvpJsqV6h/MH+qTN
 R+vZiOZObA+D55TVP5KJtQHw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ad946f9876a3b876;
	Fri, 23 Oct 2026 22:27:31 +0000
X-Mizu-Trace-ID: ad946f9876a3b876
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
Subject: [PATCH bpf-next v2 3/8] bpftool: Apply __bpf_relocatable per record on BTF dump
Date: Fri, 23 Oct 2026 15:26:47 -0700
Message-ID: <20261023222652.3927736-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
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
preserve_access_index if compiler supports it.

Clang output is unchanged.

GCC-BPF programs now can get CO-RE relocations from vmlinux.h, however
the selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX and
is unaffected yet.

[1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                       | 62 +++++++++++++++----
 .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++---
 .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++---
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index abd661db91e6..5a2c5341b736 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1092,22 +1092,61 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
-static int dump_btf_c(const struct btf *btf,
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
+static int dump_btf_c(struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
 	struct sort_datum *datums = NULL;
-	struct btf_dump *d;
+	struct btf_dump *d = NULL;
+	struct btf *split;
+	size_t ptr_sz;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
-	if (!d)
+	split = btf__new_empty_split(btf);
+	if (!split)
 		return -errno;
 
+	/* Retain the native default if the pointer size cannot be inferred. */
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
+	printf("#define __bpf_relocatable preserve_access_index\n");
+	printf("#else\n");
+	printf("#define __bpf_relocatable\n");
+	printf("#endif\n");
 	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
@@ -1130,10 +1169,10 @@ static int dump_btf_c(const struct btf *btf,
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
 
@@ -1146,20 +1185,17 @@ static int dump_btf_c(const struct btf *btf,
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
index 5470b2b43229..97664633931f 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_relocatable
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_relocatable preserve_access_index
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
+} __attribute__((__bpf_relocatable));
 
 struct s {
 	int f;
-};
+} __attribute__((__bpf_relocatable));
 
 
 /* BPF kfuncs */
 #ifndef BPF_NO_KFUNC_PROTOTYPES
 #endif
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute pop
-#endif
-
 #endif /* __VMLINUX_H__ */
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 4310adc2ed51..edc8c5b708d7 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -1,8 +1,12 @@
 #ifndef __VMLINUX_H__
 #define __VMLINUX_H__
 
-#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
-#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
+#ifndef __bpf_relocatable
+#if !defined(BPF_NO_PRESERVE_ACCESS_INDEX) && __has_attribute(preserve_access_index)
+#define __bpf_relocatable preserve_access_index
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
+} __attribute__((__bpf_relocatable));
 
 enum {
 	E0 = 1,
@@ -34,15 +38,11 @@ enum {
 
 struct s {
 	int f;
-};
+} __attribute__((__bpf_relocatable));
 
 
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

