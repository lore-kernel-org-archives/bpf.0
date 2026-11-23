Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475954;
	b=WKNE7JS0lhDOFkoEQrrWpOb17xdyVgrYY24agGNZEDbkhstCKOF13TlsbAO+hb/AHQo9
	 Y4Na67Ocp+6IzFyBoW3Cln/BMN1lNsImO+3+JI02pBLtuoVza3B02R2RDvHzHbR5V2HMs
	 Wv5TBWHvDzwSaphHCAsiGhOJwD0GxYEXUcwO/vZT4vxx/+5YQdkJQVbT6sJ3tIyCCUHbE
	 NTE2j7ZT121I0CAcEtJTqVMnWdGpwwlcdwdXIY6j2vgW3N0V/4JK11MCsntbxLUWt4I6l
	 9ZwK3rzOYNFxPTNPXgnsPgRsT3TwJ5qKR6xU+YmFQAkRq8J1r1zhPVB++j84qrkzXGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475954;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=W+na5iIX3zD/O39sdwfd5yg7zYf+HfIqHsl33I4U7Rg=;
	b=YFnwMjKdqelpvpwG+D5pqcnGUTDndkVzfEOpqXS23DztXObtvhjwF9k4Wq3jpmfCaaiY
	 jxL5fO9czlKt0W4Xr5Xhu/rIMU7YzlpUi3EbRSj9heR18KIzsJbO8oGv08v6YifdeOwZu
	 vmkDdXHecQgQqPUvtAKBDrckHD45IycoeOc98JPNaZaIM+jlTlSK2FSOV9SyUE1l4uHa8
	 uomE/zVR8h+o7lE9FqMH4/DpJVCPfjO/J7jHKJ+5fTLz/Oh9oJWqpBAe0Z/ipW1mb+r+m
	 bfeYNXwEzF1DDm9td8wCkKSupx6tZRBFJ89I7dVHNbLZbYAkwoK6bj/OmWIygWyNV+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4CJsiPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A206606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4CJsiPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC921F000C4;
	Mon, 23 Nov 2026 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475953;
	bh=W+na5iIX3zD/O39sdwfd5yg7zYf+HfIqHsl33I4U7Rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T4CJsiPUGMINfNDOnR7NvyuT0XA30giS1Nm/ywIouWTt/zv+YJOdVctk2Qg/9KAfv
	 Pndy2a/BkjMODOyES5Z7DhNXZWoZZVXWKS/eVYk3QFd7Athczk0f6Rxjbj6bhQLdvJ
	 vXiFYsnVjFTCrl68Zd0OcYVE5QfDhy6Xhl2ZpHDzjXp9e8Cwl2QWpqIi0nsuFGkrFl
	 Q87Y+B4hxraSTWvs7ryi9X8hkpRhyAkWQOSEIlQs6Uq+3G4xjymK4/b4AtaGtCUCeS
	 Kg16fYEfi2beEYujb9BIxyQTQnsH1cAb+u0qya6xVdFIJLsdfKND8CRO/IDEQEnt8v
	 BLFyG8tRo3fdA==
Message-ID: <16b4f479-0830-4a90-b32a-d360aca1dc45@kernel.org>
Date: Mon, 23 Nov 2026 23:19:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] lib/Kconfig.debug: Set the minimum required
 pahole version to v1.24
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261123231053.2538168-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261123231053.2538168-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 11:10 PM, Yonghong Song wrote:
> Commit 2c1ccd9a1d78 ("docs: changes.rst: restore pahole 1.26 minimum
> (regressed by sort)") raised the minimal pahole version in the
> requirements table of Documentation/process/changes.rst to v1.26, since
> kfuncs with KF_IMPLICIT_ARGS needed the decl_tag_kfuncs feature of
> pahole v1.26. Commit 692393104909 ("resolve_btfids: Emit bpf_kfunc and
> bpf_fastcall decl tags") removed that need, as resolve_btfids now emits
> the kfunc decl tags itself. CONFIG_DEBUG_INFO_BTF, on the other hand,
> still accepts pahole v1.22.
> 
> Set the minimal version to v1.24, so that the kflag of an enum in
> vmlinux and module BTF is meaningful: 0 for an unsigned enum and 1 for a
> signed enum. pahole records the signedness of an enum in the kflag since
> v1.24. With an older pahole, every enum has the kflag 0, signed or not.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Alan Maguire <almagui@kernel.org>

> ---
>  Documentation/process/changes.rst | 4 ++--
>  lib/Kconfig.debug                 | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 28f2ca63318e..a292f31f1891 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -53,7 +53,7 @@ mcelog                 0.6              mcelog --version
>  mkimage (optional)     2017.01          mkimage --version
>  nfs-utils              1.0.5            showmount --version
>  openssl & libcrypto    1.0.0            openssl version
> -pahole                 1.26             pahole --version
> +pahole                 1.24             pahole --version
>  pcmciautils            004              pccardctl -V
>  pigz (optional)        2.4              pigz --version
>  PPP                    2.4.0            pppd --version
> @@ -146,7 +146,7 @@ pahole
>  
>  Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
> -modules as well.  This requires pahole v1.22 or later.
> +modules as well.  This requires pahole v1.24 or later.
>  
>  It is found in the 'dwarves' or 'pahole' distro packages or from
>  https://fedorapeople.org/~acme/dwarves/.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2d22638ec13a..9479034afe5a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -400,12 +400,12 @@ config DEBUG_INFO_BTF
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> -	depends on PAHOLE_VERSION >= 122
> +	depends on PAHOLE_VERSION >= 124
>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>  	depends on !HEXAGON
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
> -	  Turning this on requires pahole v1.22 or later, which will convert
> +	  Turning this on requires pahole v1.24 or later, which will convert
>  	  DWARF type info into equivalent deduplicated BTF type info.
>  
>  config PAHOLE_HAS_BTF_TAG

