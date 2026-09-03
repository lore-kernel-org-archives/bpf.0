Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A58431A3C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474439; cv=none; b=f8EbULFqDWGYO7y9NUQ9vWFhTBo2J1UtNRVbhTasfHKS7py6AaZKiIDBqVSmDHCJtLz9hG6DHtmzNr1N7jLiVPpcCHMHnP+LmDN6twy+v/GQGKaoqSqTT16mxpoa05rxnO8lFVn9iyncuC738Khjr/J2dJ5x+MrQtIwFspS/Yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474439; c=relaxed/simple;
	bh=IQ6ss07CJCUuEauKZIYYS9wQYR/4ZHlxK/xYA1MRFMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n2nThY152L0E8MqkLqM83yK9yBZ/exq6nbc+gWTB/qkxh5jNzmzE6csS8WAcNjGVC69QCuhbLIQpQPQSwOvljFtr4tcA3gv+UduSZS1TmDAn/bAbr9znOH3k/7fylfC0lTGTGuWCU2iAQsYzCoxQ25IHW/QLvbsLzJtP8IOvATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxsalH2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxsalH2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF6E1F000E9;
	Thu,  3 Sep 2026 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474437;
	bh=v2+RR4ITAUVGS3M7Sq+0HY0tpgJAlg9EIwwnz+eZrCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dxsalH2nxidAE7LDBKlLXiva91QQj7JqdtkeAMpk70Ppt/m+3L4dRVlyb0w2K/6BO
	 DmVhIl2Tg2KBso56jEZSggxhFAJ5765mZySuY0g2DNed1rXnf3HCsuSmUFh9adCFf0
	 q5oBOtUQCNr8vB/rhfFQYT7xF4TRba09vi/d/3dNhOEqa0GrL94tNAt0yuKRMMaJQm
	 OTT51VDcRFBvYGyFAOAZmv1b3NGnt+AY9cfaYlX161fuqi/syNgmpwYW8cMW8xCM6s
	 ZdKz859AC9Ozg4Ms3UDa/9kVG/hk08GzO0ZaAEK1OqoOzHpo8L/2DtKAgwt72XVWMZ
	 0isQsnZavzWNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suraj Jitindar Singh" <surajjs@amazon.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903221130.27316-1-surajjs@amazon.com>
References: <20260903221130.27316-1-surajjs@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 22:27:16 +0000
Message-Id: <20260903222717.3FF6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature checksum calculation for multi-buffer AF_XDP packets.
- [High] Incorrect error recovery on `-EOVERFLOW` leads to packet fragmenta=
tion and garbage transmission.
- [High] Integer overflow in `skb->csum_start` leads to negative checksum o=
ffset and memory corruption or IOMMU faults.
--

commit 82f4b9c7cad6fc646be8342f727421a308e35ec1
Author: Jason Xing <kernelxing@tencent.com>

xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()

This commit fixes a time-of-check to time-of-use vulnerability in the AF_XDP
transmit path by caching csum_start and csum_offset in local variables. This
ensures userspace cannot race to overwrite these values between bounds
validation and assignment, preventing potential memory corruption.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.=
org/
Link: https://patch.msgid.link/20260530042630.80626-1-kerneljasonxing@gmail=
.com

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index da7e11e3bfad2..76675ce70f03d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -733,15 +734,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
>  			}
> =20
>  			if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -				if (unlikely(meta->request.csum_start +
> -					     meta->request.csum_offset +
> +				csum_start =3D READ_ONCE(meta->request.csum_start);
> +				csum_offset =3D READ_ONCE(meta->request.csum_offset);
> +
> +				if (unlikely(csum_start + csum_offset +
>  					     sizeof(__sum16) > len)) {
>  					err =3D -EINVAL;
>  					goto free_err;
>  				}
> =20
> -				skb->csum_start =3D hr + meta->request.csum_start;
> -				skb->csum_offset =3D meta->request.csum_offset;
> +				skb->csum_start =3D hr + csum_start;

[Severity: High]
This is a pre-existing issue, but does this calculation overflow the 16-bit
skb->csum_start field?

On architectures with a 64KB page size, if userspace provides a csum_start
value close to 65535, adding hr (headroom, e.g., 64 bytes) could exceed the
16-bit maximum and silently wrap. Later, when skb_checksum_start_offset(skb)
subtracts the headroom, this could result in a negative offset, causing
out-of-bounds memory accesses into the headroom or hardware DMA faults.

> +				skb->csum_offset =3D csum_offset;
>  				skb->ip_summed =3D CHECKSUM_PARTIAL;
> =20
>  				if (unlikely(xs->pool->tx_sw_csum)) {
>  					err =3D skb_checksum_help(skb);
>  					if (err)
>  						goto free_err;
>  				}
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but does this compute the
software checksum prematurely for multi-buffer packets?

When a userspace application requests XDP_TXMD_FLAGS_CHECKSUM along with
tx_sw_csum for a multi-buffer packet, xsk_build_skb() appears to compute
the checksum over only the first fragment by calling skb_checksum_help().

Since subsequent payload fragments are added later, the final packet would
be transmitted with an invalid checksum covering only the first fragment,
leading to silent packet drops at the destination.

[ ... ]
>  free_err:
>  	if (first_frag && skb)
>  		kfree_skb(skb);
> =20
>  	if (err =3D=3D -EOVERFLOW) {
>  		/* Drop the packet */
>  		xsk_set_destructor_arg(xs->skb);
>  		xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
>  	} else {

[Severity: High]
This is a pre-existing issue, but does the error recovery path for an
oversized multi-buffer packet desynchronize the transmission state machine?

If userspace sends a multi-buffer packet exceeding MAX_SKB_FRAGS, this path
correctly clears and drops xs->skb. However, because it doesn't signal the
caller to skip the remaining descriptors of the dropped packet, the next
descriptor (a middle or tail fragment) is processed with a NULL xs->skb.

Will this cause the fragment to be incorrectly treated as a new packet,
leading to raw payload fragments being transmitted as garbage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903221130.2731=
6-1-surajjs@amazon.com?part=3D1
