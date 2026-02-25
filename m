Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A675801
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772005092; cv=none; b=avH5YNIy9bHjlcrFAmxLYIYeUD5qP+8KpTIT5lkuyxphe86YgMrsUYcqqe9HfgQuK0+gtXKsPua6wfwbwB50GqPM2jHd1bzDZ/AXECEsBTMXsLTHvRWtNNe/A6DxAy02bbFtmB5jmAJXLhlpHCx20fcGq55wsKnBkfcxEq5LIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772005092; c=relaxed/simple;
	bh=2pogDiTrJQEpyA+MouE4243GYa3otjlGllU06zSZ0zQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Py1fuT16K0+BJKssj2LNl0GQXuintBMg7j5M1SHTjY+SpbfjQEV8YB5Ps+v/8X0DI6XlEqP3s0Cj/0OuAHsXaFxPhkbxW5NCqd2p7l4yiRgOG2hWob6mGG26tjvXj4tPZjk6vB/EEosph2JmrniKOPkMIGqPiljdf0BcdRGRtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CORSCb9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CORSCb9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C51CC116D0;
	Wed, 25 Feb 2026 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772005091;
	bh=2pogDiTrJQEpyA+MouE4243GYa3otjlGllU06zSZ0zQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CORSCb9WaZl195GmCgYrCO1aA6xUrlgdlO0HMBctXfOZJbG07+ilUxq75FHUum66F
	 +JDYhRQ6n5m7wzxygsfAshBxXs0oEIx61Rgh28YPtaLOJteYHJvKlzy4t6xYbBY0Wy
	 e/mTOdMeE0lbCquuF5r7syZ49wbffcgMJr8pl3o3YIEtRo/8bgwEyevNfFZ1BRsy3o
	 YwQImiUQP7lqMUQq8cPrb36cslCjU88i95KZmgoYk1EHsEHlLN5lGIo9/K+tC+1gj1
	 ut2TyIG7Ex2SQVQjFSsqdW2W98F3hh/INfAve4eW7a/Ljvjq/ZRC/jnFyPV3VdPf/z
	 KIItNlh57PuPg==
Content-Type: multipart/mixed; boundary="===============7947378391257214783=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37aef2457aa50ca719b97ed4f945c6b22c219398d87296c72bcd69a678986ece@mail.kernel.org>
In-Reply-To: <B97C43D716882A74+20260225065459.2609916-1-xulang@uniontech.com>
References: <B97C43D716882A74+20260225065459.2609916-1-xulang@uniontech.com>
Subject: Re: [PATCH v2] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
From: bot+bpf-ci@kernel.org
To: xulang@uniontech.com,martin.lau@linux.dev
Cc: ast@kernel.org,bpf@vger.kernel.org,daniel@iogearbox.net,dddddd@hust.edu.cn,dzm91@hust.edu.cn,hust-os-kernel-patches@googlegroups.com,kaiyanm@hust.edu.cn,sdf@fomichev.me,xulang@uniontech.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 07:38:10 +0000 (UTC)

--===============7947378391257214783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1003,12 +1004,13 @@ struct bpf_attach_target_info tgt_info = {};
>
>  	shim_link = cgroup_shim_find(tr, bpf_func);
>  	if (shim_link) {
> +		link = &shim_link->link.link;
> +		if (link == bpf_link_inc_not_zero(link)) {

The other callers of bpf_link_inc_not_zero() in the tree check the
return value with IS_ERR(), for example in
bpf_link_get_curr_or_next():

    link = bpf_link_inc_not_zero(link);
    if (IS_ERR(link)) {
        (*id)++;
        goto again;
    }

Would it be more consistent to use IS_ERR() here as well?  Something
like:

    if (!IS_ERR(bpf_link_inc_not_zero(link))) {

> +			/* Reusing existing shim attached by the other program. */
> +			mutex_unlock(&tr->mutex);
> +			bpf_trampoline_put(tr); /* bpf_trampoline_get above */
> +			return 0;
> +		}
>  	}

This commit fixes a use-after-free introduced by commit 69fd337a975c
("bpf: per-cgroup lsm flavor"), which added the bpf_link_inc() call
that could resurrect a zero-refcount link.

Should this include a Fixes: tag?

Suggested:
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22386382516

AI-authorship-score: medium
AI-authorship-explanation: Commit message uses markdown-style backtick formatting and verbose explanatory style atypical of kernel patches, but the v1-to-v2 iteration addressing specific reviewer feedback and manual reproduction testing suggest human authorship.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Missing Fixes tag for a use-after-free bug fix and non-idiomatic bpf_link_inc_not_zero() return value comparison; the fix itself is technically correct.

--===============7947378391257214783==--
