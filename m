Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589201;
	b=W3J7Smiefl3VXs+Da1lOmZ6UfOCws2/wYUNq0TshulxgFKe/fBGC35UC+Bs6XsjuGAHy
	 BSTBQqozGiSAM/3lJiT1Pqw2vrYdPfMcpgY3AaIwifRopJYrTWuZB8Wco7sAyeyXSXtVS
	 OWdMIKH0J7tGW3Vk9lmfLEM8yf6Qy3jinMeF3gfChzz1EkMTCFvrDF0Q6qYqp+Z+I0VZz
	 1Wg1FH2Zvxksa5JgXCA5THOUWHm8aWRc4TOBGqKHQ2xHqo/Lr+kDo0eU7AKEXF+iwIUJf
	 h7hZ7IisFRKN9Ny1nAvmljPg/rFv+DffWglm/KfUBSUS6G6+5TOp7Yen31IVoCTE1Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
	b=MWJa1VCmZcQnZy7t6iyjNJ6n1w4N2yKbsIDYgCbMjdq1B05jGlchktfTsGQ5qnZuODg+
	 L7eJO9wdt4Cd1xKWcSMJcCfHz8TxQPj7P89rwOILD/vzpNOoMhW5QFu5Z3ZeQnt8vi9m1
	 NQBt8tfV43hhvprbCQxmG8MgV00ef6dT+l3//JHWCsmeU3g0FDdbTRvBoqd0UF5gMsXvV
	 SYpeD89LnbjejcjWHBZoYBV0tnhGBjvLroDGAnsriHIcs6hUiCPWkcd9ToFIoeh3rWTrq
	 EmPLye9maA+zEZrH01PullHY2bhZjPtOgWWV+MAih7StPgeg7aERKB3ff/G4TQzg3GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FYLt4ttP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867A5606A8BD
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867A5606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FYLt4ttP
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso127885e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589199; cv=none;
        d=google.com; s=arc-20260327;
        b=MhkiLprs01xru6WPYbEv/4LWm0gFPs/YitpOIzU2DBvIAsmu8JDbVodXSGlFtBXcV+
         MLYfv2PLMw+FhMOA/jHIxikYUV4ASgeI5s+otzXYBT0MtvFKKX3jKxE9QrOkiKDCp9en
         UWFYp3DX6P4XP1sYw4YIsUybzw/E1CBtttT03LvBCa89hzZR449/RDo17EgNAPMdI6Gw
         MfiAXji4gSSmxxrCfnA1mlOIcOfavxtIJXOd/w4ixUY63QRVZ/T3T88IVYpiyN3cVXyB
         8m8uIdz3zVVReVmlNWk9EGwvNlGDKFNu4+q8iLIhWWes9UR2ScpGzdKS6TuDBqAvumzX
         wIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
        fh=xO6BQI7/+fETG60XibcTly7s0xXax1/v+Mtpqopi7jA=;
        b=foi2SKZJmpQ8MW0MAolwOS7seHoeYcR/S9EWauZCDKCQsOhXCgMW/knSjOp3UuyXVa
         LCtV+34Dcu+fzyPd4IzqhJRBOL3wUG4XQQL2lGjTImAOkj9/usudMeDgUR0Gdg0hDIIq
         hp8FKzDmAdoEx+o+xGSfQnwwAxs+4aCJPzf1BeU+LTldDO+P+Sl81D8aR2i4uxbXkJiE
         63asefv9WZRadZLq2m9VgUn7yddV+Zhc3QUA2OfOtLzdpdk5u2tPMaOHbx56H+DjT9A6
         5Jff1U8zSIj1FvXLej7ktdlq8UVUgwpjiMsTvqcmU7rLSuto8bdwAIwSluc1Xqe6c8Y4
         3Ogg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589199; x=1795193999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
        b=FYLt4ttP5B2WVHQ6vCHPoKjcfSzLRA8ecYOiE3nk+gqHrDdCArmGFAfCyVT148EhQI
         skjMiEVfofxcg4nfQkdnRH/JuUm1GJzsPQ/7iVvkcS2U47+eiAF3fvSKLoC8XiZ6PpiN
         EsMq7P3BZPSdCP0gqXHlU+VY/K/cxaFCtA4aX2ZxI0lafAlFqO8dD4gj55d6W39NjDYV
         WLD5DXNDPLF0iPlngPDHrtgxmh9UxHCbX83YetyGUfWLNJhWfuAEtUAvsAxTrtXta/+h
         hzPHbYgbYCWnpaB1yL01GqPyf2qozPZTXq0xoJVXcTqEgA/Me6HcfB5kVIOOIIoj1a4y
         kdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589199; x=1795193999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
        b=XWp0mVCGpMM/oK1oMrOfFK6VEsEcMEdI5bukH2xvyTU7Yl/S4tP8S2oyj0i9e0rcjM
         RIvobaKIrPQlyr6VcKjnizhN2B8uvDCKt8o6AZaXQk3eJIGp8Fv4vFV9r2of/O6vbAPf
         7MTk5n5BEgQHwbbq5nVRV6M0RHfMkk0KOvrixxlDptHAlaF4RywkWyfLeL4NFt2KzzjK
         9Vsj8XUp6pjslCeAOP+8TUKPQTNTUToDMCsf7YrBuulwoxvs0PIjPw+QxNWixxPJGDQF
         eEdcPCYjk0t2zfL68qUXH8yUFaaZYfasZUIN920zcOV/ezODqZFbYkQIBuH7Kyo8TCAz
         fGQA==
X-Forwarded-Encrypted: i=1; AL+hErHbxT+tvbPthGskboT2q/bDF3hP3pX5EwFKv/9f5TpYnWjScjud2HjFnuT+tgocUIG8XrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Xdw093z+PW8MUCZ1olhedbkRauXGcE202xc+nei3V+jcDlVjH
	CCly0s6XzWDtZ3JkERcBZG3DpIfnbEqvcQPmUPQJGIuABIxBHpbvBFIPOxSg1T97S2PNd63C1FW
	wk2WxBnpMhwnLLrH0Eu1Gjt6R32fZCKMN84Z5dwid
X-Gm-Gg: AYBFou3BTTF08mdndeDzWbzpOf3HRgbSSsdpk/PxkKQwG3dRSoBHHYRBGOmo0vyh5ZB
	GQDGJbvKmaW1lsd4yHnTPY9MUuNqL5VbqLw9imD8PfkDRT4N0kQPrSn8dcAF2fGuAG9CwbttI1i
	WpMcAVVifvkPA3dalPUTTP4/AW4rbJ01BSU/BK01MHaZbpXuKKVjtghmUFOd993N8IiIG32iTcO
	5FD3BjiMFic3LkuXsloYZHT1uMGSKcLzeGiHRsPDCDeRT8rp1Cs7MZJzDzz5ItNSNSEJO51ftMd
	rYYgxtt2fM33ySUhFdIYjRQ7xKb1DwrTrwEAr59Cgs1m3ceMQGx3FFRAVUBRS4MJnUvvGetylbd
	AmvZSwB+25USB2ieDXx6DxYkWz7+eszyUnhe35O8pSpQZsntf9JUxjrpwpZJ9yBjwdlOHXholbh
	OHOmYwDY1jlKXDFkMmOapJ9E4=
X-Received: by 2002:a05:600c:ac1:b0:4b8:b175:c5a3 with SMTP id
 5b1f17b1804b1-4bb56e4edcbmr658015e9.9.1794589198370; Fri, 13 Nov 2026
 08:59:58 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn> <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 13 Nov 2026 08:59:42 -0800
X-Gm-Features: AclHuK-LFbMT3CtNvV1OqgqhSoIHpLJtutAfAmKAD9TN_Xuh-nAE2mDUwuHSl-g
Message-ID: <CABdmKX39KyeRFLwiJKpt0ZVjWkNcL62ajYNUjHfN4VXAqbHJrQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: make dmabuf iterator stay drained after NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:57=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> bpf_iter_dmabuf_next() uses kit->dmabuf =3D=3D NULL to mean "iteration ha=
s
> not started".  dma_buf_iter_next() also returns NULL at the end of the
> list, so a next() call after exhaustion restarts from the list head.
>
> The verifier relies on the iterator contract that once next() returns
> NULL it keeps returning NULL: process_iter_next_call() marks the
> iterator DRAINED and treats the result of later next() calls as the
> constant zero.  A restarted dmabuf iteration therefore hands the BPF
> program a kernel pointer while the verifier believes R0 =3D=3D 0.
>
> NULL now means drained.  Initialize the state to DMABUF_ITER_START and
> translate it to dma_buf_iter_begin() on the first next().  The iterator
> state is BPF-visible ABI (one pointer wide), so use an invalid pointer
> sentinel instead of growing it.
>
> Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
> v3:
> - No change from v2; reposted with the updated 2/2 attribution.
>
>  kernel/bpf/dmabuf_iter.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index cd500248abd9..390f6d730a67 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -156,6 +156,9 @@ struct bpf_iter_dmabuf_kern {
>         struct dma_buf *dmabuf;
>  } __aligned(8);
>
> +/* NULL means drained; START means "not started yet". */
> +#define DMABUF_ITER_START      ((struct dma_buf *)1L)
> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> @@ -165,7 +168,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_d=
mabuf *it)
>         BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
>         BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
>
> -       kit->dmabuf =3D NULL;
> +       kit->dmabuf =3D DMABUF_ITER_START;
>         return 0;
>  }
>
> @@ -173,10 +176,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(st=
ruct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> -               kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
> -       else
> +       /* Once NULL is returned, next() has to keep returning NULL. */
> +       if (!kit->dmabuf)
> +               return NULL;
> +
> +       if (kit->dmabuf =3D=3D DMABUF_ITER_START)
>                 kit->dmabuf =3D dma_buf_iter_begin();
> +       else
> +               kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
>
>         return kit->dmabuf;
>  }
> @@ -185,7 +192,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_i=
ter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_START)
>                 dma_buf_put(kit->dmabuf);
>  }
>
> --
> 2.34.1
>
