Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159F472F64
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250728; cv=none; b=SscLrcl+Z5Gv8ppX9Dla8ipsBSkz8yx/HAR2/HSonojP1Y8MtlAdrRqD6Q+vFB5mAAcLhw9kAHNyS3qz23b0Q4pwc00CP4oNn0krUiWcwOS+nMsvq3N2SJ5yPCnmyybddmePTUPIrha1BrEk7p4UZWDvefBbLhjiA2UCdS82MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250728; c=relaxed/simple;
	bh=bwojgRQr90lmAhGXXGohhb+zdoQoSc1vyg7YmLQ9mMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrMJvamU1XmXXdmXPIonT7rqxdfkjTErNPuxq5A2i+F4XklCY4bzhVEDXzGLtWiD9yowV1gVyGGO1T5SBbvFJaX4nL2SD/gc59QSYV+d7UI0tNKZxggWArieA3+5TJ4zwEYCw58D4W4Ky5OpSImEcLpmVeuzZT7lq621HHDEt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhVTHHIz; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhVTHHIz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJsuMoUpiF06eY126AXSEObGmfhiEqH3pEWC3kbo1g8=;
	b=fhVTHHIzNEvjTNKCy251Vc5+wfPW3AApBnmj7ALp/Fx6oQ0KpBxdPW4fJMbvNFvr7Kbr4W
	MEUPAxwoGJ6ddugx+Cbs/pz+c0+LIhKtlnpxA+rIub+qBEaTM2dEiSkPuBL2OU6P92FNB/
	FtaiC/Msw7kSp5Bb591BJF63YVLa2ww=
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
Subject: [RFC PATCH bpf-next 4/6] bpf: Optimize string substring kfuncs
Date: Tue, 28 Jul 2026 22:57:25 +0800
Message-ID: <20260728145727.45153-5-leon.hwang@linux.dev>
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

Use the word-at-a-time character finder to skip haystack regions which
cannot begin a match. For case-insensitive searches, check both ASCII
case variants of the first needle byte.

At each candidate, use a direct fault-safe word matcher. When both
strings have the same relative alignment, skip equal words and inspect
locally loaded bytes only for mismatches and case folding.

Keep needle-first access, fall back at the same byte after a word-load
fault, and retain the extra needle-byte check at the search limit so
fault and boundary behavior remain unchanged.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/helpers.c | 142 +++++++++++++++++++++++++++++++++----------
 1 file changed, 111 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af29acc90245..93d5fa409cd7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4281,11 +4281,90 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 	return __bpf_strspn(s__ign, reject__ign, true);
 }
 
-static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
-			 bool ignore_case)
+#define bpf_str_match_byte(byte1, byte2, ignore_case)	\
+do {							\
+	char __c1 = (byte1);				\
+	char __c2 = (byte2);				\
+							\
+	if (ignore_case) {				\
+		__c1 = tolower(__c1);			\
+		__c2 = tolower(__c2);			\
+	}						\
+	if (__c1 == '\0')				\
+		return -ENOENT;				\
+	if (__c1 != __c2)				\
+		return 0;				\
+} while (0)
+
+static __always_inline int
+bpf_str_match_at(const char *s1, const char *s2, size_t limit, bool ignore_case)
 {
-	char c1, c2;
-	int i, j;
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned char byte1, byte2, *bytes1, *bytes2;
+	unsigned long word1, word2, data;
+	size_t pos = 0, word_end, i;
+
+	if (IS_ENABLED(CONFIG_KMSAN) ||
+	    !IS_ALIGNED((unsigned long)s1 ^ (unsigned long)s2, sizeof(word1)))
+		goto byte_at_a_time;
+
+	while (pos < limit && !IS_ALIGNED((unsigned long)(s1 + pos), sizeof(word1))) {
+		__get_kernel_nofault(&byte2, s2 + pos, unsigned char, err_out);
+		if (byte2 == '\0')
+			return 1;
+		__get_kernel_nofault(&byte1, s1 + pos, unsigned char, err_out);
+		bpf_str_match_byte(byte1, byte2, ignore_case);
+		pos++;
+	}
+
+	word_end = pos + round_down(limit - pos, sizeof(word1));
+	while (pos < word_end) {
+		__get_kernel_nofault(&word2, s2 + pos, unsigned long, byte_at_a_time);
+		if (has_zero(word2, &data, &constants))
+			goto byte_at_a_time;
+		__get_kernel_nofault(&word1, s1 + pos, unsigned long, byte_at_a_time);
+		if (word1 == word2) {
+			pos += sizeof(word1);
+			continue;
+		}
+
+		bytes1 = (unsigned char *)&word1;
+		bytes2 = (unsigned char *)&word2;
+		for (i = 0; i < sizeof(word1); i++)
+			bpf_str_match_byte(bytes1[i], bytes2[i], ignore_case);
+		pos += sizeof(word1);
+	}
+
+byte_at_a_time:
+	for (; pos < limit; pos++) {
+		__get_kernel_nofault(&byte2, s2 + pos, unsigned char, err_out);
+		if (byte2 == '\0')
+			return 1;
+		__get_kernel_nofault(&byte1, s1 + pos, unsigned char, err_out);
+		bpf_str_match_byte(byte1, byte2, ignore_case);
+	}
+
+	if (limit == XATTR_SIZE_MAX)
+		return -E2BIG;
+
+	/*
+	 * Read one extra byte from s2 to cover the case when it is a suffix
+	 * of the first limit bytes of s1.
+	 */
+	__get_kernel_nofault(&byte2, s2 + limit, unsigned char, err_out);
+	return byte2 == '\0' ? 1 : -ENOENT;
+
+err_out:
+	return -EFAULT;
+}
+
+#undef bpf_str_match_byte
+
+static int __bpf_strnstr(const char *s1, const char *s2, size_t len, bool ignore_case)
+{
+	unsigned char first, candidate;
+	size_t pos = 0, limit;
+	int ret, offset;
 
 	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
 	    !copy_from_kernel_nofault_allowed(s2, 1)) {
@@ -4293,37 +4372,38 @@ static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
 	}
 
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&c2, s2 + j, char, err_out);
-			if (c2 == '\0')
-				return i;
-			/*
-			 * We allow reading an extra byte from s2 (note the
-			 * `i + j <= len` above) to cover the case when s2 is
-			 * a suffix of the first len chars of s1.
-			 */
-			if (i + j == len)
-				break;
-			__get_kernel_nofault(&c1, s1 + j, char, err_out);
-
-			if (ignore_case) {
-				c1 = tolower(c1);
-				c2 = tolower(c2);
-			}
+	__get_kernel_nofault(&first, s2, unsigned char, err_out);
+	if (first == '\0')
+		return 0;
 
-			if (c1 == '\0')
-				return -ENOENT;
-			if (c1 != c2)
-				break;
+	while (pos < XATTR_SIZE_MAX && pos < len) {
+		limit = min_t(size_t, len - pos, XATTR_SIZE_MAX - pos);
+		offset = bpf_str_find(s1 + pos, limit, first, ignore_case, true);
+		if (offset < 0) {
+			if (offset == -ENOENT && limit == XATTR_SIZE_MAX - pos)
+				return -E2BIG;
+			return offset;
 		}
-		if (j == XATTR_SIZE_MAX)
-			return -E2BIG;
-		if (i + j == len)
+		pos += offset;
+
+		/*
+		 * bpf_str_find() also returns the position of a terminating
+		 * NUL. Distinguish it from a first-character match.
+		 */
+		__get_kernel_nofault(&candidate, s1 + pos, unsigned char, err_out);
+		if (candidate == '\0')
 			return -ENOENT;
-		s1++;
+
+		limit = min_t(size_t, len - pos, XATTR_SIZE_MAX);
+		ret = bpf_str_match_at(s1 + pos, s2, limit, ignore_case);
+		if (ret > 0)
+			return pos;
+		if (ret < 0)
+			return ret;
+		pos++;
 	}
-	return -E2BIG;
+	return pos == XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
+
 err_out:
 	return -EFAULT;
 }
-- 
2.55.0

