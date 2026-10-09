Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F13B2AA;
	Fri,  9 Oct 2026 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513464; cv=none; b=uYOTvohQQPp/uMGI9PdppW8QJicQBNcbNak8iseBqhlSOukoJ3xJT+R61N3EXbDPCGI6SHXAp5VyEp0EVh1CP0yy3mymBKQe23vycnTOCxREFoB/+GQ5RwZ8zFd4MHseZoWE5nxzh0i9ZO7dYu/QZVOVfw/B/6Tu+69IkjQUEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513464; c=relaxed/simple;
	bh=uilAcxXdEDHrIEA6qJQTACvA+Waqg5fO5kXAcUz6HQU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U3TST5Dn8sVV1k23WLZCzHDAy1QI+JAlQAh8aH1FOOW1RaTSef2plyuLg8fR+MS+hRjrkulYFFCI0ZIoiaKQ5c6D6RiQ8vnmNJ0IBwIw+pzhYIRo2jfFeOTr7pX8zdvyPJi7rjjGpl8ezjuBJ6tt6J/a93vQ1HZSosp5ZH/+EZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTUGcaV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTUGcaV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B41F000FF;
	Fri,  9 Oct 2026 02:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513463;
	bh=AjbgbSK47XPsGXZE4OLGuODYnfeTlr+0YETwgf4eBPY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oTUGcaV0TxSj7BxbsUP8buQuhqIcdCkkDyxA4N21HhS74Lwvr7m7geC4Z9Lk0KSSu
	 ehij/UbwLajF7cgzMa5zafI5FeTwy9ou/HdQybrUGjLIejphhijcSSP/wYdp/Q5Vl1
	 BodCClZ/TgPweqPpLuVXDGGAzdM94xvbTq2Cxri0jcmFJkjami5np1zoloLOn8s1wX
	 C80Ake68ROuiUVt9uliCJanGD/v5yD9jJt1nYQu1wnGmJjOG5w5CIcIvARRFdh9noq
	 n9wqiWloyXgv0WwdEBkGOBoFgdRUy4yWx2ly07F2JUzILSljmcRQpYudav76WumoS8
	 Pd7aMcAH9WTIQ==
Content-Type: multipart/mixed; boundary="===============7668226373489510999=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e882ba21a8f5d6f760c3e9066a509a9b4d699038200ee2be196b393598a5e7db@mail.kernel.org>
In-Reply-To: <20261009-selftests-bpf-libarena-nr-cpus-v1-1-e726ccc66fc6@gmail.com>
References: <20261009-selftests-bpf-libarena-nr-cpus-v1-1-e726ccc66fc6@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Return the lock error from buddy_init() of libarena
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 02:37:41 +0000 (UTC)

--===============7668226373489510999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Return the lock error from buddy_init() of libarena

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit
(b1487dc1b181, which doesn't touch buddy_init()); 86426a28c52d introduced the
code being changed.

>     selftests/bpf: Return the lock error from buddy_init() of libarena
>
>     buddy_init() takes the buddy lock, an arena spin lock, to put its first
>     chunk on the list, and returns -EINVAL when it can't.
>     arena_spin_lock() fails with -EOPNOTSUPP on kernels built with more
>     than 1024 possible CPUs, where it has no queue node for every CPU, and
>     with -ETIMEDOUT or -EBUSY otherwise. Returning -EINVAL for all of them
>     hides which one happened from the caller.
>     Return the error of the lock.
>     Fixes: b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
>     Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Is the Fixes: tag pointing at the right commit?

b1487dc1b181 ("selftests/bpf: Add selftests for libarena buddy allocator")
only adds st_buddy.bpf.c, st_asan_buddy.bpf.c, prog_tests/libarena.c and
prog_tests/libarena_asan.c.  It does not touch src/buddy.bpf.c or
buddy_init().

The code being changed here:

    if (buddy_lock(buddy, flags)) {
        bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
        return -EINVAL;
    }

was introduced by 86426a28c52d ("selftests/bpf: Add buddy allocator for
libarena"), which added buddy.bpf.c with buddy_init() already returning
-EINVAL when buddy_lock() failed.  The selftests commit only exposes the
discarded error, it did not introduce the code that discards it.

The same tag is also used by the follow-up commit 27aeee1ef85a
("selftests/bpf: Skip libarena on kernels with too many possible CPUs"),
which depends on this patch to see -EOPNOTSUPP from arena_buddy_reset().

Should this be:

  Fixes: 86426a28c52d ("selftests/bpf: Add buddy allocator for libarena")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37873620927
--===============7668226373489510999==--
