Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C72264C0;
	Mon, 22 Jun 2026 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169137; cv=none; b=kt1ygrviOEa508UDXKG5oDTa4EpMstr9fYHi27u954VCA+fz/5RUK6fEr9M603Jwm1FSNjWJE8K0oXAgkNwtFGqMmGpvNu7R9GKCk5uSx1CdAR/rBxK/0KLvuil/0QTNnqOqz32PJb1CexjIN+1Km+TS3ounaFcf1nP3oJyd5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169137; c=relaxed/simple;
	bh=aRrJVhQclOJmF//g4+smCBLA0DaPcDpwIePt7tco7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxNIAH5+BpcyUeEP9nxfOmAmYuOkEYp60kLjahGg1lgM7yXhv2nKkzLvu3dilpzDA5xB3h48wVqBbp6Go1ISoUNklgcVble0+/LvECZtuFx0MUAJoi9JCNua0FGoDC2lq7hAHP4Pl7alVV0AhO5gnea6W1Y/UdvZRjY+NQ7MsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN06kNND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN06kNND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EED1F000E9;
	Mon, 22 Jun 2026 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782169136;
	bh=cf8VFMdKAKyQGQAVq54fhWDFVL5UEpiUpHWH51/HhdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NN06kNND8KS4FEj3AmGiy6HruE4DdxRM45pxeV9AhqRglDlV9ogNIZ/6H5HuvNEhq
	 6/5sBQ8wRfewVea9KM2gx0Og0HdpoJsPqYiA8WvzmdFy37t28KtQ4xRA7z/CXlUUwU
	 Vog1Cy7kzzay7E+a+Qe/8xj/QjzzvzfZ6OPIaIHakTq7CubW9/WsAckg/M6hGbNjo+
	 i9XhBM13YpnqTwoHce0w+XBMphexZEkVVqFUX7kvtP6HcPl0v3ughvgM2psvjqb9Wf
	 JwU+GZE/uUTAxacyoqeHxWhhI6Cg+bvwFOY0KN5rcJka9C72x5+k0FIaL8xYHgJasn
	 TJZzGjoWbL2fg==
Date: Mon, 22 Jun 2026 15:58:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Jesper
 Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Jussi Maki
 <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Weiming Shi
 <bestswngs@gmail.com>, Ido Schimmel <idosch@idosch.org>, David Ahern
 <dsahern@gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
Message-ID: <20260622155854.75977aac@kernel.org>
In-Reply-To: <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
	<7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
	<CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 18:28:09 -0700 Xiang Mei wrote:
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 40037413dd4e..6037860d5283 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> > >       struct net_device *master, *slave;
> > >
> > >       master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > > -     if (unlikely(!(master->flags & IFF_UP)))
> > > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> > >               return XDP_ABORTED;  
> >
> >
> > I recall that when I previously modified this code, I removed the
> > !master check
> >
> > because this is on the fastpath. However, since this is a triggerable bug,
> > I think adding it here is fine.
>
> Thanks for the review. It's difficult to hit under normal statue, but
> the bug is real.
> We have triggered this bug with a PoC plus GDB to pause one thread (no
> other `cheating').

Can you double-confirm that this triggers on current HEAD
of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
NPD when removing a port from a VRF") was supposed to prevent all the
torn master fetches. Adding VRF folks to CC.
