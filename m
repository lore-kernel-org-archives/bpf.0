Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613773;
	b=LVC97Hsgc1YRdwWPWISuQM0HYULzkeIOHzmiRbEOhUjwkUZdU8de2Fv9heu7Iep9BBw9
	 bfStPMW8Q1nh4MAaHkHj5FlmYLmaCFomC2584VRv8uAiOIrxyo41QW8exKn2Yb/kbRMU5
	 caqOiQf8RIUiNOtwvtcb6lYRaHe9mzwP5VrCYbOZIffKZTdRynJ7Vd2ahXhVxWUs7q9GP
	 VYuxEQxWJH2cctcX1qF43dBxpywgFtvmGlkyIrxdlhnlXUpc8351t2V+/klgHrQ87e2YF
	 yrK4xl3LjcoCKZNt2ml2nN9qAtzUCd8JN5CGn/JJVZnq/1YOAJF11/VHEfpT95rR0ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613773;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=avp9cqTtWpYaZT22vY285NGVGfC3NkBdRxMRGQ2R0g8=;
	b=tuMXjt9IgoaPTbKHUiWZeuOgtKh+wO2dXToZ1KJUBVNMyc9r7fPiNDpCQ+8RcDTi4WWn
	 jHnD1KDRf+9JuKPLf7eJ5M8+QNQX5S5SSjHGAPFZBU4iEG5zNvg4oFo1YA0kG4CconUwf
	 iWugGJGd7nmR6k/7MNaK1rXTaTGEZRaqcDbvxSPuf3VVS0GgdlALGyqfaMSERepYWEJar
	 PASgoi3P785YsWzYs6be1jomIPh3d+y3i9YCy6xP1i+oV1/6U4vBFQOkHBDmw2I8GabrF
	 Z5UWgF6/461n2L0WLFPQot0xgOk+bms4tYz2O+H7hwyejrk23NaHVrCXxk9kL3FKXWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcBdPivZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08300606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcBdPivZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5D81F000C1;
	Wed, 21 Oct 2026 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792613772;
	bh=avp9cqTtWpYaZT22vY285NGVGfC3NkBdRxMRGQ2R0g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PcBdPivZTEymGLZSB54jbgg0KCMSP61BdKHXwK9IcsCh/9lGFIl2KnSGFE7LWSl3z
	 NqVzQC1779XJWXUwtXgU/SVX2wzxc/qZ5RJSpks5Wo2yrzsg54CIJm2r5GiNpSp/z5
	 GL845GygvpQu+Xfadh1ovEgaY/+WNThmmApbfobHVff2MskTuiOQufDM4+gqZ/eyNM
	 fip9xSL+lh6nwvRq1DBpBp7gyBe+gSim9yyEyh4iriHp7Xh6mhPRsPbAYGKUn8NWeA
	 ilpSZC2pSYIIe+gedZrr7f+/CYZ6dhaZznYuYQp3WjCNof8SkcYP7beyCTtvi543iD
	 ojzdoYpr+3wpQ==
Message-ID: <sashiko-outbox-180635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 1/9] bpf: Add __srcptr kfunc argument suffix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, linux-mm@kvack.org, "Andrew
 Morton" <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>
In-Reply-To: <20261021195759.119421-2-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <20261021195759.119421-2-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:16:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: __srcptr ignored for scalar-struct pointers in resolve_func=
_arg_type()
- [Low] bpf: docs: short section underline for __srcptr in kfuncs.rst
--

commit 5dcfefa11540873e12bd9cbd04017e587c3a3f23
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Add __srcptr kfunc argument suffix

This patch adds the __srcptr suffix annotation for BPF kfunc pointer
arguments so that the verifier checks them with MEM_RDONLY instead of
MEM_WRITE. It also documents the new annotation in
Documentation/bpf/kfuncs.rst.

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 73578a4c3b1fb..6466b76fd721e 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -351,6 +351,29 @@ In this case, a program attached to the ``inode_init=
_security`` LSM hook
>  can pass the hook's own ``xattr_count`` argument through to the kfunc,
>  which claims xattr slots by writing through it.
> =20
> +2.3.10 __srcptr Annotation
> +-------------------------

[Severity: Low]
The section underline in Documentation/bpf/kfuncs.rst is 25 dashes while the
heading is 26 characters long, which causes Sphinx to emit a "Title underli=
ne
too short" warning when building the documentation. Should one more dash be
added here?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..7dd7b172a2971 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14137,7 +14151,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>  				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
>  			return -EINVAL;
>  		}
> -		arg_type =3D ARG_PTR_TO_MEM | MEM_WRITE;
> +		arg_type =3D ARG_PTR_TO_MEM | mem_prot(meta->btf, &args[arg]);
>  	} else if (btf_type_is_struct(ref_t))
>  		/* A pointer to a struct without a size argument is classified as ARG_=
PTR_TO_BTF_ID */
>  		arg_type =3D ARG_PTR_TO_BTF_ID;
> @@ -14162,7 +14176,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>  			return -EINVAL;
>  		}
>  		proto->arg_size[arg] =3D type_size;
> -		arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
> +		arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | mem_prot(meta->btf, &ar=
gs[arg]);
>  	}

[Severity: Medium]
Should resolve_func_arg_type() in kernel/bpf/verifier.c also use
mem_prot(meta->btf, &args[arg]) instead of hardcoding MEM_WRITE?

In get_kfunc_arg_type(), a pointer to a struct or union without a following
__sz or __szk argument matches btf_type_is_struct(ref_t) and is classified =
as
ARG_PTR_TO_BTF_ID, bypassing the final else branch above.

Later, when a BPF program passes a non-BTF-ID memory pointer (such as
read-only map values from .rodata, PTR_TO_MEM | MEM_RDONLY, map keys, or
stack memory) to a kfunc parameter pointing to a fixed-size struct or union
composed of scalars, check_func_arg() -> resolve_func_arg_type() converts t=
he
argument type to fixed-size memory, but still unconditionally sets MEM_WRIT=
E:

kernel/bpf/verifier.c:resolve_func_arg_type() {
	...
	if (!btf_type_is_scalar_struct(env, btf, ref_t))
		return 0;

	resolve_ret =3D btf_resolve_size(btf, ref_t, arg_size);
	if (IS_ERR(resolve_ret)) {
		...
	}
	*arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));

	return 0;
}

Because MEM_WRITE remains set for scalar-struct pointers annotated with
__srcptr, won't the verifier still reject read-only memory arguments and
clobber spilled stack slots?

> =20
>  	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021195759.1194=
21-1-jolsa@kernel.org?part=3D1
