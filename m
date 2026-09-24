Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F73AEF51
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291905; cv=none; b=fJ+VySPdLWZY+wRILdtd6BcxOJJvEYFE9Wb/hVDxQsgIGlD9JTjRniLNHvUzugZuwMRCkDxDwcEDZXPEBPrNqaXuxIE+sFJm3+xZ+Y0eBx4xQQ+Jq3l1ID+dxpFQVeNJkh1kxLv2mbMeX+xgStFJ/aLe2b/q32YmmuQ8VRZhXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291905; c=relaxed/simple;
	bh=1M33bqcpVFqHA/4mDAfYuzXof9ZeZuHj5UucIeyHLLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuRAA1IXHQrwiFE8J9mNQ+B9kVYzCMrvkWPZ9EMbXSLEArpLortEKGnuRC4mq5JlamK0HGyHeg/+rnVt0iQGlBt8uHSZ0M6oPawgXcvRHApzOnLY+mfdqDXl/X7xYQaclVdVfFr4wgr9dsltWeJjIvMcRahIX83WzNwEsFFbx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qyNsE0Su; arc=none smtp.client-ip=91.218.175.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qyNsE0Su"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1M33bqcpVFqHA/4mDAfYuzXof9ZeZuHj5UucIeyHLLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790291901; v=1; x=1790896701;
 b=qyNsE0Suq6acSp01rTOSryknyg7I/9SZjk6uibbLunlhQpi1uHDNCSMBxs5JIk8Y8BQhDl3k
 UJ7VqNA6gmxrBLt7/D77hwGfMKiLladWXUxRhqTu1JPBj0875T0zBDdDB36NOWTUz8zjfEuZB4Q
 Gb0RTGmCLTvG61ElQs1SgFdc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1427ee8712c01b06;
	Thu, 24 Sep 2026 23:18:21 +0000
X-Mizu-Trace-ID: 1427ee8712c01b06
X-Migadu-Flow: FLOW_OUT
Message-ID: <6af94251-fc79-4377-b781-f9b413af1223@linux.dev>
Date: Thu, 24 Sep 2026 16:18:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs v1] bpf: Allow bpf_d_path() from filp_close_sync()
To: bot+bpf-ci@kernel.org, brauner@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, neil@brown.name, jolsa@kernel.org,
 broonie@kernel.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, martin.lau@kernel.org,
 yonghong.song@linux.dev, mason@kernel.org
References: <20260924204226.190315-1-ihor.solodrai@linux.dev>
 <b3b4cbefd5258ad320205bc708c7864c20a16f39ffd37673fe9cbd534a1ebbca@mail.kernel.org>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b3b4cbefd5258ad320205bc708c7864c20a16f39ffd37673fe9cbd534a1ebbca@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 2:24 PM, bot+bpf-ci@kernel.org wrote:
>> The d_path selftest closes its descriptors with close_range() so that
>> its fentry program on filp_close() runs. The vfs commit
>> 46ace7e4dc4b ("fs: make close_range() synchronous") switched
>> close_range() to filp_close_sync(), so the program still attaches but
>> is never called:
>>
>>   test_d_path_basic:FAIL:close trampoline for filp_close was not called
>>
>> With that series, close(), close_range() and the closes on exec and
>> exit all go through filp_close_sync(). Few paths still reach
>> filp_close(), dup2() being one of them, so a program on filp_close()
>> no longer sees most file closes.
> 
> Can the commit message clarify which exec closes it refers to? At
> 46ace7e4dc4b, begin_new_exec() calls do_close_on_exec(), which still
> closes O_CLOEXEC descriptors with filp_close():
> 
> fs/file.c:do_close_on_exec() {
>     ...
>     spin_unlock(&files->file_lock);
>     filp_close(file, files);
>     cond_resched();
> }
> 
> So close-on-exec stays on filp_close() rather than moving to
> filp_close_sync(). Only close(2), __range_close() and close_files()
> were converted in that series. After this patch, a program moved from
> filp_close to filp_close_sync would silently stop seeing descriptors
> closed by exec.
> 
>>
>> Allow bpf_d_path() from filp_close_sync(). It takes the same arguments
>> as filp_close() and the program runs before the file is flushed and
>> its last reference is dropped, so file->f_path is still valid. Keep
>> filp_close() in the allowlist for existing programs.
> 
> This explains why fentry is safe, but does the reasoning hold for fexit
> as well? The commit message says "the program runs before the file is
> flushed and its last reference is dropped," but that applies only to
> entry, not exit. Looking at filp_close_sync() (a546b2ef2120):
> 
>     retval = filp_flush(filp, id);
>     fput_close_sync(filp);
> 
> fput_close_sync() calls __fput() synchronously when this is the last
> reference. __fput() does:
> 
>     dput(dentry);
>     mntput(mnt);
>     file_free(file);
> 
> So by the time a fexit trampoline runs, the dentry reference is gone
> and the struct file has gone back to filp_cache (SLAB_TYPESAFE_BY_RCU,
> reusable immediately). For pipes and sockets (alloc_file_pseudo uses
> d_alloc_pseudo which sets DCACHE_NORCU), dentry_free() calls __d_free()
> directly with no RCU delay.
> 
>>
>> Attach the selftest program to filp_close_sync() and keep triggering
>> it with close_range(), since filp_close_sync() may be inlined into
>> close().
>>
>> Assisted-by: LLM
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 195f78db9bda..49d5ec983e72 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -972,6 +972,7 @@ BTF_ID(func, vfs_fallocate)
>>  BTF_ID(func, dentry_open)
>>  BTF_ID(func, vfs_getattr)
>>  BTF_ID(func, filp_close)
>> +BTF_ID(func, filp_close_sync)
>>  BTF_SET_END(btf_allowlist_d_path)
> 
> Can a fexit program on filp_close_sync() safely call bpf_d_path() on
> file->f_path that has already been freed? bpf_d_path_allowed() only
> checks the attach target, not the attach type:
> 
>     return btf_id_set_contains(&btf_allowlist_d_path,
>                                prog->aux->attach_btf_id);
> 
> and check_helper_call() uses only this callback to gate the helper.
> check_attach_target() accepts BPF_TRACE_FEXIT on any function.
> 
> For example: SEC("fexit/filp_close_sync") prog calls
> bpf_d_path(&file->f_path, buf, sz). close_range() on a pipe fd calls
> __range_close() -> filp_close_sync() -> fput_close_sync() -> __fput()
> -> dput() which frees the NORCU dentry, then file_free() frees the
> file. Then the trampoline runs the fexit prog -> bpf_d_path() ->
> copy_from_kernel_nofault(&copy, path) reads the freed file ->
> d_path(&copy) -> path->dentry->d_op->d_dname(path->dentry, ...)
> which reads freed dentry memory and calls through a function pointer
> loaded from it.
> 
> The existing filp_close entry does not have this problem: fput_close()
> -> __fput_deferred() queues ____fput with task_work_add(TWA_RESUME), so
> __fput() runs only on return to user space, after fexit. filp_close_sync
> is the first allowlist entry that drops the last reference to its own
> argument.
> 
> Would it work to allow bpf_d_path from filp_close_sync only when
> prog->expected_attach_type == BPF_TRACE_FENTRY?

Both claude and codex refuse to build a reproducer for this because they
"take extra care with some cybersecurity requests".

But the issue appears to be real, and bot's suggestion should work
(pasting a diff at the bottom).

Christian, could you please confirm that allowing filp_close_sync on
fentry, but not on fexit makes sense? Should I respin with that?

If anyone has ideas for alternative solutions to this bug or original
issue, I'd be happy to try that as well.

As it stands, many BPF programs attaching to filp_close will probably
get broken with 46ace7e4dc4b ("fs: make close_range() synchronous")
reaching the mainline.

Thanks!


diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 49d5ec983e72..42dc01756f8a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -972,9 +972,12 @@ BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
 BTF_ID(func, filp_close)
-BTF_ID(func, filp_close_sync)
 BTF_SET_END(btf_allowlist_d_path)
 
+BTF_SET_START(btf_allowlist_d_path_fentry)
+BTF_ID(func, filp_close_sync)
+BTF_SET_END(btf_allowlist_d_path_fentry)
+
 static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 {
        if (prog->type == BPF_PROG_TYPE_TRACING &&
@@ -984,8 +987,16 @@ static bool bpf_d_path_allowed(const struct bpf_prog *prog)
        if (prog->type == BPF_PROG_TYPE_LSM)
                return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
 
-       return btf_id_set_contains(&btf_allowlist_d_path,
-                                  prog->aux->attach_btf_id);
+       if (btf_id_set_contains(&btf_allowlist_d_path,
+                               prog->aux->attach_btf_id))
+               return true;
+
+       if (btf_id_set_contains(&btf_allowlist_d_path_fentry,
+                               prog->aux->attach_btf_id))
+               return prog->expected_attach_type == BPF_TRACE_FENTRY ||
+                      prog->expected_attach_type == BPF_TRACE_FENTRY_MULTI;
+
+       return false;
 }
 
 BTF_ID_LIST_SINGLE(bpf_d_path_btf_ids, struct, path)


> 
>>
>>
>>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> 
> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
>> index 1a2a2f1abf03..7665e1d28a64 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
>> @@ -109,8 +109,9 @@ static int trigger_fstat_events(pid_t pid)
>>  	fstat(indicatorfd, &fileStat);
>>
>>  out_close:
>> -	/* sys_close no longer triggers filp_close, but we can
>> -	 * call sys_close_range instead which still does
>> +	/*
>> +	 * filp_close_sync() may be inlined into close(2), so use
>> +	 * close_range(2), which calls it directly.
>>  	 */
>>  	syscall_close(pipefd[0]);
>>  	syscall_close(pipefd[1]);
>> @@ -165,7 +166,7 @@ static void test_d_path_basic(void)
>>
>>  	if (CHECK(!bss->called_close,
>>  		  "close",
>> -		  "trampoline for filp_close was not called\n"))
>> +		  "trampoline for filp_close_sync was not called\n"))
>>  		goto cleanup;
>>
>>  	for (int i = 0; i < MAX_FILES; i++) {
>> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
>> index 561b2f861808..edb5494a47f7 100644
>> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
>> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
>> @@ -41,7 +41,7 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>>  	return 0;
>>  }
>>
>> -SEC("fentry/filp_close")
>> +SEC("fentry/filp_close_sync")
>>  int BPF_PROG(prog_close, struct file *file, void *id)
>>  {
>>  	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36058459433

