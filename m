Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62933AFD16
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555901; cv=none; b=hh7fxKPLL50NZ5bgu6mlVGLBvvWdX/GGEy82jkNfEOS7ODFOoFwrqpsCck/A3WF7498hSjLrS5yD2hd+R7202OvHpcyeBoKXu9pjlHYopk4rOcX/e2kFH6g6XX4hwYrm6DM5GWdEKkVrSlvC5AmT+n10uUwDarsUIW7kmlvg0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555901; c=relaxed/simple;
	bh=xp7AcKu28PRtAybi1WcyPVM5mx4obBz4/kxu8TvMozc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1Z/rAGRTzEvA/F1s3j8g59t2b8gcLdRqTN6FV2D/X9HgwB+SSa7+k48YWD1ufo00gODDLfK5xOMeco3aRqtu3az1/xzw006yThle4m5ujcjZyui7d4gCBigwb5tvVs4MypSqqakEBy78pfox1EYmHR0O5OOisy49Cy6wKwIbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuRVqgZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuRVqgZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C71F000E9;
	Mon, 20 Jul 2026 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555900;
	bh=oAD00kc9rJ2hEkleDH0uD46YO+dOihpKh0ORjRmzHt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuRVqgZ2dc6gv22xfsWRvxhcu33IHwx/iXQu7HVog309rUWBEz/a3O15pj3x0MMXL
	 nfnkYwfjTq/hetMWCxObqoNHDcx34lI7dr2A6kK0cqIoUR6ngcDAHb2WC9h+oEI8OP
	 YpUBPQMna+0izGnblg1AyJd7HkcEr4F3HUCMX7Kttty/OH//wYiiyM+XDd6CxbTUqa
	 cbcXsSUDiLy+q8MuSOuSaBoidwOr6BRuqVaQEb5m/uS33+Kd+qTV0HGci2OyBgF5Ax
	 bfntS4L9fxPz9OL9hL+zo5/gYdUGGOOzzCGNn3WRxcaJW4CE94CN7te13fZyxJs6Xp
	 tB+tVi/j3TjmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net 2/6] xsk: drain continuation descs after overflow
 in xsk_build_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719135609.147823-3-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
 <20260719135609.147823-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:58:19 +0000
Message-Id: <20260720135820.2B5C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but rolling back a p=
artial multi-buffer packet via xskq_cons_cancel_n() on NETDEV_TX_BUSY corru=
pts the Tx ring because the consumer index may have already been prematurel=
y committed to user-space in a previous batch.
--

--- Patch [2]: [PATCH v4 net 2/6] xsk: drain continuation descs after overf=
low in xsk_build_skb() ---
commit ec981f427791ffa015b5a35518b1a57e2420d64d
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: drain continuation descs after overflow in xsk_build_skb()

Fixes generic xmit path multi-buffer logic when packets are oversized
or contain invalid descriptors. Introduces the xdp_sock::drain_cont flag
to continue consuming descriptors from the Tx ring and put them directly
onto Cq instead of silently losing them.

Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.=
org/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index a7a83dc4546a0..12a845d012f6f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1096,18 +1120,33 @@ static int __xsk_generic_xmit(struct sock *sk)

[ ... ]

>  out:
> -	if (sent_frame)
> +	if (xs->tx->cached_cons !=3D cached_cons)
>  		__xsk_tx_release(xs);

[Severity: High]
This isn't a bug introduced by this patch, but does this change to the
release condition expose a pre-existing issue where rolling back a partial
multi-buffer packet corrupts the Tx ring?

During multi-buffer packet assembly, if the max_batch limit is reached,
__xsk_generic_xmit() exits and commits the partially consumed descriptors
to ring->consumer. User-space observes this and may overwrite those slots.

On the next call to __xsk_generic_xmit(), packet assembly resumes. If
__dev_direct_xmit() subsequently returns NETDEV_TX_BUSY, the code calls
xskq_cons_cancel_n() to rewind the local cached_cons by the full packet
length:

	if (err =3D=3D NETDEV_TX_BUSY) {
		/* Tell MAC device to consume more and retry later. */
		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
		...

Because cached_cons is rewound by the full length (including fragments
consumed in the previous call), it becomes smaller than the cached_cons
saved at the start of this current call.

Will this new condition (xs->tx->cached_cons !=3D cached_cons) then evaluate
to true and commit the rewound index to the globally visible ring->consumer?

If ring->consumer jumps backwards, wouldn't the kernel fetch descriptors
that user-space may have already overwritten with new data upon retry?

> =20
>  	mutex_unlock(&xs->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719135609.1478=
23-1-maciej.fijalkowski@intel.com?part=3D2
