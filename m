Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF73164C7
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629020; cv=none; b=Oo4bla70JcZSue+KTBgVodoYD01uFDIZJysN0HPs06U+iVzkq3S/82iLkd0KSRqKLf3OpTIXuZFtYvr+YNt7IC7C10zM6Xd63IeiKhY/v0v9nK3G4FMiZsPfm0kfDPujaO5GjZUbPdnAMC+xz+tcC9xswinQTpj3bSIHcD9botc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629020; c=relaxed/simple;
	bh=VTz0gQbRyu+H0PrPLiTi2z1uAri38IWcGBJk/QYkoGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C/o5JVpsRTogWBNlzjHf+4yJyVsTnvxBYrKq3HDNsfFHEEZUpaDLzJ3/uSJ5tOoUVRqz7wWfFmdAelrraqchGM6h5S6EzB25N8ePe8fjMHhBa+NRAg0w8w7WVBLlatCmDVqbEextPCuke/ekb+pojxyrqZ6s/U/z9wYcqImrb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKliZqkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKliZqkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEEFC2BCF6;
	Tue, 12 May 2026 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778629019;
	bh=VTz0gQbRyu+H0PrPLiTi2z1uAri38IWcGBJk/QYkoGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eKliZqkxiwbDUHIcnIkJKtkgjAvKsAivQGHLfqvL4zuJONgIBCtsM38pDDFTcT4X7
	 yT4izqQlkMMCPzFCagloZp4ZlPgN7jYHMC05zSeFDh28VFObC7fKJEdYVsNJGPGsqt
	 vB8UhYFwvi5R5lnuRF8sPPtXBwwiVQiT4vj3ebI2UIyr2lw4ErIzCpzUKWSc+83vQb
	 SI9956uXSlrjzalbqNxCzbQ2lDqJ8A+tF9g4lEExfTImx7HNOZYbQcehy02oYjUwGz
	 8Io72FrFSHRClgFaKj2/ovTxjTALbvTghDa3fEKFUWhzVIECJY76bYsk6p4v2fBgwq
	 MN6j7iya+7vag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PM: wakeup: Add kfuncs to traverse over
 wakeup_sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Wu" <wusamuel@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511174559.659782-2-wusamuel@google.com>
References: <20260511174559.659782-2-wusamuel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 23:36:59 +0000
Message-Id: <20260512233659.CFEEFC2BCF6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The kfunc `bpf_wakeup_sources_get_head()` returns `void *` instead=
 of `struct list_head *`, which the BPF verifier downgrades to an unknown s=
calar, destroying BTF type tracking.
- [High] The verifier cannot enforce that the SRCU lock is actually held du=
ring list traversal, allowing trivial use-after-free vulnerabilities and vi=
olating BPF architectural patterns.
- [Medium] Wrapping the integer SRCU index in a fake `struct bpf_ws_lock *`=
 pointer circumvents verifier safeguards and introduces invalid trusted poi=
nters.
--

commit 6dcbdc1d5aa4a12914c7281f95390e19498129d0
Author: Samuel Wu <wusamuel@google.com>

PM: wakeup: Add kfuncs to traverse over wakeup_sources

This patch introduces BPF kfuncs to allow in-kernel traversal of the
wakeup_sources list. It adds functions to get the list head and manage
the SRCU lock, using an opaque pointer to hold the SRCU index for the
verifier.

> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index b8e48a023bf0c..80b497de2deb0 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c

[ ... ]

> +/**
> + * bpf_wakeup_sources_read_lock - Acquire the SRCU lock for wakeup sourc=
es
> + *
> + * The underlying SRCU lock returns an integer index. However, the BPF v=
erifier
> + * requires a pointer (PTR_TO_BTF_ID) to strictly track the state of acq=
uired
> + * resources using KF_ACQUIRE and KF_RELEASE semantics. We use an opaque
> + * structure pointer (struct bpf_ws_lock *) to satisfy the verifier while
> + * safely encoding the integer index within the pointer address itself.
> + *
> + * Return: An opaque pointer encoding the SRCU lock index + 1 (to avoid =
NULL).
> + */
> +__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
> +{
> +	return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
> +}

The verifier treats the returned struct bpf_ws_lock * as a trusted
PTR_TO_BTF_ID. By casting the integer index returned by srcu_read_lock()
into a pointer, we end up fabricating invalid kernel pointers pointing to
near-zero addresses like 0x1 or 0x2.

Does this circumvent verifier safeguards by introducing invalid trusted
pointers?

[ ... ]

> +/**
> + * bpf_wakeup_sources_read_unlock - Release the SRCU lock for wakeup sou=
rces
> + * @lock: The opaque pointer returned by bpf_wakeup_sources_read_lock()
> + *
> + * The BPF verifier guarantees that @lock is a valid, unreleased pointer=
 from
> + * the acquire function. We decode the pointer back into the integer SRC=
U index
> + * by subtracting 1 and release the lock.
> + */
> +__bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
> +{
> +	wakeup_sources_read_unlock((int)(long)lock - 1);
> +}

The patch uses KF_ACQUIRE and KF_RELEASE to ensure the lock is eventually
unlocked. However, does the BPF verifier have a mechanism to tie this
custom lock state to the list pointer returned by
bpf_wakeup_sources_get_head()?

It seems a BPF program could fetch the list head and traverse it without
ever acquiring the lock, or continue accessing elements after releasing
the lock, resulting in a use-after-free.

Would it be safer to implement a dedicated BPF iterator
(bpf_iter_wakeup_source) that internally manages the SRCU lock and safely
yields elements, rather than exposing the raw lock and list head?

> +/**
> + * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
> + *
> + * Return: The head of the wakeup sources list.
> + */
> +__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
> +{
> +	return &wakeup_sources;
> +}

Since this kfunc returns void * instead of struct list_head *, the BPF
verifier evaluates it as returning an unknown scalar.

Because the return value becomes a scalar, BPF programs cannot natively
or safely dereference the list head. They would be forced to cast the
scalar back into a pointer using bpf_rdonly_cast(), which the verifier
marks as PTR_UNTRUSTED.

Since untrusted pointers cause field dereferences to be rewritten into
slow PROBE_MEM operations, does this defeat the goal of high-performance
in-kernel traversal?

Could the return type be changed to struct list_head * to be natively
tracked as a PTR_TO_BTF_ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511174559.6597=
82-1-wusamuel@google.com?part=3D1
