Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240D1A275
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 00:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098178; cv=pass; b=dwcKLPez5s8iVDN6yWQhctetYcPhFqDfNjVMDpdyNMZYyUwM1yWYzebK1lPb85uhNwfr++lojfBYHEimX+Fvo3qjBVSNNB5Bnr7u5ds9xWJLagq6pTj6ZIM3ao8MNeYruejSG3Ke+QaoG1/rxpkXICwQzc9DXDRLSl5/sEa2gak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098178; c=relaxed/simple;
	bh=r3zTW45nsyUnnxRg7xoJ7zODVVjB0nkyf2mk8yr4AGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmZx7qQPlt++pweqd57a8ytsQphNk/leAhioL2IOVOulQ8zjLYZGJzkZO/93MYkq5LRh7TJfyHxfcE13eK8ODHNueaXhSRskZxZ7cBEmXpVJnJMpBaciahuNNsXL2zfjBiAy0+q3ETpMbyHKrK08ucLt223ThSO+lPRZncWrIRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBgw9oaP; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBgw9oaP"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso4606711fa.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787098175; cv=none;
        d=google.com; s=arc-20260327;
        b=dBHVK9tpZV3TBjQxGrTWO/fRLZeleQHaW8IvoCzPAdAR+FkRm5Q5hlSRFEqAtGM3AE
         6BVerOqAqM1guBQ/l/8o/KwW+JMJi6Ynb0qU3urFBkiGmS45nffNkOhQZFowMa4VqB5D
         qzKKMdipj0IETFeSob5Pl5KFP5jBjgUGhSeLZiFCyXSsAAQF8VC2NP5yHGkaX0HGhMMZ
         jkFT8E20+FHVJghsvn1rXZKfCQbM/sKRvYqPS3oX//cjeqQgzeRpqkmxUBFwcYo/5nJa
         tt8sQQ3GSA06QAA0o/+OmM3dU76l4M+7R/N8o2XNq5dV85UBHEenZD48xs6PB2CFyJlF
         cYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        fh=FYhAVtR0j+TGlFMC8gtVDhc0kiV388hRLxbfYTwyyXE=;
        b=kokOuwP9NhBwtWrVEfvAwiDg0J4rIZPlH/kEM/xFFJ6zm4AjPWocLTNJOiSdF9x9Q5
         XOHTxGGV/ZtpLe0QpQnuVfP0cMV424o9Yb3B9evOB1qoJvW7io3RH6pmQGKsU2V5EM0O
         SSA0m+qn3rmn68ajb3q5GlNHlMy2fh1EM4fNaLPuL2gVhx0o5vFLQs3/0n/+MJxtswST
         I0Io20ZO2S4OS0HT7IUwmQEE1BuRAzsQqLGqVIB8mBOtNsb04BNtBcRGMtpbu3Ky4hs8
         xiJfKU3CXloMmlaTDrm2Hjo9mzCilEDQm1s6iypNg3HoCn4I+5MzPBAGlbdfwK471X7Z
         VN9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787098175; x=1787702975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        b=UBgw9oaPdtT3oKAngrgfLc2GX8XoKzE1oz5pN+iZeFb8vDFx/fVfXXp8iqashYQHk1
         AdoxI6E22/IrjA9hyIXEX+MFIruN1gEHUmT8Rt/WAaf7Sy4klNZNf2Cq8cXKgXBcjOcQ
         4wACiXY8JndQdSKcgmC/SQcWbP8YMDXkN5O9hSxy+t6/zviY5hkOKH2mMG8TRUmwoKOV
         gcD7eOZaaGFDZrf1vqHeCxLBLDgcpBkOv/FmnpiaI8iaVmK/+B9N88DsZ+EY3iFvdWOz
         Jmt0ocE058R0bDI7LBfdEq4eGeCKYUJh+51DpubBCs8niZBZ0nIsF2EDSSbyY9YG45aI
         JSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787098175; x=1787702975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beYAJ6rd8hONAU+/B3i9DJe4/3st3v+JHwH8VcyoAzM=;
        b=ZcVH5GNWUVu5c1flhGZEPwT52b2zyNdZIl6WADPUveuw3xHZXAD7poOBDShuRiHRlF
         Yfr2LyAeWWky8uUi6gTJUt9ilJ4iukuu1kwK8FigO97RDo51m+0BxBiuikX35GfpkFeE
         R67DwczW43XuZWvHqOP1KjhUUNpT9yMAmn/tvfRVUHsrYCXbmtcj+Xqc6+6rxIQPMSd7
         PhuWQDQsSXod8F61mXEA8Gu4s5Up8ADi40RuT+gz2xDlWtdhybVK1Uf3bKQQRFC0RGwL
         Z+69fgbv/4h4gFW9afcf42p5QfNum4kwJZONtYF4Y4vfXGmRjNl3FzVH6WHZsBYMWnyE
         DmGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjFvFGkYO65NheMBLkzrS1F5XZGaO40HQYlfi6DU2foHTWUanws2vNT7bpYxczy5FoC88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TSbfzQz0scRBOzIZLqwnrBcMateiJh1RGzpUZJ5c4sk8fnF8
	qPW//8DJjcLpeN2Ec+HxpXAiroHHi3gLJPcHUERjsLalRSKtEiEiQI9A4KPbLc+QiK7qUP642HA
	VmL5+OJp2PO0EGxTgbJvAluTKqSm65rQ=
X-Gm-Gg: AR+sD134y6F62PeIBX9yCX0QB3SjwKv9201xpO5N8tpAU4NU7yLk+mlXjWJSzqvgRWk
	xclb8RTgBStIV2QJ5q73HZ+ID/yogRK+pratTzOEzqDP1EiXGQmOPSKeu07DKLlIVfSmAL2JcIk
	wdLBZ+CigSbs8euoQxZJjZk5BaWMyt4dVXoWFG4anDMDN9BEIc9gfCIE0Aa1jhWVFXlANWTNtz7
	1kIkd3rXBW5dZW9JYfStfGaM3YvKnfBccVwd+RBpbaSOLEFamu+FNGkWZaDidzObGzK1A7aMnn4
	zsRY9FQKidyWgxMmkdAaWuna3YGw32H/jeijiHIDSADP+Jj1IMXtayqf+9HESyu6wRXq5tTfZ8b
	UYAa/4D2wM6Ad++E0s4oQWtbWwbUCUJGxjyh5NkOZQwEiS/zWVqexXEiW92o=
X-Received: by 2002:a05:651c:222c:b0:39c:a346:8a36 with SMTP id
 38308e7fff4ca-3a189974b61mr660931fa.8.1787098174857; Tue, 18 Aug 2026
 17:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813215328.99311-1-blbllhy@gmail.com>
In-Reply-To: <20260813215328.99311-1-blbllhy@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Aug 2026 08:08:57 +0800
X-Gm-Features: AcwNN1W1pQE8vAeWnxc8X4qegJxfs2j5BNbiyglHNl_l4Fi90vnFBfcdT9VQ4FE
Message-ID: <CAL+tcoBCsSuN_+uypBoP5KdKUkto7X0T8A7qN2Vx6TqqGe-Ymw@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: fix NULL pointer dereference in __xsk_rcv()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:53=E2=80=AFAM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> loop without checking its return value. xsk_buff_can_alloc() only
> counts fill queue entries without validating their addresses, so it
> can succeed while xsk_buff_alloc() rejects all remaining entries and
> returns NULL.
>
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
>
> Fix this with a two-stage transaction. First allocate and stage all
> buffers required for the packet, recycling all staged buffers with
> xsk_buff_free() if any allocation fails. Only after this stage
> succeeds, copy the data, reserve the RX descriptors, and release the
> buffers in an error-free loop.
>
> Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path=
")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Thanks for working on different approaches!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---

I think it'd be better to put the previous discussion links like [1]
here and then explain a bit about what you've changed through
iterations next time. It would be beneficial for network folks to
effortlessly trace your patches.

[1]: https://lore.kernel.org/all/20260806204757.47817-1-blbllhy@gmail.com/

Thanks,
Jason

>  net/xdp/xsk.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b6..33475b180ea6 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp=
_buff *xdp, u32 len)
>         u32 frame_size =3D __xsk_pool_get_rx_frame_size(xs->pool);
>         void *copy_from =3D xsk_copy_xdp_start(xdp), *copy_to;
>         u32 from_len, meta_len, rem, num_desc;
> -       struct xdp_buff_xsk *xskb;
> +       struct xdp_buff_xsk *xskb, *tmp;
>         struct xdp_buff *xsk_xdp;
> +       LIST_HEAD(xsk_buffs);
>         skb_frag_t *frag;
> +       u32 i;
>
>         from_len =3D xdp->data_end - copy_from;
>         meta_len =3D xdp->data - copy_from;
> @@ -343,23 +345,45 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xd=
p_buff *xdp, u32 len)
>                 frag =3D  &sinfo->frags[0];
>         }
>
> +       for (i =3D 0; i < num_desc; i++) {
> +               xsk_xdp =3D xsk_buff_alloc(xs->pool);
> +               if (!xsk_xdp)
> +                       goto err_alloc;
> +
> +               xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> +               if (unlikely(!list_empty(&xskb->list_node)))
> +                       goto err_alloc;
> +
> +               list_add_tail(&xskb->list_node, &xsk_buffs);
> +       }
> +
>         do {
>                 u32 to_len =3D frame_size + meta_len;
>                 u32 copied;
>
> -               xsk_xdp =3D xsk_buff_alloc(xs->pool);
> +               xskb =3D list_first_entry(&xsk_buffs, struct xdp_buff_xsk=
,
> +                                       list_node);
> +               list_del_init(&xskb->list_node);
> +               xsk_xdp =3D &xskb->xdp;
>                 copy_to =3D xsk_xdp->data - meta_len;
>
>                 copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, &fro=
m_len, &frag, rem);
>                 rem -=3D copied;
>
> -               xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
>                 __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
>                                   rem ? XDP_PKT_CONTD : 0);
>                 meta_len =3D 0;
>         } while (rem);
>
>         return 0;
> +
> +err_alloc:
> +       list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> +               list_del_init(&xskb->list_node);
> +               xsk_buff_free(&xskb->xdp);
> +       }
> +       xs->rx_dropped++;
> +       return -ENOMEM;
>  }
>
>  static bool xsk_tx_writeable(struct xdp_sock *xs)
> --
> 2.52.0
>
