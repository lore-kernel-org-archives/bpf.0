Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AA7470EA1
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250706; cv=none; b=s1Nf2pHm/zG/Vw2IFxgIkDkWo2MwBpEGXtrd0UYOFfxhZPhYZNrzwN+SWSlCVR49lH7UNLeHRas/hxiASRSNb4vHgHQztxbnkwlmVpH36nD9ithaGFzZbk07LAXByviQLgU5QWQpqXhXZeyAqJ6Mfuvo6XPpOrePPcnZGvO6fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250706; c=relaxed/simple;
	bh=H+N3jFNbuOwdBeKAcONnGTOu7HTXGY50jy0Zp6WWQd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEhPHAF8oLCHAhO0a30cF3Ne+RhyYOdBEjZfyG8kQQvN8mzTWRAKQNVeyVMKKB9770Qm7eqbV8yC8a9T0pWk5u66FYZtEAKdopMa2jTt6gh4wIJCfxU9Tn/KalLu4bBqPqK7a+TtRYt/fss/n1H3ORf//wADSZs/Lir5YKo4UzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChI4L2A6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChI4L2A6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFiqfwcAUIdzLHoAzysonWR/mE9tSWpusYBFIPT2PBU=;
	b=ChI4L2A6YxNXieTGFVHI0FIT4+NbVONc+t6gMnAIDg5iWDDmCqnNCku8ecW+4CFyBOItPa
	w5A6QMsjVwSWcHQ9MrRuw027LcFtbP8m/qripwZNTrpveG/LTbEIoNga5nsC7EXHAhEwaX
	N7Xp45yCIeEdPDY/e+BQ5qxAPjPOm0U=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Rong Tao <rongtao@cestc.cn>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/6] bpf: Optimize string scan kfuncs
Date: Tue, 28 Jul 2026 22:57:22 +0800
Message-ID: <20260728145727.45153-2-leon.hwang@linux.dev>
In-Reply-To: <20260728145727.45153-1-leon.hwang@linux.dev>
References: <20260728145727.45153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use aligned nofault word loads for the strchr, strrchr, and strlen
kfunc families. Align once, hoist the full-word boundary, and use
word-at-a-time masks to skip irrelevant words or locate the first
matching or NUL byte.

Factor the common unaligned-byte, aligned-word, and byte-fallback
plumbing into an expansion macro. Keep algorithm-specific actions expanded
at each call site.

Allow the shared finder to match both ASCII case variants so the
case-insensitive substring kfuncs can use the same word-at-a-time scan.

If a word load faults, retry from the same address byte-at-a-time. Keep
the byte path under KMSAN to avoid reading uninitialized storage beyond
the terminator, and preserve the existing limits and error semantics.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/helpers.c | 180 +++++++++++++++++++++++++++++++++----------
 1 file changed, 141 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 88b38db47de9..36075c683166 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -30,6 +30,8 @@
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
 
+#include <asm/word-at-a-time.h>
+
 #include "../../lib/kstrtox.h"
 
 /* If kernel subsystem is allowing eBPF programs to call this function,
@@ -3727,6 +3729,95 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
+/* Abstract the common unaligned-byte, aligned-word, and byte-fallback scan. */
+#define bpf_str_for_each_word(s, limit, pos, word, byte, byte_label,	\
+			      byte_action, word_action, err_label)	\
+do {									\
+	__label__ byte_label;						\
+	size_t __word_end;						\
+									\
+	if (IS_ENABLED(CONFIG_KMSAN))					\
+		goto byte_label;					\
+									\
+	for (; (pos) < (limit) &&					\
+	       !IS_ALIGNED((unsigned long)((s) + (pos)), sizeof(word));	\
+	     (pos)++) {							\
+		__get_kernel_nofault(&(byte), (s) + (pos),		\
+				     unsigned char, err_label);		\
+		byte_action;						\
+	}								\
+									\
+	__word_end = (pos) + round_down((limit) - (pos), sizeof(word));	\
+	for (; (pos) < __word_end; (pos) += sizeof(word)) {		\
+		__get_kernel_nofault(&(word), (s) + (pos),		\
+				     unsigned long, byte_label);	\
+		word_action;						\
+	}								\
+									\
+byte_label:								\
+	for (; (pos) < (limit); (pos)++) {				\
+		__get_kernel_nofault(&(byte), (s) + (pos),		\
+				     unsigned char, err_label);		\
+		byte_action;						\
+	}								\
+} while (0)
+
+static __always_inline int bpf_str_find(const char *s, size_t limit, unsigned char c,
+					bool ignore_case, bool nul_is_match)
+{
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	const unsigned char match_c = ignore_case ? tolower(c) : c;
+	const unsigned char alt_c = ignore_case && islower(match_c) ?
+				    toupper(match_c) : match_c;
+	const unsigned long repeated_c = REPEAT_BYTE(match_c);
+	const unsigned long repeated_alt = REPEAT_BYTE(alt_c);
+	unsigned long word, zero_data, char_data, alt_data;
+	unsigned long zero_at, char_at, alt_at;
+	const bool has_alt = alt_c != match_c;
+	unsigned char sc;
+	size_t pos = 0;
+
+	bpf_str_for_each_word(s, limit, pos, word, sc, byte_at_a_time, ({
+		if (sc == match_c || (has_alt && sc == alt_c))
+			return pos;
+		if (sc == '\0')
+			return nul_is_match ? pos : -ENOENT;
+	}), ({
+		zero_at = has_zero(word, &zero_data, &constants);
+		char_at = has_zero(word ^ repeated_c, &char_data, &constants);
+		alt_at = has_alt ? has_zero(word ^ repeated_alt, &alt_data, &constants) : 0;
+		if (!zero_at && !char_at && !alt_at)
+			continue;
+
+		if (zero_at) {
+			zero_data = prep_zero_mask(word, zero_data, &constants);
+			zero_at = find_zero(create_zero_mask(zero_data));
+		} else {
+			zero_at = sizeof(word);
+		}
+		if (char_at) {
+			char_data = prep_zero_mask(word ^ repeated_c, char_data, &constants);
+			char_at = find_zero(create_zero_mask(char_data));
+		} else {
+			char_at = sizeof(word);
+		}
+		if (alt_at) {
+			alt_data = prep_zero_mask(word ^ repeated_alt, alt_data, &constants);
+			alt_at = find_zero(create_zero_mask(alt_data));
+			char_at = min(char_at, alt_at);
+		}
+
+		if (char_at <= zero_at)
+			return pos + char_at;
+		return nul_is_match ? pos + zero_at : -ENOENT;
+	}), err_out);
+
+	return pos == XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
+
+err_out:
+	return -EFAULT;
+}
+
 static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
 	char c1, c2;
@@ -3830,24 +3921,14 @@ __bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t
  */
 __bpf_kfunc int bpf_strnchr(const char *s__ign, size_t count, char c)
 {
-	char sc;
-	int i;
+	size_t limit;
 
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
 
+	limit = min_t(size_t, count, XATTR_SIZE_MAX);
 	guard(pagefault)();
-	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
-		if (sc == c)
-			return i;
-		if (sc == '\0')
-			return -ENOENT;
-		s__ign++;
-	}
-	return i == XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
-err_out:
-	return -EFAULT;
+	return bpf_str_find(s__ign, limit, (unsigned char)c, false, false);
 }
 
 /**
@@ -3884,22 +3965,11 @@ __bpf_kfunc int bpf_strchr(const char *s__ign, char c)
  */
 __bpf_kfunc int bpf_strchrnul(const char *s__ign, char c)
 {
-	char sc;
-	int i;
-
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
 
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
-		if (sc == '\0' || sc == c)
-			return i;
-		s__ign++;
-	}
-	return -E2BIG;
-err_out:
-	return -EFAULT;
+	return bpf_str_find(s__ign, XATTR_SIZE_MAX, (unsigned char)c, false, true);
 }
 
 /**
@@ -3916,22 +3986,44 @@ __bpf_kfunc int bpf_strchrnul(const char *s__ign, char c)
  */
 __bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
 {
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	const unsigned char uc = (unsigned char)(char)c;
+	const unsigned long repeated_c = REPEAT_BYTE(uc);
+	const bool char_matches = c == (char)c;
+	unsigned char byte, *bytes;
+	unsigned long word, data;
+	size_t pos = 0, i;
 	char sc;
-	int i, last = -ENOENT;
+	int last = -ENOENT;
 
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
 
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
+
+	bpf_str_for_each_word(s__ign, XATTR_SIZE_MAX, pos, word, byte, byte_at_a_time, ({
+		sc = byte;
 		if (sc == c)
-			last = i;
+			last = pos;
 		if (sc == '\0')
 			return last;
-		s__ign++;
-	}
+	}), ({
+		if (!has_zero(word, &data, &constants) &&
+		    (!char_matches || !has_zero(word ^ repeated_c, &data, &constants)))
+			continue;
+
+		bytes = (unsigned char *)&word;
+		for (i = 0; i < sizeof(word); i++) {
+			sc = bytes[i];
+			if (sc == c)
+				last = pos + i;
+			if (sc == '\0')
+				return last;
+		}
+	}), err_out);
+
 	return -E2BIG;
+
 err_out:
 	return -EFAULT;
 }
@@ -3949,20 +4041,30 @@ __bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
  */
 __bpf_kfunc int bpf_strnlen(const char *s__ign, size_t count)
 {
-	char c;
-	int i;
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned long word, data;
+	size_t limit, pos = 0;
+	unsigned char c;
 
 	if (!copy_from_kernel_nofault_allowed(s__ign, 1))
 		return -ERANGE;
 
+	limit = min_t(size_t, count, XATTR_SIZE_MAX);
 	guard(pagefault)();
-	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&c, s__ign, char, err_out);
+
+	bpf_str_for_each_word(s__ign, limit, pos, word, c, byte_at_a_time, ({
 		if (c == '\0')
-			return i;
-		s__ign++;
-	}
-	return i == XATTR_SIZE_MAX ? -E2BIG : i;
+			return pos;
+	}), ({
+		if (!has_zero(word, &data, &constants))
+			continue;
+
+		data = prep_zero_mask(word, data, &constants);
+		return pos + find_zero(create_zero_mask(data));
+	}), err_out);
+
+	return pos == XATTR_SIZE_MAX ? -E2BIG : pos;
+
 err_out:
 	return -EFAULT;
 }
-- 
2.55.0

