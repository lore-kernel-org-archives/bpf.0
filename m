Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A023D8902
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367770; cv=none; b=i6ggtYsdNNwnjYvlRVsVOD16d+e5k6TMhEvAypdA9apTPnVRxYZih3pd6LMZrkohDkrlCu4IzMy6aJS149NLFY4Iyp4DgVo3yLVXS+GlyyGWBxiVxBdA25Od6flO2AoQZqZQMqET6SmuIlB9iHnNGRK67+MuLRibf75v1x78jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367770; c=relaxed/simple;
	bh=3K4jO5o9L2B3k9admS9Q0eIBCTGk9WQaYPSzSl/rGKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=joCpa5P5hKAaQ5BCAtJZk96bwDAM3Zz5h4Ofmh3y8SrAVoP3CdZ0qk6V/W2X0l/o4DqDrbeBbSd74E1DUFlUo0/0onyqnG5JJZCi3ECrSIh6wJ6jBcwEPvNLM1+sn/5I8CIBQbBsliIjsGA+9rrStZJ29I/Tfsi/9SQPSHDNomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzdcinlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzdcinlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BAE1F000E9;
	Thu, 21 May 2026 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367768;
	bh=iuJD4uwd+YjO32okP2wzNJATEb6xCXs3qwcZtxC4EqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HzdcinlMAbFdfrhXorMXYu5RFvDyTHklSHNpT/lUk9HVFqZT3ce8Ne9VGXhiadecd
	 e8JEHOaoul5vXgwhGXzoLwl+5+S5n6HdxNBDPf9DUgP0OfzdwUA1bAM/Qw4RkKfyZE
	 +wuiZbi/+jL+W8rKM0fRAIOTrK6VbGQ7KZmCUKW2qKId7tp86EyeLNJ2Dv3i2EwpMe
	 o5OMmFveUJbHEdikzipA8rNLZloO9DiUcmegk41Arvl6s7wZgDgpjLaNWKpOJvgFYv
	 NgX3I2qNXEVRcKmsE7hEJ+Bnph7EAlHwNOi+3fJUC1Aj+TQImvoW+5tyiNr2loD9rS
	 NvpoD6AzIVZOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v11 6/8] bpf: Add bpf_list_add to insert node
 after a given list node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521032306.97118-7-kaitao.cheng@linux.dev>
References: <20260521032306.97118-7-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 12:49:27 +0000
Message-Id: <20260521124928.14BAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `bpf_list_add` kfunc frees the inserted node on runtime fa=
ilure, but the BPF verifier unconditionally converts it to a non-owning ref=
erence, leading to a Use-After-Free (UAF) vulnerability.
- [High] The `bpf_list_add` kfunc is registered with `KF_IMPLICIT_ARGS` but=
 lacks the required `_impl` function and BTF ID, causing the verifier to re=
ject all programs attempting to call it.
--

commit 41c84b8182697296804a152b66297f50e3a604cb
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

    bpf: Add bpf_list_add to insert node after a given list node

This commit adds a new kfunc bpf_list_add() that inserts 'new' after 'prev'
in a BPF linked list. The new node must be an owning reference, which the
kfunc consumes and converts to a non-owning reference upon insertion.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1c69476c8a094..89579165ef4dc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -2577,6 +2577,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf=
_list_head *head,
>  	return bpf_list_push_back(head, node, meta__ign, off);
>  }
> =20
> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list=
_node *new,
> +			     struct bpf_list_node *prev__nonown_allowed,
> +			     struct btf_struct_meta *meta, u64 off)
> +{
> +	struct bpf_list_node_kern *n =3D (void *)new, *p =3D (void *)prev__nono=
wn_allowed;
> +	struct list_head *prev_ptr =3D &p->list_head;
> +
> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, o=
ff);
> +}

[Severity: Critical]
Is it possible for this to result in a use-after-free if __bpf_list_add() f=
ails?

Looking at __bpf_list_add(), it introduces a runtime check that fails if the
prev node doesn't belong to the target list. When it fails, the function
calls __bpf_obj_drop_impl() to free the new node and returns -EINVAL.

However, the BPF verifier treats bpf_list_add() as a list push operation.
During check_kfunc_call(), it unconditionally consumes the owning reference=
 to
the new node and converts it to a non-owning reference, assuming static
success.

If the runtime check fails, the BPF program would be granted a valid
non-owning reference to the freed new node inside the spinlock critical
section, potentially leading to memory corruption.

[ ... ]
> @@ -4756,6 +4766,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT=
_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
> +BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)

[Severity: High]
Does this kfunc lack a required _impl function?

When a kfunc is marked with KF_IMPLICIT_ARGS, the verifier's
find_kfunc_impl_proto() explicitly requires a corresponding _impl function
to resolve the full prototype.

Since there is no bpf_list_add_impl() defined in kernel/bpf/helpers.c and
registered with BTF, fetch_kfunc_meta() will return -EINVAL. Will this cause
the verifier to unconditionally reject any BPF program attempting to use
this kfunc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521032306.9711=
8-1-kaitao.cheng@linux.dev?part=3D6
