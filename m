Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747F47D922
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260359; cv=none; b=OR8xy7lvr728Z8LOwLY4NFn6R2qovn6GIMN9Rgf4ByrsHq37Z2jg7hDsgZJTqDvqUWu0aI89ZO9n2e1ye7QhcAY3xgeee/WK/WK/hZS/WOxY9t1LUhIwkZoccjqDpOW6A6cAjfxWLXASHUJk3PzBsJv9j2lZ5d8vc9z2r+AiR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260359; c=relaxed/simple;
	bh=4ohEtG1x8ROhMjmJ7uqpVlg5CxBlAe6XE2LbC/svLig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4EWxnpX7W2RZ8dH8lrcMhD9TWrkco4HlJZLdgiO/tWnTDJPXZZOTZNUwRf627lTnwOY+G3DBSFQNyzUmw8T/VMOW+5IXt8EJHPqeAZgdv4gSuovXMLZfvte/3+819CmXv/hJOEa5ZChMMWvHEs1UFVbrrHRv2JRrRHDUtHJokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+u/KgCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+u/KgCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088511F00A3D;
	Tue,  1 Sep 2026 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260358;
	bh=2UZTKB9uKS29lFdZzrQRjCtVRPxUM4bHM+Qr8spw83w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+u/KgCewWgTM3v9Nbj7Fq9BqQ8YCfAFNUveNuuddZ4pyfUxikGeovv7Bj/PCba8l
	 J02GnumImrgX4aRIn4EmGuIpnOBWtsjm/dQMcLv4+Ohjy7OQBVcBhRaa7K22wA/ouI
	 LukFkUQsqdoXy3LNBoE1j/xtskg4en3ziR7wn3u1r6u44ejfVVT/e0t+NDAFjG+iWs
	 wlW0pdaQKaU8iPtSzzZkQv5sdfxmUedWje0KJQzFW5DxVYFZ4k0MKYTCbMm5hHDt/Q
	 PIGZ8+CMucR8O9dS1ODgtfX2g7E8n0Ggg3ROdbR+Ywyc7kc9oNx2Lskl7Vs6td3wls
	 pF69ffpk5S6RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/7] net, bpf: Add bpf hooks for ethtool
 control path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831110934.241898-4-a.s.protopopov@gmail.com>
References: <20260831110934.241898-1-a.s.protopopov@gmail.com>
 <20260831110934.241898-4-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:59:17 +0000
Message-Id: <20260901105918.088511F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] BPF LSM hooks for ethtool dump operations convert `-EOPNOTSUPP` =
to `-EPERM` and break loop iterations, causing policy denials to abort syst=
em-wide netlink dumps instead of gracefully skipping the denied device.
--

commit 7af2ce335fd164e8a86d3365a2ee187cdfafce81
Author: Anton Protopopov <a.s.protopopov@gmail.com>

net, bpf: Add bpf hooks for ethtool control path

This commit adds BPF LSM hooks to ethtool control paths (ioctl, netlink doi=
t,
and dump) to enable runtime mitigation of bugs.

> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
[ ... ]
> +static inline int ethnl_bpf_lsm_dump(const struct net_device *dev,
> +				     u32 phy_index,
> +				     u32 cmd)
> +{
> +	int ret;
> +
> +	ret =3D bpf_lsm_hook(ethtool_netlink_dump, dev, cmd, phy_index);
> +
> +	/*
> +	 * For a BPF policy this doesn't make any sense to return -EOPNOTSUPP.
> +	 * But if it does, it will not be treated as an error by ethtool code,
> +	 * so patch it here.
> +	 */
> +	if (ret =3D=3D -EOPNOTSUPP)
> +		ret =3D -EPERM;

[Severity: Medium]
Does this conversion of -EOPNOTSUPP to -EPERM unintentionally abort
system-wide dumps?

In netlink dump iterations, returning an error like -EPERM typically breaks
the iteration loop. If a BPF policy denies access to a single interface,
returning -EPERM here causes the entire global dump to fail instead of
gracefully skipping the denied device.

Could this be modified to allow the dump to skip the restricted device and
continue iterating over the remaining interfaces?

> +
> +	return ret;
> +}
> +

> --- a/net/ethtool/tunnels.c
> +++ b/net/ethtool/tunnels.c
[ ... ]
> @@ -248,6 +255,13 @@ int ethnl_tunnel_info_dumpit(struct sk_buff *skb, st=
ruct netlink_callback *cb)
> =20
>  	rtnl_lock();
>  	for_each_netdev_dump(net, dev, ctx->ifindex) {
> +		netdev_lock_ops(dev);
> +		ret =3D ethnl_bpf_lsm_dump(dev, ctx->req_info.phy_index,
> +					 ETHTOOL_MSG_TUNNEL_INFO_GET);
> +		netdev_unlock_ops(dev);
> +		if (ret)
> +			break;

[Severity: Medium]
Will this break statement abort the entire tunnel info dump if the LSM reje=
cts
a specific device?

Because the global iteration uses for_each_netdev_dump(), breaking here
prevents users or administration tools from querying information about the
rest of the interfaces on the system.

> +
>  		ehdr =3D ethnl_dump_put(skb, cb,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831110934.2418=
98-1-a.s.protopopov@gmail.com?part=3D3
