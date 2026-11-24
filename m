Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542272;
	b=XRE0qMUzeslAAJD5YlOtOrJb0uUCbPpy3qpS451OyCVssOYe++aJXRYd4ecgy6dJ2ZkU
	 R9Slsfym0Ls2RYexsjbo7U7aIi/dw+c8jF0PzZP9okNhEQT7i/zsiciouFKJxl/fY0P+Z
	 gr1dLNEAD6KoW45zPuUQiDTad3tYcrC1bDkCyv1wIvLLwhjPneXmN+PlX0keoZceO5wCt
	 dv25OHd3rZasVfe8tHOdwdFzerumQf5Qg3avFafD2cJwYOHKjiN91lQDepc9s0LwNzwG6
	 pGJWdbkYsPO48NB0cbsaoI2DEfv/PiiKfbSoD0vUBZBSabtTKaWF2YrpLosgt1MZz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542272;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=i8DvNPcu9rA59v84m/g3osoBZWAEEKYuwWBEUijmmBo=;
	b=OwizuqrpIMZAhrrI1WQ2UD5+pZB8NyXVGmr2RPWSXmt2mglwSp5Ji2qvihxYenfwZXeC
	 h2JobL+9Bs1PiwoJGTsBqHmgnBQhQQgb6NZZSyGNulZABTwukoeFiOGdmHrziMJGYpcrH
	 JeXNSrnmeIiR6Z0aic+ZaNJnQ7z81nWxIiuD2fhnNRm+xuC6Wwz8ErfB7QeUNtWgtCjm+
	 +CNsTMRq2IOnQLgdJ9jWkfS5ah1EJyqqTUd2wX7i3aLpB/MXIHTocFyBVHOakdWAqGc6r
	 sXJ9Zqw39NDiYldQy/AjHN6xiYssxEicQ7P7dqM0GvIq4/p/rl4taLIMr2WrA7xlnmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ6XunLZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA6606A32D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJ6XunLZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147C31F000C6;
	Tue, 24 Nov 2026 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542272;
	bh=i8DvNPcu9rA59v84m/g3osoBZWAEEKYuwWBEUijmmBo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=UJ6XunLZvzHml+H33MpOqVWevzIIXJmhFWtTOTUCZHY1Es7SumRtuphwc++QyLUXo
	 ALsGSAHotX7MlvLL8RNH7demOoM2j0SYHfObnvj8L5sMWepy2XIR0b+ugztyPgX4wd
	 NfVqT9hCyEhNIVWJybmcwDN+CxwVjBKhkeRwuwubZoZWaI4UVd/6uP3yDaucoOviYB
	 8soy90es2HBxUz5FfSW4XCvRIvAL3d7WPIGzp6xr6pivXH+6bh4sYTvfyFn5IpLlgM
	 FsZIlgVFPxD4Z//igY1qIk3gpQKHUZGAo3x3grFRjpwDR3yNAnIx1+DqRHbjb6Tjwz
	 I1OuV4O2q4Z0g==
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
Subject: Re: [PATCH bpf-next v1 05/10] libbpf: Add a record API for
 consuming BPF ring buffers
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <5a8c1d9b7fda04e57e15ac897d65fa95c569b55c.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <5a8c1d9b7fda04e57e15ac897d65fa95c569b55c.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.13720111569923407751.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10933; i=tamird@kernel.org;
 h=from:subject:message-id; bh=OYmoNnHDUcmz5cxJMN1YHh8YplvR5mhMzCIBYYiF4+k=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz5Hcod/41x5dZYrn3zuX/fKB3EPlv6f2ZnnfeXFq
 R9za0WEOiayMIhxMViKKbIkih7am556e49s5rvjMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOgY4xAxenAEx10nuG/+lbZ9ZLa++S/ydS5asTq8Set/Oy0C6ZY0yz7A3jBJ3DfRkZvs7cpZc
 bOfeKu8vDn/9S/7/rd3SZztFr+ztsp6/y2i/RnAA=
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

> Ring buffer records can only be consumed through a sample callback, e.g.
> from ring_buffer__poll() or ring__consume(). Add an API that returns the
> records to the caller one by one instead:
> 
>   const struct ring_rec *ring__next(struct ring *r);
>   int ring__release(struct ring *r);
>   void ring__rewind(struct ring *r);
> 
> ring__next() returns the next record without consuming it, or NULL if
> there is nothing to consume. errno is set on any error. ring__release()
> consumes all records returned since the last release or rewind.
> ring__rewind() goes back to the first record that was not released, so
> that ring__next() returns the same records again.
> 
> 	const struct ring_rec *rec;
> 
> 	do {
> 		while ((rec = ring__next(r)))
> 			handle(rec->data, rec->len);
> 	} while (ring__release(r) > 0);
> 	/* wait for data, e.g. epoll on ring__map_fd(r) */
> 
> Records stay valid until they are released, so the caller can process a
> number of them and update the consumer position once.
> 
> ring__next() invalidates and reuses the previous struct ring_rec, so if
> the caller needs to access multiple records they need to copy them
> separately. The struct is embedded in struct ring and followed by two
> unsigned longs that are always zero. If a later libbpf adds fields to it,
> an application built against that libbpf.h reads them as zero when it
> runs with this libbpf.
> 
> ring__release() returns 1 if there are more records to consume. The kernel
> wakes up the consumer only if a record is committed right at the consumer
> position, so records committed before the release don't cause a wakeup
> and the caller has to call ring__next() again instead of waiting. To not
> miss such a record, ring__release() needs a full barrier between updating
> the consumer position and checking for the record.
> 
> The new functions can only be used on a ring that has no callback, i.e.
> NULL was passed as sample_cb to ring_buffer__new() or ring_buffer__add().
> On a ring that has a callback, ring__next() and ring__release() fail with
> EINVAL and ring__rewind() does nothing, just like the callback-based
> functions already fail on a ring without one.
> 
> The position of the next record is cached in struct ring and not read from
> the consumer page, so as before only one consumer can use a ring buffer.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h   | 63 ++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.map |  3 ++
>  tools/lib/bpf/ringbuf.c  | 93 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 157 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 49f1120f4021..efd796603fa3 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1541,7 +1541,10 @@ struct ring_buffer;
>  struct ring;
>  struct user_ring_buffer;
>  
> -/* Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps. */
> +/*
> + * Callback-based consumption is unsupported for BPF_F_RB_OVERWRITE maps.
> + * The callback can be NULL for rings that are consumed with ring__next().
> + */
>  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
>  
>  struct ring_buffer_opts {
> @@ -1643,6 +1646,64 @@ LIBBPF_API int ring__consume(struct ring *r);
>   */
>  LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
>  
> +/*
> + * Record API: get records one by one with ring__next() instead of having them
> + * passed to a sample callback. It can only be used on rings that don't have a
> + * sample callback.
> + */
> +
> +/**
> + * struct ring_rec describes a record returned by **ring__next()**.
> + */
> +struct ring_rec {
> +	const void *data;	/* record data */
> +	unsigned long pos;	/* position of the record in the ring buffer */

What is the motivation for this field?

> +	__u32 len;		/* size of record data in bytes */
> +};
> +
> +/**
> + * @brief **ring__next()** returns the next record in the ring buffer without
> + * consuming it.
> + *
> + * Record data stays valid until **ring__release()** is called, so multiple
> + * records can be processed and then consumed together:
> + *
> + *	do {
> + *		while ((rec = ring__next(r)))
> + *			handle(rec->data, rec->len);
> + *	} while (ring__release(r) > 0);
> + *
> + * Each call invalidates and reuses the previous struct ring_rec, so copy it if
> + * it is needed later.
> + *
> + * @param r A ringbuffer object.
> + * @return The next record, or NULL if there is nothing to consume. errno is
> + * set on any error.
> + */
> +LIBBPF_API const struct ring_rec *ring__next(struct ring *r);
> +
> +/**
> + * @brief **ring__release()** consumes all records returned by **ring__next()**
> + * since the last **ring__release()** or **ring__rewind()**.
> + *
> + * Call it before waiting for new data. If it returns 1, call **ring__next()**
> + * again instead of waiting, as there may be no wakeup for records that were
> + * committed before the release.

Is it customary to use such prescriptive language? IMO this should
describe what this does in a way that makes it clear to the reader when
it should be called. The downside of being prescriptive is that it may
imply that this is the _only_ circumstance in which this should be
called, which is not correct.

> + *
> + * @param r A ringbuffer object.
> + * @return 1 if **ring__next()** has to be called again, 0 if the caller can

What does "has to be called again" mean here? Can we rewrite this to say
what the return means rather than what to do?

> + * wait for new data, or a negative error code on failure.
> + */
> +LIBBPF_API int ring__release(struct ring *r);
> +
> +/**
> + * @brief **ring__rewind()** goes back to the first record that was not
> + * released, so that **ring__next()** returns the same records again.
> + *
> + * @param r A ringbuffer object.
> + */
> +LIBBPF_API void ring__rewind(struct ring *r);

Could you expand the CL or the commit message to explain why this design
was chosen, rather than an explicit iterator object? With an explicit
iterator this function disappears, but questions like what it means to
have multiple iterators in scope arise.

Do we expect to introduce other iterators in libbpf? Will they follow
this pattern?

> +
>  struct user_ring_buffer_opts {
>  	size_t sz; /* size of this struct, for forward/backward compatibility */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index a45666f546fa..e373257d32fe 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -479,4 +479,7 @@ LIBBPF_1.9.0 {
>  		bpf_program__load;
>  		bpf_program__load_strategy;
>  		bpf_program__set_load_strategy;
> +		ring__next;
> +		ring__release;
> +		ring__rewind;
>  } LIBBPF_1.8.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 271c6b9b130d..822557b7149b 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -30,6 +30,12 @@ struct ring {
>  	unsigned long *producer_pos;
>  	unsigned long *overwrite_pos;
>  	unsigned long mask;
> +	/* ring__next() state: position of the next record and cached producer_pos */
> +	unsigned long next_pos;
> +	unsigned long prod_pos;
> +	struct ring_rec rec;
> +	/* always zero, in case struct ring_rec needs new fields */
> +	unsigned long rec_reserved[2];
>  	int map_fd;
>  	bool overwrite;
>  };
> @@ -158,6 +164,8 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>  	 */
>  	if (r->overwrite && sizeof(unsigned long) == sizeof(__u64))
>  		r->overwrite_pos = r->producer_pos + 2;
> +	r->next_pos = smp_load_acquire(r->consumer_pos);
> +	r->prod_pos = r->next_pos;
>  
>  	e = &rb->events[rb->ring_cnt];
>  	memset(e, 0, sizeof(*e));
> @@ -420,7 +428,7 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
>  
>  unsigned long ring__consumer_pos(const struct ring *r)
>  {
> -	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
> +	/* Synchronizes with smp_store_release() in ringbuf_process_ring() and ring__release(). */
>  	return smp_load_acquire(r->consumer_pos);
>  }
>  
> @@ -472,6 +480,89 @@ int ring__consume(struct ring *r)
>  	return ring__consume_n(r, INT_MAX);
>  }
>  
> +/* ring__next() and friends can't be mixed with callbacks on the same ring */
> +static int ringbuf_validate_rec_api(const struct ring *r)
> +{
> +	if (unlikely(r->sample_cb))
> +		return -EINVAL;
> +	if (unlikely(r->overwrite))
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +const struct ring_rec *ring__next(struct ring *r)
> +{
> +	unsigned long pos, prod_pos;
> +	__u32 *len_ptr, len, rec_sz;
> +	int err;
> +
> +	err = ringbuf_validate_rec_api(r);
> +	if (err)
> +		return libbpf_err_ptr(err);
> +
> +	pos = r->next_pos;
> +	prod_pos = r->prod_pos;
> +	for (;;) {
> +		if (pos == prod_pos) {
> +			prod_pos = smp_load_acquire(r->producer_pos);
> +			if (pos == prod_pos)
> +				return NULL;
> +		}
> +
> +		len_ptr = r->data + (pos & r->mask);
> +		len = smp_load_acquire(len_ptr);
> +		/* record is not committed yet */
> +		if (len & BPF_RINGBUF_BUSY_BIT)
> +			return NULL;
> +
> +		rec_sz = roundup_len(len);
> +		r->next_pos = pos + rec_sz;
> +		r->prod_pos = prod_pos;
> +		if (!(len & BPF_RINGBUF_DISCARD_BIT)) {
> +			r->rec.data = (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
> +			r->rec.pos = pos;
> +			r->rec.len = len;
> +			return &r->rec;
> +		}
> +		pos += rec_sz;
> +	}
> +}

Could callback consumption share the traversal core with the record API,
while preserving per-record publication and existing callback semantics?
That would also give the wakeup fix one common implementation.

> +
> +int ring__release(struct ring *r)
> +{
> +	unsigned long pos = r->next_pos;
> +	__u32 len;
> +	int err;
> +
> +	err = ringbuf_validate_rec_api(r);
> +	if (err)
> +		return libbpf_err(err);
> +
> +	smp_store_release(r->consumer_pos, pos);
> +	/*
> +	 * bpf_ringbuf_commit() clears the busy bit of a record and then checks
> +	 * consumer_pos to see if it has to wake us up. We update consumer_pos
> +	 * and then check the record, so without a full barrier in between both
> +	 * sides can miss each other's update.
> +	 */
> +	smp_mb();
> +
> +	r->prod_pos = smp_load_acquire(r->producer_pos);
> +	if (pos == r->prod_pos)
> +		return 0;
> +	len = smp_load_acquire((__u32 *)(r->data + (pos & r->mask)));
> +	/* we get a wakeup when a busy record is committed */
> +	return !(len & BPF_RINGBUF_BUSY_BIT);
> +}
> +
> +void ring__rewind(struct ring *r)
> +{
> +	if (ringbuf_validate_rec_api(r))
> +		return;

nit: this check is probably not necessary; this function is harmless.

-- 
Tamir Duberstein <tamird@kernel.org>
