Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304024218B9
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822834; cv=pass; b=iP4sEjjQoj2m75oNXSeeBwbyBTWpjy7GFCnUXWKn9ZYjkcOGeAoQO/lVrDoV5Bv/8deq18ObJgXRI54J5Bq5GTRx6swOYyCGW8nErQ3B0c680+yZ+XumPndiFL4wS3UeXLk+n/l5Dg5MUPbJglIwEnVFOtz8FyL4moRsnlEBUi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822834; c=relaxed/simple;
	bh=g0vdLma7xjZDXNlTrA81K4zbu/aX7VEdpvCQsPHac+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Butsuq9KpJGkDo12rFxgHEWp4sIDR7wO5RLmXaBJpKNgnnFlJN1Qh+oqux5kRb382DOknOl2DghOJ2Hv9Q/j1B7AxFiMOTefs60+obIvzORxKCDBCwRcnzhAp1gwsgf7hpllguJHohjmZjks99btXvabal7BzimiG9qXXRDpa40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmHr8s0c; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmHr8s0c"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-463d81452abso6101016b6e.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 10:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772822830; cv=none;
        d=google.com; s=arc-20240605;
        b=dyq8ASG5n4F25uhWKQWGIRmfIW6UjIOveJAT1VwiJlc/WLfCAm5GHRoJdYJuTueiDM
         OCmptD0wnV/OalAtZEG0qN/D3VnFifR4aHdx4G2Q5h6VAaEXaHRKGQDEiPvCLvnUxgGW
         4mK106UC2YedxBwrEqsVupWlHcl5cB6zf2W5DNlYjPgW4S2QSDROT313GyUNU8wgHasg
         hDRK5Y1RdLytnjbmF7gWU3bOviqjbq9YLiaGbdCFItP6qrXyFz4AUqNvzpm0eK0myhuU
         DYHC87iTT2V2Qwc/F69F2Yy9K1IdQEX53Ou2oTeh21p3NHcsAmYbGZ8pxbkGqobDHU//
         JI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        fh=5U8BrNR4wd4v8Kpo9nNtC+1O8E4KtnX7U4wNj2pyDE8=;
        b=VokyLjrKz14KeqpXTHnHPmYjaL+n5GGHdqHtHEsqy6r0jsMMnRTRiW8X151FTfVZ9m
         ZR3l68qGfcDzd/yOp4Vmx76d3M6oB2VdpAc8QByCoUV6hHBaPMefKN4jWwoQlhSXaugl
         S0W83ocl8edP9O5yOgvFDXaXSoCr343HSRuk3LhIe9Afj5DO320jCfbwwZPp+Ox7GF9U
         Ngknec9yXIRmADvwMyChC5/fHUxE3O4/qfOa1cGo37V1+GSOO8fFArlQa4Dax5tCl/6N
         v/4EbJ/DL+r81Un0kZRuFH1YUVd3hP4VKtZxhC6I7ZFmyBzf26Zc5tgHMXBGYCT/EuuX
         +8Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772822830; x=1773427630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        b=mmHr8s0chcn9e8Z4V2k5vT82WPObhdUqH1VWIL3u+SgBxPCX7K7H/zWfUaeRUbZPDQ
         /8aNWcV2emYatTwZoNzn+/HmcN15XVcoclterrH3dxHQplbETRhfZqe+7Jw9jW8oZWFI
         SlRcNLdE9c56m9dWilTrgFGru0S7XKszA9RudPfT9l9349zfO2wC8CKbMzJNkmz9/XBt
         aGVxzA2oXfNuREbhIZ5hq94dgKS5w/areyIRTyvJOC1uk4O2iHUEjBD0BOzUKmN2SDD5
         GypAaV91Ace1NpL+bXe7qM/8Qp9Fw2PL3xYt7KoU1XrU9Y9me6sMKmL+e9lAG4Jy60b6
         8IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772822830; x=1773427630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        b=IYhgW1wO4QHCUWihsMWVStt1lAWAY3ahzeq9VnIF6AL6b5SuukyikS+7xCBt3u22dr
         z12pGlIiQ36cH7cP7RGqAgco5J6LQ1k+G/EJHNf22thbN5WsSqt7yPZ5RSONfkH1yJzy
         MSsY2mp6iDtV6RdE8Q4sM1A6S6Tvto6iNCWpr/0Vej5cbbdQBWBD0RDrP+RRYT5MqoXa
         opUJ60k42cmabPxsp7bKBOjqVPAE96cXiSFq2q9y92lUOYNMd6lZXgpT579YqvbIzyiR
         4+7M1a8lhyH0LF4s/jWLvLb59Ij6ZVC7S2C7LmWrT3r0wd2yjE1PneMZB9YZKGMsmI8+
         jKyw==
X-Forwarded-Encrypted: i=1; AJvYcCXrjYSCLN1IhCXZlb2prxVL2NCF9/e4I7N3IG9aWvTMfGh27jsljt41J8iIoFnZ9kHDAvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdpQzTrvjQppJYwI6wtnuqVhIG3LMy0JK/rB/6RDtPcWAzITa
	N2ZhOzyTdIYu2BruQYJan+9/FO3egLyV/fdugFUsjJach/+OGzBdY6FKhAx+5SzQrvm4JnJY2OP
	J9AX6aYtluUrJOWaCe88WfOkXwiXAj+I=
X-Gm-Gg: ATEYQzzYNMZ0D+obDl2UQMtO6zogDsd2Ff1Z/U73WHJB8SxdUkeMIzV3SvzGAxmJG/p
	cS75EJ49kx4os3nVxmmIRgdP8l53yyktC6GyOfZHYk8onvrtAin9YVpwMUJiHCXP8vosxnDUJkg
	TqkJNx0vxkirKrT8zTWpIwWsAm/hfeV/hctVCix6CCY7aWTW+oILuxOw8uaNjVhCiRywLXoPBBe
	IZ8ZoIbiYVWhNweNb47+GlVY3y8+ifXr4w3/JlMaMb2ni4xUMDBDY5eejtZukt2x+8NLpj+NxM5
	D3K9/j5Tjji0XgLDTw==
X-Received: by 2002:a05:6808:1a12:b0:45f:535:a81b with SMTP id
 5614622812f47-466dca45cacmr1736666b6e.20.1772822829773; Fri, 06 Mar 2026
 10:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305142634.1813208-1-tariqt@nvidia.com> <20260305142634.1813208-6-tariqt@nvidia.com>
In-Reply-To: <20260305142634.1813208-6-tariqt@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 6 Mar 2026 10:46:57 -0800
X-Gm-Features: AaiRm53OuZX6bDZqk3KXf0VBvaW1qaEMHdpnSE_P0kEPcVqB5bhMoCryjsytJug
Message-ID: <CAMB2axO9TLY7MznMYtvbfSp5Qev=W4ZM8EtnxFBs_gM=P9vmXQ@mail.gmail.com>
Subject: Re: [PATCH net 5/5] net/mlx5e: RX, Fix XDP multi-buf frag counting
 for legacy RQ
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 6:27=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> XDP multi-buf programs can modify the layout of the XDP buffer when the
> program calls bpf_xdp_pull_data() or bpf_xdp_adjust_tail(). The
> referenced commit in the fixes tag corrected the assumption in the mlx5
> driver that the XDP buffer layout doesn't change during a program
> execution. However, this fix introduced another issue: the dropped
> fragments still need to be counted on the driver side to avoid page
> fragment reference counting issues.
>
> Such issue can be observed with the
> test_xdp_native_adjst_tail_shrnk_data selftest when using a payload of
> 3600 and shrinking by 256 bytes (an upcoming selftest patch): the last
> fragment gets released by the XDP code but doesn't get tracked by the
> driver. This results in a negative pp_ref_count during page release and
> the following splat:
>
>   WARNING: include/net/page_pool/helpers.h:297 at mlx5e_page_release_frag=
mented.isra.0+0x4a/0x50 [mlx5_core], CPU#12: ip/3137
>   Modules linked in: [...]
>   CPU: 12 UID: 0 PID: 3137 Comm: ip Not tainted 6.19.0-rc3+ #12 NONE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-g=
a6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x4a/0x50 [mlx5_core]
>   [...]
>   Call Trace:
>    <TASK>
>    mlx5e_dealloc_rx_wqe+0xcb/0x1a0 [mlx5_core]
>    mlx5e_free_rx_descs+0x7f/0x110 [mlx5_core]
>    mlx5e_close_rq+0x50/0x60 [mlx5_core]
>    mlx5e_close_queues+0x36/0x2c0 [mlx5_core]
>    mlx5e_close_channel+0x1c/0x50 [mlx5_core]
>    mlx5e_close_channels+0x45/0x80 [mlx5_core]
>    mlx5e_safe_switch_params+0x1a5/0x230 [mlx5_core]
>    mlx5e_change_mtu+0xf3/0x2f0 [mlx5_core]
>    netif_set_mtu_ext+0xf1/0x230
>    do_setlink.isra.0+0x219/0x1180
>    rtnl_newlink+0x79f/0xb60
>    rtnetlink_rcv_msg+0x213/0x3a0
>    netlink_rcv_skb+0x48/0xf0
>    netlink_unicast+0x24a/0x350
>    netlink_sendmsg+0x1ee/0x410
>    __sock_sendmsg+0x38/0x60
>    ____sys_sendmsg+0x232/0x280
>    ___sys_sendmsg+0x78/0xb0
>    __sys_sendmsg+0x5f/0xb0
>    [...]
>    do_syscall_64+0x57/0xc50
>
> This patch fixes the issue by doing page frag counting on all the
> original XDP buffer fragments for all relevant XDP actions (XDP_TX ,
> XDP_REDIRECT and XDP_PASS). This is basically reverting to the original
> counting before the commit in the fixes tag.
>
> As frag_page is still pointing to the original tail, the nr_frags
> parameter to xdp_update_skb_frags_info() needs to be calculated
> in a different way to reflect the new nr_frags.

I see the error I made. Thanks for fixing it.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> Fixes: afd5ba577c10 ("net/mlx5e: RX, Fix generating skb from non-linear x=
dp_buff for legacy RQ")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 40e53a612989..268e20884757 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1589,6 +1589,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
>         struct skb_shared_info *sinfo;
>         u32 frag_consumed_bytes;
>         struct bpf_prog *prog;
> +       u8 nr_frags_free =3D 0;
>         struct sk_buff *skb;
>         dma_addr_t addr;
>         u32 truesize;
> @@ -1631,15 +1632,13 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq,=
 struct mlx5e_wqe_frag_info *wi
>
>         prog =3D rcu_dereference(rq->xdp_prog);
>         if (prog) {
> -               u8 nr_frags_free, old_nr_frags =3D sinfo->nr_frags;
> +               u8 old_nr_frags =3D sinfo->nr_frags;
>
>                 if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
>                                                  rq->flags)) {
>                                 struct mlx5e_wqe_frag_info *pwi;
>
> -                               wi -=3D old_nr_frags - sinfo->nr_frags;
> -
>                                 for (pwi =3D head_wi; pwi < wi; pwi++)
>                                         pwi->frag_page->frags++;
>                         }
> @@ -1647,10 +1646,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, =
struct mlx5e_wqe_frag_info *wi
>                 }
>
>                 nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
> -               if (unlikely(nr_frags_free)) {
> -                       wi -=3D nr_frags_free;
> +               if (unlikely(nr_frags_free))
>                         truesize -=3D nr_frags_free * frag_info->frag_str=
ide;
> -               }
>         }
>
>         skb =3D mlx5e_build_linear_skb(
> @@ -1666,7 +1663,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
>
>         if (xdp_buff_has_frags(&mxbuf->xdp)) {
>                 /* sinfo->nr_frags is reset by build_skb, calculate again=
. */
> -               xdp_update_skb_frags_info(skb, wi - head_wi - 1,
> +               xdp_update_skb_frags_info(skb, wi - head_wi - nr_frags_fr=
ee - 1,
>                                           sinfo->xdp_frags_size, truesize=
,
>                                           xdp_buff_get_skb_flags(&mxbuf->=
xdp));
>
> --
> 2.44.0
>
