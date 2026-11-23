Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468443;
	b=vNtjJgV2lFPA2WTkYbDotxlCe34gP2JdmZU2lOMK8Izl012jLSaxjBsbje8wiI1XfnuC
	 dKIQoSyrRIw92SbTV4mQJtw4IgCgR8BBfqwjy+g0fIS+LOyXfrtjd7WyMyyHCkkfbz8rQ
	 jEQvq2CWCtSKMVeTq9I5Bc0MmDEqEE/NEXx7+40PByYLLrDIOXvviytSFamU2vg/84btL
	 00UKOARsvGuDqwu7tQnMnlG42OIlVk3FgI95IBw/SoEDOGZM+MeNGHDesJuhCfuZXDjxd
	 BTlriLHvrB2xA06hS6Ny/VXzU8dHaVOISZhYM0mTsXvAulLpP1fFnMfpVA7NnIiJlFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=iLUI5O+p+2tRmHjW4/14o7W/IN6GSuTZ+C+ANbuOOSE=;
	b=IJpDloenTRLXc17Lw+Yi/JZhgKV5NnJ9+jfnvoij7i3jIaqgm8oeHayOtH+1HFu5qgdn
	 OJ8PFUtNbwTvunqVkD7+TI/ZnV25Rcuvi5JnenC6oVIUFDpo2bj2WpxwyE7KxoFgjOJ7i
	 G25mizTx1on3k7xeSSY8YA/lCYdxtUqLspuZbVjK/0wUciGSooGRBZ7FCYA9HIMc6ZfI7
	 zEQ5hV6Jwea829f7xIZbucKofv09pA4tbijvjmEDy0zh619+rukK/blJfySBio0j+nLyY
	 wX7no2y+eLPc3qpz7mmQDLqfLr0puFyPy8Vq2BtfTcXPB+qnAecZp8PsKkoWRBwss2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZiomkya;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCA606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FCA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZiomkya
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-718facffeffso362179eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468441; x=1796073241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLUI5O+p+2tRmHjW4/14o7W/IN6GSuTZ+C+ANbuOOSE=;
        b=nZiomkyahKYT8+PRSnf89xNJ8CCphUGLtL2v31TTwQMBJElKwTFCkSWIPFt3WIdhnu
         Lfah9XPyz7e8MklvANayD7UJxd0YxiDTmLIiTl3jNBiE5XokD8rjxh3RNK1hBaNj28dT
         JYkLZrXq9SGt2UGqFAOacouVxDdfpaId8HxaqULKuaYun2ptOYACeePECR7XL7k47/QO
         XBAONMr4F6O/+W3nxp7h8gc5cZfbtchNX5R7YdQDrAW+Z9yvwEKeHAjwbGD0S30Bp/dC
         Frirs9E6DGCKTfJ8wNxa5o81QSNHYoszuqubnTzn3a06DOwzFRw+P5H9SjysLMq/CQVH
         AVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468441; x=1796073241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLUI5O+p+2tRmHjW4/14o7W/IN6GSuTZ+C+ANbuOOSE=;
        b=xTH3q5RCK0tu7a/qASTJ4EsE9EqeBkF+JNA7A3G9aiKmQmksjAFk0lPOCjbTKN2lnH
         bJedUuMrt/BOjT39Zb41v+J55BDF3q1NMUSibtSOWzLZDiroSsk8Ku6GSzmw6ZZQQuJm
         eaZ4B3FiOXMSCg8uNFz+HdB/Ydu1FApa84p4iYnCIEPBYHrES+rausNFQh6qWN3Eqiwr
         omrhr9dG24MisaE+dgALLOom68rEDORzGoQ5dUsuHaC2Ho2EfUK8dmujjVqBxOpXvXQl
         FNbGgxOTmjgetwW3GqdJGtQsqorkp1N3oe/ilbFbcjtOTES/CSQEapCjm8PehxJEfLSl
         a1nw==
X-Gm-Message-State: APuU4Z/Bwe3Grzr+fqJuVXh99w2RCszHx9yaHTFNz5XqfqI69pozeAhO
	ixIIiqzLqPJgwLLIEwELcN0WD+W+ye3i/ih1B7AMZfOG4Xpa5/k9kgOhTNgDZr1KmNA=
X-Gm-Gg: AZFdTZcKW9N3ftIg9rOQsW6jzvrvpFoDN1q5JdNs34tNJ+qT6l9rCfoKmnfas5/c36r
	kwnRcJE1KOkzYB1KsQqaF3fLK5su819ICD3etoQ746Fx5/i0oC/MNIYsjVdpxhQGm+hv0VIh3XK
	jyY7fkl1s5JhoVZJuHIUe+KRCun1uWlVNITVO9ieBupSNkB0Mzbf4Az0Gckbh/wwkaJuonSuDWU
	BhmaH9DF6u3ZMVKZYd/b9CbewGbzAgBl/wTdl3dvhdC7E3HaASDvqPircnvmhSASxFxV2WJ3uqT
	seCbv6Bg+v1UE0ssYsD+8cJ1gEiCDbpLKu3xuZ/9ya2O4IAS8OjP8DcIcaZudxttse/1YgTCVYk
	3hUjs53LM9RYhAa8mpvE/eYMYM3EXP7Y0BmSZ5SzEuHaPQcXpjG1JeEpYDfyvnwlMOgZJuoFZoW
	O8/MOVde+rwFmYmFfGnHdxacCbaZXhagzNOv2V4zan1F1IT3N5NFhHYsKBVWfEZqhxeYbZmZt/Q
	H1x0DL8/zx/efFdF1MrkTZ+8R3qRTw5BOslIXLyrYL+op0cdAk3yBb6GsCrpa/Sm9zGPmbfdeDs
	DR1pt2sOpuq4sX5EqYGgnAAzlDGxMeVCaI4Y/GIETI9dzQfUDMufGMBu+Fm0NbqaSfw0ZDc8cSa
	oE/hLX5PRRki7Iixy4A+1BNESmTBhZ/gB9/Qw
X-Received: by 2002:a05:6820:c7c5:b0:6cd:3ffc:64d7 with SMTP id 006d021491bc7-71b3959fa95mr7008872eaf.82.1795468441542;
        Mon, 23 Nov 2026 13:14:01 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38058102sm7596881eaf.6.2026.11.23.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:14:01 -0800 (PST)
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
Subject: [PATCH bpf-next v1 08/10] libbpf: Split ring setup out of ring_buffer__add()
Date: Mon, 23 Nov 2026 22:13:31 +0100
Message-ID: <bbb91dd4804421327bdff500116871aaf51c2325.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5842; h=from:subject:message-id; bh=V4TbzUfl5fL/TT6Gd1SKNMzHdATe91qsV0P+vP2Xl0s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhUnClDtvffbx/jlt5bTgmb7GwVMf3kWVzlCz/sjM1fdp R6V9RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZycCkjw+q9jQ/3njU5HsnuXFemrv hlc9DcE7OKnq3uXNB54cpi/RMMv1kjrk9a7pelHaz7eY9b2bxArb+tMWZfZJV4WdX3tN9l4gAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Move the part of ring_buffer__add() that validates and mmap()s the ring
buffer map into ringbuf_map_ring(), and keep the page size in struct ring
instead of taking it from the ring_buffer manager. This way a ring can be
set up and freed without a manager.

No functional changes intended.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 88 ++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index b4e9e27951eb..90ed354118de 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -39,6 +39,7 @@ struct ring {
 	/* overwrite mode: first record returned since the last release or rewind */
 	unsigned long batch_pos;
 	bool has_batch;
+	size_t page_size;
 	int map_fd;
 	bool overwrite;
 };
@@ -68,28 +69,24 @@ struct ringbuf_hdr {
 	__u32 pad;
 };
 
-static void ringbuf_free_ring(struct ring_buffer *rb, struct ring *r)
+static void ringbuf_free_ring(struct ring *r)
 {
 	if (r->consumer_pos) {
-		munmap(r->consumer_pos, rb->page_size);
+		munmap(r->consumer_pos, r->page_size);
 		r->consumer_pos = NULL;
 	}
 	if (r->producer_pos) {
-		munmap(r->producer_pos, rb->page_size + 2 * (r->mask + 1));
+		munmap(r->producer_pos, r->page_size + 2 * (r->mask + 1));
 		r->producer_pos = NULL;
 	}
 
 	free(r);
 }
 
-/* Add extra RINGBUF maps to this ring buffer manager */
-int ring_buffer__add(struct ring_buffer *rb, int map_fd,
-		     ring_buffer_sample_fn sample_cb, void *ctx)
+static int ringbuf_map_ring(struct ring *r, int map_fd)
 {
 	struct bpf_map_info info;
 	__u32 len = sizeof(info);
-	struct epoll_event *e;
-	struct ring *r;
 	__u64 mmap_sz;
 	void *tmp;
 	int err;
@@ -101,43 +98,26 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		err = -errno;
 		pr_warn("ringbuf: failed to get map info for fd=%d: %s\n",
 			map_fd, errstr(err));
-		return libbpf_err(err);
+		return err;
 	}
 
 	if (info.type != BPF_MAP_TYPE_RINGBUF) {
 		pr_warn("ringbuf: map fd=%d is not BPF_MAP_TYPE_RINGBUF\n",
 			map_fd);
-		return libbpf_err(-EINVAL);
+		return -EINVAL;
 	}
 
-	tmp = libbpf_reallocarray(rb->rings, rb->ring_cnt + 1, sizeof(*rb->rings));
-	if (!tmp)
-		return libbpf_err(-ENOMEM);
-	rb->rings = tmp;
-
-	tmp = libbpf_reallocarray(rb->events, rb->ring_cnt + 1, sizeof(*rb->events));
-	if (!tmp)
-		return libbpf_err(-ENOMEM);
-	rb->events = tmp;
-
-	r = calloc(1, sizeof(*r));
-	if (!r)
-		return libbpf_err(-ENOMEM);
-	rb->rings[rb->ring_cnt] = r;
-
 	r->map_fd = map_fd;
-	r->sample_cb = sample_cb;
-	r->ctx = ctx;
 	r->mask = info.max_entries - 1;
 	r->overwrite = info.map_flags & BPF_F_RB_OVERWRITE;
 
 	/* Map writable consumer page */
-	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	tmp = mmap(NULL, r->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
 		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %s\n",
 			map_fd, errstr(err));
-		goto err_out;
+		return err;
 	}
 	r->consumer_pos = tmp;
 
@@ -145,21 +125,20 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	 * data size to allow simple reading of samples that wrap around the
 	 * end of a ring buffer. See kernel implementation for details.
 	 */
-	mmap_sz = rb->page_size + 2 * (__u64)info.max_entries;
+	mmap_sz = r->page_size + 2 * (__u64)info.max_entries;
 	if (mmap_sz != (__u64)(size_t)mmap_sz) {
-		err = -E2BIG;
 		pr_warn("ringbuf: ring buffer size (%u) is too big\n", info.max_entries);
-		goto err_out;
+		return -E2BIG;
 	}
-	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd, rb->page_size);
+	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd, r->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
 		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %s\n",
 			map_fd, errstr(err));
-		goto err_out;
+		return err;
 	}
 	r->producer_pos = tmp;
-	r->data = tmp + rb->page_size;
+	r->data = tmp + r->page_size;
 	/*
 	 * overwrite_pos comes after producer_pos and pending_pos. Its offset
 	 * depends on the size of the kernel's unsigned long, which 32-bit libbpf
@@ -170,6 +149,41 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	r->next_pos = smp_load_acquire(r->consumer_pos);
 	r->prod_pos = r->next_pos;
 
+	return 0;
+}
+
+/* Add extra RINGBUF maps to this ring buffer manager */
+int ring_buffer__add(struct ring_buffer *rb, int map_fd,
+		     ring_buffer_sample_fn sample_cb, void *ctx)
+{
+	struct epoll_event *e;
+	struct ring *r;
+	void *tmp;
+	int err;
+
+	tmp = libbpf_reallocarray(rb->rings, rb->ring_cnt + 1, sizeof(*rb->rings));
+	if (!tmp)
+		return libbpf_err(-ENOMEM);
+	rb->rings = tmp;
+
+	tmp = libbpf_reallocarray(rb->events, rb->ring_cnt + 1, sizeof(*rb->events));
+	if (!tmp)
+		return libbpf_err(-ENOMEM);
+	rb->events = tmp;
+
+	r = calloc(1, sizeof(*r));
+	if (!r)
+		return libbpf_err(-ENOMEM);
+	rb->rings[rb->ring_cnt] = r;
+
+	r->page_size = rb->page_size;
+	r->sample_cb = sample_cb;
+	r->ctx = ctx;
+
+	err = ringbuf_map_ring(r, map_fd);
+	if (err)
+		goto err_out;
+
 	e = &rb->events[rb->ring_cnt];
 	memset(e, 0, sizeof(*e));
 
@@ -186,7 +200,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	return 0;
 
 err_out:
-	ringbuf_free_ring(rb, r);
+	ringbuf_free_ring(r);
 	return libbpf_err(err);
 }
 
@@ -198,7 +212,7 @@ void ring_buffer__free(struct ring_buffer *rb)
 		return;
 
 	for (i = 0; i < rb->ring_cnt; ++i)
-		ringbuf_free_ring(rb, rb->rings[i]);
+		ringbuf_free_ring(rb->rings[i]);
 	if (rb->epoll_fd >= 0)
 		close(rb->epoll_fd);
 
-- 
2.53.1-Meta

