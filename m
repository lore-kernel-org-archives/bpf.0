Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2314D8DBF;
	Fri, 25 Sep 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351893; cv=none; b=qHD+dTOT0M/zQStAlTPVAr4G6WbIe6uy/it3TAfe/X/qc2IbBOXgHcJOjNZiXHzQKi1Q6mEWlJPyU1lv54fat7OVD96R73KT85U84zM2wPVxbphqS9YDp9nUZqrj4l+3400m8W9PqM3Lba4INNGX+UJ8svIuas2DTKzP8lQ/K/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351893; c=relaxed/simple;
	bh=MVKzKEJ3WrR9RkRUypLAFaWDY0HbmqoWnQ41QYJ/ldo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKgj7pAzJnd6i1Nz1rwFArWo+EkblXkds0yljXHPFrt7C0iKAIixUoBVnaut/i8hXFkfY7lAGn10GEVKiS/KAj3yVImHC7NffkGeIs0muM+Az7zjK2DEGvO66Slpn0NercgiEq7ybfjypP3uK/aqDB4JEak6DoaBM0ZpbMHRPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXHvWtUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXHvWtUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F31F00893;
	Fri, 25 Sep 2026 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790351884;
	bh=/PxEGuDqoY/L6/XFaAkeVp18LKt6PhiAaiiUWOAHmBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EXHvWtUZq6uvZGyPQAlgUw/+MOO2N3qcuzCcZGxjplgoqnNthIQ0GydUlUQZHBm5G
	 AK8fxs0Lb2hl1ieqr2mDh4urpstyOsFgCgWBeAg2ag1RGksuAr516RGdWyuPpdDBY6
	 7BSUqtobkrqSrU2Qqq5VkRjIvozjpv3jDN2RxP8dVUv89eIGZccqdynnz/3mubp3J8
	 3LgaKu53kmBOyWCAB6pn8uhEg2CYzGfBjxJ1FNP09cZw5q5NVqSWS6SdEPsdLJf0R3
	 h6SN4oqwO3jx+NKaeWoFMoVe85Ln6TMANjo+KmsJPNddovm/E1Y8K2mVWzfQQpphM1
	 eRhrmg7q2HPaQ==
Date: Fri, 25 Sep 2026 17:57:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, viro@zeniv.linux.org.uk, 
	jack@suse.cz, neil@brown.name, jolsa@kernel.org, broonie@kernel.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org
Subject: Re: [PATCH vfs v1] bpf: Allow bpf_d_path() from filp_close_sync()
Message-ID: <20260925-skalpell-nanotechnologie-atemschutz-bce8ef8f2f26@brauner>
References: <20260924204226.190315-1-ihor.solodrai@linux.dev>
 <b3b4cbefd5258ad320205bc708c7864c20a16f39ffd37673fe9cbd534a1ebbca@mail.kernel.org>
 <6af94251-fc79-4377-b781-f9b413af1223@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6af94251-fc79-4377-b781-f9b413af1223@linux.dev>

On Thu, Sep 24, 2026 at 04:18:14PM -0700, Ihor Solodrai wrote:
> On 9/24/26 2:24 PM, bot+bpf-ci@kernel.org wrote:
> >> The d_path selftest closes its descriptors with close_range() so that
> >> its fentry program on filp_close() runs. The vfs commit
> >> 46ace7e4dc4b ("fs: make close_range() synchronous") switched
> >> close_range() to filp_close_sync(), so the program still attaches but
> >> is never called:
> >>
> >>   test_d_path_basic:FAIL:close trampoline for filp_close was not called
> >>
> >> With that series, close(), close_range() and the closes on exec and
> >> exit all go through filp_close_sync(). Few paths still reach
> >> filp_close(), dup2() being one of them, so a program on filp_close()
> >> no longer sees most file closes.
> > 
> > Can the commit message clarify which exec closes it refers to? At
> > 46ace7e4dc4b, begin_new_exec() calls do_close_on_exec(), which still
> > closes O_CLOEXEC descriptors with filp_close():
> > 
> > fs/file.c:do_close_on_exec() {
> >     ...
> >     spin_unlock(&files->file_lock);
> >     filp_close(file, files);
> >     cond_resched();
> > }
> > 
> > So close-on-exec stays on filp_close() rather than moving to
> > filp_close_sync(). Only close(2), __range_close() and close_files()
> > were converted in that series. After this patch, a program moved from
> > filp_close to filp_close_sync would silently stop seeing descriptors
> > closed by exec.
> > 
> >>
> >> Allow bpf_d_path() from filp_close_sync(). It takes the same arguments
> >> as filp_close() and the program runs before the file is flushed and
> >> its last reference is dropped, so file->f_path is still valid. Keep
> >> filp_close() in the allowlist for existing programs.
> > 
> > This explains why fentry is safe, but does the reasoning hold for fexit
> > as well? The commit message says "the program runs before the file is
> > flushed and its last reference is dropped," but that applies only to
> > entry, not exit. Looking at filp_close_sync() (a546b2ef2120):
> > 
> >     retval = filp_flush(filp, id);
> >     fput_close_sync(filp);
> > 
> > fput_close_sync() calls __fput() synchronously when this is the last
> > reference. __fput() does:
> > 
> >     dput(dentry);
> >     mntput(mnt);
> >     file_free(file);
> > 
> > So by the time a fexit trampoline runs, the dentry reference is gone
> > and the struct file has gone back to filp_cache (SLAB_TYPESAFE_BY_RCU,
> > reusable immediately). For pipes and sockets (alloc_file_pseudo uses
> > d_alloc_pseudo which sets DCACHE_NORCU), dentry_free() calls __d_free()
> > directly with no RCU delay.
> > 
> >>
> >> Attach the selftest program to filp_close_sync() and keep triggering
> >> it with close_range(), since filp_close_sync() may be inlined into
> >> close().
> >>
> >> Assisted-by: LLM
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 195f78db9bda..49d5ec983e72 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -972,6 +972,7 @@ BTF_ID(func, vfs_fallocate)
> >>  BTF_ID(func, dentry_open)
> >>  BTF_ID(func, vfs_getattr)
> >>  BTF_ID(func, filp_close)
> >> +BTF_ID(func, filp_close_sync)
> >>  BTF_SET_END(btf_allowlist_d_path)
> > 
> > Can a fexit program on filp_close_sync() safely call bpf_d_path() on
> > file->f_path that has already been freed? bpf_d_path_allowed() only
> > checks the attach target, not the attach type:
> > 
> >     return btf_id_set_contains(&btf_allowlist_d_path,
> >                                prog->aux->attach_btf_id);
> > 
> > and check_helper_call() uses only this callback to gate the helper.
> > check_attach_target() accepts BPF_TRACE_FEXIT on any function.
> > 
> > For example: SEC("fexit/filp_close_sync") prog calls
> > bpf_d_path(&file->f_path, buf, sz). close_range() on a pipe fd calls
> > __range_close() -> filp_close_sync() -> fput_close_sync() -> __fput()
> > -> dput() which frees the NORCU dentry, then file_free() frees the
> > file. Then the trampoline runs the fexit prog -> bpf_d_path() ->
> > copy_from_kernel_nofault(&copy, path) reads the freed file ->
> > d_path(&copy) -> path->dentry->d_op->d_dname(path->dentry, ...)
> > which reads freed dentry memory and calls through a function pointer
> > loaded from it.
> > 
> > The existing filp_close entry does not have this problem: fput_close()
> > -> __fput_deferred() queues ____fput with task_work_add(TWA_RESUME), so
> > __fput() runs only on return to user space, after fexit. filp_close_sync
> > is the first allowlist entry that drops the last reference to its own
> > argument.
> > 
> > Would it work to allow bpf_d_path from filp_close_sync only when
> > prog->expected_attach_type == BPF_TRACE_FENTRY?
> 
> Both claude and codex refuse to build a reproducer for this because they
> "take extra care with some cybersecurity requests".

I hate this.

> But the issue appears to be real, and bot's suggestion should work
> (pasting a diff at the bottom).
> 
> Christian, could you please confirm that allowing filp_close_sync on
> fentry, but not on fexit makes sense? Should I respin with that?

Seems fine to me.
