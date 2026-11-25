Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795639767;
	b=hR/dLQE8khFVaFyDlxE6RFVq7Ky+h6p8yHSiaaVhWHE5K6YMbjvaU2r574c4Uz3wPMV2
	 c6jzcVv/PFcIeOsl5biPrtO3WDeYNtw0hLAMndQYFFxmXSNuhE9nDruN9Y8YxL6/O5rE5
	 zCTBM50kkNH+eVnOayTkf/L9eBwgjrUO+gNG59efgXYDPMeuOBeEnnBac2LybuaRNVDiK
	 uCGQIiNgeiMBHQ+wfnCalxZdQeT9sz70aeoNDlbtCjTflwYrlbaKZTu3e/zkVXbjtd/Zy
	 zrg9wfQAsX+MLtf0FcM9C58uVOL784nEl3v5tzM+Fmz5Oy4m6yHFKOagqPAPSyeB1gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=S5riyWKyHRvkAVOHxHxn4nm45SoAHzeQVosExj5pMGA=;
	b=Tv+BqwuK/KmtYUVNpdfag39UucwDcrISbd+YzziRyndOFm8SUO46+/0bRU/00OX29xzI
	 Z14M3kp+GilJMESgGjBngxijI6i3epUwzlYeJrstpz72TEaI/nx0QwN7/gA9XSYVJ1UpD
	 UgP01n5vCay0ywhHMsQ6cmiWLXofvMJCKuFvjKNs/Z5K4uvbV+YwRRLKfqqlAkjjgDKsz
	 MqobQ20XwxhPX1NhE7+sRxGGQ7q6GXOss9yscCL4mXpRtkG8WPqpWIOr7onyCnAjjvt0A
	 nmqpzv77vmXaUD8cqDHPgX7IOLrjncHmJQlNz4XkpGlU5fPV29df8hWnNWxkAvlQnZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BtrtLAAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13C606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A13C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BtrtLAAK
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dee593f18so5833304f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 12:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795639765; cv=none;
        d=google.com; s=arc-20260327;
        b=rc/vQ1q2j98CYN8qmVJqA32ftIDQLqZoltQKC1zRK1S2mgIRy9wRp3L31vgZJw6Jz2
         PQqAbyXyqdFJ91PaEAtng2Ov/Xht7A8a9wA33YYSbJme58ywRKl8MF+jLKPdp/WiCN2x
         KkbTb6oH0oz65fruM285AvhV7uOvWgo+FysQP7w20bV16WSrzNpkdBzvw5BaVkcQXJ9t
         sxc8z5xcg9pDL+Jl3qwVqTbXQ2UkReKwITo4HYswrF/GVaAUJpmms3oWrTtqooNFr63+
         sAT8EcAcjKrxysd4zLL8JBl0br47HFGLqkWR7kCwuXPtVJcL2IxhsyC7ecH6XNaVsSQS
         WP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5riyWKyHRvkAVOHxHxn4nm45SoAHzeQVosExj5pMGA=;
        fh=OD9HlkZPdWUmBu94gKiQEkulmJKUHioi4rqD9u/eNgI=;
        b=jkawT5G98QWBBk0VsyRzaxDm4D4lMpWeWViZiLcmkTZKulPjWMBsp1MgUwlES1o3Gx
         k+tJoyBxtOWH9I30GwjGpVl07mLHNI/OcTcNTmoNh1xfBSRwyQKWT+K61QBJ7ll0LYhn
         3C5AoWE3TKWIAvlTgqzZEbJ2Zgv5S2tPoGjOBFSuuqROz6w6lgCBUAk8mBoJpM+k4mCq
         ySmRU65/JQOdXny4t1EaBHvLJZ144FZLAI0I7AoOQGMLJE+WxRJahWGcm7r1Pie1PKtg
         lcsHWSE+4tNKTR5KsLMwcIulInjkFyFedF5sCV/1ssW8jjFkg9LaweF+FksQq8wH6JxY
         5Jvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795639765; x=1796244565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5riyWKyHRvkAVOHxHxn4nm45SoAHzeQVosExj5pMGA=;
        b=BtrtLAAKoBKqLAM9EPhPelFxvcQOwJTcj/N332/2m7C71nK+p9jKRRw/gfqNRac7ch
         nwvnRpEVwKe20LOgoiH79g7LdP8dfQmFf/VPdKWHBF4LKW5XMY7lI+oyY239fMk3UKKK
         1n/rBRuV/mUrbeT9ui0q+kB/TjdpUtdSw8CT9d+o0bQDGgORUdN5D1w5Nngl60X4STtr
         xQjzodHsAdppZjXkuyVhmz5A6WotuaNHpp88JpgAk4uP0AMh+K0E+GEIeBaMykPwfOFV
         +B0maG/O/3L8ze6W+sqOauYsKYob5lHrx9dTTc136lrm7aUo/RKNyVEyE30IddYOM5a5
         qFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795639765; x=1796244565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5riyWKyHRvkAVOHxHxn4nm45SoAHzeQVosExj5pMGA=;
        b=J4fhoxP8rA7mvXdANseW/cLJDPfbFo4G14aszb6Rp2PdK8t0RMGBN3XEkdzK00oKZb
         4HA7CNzB+rxpLTxbdi3HAnSC5Hi43O8iTma7nVOGDwszsthIcDmFUXEZl3jE5M3z2BFP
         TLSeNU2Hzpe4dgyRfZKK7ehDlY/fIizkMScBkZ4KgrlF1MlaEcbJ41ii2kR63wcM7dc0
         0ZeHmFChpg8P1JgFz2uvFt04/vP04+CdlI6mBc4RUrshgp7DW2G+tKwvdwqgBmqcA2Hj
         3oxtLnZAJRB0fIj1rIGPUrskwac2y0DJRDg/KKKaDiBkYp7ecuQh4V+pbFBcdVRFppWE
         0Jbg==
X-Gm-Message-State: APuU4Z+bol+7lc1z6lj7Y8zE3jUd6kIOxHjjxsD62ocn9fwXEp8mF5eK
	XjFOZqqVHip610891OcgYlvhhf2dHDPvtrnCVgiWMDMsaoV/2sh+MsHC9wyuBe9Ezd/TzLi/pOd
	gGBOyK0AYl+lT3Kuc1DPROGT8waVjSaU=
X-Gm-Gg: AZFdTZfmwbboZ9Fbg3L1GAVNsdNTz2NYj0+hPNprnrW2DBk2WlUBO0jC8lKQNjOOKvN
	2LiJmzwhNUbOTYgD9Q+siWEyWg1BlimeUnOAvncF+YfAZPCAaTqfRCXBRV2Tb52lddOUu1xOcSt
	Jc/7bYxfwM/4ojS6O1xwipOCcz4PDH58gZNoI5GEH9odhp6m8I5AN28h3/qUKznKv4SLISTJExT
	x+5N6HZplY517KTJO8kA08yYFIFOErslMWiWDDqVbMiw8dfkyb6I6TMslqGZGEIIi0cmWrKjTQz
	UIRqIVpq1vZ0yGK4CF7qrOIghYPKgHZatZWTdVB+Eg+YTKaL/5NfEGXhD3JWfyi7Emi3EEmCWQz
	ciWuojCgjaxU1l50zCbKmqpg94ZPcVsUHWiKqECXiSrVtEG4yfzKohK5KRfALWUcMY7OTwPqStF
	2338yj5KyVFWfj0QcX+Q==
X-Received: by 2002:a05:600c:64c9:b0:4bb:8701:bb14 with SMTP id
 5b1f17b1804b1-4bb88804d1cmr415471515e9.5.1795639764983; Wed, 25 Nov 2026
 12:49:24 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795467315.git.memxor@gmail.com> <8115836d8bcbb9d59e2a350f9fb999f5ab497348.1795467315.git.memxor@gmail.com>
In-Reply-To: <8115836d8bcbb9d59e2a350f9fb999f5ab497348.1795467315.git.memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Nov 2026 12:49:13 -0800
X-Gm-Features: Aa3M54o0BxMqNhkdsW_aofW7uh98gtsgTOajLmthveOpLD22Tlgj5XJ5U1x8P1I
Message-ID: <CAEf4Bzbg_CtYvmuFYJ57arbaNVbHnAXyq3aTyZAAKcc==pq6DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/10] libbpf: Support overwritable ring
 buffers in the record API
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 1:14=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> In an overwritable ring buffer (BPF_F_RB_OVERWRITE) the kernel doesn't
> wait for the consumer and overwrites the oldest records when the ring
> buffer is full. A record returned by ring__next() can be overwritten whil=
e
> the caller is reading it, which is why such ring buffers can't be consume=
d
> through callbacks.
>
> Add ring__invalidated(), which returns true if any of the records returne=
d
> by ring__next() since the last ring__release() or ring__rewind() may have
> been overwritten. The caller has to copy record data first, and use the
> copy only if ring__invalidated() returns false afterwards:
>
>         do {
>                 while ((rec =3D ring__next(r))) {
>                         memcpy(copy, rec->data, rec->len);
>                         if (ring__invalidated(r))
>                                 break;
>                         handle(copy, rec->len);
>                 }
>         } while (ring__release(r) > 0);
>
> It can also be called once for a number of records, e.g. to dump the ring
> buffer without consuming anything:
>
>         n =3D 0;
>         while ((rec =3D ring__next(r))) {
>                 memcpy(copies[n], rec->data, rec->len);
>                 lens[n++] =3D rec->len;
>         }
>         if (!ring__invalidated(r))
>                 dump(copies, lens, n);
>         ring__rewind(r);
>
> Records are overwritten in order, so ring__invalidated() only has to chec=
k
> that the producer is less than a ring buffer size ahead of the first reco=
rd
> returned since the last release or rewind. For regular ring buffers it
> always returns false.
>
> Overwritable ring buffers get their own implementation of ring__next(),
> ringbuf_overwrite_next(), so that the regular one stays as it is.
> ringbuf_overwrite_next() does the same check for every record header
> before using it, so pos and len of a returned record are always valid and
> only record data needs ring__invalidated(). If the check fails, it
> continues from the kernel's overwrite position. There is no limit on how
> often that can repeat: a producer that keeps overwriting records before
> they can be read is not expected in practice.
>
> Overwritable ring buffers are not supported by 32-bit libbpf, where
> ring__next() fails with EOPNOTSUPP. It doesn't know where the overwrite
> position is, and 32-bit positions wrap after 4 GiB of records, which the
> check can't notice.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/libbpf.h   | 32 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  | 94 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 123 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 91d25bed5a04..24a70bf3f782 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1691,6 +1691,10 @@ struct ring_rec {
>   * Each call invalidates and reuses the previous struct ring_rec, so cop=
y it if
>   * it is needed later.
>   *
> + * In an overwritable ring buffer (BPF_F_RB_OVERWRITE) record data can b=
e
> + * overwritten at any time, see **ring__invalidated()**. Such ring buffe=
rs are
> + * not supported by 32-bit libbpf: **ring__next()** fails with EOPNOTSUP=
P.

AI tells me that we can detect whether host kernel is 32-bit or 64-bit
by checking utsname, but modifying personality, etc. Looks ugly, tbh,
but can work.

> + *
>   * @param r A ringbuffer object.
>   * @return The next record, or NULL if there is nothing to consume. errn=
o is
>   * set on any error.
> @@ -1719,6 +1723,34 @@ LIBBPF_API int ring__release(struct ring *r);
>   */
>  LIBBPF_API void ring__rewind(struct ring *r);

[...]

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 12d586afed1d..b4e9e27951eb 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -36,6 +36,9 @@ struct ring {
>         struct ring_rec rec;
>         /* always zero, in case struct ring_rec needs new fields */
>         unsigned long rec_reserved[2];
> +       /* overwrite mode: first record returned since the last release o=
r rewind */
> +       unsigned long batch_pos;
> +       bool has_batch;

very minor, but can move this next to overwrite bool to avoid unnecessary g=
ap

>         int map_fd;
>         bool overwrite;
>  };

[...]

>  const struct ring_rec *ring__next(struct ring *r)
>  {
>         unsigned long pos, prod_pos;
> @@ -512,6 +576,9 @@ const struct ring_rec *ring__next(struct ring *r)
>         if (err)
>                 return libbpf_err_ptr(err);
>
> +       if (r->overwrite)

unlikely() ?

> +               return ringbuf_overwrite_next(r);
> +
>         pos =3D r->next_pos;
>         prod_pos =3D r->prod_pos;
>         for (;;) {

[...]
