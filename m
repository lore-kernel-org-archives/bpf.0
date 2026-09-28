Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9F3A7F64;
	Mon, 28 Sep 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635327; cv=none; b=Y2FlQgXRLgYQ58A/XXl7jLO6hJmj/iwOeTOtTQJ00Zf9wem4vyYcPjaFY1E5i/dvj5ZjbvFEmT00ghDsS9nmhn65jCgLtImwNfWtg6K/jN9dbG7gopTwWHtHgorfT4XORBLrJV54CN39SgU5A+42EOOExfQtANHBsXNhjESGiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635327; c=relaxed/simple;
	bh=GCkQxK+F+gdI6MW1dWplhGxzJcpdJ//SZALXVdn+AyA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mAYCHB3SMxbZSn8K8LdpItD//72lK93Az14KiAEideI2LbV8oUU0EnrLLYXWt0HNOg9nr4Id1ACHuXoGTKdBnFnsoelpsAl4v82TPPweIi1zTpV3kmHoTAXDJxPC6PAm7liySUcjGGI8EfZbivcEqs2RGUqWP8OKtbwW9oB+Uxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH3MAEA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH3MAEA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73BF1F000FF;
	Mon, 28 Sep 2026 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635325;
	bh=ja00SkfqPBni3tmJwpP0b16xXvQ7bD4DwP5f0h0tncQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NH3MAEA9t6gAa57aMaiSx+Y4j0dtpazM5FV4ESybGvi9aeKgdM3Q9C1fCNabmboEC
	 vdkcNZU4XdMac37DzfujLJ1KbMbyrmYioTvw1r4UkhLdL02LqO7kIupw/771VwNtyW
	 jUvf6PvP3Ybj+OLh58Ox8fbqrcbzhCKNwmmvyInET+Ak2JQ+ZFwmingIFlwiTCtJGm
	 zOmhUA53rl/tdG8nM9qWmIERCfp2J7CnjUA7LBqb7AruyVWdmfeFbtWvelThNHMl65
	 FL9nJYFy6wz5W0kz0t+5ndbRMk6rVCYbGwgMb6jnDaHOdhjMI6OPiOGCkeQjyIEpBd
	 g9zGCuUw1vVaA==
Content-Type: multipart/mixed; boundary="===============7436171552706210109=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c450ab4be9ca9cdf0934b52ee5c4f8d0bcaec49c39c454dae22712fbd24ad42c@mail.kernel.org>
In-Reply-To: <20260928215110.3966357-1-vineet.gupta@linux.dev>
References: <20260928215110.3966357-1-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix linked_externs with bpf-gcc
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 22:42:04 +0000 (UTC)

--===============7436171552706210109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/linked_arena1.c b/tools/testing/selftests/bpf/progs/linked_arena1.c
> index 3e8788dec1d9..dd9c5fa424dd 100644
> --- a/tools/testing/selftests/bpf/progs/linked_arena1.c
> +++ b/tools/testing/selftests/bpf/progs/linked_arena1.c
> @@ -10,13 +10,33 @@ struct {
>  	__uint(max_entries, 1); /* number of pages */
>  } arena SEC(".maps");
>
> -long __arena a_val = 1;
> +/*
> + * Dereferencing an arena global needs the compiler to emit an
> + * addr_space_cast, which only clang does. Keep the variables so the arena
> + * is still populated and the skeleton still has its arena member, but skip
> + * the test elsewhere.
> + */
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +bool skip_tests __attribute((__section__(".data"))) = false;
> +#else
> +bool skip_tests = true;
> +#endif
> +
> +long __arena_global a_val = 1;
>  extern long __arena b_val; /* defined in linked_arena2.c */
>
>  SEC("syscall")
>  int sum1(void *ctx)
>  {
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>  	return a_val + b_val;
> +#else
> +	/*
> +	 * Reference the extern without dereferencing it, so that the relink
> +	 * test still has an extern to resolve.
> +	 */
> +	return (long)&b_val;
> +#endif
>  }

Does the relink_arena test exercise externs in allocated sections under
bpf-gcc as intended?

The commit message explains that __arena is a pointee annotation and
that placement comes from __arena_global. The definition a_val was
switched to __arena_global, but the extern declaration b_val still uses
__arena.

Under gcc, __arena expands to __attribute__((btf_type_tag("arena")))
with no section, so b_val has no explicit section. GCC does not put an
extern that has no explicit section into any BTF DATASEC (GCC
PR112849), which means under bpf-gcc b_val is a free-floating extern
VAR, not an entry of the .addr_space.1 DATASEC.

In tools/lib/bpf/linker.c, find_glob_sym_btf() returns btf_sec_id = 0
for it. linker_append_elf_sym() never takes the branch for externs in a
real allocated section:

    if (sym_is_extern && btf_sec_id) {
        ...
        if (strcmp(sec_name, BTF_EXTERN_SEC) != 0) {
            src_sec = find_src_sec_by_name(obj, sec_name);

That branch is what d07d3efd0141 ("libbpf: Fix static linking of
externs placed in allocated sections") fixed and what 34354db1b148 is
meant to cover. The check in test_relink() only walks the .addr_space.1
DATASEC:

    id = btf__find_by_name_kind(btf, sec_name, BTF_KIND_DATASEC);
    ...
        ASSERT_NEQ(btf_var(t)->linkage, BTF_VAR_GLOBAL_EXTERN, "var_resolved");

Under gcc that DATASEC never holds an extern, so the check cannot fail.
The reported "linked_externs/relink_arena:OK" for bpf-gcc would hold
with or without the linker fix.

By contrast, linked_maps1.c declares its extern with an explicit section
(extern map2_t map2 SEC(".maps");), so relink_maps covers the
allocated-section path under both compilers.

Declaring b_val with __arena_global would do the same here: under gcc
that is SEC(".addr_space.1"), and the bpf_gcc flavor builds with
-Wno-attributes, so the ignored 'used' on an extern is silent; under
clang it is address_space(1), same as today, because clang ignores
btf_type_tag on non-pointer types.

>
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/linked_arena2.c b/tools/testing/selftests/bpf/progs/linked_arena2.c
> index d0bcdf18a4b6..1bc8b97ed8cc 100644
> --- a/tools/testing/selftests/bpf/progs/linked_arena2.c
> +++ b/tools/testing/selftests/bpf/progs/linked_arena2.c
> @@ -4,15 +4,19 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_arena_common.h"
>
> -long __arena b_val = 2;
> +long __arena_global b_val = 2;
>  extern long __arena a_val; /* defined in linked_arena1.c */

The same applies to the extern a_val declaration here.

>
>  SEC("syscall")
>  int bump2(void *ctx)
>  {
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
>  	a_val += 10;
>  	b_val += 20;
>  	return a_val + b_val;
> +#else /* see linked_arena1.c */
> +	return (long)&a_val;
> +#endif
>  }
>
>  char _license[] SEC("license") = "GPL";


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36490925455
--===============7436171552706210109==--
