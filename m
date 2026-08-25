Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB3541A8F;
	Tue, 25 Aug 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674893; cv=none; b=s5Cku0quQzDN/eDBOop3+KfJFiTHBdXUtz1UpLqphoW0Gd1fLwWfQop3nsyPh1RuV4LrMjpV+Q3ENIypqzxIP/VYSSFq2BJiI4eA2Hg4qZIMLcR6d0mdBbDm5MEXnqWBp8A27mb2gMW5emyddeJtjVkU9oV/2thxRMylLtXgbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674893; c=relaxed/simple;
	bh=clERYCIS6groPkZRJaU4BKs2iWmTqbzVTorVPwgBYj0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=j5F+medlnfwSYbzA1eZvYpm6VEIyHpyyLA8i5597jlCIEirxfLZJeD/o5rDhn0JwYGpHuYfmZs7t9HZQn2uGwkHdhs743oMXS0aSy9OCBuaLg7K9hS54oeMlsFaNAVQSiATKawd3kXlYnL2Mn0EzxaBa+PL0yh4Cr258MMqv8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTg9kIFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTg9kIFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A1D1F000E9;
	Tue, 25 Aug 2026 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787674891;
	bh=vR7nDKAqpDVijosQMKINm9SJwa8xLdCYsoMVgCDX+aA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PTg9kIFxyOz+XmnNOfx/u9htnV9LAdivK6mB1hOtmTw9d0rkdAXUe5vEGIITEQsuy
	 hr8YjXqzr5j+QFsMgOO4TeGbiD5bGNk14oJmEVTDmIOY5dTMrOCFbhZ1yvR4KSEpkE
	 FXUV0RycZve+u7g/3LYrgPUhK8KAxcCQpCPYJe4ViGoXOnb6itgP0i2q/UZ0ke0E9S
	 J5v1UZ9Cu83nGnVggGQxbcu5/bImVBwUs9Aa5VpMG42ZA53pjUScmZjg8uRKqb+FaR
	 WD5uD4KwzUSAFLkA0E8eNr7pcJ8m5SyZ5LT7dRvlL5nVRzQTopSk3MxqUa95HGl3hR
	 G0KDYzwoUFO3g==
Content-Type: multipart/mixed; boundary="===============2599008689546417396=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <928bcf2c81a02eb3f44dcc84e978a13e7d7e65a650692e5a83ed48231960a2ff@mail.kernel.org>
In-Reply-To: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
References: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk_bind
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,kuba@kernel.org,pabeni@redhat.com,syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com,ahemadkhawar123@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 16:21:31 +0000 (UTC)

--===============2599008689546417396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git net/xdp/xsk.c net/xdp/xsk.c
> index 7855ee09c4b6..d2fbbeb7b6d7 100644
> --- net/xdp/xsk.c
> +++ net/xdp/xsk.c
> @@ -1612,19 +1612,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  		return -EINVAL;
>
>  	rtnl_lock();
> -	mutex_lock(&xs->mutex);
> -	if (xs->state != XSK_READY) {
> -		err = -EBUSY;
> -		goto out_release;
> -	}
> -
>  	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
>  	if (!dev) {
>  		err = -ENODEV;
> -		goto out_release;
> +		goto out_rtnl_unlock;
>  	}
>
>  	netdev_lock_ops(dev);
> +	mutex_lock(&xs->mutex);
> +	if (xs->state != XSK_READY) {
> +		err = -EBUSY;
> +		goto out_unlock;
> +	}

Does this reordering change the errno precedence userspace sees?

Before the patch, bind() on an already-bound socket (state != XSK_READY)
returned -EBUSY regardless of whether the ifindex was valid. After the
patch, the same call returns -ENODEV if the ifindex lookup fails, because
dev_get_by_index() is now checked before the state test.

If preserving the -EBUSY precedence matters for userspace compatibility,
would the state check need to stay ahead of dev_get_by_index()?

[ ... ]

> @@ -1771,9 +1770,9 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  		smp_wmb();
>  		WRITE_ONCE(xs->state, XSK_BOUND);
>  	}
> -	netdev_unlock_ops(dev);
> -out_release:
>  	mutex_unlock(&xs->mutex);
> +	netdev_unlock_ops(dev);
> +out_rtnl_unlock:
>  	rtnl_unlock();
>  	return err;
>  }

Looking at the commit message:

>     Fixes: 978939c08db1 ("xsk: use netdev_lock_ops in xsk_bind")

The Fixes tag references commit 978939c08db1, but this commit does not exist
in this repository. Running git log and searching lore shows no commit with
this SHA or subject line. The tag appears to be fabricated.

The buggy locking pattern was actually introduced in commit 975b11ae9077
when net/xdp/xsk.c was first added to this repository. Should the Fixes
tag reference that commit instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32867683423
--===============2599008689546417396==--
