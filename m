Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362274;
	b=jZthxmxpOWL99jr2oMXMbj4t49niVNOTBEVBiwWCT0KJaERRSlNfwewMOuRd8IPkZuCj
	 9Pkfk4EfchCs0QMXNSNBybSpN2DHJR9C+eYou4ALdhMum6V7i/KaYIuDzE0fp+s27EtHs
	 W73FP+NvIJePdxvr0RrJ4MQKGXdwukaxdotZeOXqNXYc9MDo69X9FD4lGiiA796pje6RZ
	 R9B4PphrclUFZoAXOUViWKJZS0fZc14O32ye6acJSb/AK5UinUbufhArNCZZ5mACJNC01
	 pQNSZgs5KoF0xRNULAZyhxSp5zDQew7bF/3wZZOOIEsD1YUSJzfcHPO6o8Xk0AzMi8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yljzukfVQ6RvifJJrutFp7JpNebDDmCgqLwBlSS8Zy0=;
	b=yHgRNwQ8uKVPzSiP5zwCg+JuZjdxaC7yu+TV8QuJUb92GKg2bIC8G9W8JKCME8aILPi0
	 NRTNK3LqxAfZVN90AYaVzAi9XW8e7Co1JMeggN14h73geM96AWy6Q2zhlTslQ9S6c9zV/
	 KlWgyMPQZYQhSp7Bbsg0n2xd2ApuBETjf0yIt82K0cSj5WvOOTkSuC4iKuPLDe968OxV6
	 oNOiC7UO9NMx44ZtpnOwET4wSxIpNKiyO3Bx2Du27eU+Mw1z1ibvs5nRjKyfzskAq1PTw
	 cbmkKFxad6C5qI702PFBfgMPv/c3i166ahKSY+JHnmuc56KogNOEM6ZRxK9VcaWLEwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+BCjLMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7E606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+BCjLMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC141F0093A;
	Fri, 30 Oct 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362273;
	bh=yljzukfVQ6RvifJJrutFp7JpNebDDmCgqLwBlSS8Zy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+BCjLMhU/81z76Y9nLuspc7zVThSuyX16cyqiqGSWtQ90g4M9J2UKcXKuPHIzlCe
	 rZlKDLYOVWc6hfWgYKf/Q4eqXTwoZ/QoS/cs3mr0vqjUJZBNvNsr6mqXvv4vMGzFbE
	 5IdJDD4gsvnyFCWInUjVAJ71iWXPv6n0G5MhVdj1r+yaoz4DTcpRZKspk2wNN7PojD
	 5bB4ZSaMIRFjsMjnkGFfRt0fy7n0t/UFc+7w+fzSatd7XjzrzGYzPxdByzDmgvnzVo
	 lKoVm/IJdz9ZuzCBaMBwRO5VtdkA67lNe3GWRyH0DrCeEpiaRyRsZbJVKSOojeDwW8
	 H2yYjQZ2gHXRg==
Message-ID: <sashiko-outbox-190997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 07/22] bpf: Let the patch list remove
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-7-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
 <20261030-bpf-verifier-patch-batch-v2-7-55cd43439f7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:11:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: premature prog->len update breaks bpf_find_subprog() in bpf_p=
atch_list_commit()
--

commit 36c5b3c1e86de2cef14800f7c3faaea5d0fafe3d
Author: Qiliang Yuan <odys.yuan@gmail.com>

bpf: Let the patch list remove instructions

This commit adds bpf_patch_list_del() to allow the verifier's patch list to
queue instruction removals alongside replacements, updating line info,
subprogs, function pointers, instruction arrays, and offloaded programs when
committed.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 940265cb80ebf..1a1a374a076b1 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -514,25 +624,43 @@ int bpf_patch_list_commit(struct bpf_verifier_env *=
env)
>  	env->insn_aux_data_len =3D img.new_cnt;
>  	data =3D NULL;
> =20
> +	/* before subprogs are removed, since it looks at them */
>  	for (i =3D 0; i < env->func_ptr_cnt; i++) {
>  		struct bpf_func_ptr *fp =3D &env->func_ptrs[i];
> +		int subprog;
> =20
>  		if (fp->xlated_off =3D=3D BPF_FUNC_PTR_DELETED)
>  			continue;
> +		if (bpf_patch_image_deleted(&img, fp->xlated_off)) {
> +			subprog =3D bpf_find_subprog(env, fp->xlated_off);
> +			if (subprog <=3D 0 ||
> +			    img.new_off[env->subprog_info[subprog].start] =3D=3D
> +			    img.new_off[env->subprog_info[subprog + 1].start]) {
> +				fp->xlated_off =3D BPF_FUNC_PTR_DELETED;
> +				continue;
> +			}
> +		}

[Severity: High]
Can calling bpf_find_subprog() here with the old-image offset fp->xlated_off
falsely mark a live function pointer as BPF_FUNC_PTR_DELETED when the progr=
am
shrinks?

Earlier in bpf_patch_list_commit(), bpf_patch_image_install() updates
prog->len to img.new_cnt:

kernel/bpf/core.c:bpf_patch_image_install() {
	memcpy(prog->insnsi, img->insns, sizeof(*img->insns) * img->new_cnt);
	prog->len =3D img->new_cnt;
    ...
}

When bpf_patch_list_commit() then calls
bpf_find_subprog()->bpf_find_containing_subprog(), it checks the old-image
offset against the already-shrunk env->prog->len:

kernel/bpf/verifier.c:bpf_find_containing_subprog() {
	if (off >=3D env->prog->len || off < 0 || env->subprog_cnt =3D=3D 0)
		return NULL;
    ...
}

If a live static subprogram near the end of the program has its entry
instruction removed (for example, a nop or simplified branch removed in
bpf_opt_remove_nops()) and earlier instruction removals shrink the program
such that fp->xlated_off >=3D img.new_cnt, bpf_find_subprog() will return
-ENOENT.

Wouldn't that cause the subprog <=3D 0 check to set fp->xlated_off to
BPF_FUNC_PTR_DELETED even though the subprogram still has live instructions,
causing resolve_func_ptrs() during bpf_jit_subprogs() to write NULL into the
read-only map slot used by callx?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-bpf-verifi=
er-patch-batch-v2-0-55cd43439f7c@gmail.com?part=3D7
