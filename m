Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133234676F
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308022; cv=none; b=IokDDL2fyb12slOFe+kIHEODrrPwq/FoHoeXAw433tGvdsnTKCUdihEKa3/9IQxcFgzWQGXP5P33dFsnAEsRavtNa2jfvBhmEKlWYRGsFAEXzufRorNy8VAozOwe4xHOFc+JXD2Tr0p2zgT7lMSuD0sG6gaKRsgUZSOwsn3R5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308022; c=relaxed/simple;
	bh=D4Wkavg4fZAwT8IsVxVVq+T8vdJiDUb39xcgu/0kqZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=be+F8KXQsKt2AGztWl6UulfgPX78qqLEQo02H1M5oDZnSwXWo4ZafsD5mo5GXBOmyNHszuH91R3peqRumnxCWczR18ShJ/GN4TCJPNh+aUWosQ6/8f/dg7O23Pb1nY5/90eNMcrLgSLt0IS37A1lJIiYckzjzdpF57f7vGLIDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbNxca+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbNxca+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9751F000E9;
	Wed, 24 Jun 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782308021;
	bh=Kjh81rz6XKEPd9FTVua6L5Mis1TBTVA8Kf2jx2DKNV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbNxca+dMzVEWe2roghW/tWWUX497YpFrGDyJPgul5mCsHqWG7V6RhEoCzSphZGS6
	 xGJxW7EFaeAY/61D8IQw/p9u8hFhi+Bs8ygWtZ5pt8zGW77aEut7UR6X4WHP+b5Kwz
	 Rp0HSMWdVuwZCNKrpQVMa3SJRXGI4mDDv61fbgtfgscXj0ReRRHgwOAH/Oyk3KW6ol
	 kK0lKvdGMGy4l4fCeZ4JuYcPh+/22XxsXMHXcfGIOg+67jesMEHpnOCr3qbaU+ceoT
	 QUbVZRH9w6L/V2dvKY2qN5iRshRE9oDjEAu9KIzOYBzE91LV1r6JMfY3pi6HO81wZ8
	 XKMBB4gchM5sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 7/7] selftests/xsk: account invalid multi-buffer Tx
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623133240.1048434-8-maciej.fijalkowski@intel.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-8-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:33:40 +0000
Message-Id: <20260624133341.0D9751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer leak in the generic (SKB) TX path when the first fragment o=
f an invalid AF_XDP multi-buffer packet is rejected.
--

commit aba0a0e03b19503a4e6b7748da982e4082aebe45
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests/xsk: account invalid multi-buffer Tx descriptors

This commit updates the af_xdp selftests to correctly account for invalid
middle fragments in multi-buffer tx packets. It ensures the whole invalid
packet is counted as outstanding in verbatim mode and appends explicit end
fragments to verify the kernel's drain logic.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> index de1e63c3fdf63..d8a1c0d40e5af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -2104,13 +2107,16 @@ int testapp_invalid_desc_mb(struct test_spec *tes=
t)
>  		{0, 0, 0, false, 0},
>  		/* Invalid address in the second frame */
>  		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> -		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{umem_sz * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
> +		{0, MIN_PKT_SIZE, 0, false, 0},

[Severity: High]
This isn't a regression introduced by this patch, but testing invalid
multi-buffer packets like this appears to expose a pre-existing buffer leak
in the generic (skb) tx path.

If an application sends a multi-buffer packet where the first fragment is
invalid (e.g. an out-of-bounds address), does __xsk_generic_xmit() in
net/xdp/xsk.c permanently leak the buffer?

In net/xdp/xsk.c:__xsk_generic_xmit():

        if (xskq_has_descs(xs->tx)) {
                bool reclaim_desc =3D xs->skb || xs->drain_cont;
                ...
                if (reclaim_desc)
                        xsk_cq_submit_addr_single_locked(xs->pool, &desc);

                xskq_cons_release(xs->tx);
                xs->drain_cont =3D xp_mb_desc(&desc);
        }

When the first fragment is invalid, xs->skb is null and xs->drain_cont is
false, making reclaim_desc evaluate to false.

The descriptor is then consumed from the tx ring via xskq_cons_release(), b=
ut
since it is never submitted to the completion queue, the buffer seems to be
permanently leaked, potentially leading to umem exhaustion.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623133240.1048=
434-1-maciej.fijalkowski@intel.com?part=3D7
