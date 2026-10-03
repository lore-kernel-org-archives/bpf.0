Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07721D63E4;
	Sat,  3 Oct 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057410; cv=none; b=s7E7fZ1mfsTMXDsJ6+vqUeCdjBrqNYGr2O1ILXpwC4bdPLVj+3/CJex5Bsodg29wT9ZMa72HkUwCJcw6skevshMiUcE9cRSE+w0xID9Lvc5ZG7FTg9ukK45E3+Bujb1jsH5zWQm7BraGby5DVhPEpq6fD0sWb4BY3NBOH1BqbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057410; c=relaxed/simple;
	bh=6AAgPxaQuo8Eq+/qvIdkUMKGfBBIBseGc9nnV7UxNeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pdWBporPM027Xb7ZB1G9U+ECf3JwNiNtWCGfgPxf3tJ/83FG2bmY8HG98nivy+J4MLclOPtnPNgsBr28bilVSkWB8f8m9sqt1G9YGE2p/cu3bsDEy1lcVqDo5j/Dck31YEupfYx190MeywbJ0Xj/NvcD9AhwcIcZkEOApAXrUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nixWVQzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nixWVQzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B841F0089C;
	Sat,  3 Oct 2026 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057408;
	bh=h+bfzNOsAj30gQLzORwaInLPYwj2sSE87m5AHpUXEDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nixWVQzI2BW2XUgii4HAwJd7h7hEmoqm/LWMY/t1VQUlEMt+TLLGPhrQAnWY4BR4x
	 tn03cnTD0Y1u8ASOkKYPZbDgXv2jPvBXYHPcgseK0buYyH6x1HeRrRRJanLkbJEJKr
	 2a6VFyxBA3pIhjGW8fmOzxF7LqgFrHk6yLdzVRC5mU6ZwtV8QnF5xLuNMolS0AXDN9
	 VMApXFs2GoJa5TnFO0LfsDzmWB7Vt7sNqxTwWisHSKBcWPty0kylwyMjGUAVM4bLpW
	 fOjT8wu3Dyrb5FgLWPCuFOzXrd0oNCYnRTdWYNZN+TIOC6+fx/VLHKnL/4umOIDZbr
	 rmU2fAYCT6NiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 3/7] kbuild, btf: Expose vmlinux inline BTF
 through sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, bpf@vger.kernel.org
In-Reply-To: <20261003194323.817885-4-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:56:47 +0000
Message-Id: <20261003195648.25B841F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: btf: Unvalidated zero-size allocation triggers WARN_ON_ONCE=
 in vmalloc_user
- [Low] bpf: btf: Linkage fails for sha256 when CONFIG_DEBUG_INFO_BTF_INLIN=
E=3Dm
--

commit de2bb52fc001c93d461a0839a26e550f67f5ecc2
Author: Alan Maguire <alan.maguire@oracle.com>

kbuild, btf: Expose vmlinux inline BTF through sysfs

This commit introduces support for embedded and module-delivered vmlinux
inline BTF payloads, making them available via sysfs. It also sets up defer=
red
binding for a module-provided .BTF.inline section.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 134b15a44625e..24abfff1ddc3c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -432,6 +438,19 @@ config DEBUG_INFO_BTF_MODULES
>  	help
>  	  Generate compact split BTF type information for kernel modules.
> =20
> +config DEBUG_INFO_BTF_INLINE
> +	tristate "Provide information about inline sites in BTF"
> +	default n
> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
> +	select DEBUG_INFO_BTF_MODULES if MODULES
> +	select CRYPTO_LIB_SHA256

[Severity: Low]
Does this cause a linkage failure when CONFIG_DEBUG_INFO_BTF_INLINE is built
as a module?

Because this is a tristate, selecting CRYPTO_LIB_SHA256 here means it will=
=20
evaluate to 'm' if the inline feature is configured as a module.=20

However, the crypto library is called directly from the built-in core kernel
object kernel/bpf/btf.c:

kernel/bpf/btf.c:btf_verify_link() {
    ...
    sha256(data, data_size, actual_digest);
    ...
}

A built-in object cannot resolve a symbol exported by a loadable module,
which will result in an 'undefined reference to sha256' error at build time.

> +	help
> +	  Generate information about inline sites in .BTF.inline sections.

[ ... ]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0630675377aaa..732ba06846675 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9015,21 +9016,122 @@ static DEFINE_MUTEX(btf_module_mutex);
> +static int btf_module_handle_vmlinux_inline(const struct module *mod)
> +{
> +	void *data =3D NULL;
> +
> +	if (!vmlinux_inline_link || strcmp(mod->name, vmlinux_inline_link->modu=
le_name))
> +		return -ENOENT;
> +
> +	data =3D vmalloc_user(mod->btf_inline_data_size);

[Severity: Medium]
Could this trigger a WARN_ON_ONCE splat in the memory allocation paths?

If a user with CAP_SYS_MODULE loads a module matching
vmlinux_inline_link->module_name, but the module has no .BTF.inline section
(or its size is exactly 0), mod->btf_inline_data_size will be set to 0.

Calling vmalloc_user(0) here happens before the size is validated against=20
link->btf_size, which causes a kernel warning in __vmalloc_node_range_nopro=
f.

> +	if (!data)
> +		return -ENOMEM;
> +	memcpy(data, mod->btf_inline_data, mod->btf_inline_data_size);
> +
> +	if (!btf_verify_link(vmlinux_inline_link, mod, data, mod->btf_inline_da=
ta_size) ||
> +	    !sysfs_btf_update(vmlinux_inline_attr, data)) {
> +		kvfree(data);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003194323.8178=
85-1-alan.maguire@oracle.com?part=3D3
