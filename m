Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A143C7CB;
	Wed, 29 Jul 2026 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314676; cv=none; b=ZjJGCIFrkXnPqRt/zgv7hbhzgQ/1WDZnCzxBRR9cPlOX6pkPVtEeumhx/End3E94bsk9aIGYUrS76Rv2421EB0qM3+ZEPTbRggyDWkb6fLsFRixZAgyTSlVhVTb5oVVbUq9Qog83llqnPin12CmttohIcTep0jr+edpQW9IQk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314676; c=relaxed/simple;
	bh=mc6iTQEpBfWKJRkFulOYq1vsD2MLFbNVb2iNK6xaKQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qDsZ2KKFN/U34IUm2e95yJ2/HF5slAFiwGv463z5J5zm9HR+sNObntb7xTyuM8kPUWcp+YmdoEPbQ1oYEhygrNUrjz1Hzt6zNov8NlH4RALLcaqXecuBr14DF0enkyiK6GkU3eiPb5sniBGWUPBDjyiiBE9OJSJUnh/C9fUJaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9xYZbS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9xYZbS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9407E1F000E9;
	Wed, 29 Jul 2026 08:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314674;
	bh=zTc/mPncOKc1IFlYEdNlhUqzlr1X8RMssyE9EcKmoV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9xYZbS2jtZOaT1Nfdk12g/I6QcXU5XDjW/fP2KUzwYck8GEvejaULZiAZJc56jFy
	 pi6b++A/VlkdfGe4unzlCR6twTD61v5+Lsy6BiwXg5J5UxVwJtjiODD642Sm4piUgr
	 qiPMjuyDrI2sU3BASlHeeGla3/BRqA08BO9awIrg2FRlcZb2B/OzWINDqaqP6csryn
	 FFRbqziS6rfs8+fdKu+4zaIBuU33w94aLPHYxnUbruyHHUrfNLKsvLFKbyelWUeC1A
	 8jnXq0WX+iK60uwz69vUk6nRttFg3Nv/dhmEav7IqdSrGG4R5I49Dhbf7V8D/+OzSv
	 ZjFnK+mLf8fPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260729-kfree_rcu_nolock-v5-2-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-2-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:44:34 +0000
Message-Id: <20260729084434.9407E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Kmemleak symmetry violation when a sheaf allocated with SLAB_ALLOC=
_NOLOCK is freed with standard kfree().

Pre-existing issues:
- [High] Lock recursion deadlock via kswapd wakeup from raw spinlock contex=
t due to GFP_NOWAIT usage.
--

--- Patch [2]: [PATCH v5 2/8] mm/slab: handle the !allow_spin case in kfree=
_rcu_sheaf() ---
commit 10fcb5282968708fbb08270a6618140198eda999
Author: Harry Yoo (Oracle) <harry@kernel.org>
mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()

This patch teaches kfree_rcu_sheaf() how to handle the !allow_spin case by
introducing free_flags. It attempts to get an empty sheaf even when spinning
is not allowed, translating free_flags to alloc_flags during allocation. It
also ensures kfree_rcu_sheaf() fails when the RCU sheaf becomes full in an
unknown context.

Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5=
@kernel.org

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1e1d3feec3535..42db62f3e801a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1638,7 +1638,7 @@ static bool kfree_rcu_sheaf(void *obj)
> =20
>  	s =3D slab->slab_cache;
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) =3D=3D numa_mem_i=
d()))
> -		return __kfree_rcu_sheaf(s, obj);
> +		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditional use =
of
SLAB_FREE_DEFAULT here cause a lock recursion deadlock?

Because SLAB_FREE_DEFAULT evaluates allow_spin to true, __kfree_rcu_sheaf()
will use GFP_NOWAIT. GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, which can
trigger wakeup_kswapd().

Since kfree_rcu() (via kvfree_call_rcu()) can be called while holding
scheduler internal raw spinlocks like pi_lock, waking kswapd enters
try_to_wake_up() which attempts to acquire pi_lock again, deadlocking the
system.

> =20
>  	return false;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index d14226ad09822..2c5ba8c326e73 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> -static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sh=
eaf)
> +static void __free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *=
sheaf,
> +			       unsigned int free_flags)
>  {
[ ... ]
> +	if (unlikely(free_flags & SLAB_FREE_NOLOCK))
> +		kfree_nolock(sheaf);
> +	else
> +		kfree(sheaf);
> =20
>  	stat(s, SHEAF_FREE);
>  }
> =20
> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sh=
eaf)
> +{
> +	__free_empty_sheaf(s, sheaf, SLAB_FREE_DEFAULT);
> +}

[Severity: High]
Does this wrapper cause a kmemleak symmetry violation?

When __kfree_rcu_sheaf() is called with SLAB_FREE_NOLOCK, it allocates the
sheaf using SLAB_ALLOC_NOLOCK, which skips kmemleak registration.

However, the allocated sheaf struct does not track its allocation flags.
Later, when this sheaf is flushed or processed for freeing (e.g., via
rcu_free_sheaf()), free_empty_sheaf() is called unconditionally.

Because free_empty_sheaf() hardcodes SLAB_FREE_DEFAULT, it will call
kfree() instead of kfree_nolock() on an unregistered memory block. Could
this lead to kmemleak warnings and false positive memory leaks due to
freeing an unknown object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D2
