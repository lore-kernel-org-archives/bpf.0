Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414695;
	b=0U8tXKiUXxfbjsaTJYnB8jyj4ep0gZOXARFWThOoI2sarofrSBj5M80RECxhUa1DNz4O
	 0TgqHE7UDLuwypwsF9N7oW0p1EkXR/otoNHIqlyhkzX0+fGWW8kAUKO1MeOuFu3eMe3kw
	 0uuciszGAOQUwl42u07BrJpZJSe1U1ZIP+wBFztB6BgnQ4EFS3f/tgY+jTRJEvJVbpi0U
	 dspjkxaWx2sNwdI4UFAEM04YOVPzKvbt5oPy6syHFbBd7Sqcp8Bj522+m80ULdBm2G16U
	 u2lw2sFyV3s+6e/lSAxj6YaC86dBCb5fjyk3aWeyJj0SzvuacmfhrZEOQ2U2Um8MMhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d+q912Ue7Mb+rAib7i65+yOlXE51CqiCadjejn3f32w=;
	b=IHzcdP15lakeX5YieRqwhfEqbKpwc9lRsscOQqFl/BNTv+CpYUg2Q1pgMPNZSydTgyIh
	 kTl+jdnFEEX2BMAK3b71uANbcXN/IagwSViCC88pvANSCJU5o1KurO+nL9w0rUaESZysT
	 GLf8wyC767bisP8km+GGcL7tKWDkpDtWCni25Wi10ElgJT8YmVHfuxkQECQRgcUNao/n6
	 zOznr1fckp/3AE/S5KZnddvOHiFJF9q0/Lv4ph0WzBJogZYeyBme7l+2DEZUsWSP9oBk8
	 iAB91NuWkLXopZEnv6vRfyf4PEj5qboTVHY4IlsMsTuoxLYYq8AxMCxYESEkKTJe/2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzvpnPqx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C3606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzvpnPqx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96F11F00A06;
	Wed, 11 Nov 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414695;
	bh=d+q912Ue7Mb+rAib7i65+yOlXE51CqiCadjejn3f32w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UzvpnPqx8BbbQ7ZCne8Mm1PphxSvFtjX5MTMyLPoi9sWevKVbmMFbcrXLrtcyf2SO
	 ZQl32qOyDbmfOHxL1fKwRfX3yvZ8z86aG9Lxtrt70RqOSH7cnLHg5UyvabP64v3nBr
	 Pj4knwBompY/RtZ5lwy6Xikzv7QIK51pn5UGKmCfGZrPkNsg5/7fmgkYszWJCGFNLv
	 2aGYWdXJdgTdTOfgEFuNMX38rUF6LhdFGSn6t7UOjmk0c8kWkLW/7hfP9e2tIDEYry
	 9oeLwoINEuCht1HOvCPw3tiX5pqV4ZYpl6oWZstC124D46he8Wxt6p1g30I6jOGYgs
	 QCodY6QRago3g==
Message-ID: <sashiko-outbox-209292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 17/29] bpf: Apply hidden slot limits only
 when a slot is needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <c426b1de0feb20215a1f4290b607509e3c9d0f7a.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <c426b1de0feb20215a1f4290b607509e3c9d0f7a.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:31:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: multi-resource check bypass for fixed locks in
  bpf_frame_desc_resolve()
--

commit 744e9327531c3db28e3b5167eeaeeddb7a4859e0
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Apply hidden slot limits only when a slot is needed

This commit defers hidden stack slot capability checks from the main
verification pass to bpf_frame_desc_resolve(), rejecting incompatible
acquisitions and releases only when the resource actually requires a hidden
slot.

> diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
> index 72dc6597321a9..0ef7fda410ee1 100644
> --- a/kernel/bpf/frame_desc.c
> +++ b/kernel/bpf/frame_desc.c
[ ... ]
> @@ -507,7 +511,9 @@ static int acq_add(struct bpf_verifier_env *env, u32 =
insn, u16 res, u8 reg, u8 f
> =20
>  /*
>   * refs[@idx] is what acquisition @acq acquired, held by the frame that =
owns
> - * it: its handle is in the slot of the acquisition, and the slot holds =
one.
> + * it. The slot of an acquisition holds one handle: a frame that holds t=
wo of
> + * what it acquired at once is fine as long as the acquisition gets no s=
lot,
> + * see bpf_frame_desc_resolve().
>   */
>  static int ref_set_acq(struct bpf_verifier_env *env, struct bpf_verifier=
_state *st, int idx,
>  		       int acq)
> @@ -518,9 +524,8 @@ static int ref_set_acq(struct bpf_verifier_env *env, =
struct bpf_verifier_state *
>  	for (i =3D 0; i < st->acquired_refs; i++) {
>  		if (i =3D=3D idx || st->refs[i].acq !=3D acq + 1 || st->refs[i].framen=
o !=3D ref->frameno)
>  			continue;
> -		verbose(env, "frame_desc: a frame holds two resources of insn %d at on=
ce, which is not supported in a program that throws\n",
> -			env->res_acqs[acq].insn);
> -		return -EINVAL;
> +		env->res_acqs[acq].multi =3D true;
> +		break;
>  	}
>  	ref->res =3D env->res_acqs[acq].res + 1;
>  	ref->acq =3D acq + 1;
[ ... ]
> @@ -1149,6 +1214,15 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env=
 *env)
>  		}
>  		if (!a->slot)
>  			continue;
> +		ret =3D slot_can_be_kept(env, i);
> +		if (ret)
> +			break;
> +		if (a->multi) {
> +			verbose(env, "frame_desc: a frame holds two resources of insn %d at o=
nce, which is not supported in a program that throws\n",
> +				a->insn);
> +			ret =3D -EINVAL;
> +			break;
> +		}
>  		/* some visit of the insn has nothing a slot can hold where this one h=
as */
>  		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->i=
nsn], a)) {
>  			verbose(env, "frame_desc: insn %d acquires a resource on some paths o=
nly, or one of a type that cannot be released\n",

[Severity: High]
Can a fixed-address lock bypass the a->multi check when a throw site sees
two references on one path and none on another?

For a bpf_res_spin_lock in a single-element array map, two lookups give
distinct reg->id values for the same lock address, so calling
bpf_res_spin_lock() at the same instruction with both pointers records two
references with the same ref->acq and sets a->multi =3D true.  When that
state reaches a throw site, ref_locations() sets cur.fixed =3D true and
cur.cnt =3D 1 for both references without checking ref->id, and site_visit()
increments loc->visits once per matching reference in st->acquired_refs:

kernel/bpf/frame_desc.c:site_visit() {
    ...
	site->visits++;
	for (i =3D 0; i < st->acquired_refs; i++) {
    ...
		loc =3D &env->res_locs[j];
		loc->visits++;
}

If a second path reaches the same throw site holding neither reference,
loc->visits and site->visits are both 2 with loc->cnt =3D=3D 1, so a->slot
stays false.  bpf_frame_desc_resolve() then skips the a->multi check, and
build_site() emits a BPF_FRAME_ENT_FIXED descriptor entry that unlocks the
unheld lock when unwinding from that site on the second path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D17
