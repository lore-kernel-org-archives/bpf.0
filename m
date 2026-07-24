Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED918FDBE
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784865183; cv=pass; b=HVpZ+/ghNPgV4EFAmNY1EHGyAKtOiDbKCxbfu45r8FUy4bGL/DQ7qHiSO3sqU3+iVBcLbW3VSGtcSFNuKbmUz0YSyXQgnEzZEWq9ZBfI2W3uLLqVLlsZE+Uhs0VK7wBp0B1tZEz9/RfqeqaqXflOPUpY7Ivfv6sLZrA2pEDyQ8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784865183; c=relaxed/simple;
	bh=AAt+tQ6x87EqieH4JRZs7DkkGKdTAFNhzwbrdBVNw70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhEOIEISyGH88Sy90LitXIFEy4bP0xskXAjaQe0316aBJaJqoHVSmZhejNEjH4x1ForfObg/FvAYDHVzWUWOE2Yj6Cr3J/oOCjzBGdjxf6wlIjRdcdPcx1UP+fEUSM0+M5pKmrXBYdclWusbVVgy9QrSEE8qAbJemuikv0sSyVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsS/YoQg; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsS/YoQg"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso272118e87.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 20:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784865180; cv=none;
        d=google.com; s=arc-20260327;
        b=Qd2GsE7a2JSazVg7YSp0Rt2AeiNv5myqxqRei3OqXLk101zZemS+uMG9fE6UOB5GwQ
         F2sU+kgwqwA1IEir0gtVyyJPxk9drqj6HE9kCcaoX2WkOVPo7qb0oPXd9zbrL9TVQBg6
         W6KYotVImCroJUYpwRXO4hpfKh0nD2SfKf2q8Fle/neGLExBKNEjFi9KiBTRsRSBSOiI
         EvAfWf9FblMfPF7oJFK/SV/X6wuSmp851J6GxDVQYuD1O922o8GDhZGWtl+XPWRwg3Xc
         WFAV505iZRmPIaPTriLN1wcB4YXlPv/dhsfpYCxfp9cCOfmJDqJSE+cx3OtOpSP7vPHS
         MHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ftf05G7vMLewqh+NOKCr0DXGowg0XyqdXBUvxLAZFjs=;
        fh=RscmXjB8Kou97Hxme7PF1I6eyS6hPdGu3cCInxRfecY=;
        b=UoyOAF9jqGwXKG2xPLDJOLoAiT5iEOB2PndP4Ccn99l1Mih28t9MARNruIaszeapG9
         sYI11h2uvUNQUhQkmU8rxktBZHZq+eZBDUYZxxPuBCbfIGlRBW9Zg2LgVb30C4Tis7Nr
         dTQLd/Apyg3P6nDAuY6MyhV9Y8W8i4/R4KtsOEIWVopB5UHHs1OGJwkIA7ZT6Z5RrfuY
         9s++yoWofggIZMfZHOUO7Ck99NLErjpiAA55uTlj0VrjEkOX8gRKxmlOOBh2vO5aHEPp
         tHZZqomW2GS5j0tSWnbtPXtonoi2DJsjnkDfopUZtDUwetiLo1UXQ/XMqJrKJJZgqZJe
         I3yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784865180; x=1785469980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ftf05G7vMLewqh+NOKCr0DXGowg0XyqdXBUvxLAZFjs=;
        b=JsS/YoQg1vILJIMppyaqyKaPGcto84rRQ9eGuFvb1Rxc6q4tT2V+kw74vQU+m6Fg3I
         3b2tPvZq45UeQJAA9zhOCDBI9A8QtNNtKrOZWGRWcAZQyCbqX/8M3XsZqLhm7YWapefn
         uW6icMgkzxi2JhQZffDisAiWLieT3WTkrxbVL5mnpopnnvz1R43qScjRdnmVLzv273c9
         bhBJqmQce2ioaeXheSfyNEm7bJunuGXj4WVOtupAOdX6NRb0xTimlJCYFt3O/lF5k3ps
         Y920RdDR58JRs3UIxsz9Q8DkQug0+X/WeNbarbGvGvc1WTQsQ6o4+3/GOS7DxBcU/+qE
         fUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784865180; x=1785469980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ftf05G7vMLewqh+NOKCr0DXGowg0XyqdXBUvxLAZFjs=;
        b=laMmR8+SHDUauV3B/oPPz0LgzAyoUuqp3tjv491k9hASOY7tsl42NuH43KkYJZWXaM
         LT+5MW/3mV1eyWzMGtULM9AFSfC4G0pjPPPdtDC+1G45JQJp4IIBxQWJV84O+X/s8Vih
         u21ldKMdzJtE6c+i1n+sWvrLReHYbABSD6IRP/BjOkd+Et7WV0WHm/43rnOetGEGALjW
         o/4zBFXcYoWLtx//ViRhsy4m0mXsk4u2pKoRHMM32m10lffEN7MFa3wTwdV/ZcfLrrSR
         mRBBIr9HysRHXaphOOjo8bwgVgpDKlHBSjRZz5zy1ssNwhEhF5ucaOAPYv1bWfkCh4ki
         QV2Q==
X-Forwarded-Encrypted: i=1; AHgh+RofPOVPPjyHBNlDOs15RnTVZW34cXmxVv7k5UBeB3dhncpg+Dp2dvRj9YQE2PKMWXVYcZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkTd4HsJhHZEoHlQnYS2nF+nhm5zJNXit6gqX7ORLeOPHKT/z
	nm2ABFznRb2SlxzjK5ePc2EZ3qOpxikw/EHK/U8OiSVYLgIhEQOL/3lHFAzeg9kVnx/vxfUmrqX
	yShKLQpOaiWH1HuYet5UUp/dfNvMCAlhlWWpHgS+3
X-Gm-Gg: AR+sD12w/ijWzBm9nzCUPAznujzvRG5pZr8fPwEZNPszY/wiH2GMTn3cmjLFnmXHO3w
	25WZ5O3ZNPWVlwfNHV+Ny4TEeWNRt8KfkOgxS7WmPhJIKIly8Bx+gbcVj4KZfpChVZpZNxDmSmS
	gviUjxg9bWOdYgttTvMs1VxpGNCPj8y3qvoUYvwp9jGx3jd6HXBBoln8ywLO4oUbqJxGPfKF+eG
	0EMe82oE8QZ+f7WCS5LQltVRUyPpsTacdArA9D60+eIna88jDEH5vJuVnvZxAw=
X-Received: by 2002:a05:6512:3d9f:b0:5ae:c5f2:d213 with SMTP id
 2adb3069b0e04-5b2b2f67b63mr1221389e87.36.1784865179576; Thu, 23 Jul 2026
 20:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com> <20260722221634.186886-3-joshwash@google.com>
In-Reply-To: <20260722221634.186886-3-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 23 Jul 2026 20:52:47 -0700
X-Gm-Features: AUfX_mzF6EYoyu4xTYrV2QSuc8p-IbH2jKCtRe-AL5nSaRF13COF7cND69QiJRA
Message-ID: <CALuQH+XRWpy6_jKh=14MfBGgBrxWW+F1wrbNh9zD4Gb=9=Agug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] gve: add XDP metadata support for DQ RDA
To: netdev@vger.kernel.org
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jordan Rhee <jordanrhee@google.com>, Tim Hostetler <thostet@google.com>, 
	Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:16=E2=80=AFPM Joshua Washington <joshwash@google.=
com> wrote:
>
> Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> exposes support for the XDP RX timestamping metadata operation in the DQ
> RDA mode. While the operation works on its own, the intent was to enable
> XDP metadata support for the queue format as a whole along with it.
> Currently bpf_xdp_adjust_meta fails because meta_valid is set to false.
> This change updates xdp_buff preparation to set meta_valid to true, so
> metadata can be fully used by XDP programs.
>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
> v3:
>   - bfp -> bpf
> v2:
>   - Fix referenced commit in description
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 907a0c15bf30..329a2585489b 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -882,7 +882,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struc=
t gve_rx_ring *rx,
>                                  buf_state->page_info.page_address +
>                                  buf_state->page_info.page_offset,
>                                  buf_state->page_info.pad,
> -                                buf_len, false);
> +                                buf_len, true);
>                 gve_xdp.gve =3D priv;
>                 gve_xdp.compl_desc =3D compl_desc;
>
> --
> 2.55.0.229.g6434b31f56-goog
>

Sashiko says:
---
>       if (xprog) {
>               struct gve_xdp_buff gve_xdp;
>               void *old_data;
>               int xdp_act;
>
>               xdp_init_buff(&gve_xdp.xdp, buf_state->page_info.buf_size,
>                             &rx->xdp_rxq);
>               xdp_prepare_buff(&gve_xdp.xdp,
>                                buf_state->page_info.page_address +
>                                buf_state->page_info.page_offset,
>                                buf_state->page_info.pad,
> -                              buf_len, false);
> +                              buf_len, true);
>               gve_xdp.gve =3D priv;
>               gve_xdp.compl_desc =3D compl_desc;
>
>               old_data =3D gve_xdp.xdp.data;
>               xdp_act =3D bpf_prog_run_xdp(xprog, &gve_xdp.xdp);
>               buf_state->page_info.pad +=3D gve_xdp.xdp.data - old_data;

[Severity: High]
This is a pre-existing issue, but does accumulating the XDP head adjustment
into buf_state->page_info.pad lead to out-of-bounds hardware DMA?

When XDP programs adjust the packet head, the difference is accumulated int=
o
the pad. When the buffer is recycled, it appears the pad is never reset to
the default headroom.

Could this cause subsequent reuses of the buffer to continue accumulating
the offset and eventually calculate an out-of-bounds DMA address in
gve_alloc_buffer():

drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c:gve_alloc_buffer() {
    ...
    desc->buf_addr =3D cpu_to_le64(buf_state->addr +
                                 buf_state->page_info.page_offset +
                                 buf_state->page_info.pad);
    ...
}
---

This is not acutally a concern becasue gve_alloc_buffer() always
resets the the pad based on the page pool's offset parameter. This is
something that would need to be accounted for in the case of DQ QPL,
which does not yet support XDP.
