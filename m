Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953A374E4C;
	Wed, 29 Jul 2026 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314829; cv=none; b=lhJaWjWmwqgSuTYNVQeNyCvZnjg1yj+LDk+FjuzHBkvvu9d9WUAWLfL8/Q6uRxvlfXgPyHxko83Kv2h2xPn5Fk7q+BcEtY4CjD3SRiKK9PPDEoYu2uxANBp1O8rVD+XDdk5gQUu+crxWsgYobeFbMPTrMIU7DBqGwNXBTWYdZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314829; c=relaxed/simple;
	bh=OgxgtKIq8dcyNvYKKR/6GETKf1/gTOuCFbBrJURsINk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=snZAKlZHjnRkCztLMDAvoFDzC9eDNjul7+nN3caSVfh3yzJ+a5jjFGUhUOlRf1OPVWMLFJuBVX3A2fTtX33STmUIgCTwwD5+7ahVV0AsiA6csytkJZkyu7+o3w8e49AKoYF8/whoAoVHrBt5U/gtZ1tbBTzU6yS9hQpvIlG88WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7vr8Ofr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7vr8Ofr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D129D1F000E9;
	Wed, 29 Jul 2026 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314828;
	bh=COUG6vwBfwWK327LF5v5Zcp0tkukUE4wOju+wfvnk90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i7vr8Ofro5Lr6eeJd772kVxA9a406dGTNYvRcKw8NdBIp4yo95YZhwely0JfoeDEI
	 briZMWgA4Anl7Ud6bYVrokjXpYhAXbviVxPBCQ+aLEaPIVq6G2XkbyE7i/IJ4SOtQJ
	 w/X3LJ8jw+thwXaaVZfZ3AwSOA/5nOEURrAx/fGuDXeYZGrxvrYZnPRiaZ8gR9xk6I
	 PO5YujL7t/pJqDZXcia/CkHzSbJJp5sWaK56NGm8eOPX03HEoucFXWqYNBTPqbfEgB
	 DGpM5vzkpdpjV1T+4+o7w2SUyLTgorPRgsQc5v04eBAqwainBnongxC+GzPJYpAU82
	 FmUU55OLIGkhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] mm/slab: use call_rcu() in unknown context if
 irqs are enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:47:07 +0000
Message-Id: <20260729084707.D129D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The modified fallback condition `!allow_spin && irqs_disabled()` i=
s completely dead code because `allow_spin` evaluates to true unconditional=
ly, rendering the intended NMI protection for `call_rcu()` ineffective.
--

--- Patch [3]: [PATCH v5 3/8] mm/slab: use call_rcu() in unknown context if=
 irqs are enabled ---
commit f7ce8e162ca9c0e62e67afe017d8855bcf7b7674
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: use call_rcu() in unknown context if irqs are enabled

This commit updates the fallback condition in __kfree_rcu_sheaf() to check
if IRQs are disabled, allowing direct use of call_rcu() when IRQs are
enabled. It assumes that if IRQs are enabled, re-entrance into call_rcu()
cannot occur.

Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pv=
zpgZTngNS+fg4rw@mail.gmail.com

> diff --git a/mm/slub.c b/mm/slub.c
> index 2c5ba8c326e73..bb0f2975c95b1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6157,8 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj, unsigned int free_flags)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf =3D NULL;
>  	} else {
> -		if (unlikely(!allow_spin)) {
> -			/* call_rcu() cannot be called in an unknown context */
> +		/*
> +		 * With !allow_spin, we might have interrupted call_rcu()'s
> +		 * IRQ-disabled critical section. If IRQs are not disabled,
> +		 * we know that's not the case.
> +		 */
> +		if (unlikely(!allow_spin && irqs_disabled())) {

[Severity: High]
Does this make the fallback condition completely dead code?

Since __kfree_rcu_sheaf() is only invoked by kfree_rcu_sheaf() in
mm/slab_common.c with the SLAB_FREE_DEFAULT (0) flag:

mm/slab_common.c:kfree_rcu_sheaf() {
    ...
    return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
}

The allow_spin variable will evaluate to true unconditionally. This makes
!allow_spin always false, which prevents this fallback path from executing.

If an eBPF tracing program calls kfree_rcu() from an NMI context exactly wh=
en
the CPU's RCU sheaf becomes full, could the code now invoke call_rcu() and
corrupt RCU per-CPU data structures?

>  			rcu_sheaf->size--;
>  			local_unlock(&s->cpu_sheaves->lock);
>  			goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D3
