Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075287;
	b=ilIPy4af8sxrRVfWC1xk6mvFECF41qomvQ/M2aUgRSXHHOHo1qBC8jC/mc5E2tmbN+Pm
	 MfHCMC6MpUOXwTGv4PLx3N/rLPDkxdBB76UBSC4v/nnojIfcVGbGynDwg5F/4rYJzfv66
	 sadiaadMHAnFeJh+CN3HGQEQhF+zigwz5zgnAZ5V8vQa80ujg8vUOzkRnclvP2nls/QXb
	 2aB12A0t7tgKjiXIo+v4oiu9H4pG683sDAtnH1M81NTGnqDceouRUomZCbrw0i2V1M+au
	 kgWE7FSze/yDyWUpOdzKXlptRgZZqVLL+gTFwZSZ9QT9G2zm7H4ZcBNvQOJrEA3bNsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YBgyTGpLz+UzZ96usEbkTKncVqN/Kx6pvQ0ZnvD9D1M=;
	b=2mnoScOd2Zb/UVs0VM+SoLGqsg9y/A8BNWUvvyH5+HLPgacVREjQuWtBJ7bZsLTdMdN0
	 je/wvha1ascmtS5oqG932D1s+wRvb3rWXYSC5kMzuSFNbn5l7yVDxfOWmbRAzR5PtkAW2
	 DEtOE5PpY5NGhHR6HRqNUDwsxHSyksIhKcIKGYcYSbY4wVORxlwHn07bKXnQcfxqk92k3
	 Eo8UMWMkeIoXsZYk7jUf9ceWzmo80klfCcX+/7O6ilflCflhgrVfY/rGISgp/rtY+GNj1
	 MepbMl48SatEVzD9/+y0xuVOaE65T3Ib7XXiWNezyaQNn1TC/vUR7RZyScfc2iySAWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbmCvqcZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3D606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbmCvqcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2A1F0089F;
	Sat,  7 Nov 2026 18:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075287;
	bh=YBgyTGpLz+UzZ96usEbkTKncVqN/Kx6pvQ0ZnvD9D1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lbmCvqcZl9pl7KKn4M4zyYgdnI6IvhN5yJNgOxiinLho8xESh0WATiimYGiJIOBFE
	 rld+K6UBNnrq5OwgqFiMM0AEXIJ2zi88MqYCOXeMUcy2iENNqK5/cCwq/3OmImFtg+
	 mVDEP1X+tT8loukf0QKA28RrgCCC8tKwYuHuQhpTmsA6m7kIkfVvQbU3IoqQlni3Vc
	 4Rve8EKs7kVz12Qfg9TJaktUj4QMLhwLbcxTAyZIDvd1Ug7T2ElW5GMtsZQ6Rh4Sit
	 7t5USiSNuN1NZW5/U389IIFKHArvH9UUsf9PyB71uIbSHOSo0ezoK0253FeSd4k7FU
	 I/2TOW2ltyYuQ==
Message-ID: <sashiko-outbox-203160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 8/8] bpf: Fix "unresolved symbol
 tcp_request_sock" build error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-8-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
 <20261107-sockmap-update-limit-iter-v3-8-7c0bad1ad036@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 18:14:46 +0000
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
- [Low] bpf: missing Fixes: trailer for tcp_request_sock BTF build fix
--

commit 96ec9bcc071c52f5537149bdc9a41b81773ef3e6
Author: Michal Luczaj <mhal@rbox.co>

> bpf: Fix "unresolved symbol tcp_request_sock" build error
>
> CONFIG_WERROR=3Dy CONFIG_NET=3Dy CONFIG_INET=3Dn build fails:
>
>     WARN: resolve_btfids: unresolved symbol tcp_request_sock
>     Failed to generate BTF for vmlinux
>     Try to disable CONFIG_DEBUG_INFO_BTF
>     make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>     make[1]: *** [.../Makefile:1379: vmlinux] Error 2
>     make: *** [Makefile:248: __sub-make] Error 2
>
> Handle it in the style of commit d82a532a6115 ("bpf: Fix "unresolved
> symbol" build error with resolve_btfids"): force BTF generation.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

[Severity: Low]
Commit fce557bcef11 ("bpf: Make btf_sock_ids global") exposed btf_sock_ids
to resolve_btfids under CONFIG_NET=3Dy, and commit a90765c6f603 ("tcp: move
reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c") moved the last
CONFIG_NET=3Dy user of struct tcp_request_sock into a file built only under
CONFIG_INET=3Dy.

Should this include a Fixes: tag?

  Fixes: a90765c6f603 ("tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fas=
topen.c")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-sockmap-up=
date-limit-iter-v3-0-7c0bad1ad036@rbox.co?part=3D8
