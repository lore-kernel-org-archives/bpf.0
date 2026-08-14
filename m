Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C246EF74
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712470; cv=none; b=I4nfPZJzx+pfcFf3pQZl9a1TXH9oLDGkHkmFLO1pYM9YAIIS4JV39NIFoCpHQ9QjefY1XK0QSlDeLDA0JHK9BxdbXr+i9pZ5H075PH2FQ7C+mgUo4aou47k4JaOqW335FFpe/4GLI/v0PGGEZ3Jog2JoqgAXZbKeb+nTJepMnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712470; c=relaxed/simple;
	bh=gdXlvR3pW5tv3LPqH7j/copUZEw0fVZVSMfPWKpYHX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5nzvOhnk+iea/61Gb1CqUK6kpHh+CZzSEHrZm3LBY/pP0CiYlWsjpBsJtnCY9RHz3ywQKve3lBmOFjxSVnBzKika1GEFTSlaINd3TRQGR59e9qjzVCvGpijlERVwK8sSuljEqHOoGTT9Uk+6eIA/DgGH8I1bzeY9gW0vb2ZY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpMJv+U4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpMJv+U4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC8D1F000E9;
	Fri, 14 Aug 2026 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712465;
	bh=oDlG6Tc3S34A0ITyvrlPEP8bMw/EUC2zaRtdCQ7o4L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpMJv+U4DoZqGMKgnwGzK69H+fcRQQXfWM08eZIs8ZSnrnkaFmzSOScnP9psQeW8P
	 ejDxXnQVCng7erdYvcAeG6qnYRqg1erIwsH84HNJIL9zkkSS7iTMBXINfd+10KyCAr
	 LijGxTYte//85jsIP+DMd0+x7/XRWnvym6ke4uTR9nqLTRfiTN58cRYmHuqCXGuoPQ
	 cx5X8+uwq8XLSIcHZ5323vMmsY06+h9+H/WvKVlCq5U9U/IpnTFS7Uuk/hNEYuutTb
	 7EtrySuMudQpVrgdbB+7suRXt9zaFgESUyilrvc5KFiIr/LIhOOcgG08vCdhe6tmqD
	 SRK+JFppO4Ttg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_pos
 in ringbuf_avail_data_sz()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogR2FyY8OtYQ==?= <i.tellez@btesa.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814124843.22041-4-i.tellez@btesa.com>
References: <20260814124843.22041-1-i.tellez@btesa.com>
 <20260814124843.22041-4-i.tellez@btesa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:01:04 +0000
Message-Id: <20260814130105.0AC8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Swapping the load order of producer_pos and overwrite_pos introduc=
es a TOCTOU race that causes an integer underflow in `prod_pos - over_pos`,=
 resulting in a massively overstated available data size.
--

--- Patch [3]: [PATCH v2 bpf 3/4] bpf: Read producer_pos before overwrite_p=
os in ringbuf_avail_data_sz() ---
commit efaae45af0e3891c65188df6e4677342c6fb0c41
Author: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>

bpf: Read producer_pos before overwrite_pos in ringbuf_avail_data_sz()

This commit changes the order in which producer_pos and overwrite_pos are
read in ringbuf_avail_data_sz() to match the documented memory ordering
contract. It swaps the reads so that the acquire load of producer_pos
orders the subsequent load of overwrite_pos.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 0fefa89039beb..89a9c15a260f3 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -319,8 +319,14 @@ static unsigned long ringbuf_avail_data_sz(struct bp=
f_ringbuf *rb)
>  	cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> =20
>  	if (unlikely(rb->overwrite_mode)) {
> -		over_pos =3D smp_load_acquire(&rb->overwrite_pos);
> +		/*
> +		 * Read producer_pos first: its release store in
> +		 * __bpf_ringbuf_reserve() is what publishes the matching
> +		 * overwrite_pos.
> +		 */
>  		prod_pos =3D smp_load_acquire(&rb->producer_pos);
> +		/* Ordered after the acquire load above, per that contract. */
> +		over_pos =3D smp_load_acquire(&rb->overwrite_pos);
>  		return min(prod_pos - cons_pos, prod_pos - over_pos);

[Severity: High]
Does this sequence allow an integer underflow in prod_pos - over_pos?

If the reader is preempted after reading prod_pos, and a concurrent producer
advances overwrite_pos beyond the stale prod_pos snapshot:

Reader:
    prod_pos =3D smp_load_acquire(&rb->producer_pos);
    <preempted>

Producer:
    // advances overwrite_pos beyond the snapshotted prod_pos
    rb->overwrite_pos =3D ...;
    smp_store_release(&rb->producer_pos, ...);

Reader resumes:
    over_pos =3D smp_load_acquire(&rb->overwrite_pos);
    return min(prod_pos - cons_pos, prod_pos - over_pos);

Could over_pos now be greater than prod_pos, causing the subtraction to
underflow to a massive unsigned value near ULONG_MAX?

This would result in min() returning prod_pos - cons_pos, which could be
extremely large and break EPOLLOUT for user-space producers by returning
incorrectly large available data sizes.

>  	} else {
>  		prod_pos =3D smp_load_acquire(&rb->producer_pos);
>  		return prod_pos - cons_pos;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814124843.2204=
1-1-i.tellez@btesa.com?part=3D3
