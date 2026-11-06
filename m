Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965865;
	b=3Hh7Zp1Nd+rneRGQiF0+WN93XT5g/coIENu8UtOhPLYldxv06oyHrvbgQuK50uDvazyk
	 UAwOtiwr9WKXHBMZSpKjabao5faW004OI8qnorQWt4KTk7dz7Dc+G6lSdV7+4fgcfbv9V
	 w6rl9Xc7MkcZIQEl9da7CeICAkfYJSOzz45420aip04joG5y2SgYl3/CCNFNDSeZwNZmd
	 RA9uKZWKnno2KpeaNbEDHNB7D6UpT0wAjSx1oMoJasA7Gzo4TXHbybzcle8gw56djTIcy
	 iY7Gzreu6gIYDVbWXnuvOJUxfbiK5ZRPHfrEQ3rCVZbh4n453ciu3AtSIYRGG0tEPXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965865;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hSXBJ+hish11A7LkoW+SntuYMhVNp4+Tz2Un9tXf4tA=;
	b=TE69gp0AkZTrMDTTGr8OMqarlN4IPps0OApuHoQZ7TEeYptTCtcHFJyAsLC5l6zxL6qv
	 Ug4aenG7Pt5XcB+zkZaNHfXLWXtzFJvudSdzxo1nayvOakO6rMM8alPCw0uFVx8u4x/HA
	 yJlQG5hKV5gfYOIAyUHPP3W14HKwPP1b/sEwst72XBHirRJ3xtEFSKktdes9e6Bhz0+CF
	 vQqE8nsHgNkC3OQdbNqoDEInIaTabpVk28hbMHPEgKi/DwwpsQ71L5soofHoM3u1NJX+v
	 Sayqdsa6NLHrQbGQLdNFxBn1YLOmdwJooHLzBq4T8xbAJGHt2qPjiQBTrTkHWWBw0qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ov/hiLjn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF5606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov/hiLjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E641F008A3;
	Fri,  6 Nov 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965864;
	bh=hSXBJ+hish11A7LkoW+SntuYMhVNp4+Tz2Un9tXf4tA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ov/hiLjnWEkhPQiHXTjWXe/AAYYp9QP6tchoo6hVTJHF0cuTDJ9/SlH0zrOgyD0gb
	 3AsnrKzRvyy6t8VnbmVLJ3SJNMYV84uS6mW5n/7CWtO1toUGFFj+Dup/vuZLaTtCtQ
	 XmP0gOnIxbVNvuP+0Gb1Noyz7qbzJaJtC+Y1TsYbgPhh5TzfFoUNWkWF0+lTyS6mYp
	 2LTrOT8H3LT0Acz2tDnItdyddazc6GQ9OaN4zUiZh8z7AzYFKv/fL+wlFlTb6OLewU
	 z3tqjpmbjfq2mkRG1+wG8mEVIsf1CLOPkLf6XEAtbqu4q8ROSTgtysPF8wiotxou33
	 Tyqyi1CHM8jog==
Message-ID: <sashiko-outbox-201361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: Check bpf_timer value
 membership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106095747.471718-9-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
 <20261106095747.471718-9-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:51:04 +0000
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
- [Low] selftests/bpf: non-standard multi-line comment style in
  bpf_timer_membership.c
- [Low] selftests/bpf: unnecessary macros and duplication in
  bpf_timer_membership
--

commit 62751ca885fba4775d346fbce832c200968a6cd0
Author: Yun Lu <luyun@kylinos.cn>

selftests/bpf: Check bpf_timer value membership

This commit adds BPF selftests verifying that bpf_timer_init() rejects
deleted or replaced map values with -ENOENT across hash, rhash, and LRU
hash maps while keeping live hash and array timers functional.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_timer_membership.c b/t=
ools/testing/selftests/bpf/progs/bpf_timer_membership.c
> new file mode 100644
> index 0000000000000..b7a10a80f2cf5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_timer_membership.c
> @@ -0,0 +1,161 @@

[ ... ]

> +/* Configure and start only a current map member. */
> +#define TIMER_INIT_START(v, map_sym, cb)				\
> +	({								\
> +		long __e;						\
> +		(v)->cookie =3D cookie;					\
> +		__e =3D bpf_timer_init(&(v)->timer, &map_sym, CLOCK_MONOTONIC); \
> +		if (!__e) {						\
> +			res_set_err =3D bpf_timer_set_callback(&(v)->timer, cb); \
> +			if (!res_set_err)				\
> +				res_start_err =3D bpf_timer_start(&(v)->timer, \
> +								TIMER_NS, 0); \
> +		}							\
> +		__e;							\
> +	})
> +
> +/* Delete and initialize through the retained pointer in one RCU section.
> + * Never configure or start a timer through that pointer, even if init s=
ucceeds.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line with the comment text starting on the
next line.

> +#define TIMER_DELETE_INIT(map_sym, v)					\
> +	({								\
> +		long __e;						\
> +		bpf_rcu_read_lock();					\
> +		res_delete_err =3D bpf_map_delete_elem(&map_sym, &key);	\
> +		__e =3D res_delete_err;					\
> +		if (!__e)						\
> +			res_init_err =3D bpf_timer_init(&(v)->timer, &map_sym, \
> +						      CLOCK_MONOTONIC);	\
> +		bpf_rcu_read_unlock();					\
> +		__e;							\
> +	})
> +
> +#define DEFINE_TIMER_MAP(map_sym, value_type)				\
> +static int map_sym##_cb(void *map, int *key, void *value)		\
> +{									\
> +	value_type *v =3D value;						\
> +									\
> +	__sync_fetch_and_add(&cb_count[v->cookie & (CB_SLOTS - 1)], 1);	\
> +	return 0;							\
> +}									\
> +									\
> +SEC("syscall")								\
> +int map_sym##_run(void *ctx)						\
> +{									\
> +	value_type *v, *nv, zero =3D {};					\
> +	int key =3D 0;							\

[ ... ]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__uint(max_entries, 4);
> +	__type(key, int);
> +	__type(value, struct timer_value);
> +} values SEC(".maps");
> +
> +DEFINE_TIMER_MAP(values, struct timer_value)

[Severity: Low]
This isn't a bug, but DEFINE_TIMER_MAP() is only instantiated once for
values, TIMER_DELETE_INIT() is a single-use macro that implicitly captures
key from its caller and returns an unused value, and TIMER_INIT_START()
could be a static __always_inline function.  In addition, cb_count has 64
slots even though every subtest opens a fresh skeleton and passes cookie =3D
1.

More broadly, prog_tests/bpf_timer_membership.c and
progs/bpf_timer_membership.c duplicate bpf_wq_membership.c from commit
"selftests/bpf: Check bpf_wq value membership" almost verbatim, and the
delete_rhash subtest overlaps with deleted_init_rejected in
prog_tests/rhash_timer.c from commit "bpf: Check bpf_timer value
membership before use".  Replacing the single-use macros with regular
functions and consolidating the shared wq and timer membership test logic
would avoid this duplication.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106095747.4717=
18-1-luyun_611@163.com?part=3D8
