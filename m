Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3B38645E
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022438; cv=none; b=rbozkLbP5UT23j4rImasAUBPlreLhGgkhzcBIykcFsaFHrq2RrXwy4RNtwf39e4xlWQtP9D6vewzGo+sny5KKCtQB9LEq8QegBDTmOc1JL0xAraXvpaQ1WiIXkSjJCES/RpnY5aqDCT3YjmYwg9XENOOy6fASZtL1orkdUYK3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022438; c=relaxed/simple;
	bh=NjX9g7Xv4i49SIVxWyWyXkT0cPc65HwD2Huu0GFL6mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPI1SXAthFkCxRf5vtafHs/Dyl7O5w3t09CW9QwRA4BadRVOueDY5H2zIsMsJ6JHQH3Ya1kbyt1wXjvzgoFpmoHZXwOX7/+yiKCGQRUdbBAnOZHihAVUk/AtJU4cmuKI4IWbhKHsVYod7k699bSlzM45WkCYuJf2fkKAGm5zeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4wFjxTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4wFjxTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A671F000E9;
	Thu,  6 Aug 2026 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022432;
	bh=UEQlP+hqSlACXK9mtTw7rFFyEhqtECpeIzAnb6415Ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G4wFjxTgy35rF+kNkRVXLisClEYziUqPfyaFqA423vfAGQxoA3nAiizV2w2yiXWht
	 l3GvAlX4YSvZBNBMVF/HwOAfMU+Qd6gcQSP2qSIRFIPVJi8kqednqCkZ/xYMitMb0D
	 5a11uRLE+z5bHe2yAkAOnC1Ov5ea/91LOxnK8kB2er+JbiKmqYsC6R9Y5CIhdt0wuO
	 NcXjfpV1JWqoI9ZO74SHk1p+SepPwHdt9vFjcdXLbd5AZ9aY8EYSNvmDnk0mVw9n7y
	 uZJhdgZAwUViyKtdTzfHyqBudO7HOEi2pyT1lYgUL0bQlUFXI6RtLHJKLVU0YoZF1B
	 m5iZZvNZjaGCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix pending_pos walk on 32-bit ring position
 wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogR2FyY8OtYQ==?= <i.tellez@btesa.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806130214.66028-1-i.tellez@btesa.com>
References: <20260806130214.66028-1-i.tellez@btesa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:20:30 +0000
Message-Id: <20260806132032.B8A671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `ringbuf_avail_data_sz` incorrectly handles `overwrite_mode` on 32=
-bit architectures because `max(cons_pos, over_pos)` fails on wrapped seque=
nce numbers.
- [High] `__bpf_user_ringbuf_peek` permanently stalls on 32-bit architectur=
es (and for 32-bit userspace on 64-bit kernels) when the ringbuffer hits 4G=
B of traffic.
- [High] The user-space ringbuffer consumer loop in `libbpf` uses `cons_pos=
 < prod_pos`, which permanently hangs processing after 4GB of data on 32-bi=
t architectures.
- [Medium] `ringbuf_avail_data_sz()` loads `overwrite_pos` before `producer=
_pos`, violating the explicit memory barrier contract and risking reads of =
stale state.
--

--- Patch [1]: [PATCH bpf] bpf: Fix pending_pos walk on 32-bit ring positio=
n wrap ---
commit 617dac82211278dfe2a6441e138c7025d95f169b
Author: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>

bpf: Fix pending_pos walk on 32-bit ring position wrap

This patch fixes a 32-bit wrap-around bug in __bpf_ringbuf_reserve() by
changing an absolute ordering comparison to a signed difference. This ensur=
es
the pending position is correctly advanced even when the counters wrap past=
 4GB.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 35ae64ade36b8..2c08a98370d5e 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf=
 *rb, u64 size)
>  	prod_pos =3D rb->producer_pos;
>  	new_prod_pos =3D prod_pos + len;
> =20
> -	while (pend_pos < prod_pos) {
> +	while ((long)(prod_pos - pend_pos) > 0) {
>  		hdr =3D (void *)rb->data + (pend_pos & rb->mask);
>  		hdr_len =3D READ_ONCE(hdr->len);
>  		if (hdr_len & BPF_RINGBUF_BUSY_BIT)

While reviewing this fix for the 32-bit wrap-around in __bpf_ringbuf_reserv=
e(),
I noticed a few other similar pre-existing 32-bit wrap-around and concurren=
cy
issues in the ringbuf code.

This is a pre-existing issue, but there's a similar wrap issue in
ringbuf_avail_data_sz():

kernel/bpf/ringbuf.c:ringbuf_avail_data_sz() {
    ...
	if (unlikely(rb->overwrite_mode)) {
		over_pos =3D smp_load_acquire(&rb->overwrite_pos);
		prod_pos =3D smp_load_acquire(&rb->producer_pos);
		return prod_pos - max(cons_pos, over_pos);
    ...
}

[Severity: High]
Will this code incorrectly handle overwrite_mode on 32-bit architectures?

The max() macro performs an absolute comparison. If over_pos wraps while
cons_pos has not, max() will incorrectly select cons_pos.

This calculation then evaluates modularly to a value larger than the ring s=
ize,
returning an artificially inflated available data size that permanently sta=
rves
pollers.

[Severity: Medium]
Also in ringbuf_avail_data_sz(), could this load order violate the producer=
's
barrier semantics?

The producer updates overwrite_pos and then executes
smp_store_release(&rb->producer_pos, ...). The consumer must read producer_=
pos
with smp_load_acquire() first to guarantee it observes the new overwrite_po=
s.

By reading overwrite_pos first, a race window allows observing a stale, sma=
ller
overwrite_pos alongside the new producer_pos, throwing off the size calcula=
tion.

This isn't a bug introduced by this patch, but __bpf_user_ringbuf_peek() al=
so
permanently stalls on 32-bit architectures:

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
    ...
	u64 cons_pos, prod_pos;

	/* Synchronizes with smp_store_release() in user-space producer. */
	prod_pos =3D smp_load_acquire(&rb->producer_pos);
	if (prod_pos % 8)
		return -EINVAL;

	/* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_rele=
ase() */
	cons_pos =3D smp_load_acquire(&rb->consumer_pos);
	if (cons_pos >=3D prod_pos)
		return -ENODATA;
    ...
}

[Severity: High]
Can the zero-extension of 32-bit wrapping counters to 64-bit variables break
modular arithmetic here?

When producer_pos wraps past 4GB to a small value while consumer_pos is lar=
ge,
the condition evaluates as true (e.g., 4294967200ULL >=3D 10ULL).

The consumer stops, preventing consumer_pos from ever wrapping to recover,
which causes a permanent stall.

This is a pre-existing issue, but I found a similar wrap issue in the libbpf
user-space consumer:

tools/lib/bpf/ringbuf.c:ringbuf_process_ring() {
    ...
	unsigned long cons_pos, prod_pos;
    ...
		prod_pos =3D smp_load_acquire(r->producer_pos);
		while (cons_pos < prod_pos) {
			len_ptr =3D r->data + (cons_pos & r->mask);
    ...
}

[Severity: High]
Would this absolute comparison permanently hang event consumption after 4GB=
 of
data on 32-bit architectures?

When prod_pos wraps past 4GB, it becomes smaller than the non-wrapped cons_=
pos.

The absolute comparison fails, the loop terminates prematurely, and since no
data is consumed, cons_pos never wraps to recover.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806130214.6602=
8-1-i.tellez@btesa.com?part=3D1
