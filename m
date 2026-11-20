Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206821;
	b=HtIJmUKYg2a76IpdrTyNrmuM0Mj6juYTmCowx/Agl+nYlWN2Qhmg2ajNvHxpB089QpQl
	 rt4jsKBdmHl9T43M3mZEYMpSKGgk8FzkcZoob5dYCvAQ0qUcJontkzi0SMomg+/Jc7Leb
	 39eH6fBE71PK4jJ9JsytrUAFqvcKDIUEsfO2FJOj2szOt7GGxBBesXu5J5b4wylnrs2M/
	 yy7euS6XJL6wt5b7NG5J8hn3eusCbdtUFgPYD6aMSZl4a/JLzEaUmXA1fKV21XskJEkTj
	 n9Dlf+4tvGnoANgVHloGeTJR1CePLKEf49NaB2SVcv5EEWOq2yBVmveCOiWZkgP26qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206821;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vLq58BTxujy2mAzB6yFuYYEink7v/X2VHReo6SQ4ZWk=;
	b=HETTDAen2YmhPmZbaYQeYqQwZDdA+8BKXd3OioSeCe17OCMHkgiA9P/erl6OTGQ2NLSW
	 uLOHEvWEtPlbPXqQcGwm1MIFbuIWz1b2JNHyWQVeJGxGLi9aqCmBHBh4cZ2hnoWFttY6L
	 loUvo5D8O9ZA4dtvXX/C3+UgbBF3mVzvbOGbUp+lwVGO8aSWG9zXj91q7SuTrXxEfJH9d
	 yaN0RDKUuit+QRShCSjer7A12NtKJGUPBfgMz5fOz+WyuEzBUQV2XvIq0i1RquIkQtJn/
	 CLjDgfgG8KA5un/S+LGC+j2LbDutakbcP+oAxtKk81JSdS0sQiZt6QmdvrWTDnAkNPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRqb7bho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9268606A6CA;
	Fri, 20 Nov 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRqb7bho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D281F000CA;
	Fri, 20 Nov 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206821;
	bh=vLq58BTxujy2mAzB6yFuYYEink7v/X2VHReo6SQ4ZWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PRqb7bhoNcv9zN6aev9dYnUfR/E7ufEIrCSQSFRvb/uQGqHBmU8Ny+wqIcBmSTvyb
	 g4dq9ygwMtibY4lw4adw5RkTODjRseFDvsy/3S+vtbhbOMy1b8WeRe/Kh+Z6FCEqjm
	 tBs+EljcZ6XQXRDJYg1fxrKR6CYrxCiduOSHVyxC5VDTk/3Tx7xwqoc1wqGTt7pgVW
	 eaGw2LkqU/ZOlDjBmSJB1KaSeEoRZSPKgXpWdXSHamqiILECl9l7aneFLz3OGpnvX/
	 U1LYDwdOE/iNPrVLxzN246Txxt1kllY5lw0gbmFYcdmSxzgmEO4jLWMTMQnAV2pH02
	 f5Fp6sbmVD6EQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:14 -0500
Subject: [PATCH bpf-next v3 1/8] bpf: user_ringbuf: Handle position wrap
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-bpf-ringbuf-fixes-v3-1-ff7ca15d6c37@kernel.org>
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
 Andrea Righi <andrea.righi@canonical.com>, 
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
 David Vernet <void@manifault.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=tamird@kernel.org;
 h=from:subject:message-id; bh=/lHWcWepousYSgA4rmNhFxJQz4Y7+Vqhb+CxZtIEEQo=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62ZeOsjVz9JcI1X1tGjhtGPzvH7eOP75/4U55z6v9
 /0Su56tqmMiC4MYF4OlmCJLouihvempt/fIZr47DjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOgYM3BxCsBUmxkz/K+vmNj3Ip7z1soCPu/D8w84xzpufN5791L5t/esYYfV/okzMjz7xb3
 15WuZZ53373YW7ljY/aTUga9cSFvmkGympODCA7wA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

User ring buffer positions are unsigned long counters, but
__bpf_user_ringbuf_peek() widens them to u64 before comparing and
subtracting them. On 32-bit systems, producer_pos wrapping below
consumer_pos therefore appears to move backwards and permanently stalls
the ring.

Keep the positions word-sized and derive the available data with
word-sized subtraction so the arithmetic wraps with the counters. Treat
a zero span as empty and reuse the distance for the advertised-window
check. Validate sample sizes before rejecting a window larger than the
ring, preserving the documented -E2BIG result for oversized samples.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260614020552.022A11F000E9@smtp.kernel.org/
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 kernel/bpf/ringbuf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 447863ece26a..5494c0977153 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -747,9 +747,9 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
 
 static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
 {
+	unsigned long avail, cons_pos, prod_pos;
 	int err;
 	u32 hdr_len, sample_len, total_len, flags, *hdr;
-	u64 cons_pos, prod_pos;
 
 	/* Synchronizes with smp_store_release() in user-space producer. */
 	prod_pos = smp_load_acquire(&rb->producer_pos);
@@ -758,7 +758,8 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 
 	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
 	cons_pos = smp_load_acquire(&rb->consumer_pos);
-	if (cons_pos >= prod_pos)
+	avail = prod_pos - cons_pos;
+	if (!avail)
 		return -ENODATA;
 
 	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
@@ -769,7 +770,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 	total_len = round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
 
 	/* The sample must fit within the region advertised by the producer position. */
-	if (total_len > prod_pos - cons_pos)
+	if (total_len > avail)
 		return -EINVAL;
 
 	/* The sample must fit within the data region of the ring buffer. */
@@ -781,6 +782,10 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 	if (err)
 		return -E2BIG;
 
+	/* The advertised window must also fit within the ring buffer. */
+	if (avail > ringbuf_total_data_sz(rb))
+		return -EINVAL;
+
 	if (flags & BPF_RINGBUF_DISCARD_BIT) {
 		/* If the discard bit is set, the sample should be skipped.
 		 *

-- 
2.56.1

