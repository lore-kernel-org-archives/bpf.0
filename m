Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86439022B
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970853; cv=pass; b=dIA+lRzOxXvLQJWSqvVvlzFzyioqjWLbpsDEGfyHVhcDxxrWDLh5FQSt2xt7PQob/HzJKJb0WjnyA69sp14hvQCT6nlQesXy/b2YopgumFxI+uXcC32gMEYj3gsUN6MaXdMDSYIO3YHZyRSTXXYfvROR0LqnUmqXBdeIERH1jnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970853; c=relaxed/simple;
	bh=b86w1Hfbxe6xSAgB/lj5BiWyVXB4U+5oiASYMA0EXeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXm/pnipMciFGG1p8AW458ATxoCbSMa4fzURQHXVtwrJQQw6wtdpjz70S4x0dSn3ESut0xmN5SSrRzALaN9GWVcXmJKRkN0XjKwAotbX6GCF7iGeUrCOcgUgn4+IBeMMOWU1N7AvhM5V5gtOwX2QtFDv+86u3M98mZAgZS7ipFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+MDvqIp; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+MDvqIp"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1245813e87.2
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 02:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784970850; cv=none;
        d=google.com; s=arc-20260327;
        b=qmstnUit+4X4ktV/kiWJjk7PTG3KEhpM7Putdn+LPOo+5BOGRVyIWvckZ28gh3pIOj
         xbYPXYlEr2ycbJEAnaJIGww6xJ009v7N71a59OHx+TMMfxsMy4Jr0lV5EfRpUce3IJBI
         B3gar3hP32malo9+BdfdObhzwTTi+3cmiS6QZtJyRzdKmYGM+sN5OyvS/cWC2hXFSlbz
         OjIZTo7y91jfm8Saw1y5Nid71tHaqBlA6FhC+YL1yKzqIjUi/nFHbSVnds/yTMnlcQj1
         SPH6ahPyuq3AN9cX+TKxOMHyPdJFM/Bl3rSVxo/MZ58DIpTixBwCA5mxZ1dNYE3+/vWi
         uBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        fh=EisVhAVgJ71ttwZbA95vUzBO6CeH5EUjSsQWn+m9/cQ=;
        b=ZHGuW1plbPPU1c0SRK67rjHcpTIVGtWY7p5wm/UW7nvyHsYd5lEbwutnUtwN9wZD32
         IxLjvgApIV6KxONzRVayAxacrl45ZOfiUQtIOrs5vZ49qQe6tO0ewMtQD/n1qVrykNIz
         6Qxe4lwszrqcKqjzM9PGEz6dV883VRMjEv/lGn16z9qQCtMTr1fUr3vIP6i3aA6rUop+
         dwkrsUnAylWZwbiEcnn7OcQUqlfZlh3olQS1FTUq1BLpQEBYfcUFv+K6mufZWVnxZ5ZC
         t1WiHCtg9LgjVVloPKGxxoiCD8mV68Hh7hgIyn0qpwR91g3xlVxceExs5lQcGsmJxDWa
         +UJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784970850; x=1785575650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        b=P+MDvqIp1rRQowkhh3LNzTLhx5m9EVaw+L+BOBOXhjIWzAUZE7gs0kbVHMBSp2SrZ5
         IaC2XENcbqaoRbCXkJxHMciY0yUpj5qJXUsoIHVweBLopnC+N/uImIoZ6zWWCB4f4qc3
         KRYV53o2j0k4b8panq30xAB5wtyBbA7t+kijf+aN6jI5oI9JnhfuR/FF31n3hLAbJwzC
         xRlcM2etJ2UfDUTOzhh0EqBvTSy/gxnAzWZSG8Z5Z/Z2Ov+8q4QTHZkG2Z5orHuvlMS6
         B+uK+GAxrCsFRX766Al/9IVfhfojlGLHmp/7oqqUp+vzevL7kF9+7PaRISgoc+UDkZRk
         wuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784970850; x=1785575650;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFSKBs58ICJvc3f7BylS3e76h+CIlOceHYfnXTfuT9s=;
        b=X7uN+qrAS7/sGHfLYlOMTwkJMHbVcwfhBIPTZkMsYbW9VGxmCp687iUBHI3sF98tXI
         +aVC0Fgb4xeRH267v0jaX6re8uhWAOsz9u+V4/xLJc5OO3Dqlgrs+ubeuweDW6kCA5++
         kKNjUIvpkH9jUzcgoN7x8UHOlwfKRk3MgZ8qg1Sithe9FqbupivjAhPEicJmg5d9B6tf
         +9uert1JClguIn09eerb/DOwvPcDVYspeKHGIw4/wFVflbY/OVw7Od6HzYl61ZkUsW3f
         0HZTh89Scbo9WWW8nNmf3ENE+prR6usljs+2+AWTletffgNSI3UmSJlkZOg8oF4Evsdw
         Yuwg==
X-Forwarded-Encrypted: i=1; AHgh+Rrb1gy+o1ZnXZ0qubMIOyaGzTE4hZxJ4G3bBXRGWg+AlnAlRaE1zV0XWbCH7RxndSH9DZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoznBBR1g5rQJOtd3NUOV/cw8Ktxepz9re94i9gQtQbhLXwE4Z
	ln0yfdJ4Vmwbp0iW3q/hGjOG/OAx2PSRzApy08FQFZUx5RLrcqzwVOIokdUYSkx4MXh5CSfa1vo
	PyoD+yj7HyOD8DIr+92niMqlJKaIaooc=
X-Gm-Gg: AR+sD128MSuHZoIRR9t2eNN+lRZaVXUj0QpUWtvM4wQtvdAszp2nQgrxiOJ1WncG7oC
	sm+9Pup5/EZSdU9ev5a4l2doLheP4+tph8PDt86ofWsCoY681W0CieJ+CbkFMFmYXMBTOLtjdf8
	Ph233iYuPlfuXv7BMF0gfN2oZwrg39ROzi+m7S6McBXqsZA4pzzJE2RwLTFDPqKT4S4hIpC88Ja
	LeJGnsl+TUUkSdRCG+jpJgjPAohJfMa5XpOIfKVug8PZCNHZ0kGOHiyKYgrU9Ye5le7zjosYDTc
	B0aUi3y/IJGOose7hAoZfgZQhki+fqgNsOUuQjL/Tup+haDN7/Vk+3iFGgEucgSg5x0W0SB+ZKs
	=
X-Received: by 2002:a05:6512:23a5:b0:5ae:b13d:e715 with SMTP id
 2adb3069b0e04-5b2c1b2ef0bmr253239e87.31.1784970849731; Sat, 25 Jul 2026
 02:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com>
In-Reply-To: <20260725034246.192091-1-blbllhy@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jul 2026 17:13:31 +0800
X-Gm-Features: AUfX_myO98SfNL040OjEUMr3hPrhGaMGef1Ueqf8lgr8fc9mEHJKOewqJMQwgG8
Message-ID: <CAL+tcoDKuJ0QcLXpZg4ROZ=RxRg+FwM+wzdJzmuwQ_5EPPHTaA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:43=E2=80=AFAM Cen Zhang (Microsoft)
<blbllhy@gmail.com> wrote:
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

You sent two patches within 24 hour, which obeys the basic rule of the
netdev community.

Please wait.

Thanks,
Jason


> ---
> v2:
>  - Allocate all packet buffers before reserving RX descriptors.
>  - Recycle partially allocated buffers instead of only cancelling the
>   RX producer reservations.
> Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail=
.com
>
>  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f906d51b6699..383fc2b1de48 100644
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
> @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xd=
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
> 2.53.0
>
>
