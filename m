Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206830;
	b=bF5cDfipkEKZfODPykYmVWprAE46a3ZcBnkvdi0+8XDV7WSyevVEDj06DSFBdsaKer91
	 ssZe7q8+wasjUvYzxr/aIY2SRUab/HZOPLk3K2A45YIpwZX8snszfi4iLPon9MxxV0Yq7
	 Q3heHDRKFQhK2bqLFMKHR0I/QGjXkrLWSzT8wECdK/aHUivy80fbHm9q3/l0T5//oHAQV
	 vhtTGNMr6CL7kz/+0Sh6kABBj6cqXCC5ll8oxWQUdCb8rmEaU1bd6RTJi1MnmxKi1qp40
	 wYpq9f9fyTo6WKqGURjozJPXKiaonULlv0WnHretf0aXp73ocWvEiWQQwFybPyfH1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206830;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ivTlWOa8BdOVqPfgsEtZauxYhvtxD91erQVOhL8bRv0=;
	b=zL++uEQDKvonioAp7ItVE2lQODKpPNUQvu5FPDeFd23q0AR2bmafc27/OvhYI8T91SXw
	 eNAjGvCelrwk3pvgnvmib8qxeOrpLkAJOk9lpAR1CBy3XPqotOebALSFzVG2WImJhD75x
	 MyJtaBNrJ9XIMvJQ0TfTgaZgU/ha0pfacfWpGZpUlSaRhWK2JyyFJeS2PqVV9QLUse7CQ
	 bi8SGxff4Gnl7Cyh6eY22m9NimarKrsa/t67/hc4/05lkIKrHf/dnwlPvbGhKr6oC8TtS
	 Gl9lO/yll7hrX//IRWwgfD8bHcsX4b40skBxJ9Q7p2J5ag2/1YrFuw2fKArm3mhit6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AneWuapI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA7606A6EF;
	Fri, 20 Nov 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AneWuapI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29B01F00A3D;
	Fri, 20 Nov 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206830;
	bh=ivTlWOa8BdOVqPfgsEtZauxYhvtxD91erQVOhL8bRv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AneWuapIFAhsgyKZAbZPPv2opgQg/lh/66n175ThKBjrRC49uxDB8teDkxLxRTwn6
	 96GZ4EA1H1hquV8bNdgvQsy4ccKkt1jAVqjeWz2a8/tuB4pLYXgokkeJ3IhTOwdcwL
	 v9Qm2a4WGjX2EzrIIzon6GKVhyVxQRLd2tPt92YZuwKabUVDYxyjy7ypjSGz4vIPaG
	 5nvsaSSJyUQJ2W1RMtaLK0mpPlek8cW+A6BQy5QPSnHWJ/s4oQpQ84KUvXD89JEpQD
	 TdsM1EybR+c/5SM5YBU8/6+yM9j6UZH/bXegSEaVPLBNWIIcZPhvLgsLVHLGN/E2xc
	 V8xCoXdr1j40w==
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Nov 2026 15:33:17 -0500
Subject: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned
 iterator
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
Message-Id: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11742; i=tamird@kernel.org;
 h=from:subject:message-id; bh=xpFIpGTJZyQAHVCkROSg5MKc2skJHwWp6OJJtElGQD4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNkM62aq++8Vs99bFcH7sPedVUBLh0Cj9KEm07SwG3vef
 N8x9bldx0QWBjEuBksxRZZE0UN701Nv75HNfHccZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKn+tYWRYefrmSdzcltOvz4ztbTxmpF/6yKROKNI743JCvyb65Kauxn+Wc9KSnK
 IrVUTNL6kdP/hthkyhYd+S4hNnJB5I01slUEoDwA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Ring buffer records are exposed only through callbacks. Callers that
need to stop at an operation-specific condition have no non-error way to
end consumption early.

Add a caller-owned iterator that returns borrowed records one at a time.
Each next call ends the borrow and can publish consumed records before
inspecting another one, allowing callers to batch consumer updates.
Implement callback consumption on the same internal iterator core so
both paths share the record traversal and publication protocol. Allow
iterator-only rings to omit the setup callback.

Preserve callback validation, so callback-based consumption of an
iterator-only ring still returns -EINVAL. Keep the consumer-publication
barrier on early destruction, including bounded and callback-error
returns.

Keep overwrite maps out of the public iterator; handling a stale
consumer position requires a separate resynchronization protocol.
Require iterator users to observe exhaustion before waiting for another
readiness notification.

Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
 tools/lib/bpf/libbpf.h   |  67 ++++++++++++++++++
 tools/lib/bpf/libbpf.map |   3 +
 tools/lib/bpf/ringbuf.c  | 172 +++++++++++++++++++++++++++++++++++++----------
 3 files changed, 207 insertions(+), 35 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 856650d58578..cc9e141ffd0a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1541,6 +1541,11 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
+/* Opaque caller-owned iterator state. */
+struct ring_buffer_iter {
+	__u64 __opaque[8];
+};
+
 /* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
 /*
  * A negative return stops consumption; non-negative values continue. Stopping
@@ -1594,6 +1599,68 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
 					  unsigned int idx);
 
+/**
+ * @brief **ring_buffer_iter_new()** initializes a caller-owned iterator for a
+ * ring buffer map.
+ *
+ * @param it Pointer to the iterator to initialize.
+ * @param r Ring buffer map to iterate. Its ring buffer manager must remain
+ * valid until the iterator is destroyed.
+ * @return 0 on success; a negative error code on failure.
+ *
+ * Every successful call must be paired with ring_buffer_iter_destroy() before
+ * the iterator storage is reused or the ring buffer manager is freed. An
+ * active iterator must not be copied. On failure, the iterator is unchanged.
+ *
+ * A ring consumed only through iterators may be registered with a NULL sample
+ * callback. A sample callback is required to consume records through
+ * callback-based APIs.
+ *
+ * Only one iterator or callback-based consumer may operate on a ring buffer
+ * map at a time. BPF_F_RB_OVERWRITE ring buffer maps are not supported.
+ */
+LIBBPF_API int ring_buffer_iter_new(struct ring_buffer_iter *it,
+				    struct ring *r);
+
+/**
+ * @brief **ring_buffer_iter_next()** returns the next available record.
+ *
+ * @param it Pointer to an initialized ring buffer iterator.
+ * @param size Optional pointer that receives the record size.
+ * @param sync Publish consumed records before advancing.
+ * @return A read-only pointer to the record data, or NULL if the iterator is
+ * exhausted.
+ *
+ * The returned record's data becomes invalid on the next call to
+ * ring_buffer_iter_next() or ring_buffer_iter_destroy(), regardless of sync.
+ * When sync is true, this call publishes records returned by earlier calls
+ * before inspecting another one. Otherwise publication may be deferred until
+ * the iterator refreshes the producer position, observes a busy record, or
+ * is destroyed. Once this function returns NULL, it continues returning NULL.
+ * Create a new iterator to check the ring again.
+ *
+ * Only a NULL return establishes a notification-safe observation: after
+ * publishing the consumer position, the iterator observed no committed record.
+ * Before waiting for ring buffer readiness, drive an iterator to NULL. If an
+ * iterator was destroyed early, create another iterator and drive it to NULL
+ * before waiting.
+ */
+LIBBPF_API const void *ring_buffer_iter_next(struct ring_buffer_iter *it,
+					     size_t *size, bool sync);
+
+/**
+ * @brief **ring_buffer_iter_destroy()** destroys a ring buffer iterator.
+ *
+ * @param it Pointer to a zero-initialized iterator or one initialized by
+ * ring_buffer_iter_new().
+ *
+ * Any record returned by the previous ring_buffer_iter_next() call is consumed.
+ * Destroying an iterator before ring_buffer_iter_next() returns NULL publishes
+ * the consumed position, but records can remain queued without a new readiness
+ * notification.
+ */
+LIBBPF_API void ring_buffer_iter_destroy(struct ring_buffer_iter *it);
+
 /**
  * @brief **ring__consumer_pos()** returns the current consumer position in the
  * given ringbuffer.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a45666f546fa..5ab5a46fedb1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -479,4 +479,7 @@ LIBBPF_1.9.0 {
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
+		ring_buffer_iter_destroy;
+		ring_buffer_iter_new;
+		ring_buffer_iter_next;
 } LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 7bf92311da68..2e281e2fa573 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -255,64 +255,166 @@ static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
 	return 0;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r, size_t n)
+/*
+ * The private state aliases the public iterator's opaque __u64 storage.
+ * Allow that access without violating strict aliasing rules.
+ */
+struct ring_buffer_iter_state {
+	struct ring *ring;
+	unsigned long cons_pos;
+	unsigned long prod_pos;
+	bool consumer_dirty;
+	bool needs_wakeup;
+} __attribute__((__may_alias__));
+
+_Static_assert(sizeof(struct ring_buffer_iter_state) <=
+		       sizeof(struct ring_buffer_iter),
+	       "ring buffer iterator state exceeds opaque storage");
+_Static_assert(__alignof__(struct ring_buffer_iter_state) <=
+		       __alignof__(struct ring_buffer_iter),
+	       "ring buffer iterator is under-aligned");
+
+static void ringbuf_iter_publish(struct ring_buffer_iter_state *state)
 {
-	int *len_ptr, len, err;
-	/* 64-bit to avoid overflow in case of extreme application behavior */
-	int64_t cnt = 0;
+	if (!state->consumer_dirty)
+		return;
+
+	/* Release consumed records to the producer. */
+	__atomic_store_n(state->ring->consumer_pos, state->cons_pos,
+			 __ATOMIC_RELEASE);
+	state->consumer_dirty = false;
+	state->needs_wakeup = true;
+}
+
+static void ringbuf_iter_init(struct ring_buffer_iter *it, struct ring *r)
+{
+	struct ring_buffer_iter_state *state = (void *)it;
+
+	memset(it, 0, sizeof(*it));
+	state->ring = r;
+	state->cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
+	state->prod_pos = state->cons_pos;
+}
+
+int ring_buffer_iter_new(struct ring_buffer_iter *it, struct ring *r)
+{
+	if (r->overwrite)
+		return libbpf_err(-EOPNOTSUPP);
+
+	ringbuf_iter_init(it, r);
+	return 0;
+}
+
+static const void *ringbuf_iter_next(struct ring_buffer_iter *it, size_t *size,
+				     bool sync)
+{
+	struct ring_buffer_iter_state *state = (void *)it;
+	struct ring *r = state->ring;
+	int *len_ptr, len;
 	unsigned long cons_pos, prod_pos;
 	bool got_new_data;
 	void *sample;
 
-	err = ringbuf_validate(r);
-	if (err)
-		return err;
-	if (n == 0)
-		return 0;
+	if (!r)
+		return NULL;
+	if (sync)
+		ringbuf_iter_publish(state);
+	cons_pos = state->cons_pos;
+	prod_pos = state->prod_pos;
 
-	cons_pos = __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
-	for (;;) {
+	do {
 		got_new_data = false;
-		prod_pos = __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
-		while (prod_pos - cons_pos > 0) {
+		if (cons_pos == prod_pos) {
+			ringbuf_iter_publish(state);
+			if (state->needs_wakeup) {
+				/*
+				 * Ensure either this sees a new record or its producer sees
+				 * the updated consumer position and sends a notification.
+				 */
+				__atomic_thread_fence(__ATOMIC_SEQ_CST);
+				state->needs_wakeup = false;
+			}
+			prod_pos = __atomic_load_n(r->producer_pos,
+						   __ATOMIC_ACQUIRE);
+			state->prod_pos = prod_pos;
+		}
+
+		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = __atomic_load_n(len_ptr, __ATOMIC_ACQUIRE);
 
 			/* Retry a busy record once after publishing prior records. */
-			if (len & BPF_RINGBUF_BUSY_BIT)
+			if (len & BPF_RINGBUF_BUSY_BIT) {
+				ringbuf_iter_publish(state);
+				got_new_data = state->needs_wakeup;
+				if (got_new_data) {
+					/* Order the consumer update before retrying the header. */
+					__atomic_thread_fence(__ATOMIC_SEQ_CST);
+					state->needs_wakeup = false;
+				}
 				break;
+			}
 
 			got_new_data = true;
 			cons_pos += roundup_len(len);
+			state->cons_pos = cons_pos;
+			state->consumer_dirty = true;
 
 			if ((len & BPF_RINGBUF_DISCARD_BIT) == 0) {
 				sample = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
-				err = r->sample_cb(r->ctx, sample, len);
-				if (err < 0) {
-					/* update consumer pos and bail out */
-					__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
-					__atomic_thread_fence(__ATOMIC_SEQ_CST);
-					return err;
-				}
-				cnt++;
+				if (size)
+					*size = len;
+				return sample;
 			}
 
-			__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);
-
-			if (cnt >= n)
-				goto done;
+			if (sync)
+				ringbuf_iter_publish(state);
 		}
-		if (!got_new_data)
-			return cnt;
+	} while (got_new_data);
 
-		/*
-		 * Order the published consumer position before the next
-		 * producer-position load, whether below or in a later invocation.
-		 */
+	state->ring = NULL;
+	return NULL;
+}
+
+const void *ring_buffer_iter_next(struct ring_buffer_iter *it, size_t *size,
+				  bool sync)
+{
+	return ringbuf_iter_next(it, size, sync);
+}
+
+void ring_buffer_iter_destroy(struct ring_buffer_iter *it)
+{
+	struct ring_buffer_iter_state *state = (void *)it;
+
+	ringbuf_iter_publish(state);
+	/* Order publication before a producer load in a later invocation. */
+	if (state->needs_wakeup)
 		__atomic_thread_fence(__ATOMIC_SEQ_CST);
+	memset(it, 0, sizeof(*it));
+}
+
+static int64_t ringbuf_process_ring(struct ring *r, size_t n)
+{
+	struct ring_buffer_iter it
+		__attribute__((cleanup(ring_buffer_iter_destroy))) = {};
+	const void *sample;
+	size_t size;
+	int err = ringbuf_validate(r);
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	int64_t cnt = 0;
+
+	if (err)
+		return err;
+	if (n == 0)
+		return 0;
+
+	ringbuf_iter_init(&it, r);
+	while (cnt < n && (sample = ringbuf_iter_next(&it, &size, true))) {
+		err = r->sample_cb(r->ctx, (void *)sample, size);
+		if (err < 0)
+			return err;
+		cnt++;
 	}
-done:
-	__atomic_thread_fence(__ATOMIC_SEQ_CST);
 	return cnt;
 }
 
@@ -421,7 +523,7 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 
 unsigned long ring__consumer_pos(const struct ring *r)
 {
-	/* Synchronizes with the release store in ringbuf_process_ring(). */
+	/* Synchronizes with the iterator's release store. */
 	return __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
 }
 

-- 
2.56.1

