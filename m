Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B8303C97;
	Mon, 17 Aug 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975822; cv=none; b=G4PHsaLgbElfHuMS26QPPAv1bb9YnUpP4Z9nlFIEYeE39/ELn8v6t0THWHbt/ZroU9MXxl6iGWgCu5psKK0M7wcEHuDknvsIWkjV24WlZDX9zYReqJQGAyNm/9D04zcfeBTlnazJdaMxND566r830/RGzUne5Vl8giC5MM0h3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975822; c=relaxed/simple;
	bh=cfCsZYXp1CeSp0NWC2XaEz0mV5RIklZvXfVcBpK4rx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGBB2HeVgDL3zfBqZQj6f8D8G7+NhvJhJnQxBZmSgf0S9IOBp1w2S3rasRLWgAh52dxr3vTRdxkiM/gmAHUlfJYRU7qZynhlGo+rvV5jG3ixLtLaNzf5rWpV7CX0jDNkJDhNahnuYFxBfwB6vpEOHInqXybnKieP/oL9iG3kRxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agd7moFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agd7moFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582C31F00A3A;
	Mon, 17 Aug 2026 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975820;
	bh=B33tnM32NTZa66KFwDiTusPS02b0SsXFaef5soJ/5a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Agd7moFmm6nWcqvd25KuPzNzl08P+K9QrOohu/O0oOULXUMjyAvOUqe/B45HnCJBS
	 C+3LsCDu7A9VCxzt6kgPfS7Or2Nc2pbnDhz7vy8/s4ISp2xWb3ZcNBC4Rsvw/H+425
	 YpRpu7/Lz3Cj8WNw9RulXt09BXaTmcvCXajq6j+hYE+g8WXn+w12C6/yVJwIHqCHVn
	 Rhu0Cs5dgRBQcDFR16u0yEuAr7gpoaI3A8mNN35ZRBEZN8XkgkjZ9oHReQQsxS2EkL
	 sC9+Nb6EDeumy4FAIl91nbX6F1adATQlMm+qrA8d7KDbjBQs3+khxzBtY9sDC73gVs
	 Cp/OMrqqu9aAQ==
Date: Mon, 17 Aug 2026 15:10:16 +0100
From: Simon Horman <horms@kernel.org>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: magnus.karlsson@intel.com, kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v4] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <20260817141016.GZ265046@horms.kernel.org>
References: <20260813215328.99311-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813215328.99311-1-blbllhy@gmail.com>

On Thu, Aug 13, 2026 at 05:53:28PM -0400, Cen Zhang (Microsoft) wrote:
> In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> loop without checking its return value. xsk_buff_can_alloc() only
> counts fill queue entries without validating their addresses, so it
> can succeed while xsk_buff_alloc() rejects all remaining entries and
> returns NULL.
> 
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> 
> Fix this with a two-stage transaction. First allocate and stage all
> buffers required for the packet, recycling all staged buffers with
> xsk_buff_free() if any allocation fails. Only after this stage
> succeeds, copy the data, reserve the RX descriptors, and release the
> buffers in an error-free loop.
> 
> Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

