Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD393FD156
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498532; cv=none; b=EjJAdDFOtFVK8/niy6nA/F4T4B7fU2OoHvFF2DV2aKHmYOqD+bkyc01RVSgQkaT/1tIrE5qmzx4Kn6mwnLsgU2F5bskL+aHWsg3hthvRK0g5ncS+Hs8tdivFk3vC43HKDka61aVrZskp3w4ot3o12QTym0SR6Lpsu7UgXeZBBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498532; c=relaxed/simple;
	bh=sYH+Bi1xi9tH7hq/v9xUNWJ0qm6lqvrTlHq9I/k7cA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0Jn0vQ9KprFSi5yqnqzPt3WyFAm6rSrwUjzSt+6jezGoSV0tARlZGkjNPEfLtEEy6TtvLiBFBYZOezxXpBEzu6luT1xcfqubZaMdFWvXUjEP3q5plShI/Fl/WE9TCW/1VvqfAHh6psV2R2zbxf4uDH7PWlpuXSc+Mus1BhQGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHzWa7ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHzWa7ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDE1F000E9;
	Wed,  8 Jul 2026 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498531;
	bh=8LIgJ8Fa6oABKnJIIcKAL0JqU6RIGHHj9zu/RfNIMaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHzWa7MLcV4d6QFiEMqikEZEDud9mrTR43UMrH8a0PLAWdFfVkDiE9lK1Str7KMHE
	 miRmYtG86F+T4IrycV7vBdjv4FFNaslwplYf+R7QKF0QiaazfnFiBmp8uUowGeCrz+
	 FPZuV/MAi0BOKGIprB1yyg43fBMbzc2BpvNnW6kqveGZRLZSFu05q2XpsQvvORTTOf
	 31jA48KUoJ+Fzw3rpBBRmoNMhBNZ4IEmt+8eYOLtdMDTI+0CtC/PlE2P7w43NP4lUS
	 sjSVeudFrLv/7vWqeEgbFrb1u0WYa8iY50UlaAd2N8S7F4rDfOuNL7hQs0tudlvrF4
	 Z5WvTfg379dBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 3/8] libbpf: Drop in-loader metadata check
 for load-time verification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708075343.358712-4-daniel@iogearbox.net>
References: <20260708075343.358712-1-daniel@iogearbox.net>
 <20260708075343.358712-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:15:30 +0000
Message-Id: <20260708081531.37FDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpftool does not include the map contents when generating the PKCS=
#7 signature, which causes the kernel to always reject signed loaders.
- [High] The `run_gen_loader` function in the selftest does not set `attr.f=
d_array_cnt`, causing the verifier to reject the loader program with `-EACC=
ES`.
--

--- Patch [3]: [PATCH bpf-next v6 3/8] libbpf: Drop in-loader metadata chec=
k for load-time verification ---
commit 7b60178a5e722682c8474b704e91ce40e0fc21ed
Author: Daniel Borkmann <daniel@iogearbox.net>

libbpf: Drop in-loader metadata check for load-time verification

This patch removes the in-BPF verification logic from the signed loader,
relying on the kernel to verify the metadata at BPF_PROG_LOAD time. It
also sets fd_array_cnt in skel_internal.h for signed loads so the kernel
can scan fd_array for the exclusive metadata map.

> libbpf: Drop in-loader metadata check for load-time verification
>=20
> The signed gen_loader used to police its own metadata map from within
> BPF: emit_signature_match() read the kernel-cached map->sha[] back
> through hardcoded struct bpf_map offsets and compared it against a hash
> that compute_sha_update_offsets() baked into the signed instructions,
> after a BPF_OBJ_GET_INFO_BY_FD round-trip to populate map->sha[].
>=20
> The kernel now verifies the metadata at BPF_PROG_LOAD time by folding
> the frozen contents of the loader's exclusive fd_array maps into the
> signature, so the loader no longer checks anything itself. Generated

[Severity: High]
Since the kernel now concatenates the map contents to the signed payload
during signature verification in bpf_prog_verify_signature(), does
bpftool need a corresponding update?

Currently, bpftool_prog_sign() in tools/bpf/bpftool/sign.c only signs
the BPF instructions (opts->insns) without including the map contents
(opts->data). Won't this cause the kernel to consistently reject loaders
signed by bpftool with -EKEYREJECTED?

> loaders thus carry no verification logic of their own anymore: Nothing
> in the signing chain depends on emitted loader bytecode doing the right
> thing.

[ ... ]

> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index 74503d358bc8a..53fee53d36d51 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h

[ ... ]

> @@ -400,6 +371,8 @@ static inline int bpf_load_and_run(struct bpf_load_an=
d_run_opts *opts)
>  #ifndef __KERNEL__
>  	attr.signature =3D (long) opts->signature;
>  	attr.signature_size =3D opts->signature_sz;
> +	if (opts->signature)
> +		attr.fd_array_cnt =3D 1;

[Severity: High]
Does run_gen_loader() in
tools/testing/selftests/bpf/prog_tests/signed_loader.c need a similar
update to set attr.fd_array_cnt =3D 1?

Without this, when run_gen_loader() loads the signed program,
fd_array_cnt remains 0. The verifier's fd_array_get_map_idx() will then
see env->signature is set but env->fd_array is missing, which causes
the load to abort with -EACCES and breaks the selftest.

>  #else
>  	if (opts->signature || opts->signature_sz)
>  		pr_warn("signatures are not supported from bpf_preload\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708075343.3587=
12-1-daniel@iogearbox.net?part=3D3
