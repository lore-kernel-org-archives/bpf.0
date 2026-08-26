Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404B39794B
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772347; cv=none; b=rwUPu6ShVEBFjCI3OSfOuu20A6gzQPqOUr0CLGBbs9Z7Vo0jVNmSKtuINmIx7ijacmdf1KBBZkltR+ROWLehIhW60kf2U0fKGIg89XD6iNAv+tJwCamsNSCe9vYfW4G6k+iQepJXJtHCapohff0S2Vo+mRS6rGG3SUVOnU7YFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772347; c=relaxed/simple;
	bh=5b/ECp49L8jIiLp3ssx0mAGt7VfHIzSie+MNRnWE+cY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k1O+bMINLtt6xffPy0od4z7cenf8woaAKz+kKHymg6xCDnxinzy4DVuQKvFedBq91I+bHwPzSbz8VEkYH5zbWyStW3YWWM1OQSwEOl50ryPwKrfkskS4t8PdTfQj08nPp4aSJkVf+yMfjjcsG4q/rQy9JGjIkyqQCZMtPxYIu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy2rrx3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy2rrx3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312931F00A3E;
	Wed, 26 Aug 2026 19:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772324;
	bh=0LDphrX3Dvk1QBCU3Wh6IE+qbImUi+jsT9rlFq+dohE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hy2rrx3zOb4su3TnoT+I2vzXZ8veCUV5kh5OA/Yzuhdmgao+UnKtLnrjBEpysyym+
	 6Nw82GrJWL9HUqeZH86C8SiITTr37zoHY41CmmgRVrQvSVE8hr7aCkVU0WYqe8aGqb
	 nT7wtveEcQh7VhzHYGUlGFt/X6u7KVFwKOFlcmhZ2c1cbgMkJ+9yRrIOgxEnzuDBo8
	 BgHQooagRrXxkIJZN/amfZYHSaGuf93ghGuQFaQuNFI8wJnBaOKHClVOnrl4k3r2kV
	 SC1oFd9wuzeaYo2fORsnhKLIXoztG9txHMUBvKr5wTvD8eTowHOv4JheEyC/JilDFH
	 J9ch7aBfIQ5/w==
Content-Type: multipart/mixed; boundary="===============6681129137149194261=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <397260f6e73079ddc30bb5a8e25b78d23850b6e043f7f5e1cc64522cdcc8c7f8@mail.kernel.org>
In-Reply-To: <20260826181825.1826541-5-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-5-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 4/5] libbpf: Support declarative dynamic load via BTF decl_tag
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:24 +0000 (UTC)

--===============6681129137149194261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9d160b5b9c0ee..52978f0e04539 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -218,6 +218,11 @@ enum libbpf_tristate {
>  #define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
>  #define __arg_arena __attribute((btf_decl_tag("arg:arena")))
>
> +/* Mark a BPF program to be loaded dynamically instead of autoloaded,
> + * equivalent to bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC).
> + */
> +#define __load_dynamic __attribute__((btf_decl_tag("loadtype:dynamic")))
> +
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1d00c47841b..5d58dbf25234f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -7156,6 +7158,50 @@ static int bpf_prog_assign_exc_cb(struct bpf_object *obj, struct bpf_program *pr
>  	return 0;
>  }
>
> +#define DYNLOAD_DECL_TAG "loadtype:dynamic"
> +
> +/*
> + * Check whether a BPF program is annotated with the DYNLOAD_DECL_TAG BTF
> + * decl tag, requesting that it be loaded dynamically after the object load.
> + *
> + * Returns 1 if the tag is present, 0 if it is not, negative error otherwise.
> + */
> +static int prog_has_dynload_tag(struct bpf_object *obj, struct bpf_program *prog)
> +{
> +	int i, n;
> +
> +	if (!obj->btf)
> +		return 0;
> +
> +	n = btf__type_cnt(obj->btf);
> +	for (i = 1; i < n; i++) {
> +		const struct btf_type *tag_t, *fn_t;
> +
> +		tag_t = btf__type_by_id(obj->btf, i);
> +		if (!btf_is_decl_tag(tag_t) || btf_decl_tag(tag_t)->component_idx != -1)
> +			continue;
> +		if (strcmp(btf__str_by_offset(obj->btf, tag_t->name_off),
> +			   DYNLOAD_DECL_TAG) != 0)
> +			continue;
> +
> +		/* a decl tag's type field points at the entity it decorates */
> +		fn_t = btf__type_by_id(obj->btf, tag_t->type);
> +		if (!btf_is_func(fn_t) || btf_func_linkage(fn_t) != BTF_FUNC_GLOBAL) {
> +			pr_warn("prog '%s': " DYNLOAD_DECL_TAG
> +				" decl tag must be applied to a global function\n",
> +				prog->name);
> +			return -EINVAL;
> +		}
> +
> +		if (strcmp(btf__str_by_offset(obj->btf, fn_t->name_off), prog->name) != 0)
> +			continue;   /* tag belongs to a different program */
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct {
>  	enum bpf_prog_type prog_type;
>  	const char *ctx_name;

[ ... ]

> @@ -8467,6 +8516,22 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
>  			return err;
>  		}
>  	}
> +
> +	if (prog_is_subprog(obj, prog))
> +		continue;
> +
> +	err = prog_has_dynload_tag(obj, prog);
> +	if (err < 0)
> +		return err;
> +	if (err > 0) {
> +		err = bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC);
> +		if (err) {
> +			pr_warn("prog '%s': failed to apply " DYNLOAD_DECL_TAG
> +				" decl tag: %s\n",
> +				prog->name, errstr(err));
> +			return err;
> +		}
> +	}
>  }
>
>  return 0;

Can the gen_loader incompatibility check reach __load_dynamic programs?
Looking at the control flow, bpf_object_init_progs() runs inside
bpf_object_open() before the object is returned to the caller, but
bpf_object__gen_loader() is a public API that can only be called after
open returns. This means obj->gen_loader is structurally guaranteed to
be NULL when prog_has_dynload_tag() routes through
bpf_program__set_load_type() -> bpf_program__set_dynamicload().

The guard in bpf_program__set_dynamicload() checks:

    if (obj->gen_loader)
            return libbpf_err(-ENOTSUP);

Both in-tree gen_loader users call bpf_object__open_file() first, then
bpf_object__gen_loader(), then bpf_object__load():

tools/bpf/bpftool/prog.c:
    obj = bpf_object__open_file(file, &open_opts);
    ...
    err = bpf_object__gen_loader(obj, &gen_opts);
    ...
    err = bpf_object__load(obj);

tools/bpf/bpftool/gen.c:
    err = bpf_object__gen_loader(obj, &gen_opts);
    ...
    err = bpf_object__load(obj);

So running 'bpftool gen skeleton -L' on an object containing a
__load_dynamic program accepts the combination that the code declares
unsupported. The imperative bpf_program__set_dynamicload() call path
after open would correctly reject it, but the declarative path during
open cannot.

bpf_object__load_progs() then skips the program because load_type is
DYNAMIC, so bpf_gen__prog_load() is never emitted for it and
gen->nr_progs undercounts. The bpf_gen__finish() check only errors on
undercounts in the other direction, so the fd-writeback loop copies
prog_fd[i] into descriptor slot i for i < gen->nr_progs while bpftool
emits one struct bpf_prog_desc per program in object order. When the
dynamic program is not last, every following program's fd lands in the
wrong skel->progs.* slot.

Does this need an obj->gen_loader check in bpf_object_init_progs() after
prog_has_dynload_tag() returns 1, or should bpf_object__gen_loader() walk
the programs and error if it finds any with load_type == DYNAMIC?

> @@ -15248,10 +15313,9 @@ static int bpf_program__set_dynamicload(struct bpf_program *prog)
>  	 * to gen_loader. For this reason, prevent calling
>  	 * bpf_program__set_dynamicload when gen_loader was used to
>  	 * generate a BPF object loader.
> -	 * A gen_loader implementation is being called for autoloaded
> -	 * programs and defines its own model for loading BPF programs.
> -	 * To pass a BPF program to gen_loader, set the program's load type
> -	 * to LD_AUTOLOAD.
> +	 * A gen_loader implementation is being called for programs with
> +	 * load type BPF_PROG_LOAD_TYPE_AUTO and defines its own model for
> +	 * loading BPF programs.
>  	 */
>  	if (obj->gen_loader)
>  		return libbpf_err(-ENOTSUP);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000627295
--===============6681129137149194261==--
