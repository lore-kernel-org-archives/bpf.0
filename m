Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4B3AC0C0
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906987; cv=none; b=OwxFHoRPLr8ZiN9hdJ1EBYXMixwdjetDpz62d0iQ+NViGuiPfWWw4sYXmmRqXeCROx3Lt3zUOYlbuDldF5048WgkM2USOCCEFWkdK9Lx+5OWcgZZrueJPIciwRB/CAxCpCjV4P53i4fwK3tmQG1jwG2ZPxKHGe02cCD3FrhrEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906987; c=relaxed/simple;
	bh=ytAKH//DFzNZfRCGI1xGCTwP8eb3k3IMqu1ALqCQNFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcu4tt8FywLkleTlU/PAu1xeGUIJiwguZkkdvWwytlgdnexriN2x8IEAgKkEmxpVPsCVj3gABMHyNSNt+Ll11IUxyaWlqJfOQ+wj1NXR8+M4u9tHbVpi++W8V6+gvJY05Xee2SnJnGnlEC+goLt4SkcB4EYJZ1tlm6WnHhRpRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYNPB8hX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYNPB8hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEA61F00893;
	Mon,  8 Jun 2026 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906984;
	bh=rny1OZV3T1dRVFf/PA0/vCgAu432iNsOCnYPQRZ4RpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYNPB8hXmEhtPRkzYe25nPgFrgxgo1KtFGRH905U4035bmmfqwzlrqGtovl0BfUNM
	 3s4Uz6bXeeeBdFTHbOJUBm2ynfKxWkE+Wo4KjjrtPTAlSFhE3cjM9EpH7b7syKW3Le
	 XqZI1T9v4KW5RzRlMgki2uGwbQRmkPkY93d6zyFU5QTcABd8W9+RBwyVkEy0FMqyCE
	 /Rzrr82wcb2PB8L07L98NrafAZbTr2P7SgjveqjibVNK7ya3QSZEiLKZycCMWc7R/f
	 ROaAD7eho/2oXvk8sYysnpb1rXKB7jaYPjjl9S/Las09lveXdS1yEtf+Ts1T2E4A/I
	 jC3OjPPneDJzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/15] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-8-ankur.a.arora@oracle.com>
References: <20260608080440.127491-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:23:04 +0000
Message-Id: <20260608082304.ADEA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `atomic64_cond_read_acquire_timeout` and `atomic64_cond_read_r=
elaxed_timeout` macros can cause torn reads and synchronization failures on=
 32-bit architectures.
--

commit aafb3af0335d368d82aaca86bf6b2a18f8ae6033
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces. Also
add a short description for the interfaces.

> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9b..5bcb86e077845 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h

[ ... ]

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
> +
> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))

[Severity: High]
Will this cause torn reads and synchronization failures on 32-bit
architectures?

On 32-bit platforms, atomic64_t operations typically rely on spinlocks or
specific instructions to prevent tearing. These new macros bypass the
architecture-specific atomic64_read() and directly use
smp_cond_load_acquire_timeout() and smp_cond_load_relaxed_timeout() on the
counter member.

These macros poll using a lockless READ_ONCE(). On 32-bit systems, a 64-bit
READ_ONCE() compiles into two separate 32-bit memory loads. If concurrent
writers modify the counter via spinlocked atomic64 operations, the lockless
polling loop could observe torn (partially updated) reads.

If a torn read spuriously satisfies the polling condition, the loop might e=
xit
prematurely with a corrupt value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D7
