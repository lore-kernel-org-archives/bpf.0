Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77303405C3F
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796709; cv=none; b=qDFo/ICqrfi8jijUKCyqJtsWdKJTCD1gLbFVpP7uyeLO/JcBPr6STZsjQ5q1Q2X7R2XGft4yPU7ckqSs6UiHJgBNeAdCrgZ4cmv5tZADDFIhrWlMioPx6cBwZmtNUsLZtQtHf16JlT1MIsCsGTrAND9A4pPWI5wJdR2LBeP8Qno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796709; c=relaxed/simple;
	bh=NSUO4hVvZlZma0Ke9bgBkPvoPZTLx+6Twz96Xy7OlCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPLpBtd8XuU34Flrvom2qhHPNxF4IMm3uaJLVq/iaH2AyEejlJ43MJfZm3f+kYhLB2biLd1de/SYOuZ9D+FxTkWKSc87RIxhcpa4eRmr2bW6xaqtjsx5meEn4nWgwNJrNHmnFahw4/DlHwmpPSC0oz9qfIZXlhl4Hsl39Ox0cK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkQyNMc1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkQyNMc1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2813865a91.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796707; x=1791401507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rJ00cYWuKporcFNNrBc+c9CkGMwzbHBsMvy2jda7qM=;
        b=PkQyNMc1ZAI+klcCueTI6oMYdlB54D2fdEaW9f9z4cbe1cNdYigeoSwsHqBfe0WI7h
         3rRUL85ixry3sOk4mDjhrY+t3HDisxtHscu1DsMa9pS0WpSIV91ym5lvtjdHK+OFc52h
         qW4oVjbMWGUqC0ueFxDgP0/KA0r6rgEU2E3zGhbXs9+mlmqvU/Y2gM5xwsagXWb/uGoN
         lmBTQh1gyk4UbjfmboxFyRJgF6kyycmVjgmF110tRW0U3ORpQzK/uIVJoP9euAJev822
         2U5/ngVr33ybqQksZ5Hh60N5MG0IHTA9U1zNQN1Jq4e3MsLBTrJwh0eh3CNWMAHTGtyZ
         8SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796707; x=1791401507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rJ00cYWuKporcFNNrBc+c9CkGMwzbHBsMvy2jda7qM=;
        b=R1za3n4AMWPN2Dk89ApVo10c6ZemA8+FOISFKc5sEvce8sggoZfZYv5i+WldG62BpF
         yaZ4l8v9pClbwf0eSHVjinQOGRjlKh9aoDp0xnChJy/tO8iSHpsLFMvOQGI2boEHVsyj
         Utf7IZ1KFy7qgFaNsM2CwV+SQl2qU3UsWX/2YtFnN1nVFJfutQS7F+sR98XrtnYkezir
         3K4l21sYX9qpXfV6yVf8uzbndVVgYmvMuWDY7RXNnRJ7lRBYLW8rhiKgZRQH/o2cQp+e
         EF9iPRHlMd/bnxdCzjSgyIvWgWCz5P16CwZUNfJrh0xIZkcv3vajrYAfAyHNZPJnM8cr
         IpUQ==
X-Gm-Message-State: AFq9FYJe24VFkCp4GGYOAJAHDoG2VvFn8cu1f8gpHA62ws8WdZ3+qknC
	K8X7K+qn+TJqMbwy3ryqQ5LlIn+eStisoHzIHIHIxy80EVhtn+D+3jqiRDTAgS2s
X-Gm-Gg: AYBFou18qrPp5bxqfAJcBez3NeIeHkFzid+2Jbawr5TDOfemV+vejIXRLMqMc0QZlkn
	cdcVx50iKLvuAwl0/V2PGro1EoalHplOe+v3d4uNXl4/aigcFSkPBwImJylgWsT9NUm+BfgTaC6
	9s3E2JS7Lu3XOvHEWKJl5v39afuMkQ+pd1ytc5w0LWBGQM9/ph2LdxrGyZUX4S6Jwwzlaq8/34V
	2lhub3E4jmbk7Y3EX7o/trKFO25rwJj/FKbnjFd8jSZiZecOAopKsmVe+7+KY/mbZBmbxj/TQy/
	6R9MPpasdt4VeCwKhSYx2MCxltYo5QF12xZ4W7Vs3VrYCWzFF/t+m/DNlK6OdBbEu2ExKo5mQ7o
	Asl56RMUQYZHUlkX8VrXWuJ24oeEkTGvADEw/N7yH4g+DHHEFIAM4FubNn0PZw1a2wUnVNoLCXK
	vT+lPQF18Pnxv0Z3Txjs3gzjPqczv3j6hDvhuAXA2u/VpVqFahvOq1TomAthvhh2eDy8F9X5UEK
	8znNjjUm6hrM+TwM+tu3n960SiCYqPEwj4nP6FBoo6O0gUpH3jPdMWcf/kwOlNzs6GMGIrMy/o0
	rlyeYUUtXcdmY7mDW/UBRisZEgP/nBw8LqsGEmxz+FA=
X-Received: by 2002:a17:90b:5830:b0:3a4:a045:27cb with SMTP id 98e67ed59e1d1-3a4d193d3a7mr1401936a91.46.1790796706378;
        Wed, 30 Sep 2026 12:31:46 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f479dc9fsm657228a91.15.2026.09.30.12.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 05/14] bpf: Allow names of Rust types and functions in BTF
Date: Wed, 30 Sep 2026 19:31:18 +0000
Message-ID: <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
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

