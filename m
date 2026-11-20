Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163941;
	b=z5qO7Fo5Td7VvrH5zU5jHF2mp/klhh9ikY7S/F/eK6pqx06WNW+7zWtvwIYjThty846p
	 Fj3tsLCe7lgN47H5++Wz+Tb1KkQu9C0Wh1Q5MIgceG9sjCJfFSlkiC42uMSXGK/4Zo3SN
	 0elvvvGU88KtvBuFRN0L1zf4N8GcuohpunMJf0+pv8z2iuTy8kLMKsfO37vEJZ7MvH/Sb
	 sflnhvAu2p12/dFubck2zG30CemDfHxczT1YHL3eo7KjtNcN2ZGNrhwCjv3kcQSpUF4WG
	 xNhj+weLjU23/rtf73GPboslHgl0lig0CBZmY8XDhN6Y1wbUr3YpVqWZvBAgGujPacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UlntU7uAZ8XkTlgYWuarRShjeIjlu2L//m5/ymDzcQU=;
	b=rAoGwhIaY5UFdHyU30gmY8o3expJFG0kJHkcYQ3t5Jb/DTXgfOw832Um9bFzv234KJhH
	 4XE1QFDj4pva7IFD5WVHncOi8QGb0bxOHC8B72ojSf5bIi8sLC8Sxeu+gBw52s4wRg9L9
	 0CAfczy9UbN8w49sRCKiRsmNa0MMyKoUP3dPKP+rWFyCvm8EplkE1rpFgp1W95b7/U5Tc
	 KwWQlh3N1wrgu34MAhmJZOgJcaUnvQdjkZ9xk0ZTrIPVu7WjZv+J3a/r3Ulx5c5TVwgqP
	 M25hvEQvlyZqSeqacHpY5HlqP1NT2sQMnz7SY9lAhUYtRLu+WiFvNvQvFT0M4vuK/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hn/FhgQS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD2606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hn/FhgQS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DB21F000C4;
	Fri, 20 Nov 2026 08:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163941;
	bh=UlntU7uAZ8XkTlgYWuarRShjeIjlu2L//m5/ymDzcQU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hn/FhgQStGPhIMnRhvy/bzO6bVXRrOcl3psvjFn65//LQCtV11UnGJCsraypI7nAc
	 KrYj2fCiHb9rDdOa4LTz1ctst3ASv0arlrIdUMIaGipayy32KEv6FBjc0/wH8IHNjI
	 J8DudumBDHmzhCOphlSciWP45fzNX2mGPciT1j4nH7tksWpkvVseXleJbN8F6nAkN8
	 sxxAHdoqnPbYNG5vB7hwN6nSIVFmFj2H/16qoLOdhausgABpNQ4AEDJhYGPIhM4ZSD
	 2UhXsJ+Y9mCTWex3SZ944/5DoAjsL++EJFihblN68HNLCyi5xKGHvMPo+Pn7OPlltx
	 kZmdiNVX8tKcg==
Message-ID: <sashiko-outbox-224753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/49] bpf: Do not fail a check because a state
 has fewer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-9-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:39:00 +0000
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
- [High] bpf: missing far-offset check in check_ptr_to_btf_access()
  after blur
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] bpf: unaligned memory access in bpf_map_direct_read() [1]
--

commit 22e172eae518ce6c856dc6c4380ea2788200c435
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Do not fail a check because a state has fewer values

This commit avoids rejecting pointer arithmetic with large positive
offsets, range-splitting conditional jumps, and narrow loads from spilled
pointers when a verifier state has a narrower set of values than a joined
state would.

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index 50179edbf348c..61e22636ff890 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -214,6 +214,9 @@ static void const_reg_xfer(struct bpf_verifier_env *e=
nv, struct const_arg_info *
>  			ci_out[r] =3D unknown;
>  		break;
>  	}
> +	/* do_check() has only a range for a far offset */
> +	if (ci_is_map_value(dst) && abs((s64)dst->val) >=3D BPF_MAX_VAR_OFF)
> +		*dst =3D unknown;
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but can the BPF_LDX case in
const_reg_xfer() trigger an unaligned kernel memory access in
bpf_map_direct_read() [1]?

bpf_compute_const_regs() runs before the main verifier enforces alignment
checks.  When const_reg_xfer() folds a BPF_LDX from a read-only map, it
computes off =3D src->val + insn->off and passes it directly to
bpf_map_direct_read(), which dereferences ptr with a direct C pointer cast
such as *(u32 *)ptr.  On strict-alignment architectures, an unprivileged
user loading a program with an unaligned read offset from a read-only map
triggers an unhandled alignment fault and panics the kernel.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 030263d01e3e2..ef8e45a399ca5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -16078,6 +16066,27 @@ enum {
>  	REASON_STACK	=3D -5,
>  };
> =20
> +/*
> + * A far pointer is no error: a state with near offsets gets here, so th=
is one does too.
> + * An access through it is unproven. But a constant offset has to fit in=
 an int.
> + */
> +void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg)
> +{
> +	s64 smin =3D reg_smin(reg), smax =3D reg_smax(reg);
> +
> +	/* an id and a range need an offset that does not wrap around */
> +	if (reg_is_pkt_pointer(reg) && offset_is_far(reg)) {
> +		reg->id =3D bpf_new_id(env);
> +		reg->range =3D 0;
> +	}
> +	if (reg->type =3D=3D SCALAR_VALUE || (smin < BPF_MAX_VAR_OFF && smax > =
-BPF_MAX_VAR_OFF))
> +		return;
> +	scalar_set_unknown(scalar_of(reg));
> +	reg->r64 =3D cnum64_from_srange(min(smin, BPF_MAX_VAR_OFF - 1),
> +				      max(smax, 1 - BPF_MAX_VAR_OFF));
> +	reg_bounds_sync(reg);
> +}

[Severity: High]
Can a far PTR_TO_BTF_ID pointer pass check_ptr_to_btf_access() and
btf_struct_access() after bpf_blur_far_offset() lowers its smin to
BPF_MAX_VAR_OFF - 1?

Unlike check_stack_access_within_bounds() and check_mem_region_access(),
neither check_ptr_to_btf_access() nor btf_struct_access() checks
offset_is_far(reg).  Because bpf_blur_far_offset() lowers reg_smin(reg) to
BPF_MAX_VAR_OFF - 1 with step =3D 1, min_off in btf_struct_access() fits in=
 a
32-bit int even when a huge positive offset was added, and a trailing
1-byte flexible array member (such as data[] in struct
bpf_local_storage_data or ifalias[] in struct dev_ifalias) skips the
max_off upper-bound check:

kernel/bpf/btf.c:btf_struct_access() {
	if (check_add_overflow(reg_smin(reg), (s64)_off, &min_off) ||
	    check_add_overflow(reg_smax(reg), (s64)_off, &max_off) ||
	    min_off !=3D (int)min_off) {
		...
		return -EINVAL;
	}
	...
		array_start =3D min_off - arrays[i].off;
		/* An array within the flexible tail has no upper bound to exceed */
		if (array_start >=3D flex_off && btf_type_is_array(t) &&
		    btf_type_array(t)->nelems =3D=3D 0)
			return ret;
}

For a PTR_TRUSTED or MEM_RCU pointer, bpf_may_fault_on_deref() is false, so
the load is not rewritten to BPF_PROBE_MEM and can read arbitrary
out-of-bounds kernel memory or fault in kernel mode.  Checking
offset_is_far(reg) in check_ptr_to_btf_access() would reject far BTF
pointer accesses.

[1] https://sashiko.dev/#/bug/linux-ad386ec5-9f86-4c83-a85e-b56e4d8748cb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D8
