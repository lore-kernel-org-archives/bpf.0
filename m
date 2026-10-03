Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA22C15BB
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054163; cv=none; b=iaxTlEcO+PvoxFYiatEbTeTVvP6DqSjP1+LgwXMj07r1/AMwoxDfiDJv2cfChHvPbujj/cmBlV66KOa5xUCGQnG/JHeZrt64dqLO8oAuQC5WpTablmtYLVoT6FeLsFfTkh8NYSzPVAd602ITCoz5bkv9c6ZEwSdCjai5hVIJZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054163; c=relaxed/simple;
	bh=6kfhr94NsYPHTY45DFOBaH6IMGmiwqrDi2tDvgmWCus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHKP+gBGhOusbxdEiA4S9ch16Ydot0KaUxjFXHWtHIG8sqdn5QmCgymXrk7LOKCiTjhMQ0YQ6HQf0kInDPAVGkDRrHYndKe6cBUMk77hwwrdk+6++MzqhzwSz48A5sXfTrfHnYPxYer6C/l40QN1Bewx7cc7Pu04cNKTs7+KeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxQchIkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxQchIkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D191F0089B;
	Sat,  3 Oct 2026 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791054162;
	bh=yXrEYYqnuuSzg6gJeToU6j1y6l4C4U56qQM9TevOogE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxQchIkKnuOgXKqBjFnqkfTXVkyjSPoxnhpij+2kmXakC36asA8SkmSk7/Sc2oGUE
	 33sNzdr1oZoWrmGfykH07wRcn13frUuY728l8YAkJTE00C4QcQf3C1Aprt+KBnfQZy
	 qhB87YqJ+Pog8uzdKdwSWzWN0RMTc/GMQsletpfiL51KrslF+TolsQpC1VtFdP481G
	 ENf/aOd3fW3mqwl1NlPIGd5w/2nrpIgYYu5nRIZab0g6Qxz6Af4R5iUplpTUow4avj
	 r16el2gh6ztlg2AO1edlGrpi1NUiyPOzq3fBKoqVzKmvwqj5mcL+hlbpp2zmOdTu6W
	 hNxHKj2l1B2Dw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC net-next 13/15] eth: fbnic: Support AF_XDP zero-copy
 receive
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002190018.696925-14-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-14-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:02:40 +0000
Message-Id: <20261003190241.90D191F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: deadlock on 32-bit during u64_stats_sync update with preempti=
on enabled
--

commit 1bc54e591deb70184971cd19a4b1a9d18715cb4e
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

eth: fbnic: Support AF_XDP zero-copy receive

This commit adds support for AF_XDP zero-copy receive in the fbnic driver.
It integrates the XSK buffer pool as a memory provider for page_pool and
refactors the receive ring refill loops to balance header and payload buffe=
rs.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
[ ... ]
> -static void fbnic_fill_bdq(struct fbnic_ring *bdq)
> +static bool fbnic_fill_bdq_one(struct fbnic_ring *bdq, unsigned int *tai=
l)
>  {
> -	unsigned int count =3D fbnic_desc_unused(bdq);
> -	unsigned int i =3D bdq->tail;
> +	netmem_ref netmem;
> =20
> -	if (!count)
> -		return;
> +	netmem =3D page_pool_dev_alloc_netmems(bdq->page_pool);
> +	if (!netmem) {
> +		u64_stats_update_begin(&bdq->stats.syncp);

[Severity: High]
Does this code risk a deadlock on 32-bit systems when called from process
context with preemption enabled?

If memory allocation fails here during interface bring-up (e.g., via
ndo_open -> fbnic_up() -> fbnic_fill() -> fbnic_nv_fill() -> fbnic_fill_bdq=
s()
-> fbnic_fill_bdq_one()), the sequence counter is updated without disabling
preemption.

If the thread is preempted while the sequence counter is odd, and another
thread attempts to read network statistics (like ndo_get_stats64 or
get_queue_stats_rx), the reader will spin forever preventing the writer
from finishing, leading to a hard deadlock.

> +		bdq->stats.bdq.alloc_failed++;
> +		u64_stats_update_end(&bdq->stats.syncp);
> +		return false;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002190018.6969=
25-1-bjorn@kernel.org?part=3D13
