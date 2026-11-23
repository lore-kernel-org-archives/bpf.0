Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468447;
	b=rFINQVQBH0tutraplC0vxYFLZ3wJrngu66LfJGuwZoe91aDjxI4lVnIyry6Jq4edkKo1
	 fmswE3q63AvIJ3ZWHsKvrn3Vj/RZnJ9ho5r4VoQ2v9cTt1x1mSQ/lSlP4Tjfnj/h57EWz
	 dzlkwwaxx1jXAy2PZRciiUhEYeniLhKYdBRkGrmsyFEPiWB3B7x53xlRTkJH3KxbLT9Vq
	 q9Jz4FeFPuc/PfZhH8iGHGhGOZdBLXBHG0HNtCCcB4YAQLKUdJqSx5eAb7FG2C38ark9A
	 gBzNlBH1tdBI1sh2Jvs4ktGawp0327U2s5pHumyhsigTziOwksB8T+6P3s11Rk8udHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=w+ZAmPj89M9XqVxvMEL+LtteTHJMDK5yzdAyirr+4XI=;
	b=enZ67xmvhBlgxA39QacsiFg0ZW6JUvQP4hg9tLOrS3NCBvHIu/BG/KfmppsB/mnSK2qb
	 a4rWabwf8h1McgoPEQU8wIOT0aTCFat71V99Oh7PbplyPUWTS/sdyVfSMM8S/EbrV36+5
	 BLfFUglQ1TzwL/S/XlfISxdh2Ol3lVe0hPfHXfjIwNm5IZOcQZRhHxoxTopxynB8Vz60d
	 nBkmUFjuF1dPyL4SCl7Od/Et9BOvXPTnqr1QQVJGG+e2xFVkm/RZX3M67SpQdctCQqwfo
	 iN7oHncPqVlAX9a9AeR8s7a2ouE8b4a16ugyVy+TwQhbnSVP287g244ML2ly/sLvVsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeSDv9Dg;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PeSDv9Dg
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so1453050b6e.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468445; x=1796073245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+ZAmPj89M9XqVxvMEL+LtteTHJMDK5yzdAyirr+4XI=;
        b=PeSDv9DgUgjgLv+kS6X5Nr8un2LK19hl5CRBo/HV27YXEsVo6U7Me4UTSrYr6NOGXk
         Euvhbm5fVYv1d7UTO1WZVpvbFqQhG7P+ZKLD0nhtt1upMrG2voVra4yE4i64zC/zhJ/p
         LvFTLjSrc2EYvHfMbaZqvnbSzxodlUZptvilLpb4BS3H4Esx4Qi86dS/a3vsy4LPS6b/
         2cwRMh+lGUBu3TA7L/K1uu2go5PtYvtK1CfyFgEn3WF9h4p8nHubAPNLJB46fHNAkyVK
         aNEy7qu+XA3h1WjXPzyUq9/wdPbHtKxUxCa51/Bir2vCk1KWxhYEPIKX13/Ni7lOpVo5
         jd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468445; x=1796073245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+ZAmPj89M9XqVxvMEL+LtteTHJMDK5yzdAyirr+4XI=;
        b=tQcKpQlmiQaZNnCVLZjVMGC2uQEzseLHx5T6daPTysz2NVjsyPI/4hCvtAjE/QBF8B
         E4kOLYEEXVzf8SEvHKOLPmwO+piwQTeakjhtjpjreRi4IOKY25mZl4xry0uimOKSKRLN
         eDv/v4SoCn16XTQo9jrE8/TLa5T63BsgUUcwoNkQ/fLf659oQw4aXbnbQnQO2M6U8HN1
         u9d3wMJ4c64OHHb7yHLYIdnd5SjS02pAz7ueksISMgOZH3AUHFUkUFZWOG5jltdD/RS7
         8atqsuPG5DXN17LlT6tPaD+jCZkgZzJrLGkSNOD5j8aG/5ycWFeuvUfwQDTko+72SKW1
         szrg==
X-Gm-Message-State: APuU4Z+JTKdwZyN7IZrReUrJR1IG09mkzC1rSTsMXEZ4Hipo3THF6Q3o
	bg8cdGW0cGugKYQPCI6GpKfdJ2jBqG7fVRmizAA0Xu9V2EDWlTXVpkY82hh5np/22Hc=
X-Gm-Gg: AZFdTZfqIJaamyrFwz6cMnWVnRaNE3XZhzw85Fy1vaWSi2KXE8eX3PhjlLl0ZI0fLS+
	ydQuRHVloeJt+nrt1ETV/AawlB8jI2JRexkmQ0Z+2W6n4NyfamcGeJ+oBZkVSiO+HQgSqaSZuPA
	3gCFCUYVf5QW0r7BnDFrYxCKYESYGVObRF6C5XGkllDkvXpSb8J7vXmWXz37OAQYTY8hM8OCG8W
	iEtr9UQEXgOxGmNxg4iLYApNQ9fu4vNQZRglelTVwrWLbAEjL+kCqeQWDC7p5StnDAURgKiJ4KH
	hUpV9lEdvGCNWOVXMa04QQckXwFiM0ZM2ipjV9ULol8PDTft8Or8UVJvSBxaQKIG9mSup/DC3bf
	JSCVilY1goZVclLxaDRxUgB6Rw4JHlnesCcHq8Qt9F/y+Mr5C6yrhPyBMKvdi08BBoHIqZ58AGw
	cm6Ce1W7UZD5HC0gDl3UpVXryYXrDxmpn/kXj86zwFePNP9Ukec0YqU7NZDg+WkZ/7Oe6a4dxS6
	c7CTCtN2rJEtlv8949ow4vJg3zWRHshkAX6BOW0e0fi+ue2YXgCeL9rQcNnRm3bGZQNqp9Qg0hr
	ZLqMSfNP6jw6ZLEf+PQ9hHf5cbHBTezdCI/Q7IYjw/5hdUPWlKGiSeGrXTJJsus9qx9hcalFzQE
	RMkJ+kcxA2z3G15nH3iFPhixcnlBKkuIDKCeEJl9xstMoDiD+E+qUOIq/
X-Received: by 2002:a05:6808:1910:b0:573:4714:5d7c with SMTP id 5614622812f47-57a0ad2a864mr13195821b6e.66.1795468445461;
        Mon, 23 Nov 2026 13:14:05 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3485e3ecsm9353441b6e.9.2026.11.23.13.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:14:04 -0800 (PST)
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
Subject: [PATCH bpf-next v1 09/10] libbpf: Add ring__new() and ring__free()
Date: Mon, 23 Nov 2026 22:13:32 +0100
Message-ID: <672644a3994795301e66804ad18983a65efd0d75.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; h=from:subject:message-id; bh=wgcRun0yM6UdQeJ1jr4IyYh91RJ6oOtTNN6lxz/ccd4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhemJop4orq8Cxgmmy65sXRn3dauo+c+4PscT++XDnPcF 5jV0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ+dxkZvvrPeyWxVGXOo8Wcs898Xu 8YsWLuKuGw6eWpv0W5H+b0izEyTNyX35HA/pX9rgOz5fWin2m6drJC3z8s9fi1LHbRUXZZdgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A struct ring can only be obtained from a ring_buffer manager, which
creates an epoll instance and owns all its rings. An application that
consumes a single ring buffer with ring__next() and polls the map fd in
its own event loop doesn't need the manager.

Add ring__new() to create a struct ring directly from a ring buffer map
fd, and ring__free() to free it:

	r = ring__new(map_fd, NULL);
	epoll_ctl(epfd, EPOLL_CTL_ADD, ring__map_fd(r), &ev);
	for (;;) {
		epoll_wait(epfd, &ev, 1, -1);
		do {
			while ((rec = ring__next(r)))
				handle(rec->data, rec->len);
		} while (ring__release(r) > 0);
	}
	ring__free(r);

Rings that belong to a ring_buffer manager are still freed by
ring_buffer__free() and must not be passed to ring__free(). It is an easy
mistake to make and hard to debug, so ring__free() prints a warning and
does nothing for such a ring.

ring__new() takes an opts struct for future extensions, like
ring_buffer__new() and user_ring_buffer__new().

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h   | 29 +++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 24a70bf3f782..038502f27014 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1593,6 +1593,35 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
 					  unsigned int idx);
 
+struct ring_opts {
+	size_t sz;
+	size_t :0;
+};
+#define ring_opts__last_field sz
+
+/**
+ * @brief **ring__new()** creates a ringbuffer object for a single
+ * BPF_MAP_TYPE_RINGBUF map, without a ringbuffer manager.
+ *
+ * The ring has no sample callback, so it can only be consumed with
+ * **ring__next()**. Free it with **ring__free()**. To wait for data, poll
+ * *map_fd*.
+ *
+ * @param map_fd File descriptor of a BPF_MAP_TYPE_RINGBUF map.
+ * @param opts Options, can be NULL.
+ * @return A ringbuffer object on success; NULL and errno set on error.
+ */
+LIBBPF_API struct ring *ring__new(int map_fd, const struct ring_opts *opts);
+
+/**
+ * @brief **ring__free()** frees a ringbuffer object created with
+ * **ring__new()**. Rings returned by **ring_buffer__ring()** are freed by
+ * **ring_buffer__free()** and must not be passed to this function.
+ *
+ * @param r A ringbuffer object, can be NULL.
+ */
+LIBBPF_API void ring__free(struct ring *r);
+
 /**
  * @brief **ring__consumer_pos()** returns the current consumer position in the
  * given ringbuffer.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a953f123138..16e15f79af54 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -479,7 +479,9 @@ LIBBPF_1.9.0 {
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
+		ring__free;
 		ring__invalidated;
+		ring__new;
 		ring__next;
 		ring__release;
 		ring__rewind;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 90ed354118de..e794448dcb89 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -42,6 +42,8 @@ struct ring {
 	size_t page_size;
 	int map_fd;
 	bool overwrite;
+	/* created by ring__new(), not owned by a ring_buffer */
+	bool standalone;
 };
 
 struct ring_buffer {
@@ -204,6 +206,44 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	return libbpf_err(err);
 }
 
+struct ring *ring__new(int map_fd, const struct ring_opts *opts)
+{
+	struct ring *r;
+	int err;
+
+	if (!OPTS_VALID(opts, ring_opts))
+		return errno = EINVAL, NULL;
+
+	r = calloc(1, sizeof(*r));
+	if (!r)
+		return errno = ENOMEM, NULL;
+
+	r->page_size = getpagesize();
+	r->standalone = true;
+
+	err = ringbuf_map_ring(r, map_fd);
+	if (err) {
+		ringbuf_free_ring(r);
+		return errno = -err, NULL;
+	}
+
+	return r;
+}
+
+void ring__free(struct ring *r)
+{
+	if (!r)
+		return;
+
+	if (!r->standalone) {
+		pr_warn("ringbuf: ring__free() called for a ring owned by ring_buffer, map fd=%d\n",
+			r->map_fd);
+		return;
+	}
+
+	ringbuf_free_ring(r);
+}
+
 void ring_buffer__free(struct ring_buffer *rb)
 {
 	int i;
-- 
2.53.1-Meta

