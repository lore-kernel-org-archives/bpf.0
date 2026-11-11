Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384432;
	b=mnLGhDDmBpCOADXCeb3pmb7UYmDpdiIK+NJwB+ZnlIsU/mONHTeljG7X4HjTyts+Iy+5
	 YcBy3PXk6JsSO+VMOpVf4TEXnCFJuArJBwN/0yR537J9xgauEFR6dA3euro81F+6TRUfl
	 UmfN618HKGv1LmSlAcR8X3EHkWPCUHZ1X6kS6r8igJ1DFoNHenUV6bWtaiRQr5gU3DblC
	 uWY4AQnYVa26G/EKZIaa5eyE1pAP+HAC1MnrwsBalU/lJlJv5yq3IFtlNYUXq0J7wegVc
	 cwMhUvmzUHh0ds3G0xapvefHHYHzohYRktz5uEUiKFkGtFNGMupdWBC6ZB6hvmJlA1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384432;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=xLs8ayfHBLqGNIeqNvKdUFFV2ceLPPx5aCzC8uzmT9g=;
	b=uFXRr14ghh3Xym9ZGk/pNvbvq6pFHyhGMzsJyV0+z/xbwSjdhZVgHVKfo1RBao3vKOvM
	 v9YqKKflithisuVaiOd+MElpXCYU1UpfnHv14dBsuJQjjeA4QvbxPMMOEzGYKY7anzx58
	 TorCe3B8AsQejgAWp9j+MzKw9IheaIL3uj9/jjfdfqPAMsiSS0KGa5Kmw8eM7T2oeztxM
	 wlzi5y6mocJ8I7iu/4U4yiLsvLcnlVqB5b9VsQKepBKr+IKq9ToJC7ZR8AUbIhzXjolsx
	 5MQ4pVILgah4TRsqb0vAk0L3PmhMiOeXFbREolaOaCdTgK1PZhZpvGpypIt3rZwDwoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQzzNTqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920D606A324;
	Wed, 11 Nov 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQzzNTqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB31F00A05;
	Wed, 11 Nov 2026 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384431;
	bh=xLs8ayfHBLqGNIeqNvKdUFFV2ceLPPx5aCzC8uzmT9g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eQzzNTquYrxYVEFbtJN+AW7DVsuwrXK4utXRDDXQu68G2UP6hmobRWFk/oxYrok78
	 n/ZLSAzBZwT152UZsyQF1isaMyNL3rCI60+PlIyY4rNlqSRxkIhiHnuLcXHfBrFfRc
	 MxoP1K4kxhNWxK35nB+Ymko9PjTd2a3fslYG0lbeKBcfZg0vS2fqlIpvfobZlpOzoT
	 Yb6Tj8whl+dh/8wG2qqwMajZDyHcomUqFQB1oWK7DgXlF8jfJ0FvvH9OAf1imKyVFJ
	 JckjI2/n+NLBV+Np0KMs9xTVu70cxur5LFtgtR0MBtUPLcfJdplG0VtkYZzx4iQfAT
	 PpnLUMcI7NJ7Q==
Content-Type: multipart/mixed; boundary="===============5514991749610700103=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1c785d97eaac586357e585c4b711076a0df87052bdb135d346c0327d6972fdfb@mail.kernel.org>
In-Reply-To: <20261111073416.203153-4-changwoo@igalia.com>
References: <20261111073416.203153-4-changwoo@igalia.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: libarena: Cache the rbtree's leftmost node and count
From: bot+bpf-ci@kernel.org
To: changwoo@igalia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,emil@etsalapatis.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,david.dai@linux.dev,gavinguo@igalia.com,bpf@vger.kernel.org,sched-ext@lists.linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,changwoo@igalia.com,kernel-dev@igalia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:07:10 +0000 (UTC)

--===============5514991749610700103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Cache the rbtree's leftmost node and count

TL;DR: The three new rbtree lockless helpers in rbtree.h are plain static, not
static inline. They may trigger -Wunused-function under -Werror and break the
whole selftests build. Should they be inline?

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> index 788e25fcd7fd..e34d5a51ae3d 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h

[ ... ]

> @@ -81,4 +98,37 @@ void rb_node_free(struct rbnode __arena *rbnode);
>
>  int rb_integrity_check(struct rbtree __arena *rbtree);
>
> +/*
> + * Lockless reads of the head and the node count. [ ... ]
> + */
> +static struct rbnode __arena *rb_first_lockless(struct rbtree __arena *rbtree)
> +{
> +	return READ_ONCE(rbtree->first);
> +}
> +
> +/* -ENOENT if the tree is empty, 0 with the leftmost key in @key otherwise. */
> +static int rb_first_key_lockless(struct rbtree __arena *rbtree, u64 *key)
> +{
[ ... ]
> +static u64 rb_nr_nodes_lockless(struct rbtree __arena *rbtree)
> +{
> +	return READ_ONCE(rbtree->nr);
> +}
> +
>  #endif /* __BPF__ */

Can these three plain static functions break the libarena build?

src/rbtree.bpf.c includes <libarena/rbtree.h> but calls none of them.
Clang only exempts unused file-scope functions from -Wunused-function when
they are declared inline, since static inline functions are assumed to be
header helpers.  A plain static function defined in a header still gets the
warning.

The libarena objects are built with the selftests' BPF_CFLAGS, which include
-Wall -Werror, so this would be expected to fail with something like:

  rbtree.h: error: unused function 'rb_first_lockless' [-Werror,-Wunused-function]

and, because the libarena skeletons are prerequisites of the test_progs
build, it would break the whole selftests build rather than only the rbtree
tests.

The other helpers defined in libarena headers use static inline or
static __always_inline.  Should these three be declared static inline (or
static __always_inline, as in the earlier revision) as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982574960
--===============5514991749610700103==--
