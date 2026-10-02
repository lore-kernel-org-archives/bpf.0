Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B3495049
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945254; cv=none; b=d1Qko9w5Bu06Y+/2QFQqB3ajK6SU1js8eymPdkP254cbbdrWFFG3onYNAtrLhWYGX2tXoeAUq0Wb41NRpw4Z9gQ/Cg9Gg2y4yBhYUmklejnDvh/tu52fTXzNV1FV50fk6ooiAV767Ybl/g2WRVR1kj/wdBWHAyAFsmsX6k/IVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945254; c=relaxed/simple;
	bh=NSUO4hVvZlZma0Ke9bgBkPvoPZTLx+6Twz96Xy7OlCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tsk+fn44sOTsqFrzigV1O+6gIlXwKYwvTzk+YsltQvcLYTJuvp87ZmRR8QZi8VlISqKcO+077T7jiestOxXYy8HbvztiJjrkkc1+7Gcn+XIg1F/9XWTZS8GzflCJx4DwOXp+8DS85wGHDMP1FIOrI5icELR4Mszg4nco4K9WPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb/P8c5s; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb/P8c5s"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso3060542a91.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945252; x=1791550052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rJ00cYWuKporcFNNrBc+c9CkGMwzbHBsMvy2jda7qM=;
        b=Tb/P8c5szosfca83KbmpTCZmbd/u6O6SLSdhiUzJ/Fgv0gbyuRiNZ2gpTdAWkYJuzj
         +dxXo6ToN3WeG8108celvnY3UfaydKeOLSE6SxFJSXs7yA4VKKzVTtqAprGdV5SKD8v2
         VWdBU5abGPDbo570EqL5bEhXyKaKCHGNfabZLu5YAX8kXneJRMApTTjzAQ3lR8P76xiP
         YCs1Ag5L7a3ZWVZC8fOrnuKfoWV1v4DU/YYm8MDl2/1znpFpQaGdDf7pd3vwS/HMbiYQ
         uniDQ/68sKi0TGJ8RxTL1PhmpclqUdKT3Q0C2Ck8TB19Hy5PAQ5PBjcrMnDRqzP36MZE
         TZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945252; x=1791550052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rJ00cYWuKporcFNNrBc+c9CkGMwzbHBsMvy2jda7qM=;
        b=yARHvDN2Uy+Ci02o4G+cs/H7bLuC/NpZGfeyPv+VM1ZXz1Y2qhuVcGkEv5SYgBgdxV
         /V8MaSFys76TPcD6tR/gM4ACczgsnEvM6iy8mZhq96+f3UUXapsiWoUvF2yuwekfgW2x
         s91uEbK0h0X/hguWBz97KfGT6MhAtIEHCfWOelNuf9tp5FiDPGouBBPpiEObKB04JyrG
         vn0k5odF0h2Ln+MBk1oLPN/nLGXvdQB24qLEKGEwPB2SApNTau7KFrR7ppwO+sl0pajG
         orAJF6xXmr4M7IlmRaTqcJfcZxJlXjcTcn4pd4/dUAMxVxyBCnCRz1ByZ2x1wmDwdYiE
         W9Gw==
X-Gm-Message-State: AFq9FYI0AKzBeN7xOlGQBzwsCvGknt7ARKMD0ST7h+dwPcsT02Qz5z2+
	FdfhStdw27ESeEIsB9ATtNp/JBLKgR7/CXsg3y+b+1pFiZ4cYxLXGERxGuOjppjGRZ0=
X-Gm-Gg: AYBFou3nlKvqPvdypcbLG17aAC7+9ZDAo23k65+UFJzpffVR8aD820xAR/NniT5Y0SV
	bMPM1gOJsaajUzCXY0pwG/zOvXnNr/Wwv8OsW1QnKcs70/CtAR6QhAIpRpjEO3vodXiYoMnQJe5
	eK36H4/whTdV6qsQ8VFwOkxUPU4acYnPv0FJQ+kiH6B1Ft4H1/BXpYvaSKNAgY+EcmJCvq8fLC+
	/5kr+cEIeaRhB8GOKcX78RjZf+PEZH283DZGJrVcn+XA7YBoUbjz4/z521wrfDEK+Dokq09oDfg
	SQhJHks4nAcZ20EU9Y6QtQpfrzG0MxvRNK05lX0e5R23Lovds5sZZDmxpwnMFog+p4kdT8We0N7
	2Xhhy+s0SD+RcjGzO2l13L7vLFZ5stKwTK3qBV55XlyGlh9ga3dlnmv9qiJ2q7k2RtuGRvkR7WT
	ao6Da8IkjUCQC5hvronyfuKOcHwCARmJO+u0lqgYa4fZTbp61jZL0FdtRrg58rb8YRGmKiAzvM2
	jPhEKSxLxHf1JnmLcmjf9FYkOlWh4XkGx2smpaGbnBCGrDOpGYKZQQYiCm61t/Xca8WP81TuSMD
	07/lIGo1dPR5fm9Q/cWYHYn8Iu54nVqUKJaQDva2biY=
X-Received: by 2002:a17:90b:1e53:b0:3a0:a055:1741 with SMTP id 98e67ed59e1d1-3a6ceaff95dmr1392720a91.27.1790945251452;
        Fri, 02 Oct 2026 05:47:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd58ade9sm4188865a91.8.2026.10.02.05.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/15] bpf: Allow names of Rust types and functions in BTF
Date: Fri,  2 Oct 2026 12:47:04 +0000
Message-ID: <20261002124714.180012-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Names of types and functions in BTF that LLVM makes for a Rust program
are not C identifiers:

  [69] STRUCT 'NonNull<str>' size=16 vlen=1
  [147] FUNC 'write_fmt<scx_cosmos::BpfStream>' type_id=146

and the kernel rejects such BTF with "Invalid name". scx_simple and
scx_cosmos schedulers written in Rust have them in STRUCT, FWD and FUNC,
made of letters, digits and " #&()*,:;<>[]{}", 430 characters at most.

Allow any printable character in btf_name_valid_identifier(), like it's
done for DATASEC. It checks names of types, functions, members,
enumerators, variables and arguments, so all of them can have such
characters now. The limit of KSYM_NAME_LEN stays.

The name of FUNC is a part of the name of the program in kallsyms, where
a space would break the parsers. Replace what is not a character of
an identifier with '_' there.

Tests in prog_tests/btf.c expect "Invalid name" for names with '!' and
'*', which are valid now. Put a character that is not printable there.
The type name '?foo' is expected to load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c                             | 15 ++----
 kernel/bpf/core.c                            |  5 ++
 tools/testing/selftests/bpf/prog_tests/btf.c | 52 ++++++++++----------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8cc17a1cd25c..d27af5d8e495 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -901,16 +901,6 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first)
-{
-	if ((first ? !isalpha(c) :
-		     !isalnum(c)) &&
-	    c != '_' &&
-	    c != '.')
-		return false;
-	return true;
-}
-
 const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 {
 	while (offset < btf->start_str_off)
@@ -923,20 +913,21 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
+/* Names in BTF of Rust are not C identifiers. Allow any printable character */
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true))
+	if (!isprint(*src))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false))
+		if (!isprint(*src))
 			return false;
 		src++;
 	}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a1721f9c0f52..36900b02d668 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -18,6 +18,7 @@
  */
 
 #include <uapi/linux/btf.h>
+#include <linux/ctype.h>
 #include <linux/filter.h>
 #include <linux/sched/signal.h>
 #include <linux/skbuff.h>
@@ -589,6 +590,10 @@ bpf_prog_ksym_set_name(struct bpf_prog *prog)
 				      prog->aux->func_info[prog->aux->func_idx].type_id);
 		func_name = btf_name_by_offset(prog->aux->btf, type->name_off);
 		snprintf(sym, (size_t)(end - sym), "_%s", func_name);
+		/* the name of a function of Rust is not an identifier */
+		for (; *sym; sym++)
+			if (!isalnum(*sym) && *sym != '_' && *sym != '.')
+				*sym = '_';
 		return;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index df6ad38d287d..87b554067071 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -1987,14 +1987,14 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "typedef (invalid name, invalid identifier)",
+	.descr = "typedef (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_TYPEDEF_ENC(NAME_TBD, 1),			/* [2] */
 		BTF_END_RAW,
 	},
-	.str_sec = "\0__!int",
-	.str_sec_size = sizeof("\0__!int"),
+	.str_sec = "\0__\7int",
+	.str_sec_size = sizeof("\0__\7int"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "typedef_check_btf",
 	.key_size = sizeof(int),
@@ -2112,15 +2112,15 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "fwd type (invalid name, invalid identifier)",
+	.descr = "fwd type (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
 		BTF_TYPE_ENC(NAME_TBD,
 			     BTF_INFO_ENC(BTF_KIND_FWD, 0, 0), 0),	/* [2] */
 		BTF_END_RAW,
 	},
-	.str_sec = "\0__!skb",
-	.str_sec_size = sizeof("\0__!skb"),
+	.str_sec = "\0__\7skb",
+	.str_sec_size = sizeof("\0__\7skb"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "fwd_type_check_btf",
 	.key_size = sizeof(int),
@@ -2175,7 +2175,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "struct type (invalid name, invalid identifier)",
+	.descr = "struct type (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
 		BTF_TYPE_ENC(NAME_TBD,
@@ -2183,8 +2183,8 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
 		BTF_END_RAW,
 	},
-	.str_sec = "\0A!\0B",
-	.str_sec_size = sizeof("\0A!\0B"),
+	.str_sec = "\0A\7\0B",
+	.str_sec_size = sizeof("\0A\7\0B"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "struct_type_check_btf",
 	.key_size = sizeof(int),
@@ -2217,7 +2217,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "struct member (invalid name, invalid identifier)",
+	.descr = "struct member (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
 		BTF_TYPE_ENC(NAME_TBD,
@@ -2225,8 +2225,8 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
 		BTF_END_RAW,
 	},
-	.str_sec = "\0A\0B*",
-	.str_sec_size = sizeof("\0A\0B*"),
+	.str_sec = "\0A\0B\7",
+	.str_sec_size = sizeof("\0A\0B\7"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "struct_type_check_btf",
 	.key_size = sizeof(int),
@@ -2260,7 +2260,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "enum type (invalid name, invalid identifier)",
+	.descr = "enum type (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
 		BTF_TYPE_ENC(NAME_TBD,
@@ -2269,8 +2269,8 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_ENUM_ENC(NAME_TBD, 0),
 		BTF_END_RAW,
 	},
-	.str_sec = "\0A!\0B",
-	.str_sec_size = sizeof("\0A!\0B"),
+	.str_sec = "\0A\7\0B",
+	.str_sec_size = sizeof("\0A\7\0B"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "enum_type_check_btf",
 	.key_size = sizeof(int),
@@ -2306,7 +2306,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "enum member (invalid name, invalid identifier)",
+	.descr = "enum member (invalid name, not printable)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),		/* [1] */
 		BTF_TYPE_ENC(0,
@@ -2315,8 +2315,8 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_ENUM_ENC(NAME_TBD, 0),
 		BTF_END_RAW,
 	},
-	.str_sec = "\0A!",
-	.str_sec_size = sizeof("\0A!"),
+	.str_sec = "\0A\7",
+	.str_sec_size = sizeof("\0A\7"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "enum_type_check_btf",
 	.key_size = sizeof(int),
@@ -2625,14 +2625,14 @@ static struct btf_raw_test raw_tests[] = {
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
-		/* void (*)(int a, unsigned int !!!) */
+		/* void (*)(int a, unsigned int \7) */
 		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 2),
 		BTF_END_RAW,
 	},
-	.str_sec = "\0a\0!!!",
-	.str_sec_size = sizeof("\0a\0!!!"),
+	.str_sec = "\0a\0\7",
+	.str_sec_size = sizeof("\0a\0\7"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "func_proto_type_check_btf",
 	.key_size = sizeof(int),
@@ -2775,12 +2775,12 @@ static struct btf_raw_test raw_tests[] = {
 		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 2),
-		/* void !!!(int a, unsigned int b) */
+		/* void \7(int a, unsigned int b) */
 		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
 		BTF_END_RAW,
 	},
-	.str_sec = "\0a\0b\0!!!",
-	.str_sec_size = sizeof("\0a\0b\0!!!"),
+	.str_sec = "\0a\0b\0\7",
+	.str_sec_size = sizeof("\0a\0b\0\7"),
 	.map_type = BPF_MAP_TYPE_ARRAY,
 	.map_name = "func_type_check_btf",
 	.key_size = sizeof(int),
@@ -3585,15 +3585,13 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 },
 {
-	.descr = "type name '?foo' is not ok",
+	.descr = "type name '?foo' is ok",
 	.raw_types = {
 		/* union ?foo; */
 		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
 		BTF_END_RAW,
 	},
 	BTF_STR_SEC("\0?foo"),
-	.err_str = "Invalid name",
-	.btf_load_err = true,
 },
 
 {
-- 
2.55.0

