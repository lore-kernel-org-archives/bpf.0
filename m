Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14852D12ED
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202909; cv=pass; b=FYGsuNj0DSe+F3/wNkJZWW32QMbmaWuJnj8Sdz6vO0C9/UmfEWDrj8WQdyOpskZo79RN9+VMtymb5bJuARt9CW3yrXkQ55y/Lt4SpGY5ihI9uiBdGqX93+S853VtJnIr2H1DTGLykqf3mBXMHHjTggkUnkjSz/UkLGNI7MwCusg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202909; c=relaxed/simple;
	bh=MfukvMvTV2NaktHGYa6MFCbP0F0PQy/xKxbXx67rV3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXM4XjzeRBoS6S4CsNIaLvSJ0eCTNrgleJfIvyWLkgWQPvvoDnFkKx0NdVT5A8H2B72HLcDlCQhHvME9x9vnVDikgWIl6RGjDiAl1jFHp2tc93pmfn/jEXK8DC02TFK26wgJpOu3ZKU4Wxw5qro1wg6VscCtW7Na/L3Ju8vtdDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJxRgHfx; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJxRgHfx"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso3033764e87.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 18:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785202905; cv=none;
        d=google.com; s=arc-20260327;
        b=ljlFVC9W3NWIM1kTlBUbn6l9l9DdoC+lLlInrrYa8WzHQoHK6qDqis2w+Ap//STy3Q
         Hn9MlQaKaF7JgUkf3Rz7PZfAGdMj7uC4CXbSrvHaxH8r6zXtMy3pppN4OeaWRpcxfr6h
         8U3TUQxMRUq3LuR1NAceCEjuwNnkQ/5N6VDxFbDCiDiLGo8keeT0d/yRBrmO8zqrgo3q
         tJMIAzjpFpix/JkuEMgDkWd+a7Y58xCx0x8Sx9GTVuijk/oapH5MitwokVW6g3C5vlLv
         lpuptI0/fAtz0T+kBd3attwNvxRe5AHEmVeKzLxppzRpCiu745zeHRfFal93tq172slc
         pSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k2lOBcWQbmiHRmtMLTg8SCSxKUj0i91nJEcTvqu4FD0=;
        fh=fzbP4JAa9aKfisuNp05ZwIwuntmG43oiPw3WKKTj1fQ=;
        b=ZNdCtZIP7dYU5fLt7rDY+MPtTNE2QpP4s4t+FsXs/1nVPuGjD5Njh/rhkHjQLAlizH
         D9HLexDi9tt3Fh5o1yi9QUuK9pF/MdIu/OYYA16hqlZKaSKPz/9im2UN5h7NFt3iPtim
         TsUFyf83PE8ro/ePQ8DnnIZBcWx/leMuh+km9wQVw1tDLlIxq/RjohrEVFdS+esViKQL
         G9KCpZVp+ZPoSxYxE2K3GhoPTArfs/rGyELMapo4wz5oWQ5ocUWwXc+E1h9yD6FLCwZC
         I4apLnygowIoSLuZPIBALayqoWt50jLOfFy6gwTnK6iuUaR26yBDvNJxoYUhGe6opRrT
         tflQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202905; x=1785807705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k2lOBcWQbmiHRmtMLTg8SCSxKUj0i91nJEcTvqu4FD0=;
        b=BJxRgHfxS2MkB+i+LW6V3lQg3ymDCHrb1r3oJkeW0UE/dt+Ktjz8PuTGmvWIoRBlI/
         o+SOOqUwUgpqXdoab+/M5oQ/LG0QmfGbDGQ0X9DwNZdK+oLM9LDfH+1mDZIFOx3wpUDC
         IK5MN88tQgFDgvT3Ugb++b9rprYTxgmrOl6lXYdKQengJj5I+cYsHKmtE/vPhWBgRsYT
         8M0cC+tf4XSYzqk91WtE3kddzV1nZ1nbZA0LNDOwnJ/TBYk0HTpnQULAXvu6IQyKcia9
         0LrxIh+lAQB8btWlYlZQ4QlZ8jSYC5j2f8BxhIf84zvhWBq2cSai6ZZ29ej5BJvqj4Ty
         Pq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202905; x=1785807705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2lOBcWQbmiHRmtMLTg8SCSxKUj0i91nJEcTvqu4FD0=;
        b=p3aIPgpiAufyqczomh09RmN/cLKyoK2WzSc+1AcMxKYwpT50lDyYMtf03ACCA+ULc+
         tTXq6kBFDtPUG6IsOcWWNDsY+BCL4nAeXRhMHjY7NlzKNdmx0ti8CwobhhaooY6OnQJL
         eztHA7C8GXu9EEpKi4dlU6sZLvStAoaY0KDUSW+6ZJvrXRaJmLg/NqwKdODNCfkwHE1y
         lMsWmnJStQediyYwGBgk8fO6Q0RBuOta52gs/xSzZ4vMHdwJLjZjSOmzp4dFBduer9qU
         iAAGYKT94purlqepjE21gkPTCe8xroAifBh595p3MIa29xMCvNEwoM261hEoJsn4rOL1
         U0Sg==
X-Forwarded-Encrypted: i=1; AHgh+RpqT6SvzdKWYNxDf2ceyguGDj674n/9XgyC0+v7hfsAGh4SN1cO9dX+1918G2BeDDwMbNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRi2lF3V2YhWKpoRdejFGF8B1BAAdXNobU29m+PTtpAt/Fzuw
	VADWcXZ7qso8i1aA6msL2HE7EQ+4OxlFxFCum4NYg5khlpkOlW3rBTlDnJUf5c64PvQRCbnimPt
	V7mXygyeY+3KymN34HGDbhpg1yjlVqsE=
X-Gm-Gg: AR+sD10rxnS7Z6OLad9B0wP6QKn4+ponWZ2+IQ60s+bB92vrypjQXuiIuxHeS39ed5M
	wPwh/NqzSdRYqQo9Wm+YJeRefJeHxN4NNEjPn+B6LvUoRhFF+mv4fpmT51OJengQboVLOwtRjy+
	ArayMXjUGlr+lFLLpBI+x0TzjKJ2NIvVHdYILGBCkqrKcMLvkrOvjGThqS+4rjzPKvSrxjU0Ta1
	qb7vEH8AgqXhnK4N2CTpNUCEmw0dV/aXaTifJy8vox+vZdVykb2c6eHMPkH2CzNNFzCyGGPUQME
	LMueVUa5j5w1j0OBSgAH/H9JzdyawqPKnCuM6XcW/ljGtZ9VDGvvCVlJsv0xLpX1nbzSUxYyDUI
	=
X-Received: by 2002:a05:6512:2397:b0:5b0:bc3:dbeb with SMTP id
 2adb3069b0e04-5b2d021886cmr47331e87.17.1785202905179; Mon, 27 Jul 2026
 18:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com>
In-Reply-To: <20260725034246.192091-1-blbllhy@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jul 2026 09:41:07 +0800
X-Gm-Features: AUfX_mxtIV_a4iNYz3Ho_y8NgLDjHps7lRnbEvFITC8EVJHtP1QppvSrWmPMsME
Message-ID: <CAL+tcoAi8zO=wv2VRwQdFwvBeRzFfQH2ZqofF1G0u8RhGL115w@mail.gmail.com>
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

It will cause a memory leak because the current xsk_xdp that is not
added to the local list will miss the chance to get freed? And the
empty list_node cannot be easily freed by xp_free()...

Thanks,
Jason

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
