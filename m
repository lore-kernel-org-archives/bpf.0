Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454169;
	b=Kao9d8kxpn+6U7CdOvdANQ/CMa2pSxfyx1rze23MA74rzMmhYSARA1BvAt5jx4+Py/xq
	 pQIXFM/h2w213oj8c2XVafdY+LCpWfrGHzLTdc5ouKzFfGs9A/1IrE0emqbzy+DCpxOUE
	 P5aKyHeH2rMksjMOMV7RiNWK45rAlZRBaeruw3QI80bX0hyIhnCQTsFzStSxdJYus2pgU
	 y/52iGdKBqaf9I59LXh4nIVv8YOiai3GgwMC1f2IglpUJLkqfBleR8GveH1hJNiAxCaTE
	 m7zc/bTpqFQlcM+/bro+ajG3m7fe3hCtpfEUS5d9ip3DgBQ9yRWsWZgLGrpDUsQu1WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZOPSy2txvMbOY4X1AQdaor/eQTWwQ//qa48gECG4DCw=;
	b=C8OCaFkMfsVXvscYVhBxYzFPn4u8PXQxQClD9UsbvmV6JUm0uc1XsgojDkgRAJpaptp1
	 RIXbM4dD/mMLA5xhP2gNKZpmTsF1k3suvh/N58aODVjFeVDSMpS1RICxieTU/yBga579J
	 u9LCqJJVBxdjpSAvWPNynjQIGz6BY5+Stw31hVoL3NlyV7SP68SZUPhh3EJRfAItFs2br
	 Efrr+hit8/eOwjyBvO5F4qrEYaRpwbximA+IbCSKz3t3TwoI9zXzIyaEfcsEBDQobepSy
	 zEiURlVR5giVx3fxttsbpnlKfwFONPsjX/8ylfUadm5mhYTetYrAYw/qMheTBahunUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEEZC2gW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F97606A31A;
	Sat, 31 Oct 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEEZC2gW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFE1F00919;
	Sat, 31 Oct 2026 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454169;
	bh=ZOPSy2txvMbOY4X1AQdaor/eQTWwQ//qa48gECG4DCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEEZC2gW1dGDtu3R3r/E5p75m/L05NojSXM2uke/v5srbS1iHd5LOGpQLB3tnBunE
	 IlP5eUXaE88RH2KvaqdCiOc01dMefa0fShsheh7hpRdyCW0Vr0c2FOTAw7mRZYMVHh
	 53EinQ5gN8WaIXN+KsoGOA+GXlnK1B6bnUJ+SpeinHPbJBN0LVjPvJIOtKAHEdBDHi
	 P/ZvswsIFhRZPN+OWQLwf7AgkREE7gtTxNDxkTSYf2jJxCtJJuwozE5YFw35b/iTE+
	 ZLTMs2yWBDbDNXI+3A4VWkKFF59QdtMn22uqVqn6E6Fpwu/lQvKSue8W/cq1NFGjVu
	 SrY3kon9TTjAg==
Message-ID: <sashiko-outbox-191985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 02/13] bpf: fetch the vmlinux BTF where kernel
 types enter a program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jay Wang" <wanjay@amazon.com>, bpf@vger.kernel.org, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire" <almagui@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, x86@kernel.org, "Hazem Mohamed Abuelfotoh" <abuehaze@amazon.com>, "Bjoern
 Doebel" <doebel@amazon.de>, "Martin Pohlack" <mpohlack@amazon.de>, jay.wang.upstream@gmail.com
In-Reply-To: <20261031130959.23472-3-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
 <20261031130959.23472-3-wanjay@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 13:42:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf: NULL or ERR_PTR btf_vmlinux dereference via check_pseudo_btf_=
id()
- [Low] bpf: unreachable !btf check in check_ptr_to_map_access() when BTF i=
s disabled
- [Low] bpf: unresolved TODO-NEEDS-IHOR Signed-off-by placeholder in commit=
 log
--

commit a99de2b5b9828d221e9bcde23ac921cf3c9fc798
Author: Jay Wang <wanjay@amazon.com>

bpf: fetch the vmlinux BTF where kernel types enter a program

This commit drops the up-front vmlinux BTF fetch in bpf_check() and instead
fetches the vmlinux BTF on demand at the points where kernel types enter the
verifier state, avoiding unnecessary BTF parsing for programs that do not u=
se
kernel types.

>     bpf: fetch the vmlinux BTF where kernel types enter a program
>    =20
>     bpf_check() fetches the vmlinux BTF up front for every program, wheth=
er
>     the program uses kernel types or not.  That is free today because the
>     BTF is parsed at boot anyway.  Once it can be parsed on first use
>     (CONFIG_DEBUG_INFO_BTF_LAZY, later in this series), it would make eve=
ry
>     program load pay for parsing 5-7 MB of BTF, including the socket filt=
ers
>     systemd loads at boot.
>    =20
>     Drop the up-front fetch and fetch where kernel types enter the verifi=
er
>     state instead:
>    =20
>      - bpf_add_kfunc_call(), for the first kfunc call of a program;
>      - check_ptr_to_map_access(), for map_ptr field access;
>      - check_pseudo_btf_id(), for ldimm64 of a kernel variable (ksym);
>      - check_helper_call(), for helpers whose prototype takes
>        ARG_PTR_TO_BTF_ID or returns RET_PTR_TO_BTF_ID, and for
>        bpf_snprintf_btf() and bpf_seq_printf_btf(), which take a kernel
>        type id inside struct btf_ptr (helper_uses_vmlinux_btf()).
>    =20
>     The other ways in already fetch the BTF themselves: attach_btf in
>     bpf_prog_load(), struct_ops map creation, CO-RE candidate lookup,
>     bpf_find_btf_id(), btf_prepare_func_args() for kernel-typed arguments
>     and the kernel context type lookups.  The remaining reads of the
>     btf_vmlinux global in the verifier are on paths dominated by one of
>     these fetches.  A program that uses none of them, such as a socket
>     filter, does not need the vmlinux BTF any more, and verifies the same
>     whether or not it has been parsed.
>    =20
>     Four related changes keep it that way:
>    =20
>      - The "in-kernel BTF is malformed" check in bpf_check() read the
>        global right after the up-front fetch.  Without the fetch it would
>        pass or fail depending on whether something else had parsed the BTF
>        before, so drop it; every fetch point reports a missing BTF itself
>        and passes on an error of the parse, as that check did.
>    =20
>      - check_ptr_to_map_access() checks allow_ptr_leaks before it fetches
>        the BTF, and bpf_prog_load() falls back to the vmlinux BTF for an
>        attach_btf_id only with CAP_BPF, which all program types that take
>        one need, so that an unprivileged load cannot make the kernel parse
>        it only to be refused.  The map_ptr permission error can then not
>        name the map's struct any more and says "map_ptr access is allowed
>        only to CAP_PERFMON and CAP_SYS_ADMIN".  A ksym, which unprivileged
>        programs may use, still parses it.
>    =20
>      - Add bpf_peek_btf_vmlinux(), which returns the vmlinux BTF only if =
it
>        is parsed already, and use it in bpf_btf_printf_prepare().  The BTF
>        printf helpers run in program context, which may be atomic, and the
>        verifier has fetched the BTF for every program that calls them.
>    =20
>      - is_kfunc_dynptr_write(), reached from the argument checks that
>        helpers and kfuncs share, compared meta->btf with the global, which
>        a helper's NULL matches while the global is NULL.  Check that the
>        call is a kfunc first, as the other kfunc predicates there do.
>    =20
>     Helpers taking ARG_PTR_TO_BTF_ID_SOCK_COMMON are left out on purpose:
>     they take sockets without BTF types too, the shared argument check re=
ads
>     the global only for a PTR_TO_BTF_ID register, and every source of such
>     a register fetched the BTF.
>    =20
>     No functional change with CONFIG_DEBUG_INFO_BTF=3Dy, where kfunc
>     registrations at boot parse the BTF, other than that error message and
>     that, if the vmlinux BTF fails to parse (a broken toolchain), programs
>     that use no kernel types now load instead of failing.  Without BTF the
>     new helper check is compiled out and the existing error paths are
>     unchanged.
>    =20
>     Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>     TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.de=
v>
>     Signed-off-by: Jay Wang <wanjay@amazon.com>

[Severity: Low]
This isn't a bug in the code, but the commit log still has an unresolved
TODO-NEEDS-IHOR prefix on the Signed-off-by trailer following
Co-developed-by. Should that placeholder be resolved before merging?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..1b901e3cb3c22 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6867,30 +6883,33 @@ static int check_ptr_to_map_access(struct bpf_ver=
ifier_env *env,
>  	enum bpf_type_flag flag =3D 0;
>  	const struct btf_type *t;
>  	const char *tname;
> +	struct btf *btf;
>  	u32 btf_id;
>  	int ret;
> =20
> -	if (!btf_vmlinux) {
> -		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_B=
TF\n");
> -		return -ENOTSUPP;
> -	}
> -
>  	if (!map->ops->map_btf_id || !*map->ops->map_btf_id) {
>  		verbose(env, "map_ptr access not supported for map type %d\n",
>  			map->map_type);
>  		return -ENOTSUPP;
>  	}
> =20
> -	t =3D btf_type_by_id(btf_vmlinux, *map->ops->map_btf_id);
> -	tname =3D btf_name_by_offset(btf_vmlinux, t->name_off);
> -
> +	/* before the BTF fetch: unprivileged loads must not parse it */
>  	if (!env->allow_ptr_leaks) {
> -		verbose(env,
> -			"'struct %s' access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\=
n",
> -			tname);
> +		verbose(env, "map_ptr access is allowed only to CAP_PERFMON and CAP_SY=
S_ADMIN\n");
>  		return -EPERM;
>  	}
> =20
> +	btf =3D bpf_get_btf_vmlinux();
> +	if (IS_ERR(btf))
> +		return vmlinux_btf_err(env, btf);
> +	if (!btf) {
> +		verbose(env, "map_ptr access not supported without CONFIG_DEBUG_INFO_B=
TF\n");
> +		return -ENOTSUPP;
> +	}

[Severity: Low]
Can this !btf check in check_ptr_to_map_access() ever be reached?

When CONFIG_DEBUG_INFO_BTF is disabled, BTF_ID_LIST_SINGLE() and
BTF_ID_LIST_GLOBAL_SINGLE() in include/linux/btf_ids.h define zero-initiali=
zed
arrays:

    #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_u=
nused name[1];
    #define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 __maybe_u=
nused name[1];

Because *map->ops->map_btf_id is 0 for all map types when
CONFIG_DEBUG_INFO_BTF is disabled, moving bpf_get_btf_vmlinux() after the
!*map->ops->map_btf_id check causes check_ptr_to_map_access() to always exit
early with "map_ptr access not supported for map type %d", leaving the !btf
branch unreachable.

[ ... ]

> @@ -20898,12 +20941,14 @@ static int check_pseudo_btf_id(struct bpf_verif=
ier_env *env,
>  			return -EINVAL;
>  		}
>  	} else {
> -		if (!btf_vmlinux) {
> +		btf =3D bpf_get_btf_vmlinux();
> +		if (IS_ERR(btf))
> +			return vmlinux_btf_err(env, btf);
> +		if (!btf) {
>  			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=
=3Dy is specified in Kconfig.\n");
>  			return -EINVAL;
>  		}
> -		btf_get(btf_vmlinux);
> -		btf =3D btf_vmlinux;
> +		btf_get(btf);
>  	}
> =20
>  	err =3D __check_pseudo_btf_id(env, insn, aux, btf);

[Severity: High]
Can a program create a PTR_TO_BTF_ID register through check_pseudo_btf_id()
without btf_vmlinux being fetched or validated, leading to a NULL or ERR_PTR
dereference of btf_vmlinux in check_func_arg()?

In check_helper_call(), bpf_get_btf_vmlinux() is only called when
IS_ENABLED(CONFIG_DEBUG_INFO_BTF) && helper_uses_vmlinux_btf(func_id, fn), =
and
helper_uses_vmlinux_btf() omits ARG_PTR_TO_BTF_ID_SOCK_COMMON under the
assumption that every source of a PTR_TO_BTF_ID register has already fetched
btf_vmlinux.

However, in check_pseudo_btf_id(), when btf_fd (insn[1].imm) is non-zero:

    btf_fd =3D insn[1].imm;
    if (btf_fd) {
        btf =3D btf_get_by_fd(btf_fd);
        if (IS_ERR(btf)) {
            verbose(env, "invalid module BTF object FD specified.\n");
            return -EINVAL;
        }
    } else {
        btf =3D bpf_get_btf_vmlinux();
        ...
    }

btf_get_by_fd() accepts any BTF fd, including a user-loaded BTF created via
BPF_BTF_LOAD (which does not fetch btf_vmlinux), and check_pseudo_btf_id()
does not verify btf_is_module(btf) or btf_is_kernel(btf). If a user loads a
BTF containing a BTF_KIND_STRUCT and a BTF_KIND_VAR whose name matches a
kernel symbol in kallsyms, __check_pseudo_btf_id() sets
aux->btf_var.reg_type =3D PTR_TO_BTF_ID and check_ld_imm() marks the destin=
ation
register as PTR_TO_BTF_ID while btf_vmlinux is still NULL (with
CONFIG_DEBUG_INFO_BTF_LAZY=3Dy before first parse, or CONFIG_DEBUG_INFO_BTF=
=3Dn)
or ERR_PTR (if btf_parse_vmlinux() failed).

When that PTR_TO_BTF_ID register is then passed to a helper taking
ARG_PTR_TO_BTF_ID_SOCK_COMMON (or ARG_PTR_TO_BTF_ID when
CONFIG_DEBUG_INFO_BTF=3Dn), check_func_arg() does:

    case ARG_PTR_TO_BTF_ID:
    case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
    {
        const u32 *arg_btf_id =3D fn->arg_btf_id[arg];
        const struct btf *arg_btf =3D is_kfunc(meta) ? meta->btf : btf_vmli=
nux;
        ...
        if (!meta->btf) {
            ...
            if (base_type(reg->type) !=3D PTR_TO_BTF_ID)
                break;
        }
        ...
        if (!process_arg_ptr_to_btf_id(env, reg, regno, arg_btf_id, arg_btf=
, meta))

which passes arg_btf =3D btf_vmlinux (NULL or ERR_PTR) into
bpf_diag_fmt_btf_type() and process_arg_ptr_to_btf_id() ->
btf_type_skip_modifiers() -> btf_type_by_id(), dereferencing arg_btf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031130959.2347=
2-1-wanjay@amazon.com?part=3D2
