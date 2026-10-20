Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792476565;
	b=GaBOXUDEMGT5oDH5M7XlyDHZL95JgJ3EwXtycKa8rvIzl+FBFWnGIFTIXhBvL4iQ/j0I
	 5xIZltzhhHH4I8uviINgVYEU7aunn3mp8P88ZUmZmDwl86T93ZZz+3WyodUKQ5Jn2CCeu
	 7X+NT38aJ+C+8dIh3jNKZdTw3zDOQ7xr7FATo37pRD90mSFzDEBhDMTJe6Jj8j6O3+Sey
	 EKfdxFc88d2vf4gD0Jb8Z0ggx9/hFRmgMMyBhV2+5i7P+8nhr1diS8vYWbSmUEsSFI02O
	 yoGoFH7zVK7S5kLTbPcMk+mLb4ZlSsAvToa4kDyzxxpE7JF5QPXeMSqjT5XNQtmRayg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
	b=yiTvUK8ie270tAkqCHvWHRQpwBTSN0a60gBHwNL0Ysp5UYnCK3qVS4TDFHoN3t4Jjxzh
	 LXmweyxQbymYNMXgk+lNpiW0yTBOQoHKCzo27uvFT+1AI56ukGL1sw4hH/QYL6yH/ppu8
	 HsHcZjjlOixEw88mx2C3m2K5KHQB47a9aDpYRwHzHHWNcQ03kHR7bmWoC4w60sqlF+boD
	 HnrHxYNH9ixKYt9e0P4mJ6/AWVnAST++HLqxEUpFxiAVOpgZ6JGfJZjkgMV8U4N8yhON7
	 CEEcwHrKN16INsFkxSpsxp7jSIdVwNCrGOEWgfL8H3Azu+2+Dos0VUPgXhHTR91OcrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UE/4oJGk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0F7606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 06:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F0F7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UE/4oJGk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9e53d011eso11961185ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 23:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792476564; cv=none;
        d=google.com; s=arc-20260327;
        b=cmDLzO8Bi5D4HeItMdL4+d4oVO0R8D2MqQQNw+A45yAoIhburx+HqUJqBhqj7UP8CS
         fFllWTk/VkYY5BIl2RdPn/AYAt/YhVYb8+X0wShghkuPVHGL1YgwTeikNSpBBpOZk5Be
         4mhLgcCV40SCsTyFnVtxLb1uUA0n1av00E7AsXxy4F6g+PY2RkiSfwJRN077gBgLBuRd
         K96xpu0XS3LCYK70ea0P/H3GE/jzBTBslI3qIPB+2lqxw5Gudji+zxMRfr9Xk6gGvegA
         a56UrmbO0kavuZ6XUedJU6ZX4xyylduXhUxKRdsAAVpOimnFI4g7QaxDLMX1Kae4p3De
         OHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
        fh=sSTQ/HZv30+zsyVfcXK5UyhQqy54qB04AGsypbr9P3w=;
        b=pTdgTtwfEwf4luBk+ut/Mjg2+Rpr2vn7lkS2WnDX7cwWLBBOfkqBTyVB+uybTvvnu0
         Sl/NEBXmwOAyv3qjlsQTJRm4fqmSmtnT5ap3dZ3s5Ek6op9EINf590pr38l7BU11lcCP
         OEMxlAhLbE9Fzt5QTmbEjb9PBOe9ZTV6FNMcedDBDPCblY8aY1QLUM8j8wNKkK1P/V55
         ypeo7njkd0Idm8NcV5rm5tFhKtqyUUbAHfu0zWIMUrgxXwiB+SBAlKKIEDMg8z2U7MlC
         p/OT+hJNQNfna2uHfIxkqCTgZ+NiR+S/Wce67wVnhKoec4UtP6pJsaB/0yZq9VbahXZX
         67fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792476564; x=1793081364; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
        b=UE/4oJGkhT1gT9Xw5NZpc7ld70sOY7OfPe4yNnKKhXjU34WbDz9h1eP9n+Sm2R+iks
         7s37xfSjkwQC6qHvOzPiD1FDYxCKLlEZ0M+zKMtPV95fkLkDzcd/LVVNOhzT+DuHtcuj
         rAaZTBwd+D1d/rADkXXWJ5U5dMgwsrHqGaOF0ZIcZt10myc6vIZvL+XSJBVdqaI4JHbP
         j2C1OcRnQFfuLzpRTty3xHkD9pOvBxZbFW4ZXZBIENWxzhKus28iH7fwir3hW22UxRDw
         g6aLij6mN73RQOAKCNRYq0yIUzbd6ddDvZqV9us/cXJ1QnIC22AFA74JBI/yLgOInXCO
         MBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792476564; x=1793081364;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jlBMqWrnKdF3kDItdCwsVZrOeSHrOAQ67ICKgOgsRc8=;
        b=yxdwcuny5A/TJbTxg7kNQkYDSYASOxXzwUr0n9tZrah1ZpmfVNuvWCX951be6QFENg
         LK13PrVPCg/Tft5RDfaOk+v999vzHLanCxUNKDqbrUbCu+IHRog4nwqT64zT2vgCYh3+
         3wgpzSqMjXqxtu/B9W8a8YWr2cUeMulTHERLY0foU/fZ9BXsNRs3crSGP7+f7/DakV1+
         AW0SWPuu+QG3opFMYIlXBU6MDNyBXP+gAZ16sT0GJzybAcU3ErkgREwVAxuGvjj5Ychr
         2i+nC4tS+syMhS/BJPJG4gMqfJI3QMXOBKLjTZmN+wg/hidDlXLcZr4wz03ClgNh2qsd
         zJog==
X-Forwarded-Encrypted: i=1; AKwUvBymq5LUNp9ZPBpQhWYbOcwsMG3Q0sJMtWeq7YqQvnx7oFIddht1O3pqS7imd6fTfPzhSgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWEKcgzjO0NsbEsPZe/n7nfuOWn990VaCpyD7cHl8dfBf1FbE6
	gzxqWlMRH7nXZw1jYE7niwYOz0YZKnWu3t3OvCHfTea0djPk/96eEgZkM0Zf+tZPSCdZN1NjZKl
	f960E+EKvh9xoP7hs/Ofz+K/IEpvFlx0=
X-Gm-Gg: AYBFou1ed39zSwpVqeLcInC8JOfoQC5FT+1J0G/tRtfKLUucuMhuS+ZvLMk6C0t0VIW
	i72HaY+eYlbcygnGciyyGk1dAW29P4o5RQlkDomU/RLdoWPZOsS0XamElclPAHdLqSJ6kgvV8cW
	YdK5Gej6QFsCfOBnS/MVcU9U4EdfD8Zb7mVcDEKEvN+cIIaHMwMNRPcN7QBTIyWYaENEafGBeae
	Pt+94rU7XFIPOdungBWRKw10Ql2SGqPr52/45aOezSDUvo4xyZjdZDN8wr/x7F4G1CrWzGj1vhH
	plTirSw7UQ0MKtegGlNdKNUQP9qRnz9+2IF2+FGsnJXscWTNl/3hvEiO
X-Received: by 2002:a17:903:2f88:b0:2e8:1d5c:f6f2 with SMTP id
 d9443c01a7336-2e9a69f8f83mr83802375ad.24.1792476564489; Mon, 19 Oct 2026
 23:09:24 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com> <ataHK9s/MpNgXWhT@boxer>
In-Reply-To: <ataHK9s/MpNgXWhT@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 20 Oct 2026 09:09:11 +0300
X-Gm-Features: AclHuK-XbUcddl9KosRGKNZXHh6f-ueh77OfYnuvOwoLmpUVjr9gfpKt9gc-2dI
Message-ID: <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: marcin.knap@vecima.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Oct 2026 at 00:14, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Oct 19, 2026 at 10:22:02AM +0200, Marcin Knap via B4 Relay wrote:
> > From: Marcin Knap <marcin.knap@vecima.com>
> >
> > When an XDP program redirects a zero-copy buffer to an XSK and the
> > socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> > -ENOBUFS to xdp_do_redirect().
> >
> > A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> > drivers rely on that: mlx5e treats the failure as XDP_DROP and releases
>
> Sashiko report shows that drivers are rather inconsistent here

A note to ourselves, we should write a section in the documentation
for AF_XDP that defines the expected driver behavior. There are very
likely more inconsistencies out there since this was never explicitly
specified anywhere.

> > the buffer when the Rx WQE is refilled, and i40e and ice free it on
> > XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
> > another Rx descriptor, the second free puts an in-use buffer back on
> > the pool free list, and the same UMEM frame is later handed to user
> > space twice.
>
> Did you verify this or is this rather a speculation? xp_free() protects
> against double-free cases.
>
> > On mlx5 with striding RQ this also ended in a NULL pointer
> > dereference in mlx5e_post_rx_wqes().
>
> Please more info on this then.
>
> >
> > Leave the buffer with the caller on both the single-buffer and the
> > multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> > do. i40e and ice relied on the core freeing the buffer on their
> > need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.
> >
> > Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> > zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> > with the Rx ring. With this change no duplicate frames were seen with
> > striding RQ on or off.
>
> Have you thought about massaging mlx driver instead of intel + core?
> Even when that would be correct approach ixgbe would miss being addressed.
>
> >
> > Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> > Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> > ---
> > Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> > The i40e and ice changes and the multi-buffer path are build-tested
> > only, as I don't have that hardware available.
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
> >  drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
> >  net/xdp/xsk.c                              | 15 +++------------
> >  3 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 9f47388eaba5..d32c7255f0b3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> >               return;
> >
> >       if (xdp_res == I40E_XDP_EXIT) {
> > +             xsk_buff_free(xdp_buff);
> >               *failure = true;
> >               return;
> >       }
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 0643017541c3..7c1dd4c87a71 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> >                       xdp_xmit |= xdp_res;
> >               } else if (xdp_res == ICE_XDP_EXIT) {
> > +                     xsk_buff_free(first);
> >                       failure = true;
> >                       first = NULL;
> >                       break;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6..0edc160c660f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >       struct list_head *xskb_list;
> >       u32 contd = 0;
> >       u32 num_desc;
> > -     int err;
> >
> > -     if (likely(!frags)) {
> > -             err = __xsk_rcv_zc(xs, xskb, len, contd);
> > -             if (err)
> > -                     goto err;
> > -             return 0;
> > -     }
> > +     if (likely(!frags))
> > +             return __xsk_rcv_zc(xs, xskb, len, contd);
> >
> >       contd = XDP_PKT_CONTD;
> >       num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
> >       if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> >               xs->rx_queue_full++;
> > -             err = -ENOBUFS;
> > -             goto err;
> > +             return -ENOBUFS;
> >       }
> >
> >       __xsk_rcv_zc_safe(xs, xskb, len, contd);
> > @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >       }
> >
> >       return 0;
> > -err:
> > -     xsk_buff_free(xdp);
> > -     return err;
> >  }
> >
> >  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> >
> > ---
> > base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
> > change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
> >
> > Best regards,
> > --
> > Marcin Knap <marcin.knap@vecima.com>
> >
> >
>
