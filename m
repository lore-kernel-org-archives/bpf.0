Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901654;
	b=t4mgJ5pthcngx9sbrDookMA3s7a13YJtS/X7Kl6+ku5Zt4vEDKB6yPFqgostJCZeCjgV
	 bw948eSGBCnTzeLGA3HE6X6AJMrjJUSShwKkWRWRk+lcyQ+KsWPXFv5K6dnWnwavDHApz
	 KNhTceai5swyGWeWY34YXBk2GbIvj6ZEPvwCiJTcyCFhgP+WGsORePus4+LslBN+gz0IO
	 rWOstlK2AQuNP/OscMjWYOiEVd/whiZEuRWb+dblLfjYG9+PAs/tlxwi2yyQTToVhtzyz
	 uD4S8EboCzDgiMJhKcrgNPIcxBo8ibhPliZurhpHugKp8JQHoIcryLlGXLYRPSwFqSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N7GvyPihWFSXbqG1c9TsWBGoWUgWzZlaISD/Mr4e88Q=;
	b=oyHViY3+Gev5149Y2sEGNv/Xb/oOb3/vW/Ng9Xty6cN0Z0ZNebgIj9Rfim2zXWvVAQ91
	 gbLaITYGhIgqV9QZ+/UCREYAQvwUAoth3e5d+6R03DBOAgandtbevoVegyFE4kAVmBY0q
	 Rnn9nBR3TYzTA9nMKkXKtPqXGtmAe1qNh/65Q95PkkjLlV1RqgWT2txm5I5nKXwxZX6+w
	 fa7Fj5AV5Qb2PLPAbG/bxwlBEXijfxfZxrwFqt/mfPjpZLcwAg2XMT/QdWSsF1o7M/XMV
	 mGk/7Dkwx1q9q0CmJvefILSqEeZnudyctVX4taWyFawRoVBO1ML+WQHudVL9/jW0T8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="CAqW7O/Q";
	arc=none smtp.remote-ip=95.215.58.97
Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2D606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B2D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CAqW7O/Q
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5u/pfEdVLFSNM+3mpt3QF/ZaL5EocmOqvHpnP7b4tdY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901651; v=1; x=1794506451;
 b=CAqW7O/QdRMwnf44gkKX0eGxJNAsUP7hfklELSiSw9AEcFYcdUiaCjQeYSveg2GVMrMUM2Zi
 0MnuHfM8blQ8F7w+5B1MmYhDO+jLR1h+2LdJ0qxvVmHPLfBm5m+0h9es2b22wwL2SHqgEBCorPR
 xMFBpwTWSO857PiCATYUQWbo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ef12d0ad92044af;
	Thu, 05 Nov 2026 18:00:31 +0000
X-Mizu-Trace-ID: 4ef12d0ad92044af
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
Subject: [PATCH bpf-next v4 10/17] bpftool: Apply __bpf_relocatable per record on BTF dump
Date: Thu,  5 Nov 2026 10:58:38 -0700
Message-ID: <20261105175845.30357-11-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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
kflagged decl tags rendered by btf_dump. Add the tags to the split BTF
that bpftool dumps through. The tags use the __bpf_relocatable macro,
which by default expands to __attribute__((preserve_access_index)) if
the compiler supports it.

Programs built with Clang are unchanged.

GCC-BPF programs can now get CO-RE relocations from vmlinux.h. The
selftests GCC-BPF build defines BPF_NO_PRESERVE_ACCESS_INDEX, so it is
not affected yet.

[1]: https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2]: https://lore.kernel.org/bpf/20260929234608.48503-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                       | 34 +++++++++++++++----
 .../bpf/bpftool_btf_dump_sorted.expected      | 16 ++++-----
 .../bpf/bpftool_btf_dump_unsorted.expected    | 16 ++++-----
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index b4516361a3fe..aa4290d5cabc 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1131,6 +1131,24 @@ static int btf_c_annotate_type_tags(struct btf *btf)
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
@@ -1153,6 +1171,10 @@ static int dump_btf_c(struct btf *btf,
 	if (err)
 		goto done;
 
+	err = btf_c_annotate_records(split);
+	if (err)
+		goto done;
+
 	d = btf_dump__new(split, btf_dump_printf, NULL, NULL);
 	if (!d) {
 		err = -errno;
@@ -1162,8 +1184,12 @@ static int dump_btf_c(struct btf *btf,
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
@@ -1207,10 +1233,6 @@ static int dump_btf_c(struct btf *btf,
 			goto done;
 	}
 
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute pop\n");
-	printf("#endif\n");
-	printf("\n");
 	printf("#endif /* __VMLINUX_H__ */\n");
 
 done:
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

