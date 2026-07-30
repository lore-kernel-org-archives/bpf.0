Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B61DA60D
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373299; cv=none; b=lBVdBC7pbHW0D41SnTcZN626tcX4YksVus/h6THYNHlIZoteuLV67M7japQcopZIamdDB5KjpBun8UfgoaR/cKS9VK49+cCbh85IT+vsHfKwwyOzZ5C2tJOkUd/pccL7mNfZnqJmm2Ar7NwzPTQj513S9d1lLo/rmsYGhy8y5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373299; c=relaxed/simple;
	bh=TOvogJZTxyBlbZeidme1IMp54EckoWTgQYP562eCWOA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B70In3vBNWXWEdIj/BIZm8chPwYgo90LnagdhSBeiVjNf3TxPnWjkTF4o1rVmiMJz2ssnpMaW7R48kpjGAljZc9EpYlGhv+hh3dvWWFxud04z4/49Jotd2PMPFglvj8KmuFlScvCAIzt9D+sp9+UZlvvv00ZodM98SlCnCGw0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjahb4vA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjahb4vA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A51F000E9;
	Thu, 30 Jul 2026 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373298;
	bh=WaQmumtEIjxt5+NpnhtOggxXieWKz6W/L/swvjxuG80=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vjahb4vAQfwcNKfaPQUwl7RxH8e0hB+gGePoFnEL4pGhBD9ruTSeJ6pudUls3k+RC
	 /DGJDdRyLNq6DubM1KXodzqpkvNV4rA4bGLun3vMPa3U56wNvETYg7YdFm/hutlZeS
	 enDi/ewgm6WBh4K5qDjgWFguMx01qO8hs8i+0xz9wzCaN7SJNFUis7ns+WzGLrQ4Ya
	 mLfvZB4JfZRusIV/prUwwJPJyctiBDNVXDzq6KkURk0AazOE8dFeBG+LHQ74zFOQmf
	 ZmjinrhQxNhcD1K67v6r7BO9EY5qCdW2rxY9j5OFvST3N9W7qAhFfZGQBTFt5GGOXI
	 DWgoJszHFEuNg==
Content-Type: multipart/mixed; boundary="===============8536028787354132834=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <776af17a5b92e5d99bf506310ed77ae3343147e2d516494b4d548e2fad7b6b66@mail.kernel.org>
In-Reply-To: <20260730001145.381820-2-vldsampaio@pm.me>
References: <20260730001145.381820-2-vldsampaio@pm.me>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Simplify cnum contains() by removing redundant branches
From: bot+bpf-ci@kernel.org
To: vldsampaio@pm.me,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,vldsampaio@pm.me,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Jul 2026 01:01:37 +0000 (UTC)

--===============8536028787354132834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit d2e5a95c6c27e8fdd19a942255f933b33741c758
> Author:     Vinicius Sampaio <vldsampaio@pm.me>
> AuthorDate: Thu Jul 30 00:11:34 2026 +0000
> Commit:     Kernel Patches Daemon <kernel-patches-bot@fb.com>
> CommitDate: Wed Jul 29 17:23:31 2026 -0700
>
>     bpf: Simplify cnum contains() by removing redundant branches
>
>     This patch simplifies the contains() implementation.

This isn't a bug, but could the opening line be dropped or rephrased?
It restates the subject line and uses the "This patch" phrasing that
Documentation/process/submitting-patches.rst discourages in favor of
imperative mood. The substantive rationale about circular ranges starts
in the next paragraph and could lead directly.

>
>     Bearing in mind that a non-empty cnum represents an inclusive circular
>     range in the corresponding unsigned integer domain, membership could be
>     tested by checking whether the distance from the range base to the
>     queried value is within the range size.
>
>     This makes the explicit wrapping and non-wrapping cases in contains()
>     unnecessary, since:
>
>             v - cnum.base <= cnum.size
>
>     is equivalent for both ordinary ranges and ranges that cross the
>     unsigned wrap boundary.

[ ... ]

>     Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
>     Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
>     Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>     Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
>     Signed-off-by: Vinicius Sampaio <vldsampaio@pm.me>
>     Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>
> diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
> index a90e317e3578..ac1f62a0195d 100644
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h
> @@ -210,12 +210,7 @@ bool FN(is_empty)(struct cnum_t cnum)
>
>  bool FN(contains)(struct cnum_t cnum, ut v)
>  {
> -	if (FN(is_empty)(cnum))
> -		return false;
> -	if (FN(urange_overflow)(cnum))
> -		return v >= cnum.base || v <= (ut)cnum.base + cnum.size;
> -	else
> -		return v >= cnum.base && v <= (ut)cnum.base + cnum.size;
> +	return !FN(is_empty)(cnum) && v - cnum.base <= cnum.size;
>  }
>
>  bool FN(is_const)(struct cnum_t cnum)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30502671499
--===============8536028787354132834==--
