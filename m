Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392571;
	b=Zr5OtjGycCV4HIxSHBCq+14XDfZCGo3soDVZP4rt/SQBCtzLI5Fp+PqymbpBhBAWo4lZ
	 kR6FfVv7EqJwTB045hSgKtTEsrjKp0Lbv+15tuDnHpUeTH8PdVNHlpDKM7+4c/qR0C+su
	 SeZJFYj48x5GH0zfxWd0gTXRQk1wMlk6PzdwvLuM47RFQc4GnqOZwmoo5Krzi/fgdQhW4
	 Fgc6ZzwzHCjAf8QidtlEE8XsgQPa91nVWyb1eHtaZULPiRvlFOKvM0hnBv5nlLwZ5NUy1
	 Gr/QdQQWqdGg5KsnS0+BoEN1Osy03U1lFY+R79ISpEqIrm+s0C0HS2NpXH+18o51+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kbeAuwIW5ME/Hs5xII2lumTPBJynIuWfT9t5dT98Jf4=;
	b=Vd7GyCNo6YYJDtIZhdrXUGIouBkCFExA0J24t7c29cJOtXe3Tf/Zx38+6ajQ3pU1rgUP
	 iGfeoAUtLVxL1dBGDQLZH+8VXE74vr2JePcxhbcmFcoTW9/uJG9gqN4lEeDPUMB17Y9hy
	 heL9x/XcGtf7cnwTouL8vozU7lfNrmQMqmWShpPQslgEPlD04OisQ2NbrWLpyLT/sVXdt
	 kcieR4TM7T1F9qSFxtYGXnWSo0vULyMw0cF/FUbTeH8rOPUGs+aag4U9KaNx3luaDgBEA
	 kx0YGQLxS1Gb11pFwn7iXee9vCE8gN0z9T/Xwr4vHrMBYxpruLDbfD6Cm/saNqhY0qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYiGiHq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E6606A332
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYiGiHq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E14A1F00A07;
	Wed, 11 Nov 2026 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392571;
	bh=kbeAuwIW5ME/Hs5xII2lumTPBJynIuWfT9t5dT98Jf4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kYiGiHq7nV9pLiYtXBP7ZH5gBypNr1wpnLZup/rGF2O5X+Xui+efNzV4L7SKCFMx6
	 QQtGy1mbnpiWBIEGUCgxlSjI3GtPHX1gieiLnm0aWpBFxALoJ2PPLmU0xbNyxqzECP
	 LOc9TRt5QEDhBcVeSRJc6kPBNpO+q5Rh89p9y6QDjo0XtUrWYVbxWcHVVyGR2cyI6m
	 hJPURN3E853oHhC8HjNClXIBK7IRzw6lRiroYPnKnairdL8l6Uw8KmafsCoHaw+WlY
	 8Ijb+5EAaoRTzbnxaqAPwIYEDV3W5zUl02tDcV0ijojVZj7cSxyJPFmq7VkgN4rCHy
	 5fjNrNUaPJh0g==
Message-ID: <sashiko-outbox-208794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-12-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:51 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] eth: fbnic: wrong Rx queue index used for idle polling in
  fbnic_queue_stop() [1]
--

commit 94641017ff155e4aaace7b6d7179917c8e4199a7
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

eth: fbnic: Support AF_XDP page pool zero copy

This commit adds AF_XDP zero-copy support to fbnic using a page pool
memory provider shared between header and payload rings, and transmits
socket descriptors on the XDP TX ring during NAPI polling.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_txrx.c
> index d96c957d6fbad..c358003f053b6 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

[ ... ]
> @@ -3216,5 +3479,6 @@ const struct netdev_queue_mgmt_ops fbnic_queue_mgmt=
_ops =3D {
>  	.ndo_queue_stop		=3D fbnic_queue_stop,
>  	.ndo_default_qcfg	=3D fbnic_default_qcfg,
>  	.ndo_validate_qcfg	=3D fbnic_validate_qcfg,
> -	.supported_params	=3D QCFG_RX_PAGE_SIZE,
> +	.supported_params	=3D QCFG_RX_PAGE_SIZE | QCFG_RX_HEADROOM,
> +	.xsk_page_pool		=3D true,
>  };

[Severity: Critical]
This problem wasn't introduced by this patch, but does fbnic_queue_stop()
poll the wrong RX hardware queue index for idle state [1] when
stopping a non-zero RX queue (such as when binding an AF_XDP socket)?

drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:fbnic_queue_stop() {
	...
	for (t =3D 0; t < nv->txt_count + nv->rxt_count; t++) {
		err =3D fbnic_wait_queue_idle(fbn, t >=3D nv->txt_count,
					    nv->qt[t].sub0.q_idx);
		if (err)
			goto err_restart;
	}
	...
}

In fbnic_alloc_napi_vector(), RX queue triads initialize qt->sub0.q_idx to
0 and store rxq_idx in qt->cmpl.q_idx. Passing sub0.q_idx to
fbnic_wait_queue_idle() checks RX queue 0 instead of the target RX queue:
if queue 0 is idle while the target RX queue is still active,
fbnic_queue_stop() frees the active queue's resources while DMA is still in
flight, whereas if queue 0 is busy, stopping another RX queue can time out.

[1] https://sashiko.dev/#/bug/linux-197dd65d-fb9f-419a-afba-7621f586ae26

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D11
