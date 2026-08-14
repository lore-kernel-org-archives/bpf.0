Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3446AA9F
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712736; cv=none; b=BUrwt8npIyQLtkgxPTyGw8CYH3O+0BjYP8ztNjKVIWPcocDeV9GSz7Qf5zgn4RBgo21f05ijq6aCq7pAy+VUL9H5U5teiFe15dAVUL48OOviFH1MoaHmY5aRpYtGLn9/p/mG1VuvD84R1XfVDoQ+cwnwpB8eQ1biojzj9GDmojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712736; c=relaxed/simple;
	bh=Uz4HtXb2a8b1gPEl331bg368qMeFYsLV1Zdksf32Nb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5keJXBRZexoY3CnJ1DISd9zpfA9qtI4RRQn8KWLGn8FnI8befFuHNpydaRABvJVdFF3/C4pwzI8xOBcH+fy0K26PCS1b5CFNwaMZ27bPPEC5LEuk0RkqoGmCwiPNAhVzAVIFL9t84KZHt/QtNVQ/g91qGcXbf7xT6JEmPFIBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7zWVQvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7zWVQvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE021F000E9;
	Fri, 14 Aug 2026 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712732;
	bh=etpIePCFgqjx+V+xCLzQ+1Q/vXJCIp2NJm/P4iEsJR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q7zWVQvpZvvbYOVHyd8Y5LSq5aO4FFtHI3xxhfZzMofgylaIoPCKN9ZEmWSm+Drck
	 fj0I6oHpr2vq+FSZXb6SmJrLqJXGxVT+e1iKVxe8tAUaMki3kvYJvnxx9bezd13BWd
	 9WUuBF2+dRsKYRelEXx27MY7PWXPZrS76Vug8WlhXS6se+1X/YtV/N6L+/bq+ey1Wg
	 8q3Lvf9RgYpWZdrT5eFKjMB/O6NrONUqEN61jFBY8wR8fWsg33eo8XEbi3aST/rc80
	 GfbBiyZ9QsJem+perb4ld7V9MPmkurT9qtkqfNmld1D0sEhb2ViH+VqsvO0cTJp5U5
	 scJLs53xIVyHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 1/4] bpf: Fix pending_pos walk on 32-bit ring
 position wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogR2FyY8OtYQ==?= <i.tellez@btesa.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814124843.22041-2-i.tellez@btesa.com>
References: <20260814124843.22041-1-i.tellez@btesa.com>
 <20260814124843.22041-2-i.tellez@btesa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:05:32 +0000
Message-Id: <20260814130532.ABE021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing wrap-around handling in BPF_MAP_TYPE_USER_RINGBUF kernel c=
onsumer
- [High] Missing wrap-around handling in libbpf ringbuffer consumer
- [Medium] Incorrect wrap-around handling and memory barrier usage in `ring=
buf_avail_data_sz`
--

--- Patch [1]: [PATCH v2 bpf 1/4] bpf: Fix pending_pos walk on 32-bit ring =
position wrap ---
commit 3d10b943efa00590ce8d5db29b823f30ea00dbbf
Author: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>

bpf: Fix pending_pos walk on 32-bit ring position wrap

The reservation path caches the position of the oldest not-yet-committed
record in rb->pending_pos and advances it past already committed records
on every reservation. Consumer, producer, and pending positions are 32-bit =
on
32-bit architectures and can wrap around, which causes an ordered comparison
to incorrectly stall reservations permanently. This patch changes the
ordered comparison to an unsigned difference, which stays correct across the
wrap-around.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade36b8..06d3cc192601f 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>  	prod_pos =3D rb->producer_pos;
>  	new_prod_pos =3D prod_pos + len;
> =20
> -	while (pend_pos < prod_pos) {
> +	while (prod_pos - pend_pos > 0) {

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
32-bit wrap around issues, does this code in __bpf_user_ringbuf_peek() also
have the same problem?

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
    ...
    cons_pos =3D smp_load_acquire(&rb->consumer_pos);
    if (cons_pos >=3D prod_pos)
        return -ENODATA;
    ...
    if (total_len > prod_pos - cons_pos)
        return -EINVAL;
    ...
}

Because cons_pos and prod_pos are read from 32-bit unsigned longs into 64-b=
it
u64 variables, will the implicit zero-extension cause cons_pos >=3D prod_pos
to incorrectly evaluate to true when prod_pos wraps around 4GB?

Also, wouldn't the subtraction total_len > prod_pos - cons_pos underflow to=
 a
massive positive value on 32-bit architecture wrap-around, bypassing the si=
ze
check?


[Severity: Medium]
This is a pre-existing issue, but is the wrap-around handling in
ringbuf_avail_data_sz() also affected?

kernel/bpf/ringbuf.c:ringbuf_avail_data_sz() {
    ...
    if (unlikely(rb->overwrite_mode)) {
        over_pos =3D smp_load_acquire(&rb->overwrite_pos);
        prod_pos =3D smp_load_acquire(&rb->producer_pos);
        return prod_pos - max(cons_pos, over_pos);
    }
    ...
}

Could the max() macro unsafely select the logically older cons_pos over
over_pos during a 32-bit wrap-around, because max() uses an ordered compari=
son
rather than modular arithmetic?

Additionally, is it safe to read overwrite_pos before producer_pos here,
or does this break the acquire-release pairing and allow reading a stale
overwrite_pos relative to producer_pos?


[Severity: High]
This is a pre-existing issue, but does the libbpf consumer loop have a simi=
lar
wrap-around problem on 32-bit architectures?

tools/lib/bpf/ringbuf.c:ringbuf_process_ring() {
    ...
    cons_pos =3D smp_load_acquire(r->consumer_pos);
    do {
        got_new_data =3D false;
        prod_pos =3D smp_load_acquire(r->producer_pos);
        while (cons_pos < prod_pos) {
    ...
}

If producer_pos wraps around the 32-bit boundary and becomes smaller than
consumer_pos, will the ordered loop condition cons_pos < prod_pos become fa=
lse
and permanently stall the libbpf consumer?

>  		hdr =3D (void *)rb->data + (pend_pos & rb->mask);
>  		hdr_len =3D READ_ONCE(hdr->len);
>  		if (hdr_len & BPF_RINGBUF_BUSY_BIT)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814124843.2204=
1-1-i.tellez@btesa.com?part=3D1
