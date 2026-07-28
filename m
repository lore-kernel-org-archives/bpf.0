Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D1374E5B
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255643; cv=none; b=Somn9eRAdxrlMU4OzTMsDTx6Usdg52i5YAKlVUfMvoensYLfE3PopoN4GGttbOFc/bqq7G9EcIsbD/VuJO1VlXpPdAzKDYz6Z2vDmFakjgVwGlYfMNr3JS9NkVJJaW8ITHmO2rg/nvXCB+FnZnbTgBP8f3KHjoO3PqXSmAZdQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255643; c=relaxed/simple;
	bh=RriGHHk8QHelciQ80YHU9tP7USX/sL7Y3Z/cFcuJ7So=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xo/wU9+W5WS9KRcdy6YP4NMkFkjtFLZhEP2Ua/ES7FTYIqNr8g4d4+kY3wQ5tB+BnMMbrnNyJveRA91bc9zLuTPSX0NRX1602Vvirs0K+3DlQfrT8/SaZnFrM/gS13+3RJCHdflkuUTh2U9kKapHCLqEMCFI5Ba9B60AcfiHYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idFFK56d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idFFK56d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE01F000E9;
	Tue, 28 Jul 2026 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255642;
	bh=MVbF1oKCjziOwqJXfddlVZjOs0HeJtsThRna7R6p0oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idFFK56dUDhmiIW/iOZOb5b3CTE9VMHcZFbUeJdfjay2NRAn78HKEqA0WHqjz8o5u
	 U2eaXyz7FbXWVIxVMp+RPEtgvfIaH+RF9GrP17omvPCatLWOa2tYv+7ELPivur74RI
	 maiRUtJ0padz5v9FxidTv0X3VwZ1hZkRakj683McMpTH//q4fIefroqE40xR86fYj6
	 ox+sEhAMnMKat9ljfx3iM7W3NplAbHK+ze9R9w2XDsp5iDspEoaZULFIKsQq+61lTm
	 rsrp1e7V7qzLEew01ppTR9aH6gbg+gARgqoLmx8QVPhVjDB68fv0sFqWOikjd+wI7Y
	 ygV/pYG0Ias2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/6] xsk: pass TX metadata pointer by reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727161959.885642-3-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-3-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:20:41 +0000
Message-Id: <20260728162042.27EE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `xsk_tx_metadata_to_compl()` returns early when `meta =3D=3D N=
ULL` without clearing the `compl` output structure, leading to arbitrary ke=
rnel memory writes during TX completion.
--

--- Patch [2]: [PATCH net 2/6] xsk: pass TX metadata pointer by reference -=
--
commit 83fcec7a0c0075ec991849b8d99f6d6cd083c335
Author: Stanislav Fomichev <sdf.kernel@gmail.com>

xsk: pass TX metadata pointer by reference

Completion handling needs to know whether a timestamp was requested when
the metadata was processed. Let xsk_tx_metadata_request() update the
caller's metadata pointer so that decision can be carried forward without
rereading user-controlled flags.

[ ... ]

> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 8b51876efbed1..06c081feff42d 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -153,17 +153,19 @@ static inline void xsk_tx_metadata_to_compl(struct =
xsk_tx_metadata *meta,

[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed that=20
xsk_tx_metadata_to_compl() returns early without explicitly clearing the=20
compl structure when meta is NULL:

static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
                                            struct xsk_tx_metadata_compl *c=
ompl)
{
        if (!meta)
                return;

In drivers like mlx5e_xsk_tx(), compl is declared on the stack and passed i=
n=20
uninitialized:

mlx5e_xsk_tx() {
        if (xp_tx_metadata_enabled(sq->xsk_pool)) {
                struct xsk_tx_metadata_compl compl;

                xsk_tx_metadata_to_compl(meta, &compl);
                ...
                mlx5e_xdpi_fifo_push(..., { .xsk_meta =3D compl });
        }
}

If an untrusted user sends a packet with invalid flags, causing meta to be=
=20
NULL, could the uninitialized stack garbage in compl be pushed to the NAPI =
TX=20
completion FIFO? Would this cause the completion path to dereference a garb=
age=20
pointer and write a hardware timestamp to arbitrary kernel memory?

Similarly, in stmmac_xdp_xmit_zc():

stmmac_xdp_xmit_zc() {
        ...
        xsk_tx_metadata_to_compl(meta,
                                 &tx_q->tx_skbuff_dma[entry].xsk_meta);
}

Could this early return leave a stale pointer from a previous packet in the=
=20
descriptor ring, leading to an accidental overwrite of userspace UMEM?

>  /**
>   *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
> - *  @meta: pointer to AF_XDP metadata area
> + *  @pmeta: pointer to pointer to AF_XDP metadata area

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161959.8856=
42-1-sdf@fomichev.me?part=3D2
