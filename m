Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C231E83A
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124527; cv=none; b=a1GDaPE1yYrc4OiImRMJsrUYcJ5sSwIYs55kvPCOz9mgKa6bxcOTqnc0j3j6q1MKIuPxUKLnAgJuA7OHXUbGWePCUSCO9jYDHCK7QTFddeZTrVnVmVAwmT3wNAq3QB4XQ7hfL1ahZjloAl3ViVwntg2ds0Hln5FgDZEsWL0uCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124527; c=relaxed/simple;
	bh=lq+9aN+dJHBH9ukllxWiDdFsy4PByB1+JgDYjhPTzMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4JZ9uBON3BrTR7firwN+DrvYzwL/Xtza4LADvun1kQmx9dcEj29G076swP4uiP/HT5mLWFCQ+7fECUKC8n1fPnsI5LLTJT4ZmhCM78PcSS8ZVAsdJfMoaZSUcWb4bwnaULMXQkykji3z/DPdQVMhMP1+6e1emzW4QlJ+RtbMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6+dih93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6+dih93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8638A1F00A3A;
	Wed, 15 Jul 2026 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124525;
	bh=wcIU+uqoDe8HqlFGifwVVLXDiFspZ1Vmol8CIpV6esI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6+dih93u3+EPZNdToxg4rLL/yrk5OojkChvDAl/vCQD75VTAeUWR/9Wqd5N2nKeP
	 WS41O+9pTAny1w00AgHTyNwFhd57OQoysw6zNqAnyvDRnJk376DHQJYBMPFfempQSt
	 nMQwsQ2raBOjbuZE62gyM3hWbQe1777yfntC72ttnc0g/35Z31z/VUi9kl5DwKj9gJ
	 4FOmOqJzmhad2mXpk/8vrpNJF7Knov3ZmCEZu6Bb6hxEDazj1ElcYtAKFe7yAcefUX
	 dataw3JdH0OZAyci6MVXA2bO0Ea7SQPN+KePD6LpFxvKEKeS/B7CJj+hHSm+pDeQRD
	 C0nOQF7kr3qbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs
 in ZC path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714140722.111645-5-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:08:45 +0000
Message-Id: <20260715140845.8638A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Processing an invalid descriptor or draining an invalid multi-buff=
er packet at the beginning of a Tx batch stalls the Tx queue.
--

--- Patch [4]: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx desc=
s in ZC path ---
commit f71b54a29f7fa6021e0f05cf7b9e1dfd86287c21
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xsk: reclaim invalid multi-buffer Tx descs in ZC path

This commit updates the zero-copy Tx batch parser to process descriptors in
packet units rather than individually. It ensures that descriptors belonging
to invalid or oversized multi-buffer packets are properly drained and
returned to the completion ring for reclamation without being sent to the
driver.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 385a3f4a1b320..2909a0ec68373 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -603,19 +758,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_=
pool *pool, u32 nb_pkts)
>  	if (!nb_pkts)
>  		goto out;
> =20
> -	nb_pkts =3D xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> -	if (!nb_pkts) {
> -		xs->tx->queue_empty_descs++;
> -		goto out;
> -	}
> -
> -	__xskq_cons_release(xs->tx);
> -	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
> -	xs->sk.sk_write_space(&xs->sk);
> +	batch =3D umem_shared ?
> +		xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> +		__xsk_tx_peek_release_desc_batch(pool, xs,
> +						 pool->tx_descs,
> +						 nb_pkts);
> +	xsk_tx_commit_batch(pool, &batch);
> =20
>  out:
>  	rcu_read_unlock();
> -	return nb_pkts;
> +	return batch.tx_descs;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but returning 0 to the driver
here from xsk_tx_peek_release_desc_batch when the batch consists solely of
reclaimed descriptors signals that the Tx ring is empty.

Since user space typically waits for hardware completions before manually
triggering sendmsg again, does returning 0 here result in a permanent
Tx queue stall until an unrelated Rx packet arrives to trigger an interrupt?

> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 3e3fbb73d23e2..a15ff1929db62 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h

[ ... ]

> @@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, =
struct xsk_buff_pool *pool,
>  		descs[nb_entries] =3D ring->desc[idx];
>  		cached_cons++;
>  		parse_desc(q, pool, &descs[nb_entries], &parsed);
> -		if (unlikely(!parsed.valid))
> -			break;
> +		if (unlikely(!parsed.valid)) {
> +			if (!drain && !nr_frags && !parsed.mb)
> +				break;

[Severity: High]
This is a pre-existing issue, but when xskq_cons_read_desc_batch encounters
a standalone invalid descriptor at the very start of a batch, it breaks
early out of this processing loop.

If no valid descriptors were accumulated yet, doesn't this result in
returning an empty batch to the driver, causing NAPI polling to halt
prematurely and stranding any subsequent valid packets on the ring?

> +
> +			drain =3D true;
> +		}
> +
> +		nr_frags++;
> +		nb_entries++;
> =20
>  		if (likely(!parsed.mb)) {
> -			total_descs +=3D (nr_frags + 1);
> -			nr_frags =3D 0;
> -		} else {
> -			nr_frags++;
> -			if (nr_frags =3D=3D pool->xdp_zc_max_segs) {
> +			if (unlikely(drain)) {
> +				batch.reclaim_descs =3D nr_frags;
> +				WRITE_ONCE(xs->drain_cont, false);
>  				nr_frags =3D 0;
>  				break;
>  			}

[Severity: High]
Similarly, this is a pre-existing issue, but breaking early here when
finishing a drained packet will leave batch.tx_descs as 0 if no valid
packets were seen first.

Could this stall the Tx queue, since no valid packets are submitted to the
hardware to generate the Tx completion interrupts that user space needs
to resume operation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714140722.1116=
45-1-maciej.fijalkowski@intel.com?part=3D4
