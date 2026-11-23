Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469309;
	b=16qlN1ZnEweQrfgNxtJzxnR0aetNDxjciPbnGGzWWdjMo0e5Ev3/tAniGkahhE3yNVU0
	 qqLvDq3YeQUivmQXmgoyuyf4fOPGH09qsq7NRQoisPVeBuNx3CZVChfjTWahxWydqkQfE
	 H+1FPjLZOXBg00mYqlRFzVyO5ZMDlp7mCRqMUpcS3v/35DRf6GZsxUDMTf6oRID4XCswO
	 0dkFkthByAljzZi5uSiKoP3zsryt0mFEB2TnPqilEIJOYgaVnMx6M8W3UbIvKIu5QHsaQ
	 SemXGDZV6jaEuspVgtk3eleu4OI8DI7pQMXsZ7/H04cLUIxe9D/YN9UrkBmJLKhFZWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0HT6xoigilQl4nxh76XDvII1KxBquEAEUflGScVzCo0=;
	b=0Jt1+2bDI6VPQOcBNKZM7MViNGFnoO2Fh7vbM/M89Fl4qtBunrlz+SDiM8wHSAsmusGp
	 fMIOTEL3UvFR2QoHPmjZQc2ufblwbxnViszfS0eEpEiyhxgI6MoKDCYJ2/QhFNfQqrR68
	 QAK7Ii33986koLlhwEaiG4kyRuQ/oyCfH9EIrbLXgrxO1pg9NRXmpvqA/P8Wg5IfhCw9O
	 JgsnbNj7hlp4GGnMfhCu68M9GhP4QH31lBCvABvN558u31utVhQRxBu2acG+l7JUj9skA
	 8Hv+R6/WS4Syt2tPWOduGdd0Ph9RxEQEICX946nAmODued3YiRsFE9LVVUIJNWK2dZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8IUNhaC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4C606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8IUNhaC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCAB1F000C4;
	Mon, 23 Nov 2026 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469309;
	bh=0HT6xoigilQl4nxh76XDvII1KxBquEAEUflGScVzCo0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=X8IUNhaCWFfkad4JxkrHe2IJoHElQbFCEcV9sHZrGQ4K76dg9GIsnCft7xYuegRus
	 hGrlLo5g/UH8lSMRyr/35S550F4DF+WaCUsaqzR7Y/BxZMAtaqRB26P1vocx8Q+nkI
	 P5WBD74N6GjKu2JHQ0AnJBouWQKDv34CQ5lqa/o1LsHdzyArJHPluhoNM5Icfn+KWC
	 4lcsw+HAGEBbd/m7S5gk+sEW7qPIQtFFRl56Dd5Aa9s//UV6bhcgPTIGYetRSe9HX9
	 0ESD7LsdIHLxw8XnClky1W50SdPqmXtEiQBL3VLUgFT9iTbTI370KmEY1XC/mpL+UU
	 i6wPZHG6j3JmA==
Message-ID: <sashiko-outbox-230084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 07/10] libbpf: Support overwritable ring
 buffers in the record API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <8115836d8bcbb9d59e2a350f9fb999f5ab497348.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <8115836d8bcbb9d59e2a350f9fb999f5ab497348.1795467315.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:28:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] libbpf: silent loss of valid records via batch_pos in
  ring__invalidated()
--

commit d2233d2ea9e5d957fed51c54cbd2073eb0c4fc69
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

libbpf: Support overwritable ring buffers in the record API

This commit adds support for overwritable BPF ring buffers
(BPF_F_RB_OVERWRITE) to the libbpf record API and introduces
ring__invalidated() to detect whether records returned since the last
release or rewind were overwritten.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 12d586afed1dd..b4e9e27951eb8 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c

[ ... ]

> @@ -497,11 +500,72 @@ static int ringbuf_validate_rec_api(const struct ri=
ng *r)
>  {
>  	if (unlikely(r->sample_cb))
>  		return -EINVAL;
> -	if (unlikely(r->overwrite))
> +	/* 32-bit: no overwrite_pos, and positions wrap after 4 GiB of records =
*/
> +	if (unlikely(r->overwrite && !r->overwrite_pos))
>  		return -EOPNOTSUPP;
>  	return 0;
>  }
> =20
> +/*
> + * Overwrite mode: check that whatever was read at pos, and at later pos=
itions,
> + * was not overwritten while we were reading it. The producer can overwr=
ite pos
> + * once it is a ring size ahead of pos.
> + */
> +static bool ringbuf_pos_valid(const struct ring *r, unsigned long pos, u=
nsigned long *prod_pos)
> +{
> +	/* pairs with smp_wmb() after the producer_pos update in the kernel */
> +	smp_rmb();
> +	*prod_pos =3D smp_load_acquire(r->producer_pos);
> +	return *prod_pos - pos <=3D r->mask;
> +}
> +
> +/* ring__next() for overwritable ring buffers */
> +static const struct ring_rec *ringbuf_overwrite_next(struct ring *r)
> +{
> +	unsigned long pos =3D r->next_pos, prod_pos;
> +	__u32 *len_ptr, len;
> +
> +	prod_pos =3D smp_load_acquire(r->producer_pos);
> +	for (;;) {
> +		if (prod_pos - pos > r->mask) {
> +			/*
> +			 * The producer lapped us, continue from the oldest record.
> +			 * overwrite_pos is never ahead of a producer_pos that is
> +			 * loaded after it.
> +			 */
> +			pos =3D smp_load_acquire(r->overwrite_pos);
> +			prod_pos =3D smp_load_acquire(r->producer_pos);
> +			continue;
> +		}
> +		r->next_pos =3D pos;
> +		if (pos =3D=3D prod_pos)
> +			return NULL;
> +
> +		len_ptr =3D r->data + (pos & r->mask);
> +		len =3D smp_load_acquire(len_ptr);
> +		/* if the producer lapped us, this is not a record header */
> +		if (!ringbuf_pos_valid(r, pos, &prod_pos))
> +			continue;
> +		/* record is not committed yet */
> +		if (len & BPF_RINGBUF_BUSY_BIT)
> +			return NULL;
> +
> +		r->next_pos =3D pos + roundup_len(len);
> +		if (len & BPF_RINGBUF_DISCARD_BIT) {
> +			pos =3D r->next_pos;
> +			continue;
> +		}
> +		if (!r->has_batch) {
> +			r->batch_pos =3D pos;
> +			r->has_batch =3D true;
> +		}
> +		r->rec.data =3D (void *)len_ptr + BPF_RINGBUF_HDR_SZ;
> +		r->rec.pos =3D pos;
> +		r->rec.len =3D len;
> +		return &r->rec;
> +	}
> +}

[ ... ]

> @@ -540,9 +607,20 @@ const struct ring_rec *ring__next(struct ring *r)
>  	}
>  }
> =20
> +bool ring__invalidated(const struct ring *r)
> +{
> +	unsigned long prod_pos;
> +
> +	if (!r->has_batch)
> +		return false;
> +
> +	/* records are overwritten in order, so it is enough to check the first=
 one */
> +	return !ringbuf_pos_valid(r, r->batch_pos, &prod_pos);
> +}
> +
>  int ring__release(struct ring *r)
>  {
> -	unsigned long pos =3D r->next_pos;
> +	unsigned long pos =3D r->next_pos, prod_pos;
>  	__u32 len;
>  	int err;
> =20
>  	err =3D ringbuf_validate_rec_api(r);
>  	if (err)
>  		return libbpf_err(err);
> =20
> +	r->has_batch =3D false;
>  	smp_store_release(r->consumer_pos, pos);

[Severity: Medium]
Can checking r->batch_pos in ring__invalidated() cause the documented
consumption loop to drop valid records that were never overwritten?

In the per-record loop:

	do {
		while ((rec =3D ring__next(r))) {
			memcpy(copy, rec->data, rec->len);
			if (ring__invalidated(r))
				break;
			handle(copy, rec->len);
		}
	} while (ring__release(r) > 0);

r->batch_pos is only set on the first record returned after
ring__release() or ring__rewind(), while r->next_pos advances past every
record returned by ring__next().

If the inner loop processes record A at r->batch_pos and then reads a
later record B, the producer can overwrite record A without reaching
record B.  ring__invalidated() still checks r->batch_pos, so it returns
true for record B even though B's data copy is valid.  The caller then
breaks out of the inner loop without handling B, and ring__release()
advances r->consumer_pos to r->next_pos (past B), permanently skipping
record B.

Similarly, if the producer laps pos on a later iteration of the same
batch (when r->has_batch is already true), ringbuf_overwrite_next() jumps
to r->overwrite_pos, advances r->next_pos past the oldest valid record
there, and returns it with r->batch_pos still pointing to the lapped start
of the batch.  ring__invalidated() is then guaranteed to return true, so
ring__release() drops that record too (and in the ring__rewind() dump
pattern, jumping to r->overwrite_pos mid-batch keeps returning records for
a batch that is already invalidated).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795467315.gi=
t.memxor@gmail.com?part=3D7
