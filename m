Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D6212548
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784462187; cv=none; b=tUUtw9P7/BXcx1ljKr7jsq6reov4WeYu+eXSaZ+tDRLUXbPpUjC7FxdccT7mF6mZM5Yxa33uuN5TjfDzvbNJUlO4Q7pkfRjGJ0R/jov1FelZjlN6ckxLVbixSHENlYOu5YJsdmtLECHN/HVeZtXsvwDxdLZMMQ/PR0lHUx5b2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784462187; c=relaxed/simple;
	bh=heINLIEhWIzC1OQ8ODw8zSe/e3BZTSekgHtOcm8OS08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NopiBikwpim20e+CAk2WvW2QWuHrMbvZM4bjtpevWovCwTFpd1UWM1VQW99bNz6qb8A9gesGtIJr30LHmdxZYLj+140jVS4WajBJnsMQ2bAT3FjoYEtKHjFjYf6yf1KHL3S1Vm/W1SOmFwpai38l15fhB0TcfZ+tnZyMtblo5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juyu5HfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juyu5HfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B498D1F000E9;
	Sun, 19 Jul 2026 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784462185;
	bh=mZ40YqmmVHyM+kXotN34KZYCAtlDRFJ/FhizuGTf3bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=juyu5HfDseDfwT3d6xXjpq2lz7TZLdfV/tuzOsNA+zzrObFeVG2kUmOoanyZDrv2P
	 G2fyD5Re+4jpFlYCPBjK+FFGBQlK+d8Xx/01Q6warvfMQHQTTNqb0WVLyzkCHVz3cE
	 Q9JRpMVGuWLeAxulWMmpcafixbKPi8xuifoNodWrKk62wt29mah3iT2bdlGrXiDath
	 EHhL6wG4Lr49mtugdUJk6zC9uv1IU06tJoOWdODk6cPsED3KceN1sa3U/eQ5/78MZ9
	 4cShoBrZ6JyJwSvzL8ayeay036dVw7RYQz08j49yS+f4UYH99pVPlcyIEOym0Frqlb
	 dzXenvnK/LQnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in all
 contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719113551.1294284-2-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
 <20260719113551.1294284-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 11:56:25 +0000
Message-Id: <20260719115625.B498D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] bpf_res_spin_lock() remains disabled for socket filter programs,=
 contradicting the commit title 'Allow bpf_res_spin_lock() in all contexts'.

Pre-existing issues:
- [High] When parsing BTF fields, the check for a valid `bpf_res_spin_lock`=
 offset incorrectly checks `rec->spin_lock_off` instead of `rec->res_spin_l=
ock_off`.
--

--- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Allow bpf_res_spin_lock() in al=
l contexts ---
commit 88a844e18ff8ff22c90389d929ce1c63353b73fe
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Allow bpf_res_spin_lock() in all contexts

This commit removes the restriction that prevents tracing programs from
using bpf_res_spin_lock(). The stated goal is to allow its use in all
contexts.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4446f0bde88b5..bb6e16668d0d1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17815,7 +17815,9 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>  			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;
>  		}
> +	}

[Severity: Medium]
The commit message states the goal is to allow bpf_res_spin_lock() in all
contexts. However, just above this block in check_map_prog_compatibility(),
there is a check that still blocks it:

	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
		if (prog_type =3D=3D BPF_PROG_TYPE_SOCKET_FILTER) {

Does this contradict the commit title by leaving it disabled for socket
filter programs?

> =20
> +	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
>  		if (is_tracing_prog_type(prog_type)) {
>  			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
>  			return -EINVAL;


While reviewing this area, I also noticed a potential issue in another file.

kernel/bpf/btf.c:btf_parse_fields() {
	...
		case BPF_RES_SPIN_LOCK:
			WARN_ON_ONCE(rec->spin_lock_off >=3D 0);
			/* Cache offset for faster lookup at runtime */
			rec->res_spin_lock_off =3D rec->fields[i].offset;
			break;
	...
}

[Severity: High]
This is a pre-existing issue, but does this WARN_ON_ONCE() incorrectly chec=
k=20
rec->spin_lock_off instead of rec->res_spin_lock_off?

If a user creates a BPF map value containing both a bpf_spin_lock and a
bpf_res_spin_lock, and BPF_SPIN_LOCK is parsed first, rec->spin_lock_off wi=
ll
be non-negative. When BPF_RES_SPIN_LOCK is then processed, it appears this
would trivially trigger the warning, which could cause a kernel panic if
panic_on_warn is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719113551.1294=
284-1-memxor@gmail.com?part=3D1
