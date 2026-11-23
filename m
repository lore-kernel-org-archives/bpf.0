Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468438;
	b=XmBqgO4gD/pQkzJ2SVw9iEiuBgaMOEt4hTE0yIZ+DQ1b8ft9vFhCatghzn336TahmXhn
	 DQ2ABAkfo8+C6ZkQJTQlxLYRUueJ4rjhAmYaUszYrt8LpXZaxwzZp6H59ai9IY7deYdh/
	 SliaOd2+Qbapm7b7oXMEuGFkl4k8P+0Wq+Mnl76wypnTZ3WHUk1VuppDXh51E2mZGm49t
	 SA3c9O5IvfkEJyhPCiSry/xOqiaZCYIyVnBu1DLnM4+wvBMhSQ00fNur8l3e+aP7rYL2r
	 ZdLiLQ9bf3ILTXpdCRqfpRxTAXoLrJXZ4WwCHBBAQtFfxZeTbG/QS+YAI95jMxLs1Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=0mYGpcNNM8B5ivu8Dyd+gTLYJUTe2chmwxpsGvAhekQ=;
	b=XbmyU3ymDk3pe1pUawg5Ol/nzJLWVt6oAGtAEBus+1dupkdNZPogf3jO3lnO/7RhDeGc
	 oNc+X7fgr95kQxVE7CXK3e66DWApSZNaly9gyyTUqZtEjEstTfyA/55REnvbh8wIFPhhE
	 2rPQBjTojtghOJJ7UF3xa5XGl319a/YrJBHmOtO8HjPaFqOAg73D+mqjQimHJ0Qbn2VaP
	 EazoCt5XlHvD8Qzo6u5Doj2yhpgPCplG44qEiPgQwRNxV3X6jGAlbyjD1mlOTz1TQJfjY
	 MXi9WTY35/LiH4gdvgw7BZ1AY7cJ6imO/FgwY96HZPSBCFm88DdgHni3f5llj1wd2Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iObL9rqj;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C888F606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C888F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iObL9rqj
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8629eb92bebso1476091a34.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468437; x=1796073237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mYGpcNNM8B5ivu8Dyd+gTLYJUTe2chmwxpsGvAhekQ=;
        b=iObL9rqjCAkDq46kjfG47he6RHSSO236ieQ5gLFCifD+zQ03HY3Up2JNji9hGrMR9i
         UIStWwH3RUNbbY2ee5O2CqYCFho/mrdKE6dyE3VV8lyXG9HIonDkUfOWiSOVzhyfcO8R
         5pyOyechz2O4WP0CJCzRSAKWtO4h3zg+umpwjwSSDo93PbNOXTqUUiXaYK+JqlOWO6fg
         SdbOXY1JSjnRL0dnJev9RLyKI3XtzjeIPEjMV7IzfRQsV97WBp8kwMmMmaaLfU992dKc
         1XPC4Sd9rBQnjIwZvPTfCItJj4jDNSGFYwok+o9wazIpTvj1jEYugr560d5s1NxMj6H2
         oCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468437; x=1796073237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0mYGpcNNM8B5ivu8Dyd+gTLYJUTe2chmwxpsGvAhekQ=;
        b=YbsAHu12W7hsSeO9qhaKXUVAueDY99JBDkumyCtHyljqu6+ldge6A3fMHdllu4O8IF
         705uowzG82+gi0wNneNnMp9JvERTEILPBgusmpxwjVQAwFx2BZCmbKYaPh7FKL/GNFdW
         rCOes4RgVoums6ODiPxq6JrEH/KRrFhEIAVsYdzBz5fpi+K3y+oqAQx2rtBxPMGke6hI
         urOJsQMZxrDM7QUQ8ja6cLzJ2x8PwdqT1uVrVdgcLU3sU8eVMB55/4FGfbPVJIT53knu
         uo0n7Hm/RkWZJuYi4vqvJBZZLGbUrUMjlt2TddL63Tt8ey41z3t3pU6jFXh5n1lDsIE/
         COAA==
X-Gm-Message-State: APuU4Z9gEpTFrXa3MsrH0P2xIp9n7kn3rHjRspv9VYibG0OoIhDTTxsc
	HbKN51LOcrdbjRyFB/LIZSPW2fpZJRfKOzi5G2hF3GuMCxhDLeqyFqfRZnD8zd6lhAM=
X-Gm-Gg: AZFdTZd8IHg/RNBAN7pZt9cYZlrzc/pCp4XOcU5hsENVeEWvBV9UKuFGIvLsiqptxPy
	l67Gl21iyPK3LVxGub8v4c8KEGxp9J496GlE4QRhDAmbTVtgqIOznc/hSByUhv9SDAkqCgDqTE1
	B+WZXGjXQp2rVQ2uUqJeiy3EsaYaMDmvEbbyVfuVA5BfkCWHq4CR6/88gDyiAx8ec9HZksrJXu9
	u5kT2bAmFs7Jh1jC/IpW+05LesKBE6e+EQua7g4D62l8u/ozeCsNng0T7IRvhm9DZZ2/jnTNXQw
	kl0XljSpJNKdQUt+MoTLBwCk3o+bLmFnurz+HM3yT7Y3Q+LBkm0ZvmeqFlcWKXk4Zt+Qcig/z1W
	MXkL5b/w8w/hm3s5WtPHmCKYTqRMQMqvf3F5+ctz6zcQu6iEBifOKqR8d8de5MFGDERDnBy64HA
	osqyzagzQ/uYTYnsgLMzYE8UwX8xwgdK+klzUNTqHSZdmfSS5p24XCqJ1D6tMrWhRNG9FJo+qzz
	PVJfLZiMF/YqYD/+b8CEB/OG7xzmrKXp8wv4L9oJCb30TSEyRsVGwZAaQd5D86CzQGal8PSJPby
	WWMMu+mC6aXaq+ak6Hcr7dMXC+Rjt2m/B/Kq9W+YXWj3gOdd6MnkG3dXX1NvSFtZyK39t08CqSR
	DNtzovsOgYRiiIoqYp+WVxXJLQViWDgaRqwD4
X-Received: by 2002:a05:6830:4424:b0:862:ae69:12b5 with SMTP id 46e09a7af769-86315aa555emr13410188a34.26.1795468436680;
        Mon, 23 Nov 2026 13:13:56 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6da9sm9606278a34.15.2026.11.23.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/10] libbpf: Add ring_buffer__wait()
Date: Mon, 23 Nov 2026 22:13:29 +0100
Message-ID: <9261f4f36695c31ab7be111d83cf60f5d4f524b1.1795467315.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; h=from:subject:message-id; bh=3ZKuAIz+x24cY4kqHoJ36hJzOg28s6eln6MxPGPWvOA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhcmuqNaH3e/TL8ilvN98IORGvvUtDo56eWeu205zlhZF mkh3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJrpjP8L1j4I6WpTWj7va9KVupmxz pa7s2+9KTz3vNf1tsyf51eJMPI8ESX223L8hvrVJ7kBag6FvT/v5qn+Mk25tbavboli2LCGQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

ring_buffer__poll() waits for data and then consumes it through the sample
callbacks, so it fails when a ring has no callback. Rings that are
consumed with ring__next() don't have one, so the only way to wait for
them is epoll_wait() on ring_buffer__epoll_fd().

Add ring_buffer__wait(), which only does the epoll_wait() and returns the
number of rings that have data. It works for rings with and without
callbacks: the caller consumes the data afterwards, with ring__consume()
or ring__next() on each ring.

	rb = ring_buffer__new(map_fd, NULL, NULL, NULL);
	r = ring_buffer__ring(rb, 0);

	while (ring_buffer__wait(rb, -1) >= 0) {
		do {
			while ((rec = ring__next(r)))
				handle(rec->data, rec->len);
		} while (ring__release(r) > 0);
	}

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.h   | 15 +++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 12 ++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index efd796603fa3..91d25bed5a04 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1560,6 +1560,21 @@ LIBBPF_API void ring_buffer__free(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
+
+/**
+ * @brief **ring_buffer__wait()** waits until at least one of the rings has
+ * data, without consuming it.
+ *
+ * Unlike **ring_buffer__poll()** it doesn't call sample callbacks, so it also
+ * works for rings that are consumed with **ring__next()**.
+ *
+ * @param rb A ringbuffer manager object.
+ * @param timeout_ms Maximum time to wait in milliseconds, 0 to not wait at
+ * all, -1 to wait indefinitely.
+ * @return The number of rings that have data, 0 if the timeout expired, or a
+ * negative error code on failure.
+ */
+LIBBPF_API int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e373257d32fe..943f6f3f0639 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -482,4 +482,5 @@ LIBBPF_1.9.0 {
 		ring__next;
 		ring__release;
 		ring__rewind;
+		ring_buffer__wait;
 } LIBBPF_1.8.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 822557b7149b..12d586afed1d 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -412,6 +412,18 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 	return res;
 }
 
+/* Wait for data in the ring(s) without consuming it */
+int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms)
+{
+	int cnt;
+
+	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
+	if (cnt < 0)
+		return libbpf_err(-errno);
+
+	return cnt;
+}
+
 /* Get an fd that can be used to sleep until data is available in the ring(s) */
 int ring_buffer__epoll_fd(const struct ring_buffer *rb)
 {
-- 
2.53.1-Meta

