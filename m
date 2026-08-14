Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D81F4908B5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734649; cv=none; b=Phuqq4FJlSDTk7VsbxLDoA1m2o4G1LK4vmMfEXOGJUJbxjwEwPDoSEJMdrhNX1o0C6seacH8CAz3nWnDXRdMxEP9RVCSUwIshtx31ESVDByeBIfRegGf3RekpJN/UEykcqVq5DodGUM6Ikpg8FNws9OgkUoiadvBDNIZnP7ieUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734649; c=relaxed/simple;
	bh=pHTqCQt50z7dXIzPdX2hY8n1RY11Tt6BVmL1kDgf9+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hqxyQMSNLnp7KRbkSfcW60tj7TqhZTxmdTeMI1L1MlchZgK1BCVWPMUjFZ0LjQh5i5E3lkvW8GZns0aTK4Ik5bPveohjzu1u2ZD59LtDevGt0XHBTcTy2g8KZX6Nr6rI8w/Rga8PX8wj+bCCt6anYvZMJYpjNQYjghpWeRhqAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVd3HlCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVd3HlCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B01F000E9;
	Fri, 14 Aug 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786734640;
	bh=m2uqjmIIPAeGgh4znNzQV1JcawGLRbL//mcm8LmMUWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVd3HlCIo1RdkSfckE87804D8IN5Mo0lN3+j6yXwwfmxwnqXBBXhloIgwbBZp87Vi
	 DgqWVSUWxbIShyXPYOc+pIOKuSOOiXxFqQW0tsBsUYITlkzr2WPa5Y5TwtyZV++j4f
	 g6l9qemw+QhlirkXxg6Rgw4RbVzsmQNYXPIcxW37avv3EcptFord85UghUK75h9CKi
	 c6rMOSLfErR7Qg+YW9HYAGRUDykmAdaGE0cJEdxL7EogCvED+quGgttOyB16xmb4c1
	 W96FeayMsfWp+Hsr0K6scMt61qcMIrunzAR2mptAuITUvF7jy9IXLJFh94txDhoJzi
	 PPeoh7R4JzQzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/secretmem: properly account locked pages
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
References: <20260814-secretmem-accounting-v1-1-d2f8c677980b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 19:10:40 +0000
Message-Id: <20260814191040.9B0B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Clean secretmem folios evicted via `posix_fadvise(POSIX_FADV_DONTN=
EED)` or `drop_caches` leak `locked_vm` accounting because unaccounting is =
tied exclusively to inode destruction.
- [High] `secretmem_fault()` evaluates `RLIMIT_MEMLOCK` against the faultin=
g process but charges the `locked_vm` of the file descriptor's creator, ena=
bling limit bypasses and DoS.
--

--- Patch [1]: [PATCH] mm/secretmem: properly account locked pages ---
commit ebb3ab3c96b96ff43e45d7aaef427613df2d6542
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/secretmem: properly account locked pages

secretmem has a relatively laissez-faire attitude to accounting the folios
it allocates.

The intention is that the memory is treated as if it were mlock()'d and
thus is limited by the RLIMIT_MEMLOCK limit if the CAP_IPC_LOCK capability
is not in place.

[ ... ]

Link: https://lore.kernel.org/linux-mm/20260813225328.2010303-1-4ncienth@gm=
ail.com/

> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index d29865075b6ea..537fe5b1222f2 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -47,10 +49,107 @@ bool secretmem_active(void)
>  	return !!atomic_read(&secretmem_users);
>  }
> =20
> +struct secretmem_inode_state {
> +	struct user_struct	*user;
> +	atomic_long_t		nr_pages_accounted;
> +};
> +
> +static bool __secretmem_account_pages(struct user_struct *user,
> +		unsigned long nr_pages)
> +{
> +	unsigned long page_limit, cur_pages, new_pages;
> +
> +	if (!nr_pages)
> +		return true;
> +
> +	page_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +
> +	cur_pages =3D atomic_long_read(&user->locked_vm);

[Severity: High]
Does this code check the limit of the faulting process but charge the creat=
or
of the file descriptor?

Looking at __secretmem_account_pages(), it uses rlimit(RLIMIT_MEMLOCK) which
evaluates the limit for the current task, but it increments user->locked_vm
which belongs to the fd creator.

If the fd is passed to a process with a higher or infinite RLIMIT_MEMLOCK,
could the creator bypass their own limit and inflate their locked_vm quota?

Conversely, if the fd is passed to a privileged daemon with a strict
RLIMIT_MEMLOCK, could any page fault by the daemon fail the limit check and
raise a SIGBUS?

> +	do {
> +		new_pages =3D cur_pages + nr_pages;
> +		if (new_pages > page_limit)
> +			return false;
> +	} while (!atomic_long_try_cmpxchg(&user->locked_vm,
> +					  &cur_pages, new_pages));
> +	return true;
> +}

[ ... ]

> +static void secretmem_destroy_inode_priv(struct inode *inode)
> +{
> +	struct secretmem_inode_state *state =3D inode->i_private;
> +
> +	if (!state)
> +		return;
> +
> +	secretmem_unaccount_all_folios(state);

[Severity: High]
Could this code leak locked_vm accounting when clean folios are evicted?

If clean secretmem folios are evicted from the page cache via
posix_fadvise(POSIX_FADV_DONTNEED) or drop_caches, they are freed via
secretmem_free_folio().

Since unaccounting is exclusively tied to inode destruction here, are we
missing a decrement to locked_vm when the folio is evicted?

If so, subsequent faults to the same offsets could allocate new folios and
double-charge locked_vm, potentially allowing an unprivileged user to exhau=
st
the global user_struct->locked_vm quota without actually consuming physical
memory.

> +	free_uid(state->user);
> +	kfree(state);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-secretmem-=
accounting-v1-1-d2f8c677980b@kernel.org?part=3D1
