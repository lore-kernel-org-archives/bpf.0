Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343930;
	b=g/WW0RbgidcGUeaUZtUx21/T3JhXCdY+bRiqj9HdblUlA1FP3hv4yAj9fqA5qawfqefW
	 tBgevy/lZTHcsxVGokQTRO1MGCWir6rze2pHAyg/6r0hRjb3r/mYPEaM6aHI/aFMn5+zn
	 X0vQiThUL/w6yD14Y08XIWNAcGE6mZBh7IH8q87CPSOlnHp2DXhslYWvfV+stwX2YrYbN
	 rroajDyM+1dcg9fFFRgtLMollfJNAwSa31vzYWdQfbYZGo3juK4Wwg806hAAyju0u750N
	 tn5g23d9lO46yovuEeQt7gZuLDOdUQYsjAggqj9F+99wovbhkPb3R5RnQDXHZDRepeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=BXhgO1kakUVw/Lnq9T3SuvJ+p5G9NhKR6QNRYxXhq0k=;
	b=jxCZX+sXdYOK5PyjL15AevA5aNz6fcyXw4ka/w4/ADOHd744tHKg+L7uP8VL1vzrBKNd
	 9VgP0WsWonvThQXdSKQ5AkiSwVWj+/eelg9fxQZomewQ1ZVZKtvzuexaYlZrdfRr8iSyG
	 4ZckR+oYNUsx1AkhTG4vwYniMX1NPZnpOnNIPUY0qggtAEcPuaMqN7aiohoMMiYGp6RYd
	 QHrrXJvfXrih+Az4zxo7SSNlS7q/QTtRPCJKfU0KrfuXfHeTzcQtvE22Y1SuD2tXE9bSD
	 0FIzLy/DEpyLZQBbUs4o1iJOaa1JGgDoqDmclZfXvzjuRa7jjH5UjtjjcpqN035aHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P43PHLIe;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D62606A330
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 10:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D62606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P43PHLIe
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3866a784546so2801172eec.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795343929; x=1795948729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXhgO1kakUVw/Lnq9T3SuvJ+p5G9NhKR6QNRYxXhq0k=;
        b=P43PHLIeWdGUEIWy04Momf5Sdl3Pl29+NjleCIg1hioXxWxdr7h7g3ETogxPVfZNv3
         +lWTx9NOdlw4LALbKHLnY86vSvFjCOM9xfE88DLfDBbexWMcueO6/jpGSl+j/oQtERSn
         HsYmLK0z6+Wu5MTU6GuZZWnAXaMPwdNCwaVRP5O/xoZO6dK5gKaL4G8d2iJjGrCC1lLA
         oFW0H52ROxOwCC52hL52CqnfZdYUs9KnMI/KPsLbbQ3Cc9pzEO5UB3Klxmz6D3lvF7Sm
         aCJY2+rKWYx3IKXEDUuROWnmK7r/b5bwl+cM6iPf/l77bnt/2GRuEJhX5yi0Ecb2UA45
         uwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343929; x=1795948729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXhgO1kakUVw/Lnq9T3SuvJ+p5G9NhKR6QNRYxXhq0k=;
        b=CHh9tW02pT124e60v1hKpzh+8FkKJbM6bUVXRKheIBZyh0lj7AgcG6TZi1KpAN4+s5
         mFkYxc2L+HOu4CUnmBRbSMt5onhQzpMbBJKzG2NiSvYrBstZ4OY6Pgo9l4I5VzRGxZcK
         xce1pqpSzHelCQbE3V8s3AqvAyUPRAnNaP9Vg2T4x1okwCngQm7MoIjB3MN8GEIPxSd6
         6vKMQukBRq/x9GoFUURMEBIU3legQEJcdBpRczmYQIUGw1XlCVSsil8Rlb05/Y/Eqgsb
         ifH/Yiv0rb7fh+WW7c2mbq+71igMt7yvZuJhO1heX0wRKEz3A7tpbrDtk0kn5qWHiZq+
         8Iug==
X-Gm-Message-State: APuU4Z9p9lpGtdUVwI2cm+vVbeVOcGWdk321NmGGYPSAZCk91DtdeTZH
	e55jdSPVRsQ3b5DYjtKY/uxWXkMrVE1VTDvwU5aUOa7wQPyrKfecxocAFPAfTK9bAxI=
X-Gm-Gg: AZFdTZfi6zIOdD8sdLQbApWbMT0IjN8mR/YGWAcUKGhBDOBAJhjDTNRdEfAQLLB1lyf
	ZiZT7SiEn5wJOj7spTR8H3r+eggg6kojFIgEKDEiRj8bA5olOZTeM8hYRB1f0EBSv0Ib9w3YxOw
	GO78o5w0/4fW9kqp001Z+sYzyBVI7an6f7gWA0pLUtXeq8qnQ8P0t8hSw55BPKXCWepv2Uu+NDW
	150IVhyi4fFhlHUttdwUpPBUwaUYGL8TEns7gOS16v/eIdUj/vDl3Brk6DTaPfUzcUi6a0hQsu+
	T5nz8zKCayVWXDFJrQY50vL8wttCdikASMEdvDEyNRJZIDeFGTKEnRCmDdyc/LessMESF6+pVuW
	dxpwC0etjJwusqGZJbJB6gRUm2suDEu7HnH5qQ9wX8pRFK3s1fIfj6dt630H0Nz9ueraSqjz1Zd
	w2GYLW5B7r1K2IaL0tmZEWlujQVlCQ+tnA6r3zn/bzf5yCegTB5sqiCd0ZKwADpl6g8tbYMk5u1
	OdGT5ywZYxlMZkDxXduhcNIICU0wyuZFRP0rO7dL9ipqiCHtDaVBn+vdgSQfXv2qGS81jezrSfm
	L1MaxVE7QayxAtKSP++4qdOIeY7xcSjSJ7OspVsGV+xzUiEjymQXNkW5wTwU57NQ4m+hLESdCrq
	SAaaWPdhVYJg=
X-Received: by 2002:a05:7300:1486:b0:383:6eb6:5730 with SMTP id 5a478bee46e88-38570e24c0fmr10129276eec.32.1795343928963;
        Sun, 22 Nov 2026 02:38:48 -0800 (PST)
Received: from boogieman ([182.66.218.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm27124771eec.24.2026.11.22.02.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:38:48 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [RFC PATCH bpf-next 1/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
Date: Sun, 22 Nov 2026 16:08:37 +0530
Message-ID: <20261122103838.244974-2-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122103838.244974-1-abhishekkhade69@gmail.com>
References: <20261122103838.244974-1-abhishekkhade69@gmail.com>
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
on the kernel's optimized memchr() (leveraging word-at-a-time 64-bit
detection) followed by memcmp(), returning the matched byte offset or
-ENOENT. Buffer sizes are capped at BPF_MEMMEM_MAX_LEN (2 MB) to prevent
RCU stall/soft-lockup risks. Verifier bounds safety is enforced via the
standard __sz naming convention and dynptr type tracking.

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 kernel/bpf/helpers.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2..4b99bf050 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2991,6 +2991,119 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	return ret;
 }
 
+#define BPF_MEMMEM_MAX_LEN (2 * 1024 * 1024) /* 2 MB max search buffer */
+
+/*
+ * In-kernel binary byte sequence search.
+ * Scans haystack for the first byte using optimized memchr(),
+ * then validates the remaining needle with memcmp().
+ */
+static void *__bpf_memmem(const void *haystack, size_t haystack_sz,
+			  const void *needle, size_t needle_sz)
+{
+	const char *h = haystack;
+	const char *n = needle;
+	const char *end;
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
+ * * %-EINVAL - invalid flags or parameters (empty needle or needle > haystack)
+ * * %-E2BIG  - haystack exceeds maximum allowed search size (2 MB)
+ */
+__bpf_kfunc long bpf_memmem(const void *haystack, u32 haystack__sz,
+			    const void *needle, u32 needle__sz,
+			    u64 flags)
+{
+	const void *match;
+
+	if (flags)
+		return -EINVAL;
+	if (!haystack || !needle || needle__sz == 0 || needle__sz > haystack__sz)
+		return -EINVAL;
+	if (haystack__sz > BPF_MEMMEM_MAX_LEN)
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
+ * Note:
+ * For skb dynptrs, the inspected buffer range must be contiguous/linear
+ * (e.g. via bpf_skb_pull_data()); fragmented buffers will return %-EINVAL.
+ *
+ * Return:
+ * * >=0      - 0-based byte offset of match in dynptr buffer
+ * * %-ENOENT - needle was not found
+ * * %-EINVAL - invalid flags, non-linear buffer, or parameters
+ * * %-E2BIG  - dynptr buffer exceeds maximum allowed search size (2 MB)
+ */
+__bpf_kfunc long bpf_dynptr_memmem(const struct bpf_dynptr *haystack,
+				   const void *needle, u32 needle__sz,
+				   u64 flags)
+{
+	struct bpf_dynptr_kern *ptr = (struct bpf_dynptr_kern *)haystack;
+	const void *data;
+	const void *match;
+	u32 size;
+
+	if (flags)
+		return -EINVAL;
+	if (!ptr || !ptr->data || !needle || needle__sz == 0)
+		return -EINVAL;
+
+	size = __bpf_dynptr_size(ptr);
+	if (needle__sz > size)
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
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -5168,6 +5281,8 @@ BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
 #ifdef CONFIG_S390
 BTF_ID_FLAGS(func, bpf_get_lowcore)
 #endif
+BTF_ID_FLAGS(func, bpf_memmem)
+BTF_ID_FLAGS(func, bpf_dynptr_memmem)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
-- 
2.53.0

