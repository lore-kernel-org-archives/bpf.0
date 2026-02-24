Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BB33D4F3
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968328; cv=none; b=vD/o3WhkuYPDhQatdXgrMDk9vuTAnice91+yE7buPgSvTielq/lQpdAXH/MKzWpXkmEjfMNjF3vbwAnZDg+qqGTZbkq6+rschA9EDj4cBIlRMEvpLUefFer4D3wju+ak2qRLrIpljmAeulG6j0K8ig28yV7QTy+denkwHXyt10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968328; c=relaxed/simple;
	bh=p9N0tg9ro3UyBcP2Fzp3R/vRzcui4PdL161SdN6uY2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3WGNM+16SuurOcWnYEW+02vLWQLtC4AxhQbNxdxproDlbUu+AXxZnLVfQJy7UxP3iE7lFLzzyFjjTrdg/c1Qfxp1BdX3iVEOJmc8MynpqZXiKsBbxadqiPA2PbV4Naz/YPywBsy1IBdzhIm4RxB1mlZPVhnqZwAzwUhmsyiYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KcW5ewYG; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KcW5ewYG"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260224212514e6a90b078100020795
        for <bpf@vger.kernel.org>;
        Tue, 24 Feb 2026 22:25:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vbehI5k0rB54bjh1f0a2umagLZ4OYrZF4eNdQQugxLw=;
 b=KcW5ewYGX3l5vf4Wblfb+Vgb1Jpva+THV2gf/O4U5sXYcTiaDI7LLIzlAwZMx9XA8avU3B
 MQLeoJMHcWwQCTYV+Lbgn3qf3lawLd9EMojyc47icVDouNXsJJbkRi9MuydVi1Y2oRAEgY9U
 W96vDkI/s4GJtRjD1v8EERcDzrnoFuR4N2bBcqEagUxqt4QDYPEVaFLMXWkTTmUInyqXA/67
 dSjuG5ywwV4GpDznI04Ak2CUpfcKMKF76RVh6CM5zU0SWApiNooKLivJ5BkfGYoQBNqrOYq9
 GSfAnJqKWOzldv8IzuXYnOj/5a/eqfGWLWyn4qc+ed3rWdHWodlyNeww==;
Message-ID: <f269adc1e366685a15622fb51740eca7168c9339.camel@siemens.com>
Subject: Re: [PATCH] igc: fix page fault in XDP TX timestamps handling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Richard Cochran	 <richardcochran@gmail.com>, Song Yoong Siang
 <yoong.siang.song@intel.com>,  Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 24 Feb 2026 22:25:10 +0100
In-Reply-To: <20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
References: 
	<20260224-igc-fix-xdp-tx-tstamp-pagefault-v1-1-7c729ef61ee5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-02-24 at 13:38 +0100, Zdenek Bouska wrote:
> If an XDP application that requested TX timestamping is shutting down
> while the link of the interface in use is still up the following kernel
> splat is reported:
>=20
> [  883.803618] [   T1554] BUG: unable to handle page fault for address: f=
fffcfb6200fd008
> ...
> [  883.803650] [   T1554] Call Trace:
> [  883.803652] [   T1554]  <TASK>
> [  883.803654] [   T1554]  igc_ptp_tx_tstamp_event+0xdf/0x160 [igc]
> [  883.803660] [   T1554]  igc_tsync_interrupt+0x2d5/0x300 [igc]
> ...
>=20
> During shutdown of the TX ring the xsk_meta pointers are left behind, so
> that the IRQ handler is trying to touch them.
>=20
> This issue is now being fixed by cleaning up the stale xsk meta data on
> TX shutdown. TX timestamps on other queues remain unaffected.
>=20
> Fixes: 15fd021bc427 ("igc: Add Tx hardware timestamp request for AF_XDP z=
ero-copy packet")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

