Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF042FCB6
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138815; cv=none; b=X2atGrWCiLraV2lfmf/lW0cFJ+wmLclAchTgGBjXv1PCWt3ROl19pVv5OIYMF5/k65QjZXFyQ/tBlzT8/XMwIhyUiSxUARQkPIcGCIAslrXscFOXQ4KjkPXBT0K2nLzivsO5cUIjYXyGfmKLmDdbzzwBrxpl/F1yxUoA846CLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138815; c=relaxed/simple;
	bh=sLakOvNkQWaR0+vL1jIO+7BMCg12DYS+5LnTmhW+hmM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CyN7sPn2KFkFVKZGlOzFK2n2WWpky8YsO08zvLjfRDyIx/Hu2VhStidbLIB39zh2MrZCzIeGGEZsEi9wejs7tJxokqYYXTDK46DwihIHqkMDH8wBn3fahAOqRLLm3/xud5tDfjSBMB30IABpItR4lN5X4kQVGgGNuekeXLi57zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4ETkfki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4ETkfki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4F41F000E9;
	Wed, 15 Jul 2026 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138803;
	bh=ssC56iArNVypQyXvRmH5Hn2ZgzcSOgxY+0PgMUsDxHk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J4ETkfkiq8KjzZWzywlSAYUrwEWN6FzBVOKUWIOoPXnv2DNfv1gtinIQgWeXG9fg9
	 G67xAYG9hqogTOyQMKvh7wWjQYtHNs0+VNNyoJ/TfvaqRuizPr7A07iNLD4ybbLYlx
	 JbRVVSrrp/ZBeH3JroH0WfDurHqBKDdxSmyhVdnNcgRExOab0jr2zxlimdvdGk/aTu
	 hYuVcM+2YpSIQ6W2oZWYmMfRp2oJUVeIarArqMyRZCOL3r9E6F0SwDtXZ8Ay+Q56tZ
	 7naZQOWvdu4xQOj6OtCHoxdBXFKjNjZXFXHHuDtdDVyHVdGBJizO4vSDYc5GK6KYTL
	 5yX5lQx6oEd2Q==
Content-Type: multipart/mixed; boundary="===============3198690310489056921=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ff4dc633b820e4fc96407d4cb7d2faa54576e93dc6c986ccd5b23a6092353ebc@mail.kernel.org>
In-Reply-To: <20260715172127.2416388-3-ameryhung@gmail.com>
References: <20260715172127.2416388-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Zero kfunc arg meta before error paths can read it
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 18:06:43 +0000 (UTC)

--===============3198690310489056921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Zero kfunc arg meta before error paths can read it
>
>     check_kfunc_call() reads meta.func_name when bpf_fetch_kfunc_arg_meta()
>     returns -EACCES, but that error can come from fetch_kfunc_meta() (e.g.
>     fd_array_get_btf() rejecting BTF binding for a signed program) before
>     meta is memset(), leaving it uninitialized and risking a garbage deref
>     in verbose().
>
>     Move the memset() to the start of bpf_fetch_kfunc_arg_meta() so meta is
>     zeroed on every error return. The intended "not allowed" -EACCES path
>     still sets func_name first, so its message is unchanged.
>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a fix for an uninitialized read introduced when
fetch_kfunc_meta() was added and bpf_fetch_kfunc_arg_meta() was reordered so
the memset() ran after the fetch could return -EACCES.  Should this include a
Fixes: tag?

  Fixes: 08ca87d63243 ("bpf: Introduce struct bpf_kfunc_meta")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29436864141
--===============3198690310489056921==--
