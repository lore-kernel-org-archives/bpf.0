Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35C1A6800
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781402753; cv=none; b=B0sZQQQhugYXVkoID1az0hxFSVjcvSUaAaeG/LnCB2hvCk0BZrlKB6KilSJm/vr+TIMk628nbEZZleqBJMaqv6levRpqzt/BgIgdKVLWUsO7ALK6jGusEa/LSxlm/Mo+3AsrGrNJXA0f1OroCgG9U72pilQ2AMtDzkfWWPQwtl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781402753; c=relaxed/simple;
	bh=BJ9CoV2JTgdvKvoHGH6ODr+5FX0AMc2b2w5JaFHv4Ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nuKV1LOzhPT2WQ18Kp939jvwJ2rAicQPil//3sdG6jwjbbldrxBaFPHQxg/KvFh06E1HYr7Y4Vh3x1hI8XG3OOOSppBPzd++eGn2C13m7yAYfbj1iIG3v19gDU4tPfzRdat8Zhgn9/0Rf0r0dBRsH8e6MFJ8uqwVtV2Kpeox6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6XBT5dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6XBT5dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A11F000E9;
	Sun, 14 Jun 2026 02:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781402752;
	bh=/b1Fo36fNirwrY4t2vAd3yBCCYknWOaNKOVh84iT+t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6XBT5dgQNpuqaWPEo1j+VMej9pIViBIReLKsNk0KCCQw4TuYvRGUMrho/1z2oNiy
	 0/eM7AwX1Pme71xiebsXYZQc3dADct0KnqfUTjwhE0Rz07jFE26vT872E2Z17ySCmW
	 9o62a+sFagmPyVGIzJdtgVVf7lIs1YisjM5c96StLYyYQ5UgDVhtG0wqvhdKUILhXH
	 aw2yiLXgKVXKrJrpDSmRMtDas8G/FTD6CAR/G61h53B0Mw90yaFghnf/TZJwzdbBUy
	 0lnysL8CzxSa4TB3sv5u7zcORiln+WwWohCJg7dyDfmtZo6+vGvdRHh5+DymGgquHs
	 Uxn8SjJQzgnOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tamir Duberstein" <tamird@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 02:05:51 +0000
Message-Id: <20260614020552.022A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__bpf_ringbuf_reserve` in the kernel permanently fails allocation=
s after 32-bit position wrap-around.
- [High] Kernel-side `__bpf_user_ringbuf_peek` incorrectly handles 32-bit w=
rap-around, leading to permanent stalls and bypassing bounds checks.
- [High] 32-bit userspace running on a 64-bit kernel permanently breaks BPF=
 ring buffers after 4GB of data is processed due to pointer size mismatches.
--

commit ce5e8d811804f9ff598195a7f394512f77c373b0
Author: Tamir Duberstein <tamird@kernel.org>

libbpf: ringbuf: Handle position counter wrap

Ring buffer positions are unsigned long counters and can wrap on 32-bit
systems. ringbuf_process_ring() stops consuming when producer_pos wraps
below consumer_pos because it compares the counters by magnitude.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index ae7fa79b62170..b7adce37b5196 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -268,7 +268,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	do {
>  		got_new_data =3D false;
>  		prod_pos =3D smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +		while (cons_pos !=3D prod_pos) {
>  			len_ptr =3D r->data + (cons_pos & r->mask);
>  			len =3D smp_load_acquire(len_ptr);
>=20

[Severity: High]
This is a pre-existing issue, but does this fix fully resolve the behavior
for 32-bit userspace applications running on 64-bit kernels?

Looking further down in ringbuf_process_ring(), userspace updates the
consumer position:

    __atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_RELEASE);

On a 32-bit architecture, this writes 4 bytes. However, the 64-bit kernel
defines consumer_pos as an 8-byte unsigned long. When the 32-bit userspace
counter wraps at 4GB, it writes 0 to the lower 4 bytes while leaving the
upper 4 bytes unchanged.

Could this cause the kernel's bpf_ringbuf_has_space() to perceive an
instant drop in the consumer position, making it evaluate the ring buffer
as permanently full?

[Severity: High]
This is a pre-existing issue, but does the kernel side have a similar
wrap-around issue in __bpf_ringbuf_reserve()?

kernel/bpf/ringbuf.c:__bpf_ringbuf_reserve() {
    ...
    while (pend_pos < prod_pos) {
        ...
    }
    ...
}

Since pend_pos and prod_pos are unsigned longs, on 32-bit kernels, does
this magnitude comparison fail when producer_pos wraps around to a small
value? It appears pend_pos would freeze at its pre-wrap value, causing
bpf_ringbuf_has_space() to permanently return false and deny future
allocations.

[Severity: High]
This is also a pre-existing issue, but does __bpf_user_ringbuf_peek() have
a related wrap-around bug on 32-bit systems?

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
    u64 cons_pos, prod_pos;
    ...
    prod_pos =3D smp_load_acquire(&rb->producer_pos);
    ...
    cons_pos =3D smp_load_acquire(&rb->consumer_pos);
    if (cons_pos >=3D prod_pos)
        ...
}

Because rb->producer_pos and rb->consumer_pos are 32-bit unsigned longs on
32-bit systems, are they zero-extended to 64-bit u64 variables? If
producer_pos wraps around while consumer_pos is still large, does the
64-bit promotion cause the magnitude comparison to evaluate to true,
permanently stalling consumption by returning -ENODATA?

Additionally, would the 64-bit subtraction (prod_pos - cons_pos) yield a
massive value that defeats the bounds check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-bpf-ringbu=
f-fixes-v1-0-e623481cb724@kernel.org?part=3D3
