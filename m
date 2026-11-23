Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468441;
	b=HchjaW19jxYUcp7oZdEBIBIRS6Yr2DsZWQCSsOuL64Yf8a7EksxnovCTGjvg6OoGRcip
	 fURlWMve0QvMQXNBWcqA6GGV7B8c3XTF/X8MXYABS9BuFxtksolBYXQSwjW9Fr+M+Ijy5
	 QzkhhjKPhFghK/sVI325PHS0MBtySEt8GVNdBBYVlJAMX7Czttu48HQig4CQax8T1Akqt
	 GaDxossttm1vXsCtfMDHVeWneLST7EVnEBNz0NYylmalpgOy+tD1YEnmTxS0j5NCsK6cf
	 Brs5fOITF/mEf/qFPezxbiQ26prgPZrj1191Q7h9v+adxtAdDNmHFv8Wcv8tNAzGyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=gcQvjA8+h2ohzgIuzsHN3vA4zsOOD3Q9/0Wle15fFD0=;
	b=4MwtSuhlmm1U1+jq2lwdTLmJGQEwGcxUzIEBkJ2+JEBjIjxh3r4teLeqZGZKTKSoy0pZ
	 xzdj9ajwiGTB3Za17soupmG38BMrvNEKifAIgUcopCSjT4FeDvE0tqC++O0SgBG1J5s20
	 TH2cETSsQBNUFFMEZpyZkdWDMvPn3dj3fgC/my4enEbAKJlhIL0Ul5TcBqUCi2S8cV1mf
	 uPij2mVJioMZDmShEM0VqmbI0zfk2poKFyazwqxZI9/ReSnoLNzgpIPHeo9weirI+CBOF
	 wQN+HhHKlV57Us1baUCLHu84/FI/dMimLxBdB5EikAH90ZkbrKpagOuBaEipLgn3f4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enhv+Itv;
	arc=none smtp.remote-ip=74.125.231.199
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497D606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9497D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=enhv+Itv
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so1296831b6e.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468439; x=1796073239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcQvjA8+h2ohzgIuzsHN3vA4zsOOD3Q9/0Wle15fFD0=;
        b=enhv+Itvhk3d/X/mcqcSKPH2NDZW287V3ruGlO/fWLOtzgNHAg/ro/3LM+hizod23+
         NGE1cp3ZFhIAuT/l9W2wbldHz3IUdNoLelsMZCZaYtO4Uqe6PnZniITZEDy+NBdP8vE1
         lw71SSw5IGF/So/yJ0CFaIquaDrhIRNTGjZvJ5DShUaVtdQt275Bpeh5nvmRMBik4TYN
         rno0UE8PtHGvyRa3VXWxs1rHlh/Mj0i3DkFBvudPzQSgUtlRiJN0guD2Fz4c+BYH5Hwh
         oImDRc7iNHhHjHfDA4I1UCWHX+SvKRvjS7lUfuegwi6K2uQLsBuO6SGn8Rdke82SC5Gy
         vyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468439; x=1796073239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gcQvjA8+h2ohzgIuzsHN3vA4zsOOD3Q9/0Wle15fFD0=;
        b=t5fOGlVejlTdATCimWySzVASFRebH1CqVCvUJute6wRKVISdDFsgAm5u7flDYOGtoi
         icjfPQvvo9tE1JOipVvBKKIRUg3zTpmgja78ID5ZyTrhyT/rUhhpo3efYRfLH3uSK27Z
         RGKvzkE05D5Y3VeTzP2fC6BR2v++KOUY1J4LB/mIj6BcrCrO+vTRA4/nsEm5rsJMP4cj
         e5oUoEI4tY7CXd4SMKlJ4QQeiVhdoaHYrsjZyXugKTP/1Tj1dlnUtGRE3NqjUUDRq188
         7Fuw4U0a63LFn0G/j0RJBaxUEujYhRp8h5L6HKfY9YjQ86fYrbToFk+VsJZLeWXngKjo
         6Gsg==
X-Gm-Message-State: APuU4Z/JnVKuviDBP6rGJLaSv3te7DL+F70H4Ljl9AmBoH4nrJzrlNR9
	AoVpwZVB+SDlH+NiAr3tlWRSJuI4ZKTXgfG7yW7M28nN984R6wceDb15xDNhJHkqKYf7/A==
X-Gm-Gg: AZFdTZdm5ZXXBYiPlUsWV+cak089hlJ7k6q5P+joeyhQlqUb712Jf4t3qjH1NK3iiKX
	9zt2J5XioDiO4FT840APqynvZfq90VFu1rv/dVDVKBR5RIO08rsJOK7NigJMf3y3/TVi1Rrfqk/
	ceqzyCXm3AO3QVYRszQUulALykPIH3FxFBFHtylivN+fnkmswnh7yRctfL7rjCRcsFk1xUuj2tW
	24AX6v8qWAkavm+L/ovZs6cmbXiDyhbWPCpV3KP2wWXZ7mvz/KiDJkkaxhqG5UZQDhDQ1dSemsD
	+hhtxVuCBKXbxbV7vvwGStRZcOjoqasAqDF+uP5EJdYYnv7xyhrj97i3NDwhBy/lDqOTsJktaY8
	uVmB9sNekR5/wd8ZLAoa5EEz6lnZVjQj92k8Ffl/PxxPXTjthqpqlB8dX7bH+50eQxSqU/PIcRx
	DdqcUFNpo3Wi2R0RROReNPCiDOzAwB0tZuZLC/8QZiBmrRaausQt/bl9QOsdDQOduvWg11/Eyzh
	Rjze9KXL4kuj0dHAfz9oGz8ZImH2vugcXdRbIyyVg6d7wk+XgFFZhIo78uSpdpq1/45ifafOqyi
	KgRpHNazwe9pcavgGG3Oy8hVu4cKkqe1BBb77mkYJGm6PWAaGiAwf8pYlJBdM3AFF0z+dl4cU24
	BIhP41ec96QpGgJuNZgG22Ma0Y3xNrNYgfGtZzL2KL5Nqv8jh9XdCWT8OwAwj3pXlTqGsyOa48/
	BHzHT7AgZ7jA==
X-Received: by 2002:a05:6808:6404:b0:55c:836:5955 with SMTP id 5614622812f47-57a0bb6ee75mr12832420b6e.44.1795468439386;
        Mon, 23 Nov 2026 13:13:59 -0800 (PST)
Received: from localhost (fwdproxy-atn-115.fbsv.net. [173.252.95.115])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm11402662fac.8.2026.11.23.13.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:57 -0800 (PST)
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
Subject: [PATCH bpf-next v1 07/10] libbpf: Support overwritable ring buffers in the record API
Date: Mon, 23 Nov 2026 22:13:30 +0100
Message-ID: <8115836d8bcbb9d59e2a350f9fb999f5ab497348.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9362; h=from:subject:message-id; bh=vQUWD3Rg27gWL4YkQg4LvJNa3rPJ1zAXcilMiFGGwvw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhUnRcmf+nKNHF0mf2xA7UehEzdsjSxwZDnyfeHxdVka7 xj/FjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEykvZWR4dGBZtWOVd0vF/BElLUWza lou6p3/avGvweqtZHq/t+3XGNkOHF41nzdG30MQRlTRFzdtFjl5v77yajBWL9RRufIi92RHAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

In an overwritable ring buffer (BPF_F_RB_OVERWRITE) the kernel doesn't
wait for the consumer and overwrites the oldest records when the ring
buffer is full. A record returned by ring__next() can be overwritten while
the caller is reading it, which is why such ring buffers can't be consumed
through callbacks.

Add ring__invalidated(), which returns true if any of the records returned
by ring__next() since the last ring__release() or ring__rewind() may have
been overwritten. The caller has to copy record data first, and use the
copy only if ring__invalidated() returns false afterwards:

	do {
		while ((rec = ring__next(r))) {
			memcpy(copy, rec->data, rec->len);
			if (ring__invalidated(r))
				break;
			handle(copy, rec->len);
		}
	} while (ring__release(r) > 0);

It can also be called once for a number of records, e.g. to dump the ring
buffer without consuming anything:

	n = 0;
	while ((rec = ring__next(r))) {
		memcpy(copies[n], rec->data, rec->len);
		lens[n++] = rec->len;
	}
	if (!ring__invalidated(r))
		dump(copies, lens, n);
	ring__rewind(r);

Records are overwritten in order, so ring__invalidated() only has to check
that the producer is less than a ring buffer size ahead of the first record
returned since the last release or rewind. For regular ring buffers it
always returns false.

Overwritable ring buffers get their own implementation of ring__next(),
ringbuf_overwrite_next(), so that the regular one stays as it is.
ringbuf_overwrite_next() does the same check for every record header
before using it, so pos and len of a returned record are always valid and
only record data needs ring__invalidated(). If the check fails, it
continues from the kernel's overwrite position. There is no limit on how
often that can repeat: a producer that keeps overwriting records before
they can be read is not expected in practice.

Overwritable ring buffers are not supported by 32-bit libbpf, where
ring__next() fails with EOPNOTSUPP. It doesn't know where the overwrite
position is, and 32-bit positions wrap after 4 GiB of records, which the
check can't notice.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h   | 32 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 94 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 91d25bed5a04..24a70bf3f782 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1691,6 +1691,10 @@ struct ring_rec {
  * Each call invalidates and reuses the previous struct ring_rec, so copy it if
  * it is needed later.
  *
+ * In an overwritable ring buffer (BPF_F_RB_OVERWRITE) record data can be
+ * overwritten at any time, see **ring__invalidated()**. Such ring buffers are
+ * not supported by 32-bit libbpf: **ring__next()** fails with EOPNOTSUPP.
+ *
  * @param r A ringbuffer object.
  * @return The next record, or NULL if there is nothing to consume. errno is
  * set on any error.
@@ -1719,6 +1723,34 @@ LIBBPF_API int ring__release(struct ring *r);
  */
 LIBBPF_API void ring__rewind(struct ring *r);
 
+/**
+ * @brief **ring__invalidated()** checks if any of the records returned by
+ * **ring__next()** since the last **ring__release()** or **ring__rewind()**
+ * may have been overwritten.
+ *
+ * The kernel can overwrite records of an overwritable ring buffer
+ * (BPF_F_RB_OVERWRITE) while they are being read. Copy record data first, and
+ * use the copy only if this function returns false afterwards:
+ *
+ *	do {
+ *		while ((rec = ring__next(r))) {
+ *			memcpy(copy, rec->data, rec->len);
+ *			if (ring__invalidated(r))
+ *				break;
+ *			handle(copy, rec->len);
+ *		}
+ *	} while (ring__release(r) > 0);
+ *
+ * Once it returns true, it keeps returning true until **ring__release()** or
+ * **ring__rewind()** is called. *pos* and *len* of a returned record are
+ * always valid and don't need this check.
+ *
+ * @param r A ringbuffer object.
+ * @return true if records may have been overwritten, false if not. Always
+ * false for a ring buffer that is not overwritable.
+ */
+LIBBPF_API bool ring__invalidated(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 943f6f3f0639..6a953f123138 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -479,6 +479,7 @@ LIBBPF_1.9.0 {
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
+		ring__invalidated;
 		ring__next;
 		ring__release;
 		ring__rewind;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 12d586afed1d..b4e9e27951eb 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -36,6 +36,9 @@ struct ring {
 	struct ring_rec rec;
 	/* always zero, in case struct ring_rec needs new fields */
 	unsigned long rec_reserved[2];
+	/* overwrite mode: first record returned since the last release or rewind */
+	unsigned long batch_pos;
+	bool has_batch;
 	int map_fd;
 	bool overwrite;
 };
@@ -497,11 +500,72 @@ static int ringbuf_validate_rec_api(const struct ring *r)
 {
 	if (unlikely(r->sample_cb))
 		return -EINVAL;
-	if (unlikely(r->overwrite))
+	/* 32-bit: no overwrite_pos, and positions wrap after 4 GiB of records */
+	if (unlikely(r->overwrite && !r->overwrite_pos))
 		return -EOPNOTSUPP;
 	return 0;
 }
 
+/*
+ * Overwrite mode: check that whatever was read at pos, and at later positions,
+ * was not overwritten while we were reading it. The producer can overwrite pos
+ * once it is a ring size ahead of pos.
+ */
+static bool ringbuf_pos_valid(const struct ring *r, unsigned long pos, unsigned long *prod_pos)
+{
+	/* pairs with smp_wmb() after the producer_pos update in the kernel */
+	smp_rmb();
+	*prod_pos = smp_load_acquire(r->producer_pos);
+	return *prod_pos - pos <= r->mask;
+}
+
+/* ring__next() for overwritable ring buffers */
+static const struct ring_rec *ringbuf_overwrite_next(struct ring *r)
+{
+	unsigned long pos = r->next_pos, prod_pos;
+	__u32 *len_ptr, len;
+
+	prod_pos = smp_load_acquire(r->producer_pos);
+	for (;;) {
+		if (prod_pos - pos > r->mask) {
+			/*
+			 * The producer lapped us, continue from the oldest record.
+			 * overwrite_pos is never ahead of a producer_pos that is
+			 * loaded after it.
+			 */
+			pos = smp_load_acquire(r->overwrite_pos);
+			prod_pos = smp_load_acquire(r->producer_pos);
+			continue;
+		}
+		r->next_pos = pos;
+		if (pos == prod_pos)
+			return NULL;
+
+		len_ptr = r->data + (pos & r->mask);
+		len = smp_load_acquire(len_ptr);
+		/* if the producer lapped us, this is not a record header */
+		if (!ringbuf_pos_valid(r, pos, &prod_pos))
+			continue;
+		/* record is not committed yet */
+		if (len & BPF_RINGBUF_BUSY_BIT)
+			return NULL;
+
+		r->next_pos = pos + roundup_len(len);
+		if (len & BPF_RINGBUF_DISCARD_BIT) {
+			pos = r->next_pos;
+			continue;
+		}
+		if (!r->has_batch) {
+			r->batch_pos = pos;
+			r->has_batch = true;
+		}
+		r->rec.data = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
+		r->rec.pos = pos;
+		r->rec.len = len;
+		return &r->rec;
+	}
+}
+
 const struct ring_rec *ring__next(struct ring *r)
 {
 	unsigned long pos, prod_pos;
@@ -512,6 +576,9 @@ const struct ring_rec *ring__next(struct ring *r)
 	if (err)
 		return libbpf_err_ptr(err);
 
+	if (r->overwrite)
+		return ringbuf_overwrite_next(r);
+
 	pos = r->next_pos;
 	prod_pos = r->prod_pos;
 	for (;;) {
@@ -540,9 +607,20 @@ const struct ring_rec *ring__next(struct ring *r)
 	}
 }
 
+bool ring__invalidated(const struct ring *r)
+{
+	unsigned long prod_pos;
+
+	if (!r->has_batch)
+		return false;
+
+	/* records are overwritten in order, so it is enough to check the first one */
+	return !ringbuf_pos_valid(r, r->batch_pos, &prod_pos);
+}
+
 int ring__release(struct ring *r)
 {
-	unsigned long pos = r->next_pos;
+	unsigned long pos = r->next_pos, prod_pos;
 	__u32 len;
 	int err;
 
@@ -550,6 +628,7 @@ int ring__release(struct ring *r)
 	if (err)
 		return libbpf_err(err);
 
+	r->has_batch = false;
 	smp_store_release(r->consumer_pos, pos);
 	/*
 	 * bpf_ringbuf_commit() clears the busy bit of a record and then checks
@@ -563,8 +642,14 @@ int ring__release(struct ring *r)
 	if (pos == r->prod_pos)
 		return 0;
 	len = smp_load_acquire((__u32 *)(r->data + (pos & r->mask)));
-	/* we get a wakeup when a busy record is committed */
-	return !(len & BPF_RINGBUF_BUSY_BIT);
+	if (!(len & BPF_RINGBUF_BUSY_BIT))
+		return 1;
+	/*
+	 * A busy record wakes us up when it is committed, so return 0. In
+	 * overwrite mode return 1 if the producer lapped us, as len was not
+	 * read from a record header then.
+	 */
+	return r->overwrite && !ringbuf_pos_valid(r, pos, &prod_pos);
 }
 
 void ring__rewind(struct ring *r)
@@ -573,6 +658,7 @@ void ring__rewind(struct ring *r)
 		return;
 
 	r->next_pos = smp_load_acquire(r->consumer_pos);
+	r->has_batch = false;
 }
 
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
-- 
2.53.1-Meta

