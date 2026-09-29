Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C73B6BEB
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721422; cv=none; b=lq6W5zdRieMvEFRL/NkOUHhPylcaZANZ8zGf+mZJ0OetHcLbzj6WQQ5C0OFaAhq6CQaHGQemgfHpjGr17WqkWXwKl7QS6P0aprr//SonCgUjIgivrun2pKpmAHLbTa/14z/ZWTRECOylZjBCGjvXY1N46sLplkDEm0ztonyIS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721422; c=relaxed/simple;
	bh=QTHKgGQJsk9NY+LYyjrRsKOIzUe7N+FRtcNOTfYFU6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UxPoSlY0lxU+VTyqkBRsrpurUnitoU++0BoGMLj3GwjGc30YDlqIVm/54LV8U+z4EcTxM252ECI1sYv+eZJ2wIk14FNL/tXm0K4hXJKTm172POSFSzpdH7HLDorK0xzIgCLBKgk4hIm6Beao+o3zoBOUmmX6pwZZJXLnVIxeE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4LuW5gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4LuW5gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9A91F000FF;
	Tue, 29 Sep 2026 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721420;
	bh=+AsQQlQWKYmfqZbZN1L1cxSL0ltVaI62AxdByH63NPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4LuW5ghG7YDQdQOz3jOWMWCLvuBX5/a9qEMK1JX4R1eyX2qzOImJS1F+o/VcJMC7
	 P+MUSJADwxe0GN7WCHa1E6WN+xO4tFH3Z+qj+eoznc/fhBHFqiH+IVt0z3I8KuIKcL
	 DH/72pCYU4udwLrA5dif+5YhK7wI1+Csi2bxrQ+IMNY11i1/WLiEDf3AJd5gO7lE7C
	 xacn76TU4WaKr6Tb/2uqjHC0zpOxvQ5ESYcCY2+uDPS0HbCA7HhlVhQ11+ob90QImB
	 nKKM7iXGJa9imZLfe0UNNLrH9BDW55uMtolug3PwJzOIFQzdXXtihxWjQouiBnjh+d
	 8rfJ80BNBd0gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/5] net: record XDP programs propagated to
 lower devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928223648.2739371-2-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-2-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:36:59 +0000
Message-Id: <20260929223700.6D9A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] netvsc: XDP programs permanently locked on VF during device removal
--

commit f794b6189b6f7c17a488a5d7e9c45d50b3617887
Author: Jakub Kicinski <kuba@kernel.org>

net: record XDP programs propagated to lower devices

This commit changes the XDP setup to record propagated programs in the
lower device's xdp_state[] array. It introduces the xdp_from_upper flag
to differentiate these from user-installed programs and prevent userspace
from modifying them directly.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc..096d1dedebfd4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -10532,6 +10570,11 @@ static int dev_xdp_attach(struct net_device *dev=
, struct netlink_ext_ack *extack
>  		NL_SET_ERR_MSG(extack, "XDP_FLAGS_REPLACE is not specified");
>  		return -EINVAL;
>  	}
> +	/* the program belongs to an upper device */
> +	if (dev->xdp_from_upper) {
> +		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an u=
pper device");
> +		return -EBUSY;
> +	}

[Severity: High]
Does this change permanently lock the XDP program on a VF during netvsc
device removal?

Looking at netvsc_remove() in drivers/net/hyperv/netvsc_drv.c, it clears its
internal BPF program and unregisters the VF, but skips propagating the XDP
removal to the VF:

drivers/net/hyperv/netvsc_drv.c:netvsc_remove() {
	...
	netvsc_xdp_set(net, NULL, NULL, nvdev);

	// ...
	vf_netdev =3D rtnl_dereference(ndev_ctx->vf_netdev);
	if (vf_netdev)
		netvsc_unregister_vf(vf_netdev);
	...
}

The linkage is destroyed before unregister_netdevice() triggers
dev_xdp_uninstall(). Because the VF was orphaned without clearing
xdp_from_upper, userspace seems permanently prevented from recovering the
VF's XDP slot here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928223648.2739=
371-1-kuba@kernel.org?part=3D1
