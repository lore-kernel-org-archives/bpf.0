Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D033F588
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670132; cv=none; b=fcOHR9NOyTSUzPMejB87eVqZUZYxVHUiDlh4E+63VTpSdkknzRLN0E7ZJfmdAnlzXzShNfdAaj78cgRwb5KriejAd65pOrLk5/S4pRxHfVx7JS28SCM69qx2fJBLVLizGZk+S/cyZqNISjAMNIps6jcn5EelDzEDKCNQ/Thg07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670132; c=relaxed/simple;
	bh=AJLexjR4j/EcxhZEfolSjbEv+bza6WRDeznDD4kK5d0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTgpmBiGBhtfWGgQAz/4F/EsjmNhUVkNyLJm63cEb3vvTO5icN9FLZ7KL6FhypR71PmFpFY5qT0SAtV0ixXaHNQsVQ6agvQEAP23zfoQe0br26yK67M4EXZMZptxzFEB8INMxoxohAwTi6To2tlPbNJ3T/3YsrBEx3lK7bLKnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRDiYTCh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRDiYTCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0811C2BCB4;
	Fri,  1 May 2026 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670132;
	bh=AJLexjR4j/EcxhZEfolSjbEv+bza6WRDeznDD4kK5d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RRDiYTChTHtm5rg8zs6rds0tv3YNxQxotPrvQikPz1sNmq6C6Z4HuWkmGXYhIqoZp
	 E09pP21mC3K+/VH3eEg+da6/Rhr+YL0opm2suKZNU6pkO6fvKhA4VloEfK8r1eYtMt
	 tNmA9BQ60YAjx3kXhuxehiv3xBAdNP95W9EJJYFXrpI5EtUTT00aHyPHkYN46Io4wm
	 MXr+U+aggHh7aD2CuPb6bs0ZstVmQ84eIRIxCMhOk48W28IJGWcivEm68vJvPIJj5h
	 dC3WAB/ojQk4pjFbZ+2OD31ScTb/4SfIxhKB05oQvFHkkK5cyL64s76PpRX6Ycdknt
	 AYjq3v6mUZOhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430211351.658193-2-ynorov@nvidia.com>
References: <20260430211351.658193-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 21:15:31 +0000
Message-Id: <20260501211531.F0811C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Using `#ifdef CONFIG_CRC32` breaks the build for modular drivers th=
at rely on `eth_hw_addr_crc()`.
--

commit 734658b27c8ae06b58089e30d3e39cd61c7d09d6
Author: Yury Norov <ynorov@nvidia.com>

lib: include crc32.h conditionally on CONFIG_CRC32

This commit restricts the inclusion of crc32.h and the definition of
eth_hw_addr_crc() in etherdevice.h to only when CONFIG_CRC32 is enabled.
This fixes implicit declaration errors when building tinyconfig where
CONFIG_BITREVERSE=3Dn.

> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index df8f88f63a706..d35be27a91a55 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -20,7 +20,9 @@
>  #include <linux/if_ether.h>
>  #include <linux/netdevice.h>
>  #include <linux/random.h>
> +#ifdef CONFIG_CRC32
>  #include <linux/crc32.h>
> +#endif

Will this break the build for modular drivers?

CONFIG_CRC32 is a tristate option. When it is configured as a module (=3Dm)=
, the
build system defines CONFIG_CRC32_MODULE but not CONFIG_CRC32. Thus, the
preprocessor check evaluates to false.

Should this use #if IS_ENABLED(CONFIG_CRC32) instead to support both
built-in and modular configurations?

[ ... ]

> @@ -281,6 +283,7 @@ static inline void eth_hw_addr_random(struct net_devi=
ce *dev)
>  	dev->addr_assign_type =3D NET_ADDR_RANDOM;
>  }
> =20
> +#ifdef CONFIG_CRC32
>  /**
>   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
>   * @ha: pointer to hardware address
> @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_ad=
dr *ha)
>  {
>  	return ether_crc(ETH_ALEN, ha->addr);
>  }
> +#endif

If CONFIG_CRC32 is built as a module, will modular network drivers that call
eth_hw_addr_crc() fail to compile due to an implicit declaration error since
this definition is hidden?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430211351.6581=
93-1-ynorov@nvidia.com?part=3D1
