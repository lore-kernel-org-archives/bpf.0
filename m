Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C33C988F;
	Mon, 20 Jul 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585336; cv=none; b=WcMMXr6pXg1qtp6fahKO59vhDQH4PnVakv6uo9ThpG9VYhoWv2eIFJ7sHSqBNqwKfmHX5YLc2wbxwDtU+zReXkbYw8g6Kel1++u8zF/wsrNI9ykwuyU4TsJN33E+RCtUeQwu49zLm+nuThzQhhJcwG9gTiJtKltae0UhiGmncFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585336; c=relaxed/simple;
	bh=6ZcSLCTlpeIECEMaTVZOgkzcpZtJ4JqCSc2WOUljvDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsDOuR+DoKugxeMm3C3RzA3zGR+y+lgtKNqoRinDAWrhex9D+0ef3pAR84JB95cRq8M9L9fOkTHv8LLhzr4IiA7fVzMKtvxWB4tUWfiRtzJOYGOXjnzQGZyyLeWa+IV7fcYMOV4dMbQIyVq4TryYe2bLLYw0bN2o7Rqle1AuzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT6UbtmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT6UbtmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966B1F000E9;
	Mon, 20 Jul 2026 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784585334;
	bh=z11ITbQvt4NP+i0GjTjmCBTKhf0Lxqrhu6WfRIGhnpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mT6UbtmYOcXsiFK7elvuKwRHp7wkmlw03MJRL5gqKdAITLpvWFTnN92LZxOKLVAcj
	 fXA1y3IrVJq/qALoBLutVthJWs6NmYVJ7RPOJ5wSk1RXGByldWP4//t2HWuNmCjQp2
	 ciykP2LyK2iACclGNuy2mMgN6gNl/30oqyv1T0gJxiQsFY6T0XgT7hzt1y7vIUTWpR
	 MBW156AzU1Ad82gIWGpqXDhgVPauUlTW0kFkWxhGT58S3tExitlwiz9EUbtRT6lsg4
	 dsY+rQPSG72eOv4NPr7XthzSTlx8UwILF0pPjRcVGHOAcGXE+InVWtBRsAAx8sfR9b
	 yFes13reBTApQ==
Date: Tue, 21 Jul 2026 00:08:52 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Message-ID: <al6cdHMBpd1SqZyl@lore-desk>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Poik8L3QQ7fei6lR"
Content-Disposition: inline
In-Reply-To: <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>

--Poik8L3QQ7fei6lR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/16, Lorenzo Bianconi wrote:
> > On Jul 16, Stanislav Fomichev wrote:
> > > On 07/15, Lorenzo Bianconi wrote:
> > > > Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
> > > > when a device running in XDP mode creates an skb from a xdp_buff
> > > > if the attached ebpf program returns an XDP_PASS.
> > > > The test attaches an XDP program returning XDP_PASS, and a TC
> > > > ingress program that runs the bpf_skb_rx_checksum() kfunc to
> > > > inspect the resulting skb. After XDP_PASS the driver must invalidate
> > > > any previously computed hardware RX checksum since XDP may have
> > > > modified the packet data.
> > > > The BPF program counts packets per checksum type in a map, and the
> > > > test runner verifies that after sending traffic the CHECKSUM_NONE
> > > > counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
> > > > counters are zero.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  Documentation/networking/xdp-rx-metadata.rst       |  5 ++
> > > >  .../selftests/drivers/net/hw/xdp_metadata.py       | 55 ++++++++++=
+++++-
> > > >  .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++=
++++++++++++
> > > >  3 files changed, 132 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documen=
tation/networking/xdp-rx-metadata.rst
> > > > index 93918b3769a3..7434ac98242a 100644
> > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > @@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by =
the kernel when building
> > > >  ``skbs``. However, TC-BPF programs can access the XDP metadata are=
a using
> > > >  the ``data_meta`` pointer.
> > >=20
> > > [..]
> > >=20
> > > > +If a driver is running in XDP mode, any existing hardware RX check=
sum
> > > > +(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invali=
dated
> > > > +by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing =
the
> > > > +skb to the kernel, since XDP may have modified the packet data.
> > > > +
> > > >  In the future, we'd like to support a case where an XDP program
> > > >  can override some of the metadata used for building ``skbs``.
> > >=20
> > > Sorry for keeping nitpicking on this, but I'm still not convinced that
> > > it is what we currently do. From my previous reply:
> >=20
> > no worries :)
> > My current take-away from the previous discussion is we just need to do=
cument
> > what would be the driver expected behaviour adding a kselftest for it (=
without
> > modifying any driver).
> >=20
> > >=20
> > > > > Looking at a few drivers:
> > > > > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > > > > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if=
 there is
> > > > >   bpf prog attached
> > > > > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > > > > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > >=20
> > > (although for gve I might be wrong, there is also gve_rx_skb_csum tha=
t only
> > > does UNNECESSARY).
> > >=20
> > > I'd wait for Jakub to chime in, but it feels like we should just docu=
ment
> > > what we currently do as a recommended approach: for the drivers
> > > that support COMPLETE, do not report it when the bpf program is attac=
hed.
> > > Both NONE and UNNECESSARY are ok.
> >=20
> > I am not completely sure the UNNECESSARY case is different from the COM=
PLETE
> > one. What are we supposed to do if the driver reports UNNECESSARY and t=
he ebpf
> > program modifies some fields covered by the rx-checksum?
>=20
> For unnecessary, I think the safe expectation is that the bpf program
> will update the value of the checksum in the packet if it touches the dat=
a?

I do not have a strong opinion on it.
@Jakub: any input on it?

>=20
> > > Also, did you run this test on real HW? NIPA now has HW tests, maybe =
it
> > > makes sense to route this series via net-next to get the real coverag=
e?
> >=20
> > What about splitting this series and have two different series:
> > - bpf-next: add xdp rx kfunc and related selftest
> > - net-next: add kselftest for the driver expected behaviour.
> >=20
> > What do you think?
>=20
> I'd post everything to net-next to get the HW coverage. Once you get all
> the acks we can ask the maintainers' guidance.

ack, I am fine with that.

Regards,
Lorenzo

--Poik8L3QQ7fei6lR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCal6cdAAKCRA6cBh0uS2t
rBbAAQDuKu2WNBvm2CcO6No6R6S427G1mLi7hdfmjTMduKOLYwEA9/j6hFjjCn7s
9OGAW6D4Pk31PHVDpSIYW7xQEkUWTwU=
=j1RN
-----END PGP SIGNATURE-----

--Poik8L3QQ7fei6lR--
