Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B13C9448;
	Tue, 17 Mar 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752553; cv=none; b=GSFv9lrncyB6mv3abJc0gi6rVBsbJMnL2J7aq1ZKiPdFZyF5ft5L08yzOAUxLXVJP7ye30jdAhlrC07yjvXv4oTbLyw0++/TwCq98OgJJl4/lhLaW81vUWXf7jkEa8k+Gb4jT/YGCVvht2d7FumNtasOOCfurfDAkdaOVS9FmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752553; c=relaxed/simple;
	bh=/uHQxDHPHgQxprBV7SzGlauRc015kU8Io/O5yS+8Qrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OqHmw0iF3FrE4j8JGFd+80Did5NyEOJvLt3GHRjghKTGAb53nFlQLcbKZlINzwVIFiTVvhW80yHSvcs92sQPYljyXnmP1EdnkNaom54zuRG/Lx44CyGtd5xJ02cPxVgDS+PQpa9plevrMb+bop+nPeVpokdB7JhA826q5DYYDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiSzEac8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiSzEac8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7861C19425;
	Tue, 17 Mar 2026 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752553;
	bh=/uHQxDHPHgQxprBV7SzGlauRc015kU8Io/O5yS+8Qrc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oiSzEac83b+anOdvEOX/61ATix8eXjAtYVlh4bBHjVX8R32GO55VoPiWlwIbMyYR+
	 QOKbMAUs/n7oP61QTvjQRzMw1l4PP2tz60QDxO6JmvrqVD3BamKLYKMYkH+XHS3aLX
	 hnNBcjQnwwJHPqj+rcG9XipVuww289k0fNpO0qYpTe+MtXffXFlarCvgi++if/HBp+
	 9j2ygIe8Fi7s5rbrNy9K5gi++43zzyorJu4UFW2uy6pQjrTMTeIU1h4+f2+UQcUrHL
	 h/nHE0KcQXk6E1+oHN5C41UlX/9fpJMBBRn1G2eSBT9uOOfKYP9EOOdQthxPqHgQEm
	 8KPd6BH1cjLSA==
Content-Type: multipart/mixed; boundary="===============2343841723094614987=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4350dcbdc7cf54739156a2cc70d3c6cdeb224bf1df09d996b5bbf409fd6827c@mail.kernel.org>
In-Reply-To: <20260317121429.2399539-6-nhudson@akamai.com>
References: <20260317121429.2399539-6-nhudson@akamai.com>
Subject: Re: [PATCH v1 5/5] bpf: clear decap tunnel GSO state in skb_adjust_room
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,martin.lau@linux.dev,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Mar 2026 13:02:32 +0000 (UTC)

--===============2343841723094614987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3665,6 +3665,37 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);

Should SKB_GSO_TUNNEL_REMCSUM also be cleared here when decapping
a UDP tunnel?

VXLAN and Geneve set SKB_GSO_TUNNEL_REMCSUM alongside
SKB_GSO_UDP_TUNNEL during encapsulation:

net/ipv4/udp_offload.c:udp_gro_complete():
    skb_shinfo(skb)->gso_type |= SKB_GSO_TUNNEL_REMCSUM;

drivers/net/vxlan/vxlan_core.c:vxlan_build_skb():
    type |= SKB_GSO_TUNNEL_REMCSUM;

After clearing SKB_GSO_UDP_TUNNEL{,_CSUM} but not TUNNEL_REMCSUM,
the gso_type has an orphaned tunnel flag with no associated tunnel
type.

> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6)))

This check does not include SKB_GSO_TUNNEL_REMCSUM. If a packet
had both SKB_GSO_UDP_TUNNEL and SKB_GSO_TUNNEL_REMCSUM set, the
L4_UDP clearing above removes UDP_TUNNEL but leaves REMCSUM. This
check then concludes no tunnel GSO flags remain and clears
skb->encapsulation, even though a tunnel-related GSO bit is still
present.

The kernel's own UDP tunnel segmentation in
__skb_udp_tunnel_segment() explicitly handles TUNNEL_REMCSUM as
part of tunnel processing:

    remcsum = !!(skb_shinfo(skb)->gso_type &
                 SKB_GSO_TUNNEL_REMCSUM);

Would it make sense to include TUNNEL_REMCSUM in both the L4_UDP
clearing and this encapsulation check?

> +				if (skb->encapsulation)
> +					skb->encapsulation = 0;
> +		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23194329334
--===============2343841723094614987==--
