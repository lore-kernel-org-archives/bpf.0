Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406335A3A9
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015257; cv=none; b=I0YV4CtKnAlMdlo6bX5V40tCbWYxGUFAu4B7IP8CQwt6nFqIgdrzmkTp27d1eiH+47sGHTFKxzFipEPJUTu6c/ihisft2fJNfU/YWmmWhHI+Ywfr+75SmqNE9GlUFQBQx9B7uD+3nkplYpFf5ylIrZQVmkGe+g3FQWc22MhA4DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015257; c=relaxed/simple;
	bh=AvnFWNFky2XSLZI+x4U1VYDgacRu2pF22JWTG0dTm8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VKYbPsmqIQCe/I4XOj4af9yDcl1jHUolq3/sVtJ0csfEOrFgXXcqP9mKFPZpMktvIKa5c/Tc3ABYCeSVzFfLE3Lcf+eb97OYNm1S9NFH7yvBf+e4R5QFgQ4u0FXlh6CKev0/yTBBp7+EVH1PBUFyKPFnnBSAxEnVwt54Rb+wCO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgw9Zd7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgw9Zd7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B11F000E9;
	Tue, 14 Jul 2026 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784015254;
	bh=KNUrAAL71TW2syVJ3JmhtDguEieUDG26oH4Hb66HObc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dgw9Zd7vzUeFXJMx3AsrAi98l9m5/b8nMrNlTWvlSsTNrC2gEhKeKPF0ir8gGH5uL
	 HO6DbgIjJaUu3qbUKiBqlaPvKhkdEgNDJ2S0l8FA6BFjOeMB31Bp/2WNIlJimA7m9+
	 p+1bKWfmMlphoFsP7xpgAw8a+hyrdUqU0BU7rGoe4YDKjTeS7XTpJR9HeDnane9MgC
	 tYvfBuGc/iJJwh3B35nCfeGTYcVB2SiwdnX4bkqZlcJuPx7xPG4GPFiXYPi+85RU/x
	 1Omrf6E1NBVwC8L0Vs8MAKKxG6rYFkcw+x5z536DX/KTP6U+YNK8IDOoXirWSYWlU/
	 Qhg2gE8H9b9oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/15] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714073041.40250-8-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:47:34 +0000
Message-Id: <20260714074734.7D9B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Missing `atomic_long_cond_read_*_timeout` wrappers, breaking API sy=
mmetry.

Pre-existing issues:
- [High] The atomic64_cond_read_*_timeout macros bypass generic_atomic64 sp=
inlocks on 32-bit architectures, leading to torn reads.
--

--- Patch [7]: [PATCH v14 07/15] atomic: Add atomic_cond_read_*_timeout() -=
--
commit 51b6c1c793c6e910ea5b78db4aba0270bfcc54ff
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

This patch adds atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces. It
also updates documentation to briefly describe these non-RMW interfaces.

> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9b..5bcb86e077845 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -31,6 +31,16 @@
>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->cou=
nter, (c))
>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->cou=
nter, (c))
> =20
> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))

[Severity: Low]
Does this also need to update scripts/atomic/gen-atomic-long.sh to generate
the atomic_long_cond_read_*_timeout variants?

The generator script explicitly hardcodes the mappings for the non-timeout
variants:

#define atomic_long_cond_read_acquire    atomic64_cond_read_acquire
#define atomic_long_cond_read_relaxed    atomic64_cond_read_relaxed

Without updating the script, developers attempting to use the timeout
variants with atomic_long_t will encounter undefined symbol errors.

> +
> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))

[Severity: High]
This is a pre-existing issue, but does mapping atomic64_t to
smp_cond_load_acquire_timeout directly on &(v)->counter cause torn reads
on 32-bit architectures?

On 32-bit systems using CONFIG_GENERIC_ATOMIC64, native 64-bit atomics are
unavailable, so atomic64_t operations rely on a hashed spinlock array in
lib/atomic64.c.

Because smp_cond_load_acquire_timeout uses READ_ONCE() directly on the
counter address, it bypasses these spinlocks. A concurrent atomic64_set()
holding the spinlock could update the value while the lockless READ_ONCE()
splits the 64-bit read into two 32-bit loads.

If the resulting torn read falsely matches the wait condition, the thread
could prematurely unblock and enter a critical section before the data is
ready.

> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
> +
>  /*
>   * The idea here is to build acquire/release variants by adding explicit
>   * barriers on top of the relaxed variant. In the case where the relaxed

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714073041.4025=
0-1-ankur.a.arora@oracle.com?part=3D7
