Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B53A873D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515276; cv=none; b=VOgGeoFZ9aA5L/MEqDJvvpYRfEBJ9VNSRFRJLAWVqXKWcFHler8+z5Uq+BCLLW6ZYLGTkFh97k+CN38i+AsNI5tmMkKdvTg8zjlzw5XIGg3QGtwu9Iq5YI/CqLf/UElj9sViFlJYnsak4Ygn0al1ANqrRMA5mvYlaWtlarRUuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515276; c=relaxed/simple;
	bh=kzyPQJSs8uamsM5cXmZHqr815qpNJWiubMqBWsKRHa4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iSrFt17hL5fLk2IUt7nPzLQdj9k7fbnQB9bnwN0mmi/SJfzvrqx4ojnaW6wc4NnsI2l/7BVB5aETHZPskAK99DUTZjmTbRDAH3bWKbpkM1nqqRzcaKfrMTDw06tBgil3yWKKV0zuJacgpVgh1MpbuNLK858fb7XNC3Q0oGI76aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfqfik5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfqfik5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4CB1F00A3D;
	Fri,  4 Sep 2026 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788515275;
	bh=bPCd2FhH4KGLy2s75HK4fsP6wvFCWRZLzWa2pkeAUBw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Cfqfik5F7ssAuwKVw7jFzUfyolZqQMP0MktaMFfjBmfrBUcwHjE73YB38nnrp0hCE
	 wDzcDkiemRW/qd1yHJFEkI1Z3ayFuGbD0MKGJZc4CewzRrBpbbZ3wuiCseMxfF9LuL
	 fmjbsyLAQrHOkYBHKGWsddD10R83b6ER0JVcR/lUeMak/D9Yx9CfMsSQL2vmKblIVx
	 9ExutLDKPNm/p28rU6fAHQTKu3tyKjTWS85PFtsLk3aI295jRA08ReDACWMU38+4/Z
	 XesRyOlcRO4FObXpHDm77CDSlYzelTy/V/4yFc/o2lXOg+ZLjP9VQGsE8mqIcspEKR
	 PJR5ohKVwuRgQ==
Content-Type: multipart/mixed; boundary="===============3952255768304245481=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25823e816bee3912765d4010be3f0c00733b12065c5d289ea8bc7d72b5e8fc10@mail.kernel.org>
In-Reply-To: <20260904084325.52250-5-memxor@gmail.com>
References: <20260904084325.52250-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 4/8] selftests/bpf: Test borrowed refcount acquisition nullability
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: dingning04@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 09:47:54 +0000 (UTC)

--===============3952255768304245481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 61906f48025cc..cae00f7b0a245 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index eaaed0859f946..7d2f8897e5ad1 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c

[ ... ]

> @@ -89,6 +105,38 @@ long refcount_acquire_non_object(void *ctx)
>  	return bpf_refcount_acquire(ctx) != NULL;
>  }
>
> +SEC("?syscall")
> +__failure __msg("Possibly NULL pointer passed to trusted R1")
> +long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *tmp, *n, *m;
> +	int idx = 0;
> +
> +	/* Force Clang to emit complete BTF for struct node_refcount_only. */
> +	tmp = bpf_obj_new(typeof(*tmp));
> +	if (!tmp)
> +		return 3;
> +	bpf_obj_drop(tmp);
                   ^^^^

This isn't a bug, but would the usual `struct node_refcount_only
*just_here_because_btf_bug;` declaration (as in progs/local_kptr_stash.c
and progs/rcu_read_lock.c) work here instead of the in-body
bpf_obj_new()/bpf_obj_drop() pair, so the test body only contains the
pattern being verified?

The four-line allocate/check/drop sequence plus the extra `tmp` local exist
only to make Clang emit complete BTF instead of a forward declaration for
node_refcount_only. The companion file (refcounted_kptr.c) gets its
complete BTF implicitly from bpf_obj_new(typeof(*n)) in
refcount_acquire_owning_input_no_null_check without any note, so the two
files handle the same requirement differently.

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

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33856178848
--===============3952255768304245481==--
