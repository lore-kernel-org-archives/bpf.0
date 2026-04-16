Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46B29AAFD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340993; cv=none; b=PH0akbyx7jLwbR78llAeQqK2LvhxkFE8kY4fmvkXgVFlBwNAGt+RtNmpPiBLnjICVqmmwlnQug/q9PCsOOBVqQ+UprahVQlpgWY795YXjuxtkqW9+XAFJ2WllCiuRIWjcrVEafj9JKxk8bS957ORrWlUGkdSdjxKzDlhnzzA1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340993; c=relaxed/simple;
	bh=c0qnYbHYgvfZRtzJ05enFyhyVnoRq1HG/S8FKb3oE7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgpyFmBaE263GmLk5EJ3pyKg2bQIXMBoFjX4rjyivPT+co8z988Fhd/j9VLBn3Zhl1+xjO3n9DccHvpGvl0v7BtKKBH521bR4n0xyuAGZcbd605ax6J5njJPRNDm/FUAPFRFifnqQ+GcgnOjACbrNfUq/PPl1VNO3yOF3nvMFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTfc/cqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTfc/cqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A859C2BCAF;
	Thu, 16 Apr 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776340993;
	bh=c0qnYbHYgvfZRtzJ05enFyhyVnoRq1HG/S8FKb3oE7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qTfc/cqVFQKpt6I2eyryxJy/buQu3w9ecP++RAFxUEY8sDnQ3DH1LJbGAkw5R1nPF
	 GN3/02DHcIzu+/oHXrVS4fkuVUx4bxFZRoq8FNa8RweaQvtH1k1HRDtpWcWqp+H9IJ
	 IpY5PkBEMSGLLERRhfykso5healolFyIO3U8yHLDQnypC4IZR5r/8dqpXkKsSH9i20
	 mhr3NihsYBOSVgyApZdZZPX9Om8bSs2DM64WCtsLvcZNthV3hTwbjmWIMny7q5xOdL
	 yj47JvBxT/CXAALn+PGEtkzt0MK7c4V9+ZJHWK+zAlBtpV83es100b+nCX6KL7fQ8D
	 xxXbFvJ6PzNyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416075514.927101-6-nhudson@akamai.com>
References: <20260416075514.927101-6-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 12:03:12 +0000
Message-Id: <20260416120313.4A859C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Non-GSO packets bypass decapsulation state clearing logic, leading=
 to stale encapsulation state.
- [Medium] GRE decapsulation fails to clear `skb->encap_hdr_csum`.
- [Medium] `SKB_GSO_TUNNEL_REMCSUM` is not cleared from `gso_type` during U=
DP decapsulation.
--

commit 11e8db6b3cc9e077f7973f47c48689c42f700960
Author: Nick Hudson <nhudson@akamai.com>

bpf: clear decap tunnel GSO state in skb_adjust_room

On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
according to the decapsulation flags. Handle ESP inside UDP, and clear
encap_hdr_csum and remcsum_offload if UDP decap is performed.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index b87356ac05f75..54a478be04bb3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -3660,6 +3660,44 @@ static int bpf_skb_net_shrink(struct sk_buff *skb,=
 u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
> =20
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);

Should SKB_GSO_TUNNEL_REMCSUM also be cleared here during UDP decapsulation?

Remote checksum offload properties are tied to the outer tunnel header, and=
=20
stripping it without removing the associated REMCSUM GSO flag might leave
shinfo->gso_type in an invalid state.

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &=3D ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6 |
> +						  SKB_GSO_ESP)))
> +				if (skb->encapsulation)
> +					skb->encapsulation =3D 0;

Because all of this new clearing logic is added inside the if (skb_is_gso(s=
kb))
block, do non-GSO packets bypass the state clearing? BPF programs can call
bpf_skb_adjust_room() to decapsulate non-GSO packets as well.

Could leaving skb->encapsulation set after stripping tunnel headers on non-=
GSO
packets cause downstream network stack components to misinterpret the packet
as still being encapsulated?

> +
> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum =3D 0;
> +				skb->remcsum_offload =3D 0;
> +			}

Does GRE decapsulation (BPF_F_ADJ_ROOM_DECAP_L4_GRE) also need to clear
skb->encap_hdr_csum? GRE tunnels utilize the encap_hdr_csum flag when
SKB_GSO_GRE_CSUM is active.

> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |=3D SKB_GSO_DODGY;
>  		shinfo->gso_segs =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416075514.9271=
01-1-nhudson@akamai.com?part=3D5
