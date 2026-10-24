Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839288;
	b=S0MnkirPeTa762rHhEawItbBeg9B6vvw7WTtR025FdWHsPJAYq+H84FuEZAFIvWneGeL
	 NbGAvjH0IojL/ZvkBev/ycR4P865Y8WUTIGvM9mFTuDNDmP6NZWZ2+kHsO5JpRMa/gZba
	 NmOQhAgkxsHQUHfJ3mwyX2eNXXsyNZAxE+2odpLPH98Ly2QmF00ri0Y1Nv0DMaBDsbUOT
	 pTkOPZE/X+V6dmjUqLbQGb3WOGAavHB/R4BjF/c+jqx3TXJLQYdjXCWykd2h0/R7GEctP
	 TA9PnCTdBdyiJtndhJuLqjt9Q/VCx1h6HKdHzHj6QT0JKoeE8hSyuJXnMXwj+Ki+ksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839288;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wzvPaxzVvn6A8LwBUguFEHVBM9JU6kNt6e7S7V9OB2s=;
	b=K7HLx7VwHNI5aZ+lauKW2Q0kz4xMc44KGf6HPUz61Aw6aXLIJK+7BkVXSOnfmx9Zjl1h
	 OpcHY1TXdIXMvw3KU/vrs+4O5arJkDWQ5CoNsquuEG3BpuRIcO/GYILLqJhJo3X9eQYaG
	 cpAGZJFBJh+F8A+wRYsl/LzeXDXo63gu/Rvtd4E+ZfWxaMurliMwTrv2zng3HHcoRGZer
	 6syM5lc55PioKmc91q8Vs6b1c2gJIIJzP1ZuctYv6T/B8k79rR7WIRn0yhiOM1//f5S2r
	 AI/BoOgKm4BW6V3esCTpepLxbXPPn+2lqVa8D4m5zTCfMoYf0ZRrU1uMyh33RZXUQKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bafy2GDB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C76606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bafy2GDB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE071F01829;
	Sat, 24 Oct 2026 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792839287;
	bh=wzvPaxzVvn6A8LwBUguFEHVBM9JU6kNt6e7S7V9OB2s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bafy2GDBbTiAnmcYf6WklAjvDwUSp8J17Mc0d/VAaF/cNJN0Z6TwukMg9jpRvdY7C
	 WshKGfSXzksQJXSsEGtcmqR902zmdkIYUjc659xXJpwAQKLLXCla0h91uPWhN1FH6k
	 PonKaC/xNGH2ie50fA0Mc4rnZN+Ri/Wn/prZp1dwTCXLfKE8lgzzXUbddp0SOXSRy1
	 p4GqlZXm/Z66E78Uq7dJtBk+2f+6pQVq7o507Jr0SEW5anu/EfLiG253+eZeYXZqL7
	 mCChpk4zeLWh6L/e4J/ITFYB5cD9HCVIH0rM0w1Pgc0s8Qb+a54M+EBTOsK8ZE2snH
	 pZP9QwbqRIqJA==
Content-Type: multipart/mixed; boundary="===============8465764297578676581=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0308b58ac7788d9ff015a839a51fc159c10d841cc88de3073a30b3b8b97107b5@mail.kernel.org>
In-Reply-To: <20261024100647.2579244-2-xyx2021@mail.ustc.edu.cn>
References: <20261024100647.2579244-2-xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH bpf-next v8 1/2] bpf: Track borrowed iterator results by default
From: bot+bpf-ci@kernel.org
To: xyx2021@mail.ustc.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 24 Oct 2026 10:54:47 +0000 (UTC)

--===============8465764297578676581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Track borrowed iterator results by default

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit; the
unsound iterator-next behavior looks introduced by 4cc8c50c9abc, not the
task_vma iterator commit.

> bpf: Track borrowed iterator results by default
>
> An open-coded iterator can return a struct pointer borrowed from its
> current element. The verifier has not tied such results to iterator
> state since the task_vma iterator was introduced, so a saved result
> can still be used after destroy. Commit bee9ef4a40a27 ("bpf: switch
> task_vma iterator from mmap_lock to per-VMA locks") also made next
> release the protection of the prior element. A later snapshot
> conversion made vm_file explicitly borrowed from that element.
>
> Associate non-RCU, non-acquired struct results with the iterator
> reference by default. Invalidate dependents before next forks its
> NULL and non-NULL paths, while retaining the iterator itself. Let
> destroy propagate child-reference errors. Add KF_ITER_RET_INDEPENDENT
> for results that outlive the current element, preserving existing
> RCU and acquired-reference rules.
>
> Trusted pointer field loads also need to preserve the source lifetime.
> Loading a trusted field does not acquire a reference to the pointed-to
> object. Set the field pointer's parent_id to the source's reference ID
> if the source is referenced, or inherit its parent_id if it is borrowed.
> This is a generic rule, including accesses unrelated to iterators. For
> example, the following access is now rejected:
>
>   file = bpf_get_task_exe_file(task);
>   if (!file)
>           return 0;
>   inode = file->f_inode;
>   bpf_put_file(file);
>   ino = inode->i_ino;
>
> The inode pointer borrows the file's lifetime. Releasing the acquired
> file reference removes that lifetime guarantee, so the verifier must
> invalidate the derived inode pointer as well. This does not imply that
> bpf_put_file() immediately frees the file or inode. Reading the inode
> while the file reference is held remains valid. Fields with independent
> RCU protection retain their existing lifetime rules.
>
> For an iterator result, the same propagation keeps trusted fields such
> as vm_file and f_inode tied to the current element. Propagate the backing
> object's lifetime through dynptr construction too, so its descendants
> remain in the invalidation graph. Share the invalidation traversal
> between next and release, so advancing the iterator preserves its own
> reference.
>
> Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
> Suggested-by: Amery Hung <ameryhung@gmail.com>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>

Is the Fixes: tag pointing at the right commit?

When 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfuncs")
added bpf_iter_task_vma_next(), check_kfunc_call() typed the returned
struct pointer as a plain legacy PTR_TO_BTF_ID, without PTR_TRUSTED or
MEM_RCU.

Such a register is rejected by is_trusted_reg() when passed to a kfunc
("R%d must be referenced or trusted"), and it is only readable through
PROBE_MEM loads.  So a stale pointer saved from next could not be passed
to trusted-argument kfuncs or yield trusted field loads at that point.

The unsound behavior looks like it was introduced by 4cc8c50c9abc ("bpf:
Make the pointer returned by iter next method valid"), which started
marking non-RCU iter-next results as PTR_TRUSTED without tying their
lifetime to the iterator reference.

Should this be:

  Fixes: 4cc8c50c9abc ("bpf: Make the pointer returned by iter next method valid")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40085347801
--===============8465764297578676581==--
