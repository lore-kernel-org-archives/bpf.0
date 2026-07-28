Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9A471CE6
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250721; cv=none; b=QE+sFYQ3F9UL70BS849pFByLbVXYpmhFLNd1dCv/8ydHjVWfrvy/nyCSkWdljwS/HLJkT8QkX6O8Z2yAKUeo1IiIqkEltrWETKS9qUi2HVfzmoB1vl/+It0HOMFwFZYAHfIkCQv7G7OnQjO/0BqPDMShO6tw7wzVTZCyC1BiN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250721; c=relaxed/simple;
	bh=G4CtLr+M3MknCHtQvC/vgRyHZsb8qlk7S4n1YGfo1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUTB7kB9f5bHrsTYSBsvYfqs3AZUl0sSTWI039qh2SAiucb6cGeZnC8OdyF1RqG+TATnHa17hV/I+3a6N6ObjNBoo8DAPQviB0Xd/nkRKNRPWnaGnrfDSkFcGk//GpBCiZa6TwhuxG5veZIHTfPbtOugkTkEIoi1XfAklLdOFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FyUuOZKa; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FyUuOZKa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785250717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uv2itm2QyKdZXre+WATZYF4NEmrq1a0nmBWmCxqNaa0=;
	b=FyUuOZKad70trjawBKKTwEOj0Z5AWFbA7DErkKOjOwOJMOX3hMTQX4xCWKHuYHYLjqzNwR
	gjbs3m9CaSwGHEtXaMrldQ5beSG07ioBTaqDPCgMeZcXlLh1vikaIf6+7yQb7w28BgcdUF
	SOgfpLCkxvuFAx9fRMmCPIMVwqO7tQ0=
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
Subject: [RFC PATCH bpf-next 3/6] bpf: Optimize string span kfuncs
Date: Tue, 28 Jul 2026 22:57:24 +0800
Message-ID: <20260728145727.45153-4-leon.hwang@linux.dev>
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

Share a direct implementation between bpf_strspn() and bpf_strcspn().
Read the source string a word at a time and cache set membership in a
lazily populated 256-bit bitmap, so each required accept or reject byte
is nofault-loaded at most once.

Use the word-at-a-time character finder after discovering a singleton
reject set. This avoids inspecting individual source bytes for common
bpf_strcspn() delimiters.

Keep set loading lazy, retry from the same byte after a word-load fault,
and retain the existing NUL, EFAULT, and E2BIG ordering.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/helpers.c | 175 ++++++++++++++++++++++++++++++-------------
 1 file changed, 121 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 406aca61789a..af29acc90245 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4126,6 +4126,125 @@ __bpf_kfunc int bpf_strlen(const char *s__ign)
 	return bpf_strnlen(s__ign, XATTR_SIZE_MAX);
 }
 
+static __always_inline bool
+bpf_str_set_contains(const unsigned long *set_bits, unsigned char c)
+{
+	return set_bits[c / BITS_PER_LONG] & BIT(c % BITS_PER_LONG);
+}
+
+static __always_inline int
+bpf_str_set_lookup(const char *set, unsigned long *set_bits, size_t *set_pos, bool *set_complete,
+		   unsigned char *set_first, unsigned char c)
+{
+	unsigned char set_c;
+
+	if (bpf_str_set_contains(set_bits, c))
+		return 1;
+	if (*set_complete)
+		return 0;
+
+	while (*set_pos < XATTR_SIZE_MAX) {
+		__get_kernel_nofault(&set_c, set + *set_pos, unsigned char, err_out);
+		if (set_c == '\0') {
+			*set_complete = true;
+			return 0;
+		}
+
+		if (*set_pos == 0)
+			*set_first = set_c;
+		set_bits[set_c / BITS_PER_LONG] |= BIT(set_c % BITS_PER_LONG);
+		(*set_pos)++;
+		if (set_c == c)
+			return 1;
+	}
+	return -E2BIG;
+
+err_out:
+	return -EFAULT;
+}
+
+static __always_inline int
+bpf_strcspn_single(const char *s, size_t pos, unsigned char reject)
+{
+	int ret;
+
+	ret = bpf_str_find(s + pos, XATTR_SIZE_MAX - pos, reject, false, true);
+	if (ret >= 0)
+		return pos + ret;
+	return ret == -ENOENT ? -E2BIG : ret;
+}
+
+static int __bpf_strspn(const char *s, const char *set, bool reject)
+{
+	unsigned long set_bits[256 / BITS_PER_LONG] = {};
+	size_t pos = 0, word_end, i, set_pos = 0;
+	unsigned char c, set_first = 0, *bytes;
+	bool set_complete = false;
+	unsigned long word;
+	int ret;
+
+	if (!copy_from_kernel_nofault_allowed(s, 1) ||
+	    !copy_from_kernel_nofault_allowed(set, 1))
+		return -ERANGE;
+
+	guard(pagefault)();
+
+	if (IS_ENABLED(CONFIG_KMSAN))
+		goto byte_at_a_time;
+
+	while (!IS_ALIGNED((unsigned long)(s + pos), sizeof(word))) {
+		__get_kernel_nofault(&c, s + pos, unsigned char, err_out);
+		if (c == '\0')
+			return pos;
+		ret = bpf_str_set_lookup(set, set_bits, &set_pos, &set_complete, &set_first, c);
+		if (ret < 0)
+			return ret;
+		if (ret == reject)
+			return pos;
+		pos++;
+		if (reject && set_complete && set_pos == 1)
+			return bpf_strcspn_single(s, pos, set_first);
+	}
+
+	word_end = pos + round_down(XATTR_SIZE_MAX - pos, sizeof(word));
+	while (pos < word_end) {
+		__get_kernel_nofault(&word, s + pos, unsigned long, byte_at_a_time);
+		bytes = (unsigned char *)&word;
+		for (i = 0; i < sizeof(word); i++) {
+			c = bytes[i];
+			if (c == '\0')
+				return pos + i;
+			ret = bpf_str_set_lookup(set, set_bits, &set_pos, &set_complete,
+						 &set_first, c);
+			if (ret < 0)
+				return ret;
+			if (ret == reject)
+				return pos + i;
+			if (reject && set_complete && set_pos == 1)
+				return bpf_strcspn_single(s, pos + i + 1, set_first);
+		}
+		pos += sizeof(word);
+	}
+
+byte_at_a_time:
+	for (; pos < XATTR_SIZE_MAX; pos++) {
+		__get_kernel_nofault(&c, s + pos, unsigned char, err_out);
+		if (c == '\0')
+			return pos;
+		ret = bpf_str_set_lookup(set, set_bits, &set_pos, &set_complete, &set_first, c);
+		if (ret < 0)
+			return ret;
+		if (ret == reject)
+			return pos;
+		if (reject && set_complete && set_pos == 1)
+			return bpf_strcspn_single(s, pos + 1, set_first);
+	}
+	return -E2BIG;
+
+err_out:
+	return -EFAULT;
+}
+
 /**
  * bpf_strspn - Calculate the length of the initial substring of @s__ign which
  *              only contains letters in @accept__ign
@@ -4141,33 +4260,7 @@ __bpf_kfunc int bpf_strlen(const char *s__ign)
  */
 __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
 {
-	char cs, ca;
-	int i, j;
-
-	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
-	    !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
-		return -ERANGE;
-	}
-
-	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&cs, s__ign, char, err_out);
-		if (cs == '\0')
-			return i;
-		for (j = 0; j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
-			if (cs == ca || ca == '\0')
-				break;
-		}
-		if (j == XATTR_SIZE_MAX)
-			return -E2BIG;
-		if (ca == '\0')
-			return i;
-		s__ign++;
-	}
-	return -E2BIG;
-err_out:
-	return -EFAULT;
+	return __bpf_strspn(s__ign, accept__ign, false);
 }
 
 /**
@@ -4185,33 +4278,7 @@ __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
  */
 __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 {
-	char cs, cr;
-	int i, j;
-
-	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
-	    !copy_from_kernel_nofault_allowed(reject__ign, 1)) {
-		return -ERANGE;
-	}
-
-	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&cs, s__ign, char, err_out);
-		if (cs == '\0')
-			return i;
-		for (j = 0; j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&cr, reject__ign + j, char, err_out);
-			if (cs == cr || cr == '\0')
-				break;
-		}
-		if (j == XATTR_SIZE_MAX)
-			return -E2BIG;
-		if (cr != '\0')
-			return i;
-		s__ign++;
-	}
-	return -E2BIG;
-err_out:
-	return -EFAULT;
+	return __bpf_strspn(s__ign, reject__ign, true);
 }
 
 static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
-- 
2.55.0

