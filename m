Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36035958;
	Tue, 12 May 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596367; cv=none; b=YeccS3BjXtKqR7Jdy1dq+EvZieLTYzPxhJa6C+jNb9CCVSRY3dum1AmYP6NLD0fwhI3WdRbGr622Z9PgNBY+J0OnKaUK1S/t6VeVsdeRqo3UveV/saA+73fN3c8oiJCJ/k4RZyAd8kFr3Q+8ur6pPiJYTD2rNCPeSMJUyvuyd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596367; c=relaxed/simple;
	bh=y3QM0+OVP2mJ84raPj/jp3E4v8AyEL0XEzOLGP/ypyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOL0bptRl7irmiSJWmrSqAhw1fx/llHk4Le7rDvOHQCzMUMR14OugbjYbfFUZciKYrlSBSH9w+oVwqcRQXS7uLrwp7aiIzxu+ki9JrV3LeHuRliKYsQ9Oq+51ado1OBM3RIryHyFsyfeNl0t1VTyyFQzoHP0R4yxqrczKiCuWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpyNFn3A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpyNFn3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6CFC2BCB0;
	Tue, 12 May 2026 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596366;
	bh=y3QM0+OVP2mJ84raPj/jp3E4v8AyEL0XEzOLGP/ypyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EpyNFn3AwjiUk3PMNr6UO/vqEYY0IZx27wR+ZFKgXuoug28RfhwTXZ9/TGPd6KXog
	 wdpeRJDd02NAkrC4bMwhTMrTqhUckqR0BXtPm7UGXFXwHPMr5FgplQXGaQ6qnzK0jc
	 hefVwjEr3GfuPEcnaD206w/pPe2VFM9hOzcVNUZeRrsGlDslHHqAlBkUfV7YCW2sDp
	 36kJVZHBx4zBd3g+PJFopYPM8jGf1mZGOmUpx+Xze+fbQ4bHUY8m0HUR9KzciDsRxF
	 Rmn21j7eTL1dPwii9Rg2p9rCzHbq1KWb/o79uawYikMWWHjI1dR0YzA0PdmAFl75Yl
	 8G+EH4z1XvbNg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
In-Reply-To: <20260509084858.773921-5-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-5-maciej.fijalkowski@intel.com>
Date: Tue, 12 May 2026 16:32:43 +0200
Message-ID: <878q9ok8ac.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> veth currently runs XDP for skb-backed packets by constructing an
> xdp_buff and then, for XDP_TX and XDP_REDIRECT, converting that
> skb-backed xdp_buff into an xdp_frame. The backing memory is still
> skb-owned, so veth has to pin the skb data and frags manually before
> consuming the skb.
>
> Use the generic skb XDP helper for skb-backed packets instead. This
> keeps skb-backed packets on the skb generic XDP path: XDP_REDIRECT uses
> xdp_do_generic_redirect() and XDP_TX uses generic_xdp_tx(). Packets that
> already arrive as xdp_frames keep using the existing veth xdp_frame path.
>
> veth still provides its own page_pool and xdp_rxq_info through struct
> xdp_generic_ctx. It also keeps using struct veth_xdp_buff storage so
> metadata kfuncs that need the skb continue to work after a possible skb
> COW.


Hmm, so now if veth with native XDP redirects to a native XDP NIC, we'll
end up in the generic path? We'll loose some bulking capabilities as
well, but maybe that's OK.

I guess what I'm saying is that some performance numbers would help
here! ;-)

(I think it might be some accounting bug as well, but I need to re-read
it!)


Bj=C3=B6rn
