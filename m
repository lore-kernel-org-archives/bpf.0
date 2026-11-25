Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578724;
	b=n5H5ZEncZphGhGKuKnuCn8gtaC8A/tZKOrOpzpvaEYOUS+syt08ANt8KMylAnCDCp5ke
	 aGVr5eZzbE+LpzU44SpYUzW7NJjereqvkkrnwP1DMbhVShyE9sDAdXKvX4UfUaNzvqFqd
	 wkBxzrUq2Nex2tYr995KOfqufzuqET1g1hEWXEjeYbE6sftvw04hY+puU0w3QUBXP0D0r
	 TcPBtxVSFJVT4G2ZSr8ZQ0FY19GTIRon5mHUp4iCw0qBI2O4NPehEJ1NXDNRoZKKf/TZh
	 iRLRJmWOpGWL4B9AQMDYVusCGbBOjOUUHMFvrvjm1wo/ApHlbY7zmCeQ/Txt5JuTdfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578724;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/txUkQLbhGzsCk4PK18N+md78VXO625oZFre0CyKBSQ=;
	b=nwdVCCQXu7eS2pOBBrlgS7gtQORHhrB1UGnQlTS8uGvxj1/AiBW7tQx1sxWCGO4y/S9u
	 tf+k4fuOs7j8HJMYk3W2+5sploFhm02BRe8L6D3K9J0M/pOSD/aakYRCgoX/JLtvJaxzW
	 IKsPhOe/UkMnRV0kwOBdcEQ7VYfVfyMZCIQbiaPCdGb1Ax8dvE8xlGLgqZjp91vOnbAYK
	 EhfJxTFnSPOdCONOop7mUoKwufCkIK3+To8ymQVtOrzI38zcZoU56aiAZAYkuRk95XL6C
	 JtijLI4BErC4Dv9e7u+/Snnt5XKvipwmT9clNvjWJcfgLS9lW9MyJjFH9BDwVm6MSBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuljR6R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25F606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuljR6R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF73C1F000C6;
	Wed, 25 Nov 2026 03:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795578724;
	bh=/txUkQLbhGzsCk4PK18N+md78VXO625oZFre0CyKBSQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iJuljR6ReYxf+cJ1y9BXEtGnWL2f/ZuPKVN5jp/8eAk99ovIGf0RcNN5dVk4eJWmq
	 VYZ+xuR+a87kcD1qDSvGD6PwUk1bG/aHesBg46mPRMW0OVjOQeHq6YfvIxyfn6nm/F
	 ZF6uF0hpvwEQQLgQZJjh9AfzgdVwMEDAXMa2pfQ5IoMLmrNI72362s8El4KdYYdcTM
	 ynvhzvUU/nC42b6hiX2mEs9H1pnWk6LAMxUS1D0ixtl/HL5pUIVDVwj7TSm6EBcBhU
	 vJpgbNxQ2s5yPVyxJKzOqlAwlu53TLLClIE0SxV74Jsw8Tpo+T2NFU3gq48a7QMVIm
	 xVoLqF3xH/RgQ==
Message-ID: <sashiko-outbox-232521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 23/47] bpf: Fix reads past an enum in prints of BTF
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-24-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-24-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:52:03 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: truncation of 8-byte enum values to 32-bit int in
  btf_enum_show()
- [Medium] bpf: hardcoded 32-bit bitfield limit in
  btf_enum_check_kflag_member()
--

commit c14b9d6d46e8fb4261828cf2cb022187e0695c07
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Fix reads past an enum in prints of BTF data

This commit changes BTF enum printing and struct member size validation to
use the actual size of the enum type instead of assuming 4 or 8 bytes.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8c934aa8ad609..7b3291556e6ee 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4579,7 +4579,7 @@ static int btf_enum_check_kflag_member(struct btf_v=
erifier_env *env,
>  			return -EINVAL;
>  		}
> =20
> -		nr_bits =3D int_bitsize;
> +		nr_bits =3D member_type->size * BITS_PER_BYTE;
>  	} else if (nr_bits > int_bitsize) {
>  		btf_verifier_log_member(env, struct_type, member,
>  					"Invalid member bitfield_size");

[Severity: Medium]
Should int_bitsize also be computed from member_type->size * BITS_PER_BYTE
for the bitfield check?

Leaving int_bitsize hardcoded to sizeof(int) * BITS_PER_BYTE causes
btf_enum_check_kflag_member() to reject valid 33..64-bit bitfields of
8-byte BTF_KIND_ENUM and BTF_KIND_ENUM64 types, while accepting 1-byte or
2-byte enum bitfields with nr_bits up to 32.  When __btf_struct_show()
formats such an oversized bitfield on a 1-byte or 2-byte enum,
btf_show_start_type() only ensures member_type->size bytes remain in
show->obj.safe[], whereas btf_bitfield_show() copies
BITS_ROUNDUP_BYTES(bitfield_size + bits8_offset) bytes and can read past
the end of show->obj.safe[].

> @@ -4662,12 +4662,30 @@ static void btf_enum_log(struct btf_verifier_env =
*env,
>  	btf_verifier_log(env, "size=3D%u vlen=3D%u", t->size, btf_type_vlen(t));
>  }
> =20
> +static s64 btf_enum_read(const struct btf_type *t, const void *data)
> +{
> +	bool sign =3D btf_type_kflag(t);
> +
> +	switch (t->size) {
> +	case 1:
> +		return sign ? *(s8 *)data : *(u8 *)data;
> +	case 2:
> +		return sign ? *(s16 *)data : *(u16 *)data;
> +	case 4:
> +		return sign ? (s64)*(s32 *)data : *(u32 *)data;
> +	default:
> +		return *(s64 *)data;
> +	}
> +}
> +
>  static void btf_enum_show(const struct btf *btf, const struct btf_type *=
t,
>  			  u32 type_id, void *data, u8 bits_offset,
>  			  struct btf_show *show)
>  {
>  	const struct btf_enum *enums =3D btf_type_enum(t);
>  	u32 i, nr_enums =3D btf_type_vlen(t);
> +	/* Old compilers don't set the flag for negative values */
> +	u32 mask =3D t->size < 4 ? BIT(t->size * BITS_PER_BYTE) - 1 : U32_MAX;
>  	void *safe_data;
>  	int v;
> =20
> @@ -4675,10 +4693,10 @@ static void btf_enum_show(const struct btf *btf, =
const struct btf_type *t,
>  	if (!safe_data)
>  		return;
> =20
> -	v =3D *(int *)safe_data;
> +	v =3D btf_enum_read(t, safe_data);
> =20
>  	for (i =3D 0; i < nr_enums; i++) {
> -		if (v !=3D enums[i].val)
> +		if ((v ^ enums[i].val) & mask)
>  			continue;
> =20
>  		btf_show_type_value(show, "%s",

[Severity: Medium]
Does storing the s64 return value of btf_enum_read() into int v (and
masking with u32 mask) truncate 8-byte BTF_KIND_ENUM values in
btf_enum_show()?

When t->size is 8, btf_enum_read() reads 64 bits via its default branch,
but assigning the result to 32-bit int v discards the upper 32 bits.  An
8-byte BTF_KIND_ENUM value with non-zero upper bits will falsely match an
enumerator whose 32-bit value matches the lower 32 bits, or print a
truncated 32-bit integer when unmatched.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D23
