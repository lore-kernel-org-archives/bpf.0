Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665211;
	b=Y67CfTatakScKqooYASJNd2KUZRv+WZdanq8ZiMaaX8sfBnRuSbNEadq89VoxzzA/seK
	 dB4E7hwHtS+QeMWS2DfQO1km4zgwu+/rGkD4WzdIEaSYowTN5as8dlLWbMgrBOuX5hLYf
	 +B8xsEO/U9TeJZUCBnStIxpeJHudBW20hIHyoMX2kTCpKauvI1nnQt1jdBikZi9KjBhmQ
	 pMxe5HlZhImk8UtVBMgGGd92T3qkLGZgaY5/xDDXiH8rE+9uA7EE9/QqVHkbCX+Jgs/mD
	 7lXOpJY1kRXhUVX5UW6aAq0Uqjgf13AjzORXOTK3nbU7kkXpAMNCLYinYojcXQPgQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bPfldF7f8VoE2AMfTcLK7ShOnTdtm5SgCLapcl4o4Rw=;
	b=okksjJ0PiMorW8o4VRlXpSrqVnpkz+KX21SsXMZoOiXSBc1zHlw/YRpjkI5pLX9Ss8bS
	 tVscdH40gNDiMu2qoCJItw3V2k5k0LvMSbIM+sp18pGXh1lnZSb0ZKAnbnqzwfTruB8fd
	 yJ/YkntIrUslPX4cZyOps3qSmNu9caYgxXwbOOpvk6MwhCAROe4QGsGI0bN1cMnJRf7yv
	 IXRBZ0VbXIgdIjuB76f2WSpY3xx2B3i333CXrejmes3//sUtLKOQqelR8dtR4f1HafCZG
	 Ruo41f4ZDBHVRUMcKQrLDCJMHYmzLwji97faishVsfbfOexjHuz4mgLqCbWLqUMyNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lq5auTFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DA606A332
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lq5auTFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789051F000C5;
	Sat, 14 Nov 2026 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665211;
	bh=bPfldF7f8VoE2AMfTcLK7ShOnTdtm5SgCLapcl4o4Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lq5auTFUNLMdmfwhoopg/Yq+72kmYO+bYWjqLGmYanx1sCFVLnClTRfHWeBokdacw
	 Rddd1b1May1eghunzSE75UZCh1mVk7OZzZpiQnJVuRAaMb9ktAMB0ITRQqgAnsUZ6J
	 XN0u4RXpgtWevrgdHWpBBZkzFxP6/9KIljElY15/C3+MaPEsSpbUVBBlT4a+gGrRYp
	 eFkuwQuPfyCla/QikEcF05UTG/KV7ZQEgriKagEf2g31kDXpRKhUgg/+x0Gvpa+04z
	 qvsATDJDztfILrbsn0+ENPSn5iy6WQQvM10SXvxAkZVAWPZTZPK3b3WMvUoiBdJchc
	 Sguky+huc4zzw==
Message-ID: <sashiko-outbox-214604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/6] bonding: finish XDP setup before
 publishing the slave
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113-bond_enslave_restruct-v1-2-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
 <20261113-bond_enslave_restruct-v1-2-364c549e78db@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:06:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bonding: missing Fixes trailers for bond_enslave() XDP error
  leaks
--

commit 48b54e99e17c93fa370e6459ec403b3e7a7d7c19
Author: Hangbin Liu <hangbin.liu@linux.dev>

> bonding: finish XDP setup before publishing the slave
>
> bond_enslave() currently runs the fallible XDP setup
> (dev_xdp_propagate()) after the slave has already been published:
> slave_cnt is incremented, ns maddrs are added and the active slave
> may have been selected. If XDP setup then fails, the error path
> jumps to err_sysfs_del and leaks:
>
>   - the promiscuity/allmulti increments and synced addresses applied
>     to the slave earlier in the function, which are only undone on
>     an immediate allmulti failure,
>   - the ns maddrs added just before the failure, which no enslave
>     error path ever removes.
>
> Move dev_xdp_propagate() to the last fallible step, right after the
> promiscuity/allmulti/address-sync block and before
> WRITE_ONCE(bond->slave_cnt), so that no handled fallible call
> follows the publication of the slave and a failure can no longer
> leak slave_cnt or ns maddrs.
>
> bond_xdp_set_features() is moved along with this reordering so XDP
> features are updated before the slave is published. Route the XDP
> failure through a new err_set_xdp label that undoes the promiscuity,
> allmulti and address-sync state, mirroring what __bond_release_one()
> does.
>
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
Since this fixes the promiscuity/allmulti/address-sync and IPv6 NS
target multicast address leaks on the XDP setup failure path in
bond_enslave(), should the commit message include Fixes tags?

  Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver=
")
  Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave d=
evice")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-bond_ensla=
ve_restruct-v1-0-364c549e78db@kylinos.cn?part=3D2
