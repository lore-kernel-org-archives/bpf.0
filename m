Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405789;
	b=z90d28zatJRpkDZNBwmXKMDY/kv+vdHPBp8zIcPZUYRZdDSllUd9pE4wADbPWadGHFmy
	 UC0D4gm47yRq3istVHpXSeuMapcmOMpTg5NcnW3AynyZpWcIx2y5jJvaXlhJQD2Dg7qgC
	 zDKnFw+syHGF/oFAl1X7px+GKShddQBncd164UloQPKE3ndmKZw/2jQcu57ixwWTUxEdr
	 aTYg4AvBfvTl8NTkUcDczOeLGrM9uxfVdPlc9CGv23IKljSQTzTmiiE9H1s2uALkMwH5s
	 SwIHXb25sRtvd5WcaLCwSXSZLVj3V8OSZRAni8YXCJwS6Gp7hiEbViOt3WPTKVssRcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405789;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=hpJ8+O3lybCRqV8x1TEUqdWUCWcOiRkHOmOanC3aZ+k=;
	b=rEebI9bGdmC0ZiXKmH3aPDf2o9VVDCXnpBDIRZjK/iu+O8NeEp6bJ7W81y8Un4OXO4zW
	 h9YGiNCXZydoyu5dIXTUozq6UogrdPQBk7KkLgDq9UPQGR1jPQq/gXINJ/b/6gFyFyb97
	 3RtFcyooMjE0drvM/78YWYfv131XvrnEngJXzrwPuVer3Og2M3nyVvNcoUpcxbzJOO3dV
	 JAemb0J2rrfdMGF5WhrGJ0+gLA048TD3uknaTJDDzukdGAszjDnWVlQ6xVxrPTA+JMsyp
	 n0+GeqBJakCJKcmIZASIIDNF6GfRTiC0eVjFTGq+IidAFqA5eVsSernBFozhwCP/W8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+JuctI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7571606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+JuctI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211A31F0093A;
	Sat, 31 Oct 2026 00:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793405788;
	bh=hpJ8+O3lybCRqV8x1TEUqdWUCWcOiRkHOmOanC3aZ+k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U+JuctI0HCThaWt50FyBfyN/bYjxvLl2qGgVYon94XPe33LoFvXkJ3iZqNyS6Kq1v
	 tl0YKxKe9Xkbp32SRKC81Nlm3AEJgt++zfdwww48c0tteCR8Gjzb9LmH9IpBSV7Hhb
	 fUR/ppjNo8Jo7cSf+FSdcQzdCIHk0lp0OLG14HGSCTyRbUWDeiCwVfJyCVR8p/qi12
	 rs+uHB6QNxs2laG1/3UhnH2lH+/0BxDoLqSwWB5HQl/jNDV/WFwAWEtjyd+yX6mZAx
	 1+n1nYHTXTxpSCMmMk++Mxd8M+mSNb/TJ+naHZCQD4ML5EoRcl8+zk8eRMJiN6xGu1
	 /25TGx014+jbw==
Content-Type: multipart/mixed; boundary="===============4519568614030817260=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <b8912e062900f51fd8c8f44c44ef43d0788ce6af12582abc0060dd6cd4c05065@mail.kernel.org>
In-Reply-To: <20261030233355.1836749-3-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-3-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 02/13] libbpf: Dump kflagged BTF tags as is
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oss.qualcomm.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 00:16:28 +0000 (UTC)

--===============4519568614030817260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Dump kflagged BTF tags as is

TL;DR: Printing kflag type tags as is may make C dumps of existing kernel BTF
emit invalid "address_space(1)" for arena kfuncs, possibly breaking vmlinux.h
and bpftool builds until a later patch in the series.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 5ad547356303..c16dd93fa6d4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -204,7 +204,7 @@ struct btf_links {
>  #define KF_ARENA_ARG2	(1 << 15)
>  #define KF_IMPLICIT_ARGS (1 << 16)
>  #define KF_IMPL_SUFFIX "_impl"
> -#define TYPE_ATTR_ARENA "address_space(1)"
> +#define TYPE_ATTR_ARENA "__attribute__((address_space(1)))"
>  #define PARAM_SUFFIX_ARENA "__arena"
>  #define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
>  

[ ... ]

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index ea9a34db4c00..faa9aee52d74 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c

[ ... ]

> @@ -1594,7 +1594,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
>  			btf_dump_emit_mods(d, decls);
>  			name = btf_name_of(d, t->name_off);
>  			if (btf_kflag(t))
> -				btf_dump_printf(d, " __attribute__((%s))", name);
> +				btf_dump_printf(d, " %s", name);
>  			else if (strcmp(name, "arena") == 0)
>  				/* the tag denotes a pointer into the BPF arena address space */
>  				btf_dump_printf(d, " __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))");

Can this break C dumps of BTF that is already deployed?

Kernels built with pahole >= 1.30 have the arena kfuncs
(bpf_arena_alloc_pages, bpf_arena_free_pages, bpf_arena_reserve_pages) in
vmlinux BTF with a TYPE_TAG with kflag=1 and the string "address_space(1)",
since commit 21cb33c7e065 ("kbuild, bpf: Enable --btf_features=attributes").
resolve_btfids has emitted the same string since 27a78c2e7eee, and still does
up to the parent of this commit.

The old code depended on btf_dump adding the wrapper:

    if (btf_kflag(t))
        btf_dump_printf(d, " __attribute__((%s))", name);

With this change the name is printed as is.  So running:

    bpftool btf dump file /sys/kernel/btf/vmlinux format c

against any of those kernels goes through:

    dump_btf_c() -> dump_btf_kfuncs() -> btf_dump__emit_type_decl() ->
    btf_dump_emit_type_chain()

and emits:

    extern void address_space(1) *bpf_arena_alloc_pages(void *p__map,
        void address_space(1) *addr__ign, ...) __weak __ksym;

That is not valid C.  Won't any BPF program that includes the generated
vmlinux.h without BPF_NO_KFUNC_PROTOTYPES fail to build?

That includes bpftool's own skeletons.  tools/bpf/bpftool/Makefile takes
VMLINUX_BTF from /sys/kernel/btf/vmlinux when no built vmlinux is present and
runs:

    $(BPFTOOL_BOOTSTRAP) btf dump file $< format c > vmlinux.h

skeleton/pid_iter.bpf.c and skeleton/profiler.bpf.c then #include <vmlinux.h>,
so would a standalone bpftool build from this commit, on a host running such
a kernel, fail?  BPF selftests and other tools/ users that fall back to the
running kernel's BTF look to be hit the same way.

The commit message says:

> In-tree, only resolve_btfids applying address_space(1) attribute is
> affected.

Does that account for BTF that resolve_btfids and pahole already produced,
which is now on running systems and which bpftool, also in-tree, consumes?

At this commit, Documentation/bpf/btf.rst still says that for kind_flag=1 the
string is the attribute-list ("for an __attribute__((aligned(4))) the
string's contents is aligned(4)"), and the btf__add_type_attr() and
btf__add_decl_attr() comments in tools/lib/bpf/btf.c still describe the tag
as an __attribute__.  Doesn't a producer that follows the documentation now
get output that does not compile?

A later commit in the series, fd1278be39e3 ("bpftool: Normalize legacy arena
type tags before C dumps"), rewrites "address_space(1)" type tags to
"__attribute__((address_space(1)))" before bpftool dumps C.  Its commit
message describes this same breakage: "C dumps of such BTF declare arena
kfunc pointers as "void address_space(1) *", which does not compile".

That fix only covers bpftool, and only non-split BTF ("Split BTF is dumped as
is").  Other users of libbpf's public btf_dump__dump_type() and
btf_dump__emit_type_decl() API that dump existing kernel BTF still get the
uncompilable output.

5890b58f3c99 ("docs, libbpf: Document complete BTF annotation strings") later
updates the documentation and API comments.  On its own, this commit still
breaks bisection for anyone building bpftool or vmlinux.h against a v6.16+
kernel.

Should the bpftool normalization land before, or together with, the
btf_dump change?  And should libbpf keep handling the legacy
"address_space(1)" string itself, since libbpf ships separately and is used
with arbitrary kernel BTF?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41147288626
--===============4519568614030817260==--
