Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78244C67E
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987912; cv=none; b=nlOtWKdRRl2Ht4HstKEznWOBivNZ11lWJrrqFWerQn/g3UGdenwoaQYK/1nGPxgSNt51kvTsyOaQ6QK5uVlCy4JCEWec/vou38nV4E1UERVckK+yUQdHWyOac3DGM28bwd2Opukv19zKl6d6Fi2QUkJlZwjZkRQRG1ilNXUJPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987912; c=relaxed/simple;
	bh=YB5vyXomEiNlD4MxdpnFjCjHR+jZyC6FqEvQT3nyuA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+1cLWkvqaojvYr+Rx01Yh+NoG3dVQrlzYXoBGKAq9E3p2s2bkFD41wh3+Cjh31aMtIeQp5iAOaCTtlVDkygyZtql/bffrTSjOXWMWET7vx5xQ6gn1hqvI84wnahDhwJhrKApgqWntcAcxWZjZxFu4o5Ghi3FN5qLRTMr8KJzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RS/K17pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RS/K17pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C311F000E9;
	Mon, 17 Aug 2026 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987911;
	bh=CKN+q9tl7lYQI8ZJfGj6rsvGpVNeb9NI0bd+MDRTfck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RS/K17ppXCbPL9BgwgLzJXDYsPnWtqDtA55DpmT0SMp8vu91GCp1egvMuS8SqDbdh
	 mov88INkrje32MQxB35pHAvC/6mN4qFXYpkQocpSlMMThdX5SjAeG+3ymadYZPXwC7
	 Irou67FJNEmIlaltp/Q3b16zQmigBL3NC6861baxYSX02HVH37/P0gPWUa6YI9vStm
	 S+kzGVysjDRb7q2NyR1z3SNzlY32FHq+jyGKAqDxJGOjB/j+XKH/cd1pJwuOfaUGVs
	 nTN7VmbIq3anKjgNcDDGNzMD7yWhdKSQ6TSJLvPlYFgF6tvzSozKcru5WytgpDT9K6
	 kKm68r4qCebxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] drm/gpuvm: Route gpuva_op allocations to
 folio_scratchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-4-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-4-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:31:50 +0000
Message-Id: <20260817173150.D1C311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded memory leak of transient `struct drm_gpuva_op` objects d=
ue to bump allocator usage without intermediate resets.
- [Low] Undeclared static key variable 'gpuvm_scratchpad_key' used in drm_g=
puvm_init().
--

--- Patch [4]: [PATCH 4/9] drm/gpuvm: Route gpuva_op allocations to folio_s=
cratchpad ---
commit 6e27181fef6cb87688764c9745ab2086b2091e88
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: drm/gpuvm: Route gpuva_op allocations to folio_scratchpad

This commit modifies the DRM GPUVM subsystem to route default gpuva_op
allocations to a folio scratchpad embedded in struct drm_gpuvm. It updates
gpuva_op_alloc() to use folio_scratchpad_alloc_obj() and handles the bulk
teardown during drm_gpuvm_fini().

> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1109,6 +1109,8 @@ drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char =
*name,
>  	spin_lock_init(&gpuvm->evict.lock);
> =20
>  	init_llist_head(&gpuvm->bo_defer);
> +	folio_scratchpad_init_key(&gpuvm->va_scratchpad, get_order(SZ_64K),
> +				  &gpuvm_scratchpad_key);

[Severity: Low]
Does this cause a compilation failure?

In drm_gpuvm_init(), the code references gpuvm_scratchpad_key, but this
static key is not defined until later in the file via the
DEFINE_FOLIO_POOL_STATIC_KEY_PARAM macro.

[ ... ]

> @@ -2814,7 +2820,8 @@ gpuva_op_alloc(struct drm_gpuvm *gpuvm)
>  	if (fn && fn->op_alloc)
>  		op =3D fn->op_alloc();
>  	else
> -		op =3D kzalloc_obj(*op);
> +		op =3D folio_scratchpad_alloc_obj(gpuvm, va_scratchpad,
> +						struct drm_gpuva_op, GFP_KERNEL);
> =20
>  	if (unlikely(!op))
>  		return NULL;
> @@ -2831,7 +2838,7 @@ gpuva_op_free(struct drm_gpuvm *gpuvm,
>  	if (fn && fn->op_free)
>  		fn->op_free(op);
>  	else
> -		kfree(op);
> +		folio_scratchpad_free_elem(op);
>  }

[Severity: High]
Will this cause an unbounded memory leak for long-lived VMs?

In gpuva_op_alloc(), struct drm_gpuva_op objects are allocated using
gpuvm->va_scratchpad, which acts as a bump allocator. However, the
folio_scratchpad_free_elem() called here in gpuva_op_free() cannot reclaim
individual elements from a scratchpad bump allocator.

Since the memory is only fully reclaimed during bulk teardown in
drm_gpuvm_fini(), and these objects are transiently allocated per map/unmap
operation, could this result in continuous memory leakage over the lifetime
of the GPU VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D4
