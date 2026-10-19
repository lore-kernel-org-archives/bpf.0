Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032294F96C4
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417717; cv=none; b=W63tAmL1eiaYBtScXwOP04GtcQTvqk2V77iUTMxC9dRlhfzznkQcibS3CIUn11fCMxZPxGBlR4V0pipYmmCxCJVGrYlZRzHQasVXu01K85RvpZ1odMdT+nuVvgOG5k46CVWcuBXw/BxqlmwJumd3GOS8bdyL7jE/jytNDZ6oA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417717; c=relaxed/simple;
	bh=Yc6DiztdEElFDqRAYT9Ikc5y3uDeNk0F+gBDom8n+7g=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=IdcJtaz+18V4x6/H+lh9Mka8yzXO7Jqmk1W80qUsnJbyJqZdarM4PLFrCpaBi0+AluibIyGM0erq0oAjVKNiRz1TfLsipXX9V0AFlS5gyPr33hGvDc1w+lW3ISv7kBTgAa7e0G5Bht99xqGo1xIsQngP5UHCBJ7U/JaEcoHVmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOWao7XU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOWao7XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6301F000C4;
	Mon, 19 Oct 2026 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417714;
	bh=Ku2wO+pDIXGkci4ihUIPJZpudHsHvNC/iDFUtnPhahg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QOWao7XUlBiF1Mu2u7WtRED/jn+1/mBVODqp9rjbHE0BvUUiOpDdjcYtcOR2KHHAb
	 O0NXDJ77jfyYjE9bfJeTUub8y1rAdHZYZ6cocTHe3GoQxwegW64TDoWSrjYQBjn8nP
	 xGAv+WOe5BlOA4RHvLAj9bOP3pSdVHWERFZg7/RguVeNU+qCA8Kx4vawutwsYIrerB
	 hqTvd+KnZ9L87l10PW8cclYM8OD/+KCeuYTbkA1Q3zVSQpQVdKIEEaNvFuJOR2KrPx
	 Bi9f5OOY2NXFeG/hr5wDx1Q7BPYCfLtlxIjfiY4wDEMPViEIQZaSHY9OcsxOsCMvmA
	 BYkQ92kO6YcQQ==
Message-ID: <sashiko-outbox-177221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 01/16] bpf: Check exclusive maps once the
 program digest is final
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261019132203.3034698-2-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
 <20261019132203.3034698-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:48:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: unauthenticated CO-RE relocations after bpf_prog_verify_signa=
ture()
--

commit 32dc3dc6de06a5dac6e79c2b94b85778ecf062a2
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Check exclusive maps once the program digest is final

This commit defers the exclusive map hash comparison and map claiming until
check_and_resolve_insns() has computed the program digest after CO-RE
relocations. It also removes the early bpf_prog_calc_tag() call for signed
programs before process_fd_array().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d138688468236..ca5301fe3f66c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23619,11 +23657,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  		ret =3D -EINVAL;
>  		goto err_prep;
>  	}
> -	if (env->signature) {
> -		ret =3D bpf_prog_calc_tag(env->prog);
> -		if (ret < 0)
> -			goto err_prep;
> -	}
> =20
>  	ret =3D process_fd_array(env, attr, uattr);
>  	if (ret)

[Severity: High]
Can removing the pre-relocation digest check allow unauthenticated CO-RE
relocations to mutate a signed program's instructions after
bpf_prog_verify_signature() and security_bpf_prog_load() have succeeded?

In bpf_check(), bpf_prog_verify_signature() verifies the PKCS#7 signature
over the pre-relocation env->prog->insnsi and the frozen map value contents
before BTF and CO-RE relocations are processed:

    ret =3D process_fd_array(env, attr, uattr);
    if (ret)
        goto err_prep;

    if (env->signature) {
        ret =3D bpf_prog_verify_signature(env, attr, uattr.is_kernel);
        if (ret)
            goto err_prep;
    }

    ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
                     uattr.is_kernel);
    ...
    /* Prepare BTF and func_info needed to discover all subprograms. */
    ret =3D bpf_prepare_btf_info(env, attr, uattr);
    if (ret < 0)
        goto skip_full_check;

    /* Apply CO-RE before validating the program's instruction layout. */
    ret =3D bpf_check_core_relo(env, attr, uattr);
    if (ret < 0)
        goto skip_full_check;

Although fd_array_get_btf() and __add_used_btf() reject BTF objects from
fd_array when env->signature is set, bpf_prepare_btf_info() loads
attr->prog_btf_fd via btf_get_by_fd() without checking env->signature, and
bpf_check_core_relo() applies caller-supplied attr->core_relos to
env->prog->insnsi in-place.

Furthermore, in bpf_prog_verify_signature(), the signature only covers
env->prog->insnsi and the map values, not map->excl_prog_sha:

    if (!map->excl_prog_sha) {
        verbose(env, "signed program metadata map '%s' must be exclusive\n",
            map->name);
        err =3D -EPERM;
        goto out;
    }

The 32-byte hash stored in map->excl_prog_sha is supplied by userspace at
BPF_MAP_CREATE time via attr->excl_prog_hash (and a signed program with
env->used_map_cnt =3D=3D 0 has no exclusive map at all).

Previously, for a signed program with an exclusive map, bpf_prog_calc_tag()
computed env->prog->digest over the signed instructions before
process_fd_array(), and check_map_prog_compatibility() required
map->excl_prog_sha to match that pre-relocation digest.

With this change, check_excl_maps() only compares map->excl_prog_sha against
env->prog->digest after bpf_check_core_relo() has already mutated the
instructions:

    static int check_excl_maps(struct bpf_verifier_env *env)
    {
        int i;

        for (i =3D 0; i < env->used_map_cnt; i++) {
            struct bpf_map *map =3D env->used_maps[i];

            if (map->excl_prog_sha &&
                memcmp(map->excl_prog_sha, env->prog->digest, SHA256_DIGEST=
_SIZE)) {
                verbose(env, "program's hash doesn't match map's excl_prog_=
hash\n");
                return -EACCES;
            }
        }
        return 0;
    }

If a caller takes a validly signed program and metadata, supplies a crafted
prog_btf_fd and core_relos (such as BPF_CORE_TYPE_ID_LOCAL, where
bpf_core_calc_relo_insn() sets targ_res->validate =3D false and
bpf_core_patch_insn() overwrites insn->imm or insn->off without validating
the original immediate or offset), and creates the exclusive map with
excl_prog_hash set to the SHA-256 of the post-relocation instructions,
wouldn't both bpf_prog_verify_signature() and check_excl_maps() succeed whi=
le
loading modified instructions with BPF_SIG_VERIFIED?

Should signed programs either reject attr->core_relos_cnt (or prog_btf_fd) =
or
ensure that env->prog->insnsi cannot be modified after
bpf_prog_verify_signature()?

 base-commit: 25bb03f0a47b622b9025a1558bf2095ec1f55d26
--=20
2.53.0.1073.g0031eab094-goog

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019132203.3034=
698-1-memxor@gmail.com?part=3D1
