Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CC3D9DC0
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052178; cv=none; b=Gdp0bBOsVFxNiWtZ9yp5e+3O/ppieSNo+IMZkxRKKuCGjo0FD5W01IAzYTWBBGlN0r3+aMh4aa00exBl791j61+6cfpcK3EpOS+AemKvx+gNE34ujo6sS0h2jDti4CstcJPHCu25NFpKrQQyXpethoA7ZSvY5MggkqxDHhjKdRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052178; c=relaxed/simple;
	bh=0//h7A+2g2GeDq5XSlBNPKdMBQZUIIXa4ia/PLcFues=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=on9zm5cOycc5wHSekxEIand1lhwciHg97uu8g6mEid1VwVL4U1A63abNv9O/54IXFCcoh4HIWDIdEG9N0MH7V3GEbIzE2U0NEeszrCPiG9dSJOQ/l36nL29+8nFfA+CVunW9+7cUCfhIcnR/EECpIGlglInF5Mi7iThxGESnM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE8NFqiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE8NFqiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A711F000E9;
	Thu,  6 Aug 2026 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786052177;
	bh=L4ZOhEFErme37d77xlWfmaXESCtQYI1jjt5ZlgM8EmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cE8NFqivXHt5qYZtUJmHmVFG9i3G6jNXcYn9RkSY3c7bcXU68IH/O8Lxw7dEZldsS
	 mdiq8N2d9axKcfjvddUftLzhMQXm7v11EJ1WG0YxqlHYIW1GTFeP0wUeVi0JBgZ2Jb
	 HNya4acTf3w/q/tZ5PTNIHro7XDLOVCaaHGP8AH8Ftp0RjDVqvoueewkcK9HMzKtMt
	 8rjCLBIqpbuDB4P4vvdziVauqi61HxGRuTzKjUKHHqA4GpgyX+lO6ckWQT9v8gkv3y
	 rN22Txei0mE6ZNc6wFF809GPqXvI0S7uYS4UgJy0mD32vYxDcCrrvzlmILWSV5HTaR
	 7zkYtcO2cAorQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 10/15] i40e: prepare for XDP metadata ops
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805213541.2281287-11-anthony.l.nguyen@intel.com>
References: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
 <20260805213541.2281287-11-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:36:16 +0000
Message-Id: <20260806213617.56A711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free in the AF_XDP Zero-Copy receive path due to sta=
gnant index variable on error.
--

--- Patch [10]: [PATCH net-next 10/15] i40e: prepare for XDP metadata ops s=
upport ---
commit cf380b8d06da010c94723db1eb6af6df8fb0fdc8
Author: Kohei Enju <kohei@enjuk.jp>

i40e: prepare for XDP metadata ops support

This commit introduces struct i40e_xdp_buff to wrap an xdp_buff alongside
a pointer to an i40e_rx_desc. It passes the RX descriptor to XDP kfuncs
and adds bounds checking in the AF_XDP Zero-Copy path using
XSK_CHECK_PRIV_TYPE.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/eth=
ernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba53..51a05ce4c7ce8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c

[ ... ]

> @@ -472,6 +482,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, i=
nt budget)
>  		if (i40e_is_non_eop(rx_ring, rx_desc))
>  			continue;
> =20
> +		xsk_buff_to_i40e_ctx(first)->desc =3D rx_desc;
> +

[Severity: Critical]
This is a pre-existing issue, but does this function have a use-after-free
in its error handling path?

If xsk_buff_add_frag() fails earlier in the loop, it calls
xsk_buff_free(first) and breaks out of the loop without advancing
next_to_clean:

    if (!first)
        first =3D bi;
    else if (!xsk_buff_add_frag(first, bi)) {
        xsk_buff_free(first);
        break;
    }

On the subsequent NAPI poll, because next_to_process !=3D next_to_clean,
the code loads the freed buffer pointer from the stale next_to_clean
index:

    if (next_to_process !=3D next_to_clean)
        first =3D *i40e_rx_bi(rx_ring, next_to_clean);

Could this cause the next packet to be built using a freed buffer?

>  		xdp_res =3D i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>  		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
>  					  &rx_bytes, xdp_res, &failure);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805213541.2281=
287-1-anthony.l.nguyen@intel.com?part=3D10
