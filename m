Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31087296BA9
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814286; cv=none; b=CXf2WvCZWHZnYIqvUF9j73HmXkO+5Ob2rOKKFdFPNo3y3qDFtWcWc+Q82uzns6GoCF2IriAfkQVdAKxUe1DkP/0s2ukr0BhxretMtV+rJGy3wxfTzjRhMz/nk5odCXiDFpJVtrv2l9fwoxVgU3G3DrVKjesjJk/ZvcRiba8oSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814286; c=relaxed/simple;
	bh=0ZMgFY8klDrqqFDCJfxao1CbcgaYPiBbXE+zW1Sg7z8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IJx9B0zjHvowpQBOdGAAcxFBdlVRNi3/jnsMN5jtCdJVE+RExAPmOb3xXuWLBa+GPZSPPohow6fs6xW4Y9Tg/BP8tXU27BH82/MZk+PFo2a9VT9X0E8/WITg22M/wPKqFGV63NTLLBwh7OVzQ4MZMhSDUxO9vSEFy0/NvcGP4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5YUAeuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5YUAeuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE5E1F000E9;
	Thu, 27 Aug 2026 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814285;
	bh=AN+TtmU4OkdmuFE/WAm4VJloWALcT3qmAsALvyCSKqw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g5YUAeuCFGLQJsdbbhoAdqIGemRYfxiJW1U2zxnU0kAfOUyFeiQwOZAVjQOawKIDP
	 bIEW6aJ7G37xSukV59M6c07i8vqIG8G/SFz+rcqF80en09FYCYB11TebY2IqT3GEcI
	 ogryfVLIlHYJWRHzfZzrkUs3SYPXjkd3zqALCFk/Llduh7DKNtukIqg/kNPzGkq8tr
	 SVBSKniv90CMfBu/YvguGoZSgJnseW12vwY3UfszCTmin2gAaTGTAneuiTMvFXqIzo
	 SUhh45cO9YijO6spT/LRRSJT+/xEQOlvW02CF4FzYiUufAVQy4NVQq162wqC8655hq
	 aDyct5ExDUkuQ==
Content-Type: multipart/mixed; boundary="===============5972862711128503810=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c9dfc8370742b9ab97d7d248fb9698574ff6ca3074f761c400232d20ec7695f@mail.kernel.org>
In-Reply-To: <20260827061200.2519335-1-yonghong.song@linux.dev>
References: <20260827061200.2519335-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 09/11] selftests/bpf: Test global functions returning arena pointers by value
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 07:04:44 +0000 (UTC)

--===============5972862711128503810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Cover the by-value struct returns a global function may now make: two
> arena pointers filling R0:R2, an arena pointer beside a scalar, an array
> of them, and an eight byte struct returned in R0 alone. The existing
> cases for a struct and a union carrying a plain pointer stay rejected.

This isn't a bug, but would it be worth adding the new union-of-arena-
pointer case to the enumeration? The patch adds union arena_upair /
global_ret_arena_union() / aggregate_ret_global_arena_union() as a
sixteen-byte union of an arena pointer and a __u64[2]. Since the next
sentence says "cases for a struct and a union carrying a plain pointer
stay rejected", a reader might think the only union touched is a rejected
one, when the patch actually adds a newly-accepted union case as well.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index 815f342eb4b05..672a3aadd9cb2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -734,4 +734,52 @@ int check_arena_arg_ret(void *ctx)
>  	return 0;
>  }
>
> +#if defined(__clang_major__) && __clang_major__ >= 23
> +
> +struct arena_page_pair {
> +	u32 __arena *first;
> +	u32 __arena *second;
> +};
> +
> +__weak struct arena_page_pair split_arena_page(u32 __arena *page)
> +{
> +	struct arena_page_pair pair;
> +
> +	pair.first = page;
> +	pair.second = page + 1;
> +
> +	return pair;
> +}

This isn't a bug, but since the returned pointers are the first two u32
slots of a single page rather than two halves of it (page and page + 1
are offsets 0 and 4 within a single 4096-byte allocation), would a name
like arena_word_pair() / struct arena_word_pair describe the helper more
directly? The neighbouring arena return tests in the same file name
themselves after what they exercise rather than after an imagined data
layout (check_arena_arg_ret, check_arena_arg_quals1/2).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525
--===============5972862711128503810==--
