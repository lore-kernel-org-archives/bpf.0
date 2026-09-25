Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47B40B0E6;
	Fri, 25 Sep 2026 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371987; cv=none; b=SV67pZjmHCtZiKr4LUnh+HtpzvvECSO5tfY1IuIi9saN+HcXuuKsqh7X+xuV1pbtFOftlTlyuQgH/dskrLoTW1V/4rd160O2U3ZuwtYQp8Mru5iJqHtFWcK5z2qBsqy01gCbI9kW8I90hPiqdDgmJYISW+zS4wMvozDlcmQUqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371987; c=relaxed/simple;
	bh=oFzVmRidh8A7hLbK7dnJIflNNaFtAjbE1RmpP4AhD5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNmius4jHdT0N01hBlYxujsSkuHyn8m7jyeQMtJuvQ73/V6kvJn/X6/vYljgiRhSjtcOklM0nnTIrNnRXFlaZyhuAOOkek1atOKHOtYUCojXvseECKsBKSSVyT5Pp/wluC1WnlpR7nPe/1y/q5B7c4VPZWj4xqjgliY5jF/RKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBqWZZBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBqWZZBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C371F000FF;
	Fri, 25 Sep 2026 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790371985;
	bh=bEyB0hFzcNjqnvyi3s6ue1V4vlnrFUcfpW0f0eI9Kis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBqWZZBIplh9zujyJHuJdeHcCaElSJ3iME8q+AsA21EP7TRgsGTHTckuqXSA8tagv
	 EViwGO+eJHOvd483i1vDwNjWWZQMktSStlq6W6atqdjMLwDs10c+TDFTEnM9lkIDo/
	 mBy2sOy/fapuYc4p2kpriWrj4aa8Kk9vQOVfqGkBajKqc+q3RHpLGIztNibUQeGFGM
	 7ftmXZ6HRWaVXN+Nks64E6w8RgzN85vPcIm21Psa6IqJtIBCgx545RTfxID5wUZ7Oy
	 diPexwfiGnthaNks03LcYqWvOR3UB9L7PodYAkEZA9QW8VbwmlO5xvKtad5pzoDKvS
	 svczG5CP4IFvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 9/9] kbuild, bpf: allow building the vmlinux
 BTF as a module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260925211314.5118-10-wanjay@amazon.com>
References: <20260925211314.5118-1-wanjay@amazon.com>
 <20260925211314.5118-10-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:33:05 +0000
Message-Id: <20260925213305.A7C371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kconfig: turning DEBUG_INFO_BTF into tristate silently disables de=
pendent bool features
--

commit f23aaa487601db0500af9e21873fa5fc4f1af7b5
Author: Jay Wang <wanjay@amazon.com>

kbuild, bpf: allow building the vmlinux BTF as a module

This commit makes CONFIG_DEBUG_INFO_BTF a tristate. It allows the vmlinux
BTF to be built as a module (btf_vmlinux) that is loaded on demand, saving
memory when it is not needed.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 134b15a44625e..418025c5e6577 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -396,7 +396,7 @@ config DEBUG_INFO_SPLIT
>  	  Incompatible with older versions of ccache.
> =20
>  config DEBUG_INFO_BTF
> -	bool "Generate BTF type information"
> +	tristate "Generate BTF type information"

[Severity: High]
Does this change cause a regression where dependent boolean features are
disabled when CONFIG_DEBUG_INFO_BTF is configured as a module?

In Kconfig, when a bool option depends on an expression that evaluates to
m, its upper bound is restricted. Since a bool cannot hold an m value,
Kconfig evaluates the option to disabled.

Several major kernel features are boolean options that depend directly on
CONFIG_DEBUG_INFO_BTF, including CONFIG_SCHED_CLASS_EXT, CONFIG_NET_SCH_BPF,
CONFIG_DEBUG_INFO_BTF_MODULES, and CONFIG_PROBE_EVENTS_BTF_ARGS.

Setting CONFIG_DEBUG_INFO_BTF to m evaluates these dependencies to m,
which causes these features to be omitted from the build.

Could the dependencies be updated to evaluate to y when BTF is built
as a module, such as using depends on DEBUG_INFO_BTF !=3D n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925211314.5118=
-1-wanjay@amazon.com?part=3D9
