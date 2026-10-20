Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504903;
	b=NtxU1vTDbLP9A9NB6djjcGbbFfv4prfzxvudJ7QiKkAnyk8eRG3oKdjINsvvD+veIcDV
	 b2mfXJWkxgKOGy/bBV1kGo64swCEgiqID1a70INgrSU6H6cOOAzryFv8RT5LOXayvZgYB
	 tcb7Pw4NcVvqn6lUVKX2xuJ9SPMNqM0qo14A9JnHB9mLSu8ofcq3x8CT3Ewi6507GZE/a
	 lnBjZ2HvYrmrwD3qcCbXYOPcOtxJR4mwXZe0hS0hhRSFiiaIu2ie5G7O7YNKFSdPANAGF
	 z7mcMWX3tiukXVoH6drVgfbDWkrojrgCCKyM748zguB4OMTqM2kdWbhJRP/RmqHYwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504903;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/PzkJJnr1xi8qEIuYiOzuHmilmQw1z23oWnEO1Wl9hk=;
	b=OKZj1FmfKMazQ3SNhgFRWIYY6DE9ljx579JNuiYMMKu/2dkWXepW1xbZ2F3EHoIwYbiI
	 nXxasJsOr/3mCQhuxnddffuIUJWq3hVK9pyaY7DiO61QWijvtx6ODkwqHrehx7mqrKxdt
	 O/OUnZvAAQYZlpmBTr2t8LNY4vZIQj884nG+tlUKi3tDM1jd92ccU6QlB13LZjxH1XAWQ
	 QYODt6AteoaNC2r8m0j1bCXkdgaJn61w4bkhF0EnqgQGCtI9PYNQsBKt0dchHlHVbAMNN
	 zm/50HrCqSUyLEkUnyArzYyAu+fxwKa3UHrpRUOb/5aLrULkCNC/oOZce+yeaOjCHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMiLS4nC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464A606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMiLS4nC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EB1F000CF;
	Tue, 20 Oct 2026 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792504902;
	bh=/PzkJJnr1xi8qEIuYiOzuHmilmQw1z23oWnEO1Wl9hk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YMiLS4nCvbPhU9CXjO2kBrvmGnlVFvxMaqMlEUAnJjM8Hz3gnAjswc7C4gdqDrIjE
	 QfUNYvLrdVhBG0met02jHDJCEMRAPRf8xCzLFo6koWIIpfdoElXiZZA/gp6SxPrxq6
	 i2VuTlDYyr3bLbWVQ1Zg6/+MV0vyTgMH4tybL2IT3DrI4SEHdxR46ELEBgV9HpWeL0
	 9aXdJkY86Xr61wWvxuq1Xml3m0+0ceccTeXGDYy58BR7oJorHdgdDijTJ0t3ARZvvu
	 oczkRc+d+jMQtKKH4iQqR19gtlV9rVRziqwPyB+UkGdInOKR5l2mBJnsKx1Ntn15Im
	 s6p6JJKMZ1WpA==
Message-ID: <sashiko-outbox-179076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 13/16] bpftool: Emit the arena percpu datasec
 into skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <a579251a284c3dd4954c305a04346acef4ec4113.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
 <a579251a284c3dd4954c305a04346acef4ec4113.1792503001.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:01:41 +0000
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
- [Medium] bpftool: NULL pointer dereference in do_skeleton() when BTF is a=
bsent
- [Low] bpftool: missing pointer cast in do_skeleton() breaks C++ skeleton =
build
--

commit 104a6169dc8cb31cbaeca548b8c48657b09d1a96
Author: Xu Kuohai <xukuohai@huawei.com>

bpftool: Emit the arena percpu datasec into skeleton

This commit updates bpftool skeleton generation to emit a separate
arena_percpu data section struct when .arena.percpu variables are present
and initializes obj->arena_percpu to cpu 0's per-cpu arena base in the
generated load function.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee680f7c21160..8a321ec1155a1 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -1511,11 +1523,58 @@ static int do_skeleton(int argc, char **argv)
>  			return %1$s__open_opts(NULL);			    \n\
>  		}							    \n\
>  									    \n\
> -		static inline int					    \n\
> -		%1$s__load(struct %1$s *obj)				    \n\
> -		{							    \n\
> -			return bpf_object__load_skeleton(obj->skeleton);    \n\
> -		}							    \n\
> +		",
> +		obj_name
> +	);
> +
> +	/* The per-cpu arena data has no mmaped slot in the map skeleton.
> +	 * Point obj->arena_percpu at cpu 0's chunk once the object is
> +	 * loaded.
> +	 */
> +	{
> +		char arena_map_ident[256] =3D "";
> +		bool have_percpu_arena =3D false;
> +
> +		bpf_object__for_each_map(map, obj) {
> +			if (bpf_map__type(map) !=3D BPF_MAP_TYPE_ARENA)
> +				continue;
> +			if (find_type_for_map(bpf_object__btf(obj), "arena_percpu") &&
> +			    get_map_ident(map, arena_map_ident, sizeof(arena_map_ident))) {

[Severity: Medium]
Can this dereference a NULL btf pointer when generating a skeleton for an
object with an arena map but no BTF information?

Earlier in do_skeleton(), codegen_datasecs() is guarded by checking if btf
is non-NULL:

    if (btf) {
        err =3D codegen_datasecs(obj, obj_name);
        if (err)
            goto out;
    }

Here, bpf_object__btf(obj) is passed directly to find_type_for_map()
without checking if btf is NULL:

    do_skeleton()
      find_type_for_map(bpf_object__btf(obj), "arena_percpu")
        btf__type_cnt(btf)
          return btf->start_id + btf->nr_types;

Should this check that btf is non-NULL before calling find_type_for_map()?

> +				have_percpu_arena =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (have_percpu_arena) {
> +			codegen("\
> +				\n\
> +				static inline int \n\
> +				%1$s__load(struct %1$s *obj) \n\
> +				{ \n\
> +					int err; \n\
> +					 \n\
> +					err =3D bpf_object__load_skeleton(obj->skeleton); \n\
> +					if (err) \n\
> +						return err; \n\
> +					obj->arena_percpu =3D \n\
> +						bpf_map__arena_percpu_base(obj->maps.%2$s); \n\

[Severity: Low]
Will this assignment fail to compile when the generated skeleton header is
included in C++ code?

bpf_map__arena_percpu_base() returns void *, while obj->arena_percpu is a
typed struct pointer (struct <obj_name>__arena_percpu *). In C++, implicit
conversion from void * to a typed pointer is not permitted.

Elsewhere in tools/bpf/bpftool/gen.c, such as in gen_st_ops_shadow_init(),
void * returns are cast using __typeof__:

    obj->struct_ops.%1$s =3D (__typeof__(obj->struct_ops.%1$s))
        bpf_map__initial_value(obj->maps.%1$s, NULL);

Should obj->arena_percpu also use a (__typeof__(obj->arena_percpu)) cast
here?

> +					return 0; \n\
> +				} \n\
> +				", obj_name, arena_map_ident);

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792503001.gi=
t.xukuohai@huawei.com?part=3D13
