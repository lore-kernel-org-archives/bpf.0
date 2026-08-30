Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD63A7F40
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082525; cv=none; b=uGy65HYbLjveII152LaexrHcnzHosgqTUl6U5Fl4hrZR7w3frRyTUKQn79u/hE3MAb6hIdIYkwBD5YOuJl9pYnv18GGjR00iKN+jxHjN4JcdChhoqWBFjfp+/acyAaLSDv2pmVy7atk/uqSam/XxBB25vNoUI7sQPs3c2f75AVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082525; c=relaxed/simple;
	bh=hQBNNl7cnjoq5ul4sDQIO5yfIQLed6Sllq0JJNUVaZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR4YBb7BQ8yfu6EX8qEko6OcKvffahBK0mGVz7RaTneRZVVyqehPAqWNKRdxBP+lGdRmCEt9LGJd2JCv1sIb/5QiiKzh8ZJqoiT7jTFIA/rnI2aZTL6tagbloHSaCFH9NMLkUbDskLR+Tbs7PxFZ69gFMSwLfjJl5VlVQNJ4Gr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7d2Dvfa; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7d2Dvfa"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b46dc430fso4925945e9.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082522; x=1788687322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVK/qsYQvh6z9w2d6ieuOwxW7in3HuAXT83Yt9jBphc=;
        b=C7d2DvfakdTaR9OPM+lxVq1Rn8wnjrXJaTNWlCGXcv2NPGvbfeMEdrd+2W5bBx0ogu
         T38GL13NYHy0Pbcwb7yYViwxSk1sZniwobP2f6te66lO5ZP8398484eGWQjyOf8e6Q8B
         U02czdbievSMAOIPbXgjfAQlUHX5paqt8/Dz9vZErdL4bvfhz6tNH1zfCY7iReVPvV9+
         VQdfVaUPz9DcFHMMnuXP4xDP0GZNTXAEjYTkQj2myLki1kTcxcyln6+6xW7pJfK5LsR5
         spj1GkoN5E1DsGM9jPtrULgEqBbGvwRM5Vf2qJ21wYC7TSdirXYBJ7u3ODYtnYhpYU+i
         xMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082522; x=1788687322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVK/qsYQvh6z9w2d6ieuOwxW7in3HuAXT83Yt9jBphc=;
        b=UWcXPI9bw21VIQYti3ZVFhu2vTU+I4q0eQUEZKAKULRDkjoMNvSepWBKNdd7a+vD1t
         sKyaD+XX9PeRLybRRilJlqRR/m/CBnPLkRQNqEG/V6M8q21Sv046Y9lWh/kQRXn/+AZI
         krZ8+ioByaa8m9xdkAG361gGfEWeaYGuY3OGWzhSVpHuRD0destNWjd3voDh1EYIdlzl
         tARgohpL+GRBh/SDmt+5xlO5eeobUUSyUKyDLYhx6qHFLGxMWIaYJye+HhANslisPNc2
         lD+Mcxd0pWgIHv3wveZsdk3AJfuGbvrOF2oatnn50/TVHbRVq2XuhcoA7J8cNF9JKZa9
         fklg==
X-Gm-Message-State: AFuF++m0Wc3848HL/XWTMASpMGgmnnt1p9dErKZSVYl9/0SE+jJE9OmI
	0ao1JzCRyKW82ka8EnvRHNXuxhKUJxYw9cjNnZRIl0GXqKjhyexJ9M8O2yrGhbnVgI0=
X-Gm-Gg: AYBFou3ZrSxUIH6JqY+OWDqs5pA9JorBuWAmSV39C65Xkxa6R4OABOyfKum53Uds3X/
	stiY8L8KAfv+JfbAcXG+P3vQbbADndVLdEGzRI3iOPwjuiVR1PHzO1u7iVNKY+oxYbGxFzSfqpq
	u5w0N1LLyXZBPZ/AhAaH81GW5rFEm2pWJCAxLK7uvtXO8T5e4NfidxSHQ71xq2r7SIsMOefSiz7
	YccmV7OlDNAYNcj1hRa5+I4+WjMWJH+m3PGTN+zgB/KOlcT+Q+E9uSkRF17KYff/P8PkmSOIFyM
	qPm2LMGmArTIt6HvEbix/G0NO8Dyfmryt5zW5BZ/giAvo2KK6NQfCnze3nDgkSA67iNaVSIEn4n
	e0j3sAuHpSAlQfoFVOPt7leuwg7z4gmbJxuLzq5rtYlEUzLqVEzBrdAqHAlHpW5SnTlDc4KXW2D
	Q/xCuPTELzI6RD2TWwHraLnmgVFuJuvyqWS5eVeN4KJFxITST+pecoZK4gbDV+DEEX0OWK4777F
	y7zHKUXCMNlHl/+4SF7a5rPO+hD3AmTk74ubFIRjD+WpTqqR3GCe566SdI+Qg0H5rsJJqBEczXb
	vsLYm/BanFO5PPDSKpZydApImOo=
X-Received: by 2002:adf:e191:0:b0:482:e6b5:61c with SMTP id ffacd0b85a97d-482f7983567mr29320036f8f.8.1788082522069;
        Sun, 30 Aug 2026 02:35:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac7c01sm15818755f8f.14.2026.08.30.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/6] bpf: Separate stream readiness from capacity accounting
Date: Sun, 30 Aug 2026 11:35:08 +0200
Message-ID: <20260830093514.4105972-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5037; i=memxor@gmail.com; h=from:subject; bh=hQBNNl7cnjoq5ul4sDQIO5yfIQLed6Sllq0JJNUVaZg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyx62ZcbIpvx8Ff9vB9DzDdtLKPzIXV1Tsm96yyXbBr RP5ZY3uHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIpRgjw2fBjvbjlWy/DO48 jlO6f56lnenqxBWPEz3+bi04/Pn/JRFGhqOdGVU7a0odqytso0P0ohxzn/to3JlzIHHtgpWrg+q zuQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stream capacity is charged before allocation and before an element is
published to the stream log. Using that reservation counter as the read and
poll readiness condition can therefore report readable data while no
element exists. A blocking reader can then repeatedly retry instead of
sleeping, while a non-blocking reader can observe POLLIN followed by
EAGAIN.

Add a separate readable byte counter. Publish bytes with release ordering
after adding elements to the lockless log, and use acquire loads before
consuming them or reporting readiness. Limit each read to its readable
snapshot and subtract only bytes actually copied; this keeps the aggregate
count correct even when concurrent publishers update it out of publication
order.

Keep the existing capacity counter solely for enforcing the stream size
limit.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  3 ++-
 kernel/bpf/stream.c | 35 +++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0af3c79f5d03..2ed1e82391b9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1713,7 +1713,8 @@ enum {
 
 struct bpf_stream {
 	refcount_t refcnt;
-	atomic_t capacity;
+	atomic_t capacity;	/* bytes reserved against the stream limit */
+	atomic_t readable;	/* published bytes available to readers */
 	struct llist_head log;	/* list of in-flight stream elements in LIFO order */
 
 	struct mutex lock;  /* lock protecting backlog_{head,tail} */
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 99a89533eaef..b1e6767d8754 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -88,6 +88,21 @@ static void bpf_stream_notify(struct irq_work *work)
 	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
 }
 
+static int bpf_stream_readable_bytes(struct bpf_stream *stream)
+{
+	return atomic_read_acquire(&stream->readable);
+}
+
+static void bpf_stream_publish(struct bpf_stream *stream, int len)
+{
+	if (!len)
+		return;
+
+	/* Pairs with atomic_read_acquire() in bpf_stream_readable_bytes(). */
+	(void)atomic_add_return_release(len, &stream->readable);
+	irq_work_queue(&stream->notify_work);
+}
+
 static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
 {
 	int ret = bpf_stream_consume_capacity(stream, len);
@@ -98,8 +113,8 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 	ret = __bpf_stream_push_str(&stream->log, str, len);
 	if (ret)
 		bpf_stream_release_capacity(stream, len);
-	else if (len)
-		irq_work_queue(&stream->notify_work);
+	else
+		bpf_stream_publish(stream, len);
 
 	return ret;
 }
@@ -176,14 +191,16 @@ static bool bpf_stream_consume_elem(struct bpf_stream_elem *elem, int *len)
 
 static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 {
-	int rem_len = len, cons_len, ret = 0;
+	int read_len, rem_len, cons_len, ret = 0;
 	struct bpf_stream_elem *elem = NULL;
 	struct llist_node *node;
 
 	mutex_lock(&stream->lock);
+	read_len = min(len, bpf_stream_readable_bytes(stream));
+	rem_len = read_len;
 
 	while (rem_len) {
-		int pos = len - rem_len;
+		int pos = read_len - rem_len;
 		int chunk, n;
 		bool cont;
 
@@ -205,7 +222,7 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 			/* Keep any successfully copied bytes; -EFAULT only if none. */
 			elem->consumed_len -= n;
 			rem_len += n;
-			ret = (len == rem_len) ? -EFAULT : 0;
+			ret = (read_len == rem_len) ? -EFAULT : 0;
 			break;
 		}
 
@@ -216,8 +233,9 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 		bpf_stream_free_elem(elem);
 	}
 
+	atomic_sub(read_len - rem_len, &stream->readable);
 	mutex_unlock(&stream->lock);
-	return ret ? ret : len - rem_len;
+	return ret ? ret : read_len - rem_len;
 }
 
 int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, void __user *buf, u32 len)
@@ -234,7 +252,7 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
 
 static bool bpf_stream_has_data(struct bpf_stream *stream)
 {
-	return atomic_read(&stream->capacity) > 0;
+	return bpf_stream_readable_bytes(stream) > 0;
 }
 
 static void bpf_stream_put(struct bpf_stream *stream)
@@ -412,6 +430,7 @@ int bpf_prog_stream_init(struct bpf_prog *prog, gfp_t gfp_extra_flags)
 
 		refcount_set(&stream->refcnt, 1);
 		atomic_set(&stream->capacity, 0);
+		atomic_set(&stream->readable, 0);
 		init_llist_head(&stream->log);
 		mutex_init(&stream->lock);
 		init_waitqueue_head(&stream->waitq);
@@ -496,7 +515,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 		list = tail;
 	}
 	llist_add_batch(head, tail, &stream->log);
-	irq_work_queue(&stream->notify_work);
+	bpf_stream_publish(stream, ss->len);
 	return 0;
 }
 
-- 
2.53.0

