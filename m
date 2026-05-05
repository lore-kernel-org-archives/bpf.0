Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEC35A3AE
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954469; cv=none; b=V2CeFaJyBtLCND8AYd/7Ix5ZPaYJ7lPUyzilFMYJugBZHalJckwI9Mil7ACYax37KPE6EGHO0jdgKpD7grtwiIIgmy7qAoXB5zYFSrjo8L710sL3y+gq6hR+KJoTuYrRZE4mY5tBso50xqD9WMgq8/a7X4ISB1pcyHVt05znE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954469; c=relaxed/simple;
	bh=tGOpWSjh37AbZwLwqbu0SLRaXmqOt0tntJZDi5e5CJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GIyOsLGPPs0U+yhOEgxrPVf76FnAt0xoh6M4bYhtJMV6LllXXlbkVMf/PbSkWj3rLpx7kflVq+HWHiRr7dVjQhQfx+kzViTI9PhbYN4guhf+jSypXa8R8CG2Wf0r1VqAzyrji6+F3I2mXlQ6X7IdFjKFanQRbYirCdAjai5O1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeZ3/c1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeZ3/c1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62BC2BCB4;
	Tue,  5 May 2026 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954469;
	bh=tGOpWSjh37AbZwLwqbu0SLRaXmqOt0tntJZDi5e5CJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KeZ3/c1D6Nbk+K42sf+XNJD98ZImqfHEoGooMip75DvM81jeoGIRkcukbMyTw0gpl
	 KPu2XE22UtP9NOfaCVfY+TrtV/gQMcgL20mVlnPd1011TeomAvstgbFxjjfRV+RmEy
	 ltU41xi6/i2C8vDBPcjsvgbGarerIu/k7G5x3arJtshjchwLIF5f+RaaX2YecKy2bC
	 wIrsHDJokKyjjR5smOZZ9Mk67SZWsiYQM9wqALCkzYCAhZMP/y28glL6V7Fp382ZVN
	 grO5w0ic58CIicZ12EqVNJ18zNpo+ytSWPtCQZWS17YsErcNhkViKmu24QvwNsipbu
	 AhMkA/OSamL+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] bpf: allow new DECAP flags and add guard rails
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504101759.3319427-5-nhudson@akamai.com>
References: <20260504101759.3319427-5-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:28 +0000
Message-Id: <20260505041429.1C62BC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Omitting the L3 decapsulation mask bypasses skb_dst_drop(), leavin=
g the decapsulated inner packet with the outer tunnel's routing destination.
--

commit 65429a5bdf5c795afb0af1f3ce1b31c6d08218f7
Author: Nick Hudson <nhudson@akamai.com>

bpf: allow new DECAP flags and add guard rails

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1a96d0af1704..04871a57f085 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3484,6 +3485,12 @@ static u32 bpf_skb_net_base_len(const struct sk_bu=
ff *skb)
>  #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
>  					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> =20
> +#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)

Does omitting the L3 decapsulation mask bypass skb_dst_drop()?

In bpf_skb_net_shrink(), dropping the stale routing destination cache is
gated by the L3 mask:

    bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
    ...
    if (decap) {
        ...
        if (skb_valid_dst(skb))
            skb_dst_drop(skb);
    }

The UAPI documentation states that L3 decap flags are "Used when the inner
and outer IP versions are different". This instructs users to omit the L3
flag when decapsulating a tunnel with identical inner and outer IP versions.

If a BPF program follows this and uses BPF_F_ADJ_ROOM_DECAP_L4_UDP without
providing an L3 decap flag, decap evaluates to false.

Could this bypass skb_dst_drop(skb) and cause the newly decapsulated inner
packet to incorrectly inherit the outer tunnel's dst_entry, routing it to
the tunnel endpoint instead of its true destination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504101759.3319=
427-1-nhudson@akamai.com?part=3D4
