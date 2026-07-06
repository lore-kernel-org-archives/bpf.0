Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9C329E7E
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348013; cv=none; b=mgKss7w0SePRO8DF4xhnGInA3p0Z5d+tzJGeIw24av6FWarM4UAXE8yj2SGNKl/ZIsSEGqa+7Yc+ur8p2PKun4qd2gMPHjxzCYFPnhLuaNd8dZXDoiztuxCweuGIsYZ9f+Hpl6mT3VTm//jfEGbIjvCantOWZ3Sf5uKnvLNohvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348013; c=relaxed/simple;
	bh=4pYl8blXZs17A2ku9nv5sW7MRud2XgxllX6C/bP2dtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LFlMeGEAev0LmuoyeNCA84ExFCNpbArM8qlN6iOnYsc2v3g5P7yta1KgCkfFYA92TmlUo//gcqx8CkOOIKDVb6yNXGYAiYLsz10CqfnQcTo7szGo7EKedz6Aqw+bnAB9SA/NA2EI9Kp6RnaUfBLL1Cu76GyQn7/sSPF8f6Rwgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzoWhcS2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzoWhcS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3431F00A3A;
	Mon,  6 Jul 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783348011;
	bh=5FphX0DguIoaU/DEw2tbSnQzcVUlntNNzuS4qwnk5Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzoWhcS2mwtRzPXDo+cBToI8+VZi+CKiyLXdkZpcbVqKpiyxQUqfzOENTSuRugHIL
	 s9JlkwbclWq7kJjDhhV6U4wzY9QlfhAcxqPSaB4CWspQSkTu6wu+8/6yAIAiW1GzJc
	 hiiEoXO2tUvBc3g2YOUIvdMObyE0cQqJfBL/a+8AKZFLRiANEje0P9J6eVC+yBiZUO
	 3eYWwciPMUMympaR/pAmOohUd4QEct+vF8mrr+6dyx7Bx2IDQeVDMToPz7P6wSjcI4
	 plSyzKU8QhEjH3Nzu2SjlOS7l84av5KRURJxxZ0aynskpPbcTqrzhhGTJCLoeHO8oy
	 7ffAivtY2daOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/9] bpf: Verify signed loader metadata at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706135644.326006-4-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
 <20260706135644.326006-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 14:26:50 +0000
Message-Id: <20260706142651.4E3431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Moving `security_bpf_prog_load` into `bpf_check` causes the `bpf_p=
rog_free` LSM hook to be executed twice if the load hook fails, or executed=
 without a prior allocation/load hook if `bpf_check` fails early.

Pre-existing issues:
- [High] bpf_prog_calc_tag() fails to mask out kernel addresses for BPF_PSE=
UDO_MAP_IDX and BPF_PSEUDO_MAP_IDX_VALUE instructions, leaking kernel heap =
addresses into the subprogram tag.
--

commit cfb17a8179c5038b966ac26cfe3e81c8fa9ab54e
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Verify signed loader metadata at load time

This commit modifies the BPF loader to verify PKCS#7 signatures over
the loader instructions and its metadata maps. It also moves the
security_bpf_prog_load() admission hook into bpf_check(), running it
after the signature is verified but before full verification.

Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.=
camel@HansenPartnership.com [0]
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00=
.camel@HansenPartnership.com [1]
Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.=
camel@HansenPartnership.com [2]
Link: https://lore.kernel.org/bpf/DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com [3]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e227c76a8dd96..65f53128fc33d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19909,11 +20068,27 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>  	ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_=
log->size);
>  	if (ret)
>  		goto err_free_env;
> +	if (env->signature) {
> +		ret =3D bpf_prog_calc_tag(env->prog);

[Severity: High]
This is a pre-existing issue, but does bpf_prog_calc_tag() fail to mask out
kernel addresses for BPF_PSEUDO_MAP_IDX and BPF_PSEUDO_MAP_IDX_VALUE
instructions?

Looking at bpf_prog_calc_tag() in kernel/bpf/core.c, it only masks the
immediate fields for BPF_PSEUDO_MAP_FD and BPF_PSEUDO_MAP_VALUE:

kernel/bpf/core.c:bpf_prog_calc_tag() {
    ...
    if (!was_ld_map &&
        dst[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
        (dst[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
         dst[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
        was_ld_map =3D true;
        dst[i].imm =3D 0;
    ...
}

During check_and_resolve_insns() in kernel/bpf/verifier.c, the actual kernel
address is written into the imm fields for these instructions. Could this
cause the unmasked kernel heap addresses of BPF maps to be incorporated
into the SHA256 tag of BPF subprograms, allowing a local attacker to
recover the pointer and bypass KASLR?

> +		if (ret < 0)
> +			goto err_prep;
> +	}
> =20
>  	ret =3D process_fd_array(env, attr, uattr);
>  	if (ret)
>  		goto err_prep;
> =20
> +	if (env->signature) {
> +		ret =3D bpf_prog_verify_signature(env, attr, uattr.is_kernel);
> +		if (ret)
> +			goto err_prep;
> +	}
> +
> +	ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
> +				     uattr.is_kernel);
> +	if (ret)
> +		goto err_prep;

[Severity: High]
If this hook fails, does it result in security_bpf_prog_free() being called
twice, or executed on an uninitialized state?

When bpf_check() is called from bpf_prog_load() in kernel/bpf/syscall.c, a
failure routes to the free_used_maps label, which unconditionally calls
__bpf_prog_put_noref() and subsequently security_bpf_prog_free() via
__bpf_prog_put_rcu():

kernel/bpf/syscall.c:bpf_prog_load() {
    ...
    err =3D bpf_check(&prog, attr, uattr, attr_log);
    if (err < 0)
        goto free_used_maps;
    ...
free_used_maps:
    __bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
    return err;
}

Since the security_bpf_prog_load hook frees the LSM state internally on
failure, the resulting error return causes the caller to free it a second
time. Alternatively, if bpf_check() fails early (like in process_fd_array),
this is bypassed entirely, causing a free without the load hook ever
running.

Can this corrupt external reference counts or state maps for BPF LSM
programs attached to this hook?

> +
>  	bpf_get_btf_vmlinux();
> =20
>  	/* grab the mutex to protect few globals used by verifier */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706135644.3260=
06-1-daniel@iogearbox.net?part=3D3
