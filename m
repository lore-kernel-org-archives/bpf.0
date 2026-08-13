Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2426FD9B;
	Thu, 13 Aug 2026 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580536; cv=none; b=RNdLft7oHKI9fz9aBm/b3urIiqKLYJBmlCCUkqCPs3sGuxqrCl6aH1QOu/PpwSDi9oJk5SBGq9Wyb6b9O7wU5U7fvT+mMJ96UWsJzpI63ipNXwqHiJMxtwRRnWghV9Oy1Ke+lIj8ZDiYuPKJKA7FrueZxU6gyZmBrBQfL1ob/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580536; c=relaxed/simple;
	bh=o+9n10YMR9eQXGkY2rSLbcWGrD6mwqLVkTDwS5dC1nY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FXgjTLNDkwaXypdSxqGJYH2uGxlqJrObBeeA+hAKkixouCczsXgsUAwhqcQ6q2ZVj08jjWMTyfveO/3SIRbNvbCf0MWSC77QUH1DnqWrNiq8+AdZ9ELzeAc838dUXSWny6zrbAWxJbxpCOFCjoqPaQKas/JqYjWGnvwjcmEyogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM1EYu/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM1EYu/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF95D1F000E9;
	Thu, 13 Aug 2026 00:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580534;
	bh=slsCB+GkG8ErJY1ZliyqAvyYTVs6M0gxA9OFIKBBRH8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GM1EYu/2x3QSK3NZ/PuMtfDZJlBat3I+e2FZlxppC9nPxQpBO88CfEA9KNn6jduv1
	 qNGtY1PdEdKeP17BP63k17VSH0s0cXzsy8EJc00SqjV4lBjj8FBq3rwh2TXJMDswGC
	 FyER0yFYNYaTS1Ssk5z1mVRWfbqXdbt5XqIJfTpJRlMseahAWn2P+aNi+qM2+kbVGX
	 34pfBJ/KPqK2WSnI3BjAN5JKS0GYBYHXNZevzZKkimEHjVUUyucOojVCr7qDkA14w+
	 xgQjIb4aLURhB1C+MPhYtRAGCyAPQUYCwKNBORuSTr4nn9N74PlyfA7jG2bb56c6eK
	 W57G5mFae+nIg==
Content-Type: multipart/mixed; boundary="===============4955271160677581350=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0694ce653e21157306a453397ed8233b81a958a1880abffbb0ad4cb5b7504e1d@mail.kernel.org>
In-Reply-To: <20260812231905.2956588-3-tjmercier@google.com>
References: <20260812231905.2956588-3-tjmercier@google.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: htab: Reduce elem_size by 8 bytes for small key sizes
From: bot+bpf-ci@kernel.org
To: tjmercier@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tjmercier@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 00:22:13 +0000 (UTC)

--===============4955271160677581350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index fed4b1db8b78b..720766121ea2b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index 373c8d17ea557..6bd4cb68c20c1 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -114,7 +114,7 @@ static inline int check_hash(void)
>  	VERIFY(check_default_noinline(&hash->map, map));
>
>  	VERIFY(hash->n_buckets == MAX_ENTRIES);
> -	VERIFY(hash->elem_size == 64);
> +	VERIFY(hash->elem_size == 32);
>
>  	VERIFY(hash->count.counter == 0);
>  	VERIFY(bpf_map_sum_elem_count(map) == 0);

Should this expectation change have been split across two commits for
bisectability? The preceding commit 1066507e33e67 dropped the
freelist/lru union from struct htab_elem, which moves elem_size to 40,
but that commit leaves the selftest checking for 64. This means the
map_ptr selftest fails at 1066507e33e67 and only passes again here
where elem_size becomes 32.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31651309438
--===============4955271160677581350==--
