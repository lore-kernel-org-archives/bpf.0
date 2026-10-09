Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93F3B637C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565201; cv=none; b=a7b/dgBOqf6qtrXkGmfWo/gKS67basPRZFxAkrOSAtDjWOfpT2zMFxDJrNcmtRCapHfhsLIv7gO1kANm3egbW+k9SABHxEHMAy8eQWp0dF/TtljOEdVwUl/SkUt4Rz1FwBLOUEy9siPxwzG+b7M9nMDxSsYVyuZRiGdeZdRN0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565201; c=relaxed/simple;
	bh=g8oTqbBI0YuaZr1siNYywLwUGaXCtpJ4FigLhsMpDJ8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EJgSh8AF6a/oW+ULvtNVb4Kak9nEH4A4dZT3DVJ8xrP/f8s3oNOHpCKCFXZ9N3C9P0GTYaRNp2K7HtldX5jrkppsCH76/KRqMkZSug6KpAWimZplGc0xX0XYfF2kTQYpL1q/YGr/EMGiYhlsufikfvzWiAKHdTPvuyADr0jnlmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1hn7X+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1hn7X+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5241F00893;
	Fri,  9 Oct 2026 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565198;
	bh=IXhv1xeXqJWgUhrEOpBKbpqlpgK0b3Q9mlodfG1ls60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1hn7X+JOthyad5d+ThplGCTaOKxBldTxF0wk0eH17hppaE804ZOv7XjDrAsLNDhn
	 9m45iqyoqDICv1+1cB6DrUlcxGe8Jn+CWSj252YErqZnvHQ3jWN3WZfwgw/dlDnfNf
	 i/wP5shHTVyC+Eq2iy5aDynrVZ5f+HuwmUOOj8sLKxiifeg0yeQ4TgQQFss8AwmCqE
	 1i9J/E9h2+SJzakHZe5Zl0EwIYFEkv/REUVcPQVlkVSpnWih6i+YqMcVKUFS+NrOxC
	 Ibs8C7LGspaUNRGHZjgtMbm1zuQjH8awBBpbiwINnixwOyD+2m+3uIIqqfnoQWzcxS
	 q1mxjePG56yGg==
Message-ID: <sashiko-outbox-165856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] net: lwt_bpf: preserve encap header across skb
 head realloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
References: <cover.1791433504.git.rakukuip@gmail.com>
 <68db88ada2fd01fc03f17dc7d54a705aa245ddea.1791433504.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:59:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: CHECKSUM_COMPLETE corruption on IPv4 encap push
--

commit ab70bb57bdb2ff3156beb5d15952b833dad5b175
Author: Luxiao Xu <rakukuip@gmail.com>

net: lwt_bpf: preserve encap header across skb head realloc

This commit addresses a use-after-free read in BPF LWT encapsulation. It
copies the encapsulation header into a local buffer if it points into the
skb head, preserving it across head reallocation.

Closes: https://bugtracker.nebusec.ai/f/11304

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
[ ... ]
> @@ -612,6 +613,11 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (unlikely(len < sizeof(struct iphdr) || len > LWT_BPF_MAX_HEADROOM))
>  		return -EINVAL;
> =20
> +	if ((u8 *)hdr >=3D skb->head && (u8 *)hdr < skb_end_pointer(skb)) {
> +		memcpy(hdr_buf, hdr, len);
> +		hdr =3D hdr_buf;
> +	}
> +
>  	/* validate protocol and length */
>  	iph =3D (struct iphdr *)hdr;
>  	if (iph->version =3D=3D 4) {

[Severity: Medium]
Does this sequence of operations corrupt CHECKSUM_COMPLETE on IPv4
encap push?

When bpf_lwt_push_ip_encap() executes on ingress, it calls
skb_postpush_rcsum() on the user-provided hdr buffer where iph->check is 0:

	if (ingress)
		skb_postpush_rcsum(skb, iph, len);

This calculates the partial checksum of the header and adds it to
skb->csum. Later in the function, the header is modified in the packet
buffer to contain the correct checksum:

	if (ipv4) {
		skb->protocol =3D htons(ETH_P_IP);
		iph =3D ip_hdr(skb);

		if (!iph->check)
			iph->check =3D ip_fast_csum((unsigned char *)iph,
						  iph->ihl);
	}

Since a valid IPv4 header sums to 0, pushing it should result in a net 0
addition to skb->csum. However, skb->csum retains the non-zero addition
from the earlier calculation and is never updated to compensate for the
iph->check data mutation.

Could this cause skb->csum to go out of sync with the packet payload,
leading to netdev_rx_csum_fault warnings and packet drops when upper
layers validate the checksum?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791433504.gi=
t.rakukuip@gmail.com?part=3D1
