Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D984C6528
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213384; cv=none; b=LZfuwQGJ4ukDsFPUp8DPrmxdBVEzyF6BjbWz+q07i/N2ps+SE+yb2TZg9sHH6E+UcCa3jE6ufgiiTc5vJLL1K7lZtfaubosmo+mrIblhQ1IOe8NyD8XgVE23a5GzOnpLa1xCM1dnJtCpm30cVNKGDmP+jZtBOJ1g3+KMW+rXZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213384; c=relaxed/simple;
	bh=5nU0TcwSpnD2+yE5npB/J1Oe0X9RatKOayTrvc166yA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VTsqloizlKS2XabMZew3P8UNsKeyG/YSGqsO+mWfF49gScFzkN+liTWu1r7PFq1+DQWr00DLC4FTZAtidONyUUZQxW+FXJe3Pnykj8bAxx7l8TL2VOzPwRY9x9zLnkYVOSain8j9RV/ZLAUq6/ewqrxDRoHh1JAZJwnH8H4C39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTBcqU8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTBcqU8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196021F000FF;
	Mon,  5 Oct 2026 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213383;
	bh=PAN6UBovfTfV4ATwCgHhIU+m42UtKcZGm0BVTYhbljs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZTBcqU8joCpqAufQe4unD/ReOeNZUlVmCyyrSKDHzLL3Fg01ZNK2jPsO9FQmVBAQU
	 OFf0NpLlRqv1IBfSMq/VsIbie2T4LTjI2ygOqmQH1xNFYLw6KkdpEwshAAMaQ0vYzp
	 wxgLBIe569i4Pmw5QF54zkrPOccJag3NcwshBLI1Vi9prrO7gHG/8wmgmwOQtmx7zj
	 NUnoeWROJl72aJuwwkqrzvYT4YqmuJ+YSsii5qjsSypppvTEEZLfjV42RaeNlQGZ4a
	 11oQw+9xreNO9Ud6zrlTbEL/aKrHBRHJ1NYBlo+qJ1AjOHTZyJOJKYopS6Pplcnlkf
	 FbMDh+kPltzlA==
Content-Type: multipart/mixed; boundary="===============4569345928346328508=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cfd771ad56f66fb0176ed52313931b706786572e32b06c2cca8d1b74c51f25dd@mail.kernel.org>
In-Reply-To: <20261005142219.33451-2-yunwei356@gmail.com>
References: <20261005142219.33451-2-yunwei356@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Let kfunc sets give kfuncs a BPF body
From: bot+bpf-ci@kernel.org
To: yunwei356@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,x86@kernel.org,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,hpa@zytor.com,leon.hwang@linux.dev,puranjay@kernel.org,sunhao.th@gmail.com,yunwei356@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  5 Oct 2026 15:16:21 +0000 (UTC)

--===============4569345928346328508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let kfunc sets give kfuncs a BPF body

TL;DR: Kfunc bodies are added before btf_populate_kfunc_set(), so if populate
fails the set's bodies may stay registered. A later registration may then be
skipped and the verifier may use the stale body. No memory-safety impact seen.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0630675377aa..4b729d0367bb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9695,6 +9705,118 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
[ ... ]

> +static int btf_add_kfunc_bodies(struct btf *btf, const struct btf_kfunc_id_set *kset)
> +{
[ ... ]

> +		/* the body stands for the call, so no kfunc flags apply */
> +		if (!pair || pair[1] || !t || !btf_type_is_func(t) ||
> +		    !btf_check_kfunc_body(btf, t, b)) {
> +			/* a set that fails to register leaves no bodies */
> +			tab->cnt = cnt;
> +			return -EINVAL;
> +		}
> +		/* a set registered for several hooks adds its bodies once */
> +		if (!btf_find_kfunc_body(btf, id)) {
> +			tab->bodies[tab->cnt].id = id;
> +			tab->bodies[tab->cnt++].body = b;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  				       const struct btf_kfunc_id_set *kset)
>  {
> @@ -9714,6 +9836,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  			goto err_out;
>  	}
>  
> +	ret = btf_add_kfunc_bodies(btf, kset);
> +	if (ret)
> +		goto err_out;
> +
>  	ret = btf_populate_kfunc_set(btf, hook, kset);
>  
>  err_out:

btf_add_kfunc_bodies() rolls back its own additions when a body fails
validation ("a set that fails to register leaves no bodies"), but
__register_btf_kfunc_id_set() calls it before btf_populate_kfunc_set(), and
the populate step can still fail after the bodies have been committed.

For example, btf_populate_kfunc_set() can return an error for a hook that is
not below BTF_KFUNC_HOOK_MAX (register_btf_kfunc_id_set() with a prog type
that bpf_prog_type_to_kfunc_hook() does not map), for -E2BIG from the filter
or BTF_KFUNC_SET_MAX_CNT limits, for -ENOMEM from krealloc, or from the
WARN_ON_ONCE for a module set registered twice for one hook.

On those paths err_out only does btf_put(), so btf->kfunc_body_tab->cnt is
not restored and the set fails to register while its bodies stay in the
table.  The populate error path also frees the whole kfunc_set_tab via
btf_free_kfunc_set_tab(), but kfunc_body_tab is left in place, so the two
tables disagree.

Can this leave a stale body behind?  If the same kfunc id is registered
again later (another set, or a module init that ignores the error and keeps
registering), the dedup check

	if (!btf_find_kfunc_body(btf, id)) {

finds the stale entry from the failed set and silently skips the new set's
body.  bpf_add_kfunc_call() in 47ef3ddba448 ("bpf: Verify calls of kfuncs
with a body through the body") then uses the stale body.

There is no memory-safety impact that I can see, since for module BTF the
stale body pointers can only be reached through btf_try_get_module(), which
fails once the module is gone.  But the behaviour contradicts the comment.

Would it make sense to save the old count and restore it when
btf_populate_kfunc_set() fails, or to add the bodies only after populate
succeeds?  No later commit in the series touches kernel/bpf/btf.c.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37326585321
--===============4569345928346328508==--
