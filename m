Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446583B05A5
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481004; cv=none; b=i6Bopofv5x1uIi923au5l5tMMLDy9gkcfmllQKNtzV27ASbzgcRFl9AH8pHnSfFjtClussqUxIZD+zvxTyNVtg4lphIw4aKq3pXMjx5UgXkm9/SLQ5bc04Frw08BlEQK5Wn4New9J4cO3bkLRbFl8JSrlxJ1H/jwGEnBiLF9Y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481004; c=relaxed/simple;
	bh=MDFwzyFHNPCdvJZfRG7S9x0rBFkQE43bGaBiVXq1uAc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nhI0/+2YlSlWHHaTNryAOZWNrTHnaXCcg0NNPhJgrBMsOL4pQllj7dtVk1VVZu21cMXyOCBNSQiN8f+0RS2ToakXk3rl2WIxrbpkk3mRab3OcJRGeGfznxb/nRP1utdpkr8TgSG3CvDVNoCw69Q9hR2dnuETc0YPfsRcMivd2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZomEKup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZomEKup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4821F000FF;
	Thu,  8 Oct 2026 17:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481003;
	bh=bki/kHEQk3uVant5WXoosSQYMjj3pc7LE+5Xaceb/fQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZomEKupzkxsJuRodiDLMXGQVCWjSi/FXGLWK4Uny+TZvBBAn1KXX2ui3HNzpXXDu
	 VAG5zj3XY/5NTx1MSNLZ5+Ksj9rkJSbcOYOG6TaF6iHsTSdBiVViBkig9Q7woBVYk/
	 l53fKMvOd8IKSi4SLSAdyRYEWqbi4baPVVeJh7zMtlhExDwb3YysU0C+ZNirVqFpW2
	 CvfOrf69qmw0MH5OgVpIUhrez7ZvANNZYxuQ7aeFPW52R/lOvhq9+p2hvj912sQLAE
	 t1QOr3NJ6Toj71+8fY0uMp11w87TQtFEPQYuf1mmt6qrJJQOWnnoETJLnxGhr+Vn4m
	 6kONsa2elOEDg==
Message-ID: <sashiko-outbox-164424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/8] net: skbuff: don't BUG() on leftover
 length in skb_checksum() and friends
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-4-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
 <20261007-b4-skbuff-bug-on-v2-4-b9a5f732895b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:36:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: UAF and double-free in axienet exposed by skb_to_sgvec error =
return
- [Low] mt76: memory leak of skb on skb_to_sgvec() error in mt76u_tx_queue_=
skb()
--

commit c07f21ad9448d85b0e365dbfeb75ae3c3a8b381b
Author: Josef Bacik <josef@toxicpanda.com>

net: skbuff: don't BUG() on leftover length in skb_checksum() and friends

This patch replaces system-halting BUG_ON calls with error returns in
skb_checksum, skb_crc32c, and __skb_to_sgvec when encountering leftover
length. It returns -EINVAL for __skb_to_sgvec and 0 for checksum functions,
allowing the system to recover gracefully.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
[ ... ]
> @@ -5339,7 +5345,10 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatter=
list *sg, int offset, int len,
>  		}
>  		start =3D end;
>  	}
> -	BUG_ON(len);
> +	if (unlikely(len)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}

[Severity: High]
By replacing the BUG_ON with an error return, callers are now expected to
cleanly handle the failure, but does this expose an existing memory
corruption path in the axienet driver?

Looking at axienet_start_xmit_dmaengine in
drivers/net/ethernet/xilinx/xilinx_axienet_main.c, the TX ring head is
incremented before calling skb_to_sgvec:

    lp->tx_ring_head++;
    sg_init_table(skbuf_dma->sgl, sg_len);
    ret =3D skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
    if (ret < 0)
        goto xmit_error_drop_skb;

On error, it jumps to xmit_error_drop_skb, frees the SKB, but fails to
decrement lp->tx_ring_head or submit the descriptor to the DMA engine:

xmit_error_drop_skb:
    dev_kfree_skb_any(skb);
    return NETDEV_TX_OK;

When subsequent successful transmissions complete, the DMA callback
axienet_dma_tx_cb monotonically increments lp->tx_ring_tail for each
completion. Will it process the abandoned ring slot and double-free the
stale skb pointer?

axienet_dma_tx_cb() {
    ...
    skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_tail++);
    ...
    dev_consume_skb_any(skbuf_dma->skb);
}

[Severity: Low]
Does this error return also cause a memory leak in the mt76 driver?

In mt76u_tx_setup_buffers from drivers/net/wireless/mediatek/mt76/usb.c,
the negative error bypasses the zero check:

    urb->num_sgs =3D skb_to_sgvec(skb, urb->sg, 0, skb->len);
    if (!urb->num_sgs)
        return -ENOMEM;

    return urb->num_sgs;

In mt76u_tx_queue_skb, this negative error is caught and returned upstream:

    err =3D mt76u_tx_setup_buffers(dev, tx_info.skb, q->entry[idx].urb);
    if (err < 0)
        return err;

However, the caller mt76_tx_process_mcu_queue unlinks the skb before
attempting to queue it:

    __skb_unlink(skb, head);
    spin_unlock(&head->lock);

    sta =3D wcid_to_sta(wcid);
    spin_lock(&q->lock);
    __mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);

Since mt76u_tx_queue_skb aborts without calling dev_kfree_skb or
ieee80211_tx_status, will the unlinked skb be permanently leaked?

> 	return elt;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-skbuff-=
bug-on-v2-0-b9a5f732895b@toxicpanda.com?part=3D4
