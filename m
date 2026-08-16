Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6623C51D
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786851474; cv=none; b=B/tAjQmsdUdwMF3Qu2HvvJTQVDj5sSqKZJP3ZeAMZO2Tay94PYqH49+ym/BebahefZIloZt7zcsMDEiCKjyziThVTKiYKhYTA04LakFxUfdOgJR3oYE4MCw4XrUPdc4ZbEwYzvGSELI2XRUZY0fu/6eCsiVY+bmJTEMH0eCCy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786851474; c=relaxed/simple;
	bh=TXdU5a3hpzsv6rBO+e0cS9mPNDSvXVxBFF0qwRD2QAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGtPf/+5FNI7nGuUzfEYGdr15DnUGB12/uenWK/mOqtHT6uOsP/IQu9xdRO1RHYvQOTejvgJOY8mytdt2ag0bJaUNwiIsEY0tu/cJA3UEXRXWE+UaXZjwJhdUvJTGJ9SchdSUvNoisObJG+o0hvtATMA0v642YsFBgNO4gFslS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k73fyvCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k73fyvCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794AE1F000E9;
	Sun, 16 Aug 2026 03:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786851472;
	bh=RBK98PDQu+5VuUWyUwCg0J7nrYLtmGGv5bOcJPo4mbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k73fyvCdzzhH1wvCL/XnSmU2m5HNY9WmUnIEpv6GXujuIGgCpG7biXBWrpYfQ+Lvb
	 N75hxPRvwQT1QrMvi8qXPVg3iHFsNpib/ywUDdpSLqve5vK7n1EZeMKr08yQqnUt0O
	 Zisi/MxcuaL4zpzLbENVHSYEHvi8eu06s0rWD8bog7vvF9hp/MfGQoWOnLUReHgGE/
	 PgcAI4jYbybtLc3RXfQJGBg5fitUFuBLZIPJPj3d+VlV7nAymFA7zIV0t1KfPATK8p
	 3khJU8kNfc6xAlloDvqeaiuzKxxqEkKTlHhb2BJha6kFPakXT9SfawFhrbnHAQwXeW
	 DbSjML3/lX/Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: free page_pool frags via the page_pool path in
 bpf_xdp_shrink_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260816031245.268898-1-jiayuan.chen@linux.dev>
References: <20260816031245.268898-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 03:37:52 +0000
Message-Id: <20260816033752.794AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The netmem_is_pp() check fails on compound tail pages, leading to =
page_pool leaks and 'Bad page state' kernel panics.
- [Low] The multi-line comment introduced in bpf_xdp_shrink_data() does not=
 follow the required BPF subsystem comment style.
--

--- Patch [1]: [PATCH bpf] bpf: free page_pool frags via the page_pool path=
 in bpf_xdp_shrink_data ---
commit 28e0b86b119236ed1263628b895946efb16e99cf
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: free page_pool frags via the page_pool path in bpf_xdp_shrink_data

This commit fixes a page_pool leak reported by syzbot when generic XDP
programs shrink skbs into fragments. It inspects the page itself using
netmem_is_pp() rather than relying on the rxq memory model.

Closes: https://syzkaller.appspot.com/bug?extid=3D237bbeed8dfe0699b7f5

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3423734124a5b..4536bd147c253 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -4293,6 +4294,14 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *x=
dp, skb_frag_t *frag,
>  	if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
>  		netmem =3D 0;
>  		zc_frag =3D bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
> +	} else if (netmem_is_pp(netmem)) {

[Severity: High]
Does this check handle compound tail pages correctly?

For fragments that span into tail pages of a compound page (such as those
from an order > 0 page_pool allocation), calling netmem_is_pp() directly on
the tail page might fail to find the page_pool signature. Tail pages store
compound_info in the memory location overlapping with pp_magic.

Would it be safer to check the compound head page here, perhaps using
netmem_compound_head(netmem) before checking the signature? Otherwise, tail
pages might still route to the wrong destructor and trigger the Bad page
state panic this patch aims to fix.

> +		/* The rxq mem model does not always describe how a released
> +		 * frag must be freed: the generic-XDP and veth paths run the

[Severity: Low]
This isn't a bug, but does this follow the required BPF subsystem multi-line
comment style?

The style guide requires the opening /* to be on its own line:

/*
 * The rxq mem model does not always describe...

> +		 * program on a shared rxq while the frag has been cow'd into
> +		 * page_pool memory. Trust the page itself and return a
> +		 * page_pool frag to its pool regardless of rxq->mem.type.
> +		 */
> +		mem_type =3D MEM_TYPE_PAGE_POOL;
>  	}
> =20
>  	if (release) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816031245.2688=
98-1-jiayuan.chen@linux.dev?part=3D1
