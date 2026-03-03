Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763E38C427;
	Tue,  3 Mar 2026 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529949; cv=none; b=cl0MyZaQ7D3fhVrR8Ph+ruKEol/bOyE2VlWKTYro+qmRjGi7u98EElob9GbBCA0q/dhJNyxq0yje/jghp3kYYLcOHh9ikbPFtP8DktpDyQj4Lj/2PIUoL3nHmU1ghetepqYmVndXx5rueuuDbDtWdDNsnEID4xD3OPTTHvWJZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529949; c=relaxed/simple;
	bh=2z8ZSyC5A7LLCOOWT8EV9tuw/GmjD3s5IHXtdve+8Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8TrYe1l4Rqzw6e+FGY5lYwGRNtIjL6PQScOe4Of3Ck4x0sDbryzihBjHyBnpstSC1XxX+QPTTeA5AzEUc9crfM8MYtQN8b0y1VHGfsqbh2e4T59NW5mVYyYu/2ZFlaeyr1g5+zC+iS8EibhmskNrrpBrMPy2uHWFkl4boqJZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeyjEFQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeyjEFQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56996C2BC87;
	Tue,  3 Mar 2026 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772529948;
	bh=2z8ZSyC5A7LLCOOWT8EV9tuw/GmjD3s5IHXtdve+8Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeyjEFQMukw3TU8d5tOoDLzd3ODMTrHFhlOmHqLJBRHk1ybfs/HzLXRzD8+RhvdyS
	 EIcansrNtvHYscxkbudam4Ys/cs/RV0zLEi9KxRvWw8kk5gGWe+GcVCvChwK3EOfs6
	 RAK2QT394GtuMA4811HyKgLz7/60l9UPzRKs6xxDBjej/YaRRdlAB+fM+gUx8gHe2V
	 YceWVCmdeOuRCGLYI07ztlafMcO2Lt766kX5V99XTMKJZAO1E8OQ/YclLqWthx++6F
	 ifn/8lgvE0DIc256/bKLBh2/wLPLecfGmWkVzxUP7d3HN5wb83KcKnd08caPKt2nk+
	 5ejoQlh/diXAg==
Date: Tue, 3 Mar 2026 10:25:46 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: Reset prog ptr to NULL
 in case of error in mtk_xdp_setup()
Message-ID: <aaapGn50iQ54jl8t@lore-desk>
References: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>
 <20260302182909.06de1942@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yCyu0DIjJWfjcGTH"
Content-Disposition: inline
In-Reply-To: <20260302182909.06de1942@kernel.org>


--yCyu0DIjJWfjcGTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 27 Feb 2026 16:52:11 +0100 Lorenzo Bianconi wrote:
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -3751,8 +3751,16 @@ static int mtk_xdp_setup(struct net_device *dev,=
 struct bpf_prog *prog,
> >  	if (old_prog)
> >  		bpf_prog_put(old_prog);
> > =20
> > -	if (netif_running(dev) && need_update)
> > -		return mtk_open(dev);
> > +	if (netif_running(dev) && need_update) {
> > +		int err;
> > +
> > +		err =3D mtk_open(dev);
> > +		if (err) {
> > +			rcu_assign_pointer(eth->prog, NULL);
> > +
> > +			return err;
> > +		}
> > +	}
> > =20
> >  	return 0;
>=20
> Maybe there's something special here, not obvious without context,
> but why are we setting eth->prog to NULL rather than old_prog?
> At the very least the commit message needs to explain..

Reviewing the code I agree, we can just restore the old program, moving
bpf_prog_put() below the error condition. I will fix it in v2.

Regards,
Lorenzo

> --=20
> pw-bot: cr

--yCyu0DIjJWfjcGTH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaaapGgAKCRA6cBh0uS2t
rIStAP4k8YfdaIeG/OvYD60XFhFefPws3OFtIzDTK6JLsChQ5AD/eA9wJQv6eO5c
T2X7PaXMz/PBi9Y7g9wayveHv1am8gc=
=ljTC
-----END PGP SIGNATURE-----

--yCyu0DIjJWfjcGTH--
