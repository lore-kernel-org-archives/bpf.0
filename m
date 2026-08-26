Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BE476056
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762778; cv=none; b=Jb6j0gtQB3OKL1JbgxwBt+xEnT4rqnHKRTnJu2JypXvzlVAgJe2ivh/cFS9iJr9oeD7cvIMe2TNKckynDcMJ9l+Q3DRHp/RWg9xK100mP8sRoWFwQmL0lkOiCN/tH+tdAexm5A4M+lpGwzk7bBW2vRa9uhVnq4YhRtNEzXz8q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762778; c=relaxed/simple;
	bh=bAF997m1Q4UYCkRkH8igB3BVsXdWuX8JSilakcI9gP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMwZTHxuze5futI5cJxurXjpuIRyHF9WuJfvnjuWfpBiliq3FKRHy6AFzhADmrj0JvnMcXnzFOaYfZp1jWOcgqPDY+TcWCp9hRPZ8unoXqMi34sJ4+/1v+/AeMeT4b2Zs3dmQBj293YCeyNZ4+TtpwsfDFKbX9IdSdnDXPwlVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV2y843e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV2y843e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D261F000E9;
	Wed, 26 Aug 2026 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787762767;
	bh=yN+b7FAdCUNuDafsLBVLCbrcZBmWI/k1FhKiR+BtqZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YV2y843e3tG0gc877YLB6n45axGPabnRxT3WIsbfZ02QD/d216zkMVo2s7wIMjj23
	 QvoOW33mnHb7EkySgKdAY9en5wRkSSvdijCtfyTpIKd2Ttd8M6VDlvS6mtufiwZIfK
	 k8nKpLDsUKm2u4+at10MQh7Pmvu8ry5UN7CVGUXJRRLX83w/Az+0ESSI1cmI+SqkHI
	 jkXhfGYuWT3fxqA952C0BQD+/QVQk5d+FftYyRKzCfS3DIghtYcVBgtPRUH+9wDqoI
	 oEnVa7xNAd4YjaO7VvRIBaTNTl7phVdFSL6Xgq8oGDFx+vSf7vlDCo6Z9LO1JCCst7
	 aDGqjoVNRtF8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] xsk: Fix circular locking dependency in
 xsk_notifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
References: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:46:06 +0000
Message-Id: <20260826164606.E6D261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch fails to resolve the reported 3-lock circular dependency=
 and introduces a new direct AB-BA deadlock between `net->xdp.lock` and `ne=
tdev_lock_ops`.
--

commit c3270120d7443d72c4a80a4f3f94211cd288531b
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>

xsk: Fix circular locking dependency in xsk_notifier

This commit attempts to fix a syzbot-reported 3-lock circular dependency
involving &net->xdp.lock, &xs->mutex, and netdev_lock_ops(). It does so by
deferring the xp_clear_dev() call until after &xs->mutex is released.

Link: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gm=
ail.com/
Link: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..c2f47182dc489 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2106,6 +2106,7 @@ static int xsk_notifier(struct notifier_block *this,
>  		mutex_lock(&net->xdp.lock);
>  		sk_for_each(sk, &net->xdp.list) {
>  			struct xdp_sock *xs =3D xdp_sk(sk);
> +			struct xsk_buff_pool *pool =3D NULL;
> =20
>  			mutex_lock(&xs->mutex);
>  			if (xs->dev =3D=3D dev) {
> @@ -2113,12 +2114,16 @@ static int xsk_notifier(struct notifier_block *th=
is,
>  				if (!sock_flag(sk, SOCK_DEAD))
>  					sk_error_report(sk);
> =20
> +				pool =3D xs->pool;
>  				xsk_unbind_dev(xs);
> -
> -				/* Clear device references. */
> -				xp_clear_dev(xs->pool);
>  			}
>  			mutex_unlock(&xs->mutex);
> +
> +			/* Clear device references outside xs->mutex to avoid
> +			 * lock inversion with netdev_lock_ops().
> +			 */
> +			if (pool)
> +				xp_clear_dev(pool);
>  		}
>  		mutex_unlock(&net->xdp.lock);

[Severity: High]
Does this actually resolve the circular locking dependency, or does it
introduce a direct AB-BA deadlock?

The commit message notes that device unregistration establishes a dependency
from netdev_lock_ops to &net->xdp.lock.

By moving xp_clear_dev() (which acquires netdev_lock_ops()) outside of
xs->mutex, it is still being called while holding &net->xdp.lock in
xsk_notifier().

Doesn't this create a direct &net->xdp.lock -> netdev_lock_ops dependency?

Combined with the device unregistration dependency (netdev_lock_ops ->
&net->xdp.lock), won't this form a new 2-lock AB-BA deadlock?

Furthermore, does this actually break the original 3-lock cycle?

The patch claims to remove the &xs->mutex -> netdev_lock_ops dependency to
break the cycle.  However, doesn't this dependency still exist in xsk_bind(=
),
which calls netdev_lock_ops() while holding xs->mutex?

If so, it appears the original 3-lock cycle (via xsk_diag_dump, xsk_bind,
and device unregistration) remains unbroken by this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826162110.9987=
9-1-ahemadkhawar123@gmail.com?part=3D1
