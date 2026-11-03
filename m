Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693425;
	b=AA6STUZJpXB66RWpX5ZwjmoMz3ocTGHHNnTGgpv/hq8QpLUxM6pkgaZq85VbSvvLxtAg
	 dJ5apkfuXM8yMAO6s0z3LxaMQcYZFrUrCOB7lOSxwuJSrnmbJUzvXlPtgj9phX3JlWoWZ
	 f+g2WVteV7BogmYU8MrpeEi5rbYWGVSg1mv4dAdi4aj2LwIKjuG6hNWkE159KIl7U1TNv
	 Bpv8qIytyNhzsOyVf7wA+aTRxbM1/5E+cpI1IvHBisPms/idLMcLCRMzb7dSn9CuXOIdx
	 +dmSeU03CcXjdqA5gNSda0/pEThTxhWGxwAaRQILmLhye3xttkaiZE73JVFKos7V5kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gf7UzY2gyj9UdBb7dmvQSKLfA12i+FWmWNeRPHVftXE=;
	b=hqm/eeD65ZAJ+XiwGcyhgPtMDHZ5YfZ32+h5BTddQoKEYgLFLwDpks90Kc2yL8gfv+qq
	 J36MhY3bkNmPEhKBuSHAySRDMuAb1ucbU4BC5KLBXCCcBjdSady4GCUVMKt5lFlwcYt3P
	 9PpnpxBuP+z9lKd5lFDuKSrQAtKC/220UVYjXuW3PTFtP+z8OELLS+nrZkYxqiByIznZg
	 Sq580ta5s93emkwe4WvgweIyvslqIEJLHt+KSVPsZX18VdyAcJRTaUJN+Puz7fgOBxNIK
	 Jx+LiP3TkwLZZVrcAnzymvDatpdbOvB7utQgcg4bwZA3FDPiguqySbNHOS1uB6fqy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDPxkxfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D236606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VDPxkxfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835051F0093A;
	Tue,  3 Nov 2026 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793693425;
	bh=gf7UzY2gyj9UdBb7dmvQSKLfA12i+FWmWNeRPHVftXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDPxkxfIN1/tz7qRiZjIqYYJ58JXQz8ILAaIeA6Kwj6xYm+OF+KzlBeY+eM+WiFuC
	 JR+sL68AHeA33POxDTHaE3MQTDDqKY6/smIfyhv4oFTEv31m7rUY5R7TQuX/xwUqLN
	 jHTjGzNT29BUDXhzj5wsH0wEEPW5rvOxJPcLut9D1/GuRXVjY8kyCdQEOIdg+zX9E7
	 z5wneTARPobNGGiSbtDKhvGthxhcpIDQGbgOBHUAnEW1bkv1gAJF72/YGtQ08sMTV4
	 LwET6PqPGSB4hZhO8nH0tCMdYNnQRSDTjHCV3VWckpDWks0JccNYI+NCWIBpkkzgmP
	 nz07vmwRcZKBg==
Message-ID: <sashiko-outbox-194803@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 4/8] selftests/bpf: Test const kfunc memory
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Federico
 Di Pierro" <nierro92@gmail.com>
In-Reply-To: <20261103075916.100050-5-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
 <20261103075916.100050-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:10:24 +0000
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
- [Medium] selftests/bpf: kfunc_call_test_const_mem() fails verifier load w=
ith MEM_WRITE
--

commit d0fe747011b126dd39ad19108026e34fdd9f18ce
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Test const kfunc memory arguments

This commit adds BPF selftests and bpf_testmod kfuncs to test passing
read-only global data, stack data, and const scalar structs to const-qualif=
ied
kfunc memory arguments, as well as rejecting read-only data for writable
memory arguments.

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
Does kfunc_call_test_const_mem() pass the verifier without a corresponding
verifier change to preserve const qualifiers on kfunc memory arguments?

In kernel/bpf/verifier.c, get_kfunc_arg_type() strips all type modifiers
including BTF_KIND_CONST from the pointed-to type via
btf_type_skip_modifiers(), advances ref_id_ptr past them, and unconditional=
ly
sets MEM_WRITE on sized memory arguments:

kernel/bpf/verifier.c:get_kfunc_arg_type() {
	...
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
	}
	...
	if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
		if (is_kfunc_arg_map(meta->btf, &args[arg]))
			proto->arg_btf_id[arg] =3D reg2btf_ids[CONST_PTR_TO_MAP];
		else
			proto->arg_btf_id[arg] =3D ref_id_ptr;
}

Similarly, for bpf_kfunc_call_test_const_struct(), when &kfunc_const_struct
(a PTR_TO_MAP_VALUE in .rodata) is passed, resolve_func_arg_type() converts
the scalar-struct pointer argument to fixed-size memory with MEM_WRITE set:

kernel/bpf/verifier.c:resolve_func_arg_type() {
	...
	if (!btf_type_is_scalar_struct(env, btf, ref_t))
		return 0;
	...
	*arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
}

When check_func_arg() validates kfunc_const_data and &kfunc_const_struct,
func_arg_access_type() returns BPF_READ | BPF_WRITE because MEM_WRITE is se=
t,
causing check_helper_mem_access() -> check_map_access_type() to reject the
read-only .rodata map with -EACCES ("write into map forbidden").

Because kfunc_call_test_const_mem is an autoloaded SEC("tc") program in
kfunc_call_test.c, wouldn't this cause kfunc_call_test__open_and_load() and
kfunc_call_test_lskel__open_and_load() in verify_success() to fail and break
the kfunc_call test suite?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103075916.1000=
50-5-jolsa@kernel.org?part=3D1
