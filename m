Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565223A3E6D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954468; cv=none; b=WmiVy4eDv4ttlYIMXEwMBSrxmQFn/54rYA8y5x3RbbctGXDgFeSxFjLTBCmrkKq6TbsLZii8fQkR2xqmJgMUNKx7xAC7Rh5fBOxJWc7ppWws0mYLJeKnpRxEvBnRBfUEX7Dj1ztmU+J+b9cDkare/omQcjZiQ93G/enmjDITcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954468; c=relaxed/simple;
	bh=T9rmKl9ZBqRlYzIHT/UULX/acBGTfh3Vc4p88TZyMT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LEE6iOiPwLR/J+1RcO/Qg4sweB67Y6HnwFraQbH44AbRCVg3VdBpXQfaQ2xQmCUu/45Gmx57QiZMBGkN3FA3bOPxd5fvT1oWBvqJNEnFKcRmXVIpKWhcrfKlU5JvVjwx3rApPGyA4GOdnKYuACK3UVeo3gSCrsHTxg1uAWiZ5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNQiirqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNQiirqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787D0C2BCB4;
	Tue,  5 May 2026 04:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954467;
	bh=T9rmKl9ZBqRlYzIHT/UULX/acBGTfh3Vc4p88TZyMT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VNQiirqWZaNDrsTq0kR0fE/UI9xks+6YWf67uPlAab7bvui0cXue7KRqk92cK4wny
	 jNQ+oH2fxI3ZQa42/P9lavPzZKpr17oUp/HaoS6dipqUzdno5RUTn//qB0OgskvxLj
	 p2YASjLsp9MqNnSMqVORWm2+zWSQvWITt+nOlS1R9MiM/VrDtvhv1ooaJkg25W6+LH
	 gsAWPTtfHlWyvAbQrnizRnsCFvC/rhEwlwER7bBafKI10bbLCwoscq0eN9rKJkvBin
	 ipPdtNPiICl/ayl8/l022NTACM7g3bhyuieRMClq5EuGNjy2/jbP0oxnf3f05VhcEK
	 udFYdb1QbOHkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504101759.3319427-4-nhudson@akamai.com>
References: <20260504101759.3319427-4-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:26 +0000
Message-Id: <20260505041427.787D0C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The documented API behavior fails to clear tunnel modifier GSO fla=
gs, leading to SKB GSO state corruption.
--

commit b28df908f04d4d037671bd0f85e9d43e6c3ddef9
Author: Nick Hudson <nhudson@akamai.com>

bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation

This commit adds new bpf_skb_adjust_room() decapsulation flags to describe
which tunnel layer is being removed. This allows later changes to update
tunnel-related GSO state accordingly during decapsulation.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> + *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
> + *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
> + *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.

If a tunnel packet has remote checksum offload, does this documentation
imply that tunnel modifier flags like SKB_GSO_TUNNEL_REMCSUM and
SKB_GSO_PARTIAL are left intact when the base UDP flags are cleared?

[ ... ]
> + *		When using the decapsulation flags above, the skb->encapsulation
> + *		flag is automatically cleared if all tunnel-specific GSO flags
> + *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
> + *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
> + *		removed from the packet. This handles cases where all tunnel
> + *		layers have been decapsulated.

If the base tunnel flags are cleared but tunnel modifier flags like
SKB_GSO_TUNNEL_REMCSUM remain, will the packet be left in an invalid
state where skb->encapsulation is 0 but tunnel offload features are
still present? This might cause the network stack's segmentation code to
process a packet with tunnel offload features but no actual tunnel.

Also, SKB_GSO_ESP appears to be missing from the list of tunnel-specific
GSO flags that prevent clearing skb->encapsulation. Could this result in
skb->encapsulation being cleared prematurely if an ESP tunnel is still
present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504101759.3319=
427-1-nhudson@akamai.com?part=3D3
