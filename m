Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7882F99B8
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783748403; cv=none; b=czvimsQS8TeJet5O1yxKk0b1N+Y9RzR0OWHREpNe11hMFv4FY7zIoyeiHmIkhq03L1/OhUDNq+EV5s8svhGktsqv+Np8QaABx5IkkEOIvsuBrUC9gus78cFzGiixe5dSamiLUrsaQBmLJDDFLwxm1rEfmkSogLlTQbgirEXWhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783748403; c=relaxed/simple;
	bh=H9Dm5VktQ3Y1PxNkpUV7uC7CAK0LsjjacjgzQuZlsww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+F8dd4AjWQCulD+FIViYJNwJeVmDrwym1Sug2wKz33P9+GZcweBTkk3TgZZmU3E7LbctidpLUtRxZ0sAxVJz0B0lzjoCGt00KtNazPAMQPKX9BuXTHgj1OU49Ok9iwbMZ7eJrFsTOCuuuTtV6caMCKs9uJuajbl0VAMd431ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGcvCGrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGcvCGrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC62D1F000E9;
	Sat, 11 Jul 2026 05:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783748401;
	bh=FDNEabBmFS8n+NeeTajK2hIBNBE5cDH4D5NaCGYAc6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGcvCGrWDc9hq4H1PsB5/9hcMymsAVW0JB11yiIG8tnzOgg50HTAUjy9l4hMkXHRu
	 BqcfBO6Rqb8TD/WE4hvebl6m8kwzZWbjyV2aAY33LwsIyPF6c8vhjXOgYufHgLT3Ef
	 Mygq1dHIbnBmWiJDq/78bf5wyG9xh6UpiAdp5XL5xozwLFOUDjmRyzpMXuTjOI6AZZ
	 TsD5vIyr7IN9g6sQcpmu+FhyEtFR5B+YILC3CO+gsfF9Ml21EjI5f037M841iGF6DW
	 DjEnqp0KrWSzdU4uzIHKxI8x4j6kAfL1CwikJd2spEH6u1ZRCe+uWh7tyRnbF09RHQ
	 ge4aRWVNNChhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore
 subprog_starts and prog clone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
References: <cover.1783775928.git.xukuohai@huaweicloud.com>
 <329e83120f0d88c2e5dc9d7bb2c0d38988959d32.1783775928.git.xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 05:40:00 +0000
Message-Id: <20260711054000.BC62D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `env->prog` in `bpf_fixup_call_args()` due t=
o cached pointer being freed by `bpf_jit_blind_constants()`.
--

--- Patch [2]: [PATCH bpf-next 2/2] bpf: Remove unnecessary dup/restore sub=
prog_starts and prog clone ---
commit bd1c64739bd8085adba51ce9687069c667da314d
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Remove unnecessary dup/restore subprog_starts and prog clone

This commit removes unnecessary cloning of BPF programs and saving of
subprog states when JIT is required. It skips these steps because the
kernel will reject the program on JIT failure rather than falling back
to the interpreter.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37f22eb418540..80c8beb45ea04 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1273,35 +1275,33 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  int bpf_jit_subprogs(struct bpf_verifier_env *env)
>  {
>  	int err, i;
> -	bool blinded =3D false;
>  	struct bpf_insn *insn;
>  	struct bpf_prog *prog, *orig_prog;
> -	u32 *orig_subprog_starts;
> +	u32 *orig_subprog_starts =3D NULL;
> +	bool cloned =3D false;
> =20
>  	if (env->subprog_cnt <=3D 1)
>  		return 0;
> =20
>  	prog =3D orig_prog =3D env->prog;
>  	if (bpf_prog_need_blind(prog)) {
> -		orig_subprog_starts =3D bpf_dup_subprog_starts(env);
> -		if (!orig_subprog_starts) {
> -			err =3D -ENOMEM;
> -			goto out_cleanup;
> +		if (!prog->jit_required) {
> +			orig_subprog_starts =3D bpf_dup_subprog_starts(env);
> +			if (!orig_subprog_starts) {
> +				err =3D -ENOMEM;
> +				goto out_cleanup;
> +			}
>  		}
> -		prog =3D bpf_jit_blind_constants(env, prog);
> -		if (IS_ERR(prog)) {
> -			err =3D -ENOMEM;
> -			prog =3D orig_prog;
> +		err =3D bpf_jit_blind_constants(env, &prog, !prog->jit_required, &clon=
ed);
> +		if (err)
>  			goto out_restore;

[Severity: Critical]
Can this lead to a use-after-free if bpf_jit_blind_constants() reallocates
the program?

When prog->jit_required is true, we pass false for the clone_needed paramet=
er.
This means bpf_jit_blind_constants() modifies the original program directly.

If a patch requires expansion, bpf_patch_insn_data() triggers
bpf_prog_realloc(), which allocates a new program structure and frees the
original one.

If functions higher up in the call stack have cached the env->prog pointer
before JIT processing, won't they be left with a dangling pointer? For
example, in bpf_fixup_call_args():

kernel/bpf/fixups.c:bpf_fixup_call_args() {
    struct bpf_prog *prog =3D env->prog;
    struct bpf_insn *insn =3D prog->insnsi;
   =20
    ...
   =20
    if (prog->jit_required) {
        verbose(env, "program requires BPF JIT compiler...\n");
        ...
    }
}

If an error occurs and triggers this fallback path, does it end up
dereferencing the freed prog pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783775928.gi=
t.xukuohai@huaweicloud.com?part=3D2
