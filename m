Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8382272E7C;
	Tue, 20 Jan 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937951; cv=none; b=ru9EMWwCAvfbfpjwg2J5L644mFDyeWhcPhrJbE30tpCB4u3JXlOLpQEdtddXciW/Xoo6aFY8VgZXBkHa7PckWFLrNN8x6CfJP0T/GaCUK1xYsvsMPGG8UK2bOVr26QRx5SeempIFGEOg9DrneyDSuz+2UfcduVLkWMG9AkT8LI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937951; c=relaxed/simple;
	bh=+Xn99DMkloz7vwj6dDBCMojDf0BKZG2iyU96TDB1ZzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvKQWPAJW26ejP+4t4X9CgWRyVvYWVGp45jWF9l1O4zWnuPzbhDVq7lwzudm+/dnuQkkxOhiGsN4tgK+8iddvy67QfyEm42ZEtuuHXFoaOfbN9Z/33R4fM+28wRxl954DDYAl3q+RD7SgnWRLuVlzJ5pZ7OQFIa7ynYXrV1VuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZAau5bv9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZAau5bv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768937940;
	bh=+Xn99DMkloz7vwj6dDBCMojDf0BKZG2iyU96TDB1ZzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAau5bv9VLz+Hw3R/m522LpPXxy1PKtHJmrdizN6vcxDGBmnFiQPk/btoEvIc+swI
	 9zpZ0ctqUnDPcJ04G0VeVtuRggBW4wUnEqXo32ZnbNkfxV7QsAd5MlhZgCjAne4HTn
	 qm6bMHewJk88JiXfoqkGnXenHElEm1tlkWYqjgOM=
Date: Tue, 20 Jan 2026 20:38:59 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Gary Guo <gary@garyguo.net>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
Message-ID: <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>

On 2026-01-20 19:15:11+0000, Gary Guo wrote:
> On Tue Jan 20, 2026 at 6:59 PM GMT, Ihor Solodrai wrote:
> > On 1/20/26 10:20 AM, Gary Guo wrote:
> >> From: Gary Guo <gary@garyguo.net>
> >> 
> >> NixOS only puts /usr/bin/env and /bin/sh at the standard location as
> >> required by POSIX, but not other shells. Other program that kernel build
> >> depends on is supplied via PATH, so shebang needs to use /usr/bin/env to
> >> find them.
> >> 
> >> This has been done to a few other scripts already, e.g.
> >> gen_test_kallsyms.sh or decode_stacktrace.sh.
> >> 
> >> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
> >> Signed-off-by: Gary Guo <gary@garyguo.net>
> >> ---
> >>  scripts/gen-btf.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> >> index be21ccee3487..4cd3159f2ddb 100755
> >> --- a/scripts/gen-btf.sh
> >> +++ b/scripts/gen-btf.sh
> >> @@ -1,4 +1,4 @@
> >> -#!/bin/bash
> >> +#!/usr/bin/env bash
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> >>  #
> >> 
> >> base-commit: 053966c344dbd346e71305f530e91ea77916189f
> >
> > Hi Gary, thanks for the patch.
> >
> > I'm guessing this came up because gen-btf.sh is part of the vmlinux
> > build, and link-vmlinux.sh has #!/bin/sh (not bash).
> 
> My typical experience is that when I see an error about /bin/bash not found, I
> just use "bash <script path>" instead without putting much think into it.
> 
> gen-btf.sh is part of build so I don't get to invoke the script directly, hence
> the patch.

For the build we have $(CONFIG_SHELL) to stick before the script.
It is only 'sh', but it is the well-known variable users know to
override. IMO all script invocations should use this mechanism.


Thomas
