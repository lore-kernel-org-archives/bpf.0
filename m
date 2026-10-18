Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BC3AFB0C;
	Sun, 18 Oct 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338692; cv=none; b=SJTCpwd0XzAwMS2sYTk5VuP2MI4rW7lc6YjT9GLVciXNeJtV0Wj37wkOIud6NUBpnmOwwGsec/PA7euThJWkR0IdJML9rmUMtqCuNZiNp+lBo1dVuObO+JcOvpa6NVA2p7lwpRJK8Ybuvg1IZN5WBOeW4nxCoNkAi/psblGxG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338692; c=relaxed/simple;
	bh=YaTa1/1PdHeY1cjXBLQYg/PF4Y+5ID+lV3t24mYibm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dllLxgcj9Qi/BgKmChsETonDuKoGT3tdEyuFujCMXKtd0ozpZR2gwrzCANZA66NBcxx2wuamb6t1Ca+UfMXxBTL+NB7Hu/akQ+kidwTjgRUHdmTg8hmkgNAxoQ8Hd4mRj3lK+LRVUFl84ryTj+jARLCIl+HMPM2tC6zJcOaiijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5lIATDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5lIATDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687CE1F000C5;
	Sun, 18 Oct 2026 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792338688;
	bh=OCyuWrGMdsrJgJ7HP4P3X9ZkHaLlXw6IVzKc+k+MNYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n5lIATDrVO1XaYWfTrfOs5WFKjDjfV6ACJBJLNV/B8wt6EN88GlNS9igrXos3//eH
	 ytrF+mpst34HxwUecxZnMvD8RjQ6dRwZtjczaU26/7Z4Ly2gIvA0G++/4z9Xi0LRF/
	 E0nMWfD7REyFgfdQfWlIgfDG9Qm+9VV+YoskbPfr4ZTOYF51lnT91aQ80d3+ueAlIu
	 ToM7QsffDrZRnFVSDsVrGglhMO35A5nE4hAZe8EmIllhGKj1BUWThYJPmC5NQkOY8L
	 S00aR1hAu/Abzmp/1r1VR7exgHzDtQlYrt4KQyLDqYulWVvezYOxaUoEjgJPpjewh7
	 E3M9RT4IhRxyw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
In-Reply-To: <atPDf2DpOfWLt9cT@boxer>
References: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
 <179220637173.434549.12610717858136223745@kernel.org>
 <atPDf2DpOfWLt9cT@boxer>
Date: Sun, 18 Oct 2026 17:51:25 +0200
Message-ID: <87wlrf2eiq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

>> [Severity: Medium]
>> On NICs that steer flows based on TX, is taking the queue out of RSS
>> enough to keep the TCP control connection off it?
>>=20
>> Flow Director ATR is on by default on i40e. i40e_atr() samples TCP TX
>> packets, including the SYN. It then programs an FD filter that steers the
>> flow's RX to the queue of the TX ring:
>>=20
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
>>     ...
>> 	flex_ptype =3D FIELD_PREP(I40E_TXD_FLTR_QW0_QINDEX_MASK,
>> 				tx_ring->queue_index);
>>     ...
>> }
>
> SO CLOSE! This one has to be addressed as atr is turned on by default and
> this could cause i40e runs being stochastic. I must admit I did not have
> i40e setup on my side, but it has full AF_XDP feature support (including
> mbuf zc) so its coverage matters.
>
> Fix would be:
>
> diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testin=
g/selftests/drivers/net/hw/xsk.py
> --- a/tools/testing/selftests/drivers/net/hw/xsk.py
> +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
> @@ -115,6 +115,16 @@ def _reserve_queue(cfg, undo):
>      return queue
>=20=20
>=20=20
> +def _disable_atr(cfg, undo):
> +    """i40e ATR steers what a TCP connection receives to the queue that =
it
> +    sends from, which can be the zero-copy one, so turn it off until und=
o."""
> +    flags =3D cmd(f"ethtool --show-priv-flags {cfg.ifname}", fail=3DFals=
e).stdout
> +    if re.search(r"^flow-director-atr\s*: on$", flags, re.MULTILINE):
> +        priv =3D f"--set-priv-flags {cfg.ifname} flow-director-atr"
> +        ethtool(f"{priv} off")
> +        undo.callback(ethtool, f"{priv} on")
> +
> +
>  def _steer_udp(cfg, undo, ifname, queue, host=3DNone):
>      """Steer the test flow to queue until undo, return False if ifname
>      cannot."""
> @@ -313,6 +323,7 @@ def main():
>          cfg.queue =3D _reserve_queue(cfg, undo)
>          if cfg.queue is None:
>              sys.exit(SKIP_CODE)
> +        _disable_atr(cfg, undo)
>=20=20
>          cfg.udp_port =3D rand_port()
>          steered =3D (_steer_udp(cfg, undo, cfg.ifname, cfg.queue) and

Sneaky ATR. Is i40e run in the HW selftests? Could this be a follow-up?


Bj=C3=B6rn
