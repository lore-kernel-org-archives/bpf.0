Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795350881;
	b=MgVvOAm7/yiPnVC8NmCi0g7N4bUOpf+u6x2dlZFCS2tVLjJZOca5A4uonp1FNJb6HDeN
	 3ybUwJ+ZEerkdeV8L9x9K1jnTvNTX2C3U3jkn8DWPEAD0kFtXEHb1GCneJiBcPfkNdy1Z
	 nYSFbSN5fwT6eMDOi9kJ7Iico1sSnzxJ9bRV9IzRm0pq58d/1hlIRL7TXvUmILs56raAk
	 Q4QSux2EW1vTzN708cupXZXLBE5cprA1mh5d37YHA/OQ5FhQ5zKF3c9RXiPswWCBPwO7K
	 L9vPdHGwjQCSIX5dffewDO3ecyIo8J9FPGnurcrFK9aqDQ1PNvxQZMGfkQrGASJTn5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=HwshFOaGVaZp5SLNtmKSxUjjmNjEApu6X0KHjtHf+i8=;
	b=aw+aqSIC10+NxabuLE0d87EtRPiKe3whYT6QuH2VwFNpTxSNbUinVir9rsV3ft1tqqg5
	 /dDcIIn8JQWCd+XApUdOUseRjCIrzadgAfRReCLL1sAKD/N9aBcGkRIgyFgtht/buA3BZ
	 RpkKSsQDWU7RWPdr1l5SlYRktPkwRq3pwXWfjW6w0YYkrtEUa80kcGBGUrn4dgsny084k
	 1qH+xH33OY1m6b2nZ05y3HcOZ4mLhtDRu5IvgPrTDk9HWu+3VmM54X4kcWUzoh9m2+ng+
	 a2/e0lJo98BEeGXDFQvZhkrJdOqOmiILznHg0ZwIWO/t7o7+pCDtiV+JQz1tFyuHhhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbVSzsdN;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A5606A320
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 12:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6A5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KbVSzsdN
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38692f62b22so167365eec.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795350880; x=1795955680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HwshFOaGVaZp5SLNtmKSxUjjmNjEApu6X0KHjtHf+i8=;
        b=KbVSzsdNN2VC2lawaTwUtAamviG8DtIqGiiKGKzCK7ZTJovKt6nPxVVMVGA1W7d53C
         kdD8g4Ft+hS0qWW5T26TsoKiOSpFgqEM0SfUwaE6R1F8TqA0JpNgQT5qQkCYnE+wO0E2
         dQmd+xdJO8W8ixnAl5Ju7wNHMdUQZtoq+Pi2CqJ/Mq03tu8wemBaZ3S3PpiDsVYx5xwE
         nGagZ1wAlbqdEzTVB+5SV6DHYyxBAg6P56zgWfevr2vBdrjDNkZpR9R1V1NnE76Bkyoe
         h8FcHvGBxbZT6J6LA6obUqXZmOhW/orWsPFGo0Ji0wL/371wHdV+jeFQu6UUkCGZTLUy
         wJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795350880; x=1795955680;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwshFOaGVaZp5SLNtmKSxUjjmNjEApu6X0KHjtHf+i8=;
        b=FECcc0hS2PjHaw8oW38YmvjpSSn8wpL/6OWexu2Ob+ytUT1cXShMMtvFL4mcRPCCt1
         LL9HGinAXYJtnGAT9hG7PZGjcWhp1MrD2C2vbv8ka8rJ98N7wkaAu5W+abm1NQf32S6F
         svBJ4fQbQCLmYSuYXGaGAcL5228nM49rokWEpwDn8q+VLWogUk9m3Ca7D0ojGEDR13Ps
         VHPk88PP4kjjM939w+H1d6+i7XFtcscEbIW5oBXiL7cl6ld54UyJOQumXuMJ0TpuG2tR
         dnQqpVwPIpJYUDt5fMwyUyh6LvltDB8Cn72G4y+yqQyrqZx+7pfd6XvqH8y0kz8H0/Bp
         6fuQ==
X-Gm-Message-State: APuU4Z/ovJAoD2nyegBmMb3eKYPjDhtsUJFDWoFjLKsAAgbeJSVGUnui
	qIuQ4ilqCEbN0xDH94YL4cEKhuEbiW3xuWzTMORn5x1xh6emNy8uxaeOaarsyGgXMHk=
X-Gm-Gg: AZFdTZdqQcSd090Byih4c0z1e7Lug630b179n+5KiLlnEQnfkTqr5kjE3IInQM0WQjU
	EMiZc1LQB03HdDWdJiPDGkazpB9JF7ZNy/IDRB0o0LJ+pHMnH2nBBz/UMWO5rxN1+idyJhlbm+R
	c6+LFQncw8b2gkvzwal8nFlXIvfoO3mo+Yva5Z1chNB6pmG4ZEfbK1DIfWnKG7tGkufMT6abnna
	sjeqYp/cOHtc32AQ99y4QTdIRgYCmF0G7s+Nols7rpVOPGeAo+gTDeahLDWZxeFWLC+t3do8IhM
	wTOO0mAEa77G9UWehwYwS+GyO6rMMB14cUTx3Qp0XZjM+xIAVkBVfFQ3DsORY362sWAecQ6iZqo
	Dlkvg1ZCkeY/jmrp+XV1hOZ+UhBo/d/Iv9qoRwOoe7MG3n2bbLMI5R5WwiMC8QCMqEPoSRFDjRe
	fw6UJntfYLQpWKx6qjIT3qzBEu2gz0RjRf+GjxaPvpOqhhzl4mNCVsRDZyzKjXTvl5IVH9GylwY
	mTkKCRslhVumjHgFEdPrfWj/kRA9iQX+HzthF/mk3nI9pNm3Qz92VKGpPdKSD42L6R158fdCLQo
	9Qda772KU+xlltmN3Re15uoj+ykNu+pREjDtCL3SSJno3JvhxJYvOni6+fGZc/NT1A==
X-Received: by 2002:a05:7300:2209:b0:386:8d2:929b with SMTP id 5a478bee46e88-38608d2945emr11724068eec.23.1795350880245;
        Sun, 22 Nov 2026 04:34:40 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm33372330eec.5.2026.11.22.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:34:39 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next v2 1/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 18:04:26 +0530
Message-ID: <20261122123427.287521-2-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122123427.287521-1-abhishekkhade69@gmail.com>
References: <20261122123427.287521-1-abhishekkhade69@gmail.com>
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

Both functions wrap an internal allocation-free scanning routine based
on the kernel's optimized memchr() followed by memcmp(), returning the
matched byte offset or -ENOENT. Buffer sizes are capped at
BPF_MEMMEM_MAX_LEN (2 MB) and needle patterns at BPF_MEMMEM_MAX_NEEDLE_SZ
(4 KB). To prevent pathological quadratic O(N * M) RCU CPU stalls,
cumulative byte comparisons across memcmp calls are strictly bounded by
BPF_MEMMEM_MAX_LEN. Verifier bounds safety is enforced via the standard
__sz naming convention and dynptr type tracking. Both kfuncs are
registered in common_btf_ids to allow access across all program types.

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 kernel/bpf/helpers.c | 116 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2..1f27ad21a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,6 +3406,120 @@ __bpf_kfunc int bpf_dynptr_memset(const struct bpf_dynptr *p, u64 offset, u64 si
 	return 0;
 }
 
+#define BPF_MEMMEM_MAX_LEN (2 * 1024 * 1024)
+#define BPF_MEMMEM_MAX_NEEDLE_SZ 4096
+
+/* In-kernel binary byte sequence search using memchr() and memcmp() */
+static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
+			  const void *needle, size_t needle_sz)
+{
+	const char *h = haystack;
+	const char *n = needle;
+	const char *end;
+	size_t total_cmp = 0;
+
+	if (needle_sz == 0)
+		return (void *)haystack;
+	if (needle_sz > haystack_sz)
+		return NULL;
+	if (needle_sz == 1)
+		return memchr(haystack, n[0], haystack_sz);
+
+	end = h + haystack_sz - needle_sz + 1;
+	while ((h = memchr(h, n[0], end - h)) != NULL) {
+		total_cmp += needle_sz;
+		if (total_cmp > BPF_MEMMEM_MAX_LEN)
+			return NULL;
+		if (memcmp(h, n, needle_sz) == 0)
+			return (void *)h;
+		h++;
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
+	if (size == 0 || needle__sz > size)
+		return -EINVAL;
+	if (size > BPF_MEMMEM_MAX_LEN)
+		return -E2BIG;
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
@@ -5214,6 +5328,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_size)
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

