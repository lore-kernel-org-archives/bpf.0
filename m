Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557C169AD2;
	Tue, 27 Jan 2026 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473112; cv=none; b=Q+2GW1+GoLJuj9R8vay9ZMglI74XcmzXaKTtBD46PyGUCmknEpG5rz3QZizTbnsahUBUh+qH51PjpY55U26ma6ZeQA8imMcSfPlrvh6tO4scQTMzS7E9bNoK/j9mr48ZweVDGvFoc0Yg7m8DndOqSPAUX1MXzKpjHe0XlxqQ7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473112; c=relaxed/simple;
	bh=DKQowGTv3wlCMXbNOg1w0AS7asHMVRYYZCWnNi0uiHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irSnC29slf3QqGEIqwmbQueuoehIzeRSMm6kkRqonfPwUkWZ2IIaGFka3GpBcHQewMgP13wrXk93LGGn7y4KAXv+aHTaXA3kv5Mv8akwWy1xZDn9LGb4GCAT6YFlwtSWAtobpqQzbeiM3WpIoIpKOhyUpjWxlsw8/kntW4dvK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBxNxjER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBxNxjER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87640C116C6;
	Tue, 27 Jan 2026 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769473112;
	bh=DKQowGTv3wlCMXbNOg1w0AS7asHMVRYYZCWnNi0uiHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBxNxjERyjW5mJtsW8bUlGdfoEBuirVFkWrTkh2/uZADM1wZ/U5aIDjhIL/GRqxng
	 wYLxYT/D0FRS/0lP5drPvL1FY60gSi6fWu5YgIoEeJ+TFOz8tGvoMPDSeSGNFWQnDm
	 F2P5bSX2aGPLVizXKbQystnx2vNYcCBh4gEgiPu+9AB8x8esMkX8DHaRluE0yUj6nt
	 pizshVbsvFwrqsclvyDz7EjneAAKhAUcWRnYAaR6Ix+5StHjKoNrK21nhvOsSx4VCQ
	 iFfb+1/+86qzvUSAgT6FCvCng+lI3vzE6QKZWJkwpvdMwVeQuBySn6YN1sZFgT3EFQ
	 xvk9HlRO1UWTQ==
Date: Mon, 26 Jan 2026 16:18:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shenwei Wang
 <shenwei.wang@nxp.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 "ast@kernel.org" <ast@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "hawk@kernel.org" <hawk@kernel.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [v4,net-next,13/15] net: fec: add fec_alloc_rxq_buffers_pp() to
 allocate buffers from page pool
Message-ID: <20260126161830.58ba78b3@kernel.org>
In-Reply-To: <PAXPR04MB85104AD2673A1D58131CEBD48893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260123022143.4121797-14-wei.fang@nxp.com>
	<20260125214519.3384279-1-kuba@kernel.org>
	<PAXPR04MB85104AD2673A1D58131CEBD48893A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 02:37:01 +0000 Wei Fang wrote:
> > > +	if (is_run) {
> > > +		err =3D fec_enet_alloc_buffers(ndev);
> > > +		if (err) {
> > > +			netdev_err(ndev, "Failed to alloc buffers\n");
> > > +			goto err_alloc_buffers;
> > > +		}
> > > +
> > > +		fec_restart(ndev);
> > > +		napi_enable(&fep->napi);
> > > +		netif_tx_start_all_queues(ndev);
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_alloc_buffers:
> > > +	if (enable) {
> > > +		xsk_pool_dma_unmap(pool, 0);
> > > +		rxq->xsk_pool =3D NULL;
> > > +		txq->xsk_pool =3D NULL;
> > > +	}
> > > +
> > > +	return err; =20
> >=20
> > Similarly, the err_alloc_buffers path cleans up the XSK pool state but
> > does not restore NAPI/TX or restart the device when is_run was true.
> > Does this leave the device in the same non-functional state?
> >  =20
>=20
> The current driver does not support allocating the buffers first and then
> replacing the old buffers, so calling fec_enet_alloc_buffers() again in t=
he
> err_alloc_buffers path may still fail and potentially make the device
> unusable. I will think about how to change this situation. Thanks.

Yes, a lot of older drivers don't. We make people improve things
whenever they try to add major features =F0=9F=A4=B7=EF=B8=8F BTW I'm quite=
 impressed
that AI pointed this out.
