Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E713CA4B3
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785971790; cv=none; b=B8PdN6TYPR293qQ+XZAOef+7E1KWcCVA1ANiSaao1Y+CzsF1UuI/2YNFqv5cFVZxAIJmpLez2kitjkMQgttOlo4BJqFNuPkloLkwNGsIwVZPA1fY2hClEk2Xx5cMPdzA0w1aAxu3d7ZCuWKya/OfMO4wRkUz4pGTBnyudGGyA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785971790; c=relaxed/simple;
	bh=KY2gwTrXWYYB+DJ/7nN/Rbth4qijjomUxDPmNL7QQqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s9dEgFHFxf0ir111+SUdXW44D9vYY4f3eV+13JjtuT9NINVmIj8vO/Rnty2rIUWBIsjp+BcE30POa2WN7hbJL4Z/Yt3BUk1ipJy2WJCjh1jAr3rGSLpoJge5YKv2204PKhrsD+nrsM6laRMebB3li+GWy58vu7EFBLsQMHHP++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxWXtHkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxWXtHkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F391F000E9;
	Wed,  5 Aug 2026 23:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785971789;
	bh=pjWhibOr5+XYOwkLsnDMQ/DQgDF3EAaYtIINcEWcmBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxWXtHkhdha8gvSEdJcNP4/fefz+71JIWFsUMZrJ2FaBjwOuLNVgmNxOvWSmt+jYk
	 Gnr0cCQ+hkqJG2jbdeOTCp2oKJFfbEOOK3kT+Mwa4JFAYt3RVUF5uGOttHhpjUG5eZ
	 ZSs0Dy4VV70JjvcqUnmDfCD0e9zhclyBGmzD1YPn3Q7kZdZ7KNTnK1aLv0FKirVfb/
	 Tqam2MDVj3Cxx6CTW08XOvkTEfOIzAEX/yZ/kce073KnZR91EPJr/ONdmzbX5yVqwa
	 ZJykMeqketCENiWFF2HrxlSSQYI1EQcTUeuhsOu4oZZfaNtPXDzLgE7/HjxlmppxN0
	 avw/iUhLdxzJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc
 BTF annotation emission
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 23:16:28 +0000
Message-Id: <20260805231628.D5F391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The minimum required pahole version in the changes.rst table was=
 not reverted to 1.22 after its dependency on 1.26 was removed.
--

--- Patch [6]: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc=
 BTF annotation emission ---
commit b5222d5ea4c3ea695d12ac70fc23f3fbadabd591
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

docs, resolve_btfids: Document kfunc BTF annotation emission

This commit updates documentation and comments to clarify that resolve_btfi=
ds
now emits BTF annotations for kfuncs instead of pahole. It modifies
changes.rst to reflect that a specific pahole version is no longer required
for these annotations.

> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index 1ca8c5f73ad00..6d1dbe4abf0f0 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
[ ... ]
> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selecte=
d, the build system
>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from =
kernel
>  modules as well.  This requires pahole v1.22 or later.
> =20
> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v=
1.26
> -or later.  Without it, such kfuncs will have incorrect BTF prototypes in
> -vmlinux, causing BPF programs to fail to load with a "func_proto incompa=
tible
> -with vmlinux" error.  Many sched_ext kfuncs are affected.
> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the =
arena
> +address_space(1) type attribute) are emitted in-tree by resolve_btfids f=
rom the
> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
> =20
>  It is found in the 'dwarves' or 'pahole' distro packages or from
>  https://fedorapeople.org/~acme/dwarves/.

[Severity: Medium]
Since this removes the dependency on pahole 1.26, should the minimum
required version in the "Current Minimal Requirements" table earlier in
this file be reverted to 1.22?

The table currently still lists 1.26:

Documentation/process/changes.rst:
    openssl & libcrypto    1.0.0            openssl version
    pahole                 1.26             pahole --version
    pcmciautils            004              pccardctl -V

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805230648.2354=
989-1-ihor.solodrai@linux.dev?part=3D6
