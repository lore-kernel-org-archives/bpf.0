Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FE39A066
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141004; cv=pass; b=twCSM8/DErSfLwC7ZLLzpd77uRzDXaXiectOmNzQ7p5EydMc2n/4LhksOmYHbTgJ6/m2pY5XTAoY/OmQZ1qFUHCZ4e4r7hCAwQfAA/8syteSGI+jj4jpo5GA+CcMexd0IzSyriGyYTYpuS6ALF3BXg60agS1cetPqTtw226SPH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141004; c=relaxed/simple;
	bh=VkJcVq88PZ051GeKnLPd8Ml2ZKh5BjaQJaJRp7q6aDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U342dHptHhrTbFMCNaVLr9qce5UCjjbvdt7bDduqeVahnB+VhLd4R7dgAIwqrQyx+Wdo70an/ppeLQsq6lqmaT+bad+nQMxV50TGO6wf6xPkt2GWAeg56xQOSjXV51caZIP6Nx+bH7YuQB/ls1dPNhn5lZGq2QsXN6VVnoP3vHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR7a8EmB; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR7a8EmB"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso1075ad.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141002; cv=none;
        d=google.com; s=arc-20240605;
        b=L79PCATGQl71tYKuE21SRbOTzU5tzt79DmxqaQflyqVN5gf8bMhb389Wpud3zl2IQu
         i3KuSDAPNWBdHfSjYoPm4DWsNxvXQ46WvN91KQP7Nz6yT6aLnw7EVIbR0BxNjzgCcw7m
         7Yuw8zQXDQSToVwejD+K8BwK8hP0u56K5BrBUtdL+NhGlo3Eu7J6B/cA+qU7q/DsYw1W
         Kfa9uXMNt9hL6FcRqS4kGvuDCIJm7gqcaPj3DB2fxNfi5Z0vnmLl1E0fFPoVyn1QvTvc
         h33BvR2ayIrhShy/0GgG3b1JAcHh2zQ1spmteivRIm81l/TqgNgj6+o5kSQ8thXdQ0gc
         UcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        fh=ADmW/dUusXXmwe+OLIjmAWphiYAYV3Dmb2fIKKHNOac=;
        b=XZMB/X1aCTwJe/8EcaJSCEsAA286QGf3PCIXqtSdwWF7N8x008zHx35ibU91NkxFYb
         gYsxebC+BTP2dOjK0UD/bdzKSspMxZgS22ppl629+s4p/JJLWLoU2CTdHoh9G6UVrFpo
         b1kMKPhCSUss0dMc1UEa/WmsqxZZESazsGwTq1unJ1J7tu+RQRzcIkKNFk1484qxQc0q
         JJkF/xdgWL8A1Io3C7K1AJkN1IE18danbBvprOipme98E0/PhRHRJ+XyolOtrX7VT2dy
         axMlKFPxrEjRiAYbz/RRuwGoSqHN5vf+nbUpOxHD9odsmLCpwWdVqvog/OG5+v7JkfiQ
         26hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141002; x=1779745802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=pR7a8EmBPVhtgoI+iG1VPzFORXXBx15tpSmrwe8xs+DN6OwRvuST6qoTu/bminXVa0
         MRDXOUz8E5xc9sf3YPgPgTwNuGEIEKHitQ9ysyFhjfqnrPhBl78GpGwEfbS6wmbMNplv
         V06l+xrqnc3BHcmhkaXmEL/IUuKLrAuiBEQ3THI0IO0F6VHOXyzSlOUHrje95ZqjYAUI
         rFx+F0sc9GGw3Fkv0CovlxhYyIsCEIayzRIEzoKdp24HXkdaIHBKm0OTN/uo6BvE7r8y
         w2e0heo0RJLFkXkFjNCvVMt7Fcjc2G0J+gPs6rvi/VohEMuKipuldrZ5eBbZEx6Ftzmi
         XnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141002; x=1779745802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=lldorkHLB0RvpdnsfjyOCrJY3MSIiwP8fFqAX3mmmGEsfbiew4AdFzYnkLdHnVVUSW
         BTMIMy8qNPC5izT3VEujzX+16VopxLUFdi3Zl53rDIdAvGtelXNguwz/boAG5XeHl8fC
         M90tBtDj/helkj5Hi9sRcKUuVHqmbBIDx3Kmu3jCyD9T06aOI320/g3lnGRvNx/81u5I
         LPThitwK0ENBFvrFHR2IVNaRJ/CpbE5O0wMm3HWg0f/G3gMOT20fmPI9PEc9Xc+vJBVU
         1AKdlOZG9jZgRLZfHE9Nz9ffLW4yQBzXB4jWw+N6AFyCRe/GOhJdhXGrykZ7DzgGMdob
         tqwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vkZ8klbC3CBdd1JY0A6Jgcj0sCHIPtBK3tY4ZwOpil8n8sxMHUpTgDV06LkjdU9vuLs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HgQDopDNONAsYYbyNzUmXznkdGlkyS8izJ1PIAup8gKK6zp7
	DWPGtB/YueHarNNbIZNutCPeyM2WOJKAUDosb9fCtrP5TsbJgU9R29lCHNzGnl9to8/LDHLz/U4
	HICK3aWgDqbXFkDfqQbzfi0r5IhgwFGD+yS0iGUaF
X-Gm-Gg: Acq92OHg7ra+Wlt9dmvHQnzdo/XEUGCDAvoUXl7ms5fuMvXBLtQaR7p9bBpT1qq6Q7D
	ZHVpNhZ/fWYNi+ur0H72UG5vYl6o25e4EmFb9r49LGHTk42qALEPShRcMJgX9AQWm+i/L9GkqJ6
	MRS756Udg/8dHlVNsrBJUNlO6XCBGRLWYmOqw6xSQ7zX1fe5kGKdMjYlr/aeJCmMzDPDuW+eXE8
	mqTrKnLBqMV2Qyc/OlvGUKn/b3d1dG2zLjLInaLvoNdgHP2sMwaYqqtwAmLMnHhs7TeDUU6tfC8
	UYCvzswgjvtcMQX9O5d5z1+beHvIlRpo0Zy3p8LrbOQqMYpEQBy877xLk7uENCJyyeoV5dODpXe
	eXQ9Imm7uY8TH8sgO
X-Received: by 2002:a17:903:2b0e:b0:2bd:7bec:f0e6 with SMTP id
 d9443c01a7336-2bdb3039f44mr4031835ad.1.1779141001688; Mon, 18 May 2026
 14:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com> <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
In-Reply-To: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 18 May 2026 14:49:49 -0700
X-Gm-Features: AVHnY4K_8GpyBqIYGQp4SgXCG1-y0gChQxakRF0W6U_iz8zjhZO9jcW9YHuJGe4
Message-ID: <CAEAWyHcFE5kUPthnRHQJS5s=YBRhdaOP9mYNsxkMt-Pm1U_1+A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to
 prevent panic on attach failure
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, 
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org, 
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com, 
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	stephen@networkplumber.org, jacob.e.keller@intel.com, 
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org, 
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 12:52=E2=80=AFPM Dipayaan Roy
<dipayanroy@linux.microsoft.com> wrote:
>
> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
> mana_remove(), mana_change_mtu() recovery, and internal error handling
> in mana_alloc_queues() can subsequently call into functions that
> dereference these pointers without NULL checks:
>
> - mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
>   dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
> - mana_destroy_vport() iterates apc->rxqs without a NULL check.
> - mana_fence_rqs() iterates apc->rxqs without a NULL check.
> - mana_dealloc_queues() iterates apc->tx_qp without a NULL check.
>
> Add NULL guards for apc->rxqs in mana_fence_rqs(),
> mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
> NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
> draining when TX queues were never allocated or already freed.
>
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a..0582803907a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context=
 *apc)
>         struct mana_rxq *rxq;
>         int err;
>
> +       if (!apc->rxqs)
> +               return;
> +
>         for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
>                 rxq =3D apc->rxqs[rxq_idx];
>                 err =3D mana_fence_rq(apc, rxq);
> @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_c=
ontext *apc)
>         struct mana_rxq *rxq;
>         u32 rxq_idx;
>
> -       for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
> -               rxq =3D apc->rxqs[rxq_idx];
> -               if (!rxq)
> -                       continue;
> +       if (apc->rxqs) {
>
> -               mana_destroy_rxq(apc, rxq, true);
> -               apc->rxqs[rxq_idx] =3D NULL;
> +               for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++)=
 {
> +                       rxq =3D apc->rxqs[rxq_idx];
> +                       if (!rxq)
> +                               continue;
> +
> +                       mana_destroy_rxq(apc, rxq, true);
> +                       apc->rxqs[rxq_idx] =3D NULL;
> +               }
>         }
>
>         mana_destroy_txq(apc);
> @@ -3269,7 +3275,8 @@ static int mana_dealloc_queues(struct net_device *n=
dev)
>         if (apc->port_is_up)
>                 return -EINVAL;
>
> -       mana_chn_setxdp(apc, NULL);
> +       if (apc->rxqs)
> +               mana_chn_setxdp(apc, NULL);

Is this check required? mana_dealloc_queues() is only called by
mana_detach(). And mana_detach() calls `mana_dealloc_queues()` only if
the port state was previously up. apc->port_is_up seems to be set to
true only on successful queue allocation. Can apc->rxqs be NULL here?

>
>         if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
>                 mana_pf_deregister_filter(apc);
> @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>          * number of queues.
>          */
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               tsleep =3D 1000;
> -               while (atomic_read(&txq->pending_sends) > 0 &&
> -                      time_before(jiffies, timeout)) {
> -                       usleep_range(tsleep, tsleep + 1000);
> -                       tsleep <<=3D 1;
> -               }
> -               if (atomic_read(&txq->pending_sends)) {
> -                       err =3D pcie_flr(to_pci_dev(gd->gdma_context->dev=
));
> -                       if (err) {
> -                               netdev_err(ndev, "flr failed %d with %d p=
kts pending in txq %u\n",
> -                                          err, atomic_read(&txq->pending=
_sends),
> -                                          txq->gdma_txq_id);
> +       if (apc->tx_qp) {

And same as above, is it possible for apc->tx_qp to be NULL here?

> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       tsleep =3D 1000;
> +                       while (atomic_read(&txq->pending_sends) > 0 &&
> +                              time_before(jiffies, timeout)) {
> +                               usleep_range(tsleep, tsleep + 1000);
> +                               tsleep <<=3D 1;
> +                       }
> +                       if (atomic_read(&txq->pending_sends)) {
> +                               err =3D
> +                                   pcie_flr(to_pci_dev(gd->gdma_context-=
>dev));
> +                               if (err) {
> +                                       netdev_err(ndev, "flr failed %d w=
ith %d pkts pending in txq %u\n",
> +                                                  err,
> +                                           atomic_read(&txq->pending_sen=
ds),
> +                                           txq->gdma_txq_id);
> +                               }
> +                               break;
>                         }
> -                       break;
>                 }
> -       }
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
> -                       mana_unmap_skb(skb, apc);
> -                       dev_kfree_skb_any(skb);
> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       while ((skb =3D skb_dequeue(&txq->pending_skbs)))=
 {
> +                               mana_unmap_skb(skb, apc);
> +                               dev_kfree_skb_any(skb);
> +                       }
> +                       atomic_set(&txq->pending_sends, 0);
>                 }
> -               atomic_set(&txq->pending_sends, 0);
>         }
> +
>         /* We're 100% sure the queues can no longer be woken up, because
>          * we're sure now mana_poll_tx_cq() can't be running.
>          */
> --
> 2.43.0
>
>
