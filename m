Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0847ACD0
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773134; cv=none; b=Wxb6NpSLLevXl+ViXuc8uPWiy4/Lk+WBs5+9Ig4SISiTKtFPZxDv0khokHbBGdSdutPv65MZ6xdR+Jmx502JEdKjVEesU/DOdI2JC5hvZ5aOYbo7yCELvw+bi7sOYXe+0arPtjtdK4joNyewGESWi62/NW0uqGvHa3oFpEq3PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773134; c=relaxed/simple;
	bh=vqOs2inr6dz7W0uTV+cgvTWwprc7omV4S7QepxfqCGY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UMPwW6xSBaak7FzuiazVoRREpZVT6UeEdD469tqvpRVzikF8UgLqEzL9EBwUOdVbl0vS3JW8/R/775EHzLiMO7wbjT5GGp+C4fLqQrDIcwb6WngcLJf723Q6SdxYfNQ3Osq25GRNiMiDC1mKggE+jdmJRMKF+9XlS9EzhZHMLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKx6OGBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKx6OGBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE9E1F000E9;
	Wed, 26 Aug 2026 19:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773120;
	bh=UYEMQ+7PCXkYN8WTEVi1V+Tjd5RnWWc9rHgpCl+o8rk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fKx6OGBcog14Zl5JqMatkyDVAzi438lSnNTEEmYv+korzPuhPo8S1ReIHLn3mrj6g
	 Z931m4whvren/CN9vp22H8dtx+84LyDQyYJhdBS7wB4bZ+LpXui9c6eslYr6Or1qWk
	 ceeHziXvueke4RpAtUjRmyiXX6D+ZgZ3JW+CgQbknlrjoYXbszQAdwBBTG0XS0Up4x
	 GSiOzaST++WHDf/DCZIMT5a2sNte8YCgwI0z+0UzF1DTeWW63Rv8MJosAFT1WotvZj
	 Awjl7PbXIpAxV9RVJTcJnQCo6eBOcmVihhAxwSSZhc/ztf+HIEscss3uKQTtpVQt+5
	 UZhkGNXsH/Gxw==
Content-Type: multipart/mixed; boundary="===============8946455476692036812=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b52c14fd3024992f26b6d93e92e3fdd9dd10b88608e07a655713ed58fe3924d@mail.kernel.org>
In-Reply-To: <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:38:39 +0000 (UTC)

--===============8946455476692036812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 821d854d43a9f..c3fe1de432108 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -725,6 +725,7 @@ struct bpf_object {
>
>  	bool has_subcalls;
>  	bool has_rodata;
> +	bool has_dynload_progs;
>
>  	struct bpf_gen *gen_loader;

[ ... ]

> @@ -9076,15 +9078,22 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
>  	obj->btf_modules_loaded = false;
>  	zfree(&obj->btf_modules);
>
> -	/* clean up vmlinux BTF */
> -	btf__free(obj->btf_vmlinux);
> -	obj->btf_vmlinux = NULL;
> +	/* The btf_vmlinux data is needed for dynamically loaded programs,
> +	 * so defer freeing it in that case to the end of the object lifetime.
> +	 */
> +	if (!obj->has_dynload_progs) {
> +		btf__free(obj->btf_vmlinux);
> +		obj->btf_vmlinux = NULL;
> +	}

This isn't a bug, but the BPF multi-line comment convention for
tools/lib/bpf/ requires the opening /* on a line of its own.

> @@ -9089,8 +9098,12 @@ static void bpf_object_post_load_cleanup(struct bpf_object *obj)
>
>  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
>  {
> -	/* clean up fd_array */
> -	zfree(&obj->fd_array);
> +	/* The fd array is needed for dynamically loaded programs,
> +	 * so defer freeing it in that case to the end of the object lifetime.
> +	 */
> +	if (!obj->has_dynload_progs || !obj->fd_array_cnt)
> +		zfree(&obj->fd_array);
>
>  	/* clean up BTF */
>  	bpf_object_cleanup_btf(obj);

Does this code keep the fd_array while closing the file descriptors it
contains?

The patch guards the zfree() to keep fd_array alive for dynamic programs,
but then immediately calls bpf_object_cleanup_btf(), which closes the
module BTF FDs:

bpf_object_cleanup_btf() {
    for (i = 0; i < obj->btf_module_cnt; i++) {
        close(obj->btf_modules[i].fd);
        ...
    }
}

The only values stored in obj->fd_array are module BTF FDs from
obj->btf_modules[] (load_module_btfs() does 'obj->fd_array[obj->fd_array_cnt++]
= mod_btf->fd;'), so when bpf_program__load_dynamically() later runs
bpf_object_load_prog() with load_attr.fd_array = obj->fd_array, it hands
the verifier a table of closed FDs.

Best case the program load fails with -EBADF and dynamic loading simply
does not work for module kfuncs. Worse, if the FD number has been recycled
by any other open() in the process between object load and dynamic load,
the verifier resolves the kfunc against an unrelated file.

The patch guards btf_vmlinux in bpf_object_cleanup_btf() but leaves the
module-BTF close unconditional.

> @@ -9805,8 +9816,16 @@ bool bpf_program__autoload(const struct bpf_program *prog)
>
>  int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
>  {
> -	return bpf_program__set_load_type(prog,
> -		autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_DISABLED);
> +	enum bpf_prog_load_type type = prog->load_type;
> +
> +	if (autoload)
> +		type = BPF_PROG_LOAD_TYPE_AUTO;
> +	else if (prog->load_type == BPF_PROG_LOAD_TYPE_AUTO)
> +		type = BPF_PROG_LOAD_TYPE_DISABLED;
> +	else
> +		return 0; /* Otherwise, keep the current load type. */
> +
> +	return bpf_program__set_load_type(prog, type);
>  }

Does the early return skip the post-load check?

The 'else return 0;' arm bypasses the call to bpf_program__set_load_type(),
which is the only place that checks 'if (prog->obj->state >= OBJ_LOADED)
return libbpf_err(-EINVAL);'. After bpf_object__load(), calling
bpf_program__set_autoload(prog, false) on any program whose load type is
not AUTO (every skipped program and every dynamic program) now returns 0
instead of -EINVAL and leaves errno untouched.

Callers that use the return value to detect "too late to change autoload"
silently get a success where they used to get an error.

[ ... ]

> @@ -15220,12 +15239,73 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>  	free(s);
>  }
>
> +static int bpf_program__set_dynamicload(struct bpf_program *prog)
> +{
> +	struct bpf_object *obj;
> +	const char *attach_name;
> +
> +	obj = prog->obj;
> +	if (!obj)
> +		return libbpf_err(-EINVAL);
> +
> +	/* Dynamically-loaded programs are not supported for gen_loader.
> +	 * This is because bpf_object_load_prog is not called for
> +	 * dynamicload programs, so dynamicload programs are not visible
> +	 * to gen_loader. For this reason, prevent calling
> +	 * bpf_program__set_dynamicload when gen_loader was used to
> +	 * generate a BPF object loader.
> +	 * A gen_loader implementation is being called for autoloaded
> +	 * programs and defines its own model for loading BPF programs.
> +	 * To pass a BPF program to gen_loader, set the program's load type
> +	 * to LD_AUTOLOAD.
> +	 */

This isn't a bug, but does LD_AUTOLOAD exist? The only occurrence of
LD_AUTOLOAD in the tree is this comment. The enumerator the sentence
means is BPF_PROG_LOAD_TYPE_AUTO.

> +	if (obj->gen_loader)
> +		return libbpf_err(-ENOTSUP);
> +
> +	if (prog_is_subprog(obj, prog))
> +		return libbpf_err(-EINVAL);
> +
> +	attach_name = strchr(prog->sec_name, '/');
> +	if (!attach_name || strchr(attach_name, ':')) {
> +		/* Only reject programs that require BTF-based attach target
> +		 * resolution (indicated by the SEC_ATTACH_BTF flag). Such
> +		 * programs need the section name parsed for the attach target
> +		 * function name (after '/') and optionally the module name
> +		 * (before ':') for libbpf_find_attach_btf_id.
> +		 *
> +		 * Programs like SEC("classifier"), SEC("socket"), etc. do
> +		 * not require BTF attach resolution and can safely use
> +		 * dynamic loading despite having no '/' in their section
> +		 * name. The BTF guard in libbpf_prepare_prog_load (checking
> +		 * SEC_ATTACH_BTF) is the authoritative check; this is an
> +		 * early-reject for programs that would fail there.
> +		 */
> +		long flags = prog->sec_def ?
> +			(long)prog->sec_def->cookie : SEC_ATTACH_BTF;
> +		if ((flags & SEC_ATTACH_BTF) && !prog->attach_btf_id)
> +			return libbpf_err(-EINVAL);
> +	}

Does this reject section forms that libbpf supports?

1. The 'strchr(attach_name, ':')' check rejects the module-qualified
form SEC("fentry/<module>:<func>"). find_kernel_btf_id() explicitly
implements it:

find_kernel_btf_id() {
    fn_name = strchr(attach_name, ':');
    if (fn_name) {
        mod_name = attach_name;
        mod_len = fn_name - mod_name;
        fn_name++;
    }
}

and libbpf_prepare_prog_load() hands it 'strchr(prog->sec_name, '/') + 1'
verbatim, so SEC("fentry/<module>:<func>") resolves fine on the normal
load path (in-tree example: tools/testing/selftests/bpf/progs/
tracing_multi_attach_module.c). The comment even names the module part
as a supported input - "optionally the module name (before ':')" - and
then rejects exactly that.

2. The '!attach_name' check rejects SEC("fentry") with no declarative
target. libbpf_prepare_prog_load() supports this: its error message says
the target "is expected [to] be specified with bpf_program__set_attach_target()
at runtime before BPF object load step". Because the guard reads
prog->attach_btf_id, which set_attach_target() fills in, this makes the
two setters order-dependent: bpf_program__set_attach_target() then
bpf_program__set_load_type(DYNAMIC) succeeds, while the reverse order
fails with -EINVAL.

> +
> +	obj->has_dynload_progs = true;
> +	prog->load_type = BPF_PROG_LOAD_TYPE_DYNAMIC;
> +	prog->autoattach = false;
> +
> +	return 0;
> +}

Does this code forget to restore autoattach?

bpf_program__set_dynamicload() clears prog->autoattach as a side effect,
and nothing ever restores it. Because bpf_program__set_load_type() lets
a program move back out of BPF_PROG_LOAD_TYPE_DYNAMIC (its 'default:'
arm just assigns prog->load_type), this sequence leaves the program in
an inconsistent state:

    bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC);
        /* autoattach = false */
    bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_AUTO);
        /* autoattach stays false */

The program is now autoloaded by bpf_object__load() but silently skipped
by the skeleton's attach step, and bpf_program__autoattach() reports
false even though the caller never touched it. The same happens through
bpf_program__set_autoload(prog, true) on a DYNAMIC program.

[ ... ]

> @@ -15233,3 +15313,49 @@ enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
>  {
>  	return prog->load_type;
>  }
> +
> +/*
> + * This function must be called after bpf_object__load_progs.
> + * Dynamically-loaded program data is initialized on object load.
> + * Post-load initialization is not supported.
> + */
> +int
> +bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level)
> +{
> +	int err;
> +	struct bpf_object *obj;
> +
> +	obj = prog->obj;
> +	if (!obj || obj->state < OBJ_LOADED)
> +		return libbpf_err(-EINVAL);
> +
> +	if (prog_is_subprog(obj, prog) || prog->load_type != BPF_PROG_LOAD_TYPE_DYNAMIC)
> +		return libbpf_err(-EINVAL);
> +
> +	prog->log_level |= extra_log_level;
> +
> +	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);
> +	if (err) {
> +		pr_warn("prog '%s': failed to dynamically load: %d\n", prog->name, err);
> +		prog->log_level &= ~extra_log_level;
> +		return err;
> +	}
> +
> +	prog->log_level &= ~extra_log_level;
> +	return 0;
> +}

Does calling this twice leak the previous FD?

The function never checks whether prog already holds an FD, so calling
it twice without an intervening bpf_program__unload_dynamically() leaks
the previous prog FD and pins the previous kernel program instance for
the lifetime of the process.

bpf_object_load_prog() unconditionally overwrites the out parameter on
success:

    *prog_fd = ret;
    ret = 0;
    goto out;

and the caller passes &prog->fd, so the old descriptor is simply dropped
with no close(). Because the leaked FD holds a reference on the old
bpf_prog, the kernel-side program (and its maps/BTF references) also stay
alive.

The commit message advertises this exact usage - "These programs can also
be reloaded and reattached multiple times" - so back-to-back loads are an
expected caller pattern, not an abuse.

The function should either reject a second load with -EBUSY when
prog->fd >= 0, or zclose(prog->fd) before loading.

---

Does the extra_log_level handling corrupt the program's log level?

The set-then-clear approach does not save and restore the original value.
With:

    bpf_program__set_log_level(prog, 1);
    bpf_program__load_dynamically(prog, 1);

the function does 'prog->log_level |= 1' (leaving it at 1), then
'prog->log_level &= ~1' (clearing it to 0). Any bit shared between the
caller's persistent log level and extra_log_level is lost.

bpf_program__log_level() now reports 0 instead of the value the caller
set, and any subsequent bpf_program__load_dynamically(prog, 0) loads
with no verifier log.

A correct save/restore needs the original value:

    __u32 saved = prog->log_level;
    prog->log_level |= extra_log_level;
    ...
    prog->log_level = saved;

For comparison, bpf_object__load_progs() does 'prog->log_level |= log_level;'
with no restore at all, so the two paths also disagree on whether
extra_log_level is sticky.

---

A subsystem pattern flags this as potentially concerning: the error
return at the end of bpf_program__load_dynamically() is 'return err;'
instead of 'return libbpf_err(err);'. The two early -EINVAL paths in
the same function do use libbpf_err(), and the sibling function
bpf_program__unload_dynamically() wraps its returns, so the omission is
inconsistent within the patch itself.

bpf_object_load_prog() is an internal helper that returns kernel-style
negative error codes without touching errno. Concrete paths that return
an error with errno unset or stale:

  - 'case BPF_PROG_TYPE_UNSPEC: ... return -EINVAL;'
  - 'case BPF_PROG_TYPE_STRUCT_OPS: if (prog->attach_btf_id == 0) ...
     return -EINVAL;'
  - 'if (!insns || !insns_cnt) return -EINVAL;'
  - 'err = prog->sec_def->prog_prepare_load_fn(...); if (err < 0) ...
     return err;'
  - 'ret = -ENOMEM; goto out;' on log-buffer realloc failure

On all of these, bpf_program__load_dynamically returns a negative value
while errno still holds whatever the caller last left there, so a caller
doing the documented 'if (bpf_program__load_dynamically(...)) perror(...)'
or reading errno gets a wrong or stale error.

Would it be safer to add the wrapper here to match the neighbouring
returns?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 700634664e326..54d7558612893 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2083,15 +2083,19 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
>   *
>   * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
>   * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
> + * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dynamically.
>   */
>  enum bpf_prog_load_type {
>  	BPF_PROG_LOAD_TYPE_DISABLED = 0,
>  	BPF_PROG_LOAD_TYPE_AUTO,
> +	BPF_PROG_LOAD_TYPE_DYNAMIC,
>  };
>
>  LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
>  					  enum bpf_prog_load_type loadtype);
>  LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
> +LIBBPF_API int bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_level);
> +LIBBPF_API int bpf_program__unload_dynamically(struct bpf_program *prog);

[ ... ]

---

The v1 patch discussion with Andrii Nakryiko on lore (January-February
2025) raised design concerns that appear unaddressed. Three key points:

1. On Feb 5, 2025, Andrii stated: "I don't want to complicate bpf_object
internals with this third autoload state, as this creates tons of
non-obvious gotchas that have to constantly be checked whenever any new
feature is added to bpf_object (or even during refactorings)." He
proposed two alternatives: (1) splitting BPF programs into multiple
independent bpf_objects with shared maps via bpf_map__reuse_fd(), or (2)
implementing bpf_object__prepare() to handle relocations while the
application manages program loading. The discussion ended on Feb 25, 2025
without the author committing to either alternative approach.

Message-ID: CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com
https://lore.kernel.org/bpf/CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com/

2. On Feb 21, 2025, Andrii stated that bpf_object is intentionally
single-threaded and will not support parallel BPF program loading:
"bpf_object is intentionally single-threaded, so I don't think we'll be
supporting parallel BPF program loading in the paradigm of bpf_object...
I don't see bpf_object becoming multi-threaded. The dynamic program
loading/unloading/loading again is something that I can't yet justify,
tbh."

Message-ID: CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com
https://lore.kernel.org/bpf/CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com/

Has the patch design been revised to address these concerns, or does it
follow one of the suggested alternatives?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000627295
--===============8946455476692036812==--
