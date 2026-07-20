Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2B4192FC;
	Mon, 20 Jul 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553068; cv=none; b=gbOEC3CicGRqaBohRW3QdzZKXwMMAZWQiEUZRE2ofBzRsQ5tIQZ56jRSLWol5YFV+ecO0pnKzZ4zoQORHW8HQ016zROKz7S3xaoMOJsS6rWAiQGwdHG/0uFg2MkRcsVEono7In+8KpwHEo7DdOu0gmxD0IE/7lH52rjCo0YFkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553068; c=relaxed/simple;
	bh=IuCmNEC0svnwvEcCoIlqZ5GB4sa362Gd2VmrpyfC1+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r95yVKfOpue+FvvisTmFNXEGUv7ttgLLqbBQiaJ7yT9YQVCcHrf5eXBWuZK3/6GClZKyJKttQbxlDedO0PJdP39iOGOyI5xZJ4vBmmBuaGmOEOgQjJ/4+dkQnjR/bzDCEMFXub52Z9LcaAPKf8ClDqdIiY1QzXQsCdKGv0jfzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVEyuPlX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVEyuPlX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA661F000E9;
	Mon, 20 Jul 2026 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553067;
	bh=LCEPYYQ8bW0kgw/0BZ+aIkU/OBIrX7mD+rvoihfKwk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XVEyuPlX5lJk6TD7m0hN3Vu3qzXJmV/PWirPByPbXDzhqZmabnL9OKscogAzw9U4i
	 kZ6+z2G5zm8dOROU2vZWiymgTWdaSSaaNzlQOFUwXgc7243/Mjxi2C4WozR6iu0iSB
	 KCp38Z07pUWLpzNkn0ZXLR0OuSk9qrvyydVcythtDNznYwij7w265tjLoV8u7XbvNb
	 FRehcB8OzPznto4j+F4D5RDRXVYbxP/SUhHgPPgsGm0K7ZYVRH2BbQ+/Cs0T6zq5SL
	 nZ9M8iky+NXk8bvoYG9CoVkgXflwNdb8z0vvqZO+wAaPWfKI0Vz+oNvP5WSsb+XBhw
	 LFuiHbrdDUEmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin
 case in kfree_rcu_sheaf()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-2-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:11:06 +0000
Message-Id: <20260720131106.BCA661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] kfree_rcu_sheaf() hardcodes SLAB_FREE_DEFAULT, rendering the new !=
allow_spin fallback logic unreachable and leaving lock recursion bugs unfix=
ed.

Pre-existing issues:
- [High] Calling kfree_nolock() can trigger RT-mutex deadlocks when execute=
d in NMI context on PREEMPT_RT kernels.
--

--- Patch [2]: [PATCH slab/for-next v4 2/8] mm/slab: handle the !allow_spin=
 case in kfree_rcu_sheaf() ---
commit 412874c34b3d9cc0ed877c03632bf3c3cd9499d6
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()

This commit teaches kfree_rcu_sheaf() how to handle the allow_spin false
case by trying to get an empty sheaf from pcs->spare or the barn even when
spinning is not allowed. It introduces free_flags to describe the context
and converts them to alloc_flags when allocating memory in the free path.

Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5=
@kernel.org

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index b6426d7ceec92..e07b4e6d6679c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1605,7 +1605,7 @@ static bool kfree_rcu_sheaf(void *obj)
> =20
>  	s =3D slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_mem_i=
d()))
> -		return __kfree_rcu_sheaf(s, obj);
> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);

[Severity: High]
Does this hardcoded SLAB_FREE_DEFAULT prevent the new allow_spin fallback
logic from ever being executed?

Since kfree_rcu_sheaf() is the sole caller of __kfree_rcu_sheaf(), passing
SLAB_FREE_DEFAULT unconditionally appears to make the new context-handling
logic unreachable.

> =20
>  	return false;
>  }

[ ... ]

> diff --git a/mm/slub.c b/mm/slub.c
> index e32a686775374..0c350274fbff4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2829,11 +2833,20 @@ static void free_empty_sheaf(struct kmem_cache *s=
, struct slab_sheaf *sheaf)
>  		mark_obj_codetag_empty(sheaf);
> =20
>  	VM_WARN_ON_ONCE(sheaf->size > 0);
> -	kfree(sheaf);
> +
> +	if (likely(allow_spin))
> +		kfree(sheaf);
> +	else
> +		kfree_nolock(sheaf);

[Severity: High]
This is a pre-existing issue, but can calling kfree_nolock() here trigger
an RT-mutex deadlock when executed in NMI context on PREEMPT_RT kernels?

Looking at kfree_nolock() in mm/slub.c, it calls free_to_pcs() with the
following sequence:

    if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
        return;

And free_to_pcs() acquires the lock via local_trylock():

    if (!local_trylock(&s->cpu_sheaves->lock))
        return false;

On PREEMPT_RT, local_trylock() maps to an RT-mutex, which can deadlock if
the NMI interrupted a critical section holding the internal raw spinlock on
the same CPU.

> =20
>  	stat(s, SHEAF_FREE);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D2
