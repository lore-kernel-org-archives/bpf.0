Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448328;
	b=UVKoCL2XTk/YmFs/w27qWNjzEtvv/fJgh+hsU2On+2pMqomECHAuRN96O03MznijHBct
	 NwXj2qAE9v2YfLwKMwVh7/670ctaKi0t01cwZXXuPQpbiKOH8C6cq0fW0K43iWaEtiCUZ
	 EOHe6J+ipdELoMKeD0jSiWBebvaM9isk7uGTRtmGgzZT7PLmDDoZiIiWzDfbApiFQiQyM
	 Du9ffuQGVDlkyjHKRCblwJJOWKexRdTEZ+5rvASpo+W9ZwoXrsYLlNAR5amHVfhItCXB9
	 h+vqZ2CtPbhnxQW83WyqHfFKIbD071AHe2Bfggk2bZr3xUAUd6A7oACfEgqesY56LVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448328;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+X5nQctZfjuCagT5X1YCMQN83cSSzFpr4WZl4ytKKU=;
	b=N7vCJUI+kOkmlr8NwiOsfHoKdS6RTucl/Fi8lRer4EOVFGbMFoJAenP4Nfy3HPMjYsp8
	 qXf+wjicHBAxgzwjxxzOQHUNI5KQuMln7U/K9Q9flcG4/mNsx6cbQ7z1aZ92UobuK18nH
	 f6WTwRt1+MCbzn990Z8VNNp/chKjJeq+XrxMOiNeO/ghiO+95YuPWM5mUy5ubSsQg48JH
	 Fps0oKlRJwjBwfz7SYQkbxxTqept+a/VNmMnOSNI1QTaxX9OsiOk0Qh25KfWK1sRU2A+2
	 uGEPjtadVkm/9i6mUABIc90h9zJnivMFFP5jIUwpc4fCQjqyHyasiQ3/QMWToWkRzOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PqW/s6MP";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C010606A31A;
	Mon, 23 Nov 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqW/s6MP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD9A1F000C6;
	Mon, 23 Nov 2026 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448327;
	bh=5+X5nQctZfjuCagT5X1YCMQN83cSSzFpr4WZl4ytKKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqW/s6MPKvEqPXmL4DOmTtx8aVsCX6kDD/Zo5HwWfu4HovzEPk4iBUQqQj5XNdX/N
	 87HUiKQbPdtjPWVB+ZHsWRqKnJSYu/WcfhE1H9pONNg2qI9wkZYVgavpSDfQsHvDAI
	 gjiJEnATI32bCTM7QDktvNE3ldtK69q2cfP4np8ykeEaHOSC8/Ey2/ASO9lsrjlvWM
	 PIUWn8iRCj3YVY9RPtTs+GX18xfibSmo8krZ2qFXYwvd1km4YggT/UpKV2mXwWhG/P
	 itu/Y/m8l0Qjf3gFYzFpEk6HZRnIB93nyC+QZFLReWg88H7bAonvbgDVqTuFpP/oRL
	 4s4pebocVDbEw==
Message-ID: <sashiko-outbox-229589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Add log support for tracing
 link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261123152743.19629-2-leon.hwang@linux.dev>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <20261123152743.19629-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:38:47 +0000
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
- [Low] bpf: non-UAPI field name tgt_fd logged in
  bpf_tracing_prog_attach()
--

commit 476f541041ef9d87251f0598129c4def280d1320
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Add log support for tracing link_create

This commit adds verifier log reporting to tracing BPF_LINK_CREATE for
attach parameter validation, reattachment checks, and target compatibility
checks in bpf_check_attach_target().

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ec8e787929112..80504011403f6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3677,7 +3677,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>  				   int tgt_prog_fd,
>  				   u32 btf_id,
>  				   u64 bpf_cookie,
> -				   enum bpf_attach_type attach_type)
> +				   enum bpf_attach_type attach_type,
> +				   struct bpf_verifier_log *log)
>  {
>  	struct bpf_link_primer link_primer;
>  	struct bpf_prog *tgt_prog =3D NULL;
> @@ -3714,6 +3715,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog =
*prog,
>  	}
> =20
>  	if (!!tgt_prog_fd !=3D !!btf_id) {
> +		bpf_log(log, "target_fd and target_btf_id must be both set or both uns=
et.\n");
>  		err =3D -EINVAL;
>  		goto out_put_prog;
>  	}
> @@ -3726,12 +3728,14 @@ static int bpf_tracing_prog_attach(struct bpf_pro=
g *prog,
>  		 * attach_tracing_prog flag is set.
>  		 */
>  		if (prog->type !=3D BPF_PROG_TYPE_EXT) {
> +			bpf_log(log, "target_fd is only allowed for freplace prog.\n");
>  			err =3D -EINVAL;
>  			goto out_put_prog;
>  		}
> =20
>  		tgt_prog =3D bpf_prog_get(tgt_prog_fd);
>  		if (IS_ERR(tgt_prog)) {
> +			bpf_log(log, "Invalid tgt_fd.\n");

[Severity: Low]
As reported by Alexei Starovoitov on v2 [1], should this log "Invalid
target_fd.\n" to match the link_create.target_fd UAPI field name used by
the other log messages in bpf_tracing_prog_attach()?

[1] https://lore.kernel.org/r/DMX8G01GB597.2KEEFI12YK9V0@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123152743.1962=
9-1-leon.hwang@linux.dev?part=3D1
