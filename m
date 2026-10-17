Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF093B19BF;
	Sat, 17 Oct 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257424; cv=none; b=CMeEuuRq+OzWRo5r/UOJ/fg/9VjJik76z2v1m+3hLjAcMk1FHtU/Y/eJyW0Zaf/WOaehXnOe8CTDbLfpC0Qo4O1XUdPvUHIhO+ejKivrdaQb60hbhkp0fZzpZFrxG3N9x/h14zKAKuaoiqb8BW3rWMYZtK/l8NYZ+oJAPyCL69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257424; c=relaxed/simple;
	bh=lmCGI0UVH6C257EB2gLt+HExUqo9MsRLUWuY6BmhihY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XQYFYMDRnnv/tRJWBcLANBsRVjTYSj5G1+eYGoYytdv2Yiiv0qwngqySV31K2ErlDGf2qkTFWTURdWmjmQfO6FkLNtkzv8/ZDpe2m71LAez5PKY0LxCQyCLJ8gvrXdSR/8oes2Z1t0oVjo7/iZzH638YYKa0es4MBr6xrymuhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVpmexDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVpmexDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA371F000C4;
	Sat, 17 Oct 2026 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257422;
	bh=BCxBXkOer72wuV3IMYghcCTFoUc4gdg138tWi5fuVSE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GVpmexDqCRVd/eNJV0bZTS6unyTVySHgFsvwO1FPtKypVKMNfv2ZGHD/ZuTWyT7+C
	 JG1KGWr1jItl0iW2M9l3fH0vC8aVzoadNdNDBpgbUfp6uh2mfKJHkhphfxSoHGfcnS
	 w/jAjcgAVqz5jaBBuvPabtdjaCs52X3rkouH4lIVEVMgIyQHHsuucWw4KK/vrGmh0R
	 T919IBpXgeDwX3DXvZQVRqNRO4EeCuy8pacxFIcTJkhQdsI2c568R74+/XRMCb8RAK
	 NyX+fngEZOi47EhiQYNWva58hoxoK2GGmZJpf4wLB5K+Eck8yNYY+RTrr4GoVCOmHI
	 9mNnduowCgyew==
Content-Type: multipart/mixed; boundary="===============1420937528216665879=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6331891dcb060c5a201d786033b1b9b948aaa8b776c6f81122ee5e0c6b990736@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-17-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-17-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 16/43] bpf: Link the first element after its storage is published
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:01 +0000 (UTC)

--===============1420937528216665879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Link the first element after its storage is published

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit; the
lockless iterator exposure looks introduced by c69d2ddb2072, not 5ce6e77c7edf.
The code change itself isn't questioned.

>     bpf: Link the first element after its storage is published
>
>     bpf_local_storage_alloc() links the first element of a new storage to the
>     bucket of its map, and then publishes the storage in the owner with
>     cmpxchg().  If another cpu has been faster, the element is taken out of
>     the bucket again and is freed together with the storage.
>
>     In between the iterator over a sk_storage map can find the element.  It
>     stays linked to a storage that points to the socket, but the socket knows
>     nothing of that storage: bpf_sk_storage_free() neither unlinks the element
>     nor waits for anybody who uses the storage.  So nothing tells the iterator
>     that the socket has gone away.
>
>     Three cpus that create the first storage of a new AF_UNIX socket at the
>     same time, and a fourth that reads the iterator, are enough: in 20 seconds
>     its program was shown some 4000 elements of storages that had lost.  If the
>     socket is closed in time, the program is handed a freed socket.
>
>     Link the element once the storage is published.  Both happens under the
>     lock of the bucket, which holds off whoever finds the element through the
>     owner and wants to unlink it.
>
>     Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Is this the right commit for the Fixes: tag?

5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
held the bucket lock (raw_spin_lock_bh(&b->lock)) for the whole time it
handed an element to the program.  The losing sk_storage_alloc() could
therefore not run selem_unlink_map() and free the storage until the
iterator had moved on, and the socket stayed alive because the allocating
caller still held it.

The element was already linked before the cmpxchg() back then, but nothing
walked the bucket list locklessly.  The old comment in the alloc path even
says that nobody accesses first_selem from the bucket list under
rcu_read_lock().

The lockless exposure looks like it came from c69d2ddb2072 ("bpf: Using
rcu_read_lock for bpf_sk_storage_map iterator"), which replaced the bucket
lock in bpf_sk_storage_map_seq_find_next()/seq_stop() with rcu_read_lock().
From then on the iterator can see the transiently linked first_selem of a
losing storage without excluding its unlink and free.

Should this be:

  Fixes: c69d2ddb2072 ("bpf: Using rcu_read_lock for bpf_sk_storage_map iterator")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============1420937528216665879==--
