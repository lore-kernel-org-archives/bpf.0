Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55823A99F
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777227457; cv=none; b=OQxfo6jjrO8pfVRlEV85+VddGEE0A4bror1lP5gm+RMPYVl6hNjNAlYklv5TlnzIfG27emnS8p6RfFxv1IiwDp/3JOhxxv1vlNKNodhBQn0CYpIFwm/MkYUTxc7udfD1sQxk366SOFsn9qZmX1cF2gLewu5RTOToMU3Hh2bLRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777227457; c=relaxed/simple;
	bh=0Gr/AarqaF+Nm0b0VHaFj427YWmkFsMpsrdwf1V61go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oxdfzel+PXk+EO9tGLZFamYzwMnPoqjxhcs2a23+noxH0e4flO1sdApYNfZq0pwj+HGDZHiIPlFJjQkhjK56cskFx7kkhUoojkgs3hfdY89PHph9YtAwnO1KZeYzgvlSN5qyKWY1dirhHdKvQDrZDjlRLzaLDmRspkSZD5BGgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6lhEbOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6lhEbOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794BCC2BCAF;
	Sun, 26 Apr 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777227456;
	bh=0Gr/AarqaF+Nm0b0VHaFj427YWmkFsMpsrdwf1V61go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a6lhEbOrP8qrz7NduZB7KlsWAQ/f9hUrINHkHhjmqUfYXxCrzAkjY9C25w1a+9U7X
	 viLdCoUyypJf+u7wTmAUHdVyUgx1ygHc5sOWKaIwcynoS6q/btgSAuW4fQlHy+ok82
	 6HNH3kXFNO+3uavpGohxRXU3bpqz+KFH/fjKsN5HLoxTaA39ycBpS8FzE+tLXHm4ho
	 Mv2GL3AVkLuWjK7V554tJIuQapjmX+EOf6YPD6s8/W+9KZApZUjW6K3XxvuSYV4dJh
	 X2mg9fPpBNUfgg239jIGOZHBpsmhN7E4yXjgvBVsnsJEKb/lz9bOGvHB16HpUB+g6N
	 T1lFIMiuyxt0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena
 direct-value access
Reply-To: sashiko@lists.linux.dev
To: "Junyoung Jang" <graypanda.inzag@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
References: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Apr 2026 18:17:35 +0000
Message-Id: <20260426181736.794BCC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Data race and bounds check bypass in arena_map_direct_value_addr=
() due to lockless reads
--

commit a9b5d3016475abf10be02a320dc627c95b306d92
Author: Junyoung Jang <graypanda.inzag@gmail.com>

bpf: Fix off-by-one boundary validation in arena direct-value access

This commit fixes an off-by-one error in the arena map boundary check
where offsets exactly at the end of the mapping were incorrectly accepted.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 802656c6fd3c..49a8f7b1beef 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struct b=
pf_map *map, u64 *imm, u32
>  {
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> =20
> -	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
> +	if ((u64)off >=3D arena->user_vm_end - arena->user_vm_start)

Could this evaluation be vulnerable to a data race?

This function reads arena->user_vm_end and arena->user_vm_start without
holding arena->lock or using READ_ONCE().

Concurrently, a user-space process calling mmap() on the arena map FD
can invoke arena_map_mmap(), which updates these fields under arena->lock.
Because user_vm_start is updated first, a concurrent reader here might
observe the new user_vm_start (a high address) and the old user_vm_end
(which might be 0).

In that scenario, arena->user_vm_end - arena->user_vm_start would
underflow to a large 64-bit value, which would allow arbitrary offsets
to bypass this bounds check.

Does this logic require synchronization or READ_ONCE() annotations to
ensure the verifier's boundary validation remains effective?

>  		return -ERANGE;
>  	*imm =3D (unsigned long)arena->user_vm_start;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260426172505.1947=
915-1-graypanda.inzag@gmail.com?part=3D1
