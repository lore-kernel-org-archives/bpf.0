Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA5432312
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781931; cv=pass; b=qwQ8rRM8Y3wSX7D3MiqU+Vhy2ihkgZ/1pH4LwZQXyMaMZM69HhYRJ0KGBcURuj7VKdT2zGXI2a4TV7NIgQE1NnXFMoVbOy2dwWp01hfgs8OJBhq8HDqwFipxZrR/8915bI56DxTQtcO6LKtRzuDJ36fQy4JWAn2gxLGdRV5letE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781931; c=relaxed/simple;
	bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAoYdclOsaJsDNKBmxLEypihg2siktGLOZTjOoAtCiC8yyeAoGCug3qlGFKMrpwKodMZKofjXbwplY55e3q48JDJk3A5AizMpGoCDX8INnpUvZ99PLnd4+7XATt0gLnmPnJ22IUYi07J367ot3oPwjWUdtUEkjIJRctfwEq7mXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QD6ij8es; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD6ij8es"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacef7d299so20005ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781929; cv=none;
        d=google.com; s=arc-20260327;
        b=BFZNhKQeXgQoj+vnEcfN87xYntdMmDvG9DghqGmJzkGMB/iuy0dQ6jrz9lS+M+JEaS
         3vJw5yanXdvZa48da3SinIRFx+5jW8DJD6GprfVMtH/gAaG44EKQws2TBHTZu5Q7gM+0
         tOFsRoCSRUaeXHDUZGwQTfZ4U+5NjAhirff3Y9EhIlgHY9YFoZXdS+aaQqUlxHD17mgz
         NKJDR4kavZnydhUUtP3EHpU0x1gRa523ojt34fyPL9f46BWY34jWs4o1PVGArQ6dzI5P
         +5UvgiakA8XAxmIZZFv6ATxbDpg355ZLVrHEOlUDEblvUvMYboZljWa58mOPfryY7HoY
         YH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        fh=KdDpD2DEnNk7tEV8yWJs+kj5/QTlv4QSYUX+0TFFXb8=;
        b=BFiuzrnUGN9HeHlV5bpSNXUy8o6x9hYwY6uMCuNT01Y98J82aj/r1FocFCHWfkp8T6
         ejk4LGDGGQSB+34FjSfpYdMaSZfxhrSKy5f27TOy/uKnPQya3Wsr7iLm4BY4UPOAPA7H
         LSqzKj2wuUbCHzESOJyS6vUunN2nwNYj0OBQ0LqjM0tvJmP2CosmbOnjucU2ph52Uo8x
         TfujbmSbtcY7FL2re/crKxQ+aPOm1jfsMwUEIW07WaD4EqFm6IUnrLDZlvDuPBPDLO8r
         puuGHO9QvF615b6tkDIe3INwrNdHl4ku+qCrifFm6HMCY4IF2EwHnAhsSt6Qls325Nko
         pxvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781929; x=1786386729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=QD6ij8esOYUdm2Uo++y+AEpUjnjjH0LBBYwmfY+bS9fhjaa2Jz6yMUdQJ6rdyiwJJR
         Zpz6Ccu0E2qvoLIpHHRrJbUpvsUgTTyibW1YsdH8XtzWuNkma/PviKEf0T0Yat+QTnB7
         8gq0Rwl42AoT1/z212tY8xY5VqAEHBNvDvaTAke2qiNRpZLr5iHz9XkOS6DSdyt5ae74
         LI158rARYwKARIaxOCcK4NC3AfJoq6grQFB43hawuf8s+05uQn0jI67WEe6++/G5FC/v
         g6S6JrG2Zxe5lWJMOro7sp7lK1yaAvlNbcJ3iRN7EJDv9iE99pweW6M+vXQU2Oo1Ydgo
         Dr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781929; x=1786386729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=Y2AVhnXtk7xJFgCSyoCmCwAnp4axeqPnvZWI3apAoeANanZMrzUV2rNTexCRlB0brp
         u/VQ3BYSSvIGG4uDcmYJ1GdxiQYotnxAg6GUL1JXYWLqWlFNddRIqwaAtNXaBD8peICM
         yiO0YfusZUz2xQiY5OocOwi8HkrBpQbp+NCOrN14nkkrWGuMbwvsN1unKyTqcDYm9p+Q
         +eowV5rMJru3qH0/LmSIEfjBJXmv/Smp4No8O4pjDOnojzgZwzAqxIQnrcIJ4E92tW11
         LecIrcR7NCtQphPDoXHNyCR9baqWM3tTlXgc/u04IOtaBZdgNkz3un/L5Nw792fpm+ri
         S3gA==
X-Forwarded-Encrypted: i=1; AHgh+RouOV9hXu/dpPkZC8S2KRLbEjVJxdr0R/lMfccFIUWXKGRWm4YFXq8SpVFeOxgVaJdfNRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmKzEUmaklDJ0nO95M7tUflZyDzcHq2GNNswVTrxCPEZdMUGP
	Smxx/ciqWaQKZpm18qaD9HVKYUobrCOcUY96cnYlGSYc0fQvfI5GgjMlgtvf35snktlG1dsKlYN
	PjGLwByoSMVOXmkOU4CNMcgMn0wmS/WJd43run12Q
X-Gm-Gg: AR+sD118o0SPOwFYGVHj9WYL0/7rY5+jxGei44NfBLZxJ4vTHqIXyzOacuYjcTqeMOg
	cwTrurEN5UUfmZ205E4gWPP6MI8L6+cixe0xhxtY6FLgOrYODSQdyF8BaRII8FVDcRwoOe1ZDrU
	NrJJbXdNsVFC9aABuzFcdZyyuiQNvX8Oe9MfQimhGkmdBIMOP5WCNftsdQfan/IBhwBwWbpLbqT
	rWkNQxgs7H1HvUjCeQbjFU8WfSlcp9HkKGZdlmm8mzbAALCEaKPfKDlBhCnsXWVfPRPHMqWKbnI
	jxiFht3DS9jaNCEgvaeMk5LBja0rrPqM/bG3UGo30o9T
X-Received: by 2002:a17:902:e945:b0:2d0:8b22:7eaa with SMTP id
 d9443c01a7336-2d08cb31baamr1688045ad.20.1785781928753; Mon, 03 Aug 2026
 11:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com> <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
In-Reply-To: <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:31:56 -0700
X-Gm-Features: AUfX_my3dNHecsoUf8e69cV4C1hLKJkdXZo40JvErJWzFKOvN7k3ok7JtkXPFd4
Message-ID: <CAHS8izPdDV88eP90R2sVa_dLUy=btQWTHJ804g5TrDh_2xKKLw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: atlantic: free stranded TX buffers on ring deinit
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Igor Russkikh <irusskikh@marvell.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:46=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the conversion of the RX path to page_pool posted
> for net-next it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame keeps
> the pool's inflight count above zero forever. page_pool_destroy() then
> never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: stable@vger.kernel.org # v4.11+
> Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

FWIW,

Acked-by: Mina Almasry <almasrymina@google.com>

I've noticed these claude-generated commit messages are unusually
large compared to the human written ones. In the future try reviewing
the commit msg manually and making sure the amount of detail makes
sense.

You can put extra details under the `---`

--=20
Thanks,
Mina
