Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3113CEB8A
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797658; cv=none; b=fqE7z00v1dwmYVL314gD8DJGc1dGpZvigzSnXQgKff20Nr+eUxT92BueuEMBC4NNOXba5iRI5MgVINsoBRzcTHr8k/TqH2as4ajNxerBRVckihJthrWhavwipP7eNKlk9l/0wwPCBAp1la8I3Ja8FCB6m3pfmMXGq/ojm6h36C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797658; c=relaxed/simple;
	bh=39e/bpw9hI3TccX2Ab5WIUZKOhFd+zQle6Yub1Zr+Tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IE14a0pV8W2o0Vav5ZQyZ6BVbkLXEiRndbfQIIo8hf+lVBlZbXlme2mv0N4bYUmmdMOS2ubJF0PPjN8xxCyT443tdXwuYHAkHOlxeZQazpxlrVtz61DEi8pXbe/GNIksMMaN1zp5lKUUwOvFIMDqdqGT6/CHMHfBnRoPfcyG8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWyrUjrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWyrUjrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3830F1F000FF;
	Wed, 30 Sep 2026 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797656;
	bh=qg3l+o/PhtzPaKzx+0rrM3Ot4NU8Koum/AAa5233kkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YWyrUjrCvQ8m0HOCq1nFobj5BNqdIt/91c91pO9B192lIJBFsXWGP0zzIWzVCQx3K
	 9dEvyJsUdBhtCV7EjMualRV3xNnI18sLcz/eyfrDwN5o8QpoxZnfoRDxBzsvZ8GFgq
	 VTbVgnceQfakVAf67ViUI7NX6etPOwuztlkztOJowpiJVvXe7pbyplRaZBy0c3rbOf
	 nk6zmaVgPFh1XTL73vdv5AEU/vikup1V7Ho+0C5In6UNgDeidxFJPmPKKtm7M1KpBZ
	 YuWCBqErr1Xaz5Z2IA3br8ke34T8uDm1ueUFggOpfdHU7WRBmWZZTc82a7yHZ8bBdh
	 ZIYrnry6mWOKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 09/14] bpf: Allow a variable in DATASEC that is
 smaller than its type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260930193127.2181684-10-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-10-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:47:35 +0000
Message-Id: <20260930194736.3830F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpftool/perf: out-of-bounds heap read when dumping DATASEC varia=
bles
--

commit 1b453d08464afcede36a667c89c48e99ef1d651d
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Allow a variable in DATASEC that is smaller than its type
   =20
LLVM splits a static of a Rust program into pieces. Every piece is a VAR
with the type of the whole static:
   =20
  [223] STRUCT 'BpfCell<core::option::Option<...>>' size=3D32 vlen=3D1
  [236] VAR '..scx_cosmos9TASK_CTXS.0' type_id=3D223, linkage=3Dstatic
  [248] DATASEC '.bss' size=3D0 vlen=3D9
          type_id=3D236 offset=3D24648 size=3D1 (VAR '..TASK_CTXS.0')
   =20
and the kernel rejects such BTF with "Invalid size". Allow it.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c9d4b709380c9..0630675377aaa 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -5412,16 +5412,16 @@ static int btf_datasec_resolve(struct btf_verifie=
r_env *env,
>  			return env_stack_push(env, var_type, var_type_id);
>  		}
> =20
> +		/*
> +		 * The variable can be smaller than its type. It's a piece of
> +		 * a variable that the compiler split then, with the type of
> +		 * the whole variable.
> +		 */
>  		type_id =3D var_type->type;
> -		if (!btf_type_id_size(btf, &type_id, &type_size)) {
> +		if (!btf_type_id_size(btf, &type_id, NULL)) {
>  			btf_verifier_log_vsi(env, v->t, vsi, "Invalid type");
>  			return -EINVAL;
>  		}
> -
> -		if (vsi->size < type_size) {
> -			btf_verifier_log_vsi(env, v->t, vsi, "Invalid size");
> -			return -EINVAL;
> -		}

[Severity: Medium]
Does removing this validation expose userspace tools to out-of-bounds heap
reads?

By allowing vsi->size < type_size, a DATASEC variable piece's offset plus i=
ts
full type size can now exceed the DATASEC's total size.

When bpftool dumps a DATASEC:

tools/bpf/bpftool/btf_dumper.c:btf_dumper_datasec() {
    ...
    ret =3D btf_dumper_do_type(d, vsi[i].type, 0, data + vsi[i].offset);
    ...
}

It unconditionally reads bytes based on the variable's full type size. Since
the piece is smaller than its type, this reads past the end of the allocated
map value buffer.

Similarly, perf passes the full type size as the bounding data_sz to libbpf:

tools/perf/util/bpf-event.c:format_btf_variable() {
    ...
    btf_size =3D btf__resolve_size(btf, t->type);
    btf_dump__dump_type_data(d, t->type, btf_data, btf_size, &opts);
    ...
}

This incorrectly bypasses libbpf's internal bounds checks, causing libbpf
to read out-of-bounds from map->rodata.

>  	}
> =20
>  	env_stack_pop_resolved(env, 0, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930193127.2181=
684-1-alexei.starovoitov@gmail.com?part=3D9
