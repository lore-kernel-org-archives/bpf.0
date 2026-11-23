Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468435;
	b=oQ/d/3xiIYQSNQolVfc2YUesC1clNhd7jsDEkWKFo3THp2sr34Hofz16ktT45tuauABy
	 r5jNbPjp13/a3W31DMKgBDtnmq2M/6R64RVlyIe87wuOfTsaLULlwSMmtYLLG3kYXNWjj
	 Qq2QfPcYKp13ar/guko2dAEykTP8HEN1cqurzfWgXix5d0C3CopYKYRvx8AQTS/fMKc7A
	 NBcGtH7s1ejyiTPCf30oVhZZ0wgFY5W6DN116z8XAsQGi+MFLupPn8x8IomGi1Z+LbQum
	 q7RChtv+ICQ8ioREToSfJENxJJuFKO6dSGRvFMCJ2ISwjFeT3OFhvNtl8FLEUxjvVyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=3g7mNaC9uDVJCpEfl5YqruRy6UHrQhjUrRAL3Z/ppYo=;
	b=V1BETwoc3T8k+EIpKGva1QeB73m8H1dgtDt/19arbiC8qf9Aj2qbhHPqvf2X5E+txpMP
	 e/DODrb3UF0gMAVtxMnBVRQkCFWhy57iTenbaPcvLZMFWlOXtge35WqhXJIneyZs4fch2
	 cZI0VZTvYt8hZF+59P9tVVSSDFPzH1XD5Ykr0MCla/YpmB7VF4yd8rnwpN32f6YUU9OFt
	 CRjOsa/bxBxJIJnvjmwvo8Okavnmr2GXnq7dJyKr71VxojHYwOvtYEx0rU87NbdSQVkNE
	 WYeA/nA+MfktSBccCB50Eaw89BYf067QNnBUpSy9JShFcVwpjzuqAqQiMAKI3MUzyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qJ0/qXQj";
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939A606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1939A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJ0/qXQj
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso1081137b6e.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468434; x=1796073234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3g7mNaC9uDVJCpEfl5YqruRy6UHrQhjUrRAL3Z/ppYo=;
        b=qJ0/qXQjUma2ACj2wjnBU3xDvk6Dcwl298tBQDylyYeRSUinqsRWCm3BiaNpcH3uIu
         6KTUHFxzpYjJBzym8Q5k7oJ0cCsDVihmNeI7tkls04VuZ1yZxo3foiez7VxO5J4Wmaqd
         PhdkyxvZCqKhQWtoWWXq2MhFDNRfgLZWHbnC7k1M3Rr204C3ibRFn9SDCVrbkJSm/2V0
         VzPdC7byvX5rdvMas+mJR5PVA/WhLmRnphAAfxZ8TPgOhOOcjLJ9JHfLkVuXwjLtnlRW
         v5fIgHKOo+67CmP6FiHl9qnxY3flatvHVvfEuP4sc4zWO6L02kXSacc/5iwqx33m0lQh
         43ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468434; x=1796073234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3g7mNaC9uDVJCpEfl5YqruRy6UHrQhjUrRAL3Z/ppYo=;
        b=npsKxJsh1MyOjkUM7KbmGt564nqI6jO60dSvLDOIBCWJxHKcvlWlNNImmgk1MU2BuZ
         qSGGrGRfibiw1KNhd9Uq5HQ5BW/6KTa41dJMQktb7xVXL41CA+T4Yo9WuRR3B6kN7I1N
         Z+SM/eu2ziagIgi890e/IMZm4yAw6TiRyJDAOJ6ZxCio6GSdgYzO+BLtxSrbFi34cxzI
         X+7lfi39O3Ju/7xSMvMi1kuV6A8WmJ/rMN8TseUQa4svYV8pZUt55oqBQF1eA9LjukUx
         pbgBT8y7lbS8JepGlAF/SkorZvHMzmdqk0UWIDcE/CyW4QA1CNAYk4hFEfm1AIHSylSX
         jKeA==
X-Gm-Message-State: APuU4Z9myDVg1AYQ95F4vd1I9WzVAz7+RRm7TBH6jK1AtwDMkte44qBL
	ABWsHwOu7xUjo2MfxC6Vyg6BDJbJ1HMxkPwNHJhJokwhUh9MqjzlqreaiiYlAHcdCzg=
X-Gm-Gg: AZFdTZd4FjjU4xkfYXP9DABaHmRtPPEIPnJVx2M1xJPmIgzSq3uO7A9OJAor5k48uMT
	3yhiqHHoeJpFaOhkDsoKjjmd7ZIL9con9a1kT2Vwk5o9BzKLNFltbTnH0cyhXnG2TpzqrvU1lVd
	0LDgKqRJHxaRHuZOhHlF+P/AUERN4nlvOYcwGsaKF8mDWFFNLTLymuGPIJq8TL2gJC22/998tW1
	ei5qPCKFqT8d3Tsb+nR3AEDkIk6fUoOwyCj/xhIIIGFDH/Phumk3kb8cEJS2GDN6o9nwMAzoJPt
	wBnQ/0T2kxMtm5VQrjdguN5iTsdTFQ7h32LAsC1wgYqv6XUQbZ8To5y7+5xzAG9Qsx73lgLehaK
	tynwmT2jscOKTfhM97LgezwTIe5KYwqbd1uzdMqaTXIXSvYmcaGgQOECPzV3x3kiksV42svlBdR
	V21WivAQHbHV9DSDMksE1eS26+vYiqfcW4hHvY8KOEXYrGYNkeKCsXST+mqAG8X6IFD05psALhl
	+Aq+WpSajl39lgFwVEyQlvkALKgBqLKsuZ7SZO4K1kpyQKNrPpcoFM4It3n49cmO4J0U+Tf1JYz
	iqzM+6EPg8KTkAhsDGxCEheoaryki8OXP6HyqSBcqbaVgstPNU3kKggP0/HlEC7NaaZPzW3iQ15
	BYdcvnJqKlaeQhgqAj1buOMsUZy5bhhBjHuESl6ItcTye553CEajQHk41lQ==
X-Received: by 2002:a05:6808:308d:b0:557:308a:9e9a with SMTP id 5614622812f47-57a095037bemr15529775b6e.21.1795468433952;
        Mon, 23 Nov 2026 13:13:53 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34763004sm9514496b6e.8.2026.11.23.13.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:53 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/10] libbpf: Add a record API for consuming BPF ring buffers
Date: Mon, 23 Nov 2026 22:13:28 +0100
Message-ID: <5a8c1d9b7fda04e57e15ac897d65fa95c569b55c.1795467315.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9411; h=from:subject:message-id; bh=E/ey34Mz0z+GlF3uZVSgZzvWx7R9Qmqwj0lRFhd0XSI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhUmPgtrtJaz1r1hue+WF73O9xXXHuWvNlelfrP00760o CvfsKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQmX2Rk+M9c+i/hp730foEH3VukM1 WWacwxXFn4/sWWM77JIa2mzIwML3kL8807L+Ql/X/ZxTjhdmtZaH3aREuLvb5evo+uhYezAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Ring buffer records can only be consumed through a sample callback, e.g.
from ring_buffer__poll() or ring__consume(). Add an API that returns the
records to the caller one by one instead:

  const struct ring_rec *ring__next(struct ring *r);
  int ring__release(struct ring *r);
  void ring__rewind(struct ring *r);

ring__next() returns the next record without consuming it, or NULL if
there is nothing to consume. errno is set on any error. ring__release()
consumes all records returned since the last release or rewind.
ring__rewind() goes back to the first record that was not released, so
that ring__next() returns the same records again.

	const struct ring_rec *rec;

	do {
		while ((rec = ring__next(r)))
			handle(rec->data, rec->len);
	} while (ring__release(r) > 0);
	/* wait for data, e.g. epoll on ring__map_fd(r) */

Records stay valid until they are released, so the caller can process a
number of them and update the consumer position once.

ring__next() invalidates and reuses the previous struct ring_rec, so if
the caller needs to access multiple records they need to copy them
separately. The struct is embedded in struct ring and followed by two
unsigned longs that are always zero. If a later libbpf adds fields to it,
an application built against that libbpf.h reads them as zero when it
runs with this libbpf.

ring__release() returns 1 if there are more records to consume. The kernel
wakes up the consumer only if a record is committed right at the consumer
position, so records committed before the release don't cause a wakeup
and the caller has to call ring__next() again instead of waiting. To not
miss such a record, ring__release() needs a full barrier between updating
the consumer position and checking for the record.

The new functions can only be used on a ring that has no callback, i.e.
NULL was passed as sample_cb to ring_buffer__new() or ring_buffer__add().
On a ring that has a callback, ring__next() and ring__release() fail with
EINVAL and ring__rewind() does nothing, just like the callback-based
functions already fail on a ring without one.

The position of the next record is cached in struct ring and not read from
the consumer page, so as before only one consumer can use a ring buffer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h   | 63 ++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.map |  3 ++
 tools/lib/bpf/ringbuf.c  | 93 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 49f1120f4021..efd796603fa3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1541,7 +1541,10 @@ struct ring_buffer;
 struct ring;
 struct user_ring_buffer;
 
-/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
+/*
+ * Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps.
+ * The callback can be NULL for rings that are consumed with ring__next().
+ */
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
 
 struct ring_buffer_opts {
@@ -1643,6 +1646,64 @@ LIBBPF_API int ring__consume(struct ring *r);
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
+/*
+ * Record API: get records one by one with ring__next() instead of having them
+ * passed to a sample callback. It can only be used on rings that don't have a
+ * sample callback.
+ */
+
+/**
+ * struct ring_rec describes a record returned by **ring__next()**.
+ */
+struct ring_rec {
+	const void *data;	/* record data */
+	unsigned long pos;	/* position of the record in the ring buffer */
+	__u32 len;		/* size of record data in bytes */
+};
+
+/**
+ * @brief **ring__next()** returns the next record in the ring buffer without
+ * consuming it.
+ *
+ * Record data stays valid until **ring__release()** is called, so multiple
+ * records can be processed and then consumed together:
+ *
+ *	do {
+ *		while ((rec = ring__next(r)))
+ *			handle(rec->data, rec->len);
+ *	} while (ring__release(r) > 0);
+ *
+ * Each call invalidates and reuses the previous struct ring_rec, so copy it if
+ * it is needed later.
+ *
+ * @param r A ringbuffer object.
+ * @return The next record, or NULL if there is nothing to consume. errno is
+ * set on any error.
+ */
+LIBBPF_API const struct ring_rec *ring__next(struct ring *r);
+
+/**
+ * @brief **ring__release()** consumes all records returned by **ring__next()**
+ * since the last **ring__release()** or **ring__rewind()**.
+ *
+ * Call it before waiting for new data. If it returns 1, call **ring__next()**
+ * again instead of waiting, as there may be no wakeup for records that were
+ * committed before the release.
+ *
+ * @param r A ringbuffer object.
+ * @return 1 if **ring__next()** has to be called again, 0 if the caller can
+ * wait for new data, or a negative error code on failure.
+ */
+LIBBPF_API int ring__release(struct ring *r);
+
+/**
+ * @brief **ring__rewind()** goes back to the first record that was not
+ * released, so that **ring__next()** returns the same records again.
+ *
+ * @param r A ringbuffer object.
+ */
+LIBBPF_API void ring__rewind(struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a45666f546fa..e373257d32fe 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -479,4 +479,7 @@ LIBBPF_1.9.0 {
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
+		ring__next;
+		ring__release;
+		ring__rewind;
 } LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 271c6b9b130d..822557b7149b 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -30,6 +30,12 @@ struct ring {
 	unsigned long *producer_pos;
 	unsigned long *overwrite_pos;
 	unsigned long mask;
+	/* ring__next() state: position of the next record and cached producer_pos */
+	unsigned long next_pos;
+	unsigned long prod_pos;
+	struct ring_rec rec;
+	/* always zero, in case struct ring_rec needs new fields */
+	unsigned long rec_reserved[2];
 	int map_fd;
 	bool overwrite;
 };
@@ -158,6 +164,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	 */
 	if (r->overwrite && sizeof(unsigned long) == sizeof(__u64))
 		r->overwrite_pos = r->producer_pos + 2;
+	r->next_pos = smp_load_acquire(r->consumer_pos);
+	r->prod_pos = r->next_pos;
 
 	e = &rb->events[rb->ring_cnt];
 	memset(e, 0, sizeof(*e));
@@ -420,7 +428,7 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 
 unsigned long ring__consumer_pos(const struct ring *r)
 {
-	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
+	/* Synchronizes with smp_store_release() in ringbuf_process_ring() and ring__release(). */
 	return smp_load_acquire(r->consumer_pos);
 }
 
@@ -472,6 +480,89 @@ int ring__consume(struct ring *r)
 	return ring__consume_n(r, INT_MAX);
 }
 
+/* ring__next() and friends can't be mixed with callbacks on the same ring */
+static int ringbuf_validate_rec_api(const struct ring *r)
+{
+	if (unlikely(r->sample_cb))
+		return -EINVAL;
+	if (unlikely(r->overwrite))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+const struct ring_rec *ring__next(struct ring *r)
+{
+	unsigned long pos, prod_pos;
+	__u32 *len_ptr, len, rec_sz;
+	int err;
+
+	err = ringbuf_validate_rec_api(r);
+	if (err)
+		return libbpf_err_ptr(err);
+
+	pos = r->next_pos;
+	prod_pos = r->prod_pos;
+	for (;;) {
+		if (pos == prod_pos) {
+			prod_pos = smp_load_acquire(r->producer_pos);
+			if (pos == prod_pos)
+				return NULL;
+		}
+
+		len_ptr = r->data + (pos & r->mask);
+		len = smp_load_acquire(len_ptr);
+		/* record is not committed yet */
+		if (len & BPF_RINGBUF_BUSY_BIT)
+			return NULL;
+
+		rec_sz = roundup_len(len);
+		r->next_pos = pos + rec_sz;
+		r->prod_pos = prod_pos;
+		if (!(len & BPF_RINGBUF_DISCARD_BIT)) {
+			r->rec.data = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+			r->rec.pos = pos;
+			r->rec.len = len;
+			return &r->rec;
+		}
+		pos += rec_sz;
+	}
+}
+
+int ring__release(struct ring *r)
+{
+	unsigned long pos = r->next_pos;
+	__u32 len;
+	int err;
+
+	err = ringbuf_validate_rec_api(r);
+	if (err)
+		return libbpf_err(err);
+
+	smp_store_release(r->consumer_pos, pos);
+	/*
+	 * bpf_ringbuf_commit() clears the busy bit of a record and then checks
+	 * consumer_pos to see if it has to wake us up. We update consumer_pos
+	 * and then check the record, so without a full barrier in between both
+	 * sides can miss each other's update.
+	 */
+	smp_mb();
+
+	r->prod_pos = smp_load_acquire(r->producer_pos);
+	if (pos == r->prod_pos)
+		return 0;
+	len = smp_load_acquire((__u32 *)(r->data + (pos & r->mask)));
+	/* we get a wakeup when a busy record is committed */
+	return !(len & BPF_RINGBUF_BUSY_BIT);
+}
+
+void ring__rewind(struct ring *r)
+{
+	if (ringbuf_validate_rec_api(r))
+		return;
+
+	r->next_pos = smp_load_acquire(r->consumer_pos);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.53.1-Meta

