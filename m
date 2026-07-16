Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70858370D75;
	Thu, 16 Jul 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218016; cv=none; b=Zxi8o8up7caprNQAGrh/p5o0tWvysmigqImNcbKg1a44KkveiiJNr4POM8Irmjo937GJRG3S8V6CF7hXz/RVGVcIO/qZG8fQkLoalvqWEiNRAmFdwJYAMeORKG38Fj5j3fPlHlAVdxcYASa2QGoI2eWpLp1BkUgnY854E2IG2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218016; c=relaxed/simple;
	bh=ryw/8DdSuXt+Pr45lTPQafMiLHoAQsM8RkcArbORWXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3SYPD0tkLdNEuJs0bJpHMbnwKxv6L/NSlGDpypJ6v2wE8sSWWlfiBwqEJzxqN5joPVvdK0TPXuEQojjxZbwVtme25Afy34Wv38eNDzDWI/QTLkSQVgzpwwL/3X/BMt/Rl/mTmMnfdIfPsd6lPmjcQQLiUMwMqnqvOdd/5IGfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRzhBV2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRzhBV2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714121F000E9;
	Thu, 16 Jul 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784218015;
	bh=E5duo1e3ULLzb5pSR2o2z4e41yjvHq5ZLuI68o0BYTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRzhBV2A1GSUiwA8eeJbb17ObnzMzPWP/5SADGAHk4mrPoGwiiMn9zH8sFewuchzP
	 cPAy7Ncp6N/WKHqhrd8OSD8RAP6J0lkvz7GWuW63x/rb9EWUJhwXwD3WM4BiLbjE5K
	 4Zuv051G76/f+nf+tBXlfr30QNjbfpTzCzcSx0xFAauJCkkAolpbB39kXXKyWOKaOz
	 r0eVtr86EAvajF/UIKYtsZ50aWYv5ypGesD9+yVAiAtkmgZoSj/jmLmuqRR7MlraVr
	 mFx6GTkoSxI3fmC2OiCYSkOSknX4gY53tqYOhTOrov4xpUBR608rUHOfmbBhInU8xn
	 uBK0+MkLceWwA==
Date: Thu, 16 Jul 2026 18:06:52 +0200
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
Message-ID: <alkBnI3XcH0XGjEo@lore-desk>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ElzzijxzuPzOLRvz"
Content-Disposition: inline
In-Reply-To: <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>

--ElzzijxzuPzOLRvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 16, Stanislav Fomichev wrote:
> On 07/15, Lorenzo Bianconi wrote:
> > Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
> > when a device running in XDP mode creates an skb from a xdp_buff
> > if the attached ebpf program returns an XDP_PASS.
> > The test attaches an XDP program returning XDP_PASS, and a TC
> > ingress program that runs the bpf_skb_rx_checksum() kfunc to
> > inspect the resulting skb. After XDP_PASS the driver must invalidate
> > any previously computed hardware RX checksum since XDP may have
> > modified the packet data.
> > The BPF program counts packets per checksum type in a map, and the
> > test runner verifies that after sending traffic the CHECKSUM_NONE
> > counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
> > counters are zero.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/networking/xdp-rx-metadata.rst       |  5 ++
> >  .../selftests/drivers/net/hw/xdp_metadata.py       | 55 ++++++++++++++=
+-
> >  .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++++++=
++++++++
> >  3 files changed, 132 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentati=
on/networking/xdp-rx-metadata.rst
> > index 93918b3769a3..7434ac98242a 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by the =
kernel when building
> >  ``skbs``. However, TC-BPF programs can access the XDP metadata area us=
ing
> >  the ``data_meta`` pointer.
>=20
> [..]
>=20
> > +If a driver is running in XDP mode, any existing hardware RX checksum
> > +(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invalidated
> > +by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing the
> > +skb to the kernel, since XDP may have modified the packet data.
> > +
> >  In the future, we'd like to support a case where an XDP program
> >  can override some of the metadata used for building ``skbs``.
>=20
> Sorry for keeping nitpicking on this, but I'm still not convinced that
> it is what we currently do. From my previous reply:

no worries :)
My current take-away from the previous discussion is we just need to docume=
nt
what would be the driver expected behaviour adding a kselftest for it (with=
out
modifying any driver).

>=20
> > > Looking at a few drivers:
> > > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if the=
re is
> > >   bpf prog attached
> > > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > > - gve (gve_rx) - can do COMPLETE even with xdp attached?
>=20
> (although for gve I might be wrong, there is also gve_rx_skb_csum that on=
ly
> does UNNECESSARY).
>=20
> I'd wait for Jakub to chime in, but it feels like we should just document
> what we currently do as a recommended approach: for the drivers
> that support COMPLETE, do not report it when the bpf program is attached.
> Both NONE and UNNECESSARY are ok.

I am not completely sure the UNNECESSARY case is different from the COMPLETE
one. What are we supposed to do if the driver reports UNNECESSARY and the e=
bpf
program modifies some fields covered by the rx-checksum?

>=20
> Also, did you run this test on real HW? NIPA now has HW tests, maybe it
> makes sense to route this series via net-next to get the real coverage?

What about splitting this series and have two different series:
- bpf-next: add xdp rx kfunc and related selftest
- net-next: add kselftest for the driver expected behaviour.

What do you think?

Regards,
Lorenzo

--ElzzijxzuPzOLRvz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCalkBnAAKCRA6cBh0uS2t
rPfeAP92miqJLHCgGcEjkwWMtzU1QP6SExcgCM79rSSWD5aqNQEAmxZYo0+AUDM1
V3y0mAsCmwsVJd0ivV0BdldoECsJxwU=
=muiS
-----END PGP SIGNATURE-----

--ElzzijxzuPzOLRvz--
