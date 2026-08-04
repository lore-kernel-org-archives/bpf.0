Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89123BD05
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880499; cv=none; b=Zn7Ogkb7IjuJor7WRmkBfYH512r1HHyauIIo37hZKo77+r4DY8aEkqj98JjXCe6MpbXCRvQlpXJLtvuE1ootojrq4Tqs6WE833NLHXJiav9L4++Z+/vMJlhT7I+YIStfhVZYrBGEMxgm8tZ0bl8Cq2VSUVQ6rlMJ/0v2BPEMwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880499; c=relaxed/simple;
	bh=qNZbW1xOfCRGkDflsnpX5w+R7tnUqaVrUAYUApFo8f0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pgeyDG9huslsMuG1E/QiC/YGSmbTJ6Cq0w51lfHsAC4cG4WLRc42Q1v4b7DVjug4DsCKL+cIFeWCCDX9YATFltbpblh/ae47kGisz66dyUCJ9a6TFeie1o/EF8m+wdMR/T9SUnxiq7we/RSoZ41elLK6Uj2oOrgPgX5JTmss7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiZNTp85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiZNTp85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FD41F000E9;
	Tue,  4 Aug 2026 21:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785880497;
	bh=xiNZAtRBau2v69ns9w0o9g9UbqyvzLIFKuQRvnYLLFY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AiZNTp851FK6ZA3PfljcN4ZY1mxYuTLbkQG57M/oBYuaoB3iRxM61o0MbVy3U3JV0
	 Spy94i7hRMCr52b0tw7DSxB8S3Z5AztWswSzJX22H49vdUFkttkAW+6KaBJKFfp5zV
	 jKkU/TqWLgFHRbuwpc5Oh6hn9OQv9h6yaGex0LufRK3oEYEj3IRsDgFoazjzowGC2A
	 wZL9vkMcm2ksKLtz3iSjjRbPx0OETBFnRvqH9Ef47NjTU7TbMpKcKk+nb7jNW0D0CV
	 c9Xyb5Nk2+UQLgpGgdsmRaSIoDzSYilh/uV9dXkL5rN7FZ9MX0L+kvlIsHgajyHCSG
	 rHkJT/GbOtxnA==
Content-Type: multipart/mixed; boundary="===============1172562801375698429=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2745ebef0f1c5b970d76736ab5828d4aea78433b2d3800b877f7e1a0555f4a4d@mail.kernel.org>
In-Reply-To: <20260804203553.1873415-1-yonghong.song@linux.dev>
References: <20260804203553.1873415-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 06/13] bpf: Reject callbacks returning more than 8 bytes
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Aug 2026 21:54:56 +0000 (UTC)

--===============1172562801375698429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 9c43eef7a91393c06822d44c361ee806f383cf97
> Author: Yonghong Song <yonghong.song@linux.dev>
>
>     bpf: Reject callbacks returning more than 8 bytes
>
>     A callback handed to a helper or a kfunc (bpf_loop(),
>     bpf_timer_set_callback(), bpf_for_each_map_elem(), ...) is invoked
>     through bpf_callback_t, and an exception callback is invoked by
>     bpf_throw() through
>
>       u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>
>     Both prototypes yield a single u64 in R0, and neither caller has any
>     notion of a second return register, so a callback returning a value in
>     the R0:R2 pair would have the upper half of its return value silently
>     dropped.
>
>     Reject both at load time:
>
>      - check_ld_imm(): a callback is materialized as PTR_TO_FUNC by an
>        ld_imm64 pointing at its subprogram, so the subprogram's return
>        convention can be checked where the callback pointer is created,
>        before it ever reaches a helper or kfunc argument.
>
>      - do_check_common(): an exception callback is not referenced by a
>        PTR_TO_FUNC, it is named by a BTF decl_tag and verified on its own,
>        so check it as its frame is set up, next to the existing "cannot
>        return void" and single-argument checks.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix. Should this include:

  Fixes: 63b5669f8a0d ("bpf: Add helpers to describe the R0:R2 return register pair")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30949310795
--===============1172562801375698429==--
