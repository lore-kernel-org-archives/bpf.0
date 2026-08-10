Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229B3F4DDC;
	Mon, 10 Aug 2026 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374646; cv=none; b=Sh6Cz5Wy0UW0MZxZS+/KhNklnTxnKAR4HYjiRozzBQHEovvFKjJw7JH9OhOEhd8Rfusypc4+DxtbkkfIRxBOWRiQZCgwGUqiGsOAloYChcVOr9mZ6OX3FYY4T7Dsx48Rvo1cbfeuCbs31lZIBiX8okOkmG4VuszB2t1dxotrp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374646; c=relaxed/simple;
	bh=sAWG2TuV2D6JBkSusGoDKXhjS8tqufnnLnfxtw1GONI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RGZqkoFt77M9EVzMzruEg8pXZ6FERr+ACKI7k4FHL61StL4xfiOyJoUMojkArs6yr7vcWN4Crm/LU2yfGaIGeKrD1mjwQ+1LsD63fuwMEsJaaiVMtudLjRTKujhXus14Ir/gcxy/wv0eLv4NQO1+5CFNjmDE6JYstHTiUfI6xhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9ZvoPn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9ZvoPn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE11F000E9;
	Mon, 10 Aug 2026 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786374645;
	bh=8EwZnhZeSJdSpHnJriPM/lr6SRyBiF63EGnVwaxD09M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a9ZvoPn/ffYvFSWc8w8t7kavNVg8Nd+Y/N/qzD0DrDe8j+eYRgKEZqmt4Rp4a/rd9
	 IV+Q/36pzMI5J48Zi0IkJU4vCUTIxYG84DDIvs8OYM7A7SCDhsFBlDAne+fkccSN6/
	 SMujqmA3o3sqLywY0cmK+dEejyWcV5anyQIg7SYBp7D5PBbpOSlR1Yd9LAfQZ2dsgK
	 yeCmr8so+0uSmFrQbcd0pGHM4P2TY8I4OhRsmGn3iZVhP/4LrvDPobdD0M8DjmBnLk
	 yZfk744LFyXf9gAxTlD3Q14XMrza+/at7KXw8h69+l6mqfO6tHsHX5CfPs4lzznmvK
	 NtYuVk3JubCXQ==
Content-Type: multipart/mixed; boundary="===============6706732374560641372=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9081a78882b2455f3464e7765c8810765e4d75f48571239f85978b00cb356c1c@mail.kernel.org>
In-Reply-To: <20260810134800.2875487-3-chenyuan_fl@163.com>
References: <20260810134800.2875487-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 15:10:44 +0000 (UTC)

--===============6706732374560641372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit d5e05189cced9c98030a06e9001b3384079ee0ac
> Author: Yuan Chen <chenyuan@kylinos.cn>
> Date:   Mon Aug 10 21:47:59 2026 +0800
>
>     bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
>
>     range_tree_set() pre-allocates the node needed for a brand-new range
>     before calling range_tree_clear(), so an allocation failure returns
>     -ENOMEM without having modified the tree (previously the overlapping
>     nodes were already removed by range_tree_clear() before the allocation
>     was attempted, permanently losing the cleared sub-ranges).
>
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This looks like a bug fix, should it include a Fixes tag?  The
allocate-after-clear ordering has been present since range_tree_set()
was introduced in b795379757eb ("bpf: Introduce range_tree data
structure and use it in bpf arena"), which already had:

kernel/bpf/range_tree.c:range_tree_set() {
    ...
    err = range_tree_clear(rt, start, len);
    if (err)
            return err;
    ...
    } else {
            left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
            if (!left)
                    return -ENOMEM;
    ...

so the tree was already mutated by the time the allocation failure was
returned.  A Fixes tag also matters here for backport scope, since the
allocator changed from bpf_mem_alloc() to kmalloc_nolock() partway
through the affected history.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31396076224
--===============6706732374560641372==--
