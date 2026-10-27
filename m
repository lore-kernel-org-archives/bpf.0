Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118617;
	b=g2Ixx6yr29/xD2M108xcGUIxLciwANuScqyvF7GHm2XqxBNNXIt9C6PyDoSi0sMaLi7A
	 f7Fl93VGFptbGnyo4CI9Pomw4DHYeFD8ULUHlvMAOCCQnXQQe3P1JBICSlpDGBCdEP2OI
	 1A/5e45oJJrSzMJfaT//mjBSn8eBnlu1hLcuaLHNEyFDCHS1uuI/ekVfyaQzwkwKu/4CE
	 KfrYW7HCQwDUJjMIkQKeius+DAbRRI9UXJQ4U939pGqRVJuVu3R5mO6ramteej0d8eeG4
	 lKxQbwF1WABNkJiDX1QgxdwJceW8HEdblYIEk6YGAQGIglh8hJmzuTSNPKamfaam49Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118617;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
	b=3CKE8afuEtLhoG9tACGOmBs1YINAMAgaT20V5PQJEYunLPGVadH1ozr3lJpt4mz3VpOr
	 G6CY87j/pVedK8iyWWuXSFRIFgiK7Ftiu5L7LmCT96l/PSHNl+xrdJpboUPkoBXvdVbiZ
	 GhJ9G+wPZ4CaHtOU2Lu5RsTwnbDdv3d5RVLurE0L+a5iJCkibaDBDxyFSLyVhXe4sZkHm
	 +5d2gnJbt6Js4+lwVssJaP/ehkOu/lGeDaTVQhETtEGXR4jSr0YvSheuCdB1qK6YFtZx4
	 7Nfd4WfR7gWG+WmeMCeYoKtZAIv4PD8900NbYvceufjPf4ttCfVF1nGbZ1s90jOHJEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10C606A327
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D10C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793118607; x=1793377807;
	bh=z/3jpXuKR8Ek75myDtIS6oISZLc5tTxlxTmwToUVi/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nSWkwrSpNgrFzE4n9LAMKt6PEdv8HOS2JVM7mE3Zo09iiDZ13pynId9Ydvnu4M3UB
	 iH+w5WgWV/iHrwO47RGhPAi6+bmNcOPtitVsUlSfGdJCSIlAHRd6BbG94qmZ+xSyul
	 rDSTVeY2trT697oMv+92cyxI352rU1n6bk0KSbECfuc/7AlHklW5cKiQrqRDt1KKzg
	 bYsieFz0X+ril90PfxYHhQ/e3VS4+YLMHW8TcDB2aU7+VihwSB7HXvcxU9l1L2WDkk
	 mO9hPcQuc43TgjhFE67L2w8U9mRD6Va6YwzNOEfGWgGKoQ6fiaYzjZ2EG12NM0Ibi+
	 5GqNUmSUtU1pw==
Date: Tue, 27 Oct 2026 16:30:02 +0000
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com, andre.guedes@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <eZWITZTcOwr2NglsQ81lTVz7KdBTIb7L8jpSRGGX3Ts-wlGb6eIUGco_iev6GD5OFkaOmIMwKlADpfVh9KE-FdHCRgfFDSs6ZzYCaJbgp8I=@1g4.org>
In-Reply-To: <auBfnRqpsuF4B+J9@boxer>
References: <20261025065154.2037149-1-p@1g4.org> <at+t/jHczGvyXKRN@boxer> <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org> <auBfnRqpsuF4B+J9@boxer>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2f363783c4d49599380b8b788c0128422907cb62
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Tuesday, October 27th, 2026 at 3:24 AM, Maciej Fijalkowski <maciej.fijal=
kowski@intel.com> wrote:

> On Mon, Oct 26, 2026 at 10:12:51PM +0000, Paul Moses wrote:
> >
> >
> >
> >
> > On Monday, October 26th, 2026 at 2:46 PM, Maciej Fijalkowski <maciej.fi=
jalkowski@intel.com> wrote:
> >
> > > On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> > > > TSIP remains set on continuation descriptors, but the inline timest=
amp
> > > > header exists only in the first buffer. Stripping it from every
> > > > descriptor truncates split frames and can underflow short buffers.
> > > >
> > > > skb ownership cannot identify frame boundaries when XDP consumes th=
e
> > > > first buffer or AF_XDP uses zero-copy.
> > > >
> > > > Track rx_in_frame per ring and update it as descriptors are consume=
d.
> > > > Strip timestamps only from first buffers, reject unsupported split
> > > > frames before XDP and drain continuations. Account discarded
> > > > descriptors against NAPI work without counting successful RX.
> > > >
> > > > Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> > > > Fixes: 26575105d6ed ("igc: Add initial XDP support")
> > > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moses <p@1g4.org>
> > > > ---
> > > > - This supersedes "igc: only strip RX timestamp header from first b=
uffer"
> > > >   following feedback from Simon Horman, Maciej Fijalkowski and Sash=
iko.
> > > >
> > > > Changes:
> > > > - track frame boundaries independently of skb ownership
> > > > - guard timestamp stripping and drain unsupported split frames
> > > > - cover the AF_XDP zero-copy RX path
> > > > ---
> > > >  drivers/net/ethernet/intel/igc/igc.h      |  1 +
> > > >  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++---=
----
> > > >  2 files changed, 64 insertions(+), 24 deletions(-)
> > >
> > > Hi Paul,
> > >
> > > I think this implementation went off track. We should make sure we *n=
ever*
> > > enter data path for XDP/AF_XDP multi-buffer scenario until we add rea=
l
> > > support to it within this driver. Now you sorta handle fragmented pac=
kets
> > > in data path.
> > >
> > > I tried to argue with bot reports that it hallucinated for
> > > igc_clean_rx_irq() content (which was concise and to the point) and a=
greed
> > > the AF_XDP should *not* be exposed to any fragmented traffic, which s=
hould
> > > be addressed on HW RX ring configuration side, not within data path.
> > >
> > > Also this should have been a v3 with a link to previous revisions so =
we
> > > could keep track what has been changing between versions.
> > >
> > > Here's something that would address ZC fragmentation issue. Could you=
 give
> > > it a spin on your side as I don't currently have igc in my setup hand=
y.
>=20
> [...]
>=20
> >
> > Looks good to me, passes basic testing, and I would rather you/intel do=
 this patch
> >
> > For posterity, I did email Tony with handoff notes stating I'd rather n=
ot do the
> > xdp/xsk/af_xdp/fpe side of things, but hadn't heard back so I kept goin=
g.
>=20
> I think this was within the thread where AI hallucinated and I stepped in=
.

No worries, it turned out more interesting than expected.=20

> If you are not fed up yet you can take your v2 and the patch I added here
> and send this as a change set. From my POV it would be better as you have
> the HW to test this against and ironically my igc card went into
> /dev/null's lab.
>=20
> >
>=20
Not fed up but sleep deprived, yes, I'll do that.


