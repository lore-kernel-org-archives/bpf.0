Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542274;
	b=GuW/IvZArIObalAvP86RRpM85O10fO5OrCEz+zsM8hAjHoyEeRBwTYxWjFHYtGrup6rA
	 5ZatCWHQpuqvsITPQ/ulz6Vl2wEnNRAq1xafINstFSxhWk5CKY1KOTXYsTpVq/WITWLz4
	 o8SpPZqC2xwCzX4CILWN3ZzuDLBstIKv904xnTqoIPTQIHAHSQIttiQADC3WqhzPunbml
	 pe7UTrnYKj+KZPxsrL7AKEV4FwY63GckFqCb49yejZq7evYVrUhvMumFlyEE/Rtwi6tTN
	 buCl3KFsp6++dYS14K8dSO5spZerlzSIr2c716pl7S3x7FrfsUCdRJMLEnKLvtEPVIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542274;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jIWTKBtad8pm/t4KfjYp6lvDjUxujVg6L4G90asRx48=;
	b=RI+kdfBLfvIQ6ySqh5u4H6u3m7LeQHjkrqKzpqx3mwXbf39PgjfwcSwMESM9dW3a5xgJ
	 UJzQ7LMvynrnYktlvsCdcMhsWxIcLSmc1vqqjvjlI0WB+Q2TdZVJdGRchS//XGxwC8C7g
	 7xb16i75iOyRznfyUAhESKIycGCLBibKeGrqmjjEJklE2XRgIcqaSjfrMal+APAiRQLHv
	 +H2+HtXKGIBf2sGC/WrTMo1AuxGX1SOcWiRktky7AsLrOWBslUU66eZJGWeOrgdpjEWma
	 Cfb2GW2SGCCsysVkzXSaeUrVRHzP0a06sJIodHYRkjDB/O4UuOrJsjS1BuzAAOx+Ikw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEdfaURv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1C606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEdfaURv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C921F000D8;
	Tue, 24 Nov 2026 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542274;
	bh=jIWTKBtad8pm/t4KfjYp6lvDjUxujVg6L4G90asRx48=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BEdfaURvX3nvcOEDzDpmW21aH4f4VQz/owSlFgKYToMwetOV9dW3KpeUrLUDYybjJ
	 FFc+tC+4vRwFeBpxiRwzNIXo8nK8pw/eQBzAgJaQ8+MHbfJQZpWHYSbwtNx2z38q2f
	 TWEMSivKAp/6Iyi6p6eVekVySfKdNZrDf31j23Sm4wv+pQvQ8Djj1uKz6UqprpyVDp
	 hBxhiub8mEeU8THKfgcqKAoAUIZo9KXfQypqILPtamt6ZwOKW1qUv0yFFfPRK+9kUS
	 whV8PGU2liqn9hZTEWaCBsf9OPtLgmAq5fUn5ixyS3Tytx6fws1p/VPVft1dY93FmK
	 f5As7yDBcXB0g==
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
Subject: Re: [PATCH bpf-next v1 06/10] libbpf: Add ring_buffer__wait()
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <9261f4f36695c31ab7be111d83cf60f5d4f524b1.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <9261f4f36695c31ab7be111d83cf60f5d4f524b1.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.16213139773460709658.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=tamird@kernel.org;
 h=from:subject:message-id; bh=xCDwOgTGt8aQeZXTDTaMfy2bqyekE5Fkc5JxLG2q8EI=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz5bWrDyTL2uWu1oyrf4zu/nuwtOxRTe37XAc9fmX
 TOVdy2165jIwiDGxWAppsiSKHpob3rq7T2yme+Ow8xhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6BjrGDFycAjDVDLIM/wvftRmX3TKW/Phgnf+R54w7+1YIXuo4yb/4wZ5nP12Eq+cw/BWuMT7
 0gUfIaO+NXyLxN1768UYtCzE7/qg21NzEOOatBCsA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

> ring_buffer__poll() waits for data and then consumes it through the sample
> callbacks, so it fails when a ring has no callback. Rings that are
> consumed with ring__next() don't have one, so the only way to wait for
> them is epoll_wait() on ring_buffer__epoll_fd().
> 
> Add ring_buffer__wait(), which only does the epoll_wait() and returns the
> number of rings that have data. It works for rings with and without
> callbacks: the caller consumes the data afterwards, with ring__consume()
> or ring__next() on each ring.
> 
> 	rb = ring_buffer__new(map_fd, NULL, NULL, NULL);
> 	r = ring_buffer__ring(rb, 0);
> 
> 	while (ring_buffer__wait(rb, -1) >= 0) {
> 		do {
> 			while ((rec = ring__next(r)))
> 				handle(rec->data, rec->len);
> 		} while (ring__release(r) > 0);
> 	}
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h   | 15 +++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  | 12 ++++++++++++
>  3 files changed, 28 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index efd796603fa3..91d25bed5a04 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1560,6 +1560,21 @@ LIBBPF_API void ring_buffer__free(struct ring_buffer *rb);
>  LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>  				ring_buffer_sample_fn sample_cb, void *ctx);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> +
> +/**
> + * @brief **ring_buffer__wait()** waits until at least one of the rings has
> + * data, without consuming it.
> + *
> + * Unlike **ring_buffer__poll()** it doesn't call sample callbacks, so it also
> + * works for rings that are consumed with **ring__next()**.
> + *
> + * @param rb A ringbuffer manager object.
> + * @param timeout_ms Maximum time to wait in milliseconds, 0 to not wait at
> + * all, -1 to wait indefinitely.
> + * @return The number of rings that have data, 0 if the timeout expired, or a
> + * negative error code on failure.
> + */
> +LIBBPF_API int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
>  LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index e373257d32fe..943f6f3f0639 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -482,4 +482,5 @@ LIBBPF_1.9.0 {
>  		ring__next;
>  		ring__release;
>  		ring__rewind;
> +		ring_buffer__wait;
>  } LIBBPF_1.8.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 822557b7149b..12d586afed1d 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -412,6 +412,18 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
>  	return res;
>  }
>  
> +/* Wait for data in the ring(s) without consuming it */
> +int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms)
> +{
> +	int cnt;
> +
> +	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
> +	if (cnt < 0)
> +		return libbpf_err(-errno);
> +
> +	return cnt;
> +}

Could this share code with ring_buffer__poll?

-- 
Tamir Duberstein <tamird@kernel.org>
