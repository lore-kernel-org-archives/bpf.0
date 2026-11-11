Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794427265;
	b=jdVPQLwdRuzG7jjI3AIaQjoLmAg2l+r1yLjyjm+y/ibGUevirMdp6NdjFiM5q45XVq70
	 3KjYu524BLyBG3smVHYIjVDMhWLrtgT2dw7nazp5whVjRkg8h9Fq9hTntsGIjw5DluJUu
	 7CZqfDZALN8aoCxBvOn4PZkLVhNb1152+O7DbsvpxaegwrHTW27gsJmdhGFnNDkVL6FVD
	 GOV+UaiKN21DAolTSOVFdlilIiBcSnadLdYioW4dqgjIzjAetp1nUpk7eivHfrv9pgqR7
	 LiYqkxVMJwDXOvjFWhLR47JC9kk+hREqMRbFJNEDqJ2YCR7218N6bXJwke9Lb9IwC/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
	b=FynPMzqQnr4AsbrZVnSGvdZdijnKcB7wmc7U20fFg3VLrXT5DityrEBLhb0VHkCdg70O
	 105okVngZ9J1UxrGXANwqLIukdI55fz3iu8vHjh0pWrD2fH3k3D5YNF+D8XAF3KUi+y11
	 g3TJamkHCeUmCBPbxYd0x/Ra2us28go2IKbr1erXbBOuxacReAzVCy1+8zKoT/jb6qyqM
	 uJPePG2EZGU1Jh0rc7SKBLCEBm/ku9qalmb76FdGd9xRDDCdxlVN/8TDJashWsh2M6UPy
	 ECnQkkiRCIqlyGOR/3NbGXe+CoeQATa81vcgTR9LSbac0fhlPuDic5dWWQN5MT6sFiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="e0/7texl";
	arc=fail smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74788606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 20:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74788606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e0/7texl
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5383c97c8cfso30661cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794427264; cv=none;
        d=google.com; s=arc-20260327;
        b=cXVCfEi8q9eAx/O4k2vyLkp/biSsC0/k+oXZJIO7drDsCmSHGyiY2JJr78ZWA6W/sV
         ZWqZxBVU1fj2k1XAXd73EMZfbrrDq2QvUojdLZQp3T1H5Fj/19LLOO6x34m2N+AHw3vi
         npNvYVYQ6Rgz6WYVsrzel/Z1ek6CO/TjfFL+XHMDG+L+9kDAru0K5Wqw/mFzKxsvgwXT
         +gNSb3lQPy7/BWcrKrY93fCUxsFNwBJ9dlHGvJu6sVYhx6z7WL21g3fT29roB2rusQ2L
         3GHoVEWxmCEDXDsYabwSzqyVXzZ2VLj9GbezNKSTdTv1dxc8uaVHQGQszVQ+SVGy3CTe
         KTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
        fh=aww2UfzWvEDwSHBtCLuyhA6cSHzxvsaqjMW8vY6rnyg=;
        b=hOg8NrulHZ5VyGjlfP8OyLlUHD/FSnWl7lRQTF9Rg0RcmZ73Cm1PghA4xGUDX21q+u
         uBrwen+O5ormOw1M9LOCF+0BcBIG4clzdNWU8C4mMDU7QiaiRj7ObXMQspLud3L7NiT3
         Yalxd5pNXakVDogVEjyUnrhbnHqZPOk4jd2DPsmxbztCfhuZudRO2t2/CRebr/0Lbbx7
         /wSuVXOwjAe9Q2GZHgFySrCfOg+5UPhhNCMTGaOqLNc7OFf0UzK+VCFfiM2CFQy8qeCY
         EPRJUhrwjuc4hW3zdfceBfOCFWi0rhJqU0uNey8BuND4uIKj13cwC+ehleolArWpDvBP
         jBEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794427264; x=1795032064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
        b=e0/7texlSOu4KxVZE0iowt9LZ3snSvdmUmXOWXqPvVg6nIujvUChLVQUD1CQnS/21L
         DdXlTDttd464JKAHMoLOl3o94DAdpWFnNkIKdwKGjWcZG9l9O+fnjoGxm0JxzRAFvZCo
         yF5YzRzunZQUkSEzBeXlt4Y0A1bkdMnN2JtnOW7eIq+kUucV3uvL46rSRbm/HbJNnFPN
         jAdOipxflAvbMEwHX1AVPKlqTd7vp2SfnW6HUpZu7+UwuwNGfUwus6Q/EtcjXLtxfLRl
         t3blfXCBNN5P6LcWe9IZZtzyCCJtekzOC1vrSY5Zd0ZDLXnngRuvAxIvUPrQc3qgvEd4
         3uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427264; x=1795032064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
        b=iLHYyuGyfI/8qFVLzFb8GSsydNx9dW0LyVRD7JuC8j9ruo7eTCYQRoReQ0BYgEE355
         zlTmJVVZOdVszljpI7mDFQsRBz+GeX3C2J5UvIS0NnNSl7dkwm6tto8xVrMWzzIipUYs
         +wRMgxXWefwsInLJgvWFZHvqHaOV59o3ncf0auyuhf9QqseytJeGE9L1JCWT2pEwieXO
         ihgU2bQwGxkZ6iy6JDpfVNF0iPNm00dr/dmmFWZL0bOOUFmTk8ReOVAttGxz7H5BNyhd
         ZHD3QZt//Kl8neW+NJE/ZsRActzt9ZfRd036wHqjrux+0t21zJIKITteMGwuvJ704BE2
         nNPQ==
X-Forwarded-Encrypted: i=1; AL+hErGCvaWyEtks70oTC8hSMWHWt1B+ClPw4sc/oOPXKWeMukKhCKjvL8MjCw5a7M2Zmc8aEnw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Irshrqxp53Rdif21skl/8c//ubJkmWOnBzZ4mjxGjASLePJC/
	DaA46m5PVWHp1lU6II/neyafMKcXMhFyM3bPny1xz3sy8l4lCDwj9uIwP/JnmUwP3CPXmU7pKyV
	KIxF6TM4PgtVb/zkk9Pw2OqJWYt6BDuz5cJliSAjc
X-Gm-Gg: AYBFou1R13+MnjT+Mgt61gku5oklsgtYG7qKQ8+3q168Sbf8rfFklRr+W8VU0ge2Nv/
	FqYumJulXiqj6ihIzqr8m6dOK4JeYnnyYMktEwPZTW8Fy4kzMosEOpU5LY7qJ9fFBTkgW1m8R7d
	cWXv/mx8WWHS3OdTEtO1CC/yCXM60ZIldv6gAD0lB05vxcZ16eHRdy8jzK2z2Zi101Mq8LbZkOo
	PbSZt4jM5Fyd/MnvDHunj2qS4c9okWhcvfjICmPwYgYkprslCaUuScJXnreAj7i2JYeD5x+/LMf
	kFvHhrpxMXfuILQUR/CW0AqxfKuTOGFEYUx8Dy0tvmI1BWHomK5nV9CYThDUoELGN2jraBNvOvf
	mOg9ePofv7usoGPOPXCH1+l9xiSe/dzG2yw9AVOCORMAMbprwKX6RjOCn/Buwnfb1TVvX0UtYOQ
	C8CYY31jvWF/jWQ0TQhBfDBw==
X-Received: by 2002:a05:622a:2b4b:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-559710b30e1mr1999241cf.13.1794427263429; Wed, 11 Nov 2026
 12:01:03 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 11 Nov 2026 12:00:49 -0800
X-Gm-Features: AclHuK81JcIQVOh-tqCQX9JsRqdWOHCGs7dqRFvbpp7CrwexNznx4vXc5gM5Rp0
Message-ID: <CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 4:57=E2=80=AFAM Kang Chen <k.chen@smail.nju.edu.cn>=
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
> Use an invalid pointer value as the drained sentinel so the iterator
> state keeps its one-pointer ABI, and skip dma_buf_put() for it.
>
> Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Thanks for this fix. The cgroup (bpf_iter_css_next) and scx_dsq
(bpf_iter_scx_dsq_next) iterators look like they also have this
problem.

> ---
>  kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index cd500248abd9..a2b7c38f9ae6 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
>         struct dma_buf *dmabuf;
>  } __aligned(8);
>
> +/*
> + * The iterator state is one pointer wide because struct bpf_iter_dmabuf=
 is
> + * part of the generated vmlinux.h ABI.  Use an invalid pointer value as=
 the
> + * "drained" sentinel instead of growing the state.
> + */

This comment explains why this patch uses a sentinel instead of
growing the state, but that doesn't help anyone reading this code in
the future. This belongs in the commit message, not a code comment.
The real constraint is that the size of bpf_iter_dmabuf is
user-visible API, so it can't grow without breaking backwards
compatibility.

> +#define DMABUF_ITER_DONE       ((struct dma_buf *)1L)

I would prefer this to be DMABUF_ITER_START to mirror the kmem_cache
iterator. Then the second if (!kit->dmabuf) block in
bpf_iter_dmabuf_next() below could also be removed.

> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(st=
ruct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> +       /*
> +        * The verifier assumes that an iterator which returned NULL keep=
s
> +        * returning NULL (see process_iter_next_call()).  Without this c=
heck
> +        * the NULL left by the last dma_buf_iter_next() would be interpr=
eted
> +        * as "not started" and the iteration would restart from the list=
 head.
> +        */

Same here, this is commit message material. If you want to add a code
comment, referencing the rule from bpf_iterators.rst should be enough:

/* Once NULL is returned, subsequent next calls should keep returning NULL.=
 */

> +       if (kit->dmabuf =3D=3D DMABUF_ITER_DONE)
> +               return NULL;
> +
>         if (kit->dmabuf)
>                 kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
>         else
>                 kit->dmabuf =3D dma_buf_iter_begin();
>
> +       if (!kit->dmabuf) {
> +               kit->dmabuf =3D DMABUF_ITER_DONE;
> +               return NULL;
> +       }
> +
>         return kit->dmabuf;
>  }
>
> @@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_i=
ter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_DONE)
>                 dma_buf_put(kit->dmabuf);
>  }
>
> --
> 2.34.1

I think we should also add a test for this. I've sent one as a reply
to this thread. It fails without your fix and passes with it. Feel
free to add it as 2/2 in v2.
