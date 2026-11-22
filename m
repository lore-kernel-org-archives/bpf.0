Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795358307;
	b=B8VDFQZO4/QdEgeWJ03PRxasIFD7JZ8T9QO0tVHEqdCid8Vsbx4K+Ff2BBg8uV5a1RIB
	 zGZtIhJT9Yu8ahGESNrMCYL9refOHmjL7qmjPFCMx4b4fyWPCIxWyHZjHgqVq7i/zafwt
	 dGSZe1w/Uv/x29LtpEGeyKWuQms/MlTxQT8MEs1bRSs+3mX8cdhLvYI1ytmhmlOC4tngY
	 YpO2lKSFQyuJ2wXuWHTFuNlcmD3pmgBUtYiHxMrR1RnOW2KPd1jYg2nSFFucd0fazwNjB
	 ZNfuiKouahXpRYSyknNbLNwGL3xn9jkSrgBaP4XrJSZOJjS7nVtCqCXbmm9NL8q+g8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795358307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qDCZ3AuSRCFb8+HUFsPmX0uGsbsC/oZrfmcest+AnFw=;
	b=HptT+BAyCkyNBwovtgLeiF3jBOB4MxZvdi03TEkUX7jSZaiKTiwo21hvDb4ztWeVmVKE
	 hsaXd7tqu09rZI1MDqIcicFv9LTdB73HyJLAszdL8iM7OTsc+mwjfNCCEf9TlbeQPt2wc
	 Z+Ei7OJ354C8yib/aTQWQZQAUoW4SfW4u/iuJ1RdRTAUvuLtoApsb4zceNsN27AmJFBl6
	 g6bUxX8q5eP99xt3GNPgmyYJPMVgFl6Bk+f1hlRVDCiPAxMth20krE32TK6sRdOT4yz9D
	 KGyEf6hO4uwPemaw80oYTuYnIG2UYdX9T7mAf9SRLjQV72QnTvSsknm+u4Y6JieDA4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bdzcd3Or;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40276606A687
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 14:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40276606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bdzcd3Or
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18818daa3e7so1464233c88.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 06:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795358305; x=1795963105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qDCZ3AuSRCFb8+HUFsPmX0uGsbsC/oZrfmcest+AnFw=;
        b=Bdzcd3OrZvvgENOzbAyHaNRUkB59oPT/E5QRj5aC0AtwNQBXkzZTYnLudwjihR40eh
         yBluj47t92U02nqepJCsaaZ7kIP4ciFpM6VfVwvrDMcbsNDPEb39l3zG+8pOpTvfNfOR
         bJWVtY3Kp1fgTZCuRUQJzEICuaTXKrr2T65hr1QrEEQPYaVQOiZFtjn68YFUjfdmXqiJ
         +r9BMhCNENo3J6GSB63Q6Se03vrB9E1x34WaVXUvALhh/wrOY4SUcu1dckF+SXcNe6bQ
         zX8Zd4AfFzNsZ9ekzqMZanGZ/kLbt9wUTpNyUHFMzDqQWfetFsuRrS9eFHME1Ys69RVQ
         nufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795358305; x=1795963105;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDCZ3AuSRCFb8+HUFsPmX0uGsbsC/oZrfmcest+AnFw=;
        b=EXhfBJ7FCskjd5odwPsy2sfdsiWw8IZxb6JVbCrAmZQVFXOkYxdjUkSNEG/iJMs9dN
         BC/g0D/+ZjQkBMRnq0ATcTVtzh0wTDYjhFsVM5zXutrME0jdGrmjhHjraVISUxJ2MbLw
         7imqUw7vW05wM8IqtgEWuaN0FD8+EVEHslxKvrzheXgAKkRsxctXAA9xMs6mpfYfmf8z
         fRKDbtesHUG9I+FbbwtL3blKtwhEmyje3XHWSMHq2PK//JiLF8zXEBYLHfxOQyEL9eXH
         mlNe8YJm6eavPxExJITSL0x7aSokN66SotjDnBC65TyrATD3ShcJkK6RNvupR2FYwWEs
         2O9g==
X-Gm-Message-State: APuU4Z8HF+oS/ZO5vsFLukfgJLCcTVBTFMZiO3SJIM8xWzUCBIw+gASv
	tJr/1Q3vF/Pk1E32HvAYrbT9Dw9Zue//DUzixc6/EGJEeR7WNCVAl0v3GLs/UCvMLic=
X-Gm-Gg: AZFdTZehQUFXtGozvE5qkoaix7ODfJkDVNq1VcqNnvNuRJI22lhtdq8FzxPPMnagx+f
	4dEYW5cnpy2boztjvP6+BLq7MVDds1MjlNEaIGxM20P7+7Cv5BibSDQdDHf5EThmkLu7HVuLUmb
	wS2mLjT3+0fxYaAmAsTz/juIPmtLpqSWyOzORiB4kLkXSvFn6nOo0c1lw6In60hjABNG4bNu6+L
	v50iiy0EW/bNS9yBuHhT+lmThqcYSfWVB+NeesacoGomWpoyxLuBHxbLZQS4w/HSEwFazOFUG3t
	bqZLDIU1LDI1lBnq048mwZES2PzGocQ4GIzS4fsFULp5GrP8GkpsqRYFuro/GLfNN08QsMZL1dx
	vyBt8wP0HBeeoOu3a5NL6H0hUb8VnRrqaRh8ArbZYKx1E3gKme7rgq63FJTX03XLJn8i9z7yY2T
	gAu8eXKqH7H6hWd/mnDLMQxGNBPDaXXT4LCrNdOUbj30J3rqBo2Sbok/n18h0pNsaTLQMCTm3A+
	p9aQwSmMU+y8tEft0Z4pRUakqyCx6bXPxBPf92ApaXy8jy3p9SNK03Im2MZA3f/NnTv2vLU07wl
	qdTu77R0AeqSYOir8XC9zhMipBlET3SkgVgoHFRf6EeEj5rv4hnD4uL0i5dcdJSnFA==
X-Received: by 2002:a05:7022:296:10b0:1b4:facd:5311 with SMTP id a92af1059eb24-1b5524972dbmr9254817c88.8.1795358305066;
        Sun, 22 Nov 2026 06:38:25 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm21265456c88.8.2026.11.22.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:38:24 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 20:08:14 +0530
Message-ID: <20261122143815.330528-2-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122143815.330528-1-abhishekkhade69@gmail.com>
References: <20261122143815.330528-1-abhishekkhade69@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the introduction of bpf_strstr, bpf_strnstr, bpf_strcasestr, and
bpf_strcasecmp in Linux 6.17–6.19, BPF programs gained solid support for
floating-offset substring search in null-terminated C-strings.

However, in network packet inspection (TC/XDP, TLS SNI tagging, binary
protocol delimiters) and security monitoring (e.g. BPF LSM hooks
inspecting raw memory or binary execution buffers), data buffers are
frequently not null-terminated and often contain embedded '\0' bytes.
For these use cases, existing string kfuncs terminate prematurely at the
first null byte.

Currently, developers attempting to search variable-length binary
payloads must choose between:
1. Writing a loop using bpf_loop() or open-coded iterators: Even with
   verifier inlining, this executes 1 subprogram call per byte and
   cannot leverage 64-bit word-at-a-time SIMD scanning, making it
   significantly slower than kernel-internal scanning.
2. Streaming raw buffers to user space via BPF ring buffers: This
   induces heavy memory copying and context-switch latency, often
   leading to ring buffer drops under high-throughput workloads.

To address this gap, this RFC proposes two complementary kfuncs in
kernel/bpf/helpers.c:
- bpf_memmem(): Searches for a byte sequence within a flat memory slice.
- bpf_dynptr_memmem(): Searches for a byte sequence within a dynamic
  pointer (struct bpf_dynptr).

Both functions wrap an in-kernel allocation-free scanning routine based
on the Crochemore-Perrin Two-Way string matching algorithm. By computing
the needle's critical factorization, the Two-Way algorithm guarantees
strict O(N) linear-time execution (at most 2*N comparisons in the worst
case) with strictly O(1) extra space, completely eliminating quadratic
O(N*M) RCU stall hazards without requiring artificial comparison budget
counters or risking premature abort false negatives.

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 kernel/bpf/helpers.c | 247 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2..fe66e413a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,6 +3406,251 @@ __bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offset, u64 si
 	return 0;
 }
 
+#define BPF_MEMMEM_MAX_LEN (2 * 1024 * 1024)
+#define BPF_MEMMEM_MAX_NEEDLE_SZ 4096
+
+/*
+ * Crochemore-Perrin Two-Way string matching algorithm.
+ * Computes the maximal suffix for lexicographical order (<=) to find
+ * the critical factorization split index and local period in O(m) time and O(1) space.
+ */
+static size_t bpf_max_suffix(const unsigned char *needle, size_t needle_sz,
+			     size_t *out_period)
+{
+	ssize_t max_suf_idx = -1;
+	ssize_t curr_pos = 0;
+	ssize_t offset = 1;
+	ssize_t period = 1;
+	ssize_t len = (ssize_t)needle_sz;
+
+	while (curr_pos + offset < len) {
+		unsigned char char_a = needle[curr_pos + offset];
+		unsigned char char_b = needle[max_suf_idx + offset];
+
+		if (char_a < char_b) {
+			curr_pos += offset;
+			offset = 1;
+			period = curr_pos - max_suf_idx;
+		} else if (char_a > char_b) {
+			max_suf_idx = curr_pos;
+			curr_pos = max_suf_idx + 1;
+			offset = 1;
+			period = 1;
+		} else {
+			if (offset == period) {
+				curr_pos += period;
+				offset = 1;
+			} else {
+				offset++;
+			}
+		}
+	}
+	*out_period = (size_t)period;
+	return (size_t)(max_suf_idx + 1);
+}
+
+/*
+ * Computes the maximal suffix for reverse lexicographical order (>=).
+ */
+static size_t bpf_max_suffix_rev(const unsigned char *needle, size_t needle_sz,
+				 size_t *out_period)
+{
+	ssize_t max_suf_idx = -1;
+	ssize_t curr_pos = 0;
+	ssize_t offset = 1;
+	ssize_t period = 1;
+	ssize_t len = (ssize_t)needle_sz;
+
+	while (curr_pos + offset < len) {
+		unsigned char char_a = needle[curr_pos + offset];
+		unsigned char char_b = needle[max_suf_idx + offset];
+
+		if (char_a > char_b) {
+			curr_pos += offset;
+			offset = 1;
+			period = curr_pos - max_suf_idx;
+		} else if (char_a < char_b) {
+			max_suf_idx = curr_pos;
+			curr_pos = max_suf_idx + 1;
+			offset = 1;
+			period = 1;
+		} else {
+			if (offset == period) {
+				curr_pos += period;
+				offset = 1;
+			} else {
+				offset++;
+			}
+		}
+	}
+	*out_period = (size_t)period;
+	return (size_t)(max_suf_idx + 1);
+}
+
+/*
+ * In-kernel binary byte sequence search using the Crochemore-Perrin
+ * Two-Way algorithm. Guarantees O(N) linear time in the worst case with
+ * strictly O(1) extra space, eliminating quadratic RCU stalls without
+ * artificial comparison budgets or premature abort hazards.
+ */
+static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
+			  const void *needle, size_t needle_sz)
+{
+	const unsigned char *h = (const unsigned char *)haystack;
+	const unsigned char *n = (const unsigned char *)needle;
+	size_t period_fwd, period_rev, period;
+	size_t split_fwd, split_rev, split_idx;
+	size_t h_idx, n_idx, memory, shift;
+
+	if (needle_sz == 0)
+		return (void *)haystack;
+	if (needle_sz > haystack_sz)
+		return NULL;
+	if (needle_sz == 1)
+		return (void *)memchr(haystack, n[0], haystack_sz);
+
+	/* Preprocessing: Find critical factorization split point */
+	split_fwd = bpf_max_suffix(n, needle_sz, &period_fwd);
+	split_rev = bpf_max_suffix_rev(n, needle_sz, &period_rev);
+
+	if (split_fwd > split_rev) {
+		split_idx = split_fwd;
+		period = period_fwd;
+	} else {
+		split_idx = split_rev;
+		period = period_rev;
+	}
+
+	if (memcmp(n, n + period, needle_sz - period) == 0) {
+		/* Case 1: Periodic needle */
+		memory = 0;
+		h_idx = 0;
+		while (h_idx <= haystack_sz - needle_sz) {
+			n_idx = (split_idx > memory) ? split_idx : memory;
+			while (n_idx < needle_sz && n[n_idx] == h[h_idx + n_idx])
+				n_idx++;
+
+			if (n_idx < needle_sz) {
+				h_idx += (n_idx - split_idx + 1);
+				memory = 0;
+			} else {
+				n_idx = split_idx;
+				while (n_idx > memory && n[n_idx - 1] == h[h_idx + n_idx - 1])
+					n_idx--;
+				if (n_idx <= memory)
+					return (void *)(h + h_idx);
+				h_idx += period;
+				memory = needle_sz - period;
+			}
+		}
+	} else {
+		/* Case 2: Non-periodic needle */
+		shift = (split_idx > needle_sz - split_idx) ? split_idx : (needle_sz - split_idx);
+		shift++;
+		h_idx = 0;
+		while (h_idx <= haystack_sz - needle_sz) {
+			n_idx = split_idx;
+			while (n_idx < needle_sz && n[n_idx] == h[h_idx + n_idx])
+				n_idx++;
+
+			if (n_idx < needle_sz) {
+				h_idx += (n_idx - split_idx + 1);
+			} else {
+				n_idx = split_idx;
+				while (n_idx > 0 && n[n_idx - 1] == h[h_idx + n_idx - 1])
+					n_idx--;
+				if (n_idx == 0)
+					return (void *)(h + h_idx);
+				h_idx += shift;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * bpf_memmem - search for needle byte pattern in a flat memory buffer
+ * @haystack: pointer to haystack memory buffer
+ * @haystack__sz: size of haystack buffer in bytes
+ * @needle: pointer to byte pattern to search for
+ * @needle__sz: size of pattern in bytes
+ * @flags: reserved for future options (must be 0)
+ *
+ * Return:
+ * * >=0      - 0-based byte offset of match in haystack
+ * * %-ENOENT - needle was not found in haystack
+ * * %-EINVAL - invalid flags or parameters
+ * * %-E2BIG  - haystack exceeds 2 MB or needle exceeds 4 KB
+ */
+__bpf_kfunc long bpf_memmem(const void *haystack, u32 haystack__sz,
+			    const void *needle, u32 needle__sz,
+			    u64 flags)
+{
+	const void *match;
+
+	if (flags)
+		return -EINVAL;
+	if (!haystack || !needle || needle__sz == 0 || haystack__sz == 0)
+		return -EINVAL;
+	if (needle__sz > haystack__sz)
+		return -EINVAL;
+	if (haystack__sz > BPF_MEMMEM_MAX_LEN || needle__sz > BPF_MEMMEM_MAX_NEEDLE_SZ)
+		return -E2BIG;
+
+	match = __bpf_memmem(haystack, haystack__sz, needle, needle__sz);
+	if (!match)
+		return -ENOENT;
+
+	return (long)((const char *)match - (const char *)haystack);
+}
+
+/**
+ * bpf_dynptr_memmem - search for needle within a dynamic pointer
+ * @haystack: pointer to dynptr representing the search buffer
+ * @needle: pointer to pattern to search for
+ * @needle__sz: size of pattern in bytes
+ * @flags: reserved for future options (must be 0)
+ *
+ * Return:
+ * * >=0      - 0-based byte offset of match in dynptr buffer
+ * * %-ENOENT - needle was not found
+ * * %-EINVAL - invalid flags, non-linear buffer, or parameters
+ * * %-E2BIG  - dynptr buffer exceeds 2 MB or needle exceeds 4 KB
+ */
+__bpf_kfunc long bpf_dynptr_memmem(const struct bpf_dynptr *haystack,
+				   const void *needle, u32 needle__sz,
+				   u64 flags)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)haystack;
+	const void *data;
+	const void *match;
+	u64 size;
+
+	if (flags)
+		return -EINVAL;
+	if (!ptr || !needle || needle__sz == 0)
+		return -EINVAL;
+	if (needle__sz > BPF_MEMMEM_MAX_NEEDLE_SZ)
+		return -E2BIG;
+
+	size = __bpf_dynptr_size(ptr);
+	if (size > BPF_MEMMEM_MAX_LEN)
+		return -E2BIG;
+	if (size == 0 || needle__sz > size)
+		return -EINVAL;
+
+	data = __bpf_dynptr_data(ptr, size);
+	if (!data)
+		return -EINVAL;
+
+	match = __bpf_memmem(data, size, needle, needle__sz);
+	if (!match)
+		return -ENOENT;
+
+	return (long)((const char *)match - (const char *)data);
+}
+
 __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
 {
 	return obj;
@@ -5214,6 +5459,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_dynptr_copy)
 BTF_ID_FLAGS(func, bpf_dynptr_memset)
+BTF_ID_FLAGS(func, bpf_memmem)
+BTF_ID_FLAGS(func, bpf_dynptr_memmem)
 #ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
-- 
2.53.0

