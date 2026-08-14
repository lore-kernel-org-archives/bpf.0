Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BC1EB1AA
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712840; cv=none; b=Ln1O3ehd2KEbIiWMPK0aIwqdo3fqraM+koTjxOgZuno9X/3u/8S9pxMAiUbzktrp8Lovp3bG82beVOlgzrXN9p0oVlwJrL7M6DHRwfMLGWCzNrDig9/79KLC3UsOZll3EUr/XOEYs2BVpJpUMnmCZpZRFgj5Y0IhJNUBiyNKSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712840; c=relaxed/simple;
	bh=Sglc8JROT2CCgynGe6ZyTxpezKjV20Su4u3VIbvsrms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sNOAYSUAaZXgxBgLE6Fjzn1bWoaO7GLRpjItJfj0vvii4S7NIvD6rou6sMAGuCS/2bOOgMqAelUQNSc/ixS7wsRiqQk6SDN5ifx3kp5mi0fw+u+AcYh17SWrfOs9Cwybhq4GI7yQOcv9/KZI4CLcquMMVDi5MTj9MiCIiVKFcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0L9FkCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0L9FkCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741801F000E9;
	Fri, 14 Aug 2026 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712838;
	bh=UFxlK64SwJRGzqAd1H0LOWpnoPphGlUaa/PcteyrV48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0L9FkCMsTs9k6I70G6JhC3ope3I03ZJfXz3trogefPKw2wdQ3Kn3QC/kWDrz4Jp+
	 LDnvZWZmE5XFVlFo7ADpELDkmE+LkjC8RS3v1eHPYTuPNe2qfUB/Ty+zK33IOK30Ae
	 /d7ZkPsJY+bWwsA361nMxctfpcspwkneIEons5Q1k0MPt1SBaD0f0bnbOIry76aUQ4
	 d6FRzrY17OGaGiRP9JnT5e3wsdxzvM+tD5BsNR+M5Si30xAx4SDXS87mVjRi9lI7pv
	 5xfykuBgJ3NbtHxCzIdWOwyhulNqivGH/7Ome34SvEcs8CU7Sqb6c8S9SV9DXLjter
	 NgR3+8LP9t10g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 4/4] libbpf: Fix ring buffer consumer loop on
 32-bit position wrap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXNyYWVsIFTDqWxsZXogR2FyY8OtYQ==?= <i.tellez@btesa.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814124843.22041-5-i.tellez@btesa.com>
References: <20260814124843.22041-1-i.tellez@btesa.com>
 <20260814124843.22041-5-i.tellez@btesa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:07:17 +0000
Message-Id: <20260814130718.741801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The loop condition `prod_pos - cons_pos > 0` uses unsigned arithme=
tic, turning it into a simple inequality check (`!=3D`) which causes an inf=
inite loop if `cons_pos` oversteps `prod_pos`.

Pre-existing issues:
- [High] 32-bit user space on 64-bit kernel will experience permanent ringb=
uffer stall after 4GB of traffic.
- [High] The kernel's `__bpf_user_ringbuf_peek` implementation suffers from=
 a 32-bit position wrap bug that permanently breaks the map on 32-bit archi=
tectures.
--

--- Patch [4]: [PATCH v2 bpf 4/4] libbpf: Fix ring buffer consumer loop on =
32-bit position wrap ---
commit fb935226d411d583439a72026e8126519f36b208
Author: Israel T=C3=A9llez Garc=C3=ADa <i.tellez@btesa.com>

libbpf: Fix ring buffer consumer loop on 32-bit position wrap

ringbuf_process_ring() walks the records between the consumer and the
producer with an ordering comparison. This patch fixes a 32-bit position
wrap bug by comparing the distance instead, as the consumer never runs
ahead of the producer.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 00ec4837a06de..c8fe57401a8b5 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -244,7 +244,7 @@ static int64_t ringbuf_process_ring(struct ring *r, s=
ize_t n)
>  	do {
>  		got_new_data =3D false;
>  		prod_pos =3D smp_load_acquire(r->producer_pos);

[Severity: High]
This isn't a bug introduced by this patch, but on a 32-bit userspace running
on a 64-bit kernel, does this lead to a permanent ring buffer stall?

Because unsigned long is 32-bit in userspace but the kernel uses 64-bit
positions, won't producer_pos in the kernel exceed 2^32 after 4GB of
traffic, while the 32-bit userspace only updates the lower 32 bits of
consumer_pos?

Does this cause prod_pos - cons_pos in the kernel to permanently exceed the
ring buffer mask, causing bpf_ringbuf_has_space() to reject all future
records?

> -		while (cons_pos < prod_pos) {
> +		while (prod_pos - cons_pos > 0) {

[Severity: High]
Does this condition risk an infinite loop in the consumer?

Since prod_pos and cons_pos are unsigned long, their subtraction is
unsigned and strictly >=3D 0, making > 0 act identically to !=3D 0.

If cons_pos oversteps prod_pos due to reading a torn or corrupted record
length (such as when the kernel overwrites unconsumed records in
BPF_F_RB_OVERWRITE mode), won't cons_pos bypass prod_pos?

Will the loop then spin endlessly, processing garbage memory as records
until cons_pos coincidentally aligns perfectly with prod_pos again?

>  			len_ptr =3D r->data + (cons_pos & r->mask);
>  			len =3D smp_load_acquire(len_ptr);
> =20

While reviewing this 32-bit position wrap behavior, I noticed a similar
pre-existing issue in the kernel's USER_RINGBUF implementation.

[Severity: High]
This is a pre-existing issue, but does __bpf_user_ringbuf_peek() permanently
break maps on 32-bit architectures?

kernel/bpf/ringbuf.c:__bpf_user_ringbuf_peek() {
    ...
    u64 cons_pos, prod_pos;
    ...
    if (cons_pos >=3D prod_pos)
        return -ENODATA;
    ...
}

On 32-bit kernels, rb->producer_pos and rb->consumer_pos are 32-bit
variables read into 64-bit u64 variables. When producer_pos wraps past
32-bit, its zero-extended 64-bit value becomes small, while consumer_pos
remains large.

Does this absolute ordering check falsely evaluate to true, permanently
returning -ENODATA and stalling the map until user space pushes another 4GB
of data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814124843.2204=
1-1-i.tellez@btesa.com?part=3D4
