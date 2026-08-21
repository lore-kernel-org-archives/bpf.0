Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA56424D6C
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325439; cv=none; b=Pq+XAa6ZgLphlfhvrq01CQHAfPyFX96xcyaHB0DAKdgIMXwWgfyQa0qdSSyoph0JnewS7Rc31eZ3shNg1VUbfzU/l522W+ADsNWxQRywBq7QR6klgbLqyPeKXch1lwPNKwC+iNOdo0w1SyYS4Q//ncphDp0x8WgStpMBKAMnxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325439; c=relaxed/simple;
	bh=ThpaDSJUyscX+gZ0P5GSwxTh86mSrRmFDSneNtXt/XU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbauklcvlgFEgNHRFi4vNa5l0LbcLOYYGbHRPhVX+aVs3dt4oBDwB6UAALiYVMAWEp12re5jQUlfR+FTweyTSKO2zx32LuQMI3uPRihX71PcwFycqb+zvD8Lj1I2XAvgS5akk8/cu9RnuZjYH3zMWOdWHMRvayAAzmZ6U+zL+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mserXkUy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mserXkUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0C71F000E9;
	Fri, 21 Aug 2026 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787325438;
	bh=ZQGWBkgXvE5rT1xmCwBmvFjTVgC8vH/cXw3neStwZFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mserXkUyTWAu0q+94sulng+3B+BZ2rWz4hkmIMir2z5GuOgzvEEUnpT/GocJXG3Dg
	 6AETCYKP3Uo762scGT4AQSe4LpW8fUW/iYWYf+KS5oaMJPRTPn2EC0HCzOaqPfE2WA
	 NigUSFJjYjSgsjo3MGHNWU2gks21+ELgCF6lnFlvjZOBAgrFsMHv7mxHSvI4doNQbq
	 BxcjW9+HL6gJlolW5B9Aq/jRmRPY8sDLKqKdXg0VWQwVXonVrXAxfjZdDt0PVMxiX0
	 Pudo+tEphiAdlUCU8z6hUOqvItYclYbRylDn+ih9yO5ZCYA6MJOt+b3UY7Swb2xPEW
	 XxNqIzX583tLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/mlx5e: Prevent stale XSK buffer release on
 refill retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Tollet" <jtollet@cisco.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260820151558.11015-1-jtollet@cisco.com>
References: <20260820151558.11015-1-jtollet@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:17:17 +0000
Message-Id: <20260821151717.CE0C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix: Double Free in MPWQE path on XSK ring full
--

--- Patch [1]: [PATCH net v2] net/mlx5e: Prevent stale XSK buffer release o=
n refill retry ---
commit c24da150351198b044b52cb55d5ba341b752ae81
Author: Jerome Tollet <jtollet@cisco.com>

net/mlx5e: Prevent stale XSK buffer release on refill retry
   =20
When an XDP redirect to an AF_XDP socket fails because its RX ring is
full, the XSK core frees the buffer. During the subsequent batched refill
of a legacy cyclic RQ, mlx5e also releases the WQE's XSK buffer before
allocating a replacement. If that refill succeeds only partially, a WQE
left without a replacement retains its old buffer pointer.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 6fc6605d20549..7967a27372981 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -410,8 +410,11 @@ static inline void mlx5e_free_rx_wqe(struct mlx5e_rq=
 *rq,
> =20
>  static void mlx5e_xsk_free_rx_wqe(struct mlx5e_wqe_frag_info *wi)
>  {
> -	if (!(wi->flags & BIT(MLX5E_WQE_FRAG_SKIP_RELEASE)))
> -		xsk_buff_free(*wi->xskp);
> +	if (wi->flags & BIT(MLX5E_WQE_FRAG_SKIP_RELEASE))
> +		return;
> +
> +	xsk_buff_free(*wi->xskp);
> +	wi->flags |=3D BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does a similar double-free=20
vulnerability exist in the MPWQE path?

It looks like the same sequence of events can happen for multi-packet WQEs
when the XSK RX ring is full. In mlx5e_post_rx_mpwqes() (in en_rx.c):

mlx5e_post_rx_mpwqes() {
        ...
        mlx5e_free_rx_mpwqe();
        ...
        alloc_err =3D mlx5e_xsk_alloc_rx_mpwqe();
        if (unlikely(alloc_err)) {
                ...
                break;
        }
}

If mlx5e_xsk_alloc_rx_mpwqe() fails (e.g., returning -ENOMEM), it returns
without filling the skip_release_bitmap with 1s. This differs from the
standard mlx5e_alloc_rx_mpwqe() path which correctly calls bitmap_fill()
on error.

When the allocation fails, the loop breaks early and actual_wq_head is not
advanced.

On the next NAPI poll, won't mlx5e_post_rx_mpwqes() process this same WQE
head again? Since skip_release_bitmap is still 0, mlx5e_free_rx_mpwqe()
will execute xsk_buff_free() on the same pointers, causing a double-free.

Should mlx5e_xsk_alloc_rx_mpwqe() also fill the skip_release_bitmap on
error, or should mlx5e_free_rx_mpwqe() update the bitmap immediately after
freeing the buffers, similar to your fix here for the legacy cyclic RQ?

> =20
>  static void mlx5e_dealloc_rx_wqe(struct mlx5e_rq *rq, u16 ix)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820151558.1101=
5-1-jtollet@cisco.com?part=3D1
