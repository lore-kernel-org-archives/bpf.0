Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83979432E8D
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581488; cv=none; b=WL69TSY35GlgLfRuIG3sOfXPNTgfwJaZWyvcNV7E55lHKwCN8iIs00REXxMA1moPaPUDIw0tqmJ2a9ZRPhVYX53FbWUndl7WJUOK2yX4OnWuQdUAd2E947s66lmaft+/pu3ouEnKyyxxOLhUWp5TX/FtwYWYP66iXLv8XPNuTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581488; c=relaxed/simple;
	bh=b6O/Ru0YUI4xxdn5yRnfR8SQCNYg7XaIURZIG265mZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhlKuItx7HSOwmPK6GF6LvoDjPDg0PNDw0U2ZPkPUQsYtEAKBEuc8HLUuhghUBz2sqRwWEFVHdTu3YlYgqg4dVyJ6HMgQ3CcgC1t6nndBrCTyQLUtDNB81yxJEq22Ggkc8zXJH4o6HFHAdi54WqvEWP7cg7BmO09xbO3Y8IlBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IloMf/6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IloMf/6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035571F00A3A;
	Mon, 24 Aug 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787581487;
	bh=pSl1ImY5zi73EfwD/SEljJs8/JKLYhAUAX1aG6LkZHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IloMf/6BS+5X2QoSijIUUGn/VDxiJd+rEWnUyKjAY5S4wlG8BxDeiI0hhtyrYnRHX
	 EWu7nzSOdsapJ7IYrLgbn/ljC3gYb1/UDvLcnCaREpy8eM4es2BOLlDn02kSZWMPym
	 17Ck+ktuks4fN4/DknmdUJAw4p+4LBJVMdZqnWUkFOkOoQPm4e/7Y059GYOvTqhmmm
	 Mvi+rTBQQ8wjNWHvFJNF7sdFloXRkWSZsUogcZx/TFJEBUgOX0lUMCW1GQTc9vpS9o
	 XWMbayWTcY+5XUIoEzyZQIKO54pUieRfzbV3d+poMC8b+KHNiHiB8p2keWGN/2gss+
	 busDFn3kWAf/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libpf: Fix for the compiler sanity checking
Reply-To: sashiko-reviews@lists.linux.dev
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824141532.604269-1-tw19881113@gmail.com>
References: <20260824141532.604269-1-tw19881113@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:24:46 +0000
Message-Id: <20260824142447.035571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Latent undefined behavior due to signed left-shift overflow in t=
he `BTF_INFO_ENC()` macro.
- [Medium] Latent undefined behavior due to signed left-shift when setting =
retprobe bit in `attr.config`.
--

--- Patch [1]: [PATCH] libpf: Fix for the compiler sanity checking ---
commit 6bb550337600fb1ee129a0b5ed1c50e66620bbc5
Author: Tw <tw19881113@gmail.com>

libpf: Fix for the compiler sanity checking

This patch fixes an undefined behavior issue during libbpf compilation.
It resolves a ubsan warning about left shifting 1 by 31 places in an int
by casting the integer to a u32 before performing the shift.

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 4c46d34fc055d..222d2f1c0ed3a 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkage(=
const struct btf_type *t)
> =20
>  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
>  {
> -	return (kflag << 31) | (kind << 24) | vlen;
> +	return ((__u32)kflag << 31) | (kind << 24) | vlen;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but since you are fixing the
shift in btf_type_info(), should we also apply this fix to the BTF_INFO_ENC
macro in this same file?

tools/lib/bpf/libbpf_internal.h:
#define BTF_INFO_ENC(kind, kind_flag, vlen) \
	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))

The !! operator results in a signed int. If a caller provides a non-zero
kind_flag, shifting it left by 31 places into the sign bit will also result
in undefined behavior. Would it make sense to cast to __u32 here as well?

[Severity: Medium]
This is another pre-existing issue, but I noticed a similar left-shift
that could cause undefined behavior when setting the retprobe bit:

tools/lib/bpf/libbpf.c:perf_event_open_probe()
	if (retprobe) {
		int bit =3D uprobe ? determine_uprobe_retprobe_bit()
				 : determine_kprobe_retprobe_bit();

		if (bit < 0) {
[ ... ]
			return bit;
		}
		attr.config |=3D 1 << bit;
	}

Since bit is read from sysfs, if a future kernel update returns a bit index
of 31 or higher, would 1 << bit overflow and incorrectly configure
attr.config? Should this use 1ULL << bit to safely set the 64-bit config
field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824141532.6042=
69-1-tw19881113@gmail.com?part=3D1
