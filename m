Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22195423A6C;
	Mon, 20 Jul 2026 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552512; cv=none; b=gSTmk0bzrAUNMmJYa0QIeJVUgDWJWw4T4eYcLIKESv1FDNKj2guAXaFTRRjZW8B3+kiIU5fNq2Oak0cwI8QI0MdWgQmZWCN2rmX1IPfzTAPKPve1963qhvLnhlShZ8wvPGBO3dU1YiwpcdQpOmWqdvnCK8bl1+Z6F/f54uulI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552512; c=relaxed/simple;
	bh=2w2yKx55sabH6DkHxsJitnsiiG+NddL4iteJbiG03UY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O52fQKhD+USqZZaczb24pGN4OI9dKEYDLkQA05jWQSrsJI4XBnWJLXs54M+TV7kjBiFDcHFRhQaSK/pc6BnSQZ4SikNyB4op9cL99N3uZZ2xVTO7hQrpKClP//KGxWrplw0+7+XU8s5MADsEoJE2PzKomRotL58My6LSfjvtBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hS6oBRMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS6oBRMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23A21F039EE;
	Mon, 20 Jul 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552495;
	bh=eOIlIMFYGpxf202fxgFA2yGngzwcEsZZt35L6iAiCQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hS6oBRMuRqdSuI9X5MIgjU8qvlXkBzkVzh6Cp6PgCjm8MqyjMDV4IBhFojc2AKboz
	 F6720/TZWGioA7a3tRrjX0/3Z/Etj1aYnEdX9hkYon9xeGDjgAbc4xh2ujSCY33/xH
	 5VLbvVPiwKtYQClDTBbwPKrHRSO5DVenHjmjywyYldKvAEX4y5toZsly5qifLV3/9c
	 vY2q63hmNeRAz9vgfadU6YBJfwS4shI+4CPNHRLEWFrXiY5rkx0R2kObu4ez2p/bfc
	 dIOr0QNoQl7w8mo4hkkDwrLx6MQthhnGcrSFaVXXUvHPlbi6kd8AvVUP6UmIAOwQQm
	 fOCSpRSKLM9VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 3/8] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260720-kfree_rcu_nolock-v4-3-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-3-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:01:34 +0000
Message-Id: <20260720130134.C23A21F039EE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Acquiring local_trylock in __kfree_rcu_sheaf() causes an invalid w=
ait context lockdep warning when kvfree_call_rcu() is called under a raw sp=
inlock.
--

--- Patch [3]: [PATCH slab/for-next v4 3/8] mm/slab: use call_rcu() in unkn=
own context if irqs are enabled ---
commit 48ff7cace4bd8ff5a54e0dc53dea46c9c152b1ad
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: use call_rcu() in unknown context if irqs are enabled

This patch optimizes the deferred call_rcu() path in __kfree_rcu_sheaf() by
checking if IRQs are disabled. If IRQs are enabled, it avoids falling back
to the deferred path since call_rcu() cannot be interrupted by itself in
this context.

Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pv=
zpgZTngNS+fg4rw@mail.gmail.com

> diff --git a/mm/slub.c b/mm/slub.c
> index 0c350274fbff4..680fe64aff72e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6136,8 +6136,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
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
>  			rcu_sheaf->size--;
>  			local_unlock(&s->cpu_sheaves->lock);

[Severity: High]
This is a pre-existing issue, but does using local_unlock() here (and
local_trylock() earlier in __kfree_rcu_sheaf()) violate wait context rules?

The kvfree_call_rcu() path can be called with a raw spinlock held, such as
pi_lock.

Because local_trylock is treated as a sleeping lock under PREEMPT_RT
wait-type checking, acquiring it while holding a raw spinlock triggers a
lockdep "Invalid wait context" warning.

This happens because CONFIG_PROVE_RAW_LOCK_NESTING statically checks
declared wait-types rather than runtime behavior.

Is there a way to defer this freeing without taking local_trylock?

>  			goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D3
