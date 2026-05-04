Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233F21D3D6;
	Mon,  4 May 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892586; cv=none; b=oihzeAzerClmbYNGmVLHUF8Ksrzb8m4PpBQxj5J+N14WcsNZwp3qBM9PrRDQXlTFU6hKwCMmj1Krm2LQo1joo+MR+LCPr64dR5Mw0WNX3sZkFxr5OD1D6tXpwJOMqf4nphB/QvZOP0S/OVkxISmBXpZ/JhquSpUOuGqKd+KWqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892586; c=relaxed/simple;
	bh=McP0r7T7zcCf+iF0H+1tFE2aMAVILGiauj75B3YAjT8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uLJThESPvKWwM/waFi8yL8nlXzlBPidzaFOn3MnkdlGa7Cka/gzN7P5r/DboHYJ0vppN1r4aBNAUnKXasHtWbAl/VRll/IZ7tJ394zFBKHSX9k6YpDFTTD1k63hNDe/4r0dDM2oYDsdgf3KBJ3zIWnbEopoKxM0EIBcdxq5f9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS83p78I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS83p78I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23ECC2BCB8;
	Mon,  4 May 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892586;
	bh=McP0r7T7zcCf+iF0H+1tFE2aMAVILGiauj75B3YAjT8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OS83p78In/8eA3ry1KuTHWpmKry23wj38V9qT+/uOl5clK81bbqXTy4mg2+DlKIF7
	 k++GVpKW+PSdO13+ARiayS4/8vUVBV7fML9UDFI3MtqlTEFBP6T+ia4LNEQ70UQA3K
	 sY7rkBOxb9jZFJDbwuk40wefWQcysrdgJwmZW2NvGa3V8eDTmVxCjGOIjxUjDa4IVo
	 9XZ4uUYTrpWvQk1GE4V3ZI9mUov3uNnQ3BJVe7X2uxMkCpxbVwuyHBZM+VhS64TdWO
	 90n46v6JovhhgjfhT9nQi9YhKbliLoHUeZ8kZYT0uG6iK+tnGv51mTkPFY1altWx6Y
	 +javKaViJF82Q==
Content-Type: multipart/mixed; boundary="===============5615260453470546558=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <edd6b1bdae345d0426cbae30578ee57463a40ab19640fdb81125e36aa7bf7f38@mail.kernel.org>
In-Reply-To: <20260504101759.3319427-4-nhudson@akamai.com>
References: <20260504101759.3319427-4-nhudson@akamai.com>
Subject: Re: [PATCH v6 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  4 May 2026 11:03:04 +0000 (UTC)

--===============5615260453470546558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c021ed8d7b44..4a53e731c554 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3010,8 +3010,34 @@ union bpf_attr {
>   *
>   *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
>   *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
> - *		  Indicate the new IP header version after decapsulating the outer
> - *		  IP header. Used when the inner and outer IP versions are different.
> + *		  Indicate the new IP header version after decapsulating the
> + *		  outer IP header. Used when the inner and outer IP versions
> + *		  are different. These flags only trigger a protocol change
> + *		  without clearing any tunnel-specific GSO flags.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
> + *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
> + *		  when decapsulating a GRE tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
> + *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
> + *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
> + *
> + *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
> + *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
> + *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
> + *		  or IPv4-in-IPv6).
> + *
> + *		When using the decapsulation flags above, the skb->encapsulation
> + *		flag is automatically cleared if all tunnel-specific GSO flags
> + *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + *		removed from the packet. This handles cases where all tunnel
> + *		layers have been decapsulated.

The documentation states that skb->encapsulation is automatically
cleared when all tunnel-specific GSO flags have been removed. Does the
implementation in bpf_skb_net_shrink() handle non-GSO packets correctly?

In v5 review, Martin KaFai Lau noted that the GSO flag clearing logic
is only executed inside the if (skb_is_gso(skb)) block in
bpf_skb_net_shrink(). This means non-GSO packets bypass decapsulation
state clearing. When a non-GSO packet undergoes decapsulation with
tunnel headers stripped but skb->encapsulation remains set, downstream
network stack components may misinterpret the packet as still being
encapsulated.

Note that bpf_skb_net_grow() sets encapsulation regardless of
skb_is_gso, which suggests non-GSO packets can have encapsulation set.

This concern has been raised multiple times by reviewers but has not
been addressed in the current version.

Reference: https://lore.kernel.org/bpf/2026427201356.-eYM.martin.lau@linux.dev/

>   *
>   * 		A call to this helper is susceptible to change the underlying
>   * 		packet buffer. Therefore, at load time, all checks on pointers
> @@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
>  	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
>  	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
> +	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
> +	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
> +	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
>  };
>
>  enum {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25314425016
--===============5615260453470546558==--
