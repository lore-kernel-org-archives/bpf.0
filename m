Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CD29BD8C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031815; cv=none; b=sP11LmIZQYBcbf4TxF9lNIi9lHzFN2OSwzH2M0T4+pF+skXFQxL8nJEadb7iJH8nThdGiUsJt69qhVDuLcOYPDAEQ2aR49LnJ9rkVEDpDfApDoBK0hXtovq9LiTrnXEXqS+xSom2Og4VglWLbgW3iMAuii5/xUc4BXPefPGz/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031815; c=relaxed/simple;
	bh=f3mdfPM9EUBB8CukiLnUhVCnCWOCXP5oU/VDTZrgdCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aP1iapJdStzqsSJgp4RetbOdI9mRq0+gOJJeDE8+IWge7leBAWqZiNkptiKrPcwpCKKWJ8y0B09wOOmEPKnRAbZD6+TaI35NZHG4iweczoj+329YuZtlNbjvb501dhv48yfGCgdZ7WYnCWSt1XKfZ2E6ByxEvFkNSFgCWHLldRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7kbkExv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7kbkExv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F781F000FF;
	Mon, 21 Sep 2026 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790031814;
	bh=cthZX2+TPtmmv+7WR7aqj6Yqt4mRvq7Te7d+5rHkyZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7kbkExv2kSXIZELhXu02nW7YX3CNhkChrZeTmV2Mnva4dCZppIdgin5YHzCuaxwm
	 3yvWve3CzybbmdBsE86Wm9BLx+jW3ePjs3M2IErfaERTcb594hOvo1+zayVEthfqct
	 Nu8s7QGTXD/mXVtlfBP5E7NoiFP41lPqrlDj/ynxqbYdnT2foghoWPGVjygtm0wM5R
	 WrzCg+J/SvrG0Xj9ThVGXu04lMJYGq7tA6f5E2ZlaxOG4wTgLn4IbiLiaHcC0kZMfF
	 z4j7RQ9yLe+ZWjaHPIq3UQkJBJCLU6rmM5kVFSEjJdeyirJElh2BJRn0L6oUj8j/Vm
	 iG1wzqQiAq8+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/7] libbpf: BPF programs manual loading and
 attaching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921223937.3203093-3-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
 <20260921223937.3203093-3-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:03:33 +0000
Message-Id: <20260921230334.13F781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_program__load() allows loading from failed object, causin=
g Use-After-Close
--

commit 62d928e64d7108c312cff920bafa876c284cb8bd
Author: Slava Imameev <slava.imameev@crowdstrike.com>

libbpf: BPF programs manual loading and attaching

BPF programs designated as manually loaded can be loaded and attached
independently after the initial bpf_object loading and attaching. This
patch adds bpf_program__load() to support loading these manual-strategy
programs independently.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3085847cb97f..939f0d6378e38 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -9233,7 +9286,7 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
>  			err =3D bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_ma=
ps);
>  	}
> =20
> -	bpf_object_post_load_cleanup(obj);
> +	bpf_object_post_load_cleanup(obj, false);
>  	obj->state =3D OBJ_LOADED; /* doesn't matter if successfully or not */
> =20
>  	if (err) {

[Severity: High]
Could this state assignment allow dangerous program loads if
bpf_object_load() fails?

When bpf_object_load() fails after bpf_object_prepare(), it falls through to
error handling which calls bpf_object_unload() and closes the map FDs.
However, the state is still unconditionally set to OBJ_LOADED.

[ ... ]

> @@ -15386,3 +15501,34 @@ enum bpf_prog_load_strategy bpf_program__load_st=
rategy(const struct bpf_program
>  {
>  	return prog->load_strategy;
>  }
> +
> +/*
> + * This function must be called after bpf_object__prepare (or
> + * bpf_object__load, which calls bpf_object__prepare internally).
> + * Manually-loaded program data is initialized on object prepare.
> + * Post-prepare initialization is not supported.
> + */
> +int
> +bpf_program__load(struct bpf_program *prog)
> +{
> +	int err;
> +	struct bpf_object *obj =3D prog->obj;
> +
> +	if (obj->state < OBJ_PREPARED)
> +		return libbpf_err(-EINVAL);

[Severity: High]
Is this state check sufficient to prevent a use-after-close if the underlyi=
ng
object failed to load?

If an application ignores a prior bpf_object_load() error and calls
bpf_program__load(), this check will pass because the failed object is now =
in
the OBJ_LOADED state (which is >=3D OBJ_PREPARED).

Because the failure triggered bpf_object_unload(), the map FDs were closed,
allowing bpf_program__load() to proceed with stale map FDs.

If a map FD is reused, the kernel might attach the BPF program to an
unrelated map, causing data corruption or security boundary violations.
For programs with BTF, the kernel rejects the load with -EFAULT because
func_info is freed but func_info_cnt remains > 0. For programs without BTF,
the kernel proceeds using the stale FDs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921223937.3203=
093-1-andrey.grodzovsky@crowdstrike.com?part=3D2
