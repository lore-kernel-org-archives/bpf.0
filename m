Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874722;
	b=M6FVb8OwNXcqHK2t06UaGXJ2HUUI8xny0km4NZmdNsbaMbkzhFwRe8xDBzsfpXHhaPyp
	 gkSAhXbY8So+563sxE/sr6pI01kt8rE89MSItWIvXb5czqFBajjfYXEEk7Rbrxe+6XlQy
	 j3ZpWGjIOfrT+SCJoWUVlqv6pihwTM2iSUmsgHxfqdn6XEMDArUFBtPXu08tertSGCdWc
	 9t556aEU/RMhppyiEv1DLcHNqYF6+BbxNUe+kgtxedu2mwsoWNhIkAWl8cvCrbGRTv8M6
	 nHQqA7UUXGTOsmfmIkv1HFgeNUVots/GwArbcjN9QjDC8xeGrgHhIkp7QTulYgVbD6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874722;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xKhjKjL6NUJD8Nx7MIL7fAZeI2PVjUsp8Wn9XjenML0=;
	b=uZfhLT226ZjWEc7Y3uuyxClpJu2wdKvnJzlVOjbuhi0FqE0c48Eae7/yB23VTcp43y0T
	 LYvf/x90bFDrEvtmR5TmIyj4i6IWm5/MuEpondKvgS5wuYRXnnpWENvEPBAShHUhesOUw
	 7GhD4n9RLJjJ7N1iJlmfnv+sZ0mqFPb0YnYeubi+QTm5JyfkLvYIwZuLeh88oY2c+pbE0
	 Yid/dzmdnGBvjpEoe1FBaI1tyZfe5+Dw1qSvI7YsgEUZxnlo/d+YoQL4vNSNmgmYsY0PN
	 5/xCX9ifrwu62LPL2KRYiWYgccnot79+tjntX8ZXHYuqxp34biF7KZ5fRH+QpP6Euzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+w76bhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A08606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+w76bhR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B71F00919;
	Thu,  5 Nov 2026 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874721;
	bh=xKhjKjL6NUJD8Nx7MIL7fAZeI2PVjUsp8Wn9XjenML0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+w76bhRzvh3DlQftxYcZVSjXpIK0PKvDJXlhm+XtBg+CcdCP1pMKjOZ8HY56g585
	 q1p8JHZKs7HZ5rabs5rrpLYXFJBqC4Op9YaJnNCkiNWk+UTYDV55moBm6pOfA4vwvA
	 B1XJU8yX6GcZvaSr5yjw1rZ3wmBUjVMujPPlZOAlvCVFTi64vL4zyMllAxI3BY6uUt
	 FxSfgKdIqNBbBz4yPHNCNEUpljza8e9jqHhpC44B8U3qbSDLuLQBPgY2za/5obEhre
	 UWIuEqJ6v6HAPvl6TsxKkrKSmklNgbRVsPkPyI6ahAa4mYZSlrQuFnHva4N3NwarWE
	 0Qg+ocdKu9AhA==
Message-ID: <sashiko-outbox-198859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 4/8] selftests/bpf: Test const kfunc memory
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261105102343.311331-5-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
 <20261105102343.311331-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:32:00 +0000
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
- [Medium] selftests/bpf: kfunc_call_test_const_mem() fails due to MEM_WRIT=
E in verifier
--

commit 0e976b113cb623dc07d1d416bf2badf98c0f26f7
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Test const kfunc memory arguments

This commit adds BPF selftests and bpf_testmod kfuncs to verify passing
read-only global data, writable stack data, and const scalar structs to
const-qualified kfunc memory arguments, while rejecting read-only data
passed to writable memory arguments.

> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/=
testing/selftests/bpf/progs/kfunc_call_test.c
> index 8e6560c31e781..4f4a6713aa6e5 100644
> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> @@ -5,6 +5,9 @@
>  #include "bpf_misc.h"
>  #include "../test_kmods/bpf_testmod_kfunc.h"
> =20
> +static const char kfunc_const_data[] =3D "read-only source";
> +static const struct prog_test_pass1 kfunc_const_struct =3D { .x0 =3D 1 };
> +
>  static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
> =20
>  SEC("tc")
> @@ -208,6 +211,17 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
>  	return 0;
>  }
> =20
> +SEC("tc")
> +int kfunc_call_test_const_mem(struct __sk_buff *skb)
> +{
> +	char stack_data[] =3D "read-write";
> +
> +	bpf_kfunc_call_test_const_mem(kfunc_const_data, sizeof(kfunc_const_data=
));
> +	bpf_kfunc_call_test_const_mem(stack_data, sizeof(stack_data));
> +	bpf_kfunc_call_test_const_struct(&kfunc_const_struct);
> +	return 0;
> +}

[Severity: Medium]
Does kfunc_call_test_const_mem() pass verification without a corresponding
verifier change to preserve const qualification on kfunc memory arguments?

In kernel/bpf/verifier.c, get_kfunc_arg_type() strips modifiers from the
pointed-to type via btf_type_skip_modifiers() and unconditionally marks
pointer+size and fixed-size memory arguments as writable:

kernel/bpf/verifier.c:get_kfunc_arg_type() {
	ref_id_ptr =3D &t->type;
	ref_t =3D btf_type_skip_modifiers(meta->btf, *ref_id_ptr, &ref_id);
	while (*ref_id_ptr !=3D ref_id)
		ref_id_ptr =3D &btf_type_by_id(meta->btf, *ref_id_ptr)->type;
	...
	} else if (arg + 1 < nargs &&
		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
		...
		arg_type =3D ARG_PTR_TO_MEM | MEM_WRITE;
	} else if (btf_type_is_struct(ref_t))
		arg_type =3D ARG_PTR_TO_BTF_ID;
	else {
		...
		arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
	}
}

Similarly, for bpf_kfunc_call_test_const_struct(), get_kfunc_arg_type()
records the argument as a BTF struct pointer with proto->arg_btf_id[arg]
pointing past the const modifier, and resolve_func_arg_type() then rewrites
the scalar struct argument to writable memory:

kernel/bpf/verifier.c:resolve_func_arg_type() {
	...
	*arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
}

When kfunc_call_test_const_mem() passes the .rodata globals kfunc_const_data
and &kfunc_const_struct to bpf_kfunc_call_test_const_mem() and
bpf_kfunc_call_test_const_struct(), check_func_arg() requests write access
via func_arg_access_type() -> check_helper_mem_access() ->
check_map_access_type(), which rejects the program with "write into map
forbidden".

Because kfunc_call_test_const_mem() is an autoloaded program in
kfunc_call_test.c, won't this also cause kfunc_call_test__open_and_load()
and kfunc_call_test_lskel__open_and_load() in verify_success() to fail for
all subtests using the kfunc_call_test skeleton?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105102343.3113=
31-5-jolsa@kernel.org?part=3D1
