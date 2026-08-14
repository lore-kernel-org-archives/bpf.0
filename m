Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180D471257
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712661; cv=none; b=qeyO7/+20WQH+bNnl3ZBNMEGUGDcjDc4gnBN40ZQ00nCL7mJDSD3Rc6DJIWiVG8ruMmrOm6m5fFmi+WDjCYQCtcHANNMNmLJ1TloCHoreGVJEfwYaPlmfrJO02xpp/dxUmPLxNbpTDgNaUabbwzFWZJ6LzjFDWUB6hxvEUK4DOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712661; c=relaxed/simple;
	bh=LWPR+OTrEzgUC6s02QlV454g+oxy698CRadn8sokUSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GgZouat7qcBgUBZTlbognfPu1kIxSVIahh40DDAF4l6n1TgNLP1go04aisI+1D2SEWvmkKXtac1jnGi6LBx3i0BOq9qUjRYTX/YutS+ewKCeqH9ybeOsGP2gVCKtSsnHMEZxWk+E398ouyPffpPBwGauoWIdRtKaYb5I3RwNzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6ZZpuFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6ZZpuFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62981F000E9;
	Fri, 14 Aug 2026 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712657;
	bh=//6ElENCfJELCxZ0ssFCfjlfDmGDQ0i4gVj1OipaPNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6ZZpuFmmPrQl76J6qWIiWqRnB/5Me0CIKAHxYaeq74QvKFmy3KFiJLimKLY3nATy
	 qtGxkOvn+uMekeac8c6sihkRsoNW4T3P6faxXOm8yb1C6mGwId8BCF4T/sS7ZILbsu
	 YkwcDafyriggsN4v8QRIqCOFwPbRMNmW/YtGco4VaDNa1o9VhFuA0pK+fqud9uRzzX
	 uz9YnlQlqzSE1TRIFXe/dUp7aorzRC6/BJkPdMenlGBDyzyS0fADyl3x4CCWOyQyoK
	 78oxfWTqB3gOtbIVwRsHm/sVaoHM9CHh3+OZknS7DoUiUa0nBYCiPWwUfyS5hC4eqt
	 E2Hk0f1QXUOgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 2/4] bpf: Fix available-data accounting on 32-bit
 wrap in overwrite mode
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogR2FyY8OtYQ==?= <i.tellez@btesa.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814124843.22041-3-i.tellez@btesa.com>
References: <20260814124843.22041-1-i.tellez@btesa.com>
 <20260814124843.22041-3-i.tellez@btesa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:04:16 +0000
Message-Id: <20260814130416.E62981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit wrap-around bug in `__bpf_user_ringbuf_peek` deadlocks the =
user ringbuf.
--

--- Patch [2]: [PATCH v2 bpf 2/4] bpf: Fix available-data accounting on 32-=
bit wrap in overwrite mode ---
commit def0b55b3ee1635d80af8891542c5b83a8fe238e
Author: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>

bpf: Fix available-data accounting on 32-bit wrap in overwrite mode

In overwrite mode ringbuf_avail_data_sz() picks the newer of the consumer
and overwrite positions before measuring how much data is available. This
commit fixes a 32-bit wrap issue by comparing distances rather than
positions.

> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 06d3cc192601f..0fefa89039beb 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -321,7 +321,7 @@ static unsigned long ringbuf_avail_data_sz(struct bpf=
_ringbuf *rb)
>  	if (unlikely(rb->overwrite_mode)) {
>  		over_pos =3D smp_load_acquire(&rb->overwrite_pos);
>  		prod_pos =3D smp_load_acquire(&rb->producer_pos);
> -		return prod_pos - max(cons_pos, over_pos);
> +		return min(prod_pos - cons_pos, prod_pos - over_pos);
>  	} else {
>  		prod_pos =3D smp_load_acquire(&rb->producer_pos);
>  		return prod_pos - cons_pos;

[Severity: High]
This is a pre-existing issue, but does a similar 32-bit wrap-around bug
exist in __bpf_user_ringbuf_peek() within the same file?

Looking at __bpf_user_ringbuf_peek(), it loads the 32-bit producer and
consumer positions into u64 variables:

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
    ...
    u64 cons_pos, prod_pos;
    ...
    prod_pos =3D smp_load_acquire(&rb->producer_pos);
    ...
    cons_pos =3D smp_load_acquire(&rb->consumer_pos);
    if (cons_pos >=3D prod_pos)
        return -ENODATA;
    ...
    if (total_len > prod_pos - cons_pos)
        return -EINVAL;
    ...
}

Because these are zero-extended into u64 on 32-bit architectures, does the
ordering comparison (cons_pos >=3D prod_pos) evaluate to true when the 32-b=
it
producer_pos wraps around to 0 (e.g., 0xFFFFFFF8 >=3D 0x00000008)?

If so, would this cause __bpf_user_ringbuf_peek() to incorrectly return
-ENODATA, failing to advance cons_pos and permanently deadlocking the user
ringbuffer once more than 4GB of data is pushed?

Additionally, does the u64 zero-extension break the modulo arithmetic in the
distance calculation (prod_pos - cons_pos)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814124843.2204=
1-1-i.tellez@btesa.com?part=3D2
