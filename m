Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B882EEE63
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864404; cv=pass; b=TTbh8E89FSFNXYnWWs9MYPYQn2EQTbRkFoMo8z3pUDrb21/l82r1Pbr7coMfoBQhnEOeqfbSKdEdcHv+tcJU7lO+Tu14xtzuJYoAMBcIAuJynynczveK7JG0E6+FBDB3292XACnhPpIu8Uz5ssfgM5SaIGSsftSvel5KhucJWTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864404; c=relaxed/simple;
	bh=pB8/V3XlrG5omt7Gz5mMSVLoHIr+uYCl606AtWvg3WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwH680kFV/YNhbkEKXvUwQYbpsx5LKyCIE83KfNuVshVZPJGy8Y0EabMgmKC8yWxx/2cO0LrimToHNVRZ7gKljwvWSxNuyR3T8hfFMDxcTyiNvSFU5EViKRZoCqYvRJ0OvSFSSpOjwf4atrgkjz+z2fDxvg+WvRzkPCkj6/mAVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bjjrxLZ+; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjjrxLZ+"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aec201b582so1363725e87.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 20:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784864400; cv=none;
        d=google.com; s=arc-20260327;
        b=ofA9l/IgFlfetW7/q5WsRrlWiR4VbTBVEdR6Bw0IDCeoRQUDQsedkzxMJddvxAwwed
         bGiN9KrcU7/UGHU+G5g8fzl4lerQ1TxUkWPIRTGIZjgs6lx4U4/NZORslUu7Ue9r+ypI
         sX4dUK3E9IUxmXMwgxGJfiTaTeRlAK9su6C2RUEvgflLcEoHvOljTG6PIlypm30afnbW
         cl7aWq3yggYqtIoLo6qf+XFj+sryA6PAQd0AbXPtj9MoruYCXsLPhJvXNBz3m1aA6p/4
         /bav8D+NU1C6MfE1bFn3o0Y1Z4Th8S4/jCZvIAKcwMWEy5JHThB7j5jj/LYKD3/BCrGV
         i9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        fh=EI9h3kv2pjMWc2Z6LOkJ5ObhZKkfLXnPxO7VzyEiun8=;
        b=PNyaBWHDA6mi6v2vpQOGuoI/AjQUTQxW97jRsO14AQp+jcVzHX9ZpBVYwbeREqzJ5w
         FKKSmJV4rWJX8eqvHX4yrCW+Im4dRKDBYorWY8eVFYPuXSnljgVjHDbYs3d6On6fWu8s
         dqy7dwiG2I0UfPC4iqHyGY5eNKw8kOxAfAQA8Pbvpd8z4V+ufeS4uyDy57LGF0FYb7zJ
         vhluTD0BTKlmrh+8XaDep+Df5OLV77waRiHfAc2f6NIHDO8ztCSYhSd/ui++j0F37Ajq
         EX4VL6FlGnGaOhrhysiUmgCUgRgeU9czeQJZvcpWNVnB/sXM+HQamV1KMlIrgGjChT92
         eA5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784864400; x=1785469200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        b=bjjrxLZ+i/gWyy5RQCwU8Vfgpz+ENMx1x/29cHdjXXaRjprqEu20bNsYRUGrzO1jdv
         57xGK6z8HCfD/0p2h3Rh4fsoTIqPXr4iW03mu1af1pWWxCtd2yY8ueP4+vGcgll1O1gc
         +bDfY3CTFSwDR+8idN2dOZsN0p7tWExLG6Fj2T6oQKhSKdyQ68aQ2dRWcjYVCwrZoLct
         EKeBCcZ5ImXdhDvWFddpZPelArV8vkSlk/TbX65jo2HW5m09I4saBB27nwhZ2CdLSim7
         IKcz2nNiXs9lHXGfqZrKPbGFy0OcvkU3IT9UX4zsr4TyKFFAVVy3drKGvCmHal87mTxF
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784864400; x=1785469200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jUaUCz0UWiUWGL5mMfIye/RyD1iev9TqicEqDX5xhA=;
        b=GMzII26nJcyUoVjSA0taIN74hikH61gl3qy/xaACWBrbv/GaJzgcKMPXkKSRT2my5N
         ZNW1vDRToUpVnwPdRNhMlSZtpTMeqKS64f2i8WiX7rYD2rpusaHCyJFtYTNW3YfFnfML
         clLGvxYR0xj4Qm9xas0XuP1wVKRQoCBhFYsum2K08QPKPxNvv3it3A9Sb+Vp7dGyFmtE
         CYDJSXR5M/K8A+Er+LX8/vEtppDuTov0Ko7IP7v6E8Aah6ps/OYeK6dIbIYnzFwlWY8N
         OnTCLmsZhL0eCmk/tLhfHpCg8lHQlylnwqm4cbSzq5fVOR5TUS0I9f94bef0VSdR1DyB
         RYIg==
X-Forwarded-Encrypted: i=1; AHgh+Rrv+Rv9h3qYMhac2skk+ziiOyUmSI4K+96X+87fJMJ/FUkxyTpLCW84xwtainp4K4M0RMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3zsToB2jm58XIsik6oTVJvKIdby47e+rpMz1FosXS5pRAGev
	l3sNalfbPsI5+p251qml5NwOKIcgyr/2sFeDVMS1a7Eax+rTfxluCuPkVDamb16Ga4xfQ3y98LY
	9yIcAH3aO9MCAZZmUVdGexOYT2G1IUCIHJqSJSsA97ZtG62/dgDiLxCCXOz4=
X-Gm-Gg: AR+sD13+ZK4kvky85JDAiHWAGoM8in9qE/JYBqQkg462TJyTd/g18oLBaSqSvrmT8N1
	Ct5V+8qkehQqV48cEotvtNB5iU0cvr8QhjSZtORKEMR46HW38lsU48z5SXcHF5zET/Iz3T/dZYy
	atrFTsdgHizwb6PHXkUrRsImw4CDFv05kRMWyOoROI2JYjyI3SPa0ubnJzC5sJvR5BBqeSwmozw
	zW497zP8zUXX6euzgG/hLB2qnZQTVXG0YlhOmgVOYIGIb7TOp6WPXKz1Cnx1WO3mCZUSPSvqw==
X-Received: by 2002:a05:6512:8019:20b0:5b2:a353:e4af with SMTP id
 2adb3069b0e04-5b2b2f7a8ecmr887529e87.56.1784864399706; Thu, 23 Jul 2026
 20:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com> <20260722221634.186886-2-joshwash@google.com>
In-Reply-To: <20260722221634.186886-2-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 23 Jul 2026 20:39:47 -0700
X-Gm-Features: AUfX_myiu_NuloPmeS8ZU_Op_ds7ofTLCGS4h_nAjcrnVJa1oicB1rvJdCghtG0
Message-ID: <CALuQH+UFf2oWTnrSK6mW4+PAqPTyfwJ55Zr8hNF5MTPC9KX2wA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for
 XDP_PASS case
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
> Newer common methods have been introduced to construct SKBs in the
> event of XDP_PASS because many drivers replicated very similar
> functionality. Update GVE to use these common methods for copy mode and
> zero-copy mode.
>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
> v3:
>   - Newly introduced. Ensures that XDP metadata is passed onto SKB in
>     XDP_PASS case.
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 02cba280d81a..907a0c15bf30 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -736,8 +736,7 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>         }
>
>         /* Copy the data to skb */
> -       rx->ctx.skb_head =3D gve_rx_copy_data(priv->dev, napi,
> -                                           xdp->data, buf_len);
> +       rx->ctx.skb_head =3D xdp_build_skb_from_zc(xdp);

Sashiko says:
---
[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally
overwrite the SKB head on every fragment for multi-fragment packets?

If an AF_XDP enabled interface receives a jumbo frame (e.g., 9000 bytes),
the hardware splits the packet across multiple RX descriptors. For each
descriptor, gve_rx_xsk_dqo() allocates a new SKB here and assigns it to
rx->ctx.skb_head.

Since this ignores whether rx->ctx.skb_head is already populated from previ=
ous
fragments, does it leak the SKBs of prior fragments and truncate the delive=
red
packet?
---

Multi-buffer XDP is not supported in GVE DQ.

>         if (unlikely(!rx->ctx.skb_head)) {
>                 xsk_buff_free(xdp);
>                 gve_free_buf_state(rx, buf_state);
> @@ -745,8 +744,6 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>         }
>         rx->ctx.skb_tail =3D rx->ctx.skb_head;
>
> -       /* Free XSK buffer and Buffer state */
> -       xsk_buff_free(xdp);
>         gve_free_buf_state(rx, buf_state);
>
>         /* Update Stats */
> @@ -899,9 +896,17 @@ static int gve_rx_dqo(struct napi_struct *napi, stru=
ct gve_rx_ring *rx,
>                         return 0;
>                 }
>
> +               rx->ctx.skb_head =3D xdp_build_skb_from_buff(&gve_xdp.xdp=
);
> +               if (unlikely(!rx->ctx.skb_head))
> +                       goto error;
> +               rx->ctx.skb_tail =3D rx->ctx.skb_head;
> +
> +               gve_reuse_buffer(rx, buf_state);
> +
>                 u64_stats_update_begin(&rx->statss);
>                 rx->xdp_actions[XDP_PASS]++;
>                 u64_stats_update_end(&rx->statss);
> +               return 0;

Sashiko says:
---
[Severity: High]
Does returning 0 here bypass the copy-on-demand safety check for XDP_PASS
packets?

The gve_rx_should_trigger_copy_ondemand() check at the end of gve_rx_dqo()
appears to be skipped. By bypassing this check, could the networking stack
hold onto the QPL pages indefinitely?

This might drive used_buf_states_cnt to num_buf_states, exhausting the buff=
er
pool and preventing new RX buffers from being posted to hardware, ultimatel=
y
starving the RX ring.
---

DQ QPL doesn't have XDP support, so QPL pages are not in use.

>         }
>
>         if (eop && buf_len <=3D priv->rx_copybreak &&
> --
> 2.55.0.229.g6434b31f56-goog
>


Sashiko says:
---
> @@ -894,14 +891,22 @@ static int gve_rx_dqo(struct napi_struct *napi, str=
uct gve_rx_ring *rx,
>               buf_state->page_info.pad +=3D gve_xdp.xdp.data - old_data;
>               buf_len =3D gve_xdp.xdp.data_end - gve_xdp.xdp.data;
>               if (xdp_act !=3D XDP_PASS) {
>                       gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp=
_act,
>                                        buf_state);
>                       return 0;
>               }

[Severity: High]
This is a pre-existing issue, but if the first fragment of a multi-descript=
or
packet is dropped (e.g. XDP_DROP), does the driver fail to track that the r=
est
of the packet must be dropped?

When the next descriptor containing the middle of the payload arrives,
rx->ctx.skb_head will be NULL. Will the driver incorrectly treat this fragm=
ent
as a new Ethernet frame and run the XDP program on arbitrary payload data?
---

Again, GVE DQ doesn't support multi-buffer XDP. This will be addressed
when support is added.

--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3
