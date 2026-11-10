Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316826;
	b=4NTImiCMNJXH4NPz8/v6vnYegQNMZ4KpLz0RKEpro2zSO2/cH8b0MktQ00dBIeAqMeAb
	 tGOzWI4Ywg4+B37yWG3lyvnmlQIHbTGIifTAalZupRL+LLVBcQc1WnJXWYrIoe24vl4ks
	 Q4AuLLKXyzAYAETR5TLT0btVn8FG57QMCNEUp9T67jQSDALftOI5vFMBNtpDxeI9sRhAm
	 RWAGGWhu+ACKGKl6FhZSRgqwPJ+8w8T8X5JLrXDfSqY7CiPTaq7csAirpBCmFQKlMUN52
	 93g6Q3OK4P1KYm+RjqFdmnFrtzj3GU2vezppIxOqA93Jr4Yx+hUzMFxD6G8/l36pRNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1yXxbEsc5Qxia0KRluRo/goytXSVlB2bBLwxeDAnqXM=;
	b=KDHgl0P6/D4LVuuT6oNnYU+G6JAS6GxCYwmwxFJ5gb4jqXT1cjXBuPl957Wo8hBi5xqu
	 Y2YfBWfXEnwmfYzevQYNxBMHmHH3k4TLtrBXraluZK/zRrc70BjZbezQ5oQbhIbkekDol
	 rHiqQ/0XrMQl5bPag6faDOiJUp1t/v4EvOVJKPFAgEI2zy7LywIrKnh25HfBKicJpkrhW
	 3EoKkjq+FL3d9zBHv5uv55D4z2EroIPJeaKSbd+1mzTMfaxWAcrkmlr+6FxcsvkrGW1hv
	 dw1HGx88CLphwDrh329mAImgSx0Ov00ymCX9m4SL6XXwH0KXp6uLH8Hes2fY7mJQx1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ec9pKMXz;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Pe515MfM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0463360A5BE7
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0463360A5BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ec9pKMXz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Pe515MfM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794316824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yXxbEsc5Qxia0KRluRo/goytXSVlB2bBLwxeDAnqXM=;
	b=ec9pKMXz0AUiJn32jOiUzGcZQwwzQdhmCxoix7wKUvfINpXCr1qo2ot9+oscYcKLhrv012
	sxIZLbOLQROtLQCGQeIU7tYt0PibUfkubHvXqZs5a/ksbZY87SPFxrK6zgq59TP2MSvsz+
	F2wnVCbjKwm5axdoh++azl2ZJQqgGQA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-WGITYL_vNXSNg_NlWdcfHw-1; Tue, 10 Nov 2026 08:20:22 -0500
X-MC-Unique: WGITYL_vNXSNg_NlWdcfHw-1
X-Mimecast-MFC-AGG-ID: WGITYL_vNXSNg_NlWdcfHw_1794316821
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c504991a35eso89633366b.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794316821; x=1794921621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yXxbEsc5Qxia0KRluRo/goytXSVlB2bBLwxeDAnqXM=;
        b=Pe515MfMPW2hYxQ54QwXfJ4zSgw67tdLLdN5n4X8yidu0V+AFOGkmdcbokccL8tXGd
         QgXHqSaWPcSejYrlBLrQOpoOkM8gVVGbK3lNJLApGcks1tHJLRrpTVKVk++YDPMMqlhI
         7XJIqNi36+gKZ6vAUho0andEitdbgBz22BGw/4627JFRNCbf8i8JRpnM67vFQdict0Q5
         LEFvQyt3RKMu2GOLpK6wIXT4je6AJ4vCgggKNVQPhZv6+vPv5NdY9eDpDOuThcnO6gJ4
         r0KqnX+mtBXZJ9BR+JdDEGjXgsbHibSVkZtHDpXy/fv+lrZLmr/zSwr8oLYx1FzIhWNB
         tZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316821; x=1794921621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yXxbEsc5Qxia0KRluRo/goytXSVlB2bBLwxeDAnqXM=;
        b=Xrnqvk844G5DuZCgwiDUt8ZH86BdX228gk7s5gDJkJxAmxb6GtDv6Rn2DtmULbNRCS
         3N7XMtlW2N4Wasq4xeRMyRCE5ZySX/ItdFGve4Ww093WruN/x0pC1kCy6uLXI53qDTNO
         fXtK6YJFOvqUyotiGZbSGjpYdPox5q0Rd/nt7U7kgfKWQd5QtNTkLr5zqunRwgA/qCd2
         qYwkVJR2g7j6+K4rw2kuxchEkJ5mR1+y6EPLupAuNA0E1Ycc7Q9V1Ek2aH31rIJ+WKO1
         +VhzVsqyX/0xbLvFoMNgGB4yXOmOeuDlE6zLxebzNaEmtifgCc1XOON4xYbRFvEXW76R
         o/zg==
X-Forwarded-Encrypted: i=1; AL+hErFJa/jtbWBgHQdNjD+X7yqVo6PV0XQlLMZzDIa5zlxLXTZNvugC5YQ786MJD6+FeMr0eL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z93XWwgaWrZx3A6St7uJSCfeVuqgyt/uFTh3B7Ip0wfVCWJuUvJ
	Ea7tlUYKmVALPXilNle0h+OaY4nCsfIVPwPtM5u/OD7CVbV9OIluDDNA10HHxz1SRRstx6HA3yl
	PheuIuXQsPvlaad+9WAWQGISNiwPEBNT9XmcgKlx1MW3Nf8fWMuWjAQ==
X-Gm-Gg: AYBFou1SC6LofXdv8C5RDhxgRdgV+fXgR7Zy46imibndpHREvKUsw9nS7gip9wjJnCe
	IBvDbkxpFSS6hMpjx7yKNTzTMvyapzwRcPNS1rKgRetSK7iLM99vGcfE/gjYHgylksj/upBQeCO
	8S4c0tTeZkaffPGeuDw4Rskl4a+X5TheN+sa+x1w6Wi8CvpZKp/ssHs7zsklAcNxKuUg5XOcATx
	qWzx97dQxyjAD+v7iXVv+ZlHfVDm25jK2YtAP0D7DTC7yAuxaEJQ23FJr/Nb2fECYZXVQ6puxn4
	OZ2NuDibboWKzCLgds4wqyGKQdvw7REIpeRaFFSH/MIFNBfierZOV8RiScUk9n/WoMZN2Tschy7
	C9RJe7AsDKHxqp3nkSUMGUNy9sRv0k4s1AhBMd5QRCWV/cmMuzOq6zdWOUQuC3nVHwcs9ac+QQy
	LmuPNCXKavoCj0DTg/6ZEMHMfKxD/IZo19lIoORtCOs7L8oQBlB33kjtiXXk4Zxg9p6TnE+hd9T
	VHRhczgRBYkFV7qBZWVdJt7JYhFNPDjkZDkznrJ5Wd56hgFIweK
X-Received: by 2002:a17:906:7cf:b0:c33:9fab:5f61 with SMTP id a640c23a62f3a-c504956a911mr166702666b.29.1794316820940;
        Tue, 10 Nov 2026 05:20:20 -0800 (PST)
X-Received: by 2002:a17:906:7cf:b0:c33:9fab:5f61 with SMTP id a640c23a62f3a-c504956a911mr166698566b.29.1794316820256;
        Tue, 10 Nov 2026 05:20:20 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5d54bbsm107791166b.48.2026.11.10.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:19 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 08/12] io_uring/opaque: add vectored IORING_OP_OPAQUE_OBJ_SEND
Date: Tue, 10 Nov 2026 13:20:02 +0000
Message-Id: <20261110132006.3280986-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110132006.3280986-1-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow one send request to concatenate several object ranges, amortizing
request, queue and CQE work across small objects.

With SEND_VECTOR in sqe->ioprio, addr points to len entries and off must
be zero. A vector contains 1 to 1024 io_uring_opaque_send_entry records,
each with a handle, offset, nonzero length and zero reserved word. Handles
and ranges may repeat. The optional frame wraps the concatenated body;
prefix, body and suffix together must fit in INT_MAX bytes.

Preparation copies the entry array when the kernel consumes this SQE.
Keep the array valid until that consumption, including across short or
failed submissions. The resulting request has one queue entry, one
cursor and one completion; retry and ordering follow single-range sends.

Admission resolves and validates every range under the table mutex before
taking any reference. Indexed segment lookup uses short walks and binary
search; ranges together may span at most 4096 backing segments. A second
pass acquires references and, for LAST, removes each distinct handle once.
Acquisition is all-or-none; the queued-byte result may still be short.
Repeated entries retain the references needed to use the same immutable
version.

One request-owned block holds entries, pinned versions, range starts and
cursor segments. If it must grow, admission drops the mutex and resolves
the handles again after allocation. Cursor construction uses only the
versions already pinned by the request.

Ordinary-sized blocks remain with cached requests for reuse. Cleanup
frees blocks exceeding 256 entries or segments, and frees every block
under KASAN. The VECTOR flag identifies the operation independently of
whether a recycled request still carries a block. As with single-range
sends, final version release occurs after the socket is unlocked.

Vector admission uses the same already-reserved TX FIFO position as scalar
admission. Reference/cursor construction may finish after a head fails;
cleanup retains the linked failure barrier and socket identity until the
position drains. The vector caller never overtakes an earlier admission.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/uapi/linux/io_uring/opaque.h |  12 +
 io_uring/opaque.c                    | 405 ++++++++++++++++++++++++++-
 2 files changed, 407 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/io_uring/opaque.h b/include/uapi/linux/io_uring/opaque.h
index 2a862d76a40e..c04eaed8ce5f 100644
--- a/include/uapi/linux/io_uring/opaque.h
+++ b/include/uapi/linux/io_uring/opaque.h
@@ -61,6 +61,18 @@ enum io_uring_opaque_op {
 
 /* IORING_OP_OPAQUE_OBJ_SEND: sqe->ioprio contains these flags. */
 #define IORING_OPAQUE_SEND_LAST	(1U << 0)
+/* addr points at len struct io_uring_opaque_send_entry, off is zero: one send, many ranges. */
+#define IORING_OPAQUE_SEND_VECTOR	(1U << 1)
+/* Entries of one vectored send, as many as SEND_ZC takes iovecs (UIO_MAXIOV). */
+#define IORING_OPAQUE_SEND_VEC_MAX	1024
+
+/* One range of a vectored send, named as addr, off and len name it in a single one. */
+struct io_uring_opaque_send_entry {
+	__u64 handle;
+	__u64 off;
+	__u32 len;
+	__u32 __resv;
+};
 
 /* Optional SEND sqe->addr3 framing; size includes zero reserved extensions. */
 struct io_uring_opaque_frame {
diff --git a/io_uring/opaque.c b/io_uring/opaque.c
index b62c4be92fea..0c58900073f7 100644
--- a/io_uring/opaque.c
+++ b/io_uring/opaque.c
@@ -29,13 +29,23 @@ bool io_opaque_cache_init(struct io_ring_ctx *ctx)
 				   sizeof(struct io_opaque_req), sizeof(struct io_opaque_req));
 }
 
+/* Frees a request left in the cache, with the vector block it may carry. */
+static void io_opaque_req_destroy(const void *entry)
+{
+	const struct io_opaque_req *op = entry;
+
+	kvfree(op->vec);
+	kfree(entry);
+}
+
 void io_opaque_cache_free(struct io_ring_ctx *ctx)
 {
-	io_alloc_cache_free(&ctx->opaque_cache, kfree);
+	io_alloc_cache_free(&ctx->opaque_cache, io_opaque_req_destroy);
 }
 
 static void io_opaque_resume(struct io_tw_req tw_req, io_tw_token_t tw);
 static void io_opaque_ready(struct io_tw_req tw_req, io_tw_token_t tw);
+static void io_opaque_vec_cleanup(struct io_opaque_req *op);
 static void io_opaque_stream_close(struct io_opaque_stream *stream);
 static void io_opaque_tx_put(struct io_opaque_req *op);
 
@@ -783,7 +793,8 @@ static struct io_opaque_req *io_opaque_req_alloc(struct io_kiocb *req,
 	op = io_uring_alloc_async_data(&req->ctx->opaque_cache, req);
 	if (!op)
 		return ERR_PTR(-ENOMEM);
-	memset(op, 0, sizeof(*op));
+	/* Not the vector block, which a recycled request brings along. */
+	memset(op, 0, offsetof(struct io_opaque_req, vec));
 	op->op = U16_MAX;
 	op->req = req;
 	op->store = store;
@@ -794,6 +805,18 @@ static struct io_opaque_req *io_opaque_req_alloc(struct io_kiocb *req,
 	return op;
 }
 
+/*
+ * A finished request goes back to its ring's cache, with the vector block it
+ * carries, or is freed with it when the cache is full.
+ */
+static void io_opaque_req_free(struct io_ring_ctx *ctx, struct io_opaque_req *op)
+{
+	if (!io_alloc_cache_put(&ctx->opaque_cache, op)) {
+		kvfree(op->vec);
+		kvfree(op);
+	}
+}
+
 /* The ring lock protects enrollment; wait_lock arbitrates remote wakeups. */
 static void io_opaque_enroll(struct io_opaque_req *op)
 {
@@ -1675,10 +1698,12 @@ void io_opaque_cleanup(struct io_kiocb *req)
 		if (op->frame_charge)
 			io_opaque_uncharge_frame(store, op->frame_charge, op->frame_reserved);
 	}
+	if (unlikely(op->vec))
+		io_opaque_vec_cleanup(op);
 	io_opaque_data_put(store, op->data);
 	io_opaque_stream_put(op->stream);
 	lockdep_assert_held(&req->ctx->uring_lock);
-	io_cache_free(&req->ctx->opaque_cache, op);
+	io_opaque_req_free(req->ctx, op);
 	io_req_async_data_clear(req, 0);
 }
 
@@ -1776,17 +1801,154 @@ static void io_opaque_send_resolve(struct io_opaque_req *op)
 	op->resolved = true;
 }
 
+/*
+ * Check @nr entries copied from user memory; return the body they add up to.
+ * A handle may repeat, and a range may too.
+ */
+static int io_opaque_vec_check(const struct io_uring_opaque_send_entry *ent, u32 nr,
+			       u32 *total)
+{
+	u64 sum = 0, end;
+	u32 i;
+
+	BUILD_BUG_ON(sizeof(*ent) != 24);
+	if (!nr || nr > IORING_OPAQUE_SEND_VEC_MAX)
+		return -EINVAL;
+	for (i = 0; i < nr; i++) {
+		if (ent[i].__resv || !ent[i].len ||
+		    check_add_overflow(ent[i].off, (u64)ent[i].len, &end))
+			return -EINVAL;
+		sum += ent[i].len;
+		if (sum > INT_MAX)
+			return -EINVAL;
+	}
+	*total = sum;
+	return 0;
+}
+
+/*
+ * Make room in the request's block for @nr entries and @segs segments, keeping
+ * its first @keep entries. A block that is big enough stays as it is. This
+ * allocates, so tables must not be held, and the send must hold no reference
+ * yet: what admission recorded about the versions is not carried over.
+ */
+static int io_opaque_vec_grow(struct io_opaque_req *op, u32 nr, u32 segs, u32 keep)
+{
+	struct io_opaque_vec *old = op->vec, *vec;
+
+	lockdep_assert_not_held(&op->store->tables);
+	if (old) {
+		WARN_ON_ONCE(old->pinned);
+		if (old->cap_nr >= nr && old->cap_segs >= segs)
+			return 0;
+		nr = max(nr, old->cap_nr);
+		segs = max(segs, old->cap_segs);
+	}
+	vec = kvmalloc(size_add(sizeof(*vec),
+				size_add(array_size(nr, sizeof(*vec->ent) + sizeof(*vec->pin) +
+						       sizeof(*vec->start)),
+					 array_size(segs, sizeof(*vec->bv)))),
+		       GFP_KERNEL_ACCOUNT);
+	if (!vec)
+		return -ENOMEM;
+	vec->cap_nr = nr;
+	vec->cap_segs = segs;
+	vec->ent = (void *)(vec + 1);
+	vec->pin = (void *)(vec->ent + nr);
+	vec->start = (void *)(vec->pin + nr);
+	vec->bv = (void *)(vec->start + nr);
+	vec->pinned = 0;
+	if (old) {
+		vec->nr = old->nr;
+		memcpy(vec->ent, old->ent, array_size(keep, sizeof(*vec->ent)));
+		kvfree(old);
+	} else {
+		vec->nr = 0;
+	}
+	op->vec = vec;
+	return 0;
+}
+
+/*
+ * The @nr entries are in the block: validate them and make the request what
+ * its length and offset say about a send, a body of their total at no offset.
+ */
+static int io_opaque_vec_commit(struct io_opaque_req *op, u32 nr)
+{
+	struct io_opaque_vec *vec = op->vec;
+	u32 total;
+	int ret;
+
+	ret = io_opaque_vec_check(vec->ent, nr, &total);
+	if (ret)
+		return ret;
+	vec->nr = nr;
+	vec->pinned = 0;
+	op->handle = 0;
+	op->offset = 0;
+	op->length = total;
+	return 0;
+}
+
+/*
+ * Whether entry @i of an admitted vector holds a reference of its own. A LAST
+ * vector takes one per entry. Any other takes one per run of entries that name
+ * the same handle: within one hold of tables the same handle is the same
+ * version, so the rest of the run shares the first entry's pin. This looks at
+ * the entries, which never change, and not at the pins, which may be freed by
+ * the time the run's owner has been released.
+ */
+static bool io_opaque_vec_owns(const struct io_opaque_req *op, u32 i)
+{
+	const struct io_opaque_vec *vec = op->vec;
+
+	return (op->send_flags & IORING_OPAQUE_SEND_LAST) || !i ||
+	       vec->ent[i].handle != vec->ent[i - 1].handle;
+}
+
+/* Drop every version reference the send holds; one that took none drops none. */
+static void io_opaque_vec_release(struct io_opaque_req *op)
+{
+	struct io_opaque_vec *vec = op->vec;
+	u32 i;
+
+	for (i = 0; i < vec->pinned; i++)
+		if (io_opaque_vec_owns(op, i))
+			io_opaque_data_put(op->store, vec->pin[i]);
+	vec->pinned = 0;
+}
+
+/*
+ * Request cleanup: release what a vectored send pinned and let go of the block
+ * unless the request takes it back to the cache. A big block is not worth
+ * keeping, and under KASAN an entry in the cache is cleared when it is taken,
+ * which would leak it.
+ */
+static void io_opaque_vec_cleanup(struct io_opaque_req *op)
+{
+	struct io_opaque_vec *vec = op->vec;
+
+	io_opaque_vec_release(op);
+	if (IS_ENABLED(CONFIG_KASAN) || vec->cap_nr > IO_VEC_CACHE_SOFT_CAP ||
+	    vec->cap_segs > IO_VEC_CACHE_SOFT_CAP) {
+		kvfree(vec);
+		op->vec = NULL;
+	}
+}
+
 /*
  * Find the segment of @data that holds byte @off, and return how far into it
  * @off is. @seg is a segment of the object that starts @pos bytes in and not
  * after the one wanted: the walk goes on from there, and leaves @seg and @pos
  * at the start of the segment it found.
  *
- * A segment within IO_OPAQUE_SEEK_STRIDE steps is walked to. A farther one
+ * A segment within IO_OPAQUE_SEEK_STRIDE steps is walked to, which is all that
+ * a range after the previous one in the same object ever takes. A farther one
  * is reached by jumping to the last anchor that is at or before @off, if that
  * is ahead of where the walk is, and walking on from it: under a stride more.
  * No seek takes more than two strides and a binary search over the anchors,
- * wherever it starts, however large the object is.
+ * wherever it starts, however large the object is, and so a vector of any
+ * ranges keeps tables for a time that its entries bound.
  */
 static u32 io_opaque_vec_seek(const struct io_opaque_data *data, u64 off, u32 *seg, u64 *pos)
 {
@@ -1822,6 +1984,39 @@ static u32 io_opaque_vec_seek(const struct io_opaque_data *data, u64 off, u32 *s
 	return off - at;
 }
 
+/*
+ * The segments of the range of @len bytes that starts @skip bytes into segment
+ * @seg of @data, as a cursor over the whole object would visit them: the first
+ * starts inside its extent, the last ends inside its own. They are stored at
+ * @bv, and all of them counted, unless it is NULL: then only the count is
+ * wanted, and it stops at @room + 1, since a caller that has room for no more
+ * has no use for how many more there are. The range must lie within the
+ * object.
+ */
+static u32 io_opaque_vec_span(const struct io_opaque_data *data, u32 seg, u32 skip, u32 len,
+			      struct bio_vec *bv, u64 room)
+{
+	const struct bio_vec *src = data->bvec;
+	u32 n = 0;
+
+	while (len && seg < data->nr) {
+		u32 take = min(src[seg].bv_len - skip, len);
+
+		if (bv) {
+			bv[n] = src[seg];
+			bv[n].bv_offset += skip;
+			bv[n].bv_len = take;
+		}
+		n++;
+		if (!bv && n > room)
+			break;
+		len -= take;
+		skip = 0;
+		seg++;
+	}
+	return n;
+}
+
 /* The handle must hold a version, and the range must lie within it. */
 static int io_opaque_send_range(const struct io_opaque_slot *slot, u64 off, u32 len)
 {
@@ -1849,6 +2044,8 @@ static struct io_opaque_data *io_opaque_send_pin(struct io_opaque_store *store,
 /* Drop the references a send took at admission; a no-op when it took none. */
 static void io_opaque_send_unpin(struct io_opaque_req *op)
 {
+	if (op->send_flags & IORING_OPAQUE_SEND_VECTOR)
+		io_opaque_vec_release(op);
 	io_opaque_data_put(op->store, op->data);
 	op->data = NULL;
 }
@@ -1861,11 +2058,28 @@ static void io_opaque_send_unpin(struct io_opaque_req *op)
  * last reference frees the version, every extent of it, and that is not for
  * the lock to wait out. Nobody can take a reference on a version whose count
  * is one, which is not in the table, so the last one is still the last then.
+ * A vector's entries that were put are cleared, so that the rest cannot put
+ * them again.
  */
 static bool io_opaque_send_unpin_cheap(struct io_opaque_req *op)
 {
 	bool left = false;
 
+	if (op->send_flags & IORING_OPAQUE_SEND_VECTOR) {
+		struct io_opaque_vec *vec = op->vec;
+		u32 i;
+
+		for (i = 0; i < vec->pinned; i++) {
+			if (!vec->pin[i] || !io_opaque_vec_owns(op, i))
+				continue;
+			if (refcount_dec_not_one(&vec->pin[i]->refs))
+				vec->pin[i] = NULL;
+			else
+				left = true;
+		}
+		if (!left)
+			vec->pinned = 0;
+	}
 	if (op->data) {
 		if (refcount_dec_not_one(&op->data->refs))
 			op->data = NULL;
@@ -1887,16 +2101,130 @@ static void io_opaque_send_iter(struct io_opaque_req *op, const struct bio_vec *
 	iov_iter_truncate(&op->iter, op->length);
 }
 
-/* Resolve what a send names, take its references and set its cursor, under tables. */
+/*
+ * Admission of a vectored send, under tables; every entry sees the versions
+ * as they are in this one hold, and nothing in here sleeps. Pass one resolves
+ * and counts, and fails without having pinned or detached anything, so a
+ * vector that cannot go consumes nothing. It finds where each range starts by
+ * walking the segments of its version, and an entry that follows another in
+ * the same version, not before the segment that one started in, walks on from
+ * there instead of from the first: ranges in ascending order walk each object
+ * once. One that is more than a stride from where the walk is jumps to the
+ * version's anchors (see io_opaque_vec_seek()), so that ranges that go back
+ * or alternate between large objects cost a few dozen steps each, not an
+ * object. Counting the segments of the ranges stops as soon as the limit is
+ * passed. What tables is held for is therefore bounded by the entries and the
+ * limit, whatever the ranges. A block with too few segments is not grown here,
+ * as that allocates; the number needed is returned, and io_opaque_vec_finish()
+ * grows the block and asks again. Pass two takes the references and looks
+ * nothing up: pass one recorded every version in pin[], and tables has been
+ * held since. A LAST vector detaches each handle at its first entry, and an
+ * entry that repeats the handle takes one more reference on the version it
+ * found. Any other vector takes one reference for each run of entries that
+ * name the same handle (see io_opaque_vec_owns()), so eight ranges of one
+ * object cost one reference, and a handle that returns after another one pins
+ * again. Nothing can fail from there on. The cursor over the combined segments
+ * is io_opaque_vec_build()'s, once tables is dropped.
+ */
+static int io_opaque_vec_acquire(struct io_opaque_req *op)
+{
+	struct io_opaque_store *store = op->store;
+	bool last = op->send_flags & IORING_OPAQUE_SEND_LAST;
+	struct io_opaque_vec *vec = op->vec;
+	const struct io_opaque_data *prev = NULL;
+	u64 segs = 0, pos = 0;
+	u32 i, seg = 0;
+	int ret;
+
+	if (store->dead)
+		return -ESHUTDOWN;
+	for (i = 0; i < vec->nr; i++) {
+		const struct io_uring_opaque_send_entry *ent = &vec->ent[i];
+		struct io_opaque_slot *slot = io_opaque_lookup(store, ent->handle);
+		struct io_opaque_data *data;
+		u32 skip, n;
+
+		ret = io_opaque_send_range(slot, ent->off, ent->len);
+		if (ret)
+			return ret;
+		data = slot->data;
+		if (data != prev || ent->off < pos) {
+			prev = data;
+			seg = 0;
+			pos = 0;
+		}
+		skip = io_opaque_vec_seek(data, ent->off, &seg, &pos);
+		vec->start[i].seg = seg;
+		vec->start[i].skip = skip;
+		n = io_opaque_vec_span(data, seg, skip, ent->len, NULL,
+				       IO_OPAQUE_SEND_VEC_SEGS - segs);
+		segs += n;
+		if (segs > IO_OPAQUE_SEND_VEC_SEGS)
+			return -EMSGSIZE;
+		/* Not yet a reference: pass two takes it, and a repeated handle needs it. */
+		vec->pin[i] = data;
+	}
+	/* Within the limit, so it fits an int. */
+	if (segs > vec->cap_segs)
+		return segs;
+	for (i = 0; i < vec->nr; i++) {
+		struct io_opaque_slot *slot;
+
+		if (!last) {
+			if (io_opaque_vec_owns(op, i))
+				refcount_inc(&vec->pin[i]->refs);
+			continue;
+		}
+		slot = io_opaque_lookup(store, vec->ent[i].handle);
+		if (!slot->data)
+			refcount_inc(&vec->pin[i]->refs);
+		else
+			vec->pin[i] = io_opaque_send_pin(store, slot, true);
+	}
+	vec->pinned = vec->nr;
+	if (last)
+		op->consumed = true;
+	return 0;
+}
+
+/*
+ * The cursor over the combined segments, from the starts that admission
+ * recorded. It takes no lock and is done without tables, which is the point of
+ * it: each version is held by the send's own reference, and the segments of a
+ * version never change.
+ */
+static void io_opaque_vec_build(struct io_opaque_req *op)
+{
+	struct io_opaque_vec *vec = op->vec;
+	u32 i, filled = 0;
+
+	lockdep_assert_not_held(&op->store->tables);
+	for (i = 0; i < vec->nr; i++)
+		filled += io_opaque_vec_span(vec->pin[i], vec->start[i].seg, vec->start[i].skip,
+					     vec->ent[i].len, vec->bv + filled, U64_MAX);
+	io_opaque_send_iter(op, vec->bv, filled, op->length, 0);
+}
+
+/*
+ * Resolve what a send names and take its references, under tables. A send of
+ * one range also gets its cursor. A vector returns 0 with its references taken,
+ * a negative errno with none taken and nothing removed, or the number of
+ * segments its ranges span when its block holds fewer, to be settled by
+ * io_opaque_vec_finish() once tables is dropped.
+ */
 static int io_opaque_send_acquire(struct io_opaque_req *op)
 {
 	struct io_opaque_store *store = op->store;
 	bool last = op->send_flags & IORING_OPAQUE_SEND_LAST;
-	struct io_opaque_slot *slot = io_opaque_lookup(store, op->handle);
+	struct io_opaque_slot *slot;
 	u64 pos = 0;
 	u32 seg = 0, skip;
 	int ret;
 
+	if (unlikely(op->send_flags & IORING_OPAQUE_SEND_VECTOR))
+		return io_opaque_vec_acquire(op);
+	slot = io_opaque_lookup(store, op->handle);
+
 	if (store->dead)
 		return -ESHUTDOWN;
 	if (!op->length)
@@ -1907,13 +2235,58 @@ static int io_opaque_send_acquire(struct io_opaque_req *op)
 	op->data = io_opaque_send_pin(store, slot, last);
 	if (last)
 		op->consumed = true;
-	/* The cursor starts at the segment that holds the range. */
+	/* The cursor starts at the segment that holds the range, found as a vector's are. */
 	skip = io_opaque_vec_seek(op->data, op->offset, &seg, &pos);
 	io_opaque_send_iter(op, op->data->bvec + seg, op->data->nr - seg, op->data->length - pos,
 			    skip);
 	return 0;
 }
 
+/*
+ * What admission of a vector does without tables, after the hold in which
+ * io_opaque_send_acquire() returned @ret. A block with too few segments (@ret
+ * of them are needed) is grown here, where allocating is fine, and the vector
+ * is resolved again in a new hold: nothing was pinned, and the versions may
+ * have changed meanwhile, so every entry is looked at again. Once the vector
+ * is admitted, the cursor is built.
+ */
+static int io_opaque_vec_finish(struct io_opaque_req *op, int ret)
+{
+	while (ret > 0) {
+		ret = io_opaque_vec_grow(op, op->vec->nr, ret, op->vec->nr);
+		if (ret)
+			return ret;
+		scoped_guard(mutex, &op->store->tables)
+			ret = io_opaque_send_acquire(op);
+	}
+	if (!ret)
+		io_opaque_vec_build(op);
+	return ret;
+}
+
+/*
+ * A vectored send: addr names len entries and off is zero. They are copied
+ * now, like SEND_ZC's iovecs, and the array need not stay valid. The request
+ * still holds the SQE's addr, off and len in handle, offset and length; the
+ * commit turns them into the body, whose handle and offset are none.
+ */
+static int io_opaque_send_vec_prep(struct io_opaque_req *op)
+{
+	u32 nr = op->length;
+	int ret;
+
+	if (op->offset || !nr || nr > IORING_OPAQUE_SEND_VEC_MAX)
+		return -EINVAL;
+	/* Every entry spans a segment; admission grows the block if some span more. */
+	ret = io_opaque_vec_grow(op, nr, nr, 0);
+	if (ret)
+		return ret;
+	if (copy_from_user(op->vec->ent, u64_to_user_ptr(op->handle),
+			   array_size(nr, sizeof(*op->vec->ent))))
+		return -EFAULT;
+	return io_opaque_vec_commit(op, nr);
+}
+
 int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_opaque_store *store = io_opaque_get_store(req, READ_ONCE(sqe->opaque_store_id));
@@ -1925,7 +2298,7 @@ int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	if (!store)
 		return -ENXIO;
-	if ((send_flags & ~IORING_OPAQUE_SEND_LAST) ||
+	if ((send_flags & ~(IORING_OPAQUE_SEND_LAST | IORING_OPAQUE_SEND_VECTOR)) ||
 	    ((send_flags & IORING_OPAQUE_SEND_LAST) && (req->flags & REQ_F_CQE_SKIP)) ||
 	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
 	    (msg_flags & ~(MSG_MORE | MSG_DONTWAIT)))
@@ -1943,6 +2316,11 @@ int io_opaque_send_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	op->msg_flags = msg_flags;
 	if (op->msg_flags & MSG_DONTWAIT)
 		req->flags |= REQ_F_NOWAIT;
+	if (unlikely(send_flags & IORING_OPAQUE_SEND_VECTOR)) {
+		ret = io_opaque_send_vec_prep(op);
+		if (ret)
+			return ret;
+	}
 	if ((!op->length && !op->addr) || op->length > INT_MAX ||
 	    check_add_overflow(op->offset, (u64)op->length, &end))
 		return -EINVAL;
@@ -2036,13 +2414,20 @@ static struct io_opaque_tx *io_opaque_tx_alloc(struct io_opaque_store *store,
 	return kzalloc_obj(struct io_opaque_tx, gfp);
 }
 
-/* Resolve what a send names and take its references, under tables. */
+/*
+ * Resolve what @op names and take its references: the handles under tables,
+ * and then, without it, the block and the cursor. A vector leaves tables once
+ * its references are taken; one whose block is too small leaves it earlier, to
+ * grow the block, and is resolved again.
+ */
 static int io_opaque_tx_acquire(struct io_opaque_req *op)
 {
 	int ret;
 
 	scoped_guard(mutex, &op->store->tables)
 		ret = io_opaque_send_acquire(op);
+	if (unlikely(op->send_flags & IORING_OPAQUE_SEND_VECTOR))
+		ret = io_opaque_vec_finish(op, ret);
 	return ret;
 }
 
-- 
2.34.1

