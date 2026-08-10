Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC33BBFCF;
	Mon, 10 Aug 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359616; cv=none; b=WJgVXa0nrG8jklv41aQ+37mncxNxTJwfu6pr1TmHBXjqehMMXwJSkPekxTzfB6yMMnLfmIT5AojBDWAjJIWy4uJPexQSG3ViekeZr1btjWZxSY2Pg6sZXGcg8sKVqTx0T4ayhUir57e9jaGIzfprGED21DBLKbJHavTEXIZ0EuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359616; c=relaxed/simple;
	bh=Vj/dauoRj2y+S1zSycQnLgABrj9u0znpMw++46oV0AE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iBSdBxuKRNJ2mkX4hiN5P3oy9soEb7loy58+sW2sPv4HUKbtZsK0KmXo3rtK2z6txTmB2SA+ZXeTMY4q+8tMVn6+r3Ni1w+Yfz85fmaDC2KS/f0wimu1Vj+htFr7QQEZShvwxZ3sQ/2ygJRM/fOtIWyNwioJOa+Y5hB/YoenM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abtlaqMc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abtlaqMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F71F00A3D;
	Mon, 10 Aug 2026 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786359600;
	bh=KF38iDPbmapNPIDZKDcDxXKuwcASctBLPsszF8wm6uc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=abtlaqMcHyrN/3YQ2ndYj6hhW4S+/PFEwnCsu7YkrYkmrtamGTqhDYOGmQ1rUsRgs
	 pmoPLdpQx8iKx1GjdlwuOb3DSbkJRs4ubTAy58UnIbHrqnvZIZcN2w+5Vt24+uV6Bb
	 m3ZLxtJ1u53qva4Nq49sENxlKLRlYvap236joF5NL5R+LHyjLj5VjIIk3FVNh/Pdof
	 YIcKCHX1mBsg2m4q0C7+juLLwkvLhGQJ86qpgR23vYTp5+T/m0GATsKwj7EMhQhhEs
	 doFAhGEompVO+UXM6G/bmBelJ2/PIl4u5nsXqi4lK70D5KCIjBkgxdgjtiMiux9+G7
	 d/IgZYdLIGgCw==
Content-Type: multipart/mixed; boundary="===============4498802350136371953=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da5ec55c58dcd8997d2c5e1836e3b41289ebefe9be5328057fde62d8e7d8d5ad@mail.kernel.org>
In-Reply-To: <20260810094634.2723213-3-chenyuan_fl@163.com>
References: <20260810094634.2723213-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 10:59:59 +0000 (UTC)

--===============4498802350136371953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
>
> range_tree_set() pre-allocates the node needed for a brand-new range
> before calling range_tree_clear(), so an allocation failure returns
> -ENOMEM without having modified the tree (previously the overlapping
> nodes were already removed by range_tree_clear() before the allocation
> was attempted, permanently losing the cleared sub-ranges).
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Should this include a Fixes: tag?

The commit message describes a concrete bug: on allocation failure the
range tree was left with overlapping free sub-ranges already removed,
permanently losing that arena free space.

The clear-then-allocate ordering has been present since
kernel/bpf/range_tree.c was introduced. The original code had exactly
the same structure, only with bpf_mem_alloc() instead of
kmalloc_nolock():

    /* Clear out everything in the range we want to set. */
    err = range_tree_clear(rt, start, len);
    if (err)
        return err;
    ...
    } else {
        left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
        if (!left)
            return -ENOMEM;

Concrete reproduction of the pre-patch bug: with the tree holding a
single free range {[10,20]} and a call to range_tree_set(rt, 5, 20)
(i.e. start=5, last=24), range_tree_clear() takes the 'in the middle of
the clearing range' branch, removing and freeing [10,20]. The subsequent
allocation then fails, range_tree_set() returns -ENOMEM, and the tree is
left empty -- the [10,20] free range is gone for the lifetime of the
arena.

Four of the five callers (arena_alloc_pages() rollback at
kernel/bpf/arena.c:774, arena_free_pages() at :884, arena_free_worker()
at :1011, arena_vm_fault() rollback at :523/:529) discard
range_tree_set()'s return value, so the loss is silent.

Should this include:

  Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31377360587
--===============4498802350136371953==--
