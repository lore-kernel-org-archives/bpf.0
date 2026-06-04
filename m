Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265E47D959
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580779; cv=pass; b=VuCH6DqCS4AlwfL7Fzzqkcdc+/dC+NqhQt4KjaD25eEzJzN4Zu2oI0jrQjEQLQROPyYrzGcLx0yhsjE4tkGUe7OmTHwjqSn3CJcsEzY/lyN4SPN+9yFLGYM9xKYLtRKU1+WoQg0aafxSaf8nwCuy05T25XTpxLhDpDPD97frVzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580779; c=relaxed/simple;
	bh=iYme8jFzl2i6imnwPVJ/AP2qxrjAVPMc+7VBvNKbQsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaB9+vFEx1RlUXnz8kKerAbHhrGp9w1PzJZ8WNwgkSqOlhrSCOjVi9l+YYVnNwn5qB3jlKVYHodEAFkXL2O/lyCAVnz+4GXi7cuwclpte1iQUsosMLq4NDCsfr5x8HdB6bWrVod2TljMHS7WRCV/PQ14p3+BPS/YBgYRBlhKZDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAKq8rah; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAKq8rah"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7defee656dcso5204527b3.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 06:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780580777; cv=none;
        d=google.com; s=arc-20240605;
        b=H2TAFZTw23hB0LMh1C2tCAhubeCYxjJBDlCvCE9CqPWU6ONhqv+2cFXrN1q6BfGm8n
         B7L1ZSGqaHCbucUcdw5DpoprRqm99J9c1RlpzMTj3eAdtTT6P3WY2RKcyy07c2naf81k
         0npEN0S9II1oxdjCKaDI0hTzoXDLWSxTn2JlE96MvKXq8t2l8BGP9c5k5YT1rKmEGSfY
         MM1FAP0kh5qlNG/lDzQZvfw771FclXj+Zn5AR03HjjhqDZH3vanQAzI+3t2rHswKj1oA
         uOqp+KzG8W7r1QoAXKhS0vbHcREdz6VlTFKzS40qilQL8UAH3jLUpxcj2q+qY6yN3GGh
         gXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        fh=wZXCnz/4a9EwUnXnB3Fgi5VOc3kn069C5YVy5BYARd4=;
        b=dSy/Ap9V8TOHbROkuBWAzLQ3mM6PInvgFgTlQBfCJadflhyPkDguIGRpLMSfh+hODR
         Wk3nXeJCIDeA3Ki1CmwxI+M3GIcV2VwA9KYXgUBNeTm7zTpzWTJSZ6VcPdojRi9Q0nD6
         Wxnlt+KYxFim4fHRQc0tksm2QQ5GjayfCTU6xZBO01ByeuQdOpWde2rHEWFibmH/Epab
         VD64Yf2ZDarLOWxi/+1e5C6HC/Dain1UjnUBLRWkpimetI8xo4QMCD4XVRtAudY8BG1e
         tJLXzCQQI2+QgyeNWFnpzR1OgtgwhNMzMPhKPGMuNrpoBBMW4toYDXDhEf44MuuBvRpp
         iiSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580777; x=1781185577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        b=bAKq8rahv0NGGP7euMuF0bI/PNS+umztxgcIhptNOcAhHT2peOB60hZ7AX1WTTqrrS
         RA1z+QCcSRcJVj30oWPDW+Sem4i2Voy9eEIPUsVzIJncVOPE+QbcDZZXgevM1tD+omWL
         iwdd3JpddHlW31nYSbmGHMH/3aNpKGYKmb6KbjINWmTqIi7B4Gz/OB1PKiHfdIkErf+T
         XmEW2cgGNCiIeZ7R3G0KYAWhzNca9E5rQW6KkN7h1ZEEn48KFUz9DQdBXcrPSxiPsBic
         xagh0P1H93NSwN6YUgZmgc9KecluL4xxU0qcqCi2TNW1rfPRIXO0CpZ2cYkJOt1ufVeU
         8lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580777; x=1781185577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKmbEqQuIE7hhwfnG8ZqOT6v5fXQBR07PpEbjFiDPbQ=;
        b=onAecziSVK663c1cMXb//ZrBtsMagJwSg0gj/R63TkTl4PIi6OfK0+sfBqFPET8Hwi
         HvNI8oYhbMqYBqk0MyrSdaJt3K98bbg99MMSl7LfybVr3Aq2OE7XbIxBrTg9mBxG2NpN
         nN0F/O09Tf9+DC+7sFROQPrYC8k8NUh2GbU4ihdzb9ZRn1M4AbaQlALzKqyAkJOHpnlP
         PgGZQyXAj9r4V8iYhF5R1oQc5v9rJS3dKT52r9Pn4HZzIGkASr8zTQJSFJJwXHKU6PCh
         hSQgN+IAba8zXQH7JdS45GIW5tqZkDcuu5qX4a2lEDB2Zvv0oO6y9lOaAxS8k9eYkT7H
         EDvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/u78o4GqXo7fp7qNVwwdomWNaSJoDLZG+VH9xSdyVPiwnK+LyQaFKrupMWjySx/tBHTpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRSUwAe/+znfd4uZAk7RAoptOxMV4WujWp7ASARtGRIiMyW1M
	LqkRY6aTrwqcy2RPn5rRRz7/Fak4pnL2LUbvBSmVvqI1KlweodMxnxMhBPdw2lxgu9TLd/x2DOS
	rGjqwWpampSVSgU+Vro/m5NkLMPnCCpg=
X-Gm-Gg: Acq92OGDG2XTx+sA1rDT5IVGXIg1pBD5DkivarfP1niy2p80RAWTfj24Bx8hby7aCpL
	hRUQHBe8XOJ6gPAVg5g0DhmmlkMsxlXDJ4RtO6rvlGiQtw9y6rMxAFECSMlEBn47v26iM/bsbxR
	WItO/SwdKwYGTc6SwU2wLT9Qq5cdeXc5ZNljJc+rAZXYz2oO5r1ffxlBLE1MZ3MjahI4vIXWk7J
	Gc9NUfuv/Pr6EgfTGqnrEFmdiv7H8P1yqw8y/wkxyA/ZYNR2sdm5Sy9iPucB5nAyXDAf4rSyCCM
	NFIdgk0moKNURSYJmVUby+BcxSy0ZRx1AV1FydQH9GeX3KGQ
X-Received: by 2002:a05:690c:6b8a:b0:7ba:eefe:9fb3 with SMTP id
 00721157ae682-7ea47312561mr70100457b3.2.1780580777600; Thu, 04 Jun 2026
 06:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604112846.1420908-1-lgs201920130244@gmail.com>
In-Reply-To: <20260604112846.1420908-1-lgs201920130244@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 4 Jun 2026 14:46:06 +0100
X-Gm-Features: AVHnY4I9Tv-80eeJdvyCpRZWqPhjjoeWHuRXarM4mq3EjV_ABbs5fEo5cIh_JVQ
Message-ID: <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
Subject: Re: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 at 12:31, Guangshuo Li <lgs201920130244@gmail.com> wrote=
:
>
> lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page pool
> with each port's XDP RXQ. During an FDMA reload, this registration is
> performed before fdma_alloc_coherent() is called.
>
> If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the new
> page pool and returns an error. The reload rollback path restores
> rx->page_pool and rx->fdma to their old values, but it does not restore
> the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
> state can remain associated with the page pool from the failed allocation
> attempt while the RX state has been rolled back to the old page pool.
>
> Restore the old page pool registration for each port's XDP RXQ in the
> reload rollback path before RX is started again, so the XDP RXQ state
> matches the restored RX state.
>
> Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966=
x_fdma_reload()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index f8ce735a7fc0..76654b44baf2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan96=
6x, int new_mtu)
>  restore:
>         lan966x->rx.page_pool =3D page_pool;
>         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> +       /*
> +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
> +        * each port's XDP RXQ before the allocation failed. The new pool=
 is
> +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool'=
s
> +        * registration before restarting RX.
> +        */
> +       for (int i =3D 0; i < lan966x->num_phys_ports; i++) {
> +               if (!lan966x->ports[i])
> +                       continue;
> +
> +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq)=
;
> +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> +                                          MEM_TYPE_PAGE_POOL, page_pool)=
;
> +       }
> +
>         lan966x_fdma_rx_start(&lan966x->rx);
>
>         lan966x_fdma_wakeup_netdev(lan966x);
> --
> 2.43.0
>

Hi Guangshuo,

Just one remark. The re-registration fix looks right, but the same
restore path has a related gap.

  Just above the failing alloc we set:

  lan966x->rx.page_order =3D round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
  lan966x->rx.max_mtu =3D new_mtu;

  These aren't rolled back in restore:, so after a failed reload
page_order/max_mtu are new while pages/fdma/page_pool are old.
lan966x_xdp_run() then calls
  xdp_init_buff() with PAGE_SIZE << page_order, advertising a
too-large frame_sz =E2=80=94 for a jumbo MTU that bumps page_order,
bpf_xdp_adjust_tail() could grow past the real
  page.

  Could you save and restore the old page_order/max_mtu too, so the
restored RX state is fully consistent?

Cheers.
