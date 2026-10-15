Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9A3DD86F;
	Thu, 15 Oct 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052236; cv=none; b=sDQZZ8P+YE8FCQ6x7F0g+eTI62G2GoJHSkML6tzWWgLMhaWjHjXwMpdyZTeDUsGaG/l+GACSi1emM4Wf8j9wk4DVNLkUckC1hHnYQ0UGLXrHUTNBdtOA5ZMFw2oiIHG67PVuXPwfOYqcT1Jo9iwftL81+eorXRwRt76zUSuveY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052236; c=relaxed/simple;
	bh=MyTZY4us75nALOpJNxTHuNxbPQgodRN1DQqSMftrzdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ChNVRawV/TrY4wNkzmLBfQV8Vd5/IpRE9+F8CVDvnrQqUk63QYnjbFtR8upMZaRL/W9dS9zUgn8q9NCeGq8flxHBeouWd5n7JuI3T6rKpYZ8IObfhYi5MD8f+3JOZ3P3oqglT19wWTVxtLuztO1mQAmqcKeqp2ExV7lPa8UzmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2ayxIXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2ayxIXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDF91F000C5;
	Thu, 15 Oct 2026 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052235;
	bh=MyTZY4us75nALOpJNxTHuNxbPQgodRN1DQqSMftrzdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k2ayxIXZAVQeUdp20fUamD4jnxyMOhG5+AQggvThDFiZrD+1P3h6GjP/olLUuA49y
	 8aQILQ7JtnJbWOtOh4Gc8ht6/Xm+GdJCeN+daip/Ba8/54xbXN4yrDW9/eybZbpUxr
	 tKF6N90xjC0JA525rZ4xYheQnZ2NeJ88oRucNtM1PjhgXzBHYBX3I0XznFUtsJjqiY
	 eFJ+8JJcfycT2aI95j+cHTpNNrfSt16uzk2jNr5F3D7PkVnvyTQK6WCIiWOlGDl68c
	 Q8sH4Tnu0ij9pNuQQv50oftE5Wy4NpvAvsX5tuibuKSgMdNcooYidmIaj+POwut7mN
	 9Z0bWE/ArzHww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 03/15] selftests: xsk: drop the
 single-interface loopback mode
In-Reply-To: <20261014184539.774708-4-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-4-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:17:12 +0200
Message-ID: <87y0bz74zb.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> xskxceiver -i ethX -i ethX, used for HW tests, bound both sockets to
> queue 0 of one interface, which the kernel only allows with a shared
> UMEM. With the endpoints about to become separate processes, they would
> have to share the UMEM mapping and the socket fd.
>
> The mode also relied on the interface being set up by hand with a
> single queue and promiscuous mode, which does not suit CI. The hardware
> test added later in this series steers its traffic with ntuple and RSS
> configuration instead.
>
> Remove the shared-UMEM TX setup, the split UMEM addressing and the
> POLL_TXQ_FULL workaround it needed, and drop the -i IFACE option of
> test_xsk.sh that used it. XDP_SHARED_UMEM (two sockets of one endpoint)
> is unaffected.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
