Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206833;
	b=imcnDrWXDO2D768kHxS2DkxTikT8f+BaESL5G26iEAidu16f2i414kU3zdRqFZNJXf8h
	 bRJLAYW3yoeCRT9lj3mVVdhxeG4wtlTNj3mnYlv+OgURG0jskWcIVxfRVGuTQvKMsR7jm
	 mzFEA2THXIDs4Wm3m38bCVKH78qqum+kT2uYmvMD/xSFtT9ob4b0C8pfL8TutPT0a8mG7
	 AMPIfITy3rwQS1xkFelnp93RPRdKdYW9e9ctLBUfgAxUhs4QK4GpnSigjbFF0R0Y77waI
	 z9ElK9Typ96HDFbktxBY4bsPH6wPcEu0hRsHPbwCSaz2ZL6sxBK5D6QiUSBS+BWfhnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206833;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dMi5qotgpV92DRKiTnUckxogR43ZUvKJiL8sMXtWcOs=;
	b=jDWhDSKtZj2yVbDgRzbw+XRFtIa8oKoUnd53oAsHXzvwroMtmQjKFO/rgHHK9vqy001C
	 /QA8o0/gjgD4FaF0eBjXqObdPDycYN17W7yDkMhZoUqEw2WcFemd8R7c43O/0RFmtlLAN
	 HpKwUU3yeWkkhkygD0D5VCJW6nZcqcGTA5iwjhHrfPuZm96ikcQE9HpDtvGCKu91F0hd7
	 YVpJSz4F9mZdJs4wRi0R6utBmWgc+seSHtJ01fqry+uVPC2FOd/qJH3Jqg6lNurs9+1vu
	 Q3BnjH6W3XisXlT2rgp6nROc7Jx+8McnBgugKYh6AY8F7st6fzbVeFhJioX2YhLOZ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9l7dBVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A8606A6E2;
	Fri, 20 Nov 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9l7dBVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C31F000F2;
	Fri, 20 Nov 2026 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206833;
	bh=dMi5qotgpV92DRKiTnUckxogR43ZUvKJiL8sMXtWcOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h9l7dBVXFs0JNer4hc4n7ZRsNhKmTKoTRZfDwPIDRuhYj1byEGeXlhYjwNHuv5y25
	 if2UlGOa4bSHhZXrQIyZLKA+vcvthZnAYY8rRPkaAzYjnQMmp2XVZtxgd7Hk1Tv0hI
	 xtMZSEOIkShhNxrryRqFa955ZbcdBoH9CEXMHAnqCe0Ig34Zargrl7xy9OmzH3p8P4
	 ph6XSgwLtnut3OmQqu5nk3Jh6TD5kjiVBpaMqDbofo75yqQtOjf7WLLZF/c/I6L+3V
	 WNWkWRJZnDXs3P5UX6JzbO1rzkbfEQlPo2nPjogNLmfMSk0R2bjPwtXNdmygybcTcM
	 4yJN5yLNhmWKw==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:18 -0500
Subject: [PATCH bpf-next v3 5/8] libbpf: ringbuf: Simplify iterator
 implementation
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
Message-Id: <20261120-bpf-ringbuf-fixes-v3-5-ff7ca15d6c37@kernel.org>
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
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3640; i=tamird@kernel.org;
 h=from:subject:message-id; bh=4sn4qc6EyWTFo6v4x3WIdruy+RpIRlHtUwTkC9vDjWo=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62Y90/lkEMho9d8/8LpBHG94k9cffpkw25kqXSYtC
 s3teus6JrIwiHExWIopsiSKHtqbnnp7j2zmu+Mwc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 kY6BjjEDF6cATPXSXIZ/ZisOa+y9+5r3pu85T8tnFWJOTjv7pLU3sjWadlT3KBeqMPwznDXHcc2
 kqP9JKz83qyW+33yAtbte+xC/xZvEgBmbjb9wAQA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

The iterator core retained ringbuf_process_ring()'s nested loop shape to
make the functional conversion easy to compare. This leaves mirrored
position variables and a got_new_data flag to coordinate the two loops.

Express the same protocol as a single loop over the iterator state. Keep
consumer publication, producer rechecks, and the single busy-record
retry unchanged.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/ringbuf.c | 68 ++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 2e281e2fa573..9da54e6b5acd 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -311,20 +311,14 @@ static const void *ringbuf_iter_next(struct ring_buffer_iter *it, size_t *size,
 	struct ring_buffer_iter_state *state = (void *)it;
 	struct ring *r = state->ring;
 	int *len_ptr, len;
-	unsigned long cons_pos, prod_pos;
-	bool got_new_data;
-	void *sample;
 
 	if (!r)
 		return NULL;
 	if (sync)
 		ringbuf_iter_publish(state);
-	cons_pos = state->cons_pos;
-	prod_pos = state->prod_pos;
 
-	do {
-		got_new_data = false;
-		if (cons_pos == prod_pos) {
+	for (;;) {
+		if (state->cons_pos == state->prod_pos) {
 			ringbuf_iter_publish(state);
 			if (state->needs_wakeup) {
 				/*
@@ -334,46 +328,44 @@ static const void *ringbuf_iter_next(struct ring_buffer_iter *it, size_t *size,
 				__atomic_thread_fence(__ATOMIC_SEQ_CST);
 				state->needs_wakeup = false;
 			}
-			prod_pos = __atomic_load_n(r->producer_pos,
-						   __ATOMIC_ACQUIRE);
-			state->prod_pos = prod_pos;
+			state->prod_pos = __atomic_load_n(r->producer_pos,
+							  __ATOMIC_ACQUIRE);
 		}
 
-		while (cons_pos != prod_pos) {
-			len_ptr = r->data + (cons_pos & r->mask);
-			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
-
-			/* Retry a busy record once after publishing prior records. */
-			if (len & BPF_RINGBUF_BUSY_BIT) {
-				ringbuf_iter_publish(state);
-				got_new_data = state->needs_wakeup;
-				if (got_new_data) {
-					/* Order the consumer update before retrying the header. */
-					__atomic_thread_fence(__ATOMIC_SEQ_CST);
-					state->needs_wakeup = false;
-				}
-				break;
-			}
+		if (state->cons_pos == state->prod_pos) {
+			state->ring = NULL;
+			return NULL;
+		}
 
-			got_new_data = true;
-			cons_pos += roundup_len(len);
-			state->cons_pos = cons_pos;
-			state->consumer_dirty = true;
+		len_ptr = r->data + (state->cons_pos & r->mask);
+		len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
-			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
-				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
-				if (size)
-					*size = len;
-				return sample;
+		/* Publish prior records and retry a record that is still busy. */
+		if (len & BPF_RINGBUF_BUSY_BIT) {
+			ringbuf_iter_publish(state);
+			if (!state->needs_wakeup) {
+				state->ring = NULL;
+				return NULL;
 			}
+			/* Order the consumer update before retrying the header. */
+			__atomic_thread_fence(__ATOMIC_SEQ_CST);
+			state->needs_wakeup = false;
+			continue;
+		}
 
+		state->cons_pos += roundup_len(len);
+		state->consumer_dirty = true;
+
+		if (len & BPF_RINGBUF_DISCARD_BIT) {
 			if (sync)
 				ringbuf_iter_publish(state);
+			continue;
 		}
-	} while (got_new_data);
 
-	state->ring = NULL;
-	return NULL;
+		if (size)
+			*size = len;
+		return (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+	}
 }
 
 const void *ring_buffer_iter_next(struct ring_buffer_iter *it, size_t *size,

-- 
2.56.1

