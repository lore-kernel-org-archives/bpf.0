Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521335;
	b=N8dWfAEjK6RWB8SjSIegNEqeEHzH8KXzgni+fMTRqzpGq8gCNKMiMSGQKI2yo9BC/ibj
	 2MwuILXosw7s+KRNqvhvMchrvrsZPpaQJcYfrWWtwYmHlVCFBk+9EnJ62mW0n01xEVqRl
	 93AovHTwri/cxwhV0DAbRTUxe1ynKsXaZo5x2GGMW4Mab7leTB/xFZf405XcLvsNzWM6P
	 ZJYevQNqY7S76NMVcckLaAB8yBVcKTpXJAPjwgp81ww4F+14hZAE2Xl+SZYiIL4ww1icf
	 iieEXeTjgf+AF8IV/kn4vpShNaWNWX2/v1C/Hh4yCB/2wS4HAG8XPsZDfHt2oQLMiwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YGPp6zSq8MECdgo+ymz9N6VomSbT1RJdER3RaOhHS6Q=;
	b=cFzBjOibHp/Vt39c2rvMNLILulr55cTmPzvSbKZIYq+DKDZ/UfO+hZTuHAin9NbtPi+b
	 J3PYFiSRGM0urQ9DvIYn/s3KGt63RV4QmynQ9qLwJDmj6+0CYH5LRxMN8zfC/erE937vn
	 jwZN+YU2mRlF9WiF/lpmQtCo7loc2Xu3eJJ5qpVj6qQrtoLrAXb4s2YDUOc/jbgvPEySg
	 riVRIQjQ+oeA7pumGpAWYDi3JBO+tshaoul7Txl5ZtCEzdRPMoRs2Pt4eYP3UvHMHHtlQ
	 YTkFfLdQINaNmWzrFr3AElgTFnpNuFpuF8nC15A73yl5MNGGKiEMTdOMje/35rC094w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B625Jpps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019C606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B625Jpps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC91F000C9;
	Tue, 20 Oct 2026 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521335;
	bh=YGPp6zSq8MECdgo+ymz9N6VomSbT1RJdER3RaOhHS6Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B625JppsAHACxS34xusrNQX0glS4gGoQo0Ab7k5d7jVrEdfFjE8SVFxFevpJaV0Qt
	 UyTw0gJsesRkWv56cjMekf+sOSYU1oPocq3XZukioiDNS6ru4OE52/0G3GjoJOjiQ6
	 MQer+6VXEtjNh8K4sVMNtnIiWAtlL6wNLS9HRtNwaTPJ9HGHNsMoQBbplRTTvaDK7u
	 0FZdhIQ2k0PXgFTk3F3nUL46MUsNtnbtbk8BJUoXM5tX6l1soNVJ1+SIqeU6uw4xCu
	 fvU1Qkm6MFyyAga4jy7OkDlM9CvCiAsvo/X3yqvJR/KIXI0T3yvWADhffuUQvVUfc+
	 Zp1xqe2y5S8YQ==
Message-ID: <sashiko-outbox-179485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/7] selftests/bpf: libarena: Handle NMI
 reentrancy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261020181900.6755-5-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
 <20261020181900.6755-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:35:34 +0000
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
- [Medium] selftests/bpf: buddy_free() overwrites error with deferred free =
status
--

commit 6b8ade1832d5b23360c4e6c8d75625a18af4fe8e
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Handle NMI reentrancy

This commit adds per-CPU reentrancy protection to the libarena buddy cache
and defers frees issued from NMI context onto an intrusive list when the
local cache cannot be used.

> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> index ce05e3e58ebae..85d670b8762bb 100644
> --- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c

[ ... ]

> @@ -1100,12 +1244,25 @@ __weak int buddy_free(struct buddy __arena *buddy=
, void __arena *addr)
>  	if (!ret)
>  		return 0;
> =20
> +	if (bpf_in_nmi()) {
> +		buddy_deferred_free_start(buddy, addr);
> +		return 0;
> +	}
> +
>  	ret =3D buddy_lock(buddy, flags);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D buddy_free_unlocked(buddy, (u64)addr);
> =20
> +	/* Drain any frees stranded during an NMI. */
> +	if (unlikely(buddy_deferred_free_pending(buddy))) {
> +		ret =3D buddy_deferred_free_complete(buddy);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +out_unlock:
>  	buddy_unlock(buddy, flags);
> =20
>  	return ret;

[Severity: Medium]
In buddy_free() in tools/testing/selftests/bpf/libarena/src/buddy.bpf.c, if
buddy_free_unlocked(buddy, (u64)addr) fails (for example, returning -EINVAL
on an unaligned or invalid address) while buddy_deferred_free_pending(buddy)
is true, calling buddy_deferred_free_complete(buddy) unconditionally
overwrites ret. If draining the deferred list succeeds, ret is set to 0 and
the error from buddy_free_unlocked() is lost.

Also, the goto out_unlock statement jumps directly to the immediately
adjacent out_unlock label.

Should buddy_free() preserve any error from buddy_free_unlocked() in the
same way buddy_free_bulk() does:

	if (unlikely(buddy_deferred_free_pending(buddy))) {
		err =3D buddy_deferred_free_complete(buddy);
		ret =3D ret ?: err;
	}

and drop the redundant out_unlock label?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181900.6755=
-1-emil@etsalapatis.com?part=3D4
