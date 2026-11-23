Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795475905;
	b=grjPjy0yP5BsMQrxvQEeWSIvRRxz1pCVZuVEtpanOl+WzB9YAYS7t+LrsMH8MFKvF0Fy
	 4fcS8Rl0hHrS8HtjTHZJaFkMQ7ruMC2zXJ97mAOfNNe8MvsHweXfvqEZAWQlVTS9gAeZo
	 GEHyu8LrLv/fW3ZcSC460UIN6CV3cc6oFVH1Oh9h67gG6p3ygfxNF9iPL9C8Fc7038xDy
	 JAaL3qx8duLNxnoOSR+/DAPiGvy0Mb9osmWuK49ufq6wO9fB97ZAuVswC3YUfRbsFcY7p
	 n3Ollv1ejrPgoJcmMAP4/AxfUs+4pBS61pazQIBIism48VFFrSaPR7cM7S8C6InmiZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475905;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=38/ikcX48bedDufx70JkiW9O6R+ogdOZ3vndjelVDdU=;
	b=2fY5RvhOM4TAMXkM6fLkdcX+8U0He8jPMvnf9IjnlYfuRRddtQ7vJgPspOa2Mk6r5HiY
	 q5Xa3BlGxILtd2RxVDDoWt0/LaQ+DnNepYXB6yO6qVfid3ZCOD8I/VlX6Uee+rCL/VsxH
	 6GgDEOgdOg0TMVFDQrdeH8kWF/ZVMVVthbmE84fFeUz9x1+Mx+rmWKr9IMoJrl/z1pvfE
	 EPMo06odJo28ymsqF8xnwVVRZmKpfloFTGOSB/ODowcVi2yfUP23ktedRI2YITnlan7Ms
	 H0v/lEmTA81KQgK4sm6RcB6NXzmwmeOqwPL2EAzVchRusOJTS3QED9IAh3YZfU0TnLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+t+KaY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADDB606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+t+KaY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C146A1F000CF;
	Mon, 23 Nov 2026 23:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795475905;
	bh=38/ikcX48bedDufx70JkiW9O6R+ogdOZ3vndjelVDdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D+t+KaY3T5d78zJt8LQVRiF3dPdLzP9q76RVxxYLdNbEixOF6QwBHwdXXBRP/L7UY
	 gosVcZOkoke2X3NmADgorFFUHxMcxEbf1RYK1cczE/Y5RLsuCS0zSId1Qfo2UG/HRR
	 zVO0glYrzaSx/aXOiIRO+CJrw0IORymzRE1PTJ1BeX2pspoiLRF74yPNI0T5/Xup83
	 taIFhrAXn6ezN0Zf1s2I98sCiBKGinZdgZVmfjZ2p0dqMGfBEpB5RqHaQx5Db0V8GK
	 tNsyfZiSnlgB/xR8dpIbPEi0j1VYqO7dWQK+Hz0h3sj0I+6TG9R9zMWrxc5IAo/CA5
	 p6ZSWSIdM94dQ==
Message-ID: <a29d9ea3-1d36-46e8-914a-32753afb0725@kernel.org>
Date: Mon, 23 Nov 2026 23:18:22 +0000
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
Subject: Re: [PATCH bpf-next 2/2] kbuild, bpf: Remove pahole version checks
 below v1.24
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261123231053.2538168-1-yonghong.song@linux.dev>
 <20261123231058.2538362-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261123231058.2538362-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 11:10 PM, Yonghong Song wrote:
> The previous patch makes CONFIG_DEBUG_INFO_BTF require pahole v1.24, so
> the Kconfig checks for an older pahole always pass with
> CONFIG_DEBUG_INFO_BTF.
> 
> Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24), which is always
> set with CONFIG_DEBUG_INFO_BTF. Drop it from the dependency of
> CONFIG_RUST on !CONFIG_DEBUG_INFO_BTF, and always pass
> --lang_exclude=rust in scripts/Makefile.btf, which is only included
> with CONFIG_DEBUG_INFO_BTF.
> 
> CONFIG_PAHOLE_HAS_BTF_TAG (pahole v1.23) is still needed, since
> btf_type_tag is only used with clang, but it no longer needs the pahole
> version. Every user of it also checks CONFIG_DEBUG_INFO_BTF, so make it
> depend on CONFIG_CC_IS_CLANG only.
> 
> The pahole flags and the resulting config are unchanged, except that
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

one suggestion below, but

Acked-by: Alan Maguire <almagui@kernel.org>

> ---
>  init/Kconfig         |  2 +-
>  lib/Kconfig.debug    | 12 +-----------
>  scripts/Makefile.btf |  2 +-
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index c8a7cfa60a6e..ca7f20462d0c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2065,7 +2065,7 @@ config RUST
>  	depends on !MODVERSIONS || GENDWARFKSYMS
>  	depends on !GCC_PLUGIN_RANDSTRUCT
>  	depends on !RANDSTRUCT
> -	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
> +	depends on !DEBUG_INFO_BTF || !LTO
>  	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
>  	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
>  	depends on !KASAN || CC_IS_CLANG
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9479034afe5a..c6123d52576e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -409,22 +409,12 @@ config DEBUG_INFO_BTF
>  	  DWARF type info into equivalent deduplicated BTF type info.
>  
>  config PAHOLE_HAS_BTF_TAG
> -	def_bool PAHOLE_VERSION >= 123
> -	depends on CC_IS_CLANG
> +	def_bool CC_IS_CLANG
>  	help
>  	  Decide whether pahole emits btf_tag attributes (btf_type_tag and
>  	  btf_decl_tag) or not. Currently only clang compiler implements
>  	  these attributes, so make the config depend on CC_IS_CLANG.
>

While we're in the area, should we fix this to reflect that gcc has BTF tag 
support now?  
> -config PAHOLE_HAS_LANG_EXCLUDE
> -	def_bool PAHOLE_VERSION >= 124
> -	help
> -	  Support for the --lang_exclude flag which makes pahole exclude
> -	  compilation units from the supplied language. Used in Kbuild to
> -	  omit Rust CUs which are not supported in version 1.24 of pahole,
> -	  otherwise it would emit malformed kernel and module binaries when
> -	  using DEBUG_INFO_BTF_MODULES.
> -
>  config PAHOLE_HAS_INLINE
>  	def_bool PAHOLE_VERSION >= 132
>  	help
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 02ff1702e1e8..8cd8c88d4580 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -20,7 +20,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
>  
>  endif
>  
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> +pahole-flags-y						+= --lang_exclude=rust
>  
>  btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
>  ifneq ($(btf-inline),)

