Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4A48F841;
	Tue,  1 Sep 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285351; cv=none; b=mUWSVCmLg9SZaEFK7415kw5mrhb4x76d8aFlAUFBT9fWXE0HhSsN/Wg6LsneriYJZ3W8sZiunRAeROBxyWKR6tFiB0TIPYWDR2qz4lPObwAusXA/BlGBuEErEgwQQKksa8PohaoM2ap/uGKNsS+1jWcRPmUABod8B3cjrbn/33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285351; c=relaxed/simple;
	bh=vhQB7Ffs0ksZ2qC3QLRL+FPWg7pd9dktuVycpQbTgAw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g9C3Lq6cINgMbjbXUj8PyqefLEVOMLLipsfHExfaEsU8RhZKKSbqYw6Uh9FUkBELpDEN5jgo7exuIrJNedvXGqrqhsnq5JOnsTIiD4D6EJHwmWSAX5UwUDi9jT8caGl4L4QWXu257pOWDxzYuv2lWysvxo+LV3LZzd7L+w6vVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNCBMSxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNCBMSxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F9C1F000E9;
	Tue,  1 Sep 2026 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285349;
	bh=FgU6jneqTVjqscHs5hbN9Zu40bscoeCMNi6qdFAKS1w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DNCBMSxcQ/b7e5AfEuO9vlsWXTYt3HYti/QNpAkGJI/qTSmh8LU9JZAgA27y19qda
	 wdanH5ZOnl+j8QCuKkU3asZG8x59wZVoHJqCMrW9+YxpBfn7Q2ALRSCYmrPulaK35Q
	 S+b+t6jXqVus10vVdwDEZf6vC6XV6Ss3tsO6UAz+6daCX8prR2WspoePgWoEcTYUL/
	 GiMrfbzS2JVvE8uM0PfGlWrsUo6UKr18U1eW/bUS+mhxxTitwfOze+T9uX1hMyemJJ
	 5otQiSfVpqFuNiilvfJpuBEQsS+1lG93ubX7p7S10yv5dVsjY5BzBe0tg5HbUppkO7
	 xX4RNyzCr1pNw==
Content-Type: multipart/mixed; boundary="===============3884375615609321919=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e5209d324ce6f1a8cbfbf1bcd1dec1ee1b810661872bb2e359db5c281a8a2cc@mail.kernel.org>
In-Reply-To: <20260901165757.801449-14-alan.maguire@oracle.com>
References: <20260901165757.801449-14-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 13/18] kbuild: Add support for BTF inline information
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:48 +0000 (UTC)

--===============3884375615609321919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2988aa12f66..a2e192854c47 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -675,12 +675,23 @@
>  /*
>   * .BTF
>   */

[ ... ]

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294..dd1b2d9ebe99 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -425,6 +425,12 @@ config PAHOLE_HAS_LANG_EXCLUDE

[ ... ]

> @@ -432,6 +438,17 @@ config DEBUG_INFO_BTF_MODULES
>  	help
>  	  Generate compact split BTF type information for kernel modules.
>
> +config DEBUG_INFO_BTF_INLINE
> +	bool "Provide information about inline sites in BTF"
> +	default n
> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
> +	help
> +	  Generate information about inline sites in .BTF.inline sections.
> +	  These sections contain split BTF relative to the kernel or module BTF
> +	  and are made available in /sys/kernel/btf with a ".inline" suffix.
> +	  The information describes inline locations and how to retrieve their
> +	  associated parameters.
> +

This isn't a bug, but could the changelog lead with why inline location
info is wanted and what a consumer does with it, rather than one sentence
per hunk?

In particular, is the in-tree/external-module paragraph still describing
something in this patch, and would it help to note that the SYSFS
dependency and the /sys/kernel/btf exposure mentioned in the help text
arrive in a later patch?

> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index a1812985a61a..d42dbc8d7199 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -22,7 +22,14 @@ endif
>
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>
> +btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
> +ifneq ($(btf-inline),)
> +btf-inline-feat := inline
> +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=$(btf-inline-feat)
> +endif
> +
>  export PAHOLE_FLAGS := $(pahole-flags-y)
> +export BTF_INLINE := $(btf-inline)

This isn't a bug, but could this collapse to something closer to the
surrounding one-liners, e.g. `pahole-flags-$(CONFIG_DEBUG_INFO_BTF_INLINE)
+= --btf_features=inline` plus `export BTF_INLINE :=
$(CONFIG_DEBUG_INFO_BTF_INLINE)`?

Since DEBUG_INFO_BTF_INLINE already depends on PAHOLE_HAS_INLINE
(PAHOLE_VERSION >= 131), is the extra test-ge 131 check inside the block
doing anything, and is the `btf-inline-feat` indirection needed?

> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index 8ca96eb10a69..a75f41878c32 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -76,6 +76,7 @@ gen_btf_data()
>
>  	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_FLAGS}	\
>  		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
> +		${BTF_INLINE:+--inline}		\
>  		--btf ${btf1} "${ELF_FILE}"
>  }
>
> @@ -83,14 +84,21 @@ gen_btf_o()
>  {
>  	btf_data=${ELF_FILE}.btf.o
>
> -	# Create ${btf_data} which contains just .BTF section but no symbols. Add
> +	# Create ${btf_data} which contains just BTF sections but no symbols. Add
>  	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
>  	# deletes all symbols including __start_BTF and __stop_BTF, which will
>  	# be redefined in the linker script.
>  	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
>  	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
>  		--set-section-flags .BTF=alloc,readonly ${btf_data}
> -	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
> +	ONLY_SEC="--only-section=.BTF"
> +	btf_inline=${ELF_FILE}.BTF.inline
> +	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
> +		${OBJCOPY} --add-section .BTF.inline=${btf_inline} \
> +			--set-section-flags .BTF.inline=alloc,readonly ${btf_data}
> +		ONLY_SEC="${ONLY_SEC} --only-section=.BTF.inline"
> +	fi
> +	${OBJCOPY} ${ONLY_SEC} --strip-all ${btf_data}

This isn't a bug, but would a lower-case name like `only_sec` fit better
here, given `btf_inline` right below it and the rest of the locals in this
script?

> @@ -111,6 +119,10 @@ embed_btf_data()
>  	if [ -f "${btf_base}" ]; then
>  		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
>  	fi
> +	btf_inline=${ELF_FILE}.BTF.inline
> +	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
> +		${OBJCOPY} --add-section .BTF.inline=${btf_inline} ${ELF_FILE}
> +	fi

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============3884375615609321919==--
