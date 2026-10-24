Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815890;
	b=bZo5Vsxzq9b/sHcnmXjEfZJl8NeQwWfeiGPizV+6felfXF1R4Te5QZ5eERzoSEgI+sVK
	 +DTGsb7BkTPxerPkYi8ZM16o0QTV4vEABPhY3sX7YZWZHPr6Ub7kWPXDe6BJs5p3/TcHy
	 j4z4ThGtXsdRWYYLvkUF9U5lMjtunYQzPHYQt6ms0arK0sNldUGeTLZ32ET6FzpP8VN8N
	 Z9J+Mozi1R6ZiDYbqEqnKEmVZH15/LkI1ynyLL/rvQQiKD/6aF4RYL1dLGfAP3mAhrIB0
	 7kXj6xkGL9WEkGMObWJXKBseo9G3+fsB2bNIXP3pCNAZFhe83h0UqvIxzwZZYa5x1/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IINRpfUIEaqbSu+FaStzoBvugvvekoZPRaNMbIwggIk=;
	b=a8IGDh8Ca8ywgyR2AIRY5nfj6RtBQNtMLtQwNwpIPBwuMJZiwDtUnsHd9ZAW6XdSQDDo
	 Nm1sg0zl3qKPO93PblAJdyxxLCfW7EveKf3bItrVRorDpYZrTn49bpchJruFgh7gnhaNH
	 IAfJDBhax4foWyOC6OAX3iKOswUdIzr2GABihH6WVir0yd0o45rBFKo77CngWEb7MRRTT
	 czBBXLjB3m7dlceihvzade1EUA4dWvutABHyXgRxOc949YFEVHbdTP9YdV8I244ZXDV5f
	 2Kdp1YjVCRL/d7La3qC+ScTXgP+qtSOGsaWYxcGF1jGJZUrFTe0ePOI1ir5Q3ZiUyKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="obUnH6/g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD13606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=obUnH6/g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7201F01825;
	Sat, 24 Oct 2026 04:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792815889;
	bh=IINRpfUIEaqbSu+FaStzoBvugvvekoZPRaNMbIwggIk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=obUnH6/gjU1iwP+/U2JP8qiJC1UaZKozqSyBDmDTlxP8t3gkdoRNlm3r/XG9pGj55
	 rQCc7WqXW0iqoCJyEhqt6HRKjCsyhpWTOGTXLVZlXKL0kAa3i3AngcheYGMHMZnZZp
	 gGxgj8iDh/XYYFaZhI7cyMyiG3jW+aaTdQEPFrQD3UCCLwphU8lCop8gnUoXWaZ07U
	 b0HqTI3of8D49Nv9XitTAKWu7lNkmEE3D4HxEsOa18acEq50btun9mmFjhaRG8sbPd
	 9n8RDtpU6L3RcCRYlXQmrzz8iMHsW+pke3LIBFWR8A7ZdkTCi13cOyKpdv6caPPEdX
	 jUiSnjRWzfQFg==
Message-ID: <sashiko-outbox-183544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: fix helper macro C++ compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zateev" <hackerowskiy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261024035902.44566-1-hackerowskiy@gmail.com>
References: <20261024035902.44566-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:24:48 +0000
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
- [Low] libbpf: C++ build failure in bpf_for() and bpf_repeat() due to (voi=
d *)0
- [Low] libbpf: missing extern C linkage on bpf_iter_num_*() in bpf_helpers=
.h
--

commit 7e0b0adc8984c99351ff40e7c423f83f7d25ccab
Author: Eduard Zateev <hackerowskiy@gmail.com>

libbpf: fix helper macro C++ compatibility

This commit replaces GNU named variadic macro parameters in bpf_helpers.h w=
ith
__VA_ARGS__ to avoid C++26 variadic macro warnings. It also adds explicit
integer and typed pointer casts to helper macros and generated helper stubs=
 so
that bpf_helpers.h and bpf_helper_defs.h can be used from C++.

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index b37b727ef216f..6c9fdb69661ea 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h

[ ... ]

> @@ -346,7 +367,7 @@ enum libbpf_tristate {
>  		   __bpf_printk /*1*/, __bpf_printk /*0*/)
> =20
>  /* Helper macro to print out debug messages */
> -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
> +#define bpf_printk(fmt, ...) ___bpf_pick_printk(__VA_ARGS__)(fmt, ##__VA=
_ARGS__)
> =20
>  struct bpf_iter_num;
> =20

[Severity: Low]
When tools/lib/bpf/bpf_helpers.h is included directly in a C++ translation
unit without an outer extern "C" block, these kfunc declarations immediately
below struct bpf_iter_num have C++ linkage:

extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __=
weak __ksym;
extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;

When bpf_for_each(num, cur, start, end) is expanded in C++, the compiler em=
its
mangled ELF symbol names for bpf_iter_num_new(), bpf_iter_num_next(), and
bpf_iter_num_destroy() in .symtab, which causes bpf_object__collect_externs=
()
 -> find_extern_btf_id() and kernel BTF kfunc resolution in libbpf to fail
with -ENOENT.

Should bpf_helpers.h wrap its extern declarations in an #ifdef __cplusplus
extern "C" guard, similar to the other headers in tools/lib/bpf/?

> @@ -382,16 +403,18 @@ extern void bpf_iter_num_destroy(struct bpf_iter_nu=
m *it) __weak __ksym;
>   * extension: __attribute__((cleanup(<func>))), supported by both GCC and
>   * Clang.
>   */
> -#define bpf_for_each(type, cur, args...) for (							\
> +#define bpf_for_each(type, cur, ...) for (							\
>  	/* initialize and define destructor */							\
>  	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, jus=
t in case */,	\
>  						    cleanup(bpf_iter_##type##_destroy))),	\
>  	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init =
___it */		\
>  			       *___p __attribute__((unused)) =3D (				\
> -					bpf_iter_##type##_new(&___it, ##args),			\
> +						bpf_iter_##type##_new(&___it, \
> +								       ##__VA_ARGS__), \
>  	/* this is a workaround for Clang bug: it currently doesn't emit BTF */=
			\
>  	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute *=
/		\
> -					(void)bpf_iter_##type##_destroy, (void *)0);		\
> +					(void)bpf_iter_##type##_destroy, \
> +					(struct bpf_iter_##type *)0); \

[Severity: Low]
Here bpf_for_each() is updated to initialize ___p with
(struct bpf_iter_##type *)0 instead of (void *)0, since C++ rejects implicit
conversion from void * to a typed pointer.

However, the companion macros bpf_for() and bpf_repeat() immediately below =
in
tools/lib/bpf/bpf_helpers.h still initialize struct bpf_iter_num *___p with
(void *)0:

#define bpf_for(i, start, end) for (								\
	...
			    *___p __attribute__((unused)) =3D (					\
				bpf_iter_num_new(&___it, (start), (end)),			\
				(void)bpf_iter_num_destroy, (void *)0);				\

and:

#define bpf_repeat(N) for (									\
	...
			    *___p __attribute__((unused)) =3D (					\
				bpf_iter_num_new(&___it, 0, (N)),				\
				(void)bpf_iter_num_destroy, (void *)0);				\

Would expanding bpf_for() or bpf_repeat() in C++ still fail to compile unle=
ss
those initializers are also cast to (struct bpf_iter_num *)0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024035902.4456=
6-1-hackerowskiy@gmail.com?part=3D1
