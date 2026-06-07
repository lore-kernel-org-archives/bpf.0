Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850739C019
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844253; cv=pass; b=MDht9SM65gk66fLpfvLG/mxLx6DBb78lUdxZgL50aODHaKBCoxKawlrthEdQsXZCqDFGJQPZoD8CPJNZohPmHslzBqfzKMe8btCdw8BQy0GpEKg0AzcAgrgzH6QNMyvlKMLwKXhxBYijMYe994OFXH32MIFV3feferlJjZBi+cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844253; c=relaxed/simple;
	bh=J7FO8rNeBHhd738iYmLPaOFFhde7lx+0DYImZHcOwRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qowU3Ltbnyy7SQw1IRtn49zlchVDG1LSJNiVGPSSY3Ld2G8oV9JCfRadpjtStE4ImEoyDAYkppZx6KiiBB+DAnlY4NvKWSCfRFff40CrZ6L4S89ceZxT01xWKUt7CDn7RtBANtw7f/SUq05eWqSOjh19+zsH1R2naVuv869WQx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVze6Ieu; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVze6Ieu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e8833c99fcso39592657b3.3
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 07:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780844251; cv=none;
        d=google.com; s=arc-20240605;
        b=Ewrxd+YniBvfz3xvEXtdHgfP2479peT1bOCXaCH19BXGQ830VFCjQOaNKvGnZP5bSp
         ZXRPkytPTChxTIU2mB1lICOH1gSWlfZTW5y2kqun5PUk6HKDQgKHYcyuoxjT7H19+/q3
         eZh3QfC2AHNZSk6Rvfw7yQpt+Deq414n7RwNi9JFx9RwtE8PH31jTb5al0fHWHJ3cl42
         dd0Rs33J6/Jg6pXFxSvAu++Bo2QD3MnKy2c8hQbhvs0oHfaLnSn/cwTa+zwCy/TgOlPc
         KhvQ1jTkfEIVlU3Rf6YPARBgtuv62dIqbe6AG9PR40rmDrdCHfPBjWPhl5c162jlbja4
         LfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        fh=EZ6wFVG2F3Esum6H/TmwtxHCLIWkrcDcRyvpK0VDA7o=;
        b=WB7NbA0SPeNJvq963UGH1QW+rHZ6w5UR7SgwDonsSbf5IuCvacdFY7J9Y4vD9fUNNm
         Qv39FKRXKBWYd/EsEfHF8W6MdJ2cYcQ3OTehexAHuBZTRyH/BV9UdXATz7DkfhVZ0fNF
         d+OaoMdwGWcRczBfiwH21j5zZqg+HdpbriDMm6KckWdyqo42qOMuQtDeuGABClB/R2nF
         PkLSGjg/po2X5klIXk4P5fn8VrDuk0xGAZ68P5vlPUvjHhRZLjPKBGm6IWiiPAaELshz
         7EAKTXBnf+6m6b4WlmfviHehGvd+lePDWujhQVZWJ/LUgG+epvMh490+zF3CE4rGe1nJ
         +Llg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780844251; x=1781449051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        b=NVze6Ieugqf1wP3ObzpNVB/n1gaCpu3HMliaGubW6b8BpSnyZ4waJqKMrY/cnMZjcn
         nfA0QJC6u/obK+N1ORm75e7bFSHuzYnA6UJBfGQsqhmP5J4dx1ntKVQLykz3h/ROmJLX
         yf9jwmBwi37JGsIIJvZKH5rNxTpGSHSJV4G0mKeQnXyssPGmYnt1Rc7uZmaRJDBaQYDf
         r32r7jdPB33x78YUBXD4n3KNXapveQnTvDbS9e7FsH6Ree/xGteF4PqBjqITW7PL6cEn
         G9R624fbOOqcdOFD6KfLEqvAOCuCBud8j6aX0hQin2vRqEXl2HBFzigpOSDVFLvqtnOo
         Mokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780844251; x=1781449051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyUoD5DSJ9qV4GIFVl+nQMb0ZRsjixd3Li9Iu7KWuyg=;
        b=Nqfvufj6o2CzUMcvUiBuxsWI4tUWq2at+ljvTuMbdOzI5RLkHZYq2OCRz2PL5hhPSA
         SiFhb544RhTuRnCGVwbqK9fBfxq8sL8ZOlH+tt5uFcaFHHszw7JGtE3z0kJkGgdlmpcr
         kMlr/19djgSepFo6SEi96c/tbH/kxnlbQJSU98ko7kiVBympdy159GkO/M01xpfy1CRl
         GdJmQwtZNTxnnahrNxYBgzRPgKVcfHGtpgNaWRZhekhWu/Nf8OuZ0C36lr5gBm+zCh87
         054q3oUrBB8pOCv+NtKr5ENx9DiV8qT2VuQVL4aGf61OE9bG0plBb1Csa9fWkMSMkNdk
         GUzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IZlqpkoUi6brdV36UMghKwPS9bQRQJU4k8ZBI/+RdKYH9DR3faIpx7YpYBhKI/qFBn0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8lt8DA2Ng43f0P7ne6B6Y/y2ctEDvAhXaYfZmgpNFSc+Jai1
	uGQWo66Q1CqDF1JaQ6j2bZ6euuDa2wIPI5m6wXkKXd3nYEZBD5awu6J92wd5ixNxiXRCflJ+OH7
	7xiZ0nmXzPR1ZSvig2y05JUdCkTPvbjM=
X-Gm-Gg: Acq92OE9KvxX6iqcvuVYG/7jd3dn9+xHCrMxlY0wLEtMRDQUi8KAzLifoyjK52YWKV+
	FUkYeXx9CMpH27l+rgzybN96r4scBWmwgxA3l9E9wj6pmJ5Xup6ptP3hiFTeQXfEJIBp8rK+/jf
	vza9dQSaOwU5jeXvP3E3Go1244UKGzCuNWznJhGAwX+Dv5Tjn2/DpCouXOFY4JBWF24wQIcvQMB
	0PJZ4Jx2bkguMiMXMOfqPRlQyJxD0huDJtWqxOwNLp+F6JsEh2cEcGGwoo/t+gR++nIuau06Xfh
	9DePIo8OF+3ZABZoe/Y=
X-Received: by 2002:a05:690e:c49:b0:660:5c10:df11 with SMTP id
 956f58d0204a3-661070c04f7mr11777501d50.60.1780844251472; Sun, 07 Jun 2026
 07:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604112846.1420908-1-lgs201920130244@gmail.com> <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
In-Reply-To: <CA+XhMqyzy9B_UFeSC80XG-1ZMh4ckhZiXHT9anNsVutmZdmk0Q@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sun, 7 Jun 2026 22:57:22 +0800
X-Gm-Features: AVVi8CcCrEj5XAdK4dp0xOE1JuG6b--Uue7KTDDPEIa-P51dPasYkE16aY9HmBs
Message-ID: <CANUHTR8oByARnm-2REh8QaDznwj3Z1rGdzKKJ5-+sTZPL2poEw@mail.gmail.com>
Subject: Re: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
To: David CARLIER <devnexen@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thank you for the review.

On Thu, 4 Jun 2026 at 21:46, David CARLIER <devnexen@gmail.com> wrote:
>
> On Thu, 4 Jun 2026 at 12:31, Guangshuo Li <lgs201920130244@gmail.com> wro=
te:
> >
> > lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page po=
ol
> > with each port's XDP RXQ. During an FDMA reload, this registration is
> > performed before fdma_alloc_coherent() is called.
> >
> > If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the ne=
w
> > page pool and returns an error. The reload rollback path restores
> > rx->page_pool and rx->fdma to their old values, but it does not restore
> > the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
> > state can remain associated with the page pool from the failed allocati=
on
> > attempt while the RX state has been rolled back to the old page pool.
> >
> > Restore the old page pool registration for each port's XDP RXQ in the
> > reload rollback path before RX is started again, so the XDP RXQ state
> > matches the restored RX state.
> >
> > Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan9=
66x_fdma_reload()")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/dr=
ivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index f8ce735a7fc0..76654b44baf2 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan=
966x, int new_mtu)
> >  restore:
> >         lan966x->rx.page_pool =3D page_pool;
> >         memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
> > +       /*
> > +        * lan966x_fdma_rx_alloc_page_pool() registered the new pool wi=
th
> > +        * each port's XDP RXQ before the allocation failed. The new po=
ol is
> > +        * destroyed by lan966x_fdma_rx_alloc(), so restore the old poo=
l's
> > +        * registration before restarting RX.
> > +        */
> > +       for (int i =3D 0; i < lan966x->num_phys_ports; i++) {
> > +               if (!lan966x->ports[i])
> > +                       continue;
> > +
> > +               xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rx=
q);
> > +               xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
> > +                                          MEM_TYPE_PAGE_POOL, page_poo=
l);
> > +       }
> > +
> >         lan966x_fdma_rx_start(&lan966x->rx);
> >
> >         lan966x_fdma_wakeup_netdev(lan966x);
> > --
> > 2.43.0
> >
>
> Hi Guangshuo,
>
> Just one remark. The re-registration fix looks right, but the same
> restore path has a related gap.
>
>   Just above the failing alloc we set:
>
>   lan966x->rx.page_order =3D round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1=
;
>   lan966x->rx.max_mtu =3D new_mtu;
>
>   These aren't rolled back in restore:, so after a failed reload
> page_order/max_mtu are new while pages/fdma/page_pool are old.
> lan966x_xdp_run() then calls
>   xdp_init_buff() with PAGE_SIZE << page_order, advertising a
> too-large frame_sz =E2=80=94 for a jumbo MTU that bumps page_order,
> bpf_xdp_adjust_tail() could grow past the real
>   page.
>
>   Could you save and restore the old page_order/max_mtu too, so the
> restored RX state is fully consistent?
>
> Cheers.

Yes, that makes sense. I missed that page_order and max_mtu are also
updated before the failing allocation and need to be restored together
with the old RX state.

I will save and restore the old page_order/max_mtu in the reload rollback
path, and send a v2 with that fixed.

Thanks,
Guangshuo
