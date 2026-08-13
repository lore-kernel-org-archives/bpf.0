Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073463F483D;
	Thu, 13 Aug 2026 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659998; cv=none; b=i8uiBtfIEqZtWkLqTLr2p1s/ibcGrxLahD7XWFyofYx6B4Ia6y/RyWIjgrDhEWWno3ZjCDm3E1C1evsCNErCqLre8kz4tXbayIS1xiKNREabwTx6nkbW03U7XT04GuGSfYF/hiIPdSWoTEvKjgpKEnmBFl0OUxrOPGha3XqoNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659998; c=relaxed/simple;
	bh=JpUVWn8UsZxzQeUqXmGo+2AOroUYvmVBFTXLwnNbOhA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aNDGmnOIuEz/TkpaNdlaDnLvSCYr5jRLRpkSCByNrSP5PZ54T889ltu1WMGbTks8r7WjKoNB+1TdLo73oLtZTZS9J7FhJoQsDTMXBeAfOe2Ecu1ROLEEHvSgaF/HHC7Mo+OJL7YaORDliKcpO0HAlcze0KK+ane+4U6sWeyUejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGkpXLTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGkpXLTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A431F00A3A;
	Thu, 13 Aug 2026 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659996;
	bh=COjYU0sEfdGhoYwtqy3AekC66nLkRTjlQ8/+x3QCqBQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CGkpXLTc0D7iAQ7Zmr42so6SXR4CEjcu1yBqIKuAVUfUNvnL9eQaMJ9diaaEg26dI
	 DN2nK/OhfRZpenEdIiVSiwpkFIdueVtExvn8UFDUexYGHYvglqF3yc+DHTwI2SLcxt
	 xBsd3peWVbfPI0MOiGO7XNrFjE40SLcQO0OUJKtXQAp6T2kau9YsBElmdXdROl1JKV
	 rntB/yL5s93SUcO36UV54zU4Pj0t5E/sbsX9DDo7Ek1NDkFHUePzR1zc48Yuxly+nP
	 HJd24wvvV4BV5sCCjXtPEuVSvHgwJSRNLcP7TSJ1YUEIdEonJb+ACxLVHJmBaLCqy2
	 2CP9CLa8Hj4yg==
Content-Type: multipart/mixed; boundary="===============0727513438879644745=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <54f3845022121f32320c644ae2ad998cc047bc5513756bf65febfb21d528c253@mail.kernel.org>
In-Reply-To: <20260813211533.290256-3-dingning04@gmail.com>
References: <20260813211533.290256-3-dingning04@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] selftests/bpf: Test refcount_acquire return nullability
From: bot+bpf-ci@kernel.org
To: dingning04@gmail.com,bpf@vger.kernel.org
Cc: memxor@gmail.com,greg@kroah.com,dingning04@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,utilityemal77@gmail.com,chengkaitao@kylinos.cn,vmalik@redhat.com,leon.hwang@linux.dev,chenyy23@mails.tsinghua.edu.cn,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 22:26:35 +0000 (UTC)

--===============0727513438879644745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 61906f48025cc..fd35093285c0d 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c

[ ... ]

> @@ -832,6 +848,51 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
>  	return 0;
>  }
>
> +SEC("tc")
> +__success
> +long refcount_acquire_owning_input_no_null_check(void *ctx)
> +{
> +	struct node_refcount_only *n, *m;
> +
> +	n = bpf_obj_new(typeof(*n));
> +	if (!n)
> +		return 1;
> +
> +	m = bpf_refcount_acquire(n);
> +	bpf_obj_drop(m);
> +	bpf_obj_drop(n);
> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +__success
> +long refcount_acquire_rcu_map_kptr_null_checked(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n, *m;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	m = bpf_refcount_acquire(n);
> +	bpf_rcu_read_unlock();

This isn't a bug, but since SEC("tc") programs are already treated as
being in an RCU critical section (in_rcu_cs() returns true for
non-sleepable programs), would a sleepable program type make the
bpf_rcu_read_lock()/unlock() section here actually load-bearing, or
could the pair simply be dropped?

> +
> +	if (!m)
> +		return 3;
> +	bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +
>  static long __stash_map_empty_xchg(struct node_data *n, int idx)
>  {
>  	struct map_value *mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 024ef2aae2008..acd3e81a39168 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c

[ ... ]

> @@ -80,6 +96,37 @@ long refcount_acquire_maybe_null(void *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__failure __msg("Possibly NULL pointer passed to trusted R1")
> +long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *tmp, *n, *m;
> +	int idx = 0;
> +
> +	tmp = bpf_obj_new(typeof(*tmp));
> +	if (!tmp)
> +		return 3;
> +	bpf_obj_drop(tmp);

This isn't a bug, but is the bpf_obj_new()/bpf_obj_drop() pair at the
start needed to force a complete BTF type for struct node_refcount_only,
or is it leftover setup? A one-line comment would keep someone from
removing it later.

> +
> +	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	m = bpf_refcount_acquire(n);
> +	bpf_rcu_read_unlock();
> +
> +	bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +
>  SEC("?tc")
>  __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31745514567
--===============0727513438879644745==--
