Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468963;
	b=qesdLgP0Y+yIE2mx34X/VH+VTMt/Xc16GS0vsbtA0jP03VQ90auVwfuDkCFCyXvyRuNP
	 gwlUvBu8fMJoRTcIA/xA0xtYQvD2jzeT/qtmgBpqVPZ710+2cJZ5/SV4aQwGUfTm5kAuU
	 xrAGn6GJ1ZQB/joM1IA6dJwTc5omK7qKv2VEsyZWGS9LQoN9N2hi/5xZgFdmadywfvrcB
	 kY91V2AIFemZOiBbzFt9IORtVwKQOBWKBIjSj1S+qUJxuTDYzDlGxf9NpODVbccnpmXkR
	 +Vj/4BNiHPx/LpqCF/8BCD6XFjpdkAW7Vb0qQk2UvwDeu3pIy0uaVYKbmZcKt6QYNuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cl6ZRJYYY5DrHVCI1v0iBpmYluA8BQTtkA9btDJNYTY=;
	b=InUuyxp6PhGc25lBK5d5lCJr9IVidXWezVuvcaBzSM4yTcWNNAXINWaI53TOumArVpPO
	 N4OrYh/Ug14mnp9uUx3TWg/W7vb2OdktHLT4AMLQn5oQvHnbu+Hb51cbcU49zg9jGuzTE
	 smxCYmOEnRsyLcXUtKPmnpp1y4DlqVB6G8zQXFu+6aspsSu289bZZUtIG3a0tXMhCtVJA
	 FRPc+Y7PGhTgv7PJVzDWR8FZUkwFqTtf8heh7lkS3CAoTWFv1w+yzCa0RtxgqCq5Pwm7/
	 4LNK75DRc8did4cegMvmsPwtp3zon5ZMMbXRYi+XXJbJPAM2bC7GOfZFgyJOdzZuauQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aBnofvC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE5606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBnofvC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DB51F000C6;
	Mon, 23 Nov 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468963;
	bh=cl6ZRJYYY5DrHVCI1v0iBpmYluA8BQTtkA9btDJNYTY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aBnofvC/urIPP7ExlFSSHy/M2ItrJLPryThhuvPwfu5PbxuNGnG4rh5Yo4g/Qy5Bl
	 rnyIOYpBWIhE6nYiUIvhh3Sjl8jnxmjzi9/Mnu50kLNwA6Kvlylxqaod6jiXuWEwxR
	 VQOj3spxe3UJCp2EKHAcZUfybNDE791hOLkbgvmvn17XDmoR7p1jGNbCxSmnh6v64+
	 b+ASqjw/ScYMWKkcR2DOq9YHPM1hrydcFrNBgd1pcRd4yw73sxofzjz6SwzXwzG/IB
	 aXRWaK1XpA8v06i0HTugjyWXZ7QuNTh9LTcpLxCWVdN8yH5bYsNhVe143wqcc75myv
	 AXEq4bFh+CL2g==
Message-ID: <sashiko-outbox-230081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 04/10] libbpf: Account for the overwrite
 position in ring__avail_data_size()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <853ef5deb34f53b2007ab47699c889b730d87805.1795467315.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:22:42 +0000
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
- [Medium] libbpf: load ordering race and underflow in
  ring__avail_data_size()
--

commit 2b238949efda4fe4f9b112e9f915c9221770464d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

libbpf: Account for the overwrite position in ring__avail_data_size()

This commit updates ring__avail_data_size() in 64-bit libbpf to read
overwrite_pos from the producer page on overwrite-mode ring buffers and
cap the available data size at producer_pos - overwrite_pos.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 78fcb3df243f9..271c6b9b130de 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
[ ... ]
> @@ -426,11 +434,16 @@ unsigned long ring__producer_pos(const struct ring =
*r)
> =20
>  size_t ring__avail_data_size(const struct ring *r)
>  {
> -	unsigned long cons_pos, prod_pos;
> +	unsigned long cons_pos, prod_pos, over_pos;
> =20
>  	cons_pos =3D ring__consumer_pos(r);
>  	prod_pos =3D ring__producer_pos(r);
> -	return prod_pos - cons_pos;
> +	if (!r->overwrite_pos)
> +		return prod_pos - cons_pos;
> +
> +	/* records before overwrite_pos are gone */
> +	over_pos =3D smp_load_acquire(r->overwrite_pos);
> +	return min(prod_pos - cons_pos, prod_pos - over_pos);
>  }

[Severity: Medium]
Can prod_pos - over_pos underflow when producer_pos is loaded before
overwrite_pos?

CPU0 (userspace consumer)         CPU1 (BPF producer)
ring__avail_data_size()
  prod_pos =3D ring__producer_pos(r)
                                  __bpf_ringbuf_reserve()
                                    /* advances rb->overwrite_pos
                                     * and rb->producer_pos
                                     */
  over_pos =3D smp_load_acquire(r->overwrite_pos)
  prod_pos - over_pos             <-- underflows if over_pos > prod_pos

When multiple reservations advance overwrite_pos past the stale prod_pos
snapshot, prod_pos - over_pos wraps around unsigned long, causing min()
to fall back to prod_pos - cons_pos and include already overwritten
records.  If a single reservation advances overwrite_pos up to the
sampled prod_pos, ring__avail_data_size() returns 0 for a full buffer.

In the kernel, ringbuf_avail_data_sz() loads overwrite_pos before
producer_pos so that prod_pos is at least as recent as over_pos:

kernel/bpf/ringbuf.c:ringbuf_avail_data_sz() {
    ...
	if (unlikely(rb->overwrite_mode)) {
		over_pos =3D smp_load_acquire(&rb->overwrite_pos);
		prod_pos =3D smp_load_acquire(&rb->producer_pos);
		return min(prod_pos - cons_pos, prod_pos - over_pos);
	}
    ...
}

Loading r->overwrite_pos with smp_load_acquire() before calling
ring__producer_pos(r) avoids the underflow.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795467315.gi=
t.memxor@gmail.com?part=3D4
