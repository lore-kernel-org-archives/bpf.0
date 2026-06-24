Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941C331EDF;
	Wed, 24 Jun 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329262; cv=none; b=Hiu7Z/v+dmbd+198mIw4ZZGSNaEW/hKaGpEq6yyW6cm72HTe7exLHRkNKsq6iO/u2BCopeJ/SwqBaWQXwikd4WL8M7LXWVhx8OaRgNHF2e0sh2Ttrnj197wGSGN3Zy/3XMZl/O7vxFV6f+AG0zfqb6HCoWP/+Ioh8E/sFfjFeQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329262; c=relaxed/simple;
	bh=VFAoD0fMnrxZ/wlVn+JNbR6s6TVkVfb+zHIPiiPpBFA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PNCo4F1UEEDYGdWrSv2Yjs54JspJGZM78bCObPzxOQSQXq5TKg5I1pn5TZcUSdASjPrT5ERbIITw2h89GiOBYkSBZIPXwnKD09dTlAkR6HczQXSTg7zNo+Fh5vn2SGe0PeJpoRlkcww4N78FCRFgkBeOygroEJWxUc1kzLHfHH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3p6ecp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3p6ecp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0981F000E9;
	Wed, 24 Jun 2026 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329261;
	bh=8t8vP6YB+sW63PavNOQvp5rAVzrhGWeBTKFpkgNwJOs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P3p6ecp+zTFxq6rn05ZqzbVGcAg3zurRaPxff9S1/S4nVFgf7wgGxnAWQacCt+1Ls
	 hl01QKLnYcowty4R8jm294phKFUhlcEgTbr1sUOYBgSyQx8UkyA8BP1gr0U9TOzFmp
	 ZpI8FTFEnDz+iAB7KyXLa4x9y7dIbMzYeI1P0Q1FwhoOdyyxVOgRFgEUP+z+9r0SzX
	 3Y1CeTlivZIjc/XV3YNp6wzlTLLWT80GI4R/GfhDTx5aA15uHsqtFZUSvrPkf/XOzn
	 ayOxWyhmvrBtRMY2ROxeKwZj20tL3Ywu8pS2mLTGR374JPRcjwUyPfFtpxL9jVMi2S
	 lEdJCyG+tDdcA==
Content-Type: multipart/mixed; boundary="===============8371667215514950318=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e736a905619cd4996f9867cde8050cfa6af23d6583c1e7699d1934c1dab6e09b@mail.kernel.org>
In-Reply-To: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
References: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
Subject: Re: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: linux-kernel@vger.kernel.org,bpf@vger.kernel.org,sidnayyar@google.com,john.fastabend@gmail.com,gprocida@google.com,maennich@google.com,ynaffit@google.com,nkapron@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 19:27:40 +0000 (UTC)

--===============8371667215514950318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index b740fa73ee26..25a9f8340980 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -21,6 +21,15 @@ static bool bpf_verifier_log_attr_valid(u32 log_level, char __user *log_buf, u32
>  	/* log buf without log_level is meaningless */
>  	if (log_buf && log_level == 0)
>  		return false;
> +
> +	/* BPF_LOG_KERNEL is an exclusive internal mode, not a bit flag.
> +	 * It must be checked via strict equality to prevent it from being
> +	 * combined with userspace flags, which would cause the verifier
> +	 * to fallback to userspace logging and copy_to_user() failures.
> +	 */

This isn't a bug, but would it read more in line with the BPF multi-line
comment style to put the opening /* on its own line here?  The text
currently starts on the same line as the opening /*:

	/* BPF_LOG_KERNEL is an exclusive internal mode, not a bit flag.
	 * It must be checked via strict equality ...

> +	if (log_level == BPF_LOG_KERNEL)
> +		return true;
> +
>  	if (log_level & ~BPF_LOG_MASK)
>  		return false;
>  	if (log_size > UINT_MAX >> 2)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28121265957
--===============8371667215514950318==--
