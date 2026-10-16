Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4D25783C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111624; cv=none; b=LLLefSKBS6z/zHML9unPv2woTboxmkk6dfZEcNkybYRLo4lxwP0AcZRJB6cmtafD6y0aiIVcmgpgBJkcNS2eA0g6BwGVWVKBovP1Mj1y7XJNbUcpn2UY+CrhVGrghRTzU8Stnfc63HJYGNKmPjqDbNIlDnxk4zR4ylS6XxETjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111624; c=relaxed/simple;
	bh=eFoMIt8q+0SiShrdvXJtL/EmruwzISM8p2ygXXuwTBM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=mEIP5dkYnd+q5PAVsz1C0IWQLQfByFfxskKGII8yPQ6RpPBPc0kyL6Vx8XAnIqLEysd184y79WSTIE0BNjyos8PQI0UZnIvMtBZJYf7/gGrksB58O/jhg0Es7+nPdHX/ZxppiyYDGCXKV0+PU7WbBwhbudO8iiTR9dQhgnNguxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD8iCkP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD8iCkP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E7E1F000C4;
	Fri, 16 Oct 2026 00:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111623;
	bh=piIWWUu4uIMNLSq9PYdzb+nUtjcq+9FkxHoU1dEnD/s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LD8iCkP3hcN6aHjc1Vhi/anSelRfmlwNXkibnRH5+1frtGwhR3/jsdJNm5O9NjaZm
	 CJHaMegc1UrRHKfagPtsmeWqC1gnADzgmsT3MRhtK08lrdfveanEEGFQQ+ybh9uPk5
	 rNohpgz6BqB/uw22FYJZ8oXjiRDI++wYLkfUzmMqIrq2kuZFcHTuDzjouRezXV6W7s
	 nx7N6Yhs3eQbTdU5E6HNdO3h0REWm6iYFF2opALvLP+SMmOM98skRBjkD9jRWKbggf
	 wFQr5Y2ZKR3eEuRAltdk8wPkZTcctbnJN5nL3/JHQZEXWBEWm9lBJoEj0SfnJQRJGQ
	 4Lv/q3AgMLXQA==
Message-ID: <sashiko-outbox-173535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Load ringbuf consumer_pos under the
 spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Malovitsa" <igor.malovitsa@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261016003318.529860-2-igor.malovitsa@gmail.com>
References: <20261016003318.529860-1-igor.malovitsa@gmail.com>
 <20261016003318.529860-2-igor.malovitsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:47:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: ABI compat break for 32-bit userspace on 64-bit ringbuffer
--

commit 2d8c0038759a4aa9aef622680e46c8ac2c7b7e99
Author: Igor Malovitsa <igor.malovitsa@gmail.com>

bpf: Load ringbuf consumer_pos under the spinlock

__bpf_ringbuf_reserve() loads consumer_pos before taking the spinlock.
Nothing bounds how stale that value is when the lock is finally taken.
This patch moves the load of consumer_pos inside the spinlock to ensure
it is exact.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 3f1013d805446..6b86c4db51088 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -473,11 +473,12 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringb=
uf *rb, u64 size)
>  	if (len > ringbuf_total_data_sz(rb))
>  		return NULL;
> =20
> -	cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> -
>  	if (raw_res_spin_lock_irqsave(&rb->spinlock, flags))
>  		return NULL;
> =20
> +	/* Under the lock, so at most one ring behind producer_pos. */
> +	cons_pos =3D smp_load_acquire(&rb->consumer_pos);

[Severity: High]
Does this code handle 32-bit userspace running on a 64-bit kernel correctly?

Since consumer_pos and producer_pos are defined as unsigned long in
struct bpf_ringbuf, they are 64-bit on a 64-bit kernel but treated as
32-bit by 32-bit userspace applications.

On little-endian architectures, 32-bit userspace updates only the lower
32 bits. When the userspace counter wraps after 4GB, it writes 0.

Since the kernel's 64-bit producer_pos will exceed 4GB, new_prod_pos -
cons_pos evaluates to a value greater than 4GB.

Because this value is larger than the ringbuffer mask, does this cause the
kernel to incorrectly believe the ringbuffer is permanently full?

Can an unprivileged 32-bit process trigger this state after 4GB of traffic,
causing a permanent DoS on the map?

> +
>  	pend_pos =3D rb->pending_pos;
>  	prod_pos =3D rb->producer_pos;
>  	new_prod_pos =3D prod_pos + len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016003318.5298=
60-1-igor.malovitsa@gmail.com?part=3D1
