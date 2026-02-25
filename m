Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF8364020
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017867; cv=none; b=MnKB01cOVsIgM3KqLTDi7bhVGLDjxo/5i0vECiezLc1GXHmatVRCwXVHD6YLTamt78OhfIqkVy27FA7P15pHPSXmW2qaTr2Bo/O2w7LCtG/v60sNjUg1DSSM1IKmge0y35TjzCyfW11vdJa5VZET9woJXd7pN3PxxqsW+Zuu/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017867; c=relaxed/simple;
	bh=EbYZckyTUpRdw1Kb/+WXutbwzQab58VCt2lVfCH9L94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaeWeTBfslph7tWhDsaQUvyaMco8IK/MwyhKLCVEv2DukGJ8IUJNd3fy2A4pyemmxiDctZ9MqgqxIlNGF0Lat9xMuCcFcMKzWIsnlSvyjXHTZM0JpVTW2me7j2jtIDl8YJ4m4W7KWI/S1WWypaWtvE+b0L1etUrFMjZUQAJR93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IBktAHMd; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IBktAHMd"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260225111059e0084ffeea00020781
        for <bpf@vger.kernel.org>;
        Wed, 25 Feb 2026 12:10:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Asc7os5XgEttj+QqFfI9VdSfR3d7ytYJwpk2iQbc3GQ=;
 b=IBktAHMdRTU6V+8xrzNUCbSLyz2pcjARd1g51+nrvqYOdAqTA5KuLrcC6RTKX814EhQ6pD
 98zkHaHWDzqmtcyXuEszOgWJwZdaq/f4WH95f2I+pem0PFeOFRWBH63YazXLYrijQBBkQL/E
 I8RTxLQUTSl6qUV3LxLCci+1NJ5vjjufACcZtO9/87kbP68/W4v687xlC/PrtWk0VkEmjFkR
 CDX8RaFHnNo8P3jvEbhIej0nKleAyrQrsAykTPwfmIe7Gj/p9YMO581U0gBwwnqB9Ex3jUyw
 fkIzJIEpP9kbDMla0Xu05DrrRjJk6DGWhE9OXG2qmzU0kLCyXssSJT2g==;
Message-ID: <f4232af291e742d0d0a110bbf6934ebdf490e153.camel@siemens.com>
Subject: Re: [PATCH v2] igc: fix page fault in XDP TX timestamps handling
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
Date: Wed, 25 Feb 2026 12:10:58 +0100
In-Reply-To: <20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
References: 
	<20260225-igc-fix-xdp-tx-tstamp-pagefault-v2-1-bf797ec20f3b@siemens.com>
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

On Wed, 2026-02-25 at 10:58 +0100, Zdenek Bouska wrote:
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
> ---
> Changes in v2:
> - Moved 'adapter' variable declaration into the if block (Vinicius)
> - Link to v1: https://lore.kernel.org/r/20260224-igc-fix-xdp-tx-tstamp-pa=
gefault-v1-1-7c729ef61ee5@siemens.com
> ---

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
