Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACB30596F;
	Sat,  5 Sep 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573037; cv=none; b=BCc6D/Xthgn/SaL8o/mke9FtVpzFVle2sFIIvj1ULQs75a28dKazyUZ7UuG9cqu2aEjyLLc7mflKRta1t+IPCt5t7kjVXKc4SXYr2DBCF19ej75ScVNpZc8bDCpxbREa6rpbjEC6V+mvyT8F6o1Wn0+AP3KS2Xha3f548Cgv5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573037; c=relaxed/simple;
	bh=i1JMNzZhT4/rERa3nATeMebz9JfIJY9AA7S1OhTs+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocw3jfcx+V+l+P2Q7dPzHG26nLSx5EicqvJ74mkdvrh7l0lcIpzjKdPsTBAlv6unk4QXYYaZ/Sr1wZHknTc6HHwUqx1m+xaKtvBbJrbGmNCCHtQwyrmxMusagN2kuISskZAT57+hFD22bl4s02XZLLg8ad65qRk9xOJdOsz31TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzO4Bn13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzO4Bn13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5A21F00A3D;
	Sat,  5 Sep 2026 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573035;
	bh=MUtDzm9LK90ZSrkO3INr0pqaHDrzEJBvQMG5NTfTmro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LzO4Bn13Wndsw0K3Zaf/EPKFVDEfhFWRYzTA3NYM2AyUIUGsMRHPKrkI5Fd34BGAr
	 U7iB8NqG63Y1XgNErrFau13LALQkgbwziBIE/AaxncHEoikKx4NVkxNA7HkJ1KbwkB
	 e6rNVYmTXlpnLb1eYhnONrZRf69T+T+a1D/fsizri1qPewnBvm0zq0k1hi1mG1DTxI
	 q/tErfauG5uUnJF36k/qj06uRZhZ+ZJZYK4noAh7kw31TqiVKKqp9MRNgfzmTjcV0C
	 Jxn6m8agh5vld6o+HYHxKhj2U/jqZJkLRZmSp4FyCG9a4kugtUCuFCoB8k8+Rfldt2
	 4lVzIYSwO0ujw==
Date: Fri, 4 Sep 2026 18:50:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, kohei.enju@gmail.com, enjuk@amazon.com,
 przemyslaw.kitszel@intel.com, blair.steven@alliedtelesis.co.nz,
 carl.smith@alliedtelesis.co.nz, horms@kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, aleksandr.loktionov@intel.com,
 sx.rinitha@intel.com
Subject: Re: [PATCH net-next 2/4] i40e: add support for
 bpf_xdp_metadata_rx_hash()
Message-ID: <20260904185034.6e416921@kernel.org>
In-Reply-To: <178851359588.4131868.14209764775589320419@kernel.org>
References: <20260901211752.1922993-3-anthony.l.nguyen@intel.com>
	<178851359588.4131868.14209764775589320419@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 09:19:55 +0000 netdev-bot+sashiko@kernel.org wrote:
> > @@ -13784,6 +13813,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
> >  	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
> >  
> >  	netdev->netdev_ops = &i40e_netdev_ops;
> > +	netdev->xdp_metadata_ops = &i40e_xdp_metadata_ops;  
> 
> [Severity: Medium]
> Should this assignment live inside the I40E_VSI_MAIN branch, next to where
> the rest of the XDP capability state is set?
> 
> Earlier in i40e_config_netdev() the XDP capabilities are set only for the
> main VSI:
> 
> 	if (vsi->type == I40E_VSI_MAIN) {
> 		...
> 		netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
> 				       NETDEV_XDP_ACT_REDIRECT |
> 				       NETDEV_XDP_ACT_XSK_ZEROCOPY |
> 				       NETDEV_XDP_ACT_RX_SG;
> 		netdev->xdp_zc_max_segs = I40E_MAX_BUFFER_TXD;
> 	} else {
> 		/* Relate the VSI_VMDQ name to the VSI_MAIN name ... */
> 
> but i40e_config_netdev() also runs for VMDQ2 netdevs, via i40e_vsi_setup():
> 
> 	switch (vsi->type) {
> 	/* setup the netdev if needed */
> 	case I40E_VSI_MAIN:
> 	case I40E_VSI_VMDQ2:
> 		ret = i40e_config_netdev(vsi);
> 
> Those macvlan-offload "<pf>v%d" netdevs get xdp_features == 0, and
> i40e_xdp() rejects every ndo_bpf command on them:
> 
> 	if (vsi->type != I40E_VSI_MAIN)
> 		return -EINVAL;
> 
> So no native XDP program can be attached there, and xmo_rx_hash can never
> be reached on such a netdev.
> 
> Does this make the netlink capability report inconsistent?  netdev_nl_dev_fill()
> derives the xdp-rx-metadata-features bits purely from the presence of the
> callback, with no cross-check against dev->xdp_features:
> 
> net/core/netdev-genl.c:netdev_nl_dev_fill() {
> 	...
> #define XDP_METADATA_KFUNC(_, flag, __, xmo)			\
> 	if (netdev->xdp_metadata_ops && netdev->xdp_metadata_ops->xmo)	\
> 		xdp_rx_meta |= flag;
> 	...
> }
> 
> which means a VMDQ2 netdev advertises NETDEV_XDP_RX_METADATA_HASH ("Device is
> capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash()") while
> rejecting XDP entirely.
> 
> The follow-up patch adding bpf_xdp_metadata_rx_vlan_tag() extends the same
> unconditional assignment, so NETDEV_XDP_RX_METADATA_VLAN_TAG ends up reported
> on those netdevs too; the assignment is still unconditional at the end of the
> series.

Unclear to me whether it's a responsibility of the driver of the
netlink side should skip reporting if xdp_features are empty.
Let's punt on this..
