Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814374;
	b=2n0fKOMMeqRViTY8zyatf0ED5WKAG4q9DPR+etWk0lFQ2ctkzUewfTAvDk0YeRdNNOZP
	 5CPjF7AzAUIHjuILHGv246W5Lwa6S3ehkpRk1dMIqI2EhFOGAVmWwK9UVmnvz4zRk+5zb
	 E1OCKmSNo55seqN0HAMxb7FSZ2oiW7B/lU9fMlp6hpUKaxS0WhWXoIvHVJCafcf/O4jvi
	 Xivkxxmw4fmGx+1X9umCcRwPnIGqnbf7v93hCPRL3XImrdT607fXGsQ80M9qo+3Jdg01y
	 bIE5Ikn5Jk7PNLi9lFf31IG4cG4calNNt0JQTYazzulgytEU76F3pwTidOIIvLpQyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XAtFDMryQisCTaDWbSvN98SuLth7CLqkE2NAokAnzFk=;
	b=ttUuEZjLwkoLp91IE36mDldb6DT0rLcOZAbcs67fp2jGxEVucG0oEY21+tzWqAWttGwf
	 vJrxODU/AKLvjrRzzRouhHW8zT6rLET/8HlzVa5oQWcHBBlqsvxmQOJpId+YPH5kiB31/
	 vahBG7Hyg5yZdSveKIT4LyIzv3dvy+vl2NPADesdK9slIeVB2qLYOi4bEuP8WPynALOli
	 9pQAtWeEM+EabfsHz3wzgqpCZ8B1Wv5MqYf6MKmmnJa56PbQ9/EVuOLb7jF2erOoeeCfK
	 TmmmJgsJl43NE1WLK4jBBAKlpg9OWquy4xHbDHn1DbQxQaEOP78OINfYZKyXKVmUTZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iT3Eueht;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4E606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 03:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A4E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iT3Eueht
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a595487d43so10797671fa.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792814371; x=1793419171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAtFDMryQisCTaDWbSvN98SuLth7CLqkE2NAokAnzFk=;
        b=iT3EuehtcQrriaPS9m07s+nwhaqmbvVAV74maB+SETR1yp9plTSMme16mNfwfXhm1p
         KrSKUwSXCZmnzZoPYydeQF7r11BFNbxbg+5S9m3HXKrggUp/4r1cyZAZQz6T5FqTRSSI
         PomRcZvgwK/091Qq28j7qNyDcCZ8zhaMw3lnwIRlh5Oob0HC0MHXP+aT/f5kaV1rUp+t
         TpiGXbm+OJN++PU0XkiKpuUrVlX/Vr6BQP3thT71aBN+WiYDaR1m3on0haWSa+4FJooR
         XnG+J3sOpEG2pPM7usAw+/3ppLU/v9/CGatZ6MRYy2pnIUmQhhGJ6uEs8ISmb+etWRzo
         xjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792814371; x=1793419171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAtFDMryQisCTaDWbSvN98SuLth7CLqkE2NAokAnzFk=;
        b=DiQ+uN8XhVVrIR2fgQOpg/AVfBHd7zlJngY6YZ1g5jYJ8QGtOLYUJL13FQmKEGWBYh
         8EWfyq5oGnBltxKXiZsNYXNGNorFqEG9Gj/C4DH8fzCt2cacwKV/mVDWvWueeKstyDoy
         a2l7InOQDu7KSSAiCeDwPY43SJD7DBoVA46cHoeMr72z8PgTxGYR5qK8IBF5c3CTAUMl
         iPPnUC0JTrTAq0pQ94SovXdXvjbJxC3D+3CpH/jRUD7fS64KlSHkny7h/eQnaxLElWuL
         jTyXY4O3oA1Vv+MmlsLxo8+kVfET5yC90jCoPsuYsxJ5/lXqW0KxEzR60hQ7MLk/filB
         8IzA==
X-Gm-Message-State: AFq9FYLBqsIxfN9Ncdo/92Oa2wb4m6iHPNxe2K7xrurvkfsxflqPZXbZ
	AGQj/HiAcy20PAfCZfpqep+KcvsjpHf3K8yBsDwJ2X0E02zRw9Czve/m5cpGk9sz8VQ0kg==
X-Gm-Gg: AYBFou2ORNm6Fw8kdJCpRx0xo/zGhOkvhoQSyHne0fyOb5QYw1ooUsRY6aRevhW23Y1
	2cmHRKpwZ/4yqjiuK825NQ/SNsRVdGHFIxyuumE6rqlHK8oSp7AojJQpAYNJoS5241SpChjnFDN
	CAeF28nQD5bMqt8u4gKtV2OZj1M6JEdaiiT8HXxE5cbDByr4l8hazjczFY4hG4XI/pNGjLPDP7W
	9IIiDW0FXmaiY0B3vGkx4SXV6QkBHU3XEDvIdNfgFgiN7Z3GhM9YTFRNIXsioBIsiyb7l3Iqxel
	s32XbSeDDMpqlAfZczLWv5WRe52/f+sISO2bSMqU/XdoIKqxhZ+9JP9Ek/qQndykMwVLFVQYeVB
	RXtDc0HplbrkUbNIFKo2m7m3q9mTjMsw4bTKulXuxIB1WqZFCpIaIcrOJusT5s1zvRCOD+HSwTI
	XQ/1+3fKbR3TlHwdg7Un+v4b5MVE9aORmu6AH3QQ5cBnoWQWIOtqBFIpFvbpMONeSGjXR2HC4j+
	oB+ahfNIRIROJ+HckE/Tu4J3RXvfmnwqYgm8f7C7dgeqjQvpBcDm6ohYgg=
X-Received: by 2002:a05:651c:31dc:b0:3a3:1cfc:d2a7 with SMTP id 38308e7fff4ca-3ac6fd09b21mr2185601fa.14.1792814370747;
        Fri, 23 Oct 2026 20:59:30 -0700 (PDT)
Received: from localhost.net ([196.240.54.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a49f67sm1933811fa.38.2026.10.23.20.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:59:30 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] libbpf: fix helper macro C++ compatibility
Date: Sat, 24 Oct 2026 05:59:02 +0200
Message-ID: <20261024035902.44566-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
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

C++26 warns about the GNU named variadic parameter syntax in
bpf_helpers.h, which prevents consumers from using the header with
-Werror=variadic-macros. Replace the named parameters with __VA_ARGS__.

C++ also rejects implicit conversions used by helper argument packing,
bpf_for_each, and generated helper function pointers. Use explicit
integer and typed pointer casts so these helpers can be parsed and used
from C++.

Verified with GCC and Clang C++26 syntax checks using helper macros,
an ARM64-targeted BPF C smoke build, and generated helper definitions
from scripts/bpf_doc.py. checkpatch.pl reports no errors or warnings.

AI assistance: OpenAI Codex helped reproduce the C++26 failures and
draft changes to tools/lib/bpf/bpf_helpers.h and scripts/bpf_doc.py.
The human submitter must review the changes and test results before
submission.

Fixes: d6a6a55518c1 ("libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h")
Closes: https://github.com/libbpf/libbpf/issues/974
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 scripts/bpf_doc.py          |  10 +++-
 tools/lib/bpf/bpf_helpers.h | 107 ++++++++++++++++++++++--------------
 2 files changed, 72 insertions(+), 45 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 15d113a1b..02e31ad50 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -829,6 +829,11 @@ class PrinterHelpersHeader(Printer):
 /* Forward declarations of BPF structs */'''
 
         print(header)
+        print("#ifdef __cplusplus")
+        print("#define ___bpf_helper_stub(id, name) reinterpret_cast<decltype(+name)>(id)")
+        print("#else")
+        print("#define ___bpf_helper_stub(id, name) ((void *)(id))")
+        print("#endif")
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
@@ -849,8 +854,7 @@ class PrinterHelpersHeader(Printer):
             print('')
 
     def print_footer(self):
-        footer = ''
-        print(footer)
+        print("#undef ___bpf_helper_stub")
 
     def map_type(self, t):
         if t in self.known_types:
@@ -908,7 +912,7 @@ class PrinterHelpersHeader(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % helper.enum_val)
+        print(') = ___bpf_helper_stub(%d, %s);' % (helper.enum_val, proto['name']))
         print('')
 
 
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index b37b727ef..6c9fdb696 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -233,20 +233,53 @@ enum libbpf_tristate {
 #endif
 
 #define ___bpf_fill0(arr, p, x) do {} while (0)
-#define ___bpf_fill1(arr, p, x) arr[p] = x
-#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
-#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
-#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
-#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
-#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
-#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
-#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
-#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
-#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
-#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
-#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
-#define ___bpf_fill(arr, args...) \
-	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
+#define ___bpf_fill1(arr, p, x) (arr[p] = (unsigned long long)(x))
+#define ___bpf_fill2(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill1(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill3(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill2(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill4(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill3(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill5(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill4(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill6(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill5(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill7(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill6(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill8(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill7(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill9(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill8(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill10(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill9(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill11(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill10(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill12(arr, p, x, ...) do { \
+	arr[p] = (unsigned long long)(x); \
+	___bpf_fill11(arr, p + 1, __VA_ARGS__); \
+} while (0)
+#define ___bpf_fill(arr, ...) \
+	___bpf_apply(___bpf_fill, ___bpf_narg(__VA_ARGS__))(arr, 0, __VA_ARGS__)
 
 /*
  * Format strings are in a section of their own. When global data of the object
@@ -260,15 +293,12 @@ enum libbpf_tristate {
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
  */
-#define BPF_SEQ_PRINTF(seq, fmt, args...)			\
+#define BPF_SEQ_PRINTF(seq, fmt, ...)			\
 ({								\
 	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
-	unsigned long long ___param[___bpf_narg(args)];		\
+	unsigned long long ___param[___bpf_narg(__VA_ARGS__)];		\
 								\
-	_Pragma("GCC diagnostic push")				\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
-	___bpf_fill(___param, args);				\
-	_Pragma("GCC diagnostic pop")				\
+	___bpf_fill(___param, __VA_ARGS__);				\
 								\
 	bpf_seq_printf(seq, ___fmt, sizeof(___fmt),		\
 		       ___param, sizeof(___param));		\
@@ -278,15 +308,12 @@ enum libbpf_tristate {
  * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
  * an array of u64.
  */
-#define BPF_SNPRINTF(out, out_size, fmt, args...)		\
+#define BPF_SNPRINTF(out, out_size, fmt, ...)		\
 ({								\
 	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
-	unsigned long long ___param[___bpf_narg(args)];		\
+	unsigned long long ___param[___bpf_narg(__VA_ARGS__)];		\
 								\
-	_Pragma("GCC diagnostic push")				\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
-	___bpf_fill(___param, args);				\
-	_Pragma("GCC diagnostic pop")				\
+	___bpf_fill(___param, __VA_ARGS__);				\
 								\
 	bpf_snprintf(out, out_size, ___fmt,			\
 		     ___param, sizeof(___param));		\
@@ -309,29 +336,23 @@ enum libbpf_tristate {
  * __bpf_vprintk wraps the bpf_trace_vprintk helper with variadic arguments
  * instead of an array of u64.
  */
-#define __bpf_vprintk(fmt, args...)				\
+#define __bpf_vprintk(fmt, ...)				\
 ({								\
 	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
-	unsigned long long ___param[___bpf_narg(args)];		\
+	unsigned long long ___param[___bpf_narg(__VA_ARGS__)];		\
 								\
-	_Pragma("GCC diagnostic push")				\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
-	___bpf_fill(___param, args);				\
-	_Pragma("GCC diagnostic pop")				\
+	___bpf_fill(___param, __VA_ARGS__);				\
 								\
 	bpf_trace_vprintk(___fmt, sizeof(___fmt),		\
 			  ___param, sizeof(___param));		\
 })
 
-#define bpf_stream_printk(stream_id, fmt, args...)					\
+#define bpf_stream_printk(stream_id, fmt, ...)					\
 ({											\
 	static const char ___fmt[] ___bpf_fmt_sec = fmt;				\
-	unsigned long long ___param[___bpf_narg(args)];					\
+	unsigned long long ___param[___bpf_narg(__VA_ARGS__)];					\
 											\
-	_Pragma("GCC diagnostic push")							\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")				\
-	___bpf_fill(___param, args);							\
-	_Pragma("GCC diagnostic pop")							\
+	___bpf_fill(___param, __VA_ARGS__);							\
 											\
 	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param));		\
 })
@@ -346,7 +367,7 @@ enum libbpf_tristate {
 		   __bpf_printk /*1*/, __bpf_printk /*0*/)
 
 /* Helper macro to print out debug messages */
-#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
+#define bpf_printk(fmt, ...) ___bpf_pick_printk(__VA_ARGS__)(fmt, ##__VA_ARGS__)
 
 struct bpf_iter_num;
 
@@ -382,16 +403,18 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
  * extension: __attribute__((cleanup(<func>))), supported by both GCC and
  * Clang.
  */
-#define bpf_for_each(type, cur, args...) for (							\
+#define bpf_for_each(type, cur, ...) for (							\
 	/* initialize and define destructor */							\
 	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
 						    cleanup(bpf_iter_##type##_destroy))),	\
 	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
 			       *___p __attribute__((unused)) = (				\
-					bpf_iter_##type##_new(&___it, ##args),			\
+						bpf_iter_##type##_new(&___it, \
+								       ##__VA_ARGS__), \
 	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
 	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
-					(void)bpf_iter_##type##_destroy, (void *)0);		\
+					(void)bpf_iter_##type##_destroy, \
+					(struct bpf_iter_##type *)0); \
 	/* iteration and termination check */							\
 	(((cur) = bpf_iter_##type##_next(&___it)));						\
 )
-- 
2.55.0

