Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675B3CFF60;
	Wed, 27 May 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869174; cv=none; b=I7Az8ygC3n8B/PppLJbvunCSuSwsNV/GhHpkZkKfuYpj1VZ2WKOcvw48VAv8dMhPJsrGERGc7ygzrirAiL/Bt4CNj656da6609Xa2p6O0xfmy1oqbWmpPLb9DLAXmLn9I/LH7tL88JSDS3JXDv2Ffj4MsuQhgPU82SzDE4tyCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869174; c=relaxed/simple;
	bh=8H9wP9dZyVPNsLBzJBtkOZIqqSlX8NHtTMlgj+jXU5g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FQpsUsOtTuCefU0wJ8XOyAya/1mzXjUcGHgn95HnpDTCN0wsuyY1GU554kq5rOVY1UyPh05CKCdi6ESpsdh9ZxLTvmTLOIf/v2IBlmUbED2nVTzB3SD5gVOjaQQKS8jWDoNNn7JKb63McGbJOAd3Jl24nJYzQzF+cyS92232G+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6PGQue6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6PGQue6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850491F000E9;
	Wed, 27 May 2026 08:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779869171;
	bh=lpK6kddP4Ix2XusLSMFGgv8M+O0QzdAtvCCz2UObz5c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c6PGQue6MBcq1HU0LectbimcWVsYrSeSCnm19VgUo5wK/ci2PwCIHwi90D+0qT7cI
	 ULLjARGw+8Z+EicHVCSN9WMAyXx0HDNXzqA47jcRIJkpAaMwYE+Wabx/lrtbzWRh+7
	 stFw51CDuH1QkckvQJRQcJbeeSx4L/0Xff0ew2T0iXUMakGlFdPStzXC6/ereDOA4C
	 ATBV4654sWlNpSrta0Q22AvJ+0ivkrstYejESwl3czcq03OLw59iC1Lki58v7iNcBI
	 LQ3WjWgrvyA37qRUOfSQBCTtf/0+NVTrbQYb91w9JEdJ7Ztnf+HtOI6O+tPtOlrJeh
	 fhRlTNCc9VzcQ==
Content-Type: multipart/mixed; boundary="===============8353182931888954691=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de6652ce9d1367daf217fcb5793419db9d967757b7b7857b00ae1c0c008f46ec@mail.kernel.org>
In-Reply-To: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
References: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
Subject: Re: [PATCH bpf-next v1] bpf: Use hlist_nulls_replace_rcu() when updating htab elements
From: bot+bpf-ci@kernel.org
To: xuanqiang.luo@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,luoxuanqiang@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 08:06:11 +0000 (UTC)

--===============8353182931888954691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Use hlist_nulls_replace_rcu() when updating htab elements
>
>     When updating an existing element, the current code does
>     hlist_nulls_add_head_rcu() followed by hlist_nulls_del_rcu(), exposing
>     a transient state where both old and new elements are visible to
>     concurrent RCU traversals.
>
>     Use hlist_nulls_replace_rcu() to atomically replace the old element in
>     place, so RCU readers always see a consistent hash chain.
>
>     Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

This looks like a bug fix that should include:

  Fixes: 4fe8435909fd ("bpf: convert htab map to hlist_nulls")

The bug was introduced by commit 4fe8435909fd which added the
hlist_nulls_add_head_rcu() followed by hlist_nulls_del_rcu() pattern,
exposing a transient state where both old and new elements are visible
to concurrent RCU traversals.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..b20e82bd253d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1246,18 +1246,16 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  		goto err;
>  	}
>
> -	/* add new element to the head of the list, so that
> -	 * concurrent search will find it before old elem
> -	 */
> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>  	if (l_old) {
> -		hlist_nulls_del_rcu(&l_old->hash_node);
> +		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);
>
>  		/* l_old has already been stashed in htab->extra_elems, free
>  		 * its special fields before it is available for reuse.
>  		 */
>  		if (htab_is_prealloc(htab))
>  			check_and_free_fields(htab, l_old);
> +	} else {
> +		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>  	}

Does this atomic replacement approach actually solve the lookup problem?

During review of Hou Tao's earlier v1 patch that used the same approach,
Alexei Starovoitov raised a fundamental concern:

  "This atomic replacement doesn't really solve anything. lookup will see
   one element. That element could be deleted by another thread. bucket
   lock and either two step update or single step don't change anything
   from the pov of bpf prog doing lookup."

Reference: https://lore.kernel.org/bpf/CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com/

Hou Tao acknowledged this limitation and abandoned this approach in v2,
instead implementing atomic updates only for htab of maps. This patch
appears to be a re-implementation of the abandoned v1 approach without
addressing the fundamental concerns raised during that review.

Can you clarify how this approach addresses the concerns that led to
abandonment of the similar change in Hou Tao's earlier patch series?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26496972451
--===============8353182931888954691==--
