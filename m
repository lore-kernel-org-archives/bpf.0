Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9F2F7F19
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209934; cv=none; b=QD2NGvEIQSM2rKswtLV8/LbErbsY5Lz6m92dAU9KsLOVOzUMC5g0CHWmbx7O3zqu+uigZAS0FQcSazXaqN7oWE9ZBMs58bURdIqf1quFvZMJF4Jze0kJXwAsPyvluuKPFlna0yskiVhDnrxxUqq+QB9x82kFUn1TiuXvKTHey/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209934; c=relaxed/simple;
	bh=JkHrbGtfuz+Sx0n+J7G53k+PsWAi6vJdo6MREWh0sTs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iT5rzwu+zPLnuQ4f1Bo6hUFM7MPrClkpx6dB/7GBkADN+z8lsaC97DZhps/Jc97hiWhgtWt5EhEQv7HuS3kY9mkq9tnt7eLQ8lfIjxKPHuRHAXB0SwJQaapc9l+bELj1FRRRBhK6necSneYACnA3JsHztyzbXoCD8bKoUZ1HZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY5agSpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY5agSpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7569A1F000FF;
	Thu, 24 Sep 2026 00:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209932;
	bh=lSEylbQrBG1e2x6Qd/3TOIRJdEYAc4sNlAC0wLoeP+Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jY5agSpn54Tz8Jxn/pLaeJJYCaZwg4kCUd9kCYjPVmvEgqEi797nUpvqof1z3PTyF
	 mkZuJbQY9+tdKhDTXQ9V37Tiu67/uPeo795JkRPz+QEtiIc0X/+ow8rFb6mI9rrAIO
	 anJhP05Y1SxUTBAsAdKnEvwXfXJe2dHZyQgQwppdy+P7UZ7mh52M3O+xvJPtenZfX2
	 xsCvikTPZvDLLoSVKuayqSjdtfT54zUk5yp3FkRDFtyEMY8pcd+7vBhETbsbAZVXNX
	 Zcunq+ygVboCDvR4qwDbAtN7LR8wJmA1WP3408PjyO7MnoQq1pnopVYWoYICL4Ppq9
	 ObiTOR9gJHrzA==
Content-Type: multipart/mixed; boundary="===============8013647888006912334=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <68df9eab1022e5ac30007383b6f5a85dc6d7c9884edccc5f4c84cdeb9b32d427@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:32:11 +0000 (UTC)

--===============8013647888006912334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a3085847cb97f..939f0d6378e38 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>
>  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
>  {
> -	if (prog->obj->state >= OBJ_LOADED)
> +	struct bpf_object *obj = prog->obj;
> +
> +	if (strategy == BPF_PROG_LOAD_STRATEGY_MANUAL ||
> +	    prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +		if (obj->state >= OBJ_PREPARED)
> +			return libbpf_err(-EINVAL);
> +	} else if (obj->state >= OBJ_LOADED) {
>  		return libbpf_err(-EINVAL);
> +	}
> +
> +	if (strategy == prog->load_strategy)
> +		return 0;
> +
> +	switch (strategy) {
> +	case BPF_PROG_LOAD_STRATEGY_DISABLED:
> +	case BPF_PROG_LOAD_STRATEGY_AUTO:
> +		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
> +			prog->autoattach = prog->saved_autoattach;
> +		prog->load_strategy = strategy;
> +		break;
> +	case BPF_PROG_LOAD_STRATEGY_MANUAL:
> +		if (obj->gen_loader)
> +			return libbpf_err(-EOPNOTSUPP);

Can this ordering be reversed? When bpf_program__set_load_strategy(MANUAL)
is called before bpf_object__gen_loader(), this check passes because
obj->gen_loader is still NULL. Then when bpf_object__gen_loader() runs
later, it doesn't check whether any MANUAL programs already exist.

Looking at bpf_object__load_progs():

    for (i = 0; i < obj->nr_programs; i++) {
        prog = &obj->programs[i];
        if (!prog->autoload || prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO) {
            pr_debug("prog '%s': skipped auto-loading\n", prog->name);
            continue;
        }

MANUAL programs are skipped, so gen->nr_progs ends up below
obj->nr_programs. Then bpf_gen__finish() only rejects nr_progs <
gen->nr_progs, so the generated loader silently omits these programs.

If someone later calls bpf_program__load() on the MANUAL program, it goes
through bpf_object_load_prog()'s gen_loader path:

    if (obj->gen_loader) {
        bpf_gen__prog_load(obj->gen_loader, ...);
        *prog_fd = -1;
        return 0;
    }

which returns success with prog->fd = -1 and appends to gen buffers after
bpf_gen__finish() has already published opts->insns/opts->data. Since
gen_loader grows buffers with realloc(), this can leave those pointers
stale.

Note: This is fixed later in the series by 549383b4eb184 ("libbpf: Reject
gen_loader for objects with already-manual programs").

> +		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> +			return libbpf_err(-EINVAL);
> +
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
> +
>  	return 0;
>  }
>
> @@ -15386,3 +15501,34 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
>  {
>  	return prog->load_strategy;
>  }
> +
> +int
> +bpf_program__load(struct bpf_program *prog)
> +{
> +	int err;
> +	struct bpf_object *obj = prog->obj;
> +
> +	if (obj->state < OBF_PREPARED)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog_is_subprog(obj, prog) || prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog->fd >= 0)
> +		return libbpf_err(-EBUSY);
> +
> +	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);
> +	if (err) {
> +		pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
> +		return libbpf_err(err);
> +	}
> +
> +	return 0;
> +}

The commit message says MANUAL programs "can also be reloaded and
reattached multiple times", and the bpf_program__unload() doc now says
MANUAL programs keep their data "so it can be reloaded later via
bpf_program__load()". Does this work for programs that use gotox jump
tables?

During bpf_object__prepare(), create_jt_map() creates a
BPF_MAP_TYPE_INSN_ARRAY map per (prog, sym_off) and caches it in
obj->jumptable_maps. RELO_INSN_ARRAY then writes the map fd directly into
prog->insns (insn->imm = map_fd). Each bpf_program__load() call
resubmits the same prog->insns with the same map fd.

On the kernel side, bpf_insn_array_init() runs:

    if (atomic_xchg(&insn_array->used, 1))
        return -EBUSY;

with the message "There can be only one program using the map". That flag
is cleared only by bpf_insn_array_release(), which the verifier calls on
the verification error path, not when a successfully loaded program is
freed.

So this sequence:

    bpf_object__prepare()
    bpf_program__load(p)    // ok, insn_array->used = 0 -> 1
    bpf_program__unload(p)  // just zclose(prog->fd)
    bpf_program__load(p)    // -EBUSY, insn_array->used still 1

fails verification with "Failed to properly initialize insn array". The
map and its 'used' state live on in obj->jumptable_maps until
bpf_object__close().

Would libbpf need to recreate the jump-table maps (and re-patch insn->imm)
before each manual load, or should this limitation be rejected or
documented?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e7255bd4247f7..faea42f758479 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -392,7 +392,7 @@ LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog)
>  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
> -LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
> +LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);

The return type of the public LIBBPF_API bpf_program__set_autoattach()
changes from void to int, but the symbol stays in its original
libbpf.map node. This is source compatible, but callers that ignore the
result cannot tell that the call was rejected for MANUAL programs, and the
ABI of an already exported symbol changes without a new version node.

Note: This is fixed later in the series by fca8106ae09c7 ("libbpf:
Version bpf_program__set_autoattach() ABI change").

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 03c3d2bd15bf4..8def5474885a8 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -463,6 +463,7 @@ LIBBPF_1.8.0 {
>  		bpf_program__attach_tracing_multi;
>  		bpf_program__clear_flags;
>  		bpf_program__clone;
> +		bpf_program__load;
>  		bpf_program__load_strategy;
>  		bpf_program__set_load_strategy;
>  		btf__find_by_name_kind_own;

The commit message refers to bpf_program__load_manually() and
bpf_program__unload_manually():

>     A manual-strategy program is loaded via bpf_program__load_manually()
>     and unloaded via bpf_program__unload_manually(), gated on
>     bpf_object__prepare() having already run (BTF loaded, maps created,
>     relocations applied) rather than requiring a full bpf_object__load().

Neither function exists. The patch actually adds bpf_program__load()
(exported in LIBBPF_1.8.0) and changes the existing bpf_program__unload()
so that it only closes the fd for MANUAL programs. The message also leaves
out the user-visible change to bpf_program__set_autoattach(): it now
returns int and rejects MANUAL programs.

In the v1 review thread, Andrii Nakryiko expressed concern about adding
complexity to bpf_object internals:

> I don't want to complicate bpf_object internals with this third
> autoload state, as this creates tons of non-obvious gotchas that have
> to constantly be checked whenever any new feature is added to
> bpf_object (or even during refactorings).

From: https://lore.kernel.org/bpf/CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com/

While the patch has been revised to use bpf_object__prepare() as Andrii
suggested, does the implementation still add significant complexity: new
state tracking (has_manual_progs), modified cleanup logic with force
parameter, complex state machine logic for load strategies, and deferred
BTF/fd_array cleanup?

Also, for subsequent submissions, Andrii requested the [PATCH bpf-next]
subject prefix in the v1 review.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============8013647888006912334==--
