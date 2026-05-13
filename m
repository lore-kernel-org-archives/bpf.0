Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628383E9C10;
	Wed, 13 May 2026 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671901; cv=none; b=I0pdbKkvl8a0k+q0+01/e2awmEHPSXNXNqUzZfgwOP7hyL6XmUNwQDml7E6E5aSYeZOlIOJQlj3hALVZ9T0Jm/uF2nENFhHucof+2MND2v75YiQcwNl5kr/BM+qH8Vpr2pJRW67TFbZacNDVhyleGvNTvNSgbyYsyPwtISwT7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671901; c=relaxed/simple;
	bh=79nmjwvOuYGxlrHN2bZK1RkI8jZYVpwWr+HjSbP/FmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C8asbJZgksOe+MRViT7YESmZnMilNUQoa/BBhGM2wLG96VM2s+qKN7aX6xblJoi45BjXir7fxYBobLeBDTYjaY1O5gzEXYhzZrZugkz2t+7QeJ1arPnhkjrt/bH8+NsgIKFINL6VJlIcGc93JplV1W7yp6wUXH4DWi0AyL5t7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+GMv4JU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+GMv4JU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94875C2BCB7;
	Wed, 13 May 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671901;
	bh=79nmjwvOuYGxlrHN2bZK1RkI8jZYVpwWr+HjSbP/FmY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V+GMv4JUBmUpTHBMoAOuiSxgb9sMccjwDXyK+z6bfBc0YIkvQMou8ZeUXLxPI1Hdu
	 +TWrojsAdrHucdJZCBMZ2+JB+z6FFt/oMTlPxVSLaoXIIApSfC2pfL5BW0Ai0XAEaj
	 jPukqilcbZDGR5crQR2X+OLnWYd3mGsiIirDBXYZam1TyPcIcr/ipjAlnqphykY46q
	 BY9/gzLysJNoNBBotCM+4M6tf9mG0U34HAyKNbMNSVXWGWHQw0uAbDD6L0daXLRcur
	 /Ia5w8BuHkS9gUttjIXPEIwOE/H9ja/zEl4yQJSzrJQ7tK9hkwkCG80H2ZZX6/qg9d
	 6TZDfMHZFUHlg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, lorenzo@kernel.org, hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
In-Reply-To: <agNeGjzEsYRaqqFf@boxer>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-5-maciej.fijalkowski@intel.com>
 <878q9ok8ac.fsf@all.your.base.are.belong.to.us> <agNeGjzEsYRaqqFf@boxer>
Date: Wed, 13 May 2026 13:31:37 +0200
Message-ID: <87zf23im06.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Tue, May 12, 2026 at 04:32:43PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>>=20
>> > veth currently runs XDP for skb-backed packets by constructing an
>> > xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
>> > skb-backed xdp_buff into an xdp_frame. The backing memory is still
>> > skb-owned, so veth has to pin the skb data and frags manually before
>> > consuming the skb.
>> >
>> > Use the generic skb XDP helper for skb-backed packets instead. This
>> > keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
>> > xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets th=
at
>> > already arrive as xdp_frames keep using the existing veth xdp_frame pa=
th.
>> >
>> > veth still provides its own page_pool and xdp_rxq_info through struct
>> > xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
>> > metadata kfuncs that need the skb continue to work after a possible skb
>> > COW.
>>=20
>>=20
>> Hmm, so now if veth with native XDP redirects to a native XDP NIC, we'll
>> end up in the generic path? We'll loose some bulking capabilities as
>> well, but maybe that's OK.
>
> Hi Bjorn - thanks a lot for taking a look at these changes!
>
> This touches a path where receiver has XDP prog loaded but sender used
> ndo_start_xmit() to produce skbs onto another end of veth pair; these skbs
> are then stored within ptr_ring where receiver picks them up. Native XDP
> still has bulking, however the skb path has a little bit of back-and-forth
> juggle between skb<->xdp_frame conversion. Now I got rid of these
> conversions but also of home-grown generic XDP path as well as bulking and
> the end result seems to land in the same performance results.
>
> Does it make sense to you?

Hmm! Thanks! ...but doesn't this change the semantics of redirect, for
skb-input/native case?

target of redirect    before (skb-input)                     after (skb-inp=
ut)

real NIC via devmap   ndo_xdp_xmit(), bulked, XDP TX queue   netdev_start_x=
mit(), regular qdisc/TX path=20=20=20=20
cpumap                xdp_frame on remote CPU's ptr_ring     skb on remote =
CPU's softnet backlog=20=20=20=20=20=20=20=20=20=20=20
AF_XDP socket         native (potentially ZC)                xsk_generic_rc=
v (copy, generic)=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
veth peer (devmap)    xdp_frame into peer's xdp_ring         skb into peer'=
s xdp_ring (same ring, skb tag)=20


(Let me re-read it!)


Bj=C3=B6rn
