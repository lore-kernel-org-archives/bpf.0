Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDE3EC82B;
	Thu, 24 Sep 2026 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285072; cv=none; b=acz44UOLBC9fKV9H88jhnxDxkG9G+Q2PzScBQgWIchdWoJVBOzGjEefeld7goxVZuHArstykwb7VAniU8LuNUutUKfd4qc0+a20NmI7wdNgasbbuCR9y65CISsf4qVps0dsBFDZjUnof5JTawP0BG1cT7nHfVUDh2IYH24QLgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285072; c=relaxed/simple;
	bh=YA1VO/Zi7u+MCfmUDy1n4eHNFrXPrpkAdleM+U6wbiw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qSC1tBKX0csL8e+2lj3zdvkrwHdoGJymkpEag/oYvnMRZU81iIicfCRTJDo7WTVSGrk98namp/p+UI7emi20BSz4F3TF6ukEUZoUW9QblL51J86G3tRY4EVR1Xxoiyo0jPDbzwvy2XOmT4sDMe1AilXEkUoCgYR3+JojdL4dgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBL+KjxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBL+KjxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A4F1F000FF;
	Thu, 24 Sep 2026 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285071;
	bh=K9JtdP9QuhsKMWjIb9V/M+4kylp8rwGKe1awSi5QC/o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PBL+KjxO8G1bjRxSVlLHSJGqcYK3jlWGs40g45LaDPYD2E24Kiv8Conh8L5RqrK9k
	 ll3Df8EEDzlT6G+/yOE7LmElkAAPmmrt/SeXHTk/H6DlCoY1w4iM26SB7wX8nTgMwW
	 TmOGNoUAxqmhC3CBfUhuMf3tKDhBPPf/mUsBXVL6pab9OBgEb/3v3Axr/eOfNTOYrk
	 qsJEA44Tr1JtIqaIzRH3Q8TligkbdyB3jazry0aZuAhUWC7dL8i7P8UP63EQ0aANZU
	 cJ04XMcV+xSWxOzXaw/BqhINLIpi4biMzzePyD1qwpgsiTVfis96/yDSJuoCcHT7e+
	 gf6Kp5PgNbc6g==
Content-Type: multipart/mixed; boundary="===============7609480179023105782=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b3b4cbefd5258ad320205bc708c7864c20a16f39ffd37673fe9cbd534a1ebbca@mail.kernel.org>
In-Reply-To: <20260924204226.190315-1-ihor.solodrai@linux.dev>
References: <20260924204226.190315-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH vfs v1] bpf: Allow bpf_d_path() from filp_close_sync()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,brauner@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,jolsa@kernel.org,broonie@kernel.org,linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 21:24:29 +0000 (UTC)

--===============7609480179023105782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The d_path selftest closes its descriptors with close_range() so that
> its fentry program on filp_close() runs. The vfs commit
> 46ace7e4dc4b ("fs: make close_range() synchronous") switched
> close_range() to filp_close_sync(), so the program still attaches but
> is never called:
>
>   test_d_path_basic:FAIL:close trampoline for filp_close was not called
>
> With that series, close(), close_range() and the closes on exec and
> exit all go through filp_close_sync(). Few paths still reach
> filp_close(), dup2() being one of them, so a program on filp_close()
> no longer sees most file closes.

Can the commit message clarify which exec closes it refers to? At
46ace7e4dc4b, begin_new_exec() calls do_close_on_exec(), which still
closes O_CLOEXEC descriptors with filp_close():

fs/file.c:do_close_on_exec() {
    ...
    spin_unlock(&files->file_lock);
    filp_close(file, files);
    cond_resched();
}

So close-on-exec stays on filp_close() rather than moving to
filp_close_sync(). Only close(2), __range_close() and close_files()
were converted in that series. After this patch, a program moved from
filp_close to filp_close_sync would silently stop seeing descriptors
closed by exec.

>
> Allow bpf_d_path() from filp_close_sync(). It takes the same arguments
> as filp_close() and the program runs before the file is flushed and
> its last reference is dropped, so file->f_path is still valid. Keep
> filp_close() in the allowlist for existing programs.

This explains why fentry is safe, but does the reasoning hold for fexit
as well? The commit message says "the program runs before the file is
flushed and its last reference is dropped," but that applies only to
entry, not exit. Looking at filp_close_sync() (a546b2ef2120):

    retval = filp_flush(filp, id);
    fput_close_sync(filp);

fput_close_sync() calls __fput() synchronously when this is the last
reference. __fput() does:

    dput(dentry);
    mntput(mnt);
    file_free(file);

So by the time a fexit trampoline runs, the dentry reference is gone
and the struct file has gone back to filp_cache (SLAB_TYPESAFE_BY_RCU,
reusable immediately). For pipes and sockets (alloc_file_pseudo uses
d_alloc_pseudo which sets DCACHE_NORCU), dentry_free() calls __d_free()
directly with no RCU delay.

>
> Attach the selftest program to filp_close_sync() and keep triggering
> it with close_range(), since filp_close_sync() may be inlined into
> close().
>
> Assisted-by: LLM
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 195f78db9bda..49d5ec983e72 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -972,6 +972,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, filp_close_sync)
>  BTF_SET_END(btf_allowlist_d_path)

Can a fexit program on filp_close_sync() safely call bpf_d_path() on
file->f_path that has already been freed? bpf_d_path_allowed() only
checks the attach target, not the attach type:

    return btf_id_set_contains(&btf_allowlist_d_path,
                               prog->aux->attach_btf_id);

and check_helper_call() uses only this callback to gate the helper.
check_attach_target() accepts BPF_TRACE_FEXIT on any function.

For example: SEC("fexit/filp_close_sync") prog calls
bpf_d_path(&file->f_path, buf, sz). close_range() on a pipe fd calls
__range_close() -> filp_close_sync() -> fput_close_sync() -> __fput()
-> dput() which frees the NORCU dentry, then file_free() frees the
file. Then the trampoline runs the fexit prog -> bpf_d_path() ->
copy_from_kernel_nofault(&copy, path) reads the freed file ->
d_path(&copy) -> path->dentry->d_op->d_dname(path->dentry, ...)
which reads freed dentry memory and calls through a function pointer
loaded from it.

The existing filp_close entry does not have this problem: fput_close()
-> __fput_deferred() queues ____fput with task_work_add(TWA_RESUME), so
__fput() runs only on return to user space, after fexit. filp_close_sync
is the first allowlist entry that drops the last reference to its own
argument.

Would it work to allow bpf_d_path from filp_close_sync only when
prog->expected_attach_type == BPF_TRACE_FENTRY?

>
>
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> index 1a2a2f1abf03..7665e1d28a64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -109,8 +109,9 @@ static int trigger_fstat_events(pid_t pid)
>  	fstat(indicatorfd, &fileStat);
>
>  out_close:
> -	/* sys_close no longer triggers filp_close, but we can
> -	 * call sys_close_range instead which still does
> +	/*
> +	 * filp_close_sync() may be inlined into close(2), so use
> +	 * close_range(2), which calls it directly.
>  	 */
>  	syscall_close(pipefd[0]);
>  	syscall_close(pipefd[1]);
> @@ -165,7 +166,7 @@ static void test_d_path_basic(void)
>
>  	if (CHECK(!bss->called_close,
>  		  "close",
> -		  "trampoline for filp_close was not called\n"))
> +		  "trampoline for filp_close_sync was not called\n"))
>  		goto cleanup;
>
>  	for (int i = 0; i < MAX_FILES; i++) {
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 561b2f861808..edb5494a47f7 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>  	return 0;
>  }
>
> -SEC("fentry/filp_close")
> +SEC("fentry/filp_close_sync")
>  int BPF_PROG(prog_close, struct file *file, void *id)
>  {
>  	pid_t pid = bpf_get_current_pid_tgid() >> 32;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36058459433
--===============7609480179023105782==--
