Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513751;
	b=kikOEowC0iWMAlE0r2SgALAovBCbbiR7KRdDuaZd244s+gCF0nwb1azHor167I/dYOwn
	 JqlMLU+KDUIHn8P9ltQCJWBvKBzS/J/mUiCt6fkkY9v9fwaRn7GcVMs6ibzu25wNMIFyU
	 5X0tzUlVXpt4SFpaiC7Yghq7Al7ILbgAOAabdRMFEkKJsVTA1Ree8U/xcA0CJrpFRdqg9
	 KsmvuHpDk4DTNnNrpsww1SUfGE1OZnWPGTYVo7BWMlyNdcE8mezhJYO7UW/xQdqtCYQ9b
	 alDNDGv0G3qqWyptdy7gBeUlqOkUiM/NzsK641se+FcimC5kNPvkME4L/lmzZPQxblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513751;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fNRNqnCvcuqrWlc9zHZXAYfXTtyd3Hgu36FaAxzucZw=;
	b=umY9gCSkMZ2f4LPpoGTsiIYy8dlBBli18o4CyttqlCi2IeR8zeNOlzt3P1r06PQbuW0S
	 P1jirzSNbDyjHUt+zDAgZqApvNQ2pjHatk9dU9a3MbVf7gvnDxqEbvWKa6LULhpl2a86W
	 xm76mibyPH7puK/BA54j958cUq6GpjD5+ggnDdh7EjjjAOAzg/h79+iFMsDL6+dfJ+KvL
	 mjoa58zCTN/HPXGe9u6jt68Kipv/XUWzfGCRamBd5kWSHNVmFOCL8tcnCpWWlRRfX9izZ
	 sd5Ri/MYNjUfp1Ag64sBpTgg4A3pV4eOd76ijRgSLZmqy2hiC9OKx9kfRqB4C8HjNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1C606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927781F000C4;
	Tue, 20 Oct 2026 16:29:10 +0000 (UTC)
Message-ID: <sashiko-outbox-179351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 10/12] selftests/bpf: Cover the low-32 link
 for narrowing stack fills
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020161907.2115379-11-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-11-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:29:09 +0000
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
- [Low] selftests/bpf: misplaced ifdef in sext_byte_fill_drops_sext_link()
--

commit 0f3b5c981ef84ecf43731c167adb9d7addf744eb
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Cover the low-32 link for narrowing stack fills

This commit adds eight BPF verifier selftests covering low-32 scalar link
tracking across narrowing and sign-extending stack fills, and introduces a
CAN_USE_LDSX macro in bpf_misc.h to guard tests that use sign-extending
loads.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 69efe1381eca9..ab78285153fb1 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
[ ... ]
> @@ -1494,6 +1591,215 @@ __naked void sext_drops_stale_step(void)
>  	: __clobber_all);
>  }
[ ... ]
> +/*
> + * BPF_REG_LINK_SEXT says the register is (s32)(base + delta) -- a 32-bi=
t sign
> + * extension specifically. An 8- or 16-bit ldsx is a different relation,=
 so
> + * the exemption that keeps a sign-extending link across a sign-extending
> + * load has to be gated on the load width. Ungated, r2 below claims to be
> + * (s32)r6 when it is really (s8)((s32)r6).
> + */
> +SEC("socket")
> +__success __log_level(2)
> +#ifdef CAN_USE_MOVSX
> +/*
> + * Needs MOVSX as well as LDSX: the BPF_REG_LINK_SEXT under test is buil=
t with
> + * r7 =3D (s32)r6, and only the byte fill below is an ldsx.
> + */
> +/* a surviving link would print as R2=3Dscalar(id=3DN+0.sx,smin=3D... */
> +__msg("(91) r2 =3D *(s8 *)(r10 {{.*}} R2=3Dscalar(smin=3D")
> +__naked void sext_byte_fill_drops_sext_link(void)
> +{
[ ... ]
> +}
> +#endif /* CAN_USE_MOVSX */
> +
> +#endif /* CAN_USE_LDSX */
> +
>  char _license[] SEC("license") =3D "GPL";

[Severity: Low]
Should SEC("socket") and __success __log_level(2) on
sext_byte_fill_drops_sext_link() be placed inside the #ifdef CAN_USE_MOVSX
block?

In tools/testing/selftests/bpf/progs/bpf_misc.h, CAN_USE_LDSX and
CAN_USE_MOVSX can be enabled independently via __BPF_FEATURE_LDSX and
__BPF_FEATURE_MOVSX (for example, with bpf-gcc -mldsx/-msmov flags).

If CAN_USE_LDSX is defined while CAN_USE_MOVSX is not defined, the body of
the #ifdef CAN_USE_MOVSX block is preprocessed out, leaving those attributes
dangling so they attach to the following _license declaration (or to any te=
st
function added after this block).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020161907.2115=
379-1-vineet.gupta@linux.dev?part=3D10
