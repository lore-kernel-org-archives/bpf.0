Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98F29A9E9
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608181; cv=none; b=ZLy0z4g1mZJTWIK5jKUmoYQZQQ3NyFwjBP44dDyCcrQ+TaExBeIa1ik7Dk2+2mP0IG40lv/b+xlNI78QPQUXhteEAReNBJSzSl28nNEuueK3mtGAVPX1Bgdi4rIgU2TSTmFie4ndGkwR4cg3dcb3b7zWR3QvpylWhkeEi++HGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608181; c=relaxed/simple;
	bh=iHVTMhtKeBA0iVmliuKMuCjgnBtZGNMd75vWTTWeflE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jaolDYuoD9CWCF/vOUWx7sTflng2GPRhVLzHpm+jSks7YmsL00PYBHLkbQ4eQxhUSvGfS2iPKFCSGDtNJeS5CQvJHouo6Ib016f2+YsZMtUohxAt/Nw7cNFhd6keybvQ/GA7jJ4rdJaR56vmi7a1WWvH2kJXkIwEN3Hkf9pwqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fifJZInx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fifJZInx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282FEC2BCB7;
	Fri,  1 May 2026 04:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608181;
	bh=iHVTMhtKeBA0iVmliuKMuCjgnBtZGNMd75vWTTWeflE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fifJZInx0b4AiRbGZRvLmL1nexF3NgofeYvITR6rhvaOuAvKQOiZk/NQnDbrLrJFc
	 a/esMWXLjAWtPq/3Y0W8PNM20CDfkvBXLwWYcJULY0GBCveKlv0bv/K9FcPi/RiKP6
	 1lYoeCtzHCAtqMx9Khh6jIlVwX96ycDFnWT1j1Dhu5Blx4LNakjFLTHgJ42bPs+fC/
	 hDVUsiS2TRKyHgXKKaNGuYZR9lxmlCwmdOFm5EguJlj06okGX4ykPfiYTQnzkNBmgy
	 eCC4yWwzeKXigna4G5mC1Ew6JgKMMChcv05t3HIeph9PLk+Z8QBaQ7JKkE3rmLFoP1
	 FWsH+G+iJxCtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] net: mana: remove double CQ cleanup in
 mana_create_rxq error path
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430035935.1859220-4-dipayanroy@linux.microsoft.com>
References: <20260430035935.1859220-4-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 04:03:00 +0000
Message-Id: <20260501040301.282FEC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized CQ ID in error path clobbers global `cq_table[0]`
- [High] Uninitialized `tx_object` handles in `mana_create_txq` error path =
destroy valid WQ object 0
--

commit fbbff2b6d2993ad6206b12c69d7d995282d02696
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

    net: mana: remove double CQ cleanup in mana_create_rxq error path

This commit removes a redundant mana_deinit_cq() call in the error path of
mana_create_rxq(). Previously, mana_destroy_rxq() was called first, which
already cleans up the CQ and frees the rxq structure. The subsequent
mana_deinit_cq() call caused a use-after-free by accessing the embedded
CQ from the already-freed structure.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index f2a6ea162dc3..9afc786b297a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2799,9 +2799,6 @@ static struct mana_rxq *mana_create_rxq(struct mana=
_port_context *apc,
> =20
>  	mana_destroy_rxq(apc, rxq, false);

This isn't a bug introduced by this commit, but while reviewing this error
path I noticed a pre-existing issue. Does this sequence clobber the global
cq_table[0]?

When mana_gd_create_mana_wq_cq() allocates a queue via kzalloc_obj(),
queue->id is initialized to 0.

The actual hardware queue ID is only assigned later when
mana_create_wq_obj() successfully completes.

If mana_create_wq_obj() fails in mana_create_rxq(), the error path calls:
mana_destroy_rxq() -> mana_deinit_cq() -> mana_gd_destroy_queue() ->
mana_gd_destroy_cq()

Inside mana_gd_destroy_cq(), it uses queue->id (which is still 0) to clear
the gc->cq_table[id] array entry:

mana_gd_destroy_cq() {
	u32 id =3D queue->id;
	...
	gc->cq_table[id] =3D NULL;
}

This unintentionally clobbers the cq_table entry for CQ 0, which is a
valid queue ID (e.g., belonging to the hardware control channel or
another active queue).

Could this lead to dropped completions for CQ 0 and potentially hang the
device? Should queue->id be explicitly initialized to INVALID_QUEUE_ID?

I also noticed a similar pre-existing issue in the mana_create_txq()
error path. Can this destroy valid WQ object 0?

In mana_create_txq(), apc->tx_qp is allocated using kzalloc_objs(), meaning
all tx_object fields initially default to 0.

The initialization loop sets tx_object =3D INVALID_MANA_HANDLE iteratively.

If queue creation fails midway (e.g., at i =3D 0), mana_create_txq() jumps =
to
the error path and calls mana_destroy_txq().

mana_destroy_txq() loops over all apc->num_queues and unconditionally calls
mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object).

For the queue indices that were not yet reached by the initialization loop,
tx_object remains 0. Because 0 is a valid hardware handle, this issues
spurious hardware requests to destroy WQ object 0 multiple times.

Could this inadvertently destroy an active queue belonging to another VF/PF
or the hardware control channel? Should all tx_object handles be initialized
to INVALID_MANA_HANDLE before the queue creation loop begins?

> -	if (cq)
> -		mana_deinit_cq(apc, cq);
> -
>  	return NULL;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430035935.1859=
220-1-dipayanroy@linux.microsoft.com?part=3D3
