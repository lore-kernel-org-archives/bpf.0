Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF23F787E
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827607; cv=none; b=qU/NdNvi4OUBEbcgZ6uBJKQnkiCVy0YpvV9TCWJJgW4LMpKikYW+Qtsghxxf3dCxdHgtakrYglZED6H4mZ2bo67+LpouAQ9V4X3u7BwdbQMhClzIz228kD/Ejo9zCo5mZXHn9vPT5SnXQ2DJbCazTanACE1GQqhIxBueyb6mYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827607; c=relaxed/simple;
	bh=Z6bebr2uE6P4tOMWx2oHNlHX/7P1jkwN8Ziu4WdHAe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGZ9my+fPLhdvTHu/XCdN/fWFEGyJkx/KnnlDZUXXDB36RnNxrOoJy0mbihf54um7bvr1QNeaiG6jZNUzrTUKoW9siRJNAVKcoNxHgud0s2AlasmNT/52hO0NQ5wnZmbIgufMtQjMUEJqQRNcWgoCTWVFLIaE8xxe+EEV8LkSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu+nRD1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu+nRD1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F951F000E9;
	Thu, 27 Aug 2026 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787827603;
	bh=DKhLejkRg1ftIc9mF3Tvq4m2Yt7cyWPPey2JEdIcoSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vu+nRD1jOj46y5cVopX5kqQiZ3RPosUjtYl2gxWMfKqixCQN7WUy/g6JMjmH7cjDM
	 rNX04Rdko27WMNS+ZBrr0ptiHHtK8neEPA2DGBoGbvbphFHxghr0KBqhwThJpPgoT7
	 7romRGJWpKa3ZZTYkD2xUq5XfhNeROBjsINe7ivTRdtnSf3H8veqI/LveuDVhKuWFF
	 WnUk/I80VdQidThQcCjXyZ+7d8GIewvGfVuUQbHtZHltfj//Mb93xtpdcZi9Z8nSCF
	 leYNuzExgFU+TW2a3mmGWSGtVvEAAOopD8rQoTwanuKZWBtV6GMBtz4k/FcLj2n+3v
	 9nFEoYfQu0KQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
References: <cover.1787826402.git.zhuhui@kylinos.cn>
 <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:46:42 +0000
Message-Id: <20260827104642.D8F951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BPF kfunc `bpf_proactive_reclaim` can cause kernel deadlocks by tr=
iggering memory reclaim with `GFP_KERNEL` from sleepable contexts where fil=
esystem or IO locks may be held.
- [Medium] Integer overflow in calculating the returned reclaimed bytes on =
32-bit architectures.
--

commit ef066c78e33635cc7e9aa0fc78438725da7dc30b
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfunc

This commit adds a sleepable kfunc bpf_proactive_reclaim() which performs
one proactive reclaim pass on a given memory cgroup. It refuses to reclaim
if the calling task is already in a reclaim context to avoid corrupting the
outer reclaim state.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..297ff7f050427 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -159,6 +160,49 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct m=
em_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }

[ ... ]

> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size)
> +{
> +	unsigned long nr_reclaimed;
> +
> +	if (size < PAGE_SIZE || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	nr_reclaimed =3D try_to_free_mem_cgroup_pages(memcg, size / PAGE_SIZE,
> +						    GFP_KERNEL,

[Severity: High]
Can this cause a kernel deadlock when called from sleepable contexts where
filesystem or IO locks may be held?

Since GFP_KERNEL includes __GFP_FS and __GFP_IO, the direct reclaim path is
allowed to invoke filesystem shrinkers. If a shrinker attempts to acquire a
lock already held by the task (e.g., if a sleepable BPF program attached to
an LSM hook like inode_rmdir or security_file_open calls
bpf_proactive_reclaim), a self-deadlock could occur.

Would it be safer to wrap the reclaim call in memalloc_nofs_save() and
memalloc_nofs_restore() to guarantee safety, as the verifier cannot
statically enforce that no filesystem locks are held?

> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    NULL);
> +
> +	return nr_reclaimed * PAGE_SIZE;

[Severity: Medium]
Does this calculation overflow the 32-bit boundary before returning to the
caller?

On 32-bit architectures, unsigned long is 32 bits, making ULONG_MAX
approximately 4GB. If a user requests a reclaim pass with size close to
ULONG_MAX, the target pages will be close to 1,048,575.

try_to_free_mem_cgroup_pages() reclaims in batches and can easily overshoot
the target.

If nr_reclaimed exceeds 1,048,575 pages, multiplying it by PAGE_SIZE (4096)
will wrap around the 32-bit limit, yielding a severely truncated result.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787826402.gi=
t.zhuhui@kylinos.cn?part=3D1
