Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206826;
	b=CWQ+wAfCiR8e9gxGL1GoZTBl2CRbahFZhbX0FhG/iV32W5Y/mlXGz0rk859Cjy6bEDJx
	 OC2wcp8rnVmScum7sdfUppd2biE0MtLPU0WjQrbAOL596Y8L8nqka/VBvsv8rmXuG1RFS
	 NHPtCyQV5F2+KpOz2SZYeS2Aqu5LHZimJsYEOwK17ExVOJegJWgXqPdC4lnlKy4qQp0C1
	 D2Ph6qoENZFp9/BO9r7M98+PYQeOJEl/6wvWu2Z5kGAJtthixcidFemhCFZJaGZulYzn0
	 xCLKCOBmPqQkxuBJ+ceoJ6IzhdtcBvYfbbqz7TojS0ePLm8tFendt/KvcJJA3nLGfVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206826;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NwedfM5fVnl/Ma2lpycItx/H8Xscb5r5am0ml1b9cU4=;
	b=etBaDlQ+dCWvCRlHGw74CWwQw/q4gPeOnbf5AVksndIfIjyn8SSK0x3hZLtPCMqOrKuk
	 06mUyUu6yU4p8PC2t8Zs4/gHr7HwyG0EGRmdItvzPPcsk6c7FqeHFXbCHnEaJv8zUMaKZ
	 sIYnO1/YMQXuWNt0L46MOlXc2tGRHDznHbNbhT2C1O6xk/FCyFLi08Ar3GNPEvbx78fxx
	 NovzzkWdvfOHSUJyEI+OYoLNm8qveKu7wkYEbTojYDPMTsM1L65yCz7Zmr3ykD4XlYkrF
	 4ojW2a8ekIKXiu3Z2iZ1X+WqoJHP/5k4/N7gbvkgTvLUiXfqsOhNtSQArVoqO3lf2qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c8BI3J/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA860A2615;
	Fri, 20 Nov 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8BI3J/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A841F000D1;
	Fri, 20 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206826;
	bh=NwedfM5fVnl/Ma2lpycItx/H8Xscb5r5am0ml1b9cU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c8BI3J/PHbepv6CeMVJX1AVKdXWZAAGV8gsaNAiKvMdp5VOdMrPd4i5GcK8psnSzB
	 CCBfTIbWReKZNL2Rb62GB4DDkL14NwAc+ZbjFENJHxDyF0mlxbdyCxQaDZhLoTqn+1
	 nxy6F3NQusxgB4TyPKtH9p3PwEKY6MqhwFPGt+UhSoqwhfAiv0z2fsSNbsaqA6q7zC
	 rHSixEiTmY/KYsEau1dM5D/smPLDqCadBUsLyOIRdIbLtkrZr+dNCH9cHqpRhp2Em3
	 zgK1C12gBZ2NuaXE5lyKC3t0ofhUYjiWYdlN+fXfjJHY7knfhYwlCt+ZInJHoQEjOd
	 cwu5Z3U1MUYbA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:16 -0500
Subject: [PATCH bpf-next v3 3/8] libbpf: ringbuf: Prevent missed wakeups
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
Message-Id: <20261120-bpf-ringbuf-fixes-v3-3-ff7ca15d6c37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5348; i=tamird@kernel.org;
 h=from:subject:message-id; bh=D2pbZKoKhAlRHSit+/BYNBIcgENV+CY0bZzAei8JpU8=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62ZOMl13eec1E8WOb2cuyu4xq3t0fc8j4/i7O8qD1
 4X2dU+70jGRhUGMi8FSTJElUfTQ3vTU23tkM98dh5nDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10DHSMGbg4BWCqRcQYGXqOTxFjXZRgHdZY++ka00PWildsjxZKtXyoy2mR9dtwNJGR4bgwr2e
 uv0RN6foP395PMzsY8mR9sdka/1Ym7jQTpsdMXAA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

After consuming the last visible record, ringbuf_process_ring()
publishes the consumer position and checks the producer position. These
operations lack a full StoreLoad barrier. A producer can therefore
commit a new record but read the old consumer position while the
consumer reads the old producer position. The producer sends no
notification and the consumer waits despite a queued record.

Insert a full barrier between publishing a consumer position and the
next producer position load. When a record bound or callback ends the
current invocation first, execute the barrier before returning so the
load in a later invocation completes the same handshake.

After publication, retry a busy record once behind the barrier before
returning. Otherwise a producer could commit it and skip a wakeup based
on the old consumer position.

Document that bounded consumers and callbacks that terminate consumption
must drain before waiting again.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Reported-by: Andrew Werner <awerner32@gmail.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260614015716.945AF1F000E9@smtp.kernel.org/
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h  | 23 +++++++++++++++++++++++
 tools/lib/bpf/ringbuf.c | 18 ++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 49f1120f4021..856650d58578 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1542,6 +1542,11 @@ struct ring;
 struct user_ring_buffer;
 
 /* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
+/*
+ * A negative return stops consumption; non-negative values continue. Stopping
+ * can leave records queued without a new readiness notification. Before
+ * waiting for readiness again, consume until no records remain.
+ */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
@@ -1558,6 +1563,20 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+
+/**
+ * @brief **ring_buffer__consume_n()** consumes up to a requested number of
+ * records from a ring buffer manager without event polling.
+ *
+ * @param rb A ring buffer manager object.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed, or a negative error code on failure.
+ *
+ * Reaching the requested bound does not establish that every ring is empty.
+ * Records can remain queued without a new readiness notification. Before
+ * calling ring_buffer__poll() or waiting on ring_buffer__epoll_fd(), call
+ * ring_buffer__consume() until it returns 0.
+ */
 LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
@@ -1640,6 +1659,10 @@ LIBBPF_API int ring__consume(struct ring *r);
  * @param r A ringbuffer object.
  * @param n Maximum number of records to consume.
  * @return The number of records consumed, or a negative error code on failure.
+ *
+ * Reaching the requested bound does not establish that the ring is empty.
+ * Records can remain queued without a new readiness notification. Before
+ * waiting on ring__map_fd(), call ring__consume() until it returns 0.
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index db67eb98f3e0..7bf92311da68 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -271,16 +271,16 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 		return 0;
 
 	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
-	do {
+	for (;;) {
 		got_new_data = false;
 		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
 		while (prod_pos - cons_pos > 0) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
-			/* sample not committed yet, bail out for now */
+			/* Retry a busy record once after publishing prior records. */
 			if (len & BPF_RINGBUF_BUSY_BIT)
-				goto done;
+				break;
 
 			got_new_data = true;
 			cons_pos += roundup_len(len);
@@ -291,6 +291,7 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 				if (err < 0) {
 					/* update consumer pos and bail out */
 					__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
+					__atomic_thread_fence(__ATOMIC_SEQ_CST);
 					return err;
 				}
 				cnt++;
@@ -301,8 +302,17 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 			if (cnt >= n)
 				goto done;
 		}
-	} while (got_new_data);
+		if (!got_new_data)
+			return cnt;
+
+		/*
+		 * Order the published consumer position before the next
+		 * producer-position load, whether below or in a later invocation.
+		 */
+		__atomic_thread_fence(__ATOMIC_SEQ_CST);
+	}
 done:
+	__atomic_thread_fence(__ATOMIC_SEQ_CST);
 	return cnt;
 }
 

-- 
2.56.1

