Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84970179A3
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627403; cv=none; b=W+0fVQmI8ni46nsiWRsjML8Cirb3DU2yXW2oh0B4LVGAyN0FaFCbt/im4fFpIFubF/QRCMy3K0tWoRwwM6k5Z2ZTApLVgIhefgb/18lSqQILFHmPftfOTD0YTUKZq/L9g5vPKf3O074bOOwsR20SKGBedQLunNg9NiZelHybD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627403; c=relaxed/simple;
	bh=5m0PKeeySIkaelIXA6fWrNGoNihdofrT7vkUqI2mHh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lqhl74N9WDvjCeTmwdOI8pvxIRKaHiqldS9rQ05Grp6Sa4luPFmVBxo1kop/X22k/jJKl+k8lJNefc4xGmfhz96dQ1Sj9tV3ZxxVQ9hrrk2hixqxJZyTjwPPNY5iY//oZwS1MFFENq+GjYgsi4v3UDqCpCp3oOZtWU8FgTy+wUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn6Hzb/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn6Hzb/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA131F00AC4;
	Sat,  1 Aug 2026 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627402;
	bh=7kQeCFyAZMXWYXGLsmMtF3gtC7GJ21/oLxHafQ4CY5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yn6Hzb/VhbEKg/aQEaJ7e3SSsJ5MyLYvZETVbKVB9X2y9iNxyhWC4khPQs1EbtsKl
	 S2KpQL2DfQL931Y7TQgrLaGfqlHl11DrPgKzGYH6/bMLCuTdg5RbhLPj+dTd75eGlJ
	 mMMGHQbUlUeKIRD2aZKHqdF9vg+g6BAu1SF/q7GfRWW7K3Tm9Thu7f3HTTzdZRUmTv
	 mFsldLWcq9dDziqkpU/+swBkmHuLFIG8ATn/rgZ2eH6ejKR8zG0lIe/ZqRSiM2hVD+
	 JYd0cMWI7WTJy3nD0b27GJuWjrK4znPFWtikcwXBjlwAUFbe0BDV75Kc4lZ0KSqt0u
	 sh7isIOXKMm1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: enable devmem TCP in the
 test config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
References: <20260731-selftests-devmem-config-v1-1-098014348d9d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 23:36:41 +0000
Message-Id: <20260801233642.1CA131F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding `CONFIG_NET_DEVMEM=3Dy` to the config fragment is ineffectiv=
e because `NET_DEVMEM` is a hidden symbol with no prompt.
--

--- Patch [1]: [PATCH net-next] selftests: drv-net: enable devmem TCP in th=
e test config ---
commit 07d433d344dd104ff54b719b50d995dfb8a6b2be
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: enable devmem TCP in the test config

This commit updates the selftests network hardware config fragment to enabl=
e=20
CONFIG_SYNC_FILE to satisfy dependencies for DMA_SHARED_BUFFER, and explici=
tly=20
adds CONFIG_NET_DEVMEM.

> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testin=
g/selftests/drivers/net/hw/config
> index ed8642b68094f..d89a9ba176558 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -15,11 +15,13 @@ CONFIG_IPV6_SIT=3Dy
>  CONFIG_IPV6_TUNNEL=3Dy
>  CONFIG_NET_CLS_ACT=3Dy
>  CONFIG_NET_CLS_BPF=3Dy
> +CONFIG_NET_DEVMEM=3Dy

[Severity: Low]
Is this assignment effective? Since NET_DEVMEM is a hidden config symbol=20
(defined with def_bool y and no prompt string in net/Kconfig), Kconfig=20
silently ignores manual assignments in config fragments.

It should be automatically enabled when its dependencies are satisfied=20
(which the addition of CONFIG_SYNC_FILE helps achieve), making this=20
explicit entry redundant.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-selftests-=
devmem-config-v1-1-098014348d9d@meta.com?part=3D1
