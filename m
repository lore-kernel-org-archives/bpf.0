Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DD2D3ECF
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780847126; cv=pass; b=V4eywqUzhzha2mxUi7cjX7viYTx1Cg2U4bsdNt9ZtEYkElGZ+YWw0qYR2Cx0EPpV6jBRRwh+Uzld03e8us4tSdLAZ8wSAIVcti0rHXinU0dKGyiDDqfLUB0qBw+8l1VuYsYmEEw6DhR6wfqJYLHFKiQN0h8bjaB9hRjf1lR1UsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780847126; c=relaxed/simple;
	bh=pLV8jV7hklDSB01P/rnfhLSZYgR8gFqSdLAXyj5xtJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVjbx05dTn7N7c5C++rck24LiH+7fk3O0rXCM7NwiZkdxYRLeewiubf3nHKIunIVSBQ1dqjJBSZVy45RQWc9tcVw4EbNiuSd1zLu7SwTMyUnom1+ktHBEJipKzw9IvrZlLrEiuKtl94UGD9CBjPMESy5iimoRgGCBNYczPw/UO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnxbW4Fd; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnxbW4Fd"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43d133d9a28so1281222fac.2
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 08:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780847123; cv=none;
        d=google.com; s=arc-20240605;
        b=C994sRbc7Cch8Nk3t0I9xVhFDZGWl+Ws9VjOkv6lObQap3J8DWANbIUEVvIiFNE+h+
         4af5Dsu14/VCJv9NZAxLrCT8nNN84FZIS4qQSpbqRIABE4lHeBms+Q3KsYfcIr0gvy85
         7KP1/t5FqpXQirvCFln6phuYkH4hR8EXm/z4FjyZ/dhm2zS7nve4ONJLPEjbR1xmotXt
         hZLG2esIYBQ2umYlM5QtMh+6FPzrO5+XB46fhHNyIU60Gu2oBcWkHrYUwwaVExYR7uP7
         woyajyf5o2MuoF2Y8HBRgaAZiVN1HFGuv2DjWVdL/lnOG3HF/PTG/f/fTu3Z23aDYIXZ
         OhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        fh=hi3MOtPVo1YlDPQ7zKB95XpbzMZdyuPX8KaQe/D7Zxo=;
        b=MDY2F72F1yMF6+PXop+Zidd/4nQjENOmGnSuhkw3/gu5LntltJoL3ZCZ2kV0/PjL8R
         QK+ncNoBJONQht6o2myriSs2d3kXvndYUYZ9EpLkCB+KLZC+K2QR1clgSfx4Wqao4GGX
         EaR2P/46syRNAin6uQG5ExtnJwMW3LK+r/j6hqo8IfwShgiIxp0PnAy+decEmMfpQ3Or
         Wtl6A0DfK6x4Mud5Y0vab2vx2zMvkniZNNi6F54Uj2m2evDeGM2hRIgc5UtmX09Sc1fu
         OyNjIMzQzKRSmfy50ijM1RN+SfKlocdeMjKs9z6MndXBofizLMIDLabcJbBm5dBvTeaK
         JIHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780847123; x=1781451923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        b=UnxbW4Fd1sPOojgcS6audDCi+j/KdBqj1fWcz4sSNofmtIyq+TAfBCu+YLfyIJ9l5W
         CBBw3AtElUaQrKI6stbRdv2CVpR6qXYh5z/FugHjb+U31sy/wxcCiJjNA42E1al9zF+c
         fMaI6BLMRUrvHTZljFDdq9L99aeB7ENiy85B7UD8ueGy1QQJckGuqREzWh8C6kK6Vbpk
         8TEztiXVn2fFBHEnJEy+7uyIHQa5X3q4sPMqKFTT159KSBgxrGJzo3sDpDRp/z7CB+O4
         fx8d5IQmG+1M9nxWsYHWZGztzhvpIbRL2hHNVVaq7yBf3HchZTl/MXnHG1ia5CY8lXOP
         wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780847123; x=1781451923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wfBsAbCYwCC2GqYSny2LRPTg6nVEL/SrB7w99G8/W4=;
        b=hSFoSMzTaXSg+hLHJvp7+WwpeHAaQGmEBHYDZpCfrQDa1PttPbQvb5ZcKMmeR5JrnG
         B1qLDsNGqxplRt4ufnfNA/pMgbT0/uKuUezzVdGLjlLkUhsvLp8eCVuE79r6h0OdnHCF
         zrBRYPJY3FXgXCaWuXNCeAcFjunnPId9c5fPZdoUgRRxjjLct2gQPCsImWtA6txxyn9l
         dvObzmubYaMd7Cs9dgq/Ccnh4sgQyHd3fL8Gu5pNEEBtcTbEtkJ/6A7Ty74HtrTv9jTv
         hdM67553C8tdRWECUokFxNTQFczJ+hu9v7lhgIPyL5sxmnn6gaPlKIuPJuKVOiUFXZNQ
         nOvg==
X-Forwarded-Encrypted: i=1; AFNElJ+QPRTOUISxhNOTPbzkKpHpkhQos1fF643g1qQ2sH37Or0OETRVPCHoMBlx++bH+R2oqRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYTVDTw6wOwTbFMxS/KruffIpb/KfwaTC33fI35c8JeINUIvOL
	zyJxlrHB7fKfg4vkee8axwOY49zOx0poPMMhxxl4HxA8+9ZiNhj2XiDwR/PSm6Jf8tPEpJnFdl/
	T5MZg6UgCIO8Kt9PyA1eRKcPN0QWI8xQ=
X-Gm-Gg: Acq92OHW0qUlbnNLfyOEQFB19L1zymS606b2sGUqmfH8po2TQnD5Tq53nP3bncCwdy+
	4m0QVEdGStTfhKbLF8n6gSDKm62xk2pL8SvKN+WO/QKRQmLCRPjsfCbiu3F32Q8h715Tplp7FW6
	90dP/bOp3Tl4/MvcTCrzs7e6AfGER3ISLEZUHNAHCzAGkCrwY1zLdCG8JupTYNWnC9R9K28zWvR
	6z0Rj7zh4QYFfIbQeKxUuIKLtXGCgaG4sjXzJKzMPhBZMaDkkHn7QkQjuWGWWUFnVvG1OfDkJ9i
	T1VtTzSzVFn7Vzit35BC+LJ5PB+aA7mF4pbagnnWPxr6CI9E
X-Received: by 2002:a05:6870:d69b:b0:42c:ecc9:58b5 with SMTP id
 586e51a60fabf-4413d6437b6mr6270670fac.11.1780847123432; Sun, 07 Jun 2026
 08:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607145747.1494514-1-lgs201920130244@gmail.com>
In-Reply-To: <20260607145747.1494514-1-lgs201920130244@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 7 Jun 2026 16:45:12 +0100
X-Gm-Features: AVVi8CdY2BXFYwyALCEu97p932ccl-6BhYKrBK8BkYsba51UqnUMNPOIBGeL_ww
Message-ID: <CA+XhMqx+q53AwRekMD0T-92maOizqGFEgcBRCNvChWQ3JBAg2A@mail.gmail.com>
Subject: Re: [PATCH v2] net: lan966x: restore RX state on reload failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ACK on the code part at least, maintainers might disagree with this:
changelog could also note the subject rename ("restore XDP RXQ page
pool" -> "restore RX state"), so the scope change from v1 is obvious
but that s a very minor nit IMO.

Reviewed-by: David Carlier <devnexen@gmail.com>

On Sun, 7 Jun 2026 at 15:58, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> lan966x_fdma_reload() backs up rx->page_pool and rx->fdma before
> reallocating the RX resources for the new MTU. If the allocation fails,
> the restore path puts these fields back before restarting RX.
>
> However, the reload path also updates rx->page_order and rx->max_mtu
> before calling lan966x_fdma_rx_alloc(). These fields are not restored on
> failure, so RX can be restarted with the old pages, old FDMA state and
> old page pool, but with the page geometry from the failed new MTU.
>
> This can make the XDP path advertise a frame size derived from the new
> page_order while the actual RX pages still come from the old allocation.
> For example, after a failed reload to a jumbo MTU, xdp_init_buff() may be
> called with a frame size larger than the restored RX pages.
>
> lan966x_fdma_rx_alloc_page_pool() also registers the newly allocated page
> pool with each port's XDP RXQ before fdma_alloc_coherent() is called. If
> fdma_alloc_coherent() fails, the new page pool is destroyed, but the
> rollback path does not restore the per-port XDP RXQ mem model
> registration either.
>
> Save and restore rx->page_order and rx->max_mtu, and restore the old page
> pool registration for each port's XDP RXQ before RX is started again.
> This keeps the restored RX state consistent after a failed reload.
>
> Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Save and restore rx->page_order and rx->max_mtu in the reload rollback
>     path.
>   - Keep the XDP RXQ page-pool registration restore from v1.
>
>  .../ethernet/microchip/lan966x/lan966x_fdma.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc0..8272ad085150 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -815,6 +815,7 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         struct page *(*old_pages)[FDMA_RX_DCB_MAX_DBS];
>         struct page_pool *page_pool;
>         struct fdma fdma_rx_old;
> +       int page_order, max_mtu;
>         int err, i, j;
>
>         old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
> @@ -825,6 +826,8 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         /* Store these for later to free them */
>         memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));
>         page_pool = lan966x->rx.page_pool;
> +       page_order = lan966x->rx.page_order;
> +       max_mtu = lan966x->rx.max_mtu;
>
>         napi_synchronize(&lan966x->napi);
>         napi_disable(&lan966x->napi);
> @@ -854,7 +857,24 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>         return 0;
>  restore:
>         lan966x->rx.page_pool = page_pool;
> +       lan966x->rx.page_order = page_order;
> +       lan966x->rx.max_mtu = max_mtu;
>         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> +       /*
> +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +        * each port's XDP RXQ before the allocation failed. The new pool is
> +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
> +        * registration before restarting RX.
> +        */
> +       for (i = 0; i < lan966x->num_phys_ports; i++) {
> +               if (!lan966x->ports[i])
> +                       continue;
> +
> +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
> +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +                                          MEM_TYPE_PAGE_POOL, page_pool);
> +       }
> +
>         lan966x_fdma_rx_start(&lan966x->rx);
>
>         lan966x_fdma_wakeup_netdev(lan966x);
> --
> 2.43.0
>
