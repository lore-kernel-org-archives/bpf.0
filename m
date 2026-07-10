Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7EC8F49
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646473; cv=none; b=VO6FXGKqctegx5HHtmcl+M4gnMYM3f8VTMVpuUX2Kj9BGHWOnXXfO/NlLBqYVNEYxZf+UZAJO+h4NSdE4/JTIs7/GjiQCDQ8LyoslRqiAhQL9lxVvRTA+wUqUW1CBSJmBYHveqxpeNDeLbIRF2/lbvoVbM6wIltrYBjOgLocNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646473; c=relaxed/simple;
	bh=4yukS/j8Ck2PVRXvA3tdbJh2BOqWdR4qjrXDtGjnXQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MbVBsXjt3IfrcJEWtXJdp5lDVnnJLqrQ9VuPzGgxEH7gYF89WNFFaHAoSt7qdCKbitBv6tV4QxI7+9nQH2ph6KkNXoGalPO93uqXeM4ms7usBsyX3HJ5JvuQG9PvTluhp0fUoc1lmmrkb6UA31aeyoWY3uv0LTIQKCu+RyGj3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCVrY/4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCVrY/4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577F31F000E9;
	Fri, 10 Jul 2026 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783646472;
	bh=YON70PtO7oQhlpL41pTczYGhGXUGi5XG6Xh4ZeinT8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCVrY/4gWCjP92MKqlvi/KrBzvW+qxcxB1L38Rh316Lw007+udNaUX/st4kb9JOv9
	 LD/ql626z+2p9+z7aTCYU2Tf1SXo0ETRixt29YTL7rh6WrnCtCMS6b644pAY9qkK5/
	 2jBa/aJ6fTksw/Q73AHgAdfnF466LRUBdvd8EwUvjVz3NU8TbSpgKF8hH7VsNOfBCi
	 8Kx5euGimDF/s1Msnuw8XK1+XrvSbCauIepgEMSBQhqyPci2IMGHFVbEcTdIFEyPSE
	 e3DoydcVs9YdcGhKxBOi73g01LFA64LlWbSqtP1eF2Jd8EyMOctaF51uqjfu9Mefr4
	 RD5RtsGqssApA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit
 args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 01:21:11 +0000
Message-Id: <20260710012112.577F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Accessing `btf->kfunc_set_tab` without holding a module reference =
causes a use-after-free vulnerability.
--

--- Patch [1]: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit =
args ---
commit 13df91bf669b3a55c459c1663fbf726f9f52bc5c
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Fix tracing of kfuncs with implicit args

A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
(such as bpf_prog_aux) that the verifier injects at load time.
resolve_btfids strips those from the kfunc's BTF-visible prototype and
keeps the real kernel ABI in a counterpart _impl prototype.

Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-4906694106

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85edc83..20aeca6b4f95c 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kf=
unc_btf_id, const struct bpf_p
>  	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>  }
> =20
> +/*
> + * Return the union of a kfunc's flags across all hooks.
> + * Unlike btf_kfunc_flags(), not restricted to a calling
> + * program's hook. Used when attaching to a kfunc for tracing.
> + */
> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
> +{
> +	enum btf_kfunc_hook hook;
> +	u32 *hook_flags;
> +	u32 flags =3D 0;
> +
> +	for (hook =3D 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
> +		hook_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> +		if (hook_flags)
> +			flags |=3D *hook_flags;
> +	}
> +
> +	return flags;
> +}
> +
>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
>  				const struct bpf_prog *prog)
>  {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6515d4d3c0032..fde11a2f6869a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -19121,8 +19146,8 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>  		if (prog_extension &&
>  		    btf_check_type_match(log, prog, btf, t))
>  			return -EINVAL;
> -		t =3D btf_type_by_id(btf, t->type);
> -		if (!btf_type_is_func_proto(t))
> +		t =3D btf_attach_func_proto(log, btf, btf_id);
> +		if (!t || !btf_type_is_func_proto(t))
>  			return -EINVAL;

[Severity: High]
Does this introduce a use-after-free race condition during module load?

The new btf_attach_func_proto() call executes before the module reference is
safely acquired via btf_try_get_module() later in bpf_check_attach_target():

bpf_check_attach_target()
  btf_attach_func_proto()
    btf_kfunc_accumulated_flags()
      btf_kfunc_id_set_contains()
        // Accesses btf->kfunc_set_tab->sets[hook]

If a module is just loading (in MODULE_STATE_COMING) and its BTF is already
visible, a concurrent BPF_PROG_LOAD could trigger this path. Meanwhile, the
module's init function might call register_btf_kfunc_id_set(), which uses
krealloc() on the same array.

Could the sets array be freed by krealloc() while the verifier is performin=
g a
binary search on it here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710005902.2234=
832-1-ihor.solodrai@linux.dev?part=3D1
