Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652100;
	b=fCvQzQBesvNYof6JnwX+oSDEaZs23neMj+cGRJvboZNykTUIBNqJbIIpqeyLz+p4kdix
	 n60lL6sdLC4/YER84AeThzTdWbn7FDjsgMJUgyT3TTHZ5cPgP5HzmlTyVBF1jWDWDIJS0
	 FV2QjAJ5ZVDA4bmI6U1MGMzMmY7ggW6RjAuE2pFcsbwfaqoOhxTCf6PNWGfxbYChcBflJ
	 ILbyTsZ9z0rPsFAPm89Dxb+cTVIC2MsJFJnyml9z+sOBcz3Prt+nis1dDLh3vvrGz+1s/
	 +R9/wHUTkVXRKvr4ajqjfgp10mShKXciZr3K2aKrk0H0ry/ZWeUNzxhreJafOZqwLGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tpaov0Fhae3n4wC4+GJHz4spflo4TjgYUCfCQ4MH9RQ=;
	b=N6IX1PmxAos+FngPxyV8yV6eYI/zlUZ8EnadWcjw+ZkNJBColSHERqKZ03EUqbUOeN6E
	 SOAx5sdsGmOAZMGuMEB3m87gy6a9d4COEa0Wp0U19xBZoeVQ0298DwXYfHa4/lAkC2iJW
	 BT4aiOUDOJACbDSoFh9AP9oUFirGh923zSB4VVMmJqqipTtJw1Ybp9cVPoaZVHwAzjj4p
	 hqzrq7QQWRiJ+eIXR/l7/aQ8kueRXsXfwvs6CdaJiLvpm9KFRMz973XhS7sMAYUsadwGa
	 cLZ38og+mWA0kfn+ZXQd2aBLF+5CO4GX+haHQTsyCMRMqHLhRZjM9Qqq0CQ5nelZaLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppn9P9E0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44810606A32E
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppn9P9E0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0042D1F00A16;
	Mon,  2 Nov 2026 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652100;
	bh=Tpaov0Fhae3n4wC4+GJHz4spflo4TjgYUCfCQ4MH9RQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ppn9P9E08/+MVIWG1rh/dBYbqIxgCdxCFvjXHK85eXLySGWKUZ1jL4rDpOpx/IAWZ
	 B3aC/EP+SarVeZJ97QGipPZKl+NjU99zJinfSxJgXnuhhyBzHbDmkldJDVFU5r7CxQ
	 D5+NWAvY8DIgUVp8SwZrBPHsUcyESJKscWN7T3EeICEFkTkUt//5RdQrxM7EqmzZIQ
	 5wcf3VmE16BFrUSJGw1edG2pMOJoX2By877JmRgMRrV+cerD90ETGeMhpr0JgJI95z
	 P+eD1LWd33sML7Otg290UVJi68J8oQoOu1A5Pr3Ypc2rkj0TMZHsPwZ09BE+M3zlE8
	 la56hPMjZQW4Q==
Message-ID: <sashiko-outbox-194143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: Add attach option for light
 skeleton generation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261102201356.5798-5-mahe.tardy@gmail.com>
References: <20261102201356.5798-1-mahe.tardy@gmail.com>
 <20261102201356.5798-5-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:41:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpftool: bash completion suggests attach after name in _bpftool()
--

commit f5b94ca511f36c96410ef0757d692a7a6f4ea1cf
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpftool: Add attach option for light skeleton generation

This commit adds an optional attach keyword to bpftool gen skeleton when
generating light skeletons with the loader backend (-L), passing the request
through gen_loader_opts.gen_attach and updating the generated attach and
detach helpers, documentation, and bash completion.

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftoo=
l/bash-completion/bpftool
> index a28af31937ad4..9247a9fdcaef9 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1021,7 +1021,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          *)
> -                            _bpftool_once_attr 'name'
> +                            _bpftool_once_attr 'name attach'

[Severity: Low]
In _bpftool() under the gen -> skeleton case:

                skeleton)
                    case $prev in
                        $command)
                            _filedir
                            return 0
                            ;;
                        *)
                            _bpftool_once_attr 'name attach'
                            return 0
                            ;;
                    esac

When a user types "bpftool gen skeleton <file> name <TAB>", $prev is "name"
and falls through to the wildcard branch. Because "name" is already on the
command line and "attach" is not, won't _bpftool_once_attr 'name attach'
autocomplete "attach" as the object name argument to "name"?

Should there be a "name) return 0 ;;" case before the wildcard branch so
that completion does not suggest "attach" when expecting the user-supplied
object name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102201356.5798=
-1-mahe.tardy@gmail.com?part=3D4
