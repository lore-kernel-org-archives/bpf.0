Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794653242;
	b=mczozm5CDRkNjLjMK06YsTpw6W/eSvl7gefZQaDPzMhZ9SGDUFpTJyFJUc/9/LBHUAz1
	 b+PygOmcSNfX2OAXaX2YuEUdxOgyR0NPrX+lJrzVpNhKude+DPX8bQdPCJowXVq8FJlmb
	 OLxvNx274r6S9ai/fHhUcfI3BZASPBEgf2Zc/QmuaEDaXtJaSs5b8hUg/WfME+QasNTWw
	 2PtORRl7kcRTt9m7NsMiv7GRBxs+D6vln9ETSa3wZg/7VFPQxi2I+j9dt8Geq+z7G8QZQ
	 Xc2Zm5uT1kkdJ8mjVwpI9rjDgOQHaSs0jQgpm9pOiaqFG/5vpjhOQi0jtmT7+vMnuWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794653242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=damD+a6ATypVAnXYglYV6le4AUcHLkfIShEa6x0MyLQ=;
	b=43yEQu7PkanhkQBh8fXdhDgsPzXJBrQeBBJDEWBV6Va5kfWRffiAUhYLasGErIvao1Dm
	 DtDeb7cckv/Ss6lQmQk258tFoTIPNuaKrhA5+5ISrdSrEpFgv98hGgx/fNyozuUxcvZuK
	 MyVl2Mq91nCkSs9i6RiAweH+bRtlFnqvxX36WGyFSMrQos+c5mDCmlpu1shKz5e7x0XST
	 AhRY374Evvg/iYE2BEbluvjaUKA505v5zPh+2e2am0+/I+4Y2jeQxlY86VqZGP+hnIC5B
	 9l35akWAcK5dkvyCN/ApMiZAHrnPJgWdGaCdRWEFzDUYb9rA+lVEiWkILKtFHPXhDSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl7HZO6P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB460606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl7HZO6P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3684D1F000C4;
	Sat, 14 Nov 2026 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653242;
	bh=damD+a6ATypVAnXYglYV6le4AUcHLkfIShEa6x0MyLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gl7HZO6PYA/o6XLzx84VfUbayEMmy+QQsn2KHGas/uJ9tQEJB2SjJRkgVHlTJvVbY
	 4s+16uuvVfutxzH8NfN3C17Q6VC1EA28MV8fvbi5maelajsyYPl/syC6bGn/MUh/p1
	 yXwfnFbI0tteM0UJTITYRHFfOk7zty9IL4qgwMYvWMMArTuIBfplHQkiYsAFK/e6Sl
	 MFpdGnvh3xhvS9A5Xq1sTSSAWNE8vBdMQUmqCMD6AGM435bYCKpgHo+U2sB9zqNcar
	 0BG08MC7m3qK50r4VujUBh3+vPuxCKwmS9JpEHkeUMQfJrl1D/OBKTl7fNYk/gx34k
	 oDxlVA0Q0hv4Q==
Message-ID: <sashiko-outbox-214363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] veth: wake a stopped peer txq beyond
 real_num_tx_queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
 <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 10:47:21 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] veth: Fixes trailer cites dc82a33297fc instead of 08f566e8f83b
--

commit 4511ff49371a3a9f93211f5b51b7a6404ecb1f22
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

> veth: wake a stopped peer txq beyond real_num_tx_queues
>
> Since commit dc82a33297fc ("veth: apply qdisc backpressure on full
> ptr_ring to reduce TX drops"), only the peer's veth_poll() wakes a txq
> that veth_xmit() stopped on a full ptr_ring. veth_poll() skips txqs at
> or above the peer's real_num_tx_queues.
>
> If the peer shrinks its TX channels while such a txq is stopped, nothing
> wakes it. netif_set_real_num_tx_queues() keeps its state, so once the
> channels are grown back, its first skb is requeued forever. With a single
> root qdisc this blocks all transmission of the device.
>
> Look the txq up below num_tx_queues instead. Waking a txq that is not in
> use is harmless.
>
> Reproduced in virtme-ng with a UDP flood from veth0 into veth1, which has
> GRO, while switching veth0 between one and two TX channels: without this
> patch veth0 stopped transmitting within 11 cycles in 3 of 3 runs, with
> it veth0 kept transmitting through 30 cycles in 3 of 3 runs.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

[Severity: Low]
Should the Fixes: tag reference 08f566e8f83b ("veth: fix OOB txq access
in veth_poll() with asymmetric queue counts") instead?

Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
reduce TX drops") looked up peer_txq unconditionally via
netdev_get_tx_queue(peer_dev, queue_idx).  The queue_idx <
peer_dev->real_num_tx_queues check that skips txqs above
real_num_tx_queues in veth_poll() was introduced in 08f566e8f83b ("veth:
fix OOB txq access in veth_poll() with asymmetric queue counts").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113104648.2259=
83-1-simon.schippers@tu-dortmund.de?part=3D1
