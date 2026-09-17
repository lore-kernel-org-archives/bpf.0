Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD64A3866
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680894; cv=none; b=aI/xedFSvdt/r9DWFuhRO6WqAYjxMn0pTq7d9p3IydOw8xMJykJsC+U6lSvP8khILly66Mz54aYfKVPVlCEM54Jpt23GyXFcposGIrDmkAke5mYGL5QUz1YvD1HtS4HhKG0CANFbTf/V1dH+dwvymJlu4Ve24GzCEDz+BEElaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680894; c=relaxed/simple;
	bh=avVOEarCtqLCpiMvQJHXHPyA96GX6OKAMo7wb4TydVM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Y59gqbcInyLgWOAauyCLpNOVBfyFDtzTVX+3/ALFL0J2dgyPYcOXgPlM48mo4SvUkehV/3OskHBGvqqfi77UnNpR6zXo21KxFmaPCp87WucWNygR0/hrSpSexTUDLPVyMK1nLnnoBmnHjXnb8ILoemCe/JVcy/ksnbUiWl+lUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6O6+VNK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6O6+VNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBAE1F000FF;
	Thu, 17 Sep 2026 21:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680892;
	bh=wDESKXh2sFbhHqe9FM2/OaKzBOrYFaZD1PdyOU6fI80=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O6O6+VNKYz3b/Yhej5PBUQ2CvihDsBSoLqRE/cZkidiLodPw2oD5gBs8KFXMY7EkV
	 bTII5xCHfPmhELQ8YgvJ0bmE3dL8Ae8Vp+BFyGtufBil2xsapAZLVU+sz0QsKqFM51
	 h+DRlLzHEdzL+7Kj+MhonZP34Bzle4fUIVSyibhgkjlBkQyscSGrrjQcRUwbtwRpp5
	 fnBOh/Ob8qt9N87OCOfDPbWghwGxRiIRhezSwCyprL37QWoeeN5a47Qnx3UYBb+YLT
	 dKB1jyDjy56XW4pzzvN1EmlGkJkpoQ1LfIVjPZ8JhsBZoascRqEAZerXnk94lBVGxS
	 QjLGEUjuF1lgA==
Content-Type: multipart/mixed; boundary="===============5074281865827039718=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d014308da436fc5df48c6bc8f02184557a1635049630d1424a5592791dda8020@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-3-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-3-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 2/6] libbpf: BPF programs manual loading and attaching
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:52 +0000 (UTC)

--===============5074281865827039718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index bd510a4e4941c..acb8caffa442e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -8058,7 +8060,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>  			log_buf = prog->log_buf;
>  			log_buf_size = prog->log_size;
>  			own_log_buf = false;
> -		} else if (obj->log_buf) {
> +		} else if (obj->log_buf && prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL) {
>  			log_buf = obj->log_buf;
>  			log_buf_size = obj->log_size;
>  			own_log_buf = false;

Does manually-loaded programs need to skip the object-level verifier log
buffer? obj->log_buf comes from bpf_object_open_opts.kernel_log_buf; it is
caller-owned memory that libbpf never frees, so there doesn't appear to be
a lifetime reason to skip it after the object has been loaded.

The observable effect is that when a user opens an object with
kernel_log_buf set and then loads a program via bpf_program__load_manually(),
this falls through to the else arm, realloc()s its own buffer, and on
failure dumps the log to pr_warn()/pr_debug() instead of into the caller's
buffer, which stays empty. That's the only load path where kernel_log_buf
now does nothing.

[ ... ]

> @@ -9063,33 +9068,50 @@ static void bpf_object_unpin(struct bpf_object *obj)
>  			bpf_map__unpin(&obj->maps[i], NULL);
>  }
>
> -static void bpf_object_cleanup_btf(struct bpf_object *obj)
> +static void bpf_object_cleanup_btf(struct bpf_object *obj, bool force)
>  {
>  	int i;
>
> -	/* clean up module BTFs */
> -	for (i = 0; i < obj->btf_module_cnt; i++) {
> -		close(obj->btf_modules[i].fd);
> -		btf__free(obj->btf_modules[i].btf);
> -		free(obj->btf_modules[i].name);
> +	/*
> +	 * Module BTF fds may still be borrowed (via fd_array,
> +	 * attach_btf_obj_fd, or baked into relocated instructions) by
> +	 * programs that have not been manually loaded yet, so defer
> +	 * closing them in that case to the end of the object lifetime,
> +	 * unless the caller forces immediate cleanup.
> +	 */
> +	if (force || !obj->has_manual_progs) {
> +		for (i = 0; i < obj->btf_module_cnt; i++) {
> +			close(obj->btf_modules[i].fd);
> +			btf__free(obj->btf_modules[i].btf);
> +			free(obj->btf_modules[i].name);
> +		}
> +		obj->btf_module_cnt = 0;
> +		obj->btf_module_cap = 0;
> +		obj->btf_modules_loaded = false;
> +		zfree(&obj->btf_modules);
>  	}
> -	obj->btf_module_cnt = 0;
> -	obj->btf_module_cap = 0;
> -	obj->btf_modules_loaded = false;
> -	zfree(&obj->btf_modules);
>
> -	/* clean up vmlinux BTF */
> -	btf__free(obj->btf_vmlinux);
> -	obj->btf_vmlinux = NULL;
> +	/*
> +	 * The btf_vmlinux data is needed for manually loaded programs,
> +	 * so defer freeing it in that case to the end of the object lifetime.
> +	 */
> +	if (force || !obj->has_manual_progs) {
> +		btf__free(obj->btf_vmlinux);
> +		obj->btf_vmlinux = NULL;
> +	}
>  }

[ ... ]

> @@ -9817,9 +9838,13 @@ bool bpf_program__autoattach(const struct bpf_program *prog)
>  	return prog->autoattach;
>  }
>
> -void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
> +int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
>  {
> +	if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
> +		return libbpf_err(-EINVAL);
> +
>  	prog->autoattach = autoattach;
> +	return 0;
>  }

The return type of bpf_program__set_autoattach() is changed from void to
int, but the symbol keeps its original version node LIBBPF_1.0.0 in
libbpf.map and no compat symbol is added. This creates a runtime ABI
hazard: an application compiled against the new libbpf.h that does
`if (bpf_program__set_autoattach(prog, false)) goto err;` records an
undefined reference to bpf_program__set_autoattach@LIBBPF_1.0.0.

That version requirement is satisfied by any libbpf.so.1 from 1.0 through
1.7, where the function is void and never writes the return register. The
caller then tests an undefined value and can take a spurious error path.

This also affects source compatibility: any existing user code that takes
the address of the API (e.g. `void (*fn)(struct bpf_program *, bool) =
bpf_program__set_autoattach;`) or that redeclares it in a binding layer
now fails to compile.

Documentation/bpf/libbpf/libbpf_naming_convention.rst, "ABI versioning":
"Every time ABI is being changed, e.g. because a new symbol is added or
semantic of existing symbol is changed, ABI version should be bumped." The
semantics of this symbol changed (it can now fail with -EINVAL) and its
return type changed, yet its version node is untouched.

All six in-tree callers discard the return value, so nothing in-tree
changes behaviour; the exposure is entirely to out-of-tree users of the
stable API.

[ ... ]

> @@ -15236,10 +15261,48 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>
>  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
>  {
> -	if (prog->obj->state >= OBJ_LOADED)
> +	struct bpf_object *obj = prog->obj;
> +
> +	if (obj->state >= OBJ_PREPARED)
> +		return libbpf_err(-EINVAL);

The state gate is tightened from OBJ_LOADED to OBJ_PREPARED. Since commit
7a9899b0140f4 (the immediately preceding patch in this series)
bpf_program__set_autoload() is a thin wrapper around
bpf_program__set_load_strategy(), this silently regresses the long-standing
public API bpf_program__set_autoload().

Before this commit the gate was `prog->obj->state >= OBJ_LOADED`, so
autoload could be changed anywhere in the bpf_object__prepare() ->
bpf_object__load() window. After this commit any
bpf_program__set_autoload() call on an object that has been through
bpf_object__prepare() returns -EINVAL.

Turning autoload off after prepare (to skip loading a program) is a
legitimate use of that window, which bpf_object__prepare() exists to
expose (libbpf.h:270: "Leaves BPF object in the state ready for program
loading").

The commit message does not mention this behaviour change, and the
kernel-doc for bpf_program__set_load_strategy() in libbpf.h is now wrong
on both counts: "Can only be called before the enclosing bpf_object is
loaded." and "@return 0 on success; negative error code if the object was
already loaded".

No in-tree caller currently orders set_autoload() after prepare
(veristat.c's process_obj() sets autoload before bpf_object__prepare()), so
the breakage lands on out-of-tree libbpf consumers only.

If the tightening is intentional (MANUAL bookkeeping is finalized in
bpf_object_prepare_progs()), should it apply only to the MANUAL case, or
should the header docs and changelog state that set_autoload()/
set_load_strategy() no longer work after prepare?

[ ... ]

> +	switch (strategy) {
> +	case BPF_PROG_LOAD_STRATEGY_DISABLED:
> +	case BPF_PROG_LOAD_STRATEGY_AUTO:
> +		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
> +			prog->autoattach = prog->saved_autoattach;
> +		prog->load_strategy = strategy;
> +		break;
> +	case BPF_PROG_LOAD_STRATEGY_MANUAL:
> +		/*
> +		 * Manually-loaded programs are not supported for gen_loader.
> +		 * This is because bpf_object_load_prog is not called for
> +		 * manually-loaded programs, so such programs are not visible
> +		 * to gen_loader. For this reason, prevent calling
> +		 * bpf_program__set_load_strategy(MANUAL) when gen_loader was
> +		 * used to generate a BPF object loader.
> +		 * A gen_loader implementation is being called for autoloaded
> +		 * programs and defines its own model for loading BPF programs.
> +		 * To pass a BPF program to gen_loader, set the program's load strategy
> +		 * to LD_AUTOLOAD.
> +		 */
> +		if (obj->gen_loader)
> +			return libbpf_err(-EOPNOTSUPP);

The gen_loader rejection is order-dependent and can be bypassed, so the
combination the code itself declares unsupported still reaches
bpf_object_load(). bpf_object__gen_loader() (a public API) performs no
symmetric check, so the following sequence is accepted at every step:

  obj = bpf_object__open_file(...);
    /* state == OBJ_OPEN, gen_loader == NULL */
  bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
    /* passes: obj->gen_loader is still NULL */
  bpf_object__gen_loader(obj, &opts);
    /* no check for existing MANUAL programs */
  bpf_object__load(obj);

Once loaded, bpf_object__load_progs() skips the MANUAL program, so
bpf_gen__prog_load() is never called for it and gen->nr_progs (incremented
only in bpf_gen__prog_load()) undercounts obj->nr_programs.
bpf_gen__finish() only rejects the opposite skew:

  if (nr_progs < gen->nr_progs || nr_maps != gen->nr_maps) { ... -EFAULT }

so the mismatch passes silently, and bpf_gen__finish()'s wiring loop maps
prog_desc[i] <- stack prog_fd[i] for i in [0, gen->nr_progs), shifting
every light-skeleton program slot after the skipped MANUAL program onto the
wrong prog_fd. The result is a silently mis-wired generated loader rather
than an error.

The in-code comment directly above the guard overstates what it achieves:
it says the check "prevent[s] calling
bpf_program__set_load_strategy(MANUAL) when gen_loader was used", but it
only covers the gen_loader-then-MANUAL ordering, not
MANUAL-then-gen_loader.

Note also that the early-out at line 15269 (`if (strategy ==
prog->load_strategy) return 0;`) sits before the guard, so a repeat MANUAL
call succeeds even when obj->gen_loader is already set.

Commit 2ebb83ef30035 (forward search over the supplied range 41c79ac..HEAD)
adds the missing check inside bpf_object__gen_loader() and describes
exactly this failure mode.

The comment also tells the reader to "set the program's load strategy to
LD_AUTOLOAD", but no identifier named LD_AUTOLOAD exists anywhere in the
tree. The enumerator is BPF_PROG_LOAD_STRATEGY_AUTO (libbpf.h:2110). The
same comment also names the internal helper as "bpf_object_load_prog" when
the function that actually skips manual programs is bpf_object__load_progs()
- bpf_object_load_prog() is the per-program loader and is called for manual
programs, from bpf_program__load_manually(). Both make the only piece of
documentation for this restriction point at the wrong symbols.

[ ... ]

> +		if (prog_is_subprog(obj, prog))
> +			return libbpf_err(-EINVAL);
> +
> +		prog->saved_autoattach = prog->autoattach;
> +		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
> +		prog->autoattach = false;
> +		break;
> +	default:
> +		return libbpf_err(-EINVAL);
> +	}

The patch introduces a save/restore protocol for prog->autoattach that is
keyed entirely on load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL, but two
pre-existing sites assign prog->load_strategy directly and were not
updated, so they clobber MANUAL and strand the saved value:

  - bpf_object_adjust_struct_ops_autoload() (libbpf.c:1168), run from
    bpf_object_prepare() before bpf_object_prepare_progs()
  - bpf_map__init_kern_struct_ops() (libbpf.c:1249 and 1288),
    `st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;`

bpf_program__set_load_strategy() rejects subprograms and gen_loader objects
for the MANUAL case, but not struct_ops programs. So for a struct_ops
program the user marked MANUAL:

  1. set_load_strategy(MANUAL) stashes saved_autoattach and forces
     prog->autoattach = false.
  2. bpf_object_prepare() overwrites load_strategy with AUTO or DISABLED,
     bypassing the `if (prog->load_strategy ==
     BPF_PROG_LOAD_STRATEGY_MANUAL) prog->autoattach =
     prog->saved_autoattach;` restore that only lives inside
     set_load_strategy().
  3. prog->autoattach stays false permanently while
     bpf_program__load_strategy() reports AUTO, obj->has_manual_progs is
     never set (prepare_progs runs after the clobber and sees AUTO/DISABLED),
     and a later bpf_program__load_manually() returns -EINVAL.

All of this happens with no warning: the request is silently discarded and
the program's autoattach flag is left inverted relative to what the user
configured.

Should struct_ops programs be rejected in bpf_program__set_load_strategy()
alongside the existing prog_is_subprog() check, or should the two direct
assignments preserve/restore the MANUAL bookkeeping?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index cdf300443f19c..5914e5001b972 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h

[ ... ]

> @@ -378,7 +378,7 @@ LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog)
>  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
> -LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
> +LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);

[ ... ]

> @@ -2133,6 +2135,9 @@ LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
>   */
>  LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
>
> +LIBBPF_API int bpf_program__load_manually(struct bpf_program *prog);
> +LIBBPF_API int bpf_program__unload_manually(struct bpf_program *prog);

The two new public APIs are added as bare declarations with no
documentation comment. Documentation/bpf/libbpf/libbpf_naming_convention.rst,
"API documentation convention", requires public APIs to be documented above
the declaration with @brief/@param and, for non-void returns, @return.
Every other API added by this series follows it -
bpf_program__set_load_strategy() (libbpf.h:2116) and
bpf_program__load_strategy() (libbpf.h:2130) both carry full
@brief/@param/@return blocks - so the omission is also inconsistent within
the same header region.

The undocumented contracts are not guessable from the signatures and are
only visible in the implementation:
  - load requires the object to be at least OBJ_PREPARED
    (bpf_object__prepare()), not fully loaded, else -EINVAL;
  - the program's load strategy must be BPF_PROG_LOAD_STRATEGY_MANUAL and it
    must not be a subprogram, else -EINVAL;
  - re-loading an already-loaded program returns -EBUSY;
  - unload only closes the FD and deliberately retains the program image so
    it can be reloaded.

Related naming concern: bpf_program__unload_manually() sits alongside the
long-standing public bpf_program__unload() (libbpf.h:462, LIBBPF_0.0.1),
and the two have deliberately different semantics -
bpf_program__unload() also zfree()s prog->func_info, prog->line_info and
prog->subprogs, making the program unreloadable, whereas the new one
preserves them. With neither declaration documented, the near-identical
names give a caller no way to tell them apart.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============5074281865827039718==--
