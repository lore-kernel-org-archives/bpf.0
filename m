Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD2314D1A;
	Fri, 21 Aug 2026 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291949; cv=none; b=LZAJj9yiSG+mvMazVkAFAQ/XlL+q8L1eMv5dJrNqUJ0so0kOKKHPpbPior2Rd4E1j7cQXaRyKgE6kjN7YxESplsUU5dTf5w12cG9vLdxjxlqVQ/4J5lOKKE1aGcF4XzijuxFwnYRKjrkDpzvdvAuI5l6fR8fFxoYjG/7W54z/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291949; c=relaxed/simple;
	bh=XRrOMlf0LnqmGhNWO5u3uJy7L0NzfI5++yUsrtlDqGU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Xd5x0tFIFbk7Y+IqgRBgdwyZNpjXE4Ojelk4/Rgd+oRZpZpbf5TaaDbF1JT5e0v8ll/4BZvZ+p/uFHx3mJDzPPmCeGWB9KlFp4SD7TAO1Ri3Ijqw0QeARjuuLppE6yKZrhlCRUiVe2Q2BHdOdgOYufjUqnfDp2zxGCYLAKtAGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftQ7CAR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftQ7CAR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F4F1F000E9;
	Fri, 21 Aug 2026 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291948;
	bh=7MXtflTernsZZquxTeIU0LjIQuLd6MZp94Ys4dUYPeU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ftQ7CAR2Hi2sAyU7jyF9muG90Lt5h76IxBg7I2xzh97Ma5DzCkeJsgcpRWqYmSGXg
	 dOXZBRS8LEP+voF5MtxYO9dl6YdmVcldk55oyYPtt/+dZxu04Czm6+ODv+nZoZnDWL
	 d78+MjZhUWczxDSVn15OyaGdpW9eJ2DolmeKHN5uZTkiKLq0REmhc1Vfw8jyTuyr3t
	 6kL57mjNCBtLc6GTSlHKTlpeQnfS0/JLi7LpNasw77e8fXW+tYtqHEIxTDxpHHd2tO
	 0+lvXRZ0woqNWDnqYdxqo2lJDZuA0HrW/5fJigypkw6pvS/J1wzhUXSttT4vvwIzZS
	 Omxtebna51heg==
Content-Type: multipart/mixed; boundary="===============3513314361117165479=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c1310128f27e5261e668f451484fe1cdacbc9583785a278d2edc80e1002bf178@mail.kernel.org>
In-Reply-To: <20260821050631.39784-4-jiayuan.chen@linux.dev>
References: <20260821050631.39784-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,emil@etsalapatis.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 05:59:07 +0000 (UTC)

--===============3513314361117165479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> new file mode 100644
> index 000000000000..af49d8b1b995
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> @@ -0,0 +1,156 @@

[ ... ]

> +static void dump_memcg(int (*rd)(const char *, const char *, char *, size_t))
> +{
> +	char buf[512];
> +
> +	/*
> +	 * memory.current reads 0 once the child has left the cgroup, so it only
> +	 * carries information when dumped from the live child; memory.peak and
> +	 * memory.events survive the child and tell the story either way.
> +	 */
> +	if (!rd(CG_PATH, "memory.current", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.current: %s", buf);
> +	if (!rd(CG_PATH, "memory.max", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.max: %s", buf);
> +	if (!rd(CG_PATH, "memory.peak", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.peak: %s", buf);
> +	if (!rd(CG_PATH, "memory.events", buf, sizeof(buf)))
> +		fprintf(stderr, "memory.events:\n%s", buf);
> +	fflush(NULL); /* _exit() in the child would not flush stdio otherwise */
> +}

Looking at fflush(NULL) - does this need to flush every open stream?
Under -v with output redirected, any test_progs output still buffered in
stdout at fork() time would be emitted a second time by the child.
Would fflush(stderr) be sufficient here?

> +
> +/* Read one key from a flat keyed cgroup file, e.g. "oom_kill" in memory.events. */
> +static long cg_read_key(const char *cg, const char *file, const char *key)
> +{
> +	char buf[512], *p;
> +
> +	if (read_cgroup_file(cg, file, buf, sizeof(buf)))
> +		return -1;
> +	p = strstr(buf, key);
> +	if (!p)
> +		return -1;
> +	return strtol(p + strlen(key), NULL, 10);
> +}
> +
> +void serial_test_arena_memcg(void)
> +{
> +	int cgroup_fd = -1, status;
> +	const long ps = PAGE_SIZE;
> +	char buf[64];
> +	pid_t pid;
> +
> +	if (setup_cgroup_environment())
> +		return;

Can setup_cgroup_environment() failing here result in a silent pass?
setup_cgroup_environment() can fail at several points - mkdir, unshare,
mount operations - meaning on a host without the right capabilities or
where cgroup2 cannot be mounted, the test returns before any ASSERT_*
runs and test_progs records arena_memcg:OK even though nothing was
tested. Since the arena/memcg interaction is the entire point of the
test, would wrapping this in ASSERT_OK() or adding an explicit skip be
clearer?

> +
> +	cgroup_fd = create_and_get_cgroup(CG_PATH);
> +	if (!ASSERT_OK_FD(cgroup_fd, "create_and_get_cgroup"))
> +		goto out;
> +
> +	/* No memory controller -> nothing to test. */
> +	if (read_cgroup_file(CG_PATH, "memory.current", buf, sizeof(buf))) {
> +		test__skip();
> +		goto out;
> +	}

A subsystem pattern flags this as potentially concerning: when the
memory controller is not available, test__skip() increments the skip
counter but prints no reason - a #N arena_memcg:SKIP line in a CI log
would give no indication of why. The comment records it in the source,
but nothing emits it at runtime. Every other arena test in this
directory prints an explicit reason with its skip:

  prog_tests/arena_htab.c:
    printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);

  prog_tests/arena_list.c, arena_spin_lock.c, arena_atomics.c:
    [similar patterns]

Would adding printf("%s:SKIP:no memory controller\n", __func__); before
test__skip() match the neighbours?

> +
> +	pid = fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		goto out;
> +	if (pid == 0) {
> +		struct arena_memcg *cskel;
> +		__u32 i, npages;
> +		char *base;
> +		size_t sz;
> +		long cur;
> +
> +		/*
> +		 * Do everything from the child: the arena vma is VM_DONTCOPY so
> +		 * it would not survive fork(), only the child should be under the
> +		 * limit so that a memcg OOM cannot pick test_progs, and a map is
> +		 * charged to the memcg of the task that creates it - so join
> +		 * before load. The cgroup work dir belongs to the parent that set
> +		 * the environment up, so reach it with the _parent() helpers.
> +		 * Errors are reported to the parent through the exit code, since
> +		 * ASSERT_* in a forked child does not reach it.
> +		 */

[ ... ]

> +		for (i = 0; i < npages; i++)
> +			base[(size_t)i * ps] = 1;
> +		/* Faulted everything without dying: no pressure built, dump why. */
> +		dump_memcg(read_cgroup_file_parent);
> +		_exit(0);

Can the child's dump_memcg() output reach the parent's log?
stdio_hijack_init() redirects stderr to an in-memory stream in
non-verbose runs, and after fork() the child has a private copy-on-write
copy of that FILE. The fprintf() calls in dump_memcg() and fflush(NULL)
write only into the child's address space, then _exit(0) throws them
away. So in a default test_progs run - exactly where diagnostics are
needed - the parent then fails ASSERT_TRUE(WIFSIGNALED(status)) with no
memcg state attached. The sample output in the commit message was
captured with -v, the one mode where this path does work. The second
dump_memcg() call at the end of the function runs in the parent and is
unaffected. Would writing the numbers over a pipe, or having the parent
dump memory.peak/memory.events on the !WIFSIGNALED path, get them into
the log?

> +	}

[ ... ]

> +	if (!ASSERT_TRUE(WIFSIGNALED(status), "child killed by signal"))
> +		goto out;
> +	if (!ASSERT_GE(cg_read_key(CG_PATH, "memory.events", "oom_kill"), 1,
> +		       "memcg oom_kill"))
> +		dump_memcg(read_cgroup_file);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32450158690
--===============3513314361117165479==--
