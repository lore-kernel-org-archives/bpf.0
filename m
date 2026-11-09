Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253659;
	b=QQXOZ9evivBj58iunliUunOWKZZ6f5T7VlaCa0tHYSi8/rJCCOrPlJogy2XJTuM5KtHB
	 8dEAEqBq148pZczIFKiS4OAloQ7Qz5F6Ohj9StYKexhwLrrui3TJmiyunpPypIAc6rk0r
	 y3CrY52M1+Lr6igRQlIaWV5LxnAaF7cTPitFCxE3FUAFzYx59uL4udKel3PajYiy90QIO
	 4tEMqy9OK+WhwGwQ3xV+SqXENn5WHVBzOfCMBtmmu1AdidEwZ5EDZ0hW8zR60jzHmabCy
	 YNqU/VcdUUTTum/e7bARgC8C544zc0jXokScm0xLBhj7pN0jkR/X/ao0W3lKY4eo6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=QonYSPCEGPZ3jMgnrlvYYEEq7OVaztKleqa/IGAXRqM=;
	b=m3kRwcjMKxChEDix7GbQQ4+47S6jvZfTemlDm9jtVmPeTN5HpXrNezDU3uZqFLPsmR4C
	 57e8ag7+Lp4gkG6PzV53KNMCcMDWdmT2DTewlLaXa1QNY1Rw68oYiMVoNa7WwVK0h1tYj
	 7vLmJd/t0K1RyyYacW5qfNPMciGbWw3F82BNvb0x2k5u40DKHFQAduewh0svNMF2JfIZW
	 UAgLCksNO0hvWgm6S51rbjUznIJTyoMSfKXe+qbSO+FYqkqoO+kXzTWJGht77fKdXT5vQ
	 MdxRr3J52qWta5lrBetKxeirRF3bAxdXN9WPo20XaQk7pYCB8+EWscgjIoP0cEA7DVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPcgqXEH;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AD606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616AD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPcgqXEH
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4ad5d6045d4so6196225e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253658; x=1794858458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QonYSPCEGPZ3jMgnrlvYYEEq7OVaztKleqa/IGAXRqM=;
        b=EPcgqXEH56hhyI6vuRxJ+arUKTr9lGHeqCw2YEj3qY0UErHGVFM7LrHrO7itC2SGf7
         qo4pHGrzniSPPNMmjZn/EUDoQbW6wWi5iZ9bt6dWbPTsXO/ujlRFAUUnqKLs3MooO11v
         5AYMIqmjh2RziTyYWMtGlrfNpeHfLF/NMuXPmt2lEdV3pq4JJO28ovPWZocWDymt3gY1
         T15R7atiALE5YlHPEnwzyZpdoW/NvDOBqmN0/UBaYtqXR6gu+k2nbB1nnnmtOzxsa+Jg
         fb/55fpkdqY9JpL8XxRZWUaIpUGR0/W4oBG9p4pVYlb/cZPZF5nlky29gDK3ZeGtRf4V
         Am4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253658; x=1794858458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QonYSPCEGPZ3jMgnrlvYYEEq7OVaztKleqa/IGAXRqM=;
        b=A61UNOn8YONUSeON5HJEyd7GpSu0TecHyPjMnM/lgWVxBg1f4b6Oh5dcbMH76xfiV1
         4UwF52Fp17Q1EpIXLmxPv0+Pbvqte9x3rlas0AF+OqDLOK+u1Vlrq6f/gkYOtEIFl68q
         Lku1cm46fCo0allLIqdBvi5S/FhZjfuqjJZCtfyraVz3acIQw8dzMra5EI0mhLO4jUci
         E3LhwIG3KX87Nj8a2cakLnyelLA3i0YGfGS3NAl7f8NhaV1c2dnDwJLl9W3jGSEC2SZn
         wF/4YirRDSy/o8EBXc7712jMEsD6ZhEtRotDft9dYdnA5QBhnwheuKjMJiUfMySKO6RG
         IeQg==
X-Gm-Message-State: APuU4Z/LSfXpHK4cIEAWer5OfGOq9p0I+xKH+43CyAqPIccMWaJ4FK83
	qBVCrHdjTle8B9ZkASEECwuQ94TgwCMQMMlXAj7hMZMrP2bqYqcTn1FFB5vTesOf
X-Gm-Gg: AYBFou1IUH7Bw6mtrPpoY2S73pmGOHm4pXYBZ0kKzyXyzHnn4j+DWDfIHlzFjHuaO07
	s516lHoK7LY7XmV6RYyvz+8GI0Xi3lSZ3EbO+qNyB6UoZKx1OeD6eMRNJEQZIFnQ83wOvMrV9bW
	Z5Isct/C7saHQ6CBS5V24Fq9ZGEv4jnkjrqXNN8zQGhwQkcsLXvTzhdQC7+7+UnVQjFJ3SSbwpV
	wLjm1Ln9826b55WgcmkDU9nl9kmQESCr1TtKf+YUEOlkES1x+nzK5Sv3H1SLVWmo9B481aJ5Fbw
	7X8FkivhZxQvwaG+fqvJbv8oObz0osaM+XMHJ36K5MzLKpjhmqOqSVmoDn2ct477YhViFDObhEa
	vIFHJF8JjiRV21pTsXIP7WizHpuEngjhhUnULz7F0kdLtS/bnl61g6MQMCSEpeza53A6RPA7y9V
	2wCHs3ZNKuDpVTicmGf+oE7UPQXFZPgS5mBqYKLaMkucKx5Pv2bhLbgCNCM0F+dUXH0fCVnHsw3
	6qnVHljFUb+hn9iXKrT/H6MbHH7VwU5ZOKuVk/71LdIOdzDBA88A4R8rVe5gEcu4GGzjlmMRgmm
	+H22D0G+K6Ut8AMD2jIQL8zRh/njK2g0u9iTjdG0dekGFWah/8YtV1tEDEi3Lup4braOYjMU/tF
	SpL3y8DZgsfm7iPO+HI7kLvHLRkfKUjnSZaSaEnf4Cnx1pRRQnUDRDXHTcEeOehQll/44
X-Received: by 2002:a05:600c:c4a3:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4ba02341354mr4798905e9.7.1794253657654;
        Mon, 09 Nov 2026 11:47:37 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm17309405e9.11.2026.11.09.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:36 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/6] libbpf: Prevent NULL callback crash
Date: Mon,  9 Nov 2026 20:47:28 +0100
Message-ID: <bb94029254fe2b51e2a0ed6721d4554dcb1c909b.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794253561.git.memxor@gmail.com>
References: <cover.1794253561.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4910; i=memxor@gmail.com; h=from:subject:message-id; bh=gIkPw/iJj34TfMl6o8ISKgl9u35iSc/oNtxSXYxwZfM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0q/K88vLomWe9QeVnBGe+XJjoZt7YITTlLs1atM3c jtzydR2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLiOowMO7ZpXLvUf7r1zcY3 64Ry1R5bbt20bt6pS19C+m/eW3SA+xvD/wJGP7uJygz+4YGuommih12iXHKa37EIJTytmuySvm0 eAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tamir Duberstein <tamird@kernel.org>

ring_buffer__new() and ring_buffer__add() allow a NULL sample
callback. When callback-based consumption reaches such a ring, it calls
through the NULL function pointer and crashes.

Check every ring before manager polling or consumption so a missing
callback returns -EINVAL before the manager waits or consumes another
ring. Check the selected ring before direct per-ring consumption. Perform
both checks before honoring a zero record bound so invalid callback use
always reports the error.

Fixes: bf99c936f947 ("libbpf: Add BPF ring buffer support")
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h  | 11 +++++------
 tools/lib/bpf/ringbuf.c | 43 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index a8a23c135c17..1c45648fa578 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1628,18 +1628,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  *
  * @param r A ringbuffer object.
  * @return The number of records consumed (or INT_MAX, whichever is less), or
- * a negative number if any of the callbacks return an error.
+ * a negative error code on failure.
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
 /**
- * @brief **ring__consume_n()** consumes up to a requested amount of items from
- * a ringbuffer without event polling.
+ * @brief **ring__consume_n()** consumes up to a requested number of records
+ * from a ringbuffer without event polling.
  *
  * @param r A ringbuffer object.
- * @param n Maximum amount of items to consume.
- * @return The number of items consumed, or a negative number if any of the
- * callbacks return an error.
+ * @param n Maximum number of records to consume.
+ * @return The number of records consumed, or a negative error code on failure.
  */
 LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 6e88ac209298..b7fde7d0a0fd 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,6 +231,26 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
+static int ringbuf_validate(const struct ring *r)
+{
+	if (unlikely(!r->sample_cb))
+		return -EINVAL;
+	return 0;
+}
+
+static int ringbuf_validate_callbacks(const struct ring_buffer *rb)
+{
+	int i, err;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		err = ringbuf_validate(rb->rings[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
@@ -240,6 +260,9 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	bool got_new_data;
 	void *sample;
 
+	err = ringbuf_validate(r);
+	if (err)
+		return err;
 	if (n == 0)
 		return 0;
 
@@ -284,14 +307,17 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
  * records.
  *
  * Returns number of records consumed across all registered ring buffers (or
- * n, whichever is less), or negative number if any of the callbacks return
- * error.
+ * n, whichever is less), or a negative error code on failure.
  */
 int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 {
 	int64_t err, res = 0;
 	int i;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
@@ -309,14 +335,17 @@ int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
 
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
- * INT_MAX, whichever is less), or negative number if any of the callbacks
- * return error.
+ * INT_MAX, whichever is less), or a negative error code on failure.
  */
 int ring_buffer__consume(struct ring_buffer *rb)
 {
 	int64_t err, res = 0;
 	int i;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
@@ -334,13 +363,17 @@ int ring_buffer__consume(struct ring_buffer *rb)
 
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
- * negative number, if any of the registered callbacks returned error.
+ * a negative error code on failure.
  */
 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
 	int i, cnt;
 	int64_t err, res = 0;
 
+	err = ringbuf_validate_callbacks(rb);
+	if (err)
+		return libbpf_err(err);
+
 	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
 	if (cnt < 0)
 		return libbpf_err(-errno);
-- 
2.53.0

