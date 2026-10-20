Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461637;
	b=fDLddZD2oAIRPVfl//Wc8NOskz3+E+/BWZQUbqse51bVEjYxv73ww3060N/oo3ITHDrq
	 3jC0onYIWrinUWhbl++GHASAaOapd5T0qRcS3wvoS1zFgSFAil9dwrj4soNPFAqA2WgUX
	 SjQBwXsH9M2Li6ilUfBDK+hDe9/YmKEtY42bOwCISARKRuSkPuSQjrfHNEZnvr9ul7QmL
	 e2v8eREGXbZLYCiQqCeuI7A49bCFMkfYpEuuRiPaxhssF5otSHkutYqGQGxK8TP4Gvycs
	 iRmERCAtgvLkjcovFAeGK4ElGzDxCHGZ4d/iwlLnEJMw31hC4NwgP9FxJ0sjIe8aaHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461637;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JlodduQldZdsStWJrjgdzJgqzFFrar5i3dmdR0/tpuk=;
	b=vuVSDJGXtkMPlfd6SfxMMZnlAksZkYheTQ4fhzt//N8UG2OSP35Pbp1/+iN56BBHFkmL
	 2i1X7AJFM//fEFXiZ5mBIqpATpKPOELOyy+iTX3avsjFLaQceSQvycvokKlV6qyOf5oG/
	 JpcdSY8/3ImUYPDHWzbCHgNoew32RQMamAhbxBAr5uXCMPnR6ZBJre9UjbLHIXps5ILuZ
	 2/WDKzi8O+rE6IM2HbuNzlOITIAtnx1iieKaSoS2igUsAA9hLiRr9cREVObfgiXDWNo0e
	 APP4DTwax7pfEmAb4Tx9n04eopol5u/leX2dOc8ETex4ZsQ/4hauzaYB4MEzjQRfEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fX22Ah8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE345606A319;
	Tue, 20 Oct 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fX22Ah8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3571F000C4;
	Tue, 20 Oct 2026 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461636;
	bh=JlodduQldZdsStWJrjgdzJgqzFFrar5i3dmdR0/tpuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fX22Ah8aZrRJqDcfW+nPRCo2sGrBATBa6L38IXJVuy3esscBe+LDQwt9um8KJVp4v
	 YQh6HqKf3aEuRWKkURcTmYh3n/6eiBAC8eF/FwfMGtXQR9k35kIxn0V4ctVOq4B9AN
	 BnP4v4FXaTPFd0jQGkQqr/l2kQkUEvIxF7YmhP9rVgUvFBlSAyfk6UjMVbRr5dTqR6
	 czsHrahS+ooGy+qDR3u+vK5usX8ZvoHaxAaq8jDbgMAbSuN3d0X28NwR0a3+u6f7WS
	 w6Z5CcYccQAEEKleHBEZ+n6/nnC4XetXnvNDMzo81KGGr2+qL+yF/XjC64QQmpjiib
	 Vhqx5p7Zzwbpw==
Date: Mon, 19 Oct 2026 19:00:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: <netdev-bot+sashiko@kernel.org>, <alexanderduyck@fb.com>,
 <kernel-team@meta.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <edumazet@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/4] eth: mpnic: report per-queue stats
Message-ID: <20261019190035.4c3ebf4d@kernel.org>
In-Reply-To: <DM3QWDZ4B408.2O12B5PXKY8AR@gmail.com>
References: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
	<179189313526.434549.10762925482009523771@kernel.org>
	<DM3QWDZ4B408.2O12B5PXKY8AR@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 09:30:02 -0400 Daniel Zahka wrote:
> > The counter semantics come from "eth: mpnic: count packets, bytes, and
> > drops per ring" earlier in this series. This patch is the one that
> > exposes them as qstats rx-packets and rx-bytes.
> >
> > The later patch "eth: mpnic: count Rx allocation failures" also counts
> > skb build failures in alloc_failed. Those packets still stay in packets
> > and bytes.
> 
> So, the question is whether or not rx-packets, reported both to rtnl
> stats and qstats, should count drops in the driver. Here, drops are
> either running out of shinfo frags, but really just skb allocation
> failure. 
> 
> The docs for rtnl stats strongly suggest an skb allocation failure
> should still be counted for rx-packets.
> 
> The docs for qstats imply the opposite. Especially when xdp is not
> present, which is the case as of this point. Once xdp is introduced,
> though, counting an skb allocation failure in rx-packets becomes
> reasonable by the qstats docs, because xdp runs before the point of skb
> allocation.
> 
> Another option would be reporting rx-packets differently for the two
> APIs. I think this is not desirable, and seems to violate what is in
> the stats.py selftest.
> 
> So, I could either submit a v3, which would just be reverting to v1, or
> take the approach here as is.

The rtnl stats and qstats are supposed to behave the same if maintained
by SW. I should have been clearer in the doc but "XDP is considered the
first layer" was supposed to mean - if you reach the point in the driver
where you'd call an XDP prog - its a successful Rx, whether the XDP prog
is actually attached & called, or is NULL & skipped.

I believe the series is good as is.

Acked-by: Jakub Kicinski <kuba@kernel.org>
