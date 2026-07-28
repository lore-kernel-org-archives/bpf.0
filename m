Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E3471CE0
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250713; cv=none; b=jStSmZrJPSB3YFKbh2fG++1l/txGcATytE/DFCCOo5cI59fiZ0jeyNmSQylxQr3eFELVIUTAXX8MhHW27yZGHWZaMfYL7syYdzD4Nva393yXB5wC56yKhfRUy3NtK6WFEbm+znUnWV4P1iHskwutzm6I9i8mQtVPCacU+SneV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250713; c=relaxed/simple;
	bh=30Y9GTYw74wc3fRcR3KjY3S99uqLitfCNH6s0XNC8E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srkI/n5EgQ7arWIi2W3TwBFobbUKHt6t5DnDcoJQbHRrNIFRkjjC05uC6IpMbaTr4eDV2MRS0LQMtNscdiL3sklCtReDuvhzvsgL3gmbRJU2NYnHUAZIWNPT/OtDDDcn+5IQduh7SZelrB77eBu9cIDLSvb2i77YuAhDpgwQiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uj07W4Vj; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uj07W4Vj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muTwT/Dw7lTNuj/Bes4OMBsxrlqI16HqDpp1BQ0I+Rw=;
	b=Uj07W4VjodCts34hDq47koDHQ3KSXWn+cTGJGumUh9pW2cGEjjQNzoHfKdXfSZP5HeaYg7
	d9dhMd5fbYfZ1UEMe7im3mcS9/aCh5eIMHlB85kmNtq0CbseToq4iObIG8eJoo9gl+h1JQ
	wGDMxszpKg1vBMY5FKywiLwtiDIuHP0=
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
Subject: [RFC PATCH bpf-next 2/6] bpf: Optimize string comparison kfuncs
Date: Tue, 28 Jul 2026 22:57:23 +0800
Message-ID: <20260728145727.45153-3-leon.hwang@linux.dev>
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

Use aligned nofault word loads for the strcmp and strcasecmp kfunc
families when both operands have the same relative alignment. Skip
identical NUL-free words directly and inspect locally loaded bytes only
for mismatches and case folding.

Reuse the string scan expansion macro for alignment, word bounds, and
byte fallback while keeping the comparison actions expanded at the call
site.

Keep byte-at-a-time access for differently aligned operands, KMSAN, and
word-load faults. This preserves comparison order and the existing error
semantics.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/helpers.c | 72 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 36075c683166..406aca61789a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3818,32 +3818,74 @@ static __always_inline int bpf_str_find(const char *s, size_t limit, unsigned ch
 	return -EFAULT;
 }
 
+static __always_inline bool
+bpf_str_cmp_byte(unsigned char byte1, unsigned char byte2, bool ignore_case, int *ret)
+{
+	char c1 = byte1, c2 = byte2;
+
+	if (ignore_case) {
+		c1 = tolower(c1);
+		c2 = tolower(c2);
+	}
+	if (c1 != c2) {
+		*ret = c1 < c2 ? -1 : 1;
+		return true;
+	}
+	if (c1 == '\0') {
+		*ret = 0;
+		return true;
+	}
+	return false;
+}
+
 static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
-	char c1, c2;
-	int i;
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned char byte1, byte2, *bytes1, *bytes2;
+	unsigned long word1, word2, data;
+	size_t limit, pos = 0, i;
+	int ret;
 
 	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
 	    !copy_from_kernel_nofault_allowed(s2, 1)) {
 		return -ERANGE;
 	}
 
+	limit = min_t(size_t, len, XATTR_SIZE_MAX);
 	guard(pagefault)();
-	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&c1, s1, char, err_out);
-		__get_kernel_nofault(&c2, s2, char, err_out);
-		if (ignore_case) {
-			c1 = tolower(c1);
-			c2 = tolower(c2);
+
+	if (!IS_ALIGNED((unsigned long)s1 ^ (unsigned long)s2, sizeof(word1))) {
+		for (; pos < limit; pos++) {
+			__get_kernel_nofault(&byte1, s1 + pos, unsigned char, err_out);
+			__get_kernel_nofault(&byte2, s2 + pos, unsigned char, err_out);
+			if (bpf_str_cmp_byte(byte1, byte2, ignore_case, &ret))
+				return ret;
 		}
-		if (c1 != c2)
-			return c1 < c2 ? -1 : 1;
-		if (c1 == '\0')
-			return 0;
-		s1++;
-		s2++;
+		return pos == XATTR_SIZE_MAX ? -E2BIG : 0;
 	}
-	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
+
+	bpf_str_for_each_word(s1, limit, pos, word1, byte1, byte_at_a_time, ({
+		__get_kernel_nofault(&byte2, s2 + pos, unsigned char, err_out);
+		if (bpf_str_cmp_byte(byte1, byte2, ignore_case, &ret))
+			return ret;
+	}), ({
+		__get_kernel_nofault(&word2, s2 + pos, unsigned long, byte_at_a_time);
+		if (word1 == word2) {
+			if (has_zero(word1, &data, &constants))
+				return 0;
+			continue;
+		}
+
+		bytes1 = (unsigned char *)&word1;
+		bytes2 = (unsigned char *)&word2;
+		for (i = 0; i < sizeof(word1); i++) {
+			if (bpf_str_cmp_byte(bytes1[i], bytes2[i], ignore_case, &ret))
+				return ret;
+		}
+	}), err_out);
+
+	return pos == XATTR_SIZE_MAX ? -E2BIG : 0;
+
 err_out:
 	return -EFAULT;
 }
-- 
2.55.0

