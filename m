Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207144;
	b=YU6CuJbnyN3esNbb5UviuA6zcAf2JGfzUgJFEA0sayh9M7t3W9S3FnK5jhz0F7dmw+9x
	 lz6qZNTQyTUEbxRueK1IrvCs7YY71RUa5MlGsOP/H7VC9IsU3vcS7EqLX2QKvdTMUftwV
	 QO5Lsi/cjQhhvZYbxhA8UovKHDddGMmsMke5+KNxW47Mrg4eYRYHGQcTXJOJyfJ/wOMco
	 AyPyE/+nMZks5P5gIYO0X0HomVEmMhH05+rmIXrImBBlQs3K3cxoP9N4yhxPly1uFbh4B
	 jhoWQOGRmAeaOCAZCzXmRaZxAn8lXhluY7Iel1FaP/DdeRz3Y4ybs+4gMWg12D4nkXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207144;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 Received:MIME-Version:From:In-Reply-To:References:X-Google-Nh-Sender:
	 Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=yRTiBdWC1h1WQbI/9xFmaeaUt35QSNyIqlPc2Vvqj14=;
	b=jv2xkWXSMHDO/ppmxkbJ2+n69BBRbCocKkO3FXyyFhx18280XCnU7Lrsnklfk5Q2ECIi
	 mXeAsfRMAh6Z+eC7OpbqDq1UctNw+LVUYR31IlzGu958JlBCVbL6iEsuO0MC7OyFbdFTk
	 P6Uv4OiiscxfML1FP10gyoHgJJJlmgQXyobRm8auyjjHO/f+MxlNimAkBZTUPNnjKMdld
	 f4SnAYFoxzIs5GU7nlste9Tluz/8xyXJM8my8qai3Kh0xkeZ95ZfoDzKDWtBHLN5I1MYQ
	 DxAsM4kC1Iqi+WjnaXNQ89XXH2SU17ocPPG/41/AvEVnoyKgandLL1qOrIcdeRudasg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMAF6qCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0F606A6DC
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMAF6qCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782AC1F000C6
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207143;
	bh=yRTiBdWC1h1WQbI/9xFmaeaUt35QSNyIqlPc2Vvqj14=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=LMAF6qCV+1CprZ7pA27/VK9zHz5uNsD9ksgsesr9oOvmCq5vlZyTab2q0eF/2LVjZ
	 uSvPeqsutNbrnteTh0OxDgXWfuXPyCStuJ4OJoaKNJL12w3IsSVAobc7n+xtYpRZ1S
	 nyjqLFhzibPw7Jh+C8JeGY399lfYpMpAeBIJC3Vt1/MThzx3NAgl0MotkklguiXvzv
	 RMFvBRdCKlZt1rVjo8ynLW6cKHVMtHfZdw7ThA5qe3LOEoKHNiAoEvccqSVsDfkW3E
	 MwzZwsWs7haB7ghA4ax9TsEQTjzem7BPmILz0q3CUxwJ7oNNttElCPUw4gi1FJA0qM
	 5zZtb9M3wgyHA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3adef977ad9so10718941fa.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:39:03 -0800 (PST)
X-Gm-Message-State: APuU4Z9MCYMv4348FyAcVKA1cytPLDZA8TBnwn5BSw8dRj4P4MDwTMdg
	kESJR4HhOMZoqhLPxXJw2eyckgOk9zw7fZ7j7hH4PiAQ2dyKVSD+mIKbMTBhcGdqAc2Tqf9HRht
	YjMG9NxYM4o84VQLR8cwH6XjzNBgweUY=
X-Received: by 2002:a2e:be8d:0:b0:3ae:31eb:fd67 with SMTP id
 38308e7fff4ca-3ae7f9d94b3mr12988741fa.13.1795207142157; Fri, 20 Nov 2026
 12:39:02 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 20 Nov 2026 12:39:01 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: tamird@kernel.org
In-Reply-To: <20260614015716.945AF1F000E9@smtp.kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-5-e623481cb724@kernel.org> <20260614015716.945AF1F000E9@smtp.kernel.org>
X-Google-Nh-Sender: AW_J_UoH9GLFB9GnJcqEjZzmEuzbBxJJitxXBCTuXUlXyNZME-jzq03mt0y2cxJZ9TQADFzfEbTlI_2njnPWV3sHooP7m5aXbUT-LZe-aywUxsQhAIXqqqgSLH2c02zJbPeAR9AT0TqUZDycIRI7F2Bu6Q5bxq3g1STd5imZUSlhlsmVQFvloYDreKs91-AlACqF15NzTNjQCsikdsInvsAyhb5tfnlru19wZyXBC662e2FukOT3ycZgf2I-e8ARZnR7_Q1w0fe8kw
Date: Fri, 20 Nov 2026 12:39:01 -0800
X-Gmail-Original-Message-ID: <nh-959daab3-d706-4a6b-9efa-411c19f3fa35@google.com>
X-Gm-Features: Aa3M54qV3yIpFLMnD-xFbo7WTaCTfUGstD3v3eYifclS8EBTPOeNAGn7X54RWJA
Message-ID: <nh-959daab3-d706-4a6b-9efa-411c19f3fa35@google.com>
Subject: Re: [PATCH bpf 5/6] libbpf: ringbuf: Prevent missed wakeups
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Early returns in `ringbuf_process_ring()` bypass the newly added StoreLoa=
d memory barrier

Fixed in v3 by fencing before bounded and callback-error returns, and
after publication during early iterator destruction.

> [...]

> Multi-line comments introduced by the patch violate the BPF subsystem com=
ment style.

Fixed in v3.


On Sun, 14 Jun 2026 01:57:16 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Early returns in `ringbuf_process_ring()` bypass the newly added=
 StoreLoad memory barrier, leaving bounded consumers vulnerable to missed w=
akeups.
> - [Low] Multi-line comments introduced by the patch violate the BPF subsy=
stem comment style.
> --
>
> commit 1b4f252cfd5df3b60a00d140737f0f9bc3b4ad87
> Author: Tamir Duberstein <tamird@kernel.org>
> Subject: libbpf: ringbuf: Prevent missed wakeups
>
> This commit addresses missed wakeups in the BPF ring buffer by adding a f=
ull
> StoreLoad barrier before checking for new data. It ensures either the
> consumer observes the producer's update, or the producer observes the
> consumer's update and sends a notification. It also updates documentation
> and adds a selftest.
>
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 9ba6b9ad34983..a3b8f606a91d0 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1439,6 +1439,10 @@ struct ring_buffer;
> >  struct ring;
> >  struct user_ring_buffer;
> >
> > +/* A negative return stops consumption; non-negative values continue. =
Stopping
> > + * can leave records queued without a new readiness notification. Befo=
re
> > + * waiting for readiness again, consume until no records remain.
> > + */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the BPF subsyst=
em
> style? The guidelines prefer the opening /* to be on its own line.
>
> [ ... ]
>
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 1c24a83f59d5c..ea8909fec4e98 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> [ ... ]
> > @@ -267,14 +267,21 @@ static int64_t ringbuf_process_ring(struct ring *=
r, size_t n)
> >  	cons_pos =3D __atomic_load_n(r->consumer_pos, __ATOMIC_ACQUIRE);
> >  	do {
> >  		got_new_data =3D false;
> > +		if (needs_wakeup) {
> > +			/* Ensure either this sees a new record or its producer sees
> > +			 * the updated consumer position and sends a notification.
> > +			 */
>
> [Severity: Low]
> This isn't a bug, but should this multi-line comment have the opening /* =
on
> its own line to match the BPF subsystem comment style?
>
> > +			__atomic_thread_fence(__ATOMIC_SEQ_CST);
> > +			needs_wakeup =3D false;
> > +		}
> >  		prod_pos =3D __atomic_load_n(r->producer_pos, __ATOMIC_ACQUIRE);
> >  		while (cons_pos !=3D prod_pos) {
> [ ... ]
> > @@ -294,6 +301,7 @@ static int64_t ringbuf_process_ring(struct ring *r,=
 size_t n)
> >
> >  			__atomic_store_n(r->consumer_pos, cons_pos,
> >  					 __ATOMIC_RELEASE);
> > +			needs_wakeup =3D true;
> >
> >  			if (cnt >=3D n)
> >  				goto done;
>
> [Severity: High]
> If this loop terminates early by reaching the bound (cnt >=3D n) or due t=
o a
> negative callback return, consumer_pos is updated and the function return=
s,
> discarding the local needs_wakeup variable.
>
> When ring_buffer__consume() is called again to drain the remaining record=
s
> before sleeping, it will initialize needs_wakeup =3D false. This causes t=
he
> __ATOMIC_SEQ_CST fence to be skipped prior to loading producer_pos.
>
> Could this allow the CPU to delay the visibility of the consumer_pos stor=
e
> while reading a stale producer_pos, resulting in the consumer incorrectly
> sleeping and the concurrent producer skipping the wakeup notification?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-bpf-ring=
buf-fixes-v1-0-e623481cb724@kernel.org?part=3D5
