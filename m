Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C86346AC5;
	Wed, 14 Oct 2026 06:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959454; cv=none; b=lfIRvWvtFP6P6cGRqCQde01TqSTE5TY7h5kC7+UsmfHXQ6jpSvvzMqj88VzJM6rEX+HrXP/Zq1G5P8jzL5HyxJ1uhyPZENpsKHHfDB5/RaCtjiEfdKOEKdjFgt6M0ZgJGsCg5MgVGKQQDyQgOsPbT5wY/88/K9pCxS5gaZa8vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959454; c=relaxed/simple;
	bh=O7S/PivgorR9gwvIx958BdtTZiVLwTnQwr1GR2IjtWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7Bv9YNI7UVClE+CfwfefrRpI40cYjIfHj+6TIs0T+LvtyU64gf27585RZvGXun6LogIbX9CG1SDchbPNO786WCaCrYi/U/MLOTarGw+M/B2u2xXwWr1Tyll8oWO6hYArBewNhqd9/57vEps3Ogc02WaxTtIZCn/vs5+g1701jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELbns02/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELbns02/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C641F000FF;
	Wed, 14 Oct 2026 06:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791959453;
	bh=O7S/PivgorR9gwvIx958BdtTZiVLwTnQwr1GR2IjtWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ELbns02/HWQnEJhvmKnomE/ctBLg6COCyF4VfcGn74tCWhiFG2RPCdZ254m/xNgwb
	 MSE+ocde7fkGG6LqM0ABtBd/7eiihoTuUxuKl22F+mz/52s2FVdK5MpJu/FcDf3L5P
	 SGAkclQ5GYq8rCrJqtYbhr71OOeysS1YcFK20FZp1tqfYfn9/3E8EoNaB1AvGw2wdm
	 vt1ol72FyDr3zB5Ue7Ruw0cHVVHdDi8ciehXwbIyiAUxs785eMyMqnJluifZImSjft
	 +gSdb7o8Spq/hxGyq4A2FpABOUUThvyAECC+xHl0i0Zt0ROYhomb/03ul5LUphpal/
	 qrDrG8gRf0ZtA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Cc: bpf@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, James
 Hilliard <james.hilliard1@gmail.com>
Subject: Re: [PATCH net v3] xsk: freeze deferred pool teardown without
 blocking unregister
In-Reply-To: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
References: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
Date: Wed, 14 Oct 2026 08:30:49 +0200
Message-ID: <87ik3494km.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Hilliard <james.hilliard1@gmail.com> writes:

> Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
> not frozen during system sleep, so that callback can run after a
> device has suspended and gated its clocks. Use system_freezable_wq
> so running destruction finishes before device suspend and new work
> waits until process thaw.
>
> Keep assigned pools visible to NETDEV_UNREGISTER independently of
> the socket list. A released socket has already left that list, but
> its final pool put can queue destruction after workqueues freeze.
> A resume-time unregister would then wait for a device reference
> whose release cannot run until the resume completes.
>
> Track assigned pools per netdev with netdev operations locking and detach
> remaining pools after the notifier socket walk, including copy-mode pools.
> This also covers leased queues without scanning pools from unrelated
> devices or network namespaces. Remove the entry on assignment failure and
> normal teardown. The deferred worker still owns the pool and later observ=
es
> the cleared device pointer, avoiding a second driver detach or put.
>
> The lifetime problem was identified by code inspection of the deferred
> release and system-sleep paths.
>
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from=
 umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Thanks, James!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
