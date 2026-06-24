Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AF2264A9
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312484; cv=none; b=Sg1sSF28XMjGPXu08J2RbvTMty9UM/9xVdlSNqw2Xw14zlfYEh9GjyhHzDCi52XjDYLgERGWC7Bbhubzu3ihCKtknaZEhOACLnM+okLxrOv9VDNPd0OEPu75J5jIj/jfTKFM+VH3WXekZnVlMpCme82lxuD30HT2XEm39/vKgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312484; c=relaxed/simple;
	bh=DCGlV5tKgupYhmskkeXdBsuca7dh7jQHht/gbpwDqGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fojWKGEOxvP5dIr/t4Zvioax72H4fdu5lOfKnB4IX53CT7BscjJAeBEd6gr3gGg9kZzCXSi+XdPGc6ypMyvcLfDJaWgAk0hMSqSKXlBhCV4DW+IqD/9dnxUKEqa8FH0JG0G5W6Z1gdLfWRM0dVDj+Ve2iFvyvIph58jHaUiqafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2suEzyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2suEzyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AADB1F000E9;
	Wed, 24 Jun 2026 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312483;
	bh=srPdht1wisAWRghmcCbuRUFcVlTNUaHaC6Lh/aG5+8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2suEzyCSEoV5RuOUjXD0yscmSqGg9rzoOU0a235OMFjobxoq1/lVjYtkblxGCWTQ
	 QpHqGAqIRli+FrBp0Wq4cYpIikwC6jD0UJpT3smQtr4RXxVfRjmRBAMnkaTAO1zJEK
	 cH/OSltLorQnAZlgK22QYOD6WEBtL2jm3asCLO5Q5PXUctXANvLKYiZcZr+qgH+c0Q
	 AfQRaFfrfSmNgszNynH34sBTnHldvnMfCiE8jnb+6R/xyNgtHJMR7dqgFct0BbU8ih
	 4lV1OTXHHm+L3ZIhKublw7jxCkDZ/FmNHpEeyDLmgvaNUumGci03v9RBBn6eJytdyv
	 l5tgx2iT8DWmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624140301.93421-2-daniel@iogearbox.net>
References: <20260624140301.93421-1-daniel@iogearbox.net>
 <20260624140301.93421-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:48:03 +0000
Message-Id: <20260624144803.7AADB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] TOCTOU race in BPF signed program verification allows bypassing si=
gnature via concurrent modification of user-space fd_array.
--

commit e61d684bd0467f62e035ea0592a8066b9c7246fb
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Verify signed loader metadata at load time

This patch modifies the BPF verifier to perform integrity checking of a sig=
ned
program's metadata array maps before the LSM admission hook fires. It achie=
ves
this by resolving the maps from the fd_array, folding their frozen contents
into the signature verification process, and validating the map count.

Link: https://lore.kernel.org/bpf/CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuu=
LT_i--GskQ@mail.gmail.com [0]
Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.=
camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00=
.camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.=
camel@HansenPartnership.com [3]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281c..9cd2b62da3803 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19895,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>  	ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_=
log->size);
>  	if (ret)
>  		goto err_unlock;
> +	if (env->check_signature) {
> +		ret =3D bpf_prog_calc_tag(env->prog);
> +		if (ret < 0)
> +			goto skip_full_check;
> +	}
> =20
>  	ret =3D process_fd_array(env, attr, uattr);
>  	if (ret)
>  		goto skip_full_check;
> =20
> +	if (env->check_signature) {
> +		ret =3D bpf_prog_verify_signature(env, attr, uattr.is_kernel);
> +		if (ret)
> +			goto skip_full_check;
> +		signed_map_cnt =3D env->used_map_cnt;
> +	}

[ ... ]

> @@ -19966,7 +19966,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	ret =3D check_and_resolve_insns(env);
>  	if (ret < 0)
>  		goto skip_full_check;
> -
> +	if (env->prog->aux->sig.verdict =3D=3D BPF_SIG_VERIFIED &&
> +	    (env->used_map_cnt !=3D signed_map_cnt || env->used_btf_cnt)) {

[Severity: High]
Is there a TOCTOU race with how fd_array is processed between these checks?

If an attacker concurrently modifies the fd_array in user memory after
process_fd_array() runs but before check_and_resolve_insns() reads it again:

1. process_fd_array() reads the array from user space and populates
   env->used_maps with MAP_A and MAP_B.
2. bpf_prog_verify_signature() successfully verifies the signature over
   these specific maps, and signed_map_cnt is set to 2.
3. The attacker modifies the user-space fd_array memory (e.g., swapping the
   FDs for MAP_A and MAP_B, or duplicating MAP_B).
4. check_and_resolve_insns() reads the modified fd_array from user space
   again via copy_from_bpfptr_offset(&fd, env->fd_array, ...) and binds the
   swapped maps to the program's pseudo instructions.
5. This final integrity check (env->used_map_cnt !=3D signed_map_cnt) still
   passes because the total map count remains unchanged, but the
   cryptographic bindings have been completely bypassed.

Would it be safer to cache the fd_array in kernel memory during the initial
process_fd_array() call so that check_and_resolve_insns() does not need to
read from user space a second time?

> +		verbose(env, "signed program uses %s not covered by the signature\n",
> +			env->used_map_cnt !=3D signed_map_cnt ?
> +			(env->used_btf_cnt ? "maps and BTF" : "maps") : "BTF");
> +		ret =3D -EACCES;
> +		goto skip_full_check;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624140301.9342=
1-1-daniel@iogearbox.net?part=3D1
