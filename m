Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807722D9EDB;
	Thu, 26 Feb 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110671; cv=none; b=Pos3oL2fN2Q/AjhwX4KHt7lztu3O8lJtNgytIF21GTmlmnOBlPI+ExgL05XxhcDM/Qnfd44ZJPJZD/m23t/GFr8fFs/cK31eMp919cjUsgx9YnuBOZB6WI3F955Rz0+WXg+/yKhxeziPJFcOXWEEU11bsXugvsWzjcSgFkwAamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110671; c=relaxed/simple;
	bh=irALN3T00J/ivDQLCP39g36pjWOy4DCRCyKbVN7mMrg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EMrZJv8bd7A6twnCCRbO3qKiHejov8f5xzLpMba/4fQ7o5S2cYx4mI+u2vK9PM33d1NZ6QJoeJKQE/G3r0Oy6gmr3glsKGIxOh7pPPrf1Xz9c4Ic1njuFNHe6qKJ8SqgYopLBnVIxwXti46KVFbWPGW+k4LCPZtZpkQdTbv9g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/+ySRV1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/+ySRV1"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772110667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgOOpgkX5YNsXP5gZs5nXmJh9pEodVW2WxIYRj4mQco=;
	b=g/+ySRV1eAXyikJbUGR3VHGIeTxIkRP1iHT+bzH+IOxWL1hOEM/HkUzKfba7j03cAKrbrh
	xlNCyva3xY50y7hGUpQ0VQhnNmNMOe8EpUq+VtuU3BFfK8Zg0TG3/5HRInEvGL4k6IQwJS
	OaKMPhtfNezz5++P5hn7+V4iAGFVJBU=
Date: Thu, 26 Feb 2026 12:57:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <77167c3125d7db5daa958c30e24e87dae308d7b6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v1 1/2] net/bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri
 Olsa" <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jussi Maki" <joamaki@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260226095859.hLxDgGdn@linutronix.de>
References: <20260224112545.37888-1-jiayuan.chen@linux.dev>
 <20260224112545.37888-2-jiayuan.chen@linux.dev>
 <20260226095859.hLxDgGdn@linutronix.de>
X-Migadu-Flow: FLOW_OUT

2026/2/26 17:58, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de mailt=
o:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%20%3Cbig=
easy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-24 19:25:41 [+0800], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> --- a/net/core/filter.c
> >  +++ b/net/core/filter.c
> >  @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> >  struct net_device *master, *slave;
> >=20=20
>=20>  master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> >  + if (unlikely(!master || !netif_running(master)))
> >  + return XDP_TX;
> >  +
> >=20
>=20I'm not sure this check belongs here as this is not bond specific, is
> it? Also nothing stops the admin to put the device right after the
> netif_running() check so it fails later but the race window is not as
> wide as it is now.
>=20
>=20The per-CPU memory could be allocated while the bond device is create=
d.
> I don't think delaying it until "device up" brings any advantages.
> One creates the device with the intention to use it so the "up" is
> inevitable.
> The bond_xmit_get_slave() callback has the same logic. Couldn't this
> scenario also occur to the ->ndo_get_xmit_slave() user?
>=20
>=20>=20
>=20> slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
> >  if (slave && slave !=3D xdp->rxq->dev) {
> >  /* The target device is different from the receiving device, so
> >=20
>=20Sebastian
>

I agree with your points, especially allocating
rr_tx_counter unconditionally at device creation time in bond_setup().

This eliminates the NULL possibility from the root, fixes both the
ndo_xdp_get_xmit_slave and ndo_get_xmit_slave paths, and keeps the
change within the bonding subsystem.

I'll wait a bit to collect more feedback before sending a v2.
