Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403995;
	b=BL0pd0NI4sRtRiWmKaVTqfXgSKwQevHi/SPJu250yMulZyMKhTMxP9HEEgqse5ttiAAo
	 BYuWts0Ks7nBOq9APIgcl5Fd/nKa3kmJu8b7Z4zrFU3Bu8++HF6F3YJ8YNFQu2PGmss2U
	 aU95yU3qQuJzCBnCiIZQRtrrnQV7kvJFzXS9jshKp1XDdOB8AnW4HKwOl9IxzaMUIpBG8
	 nqEnw9LGGNRHJg0EESQpsJMxCLruGLFX3fbEjwzCAt1vzuk20aMQ+iECqZeL3+fZ0kimB
	 VA8mT7+EfuxF9h/nrePMsspVIqQ/rFluBIpOY9zZonmgxUBQ1Ycd/Pgze1SIeg3yFGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403995;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=m6Iy8N/aS5DZHpnECoEhMAD0vcbmQ6wNcoZNkW1OkNM=;
	b=TcJAGEqCgzbek0k3dyg6c5lCWVTjbBbuDcMciZ4go/B8tPiqBaYcGLTJyoGFja63dwPx
	 F/drROvfElmUX7/80dfdyxxmUdsmH3skmK3+nZC3d0l/d23BojmahswbI994dxtJXxGf0
	 Q3UYi1q7tvJe3OAF9SYbrxbt0yRA1e5R7zgSFTwaEsuFqpJiyjOKwXnqiVKs6HDDiGTKM
	 suGoyo59JOm70xxbsm8B1fSDUauqpIOkoOh2/0HA6SUi90Me52G5iwOSzdz0GupN9n4fL
	 DCM9wZqn7oe/LHH3KmfpT+hCXl9yGZmIqq70e+wyeFWn5CScqNKsY49Y4msgLpdH3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvDBJTvY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF8606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvDBJTvY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29991F00A0D;
	Wed, 11 Nov 2026 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403994;
	bh=m6Iy8N/aS5DZHpnECoEhMAD0vcbmQ6wNcoZNkW1OkNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nvDBJTvYoExVeEl6y5C/i5YHgTg4LrsnyZ0uVg6aNx/67Fn6q5LKA//14OQdraFJX
	 d+1tJ5rlyVugf+OwhjbXBAjf2bCpRbv54Az5wflFkivWlHVsh/uzxdK/TLpYpn3OW/
	 LzYlO8Sf5toMZUmG8mmlXPFY43kyNtx4OVfPnKAXajaIf6kp0Flx3myMsDhzPGA40o
	 wAOZsU6AbU/Ms7fganzKuju+MP2L+GWWrpACyblkMdG9oCwonNnwduJvQfjKoIEJkK
	 Fm+dVzaeueLsEEzrejqg5mKR+x476iTlo9UsDjsEYdKsI/OKr41wcFpKmt1JqkChOg
	 11nCh5u3HfHPA==
Content-Type: multipart/mixed; boundary="===============4534125352478546491=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <72e51049848235f9b6074025fa2a86471cf5676edd45adb4b756ff2fd61eac55@mail.kernel.org>
In-Reply-To: <ffc489a9770015068f1fe344435515d9265600be.1794399387.git.memxor@gmail.com>
References: <ffc489a9770015068f1fe344435515d9265600be.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 08/29] bpf: Add flags and release kfuncs to the dtor registry
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 13:33:13 +0000 (UTC)

--===============4534125352478546491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add flags and release kfuncs to the dtor registry

TL;DR: btf_find_dtor() may fall back by name to a vmlinux destructor for a
same-named module struct, so on bpf_throw() the unwinder could run it on an
object of a different type. Needs a colliding module type.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +/*
> + * Find the destructor entry of type @btf_id of *@btfp, and set *@btfp to the
> + * BTF the entry and its kfunc ids belong to. A module's BTF is split on top of
> + * vmlinux's, so a type below its first id is vmlinux's, with its destructor
> + * registered there; and a struct a module defines under the name of a vmlinux
> + * struct is the same type to the verifier, which passes it to vmlinux kfuncs
> + * by name, so it is destroyed as that type.
> + */
> +const struct btf_id_dtor_kfunc *btf_find_dtor(struct btf **btfp, u32 btf_id)
> +{

[ ... ]

> +	t = btf_type_by_id(btf, btf_id);
> +	if (!t || !btf_type_is_struct(t))
> +		return NULL;
> +	vmlinux = bpf_get_btf_vmlinux();
> +	if (IS_ERR_OR_NULL(vmlinux))
> +		return NULL;
> +	id = btf_find_by_name_kind(vmlinux, btf_name_by_offset(btf, t->name_off), BTF_KIND_STRUCT);
> +	if (id < 0)
> +		return NULL;
> +	dtor = btf_dtor_tab_find(vmlinux, id);
> +	if (dtor)
> +		*btfp = vmlinux;
> +	return dtor;
> +}

The comment says a module struct with the name of a vmlinux struct is the
same type to the verifier and is passed to vmlinux kfuncs by name.  Is that
accurate?

For kfunc pointer arguments, process_arg_ptr_to_btf_id() calls
btf_struct_ids_match(), which uses btf_types_are_same():

    if (id1 != id2)
        return false;
    if (btf1 == btf2)
        return true;
    return btf_type_by_id(btf1, id1) == btf_type_by_id(btf2, id2);

For a released argument the match is also strict, so the struct is not
walked.  Matching by name only happens for the __sk_buff/xdp_md projections
in btf_is_projection_of().

So a program holding a reference to a module's own struct X cannot pass it
to the vmlinux release kfunc of X, yet btf_find_dtor() returns the vmlinux
entry for X.  The commit message says the rule is "if the program could
call the release kfunc there, running the equivalent destructor is
allowed", and this fallback seems to break that rule.

The later consumer, resource_registry() in kernel/bpf/frame_desc.c, only
checks btf_kfunc_flags()/btf_kfunc_is_allowed() for dtor->release_btf_id
against the program.  It does not check that reg->btf and reg->btf_id would
pass the release kfunc's strict type match.

Suppose a module defines its own struct named like a vmlinux cleanup type
that is private to a .c file (bpf_cpumask, bpf_crypto_ctx, bpf_ksock or
prog_test_ref_kfunc), returns it from a KF_ACQUIRE kfunc, and registers no
destructor for it.  Can a program that holds that reference and calls
bpf_throw() then have the unwinder run the vmlinux destructor, for example
bpf_cpumask_release_dtor(), on an object of a different type?

In this patch the fallback is not reachable from btf_parse_kptr(), since
bpf_find_btf_id() searches vmlinux first by name and kind.  No in-tree
module defines such a colliding, non-deduplicated struct, so this needs a
module type to trigger.  The fallback is still present at the end of the
series.

Could the fallback be dropped, or could it require type identity before
returning a vmlinux entry for a module type?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============4534125352478546491==--
